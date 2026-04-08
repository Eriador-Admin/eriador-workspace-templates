import { Router } from "./router.js";
import { kvGet, kvPut, kvDelete } from "./kv.js";

export interface Env {
  MY_KV: KVNamespace;
}

const router = new Router();

router.get("/", () => {
  return Response.json({ message: "Hello from the edge!", timestamp: new Date().toISOString() });
});

router.get("/api/kv/:key", kvGet);
router.put("/api/kv/:key", kvPut);
router.delete("/api/kv/:key", kvDelete);

router.get("/api/geo", (request) => {
  const cf = (request as any).cf;
  return Response.json({
    country: cf?.country || "unknown",
    city: cf?.city || "unknown",
    region: cf?.region || "unknown",
    timezone: cf?.timezone || "unknown",
    colo: cf?.colo || "unknown",
  });
});

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    return router.handle(request, env);
  },
};
