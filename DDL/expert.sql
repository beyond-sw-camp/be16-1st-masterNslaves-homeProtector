-- 전문가 테이블
CREATE TABLE expert (	
expert_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,	
expert_name VARCHAR(255) NOT NULL,	
contact VARCHAR(255) NOT NULL,	
password VARCHAR(255) NOT NULL,	
qualify_type VARCHAR(255) NOT NULL,	
qualify_num VARCHAR(255) NOT NULL UNIQUE,	
created_at DATETIME NOT NULL,	
updated_at DATETIME NULL,	
deleted_at DATETIME NULL,	
PRIMARY KEY (expert_id)	
);	