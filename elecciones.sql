SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `elecciones` DEFAULT CHARACTER SET utf8 ;
USE `elecciones` ;

-- Tabla Ciudadanos
CREATE TABLE IF NOT EXISTS `elecciones`.`Ciudadanos` (
  `dni` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`dni`)
) ENGINE = InnoDB;

-- Tabla Partidos
CREATE TABLE IF NOT EXISTS `elecciones`.`Partidos` (
  `id_partido` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(256) NOT NULL,
  `logo` VARCHAR(45) NULL,
  `estado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_partido`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC)
) ENGINE = InnoDB;

-- Tabla Puestos
CREATE TABLE IF NOT EXISTS `elecciones`.`Puestos` (
  `id_puesto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(256) NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_puesto`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC)
) ENGINE = InnoDB;

-- Tabla Candidatos
CREATE TABLE IF NOT EXISTS `elecciones`.`Candidatos` (
  `id_candidato` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `id_partido` INT NOT NULL,
  `id_puesto` INT NOT NULL,
  `foto_perfil` VARCHAR(45) NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_candidato`),
  INDEX `fk_Candidatos_Partidos_idx` (`id_partido` ASC),
  INDEX `fk_Candidatos_Puestos1_idx` (`id_puesto` ASC),
  CONSTRAINT `fk_Candidatos_Partidos`
    FOREIGN KEY (`id_partido`)
    REFERENCES `elecciones`.`Partidos` (`id_partido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Candidatos_Puestos1`
    FOREIGN KEY (`id_puesto`)
    REFERENCES `elecciones`.`Puestos` (`id_puesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabla Elecciones
CREATE TABLE IF NOT EXISTS `elecciones`.`Elecciones` (
  `id_elecciones` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_elecciones`)
) ENGINE = InnoDB;

-- Tabla Conteo de Elecciones
CREATE TABLE IF NOT EXISTS `elecciones`.`Elecciones_Cont` (
  `id_elecciones` INT NOT NULL,
  `id_candidato` INT NOT NULL,
  `id_partido` INT NOT NULL,
  `id_puesto` INT NOT NULL,
  `dni` VARCHAR(20) NOT NULL,
  INDEX `fk_Elecciones_Cont_Elecciones1_idx` (`id_elecciones` ASC),
  INDEX `fk_Elecciones_Cont_Candidatos1_idx` (`id_candidato` ASC),
  INDEX `fk_Elecciones_Cont_Partidos1_idx` (`id_partido` ASC),
  INDEX `fk_Elecciones_Cont_Puestos1_idx` (`id_puesto` ASC),
  INDEX `fk_Elecciones_Cont_Ciudadanos1_idx` (`dni` ASC),
  PRIMARY KEY (`id_elecciones`, `dni`, `id_puesto`, `id_candidato`),
  CONSTRAINT `fk_Elecciones_Cont_Elecciones1`
    FOREIGN KEY (`id_elecciones`)
    REFERENCES `elecciones`.`Elecciones` (`id_elecciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Elecciones_Cont_Candidatos1`
    FOREIGN KEY (`id_candidato`)
    REFERENCES `elecciones`.`Candidatos` (`id_candidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Elecciones_Cont_Partidos1`
    FOREIGN KEY (`id_partido`)
    REFERENCES `elecciones`.`Partidos` (`id_partido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Elecciones_Cont_Puestos1`
    FOREIGN KEY (`id_puesto`)
    REFERENCES `elecciones`.`Puestos` (`id_puesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Elecciones_Cont_Ciudadanos1`
    FOREIGN KEY (`dni`)
    REFERENCES `elecciones`.`Ciudadanos` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabla Administracion
CREATE TABLE IF NOT EXISTS `elecciones`.`Administracion` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) NOT NULL,
  `clave` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_Administracion_Ciudadanos1_idx` (`dni` ASC),
  CONSTRAINT `fk_Administracion_Ciudadanos1`
    FOREIGN KEY (`dni`)
    REFERENCES `elecciones`.`Ciudadanos` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO ciudadanos(dni,nombre,apellido,email,estado) VALUES ('47171916','Matias','Orellana','meorellanaramirez@itel.edu.ar',1);
INSERT INTO administracion(usuario,clave,nombre,apellido,dni) VALUES ('Orellana','47171916','Matias','Orellana','47171916');
