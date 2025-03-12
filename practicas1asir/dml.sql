/*****************************************************************************************/
/*                                     INSERTAR DATOS                                    */
/*                                   basedatosejemplo5                                   */
/*****************************************************************************************/


/* Añadir una fila a una tabla */

INSERT INTO clientes (dni,nombre,apellido1,apellido2,codpostal)
VALUES ('567890123','Paula','Jurado','Ponferrada','14008');

/* Añadir varias filas en una misma instrucción */
INSERT INTO clientes (dni,nombre,apellido1,apellido2,codpostal) values 
('567890123','Roberto','Segarra','Prado','14010'),
('678901234','Luis','Vizcaya','Alba','14003'),
('789012345','Jaime','Córdoba','Caballero','14008'),
('890123456','Antonio','Prat','Molina','14008'),
('901234567','Rafael','Hueso','Cornell','14008');

/* Ignorar errores */
INSERT IGNORE INTO clientes (dni,nombre,apellido1,apellido2,codpostal) values 
('567890123','Roberto','Segarra','Prado','14010'),
('010101010','Marcela','Giantti','Parla','14005');

/* Añadir filas desde una selección */
/* Supongamos que queremos rellenar una tabla con datos de otras dos */


/*
create table propietarios(
 dni varchar(9),
 matricula varchar(8),
 nombre varchar(30),
 constraint primary key(dni,matricula)
);
*/

INSERT INTO propietarios
SELECT distinct dni,matricula,nombre
from clientes,seguros
where clientes.dni=seguros.cliente;

/*****************************************************************************************/
/*                                     ACTUALIZAR DATOS                                  */
/*                                   basedatosejemplo5                                   */
/*****************************************************************************************/
/* Actualizar el valor de un campo */
UPDATE clientes 
SET apellido2='Parma'
WHERE dni='010101010';


/* Actualizar el valor de varios campos */
UPDATE clientes 
SET apellido1='Giantte',apellido2='Parla'
WHERE dni='010101010';


/*****************************************************************************************/
/*                                     ACTUALIZAR DATOS                                  */
/*                                   basedatosejemplo                                    */
/*****************************************************************************************/
/* Actualizar el valor de un campo con el valor de un campo de otra tabla */

alter table lineapedido add column nombreproducto varchar(70);

update lineapedido
join productos
on lineapedido.codproducto=productos.codProducto
set lineapedido.nombreproducto=productos.nombre;

/* Actualizar el valor de un campo con una consulta agrupada */

update productos
join 
(
  select codproducto, avg(precio) media
  from lineapedido
  group by codproducto
) as t
on productos.codproducto=t.codproducto
set productos.precioVenta=t.media;


/*****************************************************************************************/
/*                                     BORRAR DATOS                                      */
/*                                   basedatosejemplo4                                   */
/*****************************************************************************************/

/* Seleccionarmos las filas con una condición where */
delete from propietarios
where matricula='3456ccc';

/* Podemos seleccionar las filas usando limit */
delete from propietarios
ORDER BY nombre
limit 1;

/*******************************************************************************************/
/* Si queremos borrar todas las filas podemos omitir WHERE y LIMIT y usar TRUCATE          */


/*       - Es más eficiente                                                                */
/*       - No se puede deshacer                                                            */
/*       - Resetea campo Auto_incremente                                                   */
/*       - No ejecuta Triggers asociados                                                   */

/*******************************************************************************************/

TRUNCATE propietarios;

/*****************************************************************************************/
/*                                         VISTAS                                        */
/*                                   basedatosejemplo4                                   */
/*****************************************************************************************/

create view lineas as 
select productos.nombre, lineapedido.*
from productos, lineapedido
where productos.codProducto=lineapedido.codProducto;

/* Podemos ver que tablas son tablas de verdad o son vistas */
show full tables;

/* Podemos definir los nombres de los campos que queremos para la vista. */
/* OR REPLACE hará que si la vista estaba creada se sustituya por esta.  */

create or replace view lineas (pedido,linea,referencia,nombre,cantidad,precio) as 
select lineapedido.numeroPedido,
		 lineapedido.numeroLinea,
		 lineapedido.codProducto,
		 productos.nombre,
		 lineapedido.cantidad,
		 lineapedido.precio
from productos, lineapedido
where productos.codProducto=lineapedido.codProducto
order by lineapedido.numeroPedido,lineapedido.numeroLinea;


