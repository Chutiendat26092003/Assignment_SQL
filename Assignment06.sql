USE Assignment
GO

-- Tạo Bảng Nhà xuất bản 
CREATE TABLE NhaXB(
    MaNXB int primary key not null,
	TenNXB nvarchar(150),
	DiaChiNXB nvarchar(200)
)

-- Tạo Bảng Loại Sách
CREATE TABLE LoaiSach(
    MaLS int primary key not null,
	TenLS nvarchar(150)
)

-- Tạo Bảng Tác Giả 
CREATE TABLE TacGia(
    MaTG CHAR(10) primary key not null,
	TenTG nvarchar(150)
)

-- Tạo Bảng Sách
CREATE TABLE Sach(
    MaSach char(10) primary key not null,
	TenSach nvarchar(200),
	NDTT nvarchar(1000),
	NamXB datetime,
	LanXB int,
	GiaBan money,
	SoLuong int,
	MaTG CHAR(10) foreign key references  TacGia(MaTG),
	MaNXB int foreign key references  NhaXB(MaNXB),
	MaLS int foreign key references  LoaiSach(MaLS)
)

-- Tạo Bảng mqh nhiều nhiều 



--2
INSERT INTO NhaXB VALUES (1, N'Tri Thức', N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội'),
                         (2, N'Kim Đồng', N'55 Quang Trung, Hai Bà Trưng, Hà Nội'),
						 (3, N'Hội Nhà văn', N' Số 65 Nguyễn Du, Hà Nội')

INSERT INTO LoaiSach VALUES (2000, N'Khoa học xã hội'),
                            (2001, N'Văn học nghệ thuật'),
							(2002, N'Truyện, tiểu thuyết'),
							(2003, N'Thiếu Nhi')

INSERT INTO TacGia VALUES ('T01', N'Eran Katz'),
                          ('T02', N'Carl Sagan'),
                          ('T03', N'John Steinbeck'),
                          ('T04',  N'Dale Carnegie'),
                          ('T05', N'Albert Camus'),
                          ('T06', N'Frank Herbert'),
                          ('T07',  N'L.M. Montgomery')


INSERT INTO Sach VALUES ('B001', N'Trí tuệ Do Thái', N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốctrí tuệ của họ xuất phát từ đâu không?', '2010', 1, 79000, 100, 'T01', 1, 2000),
                        ('B002', N'Vũ trụ', N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốctrí tuệ của họ xuất phát từ đâu không?', '2000', 15, 80000, 100, 'T02', 1, 2000),
						('B003', N'Phía Đông vườn Địa đàng', N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốctrí tuệ của họ xuất phát từ đâu không?', '2010', 1, 81000, 100, 'T03', 2, 2003),
						('B004', N'Đắc nhân tâm', N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốctrí tuệ của họ xuất phát từ đâu không?', '2015', 2, 82000, 100, 'T04', 2, 2001),
						('B005', N'Người xa lạ', N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốctrí tuệ của họ xuất phát từ đâu không?', '2010', 5, 83000, 100, 'T05', 3, 2002),
						('B006', N'Xứ cát ', N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốctrí tuệ của họ xuất phát từ đâu không?', '2010', 1, 84000, 100, 'T06', 3, 2002),
						('B007', N'Anne tóc đỏ dưới chái nhà xanh', N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốctrí tuệ của họ xuất phát từ đâu không?', '2020', 4, 85000, 100, 'T07', 3, 2003)


								 
SELECT * FROM NhaXB
SELECT * FROM LoaiSach
SELECT * FROM Sach
SELECT * FROM TacGia


--3
select * from Sach
where YEAR(NamXB) > 2008

--4
select top 3 GiaBan as Top5
from Sach
Order by GiaBan desc 

--5  những cuốn sách có tiêu đề chứa từ “Trí tuệ”
SELECT * FROM dbo.Sach
WHERE TenSach LIKE N'Trí%tuệ%'

--6 cuốn sách có tên bắt đầu với chữ “T” theo thứ tự giá giảm dần
SELECT * FROM dbo.Sach
WHERE TenSach LIKE 'T%'
ORDER BY TenSach DESC

--7 cuốn sách của nhà xuất bản Tri thức
SELECT * FROM dbo.Sach
WHERE MaNXB IN
(SELECT MaNXB FROM dbo.NhaXB
WHERE TenNXB = N'Tri Thức')

--8 Lấy thông tin chi tiết về nhà xuất bản xuất bản cuốn sách “Trí tuệ Do Thái”
SELECT * FROM dbo.Sach
WHERE TenSach = N'Trí tuệ Do Thái'

--9 thông tin sau về các cuốn sách: Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản, Loại sách
SELECT MaSach, TenSach, NamXB, TenNXB, TenLS 
FROM dbo.Sach 
INNER JOIN dbo.NhaXB ON NhaXB.MaNXB = Sach.MaNXB
INNER JOIN dbo.LoaiSach ON LoaiSach.MaLS = Sach.MaLS

--10 cuốn sách có giá bán đắt nhất
SELECT MaSach, TenSach, MAX(GiaBan) AS GiaMax
FROM dbo.Sach
GROUP BY MaSach, TenSach

--11 cuốn sách có số lượng lớn nhất trong kho
SELECT MaSach, TenSach, MAX(SoLuong) AS GiaMax
FROM dbo.Sach
GROUP BY MaSach, TenSach

--12 các cuốn sách của tác giả “Eran Katz”
SELECT * FROM dbo.Sach
WHERE MaTG IN
(SELECT MaTG FROM dbo.TacGia
WHERE TenTG = N'Eran Katz')

--13 Giảm giá bán 10% các cuốn sách xuất bản từ năm 2008 trở về trước
UPDATE dbo.Sach
SET GiaBan = GiaBan*90/100
WHERE YEAR(NamXB ) < 2008;
SELECT * FROM dbo.Sach

--14 Thống kê số đầu sách của mỗi nhà xuất bản
SELECT MaNXB, COUNT(MaSach) AS TongDauSach
FROM dbo.Sach
GROUP BY MaNXB

--15 Thống kê số đầu sách của mỗi loại sách
SELECT MaLS, COUNT(MaSach) AS TongDauSach
FROM dbo.Sach
GROUP BY MaLS