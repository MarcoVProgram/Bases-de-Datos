DROP DATABASE IF EXISTS StreamingService;
CREATE DATABASE IF NOT EXISTS StreamingService;
USE StreamingService;
CREATE TABLE IF NOT EXISTS cliente(
	id_usuario CHAR(30),
	nombre VARCHAR(25) NOT NULL,
	primer_apellido VARCHAR(20) NOT NULL,
	segundo_apellido VARCHAR(20),
	membresia BOOLEAN NOT NULL,
	correo_electronico VARCHAR(76) NOT NULL,
	CONSTRAINT id_usuario PRIMARY KEY (id_usuario)
);
CREATE TABLE IF NOT EXISTS serie(
	cod_serie CHAR(5),
	nombre VARCHAR(30) NOT NULL,
    genero VARCHAR(20) NOT NULL,
    temporadas TINYINT,
    n_espisodios_totales SMALLINT,
    CONSTRAINT cod_serie PRIMARY KEY (cod_serie)
);
CREATE TABLE IF NOT EXISTS productor(
	id_productor CHAR(6),
	nombre VARCHAR(30) NOT NULL,
	telefono_contacto CHAR(12) NOT NULL,
	localizacion VARCHAR(6) NOT NULL,
    correo_electronico VARCHAR(76) NOT NULL,
	CONSTRAINT id_productor PRIMARY KEY (id_productor)
);
CREATE TABLE IF NOT EXISTS episodio(
	id_episodio SMALLINT,
	titulo VARCHAR(50) NOT NULL,
	duracion TIME NOT NULL,
	idioma VARCHAR(20) NOT NULL,
    fecha_estreno DATE NOT NULL,
    n_visualizaciones INT,
    cod_serie CHAR(5),
	CONSTRAINT id_episodio PRIMARY KEY (id_episodio),
    CONSTRAINT cod_serie FOREIGN KEY (cod_serie) REFERENCES serie (cod_serie)
);
CREATE TABLE IF NOT EXISTS visualizacion(
	n_veces_vistas TINYINT,
	vista BOOLEAN,
	tiempo_visualizado TIMESTAMP,
	fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME,
    id_usuario CHAR(30),
    id_episodio SMALLINT,
	CONSTRAINT PK_visualizacion PRIMARY KEY (n_veces_vistas),
    CONSTRAINT id_usuario FOREIGN KEY (id_usuario) REFERENCES cliente (id_usuario),
    CONSTRAINT id_episodio FOREIGN KEY (id_episodio) REFERENCES episodio (id_episodio)
);
CREATE TABLE IF NOT EXISTS contrato(
	id_contrato CHAR(4),
	fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME,
    n_total_visualizaciones INT,
    tasa_mil_visualizaciones DECIMAL(3,2),
    cod_serie CHAR(5),
    id_productor CHAR(6),
	CONSTRAINT PK_contrato PRIMARY KEY (id_contrato),
    CONSTRAINT serie_codigo FOREIGN KEY (cod_serie) REFERENCES serie (cod_serie),
    CONSTRAINT id_productor FOREIGN KEY (id_productor) REFERENCES productor (id_productor)
);