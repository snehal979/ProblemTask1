--1) Select the name and age of all employees who work in departments with at least one employee who is over the age of 50
--2)Select all orders along with the name and city of the customer and the name of the product ordered
--3)Write a procedure, check if id already exist in table. if yes update the data else insert a new data
--4) Create a function that returns the average price of a product by taking the product ID as input and calculating the average of all prices for that product
--5) trigger trgAfterInsert is created on the Customers table. After each new customer is inserted into the table, the trigger inserts a record into the CustomerAudit table, capturing the CustomerID and the action of "Inserted".

--1) Select the name and age of all employees who work in departments with at least
-- one employee who is over the age of 50
select name,age from employees where deptId =(select depId from employees where age > 50);

--2)Select all orders along with the name and city of the customer and the name of the product ordered
select A.name,A.city,B.name from order as A inner join customer as B on A.Id =B.Id inner join product as C on A.id=C.id; ;

--Write a procedure, check if id already exist in table. if yes update the data else insert a new data
create procedure spCreateNewData(@id int ,@firstName varchar(50),@lastName varchar(50))
as
begin
declare @countEmployee int
set @countEmployee = (select count(*) from Employee where id =@id );
if(@countEmployee = 1)
begin
update Employee set firstName=@firstName,lastName =@lastName where id=@id;
print 'Update employee';
end
else
begin
insert into Employee(id,firstName,lastName) values(@id,@firstName,@lastName)
print 'newData added';
end
end

exec spCreateNewData 1,'Snehal','Bansod';

--Create a function that returns the average price of a product by taking the product
-- ID as input and calculating the average of all prices for that product
create function fnAvgPrice(@productId int)
returns int
as
begin
return(select avg(prices) as Avgprices from product where id=@productId;

select fnAvgPrice(2);
--trigger trgAfterInsert is created on the Customers table. 
--After each new customer is inserted into the table, the trigger 
--inserts a record into the CustomerAudit table, capturing the CustomerID and the action of "Inserted".

create trigger trgAfterInsert
on Customers
After insert
as
begin
--declare @id int
--select @id = i.id from Inserted i;
insert into CustomerAudit(CustomerID,action) values(@id,inserted);
print 'Add Record';
end

