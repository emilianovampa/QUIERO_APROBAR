USE GD1C2017
GO



-- Verifico si existe el schema, si no existe lo creo


IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'QUIERO_APROBAR')
	BEGIN
		EXEC sys.sp_executesql N'CREATE SCHEMA [QUIERO_APROBAR] AUTHORIZATION [gd]'
		PRINT 'Schema correctamente creado'

	END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Funcionalidad'))
	DROP TABLE QUIERO_APROBAR.Funcionalidad
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Rol'))
	DROP TABLE QUIERO_APROBAR.Rol
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Rol_Funcionalidad'))
	DROP TABLE QUIERO_APROBAR.Rol_Funcionalidad
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Usuario_Rol'))
	DROP TABLE QUIERO_APROBAR.Usuario_Rol
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Cliente'))
	DROP TABLE QUIERO_APROBAR.Cliente
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Detalle_Factura'))
	DROP TABLE QUIERO_APROBAR.Detalle_Factura
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Facturas'))
	DROP TABLE QUIERO_APROBAR.Facturas
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Autos_Turnos'))
	DROP TABLE QUIERO_APROBAR.Autos_Turnos
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Autos'))
	DROP TABLE QUIERO_APROBAR.Autos
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Rendicion'))
	DROP TABLE QUIERO_APROBAR.Rendicion
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Viaje'))
	DROP TABLE QUIERO_APROBAR.Viaje
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Turnos'))
	DROP TABLE QUIERO_APROBAR.Turnos
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Usuario'))
	DROP TABLE QUIERO_APROBAR.Usuario
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Chofer'))
	DROP TABLE QUIERO_APROBAR.Chofer
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Marca'))
	DROP TABLE QUIERO_APROBAR.Marca
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Modelo'))
	DROP TABLE QUIERO_APROBAR.Modelo
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Porcentaje'))
	DROP TABLE QUIERO_APROBAR.Porcentaje
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUIERO_APROBAR.Detalle_Rendicion'))
	DROP TABLE QUIERO_APROBAR.Detalle_Rendicion


--Creacion de tablas


CREATE TABLE QUIERO_APROBAR.Funcionalidad (
	ID_Funcionalidad NUMERIC(18,0) IDENTITY(1,1) NOT NULL,
	Descripcion NVARCHAR(255) NOT NULL,
		PRIMARY KEY (ID_Funcionalidad)
)
GO

CREATE TABLE QUIERO_APROBAR.Rol (
	ID_rol NUMERIC(18,0) IDENTITY(1,1) NOT NULL,
	Nombre NVARCHAR(255) NOT NULL,
	Habilitado BIT NOT NULL, 
		PRIMARY KEY (ID_Rol)
)
GO

CREATE TABLE QUIERO_APROBAR.Rol_Funcionalidad (
	ID_rol NUMERIC(18,0) NOT NULL,
	ID_funcionalidad NUMERIC(18,0) NOT NULL,
		PRIMARY KEY(ID_rol, ID_funcionalidad)
)

go

CREATE TABLE QUIERO_APROBAR.Usuario (
	ID_usuario NUMERIC(18,0) IDENTITY(1,1) NOT NULL,
	Username NVARCHAR(255) NOT NULL,
	Password NVARCHAR(255) NOT NULL,
	Login_Fallidos TINYINT NOT NULL DEFAULT 0
		PRIMARY KEY (ID_Usuario)
)
GO

CREATE TABLE QUIERO_APROBAR.Usuario_Rol (
	ID_rol NUMERIC(18,0) NOT NULL,
	ID_usuario NUMERIC(18,0) NOT NULL,
		PRIMARY KEY(ID_Rol, ID_Usuario)
)
GO


