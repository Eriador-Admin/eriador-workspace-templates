import { Request, Response, NextFunction } from "express";
import crypto from "crypto";

export function verifyWebhookSignature(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const secret = process.env.LEMONSQUEEZY_WEBHOOK_SECRET;
  if (!secret) {
    console.error("LEMONSQUEEZY_WEBHOOK_SECRET not set");
    return res.status(500).json({ error: "Webhook secret not configured" });
  }

  const signature = req.headers["x-signature"] as string;
  if (!signature) {
    return res.status(401).json({ error: "Missing signature" });
  }

  const hmac = crypto.createHmac("sha256", secret);
  const digest = hmac.update(req.body).digest("hex");

  if (!crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(digest))) {
    return res.status(401).json({ error: "Invalid signature" });
  }

  next();
}
