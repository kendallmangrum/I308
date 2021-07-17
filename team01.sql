#TEAM01 - FINAL SQL

#SELECT STATEMENTS/QUERIES

#A LEVEL QUERIES:

#1a
SELECT CONCAT(s.Fname, ' ', s.Lname) as studentNames
FROM student as s, section_student_grade as sx
WHERE sx.student_id = s.student_id AND sx.section_num = 15 #section_num is a PHP dropdown on site
ORDER BY s.Lname, s.Fname;

#2a
SELECT r.room_id as 'Room Number: ', b.name as 'Building Name: ', rf.feature as 'Room Feature: '
FROM room as r, building as b, room_feature as rf
WHERE r.build_id = b.build_id AND r.room_id = rf.room_id AND feature = 'Computer Lab' #feature is a PHP dropdown on site
ORDER BY b.build_id, r.room_id;

#3a
SELECT CONCAT(p.Fname, ' ', p.Lname), c.course_num as ProfessorFullName, COUNT(course_num) as TimesTaught
FROM course as c, people as p, course_section_semester_people_room as csspr
WHERE p.emp_id = csspr.emp_id AND csspr.course_id = c.course_id
GROUP BY p.emp_id, c.course_num;

#4a
SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentFullName
FROM student as s, section as sx, section_student_grade as ssg
WHERE s.student_id = ssg.student_id AND ssg.section_num = sx.section_num AND sx.course_id IN(
	
	SELECT cp.Prerequisite_id
	FROM course_prerequisite as cp
	WHERE cp.course_id = 20 #course_id is a PHP dropdown on site
)
GROUP BY StudentFullName;

#5a
SELECT CONCAT(s.Fname, ' ', s.Lname, ' ', s.student_id) as StudentName, c.course_num as CourseName, ssg.grade as GradeReceived, sm.start_date as ClassStartDate
FROM student as s, course as c, section as sx, grade as g, course_section_semester_people_room as csspr, section_student_grade as ssg, semester as sm
WHERE csspr.course_id = c.course_id AND csspr.section_num = sx.section_num AND sm.sem_id = csspr.sem_id AND c.course_id = sx.course_id 
AND sx.section_num = ssg.section_num AND g.gLetter = ssg.grade AND ssg.student_id = s.student_id AND s.student_id = 7 #student_id is a PHP dropdown on site
ORDER BY sm.start_date;

#7a
SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentFullname, m.name as Major
FROM student as s, major as m, student_major as sm, people as p, semester 
WHERE s.student_id = sm.student_id AND m.major_id = sm.major_id AND p.emp_id = s.advisor_id AND p.emp_id = 3 #emp_id is a PHP dropdown on site
ORDER BY Major, StudentFullName;

#9a
SELECT m.name as Major, d.name as Department, m.hours_to_grad as CreditsToGraduate
FROM major as m, department as d
WHERE m.dept_id = d.dept_id 
ORDER BY d.dept_id, m.name;


#B LEVEL QUERIES:

#1b
(SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentNames, ssg.grade as GradeReceived, g.gpaValue as gpaEarned
FROM student as s, section_student_grade as sx, section_student_grade as ssg, grade as g
WHERE sx.student_id = s.student_id AND sx.section_num = ssg.section_num AND ssg.grade = g.gLetter AND s.student_id = ssg.student_id AND sx.section_num = 1
ORDER BY s.Lname, s.Fname)
UNION
(SELECT '' as StudentNames, '' as GradeReceived, CONCAT('Average GPA: ', AVG(g.gpaValue)) as gpaEarned
FROM student as s, section_student_grade as sx, section_student_grade as ssg, grade as g
WHERE sx.student_id = s.student_id AND sx.section_num = ssg.section_num AND ssg.grade = g.gLetter AND s.student_id = ssg.student_id AND sx.section_num = 1
);

#3b
SELECT CONCAT(p.Fname, ' ', p.Lname, ' ', p.emp_id) as EmployeeFullName, p.phone as PhoneNumber, pe.email_address as Email, p.rank as EmployeePosition
FROM people as p, people_email as pe
WHERE p.emp_id = pe.emp_id AND pe.type = 'work' AND p.rank != 'Advisor' AND p.emp_id NOT IN(
SELECT p.emp_id
FROM people as p, course_section_semester_people_room as csspr, course as c
WHERE c.course_id = csspr.course_id AND p.emp_id = csspr.emp_id AND c.course_id = 1 #course_id is a PHP dropdown on site
ORDER BY p.emp_id
)
ORDER BY EmployeeFullName;

