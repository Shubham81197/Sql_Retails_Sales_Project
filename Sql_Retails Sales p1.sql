--Sql Retail Sales Analysis -p1


Create table Retail_Sales(

transactions_id Int primary key,
sale_date Date,
sale_time Time,
customer_id int,
gender Varchar(20),
age int,
category Varchar(20),
quantiy int,
price_per_unit float,
cogs float,
total_sale float

);

Select * from Retail_Sales;

Select Count(*) from  Retail_Sales;

Select * from  Retail_Sales
  where transactions_id is null
  or sale_date is null
  or
  sale_time is null
  or
  customer_id is null
  or
  gender is null
  or 
  age is null
  or
  category is null
  or
  quantiy is null
  or
  price_per_unit is null
  or
  cogs is null
  or
  total_sale is null;
  
 --Data Cleaning 

Delete from Retail_Sales
where transactions_id is null
  or sale_date is null
  or
  sale_time is null
  or
  customer_id is null
  or
  gender is null
  or 
  age is null
  or
  category is null
  or
  quantiy is null
  or
  price_per_unit is null
  or
  cogs is null
  or
  total_sale is null;

  -- Data  Exploration 

  --How many Sales We have ?

  Select Count(*) as Total_sale
  from Retail_Sales;

--How many Customer We have ?

Select Count( Distinct Customer_id) as Total_customer from Retail_Sales;

--How many Categories we have ?

Select  Distinct category from Retail_Sales;



--Data Analysis and Bussiness Problems 

--1 Write a Sql Query to Retrieve all the Column for Sales made  on '2022-11-05'

Select *
from Retail_Sales
where Sale_date='2022-11-05';

--2.Write a Sql query to retrieve where the Category is Clothing and the quantity sold is more than 4 in the month 
-- nov 2022.

Select *
from Retail_Sales
where 
  category='Clothing'
  and 
  to_char(sale_date,'YYYY-MM')='2022-11'
  and
  quantiy>=4;

  --3 Write a Query to Calculate the Total Sales for Each Category

Select 
Category,
sum(total_Sale) as Net_sale,
count (*) as Total_order 
from Retail_Sales
Group by 1;
 	

  --4 Write a Sql Query to find the average age of Customer who purchased items from "Beauty " category

Select 
Round(avg(age),2) as Avg_age
from Retail_Sales
where category = 'Beauty';

-- 5.Write a Sql Query to find the all transactions  where the total_sales is gretaer than 1000.

Select *
from Retail_Sales
where Total_sale>1000;

--6 write a sql query to find the total number of transaction (transaction_id) made by eah gender in each category.

Select 
Category,
gender,
count(*) as Total_transaction
from Retail_Sales
group by
category,
gender
order by 1;

--7.  write a sql query to Calculate the average sale for each month. Find out the bEst Selling Month?

Select 
Extract (year from Sale_date) as year,
Extract (Month from Sale_date) as Month,
Avg(total_sale) as avg_sale

from retail_sales
group by 1,2
order by 1,2,3;




-- Write a Sql query to find the top five customer based on the Higest Total Sale

Select 
customer_id,
sum(total_sale) as total_sales
from Retail_Sales
group by 1
order by 2 desc
limit 5;

-- 9.Write a Sql Query to find the number of unique customers who purchased items from each category .


Select 
category,
count( distinct customer_id) as Unique
from Retail_Sales
group by category;

--10. Write a Sql query to create each shift and numberof orders (Example Moring<12, afternoon Between 12&17, Evening >17)


With Hourly_Sale
As
(
Select *,
   case 
    when Extract(Hour from sale_time)<12 Then 'Morning'
	when Extract(Hour from sale_time) Between 12 And 17 Then 'Afternoon'
	Else 'Evening'
	end  as shift
	from retail_Sales
	)
	Select Shift,
	count(*) as total_orders
	from Hourly_sale
	group by shift;
   


