import pandas as pd
import numpy as np


def generate_sample_data(n=200):
    """Generate a sample sales dataset."""
    np.random.seed(42)
    categories = ["Electronics", "Clothing", "Food", "Books", "Sports"]
    regions = ["North", "South", "East", "West"]

    data = {
        "date": pd.date_range("2024-01-01", periods=n, freq="D"),
        "category": np.random.choice(categories, n),
        "region": np.random.choice(regions, n),
        "sales": np.random.randint(100, 5000, n),
        "quantity": np.random.randint(1, 50, n),
        "profit": np.round(np.random.uniform(10, 800, n), 2),
    }
    df = pd.DataFrame(data)
    df["revenue"] = df["sales"] * df["quantity"]
    return df
