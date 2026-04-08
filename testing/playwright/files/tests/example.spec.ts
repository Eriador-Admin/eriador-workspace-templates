import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/home.page';

test.describe('Home Page', () => {
  let homePage: HomePage;

  test.beforeEach(async ({ page }) => {
    homePage = new HomePage(page);
    await homePage.goto();
  });

  test('should have a title', async ({ page }) => {
    await expect(page).toHaveTitle(/.*/);
  });

  test('should display heading', async () => {
    const heading = await homePage.getHeading();
    expect(heading).toBeTruthy();
  });
});
