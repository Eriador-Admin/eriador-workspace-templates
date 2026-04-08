# Agent Instructions — {{PROJECT_NAME}}

This is a payment integration using Lemon Squeezy with Express/TypeScript.

## Tech Stack
- **Language**: TypeScript
- **Server**: Express
- **Payment**: Lemon Squeezy API v1

## Key Conventions
- Lemon Squeezy SDK: `@lemonsqueezy/lemonsqueezy.js`
- Initialize with `lemonSqueezySetup({ apiKey })` before any API calls
- Create checkouts with `createCheckout()` — returns a URL to redirect user to
- Webhooks: verify signature with HMAC SHA-256 using webhook secret
- Webhook events: `order_created`, `subscription_created`, `subscription_updated`, `subscription_cancelled`
- Raw body required for webhook verification — use `express.raw()` on webhook route
- All API responses follow JSON:API format — data is in `response.data.data`
- Store ID and Variant ID needed for creating checkouts
- API key from env var, never hardcoded
