# Agent Instructions — {{PROJECT_NAME}}

This is a Discord bot using discord.js v14.

## Tech Stack
- **Library**: discord.js v14
- **Language**: JavaScript (Node.js)
- **Pattern**: Modular commands + event handlers

## Key Conventions
- Bot entry point: `src/index.js`
- Slash commands in `src/commands/` — export `data` (SlashCommandBuilder) and `execute(interaction)`
- Event handlers in `src/events/` — export `name`, `once` (optional), `execute`
- Command registration script: `src/deploy-commands.js`
- Bot token and client ID in `.env`
