-- 공지사항 게시글 등록 프로시저 
DELIMITER //

CREATE PROCEDURE add_notice (
    IN p_title VARCHAR(255),
    IN p_content TEXT,
    IN p_admin_id BIGINT
)
BEGIN
    DECLARE admin_exists INT;

    -- 유효한 관리자(삭제되지 않음)인지 확인
    SELECT COUNT(*) INTO admin_exists
    FROM admin
    WHERE admin_id = p_admin_id AND admin_end_at IS NULL;

    IF admin_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '삭제된 관리자이거나 존재하지 않는 관리자입니다.';
    ELSE
        INSERT INTO notice (announce_title, announce_content, admin_id)
        VALUES (p_title, p_content, p_admin_id);
    END IF;
END //

DELIMITER ;


-- 공지사항 수정 프로시저
DELIMITER //

CREATE PROCEDURE update_notice (
    IN p_notice_id BIGINT,
    IN p_title VARCHAR(255),
    IN p_content TEXT,
    IN p_admin_id BIGINT
)
BEGIN
    DECLARE admin_exists INT;

    -- 관리자 유효성 검사
    SELECT COUNT(*) INTO admin_exists
    FROM admin
    WHERE admin_id = p_admin_id AND admin_end_at IS NULL;

    IF admin_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '삭제된 관리자이거나 존재하지 않는 관리자입니다.';
    ELSE
        UPDATE notice
        SET announce_title = p_title,
            announce_content = p_content,
            announce_updated_at = NOW()
        WHERE announce_id = p_notice_id;
    END IF;
END //

DELIMITER ;


-- 공지사항 삭제 프로시저
DELIMITER //

CREATE PROCEDURE delete_notice (
    IN p_notice_id BIGINT,
    IN p_admin_id BIGINT
)
BEGIN
    DECLARE admin_exists INT;

    -- 관리자 유효성 검사
    SELECT COUNT(*) INTO admin_exists
    FROM admin
    WHERE admin_id = p_admin_id AND admin_end_at IS NULL;

    IF admin_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '삭제된 관리자이거나 존재하지 않는 관리자입니다.';
    ELSE
        UPDATE notice
        SET announce_deleted_at = NOW()
        WHERE announce_id = p_notice_id;
    END IF;
END //

DELIMITER ;

-- 공지사항 조회하기 쿼리
select * from notice where announce_deleted_at IS NULL;