-- 전체 테이블 한번에 생성 쿼리.
--- 찬진
-- 유저 생성 테이블
CREATE TABLE user (	
user_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,	
user_name VARCHAR(255) NOT NULL,	
user_email VARCHAR(255) NOT NULL UNIQUE,	
user_password VARCHAR(255) NOT NULL,	
user_age INT UNSIGNED NOT NULL,	
user_phone_number VARCHAR(255) NOT NULL UNIQUE,	
user_gender VARCHAR(255) NOT NULL,	
user_created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,	
user_deleted_at DATETIME NULL,	
user_modified_at DATETIME NULL,	
PRIMARY KEY (user_id)	
);	

-- 관리자 생성 테이블
CREATE TABLE admin (			
admin_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,			
admin_name VARCHAR(255) NOT NULL,			
admin_email VARCHAR(255) NOT NULL,			
admin_password VARCHAR(255) NOT NULL,			
admin_com_num VARCHAR(255) NOT NULL,			
admin_created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,			
admin_end_at DATETIME NULL,			
PRIMARY KEY (admin_id)			
);			

-- 부동산 정보
CREATE TABLE properties (		
properties_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,		
properties_address VARCHAR(255) NOT NULL,		
properties_name VARCHAR(255) NULL,		
properties_latitude DECIMAL(9,6) NULL,		
properties_longitude DECIMAL(9,6) NULL,		
PRIMARY KEY (properties_id)		
);		

-- 전문가 테이블
CREATE TABLE expert (	
expert_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,	
expert_name VARCHAR(255) NOT NULL,	
contact VARCHAR(255) NOT NULL,	
password VARCHAR(255) NOT NULL,	
qualify_type VARCHAR(255) NOT NULL,	
qualify_num VARCHAR(255) NOT NULL,	
created_at DATETIME NOT NULL,	
updated_at DATETIME NULL,	
deleted_at DATETIME NULL,	
PRIMARY KEY (expert_id)	
);	

-- 사기 타입 테이블
CREATE TABLE fraud_type (			
fraud_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,			
fraud_type VARCHAR(255) NOT NULL,			
PRIMARY KEY (fraud_id)			
);			

-- 피해 게시글 테이블
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

-- 질문 게시글 테이블
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

-- 상담 테이블
CREATE TABLE counsel (		
counsel_id BIGINT NOT NULL AUTO_INCREMENT,		
user_id BIGINT UNSIGNED NOT NULL,		
expert_id BIGINT UNSIGNED NOT NULL,		
title VARCHAR(255) NOT NULL,		
contents TEXT NOT NULL,		
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,		
updated_at DATETIME NULL,		
deleted_at DATETIME NULL,		
category ENUM('법률', '공인중개사') NOT NULL DEFAULT '법률',		
status ENUM('대기중', '승인') NOT NULL DEFAULT '대기중',		
PRIMARY KEY (counsel_id),		
FOREIGN KEY (user_id) REFERENCES user (user_id),		
FOREIGN KEY (expert_id) REFERENCES expert (expert_id)		
);	

-- 우영
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

-- 증빙자료 테이블
CREATE TABLE proof (	
proof_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,	
post_id BIGINT UNSIGNED NOT NULL,	
expert_id BIGINT UNSIGNED NOT NULL,	
proof_file_path VARCHAR(255) NOT NULL,	
PRIMARY KEY (proof_id),	
FOREIGN KEY (post_id) REFERENCES post (post_id),	
FOREIGN KEY (expert_id) REFERENCES expert (expert_id)	
);	

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
report_action VARCHAR(255) NOT NULL,		
report_processed_at DATETIME NULL,		
PRIMARY KEY (report_id),		
FOREIGN KEY (user_id) REFERENCES user (user_id),		
FOREIGN KEY (post_id) REFERENCES post (post_id),		
FOREIGN KEY (admin_id) REFERENCES admin (admin_id),		
FOREIGN KEY (reply_id) REFERENCES reply (reply_id)		
);		

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

-- 로그 테이블
CREATE TABLE log_list (	
log_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,	
user_id BIGINT UNSIGNED NOT NULL,	
action VARCHAR(255) NOT NULL,	
entity_type VARCHAR(255) NOT NULL,	
performed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,	
details VARCHAR(255) NULL,	
PRIMARY KEY (log_id),	
FOREIGN KEY (user_id) REFERENCES user (user_id)	
);	

-- 피해 게시글 좋아요 테이블
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

-- 질문 게시글 좋아요 테이블
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

-- 사기 유형 연결 테이블
CREATE TABLE fraud_type_connect (			
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,			
post_id BIGINT UNSIGNED NOT NULL,			
fraud_id BIGINT UNSIGNED NOT NULL,			
PRIMARY KEY (id),			
FOREIGN KEY (post_id) REFERENCES post (post_id),			
FOREIGN KEY (fraud_id) REFERENCES fraud_type (fraud_id)			
);			
