// @ts-check

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: '{{PROJECT_NAME}}',
  tagline: 'Documentation site',
  favicon: 'img/favicon.ico',

  url: 'https://example.com',
  baseUrl: '/',

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: './sidebars.js',
          routeBasePath: '/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      navbar: {
        title: '{{PROJECT_NAME}}',
        items: [],
      },
      footer: {
        style: 'dark',
        copyright: `Copyright © {{YEAR}} {{AUTHOR}}. Built with Docusaurus.`,
      },
    }),
};

module.exports = config;
