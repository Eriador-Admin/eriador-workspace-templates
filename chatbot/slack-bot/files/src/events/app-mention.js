module.exports = function (app) {
  app.event("app_mention", async ({ event, say }) => {
    await say(`Hey there <@${event.user}>! You mentioned me. How can I help?`);
  });
};
