$PBExportHeader$w_con_menu_usuario_perfil.srw
forward
global type w_con_menu_usuario_perfil from w_int_con_empresa
end type
type gb_1 from groupbox within w_con_menu_usuario_perfil
end type
type pb_1 from upb_salir within w_con_menu_usuario_perfil
end type
type uo_manejo from u_manejo_datawindow within w_con_menu_usuario_perfil
end type
type pb_2 from upb_imprimir within w_con_menu_usuario_perfil
end type
type dw_listado from datawindow within w_con_menu_usuario_perfil
end type
type cb_aceptar from commandbutton within w_con_menu_usuario_perfil
end type
type dw_3 from datawindow within w_con_menu_usuario_perfil
end type
type dw_4 from datawindow within w_con_menu_usuario_perfil
end type
type dw_2 from datawindow within w_con_menu_usuario_perfil
end type
type dw_1 from datawindow within w_con_menu_usuario_perfil
end type
type gb_2 from groupbox within w_con_menu_usuario_perfil
end type
end forward

global type w_con_menu_usuario_perfil from w_int_con_empresa
integer width = 3351
integer height = 1852
string title = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
gb_1 gb_1
pb_1 pb_1
uo_manejo uo_manejo
pb_2 pb_2
dw_listado dw_listado
cb_aceptar cb_aceptar
dw_3 dw_3
dw_4 dw_4
dw_2 dw_2
dw_1 dw_1
gb_2 gb_2
end type
global w_con_menu_usuario_perfil w_con_menu_usuario_perfil

type variables
string filtro
Long							il_new_handle
Boolean						ib_actualizar = False
end variables

forward prototypes
public subroutine wf_copiar_perfil (string as_usuario_org, string as_emp_org, string as_usuario_dst, string as_emp_dst)
public subroutine f_contador_procesos (decimal cont_pro_contador, decimal cont_pro_total)
end prototypes

public subroutine wf_copiar_perfil (string as_usuario_org, string as_emp_org, string as_usuario_dst, string as_emp_dst);DataStore		lds_origen, lds_destino
Long				ll_cont, ll_total


//DELETE FROM usuario_menu WHERE usuario = :as_usuario_dst AND empresa = :as_emp_dst USING SQLCA;
//
//IF SQLCA.sqlcode = -1 THEN
//	ROLLBACK;
//	MessageBox("Copiar Perfil", "ERROR al borrar usuario: " +  SQLCA.SQLErrText)
//	Return
//ELSE
//	COMMIT;
//	lds_destino = f_cargar_cursor ("SELECT * FROM usuario_menu" )
//	lds_origen = f_cargar_cursor ("SELECT * FROM usuario_menu Where usuario = '"  + as_usuario_org + "' And  empresa = '" + as_emp_org + "'")
//	
//	ll_total = lds_origen.RowCount()
//	
//	FOR ll_cont = 1 TO ll_total
//		lds_origen.Object.usuario[ll_cont] = as_usuario_dst
//		lds_origen.Object.empresa[ll_cont] = as_emp_dst		
//	NEXT
//	
//	lds_origen.RowsCopy (1, ll_total, Primary!, lds_destino, lds_destino.RowCount() + 1, Primary!)
//	
//	IF lds_destino.Update() = 1 THEN
//		COMMIT;
//		Destroy 	lds_origen
//		Destroy lds_destino
//		MessageBox("Copiar Perfil", "Opciones de Menú copiadas correctamente¡", Exclamation!)
//		Return 
//	ELSE
//		ROLLBACK;
//		Destroy 	lds_origen
//		Destroy lds_destino
//		MessageBox("Copiar Perfil", "No se han podido copiar correctamente las Opciones de Menú¡", Exclamation!)
//		Return 	
//	END IF
//	
//END IF

f_mensaje_proceso("Copiando Perfil...",0,100)

lds_destino = f_cargar_cursor ("SELECT * FROM usuario_menu" )
lds_origen = f_cargar_cursor ("SELECT * FROM usuario_menu Where usuario = '"  + as_usuario_org + "' And  empresa = '" + as_emp_org + "'")

lds_destino.SetFilter ( " usuario = '"  + as_usuario_dst + "' And  empresa = '" + as_emp_dst + "'" )
lds_destino.filter()

IF lds_destino.FilteredCount( ) > 0 THEN	lds_destino.RowsMove( 1, lds_destino.RowCount(), Primary!, lds_destino, lds_destino.DeletedCount() + 1, Delete!)

lds_destino.SetFilter ("")
lds_destino.Filter ()
	
ll_total = lds_origen.RowCount()

FOR ll_cont = 1 TO ll_total
	lds_origen.Object.usuario[ll_cont] = as_usuario_dst
	lds_origen.Object.empresa[ll_cont] = as_emp_dst		
	f_mensaje_proceso("Copiando Perfil...",ll_cont,ll_total)
NEXT

f_mensaje_proceso("Copiando Perfil...",99, 100)
lds_origen.RowsCopy (1, ll_total, Primary!, lds_destino, lds_destino.RowCount() + 1, Primary!)

IF lds_destino.Update() = 1 THEN
	COMMIT;
	f_mensaje_proceso("Copiando Perfil...",100, 100)
	Destroy 	lds_origen
	Destroy lds_destino
	MessageBox("Copiar Perfil", "Opciones de Menú copiadas correctamente¡", Exclamation!)
	Return 
ELSE
	ROLLBACK;
	f_mensaje_proceso("Copiando Perfil...",100, 100)
	Destroy 	lds_origen
	Destroy lds_destino
	MessageBox("Copiar Perfil", "No se han podido copiar correctamente las Opciones de Menú¡", Exclamation!)
	Return 	
END IF
	

end subroutine

