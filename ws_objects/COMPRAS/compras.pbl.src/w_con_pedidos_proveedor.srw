$PBExportHeader$w_con_pedidos_proveedor.srw
forward
global type w_con_pedidos_proveedor from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_proveedor
end type
type st_proveedor from statictext within w_con_pedidos_proveedor
end type
type uo_proveedor from u_em_campo_2 within w_con_pedidos_proveedor
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_proveedor
end type
type dw_listado_proveedores from datawindow within w_con_pedidos_proveedor
end type
type dw_proveedores from datawindow within w_con_pedidos_proveedor
end type
type pb_imprimir from upb_imprimir within w_con_pedidos_proveedor
end type
end forward

global type w_con_pedidos_proveedor from w_int_con_empresa
integer width = 2971
integer height = 1676
string icon = "Application!"
pb_1 pb_1
st_proveedor st_proveedor
uo_proveedor uo_proveedor
uo_manejo uo_manejo
dw_listado_proveedores dw_listado_proveedores
dw_proveedores dw_proveedores
pb_imprimir pb_imprimir
end type
global w_con_pedidos_proveedor w_con_pedidos_proveedor

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Pedidos por Proveedor"
This.title=istr_parametros.s_titulo_ventana

dw_proveedores.SetTransObject(SQLCA)
uo_proveedor.em_campo.text= f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)
dw_listado_proveedores.SetTransObject(SQLCA)
uo_proveedor.em_campo.setfocus()
end event

event ue_listar;dw_listado_proveedores.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text)
dw_report=dw_listado_proveedores
CALL Super::ue_listar
end event

on w_con_pedidos_proveedor.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_proveedor=create st_proveedor
this.uo_proveedor=create uo_proveedor
this.uo_manejo=create uo_manejo
this.dw_listado_proveedores=create dw_listado_proveedores
this.dw_proveedores=create dw_proveedores
this.pb_imprimir=create pb_imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_proveedor
this.Control[iCurrent+3]=this.uo_proveedor
this.Control[iCurrent+4]=this.uo_manejo
this.Control[iCurrent+5]=this.dw_listado_proveedores
this.Control[iCurrent+6]=this.dw_proveedores
this.Control[iCurrent+7]=this.pb_imprimir
end on

on w_con_pedidos_proveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_proveedor)
destroy(this.uo_proveedor)
destroy(this.uo_manejo)
destroy(this.dw_listado_proveedores)
destroy(this.dw_proveedores)
destroy(this.pb_imprimir)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_proveedores)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_proveedores)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_proveedor
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_proveedor
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_proveedor
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_pedidos_proveedor
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type st_proveedor from statictext within w_con_pedidos_proveedor
integer x = 14
integer y = 168
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor:"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_proveedor from u_em_campo_2 within w_con_pedidos_proveedor
integer x = 370
integer y = 160
integer width = 1093
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)
IF Trim(uo_proveedor.em_campo.text)="" THEN 
 IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
 uo_proveedor.em_campo.text=""
 uo_proveedor.em_codigo.text=""
END IF

dw_proveedores.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text)
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Proveedores"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE

end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type uo_manejo from u_manejo_datawindow within w_con_pedidos_proveedor
integer x = 2267
integer y = 108
integer width = 613
end type

event valores;call super::valores;dw_data=dw_proveedores
f_activar_campo(uo_proveedor.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_proveedores from datawindow within w_con_pedidos_proveedor
boolean visible = false
integer x = 562
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_pedidos_proveedor"
boolean livescroll = true
end type

type dw_proveedores from datawindow within w_con_pedidos_proveedor
integer y = 264
integer width = 2871
integer height = 1176
string dataobject = "dw_con_pedidos_proveedor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[2]=f_valor_columna(dw_proveedores,dw_proveedores.GetRow(),"comlinpedpro_anyo")
lstr_param.s_argumentos[3]= f_valor_columna(dw_proveedores,dw_proveedores.GetRow(),"comlinpedpro_pedido")
OpenWithParm(w_mant_comcabpedpro,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_pedidos_proveedor
integer x = 2747
integer y = 156
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(uo_proveedor.em_campo)
end event

