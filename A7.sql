--7 List of States and Avg dates for processing (confirmed delivery date ¨C order date).
use WideWorldImporters;
go

select asp.StateProvinceName, 
       avg(datediff(day, so.OrderDate, cast(si.ConfirmedDeliveryTime as date))) as avg_dates_for_processing
from Sales.Invoices si join Sales.Orders so on so.OrderID=si.OrderID
     join Sales.Customers sc on sc.CustomerID=so.CustomerID --get deliverycityid
	 join Application.Cities ac on ac.CityID=sc.DeliveryCityID
	 join Application.StateProvinces asp on asp.StateProvinceID=ac.StateProvinceID
group by asp.StateProvinceName

