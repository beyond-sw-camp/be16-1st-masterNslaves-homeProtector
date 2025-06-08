-- 피해 게시글
CREATE TABLE post (		
post_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,		
user_id BIGINT UNSIGNED NOT NULL,		
properties_id BIGINT UNSIGNED NOT NULL,		
post_accident_number VARCHAR(255) NOT NULL,		
post_accident_end_date DATETIME NOT NULL,		
post_title VARCHAR(255) NOT NULL,		
post_content TEXT NOT NULL,		
post_status ENUM('대기중', '승인', '반려') NOT NULL DEFAULT '대기중',		
post_created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,		
post_updated_at DATETIME NULL,		
post_deleted_at DATETIME NULL,		
post_rejected_reason VARCHAR(255) NULL,		
post_like_count INT UNSIGNED NULL,		
approve_admin BIGINT UNSIGNED NULL,		
PRIMARY KEY (post_id),		
FOREIGN KEY (user_id) REFERENCES user (user_id),		
FOREIGN KEY (properties_id) REFERENCES properties (properties_id)		
);		