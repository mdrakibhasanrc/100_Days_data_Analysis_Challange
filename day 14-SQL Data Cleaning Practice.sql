use practice;
select count(*) from data;

select * from data;

alter table data
add salesdate date;
SET SQL_SAFE_UPDATES = 0;
UPDATE data SET salesDate = STR_TO_DATE(Saledate, '%M %e, %Y');

alter table data
add propertyCity varchar(50);

alter table data
add PropertyAdress varchar(50);

UPDATE data SET 
  PropertyAdress = SUBSTRING_INDEX(PropertyAddress, ',', 1), 
  propertyCity = SUBSTRING_INDEX(PropertyAddress, ',', -1);
  
alter table data
rename column ï»¿UniqueID to UniqueID;

alter table data
add year int;

alter table data
add Month_name varchar(50);

update data set
  year=year(salesdate),
  Month_name=monthname(Salesdate);



with dup as(select *,
row_number() over(partition by PropertyAdress,
							   ParcelID,SalePrice
                               order by uniqueID) as rn
from data)

delete from dup
where rn>1;

create view clean_property_data as
select
    UniqueID,
    ParcelID,
    LegalReference,
    SoldAsVacant,
    OwnerName,
    Acreage,
    LandValue,
    BuildingValue,
    TotalValue,
    YearBuilt,
    Bedrooms,
    salesdate,
    propertyCity,
    PropertyAdress,
    year,
    Month_name,
    SalePrice
from data;
select count(*) from clean_property_data;

select * from data;

alter table data
add ownerCity varchar(50);

alter table data
add ownerAdress varchar(50);

alter table data
add ownertown varchar(50);

UPDATE data SET 
  ownerAdress = SUBSTRING_INDEX(OwnerAddress, ',', 1), 
  ownertown = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2),',',-1),
  ownerCity= SUBSTRING_INDEX(OwnerAddress, ',', -1);

select * from data;

alter table  data
drop column PropertyAddress;




