delimiter //
create procedure find_all_customers()
begin
	select * from customers;
end 
// 

DELIMITER //
DROP PROCEDURE IF EXISTS `find_all_customers`//

CREATE PROCEDURE findAllCustomers()

BEGIN

SELECT * FROM customers where customerNumber = 175;

END //

