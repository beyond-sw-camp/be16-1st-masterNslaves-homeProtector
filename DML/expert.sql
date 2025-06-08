-- 전문가 등록
INSERT INTO expert (expert_name, contact, password, qualify_type, qualify_num, created_at)
VALUES ('김변호사', '01022223333', 'pw123', '법률', '변123456', NOW());

-- 전문가 조회
SELECT * FROM expert WHERE expert_name = '김변호사';

-- 전문가 정보 수정
UPDATE expert SET contact = '01033334444', updated_at = NOW()
WHERE expert_name = '김변호사';

-- 전문가 탈퇴 
UPDATE expert SET deleted_at = NOW() WHERE expert_name = '김변호사';

-- 전문가 활동 내역 보기(프로시저)
DELIMITER //

CREATE PROCEDURE expert_related_data(IN p_expert_id BIGINT)
BEGIN
  
  DECLARE EXIT HANDLER FOR SQLEXCEPTION     -- 예외 발생 시 롤백 처리
  BEGIN
    ROLLBACK;
  END;

  START TRANSACTION;

  
  SELECT                -- 전문가 정보 + 상담글 + 유저 + 증빙자료까지 엮어서 조회
    e.expert_id,
    e.expert_name,
    e.contact,
    c.counsel_id,
    c.title AS counsel_title,
    c.contents AS counsel_contents,
    c.created_at AS counsel_created_at,
    u.user_name,
    u.user_email,
    p.proof_id,
    p.proof_file_path
  FROM expert e
  LEFT JOIN counsel c ON c.expert_id = e.expert_id AND c.deleted_at IS NULL
  LEFT JOIN user u ON c.user_id = u.user_id
  LEFT JOIN proof p ON p.expert_id = e.expert_id
  WHERE e.expert_id = p_expert_id;

  COMMIT;
END;
//

DELIMITER ;