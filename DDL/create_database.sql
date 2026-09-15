CREATE DATABASE pdan_8_rentabilidad_cliente;
GO

USE pdan_8_rentabilidad_cliente;
GO
--- Segmentos

CREATE TABLE segmentos(
id INT IDENTITY(1,1) PRIMARY KEY,
codigo CHAR(6) UNIQUE NOT NULL,
nombre VARCHAR (55) NOT NULL,
descripcion VARCHAR (255) NULL
);

---- Tabla canales

CREATE TABLE canales(
	id INT IDENTITY(1,1) PRIMARY KEY,
	codigo CHAR(6) UNIQUE NOT NULL,
	nombre VARCHAR(55) NOT NULL,
	descripcion VARCHAR (255) NULL
);


--- tabla categoria productos 

create table categoria_productos(
	id int identity(1,1) primary key,
	codigo char(6) unique not null,
	nombre varchar(55) not null,
	descripcion varchar(255) null
);


--- Productos

CREATE TABLE productos(
	id INT IDENTITY (1,1) PRIMARY KEY,
	codigo CHAR(6) UNIQUE NOT NULL,
	nombre VARCHAR(55) NOT NULL,
	categoria_id INT NOT NULL,
	tipo_producto VARCHAR(30) NULL,
	moneda VARCHAR(25) NULL,
	estado VARCHAR(25) NULL,
	CONSTRAINT fk_categoria_productos FOREIGN KEY (categoria_id) REFERENCES categoria_productos(id)
	);

--- clientes

CREATE TABLE clientes (
	id INT IDENTITY (1,1) PRIMARY KEY,
	codigo CHAR(6) UNIQUE NOT NULL,
	tipo_cliente VARCHAR(1) NOT NULL,
	fecha_alta DATE DEFAULT(CONVERT(DATE,GETDATE())),
	estado VARCHAR (25) NOT NULL,
	segmento_id INT NOT NULL,
	FOREIGN KEY (segmento_id) REFERENCES segmentos(id)
);

EXEC SP_HELP clientes;

