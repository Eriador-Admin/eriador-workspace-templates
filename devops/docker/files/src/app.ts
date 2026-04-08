import express from "express";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.get("/", (_req, res) => {
  res.json({
    service: "{{PROJECT_NAME}}",
    status: "ok",
    environment: process.env.NODE_ENV || "development",
    uptime: process.uptime(),
  });
});

app.get("/health", (_req, res) => {
  res.json({ status: "healthy" });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});
