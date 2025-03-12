USE rrhh

/*EJ 1 Crear un procedimiento para añadir un atributo "total_empleados" a la tabla departamentos:
Debe calcular el número de empleados en cada departamento y actualizar el valor de total_empleados en la tabla departamentos.
Si un departamento no tiene empleados, el valor será 0.*/
DELIMITER //

CREATE PROCEDURE totalEmpleados()
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_NAME = 'departamentos' 
                   AND COLUMN_NAME = 'total_empleados') THEN
        ALTER TABLE departamentos ADD COLUMN total_empleados INT DEFAULT 0;
    END IF;
    UPDATE departamentos SET total_empleados = 0;
    UPDATE departamentos
    SET departamentos.total_empleados = (
        SELECT COUNT(*)
        FROM empleados
        WHERE empleados.departamento = departamentos.coddpto
    );

END //

DELIMITER ;

/*EJ 2 Escribe un procedimiento que determine si hay empleados sin jefe (jefe = NULL):
El procedimiento debe devolver un mensaje indicando "Existen empleados sin jefe" o "Todos los empleados tienen jefe asignado".*/
delimiter //

CREATE PROCEDURE sinJefe()
BEGIN
    DECLARE contador INT;

    SELECT COUNT(*) INTO contador
    FROM empleados
    WHERE jefe IS NULL;
    
    IF contador > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Existen empleados sin jefe.';
    END IF;
    
END //

delimiter ;

/*EJ 3 Crea un procedimiento que recibe un codigo de departamento y muestra la cantidad de empleados del departamento.
Si no existe el departamento o no hay empleados en el mismo, mostrará un mensaje de error.*/
delimiter //
CREATE PROCEDURE sinDpt(IN idDpt INT)
BEGIN
    DECLARE contador INT;

    SELECT COUNT(*) INTO contador
    FROM empleados
    WHERE departamento = idDpt;

    IF contador <= 0 THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay empleados en el departamento';
    END IF;
END //
delimiter ;

/*EJ 4 Crea un procedimiento que reciba un parámetro de salida con la categorización de empleados por departamento.
Si un departamento tiene menos de 3 empleados: "Departamento pequeño".
Si tiene entre 3 y 5 empleados: "Departamento mediano".
Si tiene más de 5 empleados: "Departamento grande".*/
delimiter //
CREATE PROCEDURE dptSize(OUT idDpt INT)
BEGIN
    DECLARE contador INT;

    SELECT COUNT(*) INTO contador
    FROM empleados
    WHERE departamento =  idDpt;

    IF contador < 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Peq';
    ELSEIF contador = 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Med';
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gra';
    END IF;
END //
delimiter ;

/*EJ 6 Crea un trigger que actualice automaticamente total_empleados en departamentos
Cada vez que se inserte o elimine un empleado.*/
delimiter //
CREATE TRIGGER upd AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    UPDATE departamentos
    SET departamentos.total_empleados = (
        SELECT COUNT(*)
        FROM empleados
        WHERE empleados.departamento = departamentos.coddpto
    );
END //

CREATE TRIGGER del AFTER DELETE ON empleados
FOR EACH ROW
BEGIN
    UPDATE departamentos
    SET departamentos.total_empleados = (
        SELECT COUNT(*)
        FROM empleados
        WHERE empleados.departamento = departamentos.coddpto
    );
END //
delimiter ;