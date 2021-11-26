-- 18 Create a view that shows the total quantity of stock items of each stock group sold 
--(in orders) by year 2013-2017. [Stock Group Name, 2013, 2014, 2015, 2016, 2017]
use WideWorldImporters;
go
drop view if exists [quantity_of_stock_group]; 
go
create view [quantity_of_stock_group] as 
select StockGroupName as [Stock Group Name], [2013], [2014], [2015], [2016], [2017]
from
(
select wsg.StockGroupName, year(so.OrderDate) as sold_year, sol.Quantity
from Warehouse.StockGroups wsg join Warehouse.StockItemStockGroups wsisg 
     on wsisg.StockGroupID=wsg.StockGroupID
	 join Sales.OrderLines sol on sol.StockItemID=wsisg.StockItemID
	 join Sales.Orders so on so.OrderID=sol.OrderID)as source_table
pivot
(sum(Quantity)
for sold_year in (
                  [2013],
				  [2014],
				  [2015],
				  [2016],
				  [2017]
	)
)as pivot_table;
go
select * from [quantity_of_stock_group]