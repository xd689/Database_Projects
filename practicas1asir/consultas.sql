/*--Listar todas las bases  de datos en el servidor MySQL--*/
select schema_name from information_schema;
/*--Ver el tamaño de las tablas de una base de datos concreta--*/
select data_length, index_length, table_schema from tables where table_schema='mysql';
/*--Obtener información sobre los índices de una tabla específica--*/
select index_schema, table_name from statistics where table_name='users';
/*--Consultar las columnas de una tabla con sus tipos de datos y restricciones--*/
select column_name, data_type, is_nullable from columns;
/*--Listar todas las tablas y vistas en una base de datos específicca--*/
mysql> select table_name,table_schema from views where table_schema='sys';
/*--Ver los privilegios de los usuarios en una base de datos--*/
select grantee, table_schema from schema_privileges;
/*--Listar las tablas que no tienen claves primarias--*/
select table_name, constraint_type from table_constraints where constraint_type='PRIMARY KEY';
/*--Consultar los procedimientos almacenados y funciones en una base de datos--*/
select specific_name, routine_type, created, routine_schema, last_altered from routines where routine_schema='sys';
/*--Ver las tablas con auto_increment y el valor actual del contador--*/
select auto_increment, table_name from tables;

