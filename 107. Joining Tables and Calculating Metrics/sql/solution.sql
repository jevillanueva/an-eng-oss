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


SELECT
    c.customer_name,
    c.city,
    o.product,
    o.quantity,
    o.unit_price
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;


SELECT
    c.customer_name,
    c.city,
    o.product
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT 
    order_id,
    product,
    quantity,
    unit_price,
    quantity * unit_price AS revenue
FROM orders;


SELECT
    c.customer_name,
    SUM(o.quantity * o.unit_price) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;


SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    AVG(o.quantity * o.unit_price) AS average_order_value
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

