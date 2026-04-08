import "dotenv/config";
import { Worker } from "bullmq";
import { connection } from "./queue.js";
import { processEmail } from "./jobs/email.js";
import { processReport } from "./jobs/report.js";

const emailWorker = new Worker("email", processEmail, { connection });
const reportWorker = new Worker("report", processReport, { connection });

emailWorker.on("completed", (job) => {
  console.log(`✅ Email job ${job.id} completed`);
});

emailWorker.on("failed", (job, err) => {
  console.error(`❌ Email job ${job?.id} failed:`, err.message);
});

reportWorker.on("completed", (job) => {
  console.log(`✅ Report job ${job.id} completed`);
});

reportWorker.on("failed", (job, err) => {
  console.error(`❌ Report job ${job?.id} failed:`, err.message);
});

console.log("🐂 Workers started — waiting for jobs...");
