import client from "prom-client";

const prefix = process.env.METRICS_PREFIX || "app";

// Collect default Node.js metrics (GC, event loop, memory, etc.)
client.collectDefaultMetrics({ prefix: `${prefix}_` });

// Custom: HTTP request counter
export const httpRequestsTotal = new client.Counter({
  name: `${prefix}_http_requests_total`,
  help: "Total number of HTTP requests",
  labelNames: ["method", "path", "status"] as const,
});

// Custom: HTTP request duration histogram
export const httpRequestDuration = new client.Histogram({
  name: `${prefix}_http_request_duration_seconds`,
  help: "Duration of HTTP requests in seconds",
  labelNames: ["method", "path", "status"] as const,
  buckets: [0.01, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5],
});

export { client };
