-- E01-10 deterministic synthetic Deventer fixture.
-- Fixture: FIX-SYN-DEV-001 v1.0.0
-- Data SHA-256:
-- 26b54ced5b0b58d58535d7ae436ea2835fecdaf798b447ce7c7c1a1f878c8f13
-- This is fictional data and does not represent a real municipal case.

INSERT INTO streetsherlock.municipality (
    id,
    code,
    display_name,
    fixture_label,
    is_synthetic,
    created_at
)
VALUES (
    '00000000-0000-4000-8000-000000000001',
    'SYN-DEV',
    'Synthetic Deventer Demo',
    'Synthetic Deventer demo data — not a real municipal case',
    TRUE,
    '2026-01-15T10:00:00Z'
);

INSERT INTO streetsherlock.source_provenance (
    id,
    source_id,
    source_dataset_version,
    source_record_id,
    snapshot_id,
    content_sha256,
    schema_version,
    classification,
    rights_id,
    synthetic,
    event_time,
    ingested_at
)
VALUES
(
    '00000000-0000-4000-8000-000000000010',
    'SRC-SYN-DEV',
    '1.0.0',
    'SYN-REPORT-001',
    'FIX-SYN-DEV-001',
    '26b54ced5b0b58d58535d7ae436ea2835fecdaf798b447ce7c7c1a1f878c8f13',
    '1',
    'synthetic',
    'PROJECT-CREATED',
    TRUE,
    '2026-01-15T09:15:00Z',
    '2026-01-15T10:00:00Z'
),
(
    '00000000-0000-4000-8000-000000000011',
    'SRC-SYN-DEV',
    '1.0.0',
    'SYN-INCIDENT-001',
    'FIX-SYN-DEV-001',
    '26b54ced5b0b58d58535d7ae436ea2835fecdaf798b447ce7c7c1a1f878c8f13',
    '1',
    'synthetic',
    'PROJECT-CREATED',
    TRUE,
    '2026-01-15T09:30:00Z',
    '2026-01-15T10:00:00Z'
);

INSERT INTO streetsherlock.report (
    id,
    municipality_id,
    provenance_id,
    reference,
    category,
    title,
    summary,
    status,
    occurred_at,
    received_at,
    location,
    row_version
)
VALUES (
    '00000000-0000-4000-8000-000000000020',
    '00000000-0000-4000-8000-000000000001',
    '00000000-0000-4000-8000-000000000010',
    'SYN-RPT-001',
    'road_surface',
    'Synthetic cycle-path surface report',
    'Fictional surface damage in Demo Zone A. This is not a real report.',
    'under_review',
    '2026-01-15T09:15:00Z',
    '2026-01-15T09:20:00Z',
    ST_SetSRID(ST_MakePoint(6.1557, 52.2552), 4326),
    0
);

INSERT INTO streetsherlock.incident (
    id,
    municipality_id,
    provenance_id,
    reference,
    category,
    title,
    summary,
    status,
    opened_at,
    location,
    row_version
)
VALUES (
    '00000000-0000-4000-8000-000000000030',
    '00000000-0000-4000-8000-000000000001',
    '00000000-0000-4000-8000-000000000011',
    'SYN-INC-001',
    'road_surface',
    'Synthetic Demo Zone A incident',
    'Fictional incident created for repeatable StreetSherlock tests.',
    'confirmed',
    '2026-01-15T09:30:00Z',
    ST_SetSRID(ST_MakePoint(6.1557, 52.2552), 4326),
    0
);

INSERT INTO streetsherlock.report_incident_link (
    id,
    report_id,
    incident_id,
    link_status,
    linked_by_subject,
    link_reason,
    linked_at,
    unlinked_at
)
VALUES (
    '00000000-0000-4000-8000-000000000040',
    '00000000-0000-4000-8000-000000000020',
    '00000000-0000-4000-8000-000000000030',
    'confirmed',
    'demo-intake',
    'Deterministic synthetic fixture relationship',
    '2026-01-15T09:35:00Z',
    NULL
);