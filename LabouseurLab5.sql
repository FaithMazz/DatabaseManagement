
-- Faith Mazzone
-- CMPT 308, Database Systems

-- Lab 5

-- Q1

select Agents.city
from Agents, Orders
where Orders.aid = Agents.aid
  and cid = 'c006';

-- Q2

select distinct Orders.pid
from Orders
INNER JOIN Agents
	ON Orders.aid = Agents.aid
INNER JOIN Customers
	ON Orders.cid = Customers.cid
where Customers.city = 'Beijing'
order by Orders.pid DESC;

-- Q3

select name
from Customers
where cid NOT IN (select cid
		    from Orders);

-- Q4

select Customers.name
from Orders
RIGHT OUTER JOIN Customers
	      ON Orders.cid = Customers.cid
where ordNo IS null;

-- Q5

select distinct Customers.name, Agents.name
from Orders, Agents, Customers
where Orders.aid = Agents.aid
  and Orders.cid = Customers.cid
  and Customers.city = Agents.city;

-- Q6

select Customers.name, Agents.name, Customers.city
from Customers, Agents
where Customers.city = Agents.city;

-- Q7

select Customers.name, Customers.city
from Customers
where Customers.city IN (select city
			 from Products
			 group by city
			 order by count(pid) ASC
			 limit 1);