import type { Request, Response } from "express";
import { stripe } from "./stripe.js";

export async function handleWebhook(req: Request, res: Response) {
  const sig = req.headers["stripe-signature"];

  if (!sig || !process.env.STRIPE_WEBHOOK_SECRET) {
    return res.status(400).send("Missing signature or webhook secret");
  }

  let event;
  try {
    event = stripe.webhooks.constructEvent(
      req.body,
      sig,
      process.env.STRIPE_WEBHOOK_SECRET
    );
  } catch (err) {
    const message = err instanceof Error ? err.message : "Unknown error";
    console.error(`Webhook signature verification failed: ${message}`);
    return res.status(400).send(`Webhook Error: ${message}`);
  }

  switch (event.type) {
    case "checkout.session.completed": {
      const session = event.data.object;
      console.log(`Payment succeeded for session: ${session.id}`);
      // TODO: Fulfill the order — update database, send confirmation email, etc.
      break;
    }
    case "checkout.session.expired": {
      const session = event.data.object;
      console.log(`Checkout expired for session: ${session.id}`);
      break;
    }
    default:
      console.log(`Unhandled event type: ${event.type}`);
  }

  res.json({ received: true });
}