CREATE TABLE QUIERO_APROBAR.Cliente (
	ID_cliente NUMERIC(18,0) IDENTITY(1,1),
	Cliente_usuario NUMERIC(18,0) NOT NULL, 
	Cliente_nombre NVARCHAR(255) NOT NULL,
	Cliente_apellido NVARCHAR(255) NOT NULL,
	Cliente_dni NUMERIC(10,0) UNIQUE NOT NULL,
	Cliente_mail NVARCHAR(255),
	Cliente_telefono NUMERIC(18,0) UNIQUE NOT NULL,
	Cliente_direccion NVARCHAR(255) NOT NULL,
	Cliente_codigo NUMERIC(18,0),
	Cliente_fecha_nacimiento DATE NOT NULL,
	Cliente_habilitado TINYINT NOT NULL DEFAULT 1,
		PRIMARY KEY(ID_cliente)
)
GO


CREATE TABLE QUIERO_APROBAR.Chofer (
	ID_chofer NUMERIC(18,0) IDENTITY(1,1),
	Chofer_usuario NUMERIC(18,0) NOT NULL,
	Chofer_nombre NVARCHAR(255) NOT NULL,
	Chofer_apellido NVARCHAR(255) NOT NULL,
	Chofer_fecha_nacimiento DATETIME NOT NULL,
	Chofer_dni NUMERIC(18,0) unique NOT NULL,
	Chofer_direccion NVARCHAR(250) NOT NULL,
	Chofer_telefono NUMERIC(18,0) UNIQUE NOT NULL,
	Chofer_email NVARCHAR(255),
	Chofer_habilitado TINYINT NOT NULL DEFAULT 1,
		PRIMARY KEY(ID_chofer)
)
GO



CREATE TABLE QUIERO_APROBAR.Facturas (
	Cod_factura NUMERIC(18,0) IDENTITY(1,1),
	Factura_fecha_inicio DATETIME NOT NULL,
	Factura_fecha_fin DATETIME NOT NULL,
	Factura_importe DECIMAL(12,2) NOT NULL,
	Factura_numero NUMERIC(18,0) NOT NULL,
	Factura_cliente NUMERIC(18,0) NOT NULL, 
		PRIMARY KEY(Cod_factura)
)
GO

CREATE TABLE QUIERO_APROBAR.Detalle_Factura (
	ID_Detalle_Factura NUMERIC(18,0) IDENTITY(1,1),
	Factura NUMERIC(18,0) NOT NULL
		PRIMARY KEY(ID_Detalle_Factura)
)
GO



CREATE TABLE QUIERO_APROBAR.Turnos (
	Cod_turno NUMERIC(18,0) IDENTITY(1,1),
	Turno_hora_inicio NUMERIC(18,0) NOT NULL,
	Turno_hora_fin NUMERIC(18,0) NOT NULL,
	Turno_descripcion NVARCHAR(255),
	Turno_valor_km DECIMAL(5,2) NOT NULL,
	Turno_precio_base DECIMAL(5,2) NOT NULL,
	Turno_habilitado TINYINT NOT NULL DEFAULT 1,
		PRIMARY KEY(Cod_turno)
)
GO

CREATE TABLE QUIERO_APROBAR.Marca (
	ID_Marca NUMERIC(18,0) IDENTITY(1,1),
	Marca_descripcion NVARCHAR(255) NOT NULL,
		PRIMARY KEY(ID_Marca)
)
GO

CREATE TABLE QUIERO_APROBAR.Modelo (
	ID_modelo NUMERIC(18,0) IDENTITY(1,1),
	Modelo_descripcion NVARCHAR(255) NOT NULL,
	Marca  NUMERIC(18,0) NOT NULL,
		PRIMARY KEY(ID_modelo)
)
GO



CREATE TABLE QUIERO_APROBAR.Autos_Turnos (
	ID_auto_turno NUMERIC(18,0) IDENTITY(1,1),
	Auto NUMERIC(18,0) NOT NULL,
	Turno NUMERIC(18,0) NOT NULL,
		PRIMARY KEY(ID_auto_turno)
)
GO



