import type { SubscriberArgs, SubscriberConfig } from "@medusajs/framework";

export default async function productCreatedHandler({ event }: SubscriberArgs) {
  console.log(`Product created: ${JSON.stringify(event.data)}`);
}

export const config: SubscriberConfig = {
  event: "product.created",
};
