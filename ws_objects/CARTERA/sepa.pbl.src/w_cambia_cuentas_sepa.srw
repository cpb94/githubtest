$PBExportHeader$w_cambia_cuentas_sepa.srw
forward
global type w_cambia_cuentas_sepa from w_int_con_empresa
end type
type pb_2 from upb_salir within w_cambia_cuentas_sepa
end type
type dw_errores from u_datawindow within w_cambia_cuentas_sepa
end type
type cb_updatear_tablas from commandbutton within w_cambia_cuentas_sepa
end type
type pb_imprimir_preli from picturebutton within w_cambia_cuentas_sepa
end type
end forward

global type w_cambia_cuentas_sepa from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3671
integer height = 2044
pb_2 pb_2
dw_errores dw_errores
cb_updatear_tablas cb_updatear_tablas
pb_imprimir_preli pb_imprimir_preli
end type
global w_cambia_cuentas_sepa w_cambia_cuentas_sepa

type variables
//str_contaparam istr_contaparam
end variables

event open;call super::open;This.title = "CAMBIO CUENTAS SEPA"
end event

on w_cambia_cuentas_sepa.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_errores=create dw_errores
this.cb_updatear_tablas=create cb_updatear_tablas
this.pb_imprimir_preli=create pb_imprimir_preli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_errores
this.Control[iCurrent+3]=this.cb_updatear_tablas
this.Control[iCurrent+4]=this.pb_imprimir_preli
end on

on w_cambia_cuentas_sepa.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.dw_errores)
destroy(this.cb_updatear_tablas)
destroy(this.pb_imprimir_preli)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cambia_cuentas_sepa
integer x = 1527
integer y = 320
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cambia_cuentas_sepa
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cambia_cuentas_sepa
integer width = 2642
end type

type pb_2 from upb_salir within w_cambia_cuentas_sepa
integer x = 3502
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_errores from u_datawindow within w_cambia_cuentas_sepa
integer x = 9
integer y = 224
integer width = 3611
integer height = 1732
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Errores"
string dataobject = "dw_cambia_cuentas_sepa"
boolean vscrollbar = true
end type

type cb_updatear_tablas from commandbutton within w_cambia_cuentas_sepa
integer x = 14
integer y = 128
integer width = 1193
integer height = 92
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Modificar Cuentas"
end type

event clicked;string ls_sel,ls_codigo,ls_nombre,ls_entidad,ls_oficina,ls_control,ls_cuenta,ls_tabla,ls_cliente
string ls_codigo_swift_actual,ls_codigo_swift_nuevo,ls_proveedoR
string ls_codigo_iban_actual,ls_codigo_iban_nuevo
long   ll_indice,ll_total,ll_donde

datastore ds_datos

