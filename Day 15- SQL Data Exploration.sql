use foodie_fi;
select * from sample;
select count(*) from sample;
describe sample;

-- Check count Columns
select count(*) as col_num
from information_schema.columns where table_name='sample';

-- Check total Values
select
    count(*) as total_orders
from sample;

-- Change columns name
ALTER TABLE `foodie_fi`.`sample` 
CHANGE COLUMN `Ship Mode` `Ship_Mode` TEXT NULL DEFAULT NULL ;

-- Count unique order
select
   count(distinct order_ID) as unique_order
from sample;

SET SQL_SAFE_UPDATES=0;


-- convert date columns

update sample
set Order_Date=cast(Order_Date as Date);

UPDATE sample
 SET Order_Date = STR_TO_DATE(Order_Date, '%m/%d/%Y');
 
 UPDATE sample
 SET Ship_Date = STR_TO_DATE(Ship_Date, '%m/%d/%Y');
 
 -- Data Exploration
/* How are the sales and profit performance throughout the years?*/

select
    year(order_date) as year,
    round(sum(profit),2) as Profit,
    round(sum(sales),2) as total_sales,
    round(sum(Quantity),2) as quantity
from sample
group by year
order by total_sales desc;

/* 2. Which region has the highest sales?*/

select
    region,
    round(sum(sales),2) as total_sales
from sample
group by region
order by total_sales desc;

/*  Which city has the highest profit?*/
select
    country,
    city,
    round(sum(Quantity),2) as total_Sold,
    round(sum(Sales),2) as total_Sales,
    round(sum(Profit),2) as total_Profit
from sample
group by country,city
order by total_Profit desc;
/* Which segment and item have generated the most profit?*/

select
    segment,
    Category,
    round(sum(Quantity),2) as total_Sold,
    round(sum(Sales),2) as total_Sales,
    round(sum(Profit),2) as total_Profit
from sample
group by 1,2
order by total_Profit desc;



/* shipping Day*/
select
     order_id,
     order_date,
     ship_date,
     abs(datediff(Order_date,ship_date)) as day_count
from sample
group by 1,2,3;


-- Add Columns
alter table sample
add column Day_count int;

update sample
set day_count=abs(datediff(Order_date,ship_date));


/*What is the average value of the "Sales" column by category?*/

select
     category,
     round(avg(sales),2) as avg_sales
from sample
group by category
order by avg_sales desc;

/* What is the highest and lowest sales made by a single customer?*/

select
	customer_id,
     max(sales) as highest_sales,
     min(sales) as lowest_sales
from sample
group by customer_id;

/* Which customer made the highest profit?*/

select
     customer_id,
     round(sum(profit),2) as total_profit
from sample
group by 1
order by total_profit desc
limit 1;

/* What is the most commonly sold product category?*/

SELECT 
  Category, 
  COUNT(*) AS TotalSales 
FROM sample 
GROUP BY Category 
ORDER BY TotalSales DESC 
LIMIT 1;

/* What is the most commonly used ship mode?*/
SELECT 
  Ship_mode, 
  COUNT(*) AS Total_SHip_Mode
FROM sample 
GROUP BY Ship_mode 
ORDER BY Total_SHip_Mode DESC 
LIMIT 1;


/* Which country has the highest number of orders?*/
SELECT 
  City, 
  COUNT(Order_id) AS order_count
FROM sample 
GROUP BY city
ORDER BY order_count DESC 
LIMIT 1;

/* Which month had the highest number of orders?*/

select
     monthname(Order_date) as month_name,
     count(order_id) as total_order
from sample
group by month_name
order by total_order desc;

/* What is the average quantity sold for each product category?*/

select
   Category,
   avg(quantity) as avg_sold
from sample
group by Category
order by avg_sold desc;

























































     


























































 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 



