import "dotenv/config";
import express from "express";
import session from "express-session";
import { generators } from "openid-client";
import { getOidcClient } from "./auth.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(
  session({
    secret: process.env.SESSION_SECRET || "change-me",
    resave: false,
    saveUninitialized: false,
  })
);

declare module "express-session" {
  interface SessionData {
    tokens?: Record<string, unknown>;
    userinfo?: Record<string, unknown>;
    nonce?: string;
    state?: string;
  }
}

app.get("/", (req, res) => {
  const user = req.session.userinfo;
  res.send(`
    <h1>{{PROJECT_NAME}}</h1>
    ${user
      ? `<p>Logged in as: <strong>${(user as Record<string, string>).preferred_username}</strong></p>
         <a href="/protected">Protected Page</a> | <a href="/logout">Logout</a>`
      : `<a href="/login">Login with Keycloak</a>`
    }
  `);
});

app.get("/login", async (req, res) => {
  const client = await getOidcClient();
  const nonce = generators.nonce();
  const state = generators.state();
  req.session.nonce = nonce;
  req.session.state = state;
  const url = client.authorizationUrl({ scope: "openid profile email", nonce, state });
  res.redirect(url);
});

app.get("/callback", async (req, res) => {
  const client = await getOidcClient();
  const params = client.callbackParams(req);
  const tokens = await client.callback("http://localhost:3000/callback", params, {
    nonce: req.session.nonce,
    state: req.session.state,
  });
  req.session.tokens = tokens as unknown as Record<string, unknown>;
  req.session.userinfo = await client.userinfo(tokens);
  res.redirect("/");
});

app.get("/protected", (req, res) => {
  if (!req.session.userinfo) return res.redirect("/login");
  res.send(`
    <h1>Protected Page</h1>
    <pre>${JSON.stringify(req.session.userinfo, null, 2)}</pre>
    <a href="/">Home</a>
  `);
});

app.get("/logout", (req, res) => {
  req.session.destroy(() => {
    res.redirect("/");
  });
});

app.listen(PORT, () => {
  console.log(`App: http://localhost:${PORT}`);
  console.log(`Keycloak: http://localhost:8080`);
});
