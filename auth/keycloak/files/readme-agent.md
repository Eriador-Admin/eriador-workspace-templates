# Agent Instructions — {{PROJECT_NAME}}

This is a Keycloak SSO project with Express integration.

## Tech Stack
- **Identity Provider**: Keycloak
- **Protocol**: OpenID Connect (OIDC)
- **App Server**: Express + TypeScript
- **Auth Library**: openid-client

## Key Conventions
- Entry point: `src/app.ts`
- OIDC config in `src/auth.ts`
- Keycloak runs in Docker on port 8080
- Realm config in `realm-export.json`
- Protected routes use auth middleware
