const express = require("express");
const { trace } = require("@opentelemetry/api");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.json({ service: "{{PROJECT_NAME}}", status: "ok" });
});

app.get("/hello/:name", (req, res) => {
  const tracer = trace.getTracer("{{PROJECT_NAME}}");
  const span = tracer.startSpan("greeting");
  span.setAttribute("user.name", req.params.name);

  const greeting = `Hello, ${req.params.name}!`;
  span.end();

  res.json({ greeting });
});

app.get("/slow", async (req, res) => {
  const tracer = trace.getTracer("{{PROJECT_NAME}}");
  const span = tracer.startSpan("slow-operation");

  await new Promise((resolve) => setTimeout(resolve, 500));
  span.setAttribute("delay_ms", 500);
  span.end();

  res.json({ message: "This was slow on purpose" });
});

app.listen(PORT, () => {
  console.log(`{{PROJECT_NAME}} listening on http://localhost:${PORT}`);
});
