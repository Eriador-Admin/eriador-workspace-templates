import type { Job } from "bullmq";

interface EmailJobData {
  to: string;
  subject: string;
  body: string;
}

export async function processEmail(job: Job<EmailJobData>) {
  console.log(`📧 Sending email to ${job.data.to}: ${job.data.subject}`);
  // Simulate sending
  await new Promise((r) => setTimeout(r, 1000));
  return { sent: true, to: job.data.to };
}
