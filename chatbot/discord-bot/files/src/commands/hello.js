const { SlashCommandBuilder } = require("discord.js");

module.exports = {
  data: new SlashCommandBuilder()
    .setName("hello")
    .setDescription("Greets a user")
    .addUserOption((option) =>
      option.setName("user").setDescription("User to greet").setRequired(false)
    ),

  async execute(interaction) {
    const target = interaction.options.getUser("user") || interaction.user;
    await interaction.reply(`Hello, ${target}! 👋`);
  },
};
