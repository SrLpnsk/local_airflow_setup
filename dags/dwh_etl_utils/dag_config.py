from datetime import datetime, timedelta

# Main DAG definition with default parameters for all tasks
SCHEDULE_INTERVAL = '0 1 * * *'  # Dev server / Local airflow machine
on_retry_callback_func = print
on_failure_callback_func = print

DEFAULT_ARGS = {
    'owner': 'airflow',
    'email': ['lpnsk11@gmail.com'],
    'retries': 0,
    'retry_delay': timedelta(minutes=1),
    'retry_exponential_backoff': True,
    'max_retry_delay': timedelta(minutes=30),
    'on_retry_callback': on_retry_callback_func,
    'on_failure_callback': on_failure_callback_func,
    'depends_on_past': False,
    'start_date': datetime(2019, 7, 1),
}

INPUT_BASE_PATH = '/input'
SQL_BASE_PATH = '/sql'
OUTPUT_BASE_PATH = '/output_csv'
