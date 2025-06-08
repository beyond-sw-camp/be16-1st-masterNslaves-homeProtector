-- 상담테이블 로그 목록 조회
SELECT
    log_id,
    user_id,
    action,
    entity_type,
    performed_at,
    details
FROM log_list
WHERE entity_type = 'counsel'
ORDER BY performed_at DESC;

