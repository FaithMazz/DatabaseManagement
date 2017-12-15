
-- Adriance Memorial Library
-- Faith Mazzone

DROP TABLE IF EXISTS ReturnedItems;
DROP TABLE IF EXISTS BorrowedItems;

DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Attendees;
DROP TABLE IF EXISTS Patrons;

DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS AudioBooks;
DROP TABLE IF EXISTS Magazines;
DROP TABLE IF EXISTS CDs;
DROP TABLE IF EXISTS DVDs;
DROP TABLE IF EXISTS Games;
DROP TABLE IF EXISTS Videos;
DROP TABLE IF EXISTS Materials;

DROP TABLE IF EXISTS ProgramSchedules;
DROP TABLE IF EXISTS Programs;
DROP TABLE IF EXISTS ProgramLeaders;
DROP TABLE IF EXISTS Rooms;

DROP TABLE IF EXISTS People;

DROP TABLE IF EXISTS Mondays;
DROP TABLE IF EXISTS Tuesdays;
DROP TABLE IF EXISTS Wednesdays;
DROP TABLE IF EXISTS Thursdays;
DROP TABLE IF EXISTS Fridays;
DROP TABLE IF EXISTS Saturdays;
DROP TABLE IF EXISTS Sundays;
DROP TABLE IF EXISTS CalendarDates;


CREATE TABLE People (
	PID char(4) not null,
	FirstName text,
	LastName text,
	DOB date,
	primary key (PID)
);

CREATE TABLE Staff (
	PID char(4) not null references People(PID),
	positionName text,
	SalaryUSD int,
	primary key (PID)
);
  
CREATE TABLE Patrons (
	PID char(4) not null references People(PID),
	DateRegistered date,
	CurrentStanding text CHECK (CurrentStanding = 'Good' 
				    or CurrentStanding = 'Bad'),
	primary key (PID)
);

CREATE TABLE ProgramLeaders (
	PID char(4) not null references People(PID),
	primary key (PID)
);


CREATE TABLE CalendarDates (
	calID char(8),
	dayName text CHECK (dayName = 'Monday'
			     or dayName = 'Tuesday'
			     or dayName = 'Wednesday'
			     or dayName = 'Thursday'
			     or dayName = 'Friday'
			     or dayName = 'Saturday'
			     or dayName = 'Sunday'),
	startTimeHour int,
	startTimeMin int,
	primary key (calID)
);


CREATE TABLE Rooms (
	RoomID char(4),
	RoomName text,
	MaxOccupancy int,
	primary key (RoomID)
);

CREATE TABLE Programs (
	ProgramID char(4),
	ProgramName text,
	CalendarDates char(8) references CalendarDates(calID),
	primary key (ProgramID)
);

CREATE TABLE Attendees (
	PID char(4) not null references People(PID),
	ProgramID char(4) not null references Programs(ProgramID),
	primary key (PID, ProgramID)
);


CREATE TABLE ProgramSchedules (
	ProgramID char(4) not null references Programs(ProgramID),
	StartDate date,
	RoomID char(4) references Rooms(RoomID),
	teacherPID char(4) references ProgramLeaders(PID),
	primary key (programID, startDate)
);


CREATE TABLE Materials (
	materialID char(8) not null,
	primary key (materialID)
);


CREATE TABLE Books (
	materialID char(8) not null references Materials(materialID),
	MaxBorrowTimeInDays int,
	LateFeePerDayUSD float,
	ISBN varchar(16),
	ReleaseDate date,
	Name text,
	AuthorFirstName text,
	AuthorLastName text,
	Genre text,
	primary key (materialID)
);


CREATE TABLE AudioBooks (
	materialID char(8) not null references Materials(materialID),
	MaxBorrowTimeInDays int,
	LateFeePerDayUSD float,
	ISBN varchar(16),
	ReleaseDate date,
	Name text,
	AuthorFirstName text,
	AuthorLastName text,
	Genre text,
	ReaderFirstName text,
	ReaderLastName text,
	primary key (materialID)
);


