export function handleHealth(): Response {
  return Response.json({
    status: "ok",
    runtime: "bun",
    version: Bun.version,
    uptime: process.uptime(),
    timestamp: new Date().toISOString(),
  });
}
