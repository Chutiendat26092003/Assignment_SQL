
-- tạo CSDL Task04_BanHang
create database Task04_BanHang
go
-- Sử dụng CSDL Task04_BanHang
use Task04_BanHang
go
-- Tạo bảng lưu trữ thông tin khách hàng
create table Customer(
	CustomerID int primary key not null,
	CustomerName nvarchar(150) not null,
	CustomerAddress nvarchar(250) not null,
	Tel varchar(20) not null,
	CustomerStatus  nvarchar(100)
)
go
-- Tạo bảng lưu trữ sản phẩm --giá bán hiện tại 
create table Product(
	ProductID int primary key not null,
	ProductName nvarchar(200),
	Descriptions nvarchar(200),
	Unit int,
	Price money
)
alter table Product
    alter column Unit nvarchar(30)
go
-- Tạo bảng lưu trữ Đơn Hàng
create table Orders(
	OrderID int primary key not null,
	CustomerID int constraint fk_Cus foreign key (CustomerID) references Customer(CustomerID),
	OrderDate date,
	OrderStatus nvarchar(100)
)
go
-- Tạo bảng lưu trữ thông tin chi tiết Đơn hàng -- giá tại thời điểm bán 
create table OrderDetails(
	OrderID int constraint fk_Or foreign key (OrderID) references Orders(OrderID),
	ProductID int constraint fk_Pro foreign key (ProductID) references Product(ProductID),
	Price money,
	Quantity int
)
go

select * from Customer
select * from Product
select * from Orders
select * from OrderDetails

insert into Customer values (333, N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '0987654321', null)

insert into Customer values (334, N'Nguyễn Văn A', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '0987654322', null)

insert into Customer values (335, N'Nguyễn Văn Binh', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '0987654323', null)


insert into Product values (100, N'Máy Tính T450', N'Máy nhập mới', N'Chiếc', '1000'),
                           (101, N'Điện Thoại Nokia 5670', N'Điện thoại đang hot', N'Chiếc', '200'),
						   (102, N'Máy In Samsung 450', N'Máy in đang ế', N'Chiếc', '100')

insert into Orders values (200, 333, '2019-11-18', null)

insert into OrderDetails values (200, 100, '1000', 1),
                                (200, 101, '200', 2),
								(200, 100, '100', 1)

update OrderDetails set ProductID = 102 where Price = 100


-- 4
-- a
select CustomerName from Customer

--b 
select ProductID, ProductName from Product

--c
select * from Orders

--5
--a 
select * from Customer
order by CustomerName

--b 
select * from Product
order by Price desc 
 
--c
select * from Product 
where ProductID in 
(select ProductID from OrderDetails
where OrderID in
(select OrderID from Orders
where CustomerID = 333))

--6
--a 
select * from Customer 
where CustomerID in 
(select CustomerID from Orders)

--b
select * from Product 
where ProductID in 
(select ProductID from OrderDetails)

--c
alter table OrderDetails
    add SumOrder money

select Price*Quantity, sum(SumOrder) [SumOrder]
from OrderDetails
group by Price, Quantity


--7
--a
alter table Product
    add constraint ck_pri check(Price > 0)

--b
alter table Orders
    add constraint ck_Date check(OrderDate < GETDATE())

--c
alter table Product
    add AppearanceDate  date not null default(GETDATE())
