#!/bin/bash
set -e
echo "Starting subscriber in background..."
npx tsx src/subscriber.ts &
SUBSCRIBER_PID=$!
sleep 1
echo "Starting publisher..."
npx tsx src/publisher.ts &
PUBLISHER_PID=$!

trap "kill $SUBSCRIBER_PID $PUBLISHER_PID 2>/dev/null; exit" SIGINT SIGTERM
wait
