/*--Practica6--*/
/*-- Datos del vehiculo con matricula 123aaa--*/
SELECT * 
from vehiculos
WHERE vehiculos.matricula LIKE '%1234aaa%';
/*--Datos del propietario del vehículo con matrícula 2345bbb--*/
SELECT * 
from clientes
JOIN seguros 
ON clientes.DNI=seguros.cliente
WHERE seguros.matricula like '%2345bbb%';
/*--Datos de las compañias de las que tenemos alun seguro activo--*/
SELECT compañias.*, seguros.activo
FROM compañias, seguros 
WHERE compañias.nombre=seguros.compañia 
AND seguros.activo='true';
/*--Datos de los clientes propietarios de un Opel corsa--*/
SELECT clientes.* 
from clientes, seguros, vehiculos
WHERE clientes.DNI=seguros.cliente
AND seguros.matricula=vehiculos.matricula
AND vehiculos.modelo like '%Opel corsa%';
/*--Nombre y apellidos del cliente relacionado con el accidente 1--*/
SELECT concat(clientes.nombre,' ',clientes.apellido1,' ',clientes.apellido2)'Nombre completo'
FROM clientes
JOIN seguros ON clientes.DNI=seguros.cliente
JOIN vehiculos on seguros.matricula=vehiculos.matricula
JOIN accidentes ON accidentes.matricula=vehiculos.matricula
WHERE accidentes.codigo=1;
/*--Numero de accidentes del cliente con dni 456789012--*/
SELECT count(accidentes.codigo)
FROM accidentes
JOIN vehiculos ON accidentes.matricula=vehiculos.matricula
JOIN seguros ON seguros.matricula=vehiculos.matricula
JOIN clientes ON clientes.DNI=seguros.cliente
WHERE clientes.DNI like '%456789012%';
/*--Listado de clientes que nunca han tenido un accidente (con subconsultas)--*/
SELECT concat(clientes.nombre, ' ', clientes.apellido1,' ', clientes.apellido2)
FROM clientes
WHERE clientes.DNI NOT IN 
( SELECT clientes.DNI 
FROM clientes 
JOIN seguros ON clientes.DNI=seguros.cliente
JOIN vehiculos on seguros.matricula=vehiculos.matricula
JOIN accidentes ON accidentes.matricula=vehiculos.matricula
); 
/*--Nombre de las compañías que tienen un número de seguros contratados por encima de la
media--*/