#5b
(SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentName, c.course_num as CourseName, ssg.grade as GradeReceived, g.gpaValue as GPAReceived, c.credit_hours as CourseCredit, sm.start_date as ClassStartDate
FROM student as s, course as c, section as sx, grade as g, course_section_semester_people_room as csspr, section_student_grade as ssg, semester as sm
WHERE csspr.course_id = c.course_id AND csspr.section_num = sx.section_num AND sm.sem_id = csspr.sem_id AND c.course_id = sx.course_id 
AND sx.section_num = ssg.section_num AND g.gLetter = ssg.grade AND ssg.student_id = s.student_id AND s.student_id = 11 #student_id is a PHP dropdown on site
ORDER BY ClassStartDate)
UNION ALL
(SELECT 'Totals' as StudentName, '' as CourseName, '' as GradeReceived, AVG(g.gpaValue) as GradeReceived, SUM(c.credit_hours) as CourseCredit, '' as ClassStartDate
FROM student as s, course as c, section as sx, grade as g, course_section_semester_people_room as csspr, section_student_grade as ssg, semester as sm
WHERE csspr.course_id = c.course_id AND csspr.section_num = sx.section_num AND sm.sem_id = csspr.sem_id AND c.course_id = sx.course_id 
AND sx.section_num = ssg.section_num AND g.gLetter = ssg.grade AND ssg.student_id = s.student_id AND s.student_id = 11); #student_id is a PHP dropdown on site

#8b
SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentFullName, CONCAT(s.p_Fname, ' ', s.p_Lname) as ParentFullName, s.p_phone as ParentPhoneNumber
FROM student as s
WHERE s.student_id NOT IN(
SELECT s.student_id
FROM student as s, section_student_grade as ssg, course_section_semester_people_room as csspr, semester as sm
WHERE ssg.student_id = s.student_id AND ssg.section_num = csspr.section_num AND sm.sem_id = csspr.sem_id AND (sm.sem_id = 4 OR sm.sem_id = 3)
GROUP BY s.student_id
)
ORDER BY StudentFullName;


#C LEVEL QUERIES:

#5c
(SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentName, c.course_num as CourseName, ssg.grade as GradeReceived, g.gpaValue as GPAReceived, c.credit_hours as CourseCredit, sm.start_date as ClassStartDate
FROM student as s, course as c, section as sx, grade as g, course_section_semester_people_room as csspr, section_student_grade as ssg, semester as sm
WHERE csspr.course_id = c.course_id AND csspr.section_num = sx.section_num AND sm.sem_id = csspr.sem_id AND c.course_id = sx.course_id 
AND sx.section_num = ssg.section_num AND g.gLetter = ssg.grade AND ssg.student_id = s.student_id AND s.student_id = 11 #student_id is a PHP dropdown on site
ORDER BY ClassStartDate)
UNION ALL
(SELECT '' as StudentName, '' as CourseName, '' as GradeReceived, CONCAT('Cumulative GPA: ', AVG(g.gpaValue)) as GradeReceived, CONCAT('Earned Credit Hours: ', SUM(case when ssg.grade != 'F' then c.credit_hours else null end)) as CourseCredit, '' as ClassStartDate
FROM student as s, course as c, section as sx, grade as g, course_section_semester_people_room as csspr, section_student_grade as ssg, semester as sm
WHERE csspr.course_id = c.course_id AND csspr.section_num = sx.section_num AND sm.sem_id = csspr.sem_id AND c.course_id = sx.course_id 
AND sx.section_num = ssg.section_num AND g.gLetter = ssg.grade AND ssg.student_id = s.student_id AND s.student_id = 11); #student_id is a PHP dropdown on site

#9c
SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentName, AVG(g.gpaValue) as GPA, SUM(c.credit_hours) as CreditHours, m.name as StudentMajor
FROM student as s, course as c, section as sx, grade as g, course_section_semester_people_room as csspr, section_student_grade as ssg, semester as sm, student_major as sma, major as m
WHERE csspr.course_id = c.course_id AND csspr.section_num = sx.section_num AND sm.sem_id = csspr.sem_id AND c.course_id = sx.course_id
 AND sx.section_num = ssg.section_num AND g.gLetter = ssg.grade AND ssg.student_id = s.student_id AND s.student_id = sma.student_id AND sma.major_id = m.major_id
GROUP BY s.student_id
HAVING(GPA > 2.75 AND CreditHours > 20)
ORDER BY m.major_id, StudentName;

#Additional 1
SELECT CONCAT(p.Fname, ' ', p.Lname) as EmployeeFullName, p.phone as PhoneNumber, pe.email_address as Email, p.rank as EmployeePosition
FROM people as p, people_email as pe
WHERE pe.emp_id = p.emp_id AND pe.type = "work" AND p.rank = "Assistant Professor"
ORDER BY EmployeeFullName;


#Additional 2
SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentName, AVG(g.gpaValue) as GPA, CONCAT(p.Fname, ' ', p.Lname) as AdvisorName, pex.area_expert as AdvisorExpertise, pe.email_address as Email
FROM student as s, grade as g, section_student_grade as ssg, people as p, people_expertise as pex, people_email as pe
WHERE s.student_id = ssg.student_id AND ssg.grade = g.gLetter AND s.advisor_id = p.emp_id AND p.emp_id = pex.emp_id AND pe.emp_id = p.emp_id AND pe.type = 'work'
GROUP BY s.student_id
HAVING(GPA < 2.75)
ORDER BY p.emp_id;



#CREATE STATEMETNS FOR FINAL:

