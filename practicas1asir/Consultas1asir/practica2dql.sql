use basedatosejemplo;
/*--Practica 2--
--ejercicio 1  Consultar el nombre y la descripción de los productos de los que se ha recibido algún pedido de más de 50 unidades.--*/
select distinct (productos.nombre), productos.descripción, lineapedido.cantidad 
from productos 
join lineapedido ON productos.codProducto=lineapedido.codProducto 
where cantidad>50;
/*--Ejercicio 2 Consultar la categoría los productos con un precio mayor de 100€ de los que se ha recibido algún pedido de más de 50 unidades --*/
select distinct (productos.categoria)
from productos join lineapedido on productos.codProducto=lineapedido.codProducto 
where precio>100 and cantidad>50 ;
/*--Ejercicio 3 Mostrar los datos de los clientes a los que se enviaron pedidos después de la fecha prevista--*/
SELECT * 
from clientes 
join pedidos on clientes.codCliente=pedidos.cliente 
where (fechaenvio>fechaprevista);
/*--Ejercicio 4 Buscar el nombre y la descripción de los productos S10_1678, S12_1108, S18_1367, S18_1749 que tienen menos de 100 unidades en almacén --*/
SELECT distinct nombre ,descripción 
from productos 
where enAlmacen>100 and codProducto 
In ('10_1678', 'S12_1108', 'S18_1367', 'S18_1749'); 
/*--Ejercicio 5 Contar los pedidos de cada cliente. El informe debe mostrar todos los datos del cliente y el número total de pedidos--*/
SELECT clientes.*, COUNT(pedidos.numeroPedido), sum(numeropedido) 
from clientes 
join pedidos 
on clientes.codCliente=pedidos.cliente 
GROUP by codcliente;
/*--Ejercicio 6 Encontrar el precio máximo al que se ha vendido (iva del 21% incluido) los productos de la serie “Granada”--*/
SELECT nombre, MAX(PrecioVenta*1.21) 
from productos 
where nombre like '%granada';
/*--Ejercicio 7 . Mostrar un listado de los productos(nombre, descripción y categoría) con la suma de todas las cantidades que nos han pedido de cada uno ordenados de mayor cantidad a menor--*/
SELECT productos.nombre, productos.descripción, productos.categoria, sum(lineapedido.cantidad) 
from productos, lineapedido 
where productos.codProducto=lineapedido.codProducto 
GROUP by productos.codProducto 
order by cantidad DESC;
/*--Ejercicio 8 Mostrar un listado de los productos que nunca han sido pedidos--*/
select productos.codProducto, lineapedido.numeropedido 
from productos 
join lineapedido on productos.codProducto=lineapedido.codProducto 
where lineapedido.numeropedido is null;
/*--Ejercicio 9 Mostrar un listado con el nombre y los apellidos de los clientes con la media de los importes pagados por cada uno en el año 2021. Deben aparecer ordenados de mayor a menor y redondeados a dos decimales--*/ 
SELECT YEAR(fechapago),nombre, 'apellido 1', 'apellido 2', round(avg(importe),2) 'Media del importe' 
from clientes 
join pagos on clientes.codCliente=pagos.cliente
where year(fechapago)=2021
GROUP by cliente 
order by avg(importe) DESC;
/*--Ejercicio 10 Mostrar un listado con el nombre y los apellidos de los clientes y la suma de los importes pagados por ellos. Solo nos interesan los clientes cuya media de los importes pagados es mayor de 50000€. Deben aparecer ordenados de mayor a menor y redondeados a dos decimales--*/
select nombre, 'apellido 1','apellido 2', sum(importe)
FROM clientes, pagos
WHERE YEAR(fechapago) = 2021
GROUP BY cliente
HAVING AVG(importe)>50000
ORDER BY sum(importe) DESC;
