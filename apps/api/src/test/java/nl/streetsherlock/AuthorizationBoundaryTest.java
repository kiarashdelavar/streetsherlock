package nl.streetsherlock;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.jwt;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest(properties = "streetsherlock.environment=test")
@AutoConfigureMockMvc
class AuthorizationBoundaryTest {

    @Autowired
    MockMvc mockMvc;

    @Test
    void SEC_CONFIG_001_healthIsTheOnlyAnonymousRoute() throws Exception {
        mockMvc.perform(get("/actuator/health"))
                .andExpect(status().isOk());

        mockMvc.perform(get("/api/identity/me"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void AUTH_MATRIX_001_seededRolesMapToExpectedRoutes() throws Exception {
        mockMvc.perform(get("/api/identity/me").with(role("auditor")))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.environment").value("synthetic-demo"));

        mockMvc.perform(get("/api/demo/incidents/demo-incident-001").with(role("intake_employee")))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.classification").value("synthetic"));
    }

    @Test
    void AUTH_IDOR_001_anonymousIncidentReadIsDenied() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void AUTH_IDOR_002_tokenWithoutRealmRolesIsDenied() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001").with(jwt()))
                .andExpect(status().isForbidden());
    }

    @Test
    void AUTH_IDOR_003_unknownRoleIsDenied() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001").with(role("unauthorized")))
                .andExpect(status().isForbidden());
    }

    @Test
    void AUTH_IDOR_004_auditorCannotReadIntakeIncident() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001").with(role("auditor")))
                .andExpect(status().isForbidden());
    }

    @Test
    void AUTH_IDOR_005_intakeEmployeeCanReadSeededIncident() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001").with(role("intake_employee")))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value("demo-incident-001"));
    }

    @Test
    void AUTH_IDOR_006_supervisorCanReadSeededIncident() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001").with(role("supervisor")))
                .andExpect(status().isOk());
    }

    @Test
    void AUTH_IDOR_007_unknownIncidentDoesNotLeakData() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/unknown").with(role("intake_employee")))
                .andExpect(status().isNotFound());
    }

    @Test
    void AUTH_IDOR_008_roleNamesAreNormalizedWithoutTrustingScopes() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001")
                        .with(jwt().jwt(token -> token
                                .claim("scope", "intake_employee")
                                .claim("realm_access", Map.of(
                                        "roles", List.of("intake-employee"))))))
                .andExpect(status().isOk());
    }

    private static org.springframework.test.web.servlet.request.RequestPostProcessor role(String role) {
        return jwt().jwt(token -> token
                .subject("synthetic-user")
                .claim("realm_access", Map.of("roles", List.of(role))));
    }
}
