import "dotenv/config";
import express from "express";
import { createCheckoutSession } from "./checkout.js";
import { handleWebhook } from "./webhook.js";
import { stripe } from "./stripe.js";
import { products } from "./products.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

// Webhook route needs raw body for signature verification — must come before json middleware
app.post("/webhook", express.raw({ type: "application/json" }), handleWebhook);

app.use(express.json());

app.get("/health", (_req, res) => {
  res.json({ status: "ok" });
});

app.get("/products", (_req, res) => {
  res.json(products);
});

app.post("/checkout", async (req, res) => {
  const { productId } = req.body;
  if (!productId) {
    return res.status(400).json({ error: "productId is required" });
  }
  try {
    const session = await createCheckoutSession(productId);
    res.json({ url: session.url, sessionId: session.id });
  } catch (err) {
    const message = err instanceof Error ? err.message : "Checkout failed";
    res.status(400).json({ error: message });
  }
});

app.get("/session/:id", async (req, res) => {
  try {
    const session = await stripe.checkout.sessions.retrieve(req.params.id);
    res.json({
      id: session.id,
      status: session.status,
      payment_status: session.payment_status,
      amount_total: session.amount_total,
      currency: session.currency,
    });
  } catch {
    res.status(404).json({ error: "Session not found" });
  }
});

app.get("/success", (req, res) => {
  const sessionId = req.query.session_id;
  res.send(`<h1>Payment Successful!</h1><p>Session: ${sessionId}</p><a href="/">Back</a>`);
});

app.get("/cancel", (_req, res) => {
  res.send(`<h1>Payment Cancelled</h1><p>You can try again anytime.</p><a href="/">Back</a>`);
});

app.listen(PORT, () => {
  console.log(`Stripe API: http://localhost:${PORT}`);
});