CREATE TABLE building (
build_id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(50),
addr_street VARCHAR(50),
addr_city VARCHAR(50),
addr_state VARCHAR(2),
addr_zip VARCHAR(10),
PRIMARY KEY (build_id)
)
ENGINE=INNODB;

CREATE TABLE room (
room_id INT AUTO_INCREMENT NOT NULL,
type VARCHAR(50),
capacity INT,
build_id INT,
PRIMARY KEY (room_id),
FOREIGN KEY (build_id) REFERENCES building(build_id)
)
ENGINE=INNODB;

CREATE TABLE people (
emp_id INT AUTO_INCREMENT NOT NULL,
Fname VARCHAR(50),
Lname VARCHAR(50),
hire_date DATE,
rank VARCHAR(50),
phone VARCHAR(50),
office_num INT,
PRIMARY KEY (emp_id),
FOREIGN KEY (office_num) REFERENCES room(room_id)
)
ENGINE=INNODB;


CREATE TABLE student (
student_id INT AUTO_INCREMENT NOT NULL,
Fname VARCHAR(50),
Lname VARCHAR(50),
addr_street VARCHAR(100),
addr_city VARCHAR(100),
addr_state VARCHAR(2),
addr_zip VARCHAR(10),
p_Fname VARCHAR(50),
p_Lname VARCHAR(50),
p_phone VARCHAR(50),
advisor_id INT,
PRIMARY KEY (student_id),
FOREIGN KEY (advisor_id) REFERENCES people(emp_id)
)
ENGINE=INNODB;

CREATE TABLE course (
course_id INT AUTO_INCREMENT NOT NULL,
course_num VARCHAR(10) NOT NULL,
title VARCHAR(50),
credit_hours INT,
subject VARCHAR(50),
PRIMARY KEY (course_id)
)
ENGINE=INNODB;

CREATE TABLE grade (
gLetter VARCHAR(2),
gpaValue DECIMAL(3,2),
PRIMARY KEY (gLetter)
)
ENGINE=INNODB;

CREATE TABLE department (
dept_id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(50),
dept_chair_id INT,
PRIMARY KEY (dept_id),
FOREIGN KEY (dept_chair_id) references people(emp_id)
)
ENGINE=INNODB;

CREATE TABLE major (
major_id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(50),
dept_id INT,
hours_to_grad INT,
gpa_to_grad DECIMAL(3,2),
PRIMARY KEY (major_id),
FOREIGN KEY (dept_id) references department(dept_id)
)
ENGINE=INNODB;

CREATE TABLE section (
section_num INT AUTO_INCREMENT NOT NULL,
start_time TIME,
end_time TIME,
days VARCHAR(50),
course_id INT,
PRIMARY KEY (section_num),
FOREIGN KEY (course_id) references course(course_id)
)
ENGINE=INNODB;

CREATE TABLE semester (
sem_id INT AUTO_INCREMENT NOT NULL,
title VARCHAR(50),
start_date DATE,
end_date DATE,
PRIMARY KEY (sem_id)
)
ENGINE=INNODB;

CREATE TABLE student_phone (
student_id INT,
type VARCHAR(50),
number VARCHAR(50),
FOREIGN KEY (student_id) REFERENCES student(student_id)
)
ENGINE=INNODB;

CREATE TABLE student_email (
student_id INT,
type VARCHAR(50),
email_address VARCHAR(50),
FOREIGN KEY (student_id) REFERENCES student(student_id)
)
ENGINE=INNODB;

CREATE TABLE student_major (
student_id INT,
major_id INT,
FOREIGN KEY (student_id) REFERENCES student(student_id),
FOREIGN KEY (major_id) REFERENCES major(major_id)
)
ENGINE=INNODB;

CREATE TABLE section_student_grade(
section_num INT,
student_id INT,
grade VARCHAR(2),
FOREIGN KEY (section_num) REFERENCES section(section_num),
FOREIGN KEY (student_id) REFERENCES student(student_id),
FOREIGN KEY (grade) REFERENCES grade(gLetter)
)
ENGINE=INNODB;

CREATE TABLE people_email (
emp_id INT,
type VARCHAR(50),
email_address VARCHAR(50),
FOREIGN KEY (emp_id) REFERENCES people(emp_id)
)
ENGINE=INNODB;

CREATE TABLE people_expertise (
emp_id INT,
area_expert VARCHAR(50),
FOREIGN KEY (emp_id) REFERENCES people(emp_id)
)
ENGINE=INNODB;

CREATE TABLE room_feature (
room_id INT,
feature VARCHAR(50),
FOREIGN KEY (room_id) REFERENCES room(room_id)
)
ENGINE=INNODB;

CREATE TABLE department_faculty (
dept_id INT,
faculty_id INT,
FOREIGN KEY (dept_id) REFERENCES department(dept_id),
FOREIGN KEY (faculty_id) REFERENCES people(emp_id)
)
ENGINE=INNODB;

