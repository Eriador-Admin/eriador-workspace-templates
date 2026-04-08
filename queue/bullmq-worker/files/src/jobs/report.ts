import type { Job } from "bullmq";

interface ReportJobData {
  reportId: string;
  format: string;
}

export async function processReport(job: Job<ReportJobData>) {
  console.log(`📊 Generating ${job.data.format} report: ${job.data.reportId}`);
  await job.updateProgress(25);
  await new Promise((r) => setTimeout(r, 500));
  await job.updateProgress(50);
  await new Promise((r) => setTimeout(r, 500));
  await job.updateProgress(100);
  return { reportId: job.data.reportId, format: job.data.format };
}
