/* Windows Function Practice Session */

use org;

select 
   w.first_name,
   w.last_name,
   w.joining_date,
   w.department,
   w.salary,
   t.WORKER_TITLE
from worker w
inner join title t on t.WORKER_REF_ID=w.worker_id;

select 
   *
from worker;

select
    *,
    avg(salary) over(partition by DEPARTMENT) as avg_salary,
    max(salary) over(partition by DEPARTMENT) as max_salary,
    min(salary) over(partition by DEPARTMENT) as min_salary
from worker;


select
    *,
    rank() over(partition by DEPARTMENT order by SALARY desc) as 'rank',
    dense_rank() over(partition by DEPARTMENT order by SALARY desc) as 'rank',
    row_number() over(partition by DEPARTMENT order by SALARY desc) as 'rank'
from worker;

select
   *,
   nth_value(first_name,2) over(partition by DEPARTMENT order by Salary desc)
from worker;

select
   *,
   last_value(first_name) over(partition by DEPARTMENT order by Salary )
from worker;



select 
    *,
dense_rank() over(order by joining_date) as rnk,
    dense_rank() over(partition by Department order by joining_date) as unq_rnk
from worker
order by rnk;

alter table worker 
add month varchar(10);

select
    monthname(joining_date)
from worker;
SET SQL_SAFE_UPDATES = 0;
update worker
set month=monthname(joining_date);


select * from worker;

select 
    *,
    rank() over(partition by month order by salary desc)
from worker;