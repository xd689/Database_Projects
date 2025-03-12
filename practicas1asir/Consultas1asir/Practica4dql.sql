/*--Practica 4--
--Listado de clientes (código, nombre y apellidos) que no han hecho ningún pago--*/
SELECT clientes.codCliente, concat(clientes.nombre,' ',clientes.apellido1,' ',clientes.apellido2) 'Nombre completo' 
FROM clientes
WHERE codCliente not in 
	(
        SELECT pagos.cliente FROM pagos
        );

/*--Listado de los empleados(código, nombre y apellidos) de cualquier oficina que no sea Córdoba--*/
SELECT empleados.codEmpleado, concat(empleados.nombre,' ', empleados.apellido1,' ', empleados.apellido2) 'Nombre completo' 
From empleados 
WHERE empleados.oficina not IN                                                                                           
	(
    select oficinas.ciudad from oficinas
    WHERE oficinas.ciudad like '%Cordoba%'
    );
    
/*--Listado de productos(código, nombre y precio) que tienen un precio más alto que el más caro de
la categoría “Anillos”--*/
select productos.codProducto, productos.nombre, productos.precioVenta
from productos
where productos.codProducto>
(
    SELECT max(productos.precioVenta) FROM productos
    WHERE categoria like '%Anillos%'
    );
/*-- Listado de productos (código, nombre, precio) de los que no hay ningún pedido de más de 70
unidades--*/
select productos.codProducto, productos.nombre, productos.precioVenta, lineapedido.numeroPedido
from productos, lineapedido
where productos.codProducto=lineapedido.codProducto
and lineapedido.cantidad<70
GROUP by lineapedido.numeroPedido, productos.codProducto;
/*--. Nombre de los productos que pertenecían a un pedido cancelado--*/
select nombre,numeropedido
from productos
join lineapedido
on lineapedido.codproducto=productos.codProducto
where lineapedido.numeropedido in
(
   select numeroPedido from pedidos
   where estado like 'cancelado'
 )
order by numeropedido;
/*--Listado de clientes que han hecho el mismo número de pedidos que el cliente 001--*/
select clientes.codCliente
from clientes,pedidos
where clientes.codCliente=pedidos.cliente
group by pedidos.cliente 
HAVING COUNT(pedidos.numeroPedido)=
(
    SELECT count(numeroPedido) from pedidos
    WHERE pedidos.cliente like '%001%'
    );

/*--Nombre del producto que más veces ha pedido el cliente 002--*/




