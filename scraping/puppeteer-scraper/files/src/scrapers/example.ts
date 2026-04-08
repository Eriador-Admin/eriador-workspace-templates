import type { Page } from "puppeteer";
import { saveJSON } from "../utils/storage.js";

interface HNItem {
  rank: string;
  title: string;
  url: string;
}

export async function scrapeHackerNews(page: Page): Promise<HNItem[]> {
  console.log("Navigating to Hacker News...");
  await page.goto("https://news.ycombinator.com", { waitUntil: "domcontentloaded" });

  const items = await page.evaluate(() => {
    const rows = document.querySelectorAll(".athing");
    return Array.from(rows).map((row) => {
      const rank = row.querySelector(".rank")?.textContent?.trim() || "";
      const link = row.querySelector(".titleline > a") as HTMLAnchorElement | null;
      return {
        rank,
        title: link?.textContent?.trim() || "",
        url: link?.href || "",
      };
    });
  });

  saveJSON("hackernews.json", items);
  console.log(`Scraped ${items.length} items from Hacker News`);
  return items;
}
