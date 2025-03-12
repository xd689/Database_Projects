/*--Practica 5--*/
/* Ejercicio 1*/
select *
from proyectos
where fechafin>fechavencimiento and fechafin<>null;

/*Ejercicio 2*/
select adjuntos.codigoadjunto,adjuntos.nombrearchivo,adjuntos.tipo,adjuntos.descripicion
from adjuntos
join adjuntostareas on adjuntos.codigoadjunto=adjuntostareas.adjunto
join tareas on adjuntostareas.tarea=tareas.codigotarea
join trabajos on tareas.trabajo=trabajos.codigotrabajo
join proyectos on trabajos.proyecto=proyectos.codigoproyecto
where proyectos.codigoproyecto=00003;

/*Ejercicio 3*/
select u.identificador,u.nombre, u.apellido1,u.apellido2
from usuarios u
join usuarios coordinadores
on u.coordinador=coordinadores.identificador
where coordinadores.nombre="Marta" and coordinadores.apellido1="Durán" and coordinadores.apellido2="González";
/*--4. Listado de usuario que trabajan en algún proyecto con presupuesto mayor a 10.000€--*/
SELECT usuarios.identificador, concat(usuarios.nombre,' ',usuarios.apellido1,' ', usuarios.apellido2) 'Nombre completo'
from usuarios
where usuarios.identificador in 
( SELECT usuarios.identificador
 FROM usuarios
 JOIN actuaciones
 ON usuarios.identificador=actuaciones.usuario
 JOIN trabajos
 ON actuaciones.trabajo=trabajos.codigotrabajo
 JOIN proyectos
 ON proyectos.codigoproyecto=trabajos.proyecto
 WHERE proyectos.presupuesto>10000
 );
 
/*--Listado de usuarios (identifincador, nombre y apellidos) que subieron adjuntos a cualquier
proyecto dado de alta en el año 2021--*/
SELECT usuarios.identificador, concat(usuarios.nombre,' ',usuarios.apellido1,' ', usuarios.apellido2) 'Nombre completo'
from usuarios 
WHERE usuarios.identificador IN
( SELECT usuarios.identificador 
 FROM usuarios 
 JOIN adjuntostareas
 ON usuarios.identificador=adjuntostareas.usuario
 WHERE year(adjuntostareas.fecha)='2021'
 );
 
/*-- Número de fincheros adjuntos del proyecto cuyo nombre es “Digitalización de Ecotaller”--*/
 SELECT COUNT(adjuntos.codigoadjunto)
FROM adjuntos
where adjuntos.codigoadjunto IN
( SELECT adjuntos.codigoadjunto 
 FROM adjuntos 
 JOIN adjuntostareas
 ON adjuntostareas.adjunto=adjuntos.codigoadjunto
 JOIN usuarios
 ON usuarios.identificador=adjuntostareas.usuario
 JOIN proyectos
 ON proyectos.coordinador=usuarios.identificador
 WHERE proyectos.nombre like '%Digitalizacion de ecotaller%'
 );
/*--Listado de proyectos (código,nombre,presupuesto) que tiene un presupuesto mayor que el
proyecto “000009”--*/
SELECT proyectos.codigoproyecto, proyectos.nombre, proyectos.presupuesto
FROM proyectos
where proyectos.presupuesto >
(SELECT proyectos.presupuesto
 FROM proyectos 
 WHERE proyectos.codigoproyecto LIKE '%00 009%'
 );
 
/*--Número de adjuntos que tiene cada trabajo de cada proyecto--*/
select trabajos.codigoproyecto,trabajos.codigotrabajo,count(adjuntostareas.adjunto)
from adjuntostareas
join tareas on adjuntostareas.tarea=tareas.codigotarea
join trabajos on tareas.trabajo=trabajos.codigotrabajo
group by trabajos.codigotrabajo,adjuntostareas.tarea;

/*--Número de adjuntos de tipo imagen que ha subido cada usuario al proyecto “000004”--*/
 select adjuntostareas.tarea, adjuntos.tipo,count(adjuntostareas.adjunto)
from adjuntos
join adjuntostareas on adjuntos.codigoadjunto=adjuntostareas.adjunto
join tareas on adjuntostareas.tarea=tareas.codigotarea
join trabajos on tareas.trabajo=trabajos.codigotrabajo
join proyectos on trabajos.proyecto=proyectos.codigoproyecto
where proyectos.codigoproyecto=00004
group by adjuntostareas.tarea
having adjuntos.tipo="Imagen";
 
/*Ejercicio 10*/
select identificador,count(actuaciones.codigoactuacion)
from usuarios
join actuaciones on usuarios.identificador=actuaciones.usuario
join trabajos on actuaciones.trabajo=trabajos.codigotrabajo
join proyectos on trabajos.proyecto=proyectos.codigoproyecto
group by usuarios.identificador, proyectos.codigoproyecto;
 
