

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;


CREATE TABLE IF NOT EXISTS `mydb`.`Administrador` (
  `idAdministrador` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdministrador`))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `empresa` VARCHAR(45) NULL,
  `tarjeta Credito` VARCHAR(45) NOT NULL,
  `Administrador_idAdministrador` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `Administrador_idAdministrador`),
  INDEX `fk_Cliente_Administrador1_idx` (`Administrador_idAdministrador` ASC),
  CONSTRAINT `fk_Cliente_Administrador1`
    FOREIGN KEY (`Administrador_idAdministrador`)
    REFERENCES `mydb`.`Administrador` (`idAdministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `Cliente_idCliente`),
  INDEX `fk_Usuario_Cliente_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Usuario_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Modulo` (
  `idModulo` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Costo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idModulo`))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`venta` (
  `idventa` INT NOT NULL,
  `cliente` VARCHAR(45) NOT NULL,
  `vendedor` VARCHAR(45) NOT NULL,
  `importe` VARCHAR(45) NOT NULL,
  `fecha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idventa`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Factura` (
  `idFactura` INT NOT NULL,
  `fecha` VARCHAR(45) NOT NULL,
  `hora` VARCHAR(45) NOT NULL,
  `cliente` VARCHAR(45) NOT NULL,
  `vendedor` VARCHAR(45) NOT NULL,
  `venta_idventa` INT NOT NULL,
  PRIMARY KEY (`idFactura`, `venta_idventa`),
  INDEX `fk_Factura_venta1_idx` (`venta_idventa` ASC),
  CONSTRAINT `fk_Factura_venta1`
    FOREIGN KEY (`venta_idventa`)
    REFERENCES `mydb`.`venta` (`idventa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `idproducto` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Factura_idFactura` INT NOT NULL,
  PRIMARY KEY (`idproducto`, `Cliente_idCliente`, `Factura_idFactura`),
  INDEX `fk_producto_Cliente1_idx` (`Cliente_idCliente` ASC),
  INDEX `fk_producto_Factura1_idx` (`Factura_idFactura` ASC),
  CONSTRAINT `fk_producto_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_Factura1`
    FOREIGN KEY (`Factura_idFactura`)
    REFERENCES `mydb`.`Factura` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`materia prima` (
  `idmateria prima` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `producto_idproducto` INT NOT NULL,
  PRIMARY KEY (`idmateria prima`, `producto_idproducto`),
  INDEX `fk_materia prima_producto1_idx` (`producto_idproducto` ASC),
  CONSTRAINT `fk_materia prima_producto1`
    FOREIGN KEY (`producto_idproducto`)
    REFERENCES `mydb`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`Compra` (
  `idCompra` INT NOT NULL,
  PRIMARY KEY (`idCompra`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Entrevista` (
  `idEntrevista` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME(60) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idEntrevista`, `Cliente_idCliente`),
  INDEX `fk_Entrevista_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Entrevista_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`piloto` (
  `idpiloto` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpiloto`))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`Transporte` (
  `idTransporte` INT NOT NULL,
  `tipo transporte` VARCHAR(45) NOT NULL,
  `piloto_idpiloto` INT NOT NULL,
  PRIMARY KEY (`idTransporte`, `piloto_idpiloto`),
  INDEX `fk_Transporte_piloto1_idx` (`piloto_idpiloto` ASC),
  CONSTRAINT `fk_Transporte_piloto1`
    FOREIGN KEY (`piloto_idpiloto`)
    REFERENCES `mydb`.`piloto` (`idpiloto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Envio` (
  `idEnvio` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Transporte_idTransporte` INT NOT NULL,
  PRIMARY KEY (`idEnvio`, `Cliente_idCliente`, `Transporte_idTransporte`),
  INDEX `fk_Envio_Cliente1_idx` (`Cliente_idCliente` ASC),
  INDEX `fk_Envio_Transporte1_idx` (`Transporte_idTransporte` ASC),
  CONSTRAINT `fk_Envio_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Envio_Transporte1`
    FOREIGN KEY (`Transporte_idTransporte`)
    REFERENCES `mydb`.`Transporte` (`idTransporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Anuncio` (
  `idAnuncio` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fecha` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idAnuncio`, `Cliente_idCliente`),
  INDEX `fk_Anuncio_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Anuncio_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`Evento` (
  `idEvento` INT NOT NULL,
  `nombre_evento` VARCHAR(45) NOT NULL,
  `fecha` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idEvento`, `Cliente_idCliente`),
  INDEX `fk_Evento_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Evento_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`Modulo_has_Cliente` (
  `Modulo_idModulo` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`Modulo_idModulo`, `Cliente_idCliente`),
  INDEX `fk_Modulo_has_Cliente_Cliente1_idx` (`Cliente_idCliente` ASC),
  INDEX `fk_Modulo_has_Cliente_Modulo1_idx` (`Modulo_idModulo` ASC),
  CONSTRAINT `fk_Modulo_has_Cliente_Modulo1`
    FOREIGN KEY (`Modulo_idModulo`)
    REFERENCES `mydb`.`Modulo` (`idModulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Modulo_has_Cliente_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
