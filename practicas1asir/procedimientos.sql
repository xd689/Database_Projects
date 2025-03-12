/*ejemplo*/
/* Cuenta el número de productos vendidos de una categoría concreta. Vemos cómo este procedimiento tiene un parámetro de entrada, que sería la categoría a buscar, y un parámetro de salida, que sería la cuenta de productos vendidos que pertenecen a esa categoría.*/
delimiter ::
create procedure cuenta_por_categoria (IN categoria_a_buscar CHAR(20), OUT cuantos INT)
BEGIN	
	SELECT COUNT(*) INTO cuantos FROM lineapedido
	JOIN productos ON lineapedido.CodProducto=productos.CodProducto
	WHERE categoria=categoria_a_buscar;
END ::
delimiter ;
/*Ejercicio 1 */
/*Crea un procedimiento que modifique la tabla pedidos para añadirle un atributo llamado “importe”.
Debe darle el valor de la suma de los importes de las lineas de pedido que le correspondan.*/

delimiter ::
create PROCEDURE modificar_importe ()
BEGIN
	  update pedidos
join 
(
  select numeroPedido, sum(importe) AS suma_importe
  from lineapedido
  group by numeroPedido
) as t
on pedidos.numeroPedido=t.numeroPedido
set pedidos.importe=t.suma_importe;

    END ::
delimiter ;
/* Ejercicio 2*/
/*Escribe un procedimiento que diga si hay o no pedidos cancelados.*/

DELIMITER ::
CREATE PROCEDURE pedidos_cancelados(OUT cancelados BOOLEAN)
BEGIN
    DECLARE resultado INT;

    SELECT COUNT(estado)
    INTO resultado
    FROM pedidos
    WHERE estado = 'Cancelado';

    IF resultado = 0 THEN
        SET cancelados = FALSE;
    ELSE
        SET cancelados = TRUE;
    END IF;
END::
DELIMITER ;
/*Ejercicio3*/
/*Crea un procedimiento que muestre cuantos pedidos se han hecho en una fecha que recibe como
parámetro. Si no existe ninguno debe mostrar “No hay pedidos en esa fecha”.*/
DELIMITER ::
CREATE PROCEDURE pedidos_en_fecha(fecha DATE)
BEGIN
    DECLARE num_pedidos INT;

    SELECT COUNT(*) INTO num_pedidos
    FROM pedidos
    WHERE fechaPedido = fecha;

    IF num_pedidos > 0 THEN
        SELECT CONCAT('Hay ', num_pedidos, ' pedido(s) en la fecha ', fecha) AS resultado;
    ELSE
        SELECT 'No hay pedidos en esa fecha' AS resultado;
    END IF;
END::
DELIMITER ;
/*Ejercicio 4*/
/*Crea un procedimiento que recibe como parámetro un año y cuenta los pedidos de ese año.
Después mostrará devolverá en un parámetro de salida los siguientes mensajes según corresponda:
'Menos de 100 pedidos'
'Entre 100 y 150 pedidos'
'Más de 150 pedidos'*/
DELIMITER ::
CREATE PROCEDURE PedidosAnuales(año INT, OUT mensaje VARCHAR(50))
BEGIN
    DECLARE num_pedidos INT;

    SELECT COUNT(*) INTO num_pedidos
    FROM pedidos
    WHERE YEAR(fechaPedido) = anio;

    IF num_pedidos < 100 THEN
        SET mensaje = 'Menos de 100 pedidos';
    ELSEIF num_pedidos BETWEEN 100 AND 150 THEN
        SET mensaje = 'Entre 100 y 150 pedidos';
    ELSE
        SET mensaje = 'Más de 150 pedidos';
    END IF;
END::
DELIMITER ; 

/*Ejercicio 5*/
/*Crea un procedimiento que recibe el nombre de una categoría y un número. El procedimiento
mostrará tantos productos de la categoría como indique el número. Por ejemplo si recibe la
categoría “pulseras” y el número 5, mostrará cinco productos de la categoría “pulseras”. El número
debe estar entre 1 y 10, de lo contrario no hará nada y mostrará el mensaje “El número no es
válido”.*/
DELIMITER ::
CREATE PROCEDURE productosCategoria(nombre_categoria VARCHAR(50), num INT)
BEGIN
    IF num BETWEEN 1 AND 10 THEN
        SELECT codProducto, nombre, precioVenta
        FROM productos
        WHERE categoria = nombre_categoria
        LIMIT num;
    ELSE
        SELECT 'El número no es válido' AS mensaje;
    END IF;
END::
DELIMITER ;
