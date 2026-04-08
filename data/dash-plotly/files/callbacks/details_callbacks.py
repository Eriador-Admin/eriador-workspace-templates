from dash import Input, Output


def register_details_callbacks(app, df):
    @app.callback(
        Output("data-table", "data"),
        Input("details-category", "value"),
        Input("details-min-sales", "value"),
    )
    def update_table(category, min_sales):
        filtered = df.copy()
        if category:
            filtered = filtered[filtered["category"] == category]
        if min_sales and min_sales > 0:
            filtered = filtered[filtered["sales"] >= min_sales]

        filtered = filtered.sort_values("date", ascending=False)
        filtered["date"] = filtered["date"].dt.strftime("%Y-%m-%d")
        return filtered.to_dict("records")
