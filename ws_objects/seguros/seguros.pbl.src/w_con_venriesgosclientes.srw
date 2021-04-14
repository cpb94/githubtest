$PBExportHeader$w_con_venriesgosclientes.srw
forward
global type w_con_venriesgosclientes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_venriesgosclientes
end type
type pb_2 from upb_imprimir within w_con_venriesgosclientes
end type
type uo_manejo from u_manejo_datawindow within w_con_venriesgosclientes
end type
type dw_detalle from u_datawindow_consultas within w_con_venriesgosclientes
end type
type dw_listado from datawindow within w_con_venriesgosclientes
end type
type st_2 from statictext within w_con_venriesgosclientes
end type
type uo_cliente from u_em_campo_2 within w_con_venriesgosclientes
end type
type cb_1 from u_boton within w_con_venriesgosclientes
end type
end forward

global type w_con_venriesgosclientes from w_int_con_empresa
integer width = 2907
integer height = 2092
pb_1 pb_1
pb_2 pb_2
uo_manejo uo_manejo
dw_detalle dw_detalle
dw_listado dw_listado
st_2 st_2
uo_cliente uo_cliente
cb_1 cb_1
end type
global w_con_venriesgosclientes w_con_venriesgosclientes

type variables
string filtro
end variables

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta riesgos por clientes"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_detalle.visible = FALSE

f_activar_campo(uo_cliente.em_campo)

end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_venriesgosclientes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.uo_manejo=create uo_manejo
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.st_2=create st_2
this.uo_cliente=create uo_cliente
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.cb_1
end on

on w_con_venriesgosclientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.uo_manejo)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.st_2)
destroy(this.uo_cliente)
destroy(this.cb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_venriesgosclientes
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_venriesgosclientes
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_venriesgosclientes
integer x = 32
integer width = 2427
integer height = 104
end type

type pb_1 from upb_salir within w_con_venriesgosclientes
integer x = 2734
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_venriesgosclientes
integer x = 2679
integer y = 132
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
f_activar_campo(uo_cliente.em_campo)
end event

type uo_manejo from u_manejo_datawindow within w_con_venriesgosclientes
integer x = 2203
integer y = 84
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

type dw_detalle from u_datawindow_consultas within w_con_venriesgosclientes
integer y = 240
integer width = 2862
integer height = 1620
integer taborder = 0
string dataobject = "dw_con_riesgosclientes"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;if row=0 then Return
str_parametros lstr_param 
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=uo_cliente.em_codigo.text
  lstr_param.s_argumentos[3]=String(dw_detalle.GetItemString(This.GetRow(),"cuenta"))
  OpenWithParm(wi_mant_venriesgosclientes,lstr_param)

end event

type dw_listado from datawindow within w_con_venriesgosclientes
boolean visible = false
integer x = 1673
integer width = 1010
integer height = 108
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_riesgos_clientes"
boolean livescroll = true
end type

type st_2 from statictext within w_con_venriesgosclientes
integer x = 27
integer y = 128
integer width = 329
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Compañia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_con_venriesgosclientes
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 361
integer y = 128
integer width = 1307
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_cliente.em_campo.text=f_nombre_segcompanyia(codigo_empresa,uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	filtro = ""
	Return
else
	filtro = "venriesgoclientes_companyia ='"+uo_cliente.em_codigo.text+"'"
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de compañias"
ue_datawindow ="dw_ayuda_segcompanyias"
ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within w_con_venriesgosclientes
integer x = 1682
integer y = 128
integer height = 84
integer taborder = 30
string text = "&Consultar"
end type

event clicked;call super::clicked;dw_detalle.reset()
dw_detalle.visible= FALSE
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
dw_detalle.visible= TRUE
end event

