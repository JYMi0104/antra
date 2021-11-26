--20Create a function, input: order id; return: total of that order. 
--List invoices and use that function to attach the order total to the other fields of invoices. 
use WideWorldImporters;
go

create function order_total(@OrderId int)
returns int as
begin
     declare @totals int
	 select @totals = sil.Quantity * sil.UnitPrice + sil.TaxAmount
	 from Sales.InvoiceLines sil join Sales.Invoices si on si.InvoiceID=sil.InvoiceID
	      and  si.OrderID=@OrderId
	 return @totals
end;
go

select si.*, dbo.order_total(si.OrderID) as order_total
from Sales.Invoices si