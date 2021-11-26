--09 list of stockitems that the company purchased more than sold in year 2015
use WideWorldImporters;

with purchase as(
select ppol.StockItemID, sum(ppol.OrderedOuters) as p_total
from Purchasing.PurchaseOrders ppo join Purchasing.PurchaseOrderLines ppol 
     on ppo.PurchaseOrderID = ppol.PurchaseOrderID
where year(ppo.OrderDate)=2015 
group by ppol.StockItemID),
sold as(
select sol.StockItemID, sum(sol.Quantity) as s_total
from Sales.Orders so join Sales.OrderLines sol on sol.OrderID = so.OrderID
where year(so.OrderDate)=2015
group by sol.StockItemID )

select purchase.StockItemID
from purchase join sold on purchase.StockItemID = sold.StockItemID
where purchase.p_total>sold.s_total
order by purchase.StockItemID