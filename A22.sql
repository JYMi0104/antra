--22.	Create a new table called ods.StockItem. It has following columns: [StockItemID], [StockItemName] ,[SupplierID] ,[ColorID] ,[UnitPackageID] ,
--[OuterPackageID] ,[Brand] ,[Size] ,[LeadTimeDays] ,[QuantityPerOuter] ,[IsChillerStock] ,[Barcode] ,[TaxRate]  ,[UnitPrice],[RecommendedRetailPrice] ,
--[TypicalWeightPerUnit] ,[MarketingComments]  ,[InternalComments], [CountryOfManufacture], [Range], [Shelflife]. 
--Migrate all the data in the original stock item table.
use WideWorldImporters;
go
drop table if exists ods.StockItem;
go
select ws.StockItemID, ws.StockItemName, ws.SupplierID, ws.ColorID, ws.UnitPackageID, ws.OuterPackageID,
       ws.Brand, ws.Size, ws.LeadTimeDays, ws.QuantityPerOuter, ws.IsChillerStock, ws.Barcode,
	   ws.TaxRate, ws.UnitPrice, ws.RecommendedRetailPrice, ws.TypicalWeightPerUnit, 
	   ws.MarketingComments, ws.InternalComments,json_value(ws.CustomFields, '$.CountryOfManufacture') as CountryOfManufacture,
	   json_value(ws.CustomFields, '$.Range') as Range, json_value(ws.CustomFields,'$.ShelfLife') as s_Shelflife,
	   ws.ValidFrom as Shelflife
into ods.StockItem
from Warehouse.StockItems ws;
go
select * from ods.StockItem
