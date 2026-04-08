# Agent Instructions — {{PROJECT_NAME}}

This is a SolidJS SPA with Vite.

## Tech Stack
- **Framework**: SolidJS 1.8+
- **Bundler**: Vite
- **Language**: TypeScript + JSX
- **Router**: @solidjs/router

## Key Conventions
- `createSignal()` returns `[getter, setter]` — call getter as function: `count()` not `count`
- `createStore()` for complex nested state — use `produce()` for immutable-style updates
- `createEffect()` auto-tracks signals used inside — no dependency array
- `createMemo()` for derived/computed values
- Components are functions that run ONCE — only the reactive expressions re-execute
- Control flow components: `<Show when={}>`, `<For each={}>`, `<Switch>/<Match>`
- Don't destructure props — it breaks reactivity. Use `props.name` or `splitProps()`
- Event handlers: `onClick` (camelCase), `on:click` (lowercase for delegation)
- JSX uses `class` not `className`, `for` not `htmlFor`
- Vite plugin: `vite-plugin-solid` handles JSX transform
- File extensions: `.tsx` for components, `.ts` for utilities
