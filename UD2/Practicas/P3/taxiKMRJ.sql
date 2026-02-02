DROP DATABASE IF EXISTS taxisKMRJ;
CREATE DATABASE IF NOT EXISTS taxisKMRJ;
USE taxisKMRJ;

CREATE TABLE IF NOT EXISTS cliente(
	nif CHAR(9),
    nombre VARCHAR(30),
    apellidos VARCHAR(50),
    fecha_nacimiento DATE,
    numero_telefono CHAR(12),
    puntuacion_social TINYINT,
    membresia BOOLEAN,
    CONSTRAINT pk_cliente PRIMARY KEY (nif)
);
CREATE TABLE IF NOT EXISTS personal(
	nuss CHAR(12),
    nombre VARCHAR(30),
    apellidos VARCHAR(50),
    fecha_nacimiento DATE,
    numero_telefono CHAR(12),
    nif CHAR(9),
    licencia VARCHAR(30),
    departamento VARCHAR(25),
    CONSTRAINT pk_personal PRIMARY KEY (nuss)
);
CREATE TABLE IF NOT EXISTS vehiculo(
	matricula CHAR(7),
    tiempo_servicio TIMESTAMP,
    carroceria VARCHAR(15),
    terreno_transitable VARCHAR(20),
    problemas_anteriores VARCHAR(80),
    CONSTRAINT pk_vehiculo PRIMARY KEY (matricula)
);
CREATE TABLE IF NOT EXISTS compania(
    id CHAR(9),
    nombre VARCHAR(40),
    telefono_contacto CHAR(12),
    localizacion VARCHAR(30),
    CONSTRAINT pk_compania PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS reserva(
	cod CHAR(9),
    fecha_viaje DATE,
    pasajeros_adicionales TINYINT,
    nif CHAR(9),
    CONSTRAINT pk_reserva PRIMARY KEY (cod),
    CONSTRAINT cliente_fk_reserva FOREIGN KEY (nif) REFERENCES cliente(nif)
);
CREATE TABLE IF NOT EXISTS nomina(
	id CHAR(5),
    dias_baja TINYINT,
    fecha_pago DATETIME,
    cantidad_euros SMALLINT,
    nuss CHAR(12),
    CONSTRAINT pk_nomina PRIMARY KEY (id),
    CONSTRAINT persona_fk_nomina FOREIGN KEY (nuss) REFERENCES personal(nuss)
);
CREATE TABLE IF NOT EXISTS viaje(
    id SMALLINT,
    lugar_salida VARCHAR(40),
    lugar_llegada VARCHAR(40),
    municipios VARCHAR(50),
    peajes BOOLEAN,
    cod CHAR(9),
    CONSTRAINT pk_viaje PRIMARY KEY (id),
    CONSTRAINT reserva_fk_viaje FOREIGN KEY (cod) REFERENCES reserva(cod)
);
CREATE TABLE IF NOT EXISTS transaccion(
    id MEDIUMINT,
    precio DECIMAL(5,2),
    tasa DECIMAL(3,2),
    personalizaciones VARCHAR(30),
    fecha_salida DATETIME,
    fecha_llegada DATETIME,
    duracion SMALLINT,
    id_viaje SMALLINT,
    CONSTRAINT pk_transaccion PRIMARY KEY (id),
    CONSTRAINT viaje_fk_transaccion FOREIGN KEY (id_viaje) REFERENCES viaje(id)
);
CREATE TABLE IF NOT EXISTS asginacion(
	id SMALLINT,
    fecha_asignacion DATE,
    fin_asignacion DATE,
    nuss CHAR(12),
    matricula CHAR(7),
    CONSTRAINT pk_asignacion PRIMARY KEY (id),
    CONSTRAINT vehiculo_fk_asignacion FOREIGN KEY (matricula) REFERENCES vehiculo(matricula),
    CONSTRAINT personal_fk_asignacion FOREIGN KEY (nuss) REFERENCES personal(nuss)
);
CREATE TABLE IF NOT EXISTS transito(
    n_veces_completadas MEDIUMINT,
    fecha DATE,
    id_viaje SMALLINT,
    nuss CHAR(12),
    CONSTRAINT pk_asignacion PRIMARY KEY (n_veces_completadas),
    CONSTRAINT viaje_fk_transito FOREIGN KEY (id_viaje) REFERENCES viaje(id),
    CONSTRAINT personal_fk_transito FOREIGN KEY (nuss) REFERENCES personal(nuss)
);
CREATE TABLE IF NOT EXISTS seguro (
    id SMALLINT,
    duracion TINYINT,
    fecha_contratacion DATETIME,
    fecha_caducidad DATETIME,
    precio DECIMAL(5,2),
    matricula CHAR(7),
    id_compania CHAR(9),
    CONSTRAINT pk_seguro PRIMARY KEY (id),
    CONSTRAINT vehiculo_fk_seguro FOREIGN KEY (matricula) REFERENCES vehiculo(matricula),
    CONSTRAINT compania_fk_seguro FOREIGN KEY (id_compania) REFERENCES compania(id)
);