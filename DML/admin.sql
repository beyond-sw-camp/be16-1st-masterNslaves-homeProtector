-- 관리자 등록하기
insert into admin(admin_name, admin_email, admin_password, admin_com_num, admin_created_at) 
values('관리자1', 'kkd0250@gmail.com', '1234pw', '124121', NOW())

-- 관리자 수정하기
update admin set admin_name ='하위 관리자' where admin_email ='kkd0250@gmail.com'

-- 관리자 탈퇴하기
update set admin admin_end_at = NOW() where admin_email = 'kkd0250@gmail.com'

-- 관리자 조회하기
select * from admin where admin_email = ?;