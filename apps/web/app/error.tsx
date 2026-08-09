"use client";

export default function ErrorState({ reset }: { error: Error & { digest?: string }; reset: () => void }) {
  return (
    <section className="system-state" role="alert">
      <h1>The workspace is unavailable</h1>
      <p>No authoritative state was changed. Try loading this local shell again.</p>
      <button type="button" onClick={reset}>Retry</button>
    </section>
  );
}