CREATE TABLE Magazines (
	materialID char(8) not null references Materials(materialID),
	MaxBorrowTimeInDays int,
	LateFeePerDayUSD float,
	issueDate date,
	Publisher text,
	primary key (materialID)
);


CREATE TABLE CDs (
	materialID char(8) not null references Materials(materialID),
	MaxBorrowTimeInDays int,
	LateFeePerDayUSD float,
	ReleaseDate date,
	Name text,
	CreatorName text,
	primary key (materialID)
);


CREATE TABLE DVDs (
	materialID char(8) not null references Materials(materialID),
	MaxBorrowTimeInDays int,
	LateFeePerDayUSD float,
	ReleaseDate date,
	Name text,
	Rating text,
	DirectorFirstName text,
	DirectorLastName text,
	primary key (materialID)
);


CREATE TABLE Games (
	materialID char(8) not null references Materials(materialID),
	MaxBorrowTimeInDays int,
	LateFeePerDayUSD float,
	ReleaseDate date,
	Name text,
	MinAge int,
	Publishers text,
	primary key (materialID)
);

CREATE TABLE BorrowedItems (
	PID char(4) not null references Patrons(PID),
	dateBorrowed date,
	dueDate date,
	materialID char(8) references Materials(materialID),
	primary key (dateBorrowed, materialID) --don't have to use PID, as one material usually can't be borrowed at the same time
);
  
CREATE TABLE ReturnedItems (
	PID char(4) not null references Patrons(PID),
	dateReturned date,
	wasItLate boolean,
	materialID char(8) references Materials(materialID),
	primary key (dateReturned, materialID)
);


-- Insert Statements --

-- People --
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p001', 'Booker', 'DeWitt', TO_DATE('1874-04-19', 'YYYY-MM-DD'));
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p002', 'Nicole', 'Greyson', TO_DATE('1985-02-30', 'YYYY-MM-DD')); 
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p003', 'Faith', 'Mazzone', TO_DATE('1997-06-08', 'YYYY-MM-DD')); 
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p007', 'Alan', 'Labouseur', TO_DATE('1992-01-01', 'YYYY-MM-DD')); 
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p004', 'Katie', 'Bradford', TO_DATE('2002-12-05', 'YYYY-MM-DD')); 
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p006', 'Tyler', 'Wheatley', TO_DATE('2007-03-31', 'YYYY-MM-DD')); 
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p008', 'Olivia', 'Bleasdale', TO_DATE('1982-07-08', 'YYYY-MM-DD')); 
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p009', 'Jack', 'Nguyen', TO_DATE('1996-11-13', 'YYYY-MM-DD')); 
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p010', 'Jeffrey', 'Parker', TO_DATE('1999-05-23', 'YYYY-MM-DD')); 
INSERT INTO People (PID, FirstName, LastName, DOB)
  VALUES ('p011', 'Joey', 'Hanson', TO_DATE('1981-09-17', 'YYYY-MM-DD'));   
-- Staff --
INSERT INTO Staff (PID, positionName, salaryUSD)
  VALUES ('p002', 'Librarian', 59350);
INSERT INTO Staff (PID, positionName, salaryUSD)
  VALUES ('p011', 'Maintenance', 30780);

-- Patrons --
INSERT INTO Patrons (PID, DateRegistered, CurrentStanding)
  VALUES ('p002', TO_DATE('2014-05-01', 'YYYY-MM-DD'), 'Good');
INSERT INTO Patrons (PID, DateRegistered, CurrentStanding)
  VALUES ('p006', TO_DATE('2016-06-21', 'YYYY-MM-DD'), 'Bad');
INSERT INTO Patrons (PID, DateRegistered, CurrentStanding)
  VALUES ('p007', TO_DATE('2015-11-10', 'YYYY-MM-DD'), 'Good');
INSERT INTO Patrons (PID, DateRegistered, CurrentStanding)
  VALUES ('p004', TO_DATE('2017-02-29', 'YYYY-MM-DD'), 'Good');