CREATE TABLE course_section_semester_people_room (
course_id INT, 
section_num INT,
sem_id INT,
emp_id INT,
room_id INT,
FOREIGN KEY (course_id) REFERENCES course(course_id),
FOREIGN KEY (section_num) REFERENCES section(section_num),
FOREIGN KEY (sem_id) REFERENCES semester(sem_id),
FOREIGN KEY (emp_id) REFERENCES people(emp_id),
FOREIGN KEY (room_id) REFERENCES room(room_id)
)
ENGINE=INNODB;

CREATE TABLE course_prerequisite(
course_id INT,
Prerequisite_id INT,
FOREIGN KEY (course_id) REFERENCES course(course_id),
FOREIGN KEY (prerequisite_id) REFERENCES course(course_id)
)
ENGINE=INNODB;



#INSERT STATEMENTS FOR FINAL:

INSERT INTO building(build_id, name, addr_street, addr_city, addr_state, addr_zip)
VALUES(01, 'Hodge Hall', '10th Street', 'Bloomington', 'IN', 47406),
(02, 'Luddy Hall', '17th Street', 'Bloomington', 'IN', 47406),
(03, 'Jacobs Hall', 'Jordan Ave', 'Bloomington', 'IN', 47406),
(04, 'Wells', '3rd Street', 'Bloomington', 'IN', 47406);

INSERT INTO room(room_id, type, capacity, build_id)
VALUES(01, 'classroom', 140, 01),
(02,'classroom',70, 02),
(03, 'classroom', 80, 03),
(04, 'classroom', 100, 04),
(05, 'classroom', 140, 02),
(06, 'classroom', 55, 01),
(07, 'classroom', 40, 04),
(08, 'classroom', 60, 03),
(09, 'office', 15, 01),
(10, 'office', 10, 02),
(11, 'office', 30, 03),
(12, 'office', 12, 04),
(13, 'office', 15, 02),
(14, 'office', 14, 03),
(15, 'office', 40, 01),
(16, 'office', 15, 04),
(17, 'office', 12, 03),
(18, 'office', 20, 02),
(19, 'office', 5, 01), 
(20, 'office', 5, 01),
(21, 'office', 5, 03),
(22, 'office', 5, 04),
(23, 'office', 5, 02);

INSERT INTO people(emp_id, Fname, Lname, hire_date, rank, phone, office_num)
VALUES(01, 'Wake', 'McDoual', '1981-02-04', 'Advisor', '619-467-3442', 09),
(02, 'Ninetta', 'Ortega', '2019-10-03', 'Advisor', '436-921-5810', 10),
(03, 'Suzi', 'Bubb', '2000-08-27', 'Advisor', '939-271-5755', 11),
(04, 'Rubin', 'Shearsby', '1983-07-07', 'Advisor', '335-569-6447', 12),
(05, 'Franz', 'Bidder', '1981-06-29', 'Advisor', '286-995-0602', 13),
(06, 'Katerine', 'Wolfe', '2007-02-07', 'Adjunct Professor', '857-156-3560', 14),
(07, 'Vincents', 'Pinke', '1984-09-11', 'Adjunct Professor', '552-384-6377', 15),
(08, 'Federico', 'Uppett', '1997-06-29', 'Assistant Professor', '732-499-9396', 16),
(09, 'Melisandra', 'Dabinett', '2003-08-16', 'Adjunct Professor', '628-592-3705', 17),
(10, 'Aland', 'Kimbrey', '2015-11-0', 'Assistant Professor' , '600-343-0063', 18),
(11, 'Aaron', 'Lutas', '2005-09-27', 'Associate Professor', '304-840-1285', 19),
(12, 'Karissa', 'Fosberry', '1984-07-14', 'Associate Professor', '490-626-1991', 20), 
(13, 'Elspeth', 'Capponeer', '1991-11-13', 'Assistant Professor', '899-459-4395', 21),
(14, 'Fredi', 'Burn', '1987-11-22', 'Adjunct Professor', '720-392-7893', 22),
(15, 'Briana', 'Lotze', '1989-12-17', 'Assistant Professor', '634-206-9107', 23);

