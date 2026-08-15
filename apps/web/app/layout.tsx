import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";

export const metadata: Metadata = {
  title: "StreetSherlock Local Demo",
  description: "Synthetic engineering shell; not for operational decisions.",
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body>
        <a className="skip-link" href="#main-content">Skip to main content</a>
        <header className="site-header">
          <Link className="brand" href="/" aria-label="StreetSherlock home">StreetSherlock</Link>
          <nav aria-label="Primary navigation">
            <ul>
              <li><Link href="/" aria-current="page">Overview</Link></li>
              <li><a href="#map-view">Spatial view</a></li>
              <li><a href="#list-view">Accessible list</a></li>
            </ul>
          </nav>
        </header>
        <main id="main-content" tabIndex={-1}>{children}</main>
        <footer><p>Local/CI shell · Synthetic fixtures only · Human decisions remain authoritative</p></footer>
      </body>
    </html>
  );
}
