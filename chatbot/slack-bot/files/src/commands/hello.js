module.exports = function (app) {
  app.command("/hello", async ({ command, ack, respond }) => {
    await ack();
    await respond(`Hello, <@${command.user_id}>! 👋`);
  });
};
