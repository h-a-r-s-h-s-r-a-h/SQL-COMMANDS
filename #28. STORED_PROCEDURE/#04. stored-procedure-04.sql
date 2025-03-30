DELIMITER $$
CREATE PROCEDURE find_employee(IN id INT)
BEGIN
	SELECT *
    FROM employees
    WHERE employee_id = id;
END $$
DELIMITER ;