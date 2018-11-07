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
	status nvarchar(100) not null default N'NULL'
 )
 Go

 create table Account
 (
 	UserName nvarchar(100) primary key,
	DisplayName nvarchar(100) not null default N'KT',
	PassWord nvarchar(1000) not null default 0,
	Type int not null default 0
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
	status int not null default 0

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

create PROC USP_GetAccountByUserName
@userName varchar(100)
as
begin
	select * from dbo.Account where UserName = @userName
end
go

exec dbo.USP_GetAccountByUserName @userName = N'KT'

