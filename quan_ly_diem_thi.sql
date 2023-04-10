create database QuanLyDiemThi;
use QuanLyDiemThi;
create table hocsinh(
	maHS varchar(20) primary key,
    tenHS varchar(50),
    ngaysinh datetime,
    lop varchar(20),
    gt varchar(20)
);

create table monhoc(
	maMH varchar(20) primary key,
    tenMH varchar(50)
);

create table bangdiem(
	maHS varchar(20),
    maMH varchar(20),
    diemthi int,
    ngayKT datetime,
    primary key (maHS, maMH),
    foreign key (maHS) references hocsinh(maHS),
    foreign key (maMH) references monhoc(maMH)
);

create table giaovien(
	maGV varchar(20),
    tenGV varchar(50),
    sdt varchar(10)
);

alter table monhoc add maGV varchar(20);
/*
ALTER TABLE monHoc ADD CONSTRAINT FK_maGV FOREIGN KEY (maGV) REFERENCES giaovien(maGV);
*/