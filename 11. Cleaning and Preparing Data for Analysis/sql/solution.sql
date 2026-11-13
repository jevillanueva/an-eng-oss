CREATE TABLE sales_cleaned (
    order_id INTEGER,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    quantity INTEGER,
    unit_price NUMERIC(10, 2),
    order_date DATE
);



-- docker cp '.\11. Cleaning and Preparing Data for Analysis\data\raw\sales_orders_cleaning.csv' 5c2c431627d5:/
-- \copy sales_cleaned FROM '/sales_orders_cleaning.csv' DELIMITER ',' CSV HEADER;


UPDATE sales_cleaned
SET customer_name =  'Unknown Customer'
WHERE customer_name IS NULL OR customer_name = '';

UPDATE sales_cleaned
SET product = 'Unknown Product'
WHERE product IS NULL OR product = '';

UPDATE sales_cleaned
SET quantity = 1
WHERE quantity <= 0;

UPDATE sales_cleaned
SET unit_price = ABS(unit_price)
WHERE unit_price <= 0;

UPDATE sales_cleaned
SET customer_name = INITCAP(TRIM(customer_name));

DELETE FROM sales_cleaned
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM sales_cleaned
    GROUP BY order_id
);

SELECT
    COUNT(*) as total_records,
    COUNT(NULLIF(customer_name, '')) as valid_customer_names,
    COUNT(NULLIF(product, '')) as valid_products
FROM sales_cleaned;