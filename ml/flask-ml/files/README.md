# {{PROJECT_NAME}}

Python Flask app with scikit-learn model serving.

Created by {{AUTHOR}} on {{DATE}}.

## Getting Started

```bash
pip install -r requirements.txt
cp .env.example .env
python app.py
```

POST to [http://localhost:5000/predict](http://localhost:5000/predict) with `{"features": [1, 2]}`.
