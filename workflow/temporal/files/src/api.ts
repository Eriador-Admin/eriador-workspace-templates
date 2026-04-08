import "dotenv/config";
import express from "express";
import { getClient, TASK_QUEUE } from "./client.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

app.get("/health", (_req, res) => res.json({ status: "ok" }));

app.post("/workflow/order", async (req, res) => {
  const { customer, amount, items } = req.body;
  if (!customer || !amount || !items) {
    return res.status(400).json({ error: "customer, amount, and items are required" });
  }

  const client = await getClient();
  const orderId = `order-${Date.now()}`;

  const handle = await client.workflow.start("orderWorkflow", {
    taskQueue: TASK_QUEUE,
    workflowId: orderId,
    args: [{ orderId, customer, amount, items }],
  });

  res.json({ workflowId: handle.workflowId, runId: handle.firstExecutionRunId });
});

app.get("/workflow/:id", async (req, res) => {
  try {
    const client = await getClient();
    const handle = client.workflow.getHandle(req.params.id);
    const describe = await handle.describe();
    res.json({
      workflowId: describe.workflowId,
      status: describe.status.name,
      startTime: describe.startTime,
      closeTime: describe.closeTime,
    });
  } catch {
    res.status(404).json({ error: "Workflow not found" });
  }
});

app.listen(PORT, () => {
  console.log(`Temporal API: http://localhost:${PORT}`);
  console.log(`Temporal UI: http://localhost:8233`);
});
