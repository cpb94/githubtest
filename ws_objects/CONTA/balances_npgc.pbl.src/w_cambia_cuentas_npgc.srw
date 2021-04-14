$PBExportHeader$w_cambia_cuentas_npgc.srw
forward
global type w_cambia_cuentas_npgc from w_int_con_empresa
end type
type pb_2 from upb_salir within w_cambia_cuentas_npgc
end type
type cb_buscar from u_boton within w_cambia_cuentas_npgc
end type
type dw_resultado from u_datawindow within w_cambia_cuentas_npgc
end type
type dw_tablas_a_cambiar from u_datawindow within w_cambia_cuentas_npgc
end type
type cb_updatear_tablas from commandbutton within w_cambia_cuentas_npgc
end type
end forward

global type w_cambia_cuentas_npgc from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3758
integer height = 2304
pb_2 pb_2
cb_buscar cb_buscar
dw_resultado dw_resultado
dw_tablas_a_cambiar dw_tablas_a_cambiar
cb_updatear_tablas cb_updatear_tablas
end type
global w_cambia_cuentas_npgc w_cambia_cuentas_npgc

type variables
//str_contaparam istr_contaparam
end variables

event open;call super::open;This.title = "CAMBIO CUENTAS NPGC"
end event

on w_cambia_cuentas_npgc.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_buscar=create cb_buscar
this.dw_resultado=create dw_resultado
this.dw_tablas_a_cambiar=create dw_tablas_a_cambiar
this.cb_updatear_tablas=create cb_updatear_tablas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_buscar
this.Control[iCurrent+3]=this.dw_resultado
this.Control[iCurrent+4]=this.dw_tablas_a_cambiar
this.Control[iCurrent+5]=this.cb_updatear_tablas
end on

on w_cambia_cuentas_npgc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_buscar)
destroy(this.dw_resultado)
destroy(this.dw_tablas_a_cambiar)
destroy(this.cb_updatear_tablas)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cambia_cuentas_npgc
integer x = 1527
integer y = 320
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cambia_cuentas_npgc
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cambia_cuentas_npgc
integer width = 2642
end type

type pb_2 from upb_salir within w_cambia_cuentas_npgc
integer x = 3502
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
end type

type cb_buscar from u_boton within w_cambia_cuentas_npgc
integer height = 92
end type

type dw_resultado from u_datawindow within w_cambia_cuentas_npgc
integer x = 9
integer y = 204
integer width = 3611
integer height = 1212
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Cuentas con equivalencia"
string dataobject = "dw_cambia_cuentas_npgc"
boolean vscrollbar = true
end type

type dw_tablas_a_cambiar from u_datawindow within w_cambia_cuentas_npgc
integer x = 9
integer y = 1420
integer width = 2414
integer height = 496
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Tablas a modificar"
string dataobject = "dw_cambia_cuentas_npgc2"
boolean vscrollbar = true
end type

event clicked;call super::clicked;string ls_tabla,ls_campo

this.selectrow(0,false)

if row > 0 then
	this.selectrow(row,true)
	ls_tabla = this.object.tabla[row]
	ls_campo = this.object.campo[row]
	
	dw_resultado.setfilter("tabla = '"+ls_tabla+"' and campo = '"+ls_campo+"'")
	dw_resultado.filter()	
else
	dw_resultado.setfilter("")
	dw_resultado.filter()
end if

dw_resultado.sort()
end event

type cb_updatear_tablas from commandbutton within w_cambia_cuentas_npgc
integer x = 2427
integer y = 1420
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
string text = "Modificar Tablas"
end type

event clicked;string ls_tabla,ls_columna,ls_filtro_ejercicio,ls_cuenta_vieja,ls_cuenta_nueva,ls_sel_modificacion
long   ll_indice,ll_total,ll_indice2,ll_total2

if messagebox("Confirmación!","¿Desea modificar las cuentas?",Question!,YesNo!,2) = 1 then
	
	dw_tablas_a_cambiar.setredraw(false)
	
	dw_tablas_a_cambiar.setfilter("updatear = 'S'")
	dw_tablas_a_cambiar.filter()
	
	ll_total = dw_tablas_a_cambiar.rowcount()
	
	for ll_indice = 1 to ll_total	
		ls_tabla = dw_tablas_a_cambiar.object.tabla[ll_indice]
		ls_columna = dw_tablas_a_cambiar.object.campo[ll_indice]
		
		if dw_tablas_a_cambiar.object.ejercicio[ll_indice] = "S" then
			ls_filtro_ejercicio = " and ejercicio = "+string(dw_tablas_a_cambiar.object.ejercicio_a_updatear[ll_indice],"###0")
		else
			ls_filtro_ejercicio = ""
		end if
		
		dw_resultado.setfilter("tabla = '"+ls_tabla+"' and campo = '"+ls_columna+"'")
		dw_resultado.filter()		
		
		ll_total2 = dw_resultado.rowcount()
		
		for ll_indice2 = 1 to ll_total2
			f_mensaje_proceso("Procesando",ll_indice2,ll_total2)
			ls_cuenta_vieja = dw_resultado.object.cuenta_actual[ll_indice2]
			ls_cuenta_nueva = dw_resultado.object.cuenta_npgc[ll_indice2]
			
			ls_cuenta_nueva = "X"+ls_cuenta_nueva
			
			ls_sel_modificacion = "update "+ls_tabla+" "+&
						"set "+ls_columna+" = '"+ls_cuenta_nueva+"' "+&
						"where empresa = '"+codigo_empresa+"' "+&
						"and "+ls_columna+" = '"+ls_cuenta_vieja+"' "+&	
						ls_filtro_ejercicio
			
			
			EXECUTE IMMEDIATE :ls_sel_modificacion USING sqlca ;
			
			if sqlca.sqlcode <> 0 then 
				rollback;
				messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_columna)				
			else
				commit;
			end if		
		next
		
		ls_sel_modificacion = "update "+ls_tabla+" "+&
						"set "+ls_columna+" = SUBSTRING("+ls_columna+",2,LEN("+ls_columna+")-1) "+&
						"where empresa = '"+codigo_empresa+"' "+&
						"and "+ls_columna+" like 'X%' "+&	
						ls_filtro_ejercicio
						
		EXECUTE IMMEDIATE :ls_sel_modificacion USING sqlca ;
		
		if sqlca.sqlcode <> 0 then 
			rollback;
			messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_columna+" eliminando X")				
		else
			commit;
		end if								
	next
	
	dw_tablas_a_cambiar.setfilter("")
	dw_tablas_a_cambiar.filter()
	dw_tablas_a_cambiar.sort()
	dw_tablas_a_cambiar.setredraw(true)
	dw_tablas_a_cambiar.selectrow(0,false)
	dw_resultado.setfilter("")
	dw_resultado.filter()
	dw_resultado.sort()
end if
end event

