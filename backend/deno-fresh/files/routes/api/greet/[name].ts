import { FreshContext } from "$fresh/server.ts";

export const handler = {
  GET(_req: Request, ctx: FreshContext): Response {
    const { name } = ctx.params;
    return new Response(JSON.stringify({ message: `Hello, ${name}!` }), {
      headers: { "Content-Type": "application/json" },
    });
  },
};
