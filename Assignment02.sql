create database Assignment
go

use Assignment
go

-- Tạo bảng lưu các hãng của CT
create table ProductCompany(
    CompanyID int primary key not null,
	CompanyName nvarchar(50),
	Address  nvarchar(200),
	Tel varchar(20)
)
go

-- Tạo bảng lưu sản phẩm của các hãng 
create table Product(
	ProductID int primary key not null,
	ProductName nvarchar(200),
	Descriptions nvarchar(200),
	Unit nvarchar(30),
	Price money,
	QuantityAvailable int
)
go

create table ProductCompanyProduct(
    CompanyID int foreign key references ProductCompany(CompanyID),
	ProductID int foreign key references Product(ProductID)
)

--3
insert into ProductCompany values (123, N'Asus', N'USA', '983232'),
                                  (333, N'Apple', N'Việt Nam', '0932321111')

insert into Product values (1000, N'Máy Tính T450', N'Máy nhập cũ',N'Chiếc', 1000, 10),
                           (1001, N'Điện Thoại Nokia5670', N'Điện thoại đang hot',N'Chiếc', 200, 200),
						   (1002, N'Máy In Samsung 450', N'Máy in đang loại bình',N'Chiếc', 100, 10),
						   (1003, N'Iphone 13', N'Đẹp Meli',N'Chiếc', 2000, 100),
						   (1004, N'Iphone 13 Promax', N'Nặng',N'Chiếc', 3000, 100)

insert into ProductCompanyProduct values (123, 1000),
                                         (123, 1001),
										 (123, 1002),
										 (333, 1003),
										 (333, 1004)

--4
select * from ProductCompany
select * from Product
select * from ProductCompanyProduct

--5
--a
select * from ProductCompany
order by CompanyName desc 

--b
select * from Product
order by Price desc 

--c
select * from ProductCompany
where CompanyName = N'Asus' 

--d
select * from Product
where QuantityAvailable < 11

--e
select CompanyName, ProductName from Product
inner join ProductCompanyProduct on Product.ProductID = ProductCompanyProduct.ProductID
inner join ProductCompany on ProductCompanyProduct.CompanyID = ProductCompany.CompanyID
where  CompanyName =  N'Asus' 

--6
--a Số hãng sản phẩm mà cửa hàng có





