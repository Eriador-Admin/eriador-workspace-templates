import { type Page, type Locator } from '@playwright/test';

export class HomePage {
  readonly page: Page;
  readonly heading: Locator;

  constructor(page: Page) {
    this.page = page;
    this.heading = page.locator('h1').first();
  }

  async goto() {
    await this.page.goto('/');
  }

  async getHeading(): Promise<string | null> {
    return this.heading.textContent();
  }
}
