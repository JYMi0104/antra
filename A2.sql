--02 if the customer's primary contact person has the same phone number as the customr's. list

use WideWorldImporters;
go
select sc.CustomerID, sc.PhoneNumber as C_PhoneNumber,
       sc.PrimaryContactPersonID, ap.PhoneNumber as PC_PhoneNumber
from Sales.Customers sc join Application.People ap on sc.PrimaryContactPersonID = ap.PersonID
where sc.PhoneNumber = ap.PhoneNumber