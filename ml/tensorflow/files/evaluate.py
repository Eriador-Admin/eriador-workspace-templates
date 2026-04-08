import numpy as np
import tensorflow as tf


def main():
    print("Loading saved model...")
    model = tf.keras.models.load_model("models/mnist_model.keras")

    print("Loading test data...")
    (_, _), (x_test, y_test) = tf.keras.datasets.mnist.load_data()
    x_test = x_test.astype("float32") / 255.0
    x_test = x_test[..., np.newaxis]

    loss, accuracy = model.evaluate(x_test, y_test)
    print(f"\nTest Loss: {loss:.4f}")
    print(f"Test Accuracy: {accuracy:.4f}")

    # Sample predictions
    predictions = model.predict(x_test[:5])
    for i in range(5):
        predicted = np.argmax(predictions[i])
        actual = y_test[i]
        print(f"  Sample {i + 1}: predicted={predicted}, actual={actual}")


if __name__ == "__main__":
    main()
