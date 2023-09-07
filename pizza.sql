# create database
create database pizza_db;

# use database
use pizza_db;

# create table pizza_sales
CREATE TABLE pizza_sales (pizza_id VARCHAR(10), order_id VARCHAR(10), pizza_name_id VARCHAR(100), quantity INT,
order_date DATE, order_time TIME, total_price DECIMAL(5,2), pizza_size VARCHAR(10),
pizza_category VARCHAR(100), pizza_ingredients VARCHAR(100), pizza_name VARCHAR(200));

-- load the table
select * from pizza_sales;

-- Get the total Revenue (round to 2 decimal figures)
select round(sum(total_price),2) as total_revenue from pizza_sales;

-- Calculate the total orders placed
select count(distinct order_id) from pizza_sales;

-- Calculate the average orders (round to 2 decimal figures)
select round(sum(total_price) / count(distinct order_id), 2) average_orders from pizza_sales;

-- Calculate total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales;

-- Average pizza sold per order
select sum(quantity) / count(distinct order_id) as average_pizza_sold from pizza_sales;

-- Daily trends for total order
select dayname(order_date) as order_day, count(distinct order_id) as total_order from pizza_sales
group by dayname(order_date);

-- Monthly trends for total order
select monthname(order_date) as order_month, count(distinct order_id) as total_orders
from pizza_sales
group by monthname(order_date)
order by total_orders desc;

-- sales by category
select pizza_category, sum(total_price) as total_sales
from pizza_sales
group by pizza_category;

-- Get the number of pizza_category sold
select pizza_category, count(pizza_category) as pizza_count
from pizza_sales
group by pizza_category;

-- percentage of sales by pizza category
-- Calculate the total and % sales for the month on January
select pizza_category, sum(total_price) as total_price, 
sum(total_price) * 100 / (select sum(total_price) from pizza_sales
where month(order_date) = 1) as '%sales'
from pizza_sales
where month(order_date) = 1
group by pizza_category;

-- Calculate the totak sales by Month
select monthname(order_date) as Month, sum(total_price) as total_sales
from pizza_sales
group by monthname(order_date)
order by total_sales desc;

-- Calculate the total sales per quater
select quarter(order_date) as quarter, sum(total_price) as sales_per_quarter
from pizza_sales
group by quarter(order_date);

-- percentage of sales by pizza_size
select pizza_size, CAST(sum(total_price) AS DECIMAL(10,2)) as total_sales, CAST(sum(total_price) * 100 / (select sum(total_price)
from pizza_sales) AS DECIMAL(10,2)) as '%pizza_size_sales'
from pizza_sales group by pizza_size;

-- Top 5 pizza that generate revenue the most
select pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc
limit 5;

-- Bottom 5 pizza by Revenue
select pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc
limit 5;

-- Top 5 pizza by quantity
select pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity desc
limit 5;

-- Top 5 pizza by order
select pizza_name, count(distinct order_id) as total_order
from pizza_sales
group by pizza_name
order by total_order desc
limit 5;

-- Bottom 5 pizza by order
select pizza_name, count(distinct order_id) as total_order
from pizza_sales
group by pizza_name
order by total_order asc
limit 5;
