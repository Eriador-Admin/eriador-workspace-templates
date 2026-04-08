import os
import tensorflow as tf
from model import create_model


def main():
    epochs = int(os.environ.get("EPOCHS", 5))
    batch_size = int(os.environ.get("BATCH_SIZE", 32))
    learning_rate = float(os.environ.get("LEARNING_RATE", 0.001))

    print("Loading MNIST dataset...")
    (x_train, y_train), (x_test, y_test) = tf.keras.datasets.mnist.load_data()

    # Normalize pixel values to [0, 1]
    x_train = x_train.astype("float32") / 255.0
    x_test = x_test.astype("float32") / 255.0

    # Add channel dimension
    x_train = x_train[..., tf.newaxis]
    x_test = x_test[..., tf.newaxis]

    print(f"Training samples: {len(x_train)}")
    print(f"Test samples: {len(x_test)}")

    model = create_model(learning_rate=learning_rate)
    model.summary()

    print(f"\nTraining for {epochs} epochs (batch size: {batch_size})...")
    model.fit(
        x_train,
        y_train,
        epochs=epochs,
        batch_size=batch_size,
        validation_split=0.1,
    )

    print("\nEvaluating on test set...")
    test_loss, test_acc = model.evaluate(x_test, y_test, verbose=0)
    print(f"Test accuracy: {test_acc:.4f}")
    print(f"Test loss: {test_loss:.4f}")

    os.makedirs("models", exist_ok=True)
    model.save("models/mnist_model.keras")
    print("\nModel saved to models/mnist_model.keras")


if __name__ == "__main__":
    main()
