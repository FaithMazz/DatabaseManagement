-- Faith Mazzone
-- CMPT 308, Database Systems

-- Lab 6

-- Q1

select name, city
from Customers
where city in (select city
	       from Products
	       group by city
	       order by COUNT(Products.city) DESC
	       limit 1);

-- Q2

select name
from Products
where priceUSD > (select AVG(priceUSD)
		  from Products)
order by name DESC;

-- Q3

select Customers.name, Orders.pid, Orders.totalUSD
from Orders
INNER JOIN Customers
	ON Orders.cid = Customers.cid
order by Orders.totalUSD DESC;

-- Q4

select Customers.name, COALESCE(SUM(Orders.quantity), 0) as "totalOrdered"
from Orders
RIGHT OUTER JOIN Customers
	      ON Orders.cid = Customers.cid
group by Customers.name
order by Customers.name DESC;

-- Q5

select Customers.name, Products.name, Agents.name
from Orders
INNER JOIN Customers
	ON Orders.cid = Customers.cid
INNER JOIN Products
	ON Orders.pid = Products.pid
INNER JOIN Agents
	ON Orders.aid = Agents.aid
where Agents.city = 'Newark';

-- Q6

select *
from (select Orders.*, Orders.quantity * Products.priceUSD * (1-(discountPCT/100)) as newColumn
      from Orders
      INNER JOIN Products 
	      ON Orders.pid = Products.pid
      INNER JOIN Customers
	      ON Orders.cid = Customers.cid) as newTable
where totalUSD != newColumn;

-- Q7

---
--
-- LEFT OUTER JOIN will return the values present in the first table
-- and values from the second table that are shared by the first table
--
-- RIGHT OUTER JOIN will return the values present in the second table
-- and values from the first table that are shared by the second table
--
---

--examples
select *
from Orders
LEFT OUTER JOIN Customers
ON Customers.cid = Orders.cid;
-- This shows all of the values in Orders, and the shared by the specified join

select *
from Orders
RIGHT OUTER JOIN Customers
ON Customers.cid = Orders.cid;
-- This does the same as above, but instead shows all the values in Customers, and a portion
-- of the Orders table.