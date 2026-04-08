# Agent Instructions — {{PROJECT_NAME}}

This is a RabbitMQ consumer microservice.

## Tech Stack
- **Message Broker**: RabbitMQ
- **Language**: Node.js
- **AMQP Client**: amqplib
- **Infrastructure**: Docker Compose

## Key Conventions
- Consumer logic in `src/consumer.js`
- Producer (for testing) in `src/producer.js`
- Connection helper in `src/connection.js`
- RabbitMQ runs in Docker via `docker-compose.yml`
- Queue name defined in consumer/producer