INSERT INTO student(student_id, Fname, Lname, addr_street, addr_city, addr_state, addr_zip, p_Fname, p_Lname, p_phone, advisor_id)
VALUES(01, 'James', 'Smith', '99 Sundown Junction', 'Salt Lake City', 'Utah', '84140', 'Cloe', 'Disle', '801-770-3072', 01),
(02, 'Jane', 'Doe', '26016 Maywood Avenue', 'Lansing', 'Michigan', '48919', 'Tann', 'Burndred', '517-817-1520', 01),
(03, 'John', 'Smith', '34 Straubel Lane', 'Pittsburgh', 'PA', '85021', 'Kassie', 'Cragell', '202-537-8954', 01),
(04, 'David', 'Crane', '771 Loeprich Plaza','Chattanooga','TN', '74920', 'Beckie', 'Goldsmith', '423-695-2952', 02),
(05, 'Jame', 'Smith', '5 Pearson Street', 'Terre Haute', 'IN', '59214', 'Willa', 'Dodimead', '812-156-1612', 02),
(06, 'Donell', 'White', '4316 Coolidge Plaza', 'Chattanooga','TN', '43921', 'Elvyn', 'Hows', '423-870-0711', 02),
(07, 'Zack', 'Pedersen', '605 Johnson Junction', 'Portland', 'OR', '65829', 'Candida', 'Madoc-Jones', '503-557-4657', 03),
(08, 'Josh', 'Endersen', '18085 Buena Vista Drive', 'Bellevue', 'WA', '38950', 'Giana', 'Conti', '425-752-7855', 03),
(09, 'Eli', 'Manning', '9585 Northland Avenue', 'Houston', 'TX', '28194', 'Carlie', 'Hurling', '713-451-4851', 03),
(10, 'Mack', 'Morrison', '0865 Dovetail Court', 'Virginia Beach', 'VA', '57392', 'Benetta', 'Clear', '757-870-7095', 04),
(11, 'Trisha', 'Sampson', '15 Grover Center', 'Phoenix', 'AZ', '65839', 'Meridith', 'Lavis', '602-394-8304', 04),
(12, 'Josh', 'Pak', '15 Scofield Hill', 'Whittier', 'CA', '47382', 'Hinze', 'Reynolds', '626-663-7691', 04),
(13, 'Chris', 'Pratt', '412 School Point', 'Boston', 'MA', '46338',  'Sile', 'Gawkroger', '617-541-4131', 05),
(14, 'Aaliyah', 'Pemberton', '7 Esker Drive', 'Springfield', 'MA', '84920',  'Maynord', 'Stanman', '413-229-3729', 05),
(15, 'Lauren', 'Stratton', '36108 Mandrake Center', 'Tampa', 'FL', '93939',  'Weber', 'Bavridge', '813-639-5850', 05);

INSERT INTO course(course_id, course_num, title, credit_hours, subject)
VALUES(01, 'INFO-I 101', 'Intro to Informatics', 3, 'INFO-I'),
(02, 'CJUS-K 300', 'Topics in Informatics', 4, 'CJUS-K'),
(03, 'INFO-I 130', 'Intro to Cybersecurity', 3, 'INFO-I'),
(04, 'INFO-I 210', 'Intro to Infrastructure', 3, 'INFO-I'),
(05, 'INFO-I 211', 'Intro to Infrastructure II', 2, 'INFO-I'),
(06, 'INFO-I 202', 'Social Informatics', 3, 'INFO-I'),
(07, 'INFO-Y 395', 'Career Development for Info Majors', 1, 'INFO-Y'),
(08, 'SPH-I 187', 'Weight Training', 1, 'SPH-I'),
(09, 'INFO-I 230', 'Analytical Foundations of Informatics', 3, 'INFO-I'),
(10, 'INFO-I 201', 'Math Foundations of Informatics', 4, 'INFO-I'),
(11, 'SPEA-V 369', 'Managing Information Technology', 2, 'SPEA-V'),
(12, 'CSCI-C 291', 'Systems Programming with C and Linux', 5, 'CSCI-C'),
(13, 'MUS-A 100', 'Foundation of Audio Technology', 3, 'MUS-A'),
(14, 'MSCH-C 101', 'Intro to Media', 3, 'MSCH-C'),
(15, 'INFO-I 300', 'HCI/Interaction and Design', 4, 'INFO-I'),
(16, 'INFO-I 342', 'Mobile Programming', 4, 'INFO-I'),
(17, 'INFO-I 360', 'Web Design', 5, 'INFO-I'),
(18, 'INFO-Y 102', 'Tech Leadership and Innovation', 1, 'INFO-Y'),
(19, 'INFO-I 453', 'Computer and Information Ethics', 3, 'INFO-I'),
(20, 'SPH-I 190', 'Yoga', 3, 'SPH-I');

INSERT INTO grade( gLetter, gpaValue)
VALUES('A', 4.00),
('A-', 3.67),
('B+', 3.33),
('B', 3.00),
('B-', 2.67),
('C+', 2.33),
('C', 2.00),
('C-', 1.67),
('D+', 1.33),
('D', 1.00),
('D-', 0.67),
('F', 0);

INSERT INTO department(dept_id, name, dept_chair_id)
VALUES(01, 'School of Informatics Computer Science and Engineering', 06),
(02, 'Kelley School of Business', 07),
(03, 'School of Public and Environmental Affairs', 08);

INSERT INTO major(major_id, name, dept_id, hours_to_grad, gpa_to_grad)
VALUES(01, 'Informatics', 01, 23, 3.0),
(02, 'Business', 02, 20, 2.5),
(03, 'Computer Science', 01, 25, 3.2),
(04, 'Environmental Technology', 03,  21, 3.0);

