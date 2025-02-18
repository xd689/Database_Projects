#1 Añadir importe total a pedidos, el valor es la suma total de importe de lineapedido.

DELIMITER //

CREATE PROCEDURE actualizaPedidos()
BEGIN
    UPDATE pedidos
    JOIN (
        SELECT numeroPedido, SUM(precio) AS total_importe
        FROM lineapedido
        GROUP BY numeroPedido
    ) lineapedido ON pedidos.numeroPedido = lineapedido.numeroPedido
    SET pedidos.importe = lineapedido.total_importe;
END //

DELIMITER ;

#2  Dice si hay o no pedidos cancelados.

DELIMITER //

CREATE PROCEDURE cancelaPedidos()
BEGIN
    DECLARE contador INT;
    DECLARE mensaje VARCHAR(255);
    
    SELECT COUNT(*) INTO contador
    FROM pedidos
    WHERE estado = 'Cancelado';
    
    IF contador > 0 THEN
        SET mensaje = 'Hay pedidos cancelados';
    ELSE
        SET mensaje = 'No hay pedidos cancelados';
    END IF;
    
    SELECT mensaje AS resultado;
END //

DELIMITER ;

#3  Dice si hay o no pedidos en una fecha que damos como parametro.

DELIMITER //

CREATE PROCEDURE cuentaPedidos(IN fecha_param DATE)
BEGIN
    DECLARE contador INT;
    DECLARE mensaje VARCHAR(255);
    
    SELECT COUNT(*) INTO contador
    FROM pedidos
    WHERE fechaPedido = fecha_param;
    
    IF contador > 0 THEN
        SET mensaje = 'Hay pedidos en esa fecha';
    ELSE
        SET mensaje = 'No hay en esa fecha';
    END IF;
    
    SELECT mensaje AS resultado;
END //

DELIMITER ;

#4  Crea un procedimiento que recibe como parámetro un año y cuenta los pedidos de ese año.  
Después mostrará devolverá en un parámetro de salida los siguientes mensajes según corresponda:
 “Menos de 100 pedidos”
 “Entre 100 y 150 pedidos”
 “Más de 150 pedidos”
 
DELIMITER //
 
CREATE PROCEDURE cuentaPedidosAnual(IN ano_param DATE)
BEGIN
    DECLARE contador INT;
    DECLARE mensaje VARCHAR(255);
    
    SELECT COUNT(*) INTO contador
    FROM pedidos
    WHERE fechaPedido = ano_param;
    
    IF contador > 100 THEN
        SET mensaje = 'Hay pedidos';
    ELSE
        SET mensaje = 'No hay en esa fecha';
    END IF;
    
    SELECT mensaje AS resultado;
END //