INSERT INTO Patrons (PID, DateRegistered, CurrentStanding)
  VALUES ('p008', TO_DATE('2012-08-14', 'YYYY-MM-DD'), 'Good');
INSERT INTO Patrons (PID, DateRegistered, CurrentStanding)
  VALUES ('p009', TO_DATE('2017-01-05', 'YYYY-MM-DD'), 'Good');
INSERT INTO Patrons (PID, DateRegistered, CurrentStanding)
  VALUES ('p010', TO_DATE('2013-09-14', 'YYYY-MM-DD'), 'Good');
INSERT INTO Patrons (PID, DateRegistered, CurrentStanding)
  VALUES ('p011', TO_DATE('2017-04-15', 'YYYY-MM-DD'), 'Good');

-- Program Leaders --
INSERT INTO ProgramLeaders (PID)
  VALUES ('p003');
INSERT INTO ProgramLeaders (PID)
  VALUES ('p011');
INSERT INTO ProgramLeaders (PID)
  VALUES ('p008');

-- Calendar --
INSERT INTO CalendarDates (calID, dayName, startTimeHour, startTimeMin)
  VALUES ('cal00001', 'Monday', 15, 30);
INSERT INTO CalendarDates (calID, dayName, startTimeHour, startTimeMin)
  VALUES ('cal00002', 'Saturday', 10, 00);
INSERT INTO CalendarDates (calID, dayName, startTimeHour, startTimeMin)
  VALUES ('cal00003', 'Wednesday', 18, 15);
INSERT INTO CalendarDates (calID, dayName, startTimeHour, startTimeMin)
  VALUES ('cal00004', 'Friday', 12, 30);

-- Rooms --
INSERT INTO Rooms (RoomID, RoomName, MaxOccupancy)
  VALUES ('r001', 'Teen Study Room', 30);
INSERT INTO Rooms (RoomID, RoomName, MaxOccupancy)
  VALUES ('r002', 'Charwat Meeting Room', 50);
INSERT INTO Rooms (RoomID, RoomName, MaxOccupancy)
  VALUES ('r003', 'Small Periodicals Room', 15);
INSERT INTO Rooms (RoomID, RoomName, MaxOccupancy)
  VALUES ('r004', 'Greenspan Board Room', 23);
INSERT INTO Rooms (RoomID, RoomName, MaxOccupancy)
  VALUES ('r005', 'Ground Floor Lobby', 150);

-- Programs --
INSERT INTO Programs (ProgramID, ProgramName, CalendarDates)
  VALUES ('g001', 'Girls Who Code', 'cal00002');
INSERT INTO Programs (ProgramID, ProgramName, CalendarDates)
  VALUES ('g002', 'Gay, Lesbian, and Straight Education Network', 'cal00004');
INSERT INTO Programs (ProgramID, ProgramName, CalendarDates)
  VALUES ('g003', 'Knitting and Crocheting Club', 'cal00001');

-- Attendees --
INSERT INTO Attendees (PID, ProgramID)
  VALUES ('p004', 'g001');
INSERT INTO Attendees (PID, ProgramID)
  VALUES ('p006', 'g001');
INSERT INTO Attendees (PID, ProgramID)
  VALUES ('p008', 'g001');
INSERT INTO Attendees (PID, ProgramID)
  VALUES ('p009', 'g001');
INSERT INTO Attendees (PID, ProgramID)
  VALUES ('p011', 'g002');
INSERT INTO Attendees (PID, ProgramID)
  VALUES ('p004', 'g002');
INSERT INTO Attendees (PID, ProgramID)
  VALUES ('p009', 'g003');
INSERT INTO Attendees (PID, ProgramID)
  VALUES ('p010', 'g003');
INSERT INTO Attendees (PID, ProgramID)
  VALUES ('p004', 'g003');
  
-- ProgramSchedules --
INSERT INTO ProgramSchedules (ProgramID, StartDate, RoomID, teacherPID)
  VALUES ('g001', TO_DATE('2017-09-11', 'YYYY-MM-DD'), 'r001', 'p003');
