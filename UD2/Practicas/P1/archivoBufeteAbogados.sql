DROP DATABASE IF EXISTS BufeteAbogados;
CREATE DATABASE IF NOT EXISTS BufeteAbogados;
USE BufeteAbogados;
CREATE TABLE IF NOT EXISTS cliente(
	dni CHAR(9),
	nombre VARCHAR(20) NOT NULL,
	primer_apellido VARCHAR(20) NOT NULL,
	segundo_apellido VARCHAR(20),
	numero_de_telefono CHAR(12) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	correo_electronico VARCHAR(76) NOT NULL,
	codigo_postal VARCHAR(6) NOT NULL,
	CONSTRAINT dni PRIMARY KEY (dni)
);
CREATE TABLE IF NOT EXISTS expendiente(
	ndau CHAR(5),
	dni CHAR(9) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE,
	CONSTRAINT ndau PRIMARY KEY (ndau),
	CONSTRAINT dni FOREIGN KEY (dni) REFERENCES cliente (dni)
);
CREATE TABLE IF NOT EXISTS estado(
	id_estado CHAR(7),
	ndau CHAR(5) NOT NULL,
	tipo VARCHAR(15),
	fecha_comienzo DATE,
	CONSTRAINT estado_pk PRIMARY KEY (id_estado),
	CONSTRAINT ndau FOREIGN KEY (ndau) REFERENCES expendiente (ndau)
);