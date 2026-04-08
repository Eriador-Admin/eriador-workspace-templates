import { defineConfig } from 'cypress';

export default defineConfig({
  e2e: {
    baseUrl: '{{BASE_URL}}',
    supportFile: 'cypress/support/e2e.ts',
    specPattern: 'cypress/e2e/**/*.cy.{ts,tsx}',
    video: false,
    screenshotOnRunFailure: true,
    viewportWidth: 1280,
    viewportHeight: 720,
  },
});
