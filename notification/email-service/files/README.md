# {{PROJECT_NAME}}

Transactional email service with [Nodemailer](https://nodemailer.com/) and HTML templates.

## Getting Started

```bash
bash init.sh    # install deps + start MailHog (local SMTP)
bash run.sh     # start the email API
bash stop.sh    # stop everything
```

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| POST | `/send` | Send an email |
| POST | `/send/welcome` | Send welcome email template |
| POST | `/send/reset-password` | Send password reset template |
| GET | `/health` | Health check |

## MailHog (Local Testing)

- **SMTP**: `localhost:1025` (no auth needed)
- **Web UI**: `http://localhost:8025` (view sent emails)

## Project Structure

```
src/
  app.ts              # Express API
  mailer.ts           # Nodemailer transport setup
  templates/
    welcome.ts        # Welcome email template
    reset-password.ts # Password reset template
    base.ts           # Base HTML layout
docker-compose.yml    # MailHog for local testing
```

## Requirements

- Node.js 18+
- Docker (for MailHog local SMTP)
