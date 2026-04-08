import os
from dotenv import load_dotenv
from jobs.word_count import run

load_dotenv()

if __name__ == "__main__":
    input_path = os.getenv("INPUT_PATH", "data/input/sample.txt")
    output_path = os.getenv("OUTPUT_PATH", "data/output/result.csv")
    parallelism = int(os.getenv("FLINK_PARALLELISM", "1"))
    run(input_path, output_path, parallelism)
