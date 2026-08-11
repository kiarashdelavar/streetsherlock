package nl.streetsherlock;

import nl.streetsherlock.config.CorrelationIdFilter;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.availability.AvailabilityChangeEvent;
import org.springframework.boot.availability.ReadinessState;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.system.CapturedOutput;
import org.springframework.boot.test.system.OutputCaptureExtension;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.http.MediaType;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.test.web.servlet.MockMvc;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.jwt;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest(properties = "streetsherlock.environment=test")
@AutoConfigureMockMvc
@ExtendWith(OutputCaptureExtension.class)
class ObservabilityFoundationTest {

    private static final String VALID_CORRELATION_ID =
            "123e4567-e89b-42d3-a456-426614174000";

    @Autowired
    MockMvc mockMvc;

    @Autowired
    ConfigurableApplicationContext applicationContext;

    @Test
    void API_ERR_001_unauthorizedResponseIsSafeProblemDetails() throws Exception {
        mockMvc.perform(get("/api/identity/me"))
                .andExpect(status().isUnauthorized())
                .andExpect(content().contentType(MediaType.APPLICATION_PROBLEM_JSON))
                .andExpect(header().exists(CorrelationIdFilter.HEADER_NAME))
                .andExpect(jsonPath("$.type").value("about:blank"))
                .andExpect(jsonPath("$.status").value(401))
                .andExpect(jsonPath("$.detail").value("Authentication is required."))
                .andExpect(jsonPath("$.correlationId").isNotEmpty())
                .andExpect(jsonPath("$.instance").doesNotExist());
    }

    @Test
    void API_ERR_002_forbiddenResponseIsSafeProblemDetails() throws Exception {
        mockMvc.perform(get("/api/identity/me").with(jwt()))
                .andExpect(status().isForbidden())
                .andExpect(content().contentType(MediaType.APPLICATION_PROBLEM_JSON))
                .andExpect(jsonPath("$.status").value(403))
                .andExpect(jsonPath("$.detail").value("Access is denied."))
                .andExpect(jsonPath("$.correlationId").isNotEmpty());
    }

    @Test
    void API_ERR_003_unknownResourceDoesNotLeakIdentifier() throws Exception {
        String restrictedIdentifier = "citizen-email-example-com";

        mockMvc.perform(get("/api/demo/incidents/{incidentId}", restrictedIdentifier)
                        .with(jwt().authorities(new SimpleGrantedAuthority("ROLE_SUPERVISOR"))))
                .andExpect(status().isNotFound())
                .andExpect(content().contentType(MediaType.APPLICATION_PROBLEM_JSON))
                .andExpect(jsonPath("$.status").value(404))
                .andExpect(jsonPath("$.detail").value("The requested resource was not found."))
                .andExpect(result -> assertThat(result.getResponse().getContentAsString())
                        .doesNotContain(restrictedIdentifier));
    }

    @Test
    void API_ERR_004_validCorrelationIdIsPreserved() throws Exception {
        mockMvc.perform(get("/actuator/health")
                        .header(CorrelationIdFilter.HEADER_NAME, VALID_CORRELATION_ID))
                .andExpect(status().isOk())
                .andExpect(header().string(
                        CorrelationIdFilter.HEADER_NAME,
                        VALID_CORRELATION_ID));
    }

    @Test
    void API_ERR_005_untrustedCorrelationValueIsReplaced() throws Exception {
        mockMvc.perform(get("/actuator/health")
                        .header(CorrelationIdFilter.HEADER_NAME, "citizen@example.invalid"))
                .andExpect(status().isOk())
                .andExpect(result -> {
                    String actual = result.getResponse()
                            .getHeader(CorrelationIdFilter.HEADER_NAME);
                    assertThat(actual)
                            .isNotBlank()
                            .isNotEqualTo("citizen@example.invalid")
                            .matches("[0-9a-f-]{36}");
                });
    }

    @Test
    void API_ERR_006_unsupportedMethodIsSafeProblemDetails() throws Exception {
        mockMvc.perform(post("/api/identity/me").with(jwt()).with(csrf()))
                .andExpect(status().isMethodNotAllowed())
                .andExpect(content().contentType(MediaType.APPLICATION_PROBLEM_JSON))
                .andExpect(jsonPath("$.status").value(405))
                .andExpect(jsonPath("$.detail").value("The request method is not supported."))
                .andExpect(jsonPath("$.correlationId").isNotEmpty())
                .andExpect(jsonPath("$.instance").value("/api/identity/me"));
    }

    @Test
    void PRIV_TEL_001_006_logsExcludeQueryAndSensitiveValues(CapturedOutput output)
            throws Exception {
        String restrictedValue = "synthetic-secret@example.invalid";

        mockMvc.perform(get("/actuator/health")
                        .queryParam("citizenEmail", restrictedValue))
                .andExpect(status().isOk());

        assertThat(output.getOut())
                .contains("\"event\":\"http_request\"")
                .contains("\"route\":\"/actuator/health\"")
                .doesNotContain("citizenEmail")
                .doesNotContain(restrictedValue);
    }

    @Test
    void RES_HEALTH_001_livenessAndReadinessAreSeparateAndMinimal() throws Exception {
        mockMvc.perform(get("/actuator/health/liveness"))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(
                        "application/vnd.spring-boot.actuator.v3+json"))
                .andExpect(jsonPath("$.status").value("UP"))
                .andExpect(jsonPath("$.components").doesNotExist());

        mockMvc.perform(get("/actuator/health/readiness"))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(
                        "application/vnd.spring-boot.actuator.v3+json"))
                .andExpect(jsonPath("$.status").value("UP"))
                .andExpect(jsonPath("$.components").doesNotExist());

        try {
            AvailabilityChangeEvent.publish(
                    applicationContext,
                    ReadinessState.REFUSING_TRAFFIC);

            mockMvc.perform(get("/actuator/health/readiness"))
                    .andExpect(status().isServiceUnavailable())
                    .andExpect(jsonPath("$.status").value("OUT_OF_SERVICE"))
                    .andExpect(jsonPath("$.components").doesNotExist());

            mockMvc.perform(get("/actuator/health/liveness"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("UP"));
        } finally {
            AvailabilityChangeEvent.publish(
                    applicationContext,
                    ReadinessState.ACCEPTING_TRAFFIC);
        }
    }
}
