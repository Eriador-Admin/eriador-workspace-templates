module.exports = function (app) {
  app.message("hello", async ({ message, say }) => {
    await say(`Hey <@${message.user}>! 👋`);
  });
};
