from pyflink.table import EnvironmentSettings, TableEnvironment


def run(input_path: str, output_path: str, parallelism: int = 1) -> None:
    """Word count job using Flink Table API."""
    settings = EnvironmentSettings.in_batch_mode()
    t_env = TableEnvironment.create(settings)
    t_env.get_config().set("parallelism.default", str(parallelism))

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
        LATERAL TABLE(string_split(line, ' ')) AS T(word)
        WHERE word <> ''
        GROUP BY word
    """).wait()

    print(f"Job complete. Results written to {output_path}")
