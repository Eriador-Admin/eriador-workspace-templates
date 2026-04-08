import { proxyActivities, sleep } from "@temporalio/workflow";
import type * as activities from "./activities.js";

const { validateOrder, processPayment, shipOrder, sendConfirmation } = proxyActivities<
  typeof activities
>({ startToCloseTimeout: "30s", retry: { maximumAttempts: 3 } });

export async function orderWorkflow(order: {
  orderId: string;
  customer: string;
  amount: number;
  items: string[];
}): Promise<{ status: string; orderId: string }> {
  // Step 1: Validate
  await validateOrder(order.orderId, order.items);

  // Step 2: Process payment
  await processPayment(order.orderId, order.amount);

  // Step 3: Ship (simulated delay)
  await sleep("2s");
  await shipOrder(order.orderId, order.customer);

  // Step 4: Send confirmation
  await sendConfirmation(order.orderId, order.customer);

  return { status: "completed", orderId: order.orderId };
}
