-- 관리자 테이블
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
