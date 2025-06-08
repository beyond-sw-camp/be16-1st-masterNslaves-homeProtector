-- 상담 게시글 등록
INSERT INTO counsel (user_id, expert_id, title, contents)
VALUES (1, 1, '전세 계약 관련', '계약 위반에 대한 조언을 듣고 싶습니다.');

-- 상담 게시글 수정
UPDATE counsel SET contents = '계약 위반 조항에 대해 자세히 알고 싶습니다.' WHERE counsel_id = 1;

-- 상담 게시글 삭제 
UPDATE counsel SET deleted_at = NOW() WHERE counsel_id = 1;

-- 상담 게시글 조회 (삭제되지 않은 항목만)
SELECT * FROM counsel WHERE deleted_at IS NULL;

-- 상담 유형별 게시글 수 조회
SELECT category, COUNT(*) AS total
FROM counsel
WHERE deleted_at IS NULL
GROUP BY category;

-- 상담 유형 목록 조회
SELECT DISTINCT category FROM counsel;

-- 상담 status별 게시글 수 조회
SELECT status, COUNT(*) AS count
FROM counsel
WHERE deleted_at IS NULL
GROUP BY status;