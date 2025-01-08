 Drop Table If Exists school;
---------------------------------------------------------------------------------------------------------------------------
--school jadvali

Create Table school(
	id Serial Not Null Unique,
	name Varchar(50),
	address Varchar(100),
	phone_number Char(13),
	davlat_maktabi bool
);

Alter Table school
Alter Column name rename to school_name;
Alter Column address rename to school_address;
Alter Column phone_number rename to scholl_phone_number;

Alter Table school rename to schools;

Insert Into school(name, address, phone_number, davlat_maktabi) values
('6-Maktab', 'Fergana', '+998905857541', True),
('21-maktab', 'Tashkent', '+998907658321', True),
('13-maktab', 'Andijan', '+998908731276', True),
('19-Maktab', 'Fergana', '+998905857541', True),
('8-maktab', 'Tashkent', '+998907658321', True),
('10-maktab', 'Andijan', '+998908731276', True);

select * from school;

-----------------------------------------------------------------------------------------------------------------------------
Drop Table If Exists teacher;
--teacher jadvali


Create Table teacher(
	id Serial Not Null Unique,
	first_name Varchar(50),
	last_name Varchar(50),
	email varchar(100) default 'aorifjonov09@gmail.com',
	phone_numbers char(13),
	school_id int References school(id)
);

Alter Table teacher rename to teachers;

Insert Into teacher(first_name, last_name, phone_numbers, school_id) values
('Shokir', 'Shokirov', '+998905857541', 1),
('Toxir', 'Toxirov', '+998907846512', 2),
('Jalil', 'Jalilov', '+998997655674', 3),
('Sobir', 'Sobirov', '+998906372516', 1),
('Hoshim', 'Hoshimov', '+998776543212', 2),
('Bakir', 'Bakirov', '+998978976543', 3);

Select 
	teacher.id,
	teacher.first_name,
	teacher.last_name,
	teacher.email,
	teacher.phone_numbers,
	school.name,
	school.address
From teacher
Join school On teacher.school_id = school.id;

--------------------------------------------------------------------------------------------------------------------------
Drop Table If Exists student;
-- student jadvali

Create Table student(
	id Serial Not Null Unique,
	first_name Varchar(50),
	last_name Varchar(50),
	date_of_brith date,
	gender Varchar(5),
	school_id int References school(id)
);

Insert Into student(first_name, last_name, date_of_brith, gender, school_id) values
('Shokir', 'Shokirov', '09.03.2005', 'erkak', 1),
('Toxir', 'Toxirov', '02.04.2007', 'erkak', 2),
('Sobir', 'Sobirov', '23.11.2006', 'erkak', 3),
('Abdulla', 'Abdullayev', '12.07.2010', 'erkak', 4),
('Shokir', 'Shokirov', '27.01.2011', 'erkak', 5),
('Abdulaziz', 'Orifjonov', '30.10.2009', 'erkak', 6);

Select 
	student.first_name,
	student.last_name,
	student.date_of_brith,
	student.gender,
	school.name,
	school.address
From student
Join school On student.school_id = school.id;

-------------------------------------------------------------------------------------------------------------------------------
Drop Table If Exists class;
--class jadvali

Create Table class(
	id Serial Not Null Unique,
	name Varchar(100),
	teacher_id int References teacher(id),
	school_id int References school(id)
);

Insert Into class(name, teacher_id, school_id) values
('1A', 1, 1),
('2B', 2, 2),
('3C', 3, 3),
('4D', 4, 4),
('5E', 5, 5),
('6F', 6, 6);

Select
	class.name,
	teacher.first_name,
	teacher.last_name,
	school.name,
	school.address
From class
Join teacher On class.teacher_id = teacher.id
Join school On class.school_id = school.id;

-----------------------------------------------------------------------------------------------------------------
Drop Table If Exists subject;
--subject jadvali

Create Table subject(
	id Serial Not Null Unique,
	name Varchar(50),
	class_id int References class(id),
	teacher_id int References teacher(id)
);

Insert Into subject(name, class_id, teacher_id) values
('Matematika', 1, 1),
('Bialogiya', 2, 2),
('Fizika', 3, 3),
('Jismoniy Tarbiya', 4, 4),
('Tarbiya', 5, 5),
('Kimyo', 6, 6);

Select
	subject.name,
	class.name,
	teacher.first_name,
	teacher.last_name
From subject
Join class On subject.class_id = class.id
Join teacher On subject.teacher_id = teacher.id;

-----------------------------------------------------------------------------------------------------------------------
Drop Table If Exists enrollment;
--enrollment jadvali

Create Table enrollment(
	id Serial Not Null Unique,
	student_id int References student(id),
	class_id int References class(id),
	enrollment_date Date Default Current_Date
);

Insert Into enrollment(student_id, class_id) values
('1', '1'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5'),
('6', '6');

Select
	student.first_name,
	student.last_name,
	class.name,
	enrollment.enrollment_date
From enrollment
Join student On enrollment.student_id = student.id
Join class On enrollment.class_id = class.id;

---------------------------------------------------------------------------------------------------------------------------------
Drop Table If Exists grade; 
-- grade jadvali

Create Table grade(
	id Serial Not Null Unique,
	student_id int References student(id),
	subject_id int References subject(id),
	grade_value Text,
	date_given Date default Current_Date
);

Insert Into grade(student_id, subject_id, grade_value) values
('1', '1', '...'),
('2', '2', '...'),
('3', '3', '...'),
('4', '4', '...'),
('5', '5', '...'),
('6', '6', '...');

Select
	student.first_name,
	student.last_name,
	student.
	subject.name,
	grade.grade_value,
	grade.date_given
From grade
Join student On grade.student_id = student.id
Join subject On grade.subject_id = subject.id;

-------------------------------------------------------------------------------------------------------------------
Drop Table If Exists attendance;
-- attendance jadvali

Create Table attendance(
	id Serial Not Null Unique,
	student_id int References student(id),
	class_id int References class(id),
	date Date Default Current_Date
);

Alter Table attendance
Add Column school_id int References school(id)
Add Column teacher_id int References teacher(id);
Drop Column teacher_id;

Insert Into attendance(student_id, class_id) values
('1', '1'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5'),
('6', '6');

Select
	student.first_name,
	student.last_name,
	subject.name,
	grade.grade_value,
	grade.date_given,
	school.school_name
From grade
Join student On grade.student_id = student.id
Join subject On grade.subject_id = subject.id;

---------------------------------------------------------------------------------------------------------


















