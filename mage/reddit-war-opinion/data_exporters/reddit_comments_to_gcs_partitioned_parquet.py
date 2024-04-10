import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/src/de-project-terraform.json'

bucket_name = 'de-project-418719-rwo-bucket'
project_id = 'de-project-418719'

table_name = "reddit_war_comments_data"

root_path = f'{bucket_name}/{table_name}'

@data_exporter
def export_data(data, *args, **kwargs):
    data['created_month'] = data['created_time'].dt.month
    data['created_time'] = data['created_time'].dt.date
    data['user_account_created_time'] = data['user_account_created_time'].dt.date
    data['post_created_time'] = data['post_created_time'].dt.date

    table = pa.Table.from_pandas(data)

    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=['created_time'],
        filesystem=gcs
    )