create function dbo.Month_Date (@date date)
Returns varchar(50)
as
Begin 
	declare @x varchar(50)
	set @x = Datename(month, @date)
	return @x
end


SELECT dbo.Month_Date('2012-12-12')
	

 

 --Create a multi-statements table-valued function that takes 2 integers
 --and returns the values between them. 
create function dbo.random_num (@x1  int ,@x2 int)
Returns  @table TABLE (num INT)
as

begin
	declare @Temp int
	If @x2 < @x1   (5-1)  >>>
	Begin
			Set @Temp =@x1
			Set @x1= @x2
			Set @x2 = @Temp
	End

while @x1 <= @x2 
	Begin 
		insert into @table(num) values(@x1)
		set @x1 =@x1 +1

	end

return

End

SELECT * from  dbo.random_num(5,1)

	 

 --Create inline function that takes Student No and returns Department Name with Student full name. 

create function dbo.Dep_student (@st_no int)
Returns  TABLE 
as
 return (select Department.Dept_Name from Department join Student
		on Student.Dept_Id =Department.Dept_Id
			 where Student.St_Id=@st_no)



SELECT *from dbo.Dep_student(1)
	

--Create a scalar function that takes Student ID and returns a message to user  

--If first name and Last name are null then display 'First name & last name are null' 

--If First name is null then display 'first name is null' 

--If Last name is null then display 'last name is null' 

--Else display 'First name & last name are not null' 


create function StId_Mess(@St_id int)
returns varchar(50)
as
Begin 
declare @x Varchar(50)
declare @fn Varchar(50)
declare @ln Varchar(50)

	select @fn =St_Fname 
	from Student
	where St_Id = @St_id

	select @ln =St_Lname 
	from Student
	where St_Id = @St_id

If @fn IS  NULL and @ln IS  NULL
Begin
	Set @x ='Null in fname and lname'
end

else If @fn IS  NULL and @ln IS NOT NULL 
Begin
	Set @x ='Null in fname'
end

else If @fn IS NOT NULL and @ln IS  NULL
Begin
	Set @x ='Null in lname'
end
else If @fn IS NOT NULL and @ln IS NOT NULL 
Begin
	Set @x ='no null'
end
return 	 @x

End

Select dbo.StId_Mess(1)



--Create inline function that takes integer which represents
--manager ID and displays department name, Manager Name and hiring date  

create function dbo.Dep_manger(@id_m int)
Returns  TABLE 
as
 return (select Department.Dept_Name ,Department.Manager_hiredate ,Instructor.Ins_Name
		from Department
		join Instructor
		on Instructor.Ins_Id =Department.Dept_Manager
		where Department.Dept_Manager=@id_m)


Select * from  dbo.Dep_manger(1)


----------------
---------------
6-
--Create multi-statements table-valued function that takes a string 
--If string='first name' returns student first name 
--If string='last name' returns student last name  
--If string='full name' returns Full Name from student table  
--Note: Use “ISNULL” function 

create function  findname(@x varchar(40))
RETURNS @table TABLE (name varchar(40))
as

begin

if @x = 'firstname'
insert  @table 
select isnull(Student.St_Fname,'Null')
from Student 

if @x = 'lastname'
insert  @table 
select isnull(Student.St_Lname,'Null')
from Student 

 if @x = 'fullname'
insert  @table 
select concat( isnull(Student.St_Fname,'Null') , isnull(Student.St_Lname,'Null'))
from Student 


return 
end
