package nl.streetsherlock.identity;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

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
class IdentityBoundaryController {

    private static final String SEEDED_INCIDENT_ID = "demo-incident-001";

    @GetMapping("/identity/me")
    @PreAuthorize("hasAnyRole('INTAKE_EMPLOYEE', 'SUPERVISOR', 'AUDITOR')")
    @Operation(
            operationId = "getCurrentIdentity",
            summary = "Read the authenticated synthetic identity")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Synthetic identity"),
        @ApiResponse(responseCode = "401", description = "Authentication is required"),
        @ApiResponse(responseCode = "403", description = "Access is denied")
    })
    CurrentIdentity currentIdentity(Authentication authentication) {
        return new CurrentIdentity(authentication.getName(), "synthetic-demo");
    }

    @GetMapping("/demo/incidents/{incidentId}")
    @PreAuthorize("hasAnyRole('INTAKE_EMPLOYEE', 'SUPERVISOR')")
    @Operation(
            operationId = "getSyntheticIncident",
            summary = "Read one synthetic incident")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Synthetic incident"),
        @ApiResponse(responseCode = "401", description = "Authentication is required"),
        @ApiResponse(responseCode = "403", description = "Access is denied"),
        @ApiResponse(responseCode = "404", description = "Resource not found")
    })
    SyntheticIncident readSyntheticIncident(@PathVariable String incidentId) {
        if (!SEEDED_INCIDENT_ID.equals(incidentId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }

        return new SyntheticIncident(SEEDED_INCIDENT_ID, "synthetic", "new");
    }

    @Schema(name = "CurrentIdentity")
    record CurrentIdentity(String subject, String environment) {
    }

    @Schema(name = "SyntheticIncident")
    record SyntheticIncident(String id, String classification, String status) {
    }
}
