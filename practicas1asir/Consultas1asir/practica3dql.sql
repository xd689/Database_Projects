use basedatosejemplo;
/*--Practica 3--
--Ejercicio1 Contar el número de pedidos que ha tenido cada producto en el año 2021--*/
SELECT productos.codProducto,nombre,year(fechapedido) AÑO, COUNT(productos.codProducto) FROM productos
JOIN lineapedido ON productos.codproducto=lineapedido.codProducto
JOIN pedidos ON pedidos.numeroPedido=lineapedido.numeroPedido
GROUP BY nombre,YEAR(fechapedido)
HAVING AÑO='2021'
/*--Ejercicio2 Mostrar un listado en el que aparezca el nombre completo de los clientes junto con su teléfono, el nombre del vendedor que lo atiende y el teléfono de la oficcina a la que pertenece ese comercial--*/
SELECT concat(clientes.nombre,clientes.apellido1, clientes.apellido2) as 'Nombre completo', clientes.telefono, empleados.nombre, oficinas.telefono 
FROM clientes, empleados, oficinas 
WHERE clientes.codVendedor=empleados.codEmpleado and empleados.oficina=oficinas.codOficina; 
/*--Ejercicio 3 Mostrar un listado donde aparezca el nombre completo de cada empleado junto con el nombre de su jefe y la ciudad de la oficcina a la que pertenece--*/
SELECT concat(empleados.nombre,empleados.apellido1, empleados.apellido2) as 'Nombre completo', empleados.supervisor, oficinas.ciudad
FROM empleados, oficinas
WHERE empleados.oficina=oficinas.codOficina; 
/*--Ejercicio4  Mostrar un listado de clientes (nombre y apellidos) junto con el nombre de los productos que han pedido alguna vez--*/
SELECT distinct concat(clientes.nombre ,' ',clientes.apellido1, ' ', clientes.apellido2) as cliente, productos.nombre producto
FROM clientes, pedidos, lineapedido, productos
WHERE clientes.codCliente=pedidos.cliente and pedidos.numeroPedido=lineapedido.numeroPedido and lineapedido.codProducto=productos.codProducto
GROUP by cliente;
/*--Ejercicio5 Listado de clientes (nombre completo) que son atendidos por comerciales de la oficcina de Córdoba--*/
SELECT concat(clientes.nombre,clientes.apellido1, clientes.apellido2) as 'Cliente', oficinas.ciudad
FROM clientes, empleados, oficinas 
WHERE clientes.codVendedor=empleados.codEmpleado and empleados.oficina=oficinas.codOficina
and (oficinas.ciudad) LIKE '%Córdoba%'; 
/*--Ejercicio6 Mostrar un listado del código y la descripción de las categorías de las que en algún momento se ha pedido una cantidad mayor de 50--*/
SELECT categorias.codCategoria, categorias.descripcion, lineapedido.cantidad, productos.codProducto
FROM categorias, lineapedido, productos
WHERE categorias.codCategoria=productos.categoria and productos.codProducto=lineapedido.codProducto 
and (lineapedido.cantidad)>50;
/*--Ejercicio7 Mostrar un listado del código y la descripción de las categorías de las que se ha pedido una cantidad mayor de 50 en el año 2021--*/
SELECT DISTINCT categorias.codCategoria, categorias.descripcion, lineapedido.cantidad, productos.codProducto, year(fechapedido)
FROM categorias, lineapedido, productos, pedidos
WHERE categorias.codCategoria=productos.categoria and productos.codProducto=lineapedido.codProducto and lineapedido.numeroPedido=pedidos.numeroPedido
and (lineapedido.cantidad)>50 and year(fechapedido)='2021';
/*--Ejercicio8  Listado de los códigos de transferencia y nombre completo de los clientes que la realizaron y que están asignados al comercial Juan Campos Molina--*/
SELECT pagos.codTransferencia, concat(clientes.nombre, ' ', clientes.apellido1,' ' , clientes.apellido2) 'Cliente', empleados.nombre 'comercial'
FROM empleados,clientes,pagos
WHERE empleados.codEmpleado=clientes.codVendedor and clientes.codCliente=pagos.cliente 
and empleados.nombre LIKE '%Juan%' and empleados.apellido1 LIKE '%Campos%' and empleados.apellido2 LIKE '%Molina%';
/*--Ejercicio9 Listado de los códigos de transferencia y nombre completo de los clientes que la realizaron y
que están asignados algún comercial de Madrid--*/
SELECT pagos.codTransferencia, concat(clientes.nombre, ' ', clientes.apellido1,' ' , clientes.apellido2) 'Nombre completo', empleados.nombre 'Comercial'
FROM empleados,clientes ,pagos, oficinas  
WHERE empleados.codEmpleado=clientes.codVendedor and clientes.codCliente=pagos.cliente and empleados.oficina=oficinas.codOficina and oficinas.ciudad='Madrid' and empleados.puesto='Comercial';
/*--Ejercicio 10 Listado de los códigos de transferencia y nombre completo de los clientes que la realizaron y
que están asignados algún comercial de Córdoba y su importe es mayor de 75000--*/
SELECT pagos.codTransferencia, concat(clientes.nombre, ' ', clientes.apellido1,' ' , clientes.apellido2) 'Nombre completo', empleados.nombre 'comercial', pagos.importe
FROM empleados,clientes ,pagos, oficinas  
WHERE empleados.codEmpleado=clientes.codVendedor and clientes.codCliente=pagos.cliente and empleados.oficina=oficinas.codOficina and oficinas.ciudad LIKE '%Cordoba%' and pagos.importe>75000
GROUP by cliente
order by importe desc;
