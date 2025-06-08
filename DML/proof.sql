-- 전문가 증빙파일
CREATE PROCEDURE upload_proof_by_expert(
    IN p_expert_id BIGINT,
    IN p_proof_file_path VARCHAR(255)
)
BEGIN
    IF p_expert_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'expert_id는 NULL일 수 없습니다';
    END IF;

    START TRANSACTION;

    INSERT INTO proof (post_id, expert_id, proof_file_path)
    VALUES (NULL, p_expert_id, p_proof_file_path);

    COMMIT;
END//

DELIMITER ;

-- 피해게시글 증빙파일
DELIMITER //

CREATE PROCEDURE upload_proof_to_post(
    IN p_post_id BIGINT,
    IN p_proof_file_path VARCHAR(255)
)
BEGIN
    IF p_post_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'post_id는 NULL일 수 없습니다';
    END IF;

    START TRANSACTION;

    INSERT INTO proof (post_id, expert_id, proof_file_path)
    VALUES (p_post_id, NULL, p_proof_file_path);

    COMMIT;
END//

DELIMITER ;
