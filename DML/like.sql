-- 피해게시글 좋아요
DELIMITER //

CREATE PROCEDURE insert_post_like (
    IN p_user_id BIGINT,
    IN p_post_id BIGINT
)
BEGIN
    DECLARE v_count INT;

    -- 1. 중복 좋아요 여부 확인
    SELECT COUNT(*) INTO v_count
    FROM post_like
    WHERE user_id = p_user_id AND post_id = p_post_id;

    -- 2. 좋아요 삽입 및 게시글 좋아요 수 증가
    IF v_count = 0 THEN
        INSERT INTO post_like (user_id, post_id, liked_created_at)
        VALUES (p_user_id, p_post_id, NOW());

        UPDATE post
        SET post_like_count = COALESCE(post_like_count, 0) + 1
        WHERE post_id = p_post_id;
    END IF;
END;
//

DELIMITER ;
-- 피해게시글 좋아요 취소
DELIMITER //

CREATE PROCEDURE delete_post_like (
    IN p_user_id BIGINT,
    IN p_post_id BIGINT
)
BEGIN
    DECLARE v_count INT;

    -- 1. 좋아요 여부 확인
    SELECT COUNT(*) INTO v_count
    FROM post_like
    WHERE user_id = p_user_id AND post_id = p_post_id;

    -- 2. 좋아요가 존재할 경우 삭제 및 카운트 감소
    IF v_count > 0 THEN
        -- 좋아요 삭제
        DELETE FROM post_like
        WHERE user_id = p_user_id AND post_id = p_post_id;

        -- 좋아요 수 감소 (최소 0 보장)
        UPDATE post
        SET post_like_count = GREATEST(COALESCE(post_like_count, 1) - 1, 0)
        WHERE post_id = p_post_id;
    END IF;
END;
//

DELIMITER ;
