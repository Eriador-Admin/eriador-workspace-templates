import "dotenv/config";
import express from "express";
import { client, httpRequestsTotal, httpRequestDuration } from "./metrics.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

// Metrics middleware — tracks all requests
app.use((req, res, next) => {
  const end = httpRequestDuration.startTimer();
  res.on("finish", () => {
    const path = req.route?.path || req.path;
    httpRequestsTotal.inc({ method: req.method, path, status: res.statusCode });
    end({ method: req.method, path, status: res.statusCode });
  });
  next();
});

// App routes
app.get("/", (_req, res) => {
  res.json({ status: "ok", message: "Hello from {{PROJECT_NAME}}" });
});

app.get("/slow", async (_req, res) => {
  const delay = Math.random() * 2000;
  await new Promise((r) => setTimeout(r, delay));
  res.json({ delayed: `${Math.round(delay)}ms` });
});

// Metrics endpoint for Prometheus scraping
app.get("/metrics", async (_req, res) => {
  res.set("Content-Type", client.register.contentType);
  res.end(await client.register.metrics());
});

app.listen(PORT, () => {
  console.log(`App: http://localhost:${PORT}`);
  console.log(`Metrics: http://localhost:${PORT}/metrics`);
});
