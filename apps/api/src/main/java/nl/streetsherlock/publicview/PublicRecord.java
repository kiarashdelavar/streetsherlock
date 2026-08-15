package nl.streetsherlock.publicview;

import java.time.OffsetDateTime;
import java.util.UUID;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(name = "PublicRecord")
public record PublicRecord(
        UUID id,
        String kind,
        String reference,
        String category,
        String title,
        String summary,
        String status,
        OffsetDateTime occurredAt,
        double longitude,
        double latitude,
        String fixtureLabel) {
}
