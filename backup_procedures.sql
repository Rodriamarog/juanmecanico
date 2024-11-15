DELIMITER //

CREATE PROCEDURE backup_database()
BEGIN
    -- Solo generamos el nombre del archivo y mostramos el comando que se debería ejecutar
    SELECT CONCAT(
        'Para hacer backup, ejecuta este comando en la terminal: mysqldump -u root -p juanmecanico > backup_',
        DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s'),
        '.sql'
    ) AS backup_command;
END //

CREATE PROCEDURE restore_database(IN backup_file VARCHAR(255))
BEGIN
    -- Mostramos el comando que se debería ejecutar
    SELECT CONCAT(
        'Para restaurar, ejecuta este comando en la terminal: mysql -u root -p juanmecanico < ',
        backup_file
    ) AS restore_command;
END //

DELIMITER ;