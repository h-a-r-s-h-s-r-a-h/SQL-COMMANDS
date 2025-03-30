DELIMITER $$
CREATE PROCEDURE get_transactions()
BEGIN
	SELECT * FROM transactions;
END $$
DELIMITER ;