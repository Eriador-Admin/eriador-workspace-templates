import os
from dotenv import load_dotenv
from utils.spark import create_spark_session
from jobs.sample_etl import run

load_dotenv()

if __name__ == "__main__":
    spark = create_spark_session()
    try:
        input_path = os.getenv("INPUT_PATH", "data/input/sample.csv")
        output_path = os.getenv("OUTPUT_PATH", "data/output/result")
        run(spark, input_path, output_path)
    finally:
        spark.stop()
