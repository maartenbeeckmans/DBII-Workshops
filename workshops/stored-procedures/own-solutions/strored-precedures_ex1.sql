-- Aanmaken stored procedure
ALTER PROCEDURE [dbo].[DeleteOrdersFromSupplier] 
  @supplierid int,
  @nrdeletedorders int output
AS
  DELETE FROM orders WHERE orderid IN 
  (
   SELECT DISTINCT orderid
   FROM product p 
   JOIN ordersdetail od ON p.ProductID = od.productid
   WHERE supplierid = @supplierid
  )
  SET @nrdeletedorders = @@ROWCOUNT