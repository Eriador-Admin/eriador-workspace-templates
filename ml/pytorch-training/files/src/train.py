import os
import torch
import torch.nn as nn
from torch.utils.tensorboard import SummaryWriter
from tqdm import tqdm

from src.config import DEVICE, EPOCHS, LEARNING_RATE, CHECKPOINT_DIR, LOG_DIR
from src.model import SimpleNet
from src.dataset import get_train_loader, get_test_loader
from src.evaluate import evaluate


def train():
    os.makedirs(CHECKPOINT_DIR, exist_ok=True)
    writer = SummaryWriter(LOG_DIR)

    model = SimpleNet().to(DEVICE)
    optimizer = torch.optim.Adam(model.parameters(), lr=LEARNING_RATE)
    criterion = nn.CrossEntropyLoss()

    train_loader = get_train_loader()
    test_loader = get_test_loader()

    print(f"Training on {DEVICE} for {EPOCHS} epochs")

    for epoch in range(1, EPOCHS + 1):
        model.train()
        total_loss = 0.0

        for batch_idx, (data, target) in enumerate(tqdm(train_loader, desc=f"Epoch {epoch}")):
            data, target = data.to(DEVICE), target.to(DEVICE)
            optimizer.zero_grad()
            output = model(data)
            loss = criterion(output, target)
            loss.backward()
            optimizer.step()
            total_loss += loss.item()

        avg_loss = total_loss / len(train_loader)
        accuracy = evaluate(model, test_loader, DEVICE)

        writer.add_scalar("Loss/train", avg_loss, epoch)
        writer.add_scalar("Accuracy/test", accuracy, epoch)

        print(f"Epoch {epoch}: loss={avg_loss:.4f}, accuracy={accuracy:.2%}")

        torch.save({
            "epoch": epoch,
            "model_state_dict": model.state_dict(),
            "optimizer_state_dict": optimizer.state_dict(),
            "loss": avg_loss,
        }, os.path.join(CHECKPOINT_DIR, f"checkpoint_epoch_{epoch}.pt"))

    writer.close()
    print("Training complete.")


if __name__ == "__main__":
    train()