if messagebox("Confirmación!","¿Desea modificar las cuentas?",Question!,YesNo!,2) = 1 then	
	dw_errores.reset()
	
	ls_tabla = 'CARBANCOS'
	
	ls_sel = "select carbancos.banco, "+&
				"       carbancos.nombre, "+&
				"       carbancos.nuestracta, "+&
				"       carbancos.entidad, "+&
				"       carbancos.oficina, "+&
				"       carbancos.control, "+&
				"       isnull(carbancos.codigo_swift,'') codigo_swift, "+&
				"       isnull(carbancos.codigo_iban,'') codigo_iban "+&
				"from   carbancos "+&
				"where  carbancos.empresa = '"+codigo_empresa+"' " +&
				"and    carbancos.pais in (select paises.pais from paises where tipopais = 'N') "
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total	
		f_mensaje_proceso(ls_tabla,ll_indice,ll_total)
		
		ls_codigo  = ds_datos.object.banco[ll_indice]
		ls_nombre  = ds_datos.object.nombre[ll_indice]
		ls_entidad = ds_datos.object.entidad[ll_indice]
		ls_oficina = ds_datos.object.oficina[ll_indice]
		ls_control = ds_datos.object.control[ll_indice]
		ls_cuenta  = ds_datos.object.nuestracta[ll_indice]
		
		ls_codigo_swift_actual = ds_datos.object.codigo_swift[ll_indice]
		ls_codigo_iban_actual  = ds_datos.object.codigo_iban[ll_indice]
		
		if ls_codigo_swift_actual = '' then
			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
			
			update carbancos
			set    carbancos.codigo_swift = :ls_codigo_swift_nuevo
			where  carbancos.empresa = :codigo_empresa
			and    carbancos.banco   = :ls_codigo;
			
			if sqlca.sqlcode <> 0 then 
				rollback;
				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_codigo)				
			else
				commit;
			end if	
			
			if isnull(ls_entidad) then ls_entidad = ''
			if trim(ls_codigo_swift_nuevo) = '' and trim(ls_entidad) <> '' then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con swift en blanco"
			end if
		else
			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
			
			if ls_codigo_swift_actual <> ls_codigo_swift_nuevo then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con swift distinto al calculado "+ls_codigo_swift_actual+"<>"+ls_codigo_swift_nuevo
			end if
		end if		
		
		if ls_codigo_iban_actual = '' then
			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
			
			update carbancos
			set    carbancos.codigo_iban = :ls_codigo_iban_nuevo
			where  carbancos.empresa = :codigo_empresa
			and    carbancos.banco   = :ls_codigo;			
			
			if sqlca.sqlcode <> 0 then 
				rollback;
				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_codigo)				
			else
				commit;
			end if		
		else
			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
			
			if ls_codigo_iban_actual <> ls_codigo_iban_nuevo then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con iban distinto al calculado "+ls_codigo_iban_actual+"<>"+ls_codigo_iban_nuevo
			end if									
		end if					

	next
	
