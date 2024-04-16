Create Database SISDB
Create Table Students (Student_id int Primary Key, 
First_name varchar(50), 
Last_name varchar(50), 
Date_of_birth Date, 
Email varchar (100)  , 
Phone_number varchar (13))

Insert Into Students (Student_id, First_name, Last_name, Date_of_birth, Email, Phone_number)
Values
(101, 'Aarav', 'Patel', '2001-05-15', 'p.aarav@cherry.com', '7894561230'),
(102, 'Aisha', 'Sharma', '2002-09-20', 's.aisha@cherry.com', '8123456789'),
(103, 'Advik', 'Gupta', '2000-11-03', 'g.advik@cherry.com', '9745123698'),
(104, 'Diya', 'Singh', '2003-02-10', 's.diya@cherry.com', '8796541230'),
(105, 'Ishan', 'Reddy', '2000-07-28', 'r.ishan@cherry.com', '8956231470'),
(106, 'Riya', 'Desai', '2001-04-05', 'd.riya@cherry.com', '7123698456'),
(107, 'Arjun', 'Joshi', '2002-03-19', 'j.arjun@cherry.com', '8237415690'),
(108, 'Aaradhya', 'Mishra', '2003-01-07', 'm.aaradhya@cherry.com', '9461528370'),
(109, 'Vihaan', 'Patel', '2000-12-25', 'p.vihaan@cherry.com', '8794563210'),
(110, 'Saanvi', 'Kumar', '2003-08-14', 'k.saanvi@cherry.com', '9574136820');

Create Table Courses (Course_id int Primary Key, 
Course_Name varchar (50),
Credits float,
Teacher_Id int references Teacher(Teacher_id))

Insert Into Courses 
Values (1, 'Python', 15.5, 1001),
(2, 'Java', 13.2, 1002),
(3, 'SQL', 17.8, 1003),
(4, 'C++', 14.6, 1004),
(5, 'Kotlin', 19.3, 1005);

Create Table Enrollments (Enrollment_id  int Primary Key,
Studnet_id int references Students(Student_id),
Course_id int references Courses (Course_id),
Enrollment_date date)

Insert Into Enrollments 
values ('202401', 101, 1, '2024-01-15'),
('202402', 102, 2, '2024-01-20'),
('202403', 103, 3, '2024-02-05'),
('202404', 104, 4, '2024-02-10'),
('202405', 105, 5, '2024-02-18'),
('202406', 106, 1, '2024-02-25'),
('202407', 107, 2, '2024-03-05'),
('202408', 108, 3, '2024-03-10'),
('202409', 109, 4, '2024-03-15'),
('202410', 110, 5, '2024-03-20');

Create Table Teacher (Teacher_id int Primary Key,
First_name varchar (50),
Last_name varchar (50),
Email varchar(100))

Insert Into Teacher 
Values(1001, 'Aakash', 'Shah', 's.aakash@cherry.com'),
(1002, 'Neha', 'Verma', 'v.neha@cherry.com'),
(1003, 'Rahul', 'Singh', 's.rahul@cherry.com'),
(1004, 'Priya', 'Patil', 'p.priya@cherry.com'),
(1005, 'Vikram', 'Reddy', 'r.vikram@cherry.com');
Insert Into Teacher
Values (1006, 'Kabir', 'Singh', 'S.Kabir@cherry.com');

Create Table Payments (Payment_id int Primary Key,
Student_id int references Students(Student_id),
Amount float,
Payment_date date)

Insert Into Payments
Values (12345, 101, 5000, '2024-01-15'),
(23456, 102, 6000, '2024-01-21'),
(34567, 103, 7000, '2024-02-06'),
(45678, 104, 5500, '2024-02-12'),
(56789, 105, 8000, '2024-02-20'),
(67890, 106, 7500, '2024-02-27'),
(78901, 107, 6200, '2024-03-07'),
(89012, 108, 6900, '2024-03-12'),
(90123, 109, 5800, '2024-03-17'),
(10123, 110, 6700, '2024-03-22');

Select * from Students
Select * from Enrollments
Select * from Courses
Select * from Teacher
Select * from Payments Order by student_id asc

---Task 2, query 1
Insert Into Students
Values (111, 'John', 'Doe', '1995-08-15', 'John.doe@example.com', '1234567890')

---Task 2, query 2
Insert into Enrollments
Values (202411, 111, 5, '2024-02-27')

---Task 2, query 3
Update Teacher
Set email = 'new_email@cherry.com' 
where teacher_id = 1002; 

---Task 2, query 4
Delete from Enrollments
Where Studnet_id= 103

---Task 2, query 5
Update Courses
Set Teacher_Id = 1004
where Course_id = 3

---Task 2, query 6
Delete from Payments
Where Student_id = 103
Delete from Students 
where Student_id = 103;
Delete from Enrollments 
Where Studnet_id = 103

