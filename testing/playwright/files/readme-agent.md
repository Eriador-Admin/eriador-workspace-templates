# Agent Instructions — {{PROJECT_NAME}}

This is a Playwright E2E test suite.

## Tech Stack
- **Framework**: Playwright Test
- **Language**: TypeScript
- **Pattern**: Page Object Model

## Key Conventions
- Tests in `tests/*.spec.ts` — use `test()` and `expect()`
- Page objects in `pages/*.page.ts` — encapsulate page interactions
- Config in `playwright.config.ts` — browsers, base URL, retries
- Uses Playwright's built-in assertions and auto-waiting
- Tests run in parallel by default

## File Patterns
- `tests/*.spec.ts` → Test specs
- `pages/*.page.ts` → Page objects
- `playwright.config.ts` → Test configuration
- `playwright-report/` → HTML test reports (generated)
