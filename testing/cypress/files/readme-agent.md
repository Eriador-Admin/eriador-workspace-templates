# Agent Instructions — {{PROJECT_NAME}}

This is a Cypress E2E test suite.

## Tech Stack
- **Framework**: Cypress 13+
- **Language**: TypeScript
- **Pattern**: Custom commands + fixtures

## Key Conventions
- E2E specs in `cypress/e2e/*.cy.ts`
- Custom Cypress commands in `cypress/support/commands.ts`
- Test fixtures (data) in `cypress/fixtures/*.json`
- Config in `cypress.config.ts`
- Uses `cy.` command chain with built-in retry/wait
- Selectors: prefer `data-testid` attributes

## File Patterns
- `cypress/e2e/*.cy.ts` → Test specs
- `cypress/fixtures/*.json` → Test data
- `cypress/support/commands.ts` → Custom commands
- `cypress.config.ts` → Configuration
