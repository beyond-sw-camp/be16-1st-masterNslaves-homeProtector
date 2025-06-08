-- 질문 게시글 좋아요
CREATE TABLE inquiry_like (	
like_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,	
inquiry_id BIGINT UNSIGNED NOT NULL,	
user_id BIGINT UNSIGNED NOT NULL,	
liked_created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,	
PRIMARY KEY (like_id),	
UNIQUE (inquiry_id, user_id),	
FOREIGN KEY (inquiry_id) REFERENCES inquiry (inquiry_id),	
FOREIGN KEY (user_id) REFERENCES user (user_id)	
);			
