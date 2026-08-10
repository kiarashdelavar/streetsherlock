package nl.streetsherlock;

import java.time.Instant;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.test.web.servlet.MockMvc;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.jwt;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest(properties = "streetsherlock.environment=test")
@AutoConfigureMockMvc
class AuthorizationBoundaryTest {

    @Autowired
    MockMvc mockMvc;

    @Autowired
    JwtAuthenticationConverter jwtAuthenticationConverter;

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

        mockMvc.perform(get("/api/demo/incidents/demo-incident-001")
                        .with(role("intake_employee")))
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
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001")
                        .with(role("unauthorized")))
                .andExpect(status().isForbidden());
    }

    @Test
    void AUTH_IDOR_004_auditorCannotReadIntakeIncident() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001")
                        .with(role("auditor")))
                .andExpect(status().isForbidden());
    }

    @Test
    void AUTH_IDOR_005_intakeEmployeeCanReadSeededIncident() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001")
                        .with(role("intake_employee")))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value("demo-incident-001"));
    }

    @Test
    void AUTH_IDOR_006_supervisorCanReadSeededIncident() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/demo-incident-001")
                        .with(role("supervisor")))
                .andExpect(status().isOk());
    }

    @Test
    void AUTH_IDOR_007_unknownIncidentDoesNotLeakData() throws Exception {
        mockMvc.perform(get("/api/demo/incidents/unknown")
                        .with(role("intake_employee")))
                .andExpect(status().isNotFound());
    }

    @Test
    void AUTH_IDOR_008_realmRolesAreNormalizedWithoutTrustingScopes() {
        Jwt token = Jwt.withTokenValue("synthetic-token")
                .header("alg", "none")
                .subject("synthetic-user")
                .issuedAt(Instant.parse("2026-08-10T00:00:00Z"))
                .expiresAt(Instant.parse("2026-08-10T01:00:00Z"))
                .claim("scope", "intake_employee")
                .claim("realm_access", Map.of("roles", List.of("intake-employee")))
                .build();

        JwtAuthenticationToken authentication =
                (JwtAuthenticationToken) jwtAuthenticationConverter.convert(token);

        assertThat(authentication).isNotNull();
        assertThat(authentication.getAuthorities())
                .extracting("authority")
                .containsExactly("ROLE_INTAKE_EMPLOYEE");
    }

    private static org.springframework.test.web.servlet.request.RequestPostProcessor role(String role) {
        return jwt()
                .jwt(token -> token.subject("synthetic-user"))
                .authorities(new SimpleGrantedAuthority("ROLE_" + role.toUpperCase()));
    }
}
