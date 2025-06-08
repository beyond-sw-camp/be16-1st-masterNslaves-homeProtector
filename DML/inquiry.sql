
-- 질문 게시글 조회 쿼리
select * from inquiry;

-- 질문 게시글 생성 쿼리
insert into inquiry(user_id, inquiry_title, inquiry_contents, inquiry_created_at) values(2, '?', '?', NOW())

-- 질문 게시글 수정 쿼리
update inquiry set inquiry_title = '?', inquiry_updated_at = NOW() where user_id = 2 and inquiry_id = 2;



-- 질문 게시글 좋아요 프로시저
DELIMITER //

CREATE PROCEDURE insert_inquiry_like (
    IN p_user_id BIGINT,
    IN p_inquiry_id
     BIGINT
)
BEGIN
    DECLARE v_count INT;

    -- 1. 중복 좋아요 여부 확인
    SELECT COUNT(*) INTO v_count
    FROM inquiry_like
    WHERE user_id = p_user_id AND inquiry_id = p_inquiry_id
    ;

    -- 2. 좋아요 삽입 및 게시글 좋아요 수 증가
    IF v_count = 0 THEN
        INSERT INTO inquiry_like (user_id, inquiry_id, liked_created_at)
        VALUES (p_user_id, p_inquiry_id
        , NOW());

        UPDATE inquiry
        SET inquiry_like_count = COALESCE(inquiry_like_count, 0) + 1
        WHERE inquiry_id = p_inquiry_id
        ;
    END IF;
END //

DELIMITER ;


-- 질문 게시글 좋아요 취소 프로시저
DELIMITER //

CREATE PROCEDURE delete_inquiry_like (
    IN p_user_id BIGINT,
    IN p_inquiry_id
     BIGINT
)
BEGIN
    DECLARE v_count INT;

    -- 1. 좋아요 여부 확인
    SELECT COUNT(*) INTO v_count
    FROM inquiry_like
    WHERE user_id = p_user_id AND inquiry_id = p_inquiry_id
    ;

    -- 2. 좋아요가 존재할 경우 삭제 및 카운트 감소
    IF v_count > 0 THEN
        -- 좋아요 삭제
        DELETE FROM inquiry_like
        WHERE user_id = p_user_id AND inquiry_id = p_inquiry_id
        ;

        -- 카운트 감소 (최소값 0 보장)
        UPDATE inquiry
        SET inquiry_like_count = GREATEST(COALESCE(inquiry_like_count, 1) - 1, 0)
        WHERE inquiry_id = p_inquiry_id
        ;
    END IF;
END //

DELIMITER ;