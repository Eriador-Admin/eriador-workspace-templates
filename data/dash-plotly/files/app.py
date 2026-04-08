from dash import Dash, html, dcc

from layouts.main_layout import create_layout
from callbacks.overview_callbacks import register_overview_callbacks
from callbacks.details_callbacks import register_details_callbacks
from data.sample_data import generate_sample_data

# Load data
df = generate_sample_data()

# Create app
app = Dash(__name__, suppress_callback_exceptions=True)
app.title = "{{PROJECT_NAME}}"

# Set layout
app.layout = create_layout(df)

# Register callbacks
register_overview_callbacks(app, df)
register_details_callbacks(app, df)


if __name__ == "__main__":
    app.run(debug=True, port=8050)
