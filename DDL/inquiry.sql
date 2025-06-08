-- 질문 게시글
CREATE TABLE inquiry (		
inquiry_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,		
user_id BIGINT UNSIGNED NOT NULL,		
inquiry_title VARCHAR(255) NOT NULL,		
inquiry_contents TEXT NOT NULL,		
inquiry_created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,		
inquiry_updated_at DATETIME NULL,		
inquiry_deleted_at DATETIME NULL,		
PRIMARY KEY (inquiry_id),		
FOREIGN KEY (user_id) REFERENCES user (user_id)		
);		