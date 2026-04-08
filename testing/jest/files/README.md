# {{PROJECT_NAME}}

A Jest testing project with TypeScript, coverage reporting, and example tests.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # run all tests
bash stop.sh    # stop watch mode
```

## Project Structure

```
src/
  math.ts             # Example module
  string-utils.ts     # Example module
__tests__/
  math.test.ts        # Unit tests for math module
  string-utils.test.ts # Unit tests for string-utils
jest.config.ts        # Jest configuration
tsconfig.json         # TypeScript configuration
```

## Commands

```bash
npm test              # Run all tests once
npm run test:watch    # Watch mode
npm run test:coverage # With coverage report
```

## Requirements

- Node.js 18+
