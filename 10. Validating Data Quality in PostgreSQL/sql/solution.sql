CREATE TABLE sales_quality (
    order_id INTEGER,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    quantity INTEGER,
    unit_price NUMERIC(10, 2),
    order_date DATE
);


-- docker cp '.\09. Validating Data Quality in PostgreSQL\data\raw\sales_orders_quality.csv' 5c2c431627d5:/sales_orders_quality.csv
-- \copy sales_quality FROM '/sales_orders.csv' DELIMITER ',' CSV HEADER;

select 
    order_id,
    count(*) as duplicate_count
FROM 
    sales_quality
GROUP BY 
    order_id
HAVING 
    count(*) > 1;



select
    SUM(CASE WHEN customer_name IS NULL OR customer_name = '' THEN 1 ELSE 0 END) AS missing_customer_name,
    SUM(CASE WHEN product IS NULL OR product = '' THEN 1 ELSE 0 END) AS missing_product,
    SUM(CASE WHEN quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantity,
    SUM(CASE WHEN unit_price <= 0 THEN 1 ELSE 0 END) AS invalid_unit_price
FROM 
    sales_quality;
