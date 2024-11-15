-- Create roles
CREATE ROLE 'administrator', 'data_analyst', 'reader';

-- Administrator role permissions
GRANT ALL PRIVILEGES ON school_db.* TO 'administrator';
GRANT CREATE USER, RELOAD, SHOW DATABASES ON *.* TO 'administrator';

-- Data Analyst role permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON school_db.* TO 'data_analyst';
REVOKE CREATE USER, RELOAD ON *.* FROM 'data_analyst';

-- Reader role permissions
GRANT SELECT ON school_db.* TO 'reader';

-- Example user creation and role assignment
CREATE USER 'admin_jane'@'localhost' IDENTIFIED BY 'secure_password123';
GRANT 'administrator' TO 'admin_jane'@'localhost';

CREATE USER 'analyst_john'@'localhost' IDENTIFIED BY 'secure_password456';
GRANT 'data_analyst' TO 'analyst_john'@'localhost';

CREATE USER 'reader_sam'@'localhost' IDENTIFIED BY 'secure_password789';
GRANT 'reader' TO 'reader_sam'@'localhost'; 