CREATE TABLE QUIERO_APROBAR.Autos (
	ID_auto NUMERIC(18,0) IDENTITY(1,1),
	Auto_chofer NUMERIC(18,0) NOT NULL, 
	Auto_modelo NUMERIC(18,0) NOT NULL,
	Auto_patente NVARCHAR(10) UNIQUE NOT NULL,
	Auto_licencia NVARCHAR(26) NOT NULL,
	Auto_habilitado TINYINT NOT NULL DEFAULT 1,
	Auto_rodado NVARCHAR(10) NOT NULL, 
		PRIMARY KEY(ID_auto)
)
GO



CREATE TABLE QUIERO_APROBAR.Porcentaje (
	ID_porcentaje NUMERIC(18,0) IDENTITY(1,1),
	Porcentaje_valor NUMERIC(18,0) NOT NULL,
	Porcentaje_fecha DATE NOT NULL,
	Porcentaje_dado_usuario NUMERIC(18,0),
			PRIMARY KEY(ID_porcentaje)
)
GO



CREATE TABLE QUIERO_APROBAR.Rendicion (
	ID_rendicion NUMERIC(18,0)  IDENTITY(1,1),
	Rendicion_chofer NUMERIC(18,0) NOT NULL, 
	Rendicion_turno NUMERIC(18,0) NOT NULL, 
	Rendicion_importe DECIMAL(7,2) NOT NULL default 0,
	Rendicion_numero NUMERIC(18,0) NOT NULL,
	Rendicion_fecha DATETIME, 
	Rendicion_porcentaje NUMERIC(18,0) NOT NULL,
		PRIMARY KEY(ID_rendicion)
)
GO

CREATE TABLE QUIERO_APROBAR.Detalle_Rendicion (
	ID_detalle_rendicion NUMERIC(18,0) IDENTITY(1,1),
	Rendicion NUMERIC(18,0) NOT NULL,
		PRIMARY KEY(ID_detalle_rendicion)
)
GO



CREATE TABLE QUIERO_APROBAR.Viaje (
	Cod_viaje NUMERIC(18,0) IDENTITY(1,1),
	Viaje_chofer NUMERIC(18,0) NOT NULL,
	Viaje_auto NUMERIC(18,0) NOT NULL,
	Viaje_turno NUMERIC(18,0) NOT NULL, 
	Viaje_cliente NUMERIC(18,0) NOT NULL, 
	Viaje_rendicion NUMERIC(18,0), 
	Viaje_factura NUMERIC(18,0), 
	Viaje_cantidad_km NUMERIC(5,0) NOT NULL,
	Viaje_fecha_viaje DATE NOT NULL,
	Viaje_hora_inicio TIME,
	Viaje_hora_fin TIME,
		PRIMARY KEY(Cod_viaje)

)
GO

-- Creacion de FKs

ALTER TABLE QUIERO_APROBAR.Rol_Funcionalidad WITH CHECK ADD
	CONSTRAINT FK_Rol_Funcionalidad_Funcionalidad FOREIGN KEY (ID_funcionalidad)
	REFERENCES QUIERO_APROBAR.Funcionalidad (ID_Funcionalidad)

ALTER TABLE QUIERO_APROBAR.Rol_Funcionalidad WITH CHECK ADD
	CONSTRAINT FK_Rol_Funcionaloidad_Rol FOREIGN KEY (ID_rol)
	REFERENCES QUIERO_APROBAR.Rol (ID_rol)



ALTER TABLE QUIERO_APROBAR.Usuario_Rol WITH CHECK ADD
	CONSTRAINT FK_Usuario_Rol_Usuario FOREIGN KEY (ID_usuario)
	REFERENCES QUIERO_APROBAR.Usuario (ID_usuario)



ALTER TABLE QUIERO_APROBAR.Usuario_Rol WITH CHECK ADD
	CONSTRAINT FK_Usuario_Rol_Rol FOREIGN KEY (ID_rol)
	REFERENCES QUIERO_APROBAR.Rol (ID_rol)


