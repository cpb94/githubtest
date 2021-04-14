$PBExportHeader$w_con_pedidos_fabricar_cliente.srw
forward
global type w_con_pedidos_fabricar_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_fabricar_cliente
end type
type pb_2 from upb_imprimir within w_con_pedidos_fabricar_cliente
end type
type st_2 from statictext within w_con_pedidos_fabricar_cliente
end type
type em_cliente from u_em_campo within w_con_pedidos_fabricar_cliente
end type
type st_nombre_cliente from statictext within w_con_pedidos_fabricar_cliente
end type
type dw_detalle from datawindow within w_con_pedidos_fabricar_cliente
end type
type dw_listado from datawindow within w_con_pedidos_fabricar_cliente
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_fabricar_cliente
end type
type cb_1 from commandbutton within w_con_pedidos_fabricar_cliente
end type
end forward

global type w_con_pedidos_fabricar_cliente from w_int_con_empresa
integer width = 2926
integer height = 1668
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_cliente em_cliente
st_nombre_cliente st_nombre_cliente
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
cb_1 cb_1
end type
global w_con_pedidos_fabricar_cliente w_con_pedidos_fabricar_cliente

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string v_cliente
dw_detalle.Reset()
if trim(em_cliente.text) = "" then
	v_cliente = "%"
else
	v_cliente = em_cliente.text
end if
dw_detalle.Retrieve(codigo_empresa,v_cliente)


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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido por cliente"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
em_cliente.setfocus()
end event

event ue_listar;string v_cliente

dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)

if trim(em_cliente.text) = "" then
	v_cliente = "%"
else
	v_cliente = em_cliente.text
end if
dw_report.retrieve(codigo_empresa,v_cliente)

CALL Super::ue_listar
end event

on w_con_pedidos_fabricar_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_cliente=create em_cliente
this.st_nombre_cliente=create st_nombre_cliente
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_cliente
this.Control[iCurrent+5]=this.st_nombre_cliente
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.uo_manejo
this.Control[iCurrent+9]=this.cb_1
end on

on w_con_pedidos_fabricar_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_cliente)
destroy(this.st_nombre_cliente)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.cb_1)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_fabricar_cliente
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_fabricar_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_fabricar_cliente
integer x = 9
integer y = 8
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_con_pedidos_fabricar_cliente
integer x = 2738
integer y = 8
integer width = 110
integer height = 96
integer taborder = 50
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_fabricar_cliente
integer x = 2738
integer y = 136
integer taborder = 30
string picturename = "print!"
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_pedidos_fabricar_cliente
integer x = 41
integer y = 144
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

type em_cliente from u_em_campo within w_con_pedidos_fabricar_cliente
integer x = 297
integer y = 140
integer width = 549
integer taborder = 10
long backcolor = 33551858
end type

event modificado;call super::modificado; st_nombre_cliente.text = f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
 if Trim(st_nombre_cliente.text)="" Then
      IF len( st_nombre_cliente.text) <> 0 Then f_activar_campo(em_cliente)
		em_cliente.text = ""
      return
 End If







 



end event

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE CLIENTES"
		ue_datawindow = "dw_ayuda_clientes"
		ue_filtro     = ""
  


 
        
end on

type st_nombre_cliente from statictext within w_con_pedidos_fabricar_cliente
integer x = 850
integer y = 144
integer width = 1106
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_detalle from datawindow within w_con_pedidos_fabricar_cliente
integer y = 248
integer width = 2848
integer height = 1196
string dataobject = "dw_con_pedidos_fabricar_cliente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;//Integer linea
//linea = row
//IF linea = 0 Then Return
//String controles
//
//controles =  This.GetItemString(linea,"usuario")
//IF controles = "MARCADO" Then
//  This.SetItem(linea,"usuario","NOMARCADO")
//  This.SelectRow(linea,FALSE)
//  f_calculo(2,linea)
//  f_calcula_bruto_linea(2,linea)
//Else
//  This.SetItem(linea,"usuario","MARCADO")
//  This.SelectRow(linea,TRUE)
//  f_calculo(1,linea)
//  f_calcula_bruto_linea(1,linea)
//End If
//
end event

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

type dw_listado from datawindow within w_con_pedidos_fabricar_cliente
boolean visible = false
integer x = 5
integer width = 160
integer height = 252
boolean bringtotop = true
string dataobject = "report_con_pedidos_fabricar_cliente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_fabricar_cliente
integer x = 2258
integer y = 92
integer width = 649
integer height = 144
integer taborder = 40
end type

on valores;call u_manejo_datawindow::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(em_cliente)
end on

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from commandbutton within w_con_pedidos_fabricar_cliente
integer x = 1957
integer y = 132
integer width = 311
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked; 
 f_control()

end event

