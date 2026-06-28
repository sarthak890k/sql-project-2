-- 1. Which city has the highest population?

select city_name,population
from city
order by population desc
limit 1;


-- 2. Which city has the highest estimated rent?

select city_name,estimated_rent
from city
order by estimated_rent desc
limit 1;


-- 3. Number of customers in each city.

select ci.city_name,cu.city_id,count(cu.customer_id)
from city ci
join customers cu
on ci.city_id=cu.city_id
group by ci.city_name,cu.city_id;


-- 4. Which city has the highest customer density?

SELECT ci.city_name,ci.population,COUNT(cu.customer_id) AS total_customers,
    COUNT(cu.customer_id)/ ci.population AS customer_density
FROM city ci
LEFT JOIN customers cu
ON ci.city_id = cu.city_id
GROUP BY ci.city_id, ci.city_name, ci.population
ORDER BY customer_density DESC
limit 1;


-- 5. Cities with above-average population.

select city_name,population
from city
where population> (select avg(population)from city);



-- 7. Cheapest product.

select product_name, price
from products
order by price 
limit 1;


-- 8. Difference between the highest and lowest priced products.

select max(price),min(price),max(price)-min(price) as difference
from products;


-- 9. Products priced above the average product price.

select product_name,price
from products
where price> (select avg(price) from products);


-- 10. Products never sold.

select p.product_name
from products p
join sales s
on p.product_id=s.product_id
where s.product_id is null;


-- 11. Total revenue generated.

select sum(total) as revenue
from  sales ;

-- 12. Average transaction value.

SELECT AVG(total) AS avg_transaction_value
FROM sales;


-- 13. Highest single sale transaction.

select max(total)
from sales;


-- -14. Monthly sales trend.

select month(sale_date),sum(total)
from sales 
group by month(sale_date)
order by month(sale_date);

-- 15. Month with the highest revenue.

select month(sale_date) as month,sum(total) as heighest_revenue
from sales 
group by month(sale_date)
order by sum(total) desc
limit 1;


-- 16. Customers who made purchases in more than one month.

SELECT customer_id,COUNT(DISTINCT MONTH(sale_date)) AS active_months
FROM sales
GROUP BY customer_id
HAVING COUNT(DISTINCT MONTH(sale_date)) > 1;


-- 17. Customers who purchased multiple different products.

select customer_id,count(distinct(product_id))
from sales
group by customer_id
having count(distinct(product_id))>1;



-- 18. Customer with the highest average rating given.

select customer_id, avg(rating)
from sales
group by customer_id
order by avg(rating) desc 
limit 1;


-- 19. Customers whose spending is above the overall average spending.

SELECT customer_id,SUM(total) AS total_spending
FROM sales
GROUP BY customer_id
HAVING SUM(total) >(SELECT AVG(customer_spending)
FROM (SELECT customer_id,SUM(total) AS customer_spending
FROM sales
GROUP BY customer_id) t);


-- 20. Which city generates the highest revenue relative to rent?

select c.city_name,c.city_id,sum(s.total)/c.estimated_rent as heighest_revenue_to_rent_ratio
from city c
join customers cu
on c.city_id=cu.city_id
join sales s
on cu.customer_id=s.customer_id
group by c.city_name,c.city_id
order by sum(s.total)/c.estimated_rent desc
limit 1;


