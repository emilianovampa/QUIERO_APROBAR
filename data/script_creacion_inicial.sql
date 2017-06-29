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
	Habilitado BIT NOT NULL DEFAULT 1, 
		PRIMARY KEY (ID_Rol)
)
GO

CREATE TABLE QUIERO_APROBAR.Rol_Funcionalidad (
	Rol_Funcionalidad_ID NUMERIC(18,0) IDENTITY(1,1),
	ID_rol NUMERIC(18,0) NOT NULL,
	ID_funcionalidad NUMERIC(18,0) NOT NULL,
		PRIMARY KEY(Rol_Funcionalidad_ID)
)

go

CREATE TABLE QUIERO_APROBAR.Usuario (
	ID_usuario NUMERIC(18,0) IDENTITY(1,1) NOT NULL,
	Username NVARCHAR(255) NOT NULL,
	Password NVARCHAR(255) NOT NULL,
	Login_Fallidos TINYINT NOT NULL DEFAULT 0,
		PRIMARY KEY (ID_Usuario)
)
GO

CREATE TABLE QUIERO_APROBAR.Usuario_Rol (
	Usuario_Rol_ID NUMERIC(18,0) IDENTITY(1,1),
	ID_rol NUMERIC(18,0) NOT NULL,
	ID_usuario NUMERIC(18,0) NOT NULL,
		PRIMARY KEY(Usuario_Rol_ID)
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
	Factura_importe DECIMAL(12,2) NOT NULL DEFAULT 0,
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
	Turno_hora_inicio NUMERIC(18,0)  NOT NULL,
	Turno_hora_fin NUMERIC(18,0)  NOT NULL,
	Turno_descripcion NVARCHAR(255),
	Turno_valor_km DECIMAL(5,2) NOT NULL,
	Turno_precio_base DECIMAL(5,2) NOT NULL,
	Turno_habilitado BIT NOT NULL DEFAULT 1,
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
	Auto_turno NUMERIC(18,0) NOT NULL,
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

ALTER TABLE QUIERO_APROBAR.Autos WITH CHECK ADD
	CONSTRAINT FK_Autos_Turnos FOREIGN KEY (Auto_turno)
	REFERENCES QUIERO_APROBAR.Turnos (Cod_turno)


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
ORDER BY Turno_Hora_Inicio


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



INSERT INTO QUIERO_APROBAR.Autos(Auto_licencia, Auto_modelo, Auto_patente, Auto_rodado, Auto_chofer, Auto_turno)
SELECT DISTINCT M.Auto_Licencia, MO.ID_modelo, M.Auto_Patente, M.Auto_Rodado, C.ID_chofer, ABS(Checksum(NewID()) % 3) + 1
FROM gd_esquema.Maestra M, QUIERO_APROBAR.Chofer C, QUIERO_APROBAR.Modelo MO
WHERE M.Auto_Patente IS NOT NULL
AND M.Chofer_Dni = C.Chofer_dni
AND M.Auto_Modelo = MO.Modelo_descripcion
group by m.Auto_Licencia, mo.ID_modelo, m.Auto_Patente, m.Auto_Rodado, c.ID_chofer




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



--Stored procedures 


--Listado estadistico. Choferes con mayor recudacion

IF EXISTS (SELECT name FROM sysobjects WHERE name='trimestre' AND type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
DROP FUNCTION QUIERO_APROBAR.trimestre
GO

create function QUIERO_APROBAR.trimestre (@mes int)
returns int
begin
declare @retorno int

if (@mes between 1 and 3) set @retorno = 1 
if (@mes between 4 and 6) set @retorno = 2
if (@mes between 7 and 9) set @retorno = 3
if (@mes between 10 and 12) set @retorno = 4

return @retorno
end

GO



IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_choferes_con_mayor_recaudacion' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_choferes_con_mayor_recaudacion
GO

create procedure QUIERO_APROBAR.sp_choferes_con_mayor_recaudacion (@año int, @trimestre int)
AS

BEGIN 
SELECT TOP 5 c.*, ISNULL(SUM(R.rendicion_importe), 0) as Recaudacion
FROM QUIERO_APROBAR.Chofer C LEFT JOIN QUIERO_APROBAR. Rendicion R ON C.ID_Chofer = R.rendicion_chofer
WHERE YEAR(R.Rendicion_fecha) = @año
AND QUIERO_APROBAR.trimestre(MONTH(R.rendicion_fecha)) = @trimestre
GROUP BY c.chofer_apellido,c.chofer_direccion,c.chofer_dni,c.chofer_email,c.chofer_fecha_nacimiento,c.chofer_fecha_nacimiento,c.chofer_habilitado,c.ID_chofer,c.chofer_nombre,c.chofer_telefono,c.chofer_usuario
ORDER BY ISNULL(SUM(R.Rendicion_importe), 0) DESC
END
GO



--Listado estadistico. Choferes con viajes mas largos


IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_choferes_con_viaje_mas_largo' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_choferes_con_viaje_mas_largo
GO

create procedure QUIERO_APROBAR.sp_choferes_con_viaje_mas_largo (@año int, @trimestre int)
AS

BEGIN
SELECT TOP 5 c.*, ISNULL(SUM(V.Viaje_cantidad_km),0) as cantidad
FROM QUIERO_APROBAR.Chofer C LEFT JOIN QUIERO_APROBAR.Viaje V ON c.ID_chofer = V.Viaje_chofer
WHERE YEAR(V.Viaje_fecha_viaje) = @año
AND QUIERO_APROBAR.trimestre(MONTH(V.Viaje_fecha_viaje)) = @trimestre
GROUP BY C.Chofer_apellido, c.Chofer_direccion, c.Chofer_dni, c.Chofer_email, c.Chofer_fecha_nacimiento, c.Chofer_habilitado, c.ID_chofer, c.Chofer_nombre, c.Chofer_telefono, c.Chofer_usuario
ORDER BY ISNULL(SUM(V.Viaje_cantidad_km),0) DESC

END
GO

--Listado estadistico. Cliente con mayor consumo


IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_clientes_con_mayor_consumo' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_clientes_con_mayor_consumo
GO

create procedure QUIERO_APROBAR.sp_clientes_con_mayor_consumo (@año int, @trimestre int)
AS
BEGIN
SELECT TOP 5 c.*, ISNULL(SUM(f.Factura_importe), 0) as importe 
FROM QUIERO_APROBAR.Cliente C LEFT JOIN QUIERO_APROBAR.Facturas F ON C.ID_cliente = F.Factura_cliente
WHERE YEAR (f.Factura_fecha_inicio) = @año
AND QUIERO_APROBAR.trimestre(MONTH (f.Factura_fecha_inicio)) = @trimestre
GROUP BY C.Cliente_apellido, C.Cliente_codigo, c.Cliente_direccion, c.Cliente_dni, c.Cliente_mail, c.Cliente_fecha_nacimiento, c.Cliente_habilitado, c.ID_cliente, c.Cliente_nombre, c.Cliente_telefono, c.Cliente_usuario
ORDER BY ISNULL(SUM(f.Factura_importe), 0) DESC
END
GO

--Listado estadistico. Cliente mayor uso de un mismo automovil 
/*

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_clientes_mayor_uso_mismo_auto' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_clientes_mayor_uso_mismo_auto
GO

create procedure QUIERO_APROBAR.sp_clientes_mayor_uso_mismo_auto (@año int, @trimestre int)
AS
BEGIN
SELECT TOP 5 c.*, a.*, ISNULL(COUNT(a.ID_auto),0) as cantidad
FROM QUIERO_APROBAR.Cliente C LEFT JOIN QUIERO_APROBAR.Viaje V ON C.ID_cliente = V.Viaje_cliente LEFT JOIN Autos A ON v.Viaje_auto = A.ID_auto
WHERE YEAR(v.Viaje_fecha_viaje) = @año
AND QUIERO_APROBAR.trimestre(MONTH(v.Viaje_fecha_viaje)) = @trimestre
GROUP BY c.Cliente_apellido, c.Cliente_codigo, c.Cliente_direccion, c.Cliente_dni, c.Cliente_mail, c.Cliente_fecha_nacimiento, c.Cliente_habilitado,c.ID_cliente, c.Cliente_nombre, c.Cliente_telefono, c.Cliente_usuario, a.Auto_chofer, a.Auto_habilitado, a.ID_auto, a.Auto_licencia, a.Auto_modelo, a.Auto_patente, a.Auto_patente, a.Auto_rodado
ORDER BY ISNULL(COUNT(a.ID_auto),0) DESC

END
GO
*/

-- Dar de baja un ROL

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_baja_rol' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_baja_rol
GO

create procedure QUIERO_APROBAR.sp_baja_rol (@id numeric(10,0))
as
begin

update QUIERO_APROBAR.Rol 
set Habilitado = 0
where ID_rol = @id

end
GO

-- Dar de alta un ROL
/*
create type funcionalidadesList as table (funcionalidadID int);

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_alta_rol' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_alta_rol
GO

create procedure QUIERO_APROBAR.sp_alta_rol (@nombre varchar(255), @habilitado  bit, @listaFuncionalidades funcionalidadesList readonly)
as
begin

insert into QUIERO_APROBAR.Rol (Nombre, habilitado)
values(@nombre, @habilitado)

insert into QUIERO_APROBAR.Rol_Funcionalidad(ID_rol, ID_funcionalidad)
select  ID_rol, funcionalidadID
from @listaFuncionalidades, QUIERO_APROBAR.Rol
where @nombre = Nombre

end
GO
*/

-- Trigger para dar de bajar la relacion, al bajar un rol

IF EXISTS (SELECT name FROM sysobjects WHERE name='tr_baja_rol')
DROP trigger QUIERO_APROBAR.tr_baja_rol
GO

create trigger QUIERO_APROBAR.tr_baja_rol on QUIERO_APROBAR.Rol for update
as
begin
if UPDATE(Habilitado)
	delete from QUIERO_APROBAR.Usuario_Rol
	where ID_rol in (select i.ID_rol
							  from inserted i
							  where i.Habilitado = 0)
END



-- Modificar ROl

/*
IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_update_rol' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_update_rol
GO											

create procedure QUIERO_APROBAR.sp_update_rol (@id numeric(10,0), @nombre varchar(255), @habilitado bit, @listaFuncionalidades funcionalidadesList readonly)	
as
begin

update QUIERO_APROBAR.Rol
set Nombre = @nombre, Habilitado= @habilitado
where ID_rol = @id

delete from QUIERO_APROBAR.Rol_Funcionalidad
where ID_rol = @id

insert into QUIERO_APROBAR.Rol_Funcionalidad (ID_rol, ID_funcionalidad)
select  @id, funcionalidadID
from @listaFuncionalidades


end
GO												

*/
-- Obtener roles habilitados

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_roles_habilitados' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_roles_habilitados
GO	

create procedure QUIERO_APROBAR.sp_get_roles_habilitados
as
begin

select * 
from QUIERO_APROBAR.Rol
where Habilitado = 1

end
GO


-- Obtiene todos los roles

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_roles' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_roles
GO	

create procedure QUIERO_APROBAR.sp_get_roles
as
begin

select * 
from QUIERO_APROBAR.Rol

end
GO


-- Actualiza los intents fallidos a 0

 IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_limpiar_intentos_fallidos' AND type='p')
        DROP PROCEDURE QUIERO_APROBAR.sp_limpiar_intentos_fallidos
GO

create procedure QUIERO_APROBAR.sp_limpiar_intentos_fallidos (@username varchar(255))
as
begin

update QUIERO_APROBAR.Usuario set Login_Fallidos = 0
where Username = @username

end
GO




-- Aumenta en 1 los intentos fallidos

 IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_incrementar_intentos_fallidos' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_incrementar_intentos_fallidos
GO

create procedure QUIERO_APROBAR.sp_incrementar_intentos_fallidos (@username varchar(255))
as
begin

update  QUIERO_APROBAR.Usuario set Login_Fallidos = (Login_Fallidos + 1)
where Username = @username

end
GO

-- Ver si existe el usuario (sirve para el logg)

IF EXISTS (SELECT name FROM sysobjects WHERE name='existeUsuario' AND type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
	DROP FUNCTION QUIERO_APROBAR.existeUsuario
GO

create function QUIERO_APROBAR.existeUsuario(@username varchar(255))
returns bit
begin
declare @retorno bit

if((select count(*)
	from QUIERO_APROBAR.Usuario
	where Username = @username) > 0) set @retorno = 1 else set @retorno = 0
return @retorno

end
GO

--Verifico si el usaurio no esta dado de baja

IF EXISTS (SELECT name FROM sysobjects WHERE name='usuarioActivo' AND type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
	DROP FUNCTION QUIERO_APROBAR.usuarioActivo
GO

create function QUIERO_APROBAR.usuarioActivo (@username varchar(255))
returns bit
begin
declare @retorno bit

if((select Login_Fallidos
	from QUIERO_APROBAR.Usuario
	where Username = @username) < 3) set @retorno = 1 else set @retorno = 0

return @retorno
end
GO



-- Chequeo de Logg

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_login_check' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_login_check
GO	

create procedure QUIERO_APROBAR.sp_login_check(@username varchar (255), @contrasenia varchar(255), @retorno int output)
as
begin

 if (QUIERO_APROBAR.existeUsuario(@username)) = 0 set @retorno = -1
	else
	begin
	if(QUIERO_APROBAR.usuarioActivo(@username) = 0) set @retorno = -3
		else
		if(select Password
		from QUIERO_APROBAR.Usuario
		where Username = @username) = HASHBYTES('SHA2_256',cast(@contrasenia as varchar(255)))begin  set @retorno = 
		(select u.ID_usuario  from QUIERO_APROBAR.Usuario U where u.Username = @username) exec QUIERO_APROBAR.sp_limpiar_intentos_fallidos @username end
			else 
			begin
			set @retorno=-2
			exec QUIERO_APROBAR.sp_incrementar_intentos_fallidos @username 
			end
		end
	return @retorno

end
GO

-- Obtener los roles de determinado usuario

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_roles_usuario' AND type='p')
	DROP PROCEDURE  QUIERO_APROBAR.sp_get_roles_usuario
GO

create procedure  QUIERO_APROBAR.sp_get_roles_usuario (@idUsuario numeric (10,0))	
as
begin

select r.*
from  QUIERO_APROBAR.Usuario u,  QUIERO_APROBAR.Usuario_Rol ur,  QUIERO_APROBAR.Rol r
where u.ID_usuario = @idUsuario
and u.ID_usuario = ur.Usuario_Rol_ID
and ur.ID_rol = r.ID_rol
and r.habilitado = 1 	

end
GO 

-- verifica si un chofer esta asignado a un auto

IF EXISTS (SELECT name FROM sysobjects WHERE name='choferYaAsignado' AND type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
	DROP FUNCTION QUIERO_APROBAR.choferYaAsignado
GO

create function QUIERO_APROBAR.choferYaAsignado(@idchofer numeric(10,0), @idTurno numeric(10,0), @idAuto numeric(10,0))
returns int
begin
declare @retorno bit

if	((select count(*)
	from QUIERO_APROBAR.Autos
	where auto_chofer = @idchofer
	and @idAuto is null or (@idAuto != ID_auto)
	and auto_habilitado = 1
	and Auto_turno = @idTurno) > 0)

	set @retorno = 1

else
	set @retorno = 0

return @retorno

end
GO


-- calculo de importe para un viaje

IF EXISTS (SELECT name FROM sysobjects WHERE name='calcularimporteViaje' AND type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
	DROP FUNCTION QUIERO_APROBAR.calcularimporteViaje
GO

create function QUIERO_APROBAR.calcularimporteViaje(@idViaje numeric(10,0))
	returns float
begin
declare @retorno float

set @retorno = (select( Turno_precio_base + (Turno_valor_km * Viaje_cantidad_km))
				from QUIERO_APROBAR.Viaje, QUIERO_APROBAR.Turnos
				where Cod_viaje = @idViaje
				and viaje_turno = Cod_turno)

return @retorno
end
GO

--Verifica si se hizo la rendicion del viaje en un turno

IF EXISTS (SELECT name FROM sysobjects WHERE name='ExisteRendicion' AND type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
	DROP FUNCTION  QUIERO_APROBAR.ExisteRendicion
GO

create function  QUIERO_APROBAR.ExisteRendicion (@idChofer numeric(10,0), @idTurno numeric(10,0), @fecha date)
returns int
begin
declare @retorno int

if((select count(*)
	from  QUIERO_APROBAR.Rendicion
	where rendicion_chofer = @idChofer
	and rendicion_fecha = @fecha
	and rendicion_turno = @idTurno) > 0) set @retorno = 1 else set @retorno = 0

return @retorno
end
GO

-- Verifica si se hizo la facturacion


IF EXISTS (SELECT name FROM sysobjects WHERE name='ExisteFacturacion' AND type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
	DROP FUNCTION QUIERO_APROBAR.ExisteFacturacion
GO

create function QUIERO_APROBAR.ExisteFacturacion (@idCliente numeric(10,0), @fechaInicio date , @fechafin date)
returns int
begin
declare @retorno int

if((select count(*)
	from QUIERO_APROBAR.Facturas
	where Factura_cliente = @idCliente
	and factura_fecha_inicio = @fechaInicio
	and factura_fecha_fin = @fechafin) > 0) set @retorno = 1 else set @retorno = 0

return @retorno
end
GO



-- Dar de alta usuario

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_alta_usuario' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_alta_usuario
GO

create procedure QUIERO_APROBAR.sp_alta_usuario (@username varchar(255), @contrasenia varchar(255))
as
begin

insert into QUIERO_APROBAR.Usuario (Username, Password)
values(@username, HASHBYTES('SHA2_256',cast(@contrasenia as varchar(16))))

end
GO


-- Cliente con mismo telefono (alta cliente)

IF EXISTS (SELECT name FROM sysobjects WHERE name='existeClienteConMismoTelefono' AND type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
	DROP FUNCTION QUIERO_APROBAR.existeClienteConMismoTelefono
GO

create function QUIERO_APROBAR.existeClienteConMismoTelefono (@idCliente numeric(10,0), @telefonoAComprobar numeric(18,0))
returns int
begin
declare @retorno int

if((select count(*)
	from ddg.Clientes
	where (@idCliente is null or (@idCliente != cliente_id))
	and @telefonoAComprobar = cliente_telefono) > 0) set @retorno = 1 
	else set @retorno = 0

return @retorno
end
GO





-- Dar de alta un cliente

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_alta_cliente' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_alta_cliente
GO

create procedure QUIERO_APROBAR.sp_alta_cliente (@nombre varchar(250), @apellido varchar(250), @fechanac date, @dni numeric(10,0), @direccion varchar(250),@codpost numeric(18,0), @telefono numeric(18,0), @email varchar(250))
as
begin

	declare @noPuedoCrearUsuario int
	set @noPuedoCrearUsuario = QUIERO_APROBAR.existeClienteConMismoTelefono(null,@telefono)
	if(@noPuedoCrearUsuario = 1) THROW 51000, 'Ya existe un cliente con el numero de telefono ingresado.', 1;	

	declare @usuario varchar(255)
	declare @contraseña varchar(255)
	set @usuario =   convert(varchar(255), @dni)
	set @contraseña =   convert(varchar(255), @dni)

	exec QUIERO_APROBAR.sp_alta_usuario @usuario, @contraseña

	insert into QUIERO_APROBAR.Cliente(cliente_usuario,cliente_nombre,cliente_apellido,cliente_fecha_nacimiento,cliente_dni,cliente_direccion,Cliente_codigo,cliente_telefono,Cliente_mail)
	values((select ID_usuario from QUIERO_APROBAR.Usuario where Username=@dni), @nombre, @apellido, @fechanac, @dni, @direccion, @codpost, @telefono, @email)

end
GO


--Modificar datos de un cliente

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_update_cliente' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_update_cliente
GO

create procedure QUIERO_APROBAR.sp_update_cliente (@nombre varchar(250),  @apellido varchar(250), @fechaNacimiento date, @direccion varchar(250), @codPostal numeric, @telefono numeric(18,0),  @email varchar(250), @habilitado numeric(1,0), @idcliente numeric(10,0)) as
begin

declare @noPuedoCrearUsuario int
	set @noPuedoCrearUsuario = QUIERO_APROBAR.existeClienteConMismoTelefono(@idcliente,@telefono)
	if(@noPuedoCrearUsuario = 1) THROW 51000, 'Ya existe un cliente con el numero de telefono ingresado.', 1;	

update QUIERO_APROBAR.Cliente
set cliente_nombre = @nombre,
cliente_apellido = @apellido,
cliente_fecha_nacimiento = @fechaNacimiento,
cliente_direccion = @direccion,
Cliente_codigo = @codPostal,
cliente_telefono = @telefono,
cliente_mail = @email,
cliente_habilitado = @habilitado
where ID_cliente = @idcliente

end
GO


-- Baja logica de un cliente

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_baja_cliente' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_baja_cliente
GO

create procedure QUIERO_APROBAR.sp_baja_cliente (@idcliente numeric(10,0)) as
begin
	update QUIERO_APROBAR.Cliente
	set Cliente_habilitado = 0
	where ID_cliente = @idcliente
end
GO


-- Alta auto


IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_alta_automovil' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_alta_automovil
GO

create procedure QUIERO_APROBAR.sp_alta_automovil (@idchofer numeric(10,0),@idmodelo numeric(10,0),@patente varchar(10),@licencia varchar(10),@rodado varchar(10), @idTurno numeric(10,0))
as
begin

if (QUIERO_APROBAR.choferYaAsignado (@idchofer, @idTurno, null)=1)
	
	THROW 51000, 'El chofer ya tiene un auto asignado en el turno seleccionado', 1;														

else
	insert into QUIERO_APROBAR.Autos (auto_chofer,auto_modelo,auto_patente,auto_licencia,auto_rodado, auto_turno)
	values(@idchofer, @idmodelo, @patente, @licencia, @rodado,  @idTurno)

end
GO


-- Modificar info del automovil

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_update_automovil' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_update_automovil
GO

create procedure QUIERO_APROBAR.sp_update_automovil (@id numeric(10,0),@idchofer numeric(10,0),@idmodelo numeric(10,0),@patente varchar(10),@licencia varchar(10),@rodado varchar(10),@habilitado numeric(1,0), @idTurno numeric(10,0)) as
begin
	
if (QUIERO_APROBAR.choferYaAsignado (@idchofer,  @idTurno, @id)=1)
	
	THROW 51000, 'El chofer ya tiene un auto asignado en el turno seleccionado.', 1;												

else

	update 	QUIERO_APROBAR.Autos
	set 	auto_chofer = @idchofer,
		auto_modelo = @idmodelo,
		auto_patente = @patente,
		auto_licencia = @licencia,
		auto_rodado = @rodado,
		auto_habilitado = @habilitado,
		auto_turno = @idTurno
	where	ID_auto = @id;
end
GO

-- Dar de baja auto

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_baja_automovil' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_baja_automovil
GO

create procedure QUIERO_APROBAR.sp_baja_automovil (@idauto numeric(10,0)) as
begin
	update QUIERO_APROBAR.Autos
	set auto_habilitado = 0
	where ID_auto = @idauto
end
GO


-- Alta chofer

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_alta_chofer' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_alta_chofer
GO

create procedure QUIERO_APROBAR.sp_alta_chofer (@nombre varchar(250), @apellido varchar(250), @fechanac date, @dni numeric(10,0), @direccion varchar(250), @telefono numeric(18,0), @email varchar(250))
as
begin
	declare @usuario varchar(255)
	declare @contraseña varchar(255)
	set @usuario =   convert(varchar(255), @dni)
	set @contraseña =   convert(varchar(255), @dni)

	exec QUIERO_APROBAR.sp_alta_usuario @usuario, @contraseña

	insert into QUIERO_APROBAR.Chofer (chofer_usuario ,chofer_nombre ,chofer_apellido, chofer_fecha_nacimiento ,chofer_dni, chofer_direccion,chofer_telefono ,chofer_email)
	values((select ID_usuario from QUIERO_APROBAR.Usuario where Username=@dni), @nombre, @apellido, @fechanac, @dni, @direccion, @telefono, @email)

end
GO


-- Modificacion chofer

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_update_chofer' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_update_chofer
GO

create procedure QUIERO_APROBAR.sp_update_chofer (@nombre varchar(250), @apellido varchar(250), @fechanac date, @dni numeric(10,0), @direccion varchar(250), @telefono numeric(18,0), @email varchar(250), @habilitado numeric(1,0), @idChofer numeric(10,0))
as
begin

update QUIERO_APROBAR.Chofer
set chofer_nombre = @nombre,
chofer_apellido = @apellido,
chofer_fecha_nacimiento = @fechanac,
chofer_dni = @dni,
chofer_direccion = @direccion,
chofer_telefono = @telefono,
chofer_email = @email,
chofer_habilitado = @habilitado
where ID_chofer = @idChofer

end
GO

--Eliminar chofer

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_baja_chofer' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_baja_chofer
GO

create procedure QUIERO_APROBAR.sp_baja_chofer (@idchofer numeric(10,0)) as
begin
	update QUIERO_APROBAR.Chofer
	set chofer_habilitado = 0
	where ID_chofer = @idchofer
end
GO


-- Alta viaje

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_alta_viaje' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_alta_viaje
GO

create procedure QUIERO_APROBAR.sp_alta_viaje (@idChofer numeric(10,0), @idAuto numeric(10,0), @idTurno numeric(10,0), @idCliente numeric(10,0), @cantKM numeric(5,0), @horaIn time(7) , @horaFin time(7)) as
begin
	insert into QUIERO_APROBAR.Viaje (viaje_chofer, viaje_auto, viaje_turno, viaje_cliente, viaje_cantidad_km, viaje_hora_inicio, viaje_hora_fin) 
	values (@idChofer, @idAuto, @idTurno, @idCliente, @cantKM, @horaIn , @horaFin)
end
GO


-- Ultima actualizacion de % pago

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_obtenerPorcentajeActual' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_obtenerPorcentajeActual
GO

create procedure QUIERO_APROBAR.sp_obtenerPorcentajeActual as
begin
	select top 1 porcentaje_valor
	from QUIERO_APROBAR.Porcentaje
	order by ID_porcentaje desc
end
GO


-- Pagar al chofer los viajes de 1 dia

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_alta_rendicion' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_alta_rendicion
GO

create procedure QUIERO_APROBAR.sp_alta_rendicion (@idChofer numeric(10,0), @fecha date, @idTurno numeric(10,0)) as
begin
declare @idRendicion int

	if(QUIERO_APROBAR.ExisteRendicion(@idChofer, @idTurno, @fecha) = 1) THROW 51000, 'Ya se realizó la rendicion', 1;	

	insert into QUIERO_APROBAR.Rendicion (rendicion_importe, rendicion_fecha, rendicion_chofer, rendicion_turno, rendicion_porcentaje)
		values( ((select sum(QUIERO_APROBAR.calcularImporteViaje(Cod_viaje))
					from QUIERO_APROBAR.Viaje
					where viaje_chofer = @idchofer
					and viaje_fecha_viaje = @fecha
					and viaje_turno = @idTurno) * (select top 1 porcentaje_valor from QUIERO_APROBAR.Porcentaje order by ID_porcentaje desc)) , @fecha, @idchofer, @idTurno,  (select max(ID_porcentaje) from QUIERO_APROBAR.Porcentaje))
	
	set @idRendicion = ((select ID_rendicion from QUIERO_APROBAR.Rendicion where rendicion_chofer= @idChofer and rendicion_fecha = @fecha))

	insert into QUIERO_APROBAR.Detalle_Rendicion(Rendicion)
	values (@idRendicion)

	update QUIERO_APROBAR.Viaje
	set viaje_rendicion = @idRendicion
	where viaje_chofer = @idChofer and viaje_fecha_viaje = @fecha and viaje_turno = @idTurno

end
GO



-- facturacion entre fechas

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_alta_factura' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_alta_factura
GO

create procedure QUIERO_APROBAR.sp_alta_factura (@idCliente numeric(10,0), @fechaDesde date, @fechaHasta date) as
begin
declare @idfactura int

	if(QUIERO_APROBAR.ExisteFacturacion(@idCliente, @fechaDesde, @fechaHasta) = 1) THROW 51000, 'Ya se realizó la facturación solicitada', 1;
	
	insert into QUIERO_APROBAR.Facturas(factura_importe, factura_cliente, factura_fecha_fin, factura_fecha_inicio, factura_numero)
		values( ((select sum(QUIERO_APROBAR.calcularImporteViaje(Cod_viaje))
					from QUIERO_APROBAR.viaje
					where viaje_cliente = @idCliente
					and viaje_fecha_viaje between @fechaDesde and @fechaHasta)) , @idCliente, @fechaHasta, @fechaDesde,  (select max(factura_numero) + 1 from QUIERO_APROBAR.Facturas))
	
	set @idfactura = ((select Cod_factura from QUIERO_APROBAR.Facturas where factura_cliente = @idCliente and factura_fecha_inicio = @fechaDesde and factura_fecha_fin = @fechaHasta))

	insert into QUIERO_APROBAR.Detalle_Factura(Factura)
	values (@idfactura)

	update QUIERO_APROBAR.Viaje
	set viaje_factura = @idfactura
	where viaje_cliente = @idCliente and viaje_fecha_viaje between @fechaDesde and @fechaHasta

end
GO

-- Verificacion si el horario es valido

IF EXISTS (SELECT name FROM sysobjects WHERE name='turno_horario_valido' AND type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
	DROP FUNCTION QUIERO_APROBAR.turno_horario_valido
GO

create function QUIERO_APROBAR.turno_horario_valido(@horaInicio NUMERIC(18,0), @horaFin NUMERIC(18,0))
returns bit
begin
declare @retorno bit

	if	(@horaFin > @horaInicio) 
		set @retorno = 1
	else 
		set @retorno = 0

return @retorno

end
GO


-- Alta de turnos para disponibilidad

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_alta_turno' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_alta_turno
GO

create procedure QUIERO_APROBAR.sp_alta_turno (@horaInicio numeric(18,0), @horaFin numeric(18,0), @descripcion varchar(250), @valorKM numeric(10,2), @precioBase numeric(10,2)) 
as
begin
	
	if(QUIERO_APROBAR.turno_horario_valido(@horaInicio, @horaFin) = 0) THROW 53000, 'Horario invalido', 1;

	insert into QUIERO_APROBAR.Turnos (turno_hora_inicio, turno_hora_fin, turno_descripcion, turno_valor_km, turno_precio_base) 
	values (@horaInicio, @horaFin, @descripcion, @valorKM, @precioBase)
end
GO


-- Dar de bajar turno


IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_baja_turno' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_baja_turno
GO

create procedure QUIERO_APROBAR.sp_baja_turno (@idTurno numeric (10,0)) as
begin
	
	update QUIERO_APROBAR.turnos
	set 	turno_habilitado = 0
	where 	Cod_turno = @idTurno;
end
GO


-- Calculo rendicion

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_importe_rendicion' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_importe_rendicion
GO

create procedure QUIERO_APROBAR.sp_get_importe_rendicion (@idRendicion numeric(10,0)) as
begin
		select rendicion_importe
		from QUIERO_APROBAR.Rendicion
		where ID_rendicion = @idRendicion
end
GO



-- Obetner funcionaldiades de un rol

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_funcionalidades_rol' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_funcionalidades_rol
GO

create procedure QUIERO_APROBAR.sp_get_funcionalidades_rol(@idRol numeric(10,0)) as
begin
	select f.*
	from QUIERO_APROBAR.Funcionalidad f, QUIERO_APROBAR.Rol_Funcionalidad rf
	where @idRol = rf.ID_rol
	and rf.ID_funcionalidad = f.ID_Funcionalidad
end
GO

-- todas las funcionalidades


IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_funcionalidades' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_funcionalidades
GO

create procedure  QUIERO_APROBAR.sp_get_funcionalidades as
begin
	select * 
	from  QUIERO_APROBAR.Funcionalidad
end
GO


-- Todas las marcas de autos

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_marcas' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_marcas
GO

create procedure QUIERO_APROBAR.sp_get_marcas as
begin
	select *
	from QUIERO_APROBAR.Marca
end
GO


-- todos los modelos

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_modelos' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_modelos
GO

create procedure QUIERO_APROBAR.sp_get_modelos as
begin
	select *
	from QUIERO_APROBAR.Modelo
end
GO


-- Turnos habilitados

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_turnos_habilitados' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_turnos_habilitados
GO

create procedure QUIERO_APROBAR.sp_get_turnos_habilitados as
begin
	select *
	from QUIERO_APROBAR.Turnos
	where turno_habilitado = 1
end
GO


-- turnos tomados por un autovil

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_turnos_automovil' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_turnos_automovil
GO

create procedure QUIERO_APROBAR.sp_get_turnos_automovil(@idAuto numeric(10,0)) as
begin
	select t.*
	from QUIERO_APROBAR.Turnos t, QUIERO_APROBAR.Autos_Turnos at
	where at.Auto = @idAuto
	and t.Cod_turno= at.ID_auto_turno
end
GO

-- Autos de un chofer

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_automoviles_chofer' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_automoviles_chofer
GO

create procedure QUIERO_APROBAR.sp_get_automoviles_chofer(@idChofer numeric(10,0)) as
begin
	select *
	from QUIERO_APROBAR.Autos
	where auto_chofer = @idChofer
end
GO


-- Autos habilitados de un chofer

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_automovilesHabilitados_chofer' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_automovilesHabilitados_chofer
GO

create procedure QUIERO_APROBAR.sp_get_automovilesHabilitados_chofer(@idChofer numeric(10,0)) as
begin
	select *
	from QUIERO_APROBAR.Autos
	where auto_chofer = @idChofer
	and auto_habilitado = 1
end
GO


-- total de un factura

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_importe_factura' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_importe_factura
GO

create procedure QUIERO_APROBAR.sp_get_importe_factura (@idFactura numeric(10,0)) as
begin
		select factura_importe
		from QUIERO_APROBAR.Facturas
		where Cod_factura = @idFactura
end
GO


-- Viaje de un rendicion


IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_viajes_rendicion' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_viajes_rendicion
GO

create procedure QUIERO_APROBAR.sp_get_viajes_rendicion(@idRendicion numeric(10,0)) as
begin

select v.*, (QUIERO_APROBAR.calcularimporteViaje(v.Cod_viaje) * (select top 1 porcentaje_valor from QUIERO_APROBAR.Porcentaje order by ID_porcentaje desc))
from QUIERO_APROBAR.Viaje v, QUIERO_APROBAR.Detalle_Rendicion rd
where rd.Rendicion = @idRendicion
and v.viaje_rendicion = rd.ID_detalle_rendicion

end
GO


-- Viajes de una factura

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_viajes_factura' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_viajes_factura
GO

create procedure QUIERO_APROBAR.sp_get_viajes_factura(@idFactura numeric(10,0)) as
begin

select v.*, QUIERO_APROBAR.calcularimporteViaje(v.Cod_viaje)
from QUIERO_APROBAR.Viaje v, QUIERO_APROBAR.Detalle_Factura fd
where fd.Factura = @idFactura
and v.viaje_factura = fd.ID_Detalle_Factura

end
GO


-- Relacion modelo marca

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_modelos_marca' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_modelos_marca
GO

create procedure QUIERO_APROBAR.sp_get_modelos_marca(@idMarca numeric(10,0)) as
begin

select *
from QUIERO_APROBAR.Modelo
where Marca = @idMarca

end

GO

-- Busqueda de clientes

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_clientes' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_clientes
GO

create procedure QUIERO_APROBAR.sp_get_clientes(@nombre varchar(250), @apellido varchar(250), @dni numeric(18,0)) as
begin

select *
from QUIERO_APROBAR.Cliente
where (@apellido is null or (cliente_apellido like CONCAT('%',@apellido,'%')))
and   (@nombre is null or   (cliente_nombre like CONCAT('%',@nombre,'%')))
and	  (@dni is null or (cliente_dni = @dni))

OPTION (RECOMPILE)
end
go



-- Clientes habilitados

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_clientesHabilitados' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_clientesHabilitados
GO

create procedure QUIERO_APROBAR.sp_get_clientesHabilitados(@nombre varchar(250), @apellido varchar(250), @dni numeric(18,0)) as
begin

select *
from QUIERO_APROBAR.Cliente
where (@apellido is null or (cliente_apellido like CONCAT('%',@apellido,'%')))
and   (@nombre is null or   (cliente_nombre like CONCAT('%',@nombre,'%')))
and	  (@dni is null or (cliente_dni = @dni))
and cliente_habilitado = 1

OPTION (RECOMPILE)
end
go


-- obtiene choferes

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_choferes' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_choferes
GO

create procedure QUIERO_APROBAR.sp_get_choferes(@nombre varchar(250), @apellido varchar(250), @dni numeric(18,0)) as
begin

select *
from QUIERO_APROBAR.Chofer
where (@apellido is null or (chofer_apellido like CONCAT('%',@apellido,'%')))
and   (@nombre is null or   (chofer_nombre like CONCAT('%',@nombre,'%')))
and	  (@dni is null or (chofer_dni = @dni))

OPTION (RECOMPILE)
end
go


-- Choferes habiltiados


IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_choferesHabilitados' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_choferesHabilitados
GO

create procedure  QUIERO_APROBAR.sp_get_choferesHabilitados(@nombre varchar(250), @apellido varchar(250), @dni numeric(18,0)) as
begin

select *
from  QUIERO_APROBAR.Chofer
where (@apellido is null or (chofer_apellido like CONCAT('%',@apellido,'%')))
and   (@nombre is null or   (chofer_nombre like CONCAT('%',@nombre,'%')))
and	  (@dni is null or (chofer_dni = @dni))
and chofer_habilitado = 1

OPTION (RECOMPILE)
end
go

-- Automoviles


IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_automoviles' AND type='p')
	DROP PROCEDURE  QUIERO_APROBAR.sp_get_automoviles
GO

create procedure  QUIERO_APROBAR.sp_get_automoviles(@idMarca numeric(10,0), @modelo varchar(250), @patente varchar(10), @idChofer numeric(10,0)) as
begin

select a.*
from  QUIERO_APROBAR.Autos a,  QUIERO_APROBAR.Modelo m
where a.auto_modelo = m.ID_modelo
and (@idMarca is null or (@idMarca = m.Marca))
and (@modelo is null or (@modelo = m.modelo_descripcion))
and (@patente is null or (@patente = auto_patente))
and (@idChofer is null or (@idChofer = auto_chofer))

OPTION (RECOMPILE)
end
go


-- Automoviles habiltiados

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_automovilesHabilitados' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_automovilesHabilitados
GO

create procedure QUIERO_APROBAR.sp_get_automovilesHabilitados(@idMarca numeric(10,0), @modelo varchar(250), @patente varchar(10), @idChofer numeric(10,0)) as
begin

select a.*
from QUIERO_APROBAR.Autos a, QUIERO_APROBAR.Modelo m
where a.auto_modelo = m.ID_modelo
and (@idMarca is null or (@idMarca = m.Marca))
and (@modelo is null or (@modelo = m.modelo_descripcion))
and (@patente is null or (@patente = auto_patente))
and (@idChofer is null or (@idChofer = auto_chofer))
and auto_habilitado = 1

OPTION (RECOMPILE)
end
go


-- todos los Turnos

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_turnos' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_turnos
GO

create procedure QUIERO_APROBAR.sp_get_turnos(@descripcion varchar(255)) as
begin

select *
from QUIERO_APROBAR.Turnos
where (@descripcion is null or (@descripcion = turno_descripcion))

OPTION(RECOMPILE)
end
go


-- detalle automovil

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_get_automovilDetalles' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_get_automovilDetalles
GO

create procedure QUIERO_APROBAR.sp_get_automovilDetalles(@idAuto numeric(10,0)) as
begin

select ma.marca_descripcion, mo.modelo_descripcion, a.auto_patente, c.chofer_nombre, c.chofer_apellido, t.turno_descripcion, a.auto_licencia, a.auto_rodado, a.auto_habilitado
from QUIERO_APROBAR.Autos a, QUIERO_APROBAR.Marca ma, QUIERO_APROBAR.Modelo mo, QUIERO_APROBAR.Chofer c, QUIERO_APROBAR.Turnos t
where a.auto_chofer = c.ID_chofer
and a.auto_modelo = mo.ID_modelo
and mo.Marca = ID_Marca
and a.auto_turno = t.Cod_turno

end
GO



-- turno valido

IF EXISTS (SELECT name FROM sysobjects WHERE name='validar_datos_turno' AND type = 'p')
	DROP PROCEDURE  QUIERO_APROBAR.validar_datos_turno
GO

create procedure  QUIERO_APROBAR.validar_datos_turno(@horaInicio time(7), @horaFin time(7), @descripcion varchar(250)) as

begin


	if	(@horaFin > @horaInicio) THROW 53000, 'Horario invalido', 1;

	if 	((select count (*) from  QUIERO_APROBAR.turnos where turno_descripcion = @descripcion) > 0) THROW 5400, 'Ya existe un turno con esta descripcion', 1;

	--if	() THROW 5500, 'El turno se superpone con otro ya habilitado', 1;

end
GO



-- Modificar turno

IF EXISTS (SELECT name FROM sysobjects WHERE name='sp_update_turno' AND type='p')
	DROP PROCEDURE QUIERO_APROBAR.sp_update_turno
GO

create procedure QUIERO_APROBAR.sp_update_turno(@idTurno numeric(18,0), @horaInicio numeric(18,0), @horaFin numeric(18,0), @descripcion varchar(250), @valorKM numeric(10,2), @precioBase numeric(10,2)) 
as
begin
	
	if(QUIERO_APROBAR.turno_horario_valido(@horaInicio, @horaFin) = 0) THROW 53000, 'Horario invalido', 1;

	update 	QUIERO_APROBAR.turnos
	set 	turno_hora_inicio = @horaInicio,
		turno_hora_fin = @horaFin,
		turno_descripcion = @descripcion,
		turno_valor_km = @valorKM,
		turno_precio_base = @precioBase
	where 	Cod_turno = @idTurno;
end
GO
















