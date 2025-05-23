CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
	amount DECIMAL(5,2),
	transaction_date DATETIME DEFAULT NOW(),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

SELECT * FROM transactions;