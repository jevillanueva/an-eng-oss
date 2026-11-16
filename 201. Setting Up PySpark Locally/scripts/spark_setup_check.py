from pyspark.sql import SparkSession

# Create a local Spark session
spark = (
    SparkSession.builder
    .appName("PySparkLocalSetup")
    .master("local[*]")
    .getOrCreate()
)

# Reduce unnecessary Spark log messages
spark.sparkContext.setLogLevel("ERROR")

print("=" * 60)
print("PYSPARK LOCAL ENVIRONMENT")
print("=" * 60)

print(f"Spark Version : {spark.version}")
print(f"Application   : {spark.sparkContext.appName}")
print(f"Master        : {spark.sparkContext.master}")

# Create a small distributed DataFrame
data = [
    (1, "CSV", 120),
    (2, "JSON", 85),
    (3, "Parquet", 250),
    (4, "CSV", 175),
]

df = spark.createDataFrame(
    data,
    ["file_id", "format", "records"]
)

print("\nSOURCE DATAFRAME")
print("-" * 60)
df.show()

# Run a simple Spark transformation
large_files = df.filter(df.records >= 150)

print("FILTERED DATAFRAME")
print("-" * 60)
large_files.show()

# Run an action
print(f"Total Records : {df.count()}")

print("=" * 60)
print("PYSPARK SETUP VERIFIED SUCCESSFULLY")
print("=" * 60)

spark.stop()