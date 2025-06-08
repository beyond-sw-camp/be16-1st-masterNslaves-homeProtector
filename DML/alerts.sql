-- 댓글 달기 + 알림생성
DELIMITER //

CREATE PROCEDURE add_post_comment_and_alert (
    IN p_user_id BIGINT,
    IN p_post_id BIGINT,
    IN p_reply_content VARCHAR(255)
)
BEGIN
    DECLARE post_owner_id BIGINT;

    -- 댓글 등록
    INSERT INTO reply (user_id, post_id, reply_content)
    VALUES (p_user_id, p_post_id, p_reply_content);

    -- 게시글 작성자 확인
    SELECT user_id INTO post_owner_id
    FROM post
    WHERE post_id = p_post_id;

    -- 알림: 게시글 작성자에게만 (자기 자신이 아닌 경우)
    IF post_owner_id != p_user_id THEN
        INSERT INTO alerts (user_id, post_id, notice_message)
        VALUES (post_owner_id, p_post_id, '새 댓글이 달렸습니다.');
    END IF;
END;
//

DELIMITER ;
-- 대댓글달기 + 알림생성
DELIMITER //

CREATE PROCEDURE add_reply_to_reply_on_post_and_alert (
    IN p_user_id BIGINT,
    IN p_post_id BIGINT,
    IN p_reply_parent_id BIGINT,
    IN p_reply_content VARCHAR(255)
)
BEGIN
    DECLARE parent_writer_id BIGINT;
    DECLARE parent_post_id BIGINT;
    DECLARE post_owner_id BIGINT;

    -- 부모 댓글의 게시글 ID 확인
    SELECT post_id, user_id INTO parent_post_id, parent_writer_id
    FROM reply
    WHERE reply_id = p_reply_parent_id;

    -- 부모 댓글이 해당 게시글에 달린 게 맞는지 확인
    IF parent_post_id != p_post_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '대댓글의 부모 댓글이 해당 게시글에 존재하지 않습니다.';
    END IF;

    -- 대댓글 등록
    INSERT INTO reply (
        user_id, post_id, reply_content, reply_parnet_id, reply_created_at
    ) VALUES (
        p_user_id, p_post_id, p_reply_content, p_reply_parent_id, NOW()
    );

    -- 게시글 작성자 확인
    SELECT user_id INTO post_owner_id
    FROM post
    WHERE post_id = p_post_id;

    -- 알림: 부모 댓글 작성자에게 (자기 자신이 아닌 경우)
    IF parent_writer_id != p_user_id THEN
        INSERT INTO alerts (user_id, reply_id, notice_message)
        VALUES (parent_writer_id, p_reply_parent_id, '내 댓글에 대댓글이 달렸습니다.');
    END IF;

    -- 알림: 게시글 작성자에게도 (자기 자신이 아닌 경우)
    IF post_owner_id != p_user_id AND post_owner_id != parent_writer_id THEN
        INSERT INTO alerts (user_id, post_id, notice_message)
        VALUES (post_owner_id, p_post_id, '게시글에 새로운 댓글이 달렸습니다.');
    END IF;
END;
//

DELIMITER ;

