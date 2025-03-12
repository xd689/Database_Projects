/*--Apuntes dql--*/
/*--Consultas simples--*/
/*--Para seleccionar todos los datos de una tabla...--*/
SELECT * FROM (TABLA);
/*--Para seleccionar solo algunos datos de una tabla--*/
SELECT campo1,campo2, campo3 FROM (TABLA);
/*--Cómo usar los alias--(HAY DOS FORMAS)--*/
SELECT campo1 'CAMPO 1' | campo1 AS 'CAMPO 1' FROM TABLA;
/*--Como calcular IVA de un precio--Con una condición--*/
/*--Esta seleccionandon unicamente el precio de venta que sea mayor a 500 y te calcula el 21%--*/
SELECT nombre, (precioVenta*1,21) FROM tabla where (precioVenta)>500;
/*--Como concatenar(agrupar) campos--*/
SELECT concat(nombre,' ','apellido 1') Nombre completo FROM tabla;
/*--Cómo sacar restricciones entre dos valores--*/
SELECT codProducto, nombre, precioVenta from tabla where (precioVenta>100 and precioVenta<500);
/*--Como redondear--*/
SELECT nombre, round((precioVenta*1,21),2) FROM tabla where (precioVenta)>500;
/*--Como usar el YEAR--*/
SELECT nombre, YEAR(fechaPago) from tabla where year(fechaPago)=2022;
/*--Sacar valores que estan o no estan en una tabla--*/
SELECT numeropedido , codProducto, cantidad FROM TABLA WHERE codProducto IN ('S18_1749','S18_2248','S18_2325');
/*--Busqueda de un campo por %--*/
SELECT nombre, MAX(PrecioVenta*1.21) from TABLA where nombre like '%granada';
/*--Busqueda de valores nulos--*/
SELECT * from TABLA where campo is null;
SELECT * from TABLA where campo is not null;
/*--Como ordenar por campos--*/
Select * from tabla order by cliente;
/*--Como contar campos de una tabla*/
select count(*) from productos;
/*--Como contar teniendo en cuenta que sean nulos o no--*/
Select count(campo) from tabla;
/*--Como contar con restricciones--*/
select count(codProducto) from tabla where cantidad>50;
/*--Como calcular la suma de un campo--*/
select codProducto, sum(cantidad) from tabla;
/*--Como hacer la media de un campo truncando a 2 decimales y solo saca la cantidad donde la suma sea mayor de 500 y el nombre sea campo--*/
Select codProducto, truncate(AVG(CANTIDAD),2) from tabla having sum(cantidad)>500 where nombre like '%campo%';
/*--Como sacar el valor minimo y el maximo de un campo con restricciones--*/
select codProducto, MAX(precioVenta) from tabla where (precioVenta)>100;
/*--Como agrupar por un campo--*/
select codProducto, sum(cantidad) from tabla group by codProducto;
/*--Agrupamos tambien con rollup--*/
SELECT numeropedido, numerolinea, sum(precio)FROM lineapedido
GROUP BY numeropedido,numeroLinea
WITH ROLLUP; /*--El rollup agrupa y hace la suma que lleva ese pedido--*/
/*--Seleccionamos todos los campos de dos tablas--*/
SELECT * FROM tabla1, tabla2;
/*--Seleccionamos campos sueltos de dos tablas--*/
select productos.nombre, productos.descripción, lineapedido.cantidad 
from productos join lineapedido ON productos.codProducto=lineapedido.codProducto;
/*Con el join on lo que hacemos es unir las tablas--*/
/*--Left join--*/
select departamentos.nombre, empleados.nombre from empleados
left join departamentos
on coddpto=departamento;
/*--Saca los datos de departamentos sin tener en cuenta que sean nulos--*/
/*--Right join--*/
select departamentos.nombre, empleados.nombre from empleados
right join departamentos
on coddpto=departamento;
/*--Saca los datos de empleados sin tener en cuenta que sean nulos--*/
/*--/* UNION hace las dos consultas y da como resultado todas las filas */
/* pero no muestra duplicados*/
select departamentos.nombre DEPARTAMENTO, empleados.nombre EMPLEADO from empleados
left join departamentos
on coddpto=departamento
UNION
select  departamentos.nombre DEPARTAMENTO, empleados.nombre  from empleados
right join departamentos
on coddpto=departamento;
/*--Saca los datos de ambas tablas sin importar que los datos sean nulos--*/
/*--Sacar datos de dos o mas tablas--*/
select count(lineapedido.numeroPedido), productos.codProducto
from pedidos,lineapedido,productos
WHERE pedidos.numeroPedido=lineapedido.numeroPedido and lineapedido.codProducto=productos.codProducto and year(pedidos.fechaPedido)=2021
GROUP by productos.codProducto;


