from dash import Input, Output, html
import plotly.express as px

from layouts.overview_tab import create_overview_tab
from layouts.details_tab import create_details_tab


def register_overview_callbacks(app, df):
    # Tab switching
    @app.callback(
        Output("tab-content", "children"),
        Input("tabs", "value"),
        Input("categories-store", "data"),
        Input("regions-store", "data"),
    )
    def render_tab(tab, categories, regions):
        if tab == "overview":
            return create_overview_tab(categories, regions)
        return create_details_tab(categories, regions)

    # KPI cards
    @app.callback(
        Output("kpi-cards", "children"),
        Input("overview-category", "value"),
        Input("overview-region", "value"),
    )
    def update_kpis(category, region):
        filtered = df.copy()
        if category:
            filtered = filtered[filtered["category"] == category]
        if region:
            filtered = filtered[filtered["region"] == region]

        total_sales = filtered["sales"].sum()
        total_profit = filtered["profit"].sum()
        avg_quantity = filtered["quantity"].mean()
        record_count = len(filtered)

        return html.Div([
            _kpi_card("Total Sales", f"${total_sales:,.0f}"),
            _kpi_card("Total Profit", f"${total_profit:,.2f}"),
            _kpi_card("Avg Quantity", f"{avg_quantity:.1f}"),
            _kpi_card("Records", f"{record_count:,}"),
        ], className="kpi-row")

    # Sales by category chart
    @app.callback(
        Output("sales-by-category", "figure"),
        Input("overview-category", "value"),
        Input("overview-region", "value"),
    )
    def update_category_chart(category, region):
        filtered = df.copy()
        if category:
            filtered = filtered[filtered["category"] == category]
        if region:
            filtered = filtered[filtered["region"] == region]

        grouped = filtered.groupby("category")["sales"].sum().reset_index()
        fig = px.bar(grouped, x="category", y="sales", title="Sales by Category",
                     color="category")
        fig.update_layout(showlegend=False)
        return fig

    # Sales by region chart
    @app.callback(
        Output("sales-by-region", "figure"),
        Input("overview-category", "value"),
        Input("overview-region", "value"),
    )
    def update_region_chart(category, region):
        filtered = df.copy()
        if category:
            filtered = filtered[filtered["category"] == category]
        if region:
            filtered = filtered[filtered["region"] == region]

        grouped = filtered.groupby("region")["sales"].sum().reset_index()
        fig = px.pie(grouped, values="sales", names="region", title="Sales by Region")
        return fig

    # Sales over time chart
    @app.callback(
        Output("sales-over-time", "figure"),
        Input("overview-category", "value"),
        Input("overview-region", "value"),
    )
    def update_time_chart(category, region):
        filtered = df.copy()
        if category:
            filtered = filtered[filtered["category"] == category]
        if region:
            filtered = filtered[filtered["region"] == region]

        daily = filtered.groupby("date")["sales"].sum().reset_index()
        fig = px.line(daily, x="date", y="sales", title="Sales Over Time")
        return fig


def _kpi_card(title, value):
    return html.Div([
        html.H3(value),
        html.P(title),
    ], className="kpi-card")
