-- 상담테이블 로그 목록 조회
SELECT
    log_id,
    user_id,
    action,
    entity_type,
    performed_at,
    details
FROM log_list
WHERE entity_type = 'counsel'
ORDER BY performed_at DESC;



-- counsel table status 승인으로 바뀔 시에만 log_list에 기록
DELIMITER //

CREATE PROCEDURE approve_counsel_status_log (
    IN p_counsel_id BIGINT,
    IN p_user_id BIGINT,
    IN p_new_status ENUM('대기중', '승인')
)
BEGIN
    DECLARE v_old_status ENUM('대기중', '승인');

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    
    SELECT status INTO v_old_status     -- 기존 상태 조회
    FROM counsel
    WHERE counsel_id = p_counsel_id;

    
    UPDATE counsel                      -- 상태 변경
    SET status = p_new_status,
        updated_at = NOW()
    WHERE counsel_id = p_counsel_id;

   
    IF v_old_status = '대기중' AND p_new_status = '승인' THEN    -- 상태가 '대기중' → '승인' 으로 바뀌었을 때만 로그 기록
        INSERT INTO log_list (
            user_id,
            action,
            entity_type,
            performed_at,
            details
        ) VALUES (
            p_user_id,
            '승인',
            'counsel',
            NOW(),
            CONCAT('상담 ID: ', p_counsel_id, '이 승인되었습니다.')
        );
    END IF;

    COMMIT;
END;
//

DELIMITER ;