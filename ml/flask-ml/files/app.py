from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
from model import predict
import os

load_dotenv()

app = Flask(__name__)
CORS(app, origins=[os.environ.get('CORS_ORIGIN', 'http://localhost:5173')])

@app.route('/health')
def health():
    return jsonify(status='ok')

@app.route('/predict', methods=['POST'])
def predict_endpoint():
    data = request.get_json()
    if not data or 'features' not in data:
        return jsonify(error='Missing features'), 400
    try:
        result = predict(data['features'])
    except (ValueError, TypeError) as e:
        return jsonify(error=str(e)), 400
    return jsonify(prediction=result)

if __name__ == '__main__':
    app.run(debug=os.environ.get('FLASK_DEBUG', 'false').lower() == 'true')
