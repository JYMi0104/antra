--11 List all the cities that were updated after 2015-01-01.
use WideWorldImporters;
go
select CityID, CityName, ValidFrom, ValidTo from Application.Cities for system_time allwhere validFrom >= '2015-01-01 00:00:00.0000000'