INSERT INTO section( section_num, start_time, end_time, days, course_id)
VALUES(01, '09:00:00', '11:00:00', 'MW', 1),
(02, '12:00:00', '14:00:00', 'TR', 1),
(03, '08:00:00', '10:00:00', 'TR', 1),
(04, '16:00:00', '17:30:00', 'MWF', 2),
(05, '08:00:00', '10:15:00', 'TR', 2),
(06, '09:00:00', '13:00:00', 'F', 3),
(07, '12:00:00', '13:00:00', 'MWF', 3),
(08, '14:00:00', '16:00:00', 'MW', 4), 
(09, '16:00:00', '18:00:00', 'MW', 4),
(10, '18:00:00', '20:00:00', 'MW', 4),
(11, '14:00:00', '15:00:00', 'F', 5),
(12, '15:00:00', '16:00:00', 'T', 5),
(13, '12:00:00', '12:30:00', 'TR', 5),
(14, '08:00:00', '11:00:00', 'F', 6),
(15, '08:00:00', '09:00:00', 'MWF', 6),
(16, '10:00:00', '11:30:00', 'TR', 7), 
(17, '12:00:00', '13:00:00', 'MWF', 7),
(18, '13:00:00', '14:30:00', 'TR', 7),
(19, '11:00:00', '12:00:00', 'T', 8),
(20, '15:00:00', '16:00:00', 'F', 8),
(21, '08:00:00', '09:00:00', 'F', 9), 
(22, '16:00:00', '18:00:00', 'R', 9), 
(23, '10:00:00', '11:00:00', 'TR', 10),
(24, '11:00:00', '12:00:00', 'TR', 10),
(25, '12:00:00', '13:00:00', 'TR', 10),
(26, '18:00:00', '19:00:00', 'M', 11),
(27, '18:00:00', '19:00:00', 'W', 11),
(28, '18:00:00', '19:00:00', 'F', 11),
(29, '11:00:00', '12:30:00', 'M', 12),
(30, '12:45:00', '14:15:00', 'M', 12),
(31, '14:30:00', '16:00:00', 'M', 12),
(32, '13:00:00', '16:00:00', 'TR', 13),
(33, '13:00:00', '16:00:00', 'MW', 13),
(34, '08:15:00', '09:15:00', 'MTRF', 14),
(35, '12:00:00', '14:00:00', 'TR', 14),
(36, '13:00:00', '13:50:00', 'WTR', 15),
(37, '14:00:00', '14:50:00', 'WTR', 15),
(38, '15:00:00', '15:50:00', 'WT', 15),
(39, '10:30:00', '12:30:00', 'TR', 16),
(40, '10:30:00', '12:30:00', 'TR', 16),
(41, '08:00:00', '09:15:00', 'T', 17),
(42, '09:30:00', '10:45:00', 'T', 17),
(43, '12:00:00', '14:30:00', 'TR', 18),
(44, '12:00:00', '14:30:00', 'TR', 18),
(45, '13:25:00', '14:55:00', 'MT', 19),
(46, '13:25:00', '14:55:00', 'MW', 19),
(47, '13:25:00', '14:55:00', 'MTR', 19),
(48, '16:00:00', '17:30:00', 'MWF', 20),
(49, '12:00:00', '13:30:00', 'MWF', 20);

INSERT INTO semester(sem_id, title, start_date, end_date)
VALUES(01, 'Fall 2018', '2018-09-01', '2018-12-16'),
(02, 'Spring 2019', '2019-01-07','2019-05-07'),
(03, 'Fall 2019', '2019-09-03','2019-12-18'),
(04, 'Spring 2020', '2020-01-10', '2020-05-10');

INSERT INTO student_major( student_id, major_id)
VALUES( 01, 01),
(01, 04),
(02,02),
(02, 01),
(03, 03),
(03, 02),
(04,04),
(04, 03),
(05, 04),
(05, 01),
(05, 03),
(06, 02),
(07, 03),
(08, 04),
(09, 01),
(10, 02),
(11, 03),
(12, 04),
(13, 01),
(14, 02),
(15, 03);

INSERT INTO department_faculty(dept_id, faculty_id)
VALUES(1, 6),
(2, 7),
(3, 8),
(1, 1),
(1, 2), 
(1, 3), 
(1, 4), 
(2, 5), 
(2, 9), 
(2, 10), 
(2, 11), 
(3, 12), 
(3, 13), 
(3, 14), 
(3, 15);

INSERT INTO course_prerequisite(course_id, Prerequisite_id)
VALUES(10, 1),
(6, 1),
(4, 1),
(5, 1),
(5, 4), 
(17, 15),
(17, 14),
(16, 15),
(20, 8);

