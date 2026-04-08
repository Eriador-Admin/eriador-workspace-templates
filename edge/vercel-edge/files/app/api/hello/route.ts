export const runtime = "edge";

export async function GET() {
  return Response.json({
    message: "Hello from the edge!",
    timestamp: new Date().toISOString(),
    region: process.env.VERCEL_REGION || "local",
  });
}
