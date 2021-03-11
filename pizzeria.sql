CREATE SCHEMA IF NOT EXISTS `Pizzeria`;
USE `Pizzeria` ;


CREATE TABLE IF NOT EXISTS `Pizzeria`.`Provincias` (
  `id_Provincias` SMALLINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Provincias`));



CREATE TABLE IF NOT EXISTS `Pizzeria`.`localidades` (
  `id_localidades` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `Provincias_id_Provincias` SMALLINT NOT NULL,
  PRIMARY KEY (`id_localidades`),
  INDEX `fk_localidades_Provincias_idx` (`Provincias_id_Provincias` ASC) ,
  CONSTRAINT `fk_localidades_Provincias`
    FOREIGN KEY (`Provincias_id_Provincias`)
    REFERENCES `Pizzeria`.`Provincias` (`id_Provincias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Pizzeria`.`clientes` (
  `id_clientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `direccion` TEXT NULL,
  `codigo_postal` VARCHAR(5) NULL,
  `localidades_id_localidades` INT NOT NULL,
  PRIMARY KEY (`id_clientes`),
  INDEX `fk_clientes_localidades1_idx` (`localidades_id_localidades` ASC),
  CONSTRAINT `fk_clientes_localidades1`
    FOREIGN KEY (`localidades_id_localidades`)
    REFERENCES `Pizzeria`.`localidades` (`id_localidades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Pizzeria`.`Tiendas` (
  `id_Tiendas` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(145) NULL,
  `cod_postal` VARCHAR(5) NULL,
  `localidades_id_localidades` INT NOT NULL,
  PRIMARY KEY (`id_Tiendas`),
  INDEX `fk_Tiendas_localidades1_idx` (`localidades_id_localidades` ASC),
  CONSTRAINT `fk_Tiendas_localidades1`
    FOREIGN KEY (`localidades_id_localidades`)
    REFERENCES `Pizzeria`.`localidades` (`id_localidades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Pizzeria`.`pedidos` (
  `id_pedidos` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `entrega` ENUM('local', 'domicilio') NULL,
  `clientes_id_clientes` INT NOT NULL,
  `Tiendas_id_Tiendas` INT NOT NULL,
  PRIMARY KEY (`id_pedidos`),
  INDEX `fk_pedidos_clientes1_idx` (`clientes_id_clientes` ASC),
  INDEX `fk_pedidos_Tiendas1_idx` (`Tiendas_id_Tiendas` ASC),
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_id_clientes`)
    REFERENCES `Pizzeria`.`clientes` (`id_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_Tiendas1`
    FOREIGN KEY (`Tiendas_id_Tiendas`)
    REFERENCES `Pizzeria`.`Tiendas` (`id_Tiendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleados` (
  `id_empleados` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `nif` VARCHAR(15) NULL,
  `telefono` VARCHAR(15) NULL,
  `cargo` ENUM('cocinero', 'repartidor') NULL,
  `Tiendas_id_Tiendas` INT NOT NULL,
  PRIMARY KEY (`id_empleados`),
  INDEX `fk_empleados_Tiendas1_idx` (`Tiendas_id_Tiendas` ASC),
  CONSTRAINT `fk_empleados_Tiendas1`
    FOREIGN KEY (`Tiendas_id_Tiendas`)
    REFERENCES `Pizzeria`.`Tiendas` (`id_Tiendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoria_pizza` (
  `id_categoria_pizza` SMALLINT NOT NULL,
  `categoria_pizza` VARCHAR(45) NULL,
  PRIMARY KEY (`id_categoria_pizza`));


CREATE TABLE IF NOT EXISTS `pizzeria`.`entregas` (
  `empleados_id_empleados` INT NOT NULL,
  `fecha/hora` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pedidos_id_pedidos` INT NOT NULL,
  PRIMARY KEY (`empleados_id_empleados`, `pedidos_id_pedidos`),
  INDEX `fk_entregas_pedidos1_idx` (`pedidos_id_pedidos` ASC) ,
  CONSTRAINT `fk_entregas_empleados1`
    FOREIGN KEY (`empleados_id_empleados`)
    REFERENCES `pizzeria`.`empleados` (`id_empleados`),
  CONSTRAINT `fk_entregas_pedidos1`
    FOREIGN KEY (`pedidos_id_pedidos`)
    REFERENCES `pizzeria`.`pedidos` (`id_pedidos`));


CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `id_productos` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `imagen` BLOB NULL DEFAULT NULL,
  `precio` FLOAT NULL DEFAULT NULL,
  `categoria` ENUM('hamburguesa', 'Bebida') NULL,
  PRIMARY KEY (`id_productos`));


CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pizzas` (
  `id_Pizzas` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `imagen` BLOB NULL,
  `precio` FLOAT NOT NULL,
  `categoria_pizza_id_categoria_pizza` SMALLINT NOT NULL,
  PRIMARY KEY (`id_Pizzas`),
  INDEX `fk_Pizzas_categoria_pizza1_idx` (`categoria_pizza_id_categoria_pizza` ASC),
  CONSTRAINT `fk_Pizzas_categoria_pizza1`
    FOREIGN KEY (`categoria_pizza_id_categoria_pizza`)
    REFERENCES `Pizzeria`.`categoria_pizza` (`id_categoria_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`detalle` (
  `pedidos_id_pedidos` INT NOT NULL,
  `id_detalle` SMALLINT NOT NULL,
  `cantidad` SMALLINT NULL DEFAULT NULL,
  `precio_total` FLOAT NULL DEFAULT NULL,
  `productos_id_productos` INT NULL DEFAULT NULL,
  `Pizzas_id_Pizzas` INT NULL DEFAULT NULL,
  PRIMARY KEY (`pedidos_id_pedidos`, `id_detalle`),
  INDEX `fk_detalle_pedidos1_idx` (`pedidos_id_pedidos` ASC) ,
  INDEX `fk_detalle_productos1_idx` (`productos_id_productos` ASC) ,
  INDEX `fk_detalle_Pizzas1_idx` (`Pizzas_id_Pizzas` ASC) ,
  CONSTRAINT `fk_detalle_pedidos1`
    FOREIGN KEY (`pedidos_id_pedidos`)
    REFERENCES `pizzeria`.`pedidos` (`id_pedidos`),
  CONSTRAINT `fk_detalle_Pizzas1`
    FOREIGN KEY (`Pizzas_id_Pizzas`)
    REFERENCES `pizzeria`.`pizzas` (`id_Pizzas`),
  CONSTRAINT `fk_detalle_productos1`
    FOREIGN KEY (`productos_id_productos`)
    REFERENCES `pizzeria`.`productos` (`id_productos`));
    
    INSERT INTO provincias (nombre) VALUES ('Barcelona');
	INSERT INTO provincias (nombre) VALUES ('Tarragona');
	INSERT INTO provincias (nombre) VALUES ('Lerida');
	INSERT INTO provincias (nombre) VALUES ('Gerona');
    
    INSERT INTO localidades (nombre,Provincias_id_Provincias) VALUES ('Barcelona',1);
	INSERT INTO localidades (nombre,Provincias_id_Provincias) VALUES ('Hospitalet',1);
	INSERT INTO localidades (nombre,Provincias_id_Provincias) VALUES ('Reus',2);  
    INSERT INTO localidades (nombre,Provincias_id_Provincias) VALUES ('Tarragona',2);
	INSERT INTO localidades (nombre,Provincias_id_Provincias) VALUES ('Lerida',3);
	INSERT INTO localidades (nombre,Provincias_id_Provincias) VALUES ('Cadaques',4);
    
    INSERT INTO clientes (nombre,apellidos,direccion,codigo_postal,localidades_id_localidades) VALUES ('Antonio','Garcia','Via julia','08016',1);
    INSERT INTO clientes (nombre,apellidos,direccion,codigo_postal,localidades_id_localidades) VALUES ('Pedro','Martinez','Diagonal','08032',2);
	INSERT INTO clientes (nombre,apellidos,direccion,codigo_postal,localidades_id_localidades) VALUES ('Maria','Rodriguez','Gran via','08021',3);
	INSERT INTO clientes (nombre,apellidos,direccion,codigo_postal,localidades_id_localidades) VALUES ('Dolores','Garcia','Constitucion','08231',4);
       
    INSERT INTO tiendas (direccion,cod_postal,localidades_id_localidades) VALUES ('Gran via',08016,1);
	INSERT INTO tiendas (direccion,cod_postal,localidades_id_localidades) VALUES ('constitucion',08032,2);
	INSERT INTO tiendas (direccion,cod_postal,localidades_id_localidades) VALUES ('diagonal',08021,3);
    
    INSERT INTO pedidos (entrega,clientes_id_clientes,Tiendas_id_Tiendas) VALUES ('domicilio',1,1);
	INSERT INTO pedidos (entrega,clientes_id_clientes,Tiendas_id_Tiendas) VALUES ('domicilio',2,1);
	INSERT INTO pedidos (entrega,clientes_id_clientes,Tiendas_id_Tiendas) VALUES ('domicilio',1,1);
	INSERT INTO pedidos (entrega,clientes_id_clientes,Tiendas_id_Tiendas) VALUES ('domicilio',3,2);
	INSERT INTO pedidos (entrega,clientes_id_clientes,Tiendas_id_Tiendas) VALUES ('domicilio',4,3);
	INSERT INTO pedidos (entrega,clientes_id_clientes,Tiendas_id_Tiendas) VALUES ('domicilio',2,1);
         
	INSERT INTO empleados(nombre,apellidos,nif,telefono,cargo,Tiendas_id_Tiendas) VALUES ('Antonio','Perez','43526786',654378652,'repartidor',1);
	INSERT INTO empleados(nombre,apellidos,nif,telefono,cargo,Tiendas_id_Tiendas) VALUES ('Pepe','Perez','43526787',654378652,'repartidor',2);
	INSERT INTO empleados(nombre,apellidos,nif,telefono,cargo,Tiendas_id_Tiendas) VALUES ('Manuel','Perez','43526788',654378652,'repartidor',3);
 
    INSERT INTO categoria_pizza VALUES (1,'MASA GRUESA');
	INSERT INTO categoria_pizza VALUES (2,'MASA FINA');
    
    INSERT INTO entregas (empleados_id_empleados,pedidos_id_pedidos) VALUES (1,1);
	INSERT INTO entregas (empleados_id_empleados,pedidos_id_pedidos) VALUES (1,2);
	INSERT INTO entregas (empleados_id_empleados,pedidos_id_pedidos) VALUES (1,3);
	INSERT INTO entregas (empleados_id_empleados,pedidos_id_pedidos) VALUES (2,4);
	INSERT INTO entregas (empleados_id_empleados,pedidos_id_pedidos) VALUES (2,5);
    INSERT INTO entregas (empleados_id_empleados,pedidos_id_pedidos) VALUES (3,6);

    INSERT INTO productos (id_productos,nombre,descripcion,precio,categoria) VALUES (1,'Fanta','Bebida azucarada',1.20,'Bebida');
    INSERT INTO productos (id_productos,nombre,descripcion,precio,categoria) VALUES (2,'Coca cola','Bebida azucarada',1.20,'Bebida');
    INSERT INTO productos (id_productos,nombre,descripcion,precio,categoria) VALUES (3,'BurguerChess','Hambutguesa queso',5.20,'Hamburguesa');
    INSERT INTO productos (id_productos,nombre,descripcion,precio,categoria) VALUES (4,'BurguerChicken','Hamburguesa Pollo',6.20,'Hamburguesa');
    
    INSERT INTO pizzas (nombre,descripcion,precio,categoria_pizza_id_categoria_pizza) VALUES ('4 QUESOS','4 quesos',9.90,1);
    INSERT INTO pizzas (nombre,descripcion,precio,categoria_pizza_id_categoria_pizza) VALUES ('4 estaciones','4 estaciones',9.90,1);
    INSERT INTO pizzas (nombre,descripcion,precio,categoria_pizza_id_categoria_pizza) VALUES ('calzone','enrrollada',9.90,2);
    INSERT INTO pizzas (nombre,descripcion,precio,categoria_pizza_id_categoria_pizza) VALUES ('Barbacoa','picante',9.90,2);
    
    INSERT INTO detalle (pedidos_id_pedidos,id_detalle,cantidad,precio_total,productos_id_productos) VALUES (1,1,2,2.40,1);
	INSERT INTO detalle (pedidos_id_pedidos,id_detalle,cantidad,precio_total,productos_id_productos) VALUES (2,1,1,1.2,1);
	INSERT INTO detalle (pedidos_id_pedidos,id_detalle,cantidad,precio_total,productos_id_productos) VALUES (3,1,2,2.40,1);
	INSERT INTO detalle (pedidos_id_pedidos,id_detalle,cantidad,precio_total,productos_id_productos) VALUES (4,1,2,2.40,2);
	INSERT INTO detalle (pedidos_id_pedidos,id_detalle,cantidad,precio_total,productos_id_productos) VALUES (5,1,2,2.40,2);
	INSERT INTO detalle (pedidos_id_pedidos,id_detalle,cantidad,precio_total,productos_id_productos) VALUES (6,1,2,2.40,1);
    INSERT INTO detalle (pedidos_id_pedidos,id_detalle,cantidad,precio_total,Pizzas_id_Pizzas) VALUES (1,2,2,19.8,1);
    
    /* Querys utilizadas*/
   /* Llista quants productes de categoria 'Begudas' s'han venut en una determinada localitat*/
   
   SELECT pr.nombre,d.cantidad,t.id_tiendas FROM detalle d,productos pr,pedidos p,tiendas t WHERE categoria ='Bebida' and id_productos = productos_id_productos
   and pedidos_id_pedidos = id_pedidos and id_Tiendas = Tiendas_id_Tiendas and localidades_id_localidades=1;
   
	/* Llista quantes comandes ha efectuat un determinat empleat */
    SELECT * FROM entregas WHERE empleados_id_empleados = 1;
    