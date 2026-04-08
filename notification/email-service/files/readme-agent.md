# Agent Instructions — {{PROJECT_NAME}}

This is a transactional email service project.

## Tech Stack
- **Email**: Nodemailer
- **Local SMTP**: MailHog
- **App Server**: Express + TypeScript

## Key Conventions
- Entry point: `src/app.ts`
- Mailer transport in `src/mailer.ts`
- HTML templates in `src/templates/`
- MailHog web UI at port 8025 for viewing sent emails
- SMTP on port 1025 (MailHog) or configure real SMTP in .env
