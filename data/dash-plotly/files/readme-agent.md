# Agent Instructions — {{PROJECT_NAME}}

This is an interactive dashboard built with Dash (Plotly) in Python.

## Tech Stack
- **Language**: Python 3.10+
- **Framework**: Dash 2.x
- **Charts**: Plotly Express + Plotly Graph Objects
- **Data**: Pandas DataFrames

## Key Conventions
- Entry point: `app.py` creates the Dash app and registers callbacks
- Layouts in `layouts/` — each tab/page is a separate module returning a component tree
- Callbacks in `callbacks/` — register with `@app.callback(Output, Input, State)`
- Use `dash.html` for HTML elements (Div, H1, P, etc.)
- Use `dash.dcc` for core components (Graph, Dropdown, Slider, DatePicker, etc.)
- Use `dash_table.DataTable` for interactive data tables
- Use Plotly Express (`px`) for quick charts, `go.Figure` for complex ones
- Callbacks must return the exact number of outputs declared
- Use `dash.no_update` to skip updating a particular output
- Use `dash.callback_context` (or `ctx`) to determine which input triggered callback
- Assets in `assets/` are auto-loaded (CSS and JS)
- DataFrames are the standard data format — pass via `dcc.Store` or module-level vars
