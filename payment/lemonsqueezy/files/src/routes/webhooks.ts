import { Router, Request, Response } from "express";
import { verifyWebhookSignature } from "../middleware/verify-webhook";

export const webhooksRouter = Router();

webhooksRouter.post(
  "/lemonsqueezy",
  verifyWebhookSignature,
  (req: Request, res: Response) => {
    const event = JSON.parse(req.body.toString());
    const eventName = event.meta?.event_name;

    console.log(`Webhook received: ${eventName}`);

    switch (eventName) {
      case "order_created":
        console.log("Order created:", event.data.id);
        // Handle order: provision access, send confirmation, etc.
        break;

      case "subscription_created":
        console.log("Subscription created:", event.data.id);
        // Handle new subscription: update user record, etc.
        break;

      case "subscription_updated":
        console.log("Subscription updated:", event.data.id);
        // Handle update: plan change, payment method update, etc.
        break;

      case "subscription_cancelled":
        console.log("Subscription cancelled:", event.data.id);
        // Handle cancellation: schedule access revocation, etc.
        break;

      default:
        console.log(`Unhandled event: ${eventName}`);
    }

    res.json({ received: true });
  }
);
