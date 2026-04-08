import os
from pyspark.sql import SparkSession


def create_spark_session() -> SparkSession:
    """Create and return a configured SparkSession."""
    master = os.getenv("SPARK_MASTER", "local[*]")
    app_name = os.getenv("SPARK_APP_NAME", "pyspark-app")

    return (
        SparkSession.builder
        .master(master)
        .appName(app_name)
        .config("spark.sql.shuffle.partitions", "4")
        .config("spark.driver.memory", "1g")
        .getOrCreate()
    )
