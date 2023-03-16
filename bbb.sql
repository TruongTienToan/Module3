use quan_ly_kho;
create table phieu_xuat(
so_phieu_xuat int primary key,
ngay_xuat date
);
create table vat_tu(
ma_vat_tu int primary key,
ten_vat_tu varchar(50)
);
create table chi_tiet_phieu_xuat(
don_gia_xuat double,
so_luong_xuat int,
so_phieu_xuat int,
ma_vat_tu int,
primary key (so_phieu_xuat, ma_vat_tu),
foreign key (so_phieu_xuat) references phieu_xuat(so_phieu_xuat),
foreign key (ma_vat_tu) references vat_tu(ma_vat_tu)
);
create table phieu_nhap(
so_phieu_nhap int primary key,
ngay_nhap date
);
create table chi_tiet_phieu_nhap(
don_gia_nhap double,
so_luong_nhap int,
ma_vat_tu int,
so_phieu_nhap int,
primary key (ma_vat_tu,so_phieu_nhap),
foreign key (ma_vat_tu) references vat_tu(ma_vat_tu),
foreign key (so_phieu_nhap) references phieu_nhap(so_phieu_nhap)
);
create table nha_cung_cap(
ma_nha_cung_cap int primary key,
ten_nha_cung_cap varchar(50),
dia_chi varchar(50)
);
create table so_dien_thoai(
so_dien_thoai int primary key,
foreign key (so_dien_thoai) references nha_cung_cap(ma_nha_cung_cap)
);
create table don_dat_hang(
so_dat_hang int primary key,
ngay_dat_hang date,
foreign key (so_dat_hang) references nha_cung_cap(ma_nha_cung_cap)
);
create table chi_tiet_don_dat_hang(
ma_vat_tu int,
so_dat_hang int,
primary key (ma_vat_tu, so_dat_hang),
foreign key (ma_vat_Tu) references vat_tu(ma_vat_tu),
foreign key (so_dat_hang) references don_dat_hang(so_dat_hang)
);
insert into phieu_xuat(so_phieu_xuat,ngay_xuat) values (1,"2023-9-9");
insert into phieu_xuat(so_phieu_xuat,ngay_xuat) values (2,"2023-10-10");
insert into phieu_xuat(so_phieu_xuat,ngay_xuat) values (3,"2023-11-11");
insert into vat_tu(ma_vat_tu,ten_vat_tu) values (1,"tivi");
insert into vat_tu(ma_vat_tu,ten_vat_tu) values (2,"tu lanh");
insert into vat_tu(ma_vat_tu,ten_vat_tu) values (3,"may giac");
insert into chi_tiet_phieu_xuat(don_gia_xuat,so_luong_xuat,so_phieu_xuat,ma_vat_Tu) values (1,5,1,2);
insert into chi_tiet_phieu_xuat(don_gia_xuat,so_luong_xuat,so_phieu_xuat,ma_vat_Tu) values (2,10,1,3);
insert into chi_tiet_phieu_xuat(don_gia_xuat,so_luong_xuat,so_phieu_xuat,ma_vat_Tu) values (3,20,2,3);
insert into phieu_nhap(so_phieu_nhap,ngay_nhap) values (1,"2023-5-15");
insert into phieu_nhap(so_phieu_nhap,ngay_nhap) values (2,"2022-6-15");
insert into phieu_nhap(so_phieu_nhap,ngay_nhap) values (3,"2022-7-15");
insert into chi_tiet_phieu_nhap(don_gia_nhap,so_luong_nhap,ma_vat_tu,so_phieu_nhap) values (1,11,1,2);
insert into chi_tiet_phieu_nhap(don_gia_nhap,so_luong_nhap,ma_vat_tu,so_phieu_nhap) values (2,22,2,3);
insert into chi_tiet_phieu_nhap(don_gia_nhap,so_luong_nhap,ma_vat_tu,so_phieu_nhap) values (3,33,3,2);
insert into nha_cung_cap(ma_nha_cung_cap,ten_nha_cung_cap,dia_chi) values (1,"aa","quang binh");
insert into nha_cung_cap(ma_nha_cung_cap,ten_nha_cung_cap,dia_chi) values (2,"bb","quang tri");
insert into nha_cung_cap(ma_nha_cung_cap,ten_nha_cung_cap,dia_chi) values (3,"cc","hue");
insert into so_dien_thoai(so_dien_thoai) values ("1");
insert into so_dien_thoai(so_dien_thoai) values ("2");
insert into so_dien_thoai(so_dien_thoai) values ("3");
insert into don_dat_hang(so_dat_hang,ngay_dat_hang) values (1,"2023-1-1");
insert into don_dat_hang(so_dat_hang,ngay_dat_hang) values (2,"2023-2-2");
insert into don_dat_hang(so_dat_hang,ngay_dat_hang) values (3,"2023-3-3");
insert into chi_tiet_don_dat_hang(ma_vat_tu,so_dat_hang) values (2,3);
insert into chi_tiet_don_dat_hang(ma_vat_tu,so_dat_hang) values (3,1);
insert into chi_tiet_don_dat_hang(ma_vat_tu,so_dat_hang) values (1,1);