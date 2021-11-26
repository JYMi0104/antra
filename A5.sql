--05 List of stock items that have at least 10 characters in description.
use WideWorldImporters

select distinct sol.StockItemID, ws.StockItemName, len(sol.Description) as length_of_description
from Sales.OrderLines sol join Warehouse.StockItems ws on sol.StockItemID=ws.StockItemID
where len(sol.Description)>=10
order by sol.StockItemID
