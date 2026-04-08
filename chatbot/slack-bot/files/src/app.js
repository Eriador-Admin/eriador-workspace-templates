require("dotenv").config();
const { App } = require("@slack/bolt");

const app = new App({
  token: process.env.SLACK_BOT_TOKEN,
  signingSecret: process.env.SLACK_SIGNING_SECRET,
  socketMode: true,
  appToken: process.env.SLACK_APP_TOKEN,
  port: {{DEV_PORT}},
});

// Load commands
require("./commands/hello")(app);

// Load events
require("./events/app-mention")(app);
require("./events/message")(app);

(async () => {
  await app.start();
  console.log("⚡ {{PROJECT_NAME}} is running on port {{DEV_PORT}}!");
})();
