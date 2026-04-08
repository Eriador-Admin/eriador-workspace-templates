import { Issuer } from "openid-client";

const KEYCLOAK_URL = process.env.KEYCLOAK_URL || "http://localhost:8080";
const REALM = process.env.KEYCLOAK_REALM || "myapp";
const CLIENT_ID = process.env.KEYCLOAK_CLIENT_ID || "myapp-client";
const CLIENT_SECRET = process.env.KEYCLOAK_CLIENT_SECRET || "change-me-secret";

export async function getOidcClient() {
  const issuer = await Issuer.discover(
    `${KEYCLOAK_URL}/realms/${REALM}`
  );

  return new issuer.Client({
    client_id: CLIENT_ID,
    client_secret: CLIENT_SECRET,
    redirect_uris: ["http://localhost:3000/callback"],
    response_types: ["code"],
  });
}
