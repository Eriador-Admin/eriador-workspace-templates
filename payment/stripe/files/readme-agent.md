# Agent Instructions — {{PROJECT_NAME}}

This is a Stripe payment integration project.

## Tech Stack
- **Payments**: Stripe API (Checkout Sessions + Webhooks)
- **App Server**: Express + TypeScript

## Key Conventions
- Entry point: `src/app.ts`
- Stripe client in `src/stripe.ts`
- Webhook handler uses raw body parsing (required by Stripe signature verification)
- Products defined in `src/products.ts`
- Always verify webhook signatures — never trust unverified events
- Use Stripe test mode keys during development
