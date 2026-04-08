# {{PROJECT_NAME}}

A data science workspace with [Jupyter](https://jupyter.org/) notebooks.

## Getting Started

```bash
bash init.sh    # create venv and install dependencies
bash run.sh     # start Jupyter server on port {{JUPYTER_PORT}}
bash stop.sh    # stop the Jupyter server
```

## Project Structure

```
notebooks/
  01_exploration.ipynb   # Data exploration
  02_analysis.ipynb      # Analysis and modeling
data/
  raw/                   # Raw data files
  processed/             # Cleaned/processed data
src/
  utils.py               # Shared utility functions
```

## Included Libraries

- **pandas** — Data manipulation
- **numpy** — Numerical computing
- **matplotlib** / **seaborn** — Visualization
- **scikit-learn** — Machine learning

## Requirements

- Python 3.11+
