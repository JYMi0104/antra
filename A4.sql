--04 list of stockitems and total quantity for each stockitems in Purchase Order in year 2013
use WideWorldImporters

select pol.StockItemID, sum(pol.OrderedOuters) as totals
from Purchasing.PurchaseOrders po join Purchasing.PurchaseOrderLines pol 
     on po.PurchaseOrderID = pol.PurchaseOrderID
where year(po.OrderDate)=2013
group by pol.StockItemID
order by pol.StockItemID