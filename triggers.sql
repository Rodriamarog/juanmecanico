DELIMITER //

-- Stored procedure for sales
CREATE PROCEDURE registrar_venta(
    IN p_total DECIMAL(10,2),
    IN p_metodo_pago VARCHAR(50)
)
BEGIN
    DECLARE v_venta_id VARCHAR(6);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al procesar la venta';
    END;

    START TRANSACTION;

    -- Generate new sale ID
    SELECT COALESCE(MAX(CAST(SUBSTRING(ID_Venta, 1) AS UNSIGNED)), 0) + 1 
    INTO @next_id 
    FROM ventas;
    
    SET v_venta_id = @next_id;

    -- Register the sale
    INSERT INTO ventas (ID_Venta, Fecha, Total, Metodo_Pago)
    VALUES (v_venta_id, CURDATE(), p_total, p_metodo_pago);

    -- Generate audit log
    INSERT INTO ventas_audit_log (
        ID_Venta,
        Fecha_Registro,
        Accion,
        Total,
        Metodo_Pago
    ) VALUES (
        v_venta_id,
        NOW(),
        'VENTA_NUEVA',
        p_total,
        p_metodo_pago
    );

    COMMIT;

    -- Return the new sale ID
    SELECT v_venta_id AS ID_Venta;
END //

DELIMITER ; 