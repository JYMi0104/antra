--1 List of Persons¡¯ full name, all their fax and phone numbers, 
--as well as the phone number and fax of the company they are working for (if any). 
use WideWorldImporters;
go
select ap.FullName, ap.FaxNumber, ap.PhoneNumber,
       sbg.BuyingGroupName as company, sc.FaxNumber as company_faxnumber, sc.PhoneNumber as company_phonenumber
from Sales.Customers sc 
     join Sales.BuyingGroups sbg on sbg.BuyingGroupID=sc.BuyingGroupID
	 right join Application.People ap on ap.PersonID=sc.CustomerID or ap.PersonID=sc.PrimaryContactPersonID or ap.PersonID=sc.AlternateContactPersonID
