# {{PROJECT_NAME}}

[Stripe](https://stripe.com/) checkout integration with webhook handling.

## Getting Started

```bash
bash init.sh    # install deps
bash run.sh     # start the payment API
bash stop.sh    # stop everything
```

## Setup

1. Create a [Stripe account](https://dashboard.stripe.com/register)
2. Copy your **test** API keys from the Stripe Dashboard
3. Copy `.env.example` to `.env` and fill in your keys
4. For webhooks locally, install [Stripe CLI](https://stripe.com/docs/stripe-cli) and run:
   ```bash
   stripe listen --forward-to localhost:3000/webhook
   ```
   Copy the webhook signing secret to `.env`

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| POST | `/checkout` | Create a Stripe Checkout session |
| POST | `/webhook` | Stripe webhook handler (raw body) |
| GET | `/session/:id` | Get session details |
| GET | `/success` | Payment success page |
| GET | `/cancel` | Payment cancelled page |
| GET | `/health` | Health check |

## Project Structure

```
src/
  app.ts              # Express API
  stripe.ts           # Stripe client setup
  checkout.ts         # Checkout session creation
  webhook.ts          # Webhook event handler
  products.ts         # Sample product catalog
```

## Testing Payments

Use Stripe's test card numbers:
- **Success**: `4242 4242 4242 4242`
- **Declined**: `4000 0000 0000 0002`
- **3D Secure**: `4000 0025 0000 3155`

Any future expiry date and any 3-digit CVC will work.

## Requirements

- Node.js 18+
- Stripe account (free test mode)
- Stripe CLI (optional, for local webhooks)
