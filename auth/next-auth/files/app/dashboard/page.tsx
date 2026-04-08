import { auth } from "@/auth";

export default async function Dashboard() {
  const session = await auth();

  return (
    <div style={{ padding: "2rem" }}>
      <h1>Dashboard</h1>
      <p>Welcome, {session?.user?.name}! This page is protected by middleware.</p>
      <a href="/">Back to home</a>
    </div>
  );
}
