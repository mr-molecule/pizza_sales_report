
Select *
From dbo.pizza_sales 

--Total Revenue
Select SUM(total_price) as Total_Revenue
From pizza_sales

--Avg Order Value
Select SUM(total_price) / COUNT(DISTINCT(order_id))  as Avg_order_value
From pizza_sales

--Total Pizzas Sold
Select SUM(quantity) as Total_pizza_sold
from pizza_sales

--Total Order
Select COUNT(DISTINCT(order_id)) as Total_orders
from pizza_sales

--Avg Pizzas Per Order
Select CAST(SUM(quantity) as DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) as Avg_pizza_per_order
from pizza_sales

--Daily Trends for Total Orders
Select  DATENAME(DW,order_date) as order_day, COUNT(DISTINCT(order_id)) as orders
From pizza_sales
Group by DATENAME(DW,order_date)

--Monthly Trend for Total Orders
Select DATENAME(MONTH,order_date) as order_month, COUNT(DISTINCT(order_id)) as            
From pizza_sales
Group by DATENAME(MONTH,order_date)

--Percentage of sales by pizza size
SELECT pizza_size,SUM(total_price) as total_sales, SUM(total_price) * 100 /              
(SELECT SUM(total_price) FROM pizza_sales) as Pizza_pct
WHERE DATEPART(Quarter,order_date) = 1 --For First Quarter i.e (Jan – April)
FROM pizza_sales
Group by pizza_size

--Percentage of sales by pizza category
SELECT pizza_size,SUM(total_price) as total_sales, SUM(total_price) * 100 /              
(SELECT SUM(total_price) FROM pizza_sales) as Pizza_pct
FROM pizza_sales
Group by pizza_size

--Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_pizzas_sold 
FROM pizza_sales
Group by pizza_category

--TOP 5 Best Performing Pizza

-- By Revenue
SELECT TOP 5 pizza_name, SUM(total_price) as Total_revenue
FROM pizza_sales
Group by pizza_name
Order by Total_revenue desc

--By Total Quantity
SELECT TOP 5 pizza_name, SUM(quantity) as Total_quantity
FROM pizza_sales
Group by pizza_name
Order by Total_quantity desc

-- By Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
Group by pizza_name desc
Order by Total_orders

--Top 5 Worst performing pizza 

-- By Revenue
SELECT TOP 5 pizza_name, SUM(total_price) as Total_revenue
FROM pizza_sales
Group by pizza_name
Order by Total_revenue

--By Total Quantity
SELECT TOP 5 pizza_name, SUM(quantity) as Total_quantity
FROM pizza_sales
Group by pizza_name
Order by Total_quantity

-- By Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
Group by pizza_name
Order by Total_orders