-- Backup procedure
DELIMITER //
CREATE PROCEDURE backup_database()
BEGIN
    -- Create backup with timestamp
    SET @backup_file = CONCAT('backup_', DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s'), '.sql');
    SET @backup_command = CONCAT(
        'mysqldump -u root -p your_database > ',
        @backup_file
    );
    
    -- Execute backup
    SYSTEM @backup_command;
END //
DELIMITER ;

-- Recovery procedure
DELIMITER //
CREATE PROCEDURE restore_database(IN backup_file VARCHAR(255))
BEGIN
    -- Restore from specified backup file
    SET @restore_command = CONCAT(
        'mysql -u root -p your_database < ',
        backup_file
    );
    
    -- Execute restore
    SYSTEM @restore_command;
END //
DELIMITER ; 