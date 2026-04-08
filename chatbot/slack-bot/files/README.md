# {{PROJECT_NAME}}

A Slack bot built with [Bolt for JavaScript](https://slack.dev/bolt-js/).

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the bot
bash stop.sh    # stop the bot
```

## Setup

1. Create a Slack app at https://api.slack.com/apps
2. Enable **Socket Mode** (or set up a public URL for Events API)
3. Add bot scopes: `chat:write`, `commands`, `app_mentions:read`
4. Install the app to your workspace
5. Copy tokens to `.env`

## Project Structure

```
src/
  app.js            # Bolt app setup and entry point
  commands/
    hello.js        # /hello slash command
  events/
    app-mention.js  # @bot mention handler
    message.js      # Message event handler
```

## Requirements

- Node.js 18+
- Slack workspace with admin access
