# Agent Instructions — {{PROJECT_NAME}}

This is a Payload CMS project.

## Tech Stack
- **CMS**: Payload CMS 2.x
- **Database**: MongoDB (Docker)
- **App Server**: Express

## Key Conventions
- Config: `src/payload.config.ts`
- Collections in `src/collections/`
- Admin panel at /admin, REST API at /api
- Media uploads stored locally in project root
- Users collection has auth enabled
