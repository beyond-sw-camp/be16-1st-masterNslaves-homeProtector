-- 게시글 신고 프로시저
  -- post id 업뎃뎃
DELIMITER $$

CREATE PROCEDURE report_post (
    IN p_user_id BIGINT UNSIGNED,
    IN p_post_id BIGINT UNSIGNED,
    IN p_reason TEXT
)
BEGIN
    INSERT INTO report (
        user_id,
        post_id,
        report_resason,
        report_status,
        report_date
    ) VALUES (
        p_user_id,
        p_post_id,
        p_reason,
        '대기중',
        NOW()
    );
END$$

DELIMITER ;