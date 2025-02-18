/*
*********************************************************************
CREACIÓN DE LA ESTRUCTURA
*********************************************************************
*/
DROP DATABASE basedatosejemplo;
CREATE DATABASE `basedatosejemplo`;

USE `basedatosejemplo`;

/*Estructura de la tabla oficinas*/

DROP TABLE IF EXISTS `oficinas`;

CREATE TABLE `oficinas` (
  `codOficina` varchar(10) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `direccion` varchar(60) NOT NULL,
  PRIMARY KEY (`codOficina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Estructura tabla categorias */
DROP TABLE IF EXISTS `categorías`;

CREATE TABLE `categorias` (
  `codCategoria` varchar(20) NOT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `imagen` mediumblob DEFAULT NULL,
  PRIMARY KEY (`codCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Estructura tabla empleados */

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `codEmpleado` varchar(4) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido1` varchar(50) NOT NULL,
  `apellido2` varchar(50) ,
  `email` varchar(100) NOT NULL,
  `oficina` varchar(10) NOT NULL,
  `supervisor` varchar(4) DEFAULT NULL,
  `puesto` varchar(50) NOT NULL,
  PRIMARY KEY (`codEmpleado`),
  KEY `idxsupervisores` (`supervisor`),
  KEY `idxoficinas` (`oficina`),
  CONSTRAINT `fksupervisores` FOREIGN KEY (`supervisor`) REFERENCES `empleados` (`codEmpleado`),
  CONSTRAINT `fkoficinasempleados` FOREIGN KEY (`oficina`) REFERENCES `oficinas` (`codOficina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Estructura tabla clientes*/

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `codCliente` varchar(3) NOT NULL,
  `empresa` varchar(60) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido1` varchar(50) NOT NULL,
  `apellido2` varchar(50),
  `telefono` varchar(11) NOT NULL,
  `direccion` varchar(60) NOT NULL,
  `poblacion` varchar(50) NOT NULL,
  `provincia` varchar(50) DEFAULT NULL,
  `codVendedor` varchar(4) DEFAULT NULL,
  `limiteCredito` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`codCliente`),
  KEY `codVendedor` (`codVendedor`),
  CONSTRAINT `fkClientesEmpleados` FOREIGN KEY (`codVendedor`) REFERENCES `empleados`(`codEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Estructura tabla pedidos*/
DROP TABLE IF EXISTS `pedidos`;

CREATE TABLE `pedidos` (
  `numeroPedido` varchar(11) NOT NULL,
  `fechaPedido` date NOT NULL,
  `fechaPrevista` date NOT NULL,
  `fechaEnvio` date DEFAULT NULL,
  `estado` varchar(15) NOT NULL,
  `observaciones` text,
  `cliente` varchar(3) NOT NULL,
  PRIMARY KEY (`numeroPedido`),
  KEY `idxcliente` (`cliente`),
  CONSTRAINT `fkclientes` FOREIGN KEY (`cliente`) REFERENCES `clientes` (`codCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Estructura tabla productos */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `codProducto` varchar(15) NOT NULL,
  `nombre` varchar(70) NOT NULL,
  `categoria` varchar(20) NOT NULL,
  `descripción` text NOT NULL,
  `enAlmacen` smallint(6) NOT NULL,
  `precioVenta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`codProducto`),
  KEY `idxcategoria` (`categoria`),
  CONSTRAINT `fkcategorias` FOREIGN KEY (`categoria`) REFERENCES `categorias` (`codCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*Estructura tabla lineapedido*/

DROP TABLE IF EXISTS `lineapedido`;

CREATE TABLE `lineapedido` (
  `numeroPedido` varchar(11) NOT NULL,
  `codProducto` varchar(15) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `numeroLinea` smallint(6) NOT NULL,
  PRIMARY KEY (`numeroPedido`,`numeroLinea`),
  KEY `idxcodproducto` (`codProducto`),
  CONSTRAINT `fk1pedidos` FOREIGN KEY (`numeroPedido`) REFERENCES `pedidos` (`numeroPedido`),
  CONSTRAINT `fkproductos` FOREIGN KEY (`codProducto`) REFERENCES `productos` (`codProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Estructura tabla pagos */

DROP TABLE IF EXISTS `pagos`;

CREATE TABLE `pagos` (
  `cliente` varchar(3) NOT NULL,
  `codTransferencia` varchar(50) NOT NULL,
  `fechaPago` date NOT NULL,
  `importe` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cliente`,`codTransferencia`),
  CONSTRAINT `fkcliente` FOREIGN KEY (`cliente`) REFERENCES `clientes` (`codCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;/*Datos tabla clientes */


/*
*********************************************************************
CARGA DE DATOS
*********************************************************************
*/

/*Datos tabla oficina */

insert  into `oficinas`(`codOficina`,`ciudad`,`telefono`,`direccion`) values 

('1','Madrid','698521477','C/ San Bernardo, 25'),

('2','Valencia','66547781','Avda. del Mar, 13'),

('3','Córdoba','622314477','Avda. Ronda de los Tejares, 31');


/*Datos de empleados */

insert  into `empleados`(`codEmpleado`,`nombre`,`apellido1`,`apellido2`,`email`,`oficina`,`supervisor`,`puesto`) values 

('0000','Isabel','Caballero','Cabrera','icaballero@ejemplo.com','1',NULL,'Presidenta'),

('0001','Manuel','Serrano','Wic','mserrano@ejemplo.com','1','0000','Gerente de Ventas'),

('0002','Juan','Campos','Molina','jcampos@ejemplo.com','1','0001','Comercial'),

('0003','Marta','Durán','Hueso','mduran@ejemplo.com','2','0001','Comercial'),

('0004','Michael','Jackson',NULL,'mjackson@ejemplo.com','2','0003','Comercial'),

('0005','Antonio','Molina','Blanco','amolina@ejemplo.com','3','0001','Comercial');


/*Datos Clientes*/
insert  into `clientes`(`codCliente`,`empresa`,`nombre`,`apellido1`,`apellido2`,`telefono`,`direccion`,`poblacion`,`provincia`,`codVendedor`,`limiteCredito`) values 

('001','Taller Gráfico','Carmen','Pérez','Soler','658741214','Calle Real, 23','Jaén','Jaén','0003','2100.00'),

('002','Regalos y más','Samuel','Iliarte','Franco','658741147','Avda. La Esperanza, 41','Marbella','Málaga','0002','7180.00'),

('003','Levante S.L.','María','Montes','Cardoso','654123987','Calle Infanta Leonor, 101','Alcobendas','Madrid','0002','1173.00'),

('004','Rosado e Hijos','Manuel','Rosado','Estévez','639258744','Calle El Laurel, 3','Bilbao','Vizcaya','0005','1182.00'),

('005','La Goleta','Victoria','Conde','Marcial','658632144','Avda. Principal,14','Martos','Jaén','0005','8170.00'),

('006','MiniRegalos','Carmelo','Martínez','Martínez','62169874','Calle Mayor, 31','Sevilla','Sevilla','0003','2105.00'),

('007','Distribuciones MRV','Mónica','Ramírez','Valenzuela','666447891','Calle del Almendro','Jaén','Jaén',NULL,'0.00'),

('008','behappy','Juan Antonio','Balmón','Domínguez','639281745','Calle Paraíso, 103','Sevilla','Sevilla','0004','5970.00'),

('009','PlayToys','Javier','Maestre','Domenech','62918473','Plaza Mayor, 31','Salamanca','Salamanca','0005','6460.00'),

('010','Frank','Fran','Smith',NULL,'63572121','Calle Antonio Machado, 54','Granada','Granada','0001','11490.00');

/*Datos categorías` */

insert  into `categorias`(`codCategoria`,`descripcion`,`imagen`) values 

('pulseras',NULL,NULL),

('anillos',NULL,NULL),

('collares',NULL,NULL),

('gargantillas',NULL,NULL),

('pendientes',NULL,NULL),

('gemelos',NULL,NULL),

('diademas',NULL,NULL),
('alfileres',NULL,NULL),
('peinetas',NULL,NULL);

/*Datos de productos */

insert  into `productos`(`codProducto`,`nombre`,`categoria`,`descripción`,`precioVenta`,`enAlmacen`) values 

('S10_1678','Pulsera Atenea','pulseras','Pulsera de plata de media caña con grabados florales.',43.50,125),
('S10_2016','Pulsera Atenea Gold','pulseras','Pulsera de oro de media caña con grabados florales.',142.50,641),

('S10_1949','Pulsera Granada','pulseras','Pulsera de plata de media caña con grabados geométricos.',51.00,245),
('S10_4698','Pulsera Granada Gold','pulseras','Pulsera de oro de media caña con grabados geométricos.',157.50,54),

('S10_4757','Pulsera Islas','pulseras','Pulsera de plata de media caña con incrustaciones de esmeralda.',173.50,100),
('S10_4962','Pulsera Islas Gold','pulseras','Pulsera de oro de media caña con incrustaciones de esmeralda.',323.50,105),

('S12_1099','Pulsera Fuego','pulseras','Pulsera de plata de media caña con incrustaciones de rubíes.',223.50,25),
('S12_1108','Pulsera Fuego Gold','pulseras','Pulsera de oro de media caña con incrustaciones de rubíes.',423.50,75),

('S12_1666','Pulsera Miel','pulseras','Pulsera de plata de media caña con incrustaciones de ámbar.',123.50,185),
('S12_2823','Pulsera Miel Gold','pulseras','Pulsera de oro de media caña con incrustaciones de ámbar.',352.75,225),

('S12_3148','Pulsera Estrellas','pulseras','Pulsera de plata labrada.',113.50,87),

('S12_3380','Pulsera Estrellas Gold','pulseras','Pulsera de oro labrada.',380.50,430),




('S12_3891','Anillo Atenea','anillos','Anillo de plata de media caña con grabados florales.',43.50,125),
('S12_3990','Anillo Atenea Gold','anillos','Anillo de oro de media caña con grabados florales.',142.50,641),

('S18_4600','Anillo Granada','anillos','anillo de plata de media caña con grabados geométricos.',324.50,75),
('S18_4409','Anillo Granada Gold','collares','anillo de oro de media caña con grabados geométricos.',560.00,105),

('S12_4473','Anillo Islas','anillos','Anillo de plata de media caña con incrustaciones de esmeralda.',173.50,100),
('S12_4675','Anillo Islas Gold','anillos','Anillo de oro de media caña con incrustaciones de esmeralda.',323.50,105),

('S18_1097','Anillo Fuego','anillos','Anillo de plata de media caña con incrustaciones de rubíes.',223.50,25),
('S18_1129','Anillo Fuego Gold','anillos','Anillo de oro de media caña con incrustaciones de rubíes.',423.50,75),

('S18_1342','Anillo Miel','anillos','Anillo de plata de media caña con incrustaciones de ámbar.',123.50,185),
('S18_1367','Anillo Miel Gold','anillos','Anillo de oro de media caña con incrustaciones de ámbar.',352.75,225),

('S18_1589','Anillo Estrellas','anillos','Anillo de plata labrada.',113.50,87),
('S18_1662','Anillo Estrellas Gold','anillos','Anillo de oro labrada.',380.50,430),




('S18_1749','Collar Atenea','collares','Collar de plata de media caña con grabados florales.',323.50,15),
('S18_1889','Collar Atenea Gold','collares','Collar de plata de media caña con grabados florales.',623.50,12),

('S18_1984','Collar Granada','collares','Collar de plata de media caña con grabados geométricos.',324.50,75),
('S18_2238','Collar Granada Gold','collares','Collar de plata de media caña con grabados geométricos.',560.00,105),

('S18_2248','Collar Islas','collares','Collar de plata de media caña con esmeraldas.',645.50,100),
('S18_2319','Collar Islas Gold','collares','Collar de plata de media caña con esmeraldas.',1045.50,125),

('S18_2325','Collar Fuego','collares','Collar de plata de media caña con incrustaciones de rubíes.',223.50,25),
('S18_2432','Collar Fuego Gold','collares','Collar de oro de media caña con incrustaciones de rubíes.',423.50,75),

('S18_2581','Collar Miel','collares','Collar de plata de media caña con incrustaciones de ámbar.',123.50,185),
('S18_2625','Collar Miel Gold','collares','Collar de oro de media caña con incrustaciones de ámbar.',352.75,225),

('S18_2795','Collar Estrellas','collares','Collar de plata labrada.',113.50,87),
('S18_2870','Collar Estrellas Gold','collares','Collar de oro labrada.',380.50,430),



('S18_2949','Gargantilla Atenea','gargantillas','Gargantilla de plata de media caña con grabados florales.',323.50,15),
('S18_2957','Gargantilla Atenea Gold','gargantillas','Gargantilla de plata de media caña con grabados florales.',623.50,12),

('S18_3029','Gargantilla Granada','gargantillas','Gargantilla de plata de media caña con grabados geométricos.',324.50,75),
('S18_3136','Gargantilla Granada Gold','gargantillas','Gargantilla de plata de media caña con grabados geométricos.',560.00,105),

('S18_3140','Gargantilla Islas','gargantillas','Gargantilla de plata de media caña con esmeraldas.',645.50,100),
('S18_3232','Gargantilla Islas Gold','gargantillas','Gargantilla de plata de media caña con esmeraldas.',1045.50,125),

('S18_3233','Gargantilla Fuego','gargantillas','Gargantilla de plata de media caña con incrustaciones de rubíes.',223.50,25),
('S18_3259','Gargantilla Fuego Gold','gargantillas','Gargantilla de oro de media caña con incrustaciones de rubíes.',423.50,75),

('S18_3278','Gargantilla Miel','gargantillas','Gargantilla de plata de media caña con incrustaciones de ámbar.',123.50,185),
('S18_3320','Gargantilla Miel Gold','gargantillas','Gargantilla de oro de media caña con incrustaciones de ámbar.',352.75,225),

('S18_3482','Gargantilla Estrellas','gargantillas','Gargantilla de plata labrada.',113.50,87),
('S18_3685','Gargantilla Estrellas Gold','gargantillas','Gargantilla de oro labrada.',380.50,430),





('S18_3782','Pendientes Atenea','pendientes','Pendientes de plata de media caña con grabados florales.',323.50,15),
('S18_3856','Pendientes Atenea Gold','pendientes','Pendientes de plata de media caña con grabados florales.',623.50,12),

('S18_4027','Pendientes Granada','pendientes','Pendientes de plata de media caña con grabados geométricos.',324.50,75),
('S18_4522','Pendientes Granada Gold','pendientes','Pendientes de plata de media caña con grabados geométricos.',560.00,105),

('S18_4668','Pendientes Islas','pendientes','Pendientes de plata de media caña con esmeraldas.',645.50,100),
('S18_4721','Pendientes Islas Gold','pendientes','Pendientes de plata de media caña con esmeraldas.',1045.50,125),

('S18_4933','Pendientes Fuego','pendientes','Pendientes de plata de media caña con incrustaciones de rubíes.',223.50,25),
('S24_1046','Pendientes Fuego Gold','pendientes','Pendientes de oro de media caña con incrustaciones de rubíes.',423.50,75),

('S24_1444','Pendientes Miel','pendientes','Pendientes de plata de media caña con incrustaciones de ámbar.',123.50,185),
('S24_1578','Pendientes Miel Gold','pendientes','Pendientes de oro de media caña con incrustaciones de ámbar.',352.75,225),

('S24_1628','Pendientes Estrellas','pendientes','Pendientes de plata labrada.',113.50,87),
('S24_1785','Pendientes Estrellas Gold','pendientes','Pendientes de oro labrada.',380.50,430),



('S24_1937','Gemelos Atenea','gemelos','Gemelos de plata de media caña con grabados florales.',323.50,15),
('S24_2000','Gemelos Atenea Gold','gemelos','Gemelos de plata de media caña con grabados florales.',623.50,12),

('S24_2011','Gemelos Granada','gemelos','Gemelos de plata de media caña con grabados geométricos.',324.50,75),
('S24_2022','Gemelos Granada Gold','gemelos','Gemelos de plata de media caña con grabados geométricos.',560.00,105),

('S24_2300','Gemelos Islas','gemelos','Gemelos de plata de media caña con esmeraldas.',645.50,100),
('S24_2360','Gemelos Islas Gold','gemelos','Gemelos de plata de media caña con esmeraldas.',1045.50,125),

('S24_2766','Gemelos Fuego','gemelos','Gemelos de plata de media caña con incrustaciones de rubíes.',223.50,25),
('S24_2840','Gemelos Fuego Gold','gemelos','Gemelos de oro de media caña con incrustaciones de rubíes.',423.50,75),

('S24_2841','Gemelos Miel','gemelos','Gemelos de plata de media caña con incrustaciones de ámbar.',123.50,185),
('S24_2887','Gemelos Miel Gold','gemelos','Gemelos de oro de media caña con incrustaciones de ámbar.',352.75,225),

('S24_2972','Gemelos Estrellas','gemelos','Gemelos de plata labrada.',113.50,87),
('S24_3151','Gemelos Estrellas Gold','gemelos','Gemelos de oro labrada.',380.50,430),



('S24_3191','Diadema Atenea','diademas','Diadema de plata de media caña con grabados florales.',323.50,15),
('S24_3371','Diadema Atenea Gold','diademas','Diadema de plata de media caña con grabados florales.',623.50,12),

('S24_3420','Diadema Granada','diademas','Diadema de plata de media caña con grabados geométricos.',324.50,75),
('S24_3432','Diadema Granada Gold','diademas','Diadema de plata de media caña con grabados geométricos.',560.00,105),

('S24_3816','Diadema Islas','diademas','Diadema de plata de media caña con esmeraldas.',645.50,100),
('S24_3856','Diadema Islas Gold','diademas','Diadema de plata de media caña con esmeraldas.',1045.50,125),

('S24_3949','Diadema Fuego','diademas','Diadema de plata de media caña con incrustaciones de rubíes.',223.50,25),
('S24_3969','Diadema Fuego Gold','diademas','Diadema de oro de media caña con incrustaciones de rubíes.',423.50,75),

('S24_4048','Diadema Miel','diademas','Diadema de plata de media caña con incrustaciones de ámbar.',123.50,185),
('S24_4258','Diadema Miel Gold','diademas','Diadema de oro de media caña con incrustaciones de ámbar.',352.75,225),

('S24_4278','Diadema Estrellas','diademas','Diadema de plata labrada.',113.50,87),
('S24_4620','Diadema Estrellas Gold','diademas','Diadema de oro labrada.',380.50,430),



('S32_1268','Alfiler Atenea','alfileres','Alfiler de plata de media caña con grabados florales.',323.50,15),
('S32_1374','Alfiler Atenea Gold','alfileres','Alfiler de plata de media caña con grabados florales.',623.50,12),

('S32_2206','Alfiler Granada','alfileres','Alfiler de plata de media caña con grabados geométricos.',324.50,75),
('S32_2509','Alfiler Granada Gold','alfileres','Alfiler de plata de media caña con grabados geométricos.',560.00,105),

('S32_3207','Alfiler Islas','alfileres','Alfiler de plata de media caña con esmeraldas.',645.50,100),
('S32_3522','Alfiler Islas Gold','alfileres','Alfiler de plata de media caña con esmeraldas.',1045.50,125),

('S32_4289','Alfiler Fuego','alfileres','Alfiler de plata de media caña con incrustaciones de rubíes.',223.50,25),
('S32_4485','Alfiler Fuego Gold','alfileres','Alfiler de oro de media caña con incrustaciones de rubíes.',423.50,75),

('S50_1341','Alfiler Miel','alfileres','Alfiler de plata de media caña con incrustaciones de ámbar.',123.50,185),
('S50_1392','Alfiler Miel Gold','alfileres','Alfiler de oro de media caña con incrustaciones de ámbar.',352.75,225),

('S50_1514','Alfiler Estrellas','alfileres','Alfiler de plata labrada.',113.50,87),
('S50_4713','Alfiler Estrellas Gold','alfileres','Alfiler de oro labrada.',380.50,430),



('S700_1138','Peineta Atenea','peinetas','Peineta de plata de media caña con grabados florales.',323.50,15),
('S700_1691','Peineta Atenea Gold','peinetas','Peineta de plata de media caña con grabados florales.',623.50,12),

('S700_1938','Peineta Granada','peinetas','Peineta de plata de media caña con grabados geométricos.',324.50,75),
('S700_2047','Peineta Granada Gold','peinetas','Peineta de plata de media caña con grabados geométricos.',560.00,105),

('S700_2466','Peineta Islas','peinetas','Peineta de plata de media caña con esmeraldas.',645.50,100),
('S700_2610','Peineta Islas Gold','peinetas','Peineta de plata de media caña con esmeraldas.',1045.50,125),

('S700_2824','Peineta Fuego','peinetas','Peineta de plata de media caña con incrustaciones de rubíes.',223.50,25),
('S700_2834','Peineta Fuego Gold','peinetas','Peineta de oro de media caña con incrustaciones de rubíes.',423.50,75),

('S700_3167','Peineta Miel','peinetas','Peineta de plata de media caña con incrustaciones de ámbar.',123.50,185),
('S700_3505','Peineta Miel Gold','peinetas','Peineta de oro de media caña con incrustaciones de ámbar.',352.75,225),

('S700_3962','Peineta Estrellas','peinetas','Peineta de plata labrada.',113.50,87),
('S700_4002','Peineta Estrellas Gold','peinetas','Peineta de oro labrada.',380.50,430),

('S72_1253','Peineta Luna','peinetas','Peineta de plata labrada e incrustaciones de nacar.',1254.50,87),
('S72_3212','Peineta Luna Gold','peinetas','Peineta de oro labrado e incrustaciones de nacar.',2600.00,430);



/*Datos tabla pedidos` */

insert  into `pedidos`(`numeroPedido`,`fechaPedido`,`fechaPrevista`,`fechaEnvio`,`estado`,`observaciones`,`cliente`) values 
(10100,'2019-01-06','2019-01-13','2019-01-10','Enviado',NULL,'001'),

(10101,'2019-01-09','2019-01-18','2019-01-11','Enviado',NULL,'008'),

(10102,'2019-01-10','2019-01-18','2019-01-14','Enviado',NULL,'002'),

(10103,'2019-01-29','2019-02-07','2019-02-02','Enviado',NULL,'003'),

(10104,'2019-01-31','2019-02-09','2019-02-01','Enviado',NULL,'004'),

(10105,'2019-02-11','2019-02-21','2019-02-12','Enviado',NULL,'005'),

(10106,'2019-02-17','2019-02-24','2019-02-21','Enviado',NULL,'006'),

(10107,'2019-02-24','2019-03-03','2019-02-26','Enviado',NULL,'007'),

(10108,'2019-03-03','2019-03-12','2019-03-08','Enviado',NULL,'008'),

(10109,'2019-03-10','2019-03-19','2019-03-11','Enviado',NULL,'009'),

(10110,'2019-03-18','2019-03-24','2019-03-20','Enviado',NULL,'010'),

(10111,'2019-03-25','2019-03-31','2019-03-30','Enviado',NULL,'001'),

(10112,'2019-03-24','2019-04-03','2019-03-29','Enviado',NULL,'004'),

(10113,'2019-03-26','2019-04-02','2019-03-27','Enviado',NULL,'002'),

(10114,'2019-04-01','2019-04-07','2019-04-02','Enviado',NULL,'003'),

(10115,'2019-04-04','2019-04-12','2019-04-07','Enviado',NULL,'004'),

(10116,'2019-04-11','2019-04-19','2019-04-13','Enviado',NULL,'004'),

(10117,'2019-04-16','2019-04-24','2019-04-17','Enviado',NULL,'004'),

(10118,'2019-04-21','2019-04-29','2019-04-26','Enviado',NULL,'006'),

(10119,'2019-04-28','2019-05-05','2019-05-02','Enviado',NULL,'005'),

(10120,'2019-04-29','2019-05-08','2019-05-01','Enviado',NULL,'006'),

(10121,'2019-05-07','2019-05-13','2019-05-13','Enviado',NULL,'007'),

(10122,'2019-05-08','2019-05-16','2019-05-13','Enviado',NULL,'008'),

(10123,'2019-05-20','2019-05-29','2019-05-22','Enviado',NULL,'009'),

(10124,'2019-05-21','2019-05-29','2019-05-25','Enviado',NULL,'010'),

(10125,'2019-05-21','2019-05-27','2019-05-24','Enviado',NULL,'006'),

(10126,'2019-05-28','2019-06-07','2019-06-02','Enviado',NULL,'001'),

(10127,'2019-06-03','2019-06-09','2019-06-06','Enviado',NULL,'001'),

(10128,'2019-06-06','2019-06-12','2019-06-11','Enviado',NULL,'004'),

(10129,'2019-06-12','2019-06-18','2019-06-14','Enviado',NULL,'002'),

(10130,'2019-06-16','2019-06-24','2019-06-21','Enviado',NULL,'003'),

(10131,'2019-06-16','2019-06-25','2019-06-21','Enviado',NULL,'004'),

(10132,'2019-06-25','2019-07-01','2019-06-28','Enviado',NULL,'004'),

(10133,'2019-06-27','2019-07-04','2019-07-03','Enviado',NULL,'004'),

(10134,'2019-07-01','2019-07-10','2019-07-05','Enviado',NULL,'004'),

(10135,'2019-07-02','2019-07-12','2019-07-03','Enviado',NULL,'002'),

(10136,'2019-07-04','2019-07-14','2019-07-06','Enviado',NULL,'010'),

(10137,'2019-07-10','2019-07-20','2019-07-14','Enviado',NULL,'007'),

(10138,'2019-07-07','2019-07-16','2019-07-13','Enviado',NULL,'005'),

(10139,'2019-07-16','2019-07-23','2019-07-21','Enviado',NULL,'006'),

(10140,'2019-07-24','2019-08-02','2019-07-30','Enviado',NULL,'007'),

(10141,'2019-08-01','2019-08-09','2019-08-04','Enviado',NULL,'007'),

(10142,'2019-08-08','2019-08-16','2019-08-13','Enviado',NULL,'002'),

(10143,'2019-08-10','2019-08-18','2019-08-12','Enviado',NULL,'008'),

(10144,'2019-08-13','2019-08-21','2019-08-14','Enviado',NULL,'004'),

(10145,'2019-08-25','2019-09-02','2019-08-31','Enviado',NULL,'008'),

(10146,'2019-09-03','2019-09-13','2019-09-06','Enviado',NULL,'004'),

(10147,'2019-09-05','2019-09-12','2019-09-09','Enviado',NULL,'009'),

(10148,'2019-09-11','2019-09-21','2019-09-15','Enviado',NULL,'009'),

(10149,'2019-09-12','2019-09-18','2019-09-17','Enviado',NULL,'010'),

(10150,'2019-09-19','2019-09-27','2019-09-21','Enviado',NULL,'004'),

(10151,'2019-09-21','2019-09-30','2019-09-24','Enviado',NULL,'001'),

(10152,'2019-09-25','2019-10-03','2019-10-01','Enviado',NULL,'003'),

(10153,'2019-09-28','2019-10-05','2019-10-03','Enviado',NULL,'004'),

(10154,'2019-10-02','2019-10-12','2019-10-08','Enviado',NULL,'002'),

(10155,'2019-10-06','2019-10-13','2019-10-07','Enviado',NULL,'004'),

(10156,'2019-10-08','2019-10-17','2019-10-11','Enviado',NULL,'004'),

(10157,'2019-10-09','2019-10-15','2019-10-14','Enviado',NULL,'005'),

(10158,'2019-10-10','2019-10-18','2019-10-15','Enviado',NULL,'003'),

(10159,'2019-10-10','2019-10-19','2019-10-16','Enviado',NULL,'005'),

(10160,'2019-10-11','2019-10-17','2019-10-17','Enviado',NULL,'006'),

(10161,'2019-10-17','2019-10-25','2019-10-20','Enviado',NULL,'007'),

(10162,'2019-10-18','2019-10-26','2019-10-19','Enviado',NULL,'005'),

(10163,'2019-10-20','2019-10-27','2019-10-24','Enviado',NULL,'004'),

(10164,'2019-10-21','2019-10-30','2019-10-23','Resuelto',NULL,'008'),

(10165,'2019-10-22','2019-10-31','2019-12-26','Enviado',NULL,'004'),

(10166,'2019-10-21','2019-10-30','2019-10-27','Enviado',NULL,'008'),

(10167,'2019-10-23','2019-10-30',NULL,'Cancelado','El cliente no aprecia la calidad esperada','008'),

(10168,'2019-10-28','2019-11-03','2019-11-01','Enviado',NULL,'007'),

(10169,'2019-11-04','2019-11-14','2019-11-09','Enviado',NULL,'009'),

(10170,'2019-11-04','2019-11-12','2019-11-07','Enviado',NULL,'008'),

(10171,'2019-11-05','2019-11-13','2019-11-07','Enviado',NULL,'009'),

(10172,'2019-11-05','2019-11-14','2019-11-11','Enviado',NULL,'009'),

(10173,'2019-11-05','2019-11-15','2019-11-09','Enviado',NULL,'006'),

(10174,'2019-11-06','2019-11-15','2019-11-10','Enviado',NULL,'003'),

(10175,'2019-11-06','2019-11-14','2019-11-09','Enviado',NULL,'002'),

(10176,'2019-11-06','2019-11-15','2019-11-12','Enviado',NULL,'010'),

(10177,'2019-11-07','2019-11-17','2019-11-12','Enviado',NULL,'009'),

(10178,'2019-11-08','2019-11-16','2019-11-10','Enviado',NULL,'010'),

(10179,'2019-11-11','2019-11-17','2019-11-13','Cancelado','El cliente no está satisfecho con la fecha de envío','005'),

(10180,'2019-11-11','2019-11-19','2019-11-14','Enviado',NULL,'009'),

(10181,'2019-11-12','2019-11-19','2019-11-15','Enviado',NULL,'008'),

(10182,'2019-11-12','2019-11-21','2019-11-18','Enviado',NULL,'002'),

(10183,'2019-11-13','2019-11-22','2019-11-15','Enviado',NULL,'009'),

(10184,'2019-11-14','2019-11-22','2019-11-20','Enviado',NULL,'008'),

(10185,'2019-11-14','2019-11-21','2019-11-20','Enviado',NULL,'008'),

(10186,'2019-11-14','2019-11-20','2019-11-18','Enviado',NULL,'006'),

(10187,'2019-11-15','2019-11-24','2019-11-16','Enviado',NULL,'007'),

(10188,'2019-11-18','2019-11-26','2019-11-24','Enviado',NULL,'008'),

(10189,'2019-11-18','2019-11-25','2019-11-24','Enviado',NULL,'008'),

(10190,'2019-11-19','2019-11-29','2019-11-20','Enviado',NULL,'004'),

(10191,'2019-11-20','2019-11-30','2019-11-24','Enviado',NULL,'006'),

(10192,'2019-11-20','2019-11-29','2019-11-25','Enviado',NULL,'001'),

(10193,'2019-11-21','2019-11-28','2019-11-27','Enviado',NULL,'005'),

(10194,'2019-11-25','2019-12-02','2019-11-26','Enviado',NULL,'004'),

(10195,'2019-11-25','2019-12-01','2019-11-28','Enviado',NULL,'003'),

(10196,'2019-11-26','2019-12-03','2019-12-01','Enviado',NULL,'002'),

(10197,'2019-11-26','2019-12-02','2019-12-01','Enviado',NULL,'006'),

(10198,'2019-11-27','2019-12-06','2019-12-03','Enviado',NULL,'008'),

(10199,'2019-12-01','2019-12-10','2019-12-06','Enviado',NULL,'001'),

(10200,'2019-12-01','2019-12-09','2019-12-06','Enviado',NULL,'007'),

(10201,'2019-12-01','2019-12-11','2019-12-02','Enviado',NULL,'001'),

(10202,'2019-12-02','2019-12-09','2019-12-06','Enviado',NULL,'001'),

(10203,'2019-12-02','2019-12-11','2019-12-07','Enviado',NULL,'004'),

(10204,'2019-12-02','2019-12-10','2019-12-04','Enviado',NULL,'001'),

(10205,'2019-12-03','2019-12-09','2019-12-07','Enviado',NULL,'004'),

(10206,'2019-12-05','2019-12-13','2019-12-08','Enviado',NULL,'002'),

(10207,'2019-12-09','2019-12-17','2019-12-11','Enviado',NULL,'002'),

(10208,'2020-01-02','2020-01-11','2020-01-04','Enviado',NULL,'004'),

(10209,'2020-01-09','2020-01-15','2020-01-12','Enviado',NULL,'006'),

(10210,'2020-01-12','2020-01-22','2020-01-20','Enviado',NULL,'007'),

(10211,'2020-01-15','2020-01-25','2020-01-18','Enviado',NULL,'006'),

(10212,'2020-01-16','2020-01-24','2020-01-18','Enviado',NULL,'004'),

(10213,'2020-01-22','2020-01-28','2020-01-27','Enviado',NULL,'006'),

(10214,'2020-01-26','2020-02-04','2020-01-29','Enviado',NULL,'001'),

(10215,'2020-01-29','2020-02-08','2020-02-01','Enviado',NULL,'001'),

(10216,'2020-02-02','2020-02-10','2020-02-04','Enviado',NULL,'006'),

(10217,'2020-02-04','2020-02-14','2020-02-06','Enviado',NULL,'006'),

(10218,'2020-02-09','2020-02-16','2020-02-11','Enviado',NULL,'005'),

(10219,'2020-02-10','2020-02-17','2020-02-12','Enviado',NULL,'010'),

(10220,'2020-02-12','2020-02-19','2020-02-16','Enviado',NULL,'009'),

(10221,'2020-02-18','2020-02-26','2020-02-19','Enviado',NULL,'004'),

(10222,'2020-02-19','2020-02-27','2020-02-20','Enviado',NULL,'005'),

(10223,'2020-02-20','2020-02-29','2020-02-24','Enviado',NULL,'006'),

(10224,'2020-02-21','2020-03-02','2020-02-26','Enviado',NULL,'009'),

(10225,'2020-02-22','2020-03-01','2020-02-24','Enviado',NULL,'010'),

(10226,'2020-02-26','2020-03-06','2020-03-02','Enviado',NULL,'005'),

(10227,'2020-03-02','2020-03-12','2020-03-08','Enviado',NULL,'004'),

(10228,'2020-03-10','2020-03-18','2020-03-13','Enviado',NULL,'010'),

(10229,'2020-03-11','2020-03-20','2020-03-12','Enviado',NULL,'002'),

(10230,'2020-03-15','2020-03-24','2020-03-20','Enviado',NULL,'008'),

(10231,'2020-03-19','2020-03-26','2020-03-25','Enviado',NULL,'009'),

(10232,'2020-03-20','2020-03-30','2020-03-25','Enviado',NULL,'008'),

(10233,'2020-03-29','2020-04-04','2020-04-02','Enviado',NULL,'003'),

(10234,'2020-03-30','2020-04-05','2020-04-02','Enviado',NULL,'001'),

(10235,'2020-04-02','2020-04-12','2020-04-06','Enviado',NULL,'002'),

(10236,'2020-04-03','2020-04-11','2020-04-08','Enviado',NULL,'009'),

(10237,'2020-04-05','2020-04-12','2020-04-10','Enviado',NULL,'002'),

(10238,'2020-04-09','2020-04-16','2020-04-10','Enviado',NULL,'005'),

(10239,'2020-04-12','2020-04-21','2020-04-17','Enviado',NULL,'001'),

(10240,'2020-04-13','2020-04-20','2020-04-20','Enviado',NULL,'007'),

(10241,'2020-04-13','2020-04-20','2020-04-19','Enviado',NULL,'003'),

(10242,'2020-04-20','2020-04-28','2020-04-25','Enviado',NULL,'006'),

(10243,'2020-04-26','2020-05-03','2020-04-28','Enviado',NULL,'002'),

(10244,'2020-04-29','2020-05-09','2020-05-04','Enviado',NULL,'004'),

(10245,'2020-05-04','2020-05-12','2020-05-09','Enviado',NULL,'002'),

(10246,'2020-05-05','2020-05-13','2020-05-06','Enviado',NULL,'004'),

(10247,'2020-05-05','2020-05-11','2020-05-08','Enviado',NULL,'007'),

(10248,'2020-05-07','2020-05-14',NULL,'Cancelado',NULL,'007'),

(10249,'2020-05-08','2020-05-17','2020-05-11','Enviado',NULL,'010'),

(10250,'2020-05-11','2020-05-19','2020-05-15','Enviado',NULL,'003'),

(10251,'2020-05-18','2020-05-24','2020-05-24','Enviado',NULL,'003'),

(10252,'2020-05-26','2020-06-04','2020-05-29','Enviado',NULL,'006'),

(10253,'2020-06-01','2020-06-09','2020-06-02','Cancelado','El cliente se equivocó en la referencia','001'),

(10254,'2020-06-03','2020-06-13','2020-06-04','Enviado',NULL,'004'),

(10255,'2020-06-04','2020-06-12','2020-06-09','Enviado',NULL,'003'),

(10256,'2020-06-08','2020-06-16','2020-06-10','Enviado',NULL,'005'),

(10257,'2020-06-14','2020-06-24','2020-06-15','Enviado',NULL,'003'),

(10258,'2020-06-15','2020-06-25','2020-06-23','Enviado',NULL,'008'),

(10259,'2020-06-15','2020-06-22','2020-06-17','Enviado',NULL,'006'),

(10260,'2020-06-16','2020-06-22',NULL,'Cancelado','Error en la dirección de envío','001'),

(10261,'2020-06-17','2020-06-25','2020-06-22','Enviado',NULL,'009'),

(10262,'2020-06-24','2020-07-01',NULL,'Cancelado',NULL,'004'),

(10263,'2020-06-28','2020-07-04','2020-07-02','Enviado',NULL,'009'),

(10264,'2020-06-30','2020-07-06','2020-07-01','Enviado',NULL,'002'),

(10265,'2020-07-02','2020-07-09','2020-07-07','Enviado',NULL,'005'),

(10266,'2020-07-06','2020-07-14','2020-07-10','Enviado',NULL,'010'),

(10267,'2020-07-07','2020-07-17','2020-07-09','Enviado',NULL,'001'),

(10268,'2020-07-12','2020-07-18','2020-07-14','Enviado',NULL,'001'),

(10269,'2020-07-16','2020-07-22','2020-07-18','Enviado',NULL,'005'),

(10270,'2020-07-19','2020-07-27','2020-07-24','Enviado',NULL,'006'),

(10271,'2020-07-20','2020-07-29','2020-07-23','Enviado',NULL,'002'),

(10272,'2020-07-20','2020-07-26','2020-07-22','Enviado',NULL,'007'),

(10273,'2020-07-21','2020-07-28','2020-07-22','Enviado',NULL,'004'),

(10274,'2020-07-21','2020-07-29','2020-07-22','Enviado',NULL,'009'),

(10275,'2020-07-23','2020-08-02','2020-07-29','Enviado',NULL,'009'),

(10276,'2020-08-02','2020-08-11','2020-08-08','Enviado',NULL,'004'),

(10277,'2020-08-04','2020-08-12','2020-08-05','Enviado',NULL,'004'),

(10278,'2020-08-06','2020-08-16','2020-08-09','Enviado',NULL,'010'),

(10279,'2020-08-09','2020-08-19','2020-08-15','Enviado',NULL,'004'),

(10280,'2020-08-17','2020-08-27','2020-08-19','Enviado',NULL,'009'),

(10281,'2020-08-19','2020-08-28','2020-08-23','Enviado',NULL,'007'),

(10282,'2020-08-20','2020-08-26','2020-08-22','Enviado',NULL,'002'),

(10283,'2020-08-20','2020-08-30','2020-08-23','Enviado',NULL,'002'),

(10284,'2020-08-21','2020-08-29','2020-08-26','Enviado',NULL,'009'),

(10285,'2020-08-27','2020-09-04','2020-08-31','Enviado',NULL,'006'),

(10286,'2020-08-28','2020-09-06','2020-09-01','Enviado',NULL,'003'),

(10287,'2020-08-30','2020-09-06','2020-09-01','Enviado',NULL,'010'),

(10288,'2020-09-01','2020-09-11','2020-09-05','Enviado',NULL,'006'),

(10289,'2020-09-03','2020-09-13','2020-09-04','Enviado',NULL,'008'),

(10290,'2020-09-07','2020-09-15','2020-09-13','Enviado',NULL,'003'),

(10291,'2020-09-08','2020-09-17','2020-09-14','Enviado',NULL,'008'),

(10292,'2020-09-08','2020-09-18','2020-09-11','Enviado',NULL,'007'),

(10293,'2020-09-09','2020-09-18','2020-09-14','Enviado',NULL,'009'),

(10294,'2020-09-10','2020-09-17','2020-09-14','Enviado',NULL,'004'),

(10295,'2020-09-10','2020-09-17','2020-09-14','Enviado',NULL,'002'),

(10296,'2020-09-15','2020-09-22','2020-09-16','Enviado',NULL,'005'),

(10297,'2020-09-16','2020-09-22','2020-09-21','Enviado',NULL,'009'),

(10298,'2020-09-27','2020-10-05','2020-10-01','Enviado',NULL,'009'),

(10299,'2020-09-30','2020-10-10','2020-10-01','Enviado',NULL,'004'),

(10300,'2019-10-04','2019-10-13','2019-10-09','Enviado',NULL,'008'),

(10301,'2019-10-05','2019-10-15','2019-10-08','Enviado',NULL,'009'),

(10302,'2019-10-06','2019-10-16','2019-10-07','Enviado',NULL,'001'),

(10303,'2020-10-06','2020-10-14','2020-10-09','Enviado',NULL,'008'),

(10304,'2020-10-11','2020-10-20','2020-10-17','Enviado',NULL,'006'),

(10305,'2020-10-13','2020-10-22','2020-10-15','Enviado',NULL,'006'),

(10306,'2020-10-14','2020-10-21','2020-10-17','Enviado',NULL,'010'),

(10307,'2020-10-14','2020-10-23','2020-10-20','Enviado',NULL,'009'),

(10308,'2020-10-15','2020-10-24','2020-10-20','Enviado',NULL,'003'),

(10309,'2020-10-15','2020-10-24','2020-10-18','Enviado',NULL,'003'),

(10310,'2020-10-16','2020-10-24','2020-10-18','Enviado',NULL,'006'),

(10311,'2020-10-16','2020-10-23','2020-10-20','Enviado',NULL,'004'),

(10312,'2020-10-21','2020-10-27','2020-10-23','Enviado',NULL,'002'),

(10313,'2020-10-22','2020-10-28','2020-10-25','Enviado',NULL,'002'),

(10314,'2020-10-22','2020-11-01','2020-10-23','Enviado',NULL,'007'),

(10315,'2020-10-29','2020-11-08','2020-10-30','Enviado',NULL,'009'),

(10316,'2020-11-01','2020-11-09','2020-11-07','Enviado',NULL,'008'),

(10317,'2020-11-02','2020-11-12','2020-11-08','Enviado',NULL,'007'),

(10318,'2020-11-02','2020-11-09','2020-11-07','Enviado',NULL,'007'),

(10319,'2020-11-03','2020-11-11','2020-11-06','Enviado',NULL,'006'),

(10320,'2020-11-03','2020-11-13','2020-11-07','Enviado',NULL,'004'),

(10321,'2020-11-04','2020-11-12','2020-11-07','Enviado',NULL,'008'),

(10322,'2020-11-04','2020-11-12','2020-11-10','Enviado',NULL,'001'),

(10323,'2020-11-05','2020-11-12','2020-11-09','Enviado',NULL,'008'),

(10324,'2020-11-05','2020-11-11','2020-11-08','Enviado',NULL,'002'),

(10325,'2020-11-05','2020-11-13','2020-11-08','Enviado',NULL,'003'),

(10326,'2020-11-09','2020-11-16','2020-11-10','Enviado',NULL,'004'),

(10327,'2020-11-10','2020-11-19','2020-11-13','Resuelto',NULL,'005'),

(10328,'2020-11-12','2020-11-21','2020-11-18','Enviado',NULL,'006'),

(10329,'2020-11-15','2020-11-24','2020-11-16','Enviado',NULL,'007'),

(10330,'2020-11-16','2020-11-25','2020-11-21','Enviado',NULL,'008'),

(10331,'2020-11-17','2020-11-23','2020-11-23','Enviado',NULL,'009'),

(10332,'2020-11-17','2020-11-25','2020-11-18','Enviado',NULL,'010'),

(10333,'2020-11-18','2020-11-27','2020-11-20','Enviado',NULL,'001'),

(10334,'2020-11-19','2020-11-28',NULL,'En espera',NULL,'004'),

(10335,'2020-11-19','2020-11-29','2020-11-23','Enviado',NULL,'002'),

(10336,'2020-11-20','2020-11-26','2020-11-24','Enviado',NULL,'003'),

(10337,'2020-11-21','2020-11-30','2020-11-26','Enviado',NULL,'004'),

(10338,'2020-11-22','2020-12-02','2020-11-27','Enviado',NULL,'004'),

(10339,'2020-11-23','2020-11-30','2020-11-30','Enviado',NULL,'008'),

(10340,'2020-11-24','2020-12-01','2020-11-25','Enviado',NULL,'006'),

(10341,'2020-11-24','2020-12-01','2020-11-29','Enviado',NULL,'005'),

(10342,'2020-11-24','2020-12-01','2020-11-29','Enviado',NULL,'006'),

(10343,'2020-11-24','2020-12-01','2020-11-26','Enviado',NULL,'007'),

(10344,'2020-11-25','2020-12-02','2020-11-29','Enviado',NULL,'008'),

(10345,'2020-11-25','2020-12-01','2020-11-26','Enviado',NULL,'009'),

(10346,'2020-11-29','2020-12-05','2020-11-30','Enviado',NULL,'010'),

(10347,'2020-11-29','2020-12-07','2020-11-30','Enviado',NULL,'006'),

(10348,'2020-11-01','2020-11-08','2020-11-05','Enviado',NULL,'001'),

(10349,'2020-12-01','2020-12-07','2020-12-03','Enviado',NULL,'001'),

(10350,'2020-12-02','2020-12-08','2020-12-05','Enviado',NULL,'004'),

(10351,'2020-12-03','2020-12-11','2020-12-07','Enviado',NULL,'002'),

(10352,'2020-12-03','2020-12-12','2020-12-09','Enviado',NULL,'003'),

(10353,'2020-12-04','2020-12-11','2020-12-05','Enviado',NULL,'004'),

(10354,'2020-12-04','2020-12-10','2020-12-05','Enviado',NULL,'004'),

(10355,'2020-12-07','2020-12-14','2020-12-13','Enviado',NULL,'004'),

(10356,'2020-12-09','2020-12-15','2020-12-12','Enviado',NULL,'004'),

(10357,'2020-12-10','2020-12-16','2020-12-14','Enviado',NULL,'002'),

(10358,'2020-12-10','2020-12-16','2020-12-16','Enviado',NULL,'004'),

(10359,'2020-12-15','2020-12-23','2020-12-18','Enviado',NULL,'007'),

(10360,'2020-12-16','2020-12-22','2020-12-18','Enviado',NULL,'005'),

(10361,'2020-12-17','2020-12-24','2020-12-20','Enviado',NULL,'006'),

(10362,'2021-01-05','2021-01-16','2021-01-10','Enviado',NULL,'007'),

(10363,'2021-01-06','2021-01-12','2021-01-10','Enviado',NULL,'007'),

(10364,'2021-01-06','2021-01-17','2021-01-09','Enviado',NULL,'008'),

(10365,'2021-01-07','2021-01-18','2021-01-11','Enviado',NULL,'008'),

(10366,'2021-01-10','2021-01-19','2021-01-12','Enviado',NULL,'004'),

(10367,'2021-01-12','2021-01-21','2021-01-16','Resuelto',NULL,'008'),

(10368,'2021-01-19','2021-01-27','2021-01-24','Enviado',NULL,'002'),

(10369,'2021-01-20','2021-01-28','2021-01-24','Enviado',NULL,'009'),

(10370,'2021-01-20','2021-02-01','2021-01-25','Enviado',NULL,'009'),

(10371,'2021-01-23','2021-02-03','2021-01-25','Enviado',NULL,'002'),

(10372,'2021-01-26','2021-02-05','2021-01-28','Enviado',NULL,'008'),

(10373,'2021-01-31','2021-02-08','2021-02-06','Enviado',NULL,'001'),

(10374,'2021-02-02','2021-02-09','2021-02-03','Enviado',NULL,'003'),

(10375,'2021-02-03','2021-02-10','2021-02-06','Enviado',NULL,'009'),

(10376,'2021-02-08','2021-02-18','2021-02-13','Enviado',NULL,'002'),

(10377,'2021-02-09','2021-02-21','2021-02-12','Enviado',NULL,'004'),

(10378,'2021-02-10','2021-02-18','2021-02-11','Enviado',NULL,'004'),

(10379,'2021-02-10','2021-02-18','2021-02-11','Enviado',NULL,'004'),

(10380,'2021-02-16','2021-02-24','2021-02-18','Enviado',NULL,'004'),

(10381,'2021-02-17','2021-02-25','2021-02-18','Enviado',NULL,'005'),

(10382,'2021-02-17','2021-02-23','2021-02-18','Enviado',NULL,'002'),

(10383,'2021-02-22','2021-03-02','2021-02-25','Enviado',NULL,'004'),

(10384,'2021-02-23','2021-03-06','2021-02-27','Enviado',NULL,'005'),

(10385,'2021-02-28','2021-03-09','2021-03-01','Enviado',NULL,'002'),

(10386,'2021-03-01','2021-03-09','2021-03-06','Resuelto',NULL,'004'),

(10387,'2021-03-02','2021-03-09','2021-03-06','Enviado',NULL,'004'),

(10388,'2021-03-03','2021-03-11','2021-03-09','Enviado',NULL,'008'),

(10389,'2021-03-03','2021-03-09','2021-03-08','Enviado',NULL,'008'),

(10390,'2021-03-04','2021-03-11','2021-03-07','Enviado',NULL,'002'),

(10391,'2021-03-09','2021-03-20','2021-03-15','Enviado',NULL,'009'),

(10392,'2021-03-10','2021-03-18','2021-03-12','Enviado',NULL,'008'),

(10393,'2021-03-11','2021-03-22','2021-03-14','Enviado',NULL,'004'),

(10394,'2021-03-15','2021-03-25','2021-03-19','Enviado',NULL,'004'),

(10395,'2021-03-17','2021-03-24','2021-03-23','Enviado',NULL,'004'),

(10396,'2021-03-23','2021-04-02','2021-03-28','Enviado',NULL,'002'),

(10397,'2021-03-28','2021-04-09','2021-04-01','Enviado',NULL,'010'),

(10398,'2021-03-30','2021-04-09','2021-03-31','Enviado',NULL,'007'),

(10399,'2021-04-01','2021-04-12','2021-04-03','Enviado',NULL,'005'),

(10400,'2021-04-01','2021-04-11','2021-04-04','Enviado',NULL,'003'),

(10401,'2021-04-03','2021-04-14',NULL,'En espera',NULL,'003'),

(10402,'2021-04-07','2021-04-14','2021-04-12','Enviado',NULL,'006'),

(10403,'2021-04-08','2021-04-18','2021-04-11','Enviado',NULL,'001'),

(10404,'2021-04-08','2021-04-14','2021-04-11','Enviado',NULL,'004'),

(10405,'2021-04-14','2021-04-24','2021-04-20','Enviado',NULL,'003'),

(10406,'2021-04-15','2021-04-25','2021-04-21','Reclamado',NULL,'005'),

(10407,'2021-04-22','2021-05-04',NULL,'En espera',NULL,'003'),

(10408,'2021-04-22','2021-04-29','2021-04-27','Enviado',NULL,'008'),

(10409,'2021-04-23','2021-05-05','2021-04-24','Enviado',NULL,'006'),

(10410,'2021-04-29','2021-05-10','2021-04-30','Enviado',NULL,'001'),

(10411,'2021-05-01','2021-05-08','2021-05-06','Enviado',NULL,'009'),

(10412,'2021-05-03','2021-05-13','2021-05-05','Enviado',NULL,'004'),

(10413,'2021-05-05','2021-05-14','2021-05-09','Enviado',NULL,'009'),

(10414,'2021-05-06','2021-05-13',NULL,'En espera',NULL,'002'),

(10415,'2021-05-09','2021-05-20','2021-05-12','Reclamado',NULL,'005'),

(10416,'2021-05-10','2021-05-16','2021-05-14','Enviado',NULL,'010'),

(10417,'2021-05-13','2021-05-19','2021-05-19','Reclamado',NULL,'004'),

(10418,'2021-05-16','2021-05-24','2021-05-20','Enviado',NULL,'001'),

(10419,'2021-05-17','2021-05-28','2021-05-19','Enviado',NULL,'005'),

(10420,'2021-05-29','2021-06-07',NULL,'En proceso',NULL,'006'),

(10421,'2021-05-29','2021-06-06',NULL,'En proceso',NULL,'002'),

(10422,'2021-05-30','2021-06-11',NULL,'En proceso',NULL,'007'),

(10423,'2021-05-30','2021-06-05',NULL,'En proceso',NULL,'004'),

(10424,'2021-05-31','2021-06-08',NULL,'En proceso',NULL,'004'),

(10425,'2021-05-31','2021-06-07',NULL,'En proceso',NULL,'009');
/*Datos para lineapedido */

insert  into `lineapedido`(`numeroPedido`,`codProducto`,`cantidad`,`precio`,`numeroLinea`) values 

(10100,'S18_1749',30,'136.00',3),

(10100,'S18_2248',50,'55.09',2),

(10100,'S18_4409',22,'75.46',4),

(10100,'S24_3969',49,'35.29',1),

(10101,'S18_2325',25,'108.06',4),

(10101,'S18_2795',26,'167.06',1),

(10101,'S24_1937',45,'32.53',3),

(10101,'S24_2022',46,'44.35',2),

(10102,'S18_1342',39,'95.55',2),

(10102,'S18_1367',41,'43.13',1),

(10103,'S10_1949',26,'214.30',11),

(10103,'S10_4962',42,'119.67',4),

(10103,'S12_1666',27,'121.64',8),

(10103,'S18_1097',35,'94.50',10),

(10103,'S18_2432',22,'58.34',2),

(10103,'S18_2949',27,'92.19',12),

(10103,'S18_2957',35,'61.84',14),

(10103,'S18_3136',25,'86.92',13),

(10103,'S18_3320',46,'86.31',16),

(10103,'S18_4600',36,'98.07',5),

(10103,'S18_4668',41,'40.75',9),

(10103,'S24_2300',36,'107.34',1),

(10103,'S24_4258',25,'88.62',15),

(10103,'S32_1268',31,'92.46',3),

(10103,'S32_3522',45,'63.35',7),

(10103,'S700_2824',42,'94.07',6),

(10104,'S12_3148',34,'131.44',1),

(10104,'S12_4473',41,'111.39',9),

(10104,'S18_2238',24,'135.90',8),

(10104,'S18_2319',29,'122.73',12),

(10104,'S18_3232',23,'165.95',13),

(10104,'S18_4027',38,'119.20',3),

(10104,'S24_1444',35,'52.02',6),

(10104,'S24_2840',44,'30.41',10),

(10104,'S24_4048',26,'106.45',5),

(10104,'S32_2509',35,'51.95',11),

(10104,'S32_3207',49,'56.55',4),

(10104,'S50_1392',33,'114.59',7),

(10104,'S50_1514',32,'53.31',2),

(10105,'S10_4757',50,'127.84',2),

(10105,'S12_1108',41,'205.72',15),

(10105,'S12_3891',29,'141.88',14),

(10105,'S18_3140',22,'136.59',11),

(10105,'S18_3259',38,'87.73',13),

(10105,'S18_4522',41,'75.48',10),

(10105,'S24_2011',43,'117.97',9),

(10105,'S24_3151',44,'73.46',4),

(10105,'S24_3816',50,'75.47',1),

(10105,'S700_1138',41,'54.00',5),

(10105,'S700_1938',29,'86.61',12),

(10105,'S700_2610',31,'60.72',3),

(10105,'S700_3505',39,'92.16',6),

(10105,'S700_3962',22,'99.31',7),

(10105,'S72_3212',25,'44.77',8),

(10106,'S18_1662',36,'134.04',12),

(10106,'S18_2581',34,'81.10',2),

(10106,'S18_3029',41,'80.86',18),

(10106,'S18_3856',41,'94.22',17),

(10106,'S24_1785',28,'107.23',4),

(10106,'S24_2841',49,'65.77',13),

(10106,'S24_3420',31,'55.89',14),

(10106,'S24_3949',50,'55.96',11),

(10106,'S24_4278',26,'71.00',3),

(10106,'S32_4289',33,'65.35',5),

(10106,'S50_1341',39,'35.78',6),

(10106,'S700_1691',31,'91.34',7),

(10106,'S700_2047',30,'85.09',16),

(10106,'S700_2466',34,'99.72',9),

(10106,'S700_2834',32,'113.90',1),

(10106,'S700_3167',44,'76.00',8),

(10106,'S700_4002',48,'70.33',10),

(10106,'S72_1253',48,'43.70',15),

(10107,'S10_1678',30,'81.35',2),

(10107,'S10_2016',39,'105.86',5),

(10107,'S10_4698',27,'172.36',4),

(10107,'S12_2823',21,'122.00',1),

(10107,'S18_2625',29,'52.70',6),

(10107,'S24_1578',25,'96.92',3),

(10107,'S24_2000',38,'73.12',7),

(10107,'S32_1374',20,'88.90',8),

(10108,'S12_1099',33,'165.38',6),

(10108,'S12_3380',45,'96.30',4),

(10108,'S12_3990',39,'75.81',7),

(10108,'S12_4675',36,'107.10',3),

(10108,'S18_1889',38,'67.76',2),

(10108,'S18_3278',26,'73.17',9),

(10108,'S18_3482',29,'132.29',8),

(10108,'S18_3782',43,'52.84',12),

(10108,'S18_4721',44,'139.87',11),

(10108,'S24_2360',35,'64.41',15),

(10108,'S24_3371',30,'60.01',5),

(10108,'S24_3856',40,'132.00',1),

(10108,'S24_4620',31,'67.10',10),

(10108,'S32_2206',27,'36.21',13),

(10108,'S32_4485',31,'87.76',16),

(10108,'S50_4713',34,'74.85',14),

(10109,'S18_1129',26,'117.48',4),

(10109,'S18_1984',38,'137.98',3),

(10109,'S18_2870',26,'126.72',1),

(10109,'S18_3232',46,'160.87',5),

(10109,'S18_3685',47,'125.74',2),

(10109,'S24_2972',29,'32.10',6),

(10110,'S18_1589',37,'118.22',16),

(10110,'S18_1749',42,'153.00',7),

(10110,'S18_2248',32,'51.46',6),

(10110,'S18_2325',33,'115.69',4),

(10110,'S18_2795',31,'163.69',1),

(10110,'S18_4409',28,'81.91',8),

(10110,'S18_4933',42,'62.00',9),

(10110,'S24_1046',36,'72.02',13),

(10110,'S24_1628',29,'43.27',15),

(10110,'S24_1937',20,'28.88',3),

(10110,'S24_2022',39,'40.77',2),

(10110,'S24_2766',43,'82.69',11),

(10110,'S24_2887',46,'112.74',10),

(10110,'S24_3191',27,'80.47',12),

(10110,'S24_3432',37,'96.37',14),

(10110,'S24_3969',48,'35.29',5),

(10111,'S18_1342',33,'87.33',6),

(10111,'S18_1367',48,'48.52',5),

(10111,'S18_2957',28,'53.09',2),

(10111,'S18_3136',43,'94.25',1),

(10111,'S18_3320',39,'91.27',4),

(10111,'S24_4258',26,'85.70',3),

(10112,'S10_1949',29,'197.16',1),

(10112,'S18_2949',23,'85.10',2),

(10113,'S12_1666',21,'121.64',2),

(10113,'S18_1097',49,'101.50',4),

(10113,'S18_4668',50,'43.27',3),

(10113,'S32_3522',23,'58.82',1),

(10114,'S10_4962',31,'128.53',8),

(10114,'S18_2319',39,'106.78',3),

(10114,'S18_2432',45,'53.48',6),

(10114,'S18_3232',48,'169.34',4),

(10114,'S18_4600',41,'105.34',9),

(10114,'S24_2300',21,'102.23',5),

(10114,'S24_2840',24,'28.64',1),

(10114,'S32_1268',32,'88.61',7),

(10114,'S32_2509',28,'43.83',2),

(10114,'S700_2824',42,'82.94',10),

(10115,'S12_4473',46,'111.39',5),

(10115,'S18_2238',46,'140.81',4),

(10115,'S24_1444',47,'56.64',2),

(10115,'S24_4048',44,'106.45',1),

(10115,'S50_1392',27,'100.70',3),

(10116,'S32_3207',27,'60.28',1),

(10117,'S12_1108',33,'195.33',9),

(10117,'S12_3148',43,'148.06',10),

(10117,'S12_3891',39,'173.02',8),

(10117,'S18_3140',26,'121.57',5),

(10117,'S18_3259',21,'81.68',7),

(10117,'S18_4027',22,'122.08',12),

(10117,'S18_4522',23,'73.73',4),

(10117,'S24_2011',41,'119.20',3),

(10117,'S50_1514',21,'55.65',11),

(10117,'S700_1938',38,'75.35',6),

(10117,'S700_3962',45,'89.38',1),

(10117,'S72_3212',50,'52.42',2),

(10118,'S700_3505',36,'86.15',1),

(10119,'S10_4757',46,'112.88',11),

(10119,'S18_1662',43,'151.38',3),

(10119,'S18_3029',21,'74.84',9),

(10119,'S18_3856',27,'95.28',8),

(10119,'S24_2841',41,'64.40',4),

(10119,'S24_3151',35,'72.58',13),

(10119,'S24_3420',20,'63.12',5),

(10119,'S24_3816',35,'82.18',10),

(10119,'S24_3949',28,'62.10',2),

(10119,'S700_1138',25,'57.34',14),

(10119,'S700_2047',29,'74.23',7),

(10119,'S700_2610',38,'67.22',12),

(10119,'S700_4002',26,'63.67',1),

(10119,'S72_1253',28,'40.22',6),

(10120,'S10_2016',29,'118.94',3),

(10120,'S10_4698',46,'158.80',2),

(10120,'S18_2581',29,'82.79',8),

(10120,'S18_2625',46,'57.54',4),

(10120,'S24_1578',35,'110.45',1),

(10120,'S24_1785',39,'93.01',10),

(10120,'S24_2000',34,'72.36',5),

(10120,'S24_4278',29,'71.73',9),

(10120,'S32_1374',22,'94.90',6),

(10120,'S32_4289',29,'68.79',11),

(10120,'S50_1341',49,'41.46',12),

(10120,'S700_1691',47,'91.34',13),

(10120,'S700_2466',24,'81.77',15),

(10120,'S700_2834',24,'106.79',7),

(10120,'S700_3167',43,'72.00',14),

(10121,'S10_1678',34,'86.13',5),

(10121,'S12_2823',50,'126.52',4),

(10121,'S24_2360',32,'58.18',2),

(10121,'S32_4485',25,'95.93',3),

(10121,'S50_4713',44,'72.41',1),

(10122,'S12_1099',42,'155.66',10),

(10122,'S12_3380',37,'113.92',8),

(10122,'S12_3990',32,'65.44',11),

(10122,'S12_4675',20,'104.80',7),

(10122,'S18_1129',34,'114.65',2),

(10122,'S18_1889',43,'62.37',6),

(10122,'S18_1984',31,'113.80',1),

(10122,'S18_3232',25,'137.17',3),

(10122,'S18_3278',21,'69.15',13),

(10122,'S18_3482',21,'133.76',12),

(10122,'S18_3782',35,'59.06',16),

(10122,'S18_4721',28,'145.82',15),

(10122,'S24_2972',39,'34.74',4),

(10122,'S24_3371',34,'50.82',9),

(10122,'S24_3856',43,'136.22',5),

(10122,'S24_4620',29,'67.10',14),

(10122,'S32_2206',31,'33.79',17),

(10123,'S18_1589',26,'120.71',2),

(10123,'S18_2870',46,'114.84',3),

(10123,'S18_3685',34,'117.26',4),

(10123,'S24_1628',50,'43.27',1),

(10124,'S18_1749',21,'153.00',6),

(10124,'S18_2248',42,'58.12',5),

(10124,'S18_2325',42,'111.87',3),

(10124,'S18_4409',36,'75.46',7),

(10124,'S18_4933',23,'66.28',8),

(10124,'S24_1046',22,'62.47',12),

(10124,'S24_1937',45,'30.53',2),

(10124,'S24_2022',22,'36.29',1),

(10124,'S24_2766',32,'74.51',10),

(10124,'S24_2887',25,'93.95',9),

(10124,'S24_3191',49,'76.19',11),

(10124,'S24_3432',43,'101.73',13),

(10124,'S24_3969',46,'36.11',4),

(10125,'S18_1342',32,'89.38',1),

(10125,'S18_2795',34,'138.38',2),

(10126,'S10_1949',38,'205.73',11),

(10126,'S10_4962',22,'122.62',4),

(10126,'S12_1666',21,'135.30',8),

(10126,'S18_1097',38,'116.67',10),

(10126,'S18_1367',42,'51.21',17),

(10126,'S18_2432',43,'51.05',2),

(10126,'S18_2949',31,'93.21',12),

(10126,'S18_2957',46,'61.84',14),

(10126,'S18_3136',30,'93.20',13),

(10126,'S18_3320',38,'94.25',16),

(10126,'S18_4600',50,'102.92',5),

(10126,'S18_4668',43,'47.29',9),

(10126,'S24_2300',27,'122.68',1),

(10126,'S24_4258',34,'83.76',15),

(10126,'S32_1268',43,'82.83',3),

(10126,'S32_3522',26,'62.05',7),

(10126,'S700_2824',45,'97.10',6),

(10127,'S12_1108',46,'193.25',2),

(10127,'S12_3148',46,'140.50',3),

(10127,'S12_3891',42,'169.56',1),

(10127,'S12_4473',24,'100.73',11),

(10127,'S18_2238',45,'140.81',10),

(10127,'S18_2319',45,'114.14',14),

(10127,'S18_3232',22,'149.02',15),

(10127,'S18_4027',25,'126.39',5),

(10127,'S24_1444',20,'50.86',8),

(10127,'S24_2840',39,'34.30',12),

(10127,'S24_4048',20,'107.63',7),

(10127,'S32_2509',45,'46.53',13),

(10127,'S32_3207',29,'60.90',6),

(10127,'S50_1392',46,'111.12',9),

(10127,'S50_1514',46,'55.65',4),

(10128,'S18_3140',41,'120.20',2),

(10128,'S18_3259',41,'80.67',4),

(10128,'S18_4522',43,'77.24',1),

(10128,'S700_1938',32,'72.75',3),

(10129,'S10_4757',33,'123.76',2),

(10129,'S24_2011',45,'113.06',9),

(10129,'S24_3151',41,'81.43',4),

(10129,'S24_3816',50,'76.31',1),

(10129,'S700_1138',31,'58.67',5),

(10129,'S700_2610',45,'72.28',3),

(10129,'S700_3505',42,'90.15',6),

(10129,'S700_3962',30,'94.34',7),

(10129,'S72_3212',32,'44.23',8),

(10130,'S18_3029',40,'68.82',2),

(10130,'S18_3856',33,'99.52',1),

(10131,'S18_1662',21,'141.92',4),

(10131,'S24_2841',35,'60.97',5),

(10131,'S24_3420',29,'52.60',6),

(10131,'S24_3949',50,'54.59',3),

(10131,'S700_2047',22,'76.94',8),

(10131,'S700_2466',40,'86.76',1),

(10131,'S700_4002',26,'63.67',2),

(10131,'S72_1253',21,'40.22',7),

(10132,'S700_3167',36,'80.00',1),

(10133,'S18_2581',49,'80.26',3),

(10133,'S24_1785',41,'109.42',5),

(10133,'S24_4278',46,'61.58',4),

(10133,'S32_1374',23,'80.91',1),

(10133,'S32_4289',49,'67.41',6),

(10133,'S50_1341',27,'37.09',7),

(10133,'S700_1691',24,'76.73',8),

(10133,'S700_2834',27,'115.09',2),

(10134,'S10_1678',41,'90.92',2),

(10134,'S10_2016',27,'116.56',5),

(10134,'S10_4698',31,'187.85',4),

(10134,'S12_2823',20,'131.04',1),

(10134,'S18_2625',30,'51.48',6),

(10134,'S24_1578',35,'94.67',3),

(10134,'S24_2000',43,'75.41',7),

(10135,'S12_1099',42,'173.17',7),

(10135,'S12_3380',48,'110.39',5),

(10135,'S12_3990',24,'72.62',8),

(10135,'S12_4675',29,'103.64',4),

(10135,'S18_1889',48,'66.99',3),

(10135,'S18_3278',45,'65.94',10),

(10135,'S18_3482',42,'139.64',9),

(10135,'S18_3782',45,'49.74',13),

(10135,'S18_4721',31,'133.92',12),

(10135,'S24_2360',29,'67.18',16),

(10135,'S24_2972',20,'34.36',1),

(10135,'S24_3371',27,'52.05',6),

(10135,'S24_3856',47,'139.03',2),

(10135,'S24_4620',23,'76.80',11),

(10135,'S32_2206',33,'38.62',14),

(10135,'S32_4485',30,'91.85',17),

(10135,'S50_4713',44,'78.92',15),

(10136,'S18_1129',25,'117.48',2),

(10136,'S18_1984',36,'120.91',1),

(10136,'S18_3232',41,'169.34',3),

(10137,'S18_1589',44,'115.73',2),

(10137,'S18_2870',37,'110.88',3),

(10137,'S18_3685',31,'118.68',4),

(10137,'S24_1628',26,'40.25',1),

(10138,'S18_1749',33,'149.60',6),

(10138,'S18_2248',22,'51.46',5),

(10138,'S18_2325',38,'114.42',3),

(10138,'S18_4409',47,'79.15',7),

(10138,'S18_4933',23,'64.86',8),

(10138,'S24_1046',45,'59.53',12),

(10138,'S24_1937',22,'33.19',2),

(10138,'S24_2022',33,'38.53',1),

(10138,'S24_2766',28,'73.60',10),

(10138,'S24_2887',30,'96.30',9),

(10138,'S24_3191',49,'77.05',11),

(10138,'S24_3432',21,'99.58',13),

(10138,'S24_3969',29,'32.82',4),

(10139,'S18_1342',31,'89.38',7),

(10139,'S18_1367',49,'52.83',6),

(10139,'S18_2795',41,'151.88',8),

(10139,'S18_2949',46,'91.18',1),

(10139,'S18_2957',20,'52.47',3),

(10139,'S18_3136',20,'101.58',2),

(10139,'S18_3320',30,'81.35',5),

(10139,'S24_4258',29,'93.49',4),

(10140,'S10_1949',37,'186.44',11),

(10140,'S10_4962',26,'131.49',4),

(10140,'S12_1666',38,'118.90',8),

(10140,'S18_1097',32,'95.67',10),

(10140,'S18_2432',46,'51.05',2),

(10140,'S18_4600',40,'100.50',5),

(10140,'S18_4668',29,'40.25',9),

(10140,'S24_2300',47,'118.84',1),

(10140,'S32_1268',26,'87.64',3),

(10140,'S32_3522',28,'62.05',7),

(10140,'S700_2824',36,'101.15',6),

(10141,'S12_4473',21,'114.95',5),

(10141,'S18_2238',39,'160.46',4),

(10141,'S18_2319',47,'103.09',8),

(10141,'S18_3232',34,'143.94',9),

(10141,'S24_1444',20,'50.86',2),

(10141,'S24_2840',21,'32.18',6),

(10141,'S24_4048',40,'104.09',1),

(10141,'S32_2509',24,'53.03',7),

(10141,'S50_1392',44,'94.92',3),

(10142,'S12_1108',33,'166.24',12),

(10142,'S12_3148',33,'140.50',13),

(10142,'S12_3891',46,'167.83',11),

(10142,'S18_3140',47,'129.76',8),

(10142,'S18_3259',22,'95.80',10),

(10142,'S18_4027',24,'122.08',15),

(10142,'S18_4522',24,'79.87',7),

(10142,'S24_2011',33,'114.29',6),

(10142,'S24_3151',49,'74.35',1),

(10142,'S32_3207',42,'60.90',16),

(10142,'S50_1514',42,'56.24',14),

(10142,'S700_1138',41,'55.34',2),

(10142,'S700_1938',43,'77.08',9),

(10142,'S700_3505',21,'92.16',3),

(10142,'S700_3962',38,'91.37',4),

(10142,'S72_3212',39,'46.96',5),

(10143,'S10_4757',49,'133.28',15),

(10143,'S18_1662',32,'126.15',7),

(10143,'S18_3029',46,'70.54',13),

(10143,'S18_3856',34,'99.52',12),

(10143,'S24_2841',27,'63.71',8),

(10143,'S24_3420',33,'59.83',9),

(10143,'S24_3816',23,'74.64',14),

(10143,'S24_3949',28,'55.96',6),

(10143,'S50_1341',34,'34.91',1),

(10143,'S700_1691',36,'86.77',2),

(10143,'S700_2047',26,'87.80',11),

(10143,'S700_2466',26,'79.78',4),

(10143,'S700_2610',31,'69.39',16),

(10143,'S700_3167',28,'70.40',3),

(10143,'S700_4002',34,'65.15',5),

(10143,'S72_1253',37,'49.66',10),

(10144,'S32_4289',20,'56.41',1),

(10145,'S10_1678',45,'76.56',6),

(10145,'S10_2016',37,'104.67',9),

(10145,'S10_4698',33,'154.93',8),

(10145,'S12_2823',49,'146.10',5),

(10145,'S18_2581',30,'71.81',14),

(10145,'S18_2625',30,'52.70',10),

(10145,'S24_1578',43,'103.68',7),

(10145,'S24_1785',40,'87.54',16),

(10145,'S24_2000',47,'63.98',11),

(10145,'S24_2360',27,'56.10',3),

(10145,'S24_4278',33,'71.73',15),

(10145,'S32_1374',33,'99.89',12),

(10145,'S32_2206',31,'39.43',1),

(10145,'S32_4485',27,'95.93',4),

(10145,'S50_4713',38,'73.22',2),

(10145,'S700_2834',20,'113.90',13),

(10146,'S18_3782',47,'60.30',2),

(10146,'S18_4721',29,'130.94',1),

(10147,'S12_1099',48,'161.49',7),

(10147,'S12_3380',31,'110.39',5),

(10147,'S12_3990',21,'74.21',8),

(10147,'S12_4675',33,'97.89',4),

(10147,'S18_1889',26,'70.84',3),

(10147,'S18_3278',36,'74.78',10),

(10147,'S18_3482',37,'129.35',9),

(10147,'S24_2972',25,'33.23',1),

(10147,'S24_3371',30,'48.98',6),

(10147,'S24_3856',23,'123.58',2),

(10147,'S24_4620',31,'72.76',11),

(10148,'S18_1129',23,'114.65',13),

(10148,'S18_1589',47,'108.26',9),

(10148,'S18_1984',25,'136.56',12),

(10148,'S18_2870',27,'113.52',10),

(10148,'S18_3232',32,'143.94',14),

(10148,'S18_3685',28,'135.63',11),

(10148,'S18_4409',34,'83.75',1),

(10148,'S18_4933',29,'66.28',2),

(10148,'S24_1046',25,'65.41',6),

(10148,'S24_1628',47,'46.29',8),

(10148,'S24_2766',21,'77.24',4),

(10148,'S24_2887',34,'115.09',3),

(10148,'S24_3191',31,'71.91',5),

(10148,'S24_3432',27,'96.37',7),

(10149,'S18_1342',50,'87.33',4),

(10149,'S18_1367',30,'48.52',3),

(10149,'S18_1749',34,'156.40',11),

(10149,'S18_2248',24,'50.85',10),

(10149,'S18_2325',33,'125.86',8),

(10149,'S18_2795',23,'167.06',5),

(10149,'S18_3320',42,'89.29',2),

(10149,'S24_1937',36,'31.20',7),

(10149,'S24_2022',49,'39.87',6),

(10149,'S24_3969',26,'38.57',9),

(10149,'S24_4258',20,'90.57',1),

(10150,'S10_1949',45,'182.16',8),

(10150,'S10_4962',20,'121.15',1),

(10150,'S12_1666',30,'135.30',5),

(10150,'S18_1097',34,'95.67',7),

(10150,'S18_2949',47,'93.21',9),

(10150,'S18_2957',30,'56.21',11),

(10150,'S18_3136',26,'97.39',10),

(10150,'S18_4600',49,'111.39',2),

(10150,'S18_4668',30,'47.29',6),

(10150,'S32_3522',49,'62.05',4),

(10150,'S700_2824',20,'95.08',3),

(10151,'S12_4473',24,'114.95',3),

(10151,'S18_2238',43,'152.27',2),

(10151,'S18_2319',49,'106.78',6),

(10151,'S18_2432',39,'58.34',9),

(10151,'S18_3232',21,'167.65',7),

(10151,'S24_2300',42,'109.90',8),

(10151,'S24_2840',30,'29.35',4),

(10151,'S32_1268',27,'84.75',10),

(10151,'S32_2509',41,'43.29',5),

(10151,'S50_1392',26,'108.81',1),

(10152,'S18_4027',35,'117.77',1),

(10152,'S24_1444',25,'49.13',4),

(10152,'S24_4048',23,'112.37',3),

(10152,'S32_3207',33,'57.17',2),

(10153,'S12_1108',20,'201.57',11),

(10153,'S12_3148',42,'128.42',12),

(10153,'S12_3891',49,'155.72',10),

(10153,'S18_3140',31,'125.66',7),

(10153,'S18_3259',29,'82.69',9),

(10153,'S18_4522',22,'82.50',6),

(10153,'S24_2011',40,'111.83',5),

(10153,'S50_1514',31,'53.31',13),

(10153,'S700_1138',43,'58.00',1),

(10153,'S700_1938',31,'80.55',8),

(10153,'S700_3505',50,'87.15',2),

(10153,'S700_3962',20,'85.41',3),

(10153,'S72_3212',50,'51.87',4),

(10154,'S24_3151',31,'75.23',2),

(10154,'S700_2610',36,'59.27',1),

(10155,'S10_4757',32,'129.20',13),

(10155,'S18_1662',38,'138.77',5),

(10155,'S18_3029',44,'83.44',11),

(10155,'S18_3856',29,'105.87',10),

(10155,'S24_2841',23,'62.34',6),

(10155,'S24_3420',34,'56.55',7),

(10155,'S24_3816',37,'76.31',12),

(10155,'S24_3949',44,'58.69',4),

(10155,'S700_2047',32,'89.61',9),

(10155,'S700_2466',20,'87.75',2),

(10155,'S700_3167',43,'76.80',1),

(10155,'S700_4002',44,'70.33',3),

(10155,'S72_1253',34,'49.16',8),

(10156,'S50_1341',20,'43.64',1),

(10156,'S700_1691',48,'77.64',2),

(10157,'S18_2581',33,'69.27',3),

(10157,'S24_1785',40,'89.72',5),

(10157,'S24_4278',33,'66.65',4),

(10157,'S32_1374',34,'83.91',1),

(10157,'S32_4289',28,'56.41',6),

(10157,'S700_2834',48,'109.16',2),

(10158,'S24_2000',22,'67.79',1),

(10159,'S10_1678',49,'81.35',14),

(10159,'S10_2016',37,'101.10',17),

(10159,'S10_4698',22,'170.42',16),

(10159,'S12_1099',41,'188.73',2),

(10159,'S12_2823',38,'131.04',13),

(10159,'S12_3990',24,'67.03',3),

(10159,'S18_2625',42,'51.48',18),

(10159,'S18_3278',21,'66.74',5),

(10159,'S18_3482',25,'129.35',4),

(10159,'S18_3782',21,'54.71',8),

(10159,'S18_4721',32,'142.85',7),

(10159,'S24_1578',44,'100.30',15),

(10159,'S24_2360',27,'67.18',11),

(10159,'S24_3371',50,'49.60',1),

(10159,'S24_4620',23,'80.84',6),

(10159,'S32_2206',35,'39.43',9),

(10159,'S32_4485',23,'86.74',12),

(10159,'S50_4713',31,'78.11',10),

(10160,'S12_3380',46,'96.30',6),

(10160,'S12_4675',50,'93.28',5),

(10160,'S18_1889',38,'70.84',4),

(10160,'S18_3232',20,'140.55',1),

(10160,'S24_2972',42,'30.59',2),

(10160,'S24_3856',35,'130.60',3),

(10161,'S18_1129',28,'121.72',12),

(10161,'S18_1589',43,'102.04',8),

(10161,'S18_1984',48,'139.41',11),

(10161,'S18_2870',23,'125.40',9),

(10161,'S18_3685',36,'132.80',10),

(10161,'S18_4933',25,'62.72',1),

(10161,'S24_1046',37,'73.49',5),

(10161,'S24_1628',23,'47.29',7),

(10161,'S24_2766',20,'82.69',3),

(10161,'S24_2887',25,'108.04',2),

(10161,'S24_3191',20,'72.77',4),

(10161,'S24_3432',30,'94.23',6),

(10162,'S18_1342',48,'87.33',2),

(10162,'S18_1367',45,'45.28',1),

(10162,'S18_1749',29,'141.10',9),

(10162,'S18_2248',27,'53.28',8),

(10162,'S18_2325',38,'113.15',6),

(10162,'S18_2795',48,'156.94',3),

(10162,'S18_4409',39,'86.51',10),

(10162,'S24_1937',37,'27.55',5),

(10162,'S24_2022',43,'38.98',4),

(10162,'S24_3969',37,'32.82',7),

(10163,'S10_1949',21,'212.16',1),

(10163,'S18_2949',31,'101.31',2),

(10163,'S18_2957',48,'59.96',4),

(10163,'S18_3136',40,'101.58',3),

(10163,'S18_3320',43,'80.36',6),

(10163,'S24_4258',42,'96.42',5),

(10164,'S10_4962',21,'143.31',2),

(10164,'S12_1666',49,'121.64',6),

(10164,'S18_1097',36,'103.84',8),

(10164,'S18_4600',45,'107.76',3),

(10164,'S18_4668',25,'46.29',7),

(10164,'S32_1268',24,'91.49',1),

(10164,'S32_3522',49,'57.53',5),

(10164,'S700_2824',39,'86.99',4),

(10165,'S12_1108',44,'168.32',3),

(10165,'S12_3148',34,'123.89',4),

(10165,'S12_3891',27,'152.26',2),

(10165,'S12_4473',48,'109.02',12),

(10165,'S18_2238',29,'134.26',11),

(10165,'S18_2319',46,'120.28',15),

(10165,'S18_2432',31,'60.77',18),

(10165,'S18_3232',47,'154.10',16),

(10165,'S18_3259',50,'84.71',1),

(10165,'S18_4027',28,'123.51',6),

(10165,'S24_1444',25,'46.82',9),

(10165,'S24_2300',32,'117.57',17),

(10165,'S24_2840',27,'31.12',13),

(10165,'S24_4048',24,'106.45',8),

(10165,'S32_2509',48,'50.86',14),

(10165,'S32_3207',44,'55.30',7),

(10165,'S50_1392',48,'106.49',10),

(10165,'S50_1514',38,'49.21',5),

(10166,'S18_3140',43,'136.59',2),

(10166,'S18_4522',26,'72.85',1),

(10166,'S700_1938',29,'76.22',3),

(10167,'S10_4757',44,'123.76',9),

(10167,'S18_1662',43,'141.92',1),

(10167,'S18_3029',46,'69.68',7),

(10167,'S18_3856',34,'84.70',6),

(10167,'S24_2011',33,'110.60',16),

(10167,'S24_2841',21,'54.81',2),

(10167,'S24_3151',20,'77.00',11),

(10167,'S24_3420',32,'64.44',3),

(10167,'S24_3816',29,'73.80',8),

(10167,'S700_1138',43,'66.00',12),

(10167,'S700_2047',29,'87.80',5),

(10167,'S700_2610',46,'62.16',10),

(10167,'S700_3505',24,'85.14',13),

(10167,'S700_3962',28,'83.42',14),

(10167,'S72_1253',40,'42.71',4),

(10167,'S72_3212',38,'43.68',15),

(10168,'S10_1678',36,'94.74',1),

(10168,'S10_2016',27,'97.53',4),

(10168,'S10_4698',20,'160.74',3),

(10168,'S18_2581',21,'75.19',9),

(10168,'S18_2625',46,'49.06',5),

(10168,'S24_1578',50,'103.68',2),

(10168,'S24_1785',49,'93.01',11),

(10168,'S24_2000',29,'72.36',6),

(10168,'S24_3949',27,'57.32',18),

(10168,'S24_4278',48,'68.10',10),

(10168,'S32_1374',28,'89.90',7),

(10168,'S32_4289',31,'57.78',12),

(10168,'S50_1341',48,'39.71',13),

(10168,'S700_1691',28,'91.34',14),

(10168,'S700_2466',31,'87.75',16),

(10168,'S700_2834',36,'94.92',8),

(10168,'S700_3167',48,'72.00',15),

(10168,'S700_4002',39,'67.37',17),

(10169,'S12_1099',30,'163.44',2),

(10169,'S12_2823',35,'126.52',13),

(10169,'S12_3990',36,'71.82',3),

(10169,'S18_3278',32,'65.13',5),

(10169,'S18_3482',36,'136.70',4),

(10169,'S18_3782',38,'52.84',8),

(10169,'S18_4721',33,'120.53',7),

(10169,'S24_2360',38,'66.49',11),

(10169,'S24_3371',34,'53.27',1),

(10169,'S24_4620',24,'77.61',6),

(10169,'S32_2206',26,'37.01',9),

(10169,'S32_4485',34,'83.68',12),

(10169,'S50_4713',48,'75.66',10),

(10170,'S12_3380',47,'116.27',4),

(10170,'S12_4675',41,'93.28',3),

(10170,'S18_1889',20,'70.07',2),

(10170,'S24_3856',34,'130.60',1),

(10171,'S18_1129',35,'134.46',2),

(10171,'S18_1984',35,'128.03',1),

(10171,'S18_3232',39,'165.95',3),

(10171,'S24_2972',36,'34.74',4),

(10172,'S18_1589',42,'109.51',6),

(10172,'S18_2870',39,'117.48',7),

(10172,'S18_3685',48,'139.87',8),

(10172,'S24_1046',32,'61.00',3),

(10172,'S24_1628',34,'43.27',5),

(10172,'S24_2766',22,'79.97',1),

(10172,'S24_3191',24,'77.91',2),

(10172,'S24_3432',22,'87.81',4),

(10173,'S18_1342',43,'101.71',6),

(10173,'S18_1367',48,'51.75',5),

(10173,'S18_1749',24,'168.30',13),

(10173,'S18_2248',26,'55.09',12),

(10173,'S18_2325',31,'127.13',10),

(10173,'S18_2795',22,'140.06',7),

(10173,'S18_2957',28,'56.84',2),

(10173,'S18_3136',31,'86.92',1),

(10173,'S18_3320',29,'90.28',4),

(10173,'S18_4409',21,'77.31',14),

(10173,'S18_4933',39,'58.44',15),

(10173,'S24_1937',31,'29.87',9),

(10173,'S24_2022',27,'39.42',8),

(10173,'S24_2887',23,'98.65',16),

(10173,'S24_3969',35,'35.70',11),

(10173,'S24_4258',22,'93.49',3),

(10174,'S10_1949',34,'207.87',4),

(10174,'S12_1666',43,'113.44',1),

(10174,'S18_1097',48,'108.50',3),

(10174,'S18_2949',46,'100.30',5),

(10174,'S18_4668',49,'44.27',2),

(10175,'S10_4962',33,'119.67',9),

(10175,'S12_4473',26,'109.02',1),

(10175,'S18_2319',48,'101.87',4),

(10175,'S18_2432',41,'59.55',7),

(10175,'S18_3232',29,'150.71',5),

(10175,'S18_4600',47,'102.92',10),

(10175,'S24_2300',28,'121.40',6),

(10175,'S24_2840',37,'32.18',2),

(10175,'S32_1268',22,'89.57',8),

(10175,'S32_2509',50,'50.86',3),

(10175,'S32_3522',29,'56.24',12),

(10175,'S700_2824',42,'80.92',11),

(10176,'S12_1108',33,'166.24',2),

(10176,'S12_3148',47,'145.04',3),

(10176,'S12_3891',50,'160.91',1),

(10176,'S18_2238',20,'139.17',10),

(10176,'S18_4027',36,'140.75',5),

(10176,'S24_1444',27,'55.49',8),

(10176,'S24_4048',29,'101.72',7),

(10176,'S32_3207',22,'62.14',6),

(10176,'S50_1392',23,'109.96',9),

(10176,'S50_1514',38,'52.14',4),

(10177,'S18_3140',23,'113.37',9),

(10177,'S18_3259',29,'92.77',11),

(10177,'S18_4522',35,'82.50',8),

(10177,'S24_2011',50,'115.52',7),

(10177,'S24_3151',45,'79.66',2),

(10177,'S700_1138',24,'58.67',3),

(10177,'S700_1938',31,'77.95',10),

(10177,'S700_2610',32,'64.33',1),

(10177,'S700_3505',44,'88.15',4),

(10177,'S700_3962',24,'83.42',5),

(10177,'S72_3212',40,'52.96',6),

(10178,'S10_4757',24,'131.92',12),

(10178,'S18_1662',42,'127.73',4),

(10178,'S18_3029',41,'70.54',10),

(10178,'S18_3856',48,'104.81',9),

(10178,'S24_2841',34,'67.82',5),

(10178,'S24_3420',27,'65.75',6),

(10178,'S24_3816',21,'68.77',11),

(10178,'S24_3949',30,'64.15',3),

(10178,'S700_2047',34,'86.90',8),

(10178,'S700_2466',22,'91.74',1),

(10178,'S700_4002',45,'68.11',2),

(10178,'S72_1253',45,'41.71',7),

(10179,'S18_2581',24,'82.79',3),

(10179,'S24_1785',47,'105.04',5),

(10179,'S24_4278',27,'66.65',4),

(10179,'S32_1374',45,'86.90',1),

(10179,'S32_4289',24,'63.97',6),

(10179,'S50_1341',34,'43.20',7),

(10179,'S700_1691',23,'75.81',8),

(10179,'S700_2834',25,'98.48',2),

(10179,'S700_3167',39,'80.00',9),

(10180,'S10_1678',29,'76.56',9),

(10180,'S10_2016',42,'99.91',12),

(10180,'S10_4698',41,'164.61',11),

(10180,'S12_2823',40,'131.04',8),

(10180,'S18_2625',25,'48.46',13),

(10180,'S18_3782',21,'59.06',3),

(10180,'S18_4721',44,'147.31',2),

(10180,'S24_1578',48,'98.05',10),

(10180,'S24_2000',28,'61.70',14),

(10180,'S24_2360',35,'60.95',6),

(10180,'S24_4620',28,'68.71',1),

(10180,'S32_2206',34,'33.39',4),

(10180,'S32_4485',22,'102.05',7),

(10180,'S50_4713',21,'74.85',5),

(10181,'S12_1099',27,'155.66',14),

(10181,'S12_3380',28,'113.92',12),

(10181,'S12_3990',20,'67.03',15),

(10181,'S12_4675',36,'107.10',11),

(10181,'S18_1129',44,'124.56',6),

(10181,'S18_1589',42,'124.44',2),

(10181,'S18_1889',22,'74.69',10),

(10181,'S18_1984',21,'129.45',5),

(10181,'S18_2870',27,'130.68',3),

(10181,'S18_3232',45,'147.33',7),

(10181,'S18_3278',30,'73.17',17),

(10181,'S18_3482',22,'120.53',16),

(10181,'S18_3685',39,'137.04',4),

(10181,'S24_1628',34,'45.28',1),

(10181,'S24_2972',37,'32.85',8),

(10181,'S24_3371',23,'54.49',13),

(10181,'S24_3856',25,'122.17',9),

(10182,'S18_1342',25,'83.22',3),

(10182,'S18_1367',32,'44.21',2),

(10182,'S18_1749',44,'159.80',10),

(10182,'S18_2248',38,'54.49',9),

(10182,'S18_2325',20,'105.52',7),

(10182,'S18_2795',21,'135.00',4),

(10182,'S18_3320',33,'86.31',1),

(10182,'S18_4409',36,'88.35',11),

(10182,'S18_4933',44,'61.29',12),

(10182,'S24_1046',47,'63.20',16),

(10182,'S24_1937',39,'31.86',6),

(10182,'S24_2022',31,'39.87',5),

(10182,'S24_2766',36,'87.24',14),

(10182,'S24_2887',20,'116.27',13),

(10182,'S24_3191',33,'73.62',15),

(10182,'S24_3432',49,'95.30',17),

(10182,'S24_3969',23,'34.88',8),

(10183,'S10_1949',23,'180.01',8),

(10183,'S10_4962',28,'127.06',1),

(10183,'S12_1666',41,'114.80',5),

(10183,'S18_1097',21,'108.50',7),

(10183,'S18_2949',37,'91.18',9),

(10183,'S18_2957',39,'51.22',11),

(10183,'S18_3136',22,'90.06',10),

(10183,'S18_4600',21,'118.66',2),

(10183,'S18_4668',40,'42.26',6),

(10183,'S24_4258',47,'81.81',12),

(10183,'S32_3522',49,'52.36',4),

(10183,'S700_2824',23,'85.98',3),

(10184,'S12_4473',37,'105.47',6),

(10184,'S18_2238',46,'145.72',5),

(10184,'S18_2319',46,'119.05',9),

(10184,'S18_2432',44,'60.77',12),

(10184,'S18_3232',28,'165.95',10),

(10184,'S24_1444',31,'57.22',3),

(10184,'S24_2300',24,'117.57',11),

(10184,'S24_2840',42,'30.06',7),

(10184,'S24_4048',49,'114.73',2),

(10184,'S32_1268',46,'84.75',13),

(10184,'S32_2509',33,'52.49',8),

(10184,'S32_3207',48,'59.03',1),

(10184,'S50_1392',45,'92.60',4),

(10185,'S12_1108',21,'195.33',13),

(10185,'S12_3148',33,'146.55',14),

(10185,'S12_3891',43,'147.07',12),

(10185,'S18_3140',28,'124.30',9),

(10185,'S18_3259',49,'94.79',11),

(10185,'S18_4027',39,'127.82',16),

(10185,'S18_4522',47,'87.77',8),

(10185,'S24_2011',30,'105.69',7),

(10185,'S24_3151',33,'83.20',2),

(10185,'S50_1514',20,'46.86',15),

(10185,'S700_1138',21,'64.67',3),

(10185,'S700_1938',30,'79.68',10),

(10185,'S700_2610',39,'61.44',1),

(10185,'S700_3505',37,'99.17',4),

(10185,'S700_3962',22,'93.35',5),

(10185,'S72_3212',28,'47.50',6),

(10186,'S10_4757',26,'108.80',9),

(10186,'S18_1662',32,'137.19',1),

(10186,'S18_3029',32,'73.12',7),

(10186,'S18_3856',46,'98.46',6),

(10186,'S24_2841',22,'60.29',2),

(10186,'S24_3420',21,'59.83',3),

(10186,'S24_3816',36,'68.77',8),

(10186,'S700_2047',24,'80.56',5),

(10186,'S72_1253',28,'42.71',4),

(10187,'S18_2581',45,'70.12',1),

(10187,'S24_1785',46,'96.29',3),

(10187,'S24_3949',43,'55.96',10),

(10187,'S24_4278',33,'64.48',2),

(10187,'S32_4289',31,'61.22',4),

(10187,'S50_1341',41,'39.71',5),

(10187,'S700_1691',34,'84.95',6),

(10187,'S700_2466',44,'95.73',8),

(10187,'S700_3167',34,'72.00',7),

(10187,'S700_4002',44,'70.33',9),

(10188,'S10_1678',48,'95.70',1),

(10188,'S10_2016',38,'111.80',4),

(10188,'S10_4698',45,'182.04',3),

(10188,'S18_2625',32,'52.09',5),

(10188,'S24_1578',25,'95.80',2),

(10188,'S24_2000',40,'61.70',6),

(10188,'S32_1374',44,'81.91',7),

(10188,'S700_2834',29,'96.11',8),

(10189,'S12_2823',28,'138.57',1),

(10190,'S24_2360',42,'58.87',3),

(10190,'S32_2206',46,'38.62',1),

(10190,'S32_4485',42,'89.80',4),

(10190,'S50_4713',40,'67.53',2),

(10191,'S12_1099',21,'155.66',3),

(10191,'S12_3380',40,'104.52',1),

(10191,'S12_3990',30,'70.22',4),

(10191,'S18_3278',36,'75.59',6),

(10191,'S18_3482',23,'119.06',5),

(10191,'S18_3782',43,'60.93',9),

(10191,'S18_4721',32,'136.90',8),

(10191,'S24_3371',48,'53.27',2),

(10191,'S24_4620',44,'77.61',7),

(10192,'S12_4675',27,'99.04',16),

(10192,'S18_1129',22,'140.12',11),

(10192,'S18_1589',29,'100.80',7),

(10192,'S18_1889',45,'70.84',15),

(10192,'S18_1984',47,'128.03',10),

(10192,'S18_2870',38,'110.88',8),

(10192,'S18_3232',26,'137.17',12),

(10192,'S18_3685',45,'125.74',9),

(10192,'S24_1046',37,'72.02',4),

(10192,'S24_1628',47,'49.30',6),

(10192,'S24_2766',46,'86.33',2),

(10192,'S24_2887',23,'112.74',1),

(10192,'S24_2972',30,'33.23',13),

(10192,'S24_3191',32,'69.34',3),

(10192,'S24_3432',46,'93.16',5),

(10192,'S24_3856',45,'112.34',14),

(10193,'S18_1342',28,'92.47',7),

(10193,'S18_1367',46,'46.36',6),

(10193,'S18_1749',21,'153.00',14),

(10193,'S18_2248',42,'60.54',13),

(10193,'S18_2325',44,'115.69',11),

(10193,'S18_2795',22,'143.44',8),

(10193,'S18_2949',28,'87.13',1),

(10193,'S18_2957',24,'53.09',3),

(10193,'S18_3136',23,'97.39',2),

(10193,'S18_3320',32,'79.37',5),

(10193,'S18_4409',24,'92.03',15),

(10193,'S18_4933',25,'66.28',16),

(10193,'S24_1937',26,'32.19',10),

(10193,'S24_2022',20,'44.80',9),

(10193,'S24_3969',22,'38.16',12),

(10193,'S24_4258',20,'92.52',4),

(10194,'S10_1949',42,'203.59',11),

(10194,'S10_4962',26,'134.44',4),

(10194,'S12_1666',38,'124.37',8),

(10194,'S18_1097',21,'103.84',10),

(10194,'S18_2432',45,'51.05',2),

(10194,'S18_4600',32,'113.82',5),

(10194,'S18_4668',41,'47.79',9),

(10194,'S24_2300',49,'112.46',1),

(10194,'S32_1268',37,'77.05',3),

(10194,'S32_3522',39,'61.41',7),

(10194,'S700_2824',26,'80.92',6),

(10195,'S12_4473',49,'118.50',6),

(10195,'S18_2238',27,'139.17',5),

(10195,'S18_2319',35,'112.91',9),

(10195,'S18_3232',50,'150.71',10),

(10195,'S24_1444',44,'54.33',3),

(10195,'S24_2840',32,'31.82',7),

(10195,'S24_4048',34,'95.81',2),

(10195,'S32_2509',32,'51.95',8),

(10195,'S32_3207',33,'59.03',1),

(10195,'S50_1392',49,'97.23',4),

(10196,'S12_1108',47,'203.64',5),

(10196,'S12_3148',24,'151.08',6),

(10196,'S12_3891',38,'147.07',4),

(10196,'S18_3140',49,'127.03',1),

(10196,'S18_3259',35,'81.68',3),

(10196,'S18_4027',27,'126.39',8),

(10196,'S50_1514',46,'56.82',7),

(10196,'S700_1938',50,'84.88',2),

(10197,'S10_4757',45,'118.32',6),

(10197,'S18_3029',46,'83.44',4),

(10197,'S18_3856',22,'85.75',3),

(10197,'S18_4522',50,'78.99',14),

(10197,'S24_2011',41,'109.37',13),

(10197,'S24_3151',47,'83.20',8),

(10197,'S24_3816',22,'67.93',5),

(10197,'S700_1138',23,'60.00',9),

(10197,'S700_2047',24,'78.75',2),

(10197,'S700_2610',50,'66.50',7),

(10197,'S700_3505',27,'100.17',10),

(10197,'S700_3962',35,'88.39',11),

(10197,'S72_1253',29,'39.73',1),

(10197,'S72_3212',42,'48.59',12),

(10198,'S18_1662',42,'149.81',4),

(10198,'S24_2841',48,'60.97',5),

(10198,'S24_3420',27,'61.81',6),

(10198,'S24_3949',43,'65.51',3),

(10198,'S700_2466',42,'94.73',1),

(10198,'S700_4002',40,'74.03',2),

(10199,'S50_1341',29,'37.97',1),

(10199,'S700_1691',48,'81.29',2),

(10199,'S700_3167',38,'70.40',3),

(10200,'S18_2581',28,'74.34',3),

(10200,'S24_1785',33,'99.57',5),

(10200,'S24_4278',39,'70.28',4),

(10200,'S32_1374',35,'80.91',1),

(10200,'S32_4289',27,'65.35',6),

(10200,'S700_2834',39,'115.09',2),

(10201,'S10_1678',22,'82.30',2),

(10201,'S10_2016',24,'116.56',5),

(10201,'S10_4698',49,'191.72',4),

(10201,'S12_2823',25,'126.52',1),

(10201,'S18_2625',30,'48.46',6),

(10201,'S24_1578',39,'93.54',3),

(10201,'S24_2000',25,'66.27',7),

(10202,'S18_3782',30,'55.33',3),

(10202,'S18_4721',43,'124.99',2),

(10202,'S24_2360',50,'56.10',6),

(10202,'S24_4620',50,'75.18',1),

(10202,'S32_2206',27,'33.39',4),

(10202,'S32_4485',31,'81.64',7),

(10202,'S50_4713',40,'79.73',5),

(10203,'S12_1099',20,'161.49',8),

(10203,'S12_3380',20,'111.57',6),

(10203,'S12_3990',44,'63.84',9),

(10203,'S12_4675',47,'115.16',5),

(10203,'S18_1889',45,'73.15',4),

(10203,'S18_3232',48,'157.49',1),

(10203,'S18_3278',33,'66.74',11),

(10203,'S18_3482',32,'127.88',10),

(10203,'S24_2972',21,'33.23',2),

(10203,'S24_3371',34,'56.94',7),

(10203,'S24_3856',47,'140.43',3),

(10204,'S18_1129',42,'114.65',17),

(10204,'S18_1589',40,'113.24',13),

(10204,'S18_1749',33,'153.00',4),

(10204,'S18_1984',38,'133.72',16),

(10204,'S18_2248',23,'59.33',3),

(10204,'S18_2325',26,'119.50',1),

(10204,'S18_2870',27,'106.92',14),

(10204,'S18_3685',35,'132.80',15),

(10204,'S18_4409',29,'83.75',5),

(10204,'S18_4933',45,'69.84',6),

(10204,'S24_1046',20,'69.82',10),

(10204,'S24_1628',45,'46.79',12),

(10204,'S24_2766',47,'79.06',8),

(10204,'S24_2887',42,'112.74',7),

(10204,'S24_3191',40,'84.75',9),

(10204,'S24_3432',48,'104.94',11),

(10204,'S24_3969',39,'34.88',2),

(10205,'S18_1342',36,'98.63',2),

(10205,'S18_1367',48,'45.82',1),

(10205,'S18_2795',40,'138.38',3),

(10205,'S24_1937',32,'27.88',5),

(10205,'S24_2022',24,'36.74',4),

(10206,'S10_1949',47,'203.59',6),

(10206,'S12_1666',28,'109.34',3),

(10206,'S18_1097',34,'115.50',5),

(10206,'S18_2949',37,'98.27',7),

(10206,'S18_2957',28,'51.84',9),

(10206,'S18_3136',30,'102.63',8),

(10206,'S18_3320',28,'99.21',11),

(10206,'S18_4668',21,'45.78',4),

(10206,'S24_4258',33,'95.44',10),

(10206,'S32_3522',36,'54.94',2),

(10206,'S700_2824',33,'89.01',1),

(10207,'S10_4962',31,'125.58',15),

(10207,'S12_4473',34,'95.99',7),

(10207,'S18_2238',44,'140.81',6),

(10207,'S18_2319',43,'109.23',10),

(10207,'S18_2432',37,'60.77',13),

(10207,'S18_3232',25,'140.55',11),

(10207,'S18_4027',40,'143.62',1),

(10207,'S18_4600',47,'119.87',16),

(10207,'S24_1444',49,'57.80',4),

(10207,'S24_2300',46,'127.79',12),

(10207,'S24_2840',42,'30.76',8),

(10207,'S24_4048',28,'108.82',3),

(10207,'S32_1268',49,'84.75',14),

(10207,'S32_2509',27,'51.95',9),

(10207,'S32_3207',45,'55.30',2),

(10207,'S50_1392',28,'106.49',5),

(10208,'S12_1108',46,'176.63',13),

(10208,'S12_3148',26,'128.42',14),

(10208,'S12_3891',20,'152.26',12),

(10208,'S18_3140',24,'117.47',9),

(10208,'S18_3259',48,'96.81',11),

(10208,'S18_4522',45,'72.85',8),

(10208,'S24_2011',35,'122.89',7),

(10208,'S24_3151',20,'80.54',2),

(10208,'S50_1514',30,'57.99',15),

(10208,'S700_1138',38,'56.67',3),

(10208,'S700_1938',40,'73.62',10),

(10208,'S700_2610',46,'63.61',1),

(10208,'S700_3505',37,'95.16',4),

(10208,'S700_3962',33,'95.34',5),

(10208,'S72_3212',42,'48.05',6),

(10209,'S10_4757',39,'129.20',8),

(10209,'S18_3029',28,'82.58',6),

(10209,'S18_3856',20,'97.40',5),

(10209,'S24_2841',43,'66.45',1),

(10209,'S24_3420',36,'56.55',2),

(10209,'S24_3816',22,'79.67',7),

(10209,'S700_2047',33,'90.52',4),

(10209,'S72_1253',48,'44.20',3),

(10210,'S10_2016',23,'112.99',2),

(10210,'S10_4698',34,'189.79',1),

(10210,'S18_1662',31,'141.92',17),

(10210,'S18_2581',50,'68.43',7),

(10210,'S18_2625',40,'51.48',3),

(10210,'S24_1785',27,'100.67',9),

(10210,'S24_2000',30,'63.22',4),

(10210,'S24_3949',29,'56.64',16),

(10210,'S24_4278',40,'68.10',8),

(10210,'S32_1374',46,'84.91',5),

(10210,'S32_4289',39,'57.10',10),

(10210,'S50_1341',43,'43.20',11),

(10210,'S700_1691',21,'87.69',12),

(10210,'S700_2466',26,'93.74',14),

(10210,'S700_2834',25,'98.48',6),

(10210,'S700_3167',31,'64.00',13),

(10210,'S700_4002',42,'60.70',15),

(10211,'S10_1678',41,'90.92',14),

(10211,'S12_1099',41,'171.22',2),

(10211,'S12_2823',36,'126.52',13),

(10211,'S12_3990',28,'79.80',3),

(10211,'S18_3278',35,'73.17',5),

(10211,'S18_3482',28,'138.17',4),

(10211,'S18_3782',46,'60.30',8),

(10211,'S18_4721',41,'148.80',7),

(10211,'S24_1578',25,'109.32',15),

(10211,'S24_2360',21,'62.33',11),

(10211,'S24_3371',48,'52.66',1),

(10211,'S24_4620',22,'80.84',6),

(10211,'S32_2206',41,'39.83',9),

(10211,'S32_4485',37,'94.91',12),

(10211,'S50_4713',40,'70.78',10),

(10212,'S12_3380',39,'99.82',16),

(10212,'S12_4675',33,'110.55',15),

(10212,'S18_1129',29,'117.48',10),

(10212,'S18_1589',38,'105.77',6),

(10212,'S18_1889',20,'64.68',14),

(10212,'S18_1984',41,'133.72',9),

(10212,'S18_2870',40,'117.48',7),

(10212,'S18_3232',40,'155.79',11),

(10212,'S18_3685',45,'115.85',8),

(10212,'S24_1046',41,'61.73',3),

(10212,'S24_1628',45,'43.27',5),

(10212,'S24_2766',45,'81.78',1),

(10212,'S24_2972',34,'37.38',12),

(10212,'S24_3191',27,'77.91',2),

(10212,'S24_3432',46,'100.66',4),

(10212,'S24_3856',49,'117.96',13),

(10213,'S18_4409',38,'84.67',1),

(10213,'S18_4933',25,'58.44',2),

(10213,'S24_2887',27,'97.48',3),

(10214,'S18_1749',30,'166.60',7),

(10214,'S18_2248',21,'53.28',6),

(10214,'S18_2325',27,'125.86',4),

(10214,'S18_2795',50,'167.06',1),

(10214,'S24_1937',20,'32.19',3),

(10214,'S24_2022',49,'39.87',2),

(10214,'S24_3969',44,'38.57',5),

(10215,'S10_1949',35,'205.73',3),

(10215,'S18_1097',46,'100.34',2),

(10215,'S18_1342',27,'92.47',10),

(10215,'S18_1367',33,'53.91',9),

(10215,'S18_2949',49,'97.26',4),

(10215,'S18_2957',31,'56.21',6),

(10215,'S18_3136',49,'89.01',5),

(10215,'S18_3320',41,'84.33',8),

(10215,'S18_4668',46,'42.76',1),

(10215,'S24_4258',39,'94.47',7),

(10216,'S12_1666',43,'133.94',1),

(10217,'S10_4962',48,'132.97',4),

(10217,'S18_2432',35,'58.34',2),

(10217,'S18_4600',38,'118.66',5),

(10217,'S24_2300',28,'103.51',1),

(10217,'S32_1268',21,'78.97',3),

(10217,'S32_3522',39,'56.24',7),

(10217,'S700_2824',31,'90.02',6),

(10218,'S18_2319',22,'110.46',1),

(10218,'S18_3232',34,'152.41',2),

(10219,'S12_4473',48,'94.80',2),

(10219,'S18_2238',43,'132.62',1),

(10219,'S24_2840',21,'31.12',3),

(10219,'S32_2509',35,'47.62',4),

(10220,'S12_1108',32,'189.10',2),

(10220,'S12_3148',30,'151.08',3),

(10220,'S12_3891',27,'166.10',1),

(10220,'S18_4027',50,'126.39',5),

(10220,'S24_1444',26,'48.55',8),

(10220,'S24_4048',37,'101.72',7),

(10220,'S32_3207',20,'49.71',6),

(10220,'S50_1392',37,'92.60',9),

(10220,'S50_1514',30,'56.82',4),

(10221,'S18_3140',33,'133.86',3),

(10221,'S18_3259',23,'89.75',5),

(10221,'S18_4522',39,'84.26',2),

(10221,'S24_2011',49,'113.06',1),

(10221,'S700_1938',23,'69.29',4),

(10222,'S10_4757',49,'133.28',12),

(10222,'S18_1662',49,'137.19',4),

(10222,'S18_3029',49,'79.14',10),

(10222,'S18_3856',45,'88.93',9),

(10222,'S24_2841',32,'56.86',5),

(10222,'S24_3151',47,'74.35',14),

(10222,'S24_3420',43,'61.15',6),

(10222,'S24_3816',46,'77.99',11),

(10222,'S24_3949',48,'55.27',3),

(10222,'S700_1138',31,'58.67',15),

(10222,'S700_2047',26,'80.56',8),

(10222,'S700_2466',37,'90.75',1),

(10222,'S700_2610',36,'69.39',13),

(10222,'S700_3505',38,'84.14',16),

(10222,'S700_3962',31,'81.43',17),

(10222,'S700_4002',43,'66.63',2),

(10222,'S72_1253',31,'45.19',7),

(10222,'S72_3212',36,'48.59',18),

(10223,'S10_1678',37,'80.39',1),

(10223,'S10_2016',47,'110.61',4),

(10223,'S10_4698',49,'189.79',3),

(10223,'S18_2581',47,'67.58',9),

(10223,'S18_2625',28,'58.75',5),

(10223,'S24_1578',32,'104.81',2),

(10223,'S24_1785',34,'87.54',11),

(10223,'S24_2000',38,'60.94',6),

(10223,'S24_4278',23,'68.10',10),

(10223,'S32_1374',21,'90.90',7),

(10223,'S32_4289',20,'66.73',12),

(10223,'S50_1341',41,'41.02',13),

(10223,'S700_1691',25,'84.03',14),

(10223,'S700_2834',29,'113.90',8),

(10223,'S700_3167',26,'79.20',15),

(10224,'S12_2823',43,'141.58',6),

(10224,'S18_3782',38,'57.20',1),

(10224,'S24_2360',37,'60.26',4),

(10224,'S32_2206',43,'37.01',2),

(10224,'S32_4485',30,'94.91',5),

(10224,'S50_4713',50,'81.36',3),

(10225,'S12_1099',27,'157.60',9),

(10225,'S12_3380',25,'101.00',7),

(10225,'S12_3990',37,'64.64',10),

(10225,'S12_4675',21,'100.19',6),

(10225,'S18_1129',32,'116.06',1),

(10225,'S18_1889',47,'71.61',5),

(10225,'S18_3232',43,'162.57',2),

(10225,'S18_3278',37,'69.96',12),

(10225,'S18_3482',27,'119.06',11),

(10225,'S18_4721',35,'135.41',14),

(10225,'S24_2972',42,'34.74',3),

(10225,'S24_3371',24,'51.43',8),

(10225,'S24_3856',40,'130.60',4),

(10225,'S24_4620',46,'77.61',13),

(10226,'S18_1589',38,'108.26',4),

(10226,'S18_1984',24,'129.45',7),

(10226,'S18_2870',24,'125.40',5),

(10226,'S18_3685',46,'122.91',6),

(10226,'S24_1046',21,'65.41',1),

(10226,'S24_1628',36,'47.79',3),

(10226,'S24_3432',48,'95.30',2),

(10227,'S18_1342',25,'85.27',3),

(10227,'S18_1367',31,'50.14',2),

(10227,'S18_1749',26,'136.00',10),

(10227,'S18_2248',28,'59.93',9),

(10227,'S18_2325',46,'118.23',7),

(10227,'S18_2795',29,'146.81',4),

(10227,'S18_3320',33,'99.21',1),

(10227,'S18_4409',34,'87.43',11),

(10227,'S18_4933',37,'70.56',12),

(10227,'S24_1937',42,'27.22',6),

(10227,'S24_2022',24,'39.42',5),

(10227,'S24_2766',47,'84.51',14),

(10227,'S24_2887',33,'102.17',13),

(10227,'S24_3191',40,'78.76',15),

(10227,'S24_3969',27,'34.88',8),

(10228,'S10_1949',29,'214.30',2),

(10228,'S18_1097',32,'100.34',1),

(10228,'S18_2949',24,'101.31',3),

(10228,'S18_2957',45,'57.46',5),

(10228,'S18_3136',31,'100.53',4),

(10228,'S24_4258',33,'84.73',6),

(10229,'S10_4962',50,'138.88',9),

(10229,'S12_1666',25,'110.70',13),

(10229,'S12_4473',36,'95.99',1),

(10229,'S18_2319',26,'104.32',4),

(10229,'S18_2432',28,'53.48',7),

(10229,'S18_3232',22,'157.49',5),

(10229,'S18_4600',41,'119.87',10),

(10229,'S18_4668',39,'43.77',14),

(10229,'S24_2300',48,'115.01',6),

(10229,'S24_2840',33,'34.65',2),

(10229,'S32_1268',25,'78.97',8),

(10229,'S32_2509',23,'49.78',3),

(10229,'S32_3522',30,'52.36',12),

(10229,'S700_2824',50,'91.04',11),

(10230,'S12_3148',43,'128.42',1),

(10230,'S18_2238',49,'153.91',8),

(10230,'S18_4027',42,'142.18',3),

(10230,'S24_1444',36,'47.40',6),

(10230,'S24_4048',45,'99.36',5),

(10230,'S32_3207',46,'59.03',4),

(10230,'S50_1392',34,'100.70',7),

(10230,'S50_1514',43,'57.41',2),

(10231,'S12_1108',42,'193.25',2),

(10231,'S12_3891',49,'147.07',1),

(10232,'S18_3140',22,'133.86',6),

(10232,'S18_3259',48,'97.81',8),

(10232,'S18_4522',23,'78.12',5),

(10232,'S24_2011',46,'113.06',4),

(10232,'S700_1938',26,'84.88',7),

(10232,'S700_3505',48,'86.15',1),

(10232,'S700_3962',35,'81.43',2),

(10232,'S72_3212',24,'48.59',3),

(10233,'S24_3151',40,'70.81',2),

(10233,'S700_1138',36,'66.00',3),

(10233,'S700_2610',29,'67.94',1),

(10234,'S10_4757',48,'118.32',9),

(10234,'S18_1662',50,'146.65',1),

(10234,'S18_3029',48,'84.30',7),

(10234,'S18_3856',39,'85.75',6),

(10234,'S24_2841',44,'67.14',2),

(10234,'S24_3420',25,'65.09',3),

(10234,'S24_3816',31,'78.83',8),

(10234,'S700_2047',29,'83.28',5),

(10234,'S72_1253',40,'45.69',4),

(10235,'S18_2581',24,'81.95',3),

(10235,'S24_1785',23,'89.72',5),

(10235,'S24_3949',33,'55.27',12),

(10235,'S24_4278',40,'63.03',4),

(10235,'S32_1374',41,'90.90',1),

(10235,'S32_4289',34,'66.73',6),

(10235,'S50_1341',41,'37.09',7),

(10235,'S700_1691',25,'88.60',8),

(10235,'S700_2466',38,'92.74',10),

(10235,'S700_2834',25,'116.28',2),

(10235,'S700_3167',32,'73.60',9),

(10235,'S700_4002',34,'70.33',11),

(10236,'S10_2016',22,'105.86',1),

(10236,'S18_2625',23,'52.70',2),

(10236,'S24_2000',36,'65.51',3),

(10237,'S10_1678',23,'91.87',7),

(10237,'S10_4698',39,'158.80',9),

(10237,'S12_2823',32,'129.53',6),

(10237,'S18_3782',26,'49.74',1),

(10237,'S24_1578',20,'109.32',8),

(10237,'S24_2360',26,'62.33',4),

(10237,'S32_2206',26,'35.00',2),

(10237,'S32_4485',27,'94.91',5),

(10237,'S50_4713',20,'78.92',3),

(10238,'S12_1099',28,'161.49',3),

(10238,'S12_3380',29,'104.52',1),

(10238,'S12_3990',20,'73.42',4),

(10238,'S18_3278',41,'68.35',6),

(10238,'S18_3482',49,'144.05',5),

(10238,'S18_4721',44,'120.53',8),

(10238,'S24_3371',47,'53.88',2),

(10238,'S24_4620',22,'67.91',7),

(10239,'S12_4675',21,'100.19',5),

(10239,'S18_1889',46,'70.07',4),

(10239,'S18_3232',47,'135.47',1),

(10239,'S24_2972',20,'32.47',2),

(10239,'S24_3856',29,'133.41',3),

(10240,'S18_1129',41,'125.97',3),

(10240,'S18_1984',37,'136.56',2),

(10240,'S18_3685',37,'134.22',1),

(10241,'S18_1589',21,'119.46',11),

(10241,'S18_1749',41,'153.00',2),

(10241,'S18_2248',33,'55.70',1),

(10241,'S18_2870',44,'126.72',12),

(10241,'S18_4409',42,'77.31',3),

(10241,'S18_4933',30,'62.72',4),

(10241,'S24_1046',22,'72.02',8),

(10241,'S24_1628',21,'47.29',10),

(10241,'S24_2766',47,'89.05',6),

(10241,'S24_2887',28,'117.44',5),

(10241,'S24_3191',26,'69.34',7),

(10241,'S24_3432',27,'107.08',9),

(10242,'S24_3969',46,'36.52',1),

(10243,'S18_2325',47,'111.87',2),

(10243,'S24_1937',33,'30.87',1),

(10244,'S18_1342',40,'99.66',7),

(10244,'S18_1367',20,'48.52',6),

(10244,'S18_2795',43,'141.75',8),

(10244,'S18_2949',30,'87.13',1),

(10244,'S18_2957',24,'54.96',3),

(10244,'S18_3136',29,'85.87',2),

(10244,'S18_3320',36,'87.30',5),

(10244,'S24_2022',39,'42.11',9),

(10244,'S24_4258',40,'97.39',4),

(10245,'S10_1949',34,'195.01',9),

(10245,'S10_4962',28,'147.74',2),

(10245,'S12_1666',38,'120.27',6),

(10245,'S18_1097',29,'114.34',8),

(10245,'S18_4600',21,'111.39',3),

(10245,'S18_4668',45,'48.80',7),

(10245,'S32_1268',37,'81.86',1),

(10245,'S32_3522',44,'54.94',5),

(10245,'S700_2824',44,'81.93',4),

(10246,'S12_4473',46,'99.54',5),

(10246,'S18_2238',40,'144.08',4),

(10246,'S18_2319',22,'100.64',8),

(10246,'S18_2432',30,'57.73',11),

(10246,'S18_3232',36,'145.63',9),

(10246,'S24_1444',44,'46.24',2),

(10246,'S24_2300',29,'118.84',10),

(10246,'S24_2840',49,'34.65',6),

(10246,'S24_4048',46,'100.54',1),

(10246,'S32_2509',35,'45.45',7),

(10246,'S50_1392',22,'113.44',3),

(10247,'S12_1108',44,'195.33',2),

(10247,'S12_3148',25,'140.50',3),

(10247,'S12_3891',27,'167.83',1),

(10247,'S18_4027',48,'143.62',5),

(10247,'S32_3207',40,'58.41',6),

(10247,'S50_1514',49,'51.55',4),

(10248,'S10_4757',20,'126.48',3),

(10248,'S18_3029',21,'80.86',1),

(10248,'S18_3140',32,'133.86',12),

(10248,'S18_3259',42,'95.80',14),

(10248,'S18_4522',42,'87.77',11),

(10248,'S24_2011',48,'122.89',10),

(10248,'S24_3151',30,'85.85',5),

(10248,'S24_3816',23,'83.02',2),

(10248,'S700_1138',36,'66.00',6),

(10248,'S700_1938',40,'81.41',13),

(10248,'S700_2610',32,'69.39',4),

(10248,'S700_3505',30,'84.14',7),

(10248,'S700_3962',35,'92.36',8),

(10248,'S72_3212',23,'53.51',9),

(10249,'S18_3856',46,'88.93',5),

(10249,'S24_2841',20,'54.81',1),

(10249,'S24_3420',25,'65.75',2),

(10249,'S700_2047',40,'85.99',4),

(10249,'S72_1253',32,'49.16',3),

(10250,'S18_1662',45,'148.23',14),

(10250,'S18_2581',27,'84.48',4),

(10250,'S24_1785',31,'95.20',6),

(10250,'S24_2000',32,'63.22',1),

(10250,'S24_3949',40,'61.42',13),

(10250,'S24_4278',37,'72.45',5),

(10250,'S32_1374',31,'99.89',2),

(10250,'S32_4289',50,'62.60',7),

(10250,'S50_1341',36,'36.66',8),

(10250,'S700_1691',31,'91.34',9),

(10250,'S700_2466',35,'90.75',11),

(10250,'S700_2834',44,'98.48',3),

(10250,'S700_3167',44,'76.00',10),

(10250,'S700_4002',38,'65.89',12),

(10251,'S10_1678',59,'93.79',2),

(10251,'S10_2016',44,'115.37',5),

(10251,'S10_4698',43,'172.36',4),

(10251,'S12_2823',46,'129.53',1),

(10251,'S18_2625',44,'58.15',6),

(10251,'S24_1578',50,'91.29',3),

(10252,'S18_3278',20,'74.78',2),

(10252,'S18_3482',41,'145.52',1),

(10252,'S18_3782',31,'50.36',5),

(10252,'S18_4721',26,'127.97',4),

(10252,'S24_2360',47,'63.03',8),

(10252,'S24_4620',38,'69.52',3),

(10252,'S32_2206',36,'36.21',6),

(10252,'S32_4485',25,'93.89',9),

(10252,'S50_4713',48,'72.41',7),

(10253,'S12_1099',24,'157.60',13),

(10253,'S12_3380',22,'102.17',11),

(10253,'S12_3990',25,'67.03',14),

(10253,'S12_4675',41,'109.40',10),

(10253,'S18_1129',26,'130.22',5),

(10253,'S18_1589',24,'103.29',1),

(10253,'S18_1889',23,'67.76',9),

(10253,'S18_1984',33,'130.87',4),

(10253,'S18_2870',37,'114.84',2),

(10253,'S18_3232',40,'145.63',6),

(10253,'S18_3685',31,'139.87',3),

(10253,'S24_2972',40,'34.74',7),

(10253,'S24_3371',24,'50.82',12),

(10253,'S24_3856',39,'115.15',8),

(10254,'S18_1749',49,'137.70',5),

(10254,'S18_2248',36,'55.09',4),

(10254,'S18_2325',41,'102.98',2),

(10254,'S18_4409',34,'80.99',6),

(10254,'S18_4933',30,'59.87',7),

(10254,'S24_1046',34,'66.88',11),

(10254,'S24_1628',32,'43.27',13),

(10254,'S24_1937',38,'28.88',1),

(10254,'S24_2766',31,'85.42',9),

(10254,'S24_2887',33,'111.57',8),

(10254,'S24_3191',42,'69.34',10),

(10254,'S24_3432',49,'101.73',12),

(10254,'S24_3969',20,'39.80',3),

(10255,'S18_2795',24,'135.00',1),

(10255,'S24_2022',37,'37.63',2),

(10256,'S18_1342',34,'93.49',2),

(10256,'S18_1367',29,'52.83',1),

(10257,'S18_2949',50,'92.19',1),

(10257,'S18_2957',49,'59.34',3),

(10257,'S18_3136',37,'83.78',2),

(10257,'S18_3320',26,'91.27',5),

(10257,'S24_4258',46,'81.81',4),

(10258,'S10_1949',32,'177.87',6),

(10258,'S12_1666',41,'133.94',3),

(10258,'S18_1097',41,'113.17',5),

(10258,'S18_4668',21,'49.81',4),

(10258,'S32_3522',20,'62.70',2),

(10258,'S700_2824',45,'86.99',1),

(10259,'S10_4962',26,'121.15',12),

(10259,'S12_4473',46,'117.32',4),

(10259,'S18_2238',30,'134.26',3),

(10259,'S18_2319',34,'120.28',7),

(10259,'S18_2432',30,'59.55',10),

(10259,'S18_3232',27,'152.41',8),

(10259,'S18_4600',41,'107.76',13),

(10259,'S24_1444',28,'46.82',1),

(10259,'S24_2300',47,'121.40',9),

(10259,'S24_2840',31,'31.47',5),

(10259,'S32_1268',45,'95.35',11),

(10259,'S32_2509',40,'45.99',6),

(10259,'S50_1392',29,'105.33',2),

(10260,'S12_1108',46,'180.79',5),

(10260,'S12_3148',30,'140.50',6),

(10260,'S12_3891',44,'169.56',4),

(10260,'S18_3140',32,'121.57',1),

(10260,'S18_3259',29,'92.77',3),

(10260,'S18_4027',23,'137.88',8),

(10260,'S24_4048',23,'117.10',10),

(10260,'S32_3207',27,'55.30',9),

(10260,'S50_1514',21,'56.24',7),

(10260,'S700_1938',33,'80.55',2),

(10261,'S10_4757',27,'116.96',1),

(10261,'S18_4522',20,'80.75',9),

(10261,'S24_2011',36,'105.69',8),

(10261,'S24_3151',22,'79.66',3),

(10261,'S700_1138',34,'64.00',4),

(10261,'S700_2610',44,'58.55',2),

(10261,'S700_3505',25,'89.15',5),

(10261,'S700_3962',50,'88.39',6),

(10261,'S72_3212',29,'43.68',7),

(10262,'S18_1662',49,'157.69',9),

(10262,'S18_3029',32,'81.72',15),

(10262,'S18_3856',34,'85.75',14),

(10262,'S24_1785',34,'98.48',1),

(10262,'S24_2841',24,'63.71',10),

(10262,'S24_3420',46,'65.75',11),

(10262,'S24_3816',49,'82.18',16),

(10262,'S24_3949',48,'58.69',8),

(10262,'S32_4289',40,'63.97',2),

(10262,'S50_1341',49,'35.78',3),

(10262,'S700_1691',40,'87.69',4),

(10262,'S700_2047',44,'83.28',13),

(10262,'S700_2466',33,'81.77',6),

(10262,'S700_3167',27,'64.80',5),

(10262,'S700_4002',35,'64.41',7),

(10262,'S72_1253',21,'41.71',12),

(10263,'S10_1678',34,'89.00',2),

(10263,'S10_2016',40,'107.05',5),

(10263,'S10_4698',41,'193.66',4),

(10263,'S12_2823',48,'123.51',1),

(10263,'S18_2581',33,'67.58',10),

(10263,'S18_2625',34,'50.27',6),

(10263,'S24_1578',42,'109.32',3),

(10263,'S24_2000',37,'67.03',7),

(10263,'S24_4278',24,'59.41',11),

(10263,'S32_1374',31,'93.90',8),

(10263,'S700_2834',47,'117.46',9),

(10264,'S18_3782',48,'58.44',3),

(10264,'S18_4721',20,'124.99',2),

(10264,'S24_2360',37,'61.64',6),

(10264,'S24_4620',47,'75.18',1),

(10264,'S32_2206',20,'39.02',4),

(10264,'S32_4485',34,'100.01',7),

(10264,'S50_4713',47,'67.53',5),

(10265,'S18_3278',45,'74.78',2),

(10265,'S18_3482',49,'123.47',1),

(10266,'S12_1099',44,'188.73',14),

(10266,'S12_3380',22,'110.39',12),

(10266,'S12_3990',35,'67.83',15),

(10266,'S12_4675',40,'112.86',11),

(10266,'S18_1129',21,'131.63',6),

(10266,'S18_1589',36,'99.55',2),

(10266,'S18_1889',33,'77.00',10),

(10266,'S18_1984',49,'139.41',5),

(10266,'S18_2870',20,'113.52',3),

(10266,'S18_3232',29,'137.17',7),

(10266,'S18_3685',33,'127.15',4),

(10266,'S24_1628',28,'40.25',1),

(10266,'S24_2972',34,'35.12',8),

(10266,'S24_3371',47,'56.33',13),

(10266,'S24_3856',24,'119.37',9),

(10267,'S18_4933',36,'71.27',1),

(10267,'S24_1046',40,'72.02',5),

(10267,'S24_2766',38,'76.33',3),

(10267,'S24_2887',43,'93.95',2),

(10267,'S24_3191',44,'83.90',4),

(10267,'S24_3432',43,'98.51',6),

(10268,'S18_1342',49,'93.49',3),

(10268,'S18_1367',26,'45.82',2),

(10268,'S18_1749',34,'164.90',10),

(10268,'S18_2248',31,'60.54',9),

(10268,'S18_2325',50,'124.59',7),

(10268,'S18_2795',35,'148.50',4),

(10268,'S18_3320',39,'96.23',1),

(10268,'S18_4409',35,'84.67',11),

(10268,'S24_1937',33,'31.86',6),

(10268,'S24_2022',40,'36.29',5),

(10268,'S24_3969',30,'37.75',8),

(10269,'S18_2957',32,'57.46',1),

(10269,'S24_4258',48,'95.44',2),

(10270,'S10_1949',21,'171.44',9),

(10270,'S10_4962',32,'124.10',2),

(10270,'S12_1666',28,'135.30',6),

(10270,'S18_1097',43,'94.50',8),

(10270,'S18_2949',31,'81.05',10),

(10270,'S18_3136',38,'85.87',11),

(10270,'S18_4600',38,'107.76',3),

(10270,'S18_4668',44,'40.25',7),

(10270,'S32_1268',32,'93.42',1),

(10270,'S32_3522',21,'52.36',5),

(10270,'S700_2824',46,'101.15',4),

(10271,'S12_4473',31,'99.54',5),

(10271,'S18_2238',50,'147.36',4),

(10271,'S18_2319',50,'121.50',8),

(10271,'S18_2432',25,'59.55',11),

(10271,'S18_3232',20,'169.34',9),

(10271,'S24_1444',45,'49.71',2),

(10271,'S24_2300',43,'122.68',10),

(10271,'S24_2840',38,'28.64',6),

(10271,'S24_4048',22,'110.00',1),

(10271,'S32_2509',35,'51.95',7),

(10271,'S50_1392',34,'93.76',3),

(10272,'S12_1108',35,'187.02',2),

(10272,'S12_3148',27,'123.89',3),

(10272,'S12_3891',39,'148.80',1),

(10272,'S18_4027',25,'126.39',5),

(10272,'S32_3207',45,'56.55',6),

(10272,'S50_1514',43,'53.89',4),

(10273,'S10_4757',30,'136.00',4),

(10273,'S18_3029',34,'84.30',2),

(10273,'S18_3140',40,'117.47',13),

(10273,'S18_3259',47,'87.73',15),

(10273,'S18_3856',50,'105.87',1),

(10273,'S18_4522',33,'72.85',12),

(10273,'S24_2011',22,'103.23',11),

(10273,'S24_3151',27,'84.08',6),

(10273,'S24_3816',48,'83.86',3),

(10273,'S700_1138',21,'66.00',7),

(10273,'S700_1938',21,'77.95',14),

(10273,'S700_2610',42,'57.82',5),

(10273,'S700_3505',40,'91.15',8),

(10273,'S700_3962',26,'89.38',9),

(10273,'S72_3212',37,'51.32',10),

(10274,'S18_1662',41,'129.31',1),

(10274,'S24_2841',40,'56.86',2),

(10274,'S24_3420',24,'65.09',3),

(10274,'S700_2047',24,'75.13',5),

(10274,'S72_1253',32,'49.66',4),

(10275,'S10_1678',45,'81.35',1),

(10275,'S10_2016',22,'115.37',4),

(10275,'S10_4698',36,'154.93',3),

(10275,'S18_2581',35,'70.12',9),

(10275,'S18_2625',37,'52.09',5),

(10275,'S24_1578',21,'105.94',2),

(10275,'S24_1785',25,'97.38',11),

(10275,'S24_2000',30,'61.70',6),

(10275,'S24_3949',41,'58.00',18),

(10275,'S24_4278',27,'67.38',10),

(10275,'S32_1374',23,'89.90',7),

(10275,'S32_4289',28,'58.47',12),

(10275,'S50_1341',38,'40.15',13),

(10275,'S700_1691',32,'85.86',14),

(10275,'S700_2466',39,'82.77',16),

(10275,'S700_2834',48,'102.04',8),

(10275,'S700_3167',43,'72.00',15),

(10275,'S700_4002',31,'59.96',17),

(10276,'S12_1099',50,'184.84',3),

(10276,'S12_2823',43,'150.62',14),

(10276,'S12_3380',47,'104.52',1),

(10276,'S12_3990',38,'67.83',4),

(10276,'S18_3278',38,'78.00',6),

(10276,'S18_3482',30,'139.64',5),

(10276,'S18_3782',33,'54.71',9),

(10276,'S18_4721',48,'120.53',8),

(10276,'S24_2360',46,'61.64',12),

(10276,'S24_3371',20,'58.17',2),

(10276,'S24_4620',48,'67.10',7),

(10276,'S32_2206',27,'35.40',10),

(10276,'S32_4485',38,'94.91',13),

(10276,'S50_4713',21,'67.53',11),

(10277,'S12_4675',28,'93.28',1),

(10278,'S18_1129',34,'114.65',6),

(10278,'S18_1589',23,'107.02',2),

(10278,'S18_1889',29,'73.15',10),

(10278,'S18_1984',29,'118.07',5),

(10278,'S18_2870',39,'117.48',3),

(10278,'S18_3232',42,'167.65',7),

(10278,'S18_3685',31,'114.44',4),

(10278,'S24_1628',35,'48.80',1),

(10278,'S24_2972',31,'37.38',8),

(10278,'S24_3856',25,'136.22',9),

(10279,'S18_4933',26,'68.42',1),

(10279,'S24_1046',32,'68.35',5),

(10279,'S24_2766',49,'76.33',3),

(10279,'S24_2887',48,'106.87',2),

(10279,'S24_3191',33,'78.76',4),

(10279,'S24_3432',48,'95.30',6),

(10280,'S10_1949',34,'205.73',2),

(10280,'S18_1097',24,'98.00',1),

(10280,'S18_1342',50,'87.33',9),

(10280,'S18_1367',27,'47.44',8),

(10280,'S18_1749',26,'161.50',16),

(10280,'S18_2248',25,'53.28',15),

(10280,'S18_2325',37,'109.33',13),

(10280,'S18_2795',22,'158.63',10),

(10280,'S18_2949',46,'82.06',3),

(10280,'S18_2957',43,'54.34',5),

(10280,'S18_3136',29,'102.63',4),

(10280,'S18_3320',34,'99.21',7),

(10280,'S18_4409',35,'77.31',17),

(10280,'S24_1937',20,'29.87',12),

(10280,'S24_2022',45,'36.29',11),

(10280,'S24_3969',33,'35.29',14),

(10280,'S24_4258',21,'79.86',6),

(10281,'S10_4962',44,'132.97',9),

(10281,'S12_1666',25,'127.10',13),

(10281,'S12_4473',41,'98.36',1),

(10281,'S18_2319',48,'114.14',4),

(10281,'S18_2432',29,'56.52',7),

(10281,'S18_3232',25,'135.47',5),

(10281,'S18_4600',25,'96.86',10),

(10281,'S18_4668',44,'42.76',14),

(10281,'S24_2300',25,'112.46',6),

(10281,'S24_2840',20,'33.95',2),

(10281,'S32_1268',29,'80.90',8),

(10281,'S32_2509',31,'44.91',3),

(10281,'S32_3522',36,'59.47',12),

(10281,'S700_2824',27,'89.01',11),

(10282,'S12_1108',41,'176.63',5),

(10282,'S12_3148',27,'142.02',6),

(10282,'S12_3891',24,'169.56',4),

(10282,'S18_2238',23,'147.36',13),

(10282,'S18_3140',43,'122.93',1),

(10282,'S18_3259',36,'88.74',3),

(10282,'S18_4027',31,'132.13',8),

(10282,'S24_1444',29,'49.71',11),

(10282,'S24_4048',39,'96.99',10),

(10282,'S32_3207',36,'51.58',9),

(10282,'S50_1392',38,'114.59',12),

(10282,'S50_1514',37,'56.24',7),

(10282,'S700_1938',43,'77.95',2),

(10283,'S10_4757',25,'130.56',6),

(10283,'S18_3029',21,'78.28',4),

(10283,'S18_3856',46,'100.58',3),

(10283,'S18_4522',34,'71.97',14),

(10283,'S24_2011',42,'99.54',13),

(10283,'S24_3151',34,'80.54',8),

(10283,'S24_3816',33,'77.15',5),

(10283,'S700_1138',45,'62.00',9),

(10283,'S700_2047',20,'74.23',2),

(10283,'S700_2610',47,'68.67',7),

(10283,'S700_3505',22,'88.15',10),

(10283,'S700_3962',38,'85.41',11),

(10283,'S72_1253',43,'41.22',1),

(10283,'S72_3212',33,'49.14',12),

(10284,'S18_1662',45,'137.19',11),

(10284,'S18_2581',31,'68.43',1),

(10284,'S24_1785',22,'101.76',3),

(10284,'S24_2841',30,'65.08',12),

(10284,'S24_3420',39,'59.83',13),

(10284,'S24_3949',21,'65.51',10),

(10284,'S24_4278',21,'66.65',2),

(10284,'S32_4289',50,'60.54',4),

(10284,'S50_1341',33,'35.78',5),

(10284,'S700_1691',24,'87.69',6),

(10284,'S700_2466',45,'95.73',8),

(10284,'S700_3167',25,'68.00',7),

(10284,'S700_4002',32,'73.29',9),

(10285,'S10_1678',36,'95.70',6),

(10285,'S10_2016',47,'110.61',9),

(10285,'S10_4698',27,'166.55',8),

(10285,'S12_2823',49,'131.04',5),

(10285,'S18_2625',20,'50.88',10),

(10285,'S24_1578',34,'91.29',7),

(10285,'S24_2000',39,'61.70',11),

(10285,'S24_2360',38,'64.41',3),

(10285,'S32_1374',37,'82.91',12),

(10285,'S32_2206',37,'36.61',1),

(10285,'S32_4485',26,'100.01',4),

(10285,'S50_4713',39,'76.48',2),

(10285,'S700_2834',45,'102.04',13),

(10286,'S18_3782',38,'51.60',1),

(10287,'S12_1099',21,'190.68',12),

(10287,'S12_3380',45,'117.44',10),

(10287,'S12_3990',41,'74.21',13),

(10287,'S12_4675',23,'107.10',9),

(10287,'S18_1129',41,'113.23',4),

(10287,'S18_1889',44,'61.60',8),

(10287,'S18_1984',24,'123.76',3),

(10287,'S18_2870',44,'114.84',1),

(10287,'S18_3232',36,'137.17',5),

(10287,'S18_3278',43,'68.35',15),

(10287,'S18_3482',40,'127.88',14),

(10287,'S18_3685',27,'139.87',2),

(10287,'S18_4721',34,'119.04',17),

(10287,'S24_2972',36,'31.34',6),

(10287,'S24_3371',20,'58.17',11),

(10287,'S24_3856',36,'137.62',7),

(10287,'S24_4620',40,'79.22',16),

(10288,'S18_1589',20,'120.71',14),

(10288,'S18_1749',32,'168.30',5),

(10288,'S18_2248',28,'50.25',4),

(10288,'S18_2325',31,'102.98',2),

(10288,'S18_4409',35,'90.19',6),

(10288,'S18_4933',23,'57.02',7),

(10288,'S24_1046',36,'66.88',11),

(10288,'S24_1628',50,'49.30',13),

(10288,'S24_1937',29,'32.19',1),

(10288,'S24_2766',35,'81.78',9),

(10288,'S24_2887',48,'109.22',8),

(10288,'S24_3191',34,'76.19',10),

(10288,'S24_3432',41,'101.73',12),

(10288,'S24_3969',33,'37.75',3),

(10289,'S18_1342',38,'92.47',2),

(10289,'S18_1367',24,'44.75',1),

(10289,'S18_2795',43,'141.75',3),

(10289,'S24_2022',45,'41.22',4),

(10290,'S18_3320',26,'80.36',2),

(10290,'S24_4258',45,'83.76',1),

(10291,'S10_1949',37,'210.01',11),

(10291,'S10_4962',30,'141.83',4),

(10291,'S12_1666',41,'123.00',8),

(10291,'S18_1097',41,'96.84',10),

(10291,'S18_2432',26,'52.26',2),

(10291,'S18_2949',47,'99.28',12),

(10291,'S18_2957',37,'56.21',14),

(10291,'S18_3136',23,'93.20',13),

(10291,'S18_4600',48,'96.86',5),

(10291,'S18_4668',29,'45.28',9),

(10291,'S24_2300',48,'109.90',1),

(10291,'S32_1268',26,'82.83',3),

(10291,'S32_3522',32,'53.00',7),

(10291,'S700_2824',28,'86.99',6),

(10292,'S12_4473',21,'94.80',8),

(10292,'S18_2238',26,'140.81',7),

(10292,'S18_2319',41,'103.09',11),

(10292,'S18_3232',21,'147.33',12),

(10292,'S18_4027',44,'114.90',2),

(10292,'S24_1444',40,'48.55',5),

(10292,'S24_2840',39,'34.30',9),

(10292,'S24_4048',27,'113.55',4),

(10292,'S32_2509',50,'54.11',10),

(10292,'S32_3207',31,'59.65',3),

(10292,'S50_1392',41,'113.44',6),

(10292,'S50_1514',35,'49.79',1),

(10293,'S12_1108',46,'187.02',8),

(10293,'S12_3148',24,'129.93',9),

(10293,'S12_3891',45,'171.29',7),

(10293,'S18_3140',24,'110.64',4),

(10293,'S18_3259',22,'91.76',6),

(10293,'S18_4522',49,'72.85',3),

(10293,'S24_2011',21,'111.83',2),

(10293,'S700_1938',29,'77.95',5),

(10293,'S72_3212',32,'51.32',1),

(10294,'S700_3962',45,'98.32',1),

(10295,'S10_4757',24,'136.00',1),

(10295,'S24_3151',46,'84.08',3),

(10295,'S700_1138',26,'62.00',4),

(10295,'S700_2610',44,'71.56',2),

(10295,'S700_3505',34,'93.16',5),

(10296,'S18_1662',36,'146.65',7),

(10296,'S18_3029',21,'69.68',13),

(10296,'S18_3856',22,'105.87',12),

(10296,'S24_2841',21,'60.97',8),

(10296,'S24_3420',31,'63.78',9),

(10296,'S24_3816',22,'83.02',14),

(10296,'S24_3949',32,'63.46',6),

(10296,'S50_1341',26,'41.02',1),

(10296,'S700_1691',42,'75.81',2),

(10296,'S700_2047',34,'89.61',11),

(10296,'S700_2466',24,'96.73',4),

(10296,'S700_3167',22,'74.40',3),

(10296,'S700_4002',47,'61.44',5),

(10296,'S72_1253',21,'46.68',10),

(10297,'S18_2581',25,'81.95',4),

(10297,'S24_1785',32,'107.23',6),

(10297,'S24_2000',32,'70.08',1),

(10297,'S24_4278',23,'71.73',5),

(10297,'S32_1374',26,'88.90',2),

(10297,'S32_4289',28,'63.29',7),

(10297,'S700_2834',35,'111.53',3),

(10298,'S10_2016',39,'105.86',1),

(10298,'S18_2625',32,'60.57',2),

(10299,'S10_1678',23,'76.56',9),

(10299,'S10_4698',29,'164.61',11),

(10299,'S12_2823',24,'123.51',8),

(10299,'S18_3782',39,'62.17',3),

(10299,'S18_4721',49,'119.04',2),

(10299,'S24_1578',47,'107.07',10),

(10299,'S24_2360',33,'58.87',6),

(10299,'S24_4620',32,'66.29',1),

(10299,'S32_2206',24,'36.21',4),

(10299,'S32_4485',38,'84.70',7),

(10299,'S50_4713',44,'77.29',5),

(10300,'S12_1099',33,'184.84',5),

(10300,'S12_3380',29,'116.27',3),

(10300,'S12_3990',22,'76.61',6),

(10300,'S12_4675',23,'95.58',2),

(10300,'S18_1889',41,'63.14',1),

(10300,'S18_3278',49,'65.94',8),

(10300,'S18_3482',23,'144.05',7),

(10300,'S24_3371',31,'52.05',4),

(10301,'S18_1129',37,'114.65',8),

(10301,'S18_1589',32,'118.22',4),

(10301,'S18_1984',47,'119.49',7),

(10301,'S18_2870',22,'113.52',5),

(10301,'S18_3232',23,'135.47',9),

(10301,'S18_3685',39,'137.04',6),

(10301,'S24_1046',27,'64.67',1),

(10301,'S24_1628',22,'40.75',3),

(10301,'S24_2972',48,'32.10',10),

(10301,'S24_3432',22,'86.73',2),

(10301,'S24_3856',50,'122.17',11),

(10302,'S18_1749',43,'166.60',1),

(10302,'S18_4409',38,'82.83',2),

(10302,'S18_4933',23,'70.56',3),

(10302,'S24_2766',49,'75.42',5),

(10302,'S24_2887',45,'104.52',4),

(10302,'S24_3191',48,'74.48',6),

(10303,'S18_2248',46,'56.91',2),

(10303,'S24_3969',24,'35.70',1),

(10304,'S10_1949',47,'201.44',6),

(10304,'S12_1666',39,'117.54',3),

(10304,'S18_1097',46,'106.17',5),

(10304,'S18_1342',37,'95.55',13),

(10304,'S18_1367',37,'46.90',12),

(10304,'S18_2325',24,'102.98',17),

(10304,'S18_2795',20,'141.75',14),

(10304,'S18_2949',46,'98.27',7),

(10304,'S18_2957',24,'54.34',9),

(10304,'S18_3136',26,'90.06',8),

(10304,'S18_3320',38,'95.24',11),

(10304,'S18_4668',34,'44.27',4),

(10304,'S24_1937',23,'29.21',16),

(10304,'S24_2022',44,'42.11',15),

(10304,'S24_4258',33,'80.83',10),

(10304,'S32_3522',36,'52.36',2),

(10304,'S700_2824',40,'80.92',1),

(10305,'S10_4962',38,'130.01',13),

(10305,'S12_4473',38,'107.84',5),

(10305,'S18_2238',27,'132.62',4),

(10305,'S18_2319',36,'117.82',8),

(10305,'S18_2432',41,'58.95',11),

(10305,'S18_3232',37,'160.87',9),

(10305,'S18_4600',22,'112.60',14),

(10305,'S24_1444',45,'48.55',2),

(10305,'S24_2300',24,'107.34',10),

(10305,'S24_2840',48,'30.76',6),

(10305,'S24_4048',36,'118.28',1),

(10305,'S32_1268',28,'94.38',12),

(10305,'S32_2509',40,'48.70',7),

(10305,'S50_1392',42,'109.96',3),

(10306,'S12_1108',31,'182.86',13),

(10306,'S12_3148',34,'145.04',14),

(10306,'S12_3891',20,'145.34',12),

(10306,'S18_3140',32,'114.74',9),

(10306,'S18_3259',40,'83.70',11),

(10306,'S18_4027',23,'126.39',16),

(10306,'S18_4522',39,'85.14',8),

(10306,'S24_2011',29,'109.37',7),

(10306,'S24_3151',31,'76.12',2),

(10306,'S32_3207',46,'60.28',17),

(10306,'S50_1514',34,'51.55',15),

(10306,'S700_1138',50,'61.34',3),

(10306,'S700_1938',38,'73.62',10),

(10306,'S700_2610',43,'62.16',1),

(10306,'S700_3505',32,'99.17',4),

(10306,'S700_3962',30,'87.39',5),

(10306,'S72_3212',35,'48.05',6),

(10307,'S10_4757',22,'118.32',9),

(10307,'S18_1662',39,'135.61',1),

(10307,'S18_3029',31,'71.40',7),

(10307,'S18_3856',48,'92.11',6),

(10307,'S24_2841',25,'58.23',2),

(10307,'S24_3420',22,'64.44',3),

(10307,'S24_3816',22,'75.47',8),

(10307,'S700_2047',34,'81.47',5),

(10307,'S72_1253',34,'44.20',4),

(10308,'S10_2016',34,'115.37',2),

(10308,'S10_4698',20,'187.85',1),

(10308,'S18_2581',27,'81.95',7),

(10308,'S18_2625',34,'48.46',3),

(10308,'S24_1785',31,'99.57',9),

(10308,'S24_2000',47,'68.55',4),

(10308,'S24_3949',43,'58.00',16),

(10308,'S24_4278',44,'71.73',8),

(10308,'S32_1374',24,'99.89',5),

(10308,'S32_4289',46,'61.22',10),

(10308,'S50_1341',47,'37.09',11),

(10308,'S700_1691',21,'73.07',12),

(10308,'S700_2466',35,'88.75',14),

(10308,'S700_2834',31,'100.85',6),

(10308,'S700_3167',21,'79.20',13),

(10308,'S700_4002',39,'62.93',15),

(10309,'S10_1678',41,'94.74',5),

(10309,'S12_2823',26,'144.60',4),

(10309,'S24_1578',21,'96.92',6),

(10309,'S24_2360',24,'59.56',2),

(10309,'S32_4485',50,'93.89',3),

(10309,'S50_4713',28,'74.04',1),

(10310,'S12_1099',33,'165.38',10),

(10310,'S12_3380',24,'105.70',8),

(10310,'S12_3990',49,'77.41',11),

(10310,'S12_4675',25,'101.34',7),

(10310,'S18_1129',37,'128.80',2),

(10310,'S18_1889',20,'66.99',6),

(10310,'S18_1984',24,'129.45',1),

(10310,'S18_3232',48,'159.18',3),

(10310,'S18_3278',27,'70.76',13),

(10310,'S18_3482',49,'122.00',12),

(10310,'S18_3782',42,'59.06',16),

(10310,'S18_4721',40,'133.92',15),

(10310,'S24_2972',33,'33.23',4),

(10310,'S24_3371',38,'50.21',9),

(10310,'S24_3856',45,'139.03',5),

(10310,'S24_4620',49,'75.18',14),

(10310,'S32_2206',36,'38.62',17),

(10311,'S18_1589',29,'124.44',9),

(10311,'S18_2870',43,'114.84',10),

(10311,'S18_3685',32,'134.22',11),

(10311,'S18_4409',41,'92.03',1),

(10311,'S18_4933',25,'66.99',2),

(10311,'S24_1046',26,'70.55',6),

(10311,'S24_1628',45,'48.80',8),

(10311,'S24_2766',28,'89.05',4),

(10311,'S24_2887',43,'116.27',3),

(10311,'S24_3191',25,'85.61',5),

(10311,'S24_3432',46,'91.02',7),

(10312,'S10_1949',48,'214.30',3),

(10312,'S18_1097',32,'101.50',2),

(10312,'S18_1342',43,'102.74',10),

(10312,'S18_1367',25,'43.67',9),

(10312,'S18_1749',48,'146.20',17),

(10312,'S18_2248',30,'48.43',16),

(10312,'S18_2325',31,'111.87',14),

(10312,'S18_2795',25,'150.19',11),

(10312,'S18_2949',37,'91.18',4),

(10312,'S18_2957',35,'54.34',6),

(10312,'S18_3136',38,'93.20',5),

(10312,'S18_3320',33,'84.33',8),

(10312,'S18_4668',39,'44.27',1),

(10312,'S24_1937',39,'27.88',13),

(10312,'S24_2022',23,'43.46',12),

(10312,'S24_3969',31,'40.21',15),

(10312,'S24_4258',44,'96.42',7),

(10313,'S10_4962',40,'141.83',7),

(10313,'S12_1666',21,'131.20',11),

(10313,'S18_2319',29,'109.23',2),

(10313,'S18_2432',34,'52.87',5),

(10313,'S18_3232',25,'143.94',3),

(10313,'S18_4600',28,'110.18',8),

(10313,'S24_2300',42,'102.23',4),

(10313,'S32_1268',27,'96.31',6),

(10313,'S32_2509',38,'48.70',1),

(10313,'S32_3522',34,'55.59',10),

(10313,'S700_2824',30,'96.09',9),

(10314,'S12_1108',38,'176.63',5),

(10314,'S12_3148',46,'125.40',6),

(10314,'S12_3891',36,'169.56',4),

(10314,'S12_4473',45,'95.99',14),

(10314,'S18_2238',42,'135.90',13),

(10314,'S18_3140',20,'129.76',1),

(10314,'S18_3259',23,'84.71',3),

(10314,'S18_4027',29,'129.26',8),

(10314,'S24_1444',44,'51.44',11),

(10314,'S24_2840',39,'31.82',15),

(10314,'S24_4048',38,'111.18',10),

(10314,'S32_3207',35,'58.41',9),

(10314,'S50_1392',28,'115.75',12),

(10314,'S50_1514',38,'50.38',7),

(10314,'S700_1938',23,'83.15',2),

(10315,'S18_4522',36,'78.12',7),

(10315,'S24_2011',35,'111.83',6),

(10315,'S24_3151',24,'78.77',1),

(10315,'S700_1138',41,'60.67',2),

(10315,'S700_3505',31,'99.17',3),

(10315,'S700_3962',37,'88.39',4),

(10315,'S72_3212',40,'51.32',5),

(10316,'S10_4757',33,'126.48',17),

(10316,'S18_1662',27,'140.34',9),

(10316,'S18_3029',21,'72.26',15),

(10316,'S18_3856',47,'89.99',14),

(10316,'S24_1785',25,'93.01',1),

(10316,'S24_2841',34,'67.14',10),

(10316,'S24_3420',47,'55.23',11),

(10316,'S24_3816',25,'77.15',16),

(10316,'S24_3949',30,'67.56',8),

(10316,'S32_4289',24,'59.16',2),

(10316,'S50_1341',34,'36.66',3),

(10316,'S700_1691',34,'74.90',4),

(10316,'S700_2047',45,'73.32',13),

(10316,'S700_2466',23,'85.76',6),

(10316,'S700_2610',48,'67.22',18),

(10316,'S700_3167',48,'77.60',5),

(10316,'S700_4002',44,'68.11',7),

(10316,'S72_1253',34,'43.70',12),

(10317,'S24_4278',35,'69.55',1),

(10318,'S10_1678',46,'84.22',1),

(10318,'S10_2016',45,'102.29',4),

(10318,'S10_4698',37,'189.79',3),

(10318,'S18_2581',31,'81.95',9),

(10318,'S18_2625',42,'49.67',5),

(10318,'S24_1578',48,'93.54',2),

(10318,'S24_2000',26,'60.94',6),

(10318,'S32_1374',47,'81.91',7),

(10318,'S700_2834',50,'102.04',8),

(10319,'S12_2823',30,'134.05',9),

(10319,'S18_3278',46,'77.19',1),

(10319,'S18_3782',44,'54.71',4),

(10319,'S18_4721',45,'120.53',3),

(10319,'S24_2360',31,'65.80',7),

(10319,'S24_4620',43,'78.41',2),

(10319,'S32_2206',29,'35.00',5),

(10319,'S32_4485',22,'96.95',8),

(10319,'S50_4713',45,'79.73',6),

(10320,'S12_1099',31,'184.84',3),

(10320,'S12_3380',35,'102.17',1),

(10320,'S12_3990',38,'63.84',4),

(10320,'S18_3482',25,'139.64',5),

(10320,'S24_3371',26,'60.62',2),

(10321,'S12_4675',24,'105.95',15),

(10321,'S18_1129',41,'123.14',10),

(10321,'S18_1589',44,'120.71',6),

(10321,'S18_1889',37,'73.92',14),

(10321,'S18_1984',25,'142.25',9),

(10321,'S18_2870',27,'126.72',7),

(10321,'S18_3232',33,'164.26',11),

(10321,'S18_3685',28,'138.45',8),

(10321,'S24_1046',30,'68.35',3),

(10321,'S24_1628',48,'42.76',5),

(10321,'S24_2766',30,'74.51',1),

(10321,'S24_2972',37,'31.72',12),

(10321,'S24_3191',39,'81.33',2),

(10321,'S24_3432',21,'103.87',4),

(10321,'S24_3856',26,'137.62',13),

(10322,'S10_1949',40,'180.01',1),

(10322,'S10_4962',46,'141.83',8),

(10322,'S12_1666',27,'136.67',9),

(10322,'S18_1097',22,'101.50',10),

(10322,'S18_1342',43,'92.47',14),

(10322,'S18_1367',41,'44.21',5),

(10322,'S18_2325',50,'120.77',6),

(10322,'S18_2432',35,'57.12',11),

(10322,'S18_2795',36,'158.63',2),

(10322,'S18_2949',33,'100.30',12),

(10322,'S18_2957',41,'54.34',13),

(10322,'S18_3136',48,'90.06',7),

(10322,'S24_1937',20,'26.55',3),

(10322,'S24_2022',30,'40.77',4),

(10323,'S18_3320',33,'88.30',2),

(10323,'S18_4600',47,'96.86',1),

(10324,'S12_3148',27,'148.06',1),

(10324,'S12_4473',26,'100.73',7),

(10324,'S18_2238',47,'142.45',8),

(10324,'S18_2319',33,'105.55',10),

(10324,'S18_3232',27,'137.17',12),

(10324,'S18_4027',49,'120.64',13),

(10324,'S18_4668',38,'49.81',6),

(10324,'S24_1444',25,'49.71',14),

(10324,'S24_2300',31,'107.34',2),

(10324,'S24_2840',30,'29.35',9),

(10324,'S24_4258',33,'95.44',3),

(10324,'S32_1268',20,'91.49',11),

(10324,'S32_3522',48,'60.76',4),

(10324,'S700_2824',34,'80.92',5),

(10325,'S10_4757',47,'111.52',6),

(10325,'S12_1108',42,'193.25',8),

(10325,'S12_3891',24,'166.10',1),

(10325,'S18_3140',24,'114.74',9),

(10325,'S24_4048',44,'114.73',5),

(10325,'S32_2509',38,'44.37',3),

(10325,'S32_3207',28,'55.30',2),

(10325,'S50_1392',38,'99.55',4),

(10325,'S50_1514',44,'56.24',7),

(10326,'S18_3259',32,'94.79',6),

(10326,'S18_4522',50,'73.73',5),

(10326,'S24_2011',41,'120.43',4),

(10326,'S24_3151',41,'86.74',3),

(10326,'S24_3816',20,'81.34',2),

(10326,'S700_1138',39,'60.67',1),

(10327,'S18_1662',25,'154.54',6),

(10327,'S18_2581',45,'74.34',8),

(10327,'S18_3029',25,'74.84',5),

(10327,'S700_1938',20,'79.68',7),

(10327,'S700_2610',21,'65.05',1),

(10327,'S700_3505',43,'85.14',2),

(10327,'S700_3962',37,'83.42',3),

(10327,'S72_3212',37,'48.05',4),

(10328,'S18_3856',34,'104.81',6),

(10328,'S24_1785',47,'87.54',14),

(10328,'S24_2841',48,'67.82',1),

(10328,'S24_3420',20,'56.55',2),

(10328,'S24_3949',35,'55.96',3),

(10328,'S24_4278',43,'69.55',4),

(10328,'S32_4289',24,'57.10',5),

(10328,'S50_1341',34,'42.33',7),

(10328,'S700_1691',27,'84.03',8),

(10328,'S700_2047',41,'75.13',9),

(10328,'S700_2466',37,'95.73',10),

(10328,'S700_2834',33,'117.46',11),

(10328,'S700_3167',33,'71.20',13),

(10328,'S700_4002',39,'69.59',12),

(10329,'S10_1678',42,'80.39',1),

(10329,'S10_2016',20,'109.42',2),

(10329,'S10_4698',26,'164.61',3),

(10329,'S12_1099',41,'182.90',5),

(10329,'S12_2823',24,'128.03',6),

(10329,'S12_3380',46,'117.44',13),

(10329,'S12_3990',33,'74.21',14),

(10329,'S12_4675',39,'102.49',15),

(10329,'S18_1889',29,'66.22',9),

(10329,'S18_2625',38,'55.72',12),

(10329,'S18_3278',38,'65.13',10),

(10329,'S24_1578',30,'104.81',7),

(10329,'S24_2000',37,'71.60',4),

(10329,'S32_1374',45,'80.91',11),

(10329,'S72_1253',44,'41.22',8),

(10330,'S18_3482',37,'136.70',3),

(10330,'S18_3782',29,'59.06',2),

(10330,'S18_4721',50,'133.92',4),

(10330,'S24_2360',42,'56.10',1),

(10331,'S18_1129',46,'120.31',6),

(10331,'S18_1589',44,'99.55',14),

(10331,'S18_1749',44,'154.70',7),

(10331,'S18_1984',30,'135.14',8),

(10331,'S18_2870',26,'130.68',10),

(10331,'S18_3232',27,'169.34',11),

(10331,'S18_3685',26,'132.80',12),

(10331,'S24_2972',27,'37.00',13),

(10331,'S24_3371',25,'55.11',9),

(10331,'S24_3856',21,'139.03',1),

(10331,'S24_4620',41,'70.33',2),

(10331,'S32_2206',28,'33.39',3),

(10331,'S32_4485',32,'100.01',4),

(10331,'S50_4713',20,'74.04',5),

(10332,'S18_1342',46,'89.38',15),

(10332,'S18_1367',27,'51.21',16),

(10332,'S18_2248',38,'53.88',9),

(10332,'S18_2325',35,'116.96',8),

(10332,'S18_2795',24,'138.38',1),

(10332,'S18_2957',26,'53.09',17),

(10332,'S18_3136',40,'100.53',18),

(10332,'S18_4409',50,'92.03',2),

(10332,'S18_4933',21,'70.56',3),

(10332,'S24_1046',23,'61.73',4),

(10332,'S24_1628',20,'47.29',5),

(10332,'S24_1937',45,'29.87',6),

(10332,'S24_2022',26,'43.01',10),

(10332,'S24_2766',39,'84.51',7),

(10332,'S24_2887',44,'108.04',11),

(10332,'S24_3191',45,'77.91',12),

(10332,'S24_3432',31,'94.23',13),

(10332,'S24_3969',41,'34.47',14),

(10333,'S10_1949',26,'188.58',3),

(10333,'S12_1666',33,'121.64',6),

(10333,'S18_1097',29,'110.84',7),

(10333,'S18_2949',31,'95.23',5),

(10333,'S18_3320',46,'95.24',2),

(10333,'S18_4668',24,'42.26',8),

(10333,'S24_4258',39,'95.44',1),

(10333,'S32_3522',33,'62.05',4),

(10334,'S10_4962',26,'130.01',2),

(10334,'S18_2319',46,'108.00',6),

(10334,'S18_2432',34,'52.87',1),

(10334,'S18_3232',20,'147.33',3),

(10334,'S18_4600',49,'101.71',4),

(10334,'S24_2300',42,'117.57',5),

(10335,'S24_2840',33,'32.88',2),

(10335,'S32_1268',44,'77.05',1),

(10335,'S32_2509',40,'49.78',3),

(10336,'S12_1108',33,'176.63',10),

(10336,'S12_3148',33,'126.91',11),

(10336,'S12_3891',49,'141.88',1),

(10336,'S12_4473',38,'95.99',3),

(10336,'S18_2238',49,'153.91',6),

(10336,'S18_3140',48,'135.22',12),

(10336,'S18_3259',21,'100.84',7),

(10336,'S24_1444',45,'49.71',4),

(10336,'S24_4048',31,'113.55',5),

(10336,'S32_3207',31,'59.03',9),

(10336,'S50_1392',23,'109.96',8),

(10336,'S700_2824',46,'94.07',2),

(10337,'S10_4757',25,'131.92',8),

(10337,'S18_4027',36,'140.75',3),

(10337,'S18_4522',29,'76.36',2),

(10337,'S24_2011',29,'119.20',4),

(10337,'S50_1514',21,'54.48',6),

(10337,'S700_1938',36,'73.62',9),

(10337,'S700_3505',31,'84.14',1),

(10337,'S700_3962',36,'83.42',7),

(10337,'S72_3212',42,'49.14',5),

(10338,'S18_1662',41,'137.19',1),

(10338,'S18_3029',28,'80.86',3),

(10338,'S18_3856',45,'93.17',2),

(10339,'S10_2016',40,'117.75',4),

(10339,'S10_4698',39,'178.17',3),

(10339,'S18_2581',27,'79.41',2),

(10339,'S18_2625',30,'48.46',1),

(10339,'S24_1578',27,'96.92',10),

(10339,'S24_1785',21,'106.14',7),

(10339,'S24_2841',55,'67.82',12),

(10339,'S24_3151',55,'73.46',13),

(10339,'S24_3420',29,'57.86',14),

(10339,'S24_3816',42,'72.96',16),

(10339,'S24_3949',45,'57.32',11),

(10339,'S700_1138',22,'53.34',5),

(10339,'S700_2047',55,'86.90',15),

(10339,'S700_2610',50,'62.16',9),

(10339,'S700_4002',50,'66.63',8),

(10339,'S72_1253',27,'49.66',6),

(10340,'S24_2000',55,'62.46',8),

(10340,'S24_4278',40,'63.76',1),

(10340,'S32_1374',55,'95.89',2),

(10340,'S32_4289',39,'67.41',3),

(10340,'S50_1341',40,'37.09',4),

(10340,'S700_1691',30,'73.99',5),

(10340,'S700_2466',55,'81.77',7),

(10340,'S700_2834',29,'98.48',6),

(10341,'S10_1678',41,'84.22',9),

(10341,'S12_1099',45,'192.62',2),

(10341,'S12_2823',55,'120.50',8),

(10341,'S12_3380',44,'111.57',1),

(10341,'S12_3990',36,'77.41',10),

(10341,'S12_4675',55,'109.40',7),

(10341,'S24_2360',32,'63.03',6),

(10341,'S32_4485',31,'95.93',4),

(10341,'S50_4713',38,'78.11',3),

(10341,'S700_3167',34,'70.40',5),

(10342,'S18_1129',40,'118.89',2),

(10342,'S18_1889',55,'63.14',1),

(10342,'S18_1984',22,'115.22',3),

(10342,'S18_3232',30,'167.65',4),

(10342,'S18_3278',25,'76.39',5),

(10342,'S18_3482',55,'136.70',7),

(10342,'S18_3782',26,'57.82',8),

(10342,'S18_4721',38,'124.99',11),

(10342,'S24_2972',39,'30.59',9),

(10342,'S24_3371',48,'60.01',10),

(10342,'S24_3856',42,'112.34',6),

(10343,'S18_1589',36,'109.51',4),

(10343,'S18_2870',25,'118.80',3),

(10343,'S18_3685',44,'127.15',2),

(10343,'S24_1628',27,'44.78',6),

(10343,'S24_4620',30,'76.80',1),

(10343,'S32_2206',29,'37.41',5),

(10344,'S18_1749',45,'168.30',1),

(10344,'S18_2248',40,'49.04',2),

(10344,'S18_2325',30,'118.23',3),

(10344,'S18_4409',21,'80.99',4),

(10344,'S18_4933',26,'68.42',5),

(10344,'S24_1046',29,'61.00',7),

(10344,'S24_1937',20,'27.88',6),

(10345,'S24_2022',43,'38.98',1),

(10346,'S18_1342',42,'88.36',3),

(10346,'S24_2766',25,'87.24',1),

(10346,'S24_2887',24,'117.44',5),

(10346,'S24_3191',24,'80.47',2),

(10346,'S24_3432',26,'103.87',6),

(10346,'S24_3969',22,'38.57',4),

(10347,'S10_1949',30,'188.58',1),

(10347,'S10_4962',27,'132.97',2),

(10347,'S12_1666',29,'132.57',3),

(10347,'S18_1097',42,'113.17',5),

(10347,'S18_1367',21,'46.36',7),

(10347,'S18_2432',50,'51.05',8),

(10347,'S18_2795',21,'136.69',6),

(10347,'S18_2949',48,'84.09',9),

(10347,'S18_2957',34,'60.59',10),

(10347,'S18_3136',45,'95.30',11),

(10347,'S18_3320',26,'84.33',12),

(10347,'S18_4600',45,'115.03',4),

(10348,'S12_1108',48,'207.80',8),

(10348,'S12_3148',47,'122.37',4),

(10348,'S18_4668',29,'43.77',6),

(10348,'S24_2300',37,'107.34',1),

(10348,'S24_4258',39,'82.78',2),

(10348,'S32_1268',42,'90.53',3),

(10348,'S32_3522',31,'62.70',5),

(10348,'S700_2824',32,'100.14',7),

(10349,'S12_3891',26,'166.10',10),

(10349,'S12_4473',48,'114.95',9),

(10349,'S18_2238',38,'142.45',8),

(10349,'S18_2319',38,'117.82',7),

(10349,'S18_3232',48,'164.26',6),

(10349,'S18_4027',34,'140.75',5),

(10349,'S24_1444',48,'50.29',4),

(10349,'S24_2840',36,'31.47',3),

(10349,'S24_4048',23,'111.18',2),

(10349,'S32_2509',33,'44.37',1),

(10350,'S10_4757',26,'110.16',5),

(10350,'S18_3029',43,'84.30',6),

(10350,'S18_3140',44,'135.22',1),

(10350,'S18_3259',41,'94.79',2),

(10350,'S18_4522',30,'70.22',3),

(10350,'S24_2011',34,'98.31',7),

(10350,'S24_3151',30,'86.74',9),

(10350,'S24_3816',25,'77.15',10),

(10350,'S32_3207',27,'61.52',14),

(10350,'S50_1392',31,'104.18',8),

(10350,'S50_1514',44,'56.82',17),

(10350,'S700_1138',46,'56.00',11),

(10350,'S700_1938',28,'76.22',4),

(10350,'S700_2610',29,'68.67',12),

(10350,'S700_3505',31,'87.15',13),

(10350,'S700_3962',25,'97.32',16),

(10350,'S72_3212',20,'48.05',15),

(10351,'S18_1662',39,'143.50',1),

(10351,'S18_3856',20,'104.81',2),

(10351,'S24_2841',25,'64.40',5),

(10351,'S24_3420',38,'53.92',4),

(10351,'S24_3949',34,'68.24',3),

(10352,'S700_2047',23,'75.13',3),

(10352,'S700_2466',49,'87.75',2),

(10352,'S700_4002',22,'62.19',1),

(10352,'S72_1253',49,'46.18',4),

(10353,'S18_2581',27,'71.81',1),

(10353,'S24_1785',28,'107.23',2),

(10353,'S24_4278',35,'69.55',3),

(10353,'S32_1374',46,'86.90',5),

(10353,'S32_4289',40,'68.10',7),

(10353,'S50_1341',40,'35.78',8),

(10353,'S700_1691',39,'73.07',9),

(10353,'S700_2834',48,'98.48',4),

(10353,'S700_3167',43,'74.40',6),

(10354,'S10_1678',42,'84.22',6),

(10354,'S10_2016',20,'95.15',2),

(10354,'S10_4698',42,'178.17',3),

(10354,'S12_1099',31,'157.60',9),

(10354,'S12_2823',35,'141.58',4),

(10354,'S12_3380',29,'98.65',11),

(10354,'S12_3990',23,'76.61',12),

(10354,'S12_4675',28,'100.19',13),

(10354,'S18_1889',21,'76.23',8),

(10354,'S18_2625',28,'49.06',10),

(10354,'S18_3278',36,'69.15',7),

(10354,'S24_1578',21,'96.92',5),

(10354,'S24_2000',28,'62.46',1),

(10355,'S18_3482',23,'117.59',7),

(10355,'S18_3782',31,'60.30',1),

(10355,'S18_4721',25,'124.99',2),

(10355,'S24_2360',41,'56.10',3),

(10355,'S24_2972',36,'37.38',4),

(10355,'S24_3371',44,'60.62',6),

(10355,'S24_3856',32,'137.62',8),

(10355,'S24_4620',28,'75.18',9),

(10355,'S32_2206',38,'32.99',10),

(10355,'S32_4485',40,'93.89',5),

(10356,'S18_1129',43,'120.31',8),

(10356,'S18_1342',50,'82.19',9),

(10356,'S18_1367',22,'44.75',6),

(10356,'S18_1984',27,'130.87',2),

(10356,'S18_2325',29,'106.79',3),

(10356,'S18_2795',30,'158.63',1),

(10356,'S24_1937',48,'31.86',5),

(10356,'S24_2022',26,'42.11',7),

(10356,'S50_4713',26,'78.11',4),

(10357,'S10_1949',32,'199.30',10),

(10357,'S10_4962',43,'135.92',9),

(10357,'S12_1666',49,'109.34',8),

(10357,'S18_1097',39,'112.00',1),

(10357,'S18_2432',41,'58.95',7),

(10357,'S18_2949',41,'91.18',6),

(10357,'S18_2957',49,'59.34',5),

(10357,'S18_3136',44,'104.72',4),

(10357,'S18_3320',25,'84.33',3),

(10357,'S18_4600',28,'105.34',2),

(10358,'S12_3148',49,'129.93',5),

(10358,'S12_4473',42,'98.36',9),

(10358,'S18_2238',20,'142.45',10),

(10358,'S18_2319',20,'99.41',11),

(10358,'S18_3232',32,'137.17',12),

(10358,'S18_4027',25,'117.77',13),

(10358,'S18_4668',30,'46.29',8),

(10358,'S24_1444',44,'56.07',14),

(10358,'S24_2300',41,'127.79',7),

(10358,'S24_2840',36,'33.59',4),

(10358,'S24_4258',41,'88.62',6),

(10358,'S32_1268',41,'82.83',1),

(10358,'S32_3522',36,'51.71',2),

(10358,'S700_2824',27,'85.98',3),

(10359,'S10_4757',48,'122.40',6),

(10359,'S12_1108',42,'180.79',8),

(10359,'S12_3891',49,'162.64',5),

(10359,'S24_4048',22,'108.82',7),

(10359,'S32_2509',36,'45.45',3),

(10359,'S32_3207',22,'62.14',1),

(10359,'S50_1392',46,'99.55',2),

(10359,'S50_1514',25,'47.45',4),

(10360,'S18_1662',50,'126.15',12),

(10360,'S18_2581',41,'68.43',13),

(10360,'S18_3029',46,'71.40',14),

(10360,'S18_3140',29,'122.93',8),

(10360,'S18_3259',29,'94.79',18),

(10360,'S18_3856',40,'101.64',15),

(10360,'S18_4522',40,'76.36',1),

(10360,'S24_1785',22,'106.14',17),

(10360,'S24_2011',31,'100.77',2),

(10360,'S24_2841',49,'55.49',16),

(10360,'S24_3151',36,'70.81',3),

(10360,'S24_3816',22,'78.83',4),

(10360,'S700_1138',32,'64.67',5),

(10360,'S700_1938',26,'86.61',6),

(10360,'S700_2610',30,'70.11',7),

(10360,'S700_3505',35,'83.14',9),

(10360,'S700_3962',31,'92.36',10),

(10360,'S72_3212',31,'54.05',11),

(10361,'S10_1678',20,'92.83',13),

(10361,'S10_2016',26,'114.18',8),

(10361,'S24_3420',34,'62.46',6),

(10361,'S24_3949',26,'61.42',7),

(10361,'S24_4278',25,'68.83',1),

(10361,'S32_4289',49,'56.41',2),

(10361,'S50_1341',33,'35.78',3),

(10361,'S700_1691',20,'88.60',4),

(10361,'S700_2047',24,'85.99',14),

(10361,'S700_2466',26,'91.74',9),

(10361,'S700_2834',44,'107.97',5),

(10361,'S700_3167',44,'76.80',10),

(10361,'S700_4002',35,'62.19',11),

(10361,'S72_1253',23,'47.67',12),

(10362,'S10_4698',22,'182.04',4),

(10362,'S12_2823',22,'131.04',1),

(10362,'S18_2625',23,'53.91',3),

(10362,'S24_1578',50,'91.29',2),

(10363,'S12_1099',33,'180.95',3),

(10363,'S12_3380',34,'106.87',4),

(10363,'S12_3990',34,'68.63',5),

(10363,'S12_4675',46,'103.64',6),

(10363,'S18_1889',22,'61.60',7),

(10363,'S18_3278',46,'69.15',10),

(10363,'S18_3482',24,'124.94',11),

(10363,'S18_3782',32,'52.22',12),

(10363,'S18_4721',28,'123.50',13),

(10363,'S24_2000',21,'70.08',8),

(10363,'S24_2360',43,'56.10',14),

(10363,'S24_3371',21,'52.05',15),

(10363,'S24_3856',31,'113.75',1),

(10363,'S24_4620',43,'75.99',9),

(10363,'S32_1374',50,'92.90',2),

(10364,'S32_2206',48,'38.22',1),

(10365,'S18_1129',30,'116.06',1),

(10365,'S32_4485',22,'82.66',3),

(10365,'S50_4713',44,'68.34',2),

(10366,'S18_1984',34,'116.65',3),

(10366,'S18_2870',49,'105.60',2),

(10366,'S18_3232',34,'154.10',1),

(10367,'S18_1589',49,'105.77',1),

(10367,'S18_1749',37,'144.50',3),

(10367,'S18_2248',45,'50.25',4),

(10367,'S18_2325',27,'124.59',5),

(10367,'S18_2795',32,'140.06',7),

(10367,'S18_3685',46,'131.39',6),

(10367,'S18_4409',43,'77.31',8),

(10367,'S18_4933',44,'66.99',9),

(10367,'S24_1046',21,'72.76',10),

(10367,'S24_1628',38,'50.31',11),

(10367,'S24_1937',23,'29.54',13),

(10367,'S24_2022',28,'43.01',12),

(10367,'S24_2972',36,'36.25',2),

(10368,'S24_2766',40,'73.60',2),

(10368,'S24_2887',31,'115.09',5),

(10368,'S24_3191',46,'83.04',1),

(10368,'S24_3432',20,'93.16',4),

(10368,'S24_3969',46,'36.52',3),

(10369,'S10_1949',41,'195.01',2),

(10369,'S18_1342',44,'89.38',8),

(10369,'S18_1367',32,'46.36',7),

(10369,'S18_2949',42,'100.30',1),

(10369,'S18_2957',28,'51.84',6),

(10369,'S18_3136',21,'90.06',5),

(10369,'S18_3320',45,'80.36',4),

(10369,'S24_4258',40,'93.49',3),

(10370,'S10_4962',35,'128.53',4),

(10370,'S12_1666',49,'128.47',8),

(10370,'S18_1097',27,'100.34',1),

(10370,'S18_2319',22,'101.87',5),

(10370,'S18_2432',22,'60.16',7),

(10370,'S18_3232',27,'167.65',9),

(10370,'S18_4600',29,'105.34',6),

(10370,'S18_4668',20,'41.76',2),

(10370,'S32_3522',25,'63.99',3),

(10371,'S12_1108',32,'178.71',6),

(10371,'S12_4473',49,'104.28',4),

(10371,'S18_2238',25,'160.46',7),

(10371,'S24_1444',25,'53.75',12),

(10371,'S24_2300',20,'126.51',5),

(10371,'S24_2840',45,'35.01',8),

(10371,'S24_4048',28,'95.81',9),

(10371,'S32_1268',26,'82.83',1),

(10371,'S32_2509',20,'44.37',2),

(10371,'S32_3207',30,'53.44',11),

(10371,'S50_1392',48,'97.23',10),

(10371,'S700_2824',34,'83.95',3),

(10372,'S12_3148',40,'146.55',4),

(10372,'S12_3891',34,'140.15',1),

(10372,'S18_3140',28,'131.13',3),

(10372,'S18_3259',25,'91.76',5),

(10372,'S18_4027',48,'119.20',6),

(10372,'S18_4522',41,'78.99',7),

(10372,'S24_2011',37,'102.00',8),

(10372,'S50_1514',24,'56.82',9),

(10372,'S700_1938',44,'74.48',2),

(10373,'S10_4757',39,'118.32',3),

(10373,'S18_1662',28,'143.50',4),

(10373,'S18_3029',22,'75.70',5),

(10373,'S18_3856',50,'99.52',6),

(10373,'S24_2841',38,'58.92',7),

(10373,'S24_3151',33,'82.31',12),

(10373,'S24_3420',46,'53.92',11),

(10373,'S24_3816',23,'83.86',10),

(10373,'S24_3949',39,'62.10',13),

(10373,'S700_1138',44,'58.00',14),

(10373,'S700_2047',32,'76.94',15),

(10373,'S700_2610',41,'69.39',16),

(10373,'S700_3505',34,'94.16',2),

(10373,'S700_3962',37,'83.42',8),

(10373,'S700_4002',45,'68.11',17),

(10373,'S72_1253',25,'44.20',9),

(10373,'S72_3212',29,'48.05',1),

(10374,'S10_2016',39,'115.37',5),

(10374,'S10_4698',22,'158.80',1),

(10374,'S18_2581',42,'75.19',2),

(10374,'S18_2625',22,'48.46',4),

(10374,'S24_1578',38,'112.70',6),

(10374,'S24_1785',46,'107.23',3),

(10375,'S10_1678',21,'76.56',12),

(10375,'S12_1099',45,'184.84',7),

(10375,'S12_2823',49,'150.62',13),

(10375,'S24_2000',23,'67.03',9),

(10375,'S24_2360',20,'60.26',14),

(10375,'S24_4278',43,'60.13',2),

(10375,'S32_1374',37,'87.90',3),

(10375,'S32_4289',44,'59.85',4),

(10375,'S32_4485',41,'96.95',15),

(10375,'S50_1341',49,'36.22',5),

(10375,'S50_4713',49,'69.16',8),

(10375,'S700_1691',37,'86.77',6),

(10375,'S700_2466',33,'94.73',1),

(10375,'S700_2834',25,'98.48',10),

(10375,'S700_3167',44,'69.60',11),

(10376,'S12_3380',35,'98.65',1),

(10377,'S12_3990',24,'65.44',5),

(10377,'S12_4675',50,'112.86',1),

(10377,'S18_1129',35,'124.56',2),

(10377,'S18_1889',31,'61.60',4),

(10377,'S18_1984',36,'125.18',6),

(10377,'S18_3232',39,'143.94',3),

(10378,'S18_1589',34,'121.95',5),

(10378,'S18_3278',22,'66.74',4),

(10378,'S18_3482',43,'146.99',10),

(10378,'S18_3782',28,'60.30',9),

(10378,'S18_4721',49,'122.02',8),

(10378,'S24_2972',41,'30.59',7),

(10378,'S24_3371',46,'52.66',6),

(10378,'S24_3856',33,'129.20',3),

(10378,'S24_4620',41,'80.84',2),

(10378,'S32_2206',40,'35.80',1),

(10379,'S18_1749',39,'156.40',2),

(10379,'S18_2248',27,'50.85',1),

(10379,'S18_2870',29,'113.52',5),

(10379,'S18_3685',32,'134.22',4),

(10379,'S24_1628',32,'48.80',3),

(10380,'S18_1342',27,'88.36',13),

(10380,'S18_2325',40,'119.50',10),

(10380,'S18_2795',21,'156.94',8),

(10380,'S18_4409',32,'78.23',1),

(10380,'S18_4933',24,'66.99',2),

(10380,'S24_1046',34,'66.88',3),

(10380,'S24_1937',32,'29.87',4),

(10380,'S24_2022',27,'37.63',5),

(10380,'S24_2766',36,'77.24',6),

(10380,'S24_2887',44,'111.57',7),

(10380,'S24_3191',44,'77.05',9),

(10380,'S24_3432',34,'91.02',11),

(10380,'S24_3969',43,'32.82',12),

(10381,'S10_1949',36,'182.16',3),

(10381,'S10_4962',37,'138.88',6),

(10381,'S12_1666',20,'132.57',1),

(10381,'S18_1097',48,'114.34',2),

(10381,'S18_1367',25,'49.60',9),

(10381,'S18_2432',35,'60.77',7),

(10381,'S18_2949',41,'100.30',8),

(10381,'S18_2957',40,'51.22',4),

(10381,'S18_3136',35,'93.20',5),

(10382,'S12_1108',34,'166.24',10),

(10382,'S12_3148',37,'145.04',11),

(10382,'S12_3891',34,'143.61',12),

(10382,'S12_4473',32,'103.10',13),

(10382,'S18_2238',25,'160.46',5),

(10382,'S18_3320',50,'84.33',7),

(10382,'S18_4600',39,'115.03',1),

(10382,'S18_4668',39,'46.29',2),

(10382,'S24_2300',20,'120.12',3),

(10382,'S24_4258',33,'97.39',4),

(10382,'S32_1268',26,'85.72',6),

(10382,'S32_3522',48,'57.53',8),

(10382,'S700_2824',34,'101.15',9),

(10383,'S18_2319',27,'119.05',11),

(10383,'S18_3140',24,'125.66',9),

(10383,'S18_3232',47,'155.79',6),

(10383,'S18_3259',26,'83.70',12),

(10383,'S18_4027',38,'137.88',1),

(10383,'S18_4522',28,'77.24',7),

(10383,'S24_1444',22,'52.60',2),

(10383,'S24_2840',40,'33.24',3),

(10383,'S24_4048',21,'117.10',4),

(10383,'S32_2509',32,'53.57',5),

(10383,'S32_3207',44,'55.93',8),

(10383,'S50_1392',29,'94.92',13),

(10383,'S50_1514',38,'48.62',10),

(10384,'S10_4757',34,'129.20',4),

(10384,'S24_2011',28,'114.29',3),

(10384,'S24_3151',43,'71.69',2),

(10384,'S700_1938',49,'71.02',1),

(10385,'S24_3816',37,'78.83',2),

(10385,'S700_1138',25,'62.00',1),

(10386,'S18_1662',25,'130.88',7),

(10386,'S18_2581',21,'72.65',18),

(10386,'S18_3029',37,'73.12',5),

(10386,'S18_3856',22,'100.58',6),

(10386,'S24_1785',33,'101.76',11),

(10386,'S24_2841',39,'56.86',1),

(10386,'S24_3420',35,'54.57',9),

(10386,'S24_3949',41,'55.96',12),

(10386,'S24_4278',50,'71.73',8),

(10386,'S700_2047',29,'85.09',13),

(10386,'S700_2466',37,'90.75',14),

(10386,'S700_2610',37,'67.22',10),

(10386,'S700_3167',32,'68.00',17),

(10386,'S700_3505',45,'83.14',2),

(10386,'S700_3962',30,'80.44',3),

(10386,'S700_4002',44,'59.22',15),

(10386,'S72_1253',50,'47.67',16),

(10386,'S72_3212',43,'52.42',4),

(10387,'S32_1374',44,'79.91',1),

(10388,'S10_1678',42,'80.39',4),

(10388,'S10_2016',50,'118.94',5),

(10388,'S10_4698',21,'156.86',7),

(10388,'S12_2823',44,'125.01',6),

(10388,'S32_4289',35,'58.47',8),

(10388,'S50_1341',27,'41.02',1),

(10388,'S700_1691',46,'74.90',2),

(10388,'S700_2834',50,'111.53',3),

(10389,'S12_1099',26,'182.90',4),

(10389,'S12_3380',25,'95.13',6),

(10389,'S12_3990',36,'76.61',7),

(10389,'S12_4675',47,'102.49',8),

(10389,'S18_1889',49,'63.91',3),

(10389,'S18_2625',39,'52.09',5),

(10389,'S24_1578',45,'112.70',1),

(10389,'S24_2000',49,'61.70',2),

(10390,'S18_1129',36,'117.48',14),

(10390,'S18_1984',34,'132.29',15),

(10390,'S18_2325',31,'102.98',16),

(10390,'S18_2795',26,'162.00',7),

(10390,'S18_3278',40,'75.59',9),

(10390,'S18_3482',50,'135.23',1),

(10390,'S18_3782',36,'54.09',2),

(10390,'S18_4721',49,'122.02',3),

(10390,'S24_2360',35,'67.87',4),

(10390,'S24_2972',37,'35.87',5),

(10390,'S24_3371',46,'51.43',6),

(10390,'S24_3856',45,'134.81',8),

(10390,'S24_4620',30,'66.29',10),

(10390,'S32_2206',41,'39.02',11),

(10390,'S32_4485',45,'101.03',12),

(10390,'S50_4713',22,'81.36',13),

(10391,'S10_1949',24,'195.01',4),

(10391,'S10_4962',37,'121.15',7),

(10391,'S12_1666',39,'110.70',9),

(10391,'S18_1097',29,'114.34',10),

(10391,'S18_1342',35,'102.74',2),

(10391,'S18_1367',42,'47.44',3),

(10391,'S18_2432',44,'57.73',5),

(10391,'S18_2949',32,'99.28',6),

(10391,'S24_1937',33,'26.55',8),

(10391,'S24_2022',24,'36.29',1),

(10392,'S18_2957',37,'61.21',3),

(10392,'S18_3136',29,'103.67',2),

(10392,'S18_3320',36,'98.22',1),

(10393,'S12_3148',35,'145.04',8),

(10393,'S12_4473',32,'99.54',10),

(10393,'S18_2238',20,'137.53',11),

(10393,'S18_2319',38,'104.32',7),

(10393,'S18_4600',30,'106.55',9),

(10393,'S18_4668',44,'41.76',1),

(10393,'S24_2300',33,'112.46',2),

(10393,'S24_4258',33,'88.62',3),

(10393,'S32_1268',38,'84.75',4),

(10393,'S32_3522',31,'63.35',5),

(10393,'S700_2824',21,'83.95',6),

(10394,'S18_3232',22,'135.47',5),

(10394,'S18_4027',37,'124.95',1),

(10394,'S24_1444',31,'53.18',2),

(10394,'S24_2840',46,'35.36',6),

(10394,'S24_4048',37,'104.09',7),

(10394,'S32_2509',36,'47.08',3),

(10394,'S32_3207',30,'55.93',4),

(10395,'S10_4757',32,'125.12',2),

(10395,'S12_1108',33,'205.72',1),

(10395,'S50_1392',46,'98.39',4),

(10395,'S50_1514',45,'57.99',3),

(10396,'S12_3891',33,'155.72',3),

(10396,'S18_3140',33,'129.76',2),

(10396,'S18_3259',24,'91.76',4),

(10396,'S18_4522',45,'83.38',5),

(10396,'S24_2011',49,'100.77',6),

(10396,'S24_3151',27,'77.00',7),

(10396,'S24_3816',37,'77.99',8),

(10396,'S700_1138',39,'62.00',1),

(10397,'S700_1938',32,'69.29',5),

(10397,'S700_2610',22,'62.88',4),

(10397,'S700_3505',48,'86.15',3),

(10397,'S700_3962',36,'80.44',2),

(10397,'S72_3212',34,'52.96',1),

(10398,'S18_1662',33,'130.88',11),

(10398,'S18_2581',34,'82.79',15),

(10398,'S18_3029',28,'70.54',18),

(10398,'S18_3856',45,'92.11',17),

(10398,'S24_1785',43,'100.67',16),

(10398,'S24_2841',28,'60.29',3),

(10398,'S24_3420',34,'61.15',13),

(10398,'S24_3949',41,'56.64',2),

(10398,'S24_4278',45,'65.93',14),

(10398,'S32_4289',22,'60.54',4),

(10398,'S50_1341',49,'38.84',5),

(10398,'S700_1691',47,'78.55',6),

(10398,'S700_2047',36,'75.13',7),

(10398,'S700_2466',22,'98.72',8),

(10398,'S700_2834',23,'102.04',9),

(10398,'S700_3167',29,'76.80',10),

(10398,'S700_4002',36,'62.19',12),

(10398,'S72_1253',34,'41.22',1),

(10399,'S10_1678',40,'77.52',8),

(10399,'S10_2016',51,'99.91',7),

(10399,'S10_4698',22,'156.86',6),

(10399,'S12_2823',29,'123.51',5),

(10399,'S18_2625',30,'51.48',4),

(10399,'S24_1578',57,'104.81',3),

(10399,'S24_2000',58,'75.41',2),

(10399,'S32_1374',32,'97.89',1),

(10400,'S10_4757',64,'134.64',9),

(10400,'S18_1662',34,'129.31',1),

(10400,'S18_3029',30,'74.84',7),

(10400,'S18_3856',58,'88.93',6),

(10400,'S24_2841',24,'55.49',2),

(10400,'S24_3420',38,'59.18',3),

(10400,'S24_3816',42,'74.64',8),

(10400,'S700_2047',46,'82.37',5),

(10400,'S72_1253',20,'41.71',4),

(10401,'S18_2581',42,'75.19',3),

(10401,'S24_1785',38,'87.54',5),

(10401,'S24_3949',64,'59.37',12),

(10401,'S24_4278',52,'65.93',4),

(10401,'S32_1374',49,'81.91',1),

(10401,'S32_4289',62,'62.60',6),

(10401,'S50_1341',56,'41.46',7),

(10401,'S700_1691',11,'77.64',8),

(10401,'S700_2466',85,'98.72',10),

(10401,'S700_2834',21,'96.11',2),

(10401,'S700_3167',77,'73.60',9),

(10401,'S700_4002',40,'66.63',11),

(10402,'S10_2016',45,'118.94',1),

(10402,'S18_2625',55,'58.15',2),

(10402,'S24_2000',59,'61.70',3),

(10403,'S10_1678',24,'85.17',7),

(10403,'S10_4698',66,'174.29',9),

(10403,'S12_2823',66,'122.00',6),

(10403,'S18_3782',36,'55.33',1),

(10403,'S24_1578',46,'109.32',8),

(10403,'S24_2360',27,'57.49',4),

(10403,'S32_2206',30,'35.80',2),

(10403,'S32_4485',45,'88.78',5),

(10403,'S50_4713',31,'65.09',3),

(10404,'S12_1099',64,'163.44',3),

(10404,'S12_3380',43,'102.17',1),

(10404,'S12_3990',77,'67.03',4),

(10404,'S18_3278',90,'67.54',6),

(10404,'S18_3482',28,'127.88',5),

(10404,'S18_4721',48,'124.99',8),

(10404,'S24_3371',49,'53.27',2),

(10404,'S24_4620',48,'65.48',7),

(10405,'S12_4675',97,'115.16',5),

(10405,'S18_1889',61,'72.38',4),

(10405,'S18_3232',55,'147.33',1),

(10405,'S24_2972',47,'37.38',2),

(10405,'S24_3856',76,'127.79',3),

(10406,'S18_1129',61,'124.56',3),

(10406,'S18_1984',48,'133.72',2),

(10406,'S18_3685',65,'117.26',1),

(10407,'S18_1589',59,'114.48',11),

(10407,'S18_1749',76,'141.10',2),

(10407,'S18_2248',42,'58.12',1),

(10407,'S18_2870',41,'132.00',12),

(10407,'S18_4409',6,'91.11',3),

(10407,'S18_4933',66,'64.14',4),

(10407,'S24_1046',26,'68.35',8),

(10407,'S24_1628',64,'45.78',10),

(10407,'S24_2766',76,'81.78',6),

(10407,'S24_2887',59,'98.65',5),

(10407,'S24_3191',13,'77.05',7),

(10407,'S24_3432',43,'101.73',9),

(10408,'S24_3969',15,'41.03',1),

(10409,'S18_2325',6,'104.25',2),

(10409,'S24_1937',61,'27.88',1),

(10410,'S18_1342',65,'99.66',7),

(10410,'S18_1367',44,'51.21',6),

(10410,'S18_2795',56,'145.13',8),

(10410,'S18_2949',47,'93.21',1),

(10410,'S18_2957',53,'49.97',3),

(10410,'S18_3136',34,'84.82',2),

(10410,'S18_3320',44,'81.35',5),

(10410,'S24_2022',31,'42.56',9),

(10410,'S24_4258',50,'95.44',4),

(10411,'S10_1949',23,'205.73',9),

(10411,'S10_4962',27,'144.79',2),

(10411,'S12_1666',40,'110.70',6),

(10411,'S18_1097',27,'109.67',8),

(10411,'S18_4600',46,'106.55',3),

(10411,'S18_4668',35,'41.25',7),

(10411,'S32_1268',26,'78.01',1),

(10411,'S32_3522',27,'60.76',5),

(10411,'S700_2824',34,'89.01',4),

(10412,'S12_4473',54,'100.73',5),

(10412,'S18_2238',41,'150.63',4),

(10412,'S18_2319',56,'120.28',8),

(10412,'S18_2432',47,'49.83',11),

(10412,'S18_3232',60,'157.49',9),

(10412,'S24_1444',21,'47.40',2),

(10412,'S24_2300',70,'109.90',10),

(10412,'S24_2840',30,'32.88',6),

(10412,'S24_4048',31,'108.82',1),

(10412,'S32_2509',19,'50.86',7),

(10412,'S50_1392',26,'105.33',3),

(10413,'S12_1108',36,'201.57',2),

(10413,'S12_3148',47,'145.04',3),

(10413,'S12_3891',22,'173.02',1),

(10413,'S18_4027',49,'133.57',5),

(10413,'S32_3207',24,'56.55',6),

(10413,'S50_1514',51,'53.31',4),

(10414,'S10_4757',49,'114.24',3),

(10414,'S18_3029',44,'77.42',1),

(10414,'S18_3140',41,'128.39',12),

(10414,'S18_3259',48,'85.71',14),

(10414,'S18_4522',56,'83.38',11),

(10414,'S24_2011',43,'108.14',10),

(10414,'S24_3151',60,'72.58',5),

(10414,'S24_3816',51,'72.96',2),

(10414,'S700_1138',37,'62.00',6),

(10414,'S700_1938',34,'74.48',13),

(10414,'S700_2610',31,'61.44',4),

(10414,'S700_3505',28,'84.14',7),

(10414,'S700_3962',40,'84.41',8),

(10414,'S72_3212',47,'54.60',9),

(10415,'S18_3856',51,'86.81',5),

(10415,'S24_2841',21,'60.97',1),

(10415,'S24_3420',18,'59.83',2),

(10415,'S700_2047',32,'73.32',4),

(10415,'S72_1253',42,'43.20',3),

(10416,'S18_1662',24,'129.31',14),

(10416,'S18_2581',15,'70.96',4),

(10416,'S24_1785',47,'90.82',6),

(10416,'S24_2000',32,'62.46',1),

(10416,'S24_3949',18,'64.83',13),

(10416,'S24_4278',48,'70.28',5),

(10416,'S32_1374',45,'86.90',2),

(10416,'S32_4289',26,'68.10',7),

(10416,'S50_1341',37,'39.71',8),

(10416,'S700_1691',23,'88.60',9),

(10416,'S700_2466',22,'84.76',11),

(10416,'S700_2834',41,'98.48',3),

(10416,'S700_3167',39,'65.60',10),

(10416,'S700_4002',43,'63.67',12),

(10417,'S10_1678',66,'79.43',2),

(10417,'S10_2016',45,'116.56',5),

(10417,'S10_4698',56,'162.67',4),

(10417,'S12_2823',21,'144.60',1),

(10417,'S18_2625',36,'58.75',6),

(10417,'S24_1578',35,'109.32',3),

(10418,'S18_3278',16,'70.76',2),

(10418,'S18_3482',27,'139.64',1),

(10418,'S18_3782',33,'56.57',5),

(10418,'S18_4721',28,'120.53',4),

(10418,'S24_2360',52,'64.41',8),

(10418,'S24_4620',10,'66.29',3),

(10418,'S32_2206',43,'36.61',6),

(10418,'S32_4485',50,'100.01',9),

(10418,'S50_4713',40,'72.41',7),

(10419,'S12_1099',12,'182.90',13),

(10419,'S12_3380',10,'111.57',11),

(10419,'S12_3990',34,'64.64',14),

(10419,'S12_4675',32,'99.04',10),

(10419,'S18_1129',38,'117.48',5),

(10419,'S18_1589',37,'100.80',1),

(10419,'S18_1889',39,'67.76',9),

(10419,'S18_1984',34,'133.72',4),

(10419,'S18_2870',55,'116.16',2),

(10419,'S18_3232',35,'165.95',6),

(10419,'S18_3685',43,'114.44',3),

(10419,'S24_2972',15,'32.10',7),

(10419,'S24_3371',55,'52.66',12),

(10419,'S24_3856',70,'112.34',8),

(10420,'S18_1749',37,'153.00',5),

(10420,'S18_2248',36,'52.06',4),

(10420,'S18_2325',45,'116.96',2),

(10420,'S18_4409',66,'73.62',6),

(10420,'S18_4933',36,'68.42',7),

(10420,'S24_1046',60,'60.26',11),

(10420,'S24_1628',37,'48.80',13),

(10420,'S24_1937',45,'32.19',1),

(10420,'S24_2766',39,'76.33',9),

(10420,'S24_2887',55,'115.09',8),

(10420,'S24_3191',35,'77.05',10),

(10420,'S24_3432',26,'104.94',12),

(10420,'S24_3969',15,'35.29',3),

(10421,'S18_2795',35,'167.06',1),

(10421,'S24_2022',40,'44.80',2),

(10422,'S18_1342',51,'91.44',2),

(10422,'S18_1367',25,'47.44',1),

(10423,'S18_2949',10,'89.15',1),

(10423,'S18_2957',31,'56.21',3),

(10423,'S18_3136',21,'98.44',2),

(10423,'S18_3320',21,'80.36',5),

(10423,'S24_4258',28,'78.89',4),

(10424,'S10_1949',50,'201.44',6),

(10424,'S12_1666',49,'121.64',3),

(10424,'S18_1097',54,'108.50',5),

(10424,'S18_4668',26,'40.25',4),

(10424,'S32_3522',44,'54.94',2),

(10424,'S700_2824',46,'85.98',1),

(10425,'S10_4962',38,'131.49',12),

(10425,'S12_4473',33,'95.99',4),

(10425,'S18_2238',28,'147.36',3),

(10425,'S18_2319',38,'117.82',7),

(10425,'S18_2432',19,'48.62',10),

(10425,'S18_3232',28,'140.55',8),

(10425,'S18_4600',38,'107.76',13),

(10425,'S24_1444',55,'53.75',1),

(10425,'S24_2300',49,'127.79',9),

(10425,'S24_2840',31,'31.82',5),

(10425,'S32_1268',41,'83.79',11),

(10425,'S32_2509',11,'50.32',6),

(10425,'S50_1392',18,'94.92',2);







/*Datos tabla pagos */

insert  into `pagos`(`Cliente`,`codTransferencia`,`fechaPago`,`importe`) values 

('001','HQ336336','2021-10-19','6066.78'),

('001','JM555205','2020-06-05','14571.44'),

('001','OM314933','2021-12-18','1676.14'),

('002','BO864823','2021-12-17','14191.12'),

('002','HQ55022','2020-06-06','32641.98'),

('002','ND748579','2021-08-20','33347.88'),

('003','GG31455','2020-05-20','45864.03'),

('003','MA765515','2021-12-15','82261.22'),

('003','NP603840','2020-05-31','7565.08'),

('003','NR27552','2021-03-10','44894.74'),

('004','DB933704','2021-11-14','19501.82'),

('004','LN373447','2021-08-08','47924.19'),

('004','NG94694','2022-02-22','49523.67'),

('005','DB889831','2020-02-16','50218.95'),

('005','FD317790','2020-10-28','1491.38'),

('005','KI831359','2021-11-04','17876.32'),

('005','MA302151','2021-11-28','34638.14'),

('006','AE215433','2022-03-05','101244.59'),

('006','BG255406','2021-08-28','85410.87'),

('006','CQ287967','2020-04-11','11044.30'),

('006','ET64396','2022-04-16','83598.04'),

('006','HI366474','2021-12-27','47142.70'),

('006','HR86578','2021-11-02','55639.66'),

('006','KI131716','2020-08-15','111654.40'),

('006','LF217299','2021-03-26','43369.30'),

('006','NT141748','2020-11-25','45084.38'),

('007','DI925118','2020-01-28','10549.01'),

('007','FA465482','2020-10-18','24101.81'),

('007','FH668230','2021-03-24','33820.62'),

('007','IP383901','2021-11-18','7466.32'),

('007','DM826140','2021-12-08','26248.78'),

('007','ID449593','2020-12-11','23923.93'),

('007','PI42991','2020-04-09','16537.85'),

('008','CL442705','2020-03-12','22292.62'),

('008','MA724562','2021-12-02','50025.35'),

('008','NB445135','2021-09-11','35321.97'),

('008','AU364101','2020-07-19','36251.03'),

('008','DB583216','2021-11-01','36140.38'),

('008','DL460618','2022-05-19','46895.48'),

('008','HJ32686','2021-01-30','59830.55'),

('008','ID10962','2021-12-31','116208.40'),

('008','IN446258','2022-03-25','65071.26'),

('008','JE105477','2022-03-18','120166.58'),

('008','JN355280','2020-10-26','49539.37'),

('008','JN722010','2020-02-25','40206.20'),

('008','KT52578','2020-12-09','63843.55'),

('008','MC46946','2021-07-09','35420.74'),

('008','MF629602','2021-08-16','20009.53'),

('008','NU627706','2021-05-17','26155.91'),

('009','IR846303','2021-12-12','36005.71'),

('009','LA685678','2020-04-09','7674.94'),

('009','CN328545','2021-07-03','4710.73'),

('009','ED39322','2021-04-26','28211.70'),

('009','HR182688','2021-12-01','20564.86'),

('009','JJ246391','2020-02-20','53959.21'),

('010','FP549817','2021-03-18','40978.53'),

('010','FU793410','2021-01-16','49614.72'),

('010','LJ160635','2020-12-10','39712.10'),

('010','BI507030','2020-04-22','44380.15'),

('010','DD635282','2021-08-11','2611.84'),

('010','KM172879','2020-12-26','105743.00'),

('010','ME497970','2022-03-27','3516.04'),

('001','BF686658','2020-12-22','58793.53'),

('001','GB852215','2021-07-26','20314.44'),

('001','IP568906','2020-06-18','58841.35'),

('001','KI884577','2021-12-14','39964.63'),

('001','HI618861','2021-11-19','35152.12'),

('001','NN711988','2021-09-07','63357.13'),

('002','BR352384','2021-11-14','2434.25'),

('002','BR478494','2020-11-18','50743.65'),

('002','KG644125','2022-02-02','12692.19'),

('002','NI908214','2020-08-05','38675.13'),

('002','BQ327613','2021-09-16','38785.48'),

('002','DC979307','2021-07-07','44160.92'),

('002','LA318629','2021-02-28','22474.17'),

('003','ED743615','2021-09-19','12538.01'),

('003','GN228846','2020-12-03','85024.46'),

('004','GB878038','2021-03-15','18997.89'),

('004','IL104425','2020-11-22','42783.81'),

('004','AD832091','2021-09-09','1960.80'),

('004','CE51751','2021-12-04','51209.58'),

('004','EH208589','2020-04-20','33383.14'),

('005','GP545698','2021-05-13','11843.45'),

('005','IG462397','2021-03-29','20355.24'),

('005','CITI3434344','2022-05-19','28500.78'),

('005','IO448913','2020-11-19','24879.08'),

('005','PI15215','2021-07-10','42044.77'),

('006','AU750837','2021-04-17','15183.63'),

('006','CI381435','2021-01-19','47177.59'),

('007','CM564612','2021-04-25','22602.36'),

('007','GQ132144','2020-01-30','5494.78'),

('007','OH367219','2021-11-16','44400.50'),

('007','AE192287','2022-03-10','23602.90'),

('007','AK412714','2020-10-27','37602.48'),

('007','KA602407','2021-10-21','34341.08'),

('008','AM968797','2021-11-03','52825.29'),

('008','BQ39062','2021-12-08','47159.11'),

('008','KL124726','2020-03-27','48425.69'),

('008','BO711618','2021-10-03','17359.53'),

('008','NM916675','2021-03-01','32538.74'),

('009','FI192930','2021-12-06','9658.74'),

('009','HQ920205','2020-07-06','6036.96'),

('009','IS946883','2021-09-21','5858.56'),

('010','DP677013','2020-10-20','23908.24'),

('010','OO846801','2021-06-15','37258.94'),

('010','HI358554','2020-12-18','36527.61'),

('010','IQ627690','2021-11-08','33594.58'),

('001','GC697638','2021-08-13','51152.86'),

('001','IS150005','2021-09-24','4424.40'),

('002','GL756480','2020-12-04','3879.96'),

('002','LL562733','2020-09-05','50342.74'),

('002','NM739638','2022-02-06','39580.60'),

('003','BOAF82044','2022-05-03','35157.75'),

('003','ED520529','2021-06-21','4632.31'),

('003','PH785937','2021-05-04','36069.26'),

('004','BJ535230','2020-12-09','45480.79'),

('005','BG407567','2020-05-09','3101.40'),

('005','ML780814','2021-12-06','24945.21'),

('005','MM342086','2020-12-14','40473.86'),

('006','BN17870','2022-03-02','3452.75'),

('006','BR941480','2020-10-18','4465.85'),

('007','MQ413968','2020-10-31','36164.46'),

('007','NU21326','2021-11-02','53745.34'),

('008','BOFA23232','2022-05-20','29070.38'),

('008','II180006','2021-07-01','22997.45'),

('008','JG981190','2020-11-18','16909.84'),

('009','NQ865547','2021-03-15','80375.24'),

('010','IF245157','2021-11-16','46788.14'),

('010','JO719695','2021-03-28','24995.61'),

('001','AF40894','2020-11-22','33818.34'),

('001','HR224331','2022-06-03','12432.32'),

('001','KI744716','2020-07-21','14232.70'),

('002','IJ399820','2021-09-19','33924.24'),

('002','NE404084','2021-09-04','48298.99'),

('003','EQ12267','2022-05-17','17928.09'),

('003','HD284647','2021-12-30','26311.63'),

('003','HN114306','2020-07-18','23419.47'),

('007','EP227123','2021-02-10','5759.42'),

('007','HE84936','2021-10-22','53116.99'),

('008','EU280955','2021-11-06','61234.67'),

('008','GB361972','2020-12-07','27988.47'),

('009','IO164641','2021-08-30','37527.58'),

('009','NH776924','2021-04-24','29284.42'),

('010','EM979878','2022-02-09','27083.78'),

('010','KM841847','2020-11-13','38547.19'),

('010','LE432182','2020-09-28','41554.73'),

('010','OJ819725','2022-04-30','29848.52'),

('001','BJ483870','2021-12-05','37654.09'),

('001','GP636783','2020-03-02','52151.81'),

('001','NI983021','2020-11-24','37723.79'),

('002','IA793562','2020-08-03','24013.52'),

('002','JT819493','2021-08-02','35806.73'),

('002','OD327378','2022-01-03','31835.36'),

('006','DR578578','2021-10-28','47411.33'),

('006','KH910279','2021-09-05','43134.04'),

('007','AJ574927','2021-03-13','47375.92'),

('007','LF501133','2021-09-18','61402.00'),

('008','AD304085','2020-10-24','36798.88'),

('008','NR157385','2021-09-05','32260.16'),

('009','DG336041','2022-02-15','46770.52'),

('009','FA728475','2020-10-06','32723.04'),

('009','NQ966143','2021-04-25','16212.59'),

('009','LQ244073','2021-08-09','45352.47'),

('009','MD809704','2021-03-03','16901.38'),

('009','HL685576','2021-11-06','42339.76'),

('009','OM548174','2020-12-07','36092.40'),

('010','GJ597719','2022-01-18','8307.28'),

('010','HO576374','2020-08-20','41016.75'),

('010','MU817160','2020-11-24','52548.49'),

('010','DJ15149','2020-11-03','85559.12'),

('010','LA556321','2022-03-15','46781.66'),

('001','AL493079','2022-05-23','75020.13'),

('001','ES347491','2021-06-24','37281.36'),

('001','HG738664','2020-07-05','2880.00'),

('001','PQ803830','2021-12-24','39440.59'),

('001','DQ409197','2021-12-13','13671.82'),

('001','FP443161','2020-07-07','29429.14'),

('001','HB150714','2020-11-23','37455.77'),

('001','EN930356','2021-04-16','7178.66'),

('001','NR631421','2021-05-30','31102.85'),

('002','HL209210','2020-11-15','23936.53'),

('002','JK479662','2020-10-17','9821.32'),

('002','NF959653','2022-03-01','21432.31'),

('003','CS435306','2022-01-27','45785.34'),

('003','HH517378','2020-08-16','29716.86'),

('003','LF737277','2021-05-22','28394.54'),

('003','AP286625','2021-10-24','23333.06'),

('003','DA98827','2020-11-28','34606.28'),

('004','AF246722','2020-11-24','31428.21'),

('004','NJ906924','2021-04-02','15322.93'),

('004','DG700707','2021-01-18','21053.69'),

('004','LG808674','2020-10-24','20452.50'),

('005','BQ602907','2021-12-11','18888.31'),

('005','CI471510','2020-05-25','50824.66'),

('005','OB648482','2022-01-29','1834.56'),

('005','CO351193','2022-01-10','49705.52'),

('005','ED878227','2020-07-21','13920.26'),

('005','GT878649','2020-05-21','16700.47'),

('005','HJ618252','2022-06-09','46656.94'),

('005','AG240323','2020-12-16','20220.04'),

('005','NB291497','2021-05-15','36442.34'),

('006','FP170292','2021-07-11','18473.71'),

('006','OG208861','2021-09-21','15059.76'),

('006','HL575273','2021-11-17','50799.69'),

('006','IS232033','2020-01-16','10223.83'),

('006','PN238558','2020-12-05','55425.77'),

('007','CA762595','2022-02-12','28322.83'),

('007','FR499138','2020-09-16','32680.31'),

('007','GB890854','2021-08-02','12530.51'),

('008','BC726082','2021-12-03','12081.52'),

('008','CC475233','2020-04-19','1627.56'),

('008','GB117430','2022-02-03','14379.90'),

('008','MS154481','2020-08-22','1128.20'),

('008','CC871084','2020-05-12','35826.33'),

('008','CT821147','2021-08-01','6419.84'),

('008','PH29054','2021-11-27','42813.83'),

('008','BN347084','2020-12-02','20644.24'),

('008','CP804873','2021-11-19','15822.84'),

('008','EK785462','2020-03-09','51001.22'),

('008','DO106109','2020-11-18','38524.29'),

('008','HG438769','2021-07-18','51619.02'),

('009','AJ478695','2022-02-14','33967.73'),

('009','DO787644','2021-06-21','22037.91'),

('009','JPMR4544','2022-05-18','615.45'),

('009','KB54275','2021-11-29','48927.64'),

('001','BJMPR4545','2022-04-23','12190.85'),

('001','HJ217687','2021-01-28','49165.16'),

('001','NA197101','2021-06-17','25080.96');