ALTER TABLE QUIERO_APROBAR.Cliente WITH CHECK ADD
	CONSTRAINT FK_Cliente_Usuario FOREIGN KEY (Cliente_usuario)
	REFERENCES QUIERO_APROBAR.Usuario (ID_usuario)


ALTER TABLE QUIERO_APROBAR.Chofer WITH CHECK ADD
	CONSTRAINT FK_Chofer_Usuario FOREIGN KEY (Chofer_usuario)
	REFERENCES QUIERO_APROBAR.Usuario (ID_usuario)


ALTER TABLE QUIERO_APROBAR.Facturas WITH CHECK ADD
	CONSTRAINT FK_Facturas_Cliente FOREIGN KEY (Factura_cliente)
	REFERENCES QUIERO_APROBAR.Cliente (ID_cliente)


ALTER TABLE QUIERO_APROBAR.Detalle_Factura WITH CHECK ADD
	CONSTRAINT FK_Detalle_Factura_Facturas FOREIGN KEY (Factura)
	REFERENCES QUIERO_APROBAR.Facturas (Cod_factura)


ALTER TABLE QUIERO_APROBAR.Autos WITH CHECK ADD
	CONSTRAINT FK_Autos_Chofer FOREIGN KEY (Auto_chofer)
	REFERENCES QUIERO_APROBAR.Chofer (ID_chofer)


ALTER TABLE QUIERO_APROBAR.Autos WITH CHECK ADD
	CONSTRAINT FK_Autos_Modelo FOREIGN KEY (Auto_modelo)
	REFERENCES QUIERO_APROBAR.Modelo (ID_modelo)



ALTER TABLE QUIERO_APROBAR.Autos_Turnos WITH CHECK ADD
	CONSTRAINT FK_Autos_Turnos_Autos FOREIGN KEY (Auto)
	REFERENCES QUIERO_APROBAR.Autos (ID_auto)

ALTER TABLE QUIERO_APROBAR.Autos_Turnos WITH CHECK ADD
	CONSTRAINT FK_Autos_Turnos_Turnos FOREIGN KEY (Turno)
	REFERENCES QUIERO_APROBAR.Turnos (Cod_turno)


ALTER TABLE QUIERO_APROBAR.Porcentaje WITH CHECK ADD
	CONSTRAINT FK_Porcentaje_Usuario FOREIGN KEY (Porcentaje_dado_usuario)
	REFERENCES QUIERO_APROBAR.Usuario (ID_usuario)


ALTER TABLE QUIERO_APROBAR.Modelo WITH CHECK ADD
	CONSTRAINT FK_Modelo_Marca FOREIGN KEY (Marca)
	REFERENCES QUIERO_APROBAR.Marca (ID_Marca)



ALTER TABLE QUIERO_APROBAR.Rendicion WITH CHECK ADD
	CONSTRAINT FK_Rendicion_Chofer FOREIGN KEY (Rendicion_chofer)
	REFERENCES QUIERO_APROBAR.Chofer (ID_chofer)


ALTER TABLE QUIERO_APROBAR.Rendicion WITH CHECK ADD
	CONSTRAINT FK_Rendicion_Turnos FOREIGN KEY (Rendicion_turno)
	REFERENCES QUIERO_APROBAR.Turnos (Cod_turno)


ALTER TABLE QUIERO_APROBAR.Rendicion WITH CHECK ADD
	CONSTRAINT FK_Rendicion_Porcentaje FOREIGN KEY (Rendicion_porcentaje)
	REFERENCES QUIERO_APROBAR.Porcentaje (ID_porcentaje)


ALTER TABLE QUIERO_APROBAR.Detalle_Rendicion WITH CHECK ADD
	CONSTRAINT FK_Detalle_Rendicion_Rendicion FOREIGN KEY (Rendicion)
	REFERENCES QUIERO_APROBAR.Rendicion (ID_rendicion)



