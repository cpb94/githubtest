$PBExportHeader$w_con_pedidos_mprima.srw
forward
global type w_con_pedidos_mprima from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_mprima
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_mprima
end type
type dw_listado_primas from datawindow within w_con_pedidos_mprima
end type
type dw_primas from datawindow within w_con_pedidos_mprima
end type
type pb_imprimir from upb_imprimir within w_con_pedidos_mprima
end type
type em_prima from u_em_campo within w_con_pedidos_mprima
end type
type st_prima from statictext within w_con_pedidos_mprima
end type
type gb_1 from groupbox within w_con_pedidos_mprima
end type
end forward

global type w_con_pedidos_mprima from w_int_con_empresa
integer width = 2907
integer height = 1644
string icon = "Application!"
pb_1 pb_1
uo_manejo uo_manejo
dw_listado_primas dw_listado_primas
dw_primas dw_primas
pb_imprimir pb_imprimir
em_prima em_prima
st_prima st_prima
gb_1 gb_1
end type
global w_con_pedidos_mprima w_con_pedidos_mprima

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Pedidos por Materias Primas"
This.title=istr_parametros.s_titulo_ventana

dw_primas.SetTransObject(SQLCA)
dw_listado_primas.SetTransObject(SQLCA)

// SI RECIBO EL CODIGO LO VISUALIZO
   IF istr_parametros.i_nargumentos>1 THEN
      em_prima.text=istr_parametros.s_argumentos[2]
      IF Trim(em_prima.text)<>"" and Not IsNull(em_prima.text) Then
			em_prima.TriggerEvent("modificado")
      END IF
	END IF
		
em_prima.setfocus()
end event

event ue_listar;dw_listado_primas.Retrieve(codigo_empresa,em_prima.text)
dw_report=dw_listado_primas
CALL Super::ue_listar
end event

on w_con_pedidos_mprima.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.dw_listado_primas=create dw_listado_primas
this.dw_primas=create dw_primas
this.pb_imprimir=create pb_imprimir
this.em_prima=create em_prima
this.st_prima=create st_prima
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.dw_listado_primas
this.Control[iCurrent+4]=this.dw_primas
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.em_prima
this.Control[iCurrent+7]=this.st_prima
this.Control[iCurrent+8]=this.gb_1
end on

on w_con_pedidos_mprima.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.dw_listado_primas)
destroy(this.dw_primas)
destroy(this.pb_imprimir)
destroy(this.em_prima)
destroy(this.st_prima)
destroy(this.gb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_primas)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_primas)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_mprima
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_mprima
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;em_prima.setfocus()
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_mprima
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_pedidos_mprima
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_mprima
integer x = 2254
integer y = 176
integer width = 613
end type

event valores;call super::valores;dw_data=dw_primas
f_activar_campo(em_prima)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_primas from datawindow within w_con_pedidos_mprima
boolean visible = false
integer x = 631
integer y = 12
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_pedidos_primas"
boolean livescroll = true
end type

type dw_primas from datawindow within w_con_pedidos_mprima
integer x = 18
integer y = 340
integer width = 2839
integer height = 1092
string dataobject = "dw_con_pedidos_mprima"
boolean hscrollbar = true
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

type pb_imprimir from upb_imprimir within w_con_pedidos_mprima
integer x = 2734
integer y = 224
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(em_prima)
end event

type em_prima from u_em_campo within w_con_pedidos_mprima
integer x = 59
integer y = 204
integer width = 411
integer taborder = 10
end type

event modificado;call super::modificado;st_prima.text = f_nombre_mprima(codigo_empresa,This.text)
iF Trim(st_prima.text) = "" Then
	IF Trim(em_prima.text)<>"" Then
	f_activar_campo(em_prima)
END IF
em_prima.text = ""
END iF

dw_primas.Retrieve(codigo_empresa,em_prima.text)
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Articulos"
ue_datawindow = "dw_ayuda_venmprima_compras"
//ue_filtro     = "tipo_materia = '1'"
end event

type st_prima from statictext within w_con_pedidos_mprima
integer x = 485
integer y = 204
integer width = 1248
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_pedidos_mprima
integer x = 46
integer y = 132
integer width = 1765
integer height = 184
integer taborder = 21
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Materia Prima"
end type

