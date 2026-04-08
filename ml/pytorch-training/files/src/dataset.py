from torch.utils.data import DataLoader
from torchvision import datasets, transforms

from src.config import BATCH_SIZE, NUM_WORKERS


def get_transforms():
    return transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize((0.1307,), (0.3081,)),
    ])


def get_train_loader() -> DataLoader:
    dataset = datasets.MNIST("data", train=True, download=True, transform=get_transforms())
    return DataLoader(dataset, batch_size=BATCH_SIZE, shuffle=True, num_workers=NUM_WORKERS)


def get_test_loader() -> DataLoader:
    dataset = datasets.MNIST("data", train=False, download=True, transform=get_transforms())
    return DataLoader(dataset, batch_size=BATCH_SIZE, shuffle=False, num_workers=NUM_WORKERS)
