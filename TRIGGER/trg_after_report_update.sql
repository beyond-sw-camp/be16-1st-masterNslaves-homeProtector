-- report 상태 완료 및 처리 시 로그에 저장

DELIMITER //

CREATE TRIGGER trg_after_report_update
AFTER UPDATE ON report
FOR EACH ROW
BEGIN
    DECLARE v_target_user_id BIGINT;

    SET v_target_user_id = NEW.user_id;

    -- POST 신고 처리
    IF NEW.post_id IS NOT NULL THEN

        IF NEW.report_status = '완료' AND OLD.report_status != '완료' THEN
            -- 게시글 논리 삭제
            UPDATE post
            SET post_deleted_at = NOW()
            WHERE post_id = NEW.post_id;

            -- 로그 기록
            INSERT INTO log_list (
                user_id, action, entity_type, performed_at, details
            ) VALUES (
                v_target_user_id,
                '완료',
                'post_report',
                NOW(),
                CONCAT('post_id=', NEW.post_id, '이 완료 처리되어 삭제됨. 사유: ', NEW.report_action)
            );

        ELSEIF NEW.report_status = '반려' AND OLD.report_status != '반려' THEN
            -- 게시글 반려 처리
            UPDATE post
            SET post_status = '반려'
            WHERE post_id = NEW.post_id;

            -- 로그 기록
            INSERT INTO log_list (
                user_id, action, entity_type, performed_at, details
            ) VALUES (
                v_target_user_id,
                '반려',
                'post_report',
                NOW(),
                CONCAT('post_id=', NEW.post_id, '이 반려 처리됨. 사유: ', NEW.report_action)
            );
        END IF;

    -- REPLY 신고 처리
    ELSEIF NEW.reply_id IS NOT NULL THEN

        IF NEW.report_status = '완료' AND OLD.report_status != '완료' THEN
            -- 댓글 논리 삭제
            UPDATE reply
            SET reply_deleted_at = NOW()
            WHERE reply_id = NEW.reply_id;

            -- 로그 기록
            INSERT INTO log_list (
                user_id, action, entity_type, performed_at, details
            ) VALUES (
                v_target_user_id,
                '완료',
                'reply_report',
                NOW(),
                CONCAT('reply_id=', NEW.reply_id, '이 완료 처리되어 삭제됨. 사유: ', NEW.report_action)
            );

        ELSEIF NEW.report_status = '반려' AND OLD.report_status != '반려' THEN
            -- 댓글 반려 로그만 기록
            INSERT INTO log_list (
                user_id, action, entity_type, performed_at, details
            ) VALUES (
                v_target_user_id,
                '반려',
                'reply_report',
                NOW(),
                CONCAT('reply_id=', NEW.reply_id, '이 반려 처리됨. 사유: ', NEW.report_action)
            );
        END IF;

    END IF;
END$$

DELIMITER ;
 