# {{PROJECT_NAME}}

[Eclipse Mosquitto](https://mosquitto.org/) MQTT broker with TypeScript publish/subscribe clients.

## Getting Started

```bash
bash init.sh    # install deps + start Mosquitto
bash run.sh     # run subscriber + publisher demo
bash stop.sh    # stop Mosquitto
```

## Architecture

```
Mosquitto Broker (port 1883)
  ├── Publisher   → publishes sensor data to topics
  └── Subscriber  → listens on topics, processes messages
```

## Topics

| Topic | Description |
|-------|-------------|
| `sensors/temperature` | Temperature readings |
| `sensors/humidity` | Humidity readings |
| `devices/+/status` | Device status (wildcard) |
| `alerts/#` | All alert sub-topics |

## Project Structure

```
mosquitto/
  mosquitto.conf     # Broker configuration
src/
  mqtt.ts            # MQTT client factory
  subscriber.ts      # Subscribe to topics
  publisher.ts       # Publish sensor data
docker-compose.yml   # Mosquitto broker
```

## Customization

Edit `mosquitto/mosquitto.conf` to:
- Enable authentication (`password_file`)
- Enable TLS (`certfile`, `keyfile`)
- Enable WebSocket listener (port 9001)

## Requirements

- Docker
- Node.js >= 18
