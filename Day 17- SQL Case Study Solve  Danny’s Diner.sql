use dannys_diner;

/* Q1. What is the total amount each customer spent at the restaurant?*/

select
   s.customer_id,
   sum(m.price) as total_amount
from sales s
inner join menu m
on s.product_id=m.product_id
group by s.customer_id
order by total_amount desc;

/* Q2.  How many days has each customer visited the restaurant?*/
select
    customer_id,
    count(distinct order_date) as cnt
from sales
group by customer_id;

/* Q3. What was the first item from the menu purchased by each customer?*/

with first_item as(select
   s.customer_id,
   s.order_date,
   m.product_name,
   rank() over(partition by customer_id order by order_date asc) as rnk
from sales s 
inner join menu m
on m.product_id=s.product_id)
select
   customer_id,
   product_name
from first_item
where rnk=1
group by customer_id,product_name;
/* Q4. What is the most purchased item on the menu and how many times was it purchased by all customers?*/

select
   m.product_name,
   count(m.product_name) as most_purchased
from sales s 
inner join menu m
on m.product_id=s.product_id
group by m.product_name
order by most_purchased desc
limit 1;

/* Which item was the most popular for each customer? */

with popular as(select
   s.customer_id,
   m.product_name,
   count(m.product_name) as cnt,
   rank() over(partition by customer_id order by count(customer_id) desc) as rnk
from sales s 
inner join menu m 
on s.product_id=m.product_id
group by s.customer_id,m.product_name
)
select
    customer_id,
    product_name,
    cnt
from popular
where rnk=1;

/* Which item was purchased first by the customer after they became a member? */

with pur as(select
   me.customer_id,
   me.join_date,
   m.product_name,
   s.order_date,
   row_number() over(partition by me.customer_id order by me.join_date) as rn
from members me
inner join sales s
on me.customer_id=s.customer_id
inner join menu m
on m.product_id=s.product_id
WHERE s.order_date >= me.join_date)

select
   customer_id,
   order_date,
   product_name
from pur
where rn=1;

/* Which item was purchased just before the customer became a member?*/

with pur as(select
   me.customer_id,
   me.join_date,
   m.product_name,
   s.order_date,
   row_number() over(partition by me.customer_id order by me.join_date) as rn
from members me
inner join sales s
on me.customer_id=s.customer_id
inner join menu m
on m.product_id=s.product_id
WHERE s.order_date < me.join_date)

select
   customer_id,
   order_date,
   product_name
from pur
where rn=1;

/* What is the total items and amount spent for each member before they became a member?*/

SELECT s.customer_id, COUNT(DISTINCT s.product_id) AS unique_menu_item, SUM(mm.price) AS total_sales
FROM sales AS s
JOIN members AS m
 ON s.customer_id = m.customer_id
JOIN menu AS mm
 ON s.product_id = mm.product_id
WHERE s.order_date < m.join_date
GROUP BY s.customer_id;

/* If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?*/

select
    s.customer_id,
    sum( case
       when m.product_name ='curry' then m.price*10
        when m.product_name ='ramen' then m.price*10
        when m.product_name='sushi' then m.price*2*10
	end)as point
from sales s 
inner join menu m
on m.product_id=s.product_id
group by s.customer_id;






























