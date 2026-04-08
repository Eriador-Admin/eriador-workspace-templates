import winston from "winston";

const logstashHost = process.env.LOGSTASH_HOST || "localhost";
const logstashPort = parseInt(process.env.LOGSTASH_PORT || "5044", 10);

const transports: winston.transport[] = [
  new winston.transports.Console({
    format: winston.format.combine(
      winston.format.colorize(),
      winston.format.simple()
    ),
  }),
];

// Add Logstash transport if available
try {
  const { LogstashTransport } = await import("winston-logstash");
  transports.push(
    new LogstashTransport({
      port: logstashPort,
      host: logstashHost,
      max_connect_retries: 5,
    })
  );
} catch {
  // Logstash transport optional — falls back to console
}

export const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || "info",
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  defaultMeta: { service: "{{PROJECT_NAME}}" },
  transports,
});