INSERT INTO ProgramSchedules (ProgramID, StartDate, RoomID, teacherPID)
  VALUES ('g002', TO_DATE('2016-11-01', 'YYYY-MM-DD'), 'r002', 'p008');
INSERT INTO ProgramSchedules (ProgramID, StartDate, RoomID, teacherPID)
  VALUES ('g003', TO_DATE('2017-02-20', 'YYYY-MM-DD'), 'r004', 'p011');


-- Materials --
INSERT INTO Materials (materialID)
  VALUES ('m0000001');
INSERT INTO Materials (materialID)
  VALUES ('m0000002');
INSERT INTO Materials (materialID)
  VALUES ('m0000003');
INSERT INTO Materials (materialID)
  VALUES ('m0000004');
INSERT INTO Materials (materialID)
  VALUES ('m0000005');
INSERT INTO Materials (materialID)
  VALUES ('m0000006');
INSERT INTO Materials (materialID)
  VALUES ('m0000007');
INSERT INTO Materials (materialID)
  VALUES ('m0000008');
INSERT INTO Materials (materialID)
  VALUES ('m0000009');

-- Books --
INSERT INTO Books (materialID, maxBorrowTimeInDays, LateFeePerDayUSD, ISBN, ReleaseDate, Name, AuthorFirstName, AuthorLastName, Genre)
  VALUES ('m0000001', 21, 0.1, '159514188X', TO_DATE('2011-06-14', 'YYYY-MM-DD'), '13 Reasons Why', 'Jay', 'Asher', 'YA Fiction');
INSERT INTO Books (materialID, maxBorrowTimeInDays, LateFeePerDayUSD, ISBN, ReleaseDate, Name, AuthorFirstName, AuthorLastName, Genre)
  VALUES ('m0000007', 21, 0.1, '9788496581579', TO_DATE('1985-01-15', 'YYYY-MM-DD'), 'Enders Game', 'Orson', 'Card', 'SciFi');

-- Audio Books --
INSERT INTO AudioBooks (materialID, maxBorrowTimeInDays, LateFeePerDayUSD, ISBN, ReleaseDate, Name, AuthorFirstName, AuthorLastName, Genre, ReaderFirstName, ReaderLastName)
  VALUES ('m0000002', 21, 0.1, '9780525618331', TO_DATE('2017-11-01', 'YYYY-MM-DD'), 'The Midnight Line', 'Lee', 'Child', 'Mystery', 'Dick', 'Hill');


-- Magazines --
INSERT INTO Magazines (materialID, maxBorrowTimeInDays, LateFeePerDayUSD, issueDate, Publisher)
  VALUES ('m0000003', 21, 0.1, TO_DATE('2016-03-01', 'YYYY-MM-DD'), 'Marie Claire');
INSERT INTO Magazines (materialID, maxBorrowTimeInDays, LateFeePerDayUSD, issueDate, Publisher)
  VALUES ('m0000008', 21, 0.1, TO_DATE('2015-02-23', 'YYYY-MM-DD'), 'TIME');

-- CDs --
INSERT INTO CDs (materialID, maxBorrowTimeInDays, LateFeePerDayUSD, ReleaseDate, Name, CreatorName)
  VALUES ('m0000004', 7, 0.25, TO_DATE('1997-05-26', 'YYYY-MM-DD'), 'N Sync', 'NSYNC');

-- DVDs --
INSERT INTO DVDs (materialID, MaxBorrowTimeInDays, LateFeePerDayUSD, ReleaseDate, Name, Rating, DirectorFirstName, DirectorLastName)
  VALUES ('m0000005', 7, 1, TO_DATE('2005-03-15', 'YYYY-MM-DD'), 'The Incredibles', 'PG', 'Brad', 'Bird');

-- Games --
INSERT INTO Games (materialID, MaxBorrowTimeInDays, LateFeePerDayUSD, ReleaseDate, Name, MinAge, Publishers)
  VALUES ('m0000006', 7, 0.25, TO_DATE('1991-01-01', 'YYYY-MM-DD'), 'Sorry!', 6, 'Hasbro');
