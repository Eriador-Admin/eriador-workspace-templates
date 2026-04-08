import { useSignal } from "@preact/signals";

interface CounterProps {
  start: number;
}

export default function Counter(props: CounterProps) {
  const count = useSignal(props.start);

  return (
    <div style={{ display: "flex", gap: "1rem", alignItems: "center" }}>
      <button onClick={() => count.value--}>-</button>
      <span style={{ fontSize: "1.5rem", minWidth: "3rem", textAlign: "center" }}>
        {count}
      </span>
      <button onClick={() => count.value++}>+</button>
    </div>
  );
}
