# {{PROJECT_NAME}}

A payment integration with [Lemon Squeezy](https://www.lemonsqueezy.com/) — a merchant of record for SaaS and digital products that handles payments, tax, subscriptions, and global compliance.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start on port 3000
bash stop.sh    # stop server
```

## Prerequisites

- Node.js 18+
- [Lemon Squeezy](https://www.lemonsqueezy.com/) account with API key

### Setup

1. Create a Lemon Squeezy account
2. Go to Settings > API > Create API Key
3. Create a Store and a Product
4. Set up a Webhook pointing to `/api/webhooks/lemonsqueezy`
5. Copy values to `.env`

## Project Structure

```
src/
  server.ts                     # Express server
  routes/
    checkout.ts                 # Create checkout sessions
    subscriptions.ts            # Manage subscriptions
    webhooks.ts                 # Webhook handler
  services/
    lemonsqueezy.ts             # Lemon Squeezy API client
  middleware/
    verify-webhook.ts           # Webhook signature verification
```

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| POST | /api/checkout | Create a checkout URL |
| GET | /api/subscriptions/:id | Get subscription details |
| POST | /api/subscriptions/:id/cancel | Cancel subscription |
| POST | /api/webhooks/lemonsqueezy | Webhook receiver |
| GET | /api/health | Health check |
