from pyspark.sql import SparkSession
from pyspark.sql import functions as F


def run(spark: SparkSession, input_path: str, output_path: str) -> None:
    """Sample ETL job: read CSV, transform, write Parquet."""
    print(f"Reading from {input_path}")
    df = spark.read.csv(input_path, header=True, inferSchema=True)

    print(f"Input record count: {df.count()}")
    df.printSchema()

    # Sample transformation: add a processed_at timestamp
    result = df.withColumn("processed_at", F.current_timestamp())

    print(f"Writing to {output_path}")
    result.write.mode("overwrite").parquet(output_path)
    print("ETL job complete.")
