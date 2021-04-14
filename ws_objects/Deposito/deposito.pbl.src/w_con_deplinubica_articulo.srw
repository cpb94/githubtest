$PBExportHeader$w_con_deplinubica_articulo.srw
forward
global type w_con_deplinubica_articulo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_deplinubica_articulo
end type
type dw_proceso from datawindow within w_con_deplinubica_articulo
end type
type dw_listado from datawindow within w_con_deplinubica_articulo
end type
type pb_imprimir_preli from picturebutton within w_con_deplinubica_articulo
end type
type dw_1 from datawindow within w_con_deplinubica_articulo
end type
type uo_1 from u_manejo_datawindow within w_con_deplinubica_articulo
end type
type uo_articulo from u_em_campo_2 within w_con_deplinubica_articulo
end type
type cb_continuar from u_boton within w_con_deplinubica_articulo
end type
type st_1 from statictext within w_con_deplinubica_articulo
end type
type gb_4 from groupbox within w_con_deplinubica_articulo
end type
end forward

global type w_con_deplinubica_articulo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2885
integer height = 1616
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_proceso dw_proceso
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
uo_1 uo_1
uo_articulo uo_articulo
cb_continuar cb_continuar
st_1 st_1
gb_4 gb_4
end type
global w_con_deplinubica_articulo w_con_deplinubica_articulo

type variables
String ante_articulo,retrasos
end variables

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
dw_1.SetRowFocusIndicator(Hand!)
This.title = "Consulta material por artículo "
f_activar_campo(uo_articulo.em_campo)




end event

on w_con_deplinubica_articulo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.uo_1=create uo_1
this.uo_articulo=create uo_articulo
this.cb_continuar=create cb_continuar
this.st_1=create st_1
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_articulo
this.Control[iCurrent+8]=this.cb_continuar
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.gb_4
end on

on w_con_deplinubica_articulo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_proceso)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.uo_articulo)
destroy(this.cb_continuar)
destroy(this.st_1)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_deplinubica_articulo
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_deplinubica_articulo
integer taborder = 10
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_articulo.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_deplinubica_articulo
integer x = 27
integer y = 20
integer width = 2578
end type

type pb_2 from upb_salir within w_con_deplinubica_articulo
integer x = 2693
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_proceso from datawindow within w_con_deplinubica_articulo
boolean visible = false
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_almtipomov"
boolean livescroll = true
end type

type dw_listado from datawindow within w_con_deplinubica_articulo
boolean visible = false
integer x = 9
integer width = 910
integer height = 144
boolean bringtotop = true
string dataobject = "report_con_deplinubica_articulo"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_deplinubica_articulo
integer x = 2697
integer y = 204
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

event clicked;dw_listado.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
f_imprimir_datawindow(dw_listado)
f_activar_campo(uo_articulo.em_campo)
end event

type dw_1 from datawindow within w_con_deplinubica_articulo
integer x = 18
integer y = 320
integer width = 2811
integer height = 1092
string dataobject = "dw_con_deplinubica_articulo"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type uo_1 from u_manejo_datawindow within w_con_deplinubica_articulo
integer x = 2222
integer y = 160
integer width = 613
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type uo_articulo from u_em_campo_2 within w_con_deplinubica_articulo
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 274
integer y = 188
integer width = 1175
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Articulos"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type cb_continuar from u_boton within w_con_deplinubica_articulo
event clicked pbm_bnclicked
integer x = 1463
integer y = 188
integer height = 88
integer taborder = 20
string text = "F5 Continuar"
end type

event clicked;call super::clicked;dw_1.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
f_activar_campo(uo_articulo.em_campo)

end event

type st_1 from statictext within w_con_deplinubica_articulo
integer x = 18
integer y = 192
integer width = 251
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_con_deplinubica_articulo
integer x = 9
integer y = 140
integer width = 1879
integer height = 148
integer taborder = 11
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

