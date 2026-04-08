# {{PROJECT_NAME}}

End-to-end tests with [Cypress](https://www.cypress.io/) and TypeScript.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # open Cypress Test Runner
bash stop.sh    # nothing to stop
```

## Project Structure

```
cypress/
  e2e/
    home.cy.ts          # E2E test specs
  fixtures/
    example.json        # Test data
  support/
    commands.ts         # Custom commands
    e2e.ts              # E2E support file
cypress.config.ts       # Cypress configuration
```

## Commands

```bash
npx cypress open        # interactive Test Runner
npx cypress run         # headless execution
npx cypress run --spec "cypress/e2e/home.cy.ts"   # single spec
```

## Requirements

- Node.js 18+
