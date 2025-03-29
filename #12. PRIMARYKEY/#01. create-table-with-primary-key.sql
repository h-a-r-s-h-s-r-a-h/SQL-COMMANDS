CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
	amount DECIMAL(5,2),
	transaction_date DATETIME DEFAULT NOW()
);

SELECT * FROM transactions;