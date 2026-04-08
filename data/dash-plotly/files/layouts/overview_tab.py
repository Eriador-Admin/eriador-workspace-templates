from dash import html, dcc


def create_overview_tab(categories, regions):
    return html.Div([
        html.Div([
            html.Div([
                html.Label("Category"),
                dcc.Dropdown(
                    id="overview-category",
                    options=[{"label": c, "value": c} for c in categories],
                    value=None,
                    placeholder="All Categories",
                    clearable=True,
                ),
            ], className="filter-item"),

            html.Div([
                html.Label("Region"),
                dcc.Dropdown(
                    id="overview-region",
                    options=[{"label": r, "value": r} for r in regions],
                    value=None,
                    placeholder="All Regions",
                    clearable=True,
                ),
            ], className="filter-item"),
        ], className="filters"),

        # KPI Cards
        html.Div(id="kpi-cards", className="kpi-row"),

        # Charts
        html.Div([
            html.Div([dcc.Graph(id="sales-by-category")], className="chart-half"),
            html.Div([dcc.Graph(id="sales-by-region")], className="chart-half"),
        ], className="chart-row"),

        html.Div([dcc.Graph(id="sales-over-time")], className="chart-full"),
    ], className="tab-content")
