/*Pedro José Notario Miñano*/
/*Ej1 Guardar el numero de elementos en el campo numeroelementos*/
/*De la tabla compuestos. Enviar compuesto como parametro*/

DELIMITER //

CREATE PROCEDURE nCompuesto(IN comp)

BEGIN
    DECLARE contador;
    SELECT formula FROM compuestos
    JOIN ( SELECT COUNT(*) INTO contador
    FROM EC GROUP BY
    EC.elemento ) ON EC WHERE compuestos.formula = EC.compuesto
    
END//

DELIMITER ;

/**/
