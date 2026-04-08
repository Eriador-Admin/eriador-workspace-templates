import { Router, Request, Response } from "express";
import {
  getSubscription,
  cancelSubscription,
} from "@lemonsqueezy/lemonsqueezy.js";

export const subscriptionsRouter = Router();

subscriptionsRouter.get("/:id", async (req: Request, res: Response) => {
  try {
    const response = await getSubscription(req.params.id);
    const sub = response.data?.data;

    res.json({
      id: sub?.id,
      status: sub?.attributes.status,
      productName: sub?.attributes.product_name,
      variantName: sub?.attributes.variant_name,
      renewsAt: sub?.attributes.renews_at,
      endsAt: sub?.attributes.ends_at,
      createdAt: sub?.attributes.created_at,
    });
  } catch (error: any) {
    console.error("Get subscription error:", error.message);
    res.status(500).json({ error: "Failed to get subscription" });
  }
});

subscriptionsRouter.post("/:id/cancel", async (req: Request, res: Response) => {
  try {
    const response = await cancelSubscription(req.params.id);
    const sub = response.data?.data;

    res.json({
      id: sub?.id,
      status: sub?.attributes.status,
      endsAt: sub?.attributes.ends_at,
    });
  } catch (error: any) {
    console.error("Cancel subscription error:", error.message);
    res.status(500).json({ error: "Failed to cancel subscription" });
  }
});