public subroutine f_contador_procesos (decimal cont_pro_contador, decimal cont_pro_total);Int 	i
String	ls_aux

ls_aux = "2"
i = 0
end subroutine

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.TriggerEvent("pagina_arriba")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.TriggerEvent("pagina_abajo")
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Copiar Perfil en permisos de usuarios por menus"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)
dw_4.SetTransObject(SQLCA)
dw_1.Retrieve()
dw_3.Retrieve()
end event

on w_con_menu_usuario_perfil.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.cb_aceptar=create cb_aceptar
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_aceptar
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.gb_2
end on

on w_con_menu_usuario_perfil.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.cb_aceptar)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_2)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_menu_usuario_perfil
integer x = 1189
integer y = 176
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_menu_usuario_perfil
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_menu_usuario_perfil
integer x = 9
integer y = 12
integer width = 3296
integer height = 104
end type

type gb_1 from groupbox within w_con_menu_usuario_perfil
integer x = 69
integer y = 312
integer width = 1577
integer height = 1416
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Origen Opciones de Menú..."
end type

type pb_1 from upb_salir within w_con_menu_usuario_perfil
integer x = 3141
integer y = 164
integer width = 119
integer height = 100
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_menu_usuario_perfil
integer x = 901
integer y = 592
integer width = 649
integer height = 144
end type

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type pb_2 from upb_imprimir within w_con_menu_usuario_perfil
integer x = 1413
integer y = 640
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

type dw_listado from datawindow within w_con_menu_usuario_perfil
boolean visible = false
integer x = 2811
integer y = 600
integer width = 215
integer height = 116
integer taborder = 80
boolean livescroll = true
end type

type cb_aceptar from commandbutton within w_con_menu_usuario_perfil
integer x = 297
integer y = 172
integer width = 430
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copiar Perfil"
end type

event clicked;Long				ll_row
String			ls_usu_origen, ls_emp_nomb_org, ls_emp_origen, ls_usu_destino, ls_emp_destino, ls_emp_nomb_dest

ll_row = dw_1.getselectedrow( 0)
IF ll_row = 0 THEN 
	MessageBox("Copiar Perfil", "Debe seleccionar un usuario de origen¡", Exclamation!)
	Return
ELSE
	ls_usu_origen = dw_1.Object.usuario[ll_row]
END IF

ll_row = dw_2.getselectedrow( 0)
IF ll_row = 0 THEN 
	MessageBox("Copiar Perfil", "Debe seleccionar una emprea de origen¡", Exclamation!)
	Return
ELSE
	ls_emp_origen = dw_2.Object.empresas_empresa[ll_row]
	ls_emp_nomb_org = dw_2.Object.empresas_nombre[ll_row]
END IF

ll_row = dw_3.getselectedrow( 0)
IF ll_row = 0 THEN 
	MessageBox("Copiar Perfil", "Debe seleccionar un usuario de destino¡", Exclamation!)
	Return
ELSE
	ls_usu_destino = dw_3.Object.usuario[ll_row]
END IF

ll_row = dw_4.getselectedrow( 0)
IF ll_row = 0 THEN 
	MessageBox("Copiar Perfil", "Debe seleccionar una empresa de destino¡", Exclamation!)
	Return
ELSE
	ls_emp_destino = dw_4.Object.empresas_empresa[ll_row]
	ls_emp_nomb_dest = dw_4.Object.empresas_nombre[ll_row]
END IF

IF Trim (ls_usu_origen ) = Trim ( ls_usu_destino)  AND Trim (ls_emp_origen ) = Trim ( ls_emp_destino) THEN 
	MessageBox("Copiar Perfil", "El Origen y el Destino deben ser diferentes¡", Exclamation!)
	Return
END IF

IF MessageBox("Copiar Perfil",  "¿ Copiar Opciones de "  + ls_usu_origen   + " en la empresa  "  +    ls_emp_nomb_org + &
		" a " + ls_usu_destino + " en la empresa " + 	ls_emp_nomb_dest + " ?",  Question!, YesNo!, 2 ) = 1 THEN
		
		wf_copiar_perfil (ls_usu_origen, ls_emp_origen, ls_usu_destino, ls_emp_destino )
ELSE
	Return
END IF



end event

type dw_3 from datawindow within w_con_menu_usuario_perfil
integer x = 1787
integer y = 420
integer width = 640
integer height = 1264
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_perfil_usuario"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row > 0  AND dwo.Type = "column" THEN
	This.SelectRow( 0, FALSE)
	This.SelectRow( row, TRUE)
	dw_4.Retrieve(dwo.Primary[row])
END IF
end event

type dw_4 from datawindow within w_con_menu_usuario_perfil
integer x = 2446
integer y = 420
integer width = 791
integer height = 1264
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_perfil_empresa"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row > 0 THEN
	This.SelectRow( 0, FALSE)
	This.SelectRow( row, TRUE)
END IF
end event

type dw_2 from datawindow within w_con_menu_usuario_perfil
integer x = 800
integer y = 420
integer width = 791
integer height = 1264
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_perfil_empresa"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row > 0 THEN
	This.SelectRow( 0, FALSE)
	This.SelectRow( row, TRUE)
END IF
end event

type dw_1 from datawindow within w_con_menu_usuario_perfil
integer x = 142
integer y = 420
integer width = 640
integer height = 1264
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_perfil_usuario"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row > 0  AND dwo.Type = "column" THEN
	This.SelectRow( 0, FALSE)
	This.SelectRow( row, TRUE)
	dw_2.Retrieve(dwo.Primary[row])
END IF
end event

type gb_2 from groupbox within w_con_menu_usuario_perfil
integer x = 1714
integer y = 312
integer width = 1577
integer height = 1416
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Destino Opciones de Menú..."
end type

