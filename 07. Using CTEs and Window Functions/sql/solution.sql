CREATe TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product VARCHAR(100),
    quantity INTEGER,
    unit_price DECIMAL(10, 2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Alice Johnson', 'Bengaluru'),
(2, 'Bob Smith', 'Mumbai'),
(3, 'Charlie Brown', 'Delhi'),
(4, 'David Williams', 'Chennai'),
(5, 'Eve Davis', 'Kolkata'),
(6, 'Frank Miller', 'Pune');

INSERT INTO orders (order_id, customer_id, product, quantity, unit_price, order_date) VALUES
(1, 1, 'Laptop', 1, 75000.00, '2024-01-15'),
(2, 2, 'Smartphone', 2, 15000.00, '2024-02-10'),
(3, 3, 'Tablet', 1, 25000.00, '2024-03-05'),
(4, 4, 'Headphones', 3, 2000.00, '2024-04-12'),
(5, 5, 'Smartwatch', 2, 10000.00, '2024-05-20'),
(6, 6, 'Camera', 1, 50000.00, '2024-06-18');


INSERT INTO orders (order_id, customer_id, product, quantity, unit_price, order_date) VALUES
(7, 1, 'Mouse', 2, 1500.00, '2024-07-01'),
(8, 2, 'Keyboard', 1, 3000.00, '2024-07-02'),
(9, 3, 'Monitor', 1, 12000.00, '2024-07-03'),
(10, 4, 'Printer', 1, 8000.00, '2024-07-04'),
(11, 5, 'Router', 1, 4000.00, '2024-07-05'),
(12, 6, 'External Hard Drive', 1, 6000.00, '2024-07-06');

WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    cs.total_spent
FROM customers c
INNER JOIN customer_sales cs ON c.customer_id = cs.customer_id
ORDER BY cs.total_spent DESC;

SELECT
    order_id,
    product,
    unit_price,
    ROW_NUMBER() OVER (
        ORDER BY unit_price DESC
    ) as row_number
FROM orders;

SELECT 
    customer_id,
    quantity * unit_price AS total_price,
    RANK() OVER (
        ORDER BY quantity * unit_price DESC
    ) as rank
FROM orders;

SELECT
    order_date,
    order_id,
    quantity * unit_price AS revenue,
    SUM(quantity * unit_price)
    OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as running_total
FROM orders;

SELECT
    product,
    customer_id,
    quantity * unit_price AS revenue,
    SUM(quantity * unit_price) 
    OVER (
        PARTITION BY product
    ) as product_total
FROM orders;

WITH rank_orders AS (
    SELECT
        product,
        order_id,
        quantity * unit_price AS revenue,
        RANK() OVER (
            PARTITION BY product
            ORDER BY quantity * unit_price DESC
        ) as rn
    FROM orders
)
SELECT
    product,
    order_id,
    revenue
FROM rank_orders
WHERE rn = 1;
