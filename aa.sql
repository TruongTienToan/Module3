-- Câu 1: Cho biết số lượng giáo viên của toàn trường
select count(*) as soluonggiaovien
from giaovien;

-- câu 2: cho biết số lượng giáo viên của bộ môn HTTT
select count(*) as soluonggiaovienHTTT
from giaovien
where MABM = 'HTTT';

-- câu 3: Tính số lượng giáo viên có người quản lý về mặt chuyên môn
select count(*) as SLGVconguoiquanly
from  giaovien
where GVQLCM is NOT NULL;

-- câu 4: Tính số lượng giáo viên làm nhiệm vụ quản lý chuyên môn cho giáo viên khác mà thuộc bộ môn HTTT.
select count(*) as SLGVQLCMthuocHTTT
from giaovien
where GVQLCM is NOT NULL and MABM = 'HTTT';

-- câu 5: Tính lương trung bình của giáo viên bộ môn Hệ thống thông tin
select avg(giaovien.LUONG) 
from giaovien
where MABM = 'HTTT';


/* DÙNG GROUP BY */
-- câu 6: Với mỗi bộ môn cho biết bộ môn (MAMB) và số lượng giáo viên của bộ môn đó.
select MABM, count(*) as soluonggiaovien
from giaovien
group by MABM;

-- câu 7: Với mỗi giáo viên, cho biết MAGV và số lượng công việc mà giáo viên đó tham gia
select giaovien.MAGV, count(*) as soluongcongviec, giaovien.HOTEN
from giaovien
left join thamgiadt on giaovien.MAGV = thamgiadt.MAGV
group by giaovien.MAGV;