import { createSignal, For, Show } from "solid-js";
import { createStore, produce } from "solid-js/store";

interface Todo {
  id: number;
  text: string;
  done: boolean;
}

export default function TodoList() {
  const [todos, setTodos] = createStore<Todo[]>([]);
  const [input, setInput] = createSignal("");
  let nextId = 1;

  const addTodo = () => {
    const text = input().trim();
    if (!text) return;
    setTodos(produce((t) => t.push({ id: nextId++, text, done: false })));
    setInput("");
  };

  const toggleTodo = (id: number) => {
    setTodos(
      (todo) => todo.id === id,
      "done",
      (done) => !done
    );
  };

  const removeTodo = (id: number) => {
    setTodos(produce((t) => {
      const idx = t.findIndex((todo) => todo.id === id);
      if (idx !== -1) t.splice(idx, 1);
    }));
  };

  return (
    <div class="todo-list">
      <h3>Todo List</h3>
      <form onSubmit={(e) => { e.preventDefault(); addTodo(); }}>
        <input
          type="text"
          value={input()}
          onInput={(e) => setInput(e.currentTarget.value)}
          placeholder="Add a todo..."
        />
        <button type="submit">Add</button>
      </form>
      <Show when={todos.length > 0} fallback={<p>No todos yet!</p>}>
        <ul>
          <For each={todos}>
            {(todo) => (
              <li style={{ "text-decoration": todo.done ? "line-through" : "none" }}>
                <input
                  type="checkbox"
                  checked={todo.done}
                  onChange={() => toggleTodo(todo.id)}
                />
                {todo.text}
                <button onClick={() => removeTodo(todo.id)}>x</button>
              </li>
            )}
          </For>
        </ul>
      </Show>
    </div>
  );
}
