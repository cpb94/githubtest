$PBExportHeader$w_con_clientes_deposito.srw
forward
global type w_con_clientes_deposito from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_clientes_deposito
end type
type uo_manejo from u_manejo_datawindow within w_con_clientes_deposito
end type
type dw_listado from datawindow within w_con_clientes_deposito
end type
type dw_detalle from datawindow within w_con_clientes_deposito
end type
type pb_imprimir from upb_imprimir within w_con_clientes_deposito
end type
end forward

global type w_con_clientes_deposito from w_int_con_empresa
integer width = 2921
integer height = 1660
pb_1 pb_1
uo_manejo uo_manejo
dw_listado dw_listado
dw_detalle dw_detalle
pb_imprimir pb_imprimir
end type
global w_con_clientes_deposito w_con_clientes_deposito

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="CONSULTA DE  CLIENTES DEPOSITO"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_detalle.Retrieve(codigo_empresa)
dw_detalle.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

end event

event ue_listar;dw_listado.Retrieve(codigo_empresa)
dw_report=dw_listado
CALL Super::ue_listar
end event

on w_con_clientes_deposito.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.dw_listado=create dw_listado
this.dw_detalle=create dw_detalle
this.pb_imprimir=create pb_imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.pb_imprimir
end on

on w_con_clientes_deposito.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.dw_listado)
destroy(this.dw_detalle)
destroy(this.pb_imprimir)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_detalle")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_detalle")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_clientes_deposito
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_clientes_deposito
integer taborder = 20
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_clientes_deposito
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_clientes_deposito
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_clientes_deposito
integer x = 2254
integer y = 104
integer width = 613
end type

event valores;call super::valores;dw_data=dw_detalle

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_con_clientes_deposito
boolean visible = false
integer x = 288
integer y = 4
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_clientes_deposito"
boolean livescroll = true
end type

type dw_detalle from datawindow within w_con_clientes_deposito
integer y = 256
integer width = 2857
integer height = 1176
string dataobject = "dw_con_clientes_deposito"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[1]="wi_con_clientes_deposito"
lstr_param.s_argumentos[2]="C"
lstr_param.s_argumentos[3]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clipro,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_clientes_deposito
integer x = 2734
integer y = 152
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")

end event

