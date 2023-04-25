-- Hiển thị danh sách tất cả các học viên
select * from student;

-- Hiển thị danh sách các học viên đang theo học
select * from student
where Status = true;

-- Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ 
select * from subject
where credit < 10;

-- Hiển thị danh sach học viên lớp A1
select st.StudentId, st.StudentName, st.Address, st.Phone
from student st
join class cl on st.ClassId = cl.ClassID
where cl.ClassName = 'A1';

-- Hiển thị điểm môn CF của các học viên
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';


-- Hiển thị tất cả các sinh viên có tên bắt đầu bằng ký tự 'h'
select * from student
where StudentName like 'h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12
select * from class
where month(StartDate) = 12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5
select * from subject
where credit between 3 and 5;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';

-- Hiển thị các thông tin: StudentName, SubName, Mark. 
-- Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select distinct st.StudentName, sj.SubName, mk.Mark
from student st
join mark mk on st.StudentId = mk.StudentId
join subject sj on mk.SubId = sj.SubId
order by mk.mark desc, st.StudentName asc ;
	
