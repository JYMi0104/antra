--13 List of stock item groups and total quantity purchased, total quantity sold,
--and the remaining stock quantity (quantity purchased ¨C quantity sold)
with sell as(
select sol.StockItemID, sum(sol.Quantity) as sold
from Sales.OrderLines sol
group by sol.StockItemID),
purchase as (
select ppol.StockItemID, sum(ppol.OrderedOuters) as purchased
from Purchasing.PurchaseOrderLines ppol
group by ppol.StockItemID)


select wsg.StockGroupID, wsg.StockGroupName, isnull(sum(purchase.purchased-sell.sold),0) as remaining
from Warehouse.StockGroups wsg 
     left join Warehouse.StockItemStockGroups wsisg on wsisg.StockGroupID=wsg.StockGroupID
	 left join Warehouse.StockItems wsi on wsi.StockItemID=wsisg.StockItemID
	 left join sell on sell.StockItemID = wsi.StockItemID
	 left join purchase on purchase.StockItemID=wsi.StockItemID
group by wsg.StockGroupID, wsg.StockGroupName
order by wsg.StockGroupID
	 
