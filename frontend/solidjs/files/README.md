# {{PROJECT_NAME}}

A reactive single-page application built with [SolidJS](https://www.solidjs.com/) — fine-grained reactivity without a virtual DOM. Powered by Vite for instant HMR.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # dev server on port 3000
bash stop.sh    # stop dev server
```

## Prerequisites

- Node.js 18+

## Project Structure

```
src/
  index.tsx                     # App mount
  App.tsx                       # Root component with router
  components/
    Counter.tsx                 # Signal-based counter
    TodoList.tsx                # Todo list with createStore
    NavBar.tsx                  # Navigation bar
  pages/
    Home.tsx                    # Home page
    About.tsx                   # About page
  styles/
    app.css                     # Global styles
```

## SolidJS Highlights

- **Fine-grained reactivity** — only the exact DOM nodes that depend on a signal update
- **No virtual DOM** — compiles to real DOM operations
- **Signals** — `createSignal()` for reactive state
- **Stores** — `createStore()` for nested reactive objects
- **Effects** — `createEffect()` for side effects
- **Memos** — `createMemo()` for derived state
- **Control flow** — `<Show>`, `<For>`, `<Switch>`, `<Match>`
