use TechShop;
Create table Customers 
(CustomerID int Primary Key, 
FirstName varchar(50), 
LastName varchar (50), 
Email varchar (50), 
Phone varchar (13), 
Address varchar (200))

Insert into Customers
Values (101, 'Rahul', 'Verma', 'rahul.v@cherry.com', '9874456321', 'Mumbai'),
(102, 'Priya', 'Singh', 'priya.s@cherry.com', '9922516352', 'Hyderabad'),
(103, 'Amit', 'Patel', 'amit.p@cherry.com', '8854635297', 'Hyderabad'),
(104, 'Deepika', 'Gupta', 'deepika.g@cherry.com', '8759658457', 'Hyderabad'),
(105, 'Rajesh', 'Sharma', 'rajesh.s@cherry.com', '9856478596', 'Chennai'),
(106, 'Neha', 'Joshi', 'neha.j@cherry.com', '8879658459', 'Pune'),
(107, 'Ankit', 'Kumar', 'ankit.k@cherry.com', '9987456985', 'Nagpur'),
(108, 'Sneha', 'Sharma', 'sneha.s@cherry.com', '9987456385', 'Chennai'),
(109, 'Vikas', 'Modi', 'vikas.s@cherry.com', '8856956842', 'Mumbai'),
(110, 'Pooja', 'Goyal', 'pooja.g@cherry.com', '7745896852', 'Pune');

select * from products

Create Table ProductCategory (CategoryId int , Category varchar(50))

Create Table Products 
(ProductID int Primary Key, 
ProductName varchar(50), 
ProductDescription varchar(255), 
Price float)

Insert Into Products
Values (10001, 'Laptop', 'High-performance laptop with SSD', 50000),
(10002, 'Smartphone', 'Latest smartphone with 5G support', 25000),
(10003, 'Tablet', '10-inch tablet with Retina display', 15000),
(10004, 'Headphones', 'Noise-cancelling wireless headphones', 3000),
(10005, 'Smartwatch', 'Fitness tracker and smartwatch', 7000),
(10006, 'Camera', 'DSLR camera with 24MP sensor', 45000),
(10007, 'Television', '4K Ultra HD smart TV', 60000),
(10008, 'Refrigerator', 'Double-door refrigerator with frost-free technology', 30000),
(10009, 'Air Conditioner', 'Inverter split AC with energy-saving features', 35000),
(10010, 'Washing Machine', 'Front-load washing machine with steam wash', 25000);

Alter Table Products
Add  ProductCategogy int

Create Table Orders 
(OrderID int Primary Key, 
CustomerID int references Customers(CustomerID), 
OrderDate Date, 
TotalAmount float)

Insert into Orders
values (5001, 101, '2024-02-20', 75000),
(5002, 102, '2024-03-11', 30000),
(5003, 101, '2024-03-05', 40000),
(5004, 102, '2024-01-24', 50000),
(5005, 105, '2023-12-25', 60000),
(5006, 101, '2024-03-01', 20000),
(5007, 103, '2024-02-12', 45000),
(5008, 103, '2024-01-08', 55000),
(5009, 104, '2024-03-18', 70000),
(5010, 105, '2024-03-28', 80000);


Create Table OrderDetails 
(OrderDetailID int Primary Key, 
OrderID int references Orders(OrderID), 
ProductID int references Products(ProductID), 
Quantity int) 

Insert into OrderDetails
values (101, 5001, 10001, 2),
(102, 5001, 10003, 1),
(103, 5002, 10002, 1),
(104, 5002, 10004, 3),
(105, 5003, 10001, 1),
(106, 5003, 10005, 2),
(107, 5004, 10003, 2),
(108, 5004, 10002, 1),
(109, 5005, 10004, 4),
(110, 5005, 10001, 3);


Create Table Inventory 
(InventoryID int Primary Key, 
ProductID int references Products(ProductID), 
QuantityInStock int, 
LastStockUpdate Date)

Insert into Inventory
values (101, 10001, 20, '2024-02-29'),
(102, 10002, 15, '2024-03-28'),
(103, 10003, 30, '2024-03-12'),
(104, 10004, 25, '2024-03-26'),
(105, 10005, 35, '2024-03-12'),
(106, 10006, 40, '2024-01-24'),
(107, 10007, 45, '2024-02-21'),
(108, 10008, 50, '2024-02-20'),
(109, 10009, 10, '2024-03-21'),
(110, 10010, 15, '2024-02-20');

--1
select FirstName, LastName, Email from Customers 

--2
select Firstname, lastname, orderid, orderdate
from orders, customers
where customers.customerid= orders.customerid

--3
insert into customers 
values (111, 'Rahul', 'Roy', 'rahul.r@cherry.com', '9875698564', 'Pune')

--4
update products
set price = price*1.1

--5
Declare @DeleteOrder int = 5006;
Delete From Orders
where OrderId = @DeleteOrder;
Delete From OrderDetails
where OrderId = @DeleteOrder
Select * from Orders
Select * from OrderDetails

--6
Insert into Orders
values (5011, 111, '2024-01-31', 50000)

--7
Declare @NewEmail varchar(50) = 'cherry@cherry.com';
Declare @Address varchar(50) =  'Gondia';
Declare @Customerid int = 101; 
Update Customers
set email = @NewEmail, Address= @Address where customerid = @Customerid
select * from Customers

