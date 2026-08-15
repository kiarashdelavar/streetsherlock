package nl.streetsherlock.publicview;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.jwt;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest(properties = "streetsherlock.environment=test")
@AutoConfigureMockMvc
class PublicRecordApiTest {

    @Autowired
    MockMvc mockMvc;

    @MockitoBean
    PublicRecordRepository repository;

    @Test
    void API_READ_001_returnsSeparatePrivacySafeReportAndIncident() throws Exception {
        when(repository.findAllSynthetic()).thenReturn(List.of(
                record("00000000-0000-4000-8000-000000000020", "report", "SYN-RPT-001"),
                record("00000000-0000-4000-8000-000000000030", "incident", "SYN-INC-001")));

        mockMvc.perform(get("/api/public/records").with(jwt()
                        .authorities(new SimpleGrantedAuthority("ROLE_INTAKE_EMPLOYEE"))))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.fixtureVersion").value("1.0.0"))
                .andExpect(jsonPath("$.items[0].kind").value("report"))
                .andExpect(jsonPath("$.items[1].kind").value("incident"))
                .andExpect(jsonPath("$.items[0].reporterName").doesNotExist())
                .andExpect(jsonPath("$.items[0].email").doesNotExist());
    }

    @Test
    void AUTH_PUB_001_deniesMissingAndUnauthorizedIdentity() throws Exception {
        mockMvc.perform(get("/api/public/records"))
                .andExpect(status().isUnauthorized());

        mockMvc.perform(get("/api/public/records").with(jwt().jwt(jwt -> jwt
                        .claim("realm_access", java.util.Map.of(
                                "roles", List.of("unauthorized"))))))
                .andExpect(status().isForbidden());
    }

    private PublicRecord record(String id, String kind, String reference) {
        return new PublicRecord(
                UUID.fromString(id),
                kind,
                reference,
                "road_surface",
                "Synthetic title",
                "Synthetic summary",
                "under_review",
                OffsetDateTime.parse("2026-01-15T09:15:00Z"),
                6.1557,
                52.2552,
                "Synthetic Deventer demo data — not a real municipal case");
    }
}
