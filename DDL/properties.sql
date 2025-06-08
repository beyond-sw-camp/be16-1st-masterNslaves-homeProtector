-- 부동산 정보
CREATE TABLE properties (		
properties_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,		
properties_address VARCHAR(255) NOT NULL,		
properties_name VARCHAR(255) NULL,		
properties_latitude DECIMAL(9,6) NULL,		
properties_longitude DECIMAL(9,6) NULL,		
PRIMARY KEY (properties_id)		
);		