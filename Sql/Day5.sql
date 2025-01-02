
--'1.	Retrieve number of students who have a value in their age. '

select St_Id
from Student
where St_Age is not	null

--2.	Get all instructors Names without repetition

Select distinct Ins_Name
from Instructor 


--3.	Display student with the following Format (use isNull function)
--Student ID	Student Full Name	Department name


Select St_Id , Isnull(St_Fname, ' ')+ ' ' + Isnull(St_Lname, ' ') as Full_Name ,Department.Dept_Name
from Student
join 
Department
on Department.Dept_Id =Student.Dept_Id



--4.	Display instructor Name and Department Name 
--Note: display all the instructors if they are attached to a department or not


Select Instructor.Ins_Name ,Department.Dept_Name
from Instructor
left join 
Department
on Department.Dept_Id =Instructor.Dept_Id

--5.	Display student full name and the name of the course he is taking
--For only courses which have a grade  


Select Isnull(St_Fname, ' ')+ ' ' + Isnull(St_Lname, ' ') as Full_Name ,Course.Crs_Name
from Student
join 
Stud_Course
on Student.St_Id =Stud_Course.St_Id
join 
Course
on Course.Crs_Id =Stud_Course.Crs_Id
where Grade is not null

--6.	Display number of courses for each topic name

Select COUNT(Crs_id)as num_course ,Topic.Top_Name
from Course
join 
Topic
on Topic.Top_Id =Course.Top_Id
group by Topic.Top_Name

--7.	Display max and min salary for instructors

Select Max(Salary) as max ,MIN(Salary) as min
from Instructor

--8.	Display instructors who have salaries less than the average salary of all instructors.
Select Ins_Name
from Instructor
where Salary < (Select AVG(Salary) from Instructor);

Select Ins_Name
from Instructor
where Salary < (Select isnull(AVG(Salary),0) from Instructor);
--9.	Display the Department name that contains the instructor who receives the minimum salary.
Select * from 
(Select Department.Dept_Name,Instructor.Salary ,
ROW_NUMBER() Over(order by Salary) as row_num
from Instructor
join Department
on Department.Dept_Id =Instructor.Dept_Id) as temp
where row_num =1
--10.	 Select max two salaries in instructor table. 
Select Salary from 
(Select Instructor.Salary ,
ROW_NUMBER() Over(order by Salary desc) as row_num
from Instructor) as temp
where row_num in(1,2)



--11.	 Select instructor name and his salary but if there is 
--no salary display instructor bonus keyword. “use coalesce Function”
Select Instructor.Ins_Name , coalesce (Instructor.Salary,'Bouns')
from Instructor 

--12.	Select Average Salary for instructors 
Select  Avg(coalesce (Instructor.Salary,0)) as Avg_Salary
from Instructor 

Select  Avg(Instructor.Salary) as Avg_Salary
from Instructor 
--13.	Select Student first name and the data of his supervisor 

Select st.St_Fname , sup.*
from Student st
join Student sup
on st.St_super = sup.St_Id

--14.	Write a query to select the highest two salaries in Each Department 
--for instructors who have salaries. “using one of Ranking Functions”

select * from (
Select  Ins_Name, Salary ,Dept_Id ,
ROW_NUMBER() over( Partition by Dept_Id order by Salary) as row_num
from Instructor
) as temp

where row_num in (1,2)
--15.	 Write a query to select a random  student from each department.
--“using one of Ranking Functions”
select * from(
select St_id,St_Fname,Dept_Id,
ROW_NUMBER() over(Partition by Dept_Id order by St_id ) as row_num
from Student) as temp
where row_num = FLOOR(RAND() * 3) + 1 

select * from(
select St_id,St_Fname,Dept_Id,
ROW_NUMBER() over(Partition by Dept_Id order by newid() ) as row_num
from Student) as temp
where row_num = 1