--8
update Orders 
set TotalAmount = (
select sum(Od.Quantity * (select Price from Products P where P.ProductID = Od.ProductID))
from OrderDetails Od
where Od.OrderID = orders.OrderID )
select * from Customers

--9
Declare @Customer int = 111;
Delete from OrderDetails
Where OrderId =
(Select OrderId
From Orders 
Where CustomerId = @Customer)
Delete from Orders 
where CustomerId = @Customer
Select * from OrderDetails

--10
Insert into products
values (10011, 'Earbuds', 'Truely Wireless Earbuds', 2000)

--11
Alter table Orders
Add Status varchar(20);
select * from orders
Declare @Status varchar(20) = 'Shipped';
Declare @OrderId int = 5004;
Update Orders
Set Status = @Status 
where OrderId = @OrderId

--12
Update Customers
set OrdersPlaced =(
select  count(customerid)
from orders
where orders.customerid = customers.customerid)
select * from customers

--task 3 query 1
select * from orders o 
left join customers c on o.customerid = c.customerid

--task 3 query 2
Select ProductName, sum(OrderDetails.Quantity * Products.Price) as TotalRevenue
from Products
Join OrderDetails on products.productid = orderdetails.productid
group by ProductName
select * from orders

---task 3 query 3
select Orders.orderid, c.customerid, c.FirstName, c.LastName, c.email, c.phone 
from customers c
right join orders on orders.customerid = c.customerid

---task 3 query 4
use TechShop;
Select top 1 Products.ProductName, sum(OrderDetails.Quantity) as TotalQuantityOrdered
from Products
Inner Join OrderDetails on Products.ProductID = OrderDetails.ProductID
Group By Products.ProductName
Order By TotalQuantityOrdered desc

---task 3 query 5
Select * from Products P
Left Join ProductCategory PC on PC.CategoryId = P.ProductCategogy


---task 3 query 6
Use TechShop;
Select C.Customerid, C.FirstName, C.LastName,  avg(O.TotalAmount) as AverageOrderValue 
from Customers C
Inner Join Orders O on C.customerid = O.customerid
Group By C.Customerid, C.FirstName, C.LastName

--- task 3 query 7
Select top 1 C.CustomerId, C.FirstName, C.LastName, C.phone, C.Email, sum(O.TotalAmount) as TotalRevenue 
from Orders O
Right Join Customers C on C.CustomerId = O.CustomerId
Group By C.CustomerId, C.FirstName, C.LastName, C.phone, C.Email
Order By TotalRevenue Desc

--- task 3 query 8
Select P.ProductName, P.ProductId, count(D.ProductId) as TimesOrdered
from Products P
Left Join  OrderDetails D on P.ProductId = D.ProductId
Group By P.ProductName, P.ProductId

--- task 3 query 9
Declare @ProductName varchar (50) = 'Laptop';
Select Distinct C.CustomerId, C.FirstName, C.LastName from Customers C
Join Orders O on O.CustomerId = C.CustomerId 
Join OrderDetails OD on OD.OrderId = O.OrderID
Join Products P on P.ProductId = OD.ProductId
where (P.ProductName = @ProductName)

--- task 3 query 10
Declare @StartDate date = '2024-01-30';
Declare @EndDate date= '2024-03-10';
Select sum(O.TotalAmount) as TotalRevenue 
from Orders O 
where OrderDate Between @StartDate and  @EndDate

---Task 4, query 1
Use TechShop;
Select * from Customers 
where OrdersPlaced<1

---Task 4, query 2
Select count(ProductId) 
from Products as products

---Task 4, query 3
Select Sum(TotalAmount) 
from Orders as "Total Revenue"

---Task 4, query 4
Declare @Category varchar (50) = 'Audio';
Select @Category as ProductCategory, avg(O.Quantity) as AverageQuantityOrdered
From OrderDetails O 
Join Products P on O.ProductId = P.ProductId
Join ProductCategory PC on PC.CategoryId = P.ProductCategogy
Where PC.Category = @Category

---Task 4, query 5
Declare @CustomerId int = 105;
Select @CustomerId as ProductId, sum(O.TotalAmount) as RevenueGenerated 
from Orders O 
where O.CustomerId = @CustomerId

---Task 4, query 6
Select C.FirstName, C.LastName, (
Select count(O.CustomerId) 
from Orders O 
where  O.CustomerId = C.CustomerId
) as TotalOrders
from Customers C

---Task 4, query 7
Select top 1 PC.CategoryId, PC.Category, count(O.Quantity) as TotalOrders 
from ProductCategory PC
Join Products P on P.ProductCategogy = PC.CategoryId
Join OrderDetails O on O.ProductId = P.ProductId
Group by PC.CategoryId, PC.Category
Order by TotalOrders desc
 select * from OrderDetails
 Select * from Products

 ----Task 4, query 8
 Select top 1 C.FirstName, C.LastName,
 ( Select Sum(O.TotalAmount)from Orders O
 where O.CustomerId = C.CustomerId
 )as TotalSpent
 From Customers C
 
----Task 4, query 9
Select C.FirstName, C.LastName, (
Select avg(TotalAmount) as AverageOrderValue 
from Orders O
where C.CustomerId = O.CustomerId
) from Customers C

---Task 4, query 10
Select C.FirstName, C.LastName, 
(Select count(O.CustomerId) from Orders O 
where O.CustomerId = C.CustomerId
) as OrdersPlaced
From Customers C
