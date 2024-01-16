create table Departments(
	id serial primary key,
	Building integer not NULL check(Building >= 1 and Building <= 5),
	Financing decimal (10, 2) not NULL default 0 check(Financing >= 0),
	name varchar(100) unique not NULL
);

INSERT INTO Departments (Building, Financing, Name) VALUES
    (1, 500000.00, 'Cardiology'),
    (2, 700000.00, 'Pediatrics'),
    (3, 600000.00, 'Surgery'),
    (4, 800000.00, 'Oncology'),
    (5, 550000.00, 'Neurology');
	
	
create table Diseases(
	id serial primary key,
	name varchar(100) unique not NULL,
	Severity integer not NULL default 1 check(Severity >= 1)

);

INSERT INTO Diseases (Name, Severity) VALUES
    ('Flu', 2),
    ('Hypertension', 3),
    ('Diabetes', 4),
    ('Bronchitis', 2),
    ('Migraine', 1);
	
create table Doctors(
	id serial primary key,
	name varchar(255) not NULL,
	Phone char(10),
	Salary decimal(10, 2) not NULL check(Salary > 0),
	Surname varchar(255) not NULL

);

INSERT INTO Doctors (Name, Phone, Salary, Surname) VALUES
    ('John', '1234567890', 80000.00, 'Doe'),
    ('Emily', '9876543210', 75000.00, 'Smith'),
    ('Michael', '5555555555', 90000.00, 'Johnson'),
    ('Sarah', '3333333333', 85000.00, 'Williams'),
    ('David', '7777777777', 82000.00, 'Jones');
	

create table Examinations(
	id serial primary key,
	DayOfWeek int not NULL check(DayOfWeek between 1 and 7),
	EndTime time not NULL,
	name varchar(100) unique not NULL,
	StartTime time not NULL check(StartTime between '08:00' and '18:00')
	);
	
INSERT INTO Examinations (DayOfWeek, EndTime, Name, StartTime) VALUES
    (1, '12:00', 'Morning Checkup', '08:00'),
    (3, '15:30', 'Afternoon Exam', '13:00'),
    (5, '17:00', 'Evening Consultation', '16:00'),
    (2, '10:30', 'Routine Blood Test', '09:00'),
    (4, '14:45', 'X-ray Session', '12:30');
	
create table Wards(
	id serial primary key,
	Building integer not NULL check(Building >= 1 and Building <= 5),
	--foreign key (Building) references Departments(Building),
	floor int not NULL check(floor >= 1),
	name varchar(20) unique not NULL
);

INSERT INTO Wards (Building, Floor, Name) VALUES
    (1, 2, 'Cardiology Ward'),
    (2, 1, 'Pediatrics Ward'),
    (3, 3, 'Surgery Ward'),
    (4, 2, 'Oncology Ward'),
    (5, 1, 'Neurology Ward');

-----------------------------------------------------------------------------------
--1. Вивести вміст таблиці палат.
select * from wards

--2. Вивести прізвища та телефони усіх лікарів.
select surname, phone from doctors

--3. Вивести усі поверхи без повторень, де розміщуються палати
select distinct floor from wards

--Завдання 4
select name as "Name of Disease", Severity as "Severity of Disese" from Diseases;

--5. Вивести назви відділень, які знаходяться у корпусі 5 з фондом фінансування меншим, ніж 600000.
select name, financing from departments
where building = '5' and financing < '600000'


--6. Вивести назви відділень, які знаходяться у корпусі 3 зфондом фінансування у діапазоні від 60000 до 75000.
select name, financing from departments
where building = '3' and financing between 600000 and 750000

--8. Вивести назви палат, які знаходяться у корпусах 4 та 5 на 1-му поверсі.
select name from wards
where building in (4, 5) and floor = 1

--9. Вивести назви, корпуси та фонди фінансування відділень, які знаходяться у корпусах 3 або 6 та мають
--фонд фінансування менший, ніж 11000 або більший за 25000.

select name, building, financing from departments
where building in (3, 6) and financing < 550000 and financing > 750000


--10. Вивести прізвища лікарів, зарплата (сума ставки та надбавки 120) яких перевищує 1500.
select name from doctors
where salary + 120 > 1500

--11. Вивести прізвища лікарів, у яких половина зарплати перевищує триразову надбавку у вигляді 500.
select name from doctors
where salary / 2 > 500 * 3

--12. Вивести назви обстежень без повторень, які проводяться у перші три дні тижня з 12:00 до 15:00.
select distinct name from examinations
where dayofweek in (1, 2, 3) and starttime > '12:00' and endtime < '15:00'

--13. Вивести назви та номери корпусів відділень, які знаходяться у корпусах 1, 3, 8 або 10.
select name, building from departments
where building in (1, 3, 8, 10)

--14 Вивести назви захворювань усіх ступенів тяжкості, крім 1-го та 2-го.
select name 
from Diseases
where severity not in (1, 2)

--15. Вивести назви відділень, які не знаходяться у першому або третьому корпусі.
select name from departments
where building not in (1, 3)

--16. Вивести назви відділень, які знаходяться у першому або третьому корпусі.
select name from departments
where building in (1, 3)

17. Вивести прізвища лікарів, що починаються з літери «N»
select surname from doctors
where surname like 'N%'
--where surname like 'J%'



