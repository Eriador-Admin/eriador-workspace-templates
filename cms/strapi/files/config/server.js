module.exports = ({ env }) => ({
  host: env('HOST', '0.0.0.0'),
  port: env.int('PORT', {{DEV_PORT}}),
  app: {
    keys: env.array('APP_KEYS'),
  },
});
