CREATE DATABASE sakilacampus;

USE sakilacampus;


CREATE TABLE IF NOT EXISTS sakilacampus.idioma(
	id_idioma tinyint unsigned PRIMARY KEY,
	nombre char(20),
	ultima_actualizacion TIMESTAMP
);

CREATE TABLE sakilacampus.pelicula(
	id_pelicula smallint unsigned PRIMARY KEY,
	titutlo VARCHAR(255),
	descripcion text, 
	anyo_lanzamiento year,
	id_idioma tinyint unsigned,
	id_idioma_original tinyint unsigned,
	duracion_alquiler tinyint unsigned,
	rental_rate decimal(4,2),
	duracion INT,
	remplacement_cost DECIMAL(5, 2),
	clasificacion enum("G", "PG","PG-13","R","NC-17"),
	caracteristicas_especiales set("Trainers", "Commentaries", "Deleted Secenes", "Behind the Scenes"),
	ultima_actualizacion TIMESTAMP,
	FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma),
	FOREIGN KEY (id_idioma_original) REFERENCES sakilacampus.idioma(id_idioma)
	
);

CREATE TABLE sakilacampus.film_text(
	film_id smallint PRIMARY KEY,
	title VARCHAR(255),
	description text 
);

CREATE TABLE sakilacampus.categoria(
	id_categoria INT PRIMARY KEY,
	nombre VARCHAR(25),
	ultima_actualizacion timestamp
);

CREATE TABLE sakilacampus.actor(
	id_actor smallint unsigned PRIMARY KEY,
	nombre VARCHAR(45),
	apellidos VARCHAR(45),
	ultima_actualizacion timestamp
);

CREATE TABLE sakilacampus.pelicula_actor(
	id_actor smallint unsigned PRIMARY KEY,
	id_pelicula smallint unsigned,
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_pelicula) REFERENCES sakilacampus.pelicula(id_pelicula)
);

CREATE TABLE sakilacampus.pelicula_categoria(
	id_pelicula smallint unsigned PRIMARY KEY,
	id_categoria tinyint unsigned,
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_pelicula) REFERENCES sakilacampus.pelicula(id_pelicula)
);

CREATE TABLE sakilacampus.pais(
	id_pais smallint unsigned PRIMARY KEY,
	nombre VARCHAR(50),
	ultima_actualizacion timestamp
);

CREATE TABLE sakilacampus.ciudad(
	id_ciudad smallint unsigned PRIMARY KEY,
	nombre VARCHAR(50),
	id_pais smallint unsigned,
	FOREIGN KEY (id_pais) REFERENCES sakilacampus.pais(id_pais)	
);

CREATE TABLE sakilacampus.direccion(
	id_direccion smallint unsigned PRIMARY KEY,
	direccion VARCHAR(50),
	direccion2 VARCHAR(50),
	distrito VARCHAR(20),
	id_ciudad smallint unsigned,
	codigo_postal VARCHAR(10),
	telefono VARCHAR(20),
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_ciudad) REFERENCES sakilacampus.ciudad(id_ciudad)
);

CREATE TABLE sakilacampus.empleado(
	id_empleado tinyint unsigned PRIMARY KEY,
	nombre VARCHAR(45),
	apellidos VARCHAR(45),
	id_direccion smallint unsigned,
	imagen BLOB,
	email VARCHAR(50),
	activo tinyint(1),
	username VARCHAR(16),
	pasword VARCHAR(40),
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_direccion) REFERENCES sakilacampus.direccion(id_direccion)
);

CREATE TABLE sakilacampus.almacen(
	id_almacen tinyint unsigned PRIMARY KEY,
	id_empleado_jefe tinyint unsigned,
	id_direccion smallint unsigned,
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_empleado_jefe) REFERENCES empleado(id_empleado),
	FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE sakilacampus.inventario(
	id_inventario mediumint unsigned PRIMARY KEY,
	id_pelicula smallint unsigned,
	id_almacen tinyint unsigned,
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_pelicula) REFERENCES sakilacampus.pelicula(id_pelicula),
	FOREIGN KEY (id_almacen) REFERENCES sakilacampus.almacen(id_almacen)
);

CREATE TABLE sakilacampus.cliente(
	id_cliente smallint unsigned PRIMARY KEY,
	id_almacen tinyint unsigned,
	nombre VARCHAR(45),
	apellidos VARCHAR(45),
	email VARCHAR(50),
	id_direccion smallint unsigned,
	activo tinyint(1),
	fecha_creacion datetime,
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_almacen) REFERENCES sakilacampus.almacen(id_almacen),
	FOREIGN KEY (id_direccion) REFERENCES sakilacampus.direccion(id_direccion)
);

CREATE TABLE sakilacampus.alquiler(
	id_alquiler INT PRIMARY KEY,
	fecha_alquiler datetime,
	id_inventario mediumint unsigned,
	id_cliente smallint unsigned,
	fecha_devolucion DATETIME,
	id_empleado tinyint unsigned,
	ultima_acutalizacion timestamp,
	FOREIGN KEY (id_inventario) REFERENCES sakilacampus.inventario(id_inventario),
	FOREIGN KEY (id_cliente) REFERENCES sakilacampus.cliente(id_cliente),
	FOREIGN KEY (id_empleado) REFERENCES sakilacampus.empleado(id_empleado)
);

CREATE TABLE sakilacampus.pago(
	id_pago smallint unsigned PRIMARY KEY,
	id_cliente smallint unsigned,
	id_empleado tinyint unsigned,
	id_alquiler INT,
	total DECIMAL(5, 2),
	fecha_pago DATETIME,
	ultima_acutalizacion timestamp,
	FOREIGN KEY (id_cliente) REFERENCES sakilacampus.cliente(id_cliente),
	FOREIGN KEY (id_empleado) REFERENCES sakilacampus.empleado(id_empleado),
	FOREIGN KEY (id_alquiler) REFERENCES sakilacampus.alquiler(id_alquiler)
);
	
	