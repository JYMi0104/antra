--10 list of customers and their phone number, together with the primary contact person's name,
-- to whom we did not sell more than 10 mugs.(search by name)in 2016
use WideWorldImporters;
--have sold more than 10 mugs in 2016
with t as(
select so.CustomerID, sum(sol.Quantity) as s_total
from Sales.Orders so join Sales.OrderLines sol on so.OrderID = sol.OrderID and year(so.OrderDate) = 2016
     join Warehouse.StockItems ws on ws.StockItemID = sol.StockItemID
where ws.StockItemName like '%mug%'
group by so.CustomerID
having sum(sol.Quantity)>10)

select sc.CustomerID, sc.CustomerName, sc.PhoneNumber, ap.FullName as 'primary_contact_person'
from Sales.Customers sc join Application.People ap on ap.PersonID = sc.PrimaryContactPersonID
where sc.CustomerID not in (select CustomerID from t)
order by sc.CustomerID

