import { NextRequest } from "next/server";

export const runtime = "edge";

export async function GET(request: NextRequest) {
  const geo = request.geo || {};

  return Response.json({
    ip: request.ip || "unknown",
    city: geo.city || "unknown",
    country: geo.country || "unknown",
    region: geo.region || "unknown",
    latitude: geo.latitude || "unknown",
    longitude: geo.longitude || "unknown",
  });
}
