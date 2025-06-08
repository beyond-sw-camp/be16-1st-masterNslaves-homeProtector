-- 댓글 신고 프로시저
  -- reply_id 업뎃됨됨
DELIMITER $$

CREATE PROCEDURE report_reply (
    IN p_user_id BIGINT UNSIGNED,
    IN p_reply_id BIGINT UNSIGNED,
    IN p_reason TEXT
)
BEGIN
    INSERT INTO report (
        user_id,
        reply_id,
        report_resason,
        report_status,
        report_date
    ) VALUES (
        p_user_id,
        p_reply_id,
        p_reason,
        '대기중',
        NOW()
    );
END$$

DELIMITER ;
