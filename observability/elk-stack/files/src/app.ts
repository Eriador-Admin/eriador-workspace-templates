import "dotenv/config";
import express from "express";
import { logger } from "./logger.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

// Request logging middleware
app.use((req, res, next) => {
  const start = Date.now();
  res.on("finish", () => {
    logger.info("HTTP request", {
      method: req.method,
      path: req.path,
      status: res.statusCode,
      duration: Date.now() - start,
      userAgent: req.get("user-agent"),
    });
  });
  next();
});

app.get("/", (_req, res) => {
  logger.info("Homepage accessed");
  res.json({ status: "ok", message: "Hello from {{PROJECT_NAME}}" });
});

app.get("/error", (_req, res) => {
  logger.error("Simulated error for testing", {
    errorCode: "TEST_ERROR",
    detail: "This is a test error log entry",
  });
  res.status(500).json({ error: "Simulated error logged" });
});

app.post("/log", (req, res) => {
  const { level = "info", message = "custom log", ...meta } = req.body;
  logger.log(level, message, meta);
  res.json({ logged: true });
});

app.listen(PORT, () => {
  logger.info(`Server started on port ${PORT}`);
  console.log(`App: http://localhost:${PORT}`);
  console.log(`Kibana: http://localhost:5601`);
});
