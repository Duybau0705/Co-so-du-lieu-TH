CREATE DATABASE ThucTap; 
go
USE ThucTap; 
go
CREATE TABLE TBLKhoa 
(Makhoa char(10)primary key, 
 Tenkhoa char(30), 
 Dienthoai char(10)); 
CREATE TABLE TBLGiangVien( 
Magv int primary key, 
Hotengv char(30), 
Luong decimal(5,2), 
Makhoa char(10) references TBLKhoa); 
CREATE TABLE TBLSinhVien( 
Masv int primary key, 
Hotensv char(40), 
Makhoa char(10)foreign key references TBLKhoa, 
Namsinh int, 
Quequan char(30)); 
CREATE TABLE TBLDeTai( 
Madt char(10)primary key, 
Tendt char(30), 
Kinhphi int, 
Noithuctap char(30)); 
CREATE TABLE TBLHuongDan( 
Masv int primary key, 
Madt char(10)foreign key references TBLDeTai, 
Magv int foreign key references TBLGiangVien, 
KetQua decimal(5,2)); 
INSERT INTO TBLKhoa VALUES 
('Geo','Dia ly va QLTN',3855413), 
('Math','Toan',3855411), 
('Bio','Cong nghe Sinh hoc',3855412); 
INSERT INTO TBLGiangVien VALUES 
(11,'Thanh Binh',700,'Geo'), 
(12,'Thu Huong',500,'Math'), 
(13,'Chu Vinh',650,'Geo'), 
(14,'Le Thi Ly',500,'Bio'), 
(15,'Tran Son',900,'Math'); 
INSERT INTO TBLSinhVien VALUES 
(1,'Le Van Son','Bio',1990,'Nghe An'), 
(2,'Nguyen Thi Mai','Geo',1990,'Thanh Hoa'), 
(3,'Bui Xuan Duc','Math',1992,'Ha Noi'), 
(4,'Nguyen Van Tung','Bio',null,'Ha Tinh'), 
(5,'Le Khanh Linh','Bio',1989,'Ha Nam'), 
(6,'Tran Khac Trong','Geo',1991,'Thanh Hoa'), 
(7,'Le Thi Van','Math',null,'null'), 
(8,'Hoang Van Duc','Bio',1992,'Nghe An'); 
INSERT INTO TBLDeTai VALUES 
('Dt01','GIS',100,'Nghe An'), 
('Dt02','ARC GIS',500,'Nam Dinh'), 
('Dt03','Spatial DB',100, 'Ha Tinh'), 
('Dt04','MAP',300,'Quang Binh' ); 
INSERT INTO TBLHuongDan VALUES 
(1,'Dt01',13,8), 
(2,'Dt03',14,0), 
(3,'Dt03',12,10), 
(5,'Dt04',14,7), 
(6,'Dt01',13,Null), 
(7,'Dt04',11,10), 
(8,'Dt03',15,6);
select*from TBLSinhVien
select*from TBLDeTai
select*from TBLGiangVien
select*from TBLHuongDan
select*from TBLKhoa
select*from TBLSinhVien
Select*From Hoctap
Select magv, Hotengv, Makhoa  from TBLGiangVien
--Bai 1
Select Gv.Makhoa, Gv.Magv, Gv. Hotengv, Kh.Tenkhoa
from TBLGiangVien as Gv inner join TBLKhoa as Kh
on Gv.Makhoa=Kh.Makhoa
--Bai 2
Select Gv.Magv, Gv.Hotengv, Kh.Tenkhoa
from TBLGiangVien as Gv join TBLKhoa as Kh
on Gv.Makhoa=Kh.Makhoa
where Tenkhoa='Dia ly va QLTN'
--Bai 3
select COUNT(Masv) as 'So sinh vien khoa Cong Nghe Sinh Hoc'
from TBLSinhVien join TBLKhoa
on TBLSinhVien.Makhoa=TBLKhoa.Makhoa
where Tenkhoa='Cong nghe Sinh hoc'
--Bai 4
Select Masv, Hotensv, (2022-Namsinh)
from TBLSinhVien join TBLKhoa
on TBLSinhVien.Makhoa=TBLKhoa.Makhoa
Where Tenkhoa='Toan'
--Bai 5
Select Count('sogv') as 'So giang vien'
from TBLGiangVien join TBLKhoa
on TBLGiangVien.Makhoa=TBLKhoa.Makhoa
where Tenkhoa=('Cong nghe Sinh hoc')
--Bai 6
select Hotensv,Makhoa,Namsinh,Quequan
from(TBLHuongDan join TBLSinhVien
on TBLSinhVien.Masv=TBLHuongDan.Masv)
where KetQua is NULL
--Bai 7
Select K.Makhoa,K.Tenkhoa, Count(K.Makhoa) as 'So giang vien moi khoa'
From TBLKhoa as K join TBLGiangVien as Gv
on K.Makhoa=Gv.Makhoa
Group by K.Makhoa,K.Tenkhoa
--Bai 8
Select K.Dienthoai
From TBLKhoa as K join TBLSinhVien as Sv
on K.Makhoa=Sv.Makhoa
where Hotensv='Le van son'
--Bai 9
Select DT.Madt, DT.Tendt
From (TBLDeTai as DT join TBLHuongDan as HD on DT.Madt=HD.Madt) Join TBLGiangVien as Gv on HD.Magv=Gv.Magv
where Hotengv='Tran Son'
--Bai 10
Select TBLDeTai.Tendt From TBLDeTai
WHERE NOT EXISTS(
Select TBLHuongDan.Madt From TBLHuongDan where TBLHuongDan.Madt=TBLDeTai.Madt)
--Bai 11
Select Gv.Magv,Gv.Hotengv,KH.Tenkhoa
From (TBLGiangVien as Gv join TBLHuongDan as HD on HD.Magv=Gv.Magv) join TBLKhoa as KH on KH.Makhoa=Gv.Makhoa 
group by Gv.Magv,Gv.Hotengv,KH.Tenkhoa having COUNT(Gv.Magv)>=2

