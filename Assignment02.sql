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
	QuantityAvailable int,
	CompanyID int foreign key references ProductCompany(CompanyID),
	TypeID int foreign key references ProductType(TypeID)
)
go

create table ProductType(
    TypeID int primary key,
	TypeName nvarchar(100),
)
go 

create table ProductCompanyProductType(
     
)

--3
insert into ProductCompany values (123, N'Asus', N'USA', '0983232'),
                                  (333, N'Apple', N'Việt Nam', '0932321111')

insert into ProductType values (50, N'Điện Thoại'),
                                  (51, N'Máy Tính'),
								  (52, N'Máy In')

insert into Product values (1000, N'Máy Tính T450', N'Máy nhập cũ',N'Chiếc', 1000, 10, 123, 51),
                           (1001, N'Điện Thoại Nokia5670', N'Điện thoại đang hot',N'Chiếc', 200, 200, 123, 50),
						   (1002, N'Máy In Samsung 450', N'Máy in đang loại bình',N'Chiếc', 100, 10, 123, 52),
						   (1003, N'Iphone 13', N'Đẹp Meli',N'Chiếc', 2000, 100, 333, 50),
						   (1004, N'Iphone 13 Promax', N'Nặng',N'Chiếc', 3000, 100, 333, 50)


--4
select * from ProductCompany
select * from Product
select * from ProductType

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
inner join ProductCompany on ProductCompany.CompanyID = Product.CompanyID
where  CompanyName =  N'Asus' 

--6
--a Số hãng sản phẩm mà cửa hàng có
select COUNT(CompanyID) AS 'CompanyNumber'
from ProductCompany


--b Số mặt hàng mà cửa hàng bán
select COUNT(ProductID) AS 'ProductNumber'
from Product

--c Tổng số loại sản phẩm của mỗi hãng có trong cửa hàng
select COUNT(TypeID) AS 'ProductNumber'
from ProductType

--d Tổng số đầu sản phẩm của toàn cửa hàng
select COUNT(ProductID) AS 'ProductNumber'
from Product

--7
--a
alter table Product
     add constraint ck_Pr check(Price > 0)

--b
alter table ProductCompany
     add constraint ck_T check(left(Tel,1)= '0')

--8
--a 
CREATE INDEX IX_ProductName ON  dbo.Product(ProductName)

CREATE INDEX IX_Descriptions ON  dbo.Product(Descriptions)

--b
CREATE VIEW View_SanPham AS
SELECT ProductID, ProductName, Price FROM dbo.Product

CREATE VIEW View_SanPham_Hang AS
SELECT ProductID, ProductName, CompanyName
FROM dbo.Product
JOIN dbo.ProductCompany ON ProductCompany.CompanyID = Product.CompanyID

--c
CREATE PROCEDURE SP_SanPham_TenHang
    @TenHang int 
AS 
SELECT * FROM  dbo.Product
WHERE CompanyID = @TenHang



CREATE PROCEDURE SP_SanPham_Gia
    @Gia int 
AS 
SELECT * FROM  dbo.Product
WHERE Price >= @Gia



CREATE PROCEDURE SP_SanPham_HetHang 
    @hethang int 
AS 
SELECT * FROM  dbo.Product
WHERE QuantityAvailable = @hethang


--d
CREATE TRIGGER TG_Xoa_Hang
ON ProductCompany
INSTEAD OF DELETE 
AS 
BEGIN 
    DELETE FROM dbo.ProductCompany  WHERE CompanyID IN (SELECT CompanyID FROM deleted)
END

CREATE TRIGGER TG_Xoa_SanPham
ON Product
FOR DELETE 
AS 
    BEGIN 
	     IF EXISTS(SELECT * FROM inserted WHERE QuantityAvailable > 0)
		 BEGIN
		     PRINT 'Chua ban het'
			 ROLLBACK TRANSACTION
		 END
    END
GO
