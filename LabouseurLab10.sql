
----------------------------------------------------------------------------------------
-- Courses and Prerequisites
-- by Alan G. Labouseur
-- Tested on Postgres 9.3.2
----------------------------------------------------------------------------------------

--
-- The table of courses.
--


DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Prerequisites;


create table Courses (
    num      integer not null,
    name     text    not null,
    credits  integer not null,
  primary key (num)
);


insert into Courses(num, name, credits)
values (499, 'CS/ITS Capping', 3 );

insert into Courses(num, name, credits)
values (308, 'Database Systems', 4 );

insert into Courses(num, name, credits)
values (221, 'Software Development Two', 4 );

insert into Courses(num, name, credits)
values (220, 'Software Development One', 4 );

insert into Courses(num, name, credits)
values (120, 'Introduction to Programming', 4);

select * 
from courses
order by num ASC;


--
-- Courses and their prerequisites
--
create table Prerequisites (
    courseNum integer not null references Courses(num),
    preReqNum integer not null references Courses(num),
  primary key (courseNum, preReqNum)
);

insert into Prerequisites(courseNum, preReqNum)
values (499, 308);

insert into Prerequisites(courseNum, preReqNum)
values (499, 221);

insert into Prerequisites(courseNum, preReqNum)
values (308, 120);

insert into Prerequisites(courseNum, preReqNum)
values (221, 220);

insert into Prerequisites(courseNum, preReqNum)
values (220, 120);

select *
from Prerequisites
order by courseNum DESC;


--
-- Faith Mazzone
-- Database Systems & Design
-- CMPT 308
-- Labouseur
-- Lab 10
--


-- Q1 --
create or replace function preReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   newCourseNum   int       := $1;
   resultset      REFCURSOR := $2;
begin
   open resultset for 
      select name, num, preReqNum
      from   Courses INNER JOIN Prerequisites on Courses.num = Prerequisites.coursenum
      where  newCourseNum = Courses.num;
   return resultset;
end;
$$ 
language plpgsql;

-- Testing --
-- 499 should return 308 and 221
select PreReqsFor(499, 'results');
Fetch all from results;
-- 308 should return 120
select PreReqsFor(308, 'results');
Fetch all from results;
-- 221 should return 220
select PreReqsFor(221, 'results');
Fetch all from results;
-- 220 should return 120
select PreReqsFor(220, 'results');
Fetch all from results;



-- Q2 --

create or replace function isPreReqFor(int, REFCURSOR) returns refcursor as 
$$
declare
   newCourseNum   int       := $1;
   resultset      REFCURSOR := $2;
begin
   open resultset for 
      select name, num, preReqNum
      from   Courses INNER JOIN Prerequisites on Courses.num = Prerequisites.coursenum
      where  newCourseNum = Prerequisites.preReqNum;
   return resultset;
end;
$$ 
language plpgsql;


-- Testing --
-- 308 should return 499
select IsPreReqFor(308, 'results');
Fetch all from results;
-- 221 should return 499
select IsPreReqFor(221, 'results');
Fetch all from results;
-- 220 should return 221
select IsPreReqFor(220, 'results');
Fetch all from results;
-- 120 should return both 308 and 220
select IsPreReqFor(120, 'results');
Fetch all from results;




-- Optional Challenge

-- Q1 --
create or replace function preReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   newCourseNum   int       := $1;
   resultset      REFCURSOR := $2;
begin
   open resultset for 
      select preReqNum
      from   Courses INNER JOIN Prerequisites on Courses.num = Prerequisites.coursenum
      where  newCourseNum = Courses.num;
   return resultset;
end;
$$ 
language plpgsql;

create or replace function isPreReqFor(int, REFCURSOR) returns refcursor as 
$$
declare
   newCourseNum   int       := $1;
   resultset      REFCURSOR := $2;
begin
   open resultset for 
      select name, num, preReqNum
      from   Courses INNER JOIN Prerequisites on Courses.num = Prerequisites.coursenum
      where  newCourseNum = Prerequisites.preReqNum;
   return resultset;
end;
$$ 
language plpgsql;


/*
start by checking if prereq exists?
if so, get the prereq number and
call prereqsfor on it. Keep doing that
until prereq for course does not exist
*/

create or replace function AllPreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   newCourseNum   int       := $1;
   resultset      REFCURSOR := $2;
   nextCourseNum  int       := $3;
begin
   --open resultset for
	--return preReqsFor(newCourseNum, 'results');
	--nextCourseNum = preReqsFor(newCourseNum, 'results');
   --return resultset;
end;
$$ 
language plpgsql;

/*
notes

Does not like call. Specifying database doesn't help.
Exec also fails. Syntax error.

Probably need to rewrite the original functions to only
return the pertinent information.

Return is working, without returning resultset.

Set up if statement first.
*/
select AllPreReqsFor(308, 'results');
Fetch all from results;