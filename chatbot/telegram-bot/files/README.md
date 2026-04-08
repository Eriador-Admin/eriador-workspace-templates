# {{PROJECT_NAME}}

A Telegram bot built with [python-telegram-bot](https://python-telegram-bot.org/) — a feature-rich Python wrapper for the Telegram Bot API with async support.

## Getting Started

```bash
bash init.sh    # create venv, install dependencies
bash run.sh     # start the bot
bash stop.sh    # stop the bot
```

## Prerequisites

- Python 3.10+
- Telegram Bot Token (get one from [@BotFather](https://t.me/BotFather))

### Get a Bot Token

1. Open Telegram and search for `@BotFather`
2. Send `/newbot` and follow the prompts
3. Copy the token and set it in `.env`

## Project Structure

```
main.py                     # Entry point — creates Application and adds handlers
handlers/
  commands.py               # /start, /help, /about command handlers
  messages.py               # Text message handler
  callbacks.py              # Inline keyboard callback handler
  conversation.py           # Multi-step conversation handler
config.py                   # Bot config (loads env vars)
requirements.txt            # Python dependencies
```

## Bot Commands

| Command | Description |
|---------|-------------|
| /start | Welcome message with inline keyboard |
| /help | Show available commands |
| /about | Bot info |
| /feedback | Start feedback conversation (multi-step) |

## Features

- **Command handlers** — respond to /commands
- **Message handlers** — respond to text messages
- **Inline keyboards** — interactive button menus
- **Callback queries** — handle button presses
- **Conversation handler** — multi-step flows with state
- **Error handling** — graceful error logging

## Useful Links

- [python-telegram-bot docs](https://docs.python-telegram-bot.org/)
- [Telegram Bot API](https://core.telegram.org/bots/api)
