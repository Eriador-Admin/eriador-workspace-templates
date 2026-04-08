import { NestFactory } from '@nestjs/core';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Connect TCP microservice transport
  app.connectMicroservice<MicroserviceOptions>({
    transport: Transport.TCP,
    options: { host: '0.0.0.0', port: {{TCP_PORT}} },
  });

  await app.startAllMicroservices();
  await app.listen({{HTTP_PORT}});

  console.log(`HTTP server on http://localhost:{{HTTP_PORT}}`);
  console.log(`TCP microservice on port {{TCP_PORT}}`);
}

bootstrap();