ALTER TABLE QUIERO_APROBAR.Viaje WITH CHECK ADD
	CONSTRAINT FK_Viaje_Chofer FOREIGN KEY (Viaje_chofer)
	REFERENCES QUIERO_APROBAR.Chofer (ID_chofer)


ALTER TABLE QUIERO_APROBAR.Viaje WITH CHECK ADD
	CONSTRAINT FK_Viaje_Autos FOREIGN KEY (Viaje_auto)
	REFERENCES QUIERO_APROBAR.Autos (ID_auto)


ALTER TABLE QUIERO_APROBAR.Viaje WITH CHECK ADD
	CONSTRAINT FK_Viaje_Turnos FOREIGN KEY (Viaje_turno)
	REFERENCES QUIERO_APROBAR.Turnos (Cod_turno)


ALTER TABLE QUIERO_APROBAR.Viaje WITH CHECK ADD
	CONSTRAINT FK_Viaje_Cliente FOREIGN KEY (Viaje_cliente)
	REFERENCES QUIERO_APROBAR.Cliente (ID_cliente)


ALTER TABLE QUIERO_APROBAR.Viaje WITH CHECK ADD
	CONSTRAINT FK_Viaje_Detalle_Rendicion FOREIGN KEY (Viaje_Rendicion)
	REFERENCES QUIERO_APROBAR.Detalle_Rendicion (ID_detalle_rendicion)



ALTER TABLE QUIERO_APROBAR.Viaje WITH CHECK ADD
	CONSTRAINT FK_Viaje_Detalle_Factura FOREIGN KEY (Viaje_factura)
	REFERENCES QUIERO_APROBAR.Detalle_Factura(ID_Detalle_Factura)



--Empiezo la migracion

INSERT INTO QUIERO_APROBAR.Rol(Nombre, Habilitado)
VALUES
('ADMINISTRATIVO', 1),
('CHOFER', 1),
('CLIENTE', 1);

INSERT INTO QUIERO_APROBAR.Funcionalidad(Descripcion)
VALUES
('ABM DE ROL'),
('REGISTRO DE USUARIO'),
('ABM DE CLIENTES'),
('ABM DE AUTOMOVIL'),
('ABM DE TURNO'),
('ABM DE CHOFER'),
('REGISTRO DE VIAJE'),
('RENDICION DE VIAJE'),
('FACTURACION DE CLIENTES'),
('LISTADO ESTADISTICO');


INSERT INTO QUIERO_APROBAR.Rol_Funcionalidad(ID_rol, ID_funcionalidad)
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(2,8),
(3,9),
(1,10),
(2,10),
(3,10);

INSERT INTO QUIERO_APROBAR.Usuario(Username, Password)
VALUES
('admin',HASHBYTES('SHA2_256','w23e'))


INSERT INTO QUIERO_APROBAR.Usuario(Username, Password)
SELECT DISTINCT Cliente_Dni, HASHBYTES('SHA2_256',cast(Cliente_Dni as varchar(255)))
FROM gd_esquema.Maestra
WHERE Cliente_Dni IS NOT NULL



INSERT INTO QUIERO_APROBAR.Usuario(Username, Password)
SELECT DISTINCT Chofer_Dni, HASHBYTES('SHA2_256',cast(Chofer_Dni as varchar(255)))
FROM gd_esquema.Maestra
WHERE Chofer_Dni IS NOT NULL



INSERT INTO QUIERO_APROBAR.Cliente(Cliente_nombre, Cliente_apellido, Cliente_dni,Cliente_telefono, Cliente_direccion, Cliente_mail, Cliente_fecha_nacimiento, Cliente_usuario)
SELECT DISTINCT M.Cliente_Nombre, M.Cliente_Apellido, M.Cliente_Dni, M.Cliente_Telefono, M.Cliente_Direccion, M.Cliente_Mail, M.Cliente_Fecha_Nac, U.ID_usuario
FROM gd_esquema.Maestra M, QUIERO_APROBAR.Usuario U
WHERE CAST(M.Cliente_Dni as varchar(255)) = U.Username




