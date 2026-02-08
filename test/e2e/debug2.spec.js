const { test, expect } = require('@playwright/test');

test('detailed debug Vue demo page', async ({ page }) => {
  const logs = [];
  const errors = [];
  const requests = [];

  page.on('console', msg => logs.push(`[${msg.type()}] ${msg.text()}`));
  page.on('pageerror', err => errors.push(err.message));
  page.on('requestfailed', req => requests.push(`FAILED: ${req.url()} ${req.failure()?.errorText}`));

  await page.goto('http://localhost:4002/dev/vue_demo');
  await page.waitForTimeout(8000);

  console.log('=== Console Logs ===');
  logs.forEach(l => console.log(l));
  console.log('=== Page Errors ===');
  errors.forEach(e => console.log(e));
  console.log('=== Failed Requests ===');
  requests.forEach(r => console.log(r));

  // Check LiveView and LiveSocket
  const status = await page.evaluate(() => {
    const ls = window.liveSocket;
    return {
      liveSocketExists: !!ls,
      isConnected: ls?.isConnected?.() || false,
      viewLogCount: ls?.viewLogger ? 'has logger' : 'no logger',
    };
  });
  console.log('=== LiveSocket Status ===', JSON.stringify(status));

  // Check if the Vue demo div has the hook attribute
  const hookEl = await page.locator('[phx-hook]').count();
  console.log('=== Elements with phx-hook ===', hookEl);

  if (hookEl > 0) {
    const hookName = await page.locator('[phx-hook]').first().getAttribute('phx-hook');
    console.log('=== Hook name ===', hookName);
  }

  // Screenshot
  await page.screenshot({ path: '/tmp/vue-demo-debug2.png', fullPage: true });
});
