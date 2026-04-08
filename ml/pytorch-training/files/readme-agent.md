# Agent Instructions — {{PROJECT_NAME}}

This is a PyTorch model training project.

## Tech Stack
- **Framework**: PyTorch 2.x
- **Logging**: TensorBoard
- **Language**: Python 3.11+

## Key Conventions
- Model definition in `src/model.py`
- Data loading in `src/dataset.py`
- Training loop in `src/train.py` with epoch-based training
- Hyperparameters in `src/config.py`
- Checkpoints saved to `checkpoints/`
- TensorBoard logs to `runs/`

## File Patterns
- `src/*.py` → Training pipeline components
- `checkpoints/*.pt` → Model checkpoints
- `runs/` → TensorBoard event files
- `data/` → Dataset files
