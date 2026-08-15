# Local persisted Report and Incident view

This Local/CI path uses only `FIX-SYN-DEV-001` synthetic data. It does not
connect to a municipality or provide a production/public service.

## Start authoritative state and identity

```bash
cp .env.example .env
make db-up
docker compose --env-file .env --profile tools run --rm flyway migrate
docker compose --env-file .env --profile identity up -d identity
```

Start the API in another terminal:

```bash
export APP_ENVIRONMENT=local
export DATABASE_URL=jdbc:postgresql://127.0.0.1:5432/streetsherlock
make api-run
```

## Obtain the synthetic demo token

The token is short-lived and must stay in your shell. Do not add it to `.env`,
logs, screenshots or commits.

```bash
export STREETSHERLOCK_DEMO_BEARER_TOKEN="$(
  curl --fail --silent --show-error \
    --request POST \
    --data-urlencode client_id=streetsherlock-local-cli \
    --data-urlencode grant_type=password \
    --data-urlencode username=demo-intake \
    --data-urlencode password=local-intake-change-me \
    http://127.0.0.1:8180/realms/streetsherlock-dev/protocol/openid-connect/token |
  python -c 'import json,sys; print(json.load(sys.stdin)["access_token"])'
)"
```

Check the privacy-safe API projection:

```bash
curl --fail --silent --show-error \
  -H "Authorization: Bearer $STREETSHERLOCK_DEMO_BEARER_TOKEN" \
  http://127.0.0.1:8080/api/public/records
```

Start the web application from the same shell environment:

```bash
export STREETSHERLOCK_API_URL=http://127.0.0.1:8080
make web-run
```

Open `http://127.0.0.1:3000`. The spatial view and accessible list use the
same filtered response. Reports and Incidents remain visually and semantically distinct.

## Safe failure and recovery

- Missing/expired/unauthorized token: the UI shows a permission state and no records.
- API/database unavailable: the UI shows a retryable unavailable state; no state changes.
- Empty filter result: the UI announces an empty state.
- To recover, restart the failed local service, obtain a new token if required, and retry.
