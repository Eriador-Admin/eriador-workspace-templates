import "dotenv/config";
import express from "express";
import { register, httpRequestsTotal, httpRequestDuration } from "./metrics.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

// Metrics middleware
app.use((req, res, next) => {
  if (req.path === "/metrics") return next();
  const end = httpRequestDuration.startTimer({ method: req.method, route: req.path });
  res.on("finish", () => {
    httpRequestsTotal.inc({ method: req.method, route: req.path, status: String(res.statusCode) });
    end();
  });
  next();
});

app.get("/health", (_req, res) => res.json({ status: "ok" }));

app.get("/", (_req, res) => {
  res.json({ message: "Hello from {{PROJECT_NAME}}!" });
});

app.get("/slow", async (_req, res) => {
  const delay = Math.random() * 2000 + 500;
  await new Promise((r) => setTimeout(r, delay));
  res.json({ message: "slow response", duration: `${Math.round(delay)}ms` });
});

app.get("/metrics", async (_req, res) => {
  res.set("Content-Type", register.contentType);
  res.end(await register.metrics());
});

app.listen(PORT, () => {
  console.log(`App: http://localhost:${PORT}`);
  console.log(`Grafana: http://localhost:${process.env.GRAFANA_PORT || 3001}`);
  console.log(`Prometheus: http://localhost:9090`);
});
