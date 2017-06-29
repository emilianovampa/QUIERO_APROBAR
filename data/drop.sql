use GD1C2017
GO


	DROP TABLE QUIERO_APROBAR.Funcionalidad

	DROP TABLE QUIERO_APROBAR.Rol

	DROP TABLE QUIERO_APROBAR.Rol_Funcionalidad

	DROP TABLE QUIERO_APROBAR.Usuario_Rol

	DROP TABLE QUIERO_APROBAR.Cliente

	DROP TABLE QUIERO_APROBAR.Detalle_Factura

	DROP TABLE QUIERO_APROBAR.Facturas

	DROP TABLE QUIERO_APROBAR.Autos_Turnos

	DROP TABLE QUIERO_APROBAR.Autos

	DROP TABLE QUIERO_APROBAR.Rendicion

	DROP TABLE QUIERO_APROBAR.Viaje

	DROP TABLE QUIERO_APROBAR.Turnos

	DROP TABLE QUIERO_APROBAR.Usuario

	DROP TABLE QUIERO_APROBAR.Chofer

	DROP TABLE QUIERO_APROBAR.Marca

	DROP TABLE QUIERO_APROBAR.Modelo

	DROP TABLE QUIERO_APROBAR.Porcentaje

	DROP TABLE QUIERO_APROBAR.Detalle_Rendicion


DROP TRIGGER QUIERO_APROBAR.tr_baja_rol

DROP TYPE funcionalidadesList



DROP FUNCTION QUIERO_APROBAR.trimestre
DROP FUNCTION QUIERO_APROBAR.existeUsuario
DROP FUNCTION QUIERO_APROBAR.usuarioActivo
DROP FUNCTION QUIERO_APROBAR.choferYaAsignado
DROP FUNCTION QUIERO_APROBAR.calcularimporteViaje
DROP FUNCTION  QUIERO_APROBAR.ExisteRendicion
DROP FUNCTION QUIERO_APROBAR.ExisteFacturacion
DROP FUNCTION QUIERO_APROBAR.existeClienteConMismoTelefono
DROP FUNCTION QUIERO_APROBAR.turno_horario_valido


DROP PROCEDURE QUIERO_APROBAR.sp_choferes_con_mayor_recaudacion
DROP PROCEDURE QUIERO_APROBAR.sp_choferes_con_viaje_mas_largo
DROP PROCEDURE QUIERO_APROBAR.sp_clientes_con_mayor_consumo
DROP PROCEDURE QUIERO_APROBAR.sp_clientes_mayor_uso_mismo_auto
DROP PROCEDURE QUIERO_APROBAR.sp_baja_rol
DROP PROCEDURE QUIERO_APROBAR.sp_alta_rol
DROP PROCEDURE QUIERO_APROBAR.sp_update_rol
DROP PROCEDURE QUIERO_APROBAR.sp_get_roles_habilitados
DROP PROCEDURE QUIERO_APROBAR.sp_get_roles
DROP PROCEDURE QUIERO_APROBAR.sp_limpiar_intentos_fallidos
DROP PROCEDURE QUIERO_APROBAR.sp_incrementar_intentos_fallidos
DROP PROCEDURE QUIERO_APROBAR.sp_login_check
DROP PROCEDURE QUIERO_APROBAR.sp_get_roles_usuario
DROP PROCEDURE QUIERO_APROBAR.sp_alta_usuario
DROP PROCEDURE QUIERO_APROBAR.sp_alta_cliente
DROP PROCEDURE QUIERO_APROBAR.sp_update_cliente
DROP PROCEDURE QUIERO_APROBAR.sp_baja_cliente
DROP PROCEDURE QUIERO_APROBAR.sp_alta_automovil
DROP PROCEDURE QUIERO_APROBAR.sp_update_automovil
DROP PROCEDURE QUIERO_APROBAR.sp_baja_automovil
DROP PROCEDURE QUIERO_APROBAR.sp_alta_chofer
DROP PROCEDURE QUIERO_APROBAR.sp_update_chofer
DROP PROCEDURE QUIERO_APROBAR.sp_baja_chofer
DROP PROCEDURE QUIERO_APROBAR.sp_alta_viaje
DROP PROCEDURE QUIERO_APROBAR.sp_obtenerPorcentajeActual
DROP PROCEDURE QUIERO_APROBAR.sp_alta_rendicion
DROP PROCEDURE QUIERO_APROBAR.sp_alta_factura
DROP PROCEDURE QUIERO_APROBAR.sp_alta_turno
DROP PROCEDURE QUIERO_APROBAR.sp_baja_turno
DROP PROCEDURE QUIERO_APROBAR.sp_get_importe_rendicion
DROP PROCEDURE QUIERO_APROBAR.sp_get_funcionalidades_rol
DROP PROCEDURE QUIERO_APROBAR.sp_get_funcionalidades
DROP PROCEDURE QUIERO_APROBAR.sp_get_marcas
DROP PROCEDURE QUIERO_APROBAR.sp_get_modelos
DROP PROCEDURE QUIERO_APROBAR.sp_get_turnos_habilitados
DROP PROCEDURE QUIERO_APROBAR.sp_get_turnos_automovil
DROP PROCEDURE QUIERO_APROBAR.sp_get_automoviles_chofer
DROP PROCEDURE QUIERO_APROBAR.sp_get_automovilesHabilitados_chofer
DROP PROCEDURE QUIERO_APROBAR.sp_get_importe_factura
DROP PROCEDURE QUIERO_APROBAR.sp_get_viajes_rendicion
DROP PROCEDURE QUIERO_APROBAR.sp_get_viajes_factura
DROP PROCEDURE QUIERO_APROBAR.sp_get_modelos_marca
DROP PROCEDURE QUIERO_APROBAR.sp_get_clientes
DROP PROCEDURE QUIERO_APROBAR.sp_get_clientesHabilitados
DROP PROCEDURE QUIERO_APROBAR.sp_get_choferes
DROP PROCEDURE QUIERO_APROBAR.sp_get_choferesHabilitados
DROP PROCEDURE  QUIERO_APROBAR.sp_get_automoviles
DROP PROCEDURE QUIERO_APROBAR.sp_get_automovilesHabilitados
DROP PROCEDURE QUIERO_APROBAR.sp_get_turnos
DROP PROCEDURE QUIERO_APROBAR.sp_get_automovilDetalles
DROP PROCEDURE  QUIERO_APROBAR.validar_datos_turno
DROP PROCEDURE QUIERO_APROBAR.sp_update_turno





































