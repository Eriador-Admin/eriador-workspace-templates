# Agent Instructions — {{PROJECT_NAME}}

This is a Puppeteer web scraping project.

## Tech Stack
- **Browser Automation**: Puppeteer
- **Language**: TypeScript
- **Runtime**: Node.js

## Key Conventions
- Entry point: `src/scraper.ts`
- Individual scrapers in `src/scrapers/`
- Browser helpers in `src/utils/browser.ts`
- Output saved to `output/` directory
- Always close browser in finally block
- Respect robots.txt and rate limits
