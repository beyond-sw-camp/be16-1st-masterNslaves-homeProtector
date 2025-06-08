-- 사기유형 연결 테이블 (이중계약, 보증금 미반환, 건물 등기 위조)
CREATE TABLE fraud_type_connect (			
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,			
post_id BIGINT UNSIGNED NOT NULL,			
fraud_id BIGINT UNSIGNED NOT NULL,			
PRIMARY KEY (id),			
FOREIGN KEY (post_id) REFERENCES post (post_id),			
FOREIGN KEY (fraud_id) REFERENCES fraud_type (fraud_id)			
);			
