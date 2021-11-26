drop table if exists ods.Orders;
go
create table ods.Orders(
    order_id int primary key,
	order_date datetime not null,
	order_total decimal,
	customer_id int
);
go
drop table if exists ods.DB_Errors
go
CREATE TABLE ods.DB_Errors
         (ErrorID        INT IDENTITY(1, 1),
          UserName       VARCHAR(100),
          ErrorNumber    INT,
          ErrorState     INT,
          ErrorSeverity  INT,
          ErrorLine      INT,
          ErrorProcedure VARCHAR(MAX),
          ErrorMessage   VARCHAR(MAX),
          ErrorDateTime  DATETIME)
go 
drop procedure if exists ods.findorder;
go
create procedure ods.findorder
(@orderdate datetime2)
as 
   begin try
     begin transaction 
     insert into ods.Orders(ods.order_id, ods.order_date, ods.order_total, ods.customer_id)
     select sol.OrderID, so.OrderDate, sum(sol.Quantity*sol.UnitPrice) as order_total, so.CustomerID
     from Sales.OrderLines sol join Sales.Orders so on sol.OrderID=so.OrderID
     where so.OrderDate=@orderdate
     group by so.OrderDate, sol.OrderID, so.CustomerID
--
   end try
   begin catch
         insert into ods.DB_Errors
         values
        (
          SUSER_SNAME(),
          ERROR_NUMBER(),
          ERROR_STATE(),
          ERROR_SEVERITY(),
          ERROR_LINE(),
          ERROR_PROCEDURE(),
          ERROR_MESSAGE(),
          GETDATE()
         );
  if (XACT_STATE())=-1
    rollback transaction
  if (XACT_STATE())=1
    commit transaction
end catch;
go
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






