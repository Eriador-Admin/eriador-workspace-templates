# Agent Instructions — {{PROJECT_NAME}}

This is a Telegram bot built with python-telegram-bot (v20+, async).

## Tech Stack
- **Language**: Python 3.10+
- **Library**: python-telegram-bot 20.x (async)
- **API**: Telegram Bot API

## Key Conventions
- Entry point: `main.py` creates `Application` and registers handlers
- Handlers in `handlers/` — one module per handler type
- All handler functions are `async def` (v20+ is fully async)
- Use `Update` and `ContextTypes.DEFAULT_TYPE` as handler params
- Inline keyboards: `InlineKeyboardButton` + `InlineKeyboardMarkup`
- Callback queries: use `CallbackQueryHandler`, answer with `query.answer()`
- Conversations: `ConversationHandler` with states dict mapping to handlers
- Config from environment variables via `config.py`
- Error handler: register with `application.add_error_handler()`
- Use `update.message.reply_text()` for responses, `update.message.reply_html()` for HTML
- Bot token MUST come from env var, never hardcoded
