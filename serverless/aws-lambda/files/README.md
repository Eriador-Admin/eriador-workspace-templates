# {{FUNCTION_NAME}}

An AWS Lambda function with API Gateway, built with Node.js and AWS SAM.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start local API with SAM
bash stop.sh    # stop local API
```

## Project Structure

```
src/
  handlers/
    hello.mjs       # Lambda handler
template.yaml       # SAM template
events/
  event.json        # Sample API Gateway event
```

## Deploy

```bash
sam build
sam deploy --guided
```

## Requirements

- Node.js 18+
- AWS SAM CLI
- Docker (for local Lambda emulation)
- AWS credentials configured
