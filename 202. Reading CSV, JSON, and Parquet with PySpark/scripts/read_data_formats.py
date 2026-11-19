from pyspark.sql import SparkSession
from pyspark.sql.types import (
    StructType,
    StructField,
    IntegerType,
    StringType,
    DoubleType,
)

spark = (
    SparkSession.builder
    .appName("ReadDataFormats")
    .master("local[*]")
    .getOrCreate()
)

spark.sparkContext.setLogLevel("ERROR")

print("=" * 70)
print("READING CSV, JSON, AND PARQUET WITH PYSPARK")
print("=" * 70)

schema = StructType([
    StructField("record_id", IntegerType(), False),
    StructField("source_system", StringType(), True),
    StructField("category", StringType(), True),
    StructField("quantity", IntegerType(), True),
    StructField("amount", DoubleType(), True),
    StructField("event_date", StringType(), True),
])

print("\nCSV FORMAT")
print("-" * 70)

csv_df = (
    spark.read
    .option("header", True)
    .schema(schema)
    .csv("data/csv/operations_data.csv")
)

csv_df.printSchema()
csv_df.show()
print(f"CSV Row Count: {csv_df.count()}")

print("\nJSON FORMAT")
print("-" * 70)

json_df = (
    spark.read
    .schema(schema)
    .json("data/json/operations_data.json")
)

json_df.printSchema()
json_df.show()
print(f"JSON Row Count: {json_df.count()}")

print("\nPARQUET FORMAT")
print("-" * 70)

parquet_df = spark.read.parquet(
    "data/parquet/operations_data.parquet"
)

parquet_df.printSchema()
parquet_df.show()
print(f"Parquet Row Count: {parquet_df.count()}")

print("\nFORMAT COMPARISON")
print("-" * 70)

print(f"CSV Columns     : {len(csv_df.columns)}")
print(f"JSON Columns    : {len(json_df.columns)}")
print(f"Parquet Columns : {len(parquet_df.columns)}")

print(f"CSV Rows        : {csv_df.count()}")
print(f"JSON Rows       : {json_df.count()}")
print(f"Parquet Rows    : {parquet_df.count()}")

print("=" * 70)
print("ALL DATA FORMATS READ SUCCESSFULLY")
print("=" * 70)

spark.stop()