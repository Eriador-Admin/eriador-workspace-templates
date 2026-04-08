from dash import html, dcc, dash_table


def create_details_tab(categories, regions):
    return html.Div([
        html.Div([
            html.Div([
                html.Label("Category"),
                dcc.Dropdown(
                    id="details-category",
                    options=[{"label": c, "value": c} for c in categories],
                    value=None,
                    placeholder="All Categories",
                    clearable=True,
                ),
            ], className="filter-item"),

            html.Div([
                html.Label("Min Sales"),
                dcc.Input(
                    id="details-min-sales",
                    type="number",
                    placeholder="0",
                    value=0,
                ),
            ], className="filter-item"),
        ], className="filters"),

        html.Div([
            dash_table.DataTable(
                id="data-table",
                columns=[
                    {"name": "Date", "id": "date"},
                    {"name": "Category", "id": "category"},
                    {"name": "Region", "id": "region"},
                    {"name": "Sales", "id": "sales", "type": "numeric"},
                    {"name": "Quantity", "id": "quantity", "type": "numeric"},
                    {"name": "Profit", "id": "profit", "type": "numeric"},
                ],
                page_size=15,
                sort_action="native",
                filter_action="native",
                style_table={"overflowX": "auto"},
                style_cell={"textAlign": "left", "padding": "8px"},
                style_header={"fontWeight": "bold", "backgroundColor": "#1a1a2e", "color": "white"},
            ),
        ]),
    ], className="tab-content")
