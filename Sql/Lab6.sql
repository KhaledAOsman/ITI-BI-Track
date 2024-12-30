--1  Display the SalesOrderID, ShipDate of the SalesOrderHeader table (Sales schema) 
--to show SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’ 
use AdventureWorks2012;

 Select SalesOrderID ,ShipDate
 from Sales.SalesOrderHeader
 where ShipDate between '2002-07-28' and '2014-07-29';

 --2  Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only) 
 Select ProductID,Name
 from Production.Product
 where StandardCost<110.0

--3  Display ProductID, Name if its weight is unknown 
 Select ProductID,Name
 from Production.Product
 where weight is null

 --4  Display all Products with a Silver, Black, or Red Color 

  Select ProductID,Name
 from Production.Product
 where Color in ('Silver','Black','Red')

  --5  Display any Product with a Name starting with the letter B 
 
 Select ProductID,Name
 from Production.Product
 where Name Like 'B%'


 Run the following Query 

--6  UPDATE Production.ProductDescription 

--SET Description = 'Chromoly steel_High of defects' 

--WHERE ProductDescriptionID = 3 

--Then write a query that displays any Product description with underscore value in its description. 

UPDATE Production.ProductDescription 

SET Description = 'Chromoly steel_High of defects' 

WHERE ProductDescriptionID = 3 


select Description 
from  Production.ProductDescription 
where Description like '%[_]%'


--7  Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table for the period between  '7/1/2001' and '7/31/2014' 

select OrderDate, SUM(TotalDue) AS Total
from Sales.SalesOrderHeader
where OrderDate between '2001-07-01' and '2014-07-31'
group by OrderDate


 --8  Display the Employees HireDate (note no repeated values are allowed) 

 Select distinct HireDate,  NationalIDNumber
 from HumanResources.Employee


 --9  Calculate the average of the unique ListPrices in the Product table 
 Select AVG(distinct ListPrice ) as Avg
 from Production.Product
 

--10  Display the Product Name and its ListPrice within the values of 100 and 120 the list should has the 
--following format "The [product name] is only! [List price]" 
--(the list will be sorted according to its ListPrice value) 

 Select 'The' +'[ ' + Name + ' ]'+ ' is only '  +'[ ' + convert(VARCHAR, ListPrice) + ' ]'
 from Production.Product
 where ListPrice between 100 and 120 
 order by ListPrice 

  

--12  Using union statement, retrieve the today’s date in different styles using convert or format funtion. 


select format(getdate(), 'yyyy-MM-dd') 
union
select format(getdate(), 'dddd, MMMM ,dd') 
union
select format(getdate(), 'dd, MM ,yy') 