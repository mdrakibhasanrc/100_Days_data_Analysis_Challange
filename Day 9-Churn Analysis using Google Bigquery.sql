select
    *
from `churn-382205.churn_analysis.churn`;


-- Check duplicated values
select
    Customer_ID,
    count(Customer_ID) as count
from `churn-382205.churn_analysis.churn`
group by Customer_ID
having count>1 ;

-- Find The total Number of Employees

select
    count(distinct Customer_ID) as Total
from `churn-382205.churn_analysis.churn`;


--How much revenue was lost to churned customers?
select
   Customer_Status,
   count(Customer_Status) as Count,
   round(Sum(Total_Revenue) ,2)  as Total
from `churn-382205.churn_analysis.churn`
group by Customer_Status;
    

--What’s the typical tenure for churned customers?

select
   CASE 
        WHEN Tenure_in_Months <= 6 THEN '6 months'
        WHEN Tenure_in_Months <= 12 THEN '1 Year'
        WHEN Tenure_in_Months <= 24 THEN '2 Years'
        ELSE '> 2 Years'
    END AS Tenure,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(),1) AS Churn_Percentage
from `churn-382205.churn_analysis.churn`
where Customer_Status='Churned'
group by Tenure
order by Churn_Percentage desc;

-- Which cities have the highest churn rates?
SELECT
    City,
    COUNT(Customer_ID) AS Churned,
    CEILING(COUNT(CASE WHEN Customer_Status = 'Churned' THEN Customer_ID ELSE NULL END) * 100.0 / COUNT(Customer_ID)) AS Churn_Rate
FROM
    `churn-382205.churn_analysis.churn`
GROUP BY
    City
HAVING
    COUNT(Customer_ID)  > 30
AND
    COUNT(CASE WHEN Customer_Status = 'Churned' THEN Customer_ID ELSE NULL END) > 0
ORDER BY
    Churn_Rate DESC;

-- What are the general reasons for churn?

SELECT 
  Churn_Category,  
  ROUND(SUM(Total_Revenue),0)AS Churned_Rev,
  CEILING((COUNT(Customer_ID) * 100.0) / SUM(COUNT(Customer_ID)) OVER()) AS Churn_Percentage
FROM 
  `churn-382205.churn_analysis.churn`
WHERE 
    Customer_Status = 'Churned'
GROUP BY 
  Churn_Category
ORDER BY 
  Churn_Percentage DESC; 


SELECT 
  Churn_Reason,  
  ROUND(SUM(Total_Revenue),0)AS Churned_Rev,
  CEILING((COUNT(Customer_ID) * 100.0) / SUM(COUNT(Customer_ID)) OVER()) AS Churn_Percentage
FROM 
  `churn-382205.churn_analysis.churn`
WHERE 
    Customer_Status = 'Churned'
GROUP BY 
  Churn_Reason
ORDER BY 
  Churn_Percentage DESC
limit 4; 


--What offers did churned customers have?

select
    offer,
    Round(count(Offer)*100/sum(count(Offer)) over(),2) as Per
from
  `churn-382205.churn_analysis.churn`
where
   Customer_Status = 'Churned'
group by 
   Offer
order by Per desc
;

-- What internet type did churners have?

select
    Internet_Type,
    Round(count(Internet_Type)*100/sum(count(Internet_Type)) over(),2) as Per
from
  `churn-382205.churn_analysis.churn`
where
   Customer_Status = 'Churned'
group by 
   Internet_Type
order by Per desc;


-- Did churners have premium tech support?

select
    Premium_Tech_Support,
    count(Premium_Tech_Support) as count,
    Round(count(Premium_Tech_Support)*100/sum(count(Premium_Tech_Support)) over(),2) as Per
from
  `churn-382205.churn_analysis.churn`
where
   Customer_Status = 'Churned'
group by 
   Premium_Tech_Support
order by Per desc;

-- What contract were churners on?

select
    Contract,
    count(Contract) as count,
    Round(count(Contract)*100/sum(count(Contract)) over(),2) as Per
from
  `churn-382205.churn_analysis.churn`
where
   Customer_Status = 'Churned'
group by 
   Contract
order by Per desc;


-- Were churners married
SELECT
    Married,
    ROUND(COUNT(Customer_ID) *100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM
    `churn-382205.churn_analysis.churn`
WHERE
    Customer_Status = 'Churned'
GROUP BY
    Married
ORDER BY
Churn_Percentage DESC;

-- Do churners have phone lines
SELECT
    Phone_Service,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churned
FROM
  `churn-382205.churn_analysis.churn`
WHERE
    Customer_Status = 'Churned'
GROUP BY 
    Phone_Service

