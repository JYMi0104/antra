use WideWorldImporters;
go
drop table if exists ods.Orders;
go
create table ods.Orders(
    order_id int primary key,
	order_date date not null,
	order_total decimal,
	customer_id int
);
go

drop procedure if exists ods.findorder;
go
create procedure ods.findorder
(@orderdate datetime2)
as 
   begin try
     begin transaction 
	 if (@orderdate not in (SELECT isnull(order_date,cast('0001-01-01' as date)) from ods.Orders ))
       begin
	   insert into ods.Orders(ods.order_id, ods.order_date, ods.order_total, ods.customer_id)
       select sol.OrderID, so.OrderDate, sum(sol.Quantity*sol.UnitPrice) as order_total, so.CustomerID
       from Sales.OrderLines sol join Sales.Orders so on sol.OrderID=so.OrderID
       where so.OrderDate=@orderdate
       group by so.OrderDate, sol.OrderID, so.CustomerID
	   commit transaction
	   end
	 else
	   begin RAISERROR ('Date already in it',1, 1)
	   end
     end try
   begin catch
        print ERROR_MESSAGE()
        print 'transaction rolled back'
        rollback transaction
end catch;
go
/*
--select 5 random date to try
declare @test int, @Bdate datetime2, @Edate datetime2
set @test=0
set @Bdate='2013-01-01'
set @Edate='2016-12-31'
DECLARE @days INT = DATEDIFF(DAY, @Bdate, @Edate)
DECLARE @Random INT = ROUND(((@days-1) * RAND()), 0)
DECLARE @random_date DATETIME2= DATEADD(DAY, @Random, @Bdate)
while @test<=5
begin 
  execute ods.findorder @random_date
end
*/

exec ods.findorder '2013-02-20'
exec ods.findorder '2014-02-20'
exec ods.findorder '2015-02-20'
exec ods.findorder '2013-06-20'
exec ods.findorder '2014-07-20'
--select * from ods.Orders


