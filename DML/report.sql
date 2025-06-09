-- adminn이 report게시글 완료 반려 프로시저
DELIMITER //

CREATE PROCEDURE admin_update_report_status (
    IN p_report_id BIGINT,
    IN p_admin_id BIGINT,
    IN p_report_status ENUM('완료', '반려'),
    IN p_report_action VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '신고 상태 변경 중 오류 발생';
    END;

    START TRANSACTION;

    -- 상태 확인 및 처리
    IF p_report_status IN ('완료', '반려') THEN
        UPDATE report
        SET 
            report_status = p_report_status,
            report_action = p_report_action,
            admin_id = p_admin_id,
            report_processed_at = NOW()
        WHERE report_id = p_report_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'report_status는 완료 또는 반려만 허용됩니다';
    END IF;

    COMMIT;
END //

DELIMITER ;