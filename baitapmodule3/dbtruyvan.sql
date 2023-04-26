-- Ví dụ 1: Với mỗi bộ môn, cho biết tên bộ môn và số lượng giáo viên của bộ môn đó
select bm.tenbm, (select count(*)
from giaovien gv 
where gv.mabm = bm.mabm) as slgv
from bomon bm;
 
 -- Ví dụ 2: Cho biết họ tên và lương của các giáo viên bô môn HTTT
 select gv.hoten, gv.luong
 from ( select magv, hoten, luong 
 from giaovien
 where mabm = 'HTTT') as gv;
 
 -- VD3: Cho biết những giáo viên có lương lớn hơn lương của giáo viên có MAGV = '001'
 select gv.hoten, gv.luong
 from giaovien gv
 where luong > (select luong from giaovien where magv = '001');
 
 -- VD4: Cho biết họ tên những giáo viên mà không có một người thân nào
 select gv.hoten
 from giaovien gv
 where magv not in (select magv from nguoithan);
 
 
 -- VD5: Cho những giáo viên có tham đề tài
 select gv.hoten
 from giaovien gv
 where magv in (select magv from thamgiadt);
 
-- VD6: Cho những giáo viên có lương nhỏ nhất

select * 
from giaovien gv1
where gv1.luong <= ALL (select gv2.luong from giaovien gv2);
 
-- VD7: Cho những giáo viên có lương cao hơn tất cả các giáo viên của bộ môn HTTT
select * from giaovien
where luong > all(select luong from giaovien where mabm = 'HTTT');

-- VD8: Cho biết bộ môn (MABM) có đông giáo viên nhất 
select mabm from giaovien
group by mabm 
having count(*) >= ALL( select count(*) from giaovien group by mabm);

-- VD9: Cho biết họ tên những giáo viên mà không có một người thân nào (sử dụng all)
select hoten from giaovien
where giaovien.magv != all (select magv from nguoithan) ;

-- VD10: Cho biết họ tên những giáo viên có tham gia đề tài (sử dụng ANY)
select hoten from giaovien
where magv = any(select magv from thamgiadt);

-- VD11: Cho biết các giáo viên có tham gia đề tài
select hoten
from giaovien
where exists(select * from thamgiadt
where thamgiadt.magv = giaovien.magv);

-- VD12: Cho biết các giáo viên không có người thân
select hoten from giaovien
where not exists(select * from nguoithan
where nguoithan.magv = giaovien.magv);

-- VD14: Cho biết những giáo viên có lương lớn hơn lương trung bình của bộ môn mà giáo viên đó làm việc
select hoten from giaovien gv1
where gv1.luong > (select avg(gv2.luong) from giaovien gv2 where gv2.mabm = gv1.mabm);

-- VD15: Cho biết những giáo viên có lương lớn nhất
select hoten from giaovien
where luong >= all(select luong from giaovien);

-- VD16: Cho biết những đề tài mà giáo viên 001 không tham gia
select madt from detai
where not exists(select * from thamgiadt where thamgiadt.madt = detai.MADT and magv = '001');

-- VD17: Cho biết họ tên những giáo viên có vai trò quản lý về mặt chuyên môn với các giáo viên khác
select gv1.hoten from giaovien gv1
where exists(select * from giaovien gv2 where gv2.gvqlcm = gv1.magv);

-- VD18: cho biết những giáo viên có lương cao nhất;
select hoten from giaovien
where luong >= (select max(luong) from giaovien);

-- VD19: Cho biết những bộ môn (MABM) có đông giáo viên nhất
select mabm, count(*) as slgv from giaovien
group by mabm having count(*) = (select max(slgv) from
								(select count(*) as slgv from giaovien
                                group by mabm) as temp);
                                
/** VD20: Cho biết những tên bộ môn, họ tên của trưởng bộ môn và số
lượng giáo viên của bộ môn có đông giáo viên nhất **/  
select bm.tenbm, gv.hoten, count(*) as slgv
from giaovien gv, bomon bm, giaovien tbm
where gv.mabm = bm.mabm and bm.TRUONGBM = tbm.magv
group by gv.MABM, tbm.hoten
having count(*) >= all (select count(*)
						from giaovien
                        group by mabm);

/** VD21: Cho biết những giáo viên có lương lớn hơn mức lương trung bình của 
giáo viên bộ môn HTTT mà không trực thuộc bộ môn HTTT **/
select hoten from giaovien
where luong > (select avg(luong) from giaovien where mabm = 'HTTT');

-- VD22: Cho tên đề tài có đông giáo viên tham gia nhất