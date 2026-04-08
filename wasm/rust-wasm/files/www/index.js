import init, { greet, fibonacci } from "../pkg/{{PROJECT_NAME}}.js";

async function main() {
  await init();

  const output = document.getElementById("output");
  const greeting = greet("World");
  const fib10 = fibonacci(10);

  output.textContent = `${greeting}\nfibonacci(10) = ${fib10}`;
}

main();
