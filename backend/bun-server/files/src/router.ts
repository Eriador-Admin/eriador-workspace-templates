import { handleItems } from "./routes/items";
import { handleHealth } from "./routes/health";

export async function handleRequest(req: Request): Promise<Response> {
  const url = new URL(req.url);
  const path = url.pathname;

  // CORS headers
  const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type",
  };

  if (req.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: corsHeaders });
  }

  let response: Response;

  try {
    if (path.startsWith("/api/items")) {
      response = await handleItems(req, path);
    } else if (path === "/health") {
      response = handleHealth();
    } else {
      response = Response.json({ error: "Not found" }, { status: 404 });
    }
  } catch (err: any) {
    console.error(`Error: ${err.message}`);
    response = Response.json({ error: "Internal server error" }, { status: 500 });
  }

  // Add CORS headers to every response
  for (const [key, value] of Object.entries(corsHeaders)) {
    response.headers.set(key, value);
  }

  return response;
}
