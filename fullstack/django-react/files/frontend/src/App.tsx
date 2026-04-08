import { useEffect, useState } from "react";

interface Item {
  id: number;
  name: string;
  done: boolean;
}

export default function App() {
  const [items, setItems] = useState<Item[]>([]);
  const [message, setMessage] = useState("");

  useEffect(() => {
    fetch("/api/hello/")
      .then((r) => r.json())
      .then((d) => setMessage(d.message));
    fetch("/api/items/")
      .then((r) => r.json())
      .then((d) => setItems(d));
  }, []);

  return (
    <div style={{ fontFamily: "system-ui, sans-serif", padding: "2rem" }}>
      <h1>{{PROJECT_NAME}}</h1>
      <p>{message}</p>
      <h2>Items</h2>
      <ul>
        {items.map((item) => (
          <li key={item.id}>
            {item.name} {item.done ? "✅" : "⬜"}
          </li>
        ))}
      </ul>
    </div>
  );
}
