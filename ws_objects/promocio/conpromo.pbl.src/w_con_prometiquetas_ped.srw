$PBExportHeader$w_con_prometiquetas_ped.srw
forward
global type w_con_prometiquetas_ped from w_int_con_empresa
end type
type st_conpromalb1 from statictext within w_con_prometiquetas_ped
end type
type pb_1 from upb_salir within w_con_prometiquetas_ped
end type
type pb_imprimir from upb_imprimir within w_con_prometiquetas_ped
end type
type dw_listado_conpromalb1 from datawindow within w_con_prometiquetas_ped
end type
type uo_manejo from u_manejo_datawindow within w_con_prometiquetas_ped
end type
type dw_etiquetas from datawindow within w_con_prometiquetas_ped
end type
type em_anyo from u_em_campo within w_con_prometiquetas_ped
end type
type st_pedido from statictext within w_con_prometiquetas_ped
end type
type em_pedido from u_em_campo within w_con_prometiquetas_ped
end type
type cb_1 from u_boton within w_con_prometiquetas_ped
end type
end forward

global type w_con_prometiquetas_ped from w_int_con_empresa
integer x = 27
integer y = 32
integer width = 3511
integer height = 2216
st_conpromalb1 st_conpromalb1
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado_conpromalb1 dw_listado_conpromalb1
uo_manejo uo_manejo
dw_etiquetas dw_etiquetas
em_anyo em_anyo
st_pedido st_pedido
em_pedido em_pedido
cb_1 cb_1
end type
global w_con_prometiquetas_ped w_con_prometiquetas_ped

on w_con_prometiquetas_ped.create
int iCurrent
call super::create
this.st_conpromalb1=create st_conpromalb1
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado_conpromalb1=create dw_listado_conpromalb1
this.uo_manejo=create uo_manejo
this.dw_etiquetas=create dw_etiquetas
this.em_anyo=create em_anyo
this.st_pedido=create st_pedido
this.em_pedido=create em_pedido
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_conpromalb1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.dw_listado_conpromalb1
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.dw_etiquetas
this.Control[iCurrent+7]=this.em_anyo
this.Control[iCurrent+8]=this.st_pedido
this.Control[iCurrent+9]=this.em_pedido
this.Control[iCurrent+10]=this.cb_1
end on

on w_con_prometiquetas_ped.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_conpromalb1)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado_conpromalb1)
destroy(this.uo_manejo)
destroy(this.dw_etiquetas)
destroy(this.em_anyo)
destroy(this.st_pedido)
destroy(this.em_pedido)
destroy(this.cb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Listado etiquetas Pedidos Promocion"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana
em_anyo.text = String(Year(Today()))
dw_etiquetas.SetTransObject(SQLCA)
dw_listado_conpromalb1.SetTransObject(SQLCA)
f_activar_campo(em_pedido)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_etiquetas)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_etiquetas)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_etiquetas)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_etiquetas)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_prometiquetas_ped
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_prometiquetas_ped
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_pedido)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_prometiquetas_ped
end type

type st_conpromalb1 from statictext within w_con_prometiquetas_ped
integer x = 69
integer y = 184
integer width = 187
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_con_prometiquetas_ped
integer x = 3246
integer y = 28
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_prometiquetas_ped
integer x = 3250
integer y = 188
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;if trim( em_pedido.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca el pedido")
	  Return
END IF
dw_etiquetas.Object.Datawindow.zoom = 100
f_imprimir_datawindow(dw_etiquetas)
dw_etiquetas.Object.Datawindow.zoom = 75
f_activar_campo(em_pedido)


end event

type dw_listado_conpromalb1 from datawindow within w_con_prometiquetas_ped
boolean visible = false
integer x = 64
integer y = 8
integer width = 494
integer height = 264
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_conpromalb1"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_prometiquetas_ped
integer x = 2775
integer y = 140
integer width = 622
integer height = 156
end type

event valores;call super::valores;dw_data=dw_etiquetas
f_activar_campo(em_pedido)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_etiquetas from datawindow within w_con_prometiquetas_ped
integer y = 308
integer width = 3415
integer height = 1624
string dataobject = "dw_con_prometiquetas_ped1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_anyo from u_em_campo within w_con_prometiquetas_ped
integer x = 265
integer y = 176
integer taborder = 0
end type

type st_pedido from statictext within w_con_prometiquetas_ped
integer x = 576
integer y = 184
integer width = 238
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pedido:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_pedido from u_em_campo within w_con_prometiquetas_ped
integer x = 823
integer y = 176
integer taborder = 10
boolean bringtotop = true
end type

event getfocus;call super::getfocus;  ue_titulo = "Selección de Pedidos"
   ue_datawindow ="dw_ayuda_promped"
   ue_filtro = "anyo =" + em_anyo.text
end event

type cb_1 from u_boton within w_con_prometiquetas_ped
integer x = 1179
integer y = 172
integer height = 92
integer taborder = 20
string text = "&Continuar"
end type

event clicked;call super::clicked;dw_etiquetas.Object.Datawindow.zoom = 75
dw_etiquetas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
end event

