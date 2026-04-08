import os
from dotenv import load_dotenv

load_dotenv()

BATCH_SIZE = int(os.getenv("BATCH_SIZE", "32"))
LEARNING_RATE = float(os.getenv("LEARNING_RATE", "0.001"))
EPOCHS = int(os.getenv("EPOCHS", "10"))
NUM_WORKERS = 2
CHECKPOINT_DIR = "checkpoints"
LOG_DIR = "runs"

_device_env = os.getenv("DEVICE", "auto")
if _device_env == "auto":
    import torch
    DEVICE = "cuda" if torch.cuda.is_available() else "cpu"
else:
    DEVICE = _device_env
