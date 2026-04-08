import { emailQueue, reportQueue } from "./queue.js";

async function produce() {
  await emailQueue.add("welcome", {
    to: "user@example.com",
    subject: "Welcome!",
    body: "Thanks for signing up.",
  });

  await reportQueue.add("monthly", {
    reportId: "RPT-001",
    format: "pdf",
  });

  console.log("Jobs enqueued!");
  process.exit(0);
}

produce();
