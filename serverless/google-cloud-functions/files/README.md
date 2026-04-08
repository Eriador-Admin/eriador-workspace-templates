# {{FUNCTION_NAME}}

A Google Cloud Function built with Node.js and the Functions Framework.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start local dev server
bash stop.sh    # stop local server
```

## Project Structure

```
index.js            # Function entry point
test/
  index.test.js     # Unit tests
```

## Deploy

```bash
gcloud functions deploy {{FUNCTION_NAME}} \
  --gen2 \
  --runtime=nodejs20 \
  --region={{GCP_REGION}} \
  --trigger-http \
  --allow-unauthenticated \
  --entry-point=helloWorld
```

## Requirements

- Node.js 18+
- Google Cloud SDK (`gcloud`)
- GCP project with Cloud Functions API enabled
