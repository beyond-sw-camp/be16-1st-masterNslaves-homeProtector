-- 증명자료 테이블
CREATE TABLE proof (	
proof_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,	
post_id BIGINT UNSIGNED NOT NULL,	
expert_id BIGINT UNSIGNED NOT NULL,	
proof_file_path VARCHAR(255) NOT NULL,	
PRIMARY KEY (proof_id),	
FOREIGN KEY (post_id) REFERENCES post (post_id),	
FOREIGN KEY (expert_id) REFERENCES expert (expert_id)	
);	