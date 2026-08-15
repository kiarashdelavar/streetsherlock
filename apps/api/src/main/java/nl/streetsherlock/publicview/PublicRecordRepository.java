package nl.streetsherlock.publicview;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
class PublicRecordRepository {

    private static final String READ_PUBLIC_RECORDS = """
            SELECT report.id,
                   'report' AS kind,
                   report.reference,
                   report.category,
                   report.title,
                   report.summary,
                   report.status,
                   report.occurred_at,
                   ST_X(report.location) AS longitude,
                   ST_Y(report.location) AS latitude,
                   municipality.fixture_label
              FROM streetsherlock.report AS report
              JOIN streetsherlock.municipality AS municipality
                ON municipality.id = report.municipality_id
             WHERE municipality.is_synthetic
            UNION ALL
            SELECT incident.id,
                   'incident' AS kind,
                   incident.reference,
                   incident.category,
                   incident.title,
                   incident.summary,
                   incident.status,
                   incident.opened_at AS occurred_at,
                   ST_X(incident.location) AS longitude,
                   ST_Y(incident.location) AS latitude,
                   municipality.fixture_label
              FROM streetsherlock.incident AS incident
              JOIN streetsherlock.municipality AS municipality
                ON municipality.id = incident.municipality_id
             WHERE municipality.is_synthetic
             ORDER BY occurred_at, kind, id
            """;

    private final JdbcTemplate jdbcTemplate;

    PublicRecordRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    List<PublicRecord> findAllSynthetic() {
        return jdbcTemplate.query(READ_PUBLIC_RECORDS, PublicRecordRepository::mapRecord);
    }

    private static PublicRecord mapRecord(ResultSet result, int rowNumber) throws SQLException {
        return new PublicRecord(
                result.getObject("id", java.util.UUID.class),
                result.getString("kind"),
                result.getString("reference"),
                result.getString("category"),
                result.getString("title"),
                result.getString("summary"),
                result.getString("status"),
                result.getObject("occurred_at", java.time.OffsetDateTime.class),
                result.getDouble("longitude"),
                result.getDouble("latitude"),
                result.getString("fixture_label"));
    }
}
