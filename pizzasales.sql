--Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;


--Calculate the total revenue generated from pizza sales.
select 
      round(sum(o.quantity*p.price)::numeric,2) as total_revenue
from
          order_details o
          join
          pizzas p
on 
p.pizza_id= o.pizza_id;


--Identify the highest-priced pizza.
select pt.name, p.price
from
      pizza_types pt
      join
      pizzas p
on
      pt.pizza_type_id=p.pizza_type_id
order by p.price desc 
limit 1;


--Identify the most common pizza size ordered.
select p.size, count(o.order_details_id)
from
        pizzas p
        join
        order_details o
on
p.pizza_id= o.pizza_id
group by size
order by count(o.order_details_id) desc
limit 1;


--List the top 5 most ordered pizza types along with their quantities.
select pt.name, sum(o.quantity)
from
       pizza_types pt
join
       pizzas p
on 
       pt.pizza_type_id=p.pizza_type_id
join
       order_details o
on 
       o.pizza_id=p.pizza_id
group by name
order by sum(o.quantity) desc
limit 5;


--Join the necessary tables to find the total quantity of each pizza category ordered.
select pt.category, sum(o.quantity)
from
       pizza_types pt
join
       pizzas p
on 
       pt.pizza_type_id=p.pizza_type_id
join
       order_details o
on 
       o.pizza_id=p.pizza_id
group by category
order by sum(o.quantity) desc;


--Determine the distribution of orders by hour of the day.
select extract(hour from order_time) as hour, count(order_id) as orders
from orders
group by extract(hour from order_time)
order by orders desc;


--Join relevant tables to find the category-wise distribution of pizzas.
select pt.category, count(name)
from
pizza_types pt
group by category;


--Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity)::numeric,0) as avg_pizza_ordered_per_day 
from 
(select o.order_date, sum(od.quantity) as quantity
from
       orders o
       join
       order_details od
on
       o.order_id=od.order_id
group by o.order_date) as data;


--Determine the top 3 most ordered pizza types based on revenue.
select pt.name, sum(o.quantity*p.price) as revenue
from 
pizza_types pt
join
pizzas p
on
pt.pizza_type_id=p.pizza_type_id
join
order_details o
on
p.pizza_id=o.pizza_id
group by pt.name
order by revenue desc
limit 3;


--Calculate the percentage contribution of each pizza type to total revenue.
select pt.category, 
(sum(o.quantity*p.price) / 
(select round(sum(o.quantity*p.price)::numeric,2) as total_sales 
from order_details o join 
pizzas p on p.pizza_id=o.pizza_id)*100) as revenue
from 
pizza_types pt
join
pizzas p
on
pt.pizza_type_id=p.pizza_type_id
join
order_details o
on
p.pizza_id=o.pizza_id
group by pt.category
order by revenue desc;


--Analyze the cumulative revenue generated over time.
select order_date, sum(revenue)over(order by order_date) as cumulative_revenue
from
(select o.order_date, sum(od.quantity*p.price) as revenue
from
order_details od join
pizzas p
on
od.pizza_id=p.pizza_id
join
orders o
on
o.order_id=od.order_id
group by o.order_date) as sales;


--Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name,revenue from
(select category,name,revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select pt.category, pt.name, sum(o.quantity*p.price) as revenue
from
pizza_types pt
join
pizzas p
on
pt.pizza_type_id=p.pizza_type_id
join 
order_details o
on 
o.pizza_id=p.pizza_id
group by pt.category, pt.name) as a) as b
where rn<=3;

















