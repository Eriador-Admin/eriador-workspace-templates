# {{FUNCTION_NAME}}

An Azure Functions v4 app built with TypeScript.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start local Functions runtime
bash stop.sh    # stop local runtime
```

## Project Structure

```
src/
  functions/
    hello.ts        # HTTP trigger function
host.json           # Azure Functions host config
local.settings.json # Local development settings
```

## Deploy

```bash
npm run build
func azure functionapp publish <app-name>
```

## Requirements

- Node.js 18+
- Azure Functions Core Tools v4 (`func`)
- Azure CLI (for deployment)
