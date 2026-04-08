import Counter from "../components/Counter";
import TodoList from "../components/TodoList";

export default function Home() {
  return (
    <div>
      <h1>{{PROJECT_NAME}}</h1>
      <p>A SolidJS application with fine-grained reactivity.</p>
      <Counter />
      <TodoList />
    </div>
  );
}
