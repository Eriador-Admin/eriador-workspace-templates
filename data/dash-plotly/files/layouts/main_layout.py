from dash import html, dcc

from layouts.overview_tab import create_overview_tab
from layouts.details_tab import create_details_tab


def create_layout(df):
    categories = sorted(df["category"].unique())
    regions = sorted(df["region"].unique())

    return html.Div([
        html.H1("{{PROJECT_NAME}}"),
        html.P("Interactive analytics dashboard built with Dash & Plotly"),

        dcc.Tabs(id="tabs", value="overview", children=[
            dcc.Tab(label="Overview", value="overview"),
            dcc.Tab(label="Details", value="details"),
        ]),

        html.Div(id="tab-content"),

        # Hidden stores for filter state
        dcc.Store(id="categories-store", data=categories),
        dcc.Store(id="regions-store", data=regions),
    ])
