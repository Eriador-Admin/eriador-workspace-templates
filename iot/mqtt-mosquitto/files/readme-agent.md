# Agent Instructions — {{PROJECT_NAME}}

This is an MQTT messaging project using Eclipse Mosquitto.

## Tech Stack
- **Broker**: Eclipse Mosquitto (Docker)
- **Language**: TypeScript
- **Client Library**: mqtt.js
- **Runtime**: Node.js

## Key Conventions
- Broker config in `mosquitto/mosquitto.conf`
- Default broker port: 1883
- Topics use `/` hierarchy: `sensors/temperature`
- Wildcards: `+` (single level), `#` (multi level)
- QoS levels: 0 (at most once), 1 (at least once), 2 (exactly once)
