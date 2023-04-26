-- Tham số loại IN
delimiter // 
create procedure getCustomerById(in cusNum int (11))
begin
	select * from customers where customerNumber = cusNum;
end //

-- Tham số loại OUT
delimiter //
create procedure getCustomersCountByCity(
in in_city varchar(50),
out total int
)
begin
	select count(customerNumber)
    into total
    from customers
    where city = in_city;
end //

-- Tham số loại INOUT
delimiter //
create procedure setCounter(
	inout counter int,
    in inc int
)
begin
	set counter = counter + inc;
end //

