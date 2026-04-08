import { auth, signIn, signOut } from "@/auth";

export default async function Home() {
  const session = await auth();

  return (
    <div style={{ padding: "2rem", maxWidth: 600 }}>
      <h1>{{PROJECT_NAME}}</h1>
      {session?.user ? (
        <div>
          <p>
            Signed in as <strong>{session.user.name}</strong> ({session.user.email})
          </p>
          <a href="/dashboard">Go to Dashboard</a>
          <form
            action={async () => {
              "use server";
              await signOut();
            }}
          >
            <button type="submit" style={{ marginTop: "1rem" }}>
              Sign Out
            </button>
          </form>
        </div>
      ) : (
        <div>
          <p>You are not signed in.</p>
          <form
            action={async () => {
              "use server";
              await signIn("github");
            }}
          >
            <button type="submit">Sign in with GitHub</button>
          </form>
          <form
            action={async () => {
              "use server";
              await signIn("google");
            }}
          >
            <button type="submit" style={{ marginTop: "0.5rem" }}>
              Sign in with Google
            </button>
          </form>
        </div>
      )}
    </div>
  );
}
