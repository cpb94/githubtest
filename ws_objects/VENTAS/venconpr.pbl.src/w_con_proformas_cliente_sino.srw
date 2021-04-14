$PBExportHeader$w_con_proformas_cliente_sino.srw
forward
global type w_con_proformas_cliente_sino from w_int_con_empresa
end type
type st_conpromped2 from statictext within w_con_proformas_cliente_sino
end type
type uo_cliente from u_em_campo_2 within w_con_proformas_cliente_sino
end type
type pb_1 from upb_salir within w_con_proformas_cliente_sino
end type
type pb_imprimir from upb_imprimir within w_con_proformas_cliente_sino
end type
type dw_listado2 from datawindow within w_con_proformas_cliente_sino
end type
type uo_manejo from u_manejo_datawindow within w_con_proformas_cliente_sino
end type
type dw_1 from datawindow within w_con_proformas_cliente_sino
end type
type ddlb_1 from dropdownlistbox within w_con_proformas_cliente_sino
end type
type gb_boton from groupbox within w_con_proformas_cliente_sino
end type
type cb_1 from commandbutton within w_con_proformas_cliente_sino
end type
type cb_2 from commandbutton within w_con_proformas_cliente_sino
end type
end forward

global type w_con_proformas_cliente_sino from w_int_con_empresa
integer x = 5
integer y = 308
integer width = 2962
integer height = 1716
st_conpromped2 st_conpromped2
uo_cliente uo_cliente
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado2 dw_listado2
uo_manejo uo_manejo
dw_1 dw_1
ddlb_1 ddlb_1
gb_boton gb_boton
cb_1 cb_1
cb_2 cb_2
end type
global w_con_proformas_cliente_sino w_con_proformas_cliente_sino

on w_con_proformas_cliente_sino.create
int iCurrent
call super::create
this.st_conpromped2=create st_conpromped2
this.uo_cliente=create uo_cliente
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado2=create dw_listado2
this.uo_manejo=create uo_manejo
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.gb_boton=create gb_boton
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_conpromped2
this.Control[iCurrent+2]=this.uo_cliente
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado2
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.ddlb_1
this.Control[iCurrent+9]=this.gb_boton
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.cb_2
end on

on w_con_proformas_cliente_sino.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_conpromped2)
destroy(this.uo_cliente)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado2)
destroy(this.uo_manejo)
destroy(this.dw_1)
destroy(this.ddlb_1)
destroy(this.gb_boton)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Proformas por Cliente"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado2.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)

ddlb_1.text ="Si" 
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;string tipo_cli

tipo_cli ="N"
if ddlb_1.text ="Si" then tipo_cli ="S"

dw_listado2.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,tipo_cli)
dw_report =dw_listado2
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_proformas_cliente_sino
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_proformas_cliente_sino
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_proformas_cliente_sino
integer y = 44
integer width = 2139
end type

type st_conpromped2 from statictext within w_con_proformas_cliente_sino
integer x = 27
integer y = 208
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_con_proformas_cliente_sino
integer x = 544
integer y = 200
integer width = 1317
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;IF ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""
Else
	ue_titulo = "Selección de no cliente"
	ue_datawindow ="dw_ayuda_vencliproforma"
	ue_filtro = ""
End if
end event

event modificado;call super::modificado;if ddlb_1.text = "Si" then
	   uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
	else
      uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)		
End if

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

string tipo_cli
tipo_cli = "N"

if ddlb_1.text="Si" then tipo_cli="S"
dw_1.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,tipo_cli)
end event

type pb_1 from upb_salir within w_con_proformas_cliente_sino
integer x = 2734
integer y = 28
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_proformas_cliente_sino
integer x = 2734
integer y = 200
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;if trim( uo_cliente.em_codigo.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca el Cliente")
	  Return
END IF

f_activar_campo(uo_cliente.em_campo)
PArent.triggerEvent("ue_listar")
end event

type dw_listado2 from datawindow within w_con_proformas_cliente_sino
boolean visible = false
integer x = 238
integer y = 16
integer width = 425
integer height = 80
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_con_proformas_cliente_sino"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_proformas_cliente_sino
integer x = 2258
integer y = 156
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_cliente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_1 from datawindow within w_con_proformas_cliente_sino
integer x = 14
integer y = 320
integer width = 2843
integer height = 1104
boolean bringtotop = true
string dataobject = "dw_con_proformas_cliente_sino"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;string pedido
date fec
str_parametros lstr_param 
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[1]="w_con_proformas_cliente_sino"
  lstr_param.s_argumentos[2]=String(dw_1.GetItemNumber(This.GetRow(),"anyo"))
  lstr_param.s_argumentos[3]=String(dw_1.GetItemNumber(This.GetRow(),"proforma"))
  OpenWithParm(w_int_venproformas,lstr_param)

end event

type ddlb_1 from dropdownlistbox within w_con_proformas_cliente_sino
integer x = 325
integer y = 196
integer width = 210
integer height = 260
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551093
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type gb_boton from groupbox within w_con_proformas_cliente_sino
integer x = 1906
integer y = 132
integer width = 329
integer height = 176
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_1 from commandbutton within w_con_proformas_cliente_sino
event clicked pbm_bnclicked
integer x = 1920
integer y = 172
integer width = 302
integer height = 60
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;dw_1.Modify("DataWindow.header.1.Height=161")
dw_1.Modify("DataWindow.detail.Height=73")
end event

type cb_2 from commandbutton within w_con_proformas_cliente_sino
event clicked pbm_bnclicked
integer x = 1920
integer y = 236
integer width = 302
integer height = 60
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resumen"
end type

event clicked;dw_1.Modify("DataWindow.detail.Height=0")
dw_1.Modify("DataWindow.header.1.Height=81")

end event

