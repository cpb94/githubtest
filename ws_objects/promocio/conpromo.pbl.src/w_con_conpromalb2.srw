$PBExportHeader$w_con_conpromalb2.srw
$PBExportComments$Consulta de albaranes por cliente.
forward
global type w_con_conpromalb2 from w_int_con_empresa
end type
type st_conpromalb2 from statictext within w_con_conpromalb2
end type
type uo_conpromalb2 from u_em_campo_2 within w_con_conpromalb2
end type
type pb_imprimir from upb_imprimir within w_con_conpromalb2
end type
type dw_listado_conpromalb2 from datawindow within w_con_conpromalb2
end type
type uo_manejo from u_manejo_datawindow within w_con_conpromalb2
end type
type dw_conpromalb2 from datawindow within w_con_conpromalb2
end type
type ddlb_1 from dropdownlistbox within w_con_conpromalb2
end type
type pb_1 from upb_salir within w_con_conpromalb2
end type
end forward

global type w_con_conpromalb2 from w_int_con_empresa
integer width = 2926
integer height = 2068
st_conpromalb2 st_conpromalb2
uo_conpromalb2 uo_conpromalb2
pb_imprimir pb_imprimir
dw_listado_conpromalb2 dw_listado_conpromalb2
uo_manejo uo_manejo
dw_conpromalb2 dw_conpromalb2
ddlb_1 ddlb_1
pb_1 pb_1
end type
global w_con_conpromalb2 w_con_conpromalb2

on w_con_conpromalb2.create
int iCurrent
call super::create
this.st_conpromalb2=create st_conpromalb2
this.uo_conpromalb2=create uo_conpromalb2
this.pb_imprimir=create pb_imprimir
this.dw_listado_conpromalb2=create dw_listado_conpromalb2
this.uo_manejo=create uo_manejo
this.dw_conpromalb2=create dw_conpromalb2
this.ddlb_1=create ddlb_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_conpromalb2
this.Control[iCurrent+2]=this.uo_conpromalb2
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.dw_listado_conpromalb2
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.dw_conpromalb2
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.pb_1
end on

on w_con_conpromalb2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_conpromalb2)
destroy(this.uo_conpromalb2)
destroy(this.pb_imprimir)
destroy(this.dw_listado_conpromalb2)
destroy(this.uo_manejo)
destroy(this.dw_conpromalb2)
destroy(this.ddlb_1)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Albaranes por Cliente"
istr_parametros.s_listado        =   "report_conpromalb2"
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromalb2.SetTransObject(SQLCA)
dw_listado_conpromalb2.SetTransObject(SQLCA)
f_activar_campo(uo_conpromalb2.em_campo)

ddlb_1.text = "Si"

end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromalb2)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromalb2)
end event

event ue_listar;string tipo_cli
tipo_cli ="N"
if ddlb_1.text ="Si" then tipo_cli = "S"

dw_listado_conpromalb2.Retrieve(codigo_empresa,uo_conpromalb2.em_codigo.text,tipo_cli)
dw_report =dw_listado_conpromalb2
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_conpromalb2
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_conpromalb2
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_conpromalb2.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_conpromalb2
integer x = 18
end type

type st_conpromalb2 from statictext within w_con_conpromalb2
integer x = 50
integer y = 228
integer width = 261
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

type uo_conpromalb2 from u_em_campo_2 within w_con_conpromalb2
integer x = 608
integer y = 220
integer width = 1509
integer height = 96
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_conpromalb2.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;if ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
   ue_datawindow ="dw_ayuda_clientes"
   ue_filtro = ""
Else
	ue_titulo = "Selección de no clientes"
   ue_datawindow ="dw_ayuda_vencliproforma"
   ue_filtro = ""
End if
	
end event

event modificado;call super::modificado;if ddlb_1.text = "Si" then
	uo_conpromalb2.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_conpromalb2.em_codigo.text)
Else
   uo_conpromalb2.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_conpromalb2.em_codigo.text)	
End if

If Trim(uo_conpromalb2.em_campo.text)="" then
	uo_conpromalb2.em_campo.text=""
	uo_conpromalb2.em_codigo.text=""
	Return
end if 
string tipo_cli
tipo_cli ="N"
if ddlb_1.text = "Si" then tipo_cli = "S"
dw_conpromalb2.Retrieve(codigo_empresa,uo_conpromalb2.em_codigo.text,tipo_cli)
end event

type pb_imprimir from upb_imprimir within w_con_conpromalb2
integer x = 2725
integer y = 216
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;if trim( uo_conpromalb2.em_codigo.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca el Cliente")
	  Return
END IF

f_activar_campo(uo_conpromalb2.em_campo)
Parent.triggerEvent("ue_listar")
end event

type dw_listado_conpromalb2 from datawindow within w_con_conpromalb2
boolean visible = false
integer x = 64
integer y = 16
integer width = 402
integer height = 168
boolean bringtotop = true
string dataobject = "report_conpromalb2"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_conpromalb2
integer x = 2245
integer y = 168
integer width = 617
integer height = 156
end type

event valores;call super::valores;dw_data=dw_conpromalb2
f_activar_campo(uo_conpromalb2.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_conpromalb2 from datawindow within w_con_conpromalb2
integer x = 5
integer y = 332
integer width = 2839
integer height = 1512
boolean bringtotop = true
string dataobject = "dw_con_conpromalb2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if row=0 then Return
string albaran
date fec
str_parametros lstr_param 
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(dw_conpromalb2.GetItemNumber(This.GetRow(),"anyo"))
  lstr_param.s_argumentos[3]=String(dw_conpromalb2.GetItemNumber(This.GetRow(),"albaran"))
  OpenWithParm(w_con_promalbaranes,lstr_param)

end event

type ddlb_1 from dropdownlistbox within w_con_conpromalb2
integer x = 347
integer y = 220
integer width = 247
integer height = 272
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551093
boolean vscrollbar = true
string item[] = {"Si","No"}
end type

type pb_1 from upb_salir within w_con_conpromalb2
integer x = 2706
integer y = 36
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
string picturename = "exit!"
end type

