# {{PROJECT_NAME}}

End-to-end tests with [Playwright](https://playwright.dev/) and TypeScript.

## Getting Started

```bash
bash init.sh    # install deps & browsers
bash run.sh     # run all tests
bash stop.sh    # nothing to stop
```

## Project Structure

```
tests/
  example.spec.ts       # Example test
pages/
  home.page.ts          # Page object
playwright.config.ts    # Playwright configuration
```

## Commands

```bash
npx playwright test                    # run all tests
npx playwright test --headed           # run with browser visible
npx playwright test --ui               # open interactive UI mode
npx playwright show-report             # view HTML report
npx playwright codegen {{BASE_URL}}    # record tests
```

## Requirements

- Node.js 18+
