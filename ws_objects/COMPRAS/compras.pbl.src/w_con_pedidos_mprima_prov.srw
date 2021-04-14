$PBExportHeader$w_con_pedidos_mprima_prov.srw
forward
global type w_con_pedidos_mprima_prov from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_mprima_prov
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_mprima_prov
end type
type dw_listado_primas from datawindow within w_con_pedidos_mprima_prov
end type
type dw_primas from datawindow within w_con_pedidos_mprima_prov
end type
type pb_imprimir from upb_imprimir within w_con_pedidos_mprima_prov
end type
type em_proveedor from u_em_campo within w_con_pedidos_mprima_prov
end type
type st_proveedor from statictext within w_con_pedidos_mprima_prov
end type
type gb_1 from groupbox within w_con_pedidos_mprima_prov
end type
type em_prima from u_em_campo within w_con_pedidos_mprima_prov
end type
type st_prima from statictext within w_con_pedidos_mprima_prov
end type
type gb_2 from groupbox within w_con_pedidos_mprima_prov
end type
end forward

global type w_con_pedidos_mprima_prov from w_int_con_empresa
integer x = 5
integer y = 268
integer width = 2930
integer height = 1800
string icon = "Application!"
pb_1 pb_1
uo_manejo uo_manejo
dw_listado_primas dw_listado_primas
dw_primas dw_primas
pb_imprimir pb_imprimir
em_proveedor em_proveedor
st_proveedor st_proveedor
gb_1 gb_1
em_prima em_prima
st_prima st_prima
gb_2 gb_2
end type
global w_con_pedidos_mprima_prov w_con_pedidos_mprima_prov

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Pedidos Mat.Prima y Proveedor."
This.title=istr_parametros.s_titulo_ventana

dw_primas.SetTransObject(SQLCA)
//uo_mprima.em_campo.text= f_nombre_mprima(codigo_empresa,uo_mprima.em_codigo.text)
dw_listado_primas.SetTransObject(SQLCA)

end event

event ue_listar;dw_listado_primas.Retrieve(codigo_empresa,em_proveedor.text,em_prima.text)
dw_report=dw_listado_primas
CALL Super::ue_listar
end event

on w_con_pedidos_mprima_prov.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.dw_listado_primas=create dw_listado_primas
this.dw_primas=create dw_primas
this.pb_imprimir=create pb_imprimir
this.em_proveedor=create em_proveedor
this.st_proveedor=create st_proveedor
this.gb_1=create gb_1
this.em_prima=create em_prima
this.st_prima=create st_prima
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.dw_listado_primas
this.Control[iCurrent+4]=this.dw_primas
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.em_proveedor
this.Control[iCurrent+7]=this.st_proveedor
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.em_prima
this.Control[iCurrent+10]=this.st_prima
this.Control[iCurrent+11]=this.gb_2
end on

on w_con_pedidos_mprima_prov.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.dw_listado_primas)
destroy(this.dw_primas)
destroy(this.pb_imprimir)
destroy(this.em_proveedor)
destroy(this.st_proveedor)
destroy(this.gb_1)
destroy(this.em_prima)
destroy(this.st_prima)
destroy(this.gb_2)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_primas)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_primas)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_mprima_prov
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_mprima_prov
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_mprima_prov
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_pedidos_mprima_prov
integer x = 2752
integer y = 8
integer width = 123
integer height = 116
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_mprima_prov
integer x = 2258
integer y = 284
integer width = 613
integer height = 140
end type

event valores;call super::valores;dw_data=dw_primas
f_activar_campo(em_prima)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_primas from datawindow within w_con_pedidos_mprima_prov
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_pedidos_primas_prov"
boolean livescroll = true
end type

type dw_primas from datawindow within w_con_pedidos_mprima_prov
integer x = 41
integer y = 420
integer width = 2830
integer height = 1180
string dataobject = "dw_con_pedidos_mprima_prov"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[2]=f_valor_columna(dw_primas,dw_primas.GetRow(),"comlinpedpro_anyo")
lstr_param.s_argumentos[3]= f_valor_columna(dw_primas,dw_primas.GetRow(),"comlinpedpro_pedido")
OpenWithParm(w_mant_comcabpedpro,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_pedidos_mprima_prov
integer x = 2734
integer y = 332
integer width = 105
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(em_prima)
end event

type em_proveedor from u_em_campo within w_con_pedidos_mprima_prov
integer x = 41
integer y = 168
integer width = 288
integer taborder = 10
end type

event modificado;call super::modificado;st_proveedor.text = f_nombre_proveedor(codigo_empresa,This.text)
iF Trim(st_proveedor.text) = "" Then
	IF Trim(em_proveedor.text)<>"" Then
	f_activar_campo(em_proveedor)
END IF
em_proveedor.text = ""
END iF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Proveedores"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE

end event

type st_proveedor from statictext within w_con_pedidos_mprima_prov
integer x = 352
integer y = 168
integer width = 997
integer height = 84
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

type gb_1 from groupbox within w_con_pedidos_mprima_prov
integer x = 18
integer y = 100
integer width = 1371
integer height = 188
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proveedor"
end type

type em_prima from u_em_campo within w_con_pedidos_mprima_prov
integer x = 1431
integer y = 168
integer width = 334
integer taborder = 20
end type

event modificado;call super::modificado;st_prima.text = f_nombre_mprima(codigo_empresa,This.text)
iF Trim(st_prima.text) = "" Then
	IF Trim(em_prima.text)<>"" Then
	f_activar_campo(em_prima)
END IF
em_prima.text = ""
END iF

dw_primas.Retrieve(codigo_empresa,em_proveedor.text,em_prima.text)
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Articulos"
ue_datawindow = "dw_ayuda_venmprima_compras"
ue_filtro     = "tipo_materia = '1'"
end event

type st_prima from statictext within w_con_pedidos_mprima_prov
integer x = 1774
integer y = 168
integer width = 1051
integer height = 84
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

type gb_2 from groupbox within w_con_pedidos_mprima_prov
integer x = 1408
integer y = 108
integer width = 1467
integer height = 180
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
string text = "M.Prima"
end type

