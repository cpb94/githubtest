$PBExportHeader$w_con_pedidos_fechas_prov.srw
forward
global type w_con_pedidos_fechas_prov from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_fechas_prov
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_fechas_prov
end type
type dw_listado_fechas from datawindow within w_con_pedidos_fechas_prov
end type
type pb_imprimir from upb_imprimir within w_con_pedidos_fechas_prov
end type
type dw_fechas from datawindow within w_con_pedidos_fechas_prov
end type
type uo_proveedor from u_em_campo_2 within w_con_pedidos_fechas_prov
end type
type gb_2 from groupbox within w_con_pedidos_fechas_prov
end type
type em_fpedido1 from u_em_campo within w_con_pedidos_fechas_prov
end type
type em_fpedido2 from u_em_campo within w_con_pedidos_fechas_prov
end type
type st_1 from statictext within w_con_pedidos_fechas_prov
end type
type st_2 from statictext within w_con_pedidos_fechas_prov
end type
type gb_1 from groupbox within w_con_pedidos_fechas_prov
end type
type cb_1 from commandbutton within w_con_pedidos_fechas_prov
end type
end forward

global type w_con_pedidos_fechas_prov from w_int_con_empresa
integer width = 2898
integer height = 1808
string icon = "Application!"
pb_1 pb_1
uo_manejo uo_manejo
dw_listado_fechas dw_listado_fechas
pb_imprimir pb_imprimir
dw_fechas dw_fechas
uo_proveedor uo_proveedor
gb_2 gb_2
em_fpedido1 em_fpedido1
em_fpedido2 em_fpedido2
st_1 st_1
st_2 st_2
gb_1 gb_1
cb_1 cb_1
end type
global w_con_pedidos_fechas_prov w_con_pedidos_fechas_prov

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Pedidos entre Fechas y por Proveedor"
This.title=istr_parametros.s_titulo_ventana

dw_fechas.SetTransObject(SQLCA)
//dw_fechas.SetRowFocusIndicator(Hand!)
dw_listado_fechas.SetTransObject(SQLCA)
em_fpedido1.text=string(date(year(today()),month(today()),1))
em_fpedido2.text=string(today())

uo_proveedor.em_campo.setfocus()
end event

event ue_listar;dw_listado_fechas.Retrieve(codigo_empresa,datetime(date(em_fpedido1.text)),datetime(date(em_fpedido2.text)),uo_proveedor.em_codigo.text)
dw_report=dw_listado_fechas
CALL Super::ue_listar
end event

on w_con_pedidos_fechas_prov.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.dw_listado_fechas=create dw_listado_fechas
this.pb_imprimir=create pb_imprimir
this.dw_fechas=create dw_fechas
this.uo_proveedor=create uo_proveedor
this.gb_2=create gb_2
this.em_fpedido1=create em_fpedido1
this.em_fpedido2=create em_fpedido2
this.st_1=create st_1
this.st_2=create st_2
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.dw_listado_fechas
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_fechas
this.Control[iCurrent+6]=this.uo_proveedor
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.em_fpedido1
this.Control[iCurrent+9]=this.em_fpedido2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.cb_1
end on

on w_con_pedidos_fechas_prov.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.dw_listado_fechas)
destroy(this.pb_imprimir)
destroy(this.dw_fechas)
destroy(this.uo_proveedor)
destroy(this.gb_2)
destroy(this.em_fpedido1)
destroy(this.em_fpedido2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.cb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_fechas)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_fechas)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_fechas_prov
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_fechas_prov
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;uo_proveedor.em_campo.setfocus()
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_fechas_prov
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_pedidos_fechas_prov
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_fechas_prov
integer x = 2245
integer y = 268
integer width = 613
end type

event valores;call super::valores;dw_data=dw_fechas
f_activar_campo(em_fpedido1)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_fechas from datawindow within w_con_pedidos_fechas_prov
boolean visible = false
integer x = 325
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_pedidos_fechas_prov"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_pedidos_fechas_prov
integer x = 2720
integer y = 316
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(em_fpedido1)
end event

type dw_fechas from datawindow within w_con_pedidos_fechas_prov
integer x = 32
integer y = 428
integer width = 2807
integer height = 1176
boolean bringtotop = true
string dataobject = "dw_con_pedidos_fechas_prov"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[3]=f_valor_columna(dw_fechas,dw_fechas.GetRow(),"comlinalb_anyo")
lstr_param.s_argumentos[2]= f_valor_columna(dw_fechas,dw_fechas.GetRow(),"comlinalb_albaran")
OpenWithParm(w_mant_comlinalb,lstr_param) 


end event

type uo_proveedor from u_em_campo_2 within w_con_pedidos_fechas_prov
integer x = 777
integer y = 292
integer width = 1390
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)
If Trim(uo_proveedor.em_campo.text)="" Then
	If Trim(uo_proveedor.em_codigo.text)<>"" then uo_proveedor.em_campo.SetFocus()
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
end if

//dw_fechas.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,datetime(date(em_fpedido1.text)),datetime(date(em_fpedido2.text)))
end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_proveedores"
ue_titulo     =  "AYUDA SELECCION DE PROVEEDORES"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type gb_2 from groupbox within w_con_pedidos_fechas_prov
integer x = 745
integer y = 216
integer width = 1454
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

type em_fpedido1 from u_em_campo within w_con_pedidos_fechas_prov
integer x = 311
integer y = 212
integer width = 302
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "$Œç<pïMˆïM"
end type

type em_fpedido2 from u_em_campo within w_con_pedidos_fechas_prov
integer x = 311
integer y = 308
integer width = 302
integer taborder = 50
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "˜"
end type

type st_1 from statictext within w_con_pedidos_fechas_prov
integer x = 50
integer y = 216
integer width = 197
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_pedidos_fechas_prov
integer x = 69
integer y = 312
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

type gb_1 from groupbox within w_con_pedidos_fechas_prov
integer x = 37
integer y = 128
integer width = 695
integer height = 288
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Pedido"
end type

type cb_1 from commandbutton within w_con_pedidos_fechas_prov
integer x = 1883
integer y = 124
integer width = 306
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;dw_fechas.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,datetime(date(em_fpedido1.text)),datetime(date(em_fpedido2.text)))
end event

