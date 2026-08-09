import { fireEvent, render, screen } from "@testing-library/react";
import { describe, expect, it, vi } from "vitest";
import RootLayout from "./layout";
import Home from "./page";
import Loading from "./loading";
import ErrorState from "./error";
import NotFound from "./not-found";

describe("E01-04 accessible shell evidence", () => {
  it("A11Y-SHELL-001 exposes a skip link and main landmark", () => { render(<RootLayout><Home /></RootLayout>); expect(screen.getByRole("link", { name:/skip to main/i })).toHaveAttribute("href", "#main-content"); expect(screen.getByRole("main")).toBeInTheDocument(); });
  it("A11Y-SHELL-002 names navigation and marks the current page", () => { render(<RootLayout><Home /></RootLayout>); expect(screen.getByRole("navigation", { name:/primary/i })).toBeInTheDocument(); expect(screen.getByRole("link", { name:"Overview" })).toHaveAttribute("aria-current", "page"); });
  it("A11Y-SHELL-003 provides a list alternative to the map", () => { render(<Home />); expect(screen.getByRole("img", { name:/map unavailable/i })).toBeInTheDocument(); expect(screen.getByRole("heading", { name:/accessible list alternative/i })).toBeInTheDocument(); });
  it("A11Y-SHELL-004 announces loading state", () => { render(<Loading />); expect(screen.getByRole("status")).toHaveTextContent(/loading/i); });
  it("A11Y-SHELL-005 announces failure and provides retry", () => { const reset=vi.fn(); render(<ErrorState error={new Error("synthetic")} reset={reset} />); fireEvent.click(screen.getByRole("button", { name:/retry/i })); expect(screen.getByRole("alert")).toBeInTheDocument(); expect(reset).toHaveBeenCalledOnce(); });
  it("A11Y-SHELL-006 provides not-found recovery", () => { render(<NotFound />); expect(screen.getByRole("link", { name:/return to overview/i })).toHaveAttribute("href", "/"); });
  it("WEB-SMOKE-001 renders only explicit synthetic shell content", () => { render(<Home />); expect(screen.getByRole("heading", { level:1 })).toBeInTheDocument(); expect(screen.getAllByText(/synthetic/i).length).toBeGreaterThan(0); });
});
