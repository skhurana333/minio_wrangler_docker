#import awswrangler as wr
from ray.data import read_parquet
import ray
import modin.pandas as pd


minio_endpoint = "http://127.0.0.1:9000"
access_key = "admin"
secret_key = "password"


df = pd.read_csv(
    's3://myparqetdata/file1.csv',
        storage_options = {
            'endpoint_url': minio_endpoint
    })

# Read Parquet data (1.2 Gb Parquet compressed)
#df = wr.s3.read_parquet("s3://myparqetdata/"
                #        ,
    #storage_options={
    #    "endpoint_url": minio_endpoint,
    #    "access_key": access_key,
    #    "secret_key": secret_key
    #}
#)

print(df.count())
df.show()