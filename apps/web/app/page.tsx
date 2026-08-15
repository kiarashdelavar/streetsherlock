"use client";

import { useEffect, useMemo, useState } from "react";

type PublicRecord = {
  id: string;
  kind: "report" | "incident";
  reference: string;
  category: string;
  title: string;
  summary: string;
  status: string;
  occurredAt: string;
  longitude: number;
  latitude: number;
  fixtureLabel: string;
};

type PublicRecordsResponse = {
  fixtureVersion: "1.0.0";
  items: PublicRecord[];
};

type LoadState =
  | { name: "loading" }
  | { name: "ready"; data: PublicRecordsResponse }
  | { name: "permission" }
  | { name: "error" };

export default function Home() {
  const [state, setState] = useState<LoadState>({ name: "loading" });
  const [kind, setKind] = useState<"all" | "report" | "incident">("all");
  const [retry, setRetry] = useState(0);

  useEffect(() => {
    const controller = new AbortController();
    setState({ name: "loading" });

    fetch("/api/public/records", { signal: controller.signal })
      .then(async (response) => {
        if (response.status === 401 || response.status === 403) {
          setState({ name: "permission" });
          return;
        }
        if (!response.ok) {
          setState({ name: "error" });
          return;
        }
        setState({
          name: "ready",
          data: (await response.json()) as PublicRecordsResponse,
        });
      })
      .catch((error: unknown) => {
        if (!(error instanceof DOMException && error.name === "AbortError")) {
          setState({ name: "error" });
        }
      });

    return () => controller.abort();
  }, [retry]);

  const records = useMemo(() => {
    if (state.name !== "ready") return [];
    return state.data.items.filter((item) => kind === "all" || item.kind === kind);
  }, [kind, state]);

  return (
    <>
      <section className="hero" aria-labelledby="page-title">
        <p className="eyebrow">Synthetic persisted view</p>
        <h1 id="page-title">Reports and incidents, kept distinct</h1>
        <p>
          This authorized Local/CI view reads privacy-safe projections from the
          authoritative database. It is not a public reporting service.
        </p>
        <div className="notice" role="status">
          Synthetic Deventer demo data — not a real municipal case
        </div>
      </section>

      <div className="filters">
        <label htmlFor="kind-filter">Record type</label>
        <select
          id="kind-filter"
          value={kind}
          onChange={(event) =>
            setKind(event.target.value as "all" | "report" | "incident")
          }
        >
          <option value="all">Reports and incidents</option>
          <option value="report">Reports only</option>
          <option value="incident">Incidents only</option>
        </select>
      </div>

      {state.name === "loading" && (
        <p className="system-state" role="status" aria-live="polite">
          Loading persisted synthetic records…
        </p>
      )}

      {state.name === "permission" && (
        <section className="system-state" role="alert">
          <h2>Permission required</h2>
          <p>This view needs an authorized synthetic demo identity.</p>
        </section>
      )}

      {state.name === "error" && (
        <section className="system-state" role="alert">
          <h2>The persisted view is unavailable</h2>
          <p>No authoritative state was changed. Check the API and try again.</p>
          <button type="button" onClick={() => setRetry((value) => value + 1)}>
            Retry
          </button>
        </section>
      )}

      {state.name === "ready" && records.length === 0 && (
        <p className="system-state" role="status">
          No synthetic records match this filter.
        </p>
      )}

      {state.name === "ready" && records.length > 0 && (
        <section className="workspace" aria-label="Synthetic persisted records">
          <article id="map-view" className="panel" aria-labelledby="map-title">
            <p className="panel-index" aria-hidden="true">01</p>
            <h2 id="map-title">Spatial view</h2>
            <div
              className="record-map"
              role="img"
              aria-label={`Spatial view with ${records.length} synthetic records. The adjacent list contains the same filtered information.`}
            >
              {records.map((item, index) => (
                <span
                  className={`map-marker map-marker--${item.kind}`}
                  style={{
                    left: `${42 + index * 10}%`,
                    top: `${48 + index * 8}%`,
                  }}
                  aria-hidden="true"
                  key={item.id}
                >
                  {item.kind === "report" ? "R" : "I"}
                </span>
              ))}
            </div>
          </article>

          <article id="list-view" className="panel" aria-labelledby="list-title">
            <p className="panel-index" aria-hidden="true">02</p>
            <h2 id="list-title">Accessible list</h2>
            <p className="result-count" aria-live="polite">
              {records.length} matching synthetic {records.length === 1 ? "record" : "records"}
            </p>
            <ul className="incident-list">
              {records.map((item) => (
                <li key={item.id}>
                  <span>
                    <strong>{item.title}</strong>
                    <small>{item.kind} · {item.reference} · {item.category}</small>
                    <small>{item.summary}</small>
                    <small>
                      {item.latitude.toFixed(4)}, {item.longitude.toFixed(4)}
                    </small>
                  </span>
                  <span className={`status status--${item.kind}`}>
                    {item.kind}: {item.status.replaceAll("_", " ")}
                  </span>
                </li>
              ))}
            </ul>
          </article>
        </section>
      )}
    </>
  );
}
