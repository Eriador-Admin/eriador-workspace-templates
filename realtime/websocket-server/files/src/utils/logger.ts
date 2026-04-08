export function log(message: string) {
  const ts = new Date().toISOString();
  console.log(`[${ts}] ${message}`);
}
