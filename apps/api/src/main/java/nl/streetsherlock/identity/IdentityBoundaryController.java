package nl.streetsherlock.identity;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api")
final class IdentityBoundaryController {

    private static final String SEEDED_INCIDENT_ID = "demo-incident-001";

    @GetMapping("/identity/me")
    @PreAuthorize("hasAnyRole('INTAKE_EMPLOYEE', 'SUPERVISOR', 'AUDITOR')")
    Map<String, String> currentIdentity(Authentication authentication) {
        return Map.of(
                "subject", authentication.getName(),
                "environment", "synthetic-demo");
    }

    @GetMapping("/demo/incidents/{incidentId}")
    @PreAuthorize("hasAnyRole('INTAKE_EMPLOYEE', 'SUPERVISOR')")
    Map<String, String> readSyntheticIncident(@PathVariable String incidentId) {
        if (!SEEDED_INCIDENT_ID.equals(incidentId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }

        return Map.of(
                "id", SEEDED_INCIDENT_ID,
                "classification", "synthetic",
                "status", "new");
    }
}
