import "dotenv/config";
import { serve } from "@hono/node-server";
import { Hono } from "hono";
import { cors } from "hono/cors";
import { itemsRoute } from "./routes/items";
import { healthRoute } from "./routes/health";
import { loggerMiddleware } from "./middleware/logger";
import { errorHandler } from "./middleware/error-handler";

const app = new Hono();

// Global middleware
app.use("*", cors());
app.use("*", loggerMiddleware);

// Routes
app.route("/api/items", itemsRoute);
app.route("/health", healthRoute);

// Global error handler
app.onError(errorHandler);

// 404 handler
app.notFound((c) => c.json({ error: "Not found" }, 404));

const port = parseInt(process.env.PORT || "3000", 10);
console.log(`{{PROJECT_NAME}} running on http://localhost:${port}`);
serve({ fetch: app.fetch, port });
