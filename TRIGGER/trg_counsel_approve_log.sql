
-- 상담 게시글 상태가 '대기중'에서 '승인'으로 바뀌었을 때만 로그 기록
DELIMITER //

CREATE TRIGGER trg_counsel_approve_log
AFTER UPDATE ON counsel                   -- counsel 테이블의 UPDATE 이후 실행
FOR EACH ROW                              -- 각 행마다 적용
BEGIN
   
    IF OLD.status = '대기중' AND NEW.status = '승인' THEN           -- 상태가 '대기중'에서 '승인'으로 바뀌었을 때만 로그 기록
        INSERT INTO log_list (
            user_id,
            action,
            entity_type,
            performed_at,
            details
        ) VALUES (
            NEW.user_id,
            '승인',
            'counsel',
            NOW(),
            CONCAT('상담 ID: ', NEW.counsel_id, '이 승인되었습니다.')
        );
    END IF;
END;
//

DELIMITER ;