INSERT INTO course_section_semester_people_room(course_id, section_num, sem_id, emp_id, room_id)
VALUES(01, 01, 01, 06, 01),
(04, 08, 01, 06, 01),
(15, 36, 01, 07, 02),
(16, 39, 01, 07, 02),
(08, 19, 01, 08, 03),
(02, 04, 01, 08, 03),
(03, 06, 01, 09, 04),
(05, 11, 01, 10, 05),
(06, 14, 01, 11, 06),
(07, 16, 01, 12, 07),
(09, 21, 01, 13, 08),
(10, 23, 01, 14, 01), 
(01, 02, 02, 15, 01),
(04, 09, 02, 15, 01),
(08, 20, 02, 15, 01),
(15, 37, 02, 14, 02),
(16, 40, 02, 14, 02),
(11, 26, 02, 13, 03),
(12, 29, 02, 13, 03),
(13, 32, 02, 12, 04),
(14, 34, 02, 11, 05),
(17, 41, 02, 10, 06),
(18, 43, 02, 09, 07),
(19, 45, 02, 08, 08),
(01, 03, 03, 07, 01),
(04, 10, 03, 07, 01),
(15, 38, 03, 10, 02),
(20, 48, 03, 10, 02),
(02, 05, 03, 09, 03),
(03, 07, 03, 09, 03),
(05, 12, 03, 11, 04),
(06, 15, 03, 12, 05),
(07, 17, 03, 13, 06),
(09, 22, 03, 14, 07),
(10, 24, 03, 11, 08),
(11, 27, 03, 11, 08),
(12, 30, 04, 06, 01),
(13, 33, 04, 09, 05),
(14, 35, 04, 07, 02),
(17, 42, 04, 07, 02),
(18, 44, 04, 08, 03),
(19, 46, 04, 08, 03),
(20, 49, 04, 14, 04),
(05, 13, 04, 14, 04),
(07, 18, 04, 13, 06),
(10, 25, 04, 12, 01),
(11, 28, 04, 11, 07),
(12, 31, 04, 10, 08),
(19, 47, 04, 11, 07);




INSERT INTO section_student_grade(section_num, student_id, grade)
VALUES(01, 01, 'A'),
(01, 02, 'C'),
(01, 03, 'A'),
(01, 04, 'A'),
(02, 05, 'D+'),
(02, 06, 'B+'),
(02, 07, 'B'),
(02, 08, 'A'),
(03, 09, 'A'),
(03, 10, 'B-'),
(03, 11, 'B+'),
(03, 12, 'C+'),
(04, 02, 'B-'),
(04, 13, 'C+'),
(04, 03, 'D'),
(04, 05, 'F'),
(05, 11, 'B'),
(05, 3, 'B+'),
(05, 01, 'B'),
(05, 06, 'B'),
(06, 12, 'A'),
(06, 10, 'D'),
(06, 06, 'B+'),
(06, 07, 'B'),
(07, 01, 'A'),
(07, 02, 'B'),
(07, 05, 'C'),
(07, 12, 'D'),
(08, 01, 'B+'),
(08, 04, 'B'),
(08, 07, 'A'),
(08, 10, 'A'),
(09, 11,'A'),
(09, 12, 'A'),
(09, 09, 'B'),
(09, 06, 'B-'),
(10, 05, 'C+'),
(10, 5, 'B'),
(10, 4, 'C'),
(11, 01, 'B'),
(11, 07, 'A-'),
(11, 10, 'B'),
(12, 01, 'A'),
(12, 04, 'C'),
(12, 11, 'B'),
(13, 05, 'C'),
(13, 06, 'A'),
(14, 05, 'C'),
(14, 08, 'B+'),
(14, 12, 'B-'),
(15, 04, 'F'),
(15, 13, 'C'),
(15, 01, 'A'),
(16, 01, 'F'),
(16, 02, 'B+'),
(16, 03, 'D+'),
(17, 07, 'B+'),
(17, 09, 'C-'),
(17, 10, 'F'),
(18, 11, 'B-'),
(18, 12, 'D-'),
(18, 13, 'A-'),
(19, 07, 'A'),
(19, 15, 'B'),
(19, 01, 'A-'),
(20, 03, 'C'),
(20, 04, 'B-'),
(20, 05, 'F'),
(21, 01, 'A'),
(21, 02, 'C+'),
(21, 05, 'C-'),
(22, 06, 'D+'),
(22, 07, 'B'),
(22, 08, 'A-'),
(22, 09, 'D+'),
(23, 03, 'B+'),
(23, 04, 'B-'),
(23, 05, 'D'),
(24, 06, 'B'),
(24, 11, 'A'),
(24, 10, 'B-'),
(25, 12, 'C+'),
(25, 09,'B-'),
(25, 08, 'A'),
(26, 03, 'A-'),
(26, 10, 'A'),
(26, 01, 'B+'),
(27, NULL, NULL),
(27, NULL, NULL),
(27, NULL, NULL),
(28, 02, 'C'),
(28, 03, 'B-'),
(28, 04, 'C+'),
(29, 02, 'C+'),
(29, 13, 'A'),
(29, 14, 'B-'),
(30, NULL, NULL),
(30, NULL, NULL),
(30, NULL, NULL),
(31, 2, 'C+'),
(31, 08, 'D'),
(31, 09, 'B-'),
(32, 10, 'B'),
(32, 01, 'A-'),
(32, 02, 'C'),
(33, 03, 'D'),
(33, 04, 'F'),
(33, 05, 'D+'),
(34, NULL, NULL),
(34, NULL, NULL),
(34, NULL, NULL),
(35, 06, 'B+'),
(35, 07, 'A'),
(35, 08, 'C'),
(36, 14, 'A'),
(36, 15, 'B-'),
(36, 11, 'C'),
(37, 09, 'C'),
(37, 10, 'A'),
(37, 12, 'B+'),
(38, 05, 'C-'),
(38, 04, 'B'),
(38, 02, 'A'),
(39, 14, 'B+'),
(39, 09, 'A'),
(39, 10, 'B+'),
(40, 15, 'C-'),
(40, 11, 'F'),
(40, 02, 'C'),
(41, NULL, NULL),
(41, NULL, NULL),
(41, NULL, NULL),
(42, 06, 'A'),
(42, 07, 'B+'),
(42, 08, 'D-'),
(43, NULL, NULL),
(43, NULL, NULL),
(43, NULL, NULL),
(44, 01, 'A-'),
(44, 02, 'B-'),
(44, 03, 'C'),
(45, 10, 'A'),
(45, 08, 'C'),
(45, 09, 'A-'),
(46, NULL, NULL),
(46, NULL, NULL),
(46, NULL, NULL),
(47, 06, 'B+'),
(47, 07, 'B'),
(47, 11, 'C-'),
(48, 9, 'B-'),
(48, 01, 'A-'),
(48, 03, 'B'),
(49, 04, 'C+'),
(49, 05, 'B-'),
(49, 07, 'B');

 
INSERT INTO student_phone(student_id, type, number)
VALUES(01, 'cell phone','857-345-8578'),
(02, 'cell phone', '567-867-0945'),
(03, 'home phone', '456-143-7435'),
(04, 'cell phone', '585-845-9847'),
(05, 'home phone', '456-986-1038'),
(06, 'cell phone', '567-903-2367'),
(07, 'cell phone', '444-867-9038'),
(08, 'cell phone', '858-903-7345'),
(09, 'cell phone', '452-836-9427'),
(10, 'home phone', '930-759-9376'),
(11, 'cell phone', '937-717-0189'),
(12, 'cell phone', '840-759-0940'),
(13, 'home phone', '467-937-9840'),
(14, 'cell phone', '826-618-2039'),
(15, 'cell phone', '927-480-1048');



