﻿$PBExportHeader$w_con_pedidos_fentrega_prov.srw
forward
global type w_con_pedidos_fentrega_prov from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_fentrega_prov
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_fentrega_prov
end type
type dw_listado_fentrega from datawindow within w_con_pedidos_fentrega_prov
end type
type dw_fentrega from datawindow within w_con_pedidos_fentrega_prov
end type
type pb_imprimir from upb_imprimir within w_con_pedidos_fentrega_prov
end type
type em_fentrega from u_em_campo within w_con_pedidos_fentrega_prov
end type
type st_2 from statictext within w_con_pedidos_fentrega_prov
end type
type st_1 from statictext within w_con_pedidos_fentrega_prov
end type
type em_fentrega1 from u_em_campo within w_con_pedidos_fentrega_prov
end type
type em_proveedor from u_em_campo within w_con_pedidos_fentrega_prov
end type
type st_proveedor from statictext within w_con_pedidos_fentrega_prov
end type
type gb_1 from groupbox within w_con_pedidos_fentrega_prov
end type
type gb_2 from groupbox within w_con_pedidos_fentrega_prov
end type
end forward

global type w_con_pedidos_fentrega_prov from w_int_con_empresa
integer width = 2935
integer height = 1764
string icon = "Application!"
pb_1 pb_1
uo_manejo uo_manejo
dw_listado_fentrega dw_listado_fentrega
dw_fentrega dw_fentrega
pb_imprimir pb_imprimir
em_fentrega em_fentrega
st_2 st_2
st_1 st_1
em_fentrega1 em_fentrega1
em_proveedor em_proveedor
st_proveedor st_proveedor
gb_1 gb_1
gb_2 gb_2
end type
global w_con_pedidos_fentrega_prov w_con_pedidos_fentrega_prov

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Pedidos por Proveedor y Fecha Entrega."
This.title=istr_parametros.s_titulo_ventana

dw_fentrega.SetTransObject(SQLCA)
//dw_fentrega.SetRowFocusIndicator(Hand!)
dw_listado_fentrega.SetTransObject(SQLCA)
em_fentrega.text=string(today())
//uo_proveedor.em_campo.setfocus()

end event

event ue_listar;dw_listado_fentrega.Retrieve(codigo_empresa,em_proveedor.text,datetime(date(em_fentrega1.text)),datetime(date(string(em_fentrega.text))))
dw_report=dw_listado_fentrega
CALL Super::ue_listar
end event

on w_con_pedidos_fentrega_prov.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.dw_listado_fentrega=create dw_listado_fentrega
this.dw_fentrega=create dw_fentrega
this.pb_imprimir=create pb_imprimir
this.em_fentrega=create em_fentrega
this.st_2=create st_2
this.st_1=create st_1
this.em_fentrega1=create em_fentrega1
this.em_proveedor=create em_proveedor
this.st_proveedor=create st_proveedor
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.dw_listado_fentrega
this.Control[iCurrent+4]=this.dw_fentrega
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.em_fentrega
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_fentrega1
this.Control[iCurrent+10]=this.em_proveedor
this.Control[iCurrent+11]=this.st_proveedor
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_con_pedidos_fentrega_prov.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.dw_listado_fentrega)
destroy(this.dw_fentrega)
destroy(this.pb_imprimir)
destroy(this.em_fentrega)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fentrega1)
destroy(this.em_proveedor)
destroy(this.st_proveedor)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_fentrega)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_fentrega)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_fentrega_prov
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_fentrega_prov
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;em_proveedor.setfocus()
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_fentrega_prov
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_pedidos_fentrega_prov
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_fentrega_prov
integer x = 2286
integer y = 192
integer width = 613
end type

event valores;call super::valores;dw_data=dw_fentrega
f_activar_campo(em_fentrega)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_fentrega from datawindow within w_con_pedidos_fentrega_prov
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_pedidos_fentrega_proveedor"
boolean livescroll = true
end type

type dw_fentrega from datawindow within w_con_pedidos_fentrega_prov
integer x = 23
integer y = 352
integer width = 2848
integer height = 1224
string dataobject = "dw_con_pedidos_fentrega_prov"
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

type pb_imprimir from upb_imprimir within w_con_pedidos_fentrega_prov
integer x = 2761
integer y = 240
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(em_fentrega)
end event

type em_fentrega from u_em_campo within w_con_pedidos_fentrega_prov
integer x = 777
integer y = 208
integer width = 315
integer height = 72
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "˜"
end type

type st_2 from statictext within w_con_pedidos_fentrega_prov
integer x = 590
integer y = 208
integer width = 187
integer height = 72
integer textsize = -9
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

type st_1 from statictext within w_con_pedidos_fentrega_prov
integer x = 50
integer y = 208
integer width = 206
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fentrega1 from u_em_campo within w_con_pedidos_fentrega_prov
integer x = 256
integer y = 208
integer width = 315
integer height = 72
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = " "
end type

type em_proveedor from u_em_campo within w_con_pedidos_fentrega_prov
integer x = 1161
integer y = 208
integer width = 288
integer taborder = 30
end type

event modificado;call super::modificado;st_proveedor.text = f_nombre_proveedor(codigo_empresa,This.text)
iF Trim(st_proveedor.text) = "" Then
	IF Trim(em_proveedor.text)<>"" Then
	f_activar_campo(em_proveedor)
END IF
em_proveedor.text = ""
END iF

dw_fentrega.Retrieve(codigo_empresa,em_proveedor.text,datetime(date(String(em_fentrega1.text))),datetime(date(string(em_fentrega.text))))
end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_proveedores"
ue_titulo     =  "AYUDA SELECCION DE PROVEEDORES"
ue_filtro     =  ""
valor_empresa = TRUE
end event

type st_proveedor from statictext within w_con_pedidos_fentrega_prov
integer x = 1454
integer y = 212
integer width = 805
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_pedidos_fentrega_prov
integer x = 37
integer y = 128
integer width = 1070
integer height = 196
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Entrega"
end type

type gb_2 from groupbox within w_con_pedidos_fentrega_prov
integer x = 1134
integer y = 128
integer width = 1147
integer height = 196
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Proveedor"
end type

