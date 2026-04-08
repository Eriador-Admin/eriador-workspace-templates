from telegram import Update, ReplyKeyboardMarkup, ReplyKeyboardRemove
from telegram.ext import (
    ContextTypes,
    ConversationHandler,
    CommandHandler,
    MessageHandler,
    filters,
)

# Conversation states
RATING, COMMENT = range(2)


async def feedback_start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    keyboard = [["1", "2", "3", "4", "5"]]
    reply_markup = ReplyKeyboardMarkup(keyboard, one_time_keyboard=True, resize_keyboard=True)

    await update.message.reply_text(
        "How would you rate your experience? (1-5)",
        reply_markup=reply_markup,
    )
    return RATING


async def feedback_rating(update: Update, context: ContextTypes.DEFAULT_TYPE):
    rating = update.message.text
    if rating not in ("1", "2", "3", "4", "5"):
        await update.message.reply_text("Please pick a number from 1 to 5.")
        return RATING

    context.user_data["rating"] = int(rating)
    await update.message.reply_text(
        "Thanks! Any additional comments? (or /skip)",
        reply_markup=ReplyKeyboardRemove(),
    )
    return COMMENT


async def feedback_comment(update: Update, context: ContextTypes.DEFAULT_TYPE):
    comment = update.message.text
    rating = context.user_data.get("rating", "?")

    await update.message.reply_text(
        f"Thank you for your feedback!\n"
        f"Rating: {rating}/5\n"
        f"Comment: {comment}"
    )
    context.user_data.clear()
    return ConversationHandler.END


async def feedback_skip(update: Update, context: ContextTypes.DEFAULT_TYPE):
    rating = context.user_data.get("rating", "?")

    await update.message.reply_text(
        f"Thank you for your feedback!\nRating: {rating}/5"
    )
    context.user_data.clear()
    return ConversationHandler.END


async def feedback_cancel(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(
        "Feedback cancelled.",
        reply_markup=ReplyKeyboardRemove(),
    )
    context.user_data.clear()
    return ConversationHandler.END


feedback_conversation = ConversationHandler(
    entry_points=[CommandHandler("feedback", feedback_start)],
    states={
        RATING: [MessageHandler(filters.TEXT & ~filters.COMMAND, feedback_rating)],
        COMMENT: [
            CommandHandler("skip", feedback_skip),
            MessageHandler(filters.TEXT & ~filters.COMMAND, feedback_comment),
        ],
    },
    fallbacks=[CommandHandler("cancel", feedback_cancel)],
)
