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

---- Tabla canalesCREATE TABLE canales(	id INT IDENTITY(1,1) PRIMARY KEY,	codigo CHAR(6) UNIQUE NOT NULL,	nombre VARCHAR(55) NOT NULL,	descripcion VARCHAR (255) NULL);--- tabla categoria productos create table categoria_productos(	id int identity(1,1) primary key,	codigo char(6) unique not null,	nombre varchar(55) not null,	descripcion varchar(255) null);