import Link from "next/link";

export default function NotFound() {
  return (
    <section className="system-state">
      <h1>Page not found</h1>
      <p>The requested demo page does not exist.</p>
      <Link href="/">Return to overview</Link>
    </section>
  );
}
