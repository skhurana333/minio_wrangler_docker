import awswrangler as wr

# Read Parquet data (1.2 Gb Parquet compressed)
df = wr.s3.read_parquet(
    path=f"s3://amazon-reviews-pds/parquet/product_category=Books/"
)

print(df.count())
df.show()
