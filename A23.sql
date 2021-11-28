--23.Rewrite your stored procedure in (21). Now with a given date, it should wipe out all the order 
--data prior to the input date and load the order that was placed in the next 7 days following 
--the input date. 
use WideWorldImporters;
go
drop procedure if exists getorder
go
create procedure getorder
(@orderdate datetime)
as 
	begin try
		begin transaction
		delete from ods.Orders where order_date < @orderdate
		select sol.OrderID, so.OrderDate,so.CustomerID, sum(sol.Quantity*sol.UnitPrice) as order_total
		from Sales.OrderLines sol join Sales.Orders so on sol.OrderID=so.OrderID
		where so.OrderDate>=@orderDate and OrderDate <= @orderdate + 7
		group by so.OrderDate, sol.OrderID, so.CustomerID
		commit transaction
    end try
	 begin catch   
        print 'date already exists.'
        select ERROR_MESSAGE() as error
        rollback transaction   
    end catch;  

--EXEC getorder @orderdate = '2013-02-20';
--select * from ods.Orders