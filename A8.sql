--8. List of States and Avg dates for processing (confirmed delivery date ¨C order date) by month.

--I assume that the processing month base on order date
use WideWorldImporters;
go
select StateProvinceName as [StateProvinceName], [1] as Jan, [2] as Feb, [3] as Mar,[4] as Apr,
       [5] as May, [6] as Jun, [7] as Jul, [8] as Aug, [9] as Sep, [10] as Oct, [11] as Nov, [12] as Dec
from
(
select asp.StateProvinceName, month(so.OrderDate)as month_of_order, 
       datediff(day, so.OrderDate, cast(si.ConfirmedDeliveryTime as date)) as datediff_processing
from Sales.Invoices si join Sales.Orders so on so.OrderID=si.OrderID
     join Sales.Customers sc on sc.CustomerID=so.CustomerID 
	 join Application.Cities ac on ac.CityID=sc.DeliveryCityID
	 join Application.StateProvinces asp on asp.StateProvinceID=ac.StateProvinceID)as source_table
pivot
(avg(datediff_processing)
for month_of_order in (
                       [1],
					   [2],
					   [3],
					   [4],
					   [5],
					   [6],
					   [7],
					   [8],
					   [9],
					   [10],
					   [11],
					   [12]
                        )
)as pivot_table
