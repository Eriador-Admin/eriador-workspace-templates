from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import ContextTypes

from config import BOT_NAME


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    keyboard = [
        [
            InlineKeyboardButton("Help", callback_data="help"),
            InlineKeyboardButton("About", callback_data="about"),
        ],
        [InlineKeyboardButton("Visit Website", url="https://example.com")],
    ]
    reply_markup = InlineKeyboardMarkup(keyboard)

    await update.message.reply_html(
        f"Welcome to <b>{BOT_NAME}</b>!\n\n"
        "I'm a bot built with python-telegram-bot.\n"
        "Use /help to see available commands.",
        reply_markup=reply_markup,
    )


async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    help_text = (
        "<b>Available Commands</b>\n\n"
        "/start - Welcome message\n"
        "/help - Show this help\n"
        "/about - About this bot\n"
        "/feedback - Submit feedback\n"
    )
    await update.message.reply_html(help_text)


async def about(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_html(
        f"<b>{BOT_NAME}</b>\n\n"
        "Built with python-telegram-bot v20.\n"
        "A template project for Belfalas workspace."
    )
