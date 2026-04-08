import { NextRequest, NextResponse } from "next/server";

export const runtime = "edge";

export async function GET(request: NextRequest) {
  const ua = request.headers.get("user-agent") || "";
  const isBot = /bot|crawl|spider|slurp/i.test(ua);

  if (isBot) {
    return Response.json({
      message: "Bot detected — you would be rewritten to a static page",
      userAgent: ua,
    });
  }

  return Response.json({
    message: "Human visitor — normal response",
    userAgent: ua.substring(0, 100),
  });
}
