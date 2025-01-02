-- 1.	 Create a view that displays student full name
--, course name if the student has a grade more than 50. 

create view DisplayGrade as(

select (St_Fname + '' + St_Lname) as 'fullname' ,Crs_Name,grade
from Student, Course, Stud_Course

where(Student.St_Id =Stud_Course.St_Id ) and
(Stud_Course.Crs_Id =Course.Crs_Id) and
(Grade >50 ))


)
Select * from DisplayGrade


--2.	 Create an Encrypted view 
--that displays manager names and the topics they teach. 
use ITI
Create  view manger_topic with Encryption as (

select distinct Instructor.Ins_Name, Topic.Top_Id ,Topic.Top_Name
from Department,Topic,Course,Instructor,Ins_Course
where (Instructor.Ins_Id =Department.Dept_Manager) and
Ins_Course.Crs_Id = course.Crs_Id and
(Instructor.Ins_Id =Ins_Course.Ins_Id) and Topic.Top_Id =Course.Top_Id
)

Select* from manger_topic

--3.Create a view that will display Instructor Name,
--Department Name for 
--‘SD’ or ‘Java’ Department 

Create  view inst_dep with Encryption as (

select Instructor.Ins_Name, Department.Dept_Name
from Department,Instructor
where Department.Dept_Id = Instructor.Dept_Id 
and Department.Dept_Name in ('Java' ,'SD')
)

Select *from inst_dep


4--Create a view “V1” that displays student data for 
student who lives in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=’tanta’
--Where st_address=’alex’;
create view v1  as
select *
from Student
where Student.St_Address in ('Alex' , 'Cairo') with check option 

--Create a view that will display the project name 
--and the number of employees work on it. “Use Company DB”
use Company_SD;

create view display_project as
Select Project.pname ,count(Works_for.ESSn) as num
from Project
join Works_for
on Project.Pnumber = Works_for.Pno
group by Project.Pname

Select * from  display_project

--6.	Create index on column (Hiredate) that allow u to
--cluster the data in table Department. What will happen?
create clustered index a1 on Department(manager_hiredate);

--7.	Create index that allow u to
--enter unique ages in student table. What will happen?

create unique index a2 ON Student(st_Age);

--8.	Using Merge statement between the following
--two tables [User ID, Transaction Amount]

Merge into dbo.tt1 as T 
using dbo.tt3 as S
On T.c1=S.	c1

When matched then
update set T.c3=S.c3

When not matched by target Then 
insert(c1,c3)
values(S.c1,S.c3)
When not matched by Source
Then delete


9-
Use ITI
select concat(Student.St_Fname,' ',Student.St_Lname) as 'full name' , Stud_Course.Grade ,
lag (concat(Student.St_Fname,' ',Student.St_Lname) ) over ( order by grade  )
,lead (concat(Student.St_Fname,' ',Student.St_Lname) ) over ( order by grade  )
from Student
join Stud_Course 

on Student.St_Id =Stud_Course.St_Id

join Course 
on Course.Crs_Id=Stud_Course.Crs_Id