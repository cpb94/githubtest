$PBExportHeader$w_cambio_iva.srw
forward
global type w_cambio_iva from w_int_con_empresa
end type
type cb_1 from commandbutton within w_cambio_iva
end type
type st_1 from statictext within w_cambio_iva
end type
type ddplb_1 from dropdownpicturelistbox within w_cambio_iva
end type
type st_2 from statictext within w_cambio_iva
end type
type st_3 from statictext within w_cambio_iva
end type
type uo_tiva_actual from u_em_campo_2 within w_cambio_iva
end type
type uo_tiva_nuevo from u_em_campo_2 within w_cambio_iva
end type
type gb_1 from groupbox within w_cambio_iva
end type
end forward

global type w_cambio_iva from w_int_con_empresa
integer width = 3173
integer height = 692
string title = "Porting Clientes"
cb_1 cb_1
st_1 st_1
ddplb_1 ddplb_1
st_2 st_2
st_3 st_3
uo_tiva_actual uo_tiva_actual
uo_tiva_nuevo uo_tiva_nuevo
gb_1 gb_1
end type
global w_cambio_iva w_cambio_iva

type variables

end variables

on w_cambio_iva.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.ddplb_1=create ddplb_1
this.st_2=create st_2
this.st_3=create st_3
this.uo_tiva_actual=create uo_tiva_actual
this.uo_tiva_nuevo=create uo_tiva_nuevo
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddplb_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.uo_tiva_actual
this.Control[iCurrent+7]=this.uo_tiva_nuevo
this.Control[iCurrent+8]=this.gb_1
end on

on w_cambio_iva.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.ddplb_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.uo_tiva_actual)
destroy(this.uo_tiva_nuevo)
destroy(this.gb_1)
end on

event open;call super::open;
//d_1.text="Ventas"

 
	
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cambio_iva
integer x = 352
integer y = 456
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cambio_iva
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cambio_iva
integer width = 3013
end type

type cb_1 from commandbutton within w_cambio_iva
integer x = 2647
integer y = 216
integer width = 343
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;string ls_iva_actual,ls_nuevo_iva,ls_errores,ls_sel
dec    ld_porc_iva
int    li_anyo
long   ll_documento,ll_linea,ll_indice,ll_total
boolean lb_correcto = true
datastore ds_datos_actualizar

if ddplb_1.text="" then
	messagebox("Atención!","Debe seleccionar una opción")
	return
end if


if uo_tiva_actual.em_codigo.text="" or uo_tiva_nuevo.em_codigo.text="" then
	messagebox("Error!!","Debe seleccionar los dos tipos de IVA")
	return
end if

ls_iva_actual = uo_tiva_actual.em_codigo.text
ls_nuevo_iva  = uo_tiva_nuevo.em_codigo.text
/**************************************************/
ld_porc_iva   = f_iva_contaiva(2012,codigo_empresa,ls_nuevo_iva)
/**************************************************/


if ddplb_1.text="Clientes" then 
	update venalb
	set    tipoiva= :ls_nuevo_iva,
	       iva    = :ld_porc_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",1,9)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if	
	
	update venalb2
	set    tipoiva= :ls_nuevo_iva,
	       iva    = :ld_porc_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",2,9)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if		
	
	update venclientes
	set    tipoiva= :ls_nuevo_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",3,9)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if
	
	update venlialb
	set    tipoiva= :ls_nuevo_iva,
	       iva    = :ld_porc_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",4,9)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if			
		
	update venlialb2
	set    tipoiva= :ls_nuevo_iva,
	       iva    = :ld_porc_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",5,9)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if					
				
	update venliped
	set    tipoiva= :ls_nuevo_iva,
	       iva    = :ld_porc_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",6,9)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if							
	
	update venliproformas
	set    tipoiva= :ls_nuevo_iva,
	       iva    = :ld_porc_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",7,9)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if								
	
	update venped
	set    tipoiva= :ls_nuevo_iva,
	       iva    = :ld_porc_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",8,9)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if									
	
	update venproformas
	set    tipoiva= :ls_nuevo_iva,
	       iva    = :ld_porc_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",9,9)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if										
	
	if lb_correcto then
		commit;
		messagebox("OK","Datos procesados correctamente")
		
		//Pasamos a recalcular proformas,pedidos y albaranes
		//Proformas
		ls_sel = "select anyo,proforma,linea from venliproformas where empresa = '"+codigo_empresa+"' and tipoiva = '"+ls_nuevo_iva+"'"
		
		f_cargar_cursor_nuevo(ls_sel,ds_datos_actualizar)

		ll_total = ds_datos_actualizar.rowcount()
		
		for ll_indice = 1 to ll_total
			f_mensaje_proceso("Actualizando Lineas Proformas",ll_indice,ll_total)
			
			li_anyo      = ds_datos_actualizar.object.anyo[ll_indice]
			ll_documento = ds_datos_actualizar.object.proforma[ll_indice]
			ll_linea     = ds_datos_actualizar.object.linea[ll_indice]
			
			if not(f_actualizar_linea_venproforma(codigo_empresa,li_anyo,ll_documento,ll_linea)) then
				lb_correcto = false
			end if
		next

		destroy ds_datos_actualizar
		
		ls_sel = "select anyo,proforma from venproformas where empresa = '"+codigo_empresa+"' and tipoiva = '"+ls_nuevo_iva+"'"
		
		f_cargar_cursor_nuevo(ls_sel,ds_datos_actualizar)

		ll_total = ds_datos_actualizar.rowcount()
		
		for ll_indice = 1 to ll_total
			f_mensaje_proceso("Actualizando Cabeceras Proformas",ll_indice,ll_total)
			
			li_anyo      = ds_datos_actualizar.object.anyo[ll_indice]
			ll_documento = ds_datos_actualizar.object.proforma[ll_indice]
			
			f_actualizar_venproforma_sinpeso(codigo_empresa,li_anyo,ll_documento)
			
