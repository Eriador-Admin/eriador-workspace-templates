import { NextRequest, NextResponse } from "next/server";

export function middleware(request: NextRequest) {
  const response = NextResponse.next();

  // Add security headers
  response.headers.set("X-Frame-Options", "DENY");
  response.headers.set("X-Content-Type-Options", "nosniff");
  response.headers.set("Referrer-Policy", "strict-origin-when-cross-origin");

  // Add geo header for downstream use
  const country = request.geo?.country || "unknown";
  response.headers.set("X-Visitor-Country", country);

  // Add request timing
  response.headers.set("X-Request-Start", Date.now().toString());

  return response;
}

export const config = {
  matcher: ["/api/:path*", "/"],
};
