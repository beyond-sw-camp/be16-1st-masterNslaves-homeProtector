-- 알림 테이블
CREATE TABLE alerts (	
notice_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,	
user_id BIGINT UNSIGNED NOT NULL,	
reply_id BIGINT UNSIGNED NULL,	
post_id BIGINT UNSIGNED NULL,	
inquiry_id BIGINT UNSIGNED NULL,	
notice_message TEXT NULL,	
notice_isread VARCHAR(255) NULL,	
PRIMARY KEY (notice_id),	
FOREIGN KEY (user_id) REFERENCES user (user_id),	
FOREIGN KEY (reply_id) REFERENCES reply (reply_id),	
FOREIGN KEY (post_id) REFERENCES post (post_id),	
FOREIGN KEY (inquiry_id) REFERENCES reply (inquiry_id)	
);	