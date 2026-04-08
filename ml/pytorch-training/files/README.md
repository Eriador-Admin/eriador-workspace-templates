# {{PROJECT_NAME}}

A [PyTorch](https://pytorch.org/) model training pipeline.

## Getting Started

```bash
bash init.sh    # create venv and install dependencies
bash run.sh     # start training
bash stop.sh    # stop training
```

## Project Structure

```
src/
  model.py         # Model architecture
  dataset.py       # Data loading
  train.py         # Training loop
  evaluate.py      # Evaluation
  config.py        # Hyperparameters
checkpoints/       # Saved model checkpoints
runs/              # TensorBoard logs
```

## Training

```bash
source venv/bin/activate
python -m src.train
```

## TensorBoard

```bash
tensorboard --logdir=runs
```

## Requirements

- Python 3.11+
- CUDA (optional, for GPU training)