INSERT INTO QUIERO_APROBAR.Chofer(Chofer_nombre, Chofer_apellido, Chofer_dni, Chofer_telefono, Chofer_direccion, Chofer_email, Chofer_fecha_nacimiento, Chofer_usuario)
SELECT DISTINCT M.Chofer_Nombre, M.Chofer_Apellido, M.Chofer_Dni, M.Chofer_Telefono, M.Chofer_Direccion, M.Chofer_Mail, M.Chofer_Fecha_Nac, U.ID_usuario
FROM gd_esquema.Maestra M, QUIERO_APROBAR.Usuario U
WHERE CAST(M.Chofer_Dni as varchar(255)) = U.Username


INSERT INTO QUIERO_APROBAR.Usuario_Rol(ID_usuario, ID_rol)
SELECT DISTINCT U.ID_usuario, R.ID_rol
FROM QUIERO_APROBAR.Usuario U, QUIERO_APROBAR.Cliente C, QUIERO_APROBAR.Rol R
WHERE U.Username = cast(C.cliente_dni as varchar(255))
AND R.Nombre = 'CLIENTE'


INSERT INTO QUIERO_APROBAR.Usuario_Rol(ID_usuario, ID_rol)
SELECT DISTINCT U.ID_usuario, R.ID_rol
FROM QUIERO_APROBAR.Usuario U, QUIERO_APROBAR.Chofer C, QUIERO_APROBAR.Rol R
WHERE U.Username = cast(C.chofer_dni as varchar(255))
AND R.Nombre = 'CHOFER'


INSERT INTO QUIERO_APROBAR.Turnos(Turno_descripcion, Turno_hora_fin, Turno_hora_inicio, Turno_precio_base, Turno_valor_km)
SELECT DISTINCT Turno_Descripcion, Turno_Hora_Fin, Turno_Hora_Inicio, Turno_Precio_Base, Turno_Valor_Kilometro
FROM gd_esquema.Maestra


update QUIERO_APROBAR.Turnos
set turno_descripcion = 'Turno Mañana'
where turno_descripcion = 'Turno Mañna'


insert into QUIERO_APROBAR.Porcentaje(Porcentaje_fecha, Porcentaje_valor)
VALUES
(CONVERT(DATE, getDate()), 30)



INSERT INTO QUIERO_APROBAR.Rendicion(Rendicion_chofer, Rendicion_fecha, Rendicion_importe, Rendicion_numero, Rendicion_turno, Rendicion_porcentaje)
SELECT DISTINCT C.ID_chofer, M.Rendicion_Fecha, sum(M.Rendicion_Importe), M.Rendicion_Nro, T.Cod_turno, 1
FROM gd_esquema.Maestra M, QUIERO_APROBAR.Chofer C, QUIERO_APROBAR.Turnos T
WHERE M.Rendicion_Fecha IS NOT NULL
AND M.Chofer_Dni = C.Chofer_dni
AND M.Turno_Hora_Inicio = T.Turno_hora_inicio
GROUP BY Rendicion_Nro, C.ID_chofer, T.Cod_turno, M.Rendicion_Fecha



INSERT INTO QUIERO_APROBAR.Detalle_Rendicion(Rendicion)
SELECT DISTINCT R.ID_rendicion
FROM QUIERO_APROBAR.Rendicion R

INSERT INTO QUIERO_APROBAR.Marca(Marca_descripcion)
SELECT DISTINCT Auto_Marca
FROM gd_esquema.Maestra


