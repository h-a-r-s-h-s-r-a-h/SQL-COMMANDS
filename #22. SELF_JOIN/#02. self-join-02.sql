SELECT a.customer_id, a.first_name, a.last_name,
		CONCAT(b.first_name," ", b.last_name) AS "referred_by"
FROM customers AS a
INNER JOIN customers AS b 
ON a.referral_id = b.customer_id;