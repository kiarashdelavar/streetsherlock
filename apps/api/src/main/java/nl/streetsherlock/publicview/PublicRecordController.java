package nl.streetsherlock.publicview;

import java.util.List;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/public")
class PublicRecordController {

    private static final String FIXTURE_VERSION = "1.0.0";

    private final PublicRecordRepository repository;

    PublicRecordController(PublicRecordRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/records")
    @PreAuthorize("hasAnyRole('INTAKE_EMPLOYEE', 'SUPERVISOR', 'AUDITOR')")
    @Operation(
            operationId = "listPublicRecords",
            summary = "List privacy-safe synthetic Report and Incident projections")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Synthetic public records"),
        @ApiResponse(responseCode = "401", description = "Authentication is required"),
        @ApiResponse(responseCode = "403", description = "Access is denied"),
        @ApiResponse(responseCode = "503", description = "Authoritative database unavailable")
    })
    PublicRecordsResponse list() {
        return new PublicRecordsResponse(FIXTURE_VERSION, repository.findAllSynthetic());
    }

    @Schema(name = "PublicRecordsResponse")
    record PublicRecordsResponse(String fixtureVersion, List<PublicRecord> items) {
    }
}
