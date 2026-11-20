from pyspark.sql import SparkSession
from pyspark.sql.functions import (
    col,
    trim,
    initcap,
    upper,
    when,
    sum as spark_sum,
)

spark = (
    SparkSession.builder
    .appName("TransformDataFrames")
    .master("local[*]")
    .getOrCreate()
)

spark.sparkContext.setLogLevel("ERROR")

print("=" * 70)
print("TRANSFORMING DATA WITH PYSPARK DATAFRAMES")
print("=" * 70)

df = (
    spark.read
    .option("header", True)
    .option("inferSchema", True)
    .csv("data/csv/operations_transform.csv")
)

print("\nSOURCE DATA")
print("-" * 70)
df.show()

print("\nSELECTED COLUMNS")
print("-" * 70)

selected_df = df.select(
    "record_id",
    "source_system",
    "category",
    "quantity",
    "amount",
    "status",
)

selected_df.show()

print("\nCLEANED DATA")
print("-" * 70)

cleaned_df = (
    selected_df
    .withColumn(
        "category",
        initcap(trim(col("category")))
    )
    .withColumn(
        "status",
        upper(trim(col("status")))
    )
    .withColumn(
        "quantity",
        when(col("quantity") <= 0, 1)
        .otherwise(col("quantity"))
    )
    .withColumn(
        "amount",
        when(col("amount").isNull(), 0.0)
        .otherwise(col("amount"))
    )
)

cleaned_df.show()

print("\nFILTERED ACTIVE RECORDS")
print("-" * 70)

active_df = cleaned_df.filter(
    col("status") == "ACTIVE"
)

active_df.show()

print("\nDERIVED COLUMN")
print("-" * 70)

derived_df = active_df.withColumn(
    "total_value",
    col("quantity") * col("amount")
)

derived_df.show()

print("\nCATEGORY AGGREGATION")
print("-" * 70)

summary_df = (
    derived_df
    .groupBy("category")
    .agg(
        spark_sum("quantity").alias("total_quantity"),
        spark_sum("total_value").alias("total_value")
    )
    .orderBy("category")
)

summary_df.show()

print("=" * 70)
print("DATAFRAME TRANSFORMATIONS COMPLETED SUCCESSFULLY")
print("=" * 70)

spark.stop()