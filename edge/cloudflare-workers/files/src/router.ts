type RouteHandler = (
  request: Request,
  env: Env,
  params: Record<string, string>
) => Response | Promise<Response>;

interface Route {
  method: string;
  pattern: URLPattern;
  handler: RouteHandler;
}

export class Router {
  private routes: Route[] = [];

  on(method: string, path: string, handler: RouteHandler) {
    this.routes.push({
      method: method.toUpperCase(),
      pattern: new URLPattern({ pathname: path }),
      handler,
    });
  }

  get(path: string, handler: RouteHandler) { this.on("GET", path, handler); }
  put(path: string, handler: RouteHandler) { this.on("PUT", path, handler); }
  delete(path: string, handler: RouteHandler) { this.on("DELETE", path, handler); }

  async handle(request: Request, env: Env): Promise<Response> {
    for (const route of this.routes) {
      if (route.method !== request.method) continue;
      const match = route.pattern.exec(request.url);
      if (match) {
        const params = match.pathname.groups as Record<string, string>;
        return route.handler(request, env, params);
      }
    }
    return new Response("Not Found", { status: 404 });
  }
}
