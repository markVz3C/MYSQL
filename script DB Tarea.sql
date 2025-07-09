-- Creación de la base de datos
DROP DATABASE IF EXISTS ejemploSelect;
CREATE DATABASE ejemploSelect;
USE ejemploSelect;

CREATE TABLE tipo_usuarios (
    id_tipo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion_tipo VARCHAR(200) NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (nombre_tipo IN ('Administrador', 'Profesor', 'Estudiante', 'Cliente', 'Moderador'))
);

-- Tabla: usuarios (se añade campo created_at con valor por defecto)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
updated_by INT,
    id_tipo_usuario INT,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CHECK (email LIKE '%@%'),
    
    CONSTRAINT fk_usuarios_tipo_usuarios FOREIGN KEY (id_tipo_usuario) 
        REFERENCES tipo_usuarios(id_tipo)
);

-- Tabla: ciudad (nueva)
CREATE TABLE ciudad (
    id_ciudad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_ciudad VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    created_at datetime default current_timestamp,
updated_at datetime default current_timestamp ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (nombre_ciudad <> 'desconocido')
);
-- Tabla: personas (relacionada con usuarios y ciudad)
CREATE TABLE personas (
    rut VARCHAR(12) NOT NULL UNIQUE,
    nombre_completo VARCHAR(100) NOT NULL,
    fecha_nac DATE,
    id_usuario INT,
    id_ciudad INT,
    created_at datetime default current_timestamp,
updated_at datetime default current_timestamp ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_personas_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_personas_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

-- Poblar tabla tipo_usuarios
INSERT INTO tipo_usuarios (nombre_tipo, descripcion_tipo) VALUES
('Administrador', 'Acceso completo al sistema'),
('Cliente', 'Usuario con acceso restringido'),
('Moderador', 'Puede revisar y aprobar contenido');

-- Poblar tabla usuarios
INSERT INTO usuarios (username, password, email, id_tipo_usuario) VALUES
('admin01', 'pass1234', 'admin01@mail.com', 1),
('jvaldes', 'abc123', 'jvaldes@mail.com', 2),
('cmorales', '123456', 'cmorales@mail.com', 3),
('anavarro', 'pass4321', 'anavarro@mail.com', 2),
('rquezada', 'clave2023', 'rquezada@mail.com', 1),
('pgodoy', 'segura123', 'pgodoy@mail.com', 2),
('mdiaz', 'token456', 'mdiaz@mail.com', 3),
('scarvajal', 'azul789', 'scarvajal@mail.com', 2),
('ltapia', 'lt123', 'ltapia@mail.com', 3),
('afarias', 'afpass', 'afarias@mail.com', 2);

-- Poblar tabla ciudad
INSERT INTO ciudad (nombre_ciudad, region) VALUES
('Santiago', 'Región Metropolitana'),
('Valparaíso', 'Región de Valparaíso'),
('Concepción', 'Región del Biobío'),
('La Serena', 'Región de Coquimbo'),
('Puerto Montt', 'Región de Los Lagos');

-- Poblar tabla personas (relacionadas con usuarios y ciudades)
INSERT INTO personas (rut, nombre_completo, fecha_nac, id_usuario, id_ciudad) VALUES
('11.111.111-1', 'Juan Valdés', '1990-04-12', 2, 1),
('22.222.222-2', 'Camila Morales', '1985-09-25', 3, 2),
('33.333.333-3', 'Andrea Navarro', '1992-11-03', 4, 3),
('44.444.444-4', 'Rodrigo Quezada', '1980-06-17', 5, 1),
('55.555.555-5', 'Patricio Godoy', '1998-12-01', 6, 4),
('66.666.666-6', 'María Díaz', '1987-07-14', 7, 5),
('77.777.777-7', 'Sebastián Carvajal', '1993-03-22', 8, 2),
('88.888.888-8', 'Lorena Tapia', '2000-10-10', 9, 3),
('99.999.999-9', 'Ana Farías', '1995-01-28', 10, 4),
('10.101.010-0', 'Carlos Soto', '1991-08-08', 1, 1); -- admin01

-- 1.-  Mostrar todos los usuarios de tipo Cliente
-- Seleccionar nombre de usuario, correo y tipo_usuario
SELECT username, email
FROM usuarios
WHERE id_tipo_usuario = (
    SELECT id_tipo FROM tipo_usuarios
    WHERE nombre_tipo = 'Cliente'
);

-- 2.-  Mostrar Personas nacidas despues del año 1990
-- Seleccionar Nombre, fecha de nacimiento y username.
SELECT nombre_completo, fecha_nac
FROM personas
WHERE fecha_nac > 1990-01-01;

-- 3.- Seleccionar nombres de personas que comiencen con la 
-- letra A - Seleccionar nombre y correo la persona.
SELECT email
from usuarios 
where id_tipo_usuario = (
	SELECT id_tipo FROM tipo_usuarios
    WHERE nombre_tipo = 'Administrador'
);

-- 4.- Mostrar usuarios cuyos dominios de correo sean
-- mail.commit LIKE '%mail.com%'
SELECT username, email
FROM usuarios
WHERE email LIKE '%@mail.com';

-- 5.- Mostrar todas las personas que no viven en 
 -- Valparaiso y su usuario + ciudad.
 -- select * from ciudad; -- ID 2 VALPARAISO
SELECT nombre_completo
FROM personas
WHERE id_ciudad <> (
    SELECT id_ciudad FROM ciudad
    WHERE nombre_ciudad = 'Valparaíso'
);

-- 6.- Mostrar usuarios que contengan más de 7 
-- carácteres de longitud.
SELECT username
FROM usuarios 
WHERE char_length(username) > 7;

-- 7.- Mostrar username de personas nacidas entre
-- 1990 y 1995
SELECT id_usuario
FROM usuarios
WHERE fecha_nac BETWEEN '1990-01-01' AND '1995-12-31';
