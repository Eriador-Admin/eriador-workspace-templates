import "dotenv/config";
import { Worker } from "@temporalio/worker";
import * as activities from "./activities.js";
import { TASK_QUEUE } from "./client.js";

async function run() {
  const worker = await Worker.create({
    workflowsPath: new URL("./workflows.js", import.meta.url).pathname,
    activities,
    taskQueue: TASK_QUEUE,
  });

  console.log(`Worker started on task queue: ${TASK_QUEUE}`);
  await worker.run();
}

run().catch((err) => {
  console.error("Worker failed:", err);
  process.exit(1);
});
