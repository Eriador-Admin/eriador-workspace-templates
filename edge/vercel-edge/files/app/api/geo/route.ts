import { geolocation, ipAddress } from "@vercel/functions";

export const runtime = "edge";

export async function GET(request: Request) {
  const geo = geolocation(request);

  return Response.json({
    ip: ipAddress(request) || "unknown",
    city: geo.city || "unknown",
    country: geo.country || "unknown",
    region: geo.countryRegion || "unknown",
    latitude: geo.latitude || "unknown",
    longitude: geo.longitude || "unknown",
  });
}
