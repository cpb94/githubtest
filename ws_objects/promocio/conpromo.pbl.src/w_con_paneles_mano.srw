$PBExportHeader$w_con_paneles_mano.srw
forward
global type w_con_paneles_mano from w_int_con_empresa
end type
type st_prommedidas from statictext within w_con_paneles_mano
end type
type pb_1 from upb_salir within w_con_paneles_mano
end type
type pb_imprimir from upb_imprimir within w_con_paneles_mano
end type
type dw_listado from datawindow within w_con_paneles_mano
end type
type uo_manejo from u_manejo_datawindow within w_con_paneles_mano
end type
type dw_detalle from datawindow within w_con_paneles_mano
end type
type cb_1 from commandbutton within w_con_paneles_mano
end type
type em_busqueda from u_em_campo within w_con_paneles_mano
end type
type dw_detalle1 from datawindow within w_con_paneles_mano
end type
end forward

global type w_con_paneles_mano from w_int_con_empresa
integer width = 2930
integer height = 2036
st_prommedidas st_prommedidas
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
dw_detalle dw_detalle
cb_1 cb_1
em_busqueda em_busqueda
dw_detalle1 dw_detalle1
end type
global w_con_paneles_mano w_con_paneles_mano

type variables
string filtro

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();if dw_detalle.Getrow()=0 then return
dw_detalle1.Retrieve(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"prompaneles_codigo"))
end subroutine

on w_con_paneles_mano.create
int iCurrent
call super::create
this.st_prommedidas=create st_prommedidas
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.dw_detalle=create dw_detalle
this.cb_1=create cb_1
this.em_busqueda=create em_busqueda
this.dw_detalle1=create dw_detalle1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_prommedidas
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.em_busqueda
this.Control[iCurrent+9]=this.dw_detalle1
end on

on w_con_paneles_mano.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_prommedidas)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.dw_detalle)
destroy(this.cb_1)
destroy(this.em_busqueda)
destroy(this.dw_detalle1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Paneles de mano"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_detalle1.SetTransObject(SQLCA)
dw_detalle.SetRowFocusIndicator(Hand!) 
dw_listado.SetTransObject(SQLCA)
f_activar_campo(em_busqueda)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_listar;string descripcion
descripcion = "%"+em_busqueda.text+"%"
dw_listado.Retrieve(codigo_empresa,descripcion)
dw_report =dw_listado
Call Super::ue_listar
end event

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_paneles_mano
integer x = 722
integer y = 828
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_paneles_mano
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_busqueda)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_paneles_mano
integer x = 18
integer y = 44
integer width = 2139
end type

type st_prommedidas from statictext within w_con_paneles_mano
integer x = 9
integer y = 148
integer width = 951
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "B u s q u e d a"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_con_paneles_mano
integer x = 2702
integer y = 32
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "print!"
end type

type pb_imprimir from upb_imprimir within w_con_paneles_mano
integer x = 2725
integer y = 220
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;f_activar_campo(em_busqueda)
Parent.triggerEvent("ue_listar")
end event

type dw_listado from datawindow within w_con_paneles_mano
boolean visible = false
integer x = 64
integer y = 8
integer width = 494
integer height = 264
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_con_paneles_mano"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_paneles_mano
integer x = 2240
integer y = 172
end type

event valores;call super::valores;dw_data=dw_detalle
f_activar_campo(em_busqueda)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_detalle from datawindow within w_con_paneles_mano
integer x = 9
integer y = 328
integer width = 1815
integer height = 1468
boolean bringtotop = true
string dataobject = "dw_con_paneles_mano"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;This.SelectRow(0, FALSE)

This.SelectRow(row, TRUE)

str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[2]=dw_detalle.GetItemString(This.GetRow(),"prompaneles_codigo")

  OpenWithParm(wi_mant_prompaneles,lstr_param)


This.SelectRow(0, FALSE)
end event

event clicked;if row=0 then return
string codigo
codigo = dw_detalle.GetItemString(row,"prompaneles_codigo")

dw_detalle1.retrieve(codigo_empresa,codigo)

end event

event rowfocuschanged;f_control()

end event

type cb_1 from commandbutton within w_con_paneles_mano
integer x = 974
integer y = 236
integer width = 430
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;string descripcion

descripcion = "%"+em_busqueda.text+"%"

dw_detalle.retrieve(codigo_empresa,descripcion)
f_activar_campo(em_busqueda)
end event

type em_busqueda from u_em_campo within w_con_paneles_mano
integer x = 9
integer y = 232
integer width = 951
integer height = 88
integer taborder = 10
end type

type dw_detalle1 from datawindow within w_con_paneles_mano
integer x = 1824
integer y = 328
integer width = 1024
integer height = 1468
integer taborder = 31
boolean bringtotop = true
string dataobject = "dw_con_detalle_panelmano"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