INSERT INTO Games (materialID, MaxBorrowTimeInDays, LateFeePerDayUSD, ReleaseDate, Name, MinAge, Publishers)
  VALUES ('m0000009', 7, 0.25, TO_DATE('2003-01-01', 'YYYY-MM-DD'), 'Garfields Typing Pal', 7, 'Typing Pal');

-- BorrowedItems --
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p002', TO_DATE('2017-12-11', 'YYYY-MM-DD'), TO_DATE('2017-12-25', 'YYYY-MM-DD'), 'm0000001');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p006', TO_DATE('2017-02-10', 'YYYY-MM-DD'), TO_DATE('2017-02-17', 'YYYY-MM-DD'), 'm0000009');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p006', TO_DATE('2017-03-21', 'YYYY-MM-DD'), TO_DATE('2017-03-28', 'YYYY-MM-DD'), 'm0000005');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p011', TO_DATE('2016-08-02', 'YYYY-MM-DD'), TO_DATE('2016-08-23', 'YYYY-MM-DD'), 'm0000001');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p007', TO_DATE('2017-01-17', 'YYYY-MM-DD'), TO_DATE('2017-02-03', 'YYYY-MM-DD'), 'm0000007');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p010', TO_DATE('2017-04-05', 'YYYY-MM-DD'), TO_DATE('2017-04-12', 'YYYY-MM-DD'), 'm0000006');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p010', TO_DATE('2014-01-13', 'YYYY-MM-DD'), TO_DATE('2014-12-25', 'YYYY-MM-DD'), 'm0000007');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p004', TO_DATE('2017-03-08', 'YYYY-MM-DD'), TO_DATE('2017-03-15', 'YYYY-MM-DD'), 'm0000006');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p010', TO_DATE('2013-10-23', 'YYYY-MM-DD'), TO_DATE('2013-10-30', 'YYYY-MM-DD'), 'm0000004');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p007', TO_DATE('2015-11-19', 'YYYY-MM-DD'), TO_DATE('2015-12-10', 'YYYY-MM-DD'), 'm0000008');
INSERT INTO BorrowedItems (PID, dateBorrowed, dueDate, materialID)
  VALUES ('p006', TO_DATE('2017-01-02', 'YYYY-MM-DD'), TO_DATE('2017-01-09', 'YYYY-MM-DD'), 'm0000009');

-- Returned Items --
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p002', TO_DATE('2017-12-13', 'YYYY-MM-DD'), false, 'm0000001');
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p006', TO_DATE('2017-03-10', 'YYYY-MM-DD'), true, 'm0000009');
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p011', TO_DATE('2016-08-20', 'YYYY-MM-DD'), false, 'm0000001');
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p007', TO_DATE('2017-02-03', 'YYYY-MM-DD'), false, 'm0000007');
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p010', TO_DATE('2017-04-10', 'YYYY-MM-DD'), false, 'm0000006');
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p010', TO_DATE('2014-12-17', 'YYYY-MM-DD'), false, 'm0000007');
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p004', TO_DATE('2017-03-13', 'YYYY-MM-DD'), false, 'm0000006');
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p010', TO_DATE('2013-12-10', 'YYYY-MM-DD'), false, 'm0000004');
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p007', TO_DATE('2015-12-08', 'YYYY-MM-DD'), false, 'm0000008');
INSERT INTO ReturnedItems (PID, dateReturned, wasItLate, materialID)
  VALUES ('p006', TO_DATE('2017-01-09', 'YYYY-MM-DD'), false, 'm0000009');



-- Tests --

select * from People;
select * from Patrons;
select * from Staff;
select * from ProgramLeaders;
select * from CalendarDates;
select * from Rooms;
select * from Programs;
select * from Attendees;
select * from ProgramSchedules;
select * from Materials;
select * from Books;
select * from AudioBooks;
select * from Magazines;
select * from CDs;
select * from DVDs;
select * from Games;
select * from BorrowedItems;
select * from ReturnedItems;





-- Find materials that have been entirely unused --
create or replace view unusedMaterials
	as select distinct m.materialID
	from Materials m, BorrowedItems b
	where m.materialId not in 
		(select materialID from BorrowedItems)
	order by m.materialID ASC;

