import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): { message: string; service: string } {
    return { message: 'Hello from {{SERVICE_NAME}}!', service: '{{SERVICE_NAME}}' };
  }
}
