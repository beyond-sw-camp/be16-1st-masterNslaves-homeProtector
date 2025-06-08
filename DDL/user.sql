-- 유저 테이블
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