//	ls_tabla = 'NOMEMPLEADOS'
//	
//	ls_sel = "select nomempleados.empleado, "+&
//				"       nomempleados.nombre+' '+nomempleados.apellido1+' '+nomempleados.apellido2 as nombre, "+&
//				"       nomempleados.cuenta_banco, "+&
//				"       nomempleados.entidad_banco, "+&
//				"       nomempleados.oficina_banco, "+&
//				"       nomempleados.control_banco, "+&
//				"       isnull(nomempleados.codigo_swift,'') codigo_swift, "+&
//				"       isnull(nomempleados.codigo_iban,'') codigo_iban "+&
//				"from   nomempleados "+&
//				"where  nomempleados.empresa = '"+codigo_empresa+"' " 
//				
//	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
//	
//	for ll_indice = 1 to ll_total	
//		f_mensaje_proceso(ls_tabla,ll_indice,ll_total)
//		
//		ls_codigo  = ds_datos.object.empleado[ll_indice]
//		ls_nombre  = ds_datos.object.nombre[ll_indice]
//		ls_entidad = ds_datos.object.entidad_banco[ll_indice]
//		ls_oficina = ds_datos.object.oficina_banco[ll_indice]
//		ls_control = ds_datos.object.control_banco[ll_indice]
//		ls_cuenta  = ds_datos.object.cuenta_banco[ll_indice]
//		
//		ls_codigo_swift_actual = ds_datos.object.codigo_swift[ll_indice]
//		ls_codigo_iban_actual  = ds_datos.object.codigo_iban[ll_indice]
//		
//		if ls_codigo_swift_actual = '' then
//			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
//			
//			update nomempleados
//			set    nomempleados.codigo_swift = :ls_codigo_swift_nuevo
//			where  nomempleados.empresa = :codigo_empresa
//			and    nomempleados.empleado = :ls_codigo;
//			
//			if sqlca.sqlcode <> 0 then 
//				rollback;
//				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_codigo)				
//			else
//				commit;
//			end if	
//		else
//			
//		end if		
//		
//		if ls_codigo_iban_actual = '' then
//			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
//			
//			update nomempleados
//			set    nomempleados.codigo_iban = :ls_codigo_iban_nuevo
//			where  nomempleados.empresa = :codigo_empresa
//			and    nomempleados.empleado = :ls_codigo;			
//			
//			if sqlca.sqlcode <> 0 then 
//				rollback;
//				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_codigo)				
//			else
//				commit;
//			end if		
//		else
//			
//		end if					
//						
//						
//	next

	ls_tabla = 'VENDOMICILIACION'
	
	ls_sel = "select vendomiciliacion.cliente, "+&
				"       vendomiciliacion.codigo, "+&
				"       genter.razon+' '+vendomiciliacion.nombrebanco as nombre, "+&
				"       vendomiciliacion.cuenta, "+&
				"       vendomiciliacion.entidad, "+&
				"       vendomiciliacion.oficina, "+&
				"       vendomiciliacion.control, "+&
				"       isnull(vendomiciliacion.codigo_swift,'') codigo_swift, "+&
				"       isnull(vendomiciliacion.codigo_iban,'') codigo_iban "+&
				"from   vendomiciliacion,genter "+&
				"where  vendomiciliacion.empresa = genter.empresa "+&
				"and    vendomiciliacion.cliente = genter.codigo "+&
				"and    vendomiciliacion.empresa = '"+codigo_empresa+"' "+&
				"and    genter.tipoter           = 'C' "+&
				"and  ( isnull(vendomiciliacion.pais,'') in (select paises.pais from paises where tipopais = 'N') "+& 
				"or     isnull(genter.pais,'') in (select paises.pais from paises where tipopais = 'N') )"
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total	
		f_mensaje_proceso(ls_tabla,ll_indice,ll_total)
		
		ls_cliente = ds_datos.object.vendomiciliacion_cliente[ll_indice]
		ls_codigo  = ds_datos.object.vendomiciliacion_codigo[ll_indice]
		ls_nombre  = ds_datos.object.nombre[ll_indice]
		ls_entidad = ds_datos.object.vendomiciliacion_entidad[ll_indice]
		ls_oficina = ds_datos.object.vendomiciliacion_oficina[ll_indice]
		ls_control = ds_datos.object.vendomiciliacion_control[ll_indice]
		ls_cuenta  = ds_datos.object.vendomiciliacion_cuenta[ll_indice]
		
		ls_codigo_swift_actual = ds_datos.object.codigo_swift[ll_indice]
		ls_codigo_iban_actual  = ds_datos.object.codigo_iban[ll_indice]
		
		if ls_codigo_swift_actual = '' then
			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
			
			update vendomiciliacion
			set    vendomiciliacion.codigo_swift = :ls_codigo_swift_nuevo
			where  vendomiciliacion.empresa = :codigo_empresa
			and    vendomiciliacion.cliente = :ls_cliente
			and    vendomiciliacion.codigo  = :ls_codigo;
			
			if sqlca.sqlcode <> 0 then 
				rollback;
				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_cliente+"/"+ls_codigo)				
			else
				commit;
			end if	
			
			if isnull(ls_entidad) then ls_entidad = ''
			if trim(ls_codigo_swift_nuevo) = '' and trim(ls_entidad) <> '' then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_cliente+"-"+ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con swift en blanco"
			end if			
		else
			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
			
			if ls_codigo_swift_actual <> ls_codigo_swift_nuevo then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_cliente+"-"+ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con swift distinto al calculado "+ls_codigo_swift_actual+"<>"+ls_codigo_swift_nuevo
			end if			
		end if		
		
		if ls_codigo_iban_actual = '' then
			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
			
			update vendomiciliacion
			set    vendomiciliacion.codigo_iban = :ls_codigo_iban_nuevo
			where  vendomiciliacion.empresa = :codigo_empresa
			and    vendomiciliacion.cliente = :ls_cliente
			and    vendomiciliacion.codigo  = :ls_codigo;		
			
			if sqlca.sqlcode <> 0 then 
				rollback;
				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_cliente+"/"+ls_codigo)			
			else
				commit;
			end if		
		else
			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
			
			if ls_codigo_iban_actual <> ls_codigo_iban_nuevo then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_cliente+"-"+ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con iban distinto al calculado "+ls_codigo_iban_actual+"<>"+ls_codigo_iban_nuevo
			end if												
		end if					
						
						
	next

