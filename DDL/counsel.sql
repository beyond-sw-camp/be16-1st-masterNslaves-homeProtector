-- 상담 게시글 테이블
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