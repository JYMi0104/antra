-- 17 Total quantity of stock items sold in 2015, group by country of manufacturing.
use WideWorldImporters;
with t as(
select StockItemID, json_value(CustomFields,'$.CountryOfManufacture') as CountryOfManufacture
from Warehouse.StockItems)


select t.CountryOfManufacture, sum(sol.Quantity) as totals
from Sales.OrderLines sol join Sales.Orders so on so.OrderID=sol.OrderID
     join t on t.StockItemID=sol.StockItemID
where year(so.OrderDate)=2015
group by t.CountryOfManufacture