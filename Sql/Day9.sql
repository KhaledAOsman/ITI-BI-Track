--1.	Create a stored procedure without parameters 
--to show the number of students per department name.[use ITI DB] 
use 
create procedure DP_names as
begin
Select Department.Dept_Name, Count(Student.St_Id) as 'Count'
from Student, Department
where Student.Dept_Id =Department.Dept_Id
group by Department.Dept_Name
end

exec DP_names


--2.	Create a stored procedure that will check for the # of 
--employees in the project p1 if they are more than 3
--print message to the user “'The number of employees 
--in the project p1 is 3 or more'” if they are less display 
--a message to the user “'The following employees work for the project p1'” 
--in addition to the first name and last name of each one. [Company DB] 

use Company_SD;
alter procedure Check_Pro 
As
begin
Declare @x int
Set @x = (Select count(Works_for.ESSn)  
		 from Works_for ,project
		 where Works_for.Pno = project.Pnumber and Project.Pname= 'AL Solimaniah' )
if @x >=3 
begin
	select 'The number of employees in the project p1 is 3 or more '
end
else
begin
 
select Employee.Fname + '' +  Employee.Lname
from Employee,Works_for,Project where Employee.SSN =Works_for.ESSn
and Project.Pnumber =Works_for.Pno
and Project.Pname ='AL Solimaniah'
union
select 'The following employees work for the project p1'

end
End

exec Check_Pro


--3.	Create a stored procedure that will be used 
--in case there is an old employee has left the
--project and a new one become instead of him.
--The procedure should take 3 parameters
--(old Emp. number, new Emp. number and the project number)
--and it will be used to update works_on table. [Company DB]

alter procedure update_emp @oldempnum int ,
@newempnum int, @pnum int
as
begin
if @pnum in (select Project.Pnumber from Project)
and @oldempnum in (select Works_for.essn from Works_for)
and @newempnum in (select Employee.SSN from Employee)
	update  Works_for 
	set ESSn = @newempnum
	where Pno = @pnum and ESSn=@oldempnum
else 
Select 'check project num and SSn of each employee'
end

--4--

USe Company_SD;
ALTER TABLE project
ADD budget int;

create table Audit (ProjectNo varchar(50),
serName varchar(50),ModifiedDate date,Budget_Old int,Budget_New int)

create trigger T1 
on Project
for update 
as
begin
insert into aduit (ProjectNo,
serName ,ModifiedDate ,Budget_Old ,Budget_New )

select Project.Pnumber , SUSER_NAME(),GETDATE(),deleted.budget,
inserted.budget
from Project,inserted,deleted

where inserted.Pnumber = Project.Pnumber  AND
deleted.Pnumber = Project.Pnumber 

end

--5.	Create a trigger to prevent anyone from
--inserting a new record in the Department table [ITI DB]
--“Print a message for user to tell him that he can’t insert
--a new record in that table”

create TRIGGER a
on Department
instead of insert
AS
begin
    PRINT 'Cannot insert a new record into the Department table.';
end



6.	 Create a trigger that prevents the insertion 
Process for Employee table in March [Company DB].

create TRIGGER a2
on employee
after insert
as 
begin
if MONTH(GETDATE()) = 'march'
rollback
end



create table StudentAudit (
serName varchar(50),ModifiedDate date,Note varchar(50))

create trigger T11
on student
after insert
AS
BEGIN
    INSERT INTO StudentAudit (
        serName,
        ModifiedDate,
        Note
    )
    SELECT 
        SUSER_NAME(),
        GETDATE(),
        concat(SUSER_NAME(), ' Insert New Row with Key ', inserted.st_id)
    FROM 
        inserted ;
END;

--8.	 Create a trigger on student table instead
--of delete to add Row in Student Audit table 
--(Server User Name, Date, Note) where note will be“
--try to delete Row with Key=[Key Value]”


create trigger T111
on student
instead of delete
AS
BEGIN
    INSERT INTO StudentAudit (
        serName,
        ModifiedDate,
        Note
    )
    SELECT 
        SUSER_NAME(),
        GETDATE(),
        concat(SUSER_NAME(), ' try to delete Row with ', inserted.st_id)
    FROM 
        inserted ;
END;

