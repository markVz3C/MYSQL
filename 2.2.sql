use sistema_venta;

create table tipo_usuarios(
id_tipo_usuario INT auto_increment PRIMARY KEY,
nombre_tipo VARCHAR(50) NOT NULL,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

create table usuarios(
id_usuario INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
correo VARCHAR(100) UNIQUE,
tipo_usuario_id INT, 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, 
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE productos(
id_producto INT auto_increment PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
precio int not null,
stock int not null,
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE);

CREATE TABLE ventas(
id_venta INT auto_increment PRIMARY KEY,
usuario_id INT,
fecha date,
updated_at datetime default current_timestamp ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE);

CREATE TABLE detalle_ventas(
id_detalle_ventas INT auto_increment PRIMARY KEY,
venta_id INT,
producto_id INT,
cantidad INT,
precio_unitario INT,
updated_at datetime default current_timestamp ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE);

ALTER TABLE usuarios
ADD CONSTRAINT fk_usuarios_tipo_usuarios
FOREIGN KEY (tipo_usuario_id) REFERENCES
tipo_usuarios(id_tipo_usuario);

ALTER TABLE ventas
ADD CONSTRAINT fk_ventas_usuarios
FOREIGN KEY (usuario_id) REFERENCES
usuarios(id_usuario);

ALTER TABLE detalle_ventas
ADD CONSTRAINT fk_detalle_ventas_ventas
FOREIGN KEY (venta_id) REFERENCES
ventas(id_venta);

ALTER TABLE detalle_ventas
ADD CONSTRAINT fk_detalle_ventas_productos
FOREIGN KEY (producto_id) REFERENCES
productos(id_producto);

ALTER TABLE usuarios
ADD contraseña VARCHAR(50) AFTER correo;

ALTER TABLE tipo_usuarios
ADD descripcion_tipo_usuario VARCHAR(200) AFTER nombre_tipo;

INSERT INTO usuarios (nombre, correo, contraseña, tipo_usuario_id, created_by, updated_by)
VALUES ('usuario inicial', 'sistema@local', 'sistema123', NULL, NULL, NULL);

INSERT INTO tipo_usuarios (nombre_tipo, descripcion_tipo_usuario, created_by, updated_by)
VALUES 
('Administrador', 'Rol con acceso total al sistema', 1, 1),
('Vendedor', 'Rol con permisos para registrar ventas y productos', 1, 1);

INSERT INTO usuarios (nombre, correo, contraseña, tipo_usuario_id, created_by, updated_by)
VALUES 
('Ana Martínez', 'ana.martinez@nombreempresa.com', 'ana123', 1, 1, 1),
('Carlos Soto', 'carlosoto1@nombreempresa.com', 'carlos123', 2, 1, 1), 
('Lucía Reyes', 'luciaareyes@nombreempresa.com', 'lucia123', 2, 1, 1); 

INSERT INTO productos (nombre, precio, stock, created_by, updated_by)
VALUES
('Laptop Lenovo', 850000, 10, 1, 1),
('Mouse Inalámbrico', 15000, 50, 1, 1),
('Monitor LG', 200000, 15, 1, 1);

INSERT INTO ventas (usuario_id, fecha, created_by, updated_by)
VALUES 
(12, '2025-05-20', 1, 1),
(13, '2025-05-21', 1, 1);

INSERT INTO detalle_ventas (venta_id, producto_id, cantidad, precio_unitario, created_by, updated_by)
VALUES
(3, 4, 1, 850000, 1, 1),
(3, 5, 2, 15000, 1, 1),
(4, 5, 1, 15000, 1, 1),  
(4, 6, 1, 200000, 1, 1);  








