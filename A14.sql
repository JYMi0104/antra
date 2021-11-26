--14 List of Cities in the US and the stock item that the city got the most deliveries in 2016. 
--If the city did not purchase any stock items in 2016, print ¡°No Sales¡±.
use WideWorldImporters;
go
--cities in US
with us_city as(
select ac.CityID, ac.CityName
from Application.Cities ac join Application.StateProvinces asp on asp.StateProvinceID=ac.StateProvinceID
     join Application.Countries aco on aco.CountryID=asp.CountryID
where aco.CountryName = 'United States'),

--in 2016, total delivery of each stockitem in each city
delivery as(
select sc.DeliveryCityID, sol.StockItemID, 
       count(sol.OrderID) as total_delivery
from Sales.Customers sc join Sales.Orders so on so.CustomerID=sc.CustomerID
     join Sales.OrderLines sol on sol.OrderID=so.OrderID
where year(so.OrderDate)=2016
group by sc.DeliveryCityID, sol.StockItemID),
t as(
select *, rank()over(partition by DeliveryCityID order by total_delivery desc) as rnk
from delivery)

select us_city.CityName, isnull(cast(t.StockItemID as varchar),'No Sales') as most_deliveries_stockitem
from us_city left join t on t.DeliveryCityID=us_city.CityID
where rnk = 1


