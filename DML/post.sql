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
    IN p_fraud_ids JSON
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

    -- 1. 부동산 정보 삽입
    INSERT IGNORE INTO properties (
        properties_address, properties_name, properties_latitude, properties_longitude
    ) VALUES (
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
END //

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

DELIMITER //

-- 주소 검색시 피해게시글 조회회
CREATE PROCEDURE search_posts_by_address(IN input_address VARCHAR(255))
BEGIN
SELECT
p.post_id,
p.post_title,
p.post_content,
p.post_created_at,
pr.properties_id,
pr.properties_address,
pr.properties_name
FROM
post p
INNER JOIN
properties pr ON p.properties_id = pr.properties_id
WHERE
pr.properties_address LIKE CONCAT('%', input_address, '%');
END //

DELIMITER ;

-- 승인된 게시글
SELECT
    p.post_id,
    p.post_title,
    p.post_content,
    p.post_created_at,
    u.user_name,
    pr.properties_address,
    pr.properties_name,
    f.fraud_type
FROM post p
JOIN user u ON p.user_id = u.user_id
JOIN properties pr ON p.properties_id = pr.properties_id
LEFT JOIN fraud_type_connect fc ON p.post_id = fc.post_id
LEFT JOIN fraud_type f ON fc.fraud_id = f.fraud_id
WHERE p.post_status = '승인'
  AND p.post_deleted_at IS NULL
ORDER BY p.post_created_at DESC;

-- 승인된 게시글 주소조회
DELIMITER //

CREATE PROCEDURE search_posts_by_address(IN input_address VARCHAR(255))
BEGIN
    SELECT
        p.post_id,
        p.post_title,
        p.post_content,
        p.post_created_at,
        pr.properties_id,
        pr.properties_address,
        pr.properties_name
    FROM post p
    INNER JOIN properties pr ON p.properties_id = pr.properties_id
    WHERE pr.properties_address LIKE CONCAT('%', input_address, '%')
      AND p.post_status = '승인'; 
END //

DELIMITER ;

-- 댓글에 달린 대댓글 조회
SELECT 
    r.reply_id,
    r.reply_content,
    r.reply_created_at,
    u.user_name
FROM reply r
JOIN user u ON r.user_id = u.user_id
WHERE r.reply_parent_id = 1
  AND r.reply_deleted_at IS NULL
ORDER BY r.reply_created_at;

-- 활성화된 사용자 조회
SELECT
    user_id,
    user_name,
    user_email,
    user_phone_number,
    user_age,
    user_gender,
    user_created_at
FROM user
WHERE user_deleted_at IS NULL;