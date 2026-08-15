import { NextResponse } from "next/server";

const upstream = process.env.STREETSHERLOCK_API_URL ?? "http://127.0.0.1:8080";
const token = process.env.STREETSHERLOCK_DEMO_BEARER_TOKEN;

export async function GET() {
  if (!token) {
    return NextResponse.json(
      { title: "Demo authorization is not configured." },
      { status: 503 },
    );
  }

  try {
    const response = await fetch(`${upstream}/api/public/records`, {
      headers: { Authorization: `Bearer ${token}` },
      cache: "no-store",
    });

    const body = await response.text();
    return new NextResponse(body, {
      status: response.status,
      headers: {
        "content-type":
          response.headers.get("content-type") ?? "application/problem+json",
      },
    });
  } catch {
    return NextResponse.json(
      { title: "The authoritative API is unavailable." },
      { status: 503 },
    );
  }
}
