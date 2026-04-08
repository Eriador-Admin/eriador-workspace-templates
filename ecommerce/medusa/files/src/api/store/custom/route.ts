import type { MedusaRequest, MedusaResponse } from "@medusajs/framework/http";

export async function GET(req: MedusaRequest, res: MedusaResponse) {
  res.json({
    message: "Welcome to your custom Medusa endpoint!",
    timestamp: new Date().toISOString(),
  });
}
