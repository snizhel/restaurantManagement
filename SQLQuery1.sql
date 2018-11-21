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

create proc usp_InsertBill
@idTable int
as
begin
	 insert dbo.Bill(DateCheckIn,DateCheckOut,idTable,status,discount)
			values(GETDATE() , null , @idTable , 0, 0)
end
go

alter proc usp_InsertBillInfo
@idBill int, @idFood int, @count int
as
begin
	declare @isExistBillInfo int
	declare @foodCount int = 1

	select @isExistBillInfo = id, @foodCount = b.count 
	from dbo.BillInfo as b 
	where idBill = @idBill and idFood = @idFood

	if(@isExistBillInfo > 0)
		begin
			declare @newcount int = @foodCount + @count
			if(@newcount > 0)
				update dbo.BillInfo set count = @foodCount + @count
				where idFood = @idFood
			else
				delete dbo.BillInfo where idBill = @idBill and idFood = @idFood
		end
	else
		begin
			if (@count > 0)
				insert dbo.BillInfo (idBill, idFood,count)
				values(@idBill,@idFood,@count)
		end
end
go

create proc usp_SwitchTable
@idTable1 int, @idTable2 int
as
begin
	declare @idFirstBill int
	declare @idSecondBill int

	declare @isFirstTableEmpty int = 1
	declare @isSecondTableEmpty int = 1

	select @idFirstBill = id from dbo.Bill where idTable = @idTable1 and status = 0
	select @idSecondBill = id from dbo.Bill where idTable = @idTable2 and status = 0

	if(@idFirstBill is NULL)
	begin
		insert dbo.Bill(DateCheckIn,DateCheckOut,idTable,status)
		values(GETDATE() , null , @idTable1 , 0)

		select @idFirstBill = MAX(id) from dbo.Bill
		where idTable = @idTable1 and status = 0
	end
	select @isFirstTableEmpty = count(*) from dbo.BillInfo where idBill = @idFirstBill

	if(@idSecondBill is NULL)
	begin
		insert dbo.Bill(DateCheckIn,DateCheckOut,idTable,status)
		values(GETDATE() , null , @idTable2 , 0)

		select @idSecondBill = MAX(id) from dbo.Bill
		where idTable = @idTable2 and status = 0
	end
	select @isSecondTableEmpty = count(*) from dbo.BillInfo where idBill = @idSecondBill

	select id into IdBillInfoTable from dbo.BillInfo where idBill = @idSecondBill

	update dbo.BillInfo set idBill = @idSecondBill where idBill = @idFirstBill
	 
	update dbo.BillInfo set idBill = @idFirstBill where id in (select * from IdBillInfoTable)

	drop table IdBillInfoTable
	
	if(@isFirstTableEmpty = 0)
		update dbo.FoodTable set status = N'NULL' where id = @idTable2
	 if(@isSecondTableEmpty = 0)
		update dbo.FoodTable set status = N'NULL' where id = @idTable1
end
go

exec usp_SwitchTable @idTable1 = 3, @idTable2 = 5

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
 (UserName,DisplayName,PassWord,Type)
 values
 (N'KT',N'Kthinhsg21',N'1',1)

 insert into dbo.Account
 (UserName,DisplayName,PassWord,Type)
 values
 (N'Employee',N'Employee123',N'1',0)

 insert into dbo.Account
 (UserName,DisplayName,PassWord,Type )
 values
 (N'Admin',N'Admin1',N'Admin',1)


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

insert dbo.Bill
(DateCheckIn,DateCheckOut,idTable,status)
values(GETDATE() , GETDATE() , 3 , 1)

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

create trigger UTG_UpdateBillInfo
on dbo.BillInfo for insert, update
as
begin
	declare @idBill int
	select @idBill = idBill  from inserted

	declare @idTable int
	select @idTable = idTable 
	from dbo.Bill 
	where id = @idBill and status = 0

	declare @count int
	select @count = count(*) from dbo.BillInfo where idBill = @idBill

	if(@count > 0)
	begin
		update dbo.FoodTable set status = N'Order' where id = @idTable
	end
	else
	begin
		update dbo.FoodTable set status = N'NULL' where id = @idTable
	end	
end
go

create trigger UTG_UpdateBill
on dbo.Bill for update
as
begin
	declare @idBill int

	select @idBill = id 
	from inserted

	declare @idTable int
	select @idTable = idTable 
	from dbo.Bill 
	where id = @idBill 

	declare @count int = 0
	select @count = count (*)
	from dbo.Bill 
	where idTable = @idTable and status = 0

	if(@count = 0)
		update dbo.FoodTable set status = N'NULL'
		where id = @idTable
end
go



alter table dbo.Bill
add discount int

update dbo.Bill set discount = 0

select * from BillInfo
select * from Bill
select * from FoodTable
select * from Food

select f.name , bi.count , f.Price, f.Price * bi.count as TotalPrice
from dbo.BillInfo as bi, dbo.Bill as b, dbo.Food as f
where bi.idBill = b.id and bi.idFood = f.id 

delete BillInfo
delete Bill




