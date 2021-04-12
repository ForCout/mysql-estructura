CREATE SCHEMA IF NOT EXISTS `spotify`;
USE `spotify` ;


CREATE TABLE IF NOT EXISTS `spotify`.`tipos_de_musica` (
  `idtipos_de_musica` INT NOT NULL AUTO_INCREMENT,
  `genero_musical` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipos_de_musica`));



CREATE TABLE IF NOT EXISTS `spotify`.`artista` (
  `id_artista` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `imagen` BLOB  NULL,
  `tipos_de_musica_idtipos_de_musica` INT NOT NULL,
  PRIMARY KEY (`id_artista`),
  INDEX `fk_artista_tipos_de_musica1_idx` (`tipos_de_musica_idtipos_de_musica` ASC) ,
  CONSTRAINT `fk_artista_tipos_de_musica1`
    FOREIGN KEY (`tipos_de_musica_idtipos_de_musica`)
    REFERENCES `spotify`.`tipos_de_musica` (`idtipos_de_musica`));


CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `id_album` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(95) NOT NULL,
  `año_publicacion` YEAR NOT NULL,
  `portada` BLOB  NULL,
  `artista_id_artista` INT NOT NULL,
  PRIMARY KEY (`id_album`),
  INDEX `fk_album_artista1_idx` (`artista_id_artista` ASC) ,
  CONSTRAINT `fk_album_artista1`
    FOREIGN KEY (`artista_id_artista`)
    REFERENCES `spotify`.`artista` (`id_artista`));


CREATE TABLE IF NOT EXISTS `spotify`.`cancion` (
  `id_cancion` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `duracion` TIME NOT NULL,
  `reproducciones` INT NOT NULL,
  `album_id_album` INT NOT NULL,
  PRIMARY KEY (`id_cancion`),
  INDEX `fk_cancion_album1_idx` (`album_id_album` ASC) ,
  CONSTRAINT `fk_cancion_album1`
    FOREIGN KEY (`album_id_album`)
    REFERENCES `spotify`.`album` (`id_album`));


CREATE TABLE IF NOT EXISTS `spotify`.`usuarios` (
  `id_usuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre`VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` ENUM('masculino', 'femenino') NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `tipo_usuario` ENUM('free', 'premiun') NOT NULL,
  PRIMARY KEY (`id_usuarios`));


CREATE TABLE IF NOT EXISTS `spotify`.`suscripcion` (
  `usuarios_id_usuarios` INT NOT NULL,
  `fecha_suscripcion` DATE NOT NULL,
  `fecha_renovacion` DATE NOT NULL,
  `modalidad_pago` ENUM('tarjeta', 'paypal') NOT NULL,
  PRIMARY KEY (`usuarios_id_usuarios`),
  CONSTRAINT `fk_suscripcion_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `spotify`.`usuarios` (`id_usuarios`));


CREATE TABLE IF NOT EXISTS `spotify`.`pagos` (
  `numero_orden` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `total` FLOAT NOT NULL,
  `suscripcion_usuarios_id_usuarios` INT NOT NULL,
  PRIMARY KEY (`numero_orden`),
  INDEX `fk_pagos_suscripcion1_idx` (`suscripcion_usuarios_id_usuarios` ASC) ,
  CONSTRAINT `fk_pagos_suscripcion1`
    FOREIGN KEY (`suscripcion_usuarios_id_usuarios`)
    REFERENCES `spotify`.`suscripcion` (`usuarios_id_usuarios`));


CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `suscripcion_usuarios_id_usuarios` INT NOT NULL,
  PRIMARY KEY (`nombre_usuario`),
  INDEX `fk_paypal_suscripcion1_idx` (`suscripcion_usuarios_id_usuarios` ASC),
  CONSTRAINT `fk_paypal_suscripcion1`
    FOREIGN KEY (`suscripcion_usuarios_id_usuarios`)
    REFERENCES `spotify`.`suscripcion` (`usuarios_id_usuarios`));


CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `id_playlist` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id_usuarios` INT NOT NULL,
  `titulo` VARCHAR(95) NOT NULL,
  `numero_canciones` INT NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `estado` ENUM('activa', 'eliminada') NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `fk_playlist_usuarios2_idx` (`usuarios_id_usuarios` ASC) ,
  CONSTRAINT `fk_playlist_usuarios2`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `spotify`.`usuarios` (`id_usuarios`));


