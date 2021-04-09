
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;

USE `youtube` ;


CREATE TABLE IF NOT EXISTS `youtube`.`usuarios` (
  `id_usuarios` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` ENUM('masculino', 'femenino') NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuarios`));



CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `titulo` INT NOT NULL,
  `usuarios_id_usuarios` INT NOT NULL,
  `idvideos` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `tamaño` FLOAT NOT NULL,
  `nombre_video` VARCHAR(45) NOT NULL,
  `duracion` TIME NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `numero_reproducciones` INT NOT NULL,
  `estado` ENUM('publico', 'oculto', 'privado') NOT NULL,
  `hora_fecha_publicacion` TIMESTAMP NULL,
  PRIMARY KEY (`titulo`),
  INDEX `fk_videos_usuarios_idx` (`usuarios_id_usuarios` ASC),
  CONSTRAINT `fk_videos_usuarios`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES`youtube` .`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `youtube`.`etiquetas` (
  `id_etiquetas` INT NOT NULL AUTO_INCREMENT,
  `nombre_etiqueta` VARCHAR(45) NOT NULL,
  `videos_titulo` INT NOT NULL,
  PRIMARY KEY (`id_etiquetas`),
  INDEX `fk_etiquetas_videos1_idx` (`videos_titulo` ASC) ,
  CONSTRAINT `fk_etiquetas_videos1`
    FOREIGN KEY (`videos_titulo`)
    REFERENCES `youtube`.`videos` (`titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `youtube`.`canal` (
  `id_canal` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `usuarios_id_usuarios` INT NOT NULL,
  `videos_titulo` INT NOT NULL,
  PRIMARY KEY (`id_canal`),
  INDEX `fk_canal_usuarios1_idx` (`usuarios_id_usuarios` ASC),
  INDEX `fk_canal_videos1_idx` (`videos_titulo` ASC),
  CONSTRAINT `fk_canal_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `youtube`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canal_videos1`
    FOREIGN KEY (`videos_titulo`)
    REFERENCES `youtube`.`videos` (`titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `id_playlist` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `estado` ENUM('publico', 'privado') NOT NULL,
  `usuarios_id_usuarios` INT NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `fk_playlist_usuarios1_idx` (`usuarios_id_usuarios` ASC) ,
  CONSTRAINT `fk_playlist_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `youtube`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS`youtube` .`likes` (
  `usuarios_id_usuarios` INT NOT NULL,
  `videos_titulo` INT NOT NULL,
  `fecha_hora` TIMESTAMP NOT NULL,
  PRIMARY KEY (`usuarios_id_usuarios`, `videos_titulo`),
  INDEX `fk_likes_videos1_idx` (`videos_titulo` ASC) ,
  CONSTRAINT `fk_likes_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `youtube`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_likes_videos1`
    FOREIGN KEY (`videos_titulo`)
    REFERENCES`youtube` .`videos` (`titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS`youtube` .`dislikes` (
  `usuarios_id_usuarios` INT NOT NULL,
  `videos_titulo` INT NOT NULL,
  `fecha_hora` TIMESTAMP NOT NULL,
  PRIMARY KEY (`usuarios_id_usuarios`, `videos_titulo`),
  INDEX `fk_dislikes_videos1_idx` (`videos_titulo` ASC) ,
  CONSTRAINT `fk_dislikes_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `youtube`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dislikes_videos1`
    FOREIGN KEY (`videos_titulo`)
    REFERENCES `youtube`.`videos` (`titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `youtube`.`comentarios` (
  `id_comentarios` INT NOT NULL AUTO_INCREMENT,
  `texto_comentario` TEXT NOT NULL,
  `fecha_hora` TIMESTAMP NULL,
  `videos_titulo` INT NOT NULL,
  `usuarios_id_usuarios` INT NOT NULL,
  PRIMARY KEY (`id_comentarios`),
  INDEX `fk_comentarios_usuarios1_idx` (`usuarios_id_usuarios` ASC) ,
  INDEX `fk_comentarios_videos1_idx` (`videos_titulo` ASC),
  CONSTRAINT `fk_comentarios_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `youtube`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentarios_videos1`
    FOREIGN KEY (`videos_titulo`)
    REFERENCES `youtube`.`videos` (`titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `youtube`.`megusta/nomegusta` (
  `fecha/hora` TIMESTAMP NOT NULL,
  `decision` ENUM('me gusta', 'no me gusta') NOT NULL,
  `comentarios_id_comentarios` INT NOT NULL,
  `usuarios_id_usuarios` INT NOT NULL,
  INDEX `fk_megusta/nomegusta_usuarios1_idx` (`usuarios_id_usuarios` ASC) ,
  INDEX `fk_megusta/nomegusta_comentarios1_idx` (`comentarios_id_comentarios` ASC) ,
  PRIMARY KEY (`comentarios_id_comentarios`, `usuarios_id_usuarios`),
  CONSTRAINT `fk_megusta/nomegusta_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `youtube`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_megusta/nomegusta_comentarios1`
    FOREIGN KEY (`comentarios_id_comentarios`)
    REFERENCES `youtube`.`comentarios` (`id_comentarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `youtube`.`sucripciones` (
  `usuarios_id_usuarios` INT NOT NULL,
  `canal_id_canal` INT NOT NULL,
  PRIMARY KEY (`usuarios_id_usuarios`, `canal_id_canal`),
  INDEX `fk_canal_has_usuarios_usuarios1_idx` (`usuarios_id_usuarios` ASC) ,
  INDEX `fk_canal_has_usuarios_canal1_idx` (`canal_id_canal` ASC) ,
  CONSTRAINT `fk_canal_has_usuarios_canal1`
    FOREIGN KEY (`canal_id_canal`)
    REFERENCES `youtube`.`canal` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canal_has_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `youtube`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


