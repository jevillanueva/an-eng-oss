import pandas as pd

sales_data = pd.DataFrame(
    [
        {
            "order_id": 1001,
            "customer_name": "Alice Johnson",
            "product": "Laptop",
            "category": "Electronics",
            "quantity": 1,
            "unit_price": 75000,
            "city": "Bengaluru",
            "order_date": "2026-08-01",
        },
        {
            "order_id": 1002,
            "customer_name": "Rahul Sharma",
            "product": "Mouse",
            "category": "Accessories",
            "quantity": 2,
            "unit_price": 800,
            "city": "Mumbai",
            "order_date": "2026-08-02",
        },
        {
            "order_id": 1003,
            "customer_name": "Priya Nair",
            "product": "Keyboard",
            "category": "Accessories",
            "quantity": 1,
            "unit_price": 1500,
            "city": "Chennai",
            "order_date": "2026-08-02",
        },
        {
            "order_id": 1004,
            "customer_name": "John Thomas",
            "product": "Monitor",
            "category": "Electronics",
            "quantity": 2,
            "unit_price": 18000,
            "city": "Hyderabad",
            "order_date": "2026-08-03",
        },
        {
            "order_id": 1005,
            "customer_name": "Sneha Patel",
            "product": "Webcam",
            "category": "Accessories",
            "quantity": 3,
            "unit_price": 2500,
            "city": "Pune",
            "order_date": "2026-08-04",
        },
    ]
)

sales_data["order_date"] = pd.to_datetime(sales_data["order_date"])

sales_data.to_csv(
    "data/csv/sales_data.csv",
    index=False
)

sales_data.to_json(
    "data/json/sales_data.json",
    orient="records",
    indent=4,
    date_format="iso"
)

sales_data.to_parquet(
    "data/parquet/sales_data.parquet",
    index=False
)

print("=" * 55)
print("SAMPLE DATA FILES CREATED")
print("=" * 55)
print("CSV     : data/csv/sales_data.csv")
print("JSON    : data/json/sales_data.json")
print("PARQUET : data/parquet/sales_data.parquet")
print("=" * 55)