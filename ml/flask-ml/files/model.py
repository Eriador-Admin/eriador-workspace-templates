from sklearn.ensemble import RandomForestClassifier
import numpy as np

# Simple example model — replace with your trained model
_model = RandomForestClassifier(n_estimators=10, random_state=42)
# Fit with dummy data so predict works out of the box
_model.fit([[0, 0], [1, 1], [2, 2]], [0, 1, 2])

def predict(features):
    """Predict from a list of feature values."""
    arr = np.array(features).reshape(1, -1)
    return int(_model.predict(arr)[0])
