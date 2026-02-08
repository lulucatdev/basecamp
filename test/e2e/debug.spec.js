const { test, expect } = require('@playwright/test');

test('debug Vue demo page', async ({ page }) => {
  const logs = [];
  const errors = [];
  page.on('console', msg => logs.push(`[${msg.type()}] ${msg.text()}`));
  page.on('pageerror', err => errors.push(err.message));

  await page.goto('http://localhost:4002/dev/vue_demo');
  await page.waitForTimeout(5000);

  console.log('=== Console Logs ===');
  logs.forEach(l => console.log(l));
  console.log('=== Page Errors ===');
  errors.forEach(e => console.log(e));

  // Take screenshot
  await page.screenshot({ path: '/tmp/vue-demo-debug.png', fullPage: true });

  // Check page HTML
  const html = await page.content();
  const vueHookMatch = html.match(/phx-hook/g);
  console.log('=== phx-hook occurrences ===', vueHookMatch?.length || 0);

  // Check if LiveView connected
  const liveViewConnected = await page.evaluate(() => {
    return window.liveSocket?.isConnected?.() || false;
  });
  console.log('=== LiveView connected ===', liveViewConnected);
});
