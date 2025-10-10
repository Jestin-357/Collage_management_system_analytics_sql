show DATABASES;
use project;

show tables;

drop table courses;

# creating the  tables
create table  courses (
    course_id INT,
    course_name varchar(36),
    Instructor_id int,
    Credits int);

INSERT INTO courses VALUES
(101, 'Data Structures', 1, 3),
(102, 'Linear Algebra', 2, 4),
(103, 'Quantum Mechanics', 3, 3),
(104, 'Operating Systems', 1, 3),
(105, 'Organic Chemistry', 2, 4),
(106, 'Artificial Intelligence', 1, 4),
(107, 'Calculus', 2, 3),
(108, 'Astrophysics', 3, 3);


create table enrollments (
    enrollment_id INT,
    student_id INT,
    course_id INT,
    EnrollmentDate DATE,
    grade CHAR(2));

INSERT INTO enrollments VALUES
(1, 1, 103, '2023-01-29', 'A'),
(2, 1, 105, '2022-12-31', 'F'),
(3, 2, 103, '2022-01-09', 'A'),
(4, 2, 102, '2021-10-28', 'A'),
(5, 3, 103, '2023-02-28', 'C'),
(6, 3, 102, '2023-04-10', 'B'),
(7, 3, 101, '2023-05-01', 'C'),
(8, 4, 105, '2021-10-07', 'C'),
(9, 4, 102, '2021-10-07', 'C'),
(10, 4, 104, '2021-10-08', 'D'),
(11, 5, 102, '2022-09-03', 'A'),
(12, 5, 101, '2022-08-26', 'B'),
(13, 5, 105, '2022-09-29', 'A'),
(14, 6, 102, '2020-11-25', 'D'),
(15, 6, 104, '2020-10-12', 'A'),
(16, 7, 105, '2022-01-25', 'C'),
(17, 7, 102, '2021-11-17', 'F'),
(18, 7, 103, '2021-10-18', 'B'),
(19, 8, 108, '2021-12-02', 'F'),
(20, 8, 102, '2021-08-30', 'C'),
(21, 9, 108, '2022-06-30', 'C'),
(22, 9, 102, '2022-05-07', 'F'),
(23, 10, 105, '2021-08-11', 'C'),
(24, 10, 106, '2021-08-20', 'F'),
(25, 10, 107, '2021-11-07', 'F'),
(26, 11, 107, '2022-04-14', 'A'),
(27, 11, 105, '2022-03-21', 'D'),
(28, 12, 108, '2021-03-12', 'D'),
(29, 12, 107, '2021-01-26', 'B'),
(30, 12, 102, '2021-05-31', 'F');

select * from enrollments;

create table  Faculty (
    faculty_id INT,
    first_name varchar(10),
    last_name varchar(16),
    department VARCHAR(20),
    email varchar(20),
    Salary int);

insert into Faculty values
(1,'Dr. Adams','Wilson','Computer Science','adams@example.com',80000),
(2,'Dr. White','Clark','Mathematics','white@example.com',75000),
(3,'Dr. Green','Brown','Physics','green@example.com',82000),
(4,'Dr.Blue','Black','Chemistry','blue@example.com',85000);


Create table students (
    studentid int,
    Name VARCHAR(20),
    Age int,
    Gender char(10),
    Major VARCHAR(20),
    Enrollmentdate date,
    Status_ char(13));
insert into students VALUES
(1, 'John Doe', 20, 'Male', 'Computer Science', '2022-08-15', 'Active'),
(2, 'Jane Smith', 21, 'Female', 'Mathematics', '2021-09-10', 'Graduated'),
(3, 'Emily Johnson', 19, 'Female', 'Physics', '2023-01-20', 'Active'),
(4, 'Michael Brown', 22, 'Male', 'Computer Science', '2021-06-14', 'Graduated'),
(5, 'Sarah Lee', 20, 'Female', 'Biology', '2022-07-19', 'Active'),
(6, 'William Turner', 23, 'Male', 'Chemistry', '2020-08-10', 'Graduated'),
(7, 'Olivia Carter', 22, 'Female', 'Psychology', '2021-09-05', 'Active'),
(8, 'James Anderson', 22, 'Male', 'Computer Science', '2021-07-10', 'Active'),
(9, 'Charlotte Davis', 20, 'Female', 'Chemistry', '2022-03-01', 'Active'),
(10, 'Benjamin Martinez', 21, 'Male', 'Biology', '2021-05-25', 'Graduated'),
(11, 'Amelia Wilson', 22, 'Female', 'Physics', '2021-11-30', 'Active'),
(12, 'Oliver Harris', 23, 'Male', 'Psychology', '2020-12-15', 'Graduated');

select * from students;
select * from courses;
select * from  enrollments;
select * from Faculty;


#1. Get the average grade for each student (considering A=4,B=3, C=2, D=1, F=0).

select s.studentid, 
    s.Name, 
    avg(
    case e.grade 
        when "A" then 4
        when 'B' then 3
        when 'c' then 2
        When 'D' then 1
        when 'F' then 0
        else NULL
    end
) as avg_grade
from students s
left join  enrollments e
on s.studentid = e.student_id
group by s.studentid,s.name;


#2. list all instructors who are teaching a course with fewer than 3 students enrolled.


select * from students;
select * from courses;
select * from  enrollments;
select * from Faculty;
select 
    f.faculty_id,
    f.first_name,
    f.last_name,
    c.course_id,
    c.course_name,
    count(e.student_id) as total_students
from Faculty f
join courses c       
on f.faculty_id = c.Instructor_id
left JOIN enrollments e
    on c.course_id  = e.course_id
group by 
     f.faculty_id,
    f.first_name,
    f.last_name,
    c.course_id,
    c.course_name
    having count(e.student_id) < 3;


#3. Find the total number of credits each student has earned, grouped by their major.


select * from courses;
select * from students;

SELECT  
    s.studentid,
    s.Name,
    s.major,
    SUM(c.credits) AS total_credits
FROM students s
LEFT JOIN enrollments e
    ON s.studentid = e.student_idå
LEFT JOIN courses c
    ON e.course_id = c.course_id
GROUP BY 
    s.studentid, 
    s.Name, 
    s.major
ORDER BY 
    s.studentid,
    s.major;


#4. Find the average salary of instructors in each department.

select * from `Faculty`;
Select department, avg(salary) as avg_salary
from `Faculty`
group by department;

#5. List all courses that are taught by more than one instructor . 

select * from courses;
SELECT 
    course_id,
    course_name,
    COUNT(DISTINCT instructor_id) AS total_instructors
FROM courses
GROUP BY 
    course_id, course_name
HAVING 
    COUNT(DISTINCT instructor_id) > 1;


#6. List the top 3 students with the highest number of credits earned.


select * from students;
select * from enrollments;

select s.studentid, s.NAME, sum(c.credits) as total_credits
from students s
left join enrollments e
on s.studentid = e.student_id
left join courses c
on e.course_id = c.course_id
group by s.studentid,s.name
order by  total_credits desc
limit 3;




