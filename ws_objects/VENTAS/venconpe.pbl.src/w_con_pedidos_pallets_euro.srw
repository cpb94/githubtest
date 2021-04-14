$PBExportHeader$w_con_pedidos_pallets_euro.srw
forward
global type w_con_pedidos_pallets_euro from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_pallets_euro
end type
type pb_2 from upb_imprimir within w_con_pedidos_pallets_euro
end type
type st_2 from statictext within w_con_pedidos_pallets_euro
end type
type dw_detalle from datawindow within w_con_pedidos_pallets_euro
end type
type dw_listado from datawindow within w_con_pedidos_pallets_euro
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_pallets_euro
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_pallets_euro
end type
type cb_1 from commandbutton within w_con_pedidos_pallets_euro
end type
type rb_1 from radiobutton within w_con_pedidos_pallets_euro
end type
end forward

global type w_con_pedidos_pallets_euro from w_int_con_empresa
integer width = 2944
integer height = 1660
pb_1 pb_1
pb_2 pb_2
st_2 st_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
uo_cliente uo_cliente
cb_1 cb_1
rb_1 rb_1
end type
global w_con_pedidos_pallets_euro w_con_pedidos_pallets_euro

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow dw_data)
end prototypes

public subroutine f_control (datawindow dw_data);dw_data.Reset()

dw_data.Setfilter("")
dw_data.filter()

String tpallet = "2"
if rb_1.checked = True then 	tpallet ="1"

if Trim(uo_cliente.em_codigo.text)<>"" then
	dw_data.Setfilter("cliente = '"+uo_cliente.em_codigo.text+"'")
	dw_data.filter()
End if
dw_data.Retrieve(codigo_empresa,tpallet)


end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta ln/pedido con t/pallet dif. ficha cliente"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(uo_cliente.em_campo)


end event

on w_con_pedidos_pallets_euro.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.uo_cliente=create uo_cliente
this.cb_1=create cb_1
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.rb_1
end on

on w_con_pedidos_pallets_euro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.uo_cliente)
destroy(this.cb_1)
destroy(this.rb_1)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_pallets_euro
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_pallets_euro
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_pallets_euro
integer x = 9
integer y = 8
integer width = 2427
integer height = 104
end type

type pb_1 from upb_salir within w_con_pedidos_pallets_euro
integer x = 2738
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_pallets_euro
integer x = 2738
integer y = 140
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type st_2 from statictext within w_con_pedidos_pallets_euro
integer x = 9
integer y = 156
integer width = 238
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_detalle from datawindow within w_con_pedidos_pallets_euro
integer x = 9
integer y = 248
integer width = 2848
integer height = 1176
integer taborder = 30
string dataobject = "dw_con_pedidos_pallets_euro"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

event rbuttondown;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[2]=String(This.GetItemString(Row,"articulo"))
  OpenWithParm(w_int_asignacion_stock,lstr_param) 
End If
end event

type dw_listado from datawindow within w_con_pedidos_pallets_euro
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_pedidos_pallets_euro"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_pallets_euro
integer x = 2258
integer y = 92
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type uo_cliente from u_em_campo_2 within w_con_pedidos_pallets_euro
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 265
integer y = 148
integer width = 1093
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;dw_detalle.Reset()
uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 




end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type cb_1 from commandbutton within w_con_pedidos_pallets_euro
integer x = 1367
integer y = 144
integer width = 329
integer height = 92
integer taborder = 11
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;f_control(dw_detalle)
end event

type rb_1 from radiobutton within w_con_pedidos_pallets_euro
integer x = 1797
integer y = 148
integer width = 384
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Pal. N->E"
boolean automatic = false
boolean lefttext = true
end type

event clicked;if rb_1.checked = True then
   rb_1.Text = "Pal. E->N"
	rb_1.checked = False
else 
	rb_1.Text = "Pal. N->E"
	rb_1.checked = True
End if
end event

