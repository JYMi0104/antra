--06 list of stock items that are not sold to the state of Alabama and Georgia in 2014.

use WideWorldImporters;

with t as (
select distinct sol.StockItemID
from Sales.Customers sc join Application.Cities ac on ac.CityID = sc.DeliveryCityID
     join Application.StateProvinces asp on asp.StateProvinceID = ac.StateProvinceID
	 join Sales.Orders so on so.CustomerID = sc.CustomerID
	 join Sales.OrderLines sol on sol.OrderID = so.OrderID
where year(so.OrderDate)=2014 and (asp.StateProvinceName='Alabama' or  asp.StateProvinceName='Georgia'))

select StockItemID, StockItemName
from Warehouse.StockItems
where StockItemID not in (select StockItemID from t)
order by StockItemID