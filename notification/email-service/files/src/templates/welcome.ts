import { baseLayout } from "./base.js";

export function welcomeEmail(name: string): string {
  return baseLayout(`
    <h1>Welcome, ${name}!</h1>
    <p>Thanks for signing up. We're excited to have you on board.</p>
    <p><a class="btn" href="#">Get Started</a></p>
  `);
}
