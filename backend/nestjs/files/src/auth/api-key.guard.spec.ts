import { ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { ApiKeyGuard } from './api-key.guard';

function contextWith(authorization?: string): ExecutionContext {
  return {
    switchToHttp: () => ({
      getRequest: () => ({ headers: { authorization } }),
    }),
  } as unknown as ExecutionContext;
}

describe('ApiKeyGuard', () => {
  const guard = new ApiKeyGuard();
  const original = process.env.API_TOKEN;

  afterEach(() => {
    process.env.API_TOKEN = original;
  });

  it('rejects requests when API_TOKEN is not configured', () => {
    delete process.env.API_TOKEN;
    expect(() => guard.canActivate(contextWith('Bearer any'))).toThrow(
      UnauthorizedException,
    );
  });

  it('rejects a missing or wrong token', () => {
    process.env.API_TOKEN = 'expected-token';
    expect(() => guard.canActivate(contextWith())).toThrow(UnauthorizedException);
    expect(() => guard.canActivate(contextWith('Bearer wrong-token!'))).toThrow(
      UnauthorizedException,
    );
  });

  it('accepts the configured token', () => {
    process.env.API_TOKEN = 'expected-token';
    expect(guard.canActivate(contextWith('Bearer expected-token'))).toBe(true);
  });
});
