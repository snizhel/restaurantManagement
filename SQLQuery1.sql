 create database RestaurantManagement
 go

 use RestaurantManagement
 go

 -- Food
 -- FoodTable
 -- FoodCategory
 -- Account
 -- Bill
 -- BillInfo

 create table FoodTable
 (
	id int identity primary key,
	name nvarchar(100) not null default N'Table has no name',
	status nvarchar(100) not null default N'NULL'			--Empty || Order
 )
 Go

 create table Account
 (
 	UserName nvarchar(100) primary key,
	DisplayName nvarchar(100) not null default N'KT',
	PassWord nvarchar(1000) not null default 0,
	Type int not null default 0	-- 1: admin && 0:staff						
 )
 Go

 create table FoodCategory
 (
	id int identity primary key,
	name nvarchar(100) not null default N'Not Know'
 )
 Go

 create table Food
 (
	id int identity primary key,
	name nvarchar(100) not null default N'Not Know',
	idCategory int not null,
	Price float not null default 0

	foreign key (idCategory) references dbo.FoodCategory(id)
 )
 Go

 create table Bill
 (
	id int identity primary key,
	DateCheckIn DATE not null default getdate(),
	DateCheckOut DATE,
	idTable int not null,
	status int not null default 0  -- 1: đã thanh toán && 0: chưa thanh toán

	foreign key (idTable) references dbo.FoodTable(id)
 )
 go

 create table BillInfo
 (
	id int identity primary key,
	idBill int not null,
	idFood int not null,
	count int not null default 0

	foreign key (idBill) references dbo.Bill(id),
	foreign key (idFood) references dbo.Food(id)
 )
 go

create PROC USP_GetAccountByUserName
@userName varchar(100)
as
begin
	select * from dbo.Account where UserName = @userName
end
go

exec dbo.USP_GetAccountByUserName @userName = N'KT'
go

create proc usp_Login
@userName nvarchar(100), @passWord nvarchar (100)
as
begin
	select * from dbo.Account where UserName = @userName and PassWord = @passWord
end
go

create proc usp_GetTableList
as select * from dbo.FoodTable
go


--thêm bàn
declare @i int = 0
while @i < 15
begin
	insert into dbo.FoodTable
	(
		name
	)
	values
	(
		N'Table' + cast (@i as nvarchar(100)))
		set @i = @i + 1
end
go

update dbo.FoodTable set status = N'Order' where id = 9

insert into dbo.Account
 (
	UserName,
	DisplayName,
	PassWord,
	Type
 )
 values
 (
	N'KT',
	N'Kthinhsg21',
	N'1',
	1
 )

 insert into dbo.Account
 (
	UserName,
	DisplayName,
	PassWord,
	Type
 )
 values
 (
	N'Employee',
	N'Employee123',
	N'1',
	0
 )

 insert into dbo.Account
 (
	UserName,
	DisplayName,
	PassWord,
	Type
 )
 values
 (
	N'Admin',
	N'Admin1',
	N'Admin',
	1
 )


-- thêm category
insert dbo.FoodCategory
(name)
values (N'Seafood')

insert dbo.FoodCategory
(name)
values (N'Soups and Salads')

insert dbo.FoodCategory
(name)
values (N'Main')

insert dbo.FoodCategory
(name)
values (N'Sweets')

insert dbo.FoodCategory
(name)
values (N'Drink')

-- thêm món ăn
insert dbo.Food
(name, idCategory, Price)
values (N'King crab',1,500000)

insert dbo.Food
(name, idCategory, Price)
values (N'Pumpkin Salad',2,50000)

insert dbo.Food
(name, idCategory, Price)
values (N'Pea Soup',2,550000)


insert dbo.Food
(name, idCategory, Price)
values (N'Handmade Pasta',3,200000)

insert dbo.Food
(name, idCategory, Price)
values (N'Miso Cod',3,250000)

insert dbo.Food
(name, idCategory, Price)
values (N'Chocolate Whoopie',4,25000)

insert dbo.Food
(name, idCategory, Price)
values (N'Pina Ice',4,70000)

insert dbo.Food
(name, idCategory, Price)
values (N'Beer',5,20000)

insert dbo.Food
(name, idCategory, Price)
values (N'Coca',5,15000)

--thêm Bill
insert dbo.Bill
(DateCheckIn,DateCheckOut,idTable,status)
values(GETDATE() , NULL , 1 , 0)

insert dbo.Bill
(DateCheckIn,DateCheckOut,idTable,status)
values(GETDATE() , NULL , 2 , 0)

insert dbo.Bill
(DateCheckIn,DateCheckOut,idTable,status)
values(GETDATE() , GETDATE() , 2 , 1)

-- thêm BillInfo
insert dbo.BillInfo 
(idBill, idFood,count)
values(1,1,2)

insert dbo.BillInfo 
(idBill, idFood,count)
values(1,3,4)

insert dbo.BillInfo 
(idBill, idFood,count)
values(1,5,1)

insert dbo.BillInfo 
(idBill, idFood,count)
values(2,6,2)

insert dbo.BillInfo 
(idBill, idFood,count)
values(3,5,1)

go


select * from FoodTable
select * from Food
select * from Bill
select * from BillInfo

select f.name , bi.count , f.Price, f.Price * bi.count as TotalPrice
from dbo.BillInfo as bi, dbo.Bill as b, dbo.Food as f
where bi.idBill = b.id and bi.idFood = f.id and b.idTable = 1









