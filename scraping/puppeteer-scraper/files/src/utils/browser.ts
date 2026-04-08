import "dotenv/config";
import puppeteer from "puppeteer";

const headless = process.env.HEADLESS !== "false";

export async function launchBrowser() {
  return puppeteer.launch({
    headless,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });
}
