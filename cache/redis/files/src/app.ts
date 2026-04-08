import "dotenv/config";
import express from "express";
import session from "express-session";
import RedisStore from "connect-redis";
import { redis } from "./redis.js";
import { cacheAside } from "./patterns/cache.js";
import { publish, subscribe } from "./patterns/pubsub.js";
import { isRateLimited } from "./patterns/rate-limiter.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

// Session with Redis store
app.use(
  session({
    store: new RedisStore({ client: redis }),
    secret: "demo-secret",
    resave: false,
    saveUninitialized: false,
  })
);

declare module "express-session" {
  interface SessionData { views: number; }
}

// Cache-aside demo
app.get("/cache-demo", async (_req, res) => {
  const result = await cacheAside("demo:time", 10, async () => ({
    time: new Date().toISOString(),
    message: "This was fetched from the source",
  }));
  res.json(result);
});

// Pub/sub demo
subscribe("notifications", (msg) => console.log(`Received: ${msg}`));

app.post("/pubsub", async (req, res) => {
  const message = req.body.message || "Hello from pub/sub!";
  await publish("notifications", message);
  res.json({ published: message });
});

// Rate limiter demo
app.get("/rate-limited", async (req, res) => {
  const ip = req.ip || "unknown";
  const { limited, remaining } = await isRateLimited(ip, 10, 60);
  res.set("X-RateLimit-Remaining", remaining.toString());
  if (limited) {
    return res.status(429).json({ error: "Too many requests", remaining });
  }
  res.json({ message: "OK", remaining });
});

// Session demo
app.get("/session", (req, res) => {
  req.session.views = (req.session.views || 0) + 1;
  res.json({ views: req.session.views });
});

app.listen(PORT, () => {
  console.log(`App: http://localhost:${PORT}`);
});
