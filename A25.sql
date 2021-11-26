--25 Revisit your answer in (19). Convert the result in JSON string and save it to the server using TSQL FOR JSON PATH.
use WideWorldImporters;
go
drop view if exists [quantity_of_stock_group_by_year];
go

create view [quantity_of_stock_group_by_year] as
select sold_year as 'Year', [Novelty Items],[Clothing],[Mugs],[T-Shirts],[Airline Novelties],[Computing Novelties],
					   [USB Novelties],[Furry Footwear],[Toys],[Packaging Materials]
from
(
select wsg.StockGroupName, year(so.OrderDate) as sold_year, sol.Quantity
from Warehouse.StockGroups wsg join Warehouse.StockItemStockGroups wsisg 
     on wsisg.StockGroupID=wsg.StockGroupID
	 join Sales.OrderLines sol on sol.StockItemID=wsisg.StockItemID
	 join Sales.Orders so on so.OrderID=sol.OrderID)as source_table
pivot
(sum(Quantity)
for StockGroupName in (
                       [Novelty Items],
					   [Clothing],
					   [Mugs],
					   [T-Shirts],
					   [Airline Novelties],
					   [Computing Novelties],
					   [USB Novelties],
					   [Furry Footwear],
					   [Toys],
					   [Packaging Materials]
                       )
)as pivot_table;
go
select * from [quantity_of_stock_group_by_year]
for json path,root('groupsold_by_year')
