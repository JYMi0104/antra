--12 List all the Order Detail (Stock Item name, delivery address, delivery state, city, country, 
--customer name, customer contact person name, customer phone, quantity) for the date of 2014-07-01. 
--Info should be relevant to that date.
use WideWorldImporters;

select ws.StockItemName,
       sc.DeliveryAddressLine1, sc.DeliveryAddressLine2,
       ac.CityName as delivery_city, asp.StateProvinceName as delivery_state,aco.CountryName as delivery_country,
	   sc.CustomerName, ap.FullName as customer_contact_person, sc.PhoneNumber,
	   sum(sol.Quantity)over(partition by sc.CustomerID, sol.StockItemID) as quantity
from Sales.OrderLines sol join Sales.Orders so on sol.OrderID=so.OrderID
     join sales.Customers sc on so.CustomerID=sc.CustomerID
	 join Application.People ap on sc.PrimaryContactPersonID=ap.PersonID
	 join Warehouse.StockItems ws on sol.StockItemID=ws.StockItemID
	 join Application.Cities ac on ac.CityID=sc.DeliveryCityID
	 join Application.StateProvinces asp on asp.StateProvinceID=ac.StateProvinceID
	 join Application.Countries aco on aco.CountryID=asp.CountryID
where so.OrderDate = '2014-07-01'
