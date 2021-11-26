--26 Revisit your answer in (19). Convert the result into an XML string and save it to the server 
--using TSQL FOR XML PATH.

use WideWorldImporters;
go
drop view if exists [quantity_of_stock_group_by_year];
go

create view [quantity_of_stock_group_by_year] as
select sold_year as 'sold_Year', [Novelty Items],[Clothing],[Mugs],[T-Shirts],[Airline Novelties],[Computing Novelties],
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

select sold_Year, [Novelty Items] as Novelty_Items,[Clothing],[Mugs],[T-Shirts],[Airline Novelties] as Airline_Novelties,
       [Computing Novelties] as Computing_Novelties, [USB Novelties]as USB_Novelties,
	   [Furry Footwear] as Furry_Footwear,[Toys],[Packaging Materials] as Packaging_Materials
from [quantity_of_stock_group_by_year]
for xml path('sold_year'), root('groupsold_by_year')
