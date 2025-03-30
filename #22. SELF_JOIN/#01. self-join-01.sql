SELECT *
FROM customers AS a
INNER JOIN customers AS b 
ON a.referral_id = b.customer_id;