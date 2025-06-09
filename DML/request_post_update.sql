-- 게시글을 수정 요청 했을 때, status '수정 요청'으로 바뀌는 프로시저

DELIMITER //

CREATE PROCEDURE request_post_update (
    IN p_post_id BIGINT,
    IN p_user_id BIGINT,
    IN p_title VARCHAR(255),
    IN p_content TEXT,
    IN p_accident_number VARCHAR(255),
    IN p_accident_end_date DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '수정 요청 중 오류 발생';
    END;

    START TRANSACTION;

    UPDATE post
    SET
        post_title = p_title,
        post_content = p_content,
        post_accident_number = p_accident_number,
        post_accident_end_date = p_accident_end_date,
        post_status = '수정 요청',
        post_updated_at = NOW()
    WHERE post_id = p_post_id AND user_id = p_user_id;

    COMMIT;
END;
//