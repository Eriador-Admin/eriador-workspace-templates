import "dotenv/config";
import express from "express";
import { lemonSqueezySetup } from "@lemonsqueezy/lemonsqueezy.js";
import { checkoutRouter } from "./routes/checkout";
import { subscriptionsRouter } from "./routes/subscriptions";
import { webhooksRouter } from "./routes/webhooks";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

// Initialize Lemon Squeezy SDK
lemonSqueezySetup({ apiKey: process.env.LEMONSQUEEZY_API_KEY! });

// Webhooks need raw body — must be before express.json()
app.use("/api/webhooks", express.raw({ type: "application/json" }));
app.use(express.json());

// Routes
app.use("/api/checkout", checkoutRouter);
app.use("/api/subscriptions", subscriptionsRouter);
app.use("/api/webhooks", webhooksRouter);

app.get("/api/health", (_req, res) => {
  res.json({ status: "ok" });
});

app.listen(PORT, () => {
  console.log(`{{PROJECT_NAME}} running on http://localhost:${PORT}`);
});
