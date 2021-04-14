$PBExportHeader$w_con_pedidos_fentrega.srw
forward
global type w_con_pedidos_fentrega from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_fentrega
end type
type st_fentrega from statictext within w_con_pedidos_fentrega
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_fentrega
end type
type dw_listado_fentrega from datawindow within w_con_pedidos_fentrega
end type
type dw_fentrega from datawindow within w_con_pedidos_fentrega
end type
type pb_imprimir from upb_imprimir within w_con_pedidos_fentrega
end type
type em_fentrega from u_em_campo within w_con_pedidos_fentrega
end type
type cb_1 from commandbutton within w_con_pedidos_fentrega
end type
type gb_2 from groupbox within w_con_pedidos_fentrega
end type
type gb_1 from groupbox within w_con_pedidos_fentrega
end type
end forward

global type w_con_pedidos_fentrega from w_int_con_empresa
integer width = 3063
integer height = 1660
string icon = "Application!"
pb_1 pb_1
st_fentrega st_fentrega
uo_manejo uo_manejo
dw_listado_fentrega dw_listado_fentrega
dw_fentrega dw_fentrega
pb_imprimir pb_imprimir
em_fentrega em_fentrega
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
end type
global w_con_pedidos_fentrega w_con_pedidos_fentrega

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Pedidos por Fecha de Entrega"
This.title=istr_parametros.s_titulo_ventana

dw_fentrega.SetTransObject(SQLCA)
//dw_fentrega.SetRowFocusIndicator(Hand!)
dw_listado_fentrega.SetTransObject(SQLCA)

em_fentrega.text=string(today())
cb_1.setfocus()

end event

event ue_listar;dw_listado_fentrega.Retrieve(codigo_empresa,datetime(date(em_fentrega.text)))
dw_report=dw_listado_fentrega
CALL Super::ue_listar
end event

on w_con_pedidos_fentrega.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_fentrega=create st_fentrega
this.uo_manejo=create uo_manejo
this.dw_listado_fentrega=create dw_listado_fentrega
this.dw_fentrega=create dw_fentrega
this.pb_imprimir=create pb_imprimir
this.em_fentrega=create em_fentrega
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_fentrega
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.dw_listado_fentrega
this.Control[iCurrent+5]=this.dw_fentrega
this.Control[iCurrent+6]=this.pb_imprimir
this.Control[iCurrent+7]=this.em_fentrega
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_1
end on

on w_con_pedidos_fentrega.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_fentrega)
destroy(this.uo_manejo)
destroy(this.dw_listado_fentrega)
destroy(this.dw_fentrega)
destroy(this.pb_imprimir)
destroy(this.em_fentrega)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_fentrega)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_fentrega)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_fentrega
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_fentrega
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_fentrega
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_pedidos_fentrega
integer x = 2871
integer y = 8
integer width = 123
integer height = 116
integer taborder = 0
end type

type st_fentrega from statictext within w_con_pedidos_fentrega
integer x = 571
integer y = 152
integer width = 210
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_fentrega
integer x = 2254
integer y = 104
integer width = 613
end type

event valores;call super::valores;dw_data=dw_fentrega
f_activar_campo(em_fentrega)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_fentrega from datawindow within w_con_pedidos_fentrega
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_pedidos_fentrega"
boolean livescroll = true
end type

type dw_fentrega from datawindow within w_con_pedidos_fentrega
integer x = 18
integer y = 268
integer width = 2949
integer height = 1176
string dataobject = "dw_con_pedidos_fentrega"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[2]=f_valor_columna(dw_fentrega,dw_fentrega.GetRow(),"comlinpedpro_anyo")
lstr_param.s_argumentos[3]= f_valor_columna(dw_fentrega,dw_fentrega.GetRow(),"comlinpedpro_pedido")
OpenWithParm(w_mant_comcabpedpro,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_pedidos_fentrega
integer x = 2734
integer y = 152
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(em_fentrega)
end event

type em_fentrega from u_em_campo within w_con_pedidos_fentrega
integer x = 786
integer y = 152
integer width = 343
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type cb_1 from commandbutton within w_con_pedidos_fentrega
integer x = 1184
integer y = 152
integer width = 457
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;dw_fentrega.Retrieve(codigo_empresa,datetime(date(em_fentrega.text)))

end event

type gb_2 from groupbox within w_con_pedidos_fentrega
integer x = 18
integer y = 104
integer width = 1134
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Entrega"
end type

type gb_1 from groupbox within w_con_pedidos_fentrega
integer x = 1166
integer y = 104
integer width = 494
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

