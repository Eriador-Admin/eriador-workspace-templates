import { app, HttpRequest, HttpResponseInit, InvocationContext } from '@azure/functions';

async function hello(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
  context.log(`Http function processed request for url "${request.url}"`);

  const name = request.query.get('name') || 'World';

  return {
    status: 200,
    jsonBody: {
      message: `Hello from {{FUNCTION_NAME}}!`,
      name,
      timestamp: new Date().toISOString(),
    },
  };
}

app.http('hello', {
  methods: ['GET', 'POST'],
  authLevel: 'anonymous',
  handler: hello,
});
