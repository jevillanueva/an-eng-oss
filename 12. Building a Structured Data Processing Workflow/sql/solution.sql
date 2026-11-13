CREATE TABLE shipments_raw (
    shipment_id VARCHAR(20),
    origin_hub VARCHAR(100),
    destination_hub VARCHAR(100),
    package_weight NUMERIC(10, 2),
    delivery_status VARCHAR(50),
    shipment_date DATE
);

-- docker cp '.\12. Building a Structured Data Processing Workflow\data\raw\daily_shipments.csv' 5c2c431627d5:/
-- \copy shipments_raw FROM '/daily_shipments.csv' DELIMITER ',' CSV HEADER;

select
    COUNT(*) as total_records,
    SUM(case when destination_hub is null or destination_hub = '' then 1 else 0 end) as missing_destination,
    SUM(case when delivery_status is null or delivery_status = '' then 1 else 0 end) as missing_delivery_status,
    SUM(case when package_weight is null or package_weight <= 0 then 1 else 0 end) as invalid_package_weight
FROM shipments_raw;


SELECT
    shipment_id,
    count(*) as duplicate_count
FROM shipments_raw
GROUP BY shipment_id
HAVING count(*) > 1;

CREATE TABLE shipments_clean AS
SELECT *
FROM shipments_raw;

UPDATE shipments_clean
SET destination_hub = 'Unknown Hub'
WHERE destination_hub IS NULL OR destination_hub = '';

UPDATE shipments_clean
SET delivery_status = 'Unknown Status'
WHERE delivery_status IS NULL OR delivery_status = '';

UPDATE shipments_clean
SET package_weight = ABS(package_weight)
WHERE package_weight <= 0;

UPDATE shipments_clean
SET package_weight = 1
WHERE package_weight = 0;

UPDATE shipments_clean
SET origin_hub = INITCAP(TRIM(origin_hub));

UPDATE shipments_clean
SET destination_hub = INITCAP(TRIM(destination_hub));

DELETE FROM shipments_clean
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM shipments_clean
    GROUP BY shipment_id
);

select
    COUNT(*) as total_records,
    SUM(case when destination_hub is null or destination_hub = '' then 1 else 0 end) as missing_destination,
    SUM(case when delivery_status is null or delivery_status = '' then 1 else 0 end) as missing_delivery_status,
    SUM(case when package_weight is null or package_weight <= 0 then 1 else 0 end) as invalid_package_weight
FROM shipments_clean;

SELECT
    delivery_status,
    count(*) as shipment_count
FROM shipments_clean
GROUP BY delivery_status
ORDER BY shipment_count DESC;

-- \copy (SELECT * FROM shipments_clean order by shipment_id) TO '/tmp/daily_shipments_clean.csv' DELIMITER ',' CSV HEADER;
-- docker cp 5c2c431627d5:/tmp/daily_shipments_clean.csv '.\12. Building a Structured Data Processing Workflow\data\processed\'