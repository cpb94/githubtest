$PBExportHeader$w_con_clientes_transportista.srw
forward
global type w_con_clientes_transportista from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_clientes_transportista
end type
type st_agente from statictext within w_con_clientes_transportista
end type
type uo_transportista from u_em_campo_2 within w_con_clientes_transportista
end type
type uo_manejo from u_manejo_datawindow within w_con_clientes_transportista
end type
type dw_listado_transportistas from datawindow within w_con_clientes_transportista
end type
type dw_transportistas from datawindow within w_con_clientes_transportista
end type
type pb_imprimir from upb_imprimir within w_con_clientes_transportista
end type
type cb_1 from commandbutton within w_con_clientes_transportista
end type
end forward

global type w_con_clientes_transportista from w_int_con_empresa
integer width = 2953
integer height = 1700
pb_1 pb_1
st_agente st_agente
uo_transportista uo_transportista
uo_manejo uo_manejo
dw_listado_transportistas dw_listado_transportistas
dw_transportistas dw_transportistas
pb_imprimir pb_imprimir
cb_1 cb_1
end type
global w_con_clientes_transportista w_con_clientes_transportista

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Clientes/Transportista"
This.title=istr_parametros.s_titulo_ventana

dw_transportistas.SetTransObject(SQLCA)
dw_transportistas.SetRowFocusIndicator(Hand!)
dw_listado_transportistas.SetTransObject(SQLCA)

f_activar_campo(uo_transportista.em_campo)

end event

event ue_listar;String desde,hasta

desde = "."
hasta = "Z"
if Trim(uo_transportista.em_campo.text)<>"" then
	desde = uo_transportista.em_codigo.text
	hasta = uo_transportista.em_codigo.text
End if


dw_listado_transportistas.Retrieve(codigo_empresa,desde,hasta)
dw_report=dw_listado_transportistas
CALL Super::ue_listar
end event

on w_con_clientes_transportista.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_agente=create st_agente
this.uo_transportista=create uo_transportista
this.uo_manejo=create uo_manejo
this.dw_listado_transportistas=create dw_listado_transportistas
this.dw_transportistas=create dw_transportistas
this.pb_imprimir=create pb_imprimir
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_agente
this.Control[iCurrent+3]=this.uo_transportista
this.Control[iCurrent+4]=this.uo_manejo
this.Control[iCurrent+5]=this.dw_listado_transportistas
this.Control[iCurrent+6]=this.dw_transportistas
this.Control[iCurrent+7]=this.pb_imprimir
this.Control[iCurrent+8]=this.cb_1
end on

on w_con_clientes_transportista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_agente)
destroy(this.uo_transportista)
destroy(this.uo_manejo)
destroy(this.dw_listado_transportistas)
destroy(this.dw_transportistas)
destroy(this.pb_imprimir)
destroy(this.cb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_transportistas)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_transportistas)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_clientes_transportista
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_clientes_transportista
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_transportista.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_clientes_transportista
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_clientes_transportista
integer x = 2729
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_agente from statictext within w_con_clientes_transportista
integer x = 14
integer y = 176
integer width = 407
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Transportista:"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_transportista from u_em_campo_2 within w_con_clientes_transportista
integer x = 425
integer y = 168
integer width = 1093
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_transportista.em_campo.text=f_nombre_ventransportista(codigo_empresa,uo_transportista.em_codigo.text)
IF Trim(uo_transportista.em_campo.text)="" THEN 
 IF Trim(uo_transportista.em_codigo.text)<>"" Then uo_transportista.em_campo.SetFocus()
 uo_transportista.em_campo.text=""
 uo_transportista.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Transportistas"
ue_datawindow = "dw_ayuda_ventransportistas"
ue_filtro     = ""


end event

on uo_transportista.destroy
call u_em_campo_2::destroy
end on

type uo_manejo from u_manejo_datawindow within w_con_clientes_transportista
integer x = 2254
integer y = 132
integer width = 613
end type

event valores;call super::valores;dw_data=dw_transportistas

f_activar_campo(uo_transportista.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_transportistas from datawindow within w_con_clientes_transportista
boolean visible = false
integer x = 73
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_clientes_transportista"
boolean livescroll = true
end type

type dw_transportistas from datawindow within w_con_clientes_transportista
integer y = 276
integer width = 2857
integer height = 1148
string dataobject = "dw_con_clientes_transportistas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[1]="wi_con_clientes_agente"
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clientes2,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_clientes_transportista
integer x = 2734
integer y = 176
integer taborder = 0
boolean bringtotop = true
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(uo_transportista.em_campo)
end event

type cb_1 from commandbutton within w_con_clientes_transportista
integer x = 1536
integer y = 172
integer width = 297
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;String desde,hasta

desde = "."
hasta = "Z"
if Trim(uo_transportista.em_campo.text)<>"" then
	desde = uo_transportista.em_codigo.text
	hasta = uo_transportista.em_codigo.text
End if
dw_transportistas.Retrieve(codigo_empresa,desde,hasta)
end event

