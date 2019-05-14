-- Versie 1
create procedure DeleteProduct1
@productID int
as
if not exists (select null from Product where ProductID = @productID)
begin
	raiserror('Product does not exist', 14, 0)
	return
end
if not exists (select null from OrdersDetail where ProductID = @productID)
begin
	print 'There are orders on the product'
	return
end
if not exists (select null from Purchases where ProductID = @productID)
begin
	print 'There are purchases on the product'
	return
end

delete from product where ProductID = @productID
print 'Product '+ str(@productID) + ' deleted'

create procedure DeleteProduct2

go; --insert go to allow creation of 2 stored procedures
-- Versie 2
create procedure DeleteProduct2
@productid int
as


delete from product 
where UnitsInStock = 0 
and ProductID not in 
( select ProductID from OrdersDetail )
and ProductID not in 
( select ProductID from Purchases )