--Bai 12
Select DT.Tendt,DT.Madt 
From TBLDeTai as DT 
where DT.Kinhphi = (Select Max(Kinhphi) From TBLDeTai)
--Bai 13
Select Dt.Madt,Dt.Tendt 
From TBLDeTai as Dt
Where Dt.Madt in (Select HD.Madt From TBLHuongDan as HD Group by Madt having COUNT(Madt)>2)
--Bai 14
Select HD.Masv,Sv.Hotensv,HD.KetQua 
From (TBLSinhVien as Sv join TBLHuongDan as HD on HD.Masv=Sv.Masv) join TBLKhoa as KH on Sv.Makhoa=KH.Makhoa
Where Tenkhoa='Dia ly va QLTN'
--Bai 15
Select KH.Tenkhoa,COUNT(Sv.Masv) as 'So luong sv' From TBLKhoa as KH join TBLSinhVien as Sv on KH.Makhoa=Sv.Makhoa
Group by KH.Tenkhoa
--Bai 16
Select *
From (TBLSinhVien as Sv join TBLHuongDan as Hd on Sv.Masv=Hd.Masv) Join TBLDeTai as Dt on Dt.Madt=HD.Madt
Where Sv.Quequan=Dt.Noithuctap
--Bai 17
Select * From TBLSinhVien as Sv join TBLHuongDan as Hd on Sv.Masv=Hd.Masv
Where Hd.KetQua is null
--Bai 18
Select Sv.Masv,Sv.Hotensv
From TBLSinhVien as Sv join TBLHuongDan as Hd on Sv.Masv=Hd.Masv
Where Hd.KetQua=0
--Bai 19
SELECT * FROM TBLHuongDan
SELECT * FROM TBLHuongDan WHERE ketqua>5 or ketqua<=5
--cau tren nhan gia tri NULL, cau duoi Khong nhan NULL
--Bai 20
CREATE TABLE Hoctap(
Magv int primary key,
Hotengv char(30),
Luong decimal(5,2),
Makhoa char(10) references TBLKhoa);
--Bai 21
Select * From Hoctap 
insert into Hoctap Select * From TBLGiangVien Where Magv between 11 and 14
--22
alter table Hoctap
Add TienHoc decimal(10,2)
--
Update Hoctap
Set TienHoc=0
where Magv=11
Update Hoctap
Set TienHoc=50
where Magv=12
Update Hoctap
Set TienHoc=50
where Magv=12
Update Hoctap
Set TienHoc=100
where Magv=13
Update Hoctap
Set TienHoc=0
where Magv=14
--
Select*From Hoctap
Select*From TBLGiangVien
--23
Select Magv,Hotengv From Hoctap
Where Luong<600 or TienHoc=0
--24
Select Magv,Hotengv From Hoctap
where TienHoc>0 and Luong<600
--25
select gv.Magv,gv.Hotengv
from HocTap ht right join TBLGiangVien gv
on ht.Magv=gv.Magv
where ht.Magv is null and gv.Luong<1000



--TH--
