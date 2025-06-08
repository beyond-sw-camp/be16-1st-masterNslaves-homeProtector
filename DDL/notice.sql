-- 공지사항 테이블
CREATE TABLE notice (	
announce_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,	
admin_id BIGINT UNSIGNED NOT NULL,	
announce_title VARCHAR(255) NOT NULL,	
announce_content TEXT NOT NULL,	
announce_post_file VARCHAR(255) NULL,	
announce_create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,	
announce_updated_at DATETIME NULL,	
announce_deleted_at DATETIME NULL,	
PRIMARY KEY (announce_id),	
FOREIGN KEY (admin_id) REFERENCES admin (admin_id)	
);	