INSERT INTO QUIERO_APROBAR.Modelo(Modelo_descripcion, Marca)
SELECT DISTINCT M.Auto_Modelo, MA.ID_Marca
FROM gd_esquema.Maestra M, QUIERO_APROBAR.Marca MA
WHERE M.Auto_Marca = MA.Marca_descripcion



INSERT INTO QUIERO_APROBAR.Autos(Auto_licencia, Auto_modelo, Auto_patente, Auto_rodado, Auto_chofer)
SELECT DISTINCT M.Auto_Licencia, MO.ID_modelo, M.Auto_Patente, M.Auto_Rodado, C.ID_chofer
FROM gd_esquema.Maestra M, QUIERO_APROBAR.Chofer C, QUIERO_APROBAR.Modelo MO
WHERE M.Auto_Patente IS NOT NULL
AND M.Chofer_Dni = C.Chofer_dni
AND M.Auto_Modelo = MO.Modelo_descripcion
 

INSERT INTO QUIERO_APROBAR.Autos_Turnos(Auto, Turno)
SELECT DISTINCT A.ID_auto, T.Cod_turno
FROM gd_esquema.Maestra M, QUIERO_APROBAR.Autos A, QUIERO_APROBAR.Turnos T
WHERE M.Auto_Patente = A.Auto_patente
AND M.Turno_Hora_Inicio = T.Turno_hora_inicio



INSERT INTO QUIERO_APROBAR.Facturas(Factura_cliente, Factura_fecha_inicio, Factura_fecha_fin, Factura_numero, Factura_importe)
SELECT DISTINCT C.ID_cliente, M.Factura_Fecha_Inicio , M.Factura_Fecha_Fin, M.Factura_Nro, (select sum(m2.Turno_Precio_Base + ( m2.Viaje_Cant_Kilometros * m2.Turno_Valor_Kilometro))
FROM gd_esquema.Maestra M2
WHERE M2.Factura_Nro = M.Factura_Nro)
FROM QUIERO_APROBAR.Cliente C, gd_esquema.Maestra M
WHERE Factura_Nro IS NOT NULL
AND C.cliente_dni = M.Cliente_Dni


INSERT INTO QUIERO_APROBAR.Detalle_Factura(Factura)
SELECT DISTINCT F.Cod_factura
FROM QUIERO_APROBAR.Facturas F


INSERT INTO QUIERO_APROBAR.Viaje(Viaje_auto, Viaje_chofer, Viaje_cliente, Viaje_rendicion, Viaje_turno, Viaje_cantidad_km, Viaje_fecha_viaje, Viaje_factura)
SELECT DISTINCT A.ID_auto, Ch.ID_chofer, Cl.ID_cliente, RD.Rendicion,T.Cod_turno, M.Viaje_Cant_Kilometros, M.Viaje_Fecha, FD.Factura
FROM QUIERO_APROBAR.Autos A, QUIERO_APROBAR.Chofer Ch, QUIERO_APROBAR.Cliente Cl, QUIERO_APROBAR.Rendicion R, QUIERO_APROBAR.Turnos T, gd_esquema.Maestra M, gd_esquema.Maestra Ma, QUIERO_APROBAR.Facturas F, QUIERO_APROBAR.Detalle_Factura FD, QUIERO_APROBAR.Detalle_Rendicion RD
WHERE M.Viaje_Cant_Kilometros IS NOT NULL
AND M.Auto_Patente = A.Auto_patente
AND M.Chofer_Dni = Ch.Chofer_dni
AND M.Cliente_Dni = Cl.Cliente_dni
AND M.Rendicion_Nro = R.Rendicion_numero
AND M.Turno_Hora_Inicio = T.Turno_hora_inicio
AND M.Chofer_Dni = Ma.Chofer_Dni
AND M.Cliente_Dni = Ma.Cliente_Dni
AND M.Viaje_Fecha = Ma.Viaje_Fecha
AND MA.Factura_Nro = F.Factura_numero
AND F.Cod_factura = FD.Factura
AND R.ID_rendicion = RD.Rendicion


