
-- Database Management (CMPT308) - Lab 4 --
-- Faith Mazzone

-- Q1

select city
from Agents
where aid in (select aid
	from Orders
	where cid = 'c006');

-- Q2

select distinct pid, aid
from Orders
where aid in (select aid
	from Orders
	where cid in (select cid
		from Customers
		where city = 'Beijing' )
	     )
order by pid desc;

-- Q3

select cid, name
from Customers
where cid in (select cid
	from Orders
	where aid in (select aid
		from Agents
		where aid != 'a03')
	     );

-- Q4

select cid, name
from Customers
where cid in (select cid
	from Orders
	where (pid = 'p01')
	AND cid in (select cid
		from Orders
		where (pid = 'p07')
		   )
	     );

-- Q5

select pid, cid
from Orders
where cid in (select cid
		from Orders
		where (aid != 'a02') and (aid != 'a03')
	     )
order by pid desc;

-- Q6

select name, discountpct, city
from Customers
where cid in (select cid
	from Orders
	where aid in (select aid
		from Agents
		where city = 'Tokyo' or city = 'New York')
	     );

-- Q7

select *
from Customers
where discountpct in (select discountpct
	from Customers
	where city = 'Duluth' 
	or city = 'Dallas');

-- Q8

----
--
-- Check Constraints in databases are rules and requirements that ensure data integrity in a database.
-- Preexisting versions of these would be that you cannot have a secondary key (referencing to another table)
-- unless that table/column exists. One could also create one's own constraints, such as making sure phone numbers
-- have a certain number of characters, that a person's age cannot succeed a reasonable number (highly unlikely a user is over
-- a user is over 150 years old), or that certain columns cannot contain values that are negative numbers. 
-- Keeping these rules allow a database to be more consistent and credible, as one can trust the values more if they
-- abide by strict, relevant rules.
--
----
