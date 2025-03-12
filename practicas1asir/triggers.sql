1. 
use basedatosejemplo;
delimiter ::
CREATE TRIGGER fechaPrevista
BEFORE INSERT
ON pedidos FOR EACH ROW
BEGIN
  IF NEW.fechaPrevista > fechaPedido THEN
    set NEW.fechaPrevista = CURDATE();
   END IF;
END::
delimiter ;
2. 
USE basedatosejemplo;
DELIMITER ::
CREATE TRIGGER limiteCredito
BEFORE INSERT
ON clientes 
FOR EACH ROW
BEGIN
  IF NEW.limiteCredito > 12000 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El límite de crédito no puede superar los 12000';
  END IF;
END ::
DELIMITER ;

Relacion ejercicios 1:
1. 

DELIMITER ::

CREATE TRIGGER stock
BEFORE INSERT
ON lineapedido 
FOR EACH ROW
BEGIN
    DECLARE v_enalmacen INT;


    SELECT productos.EnAlmacen 
    INTO v_enalmacen
    FROM Productos
    WHERE codProducto = NEW.codProducto;


    IF NEW.cantidad > v_enalmacen THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No quedan más unidades en stock';
    END IF;
END ::

DELIMITER ;

2.

DELIMITER ::

CREATE TRIGGER actualizar_pedido
AFTER INSERT 
ON lineapedido
FOR EACH ROW
BEGIN
  UPDATE pedidos
  SET importe = (
    SELECT SUM(importe) 
    FROM lineapedido 
    WHERE numeroPedido = NEW.numeroPedido
  )
  WHERE numeroPedido = NEW.numeroPedido;

END ::

DELIMITER ;

3.
DELIMITER ::

CREATE TRIGGER actualizar_stock
AFTER INSERT ON lineapedido
FOR EACH ROW
BEGIN

  IF (SELECT enAlmacen 
  	FROM productos 
  	WHERE codProducto = NEW.codProducto) >= NEW.cantidad THEN

    UPDATE productos
    SET enAlmacen = enAlmacen - NEW.cantidad
    WHERE codProducto = NEW.codProducto;
  ELSE

    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: No hay suficiente stock para el producto';
    
  END IF;
END ::

DELIMITER ;

suma de 2 y 3:

DELIMITER ::

CREATE TRIGGER comprobar_stock
BEFORE INSERT
ON lineapedido 
FOR EACH ROW
BEGIN
    DECLARE v_enalmacen INT;


    SELECT productos.EnAlmacen 
    INTO v_enalmacen
    FROM Productos
    WHERE codProducto = NEW.codProducto;


    IF NEW.cantidad > v_enalmacen THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No quedan más unidades en stock';
    END IF;
END ::

DELIMITER ;



DELIMITER ::
CREATE TRIGGER actualizar_stock
AFTER INSERT ON lineapedido
FOR EACH ROW
BEGIN
    DECLARE stock int;
    UPDATE pedidos
    SET importe = (
	    SELECT SUM(importe) 
	    FROM lineapedido 
	    WHERE numeroPedido = NEW.numeroPedido)
    WHERE numeroPedido = NEW.numeroPedido;

    UPDATE productos
    SET enAlmacen = enAlmacen - NEW.cantidad
    WHERE codProducto = NEW.codProducto;
    

    SELECT enAlmacen 
    INTO stock
    FROM productos
    WHERE productos.codProducto = NEW.codProducto;
    
   IF stock = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No quedan más unidades en stock';
  END IF;
END ::

DELIMITER ;


