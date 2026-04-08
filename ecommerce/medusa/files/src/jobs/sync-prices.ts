import type { ScheduledJobArgs, ScheduledJobConfig } from "@medusajs/framework";

export default async function syncPricesJob({ container }: ScheduledJobArgs) {
  console.log("Running scheduled price sync...");
  // Add custom sync logic here
}

export const config: ScheduledJobConfig = {
  name: "sync-prices",
  schedule: "0 */6 * * *", // Every 6 hours
};