//			if not(f_actualizar_venproforma_sinpeso(codigo_empresa,li_anyo,ll_documento)) then
//				lb_correcto = false
//			end if
		next

		destroy ds_datos_actualizar						
		
		//Pedidos
		ls_sel = "select anyo,pedido,linea from venliped where empresa = '"+codigo_empresa+"' and tipoiva = '"+ls_nuevo_iva+"'"
		
		f_cargar_cursor_nuevo(ls_sel,ds_datos_actualizar)

		ll_total = ds_datos_actualizar.rowcount()
		
		for ll_indice = 1 to ll_total
			f_mensaje_proceso("Actualizando Lineas Pedidos",ll_indice,ll_total)
			
			li_anyo      = ds_datos_actualizar.object.anyo[ll_indice]
			ll_documento = ds_datos_actualizar.object.pedido[ll_indice]
			ll_linea     = ds_datos_actualizar.object.linea[ll_indice]
			
			if not(f_actualizar_linea_venpedido(codigo_empresa,li_anyo,ll_documento,ll_linea)) then
				lb_correcto = false
			end if
		next

		destroy ds_datos_actualizar
		
		ls_sel = "select anyo,pedido from venped where empresa = '"+codigo_empresa+"' and tipoiva = '"+ls_nuevo_iva+"'"
		
		f_cargar_cursor_nuevo(ls_sel,ds_datos_actualizar)

		ll_total = ds_datos_actualizar.rowcount()
		
		for ll_indice = 1 to ll_total
			f_mensaje_proceso("Actualizando Cabeceras Pedidos",ll_indice,ll_total)
			
			li_anyo      = ds_datos_actualizar.object.anyo[ll_indice]
			ll_documento = ds_datos_actualizar.object.pedido[ll_indice]
			
			if not(f_actualizar_venpedido(codigo_empresa,li_anyo,ll_documento)) then
				lb_correcto = false
			end if
		next

		destroy ds_datos_actualizar		
		
		//Albaranes
		ls_sel = "select anyo,albaran,linea from venlialb where empresa = '"+codigo_empresa+"' and tipoiva = '"+ls_nuevo_iva+"'"
		
		f_cargar_cursor_nuevo(ls_sel,ds_datos_actualizar)

		ll_total = ds_datos_actualizar.rowcount()
		
		for ll_indice = 1 to ll_total
			f_mensaje_proceso("Actualizando Lineas Albaranes",ll_indice,ll_total)
			
			li_anyo      = ds_datos_actualizar.object.anyo[ll_indice]
			ll_documento = ds_datos_actualizar.object.albaran[ll_indice]
			ll_linea     = ds_datos_actualizar.object.linea[ll_indice]
			
			if not(f_actualizar_linea_venalbaran(codigo_empresa,li_anyo,ll_documento,ll_linea)) then
				lb_correcto = false
			end if
		next

		destroy ds_datos_actualizar
		
		ls_sel = "select anyo,albaran from venalb where empresa = '"+codigo_empresa+"' and tipoiva = '"+ls_nuevo_iva+"'"
		
		f_cargar_cursor_nuevo(ls_sel,ds_datos_actualizar)

		ll_total = ds_datos_actualizar.rowcount()
		
		for ll_indice = 1 to ll_total
			f_mensaje_proceso("Actualizando Cabeceras Albaranes",ll_indice,ll_total)
			
			li_anyo      = ds_datos_actualizar.object.anyo[ll_indice]
			ll_documento = ds_datos_actualizar.object.albaran[ll_indice]
			
			if not(f_actualizar_venalbaran_sin_peso(codigo_empresa,li_anyo,ll_documento)) then
				lb_correcto = false
			end if
		next

		destroy ds_datos_actualizar	
		
		if lb_correcto then
			commit;
			messagebox("OK","Datos procesados correctamente")		
		else
			rollback;
			messagebox("Error!","Los datos no se actulizan")
		end if		
	else
		rollback;
		messagebox("Error!",ls_errores)
	end if