//	ls_tabla = 'COMDOMICILIACION'
//	
//	ls_sel = "select comdomiciliacion.proveedor, "+&
//				"       comdomiciliacion.codigo, "+&
//				"       comdomiciliacion.nombrebanco, "+&
//				"       comdomiciliacion.cuenta, "+&
//				"       comdomiciliacion.entidad, "+&
//				"       comdomiciliacion.oficina, "+&
//				"       comdomiciliacion.control, "+&
//				"       isnull(comdomiciliacion.codigo_swift,'') codigo_swift, "+&
//				"       isnull(comdomiciliacion.codigo_iban,'') codigo_iban "+&
//				"from   comdomiciliacion,genter "+&
//				"where  comdomiciliacion.empresa = genter.empresa "+&
//				"and    comdomiciliacion.proveedor = genter.codigo "+&
//				"and    comdomiciliacion.empresa = '"+codigo_empresa+"' "+&
//				"and    genter.tipoter           = 'P' "+&
//				"and  ( isnull(comdomiciliacion.pais,'') in (select paises.pais from paises where tipopais = 'N') "+& 
//				"or     isnull(genter.pais,'') in (select paises.pais from paises where tipopais = 'N') )"
//				
//	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
//
//	for ll_indice = 1 to ll_total	
//		f_mensaje_proceso(ls_tabla,ll_indice,ll_total)
//		
//		ls_proveedor = ds_datos.object.comdomiciliacion_proveedor[ll_indice]
//		ls_codigo  = ds_datos.object.comdomiciliacion_codigo[ll_indice]
//		ls_nombre  = ds_datos.object.comdomiciliacion_nombrebanco[ll_indice]
//		ls_entidad = ds_datos.object.comdomiciliacion_entidad[ll_indice]
//		ls_oficina = ds_datos.object.comdomiciliacion_oficina[ll_indice]
//		ls_control = ds_datos.object.comdomiciliacion_control[ll_indice]
//		ls_cuenta  = ds_datos.object.comdomiciliacion_cuenta[ll_indice]
//		
//		ls_codigo_swift_actual = ds_datos.object.codigo_swift[ll_indice]
//		ls_codigo_iban_actual  = ds_datos.object.codigo_iban[ll_indice]
//		
//		if ls_codigo_swift_actual = '' then
//			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
//			
//			update comdomiciliacion
//			set    comdomiciliacion.codigo_swift = :ls_codigo_swift_nuevo
//			where  comdomiciliacion.empresa = :codigo_empresa
//			and    comdomiciliacion.proveedor = :ls_proveedor
//			and    comdomiciliacion.codigo  = :ls_codigo;
//			
//			if sqlca.sqlcode <> 0 then 
//				rollback;
//				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_proveedor+"/"+ls_codigo)				
//			else
//				commit;
//			end if	
//		else
//			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
//			
//			if ls_codigo_swift_actual <> ls_codigo_swift_nuevo then
//				ll_donde = dw_errores.insertrow(0)
//				dw_errores.object.empresa[ll_donde] = codigo_empresa
//				dw_errores.object.tabla[ll_donde]   = ls_tabla
//				dw_errores.object.codigo[ll_donde]  = ls_proveedor+"-"+ls_codigo
//				dw_errores.object.error[ll_donde]   = ls_nombre+" con swift distinto al calculado "+ls_codigo_swift_actual+"<>"+ls_codigo_swift_nuevo
//			end if						
//		end if		
//		
//		if ls_codigo_iban_actual = '' then
//			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
//			
//			update comdomiciliacion
//			set    comdomiciliacion.codigo_iban = :ls_codigo_iban_nuevo
//			where  comdomiciliacion.empresa = :codigo_empresa
//			and    comdomiciliacion.proveedor = :ls_proveedor
//			and    comdomiciliacion.codigo  = :ls_codigo;		
//			
//			if sqlca.sqlcode <> 0 then 
//				rollback;
//				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_proveedor+"/"+ls_codigo)			
//			else
//				commit;
//			end if		
//		else
//			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
//			
//			if ls_codigo_iban_actual <> ls_codigo_iban_nuevo then
//				ll_donde = dw_errores.insertrow(0)
//				dw_errores.object.empresa[ll_donde] = codigo_empresa
//				dw_errores.object.tabla[ll_donde]   = ls_tabla
//				dw_errores.object.codigo[ll_donde]  = ls_proveedor+"-"+ls_codigo
//				dw_errores.object.error[ll_donde]   = ls_nombre+" con iban distinto al calculado "+ls_codigo_iban_actual+"<>"+ls_codigo_iban_nuevo
//			end if															
//		end if					
//						
//						
//	next
		
	ls_tabla = 'COMPROVEEDORES'
	
	ls_sel = "select comproveedores.codigo, "+&
				"       genter.razon, "+&
				"       comproveedores.cuenta, "+&
				"       comproveedores.entidad, "+&
				"       comproveedores.oficina, "+&
				"       comproveedores.control, "+&
				"       isnull(comproveedores.codigo_swift,'') codigo_swift, "+&
				"       isnull(comproveedores.codigo_iban,'') codigo_iban "+&
				"from   comproveedores,genter "+&
				"where  comproveedores.empresa = genter.empresa "+&
				"and    comproveedores.codigo  = genter.codigo "+&
				"and    comproveedores.empresa = '"+codigo_empresa+"' "+&
				"and    genter.tipoter           = 'P' "+&
				"and    isnull(genter.pais,'') in (select paises.pais from paises where tipopais = 'N') "
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total	
		f_mensaje_proceso(ls_tabla,ll_indice,ll_total)
		
		ls_codigo  = ds_datos.object.comproveedores_codigo[ll_indice]
		ls_nombre  = ds_datos.object.genter_razon[ll_indice]
		ls_entidad = ds_datos.object.comproveedores_entidad[ll_indice]
		ls_oficina = ds_datos.object.comproveedores_oficina[ll_indice]
		ls_control = ds_datos.object.comproveedores_control[ll_indice]
		ls_cuenta  = ds_datos.object.comproveedores_cuenta[ll_indice]
		
		ls_codigo_swift_actual = ds_datos.object.codigo_swift[ll_indice]
		ls_codigo_iban_actual  = ds_datos.object.codigo_iban[ll_indice]
		
		if ls_codigo_swift_actual = '' then
			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
			
			update comproveedores
			set    comproveedores.codigo_swift = :ls_codigo_swift_nuevo
			where  comproveedores.empresa = :codigo_empresa
			and    comproveedores.codigo  = :ls_codigo;
			
			if sqlca.sqlcode <> 0 then 
				rollback;
				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_codigo)				
			else
				commit;
			end if	
			
			if isnull(ls_entidad) then ls_entidad = ''
			if trim(ls_codigo_swift_nuevo) = '' and trim(ls_entidad) <> '' then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con swift en blanco"
			end if						
		else
			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
			
			if ls_codigo_swift_actual <> ls_codigo_swift_nuevo then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con swift distinto al calculado "+ls_codigo_swift_actual+"<>"+ls_codigo_swift_nuevo
			end if				
		end if		
		
		if ls_codigo_iban_actual = '' then
			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
			
			update comproveedores
			set    comproveedores.codigo_iban = :ls_codigo_iban_nuevo
			where  comproveedores.empresa = :codigo_empresa
			and    comproveedores.codigo  = :ls_codigo;		
			
			if sqlca.sqlcode <> 0 then 
				rollback;
				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_codigo)			
			else
				commit;
			end if		
		else
			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
			
			if ls_codigo_iban_actual <> ls_codigo_iban_nuevo then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con iban distinto al calculado "+ls_codigo_iban_actual+"<>"+ls_codigo_iban_nuevo
			end if																		
		end if					
						
						
	next

	ls_tabla = 'VENAGENTES'
	
	ls_sel = "select venagentes.agente, "+&
				"       venagentes.nombre, "+&
				"       venagentes.cuentabanco, "+&
				"       venagentes.entidad, "+&
				"       venagentes.oficina, "+&
				"       venagentes.control, "+&
				"       isnull(venagentes.codigo_swift,'') codigo_swift, "+&
				"       isnull(venagentes.codigo_iban,'') codigo_iban "+&
				"from   venagentes "+&
				"where  venagentes.empresa = '"+codigo_empresa+"' "+&
				"and    isnull(venagentes.pais,'') in (select paises.pais from paises where tipopais = 'N') "
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total	
		f_mensaje_proceso(ls_tabla,ll_indice,ll_total)
		
		ls_codigo  = ds_datos.object.agente[ll_indice]
		ls_nombre  = ds_datos.object.nombre[ll_indice]
		ls_entidad = ds_datos.object.entidad[ll_indice]
		ls_oficina = ds_datos.object.oficina[ll_indice]
		ls_control = ds_datos.object.control[ll_indice]
		ls_cuenta  = ds_datos.object.cuentabanco[ll_indice]
		
		ls_codigo_swift_actual = ds_datos.object.codigo_swift[ll_indice]
		ls_codigo_iban_actual  = ds_datos.object.codigo_iban[ll_indice]
		
		if ls_codigo_swift_actual = '' then
			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
			
			update venagentes
			set    venagentes.codigo_swift = :ls_codigo_swift_nuevo
			where  venagentes.empresa = :codigo_empresa
			and    venagentes.agente  = :ls_codigo;
			
			if sqlca.sqlcode <> 0 then 
				rollback;
				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_codigo)				
			else
				commit;
			end if	
			
			if isnull(ls_entidad) then ls_entidad = ''
			if trim(ls_codigo_swift_nuevo) = '' and trim(ls_entidad) <> '' then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con swift en blanco"
			end if						
		else
			ls_codigo_swift_nuevo = f_uti_equivalencia_nrbe_bic11(ls_entidad)
			
			if ls_codigo_swift_actual <> ls_codigo_swift_nuevo then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con swift distinto al calculado "+ls_codigo_swift_actual+"<>"+ls_codigo_swift_nuevo
			end if									
		end if		
		
		if ls_codigo_iban_actual = '' then
			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
			
			update venagentes
			set    venagentes.codigo_iban = :ls_codigo_iban_nuevo
			where  venagentes.empresa = :codigo_empresa
			and    venagentes.agente  = :ls_codigo;		
			
			if sqlca.sqlcode <> 0 then 
				rollback;
				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_codigo)			
			else
				commit;
			end if		
		else
			ls_codigo_iban_nuevo = f_calcular_iban_desde_ccc(ls_entidad,ls_oficina,ls_control,ls_cuenta)
			
			if ls_codigo_iban_actual <> ls_codigo_iban_nuevo then
				ll_donde = dw_errores.insertrow(0)
				dw_errores.object.empresa[ll_donde] = codigo_empresa
				dw_errores.object.tabla[ll_donde]   = ls_tabla
				dw_errores.object.codigo[ll_donde]  = ls_codigo
				dw_errores.object.error[ll_donde]   = ls_nombre+" con iban distinto al calculado "+ls_codigo_iban_actual+"<>"+ls_codigo_iban_nuevo
			end if															
		end if					
						
						
	next
	
	
