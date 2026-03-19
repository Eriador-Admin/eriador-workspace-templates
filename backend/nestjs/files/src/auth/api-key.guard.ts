import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Request } from 'express';
import { timingSafeEqual } from 'crypto';

/**
 * Simple API-key guard: requires `Authorization: Bearer <API_TOKEN>`.
 * Set `API_TOKEN` in your .env file.
 */
@Injectable()
export class ApiKeyGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const apiToken = process.env.API_TOKEN;
    if (!apiToken) {
      throw new UnauthorizedException('API_TOKEN is not configured');
    }

    const request = context.switchToHttp().getRequest<Request>();
    const authHeader = request.headers.authorization;
    if (!authHeader?.startsWith('Bearer ')) {
      throw new UnauthorizedException('Missing Bearer token');
    }

    const token = authHeader.slice(7);
    if (token.length !== apiToken.length) {
      throw new UnauthorizedException('Invalid token');
    }

    const isValid = timingSafeEqual(
      Buffer.from(token),
      Buffer.from(apiToken),
    );
    if (!isValid) {
      throw new UnauthorizedException('Invalid token');
    }

    return true;
  }
}
