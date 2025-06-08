-- 댓글 테이블
CREATE TABLE reply (		
reply_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,		
post_id BIGINT UNSIGNED,		
user_id BIGINT UNSIGNED NOT NULL,		
inquiry_id BIGINT UNSIGNED,		
reply_content VARCHAR(255) NOT NULL,		
reply_created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,		
reply_modified_at TIMESTAMP NULL,		
reply_deleted_at TIMESTAMP NULL,		
reply_parent_id INT UNSIGNED NULL,		
PRIMARY KEY (reply_id),		
FOREIGN KEY (post_id) REFERENCES post (post_id),		
FOREIGN KEY (user_id) REFERENCES user (user_id),		
FOREIGN KEY (inquiry_id) REFERENCES inquiry (inquiry_id)		
);		