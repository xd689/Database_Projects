use basedatosejemplo;
/*---Practica 1 dql---
---Ejercicio1---*/
SELECT DISTINCT codProducto 
FROM lineapedido 
where cantidad>50; 
/*--Ejercicio2--*/
SELECT DISTINCT codProducto 
FROM lineapedido 
where (cantidad>50 and precio>100); 
/*--Ejercicio3--*/
SELECT * 
from pedidos 
where (fechaEnvio>fechaPrevista); 
/*--Ejercicio 4--*/
SELECT nombre ,descripción 
from productos 
where enAlmacen>100 and codProducto In ('10_1678', 'S12_1108', 'S18_1367', 'S18_1749'); 
/*--Ejercicio 5--*/
SELECT count(DISTINCT(cliente)) 
from pedidos 
where observaciones is not null ;
/*--Ejercicio 6--*/
select AVG(precioVenta*1,21) 
from productos 
where nombre like '%granada'; 
/*--Ejercicio 7--*/
select codProducto, sum(cantidad) 
from lineapedido 
GROUP by codProducto 
order by sum(cantidad) desc; 
/*--Ejercicio 8--*/
select codProducto, sum(cantidad) 
from lineapedido 
GROUP by codProducto 
having sum(cantidad)>1000 
order by sum(cantidad) desc; 
/*--Ejercicio 9--*/
select fechapago, cliente, round(avg(importe),2) 
from pagos where (fechapago>'2021-01-01') 
GROUP BY cliente 
order by avg(importe) desc;
/*--Ejercicio 10--*/
SELECT cliente CLIENTE,round(sum(importe),2) 'SUMA DE PAGOS' FROM pagos
GROUP BY cliente
having AVG(importe)>50000
order by avg(importe) DESC;
