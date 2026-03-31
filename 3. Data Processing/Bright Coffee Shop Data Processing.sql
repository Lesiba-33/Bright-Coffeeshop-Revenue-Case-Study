-------------------------------------------------------------------------------------------------------------------------------------
-- Bright Coffee Shop Analysis - Project
-------------------------------------------------------------------------------------------------------------------------------------

-- 1.  Data Inspection - Running the entire table
select *
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

-- 2. Checking Date range
select
           min(transaction_date) as min_date,
           max(transaction_date) as max_date
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--3. Checking the different store locations
Select distinct store_location
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;
-- 3 stores in todal

--4. checking the different product categories
Select distinct product_category
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;
-- 9 product categories

--5. Checking the different product types
Select distinct product_type
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;
-- 29 product types

--5. Checking the different product details
Select distinct product_detail
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;
-- 80 different product categories

--6. Checking the nulls
select*
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
Where unit_price is null
or transaction_qty is null 
or transaction_date is null;
-- No nulls found in the data set

-- 7. Checking lowest and highest unit price
select min(unit_price) as min_price,
       max(unit_price) as max_price
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;
-- min price is 0.8 and max price is 45.0

--8. Extracting  the day and month names
select 
       transaction_date, 
       dayname(transaction_date) as day_name,
       monthname(transaction_date) as month_name
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`; 

--9. Calculating the revenue
select unit_price,
       transaction_qty,
       unit_price*transaction_qty as revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

select *
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--10. Combing functions to get Clean and enhanced data set. 
select
       transaction_id,
       transaction_date,
       transaction_time,
       transaction_qty,
       store_id,
       store_location,
       product_id,
       unit_price,
       product_category,
       product_type,
       product_detail,
 --- adding columns to combine the table for better insights
       dayname(transaction_date) as Day_name,
       monthname(transaction_date) as Month_name,
       Dayofmonth(transaction_date) as Day_of_month,
  Case
       when dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
       else 'Weekday'
  End as day_classification,
  -- New column added 5. Time Buckets
  Case
       when date_format(transaction_time, 'HH:mm:ss') between '05:00:00' and '08:59:00' THEN '01. Rush hour'
       When date_format(transaction_time, 'HH:mm:ss') between '09:00:00' and '11:59:00' THEN '02. Mid Morning'
       When date_format(transaction_time, 'HH:mm:ss') between '12:00:00' and '15:59:00' THEN '03. Afternoon'
       When date_format(transaction_time, 'HH:mm:ss') between '16:00:00' and '18:00:00' THEN '04. Evening'
       else '05.Night'
  End as Time_classification,
  -- New column added 6. Spend Buckets
       CASE
            when (transaction_qty*unit_price) <=50 THEN '01. Low Spend'
            when (transaction_qty*unit_price) Between 51 and 100 THEN '02. Medium Spend'
            ELSE '03.High Spend'
       END as Spend_bucket,
  -- New Column added 7. Revenue
       (transaction_qty*unit_price) as Revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;
