$PBExportHeader$w_con_deplinubica_cliente_exportar.srw
forward
global type w_con_deplinubica_cliente_exportar from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_deplinubica_cliente_exportar
end type
type dw_proceso from datawindow within w_con_deplinubica_cliente_exportar
end type
type pb_imprimir_preli from picturebutton within w_con_deplinubica_cliente_exportar
end type
type dw_1 from datawindow within w_con_deplinubica_cliente_exportar
end type
type uo_1 from u_manejo_datawindow within w_con_deplinubica_cliente_exportar
end type
type uo_cliente from u_em_campo_2 within w_con_deplinubica_cliente_exportar
end type
type cb_continuar from u_boton within w_con_deplinubica_cliente_exportar
end type
type st_1 from statictext within w_con_deplinubica_cliente_exportar
end type
type st_2 from statictext within w_con_deplinubica_cliente_exportar
end type
type uo_articulo from u_em_campo_2 within w_con_deplinubica_cliente_exportar
end type
type gb_4 from groupbox within w_con_deplinubica_cliente_exportar
end type
end forward

global type w_con_deplinubica_cliente_exportar from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3598
integer height = 2268
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_proceso dw_proceso
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
uo_1 uo_1
uo_cliente uo_cliente
cb_continuar cb_continuar
st_1 st_1
st_2 st_2
uo_articulo uo_articulo
gb_4 gb_4
end type
global w_con_deplinubica_cliente_exportar w_con_deplinubica_cliente_exportar

type variables
String ante_articulo,retrasos
end variables

event ue_listar;//String almacen
//IF dw_almacenes.GetRow()= 0 Then Return
//almacen= dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")
//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//dw_report.Retrieve(codigo_empresa,almacen)
//CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
dw_1.SetRowFocusIndicator(Hand!)
This.title = "Consulta material por cliente (Deposito)"
f_activar_campo(uo_cliente.em_campo)




end event

on w_con_deplinubica_cliente_exportar.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.uo_1=create uo_1
this.uo_cliente=create uo_cliente
this.cb_continuar=create cb_continuar
this.st_1=create st_1
this.st_2=create st_2
this.uo_articulo=create uo_articulo
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.cb_continuar
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.uo_articulo
this.Control[iCurrent+11]=this.gb_4
end on

on w_con_deplinubica_cliente_exportar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_proceso)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.uo_cliente)
destroy(this.cb_continuar)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.uo_articulo)
destroy(this.gb_4)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_f5;call super::ue_f5;cb_continuar.Triggerevent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_deplinubica_cliente_exportar
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_deplinubica_cliente_exportar
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_deplinubica_cliente_exportar
integer x = 27
integer y = 20
integer width = 3305
end type

type pb_2 from upb_salir within w_con_deplinubica_cliente_exportar
integer x = 3387
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_proceso from datawindow within w_con_deplinubica_cliente_exportar
boolean visible = false
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_almtipomov"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_deplinubica_cliente_exportar
integer x = 3392
integer y = 240
integer width = 105
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;string articulo

if isnull(uo_Articulo.em_codigo.text) or uo_articulo.em_codigo.text = "" then
	articulo = '%'
else
	articulo = uo_articulo.em_codigo.text
end if
		
//messagebox("", "EMPRESA: "codigo_empresa+",      "+"	CLIENTE: "
		
dw_1.retrieve(codigo_empresa,uo_cliente.em_codigo.text, articulo)
f_imprimir_datawindow(dw_1)
f_activar_campo(uo_cliente.em_campo)
end event

type dw_1 from datawindow within w_con_deplinubica_cliente_exportar
integer x = 14
integer y = 368
integer width = 3497
integer height = 1676
string dataobject = "dw_con_deplinubica_cliente3_exportar"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type uo_1 from u_manejo_datawindow within w_con_deplinubica_cliente_exportar
integer x = 2917
integer y = 196
integer width = 613
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type uo_cliente from u_em_campo_2 within w_con_deplinubica_cliente_exportar
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 256
integer y = 148
integer width = 1449
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo     = "Selección de Clientes"
ue_datawindow = "dw_ayuda_clientes_deposito"
ue_filtro     = ""
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type cb_continuar from u_boton within w_con_deplinubica_cliente_exportar
event clicked pbm_bnclicked
integer x = 2373
integer y = 232
integer width = 379
integer height = 104
integer taborder = 30
string text = "F5 Continuar"
end type

event clicked;string articulo

if uo_articulo.em_codigo.text <> "" then
	articulo = uo_articulo.em_codigo.text
else
	articulo = "%"
end if

dw_1.retrieve(codigo_empresa,uo_cliente.em_codigo.text,articulo)
f_activar_campo(uo_cliente.em_campo)

end event

type st_1 from statictext within w_con_deplinubica_cliente_exportar
integer x = 23
integer y = 156
integer width = 224
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_deplinubica_cliente_exportar
integer x = 23
integer y = 252
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Articulo:"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_con_deplinubica_cliente_exportar
integer x = 283
integer y = 248
integer width = 1422
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
uo_articulo.em_campo.text = Trim(f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text))
IF Trim(uo_articulo.em_campo.text)="" THEN 
	IF Trim(uo_articulo.em_codigo.text)<>"" Then 
		uo_articulo.em_campo.SetFocus()
	END IF
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type gb_4 from groupbox within w_con_deplinubica_cliente_exportar
integer x = 9
integer y = 100
integer width = 1723
integer height = 252
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

