# {{PROJECT_NAME}}

An interactive data dashboard built with [Dash](https://dash.plotly.com/) by Plotly — a Python framework for building analytical web applications with no JavaScript required.

## Getting Started

```bash
bash init.sh    # create venv, install dependencies
bash run.sh     # start dashboard on port 8050
bash stop.sh    # stop server
```

## Prerequisites

- Python 3.10+

## Project Structure

```
app.py                      # Main Dash application
layouts/
  main_layout.py             # Page layout with tabs
  overview_tab.py            # Overview tab (KPI cards + charts)
  details_tab.py             # Details tab (data table + filters)
callbacks/
  overview_callbacks.py      # Callbacks for overview tab
  details_callbacks.py       # Callbacks for details tab
data/
  sample_data.py             # Sample dataset generator
assets/
  style.css                  # Custom CSS styling
```

## Dash Concepts

- **Layout**: HTML + Dash components define the UI (no templates)
- **Callbacks**: Python functions triggered by user interaction
- **Input/Output/State**: Decorator-based reactive binding
- **Plotly graphs**: `dcc.Graph(figure=px.bar(...))` for charts
- **DataTable**: `dash_table.DataTable` for interactive tables

## Callback Pattern

```python
@app.callback(
    Output("graph-id", "figure"),      # What to update
    Input("dropdown-id", "value"),     # What triggers the update
    State("text-id", "value"),         # Extra data (no trigger)
)
def update_graph(dropdown_value, text_value):
    fig = px.bar(df, x="col", y="val")
    return fig
```

Visit http://localhost:8050 after starting.
