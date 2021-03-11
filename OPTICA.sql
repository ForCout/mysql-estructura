
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` TEXT NULL DEFAULT NULL,
  `telefono` VARCHAR(13) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `recomendado` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`));


-- -----------------------------------------------------
-- Table `optica`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleados` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `cargo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleado`));



-- -----------------------------------------------------
-- Table `optica`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`factura` (
  `id_factura` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `id_cliente` INT NOT NULL,
  `precio_total`FLOAT NOT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `fk_factura_cliente1_idx` (`id_cliente` ASC) ,
  CONSTRAINT `fk_factura_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `optica`.`cliente` (`id_cliente`));



-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `nif` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` TEXT NOT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `cod_postal` VARCHAR(9) NULL DEFAULT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(13) NOT NULL,
  `fax` VARCHAR(13) NULL DEFAULT NULL,
  PRIMARY KEY (`nif`));


-- -----------------------------------------------------
-- Table `optica`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `Marca` VARCHAR(45) NOT NULL,
  `grad_vidrio_derecho` FLOAT NULL DEFAULT NULL,
  `grad_vidrio_izquierdo` FLOAT NULL DEFAULT NULL,
  `montura` ENUM('metalica', 'pasta', 'flotante') NULL DEFAULT NULL,
  `color_montura` VARCHAR(45) NULL DEFAULT NULL,
  `color_vidrio` VARCHAR(45) NULL DEFAULT NULL,
  `precio` FLOAT NULL DEFAULT NULL,
  `proveedor_nif` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_producto`, `proveedor_nif`),
  INDEX `fk_producto_proveedor1_idx` (`proveedor_nif` ASC) ,
  CONSTRAINT `fk_producto_proveedor1`
    FOREIGN KEY (`proveedor_nif`)
    REFERENCES `optica`.`proveedor` (`nif`));



-- -----------------------------------------------------
-- Table `optica`.`detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`detalle` (
  `id_detalle` INT NOT NULL ,
  `id_factura` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio_total` FLOAT NOT NULL,
  `id_empleado` INT NOT NULL,
  PRIMARY KEY (`id_factura`,`id_detalle`),
  INDEX `fk_detalle_producto1_idx` (`id_producto` ASC) ,
  INDEX `fk_detalle_factura1_idx` (`id_factura` ASC) ,
  INDEX `fk_detalle_empleados1_idx` (`id_empleado` ASC) ,
  CONSTRAINT `fk_detalle_empleados1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `optica`.`empleados` (`id_empleado`),
  CONSTRAINT `fk_detalle_factura1`
    FOREIGN KEY (`id_factura`)
    REFERENCES `optica`.`factura` (`id_factura`),
  CONSTRAINT `fk_detalle_producto1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `optica`.`producto` (`id_producto`));

/*Clientes*/

INSERT INTO cliente (nombre,direccion,telefono,email,fecha_registro)VALUES ('Juan','Av/Diagonal 600','933456765','garcia@gmail.com','2021-01-12');
INSERT INTO cliente (nombre,direccion,telefono,email,fecha_registro)VALUES ('Antonio','Gran via 380','933456777','antonio@gmail.com','2021-01-15');
INSERT INTO cliente (nombre,direccion,telefono,email,fecha_registro)VALUES ('Pedro','Balmes 600','933456755','pedro@gmail.com','2021-01-21');
INSERT INTO cliente (nombre,direccion,telefono,email,fecha_registro,recomendado)VALUES ('Maria','Castillejos 600','933452211','maria@gmail.com','2021-02-12',1);

/*Empleados*/

INSERT INTO empleados (nombre,cargo) VALUES ('Rosa Garcia','comercial');
INSERT INTO empleados (nombre,cargo) VALUES ('Pedro Moreno','comercial');

/*Factura*/

INSERT INTO factura (fecha,id_cliente,precio_total) VALUES ('2021-01-12',1,547.72);
INSERT INTO factura (fecha,id_cliente,precio_total) VALUES ('2021-01-15',2,189.24);
INSERT INTO factura (fecha,id_cliente,precio_total) VALUES ('2021-01-21',3,189.24);
INSERT INTO factura (fecha,id_cliente,precio_total) VALUES ('2021-02-12',4,289.24);
INSERT INTO factura (fecha,id_cliente,precio_total) VALUES ('2021-02-04',1,179.24);
INSERT INTO factura (fecha,id_cliente,precio_total) VALUES ('2021-02-05',2,368.48);

/*Proveedor*/
INSERT INTO proveedor VALUES ('43526122','Optilux','av/Geranios 65 1º','Madrid','08032','España','91324344565','91324344565');
INSERT INTO proveedor VALUES ('43526888','visionlab','av/Tordera 65 1º','Barcelona','08012','España','91324344333','91324344333');
INSERT INTO proveedor VALUES ('43526999','Luxprix','av/Santa Isabel 6 1º','Zaragoza','08022','España','91324344888','91324344888');

/*Producto*/

INSERT INTO producto (marca,grad_vidrio_derecho,grad_vidrio_izquierdo,montura,color_montura,color_vidrio,precio,proveedor_nif) 
VALUES ('Rayban',1.2,0.5,'Pasta','Negro','Transparaente',189.24,'43526122');
INSERT INTO producto (marca,grad_vidrio_derecho,grad_vidrio_izquierdo,montura,color_montura,color_vidrio,precio,proveedor_nif) 
VALUES ('oakley',1,0.5,'Metalica','Dorado','Transparaente',179.24,'43526888');
INSERT INTO producto (marca,grad_vidrio_derecho,grad_vidrio_izquierdo,montura,color_montura,color_vidrio,precio,proveedor_nif) 
VALUES ('Chanel',0.2,0.5,'Flotante','Negro','Transparaente',289.24,'43526999');

/*Detalle*/

INSERT INTO detalle VALUES (1,1,1,1,189.24,1);
INSERT INTO detalle VALUES (2,1,2,2,358.48,1);
INSERT INTO detalle VALUES (1,2,1,1,189.24,2);
INSERT INTO detalle VALUES (1,3,1,1,189.24,1);
INSERT INTO detalle VALUES (1,4,2,1,179.24,2);
INSERT INTO detalle VALUES (1,5,2,1,179.24,1);
INSERT INTO detalle VALUES (1,6,1,1,189.24,1);
INSERT INTO detalle VALUES (2,6,2,1,179.24,1);

/*Querys utilizadas*/

/*Llista el total de factures d'un client en un període determinat*/
SELECT * FROM factura WHERE fecha BETWEEN '2021-01-01' AND '2021-03-01' AND id_cliente = 1;

/*Llista els diferents models d'ulleres que ha venut un empleat durant un any*/
SELECT id_producto FROM detalle d, factura f WHERE d.id_factura = f.id_factura 
and fecha >= date_sub(curdate(), interval 12 month) AND d.id_empleado = 2;

/*Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica*/
SELECT DISTINCT p.proveedor_nif FROM producto p, detalle d where p.id_producto = d.id_producto;





