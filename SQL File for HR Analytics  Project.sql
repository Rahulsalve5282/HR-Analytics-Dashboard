create database project;
use project;
select * from hr_2;
create table hr as 
select *
from hr_1
join hr_2 on hr_1.employeenumber = hr_2.employee_id;

#--------------average attrition rate for all departments------------#

select department,
concat(format(count(case when attrition ="yes" then 1 end)/ count(*)*100,2),"%") as attrition_rate
 from hr 
group by department
order by attrition_rate desc;

#--------average hourly rate of male research scientist---#

select avg(hourlyrate)as average_hourly_rate
from hr
where gender = "male" and jobrole="research scientist"; 






#---------attrition rate vs monthly income stats------#

select department,format(avg(case when attrition ="yes" then monthlyincome end),2)
as avg_monthly_income,
concat(format(count(case when attrition ="yes" then 1 end) / count(*)*100,2), "%")
as attrition_rate
from hr
group by department;


#-----------average working years for each department-------#

select department, avg(totalworkingyears) as avg_working_years
from hr
group by department;
#------job role vs work life balance----#

select
ifnull(jobrole,"total") as jobrole,
count(case when worklifebalance = 1 then 1 end) as poor_1,
count(case when worklifebalance = 2 then 1 end) as fair_2,
count(case when worklifebalance = 3 then 1 end) as good_3,
count(case when worklifebalance = 4 then 1 end) as excellent_4,
count(*) as total_count
from hr
group by jobrole with rollup;

#--------attrition rate vs year since last promotion---#

select
    CASE
        WHEN yearssincelastpromotion <= 5 THEN '0-5 Year'
        WHEN yearssincelastpromotion <= 10 THEN '6-10 Years'
        WHEN yearssincelastpromotion <= 15 THEN '11-15 Years'
          WHEN yearssincelastpromotion <= 20 THEN '16-20 Years'
            WHEN yearssincelastpromotion <= 25 THEN '21-25 Years'
              WHEN yearssincelastpromotion <= 30 THEN '26-30 Years'
            ELSE '30+ Years'
    END AS promotion_category,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS attrition_rate
FROM hr  -- Replace 'hr' with your actual table name
GROUP BY promotion_category
ORDER BY promotion_category;

