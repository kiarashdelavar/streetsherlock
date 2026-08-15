import { fireEvent, render, screen, waitFor } from "@testing-library/react";
import { beforeEach, describe, expect, it, vi } from "vitest";
import RootLayout from "./layout";
import Home from "./page";
import Loading from "./loading";
import ErrorState from "./error";
import NotFound from "./not-found";

const response = {
  fixtureVersion: "1.0.0",
  items: [
    {
      id: "00000000-0000-4000-8000-000000000020",
      kind: "report",
      reference: "SYN-RPT-001",
      category: "road_surface",
      title: "Synthetic cycle-path surface report",
      summary: "Fictional report",
      status: "under_review",
      occurredAt: "2026-01-15T09:15:00Z",
      longitude: 6.1557,
      latitude: 52.2552,
      fixtureLabel: "Synthetic Deventer demo data — not a real municipal case",
    },
    {
      id: "00000000-0000-4000-8000-000000000030",
      kind: "incident",
      reference: "SYN-INC-001",
      category: "road_surface",
      title: "Synthetic Demo Zone A incident",
      summary: "Fictional incident",
      status: "confirmed",
      occurredAt: "2026-01-15T09:30:00Z",
      longitude: 6.1557,
      latitude: 52.2552,
      fixtureLabel: "Synthetic Deventer demo data — not a real municipal case",
    },
  ],
};

beforeEach(() => {
  vi.stubGlobal("fetch", vi.fn().mockResolvedValue({
    ok: true,
    status: 200,
    json: async () => response,
  }));
});

describe("accessible shell and persisted public view evidence", () => {
  it("A11Y-SHELL-001 exposes a skip link and main landmark", () => {
    render(<RootLayout><Home /></RootLayout>);
    expect(screen.getByRole("link", { name: /skip to main/i })).toHaveAttribute("href", "#main-content");
    expect(screen.getByRole("main")).toBeInTheDocument();
  });

  it("A11Y-SHELL-002 names navigation and marks the current page", () => {
    render(<RootLayout><Home /></RootLayout>);
    expect(screen.getByRole("navigation", { name: /primary/i })).toBeInTheDocument();
    expect(screen.getByRole("link", { name: "Overview" })).toHaveAttribute("aria-current", "page");
  });

  it("A11Y-PUB-001 gives the map an equivalent filtered list", async () => {
    render(<Home />);
    expect(await screen.findByRole("img", { name: /adjacent list contains the same filtered information/i })).toBeInTheDocument();
    expect(screen.getByRole("heading", { name: "Accessible list" })).toBeInTheDocument();

    fireEvent.change(screen.getByLabelText("Record type"), { target: { value: "report" } });
    expect(screen.getByText(/1 matching synthetic record/i)).toBeInTheDocument();
    expect(screen.getByText(/SYN-RPT-001/)).toBeInTheDocument();
    expect(screen.queryByText(/SYN-INC-001/)).not.toBeInTheDocument();
  });

  it("AT-S1-001 distinguishes persisted Report and Incident", async () => {
    render(<Home />);
    expect(await screen.findByText(/report: under review/i)).toBeInTheDocument();
    expect(screen.getByText(/incident: confirmed/i)).toBeInTheDocument();
  });

  it("AUTH-PUB-001 shows permission state without leaking records", async () => {
    vi.mocked(fetch).mockResolvedValueOnce({ ok: false, status: 403 } as Response);
    render(<Home />);
    expect(await screen.findByRole("alert")).toHaveTextContent(/permission required/i);
    expect(screen.queryByText(/SYN-RPT-001/)).not.toBeInTheDocument();
  });

  it("API-READ-001 exposes retry after unavailable API", async () => {
    vi.mocked(fetch)
      .mockResolvedValueOnce({ ok: false, status: 503 } as Response)
      .mockResolvedValueOnce({ ok: true, status: 200, json: async () => response } as Response);
    render(<Home />);
    fireEvent.click(await screen.findByRole("button", { name: /retry/i }));
    await waitFor(() => expect(screen.getByText(/SYN-RPT-001/)).toBeInTheDocument());
  });

  it("A11Y-SHELL-004 announces loading state", () => {
    render(<Loading />);
    expect(screen.getByRole("status")).toHaveTextContent(/loading/i);
  });

  it("A11Y-SHELL-005 announces failure and provides retry", () => {
    const reset = vi.fn();
    render(<ErrorState error={new Error("synthetic")} reset={reset} />);
    fireEvent.click(screen.getByRole("button", { name: /retry/i }));
    expect(screen.getByRole("alert")).toBeInTheDocument();
    expect(reset).toHaveBeenCalledOnce();
  });

  it("A11Y-SHELL-006 provides not-found recovery", () => {
    render(<NotFound />);
    expect(screen.getByRole("link", { name: /return to overview/i })).toHaveAttribute("href", "/");
  });
});
