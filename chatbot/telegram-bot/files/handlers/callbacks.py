from telegram import Update
from telegram.ext import ContextTypes


async def handle_callback(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    await query.answer()

    data = query.data

    if data == "help":
        await query.edit_message_text(
            "Available Commands:\n\n"
            "/start - Welcome message\n"
            "/help - Show help\n"
            "/about - About this bot\n"
            "/feedback - Submit feedback"
        )
    elif data == "about":
        await query.edit_message_text(
            "Built with python-telegram-bot v20.\n"
            "A template project for Belfalas workspace."
        )
    else:
        await query.edit_message_text(f"Unknown action: {data}")
