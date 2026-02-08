const { test, expect } = require('@playwright/test');

test.describe('Basecamp Smoke Tests', () => {
  test('homepage loads successfully', async ({ page }) => {
    await page.goto('http://localhost:4002/');
    await expect(page).toHaveTitle(/Basecamp/);
    await expect(page.locator('h1')).toHaveText('Basecamp');
  });

  test('no console errors on homepage', async ({ page }) => {
    const errors = [];
    page.on('pageerror', err => errors.push(err.message));
    await page.goto('http://localhost:4002/');
    await page.waitForTimeout(2000);
    expect(errors).toEqual([]);
  });

  test('LiveVue counter server increment works', async ({ page }) => {
    await page.goto('http://localhost:4002/');

    // Wait for Vue to hydrate
    await page.waitForTimeout(3000);

    // Find the server state section
    const serverSection = page.locator('text=Server State');
    await expect(serverSection).toBeVisible();

    // Click the + button in the server (indigo) section
    await page.locator('[phx-click="increment"]').click();

    // Count should become 1
    await expect(page.locator('.text-indigo-900.text-4xl')).toHaveText('1', { timeout: 5000 });
  });

  test('LiveVue counter client increment works', async ({ page }) => {
    await page.goto('http://localhost:4002/');

    // Wait for Vue to hydrate
    await page.waitForTimeout(3000);

    // Find the client state section
    const clientSection = page.locator('text=Client State');
    await expect(clientSection).toBeVisible();

    // Click the + button in the client (emerald) section
    await page.locator('.bg-emerald-600').click();

    // Count should become 1
    await expect(page.locator('.text-emerald-900.text-4xl')).toHaveText('1', { timeout: 5000 });
  });
});