CREATE TABLE IF NOT EXISTS `spotify`.`playlist_compartidas` (
  `playlist_id_playlist` INT NOT NULL,
  `cancion_id_cancion` INT NOT NULL,
  `usuarios_id_usuarios` INT NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`playlist_id_playlist`, `cancion_id_cancion`),
  INDEX `fk_usuarios_has_playlist_playlist1_idx` (`playlist_id_playlist` ASC) ,
  INDEX `fk_usuarios_has_playlist_usuarios1_idx` (`usuarios_id_usuarios` ASC) ,
  INDEX `fk_playlist compartidas_cancion1_idx` (`cancion_id_cancion` ASC),
  CONSTRAINT `fk_playlist compartidas_cancion1`
    FOREIGN KEY (`cancion_id_cancion`)
    REFERENCES `spotify`.`cancion` (`id_cancion`),
  CONSTRAINT `fk_usuarios_has_playlist_playlist1`
    FOREIGN KEY (`playlist_id_playlist`)
    REFERENCES `spotify`.`playlist` (`id_playlist`),
  CONSTRAINT `fk_usuarios_has_playlist_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `spotify`.`usuarios` (`id_usuarios`));


CREATE TABLE IF NOT EXISTS `spotify`.`playlist_eliminadas` (
  `fecha_eliminada` DATE NOT NULL,
  `playlist_id_playlist` INT NOT NULL,
  INDEX `fk_Playlist_eliminadas_playlist1_idx` (`playlist_id_playlist` ASC) ,
  PRIMARY KEY (`playlist_id_playlist`),
  CONSTRAINT `fk_Playlist eliminadas_playlist1`
    FOREIGN KEY (`playlist_id_playlist`)
    REFERENCES `spotify`.`playlist` (`id_playlist`));


CREATE TABLE IF NOT EXISTS `spotify`.`tarjetas_credito` (
  `numero_tarjeta` VARCHAR(45) NOT NULL,
  `mes/año_caducidad` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cvs` SMALLINT NOT NULL,
  `suscripcion_usuarios_id_usuarios` INT NOT NULL,
  PRIMARY KEY (`numero_tarjeta`),
  INDEX `fk_tarjetas_credito_suscripcion1_idx` (`suscripcion_usuarios_id_usuarios` ASC) ,
  CONSTRAINT `fk_tarjetas_credito_suscripcion1`
    FOREIGN KEY (`suscripcion_usuarios_id_usuarios`)
    REFERENCES `spotify`.`suscripcion` (`usuarios_id_usuarios`));


CREATE TABLE IF NOT EXISTS `spotify`.`usuarios_has_album` (
  `usuarios_id_usuarios` INT NOT NULL,
  `album_id_album` INT NOT NULL,
  PRIMARY KEY (`usuarios_id_usuarios`, `album_id_album`),
  INDEX `fk_usuarios_has_album_album1_idx` (`album_id_album` ASC) ,
  INDEX `fk_usuarios_has_album_usuarios1_idx` (`usuarios_id_usuarios` ASC) ,
  CONSTRAINT `fk_usuarios_has_album_album1`
    FOREIGN KEY (`album_id_album`)
    REFERENCES `spotify`.`album` (`id_album`),
  CONSTRAINT `fk_usuarios_has_album_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `spotify`.`usuarios` (`id_usuarios`));


CREATE TABLE IF NOT EXISTS `spotify`.`usuarios_has_artista` (
  `usuarios_id_usuarios` INT NOT NULL,
  `artista_id_artista` INT NOT NULL,
  PRIMARY KEY (`usuarios_id_usuarios`, `artista_id_artista`),
  INDEX `fk_usuarios_has_artista_artista1_idx` (`artista_id_artista` ASC) ,
  INDEX `fk_usuarios_has_artista_usuarios1_idx` (`usuarios_id_usuarios` ASC) ,
  CONSTRAINT `fk_usuarios_has_artista_artista1`
    FOREIGN KEY (`artista_id_artista`)
    REFERENCES `spotify`.`artista` (`id_artista`),
  CONSTRAINT `fk_usuarios_has_artista_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `spotify`.`usuarios` (`id_usuarios`));


CREATE TABLE IF NOT EXISTS `spotify`.`usuarios_has_cancion` (
  `usuarios_id_usuarios` INT NOT NULL,
  `cancion_id_cancion` INT NOT NULL,
  PRIMARY KEY (`usuarios_id_usuarios`, `cancion_id_cancion`),
  INDEX `fk_usuarios_has_cancion_cancion1_idx` (`cancion_id_cancion` ASC) ,
  INDEX `fk_usuarios_has_cancion_usuarios1_idx` (`usuarios_id_usuarios` ASC) ,
  CONSTRAINT `fk_usuarios_has_cancion_cancion1`
    FOREIGN KEY (`cancion_id_cancion`)
    REFERENCES `spotify`.`cancion` (`id_cancion`),
  CONSTRAINT `fk_usuarios_has_cancion_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `spotify`.`usuarios` (`id_usuarios`));
    
    
INSERT INTO tipos_de_musica (genero_musical) VALUES ('JAZZ');
INSERT INTO artista (nombre,tipos_de_musica_idtipos_de_musica) VALUES ('Chuck Berry',1);
INSERT INTO album ( titulo,año_publicacion,artista_id_artista) VALUES ('Time Out','1952',1);
INSERT INTO cancion ( titulo,duracion,reproducciones,album_id_album) VALUES ('Hell','00:03:52',150000,1);
INSERT INTO cancion ( titulo,duracion,reproducciones,album_id_album) VALUES ('Monn','00:03:52',150022,1);
INSERT INTO usuarios (nombre,email,password,fecha_nacimiento,sexo,pais,codigo_postal,tipo_usuario) VALUES ('Antonio','garcia@gmail.com','13232','1965-12-23','masculino','españa','08016','premiun');
INSERT INTO suscripcion VALUES (1,'2011-12-23','2012-12-23','tarjeta');
INSERT INTO pagos VALUES (1,'2012-12-23',32.5,1);
INSERT INTO paypal VALUES ('ANTONIO',1);
INSERT INTO playlist VALUES (1,1,'Jazz Forever',123,'2011-11-11','eliminada');
INSERT INTO playlist_compartidas VALUES (1,1,1,'2011-11-12');
INSERT INTO playlist_compartidas VALUES (1,2,1,'2011-11-12');
INSERT INTO playlist_eliminadas VALUES ('2012-01-23',1);
INSERT INTO tarjetas_credito VALUES ('848895958589','22-09-01',345,1);
INSERT INTO usuarios_has_album VALUES (1,1);
INSERT INTO usuarios_has_artista VALUES (1,1);
INSERT INTO usuarios_has_cancion VALUES (1,1);
