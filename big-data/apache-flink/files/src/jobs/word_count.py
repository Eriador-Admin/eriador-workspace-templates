from pyflink.table import DataTypes, EnvironmentSettings, TableEnvironment
from pyflink.table.udf import udtf


@udtf(result_types=[DataTypes.STRING()])
def split_words(line: str):
    """Python table function: emit one row per whitespace-separated word."""
    for word in line.split():
        yield word


def run(input_path: str, output_path: str, parallelism: int = 1) -> None:
    """Word count job using Flink Table API."""
    settings = EnvironmentSettings.in_batch_mode()
    t_env = TableEnvironment.create(settings)
    t_env.get_config().set("parallelism.default", str(parallelism))
    t_env.create_temporary_system_function("split_words", split_words)

    # Define source
    t_env.execute_sql(f"""
        CREATE TABLE source_table (
            line STRING
        ) WITH (
            'connector' = 'filesystem',
            'path' = '{input_path}',
            'format' = 'raw'
        )
    """)

    # Define sink
    t_env.execute_sql(f"""
        CREATE TABLE sink_table (
            word STRING,
            cnt BIGINT
        ) WITH (
            'connector' = 'filesystem',
            'path' = '{output_path}',
            'format' = 'csv'
        )
    """)

    # Word count transformation
    t_env.execute_sql("""
        INSERT INTO sink_table
        SELECT word, COUNT(*) AS cnt
        FROM source_table,
        LATERAL TABLE(split_words(line)) AS T(word)
        GROUP BY word
    """).wait()

    print(f"Job complete. Results written to {output_path}")
