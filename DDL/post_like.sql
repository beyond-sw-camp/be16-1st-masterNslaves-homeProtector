-- 피해 게시글 좋아요
CREATE TABLE post_like (			
like_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,			
post_id BIGINT UNSIGNED NOT NULL,			
user_id BIGINT UNSIGNED NOT NULL,			
liked_created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,			
PRIMARY KEY (like_id),			
UNIQUE (post_id, user_id),			
FOREIGN KEY (post_id) REFERENCES post (post_id),			
FOREIGN KEY (user_id) REFERENCES user (user_id)			
);	