end if
end event

type pb_imprimir_preli from picturebutton within w_cambia_cuentas_sepa
integer x = 1225
integer y = 116
integer width = 128
integer height = 108
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "Print!"
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = ""
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)
u_imp.event ue_imprimir(dw_errores)

destroy u_imp
//long 	i,linea
//int 	conejer
//
//IF not isdate(em_fechadesde.text) then
//	messagebox("ERROR DE DATOS","Fecha desde NO válida",exclamation!)
//	em_fechadesde.setfocus()
//	return	
//end if
//
//
//IF not isdate(em_fechahasta.text) then
//	messagebox("ERROR DE DATOS","Fecha hasta NO válida",exclamation!)
//	em_fechahasta.setfocus()
//	return	
//end if
//
//if date(em_fechahasta.text) < date(em_fechadesde.text) then
//	messagebox("ERROR DE DATOS","Fecha hasta > que fecha desde",exclamation!)
//	em_fechahasta.setfocus()
//	return	
//end if
//
//
//if uo_balance.em_codigo.text = "" then
//	messagebox("ERROR DE DATOS","Introduzca el balance",exclamation!)
//	uo_balance.em_campo.setfocus()
//	return	
//end if
//
//dw_listado.reset()
//
//IF cbx_ejer.Checked THEN
//	conejer = 0
//ELSE
//	conejer = 1
//END IF
//
//// Ya se ha hecho la consulta en pantalla. 
//if dw_1.rowcount() > 0 then
//	dw_listado.retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),uo_balance.em_codigo.text,conejer)
//	for i = 1 to dw_1.rowcount()
//		linea = dw_listado.insertrow(0)		
//		dw_listado.setitem(linea,"cuenta",trim(dw_1.getitemstring(i,"cuenta")))
//		dw_listado.setitem(linea,"nombre_cuenta",trim(dw_1.getitemstring(i,"nombre_cuenta")))
//		dw_listado.setitem(linea,"grupo",trim(dw_1.getitemstring(i,"grupo")))
//		dw_listado.setitem(linea,"subgrupo",trim(dw_1.getitemstring(i,"subgrupo")))
//		dw_listado.setitem(linea,"nombre_grupo",trim(dw_1.getitemstring(i,"nombre_grupo")))
//		dw_listado.setitem(linea,"nombre_subgrupo",trim(dw_1.getitemstring(i,"nombre_subgrupo")))
//		dw_listado.setitem(linea,"formula",trim(dw_1.getitemstring(i,"formula")))		
//		dw_listado.setitem(linea,"bloque",trim(dw_1.getitemstring(i,"bloque")))
//		
//		dw_listado.setitem(linea,"saldo",dw_1.getitemnumber(i,"saldo"))
//		dw_listado.setitem(linea,"saldo_anterior",dw_1.getitemnumber(i,"saldo_anterior"))
//		dw_listado.setitem(linea,"tipo",dw_1.getitemnumber(i,"tipo"))
//		dw_listado.setitem(linea,"orden",dw_1.getitemnumber(i,"orden"))
//		dw_listado.setitem(linea,"saldo_grupo",dw_1.getitemnumber(i,"saldo_grupo"))
//		dw_listado.setitem(linea,"saldo_grupo_ant",dw_1.getitemnumber(i,"saldo_grupo_ant"))
//		dw_listado.setitem(linea,"visible",dw_1.getitemnumber(i,"visible"))
//		dw_listado.setitem(linea,"partida",dw_1.getitemstring(i,"partida"))
//		dw_listado.setitem(linea,"nombre_partida",dw_1.getitemstring(i,"nombre_partida"))
//		
//		f_mensaje_proceso("Calculando Balance ",i,dw_1.rowcount())
//	next
//	
//	dw_listado.groupcalc()
//	
//else
//	f_cargar(dw_listado)
//	f_filtro(dw_listado)
//end if
//if dw_listado.rowcount() > 0 then
//	f_imprimir_datawindow(dw_listado)
//else
//	messagebox("Atención","No hay cuentas")
//	dw_listado.reset()
//	dw_listado.visible = false
//end if
//
end event

