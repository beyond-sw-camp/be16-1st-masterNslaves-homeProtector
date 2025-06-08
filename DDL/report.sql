-- 신고 테이블
CREATE TABLE report (		
report_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,		
user_id BIGINT UNSIGNED NOT NULL,		
post_id BIGINT UNSIGNED,		
admin_id BIGINT UNSIGNED NULL,		
reply_id BIGINT UNSIGNED,		
report_resason TEXT NOT NULL,		
report_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,		
report_status ENUM('대기중', '완료') NOT NULL DEFAULT '대기중',		
report_action VARCHAR(255) NULL,		
report_processed_at DATETIME NULL,		
PRIMARY KEY (report_id),		
FOREIGN KEY (user_id) REFERENCES user (user_id),		
FOREIGN KEY (post_id) REFERENCES post (post_id),		
FOREIGN KEY (admin_id) REFERENCES admin (admin_id),		
FOREIGN KEY (reply_id) REFERENCES reply (reply_id)		
);		