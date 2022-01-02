use Assignment
go

--Tạo bảng Lưu dánh sách người dùng
create table NguoiDung(
    MaND int primary key not null,
	TenND nvarchar(150),
	NgaySinh datetime,
	Diachi nvarchar(200)
)

--Tạo bảng Lưu các số điện thoại của người dùng
create table SoDTNG(
    MaSDT int primary key not null,
	SoDT int,
	MaND int foreign key references  NguoiDung(MaND)
)

--3
insert into NguoiDung values (1, N'Nguyễn Văn An', '1987-11-18', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội'),
                             (2, N'Nguyễn Phú Quý', '1999-1-26', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội')

insert into SoDTNG values (1000, 0987654321, 1),
                          (1001, 0987345222, 1),
						  (1002, 0983232333, 1),
						  (1003, 0983232366, 1),
						  (1004, 0987611111, 2),
						  (1005, 0987658888, 2),
						  (1006, 0986362636, 2),
						  (1007, 0988888666, 2),
						  (1008, 0966225522, 2)

--4
select * from NguoiDung
select * from SoDTNG

--5
select * from NguoiDung
order by TenND

select TenND, SoDT from NguoiDung
inner join SoDTNG on SoDTNG.MaND = NguoiDung.MaND
where TenND = N'Nguyễn Văn An'

select * from NguoiDung
where NgaySinh = '1987-11-18'

--6
select MaND, COUNT(MaSDT) as SLSDT
from SoDTNG
group by MaND

select COUNT(MaND) as SinhThang12
from NguoiDung
where MONTH(NgaySinh) = 11
group by MaND


select TenND, NgaySinh, Diachi, SoDT from NguoiDung
inner join SoDTNG on SoDTNG.MaND = NguoiDung.MaND



select TenND, NgaySinh, Diachi, SoDT from NguoiDung
inner join SoDTNG on SoDTNG.MaND = NguoiDung.MaND
where SoDT = 0987654321

--7
alter table NguoiDung
    add constraint ck_Ngay05 check(NgaySinh <=  getdate())

alter table NguoiDung
    add NgayBDLienLac datetime
