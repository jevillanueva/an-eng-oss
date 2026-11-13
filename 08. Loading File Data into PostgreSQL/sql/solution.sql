CREATE TABLE sales_orders (
    order_id INTEGER,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    quantity INTEGER,
    unit_price NUMERIC(10, 2),
    order_date DATE
);

-- docker cp '.\08. Loading File Data into PostgreSQL\data\raw\sales_orders.csv' 5c2c431627d5:/sales_orders.csv
-- \copy sales_orders FROM '/sales_orders.csv' DELIMITER ',' CSV HEADER;