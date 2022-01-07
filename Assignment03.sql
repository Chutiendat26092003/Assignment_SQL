﻿use Assignment
go

--Tạo Bảng KhachHang
create  table KhachHang(
    MaKH int primary key not null,
	TenKH nvarchar(150),
    SoCMT int,
    DiaChi nvarchar(200)
)
go


--Tạo Bảng SoTBCT
create table SoTBCT(
    MaTBHC int primary key not null, --mã TB hiện có 
	SoTB char(12),
    LoaiTB nvarchar(100)
)
go


--Tạo Bảng DKThueBao
create table DKThueBao(
    MaTBDK int primary key not null, --mã TB đăng ký 
	NgayDK datetime,
	MaKH int foreign key references KhachHang(MaKH),
	MaTBHC int foreign key references SoTBCT(MaTBHC)
)
go

--3
insert into KhachHang values (101, N'Nguyễn Nguyệt Nga', 123456789, N'Hà Nội'),
                             (102, N'Chu Tiến Đạt', 001203043509, N'Hà Nội')

insert into SoTBCT values (1001, 0123456789, N'Trả trước'),
                          (1002, 0123456888, N'Trả trước'),
                          (1003, 0923456888, N'Trả trước'),
                          (1004, 0323456888, N'Trả trước'),
                          (1005, 0323459999, N'Trả trước'),
                          (1006, 0323452222, N'Trả trước'),
                          (1007, 0323451111, N'Trả trước')
						  

insert into DKThueBao values (2001, '2012/12/02', 101, 1001),
                             (2002, '2015/02/02', 101, 1002),
							 (2003, '2017/05/02', 102, 1005),
							 (2004, '2020/09/02', 102, 1007)
                             

--4
select * from KhachHang
select * from DKThueBao
select * from SoTBCT

--5
select * from SoTBCT
where SoTB = 0123456789

select * from KhachHang
where SoCMT = 123456789

select TenKH, SoTB from KhachHang
inner join DKThueBao on KhachHang.MaKH = DKThueBao.MaKH
inner join SoTBCT on DKThueBao.MaTBHC = SoTBCT.MaTBHC
where SoCMT = 123456789

select * from DKThueBao
where NgayDK = '2012/12/02'

select TenKH, SoTB, DiaChi from KhachHang
inner join DKThueBao on KhachHang.MaKH = DKThueBao.MaKH
inner join SoTBCT on DKThueBao.MaTBHC = SoTBCT.MaTBHC
where DiaChi =  N'Hà Nội'

--6
select COUNT(MaKH) as SoKHDK
from KhachHang

select COUNT(MaTBHC) as SoTBCuaCT
from SoTBCT

select COUNT(MaTBDK) as 'TBDKNgay2012/12/02'
from DKThueBao
where NgayDK = '2012/12/02'

select  TenKH, SoCMT, DiaChi, SoTB as 'SoTBDKThanhCong'  from KhachHang
inner join DKThueBao on KhachHang.MaKH = DKThueBao.MaKH
inner join SoTBCT on DKThueBao.MaTBHC = SoTBCT.MaTBHC

--7
alter table DKThueBao 
    add constraint nn_Ngay  not null

alter table DKThueBao 
    add constraint ck_Ngay check(NgayDK <= getdate())

alter table SoTBCT
     add check(left(SoTB,1)= '0')

alter table SoTBCT
    add DiemThuong int 
