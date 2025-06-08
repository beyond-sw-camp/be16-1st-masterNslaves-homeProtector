DELIMITER // -- 회원등록

CREATE PROCEDURE register_user (
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_age INT UNSIGNED,
    IN p_phone VARCHAR(255),
    IN p_gender VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '회원가입 중 오류가 발생했습니다.';
    END;

    START TRANSACTION;

    -- 이메일 중복 확인
    IF EXISTS (
        SELECT 1 FROM user WHERE user_email = p_email
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '이미 사용 중인 이메일입니다.';
    END IF;

    -- 전화번호 중복 확인
    IF EXISTS (
        SELECT 1 FROM user WHERE user_phone_number = p_phone
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '이미 사용 중인 전화번호입니다.';
    END IF;

    -- 회원 등록
    INSERT INTO user (
        user_name,
        user_email,
        user_password,
        user_age,
        user_phone_number,
        user_gender
    ) VALUES (
        p_name,
        p_email,
        p_password,
        p_age,
        p_phone,
        p_gender
    );

    COMMIT;
END;
//

DELIMITER ;

-- 회원정보수정
DELIMITER // 
CREATE PROCEDURE update_user_info (
    IN p_user_id BIGINT,
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_age INT,
    IN p_phone VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '회원 정보 수정 중 오류 발생';
    END;

    START TRANSACTION;

    -- 전화번호 중복 체크 (자기 자신 제외)
    IF EXISTS (
        SELECT 1 FROM user
        WHERE user_phone_number = p_phone AND user_id != p_user_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '이미 등록된 전화번호입니다.';
    END IF;

    -- 이메일 중복 체크 (자기 자신 제외)
    IF EXISTS (
        SELECT 1 FROM user
        WHERE user_email = p_email AND user_id != p_user_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '이미 등록된 이메일입니다.';
    END IF;

    -- 사용자 정보 수정
    UPDATE user
    SET
        user_name = p_name,
        user_email = p_email,
        user_age = p_age,
        user_phone_number = p_phone,
        user_password = p_password,
        user_modified_at = NOW()
    WHERE user_id = p_user_id;

    COMMIT;
END;
//

DELIMITER ;

-- 회원삭제제

DELIMITER //

CREATE PROCEDURE withdraw_user (
    IN p_user_id BIGINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '회원 탈퇴 중 오류 발생';
    END;

    START TRANSACTION;

    -- 회원 존재 여부 확인
    IF EXISTS (SELECT 1 FROM user WHERE user_id = p_user_id) THEN

        -- 탈퇴 처리 (소프트 삭제)
        UPDATE user
        SET user_deleted_at = NOW()
        WHERE user_id = p_user_id;

        COMMIT;

    ELSE
        -- 존재하지 않는 회원일 경우 예외 발생
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '해당 회원이 존재하지 않습니다.';
    END IF;

END;
//

DELIMITER ;
