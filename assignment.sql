create database SISDB;
use SISDB;
create table students(student_id int primary key,f_name varchar(20),l_name varchar(20),dob date,email varchar(30),phn_num int);
desc students;
insert into students values(1,"Nicole","Wallace","2003-07-15","wallace@gmail.com",967603632);
insert into students values(2,"Elena","Gilbert","2002-07-25","elena@gmail.com",998212588);
insert into students values(3,"Damon","Salvatore","2000-11-17","damons@gmail.com",630376618);
insert into students values(4,"Klaus","Mikaelson","2002-04-23","klaus@gmail.com",984631257);
insert into students values(5,"Bonnie","Bennet","2003-10-09","bonnie@gmail.com",698745123);
insert into students values(6,"Caroline","Forbes","2000-02-26","caroline@gmail.com",954786321);
insert into students values(7,"Emma","White","2000-08-12","emmaw@gmail.com",714569876);
insert into students values(8,"Shane","Watson","2000-11-18","shane@gmail.com",874412369);
insert into students values(9,"Shreyas","Iyer","2003-01-14","shreyas@gmail.com",864597123);
insert into students values(10,"Rishabh","Pant","2002-06-23","rishabh@gmail.com",754139618);
select * from students;
create table Teacher(teacher_id int primary key,f_name varchar(20),l_name varchar(20),email varchar(30));
insert into Teacher values(101,"Kevin","Scott","kevin@gmail.com");
insert into Teacher values(102,"Jennifer","White","jenny@gmail.com");
insert into Teacher values(103,"Noah","Anderson","noah@gmail.com");
insert into Teacher values(104,"Laura","Smith","smith@gmail.com");
insert into Teacher values(105,"Ralph","Wheeler","Ralph@gmail.com");
insert into Teacher values(106,"Stephen","Richards","richards@gmail.com");
insert into Teacher values(107,"Austin","Mitchelle","austin@gmail.com");
insert into Teacher values(108,"Amber","Clark","amber@gmail.com");
insert into Teacher values(109,"Robert","Martin","robert@gmail.com");
insert into Teacher values(110,"Russell","Stanley","russell@gmail.com");
select * from Teacher;
create table courses(course_id int primary key,course_name varchar(20),credits int,teacher_id int,foreign key(teacher_id) references Teacher(teacher_id));
insert into courses values(1,"Mathematics",3,101);
insert into courses values(2,"English",3,102);
insert into courses values(3,"Physics",4,103);
insert into courses values(4,"Chemistry",4,104);
insert into courses values(5,"History",3,105);
insert into courses values(6,"Biology",3,106);
insert into courses values(7,"Music",2,107);
insert into courses values(8,"Art",2,108);
insert into courses values(9,"Literature",3,109);
insert into courses values(10,"Zoology",3,110);
select * from courses;
create table enrollments(enrollment_id int primary key,student_id int,foreign key(student_id) references students(student_id),course_id int,foreign key(course_id) references courses(course_id),enrollment_date date);
insert into enrollments values(201,1,3,"2023-03-10");
insert into enrollments values(202,2,2,"2023-03-12");
insert into enrollments values(203,3,4,"2023-03-13");
insert into enrollments values(204,4,1,"2023-03-14");
insert into enrollments values(205,5,6,"2023-03-15");
insert into enrollments values(206,6,7,"2023-03-16");
insert into enrollments values(207,7,8,"2023-03-17");
insert into enrollments values(208,8,5,"2023-03-18");
insert into enrollments values(209,9,9,"2023-03-19");
insert into enrollments values(210,10,10,"2023-03-20");
select * from enrollments;
create table payments(payment_id int primary key,student_id int,foreign key(student_id) references students(student_id),amount int,payment_date date);
insert into payments values(1,1,1000,"2022-04-01");
insert into payments values(2,2,1000,"2022-04-02");
insert into payments values(3,3,1500,"2022-04-03");
insert into payments values(4,4,1500,"2022-04-04");
insert into payments values(5,5,1000,"2022-04-05");
insert into payments values(6,6,1000,"2022-04-06");
insert into payments values(7,7,800,"2022-04-07");
insert into payments values(8,8,800,"2022-04-08");
insert into payments values(9,9,1000,"2022-04-09");
insert into payments values(10,10,1000,"2022-04-10");
select * from payments;
insert into students values(11,"John","Doe","2003-01-16","johndoe@example.com",1234567890);
insert into enrollments values(211,1,4,"2023-03-11");
update Teacher
set email="richards@gmail.com" where teacher_id=106;
delete from enrollments
where student_id=1 and course_id=3;
update courses
set teacher_id= 109
where course_id=1;
delete from students
where student_id= 4;
delete from enrollments
where enrollment_id=4;
update payments
set amount = 900 where payment_id=8;
select student_id,sum(amount) from payments
where student_id=3;
select student_id,sum(amount) as total_payments from payments
where student_id=3;
select students.f_name, students.l_name, sum(payments.amount) as total_payments
from students
join Payments on students.student_id = payments.student_id
where students.student_id = 3
group by students.student_id, students.f_name, students.l_name;
select courses.course_name, count(enrollments.student_id) from Courses
Left join enrollments on courses.course_id = enrollments.course_id
group by courses.course_id, courses.course_name;
select students.f_name, students.l_name
from students
Left join enrollments on students.student_id = enrollments.student_id
where enrollments.student_id is null;
select students.f_name, students.l_name, courses.course_name
from students
inner join enrollments on students.student_id = enrollments.student_id
inner join courses on courses.course_id = enrollments.course_id;
select Teacher.f_name, Teacher.l_name, courses.course_name
from Teacher
inner join courses on Teacher.teacher_id = courses.teacher_id;
select students.f_name, students.l_name, enrollments.enrollment_date
from students
left join enrollments on students.student_id = enrollments.student_id
left join courses on enrollments.course_id = courses.course_id
where courses.course_id = 7;
select students.f_name, students.l_name
from students
left join payments on students.student_id = payments.student_id
where payments.student_id is null;
select courses.course_name
from courses
left join enrollments on courses.course_id = enrollments.course_id
where enrollments.course_id is null;
select count(s1.student_id),s1.student_id,s1.course_id from enrollments as s1 join enrollments as s2
on s1.student_id=s2.student_id group by s1.course_id,s1.student_id;
select t.teacher_id,t.f_name,t.l_name,courses.course_name from Teacher t 
left join courses on courses.teacher_id=t.teacher_id where course_id  is null;
select avg(student_count) as average_students_enrolled
from (select count(*) as student_count from enrollments group by course_id) as course_enrollment_counts;
select student_id,amount from payments where amount = (select max(amount) from payments);
select c.course_id, c.course_name, count(e.student_id) as num_of_enrollments
from courses c
join enrollments e on c.course_id = e.course_id
group by c.course_id, c.course_name having count(e.student_id) = (select max(total_enrollments) 
from (select count(student_id) as total_enrollments
from enrollments
 group by course_id) as enrollmentcounts);
select student_id
from enrollments
group by student_id
having count(distinct course_id) = (select count(distinct course_id) from Courses);
select f_name, l_name
from Teacher
where teacher_id not in (select distinct teacher_id from courses);
select avg(datediff(current_date, dob) / 365) as average_age
from Students;
select course_id, course_name
from courses
where course_id not in (select distinct course_id from enrollments);
select e.student_id, e.course_id, sum(p.amount) as total_payments
from enrollments e join payments p on e.student_id = p.student_id
group by e.student_id, e.course_id;
select student_id
from payments
group by student_id
having count(*) > 1;
select s.f_name,s.student_id,sum(p.amount) from students s 
inner join payments p on s.student_id = p.student_ID group by student_id;
select c.course_name, count(e.student_id) as num_of_students
from courses c left join enrollments e on c.course_id = e.course_id
group by c.course_id, c.course_name;
select  s.student_id, s.f_name, avg(p.amount) from payments p 
inner join students s on p.student_id = s.student_id group by student_id;


