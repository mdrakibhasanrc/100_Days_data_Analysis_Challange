use foodie_fi;

/* 1: What is the total sales and profit in each of the regions in 2018?*/

select
    region,
    round(sum(sales),2) as total_sales,
    round(sum(profit),2) as total_profit
from sample
where year(Order_Date)=2016
group by region
order by 1,2;

/* Q2: Which states had the maximum and minimum sales in 2018?*/

 (select
     state,
     sum(sales) as maximum_sales
from sample
where year(Order_Date)=2017
group by state
order by maximum_sales desc
limit 1)
union
(select
     state,
     sum(sales) as minimum_sales
from sample
where year(Order_Date)=2017
group by state
order by minimum_sales asc
limit 1);


/* Q3) What is the average sales in each of the region in 2018?*/

select
     region,
     round(avg(sales)) as avg_sales
from sample
where year(order_date)=2017
group by region
order by avg_sales desc;



/* Q4) What are the 5 sub categories that have the maximum profit margin in 2018?*/

select
     Sub_Category,
     round((sum(profit)/sum(sales))*100) as profit_margin
from sample
where year(order_date)=2017
group by Sub_Category
order by profit_margin desc
limit 5;

/* What is the most and least expensive product in each subcategory?*/

select
    sub_category,
    first_value(product_Name) over(partition by sub_category order by (sales)/(Quantity) desc) as expensive_Product,
	last_value(product_Name) over(partition by sub_category order by (sales)/(Quantity) asc) as expensive_Product
from sample;


/* ) What are the 2 worst selling products in each region?*/

with cte as(select
    region,
    product_name,
    sum(quantity) as total_sales,
    row_number() over(partition by product_name order by sum(quantity) asc) as rnk
from sample
group by 1,2)

select
     region,
     product_name,
     total_sales
from cte
where rnk<3;
/* What are the top 2 sub categories in every region by most sales?*/

with cte as(select
    region,
    sub_category,
    sum(quantity) as total_sales,
    row_number() over(partition by product_name order by sum(quantity) asc) as rnk
from sample
group by 1,2)

select
     region,
     product_name,
     total_sales
from cte
where rnk<3;

/* Compare the sales in 2016 and 2017 by Sub Category.*/

with sales_2017 as(select 
     Sub_category,
     round(sum(sales),2) as 2017_sales
from sample
where year(Order_Date)=2017
group by Sub_Category
order by 2017_sales),
sales_2016 as(select 
     Sub_category,
     round(sum(sales),2) as 2016_sales
from sample
where year(Order_Date)=2016
group by Sub_Category
order by 2016_sales desc)
select 
   sales_2017.sub_category,
   2017_sales,
   2016_sales,
   (2017_sales-2016_sales) as cy_vs_py
from sales_2017
join sales_2016
on sales_2016.sub_category=sales_2017.sub_category
group by sales_2016.sub_category;
   
    















































