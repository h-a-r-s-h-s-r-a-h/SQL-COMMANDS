SELECT first_name, last_name, 
	(SELECT AVG(hourly_pay) FROM employees) AS "average"
FROM employees;