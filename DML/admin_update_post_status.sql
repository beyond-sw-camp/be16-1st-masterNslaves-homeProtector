-- admin이 post를 승인, 반려 하는 프로시저
 -- 승인, 반려 할 경우 log_list 트리거가 자동 실행되어 log_list에 업로드

DELIMITER //

CREATE PROCEDURE admin_update_post_status (
    IN p_post_id BIGINT,
    IN p_admin_id BIGINT,
    IN p_post_status ENUM('승인', '반려'),
    IN p_rejected_reason VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '게시글 상태 변경 중 오류 발생';
    END;

    START TRANSACTION;

    -- 상태가 승인일 경우 반려 사유는 NULL로 처리
    IF p_post_status = '승인' THEN
        UPDATE post
        SET 
            post_status = p_post_status,
            post_rejected_reason = NULL,
            approve_admin = p_admin_id,
            post_updated_at = NOW()
        WHERE post_id = p_post_id;
    ELSEIF p_post_status = '반려' THEN
        UPDATE post
        SET 
            post_status = p_post_status,
            post_rejected_reason = p_rejected_reason,
            approve_admin = p_admin_id,
            post_updated_at = NOW()
        WHERE post_id = p_post_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'post_status는 승인 또는 반려만 허용됩니다';
    END IF;

    COMMIT;
END;
//

DELIMITER ;