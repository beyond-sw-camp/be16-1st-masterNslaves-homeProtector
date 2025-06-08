-- 피해게시글등록 + 부동산정도 + 사기유형형
DELIMITER //

CREATE PROCEDURE insert_post_with_property_and_fraud_types (
    IN p_user_id BIGINT,
    IN p_address VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_latitude DECIMAL(9,6),
    IN p_longitude DECIMAL(9,6),
    IN p_accident_number VARCHAR(255),
    IN p_accident_end_date DATETIME,
    IN p_title VARCHAR(255),
    IN p_content TEXT,
    IN p_fraud_ids JSON  -- 예: '[1,2,4]'
)
BEGIN
    DECLARE v_properties_id BIGINT;
    DECLARE v_post_id BIGINT;
    DECLARE v_index INT DEFAULT 0;
    DECLARE v_fraud_id BIGINT;
    DECLARE v_total INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '게시글 및 사기유형 등록 중 오류 발생';
    END;

    START TRANSACTION;

    -- 1. 부동산 정보 삽입 (중복 무시)
    INSERT IGNORE INTO properties (
        properties_address, properties_name, properties_latitude, properties_longitude
    )
    VALUES (
        p_address, p_name, p_latitude, p_longitude
    );

    -- 2. 해당 부동산 ID 조회
    SELECT properties_id INTO v_properties_id
    FROM properties
    WHERE properties_address = p_address
      AND properties_name = p_name
      AND properties_latitude = p_latitude
      AND properties_longitude = p_longitude;

    -- 3. 게시글 삽입
    INSERT INTO post (
        user_id, properties_id, post_accident_number, post_accident_end_date,
        post_title, post_content, post_created_at
    ) VALUES (
        p_user_id, v_properties_id, p_accident_number, p_accident_end_date,
        p_title, p_content, NOW()
    );

    -- 4. post_id 가져오기
    SET v_post_id = LAST_INSERT_ID();

    -- 5. JSON 배열에서 fraud_id 하나씩 꺼내서 연결
    SET v_total = JSON_LENGTH(p_fraud_ids);
    WHILE v_index < v_total DO
        SET v_fraud_id = CAST(JSON_UNQUOTE(JSON_EXTRACT(p_fraud_ids, CONCAT('$[', v_index, ']'))) AS UNSIGNED);
        INSERT INTO fraud_type_connect (post_id, fraud_id)
        VALUES (v_post_id, v_fraud_id);
        SET v_index = v_index + 1;
    END WHILE;

    COMMIT;
END;
//

DELIMITER ;
-- 피해게시글 수정
DELIMITER //

CREATE PROCEDURE update_post (
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
        SET MESSAGE_TEXT = '피해 게시글 수정 중 오류 발생';
    END;

    START TRANSACTION;

    -- 게시글 수정
    UPDATE post
    SET
        post_title = p_title,
        post_content = p_content,
        post_accident_number = p_accident_number,
        post_accident_end_date = p_accident_end_date,
        post_updated_at = NOW()
    WHERE post_id = p_post_id AND user_id = p_user_id;

    COMMIT;
END;
//

DELIMITER ;
-- 피해게시글 삭제
DELIMITER //

CREATE PROCEDURE delete_post_soft (
    IN p_post_id BIGINT,
    IN p_user_id BIGINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '피해 게시글 삭제 중 오류 발생';
    END;

    START TRANSACTION;

    -- 게시글 소유자 확인 및 삭제 처리 (soft delete)
    UPDATE post
    SET post_deleted_at = NOW()
    WHERE post_id = p_post_id AND user_id = p_user_id;

    -- 삭제 반영 여부 확인
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '게시글이 존재하지 않거나 삭제 권한이 없습니다.';
    END IF;

    COMMIT;
END;
//

DELIMITER ;

