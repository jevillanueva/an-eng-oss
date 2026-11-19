import pyarrow as pa
import pyarrow.parquet as pq

data = {
    "record_id": [1, 2, 3, 4, 5],
    "source_system": ["CRM", "ERP", "API", "CRM", "ERP"],
    "category": ["Customer", "Inventory", "Orders", "Customer", "Inventory"],
    "quantity": [12, 8, 15, 10, 20],
    "amount": [1500.50, 2400.00, 3200.75, 1800.25, 4100.00],
    "event_date": [
        "2026-08-01",
        "2026-08-02",
        "2026-08-03",
        "2026-08-04",
        "2026-08-05",
    ],
}

table = pa.table(data)

pq.write_table(
    table,
    "data/parquet/operations_data.parquet"
)

print("=" * 60)
print("PARQUET SOURCE FILE CREATED")
print("=" * 60)
print("File: data/parquet/operations_data.parquet")
print(f"Rows: {table.num_rows}")
print(f"Columns: {table.num_columns}")
print("=" * 60)