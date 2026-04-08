import { FreshContext } from "$fresh/server.ts";

const JOKES = [
  "Why do programmers prefer dark mode? Because light attracts bugs.",
  "A SQL query walks into a bar, sees two tables and asks... 'Can I JOIN you?'",
  "Why did the developer go broke? Because he used up all his cache.",
  "There are only 10 types of people: those who understand binary, and those who don't.",
  "How many programmers does it take to change a light bulb? None, that's a hardware problem.",
];

export const handler = {
  GET(_req: Request, _ctx: FreshContext): Response {
    const joke = JOKES[Math.floor(Math.random() * JOKES.length)];
    return new Response(JSON.stringify({ joke }), {
      headers: { "Content-Type": "application/json" },
    });
  },
};
