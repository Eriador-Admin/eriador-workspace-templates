# {{PROJECT_NAME}}

A Discord bot built with [discord.js](https://discord.js.org/).

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the bot
bash stop.sh    # stop the bot
```

## Setup

1. Create a bot at https://discord.com/developers/applications
2. Copy your bot token
3. Copy `.env.example` to `.env` and add your token
4. Enable **Message Content Intent** in the Discord developer portal
5. Invite the bot to your server with the OAuth2 URL generator

## Project Structure

```
src/
  index.js          # Bot entry point and client setup
  commands/
    ping.js         # /ping slash command
    hello.js        # /hello slash command
  events/
    ready.js        # Bot ready event
    interactionCreate.js  # Slash command handler
  deploy-commands.js  # Register slash commands with Discord API
```

## Registering Commands

```bash
node src/deploy-commands.js
```

## Requirements

- Node.js 18+
- Discord bot token
