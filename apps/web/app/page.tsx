const syntheticItems = [
  { id: "SYN-001", label: "Synthetic surface observation", status: "Awaiting review" },
  { id: "SYN-002", label: "Synthetic lighting observation", status: "Needs triage" },
];

export default function Home() {
  return (
    <>
      <section className="hero" aria-labelledby="page-title">
        <p className="eyebrow">Engineering foundation</p>
        <h1 id="page-title">A clear view for careful city review</h1>
        <p>This shell demonstrates navigation and non-visual alternatives using synthetic data only. It is not a public reporting service.</p>
        <div className="notice" role="status">Demo state: no live municipal systems or personal data are connected.</div>
      </section>
      <section className="workspace" aria-label="Synthetic incident views">
        <article id="map-view" className="panel" aria-labelledby="map-title">
          <p className="panel-index" aria-hidden="true">01</p>
          <h2 id="map-title">Map placeholder</h2>
          <div className="map-placeholder" role="img" aria-label="Map unavailable. Use the adjacent synthetic list for the same information.">
            <span>Map integration intentionally unavailable</span>
          </div>
        </article>
        <article id="list-view" className="panel" aria-labelledby="list-title">
          <p className="panel-index" aria-hidden="true">02</p>
          <h2 id="list-title">Accessible list alternative</h2>
          <ul className="incident-list">
            {syntheticItems.map((item) => (
              <li key={item.id}>
                <span><strong>{item.label}</strong><small>{item.id}</small></span>
                <span className="status">{item.status}</span>
              </li>
            ))}
          </ul>
        </article>
      </section>
    </>
  );
}
