use Assignment
go

-- Tạo bảng loại SP
create table LoaiSP(
    MaLoaiSp char(20)primary key not null,
	TenloaiSp nvarchar(200)
)
go

-- Tạo bảng Người Chịu Trách Nhiệm
create table NCTN(
    MaNCTN int primary key not null,
	TenNCTN nvarchar(200)
)
go

-- Tạo bảng loại SP
create table SanPham(
    MaSP char(20) primary key not null,
	NgaySX datetime,
	TenSP nvarchar(200),
	MaLoaiSp char(20) foreign key references LoaiSP(MaLoaiSp),
	MaNCTN int foreign key references NCTN(MaNCTN)
)
go

-- Tạo bảng mối liên hệ nhiều nhiều
create table NCTNLoaiSP(
	MaNCTN int foreign key references NCTN(MaNCTN),
	MaLoaiSp char(20) foreign key references LoaiSP(MaLoaiSp)   
)
go

--3
insert into LoaiSP values ('Z37E', N'Máy tính sách tay Z37'),
                          ('IP22', N'Điện thoại IPhone'),
						  ('AS21', N'Máy In Asus')

insert into NCTN values (987688, N'Nguyễn Văn An'),
                        (187688, N'Nguyễn Văn Tùng'),
						(587688, N'Nguyễn Bách Khoa')

insert into SanPham values ('Z37 111111', '2012-12-09', N'Máy tính Dell Vostro 15 3000', 'Z37E', 987688),
                           ('Z37 111122', '2012-12-09', N'Máy tính Dell Vostro 3888', 'Z37E', 587688),
						   ('IP22 232323', '2012-12-09', N'IPhone 13 512GB', 'IP22', 187688),
						   ('IP22 155551', '2012-12-09', N'IPhone 13 Promax 512GB', 'IP22', 187688),
						   ('AS21 999111', '2012-12-09', N'Máy in đa chức năng HP LaserJet Pro MFP M135w ', 'AS21', 587688),
						   ('AS21 111661', '2012-12-09', N'Máy in HP LaserJet Pro M107w', 'AS21', 987688),
						   ('AS21 255811', '2012-12-09', N'Máy in HP Neverstop Laser 1000w', 'AS21', 587688)

insert into NCTNLoaiSP values (987688, 'Z37E'),
                              (987688, 'AS21'),
							  (587688, 'Z37E'),
							  (587688, 'AS21'),
							  (187688, 'IP22')

--4
select * from LoaiSP
select * from NCTN
select * from SanPham
select * from NCTNLoaiSP

--5
select * from LoaiSP
order by TenloaiSp 

select * from NCTN
order by TenNCTN

select * from SanPham
where MaLoaiSp = 'Z37E'

select * from SanPham
where MaNCTN in
(select MaNCTN from NCTN
where TenNCTN = N'Nguyễn Văn An')
order by MaSP desc

--6
select MaloaiSp, COUNT(MaSP) as SoSP from SanPham
group by MaloaiSp

select MaSP, NgaySX, TenSP, MaNCTN, TenloaiSp
from SanPham inner join LoaiSP on LoaiSP.MaLoaiSp = SanPham.MaLoaiSp

select MaSP, NgaySX, TenSP, TenNCTN, TenloaiSp
from SanPham inner join LoaiSP on LoaiSP.MaLoaiSp = SanPham.MaLoaiSp 
inner join NCTN on NCTN.MaNCTN = SanPham.MaNCTN

--7
alter table SanPham
    add constraint ck_Ngay04 check(NgaySX <= getdate())

alter table SanPham
    add PhienBan nvarchar(100)