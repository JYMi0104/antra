--16 List all stock items that are manufactured in China. (Country of Manufacture)
use WideWorldImporters

select StockItemID, json_value(CustomFields, '$.CountryOfManufacture') as CountryOfManufacture
from Warehouse.StockItems 
where json_value(CustomFields, '$.CountryOfManufacture')='China'