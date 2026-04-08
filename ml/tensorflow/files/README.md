# {{PROJECT_NAME}}

A TensorFlow/Keras training pipeline with an MNIST digit classification example.

## Getting Started

```bash
bash init.sh    # create venv and install dependencies
bash run.sh     # train the model
bash stop.sh    # stop training (if running)
```

## Project Structure

```
train.py            # Training script
model.py            # Model architecture definition
evaluate.py         # Model evaluation and metrics
requirements.txt    # Python dependencies
models/             # Saved models (created after training)
```

## Requirements

- Python 3.9+
- ~500MB disk space for TensorFlow
