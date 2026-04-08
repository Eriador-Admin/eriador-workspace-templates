import { Router, Route } from "@solidjs/router";
import NavBar from "./components/NavBar";
import Home from "./pages/Home";
import About from "./pages/About";

export default function App() {
  return (
    <Router>
      <NavBar />
      <main style={{ padding: "1rem" }}>
        <Route path="/" component={Home} />
        <Route path="/about" component={About} />
      </main>
    </Router>
  );
}