end if
	
if ddplb_1.text="Proveedores" then 	
	
	update comproveedores
	set    tipo_iva = :ls_nuevo_iva
	where  empresa  = :codigo_empresa
	and 	 tipo_iva = :ls_iva_actual;
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if
	
	f_mensaje_proceso("Actualizando",1,3)
	
	update venagentes
	set    tipo_iva = :ls_nuevo_iva
	where  empresa  = :codigo_empresa
	and 	 tipo_iva = :ls_iva_actual;
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if
	
	f_mensaje_proceso("Actualizando",2,3)
	
	update comcabpedpro
	set    tipoiva= :ls_nuevo_iva,
	       iva    = :ld_porc_iva
	where  empresa= :codigo_empresa
	and 	 tipoiva= :ls_iva_actual;
	
	f_mensaje_proceso("Actualizando",3,3)
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
		ls_errores = ls_errores + "~n" + sqlca.sqlerrtext
	end if											
	
	if lb_correcto then
		commit;
		messagebox("OK","Datos procesados correctamente")		
	else
		rollback;
		messagebox("Error!",ls_errores)
	end if			
end if


end event

type st_1 from statictext within w_cambio_iva
integer x = 133
integer y = 120
integer width = 503
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Elija una opción:"
boolean focusrectangle = false
end type

type ddplb_1 from dropdownpicturelistbox within w_cambio_iva
integer x = 142
integer y = 228
integer width = 411
integer height = 352
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Clientes"
string item[] = {"Clientes","Proveedores"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {1,2}
long picturemaskcolor = 536870912
end type

type st_2 from statictext within w_cambio_iva
integer x = 704
integer y = 120
integer width = 759
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Seleccione el Tipo de I.V.A actual:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_cambio_iva
integer x = 1678
integer y = 120
integer width = 763
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Seleccione el nuevo Tipo de I.V.A:"
boolean focusrectangle = false
end type

type uo_tiva_actual from u_em_campo_2 within w_cambio_iva
integer x = 709
integer y = 228
integer width = 722
integer height = 96
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tiva_actual.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;if f_nombre_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_tiva_actual.em_codigo.text) <> "" then
	uo_tiva_actual.em_campo.text = f_nombre_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_tiva_actual.em_codigo.text)
	
else
	uo_tiva_actual.em_campo.text  = ""
	uo_tiva_actual.em_codigo.text = ""
	
end if
end event

event getfocus;call super::getfocus;ue_datawindow = "dw_ayuda_contaiva"
ue_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
ue_filtro = "ejercicio = " + String(ejercicio_activo)
valor_empresa = true

end event

type uo_tiva_nuevo from u_em_campo_2 within w_cambio_iva
integer x = 1687
integer y = 228
integer width = 722
integer height = 96
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tiva_nuevo.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_datawindow = "dw_ayuda_contaiva"
ue_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
ue_filtro = "ejercicio = " + String(ejercicio_activo)
valor_empresa = true
end event

event modificado;call super::modificado;if f_nombre_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_tiva_nuevo.em_codigo.text) <> "" then
	uo_tiva_nuevo.em_campo.text = f_nombre_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_tiva_nuevo.em_codigo.text)
	
else
	uo_tiva_nuevo.em_campo.text  = ""
	uo_tiva_nuevo.em_codigo.text = ""
	
end if
end event

type gb_1 from groupbox within w_cambio_iva
integer x = 59
integer y = 392
integer width = 2912
integer height = 36
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

