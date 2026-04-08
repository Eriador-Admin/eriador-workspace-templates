# {{PROJECT_NAME}}

A message queue consumer service with [RabbitMQ](https://www.rabbitmq.com/) and Node.js.

## Getting Started

```bash
bash init.sh    # install deps & start RabbitMQ
bash run.sh     # start the consumer
bash stop.sh    # stop consumer & RabbitMQ
```

RabbitMQ Management UI: `http://localhost:{{RABBITMQ_MGMT_PORT}}` (guest/guest)

## Project Structure

```
src/
  consumer.js     # Message consumer
  producer.js     # Test message producer
  connection.js   # RabbitMQ connection helper
docker-compose.yml  # RabbitMQ container
```

## Testing

```bash
# In one terminal, start the consumer
node src/consumer.js

# In another terminal, send test messages
node src/producer.js "Hello from RabbitMQ!"
```

## Requirements

- Node.js 18+
- Docker (for RabbitMQ)
