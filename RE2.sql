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

#3  Crea un procedimiento que muestre cuantos pedidos se han hecho en una fecha que recibe como 
parámetro. Si no existe ninguno debe mostrar “No hay pedidos en esa fecha”.