select * from unusedMaterials;




-- Get patron's checkout history
CREATE OR REPLACE FUNCTION getPatronsCheckoutHistory (text, text, REFCURSOR) RETURNS refcursor AS
$$
	DECLARE
		newFirstName TEXT := $1;
		newLastName TEXT := $2;
		resultset REFCURSOR := $3;
BEGIN
	OPEN resultset FOR
		select distinct b.materialID, b.dateBorrowed
		from BorrowedItems b, Patrons p
		where b.PID = 
			(select distinct PID
			from People p
			where p.FirstName LIKE newFirstName and p.LastName LIKE newLastName);
	return resultset;
END
$$
LANGUAGE plpgsql;


SELECT getPatronsCheckoutHistory('Jeffrey', 'Parker', 'ref');
FETCH ALL FROM ref;

SELECT getPatronsCheckoutHistory('A%', 'L%', 'ref');
FETCH ALL FROM ref;




-- User Roles
create role admin;
create role management;
create role librarian;
create role frontDesk;

grant all on all tables in schema public to admin;

grant SELECT, INSERT, DELETE on People to management;
grant SELECT, INSERT, DELETE on Patrons to management;
grant SELECT, INSERT, DELETE on ProgramLeaders to management;
grant SELECT, INSERT, DELETE on CalendarDates to management;
grant SELECT, INSERT, DELETE on Programs to management;
grant SELECT, INSERT, DELETE on Attendees to management;
grant SELECT, INSERT, DELETE on ProgramSchedule to management;
grant SELECT, INSERT on Materials to management;
grant SELECT, INSERT on Books to management;
grant SELECT, INSERT on AudioBooks to management;
grant SELECT, INSERT on Magazines to management;
grant SELECT, INSERT on CDs to management;
grant SELECT, INSERT on DVDs to management;
grant SELECT, INSERT on Games to management;
grant SELECT on BorrowedItems to management;
grant SELECT on ReturnedItems to management;


grant SELECT, INSERT on People to librarian;
grant SELECT, INSERT on Patrons to librarian;
grant SELECT, INSERT on ProgramLeaders to librarian;
grant SELECT, INSERT on CalendarDates to librarian;
grant SELECT, INSERT on Programs to librarian;
grant SELECT, INSERT on Attendees to librarian;
grant SELECT, INSERT on ProgramSchedule to librarian;
grant SELECT, INSERT on Materials to librarian;
grant SELECT, INSERT on Books to librarian;
grant SELECT, INSERT on AudioBooks to librarian;
grant SELECT, INSERT on Magazines to librarian;
grant SELECT, INSERT on CDs to librarian;
grant SELECT, INSERT on DVDs to librarian;
grant SELECT, INSERT on Games to librarian;
grant SELECT, INSERT on BorrowedItems to librarian;
grant SELECT, INSERT on ReturnedItems to librarian;

grant SELECT on People to frontDesk;
grant SELECT on Patrons to frontDesk;
grant SELECT on ProgramLeaders to frontDesk;
grant SELECT on CalendarDates to frontDesk;
grant SELECT on Programs to frontDesk;
grant SELECT on Attendees to frontDesk;
grant SELECT on ProgramSchedule to frontDesk;
grant SELECT on Materials to frontDesk;
grant SELECT on Books to frontDesk;
grant SELECT on AudioBooks to frontDesk;
grant SELECT on Magazines to frontDesk;
grant SELECT on CDs to frontDesk;
grant SELECT on DVDs to frontDesk;
grant SELECT on Games to frontDesk;
grant SELECT, INSERT on BorrowedItems to frontDesk;
grant SELECT, INSERT on ReturnedItems to frontDesk;




-- Reports

-- Number of new members in 2017
select count(pid)
from Patrons
where Patrons.dateRegistered >= '2017-01-01';

-- Number of loans taken out in 2017
select count(materialID)
from BorrowedItems
where dateBorrowed >= '2017-01-01';