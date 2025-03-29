CREATE TABLE products (
	product_id INT,
    product_name VARCHAR(25) UNIQUE,
    price DECIMAL(4,2) NOT NULL
    CONSTRAINT check_pay CHECK (price >= 10.00)
);