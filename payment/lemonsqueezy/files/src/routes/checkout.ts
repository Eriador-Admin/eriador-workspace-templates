import { Router, Request, Response } from "express";
import { createCheckout } from "@lemonsqueezy/lemonsqueezy.js";

export const checkoutRouter = Router();

checkoutRouter.post("/", async (req: Request, res: Response) => {
  try {
    const { variantId, email, name } = req.body;

    if (!variantId) {
      return res.status(400).json({ error: "variantId is required" });
    }

    const storeId = process.env.LEMONSQUEEZY_STORE_ID!;

    const response = await createCheckout(storeId, variantId, {
      checkoutData: {
        email: email || undefined,
        name: name || undefined,
      },
    });

    const checkoutUrl = response.data?.data.attributes.url;

    res.json({
      checkoutUrl,
      checkoutId: response.data?.data.id,
    });
  } catch (error: any) {
    console.error("Checkout error:", error.message);
    res.status(500).json({ error: "Failed to create checkout" });
  }
});
