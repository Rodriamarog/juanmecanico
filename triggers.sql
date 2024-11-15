DELIMITER //

-- Trigger para validar asignaciones
CREATE TRIGGER validar_asignacion
BEFORE INSERT ON asignacion
FOR EACH ROW
BEGIN
    -- Validar que el empleado no tenga otra asignación en la misma fecha
    IF EXISTS (
        SELECT 1 FROM asignacion 
        WHERE ID_Empleado = NEW.ID_Empleado 
        AND Fecha_Inicio = NEW.Fecha_Inicio
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El empleado ya tiene una asignación en esta fecha';
    END IF;

    -- Validar que la orden de trabajo exista y esté activa
    IF NOT EXISTS (
        SELECT 1 FROM orden_trabajo 
        WHERE ID_Orden_Trabajo = NEW.ID_Orden_Trabajo
        AND Fecha_Salida IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La orden de trabajo no existe o ya está completada';
    END IF;

    -- Validar que el servicio exista
    IF NOT EXISTS (
        SELECT 1 FROM servicio 
        WHERE ID_Servicio = NEW.ID_Servicio
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El servicio especificado no existe';
    END IF;
END //

DELIMITER ; 