-- id = 1
select od.id, od.name, p.name, ot.quantity, p.price
from `order` as od join order_item as ot on ot.id_order = od.id
	join product as p on p.id = ot.id_product;


-- Lấy thông tin order info
/**
	DROP PROCEDURE IF EXISTS: xóa procedure nếu nó tồn tại
    Tham số IN: giá trị truyền vào
    Mệnh đề select ở bên trong procedure: nó trả ra bảng kết quả
**/
DROP PROCEDURE IF EXISTS sp_GetOrderInfo;
delimiter //
create procedure sp_GetOrderInfo(
	IN id integer
)
begin
	select od.id, od.name, p.name, ot.quantity, p.price
	from `order` as od join order_item as ot on ot.id_order = od.id
		join product as p on p.id = ot.id_product
	where od.id = id;
end; //

--            --------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_GetOrderTotal;
delimiter //
create procedure  sp_GetOrderTotal(
	IN id integer,
    OUT total double
)
begin
	select od.id, od.name, p.name, ot.quantity, p.price
	from `order` as od join order_item as ot on ot.id_order = od.id
		join product as p on p.id = ot.id_product
	where od.id = id;
    
    set total = (select sum(price*quantity) as total
					from `order` as od join order_item as ot on ot.id_order = od.id
						join product as p on p.id = ot.id_product
					where od.id = 1);
end; //

set @total = 0;
call c12_quanlybanhang.sp_GetOrderTotal(1, @total);
select @total;

--            --------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_GetOrderTotal1;
delimiter //
create procedure  sp_GetOrderTotal1(
	IN id integer,
    OUT total double
)
begin
	select od.id, od.name, p.name, ot.quantity, p.price
	from `order` as od join order_item as ot on ot.id_order = od.id
		join product as p on p.id = ot.id_product
	where od.id = id;
    
end; //

set @total = 0;
call c12_quanlybanhang.sp_GetOrderTotal1(1, @total);

-- Thêm order
delimiter //
DROP PROCEDURE IF EXISTS spSaveOrderSP;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spSaveOrderSP`(
	IN order_data JSON
)
BEGIN
	DECLARE i INT DEFAULT 0;
	SET @sName = JSON_EXTRACT(order_data, '$.name');
	SET @sTotal = JSON_EXTRACT(order_data, '$.total');
	SET @sOrderItems = JSON_EXTRACT(order_data, '$.orderItems');
        
	INSERT INTO `order` (`name`, `total`) VALUES (@sName, @sTotal);

	SET @last_OrderId = LAST_INSERT_ID();
	SET @sOrderItems_Length = JSON_LENGTH(@sOrderItems);
    WHILE i < @sOrderItems_Length DO
		SET @idProduct = JSON_EXTRACT(order_data, CONCAT('$.orderItems[',i,'].idProduct'));
        SET @quantiy = JSON_EXTRACT(order_data, CONCAT('$.orderItems[',i,'].quantiy'));
		INSERT INTO `order_item` (`id_order`, `id_product`, `quantity`) VALUES (@last_OrderId, @idProduct , @quantiy);
		SET i = i+1;
    END WHILE;
    
    -- INSERT INTO `c10_qlykhachhang`.`order_item` (`id_order`, `id_product`, `quantity`) VALUES ('9', '3', '1');
END //

call c12_quanlybanhang.spSaveOrderSP('{"name":"Quang Dag","total":8000.0,"orderItems":[{"idProduct":2,"quantiy":2},{"idProduct":3,"quantiy":2}]}');

-- Tạo view
create view vOrder as 
	SELECT id, name FROM c12_quanlybanhang.order;
    
insert into vorder(`id`, `name`) values (8, 'Khoa Nguyen');