
-- Database Management - Lab 3 --
-- Faith Mazzone

-- Q1

select ordno, totalusd
from Orders;

--Q2

select name, 
       city
from Agents
where name = 'Smith';

-- Q3

select pid, 
       name,
       priceusd
from Products
where qty > 200010;

-- Q4

select name,
       city
from Customers
where city = 'Duluth';

-- Q5

select name,
       city
from Agents
where city != 'New York' and city != 'Duluth';

-- Q6

select *
from Products
where (city != 'Dallas' and city != 'Duluth') and priceusd >= 1.00;

-- Q7

select *
from Orders
where month = 'Mar' or month = 'May';

-- Q8

select *
from Orders
where month = 'Feb' and totalusd >= 500.00;

-- Q9

select *
from Orders
where cid = 'c005';

