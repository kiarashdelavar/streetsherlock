-- E01-10 foundation for deterministic synthetic fixtures only.
-- No real citizen, municipal, contractor or restricted data is permitted.

CREATE TABLE streetsherlock.municipality (
    id UUID PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    display_name VARCHAR(150) NOT NULL,
    fixture_label VARCHAR(255) NOT NULL,
    is_synthetic BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL,
    CONSTRAINT municipality_must_be_synthetic
        CHECK (is_synthetic = TRUE)
);

CREATE TABLE streetsherlock.source_provenance (
    id UUID PRIMARY KEY,
    source_id VARCHAR(100) NOT NULL,
    source_dataset_version VARCHAR(50) NOT NULL,
    source_record_id VARCHAR(150) NOT NULL,
    snapshot_id VARCHAR(100) NOT NULL,
    content_sha256 CHAR(64) NOT NULL,
    schema_version VARCHAR(50) NOT NULL,
    classification VARCHAR(30) NOT NULL,
    rights_id VARCHAR(100) NOT NULL,
    synthetic BOOLEAN NOT NULL,
    event_time TIMESTAMPTZ,
    ingested_at TIMESTAMPTZ NOT NULL,
    CONSTRAINT source_provenance_identity_unique
        UNIQUE (source_id, source_record_id, snapshot_id),
    CONSTRAINT source_provenance_hash_format
        CHECK (content_sha256 ~ '^[0-9a-f]{64}$'),
    CONSTRAINT source_provenance_classification
        CHECK (classification = 'synthetic'),
    CONSTRAINT source_provenance_must_be_synthetic
        CHECK (synthetic = TRUE)
);

CREATE TABLE streetsherlock.report (
    id UUID PRIMARY KEY,
    municipality_id UUID NOT NULL,
    provenance_id UUID NOT NULL,
    reference VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    title VARCHAR(200) NOT NULL,
    summary TEXT NOT NULL,
    status VARCHAR(30) NOT NULL,
    occurred_at TIMESTAMPTZ NOT NULL,
    received_at TIMESTAMPTZ NOT NULL,
    location geometry(Point, 4326) NOT NULL,
    row_version BIGINT NOT NULL DEFAULT 0,
    CONSTRAINT report_municipality_fk
        FOREIGN KEY (municipality_id)
        REFERENCES streetsherlock.municipality (id)
        ON DELETE RESTRICT,
    CONSTRAINT report_provenance_fk
        FOREIGN KEY (provenance_id)
        REFERENCES streetsherlock.source_provenance (id)
        ON DELETE RESTRICT,
    CONSTRAINT report_reference_per_municipality_unique
        UNIQUE (municipality_id, reference),
    CONSTRAINT report_status_allowed
        CHECK (status IN ('received', 'under_review', 'closed')),
    CONSTRAINT report_time_order
        CHECK (received_at >= occurred_at),
    CONSTRAINT report_location_srid
        CHECK (ST_SRID(location) = 4326),
    CONSTRAINT report_row_version_non_negative
        CHECK (row_version >= 0)
);

CREATE TABLE streetsherlock.incident (
    id UUID PRIMARY KEY,
    municipality_id UUID NOT NULL,
    provenance_id UUID NOT NULL,
    reference VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    title VARCHAR(200) NOT NULL,
    summary TEXT NOT NULL,
    status VARCHAR(30) NOT NULL,
    opened_at TIMESTAMPTZ NOT NULL,
    location geometry(Point, 4326) NOT NULL,
    row_version BIGINT NOT NULL DEFAULT 0,
    CONSTRAINT incident_municipality_fk
        FOREIGN KEY (municipality_id)
        REFERENCES streetsherlock.municipality (id)
        ON DELETE RESTRICT,
    CONSTRAINT incident_provenance_fk
        FOREIGN KEY (provenance_id)
        REFERENCES streetsherlock.source_provenance (id)
        ON DELETE RESTRICT,
    CONSTRAINT incident_reference_per_municipality_unique
        UNIQUE (municipality_id, reference),
    CONSTRAINT incident_status_allowed
        CHECK (status IN ('triage', 'confirmed', 'in_progress', 'resolved')),
    CONSTRAINT incident_location_srid
        CHECK (ST_SRID(location) = 4326),
    CONSTRAINT incident_row_version_non_negative
        CHECK (row_version >= 0)
);

CREATE TABLE streetsherlock.report_incident_link (
    id UUID PRIMARY KEY,
    report_id UUID NOT NULL,
    incident_id UUID NOT NULL,
    link_status VARCHAR(30) NOT NULL,
    linked_by_subject VARCHAR(100) NOT NULL,
    link_reason VARCHAR(255) NOT NULL,
    linked_at TIMESTAMPTZ NOT NULL,
    unlinked_at TIMESTAMPTZ,
    CONSTRAINT report_incident_link_report_fk
        FOREIGN KEY (report_id)
        REFERENCES streetsherlock.report (id)
        ON DELETE RESTRICT,
    CONSTRAINT report_incident_link_incident_fk
        FOREIGN KEY (incident_id)
        REFERENCES streetsherlock.incident (id)
        ON DELETE RESTRICT,
    CONSTRAINT report_incident_link_pair_unique
        UNIQUE (report_id, incident_id),
    CONSTRAINT report_incident_link_status_allowed
        CHECK (link_status IN ('confirmed', 'rejected', 'unlinked')),
    CONSTRAINT report_incident_unlink_consistency
        CHECK (
            (link_status = 'unlinked' AND unlinked_at IS NOT NULL)
            OR
            (link_status <> 'unlinked' AND unlinked_at IS NULL)
        )
);

CREATE INDEX report_municipality_status_idx
    ON streetsherlock.report (municipality_id, status);

CREATE INDEX incident_municipality_status_idx
    ON streetsherlock.incident (municipality_id, status);

CREATE INDEX report_location_gix
    ON streetsherlock.report USING GIST (location);

CREATE INDEX incident_location_gix
    ON streetsherlock.incident USING GIST (location);

COMMENT ON TABLE streetsherlock.municipality IS
    'Synthetic municipality scope for Local/CI fixtures; not a partnership claim.';

COMMENT ON TABLE streetsherlock.report IS
    'A distinct synthetic observation that is never silently merged into an incident.';

COMMENT ON TABLE streetsherlock.incident IS
    'A synthetic municipal problem record managed separately from source reports.';

COMMENT ON TABLE streetsherlock.report_incident_link IS
    'Explicit reversible human-controlled relationship between Report and Incident.';