INSERT INTO student_email(student_id, type, email_address)
VALUES(01, 'school', 'JamesSmith44@iu.edu'),
(02, 'personal', 'DoeJane82@gmail.com'),
(03, 'personal', 'johnTsmith$3@yahoo.com'),
(04, 'school', 'bigcrane96@iu.edu'),
(05, 'personal', 'jamiesmith29@hotmail.com'),
(06, 'school', 'donnelwhite492@iu.edu'),
(07, 'personal', 'zackpedo@gmail.com'),
(08, 'personal', 'liljosh123@yahoo.com'),
(09, 'personal', 'gunslinger10@hotmail.com'),
(10, 'school', 'mackmorr122@iu.edu'),
(11, 'personal', 'sampsontrish@yahoo.com'),
(12, 'personal', 'joshpak33@gmail.com'),
(13, 'school', 'prattchris@iu.edu'),
(14, 'personal', 'princessali91@yahoo.com'),
(15, 'school', 'laurenstratton@iu.edu');

INSERT INTO people_email(emp_id, type, email_address)
VALUES(01, 'work', 'mcdoualwake@iu.edu'),
(02, 'work', 'orteganina@iu.edu'),
(03, 'work', 'susanbubb@iu.edu'),
(04, 'personal', 'rubinsherrb@gmail.com'),
(04, 'work', 'rubinsherrb@iu.edu'),
(05, 'work', 'franzbidder@iu.edu'),
(06, 'work', 'wolfekaterine@iu.edu'),
(07, 'work', 'pinkevincent@iu.edu'),
(08, 'personal', 'uppettefred39@gmail.com'),
(08, 'work', 'uppettefred39@iu.edu'),
(09, 'work', 'dabinetmelis@iu.edu'),
(10, 'work', 'kimbreyalan@iu.edu'),
(11, 'work', 'araonlut@iu.edu'),
(12, 'personal', 'fosberryk19@yahoo.com'),
(12, 'work', 'fosberryk19@iu.edu'),
(13, 'work', 'elspethcapon@iu.edu'),
(14, 'work', 'burnfredi12@iu.edu'),
(15, 'work', 'brianalots@iu.edu');


INSERT INTO people_expertise(emp_id, area_expert)
VALUES(01, 'Cover Letters'),
(01, 'Interview Prep'),
(02, 'Career Search'),
(03, 'Tech Interview Prep'),
(03, 'Course Scheduling'),
(04, 'Resume Builder'),
(04, 'Contract Negotiations'),
(05, 'Capstone'),
(05, 'Interview prep'),
(05, 'Course Scheduling');

INSERT INTO room_feature(room_id, feature)
VALUES(01, 'Projector'),
(02, 'Computer Lab'),
(03, 'Smart Board'),
(04, 'White Board'),
(05, 'White Board'),
(06, 'Projector'),
(07, 'Smart Board'),
(08, 'Projector'),
(09, 'Smart Board'),
(10, 'Lecture Hall'),
(11, 'Computer Lab'),
(12, 'Lecture Hall'),
(13, 'Computer Lab'),
(14, 'Projector'),
(15, 'Makerspace');











