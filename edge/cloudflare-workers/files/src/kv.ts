export async function kvGet(request: Request, env: Env, params: Record<string, string>) {
  const value = await env.MY_KV.get(params.key);
  if (value === null) {
    return Response.json({ error: "Key not found" }, { status: 404 });
  }
  return Response.json({ key: params.key, value });
}

export async function kvPut(request: Request, env: Env, params: Record<string, string>) {
  const body = await request.text();
  if (!body) {
    return Response.json({ error: "Body is required" }, { status: 400 });
  }
  await env.MY_KV.put(params.key, body);
  return Response.json({ key: params.key, value: body });
}

export async function kvDelete(request: Request, env: Env, params: Record<string, string>) {
  await env.MY_KV.delete(params.key);
  return Response.json({ deleted: params.key });
}
