import pandas as pd

csv_path = "data/csv/sales_data.csv"
json_path = "data/json/sales_data.json"
parquet_path = "data/parquet/sales_data.parquet"

print("=" * 70)
print("CSV, JSON, AND PARQUET FILE INSPECTION")
print("=" * 70)

# Read files
csv_data = pd.read_csv(csv_path)
json_data = pd.read_json(json_path)
parquet_data = pd.read_parquet(parquet_path)

# Store datasets for comparison
datasets = {
    "CSV": csv_data,
    "JSON": json_data,
    "PARQUET": parquet_data,
}

# Inspect each format
for format_name, dataframe in datasets.items():
    print(f"\n{format_name} FORMAT")
    print("-" * 70)

    print(f"Shape: {dataframe.shape}")

    print("\nColumns:")
    print(list(dataframe.columns))

    print("\nData Types:")
    print(dataframe.dtypes)

    print("\nSample Records:")
    print(dataframe.head())

# Format comparison summary
print("\n" + "=" * 70)
print("FORMAT COMPARISON SUMMARY")
print("=" * 70)

comparison = pd.DataFrame(
    {
        "Format": ["CSV", "JSON", "Parquet"],
        "Readable": ["Yes", "Yes", "No"],
        "Structure": ["Tabular", "Record-based", "Columnar"],
        "Schema Preservation": ["Limited", "Limited", "Strong"],
        "Typical Use": [
            "Simple data exchange",
            "APIs and nested data",
            "Analytics and large datasets",
        ],
    }
)

print(comparison.to_string(index=False))

print("\n" + "=" * 70)
print("FORMAT COMPARISON COMPLETE")
print("=" * 70)