---Task 2, query 7
Update Payments
Set Amount = 25000 where Payment_id = 12345;


---Task 3, query 1
Select S.Student_id, S.First_name, S.Last_name, count(P.Amount) as TotalPayments from Students S
Inner Join Payments P on P.Student_id = S.Student_id
group by S.Student_id, First_name, Last_name

---Task 3, query 2
Select C.Course_name, count(E.Studnet_id) as EnrolledStudents from Courses C
Inner Join Enrollments E on C.Course_id = E.Course_id 
Group by Course_name

---Task 3, query 3
Select * from Students S
Left Join Enrollments E on S.Student_id = E.Studnet_id 

---Task 3, query 4
Select S.First_name, S.Last_name, C.course_name from Students S
Inner Join Enrollments E on S.Student_id = E.Studnet_id
Inner Join Courses C on C.Course_id = E.Course_id

---Task 3, query 5
Select T.First_name, T.Last_name, C.Course_name from Teacher T
Join Courses C on C.Teacher_id = T.Teacher_id

---Task 3, query 6
Select S.First_name, S.Last_name, C.course_name, E.Enrollment_date from Students S
Join Enrollments E on E.Studnet_id = S.Student_id
Join Courses C on E.Course_id = C.Course_id

---Task 3, query 7
Select * from Students S
Left Join Payments P on P.Student_id = S.Student_id where P.Amount is Null

---Task 3, query 8
Select C.Course_name from Courses C
Left Join Enrollments E on E.Course_id = C.course_id
where E.Enrollment_id is null
Group by C.Course_Name

---Task 3, query 9
Select E.Studnet_id, Count(E.Course_id) from Enrollments E
Join Enrollments F on E.Studnet_id = F.Studnet_id
Where (Count(E.Course_id) > 1)
Group by E.Studnet_id

---Task 3, query 10
Select T.* from Teacher T
Left Join Courses C on C.Teacher_id = T.Teacher_id
where C.Teacher_id is null
select * from Courses

---Task 4, query 1
Select Course_id,  avg(AverageStudentsEnrolled) as AvgStudentsEnrolled 
from (Select Course_id, Count (Studnet_id) as AverageStudentsEnrolled 
from Enrollments E 
Group By Course_id
) as Courses
group by Course_id

---Task 4, query 2
Select P.Student_id, S.First_name, S.Last_name, Amount 
from Payments P 
Join Students S on S.Student_id = P.Student_id
where Amount =
(Select max(Amount) from Payments)
select * from Enrollments

---Task 4, query 3
Select C.Course_id, C.Course_Name, (
Select Count(E.Studnet_id) 
from Enrollments E 
where E.course_id = C.Course_id
) as Enrollments
From Courses C
Order By Enrollments Desc
select * from Payments

---Task 4, query 4
Select C.Course_id, C.Course_Name, T.First_Name, T.Last_Name, Sum(P.Amount) as AmountRecieved
from Courses C
Join Teacher T on T.Teacher_id = C.Teacher_id
Join Enrollments E on E.Course_id = C.Course_id
Join Payments P on E.Studnet_id = P.Student_id
Group By C.Course_id, C.Course_Name, T.First_Name, T.Last_Name

---Task 4, query 5
Select * 
From Students S
where S.Student_id In  
(Select Student_id 
from Enrollments E 
Group By E.Course_id 
Having count(E.studnet_id) = (Select  Count(distinct C.Course_id ) from Courses C))

---Task 4, query 6
Select * From Teacher T
Where Teacher_id Not In
(Select Teacher_id from Courses)

---Task 4, query 7
Select Avg(age) as AverageAgeOfStudents
From (
Select Datediff(Year, S.Date_of_Birth, getdate()) as age 
from Students S) as AverageAge

---Task 4, query 8
Select * from Courses
Where Course_id Not In
(Select Course_id from Enrollments)

---Task 4, query 9
Select E.Studnet_id, E.Course_id,
(Select sum(P.Amount) from Payments P 
Where P.Student_id = E.Studnet_id ) as TotalSpent
from Enrollments E

---Task 4, query 10
Select * from Students 
where Student_id In
(Select Student_id from Payments P 
Group By Student_id
Having Count(Student_id)>1)

---Task 4, query 11
Select S.Student_id, S.First_name, sum(P.Amount) as TotalPayments 
from Students S
Left Join Payments P on P.Student_id = S.Student_id
Group By S.Student_id, S.First_name

---Task 4, query 12
Select C.Course_id, C.Course_name, count(E.Studnet_id) as EnrolledStudents 
from Courses C
Left Join Enrollments E on C.Course_id = E.Course_id
Group By C.Course_name, C.Course_id

---Task 4, query 13
Select S.Student_id, S.First_name, S.Last_name, avg(P.Amount) as AverageAmount
from Students S
Join Payments P on P.Student_id = S.Student_id
Group By S.Student_id, S.First_name, S.Last_name

