use practice;

select * 
from orders;

select 
   OrderDate
from Orders;

/* Today Date */
select today();

/* Extract Day */
select
   extract(Day from OrderDate) as Day
from orders;

/* Extract Month */
select
   extract(Month from OrderDate) as Month
from orders;


/* Extract Year */
select
   extract(year from OrderDate) as Year
from orders;


/* Extract Quarter */
select
   extract(quarter from OrderDate) as Quarter
from orders;

/* Week  */
select
   week(OrderDate) as Week
from orders;

/* Week  Day*/
select
   weekday(OrderDate) as WeekDay
from orders;

/* Month Name*/
select
   monthname(OrderDate) as Month_Name
from orders;

/* Day Name*/
select
   dayname(OrderDate) as day_Name
from orders;

/* Add Date*/
select
    OrderDate,
   adddate(OrderDate, interval 10 day) as add_date
from orders;


alter table orders
add Month_name varchar(25);

select *
from orders;

SET SQL_SAFE_UPDATES=0;
update orders
set Month_name=monthname(OrderDate);

alter table orders
drop year ;


alter table orders
add year int;

update orders
set year=extract(year from OrderDate);