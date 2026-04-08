import { launchBrowser } from "./utils/browser.js";
import { scrapeHackerNews } from "./scrapers/example.js";

async function main() {
  const browser = await launchBrowser();
  try {
    const page = await browser.newPage();
    await scrapeHackerNews(page);
  } finally {
    await browser.close();
  }
}

main().catch((err) => {
  console.error("Scraper failed:", err);
  process.exit(1);
});
