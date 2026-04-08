import { A } from "@solidjs/router";

export default function NavBar() {
  return (
    <nav class="navbar">
      <A href="/">Home</A>
      <A href="/about">About</A>
    </nav>
  );
}
