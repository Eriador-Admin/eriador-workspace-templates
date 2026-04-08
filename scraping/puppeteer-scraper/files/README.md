# {{PROJECT_NAME}}

A web scraper built with [Puppeteer](https://pptr.dev/) for headless Chrome automation.

## Getting Started

```bash
bash init.sh    # install dependencies (includes Chromium)
bash run.sh     # run the scraper
bash stop.sh    # stop running scrapers
```

## Project Structure

```
src/
  scraper.ts        # Main scraper entry point
  scrapers/
    example.ts      # Example: scrape Hacker News titles
  utils/
    browser.ts      # Browser launch helper
    storage.ts      # Save results to JSON/CSV
output/             # Scraped data output directory
```

## Requirements

- Node.js 18+
- ~400MB disk for Chromium download
