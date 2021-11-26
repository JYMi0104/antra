--3 list of customers to whom we made a sale prior to 2016 but no sale since 2016-01-01
-- select cutomerid who bought before 2016 and not in after 2016
use WideWorldImporters;

select distinct sc.CustomerID, sc.CustomerName
from Sales.Customers sc join Sales.Orders so on sc.CustomerID = so.CustomerID
where year(so.OrderDate)<2016 and 
      sc.CustomerID not in (select CustomerID from Sales.Orders where year(so.OrderDate)>=2016)
order by sc.CustomerID
