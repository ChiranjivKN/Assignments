Create Table Customers (CustomerId int Primary Key,
FirstName varchar(50),
LastName varchar (50), 
DOB Date,
Email varchar (50),
Phone_Number varchar (13),
Address varchar (200))

Create Table Accounts (AccountId int Primary Key,
CustomerId int references Customers (CustomerId),
AccountType varchar (50),
Balance float)

Create Table Transactions (TransactionId Int Primary Key,
AccountId Int references Accounts(AccountId),
TransactionType varchar (50),
Amount float,
TransactionDate Date)

---Task 2, Query 1
Select C.FirstName, C.LastName, C.Email, A.AccountType 
from Customers C, Accounts A
Where  A.CustomerId = C.CustomerId

---Task 2, Query 2
Select T.*, C.*, A.AccountType, A.Balance 
From Transactions T, Customers C, Accounts A
Where C.CustomerId= A.CustomerId
And A.AccountId = T.AccountId

---Task 2, Query 3
Declare @AccountId int = 1103;
Declare @Amount int = 5000;
Update Accounts 
Set Balance = Balance+@amount 
Where AccountId = @AccountId

---Task 2, Query 4
Select Concat(FirstName, ' ', LastName) as FullName
From Customers

---Task 2, Query 5
Delete From Accounts 
Where Balance = 0 and AccountType = 'Savings'

---Task 2, Query 6
Declare @City varchar (50) = 'Delhi'
Select * From Customers 
Where Address = @City

---Task 2, Query 7
Declare @Account int = 1101
Select Balance From Accounts 
Where AccountId = @Account

---Task 2, Query 8
Select * From Accounts
Where Balance > 30000 and AccountType ='Current'

---Task 2, Query 9
Declare @Account int = 1105;
Select * From Transactions
Where AccountId = @Account

---Task 2, Query 10
Declare @interest float = 0.05
Select AccountId, Balance * @interest as InterestAccrued
From Accounts 
Where AccountType ='Savings'

---Task 2, Query 11
Declare @Limit int = 30000;
Select * From Accounts
Where Balance < @Limit

---Task 2, Query 12
Declare @City varchar (50) = 'Delhi'
Select * From Customers
Where Address != @City

---Task 2, Query 1
Select C.CustomerId, C.FirstName,C.LastName, Avg(A.Balance) 
from Customers C
Left Join Accounts A on A.CustomerId = C.CustomerId
Group By C.CustomerId, C.FirstName,C.LastName

---Task 3, Query 2
Select Top 10 * from Accounts
Order By Balance Desc

---Task 3, Query 3
Declare @startDate date = '2020-03-01'
Declare @endDate date = '2022-02-28'
Select * from Transactions S
Where TransactionDate >=@startDate 
And TransactionDate <= @endDate
And TransactionType = 'Deposit'
Select * from Customers
---Task 3, Query 4
Select Top 1 * From Customers
Order By DOB Asc
Select Top 1 * From Customers
Order By DOB Desc

---Task 3, Query 5
Select T.*, A.AccountType 
From Transactions T
Left Join Accounts A on A.AccountId = T.AccountId

---Task 3, Query 6
Select C.*, A.* 
From Customers C
Left Join Accounts A on C.CustomerId = A.CustomerId

---Task 3, Query 7
Declare @Account int = 1107;
Select T.*, C.CustomerId, C.FirstName, C.LastName 
from Transactions T
Inner Join Accounts A on T.AccountId = A.AccountId
Inner Join Customers C on C.CustomerId = A.CustomerId
where T.AccountId = @Account
Select * from Accounts

---Task 3, Query 8
Select A.CustomerId,C.FirstName, C.LastName, Count(A.CustomerId) as TotalAccounts
From Accounts A
Join Customers C on A.CustomerId = C.CustomerId
Group By A.CustomerId, C.FirstName, C.LastName
Having Count(A.CustomerId) > 1

---Task 3, Query 9
Select 
((Select sum(Amount) from Transactions where TransactionType = 'Deposit')
- (Select Sum(Amount) from Transactions where TransactionType = 'Withdrawl')
) as AmountDifference

---Task 3, Query 10
Declare @startDate date = '2024-01-01';
Declare @endDate date = '2024-01-31';
Select AccountId, Avg(Balance) AS AverageDailyBalance
From ( Select AccountId, TransactionDate, Sum(Amount) As Balance
From Transactions Where TransactionDate >= @startDate And TransactionDate <= @endDate Group By AccountId, TransactionDate)
As DailyBalances
Group By AccountId


---Task 3, Query 11
Select A.AccountType, sum(A.Balance) as TotalBalance
from Accounts A
Group By A.AccountType 

---Task 3, Query 12
Select T.AccountId, Count(T.AccountId) as TotalTransactions 
From Transactions T
Group By T.AccountId
Order By TotalTransactions Desc

---Task 3, Query 13
Select A.AccountId, C.FirstName, C.LastName, A.AccountType, avg(A.Balance) as AverageAccountBalance
from Accounts A
Left Join Customers C on C.CustomerId = A.CustomerId
Group By A.AccountId, C.FirstName, C.LastName, A.AccountType

---Task 3, Query 14
Select AccountId, TransactionDate, Amount, Count(TransactionId)
from Transactions
Group By Accountid, TransactionType, TransactionDate, Amount
Having Count(TransactionId) > 1

---Task 4, Query 1
Select C.*, A.Balance 
From Customers C
Inner Join Accounts A on A.CustomerId = C.CustomerId
Where A.Balance =
(Select max(Balance) from Accounts) 

---Task 4, Query 2
Select CustomerId, avg(Balance) as AverageBalance
From Accounts
Group By CustomerId
Having CustomerId In 
(Select CustomerId from Accounts Group By CustomerId
Having Count( AccountId) > 1)

---Task 4, Query 3
Select AccountId from Transactions Where Amount >(
Select avg(Amount) from Transactions as AverageTransaction)

---Task 4, Query 4
Select * From Customers Where CustomerId Not in
(Select CustomerId from Accounts where AccountId In 
( Select Distinct AccountId From Transactions))

---Task 4, Query 5
Select sum(Balance) as TotalBalance 
from Accounts 
where AccountId Not In 
( Select Distinct AccountId From Transactions)

---Task 4, Query 6
Select * from Transactions Where AccountId In
(Select AccountId from Accounts where Balance = (Select min(Balance) from Accounts))

---Task 4, Query 7
Select * from Customers Where CustomerId In
(Select CustomerId from Accounts 
Group By CustomerId 
Having Count(Distinct AccountType)>1)

---Task 4, Query 8
Select AccountType, Count(AccountId), (count(AccountId) * 100 / (Select Count(AccountId) from Accounts)) as Percentage
From Accounts 
Group By AccountType

---Task 4, Query 9
Declare @Customer int = 103;
Select * From Transactions 
Where TransactionId In
(Select TransactionId From Transactions T
Join Accounts A on A.AccountId = T.AccountId
Join Customers C on C.CustomerId = A.CustomerId 
Where C.CustomerId = @Customer)

---Task 4, Query 10
Select A.AccountType, 
(Select sum(Balance) From Accounts Where AccountType = A.AccountType 
) as TotalBalance 
From Accounts A
Group By A.AccountType