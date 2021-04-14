$PBExportHeader$w_con_expositores_act_cliente.srw
forward
global type w_con_expositores_act_cliente from w_int_con_empresa
end type
type st_conpromped2 from statictext within w_con_expositores_act_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_expositores_act_cliente
end type
type pb_1 from upb_salir within w_con_expositores_act_cliente
end type
type pb_imprimir from upb_imprimir within w_con_expositores_act_cliente
end type
type dw_listado from datawindow within w_con_expositores_act_cliente
end type
type uo_manejo from u_manejo_datawindow within w_con_expositores_act_cliente
end type
type ddlb_1 from dropdownlistbox within w_con_expositores_act_cliente
end type
type dw_detalle from u_datawindow_consultas within w_con_expositores_act_cliente
end type
type dw_detalle2 from u_datawindow_consultas within w_con_expositores_act_cliente
end type
type cb_1 from u_boton within w_con_expositores_act_cliente
end type
end forward

global type w_con_expositores_act_cliente from w_int_con_empresa
integer width = 2889
integer height = 1604
st_conpromped2 st_conpromped2
uo_cliente uo_cliente
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
ddlb_1 ddlb_1
dw_detalle dw_detalle
dw_detalle2 dw_detalle2
cb_1 cb_1
end type
global w_con_expositores_act_cliente w_con_expositores_act_cliente

type variables
String situ
end variables

forward prototypes
public subroutine f_detalle (integer reg)
end prototypes

public subroutine f_detalle (integer reg);IF reg = 0 Then Return
String serie
serie = dw_detalle.GetItemString(reg,"numserie")
dw_detalle2.Retrieve(codigo_empresa,serie)

end subroutine

on w_con_expositores_act_cliente.create
int iCurrent
call super::create
this.st_conpromped2=create st_conpromped2
this.uo_cliente=create uo_cliente
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.ddlb_1=create ddlb_1
this.dw_detalle=create dw_detalle
this.dw_detalle2=create dw_detalle2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_conpromped2
this.Control[iCurrent+2]=this.uo_cliente
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.dw_detalle
this.Control[iCurrent+9]=this.dw_detalle2
this.Control[iCurrent+10]=this.cb_1
end on

on w_con_expositores_act_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_conpromped2)
destroy(this.uo_cliente)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.ddlb_1)
destroy(this.dw_detalle)
destroy(this.dw_detalle2)
destroy(this.cb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Albaranes por Cliente"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_detalle2.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
ddlb_1.text ="Si" 
Situ = "T"
f_activar_campo(uo_cliente.em_campo)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_expositores_act_cliente
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_expositores_act_cliente
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_expositores_act_cliente
integer y = 44
integer width = 2139
end type

type st_conpromped2 from statictext within w_con_expositores_act_cliente
integer x = 14
integer y = 208
integer width = 233
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

type uo_cliente from u_em_campo_2 within w_con_expositores_act_cliente
integer x = 475
integer y = 200
integer width = 1184
integer height = 92
integer taborder = 60
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


dw_detalle.Reset()
dw_detalle2.Reset()
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 



end event

type pb_1 from upb_salir within w_con_expositores_act_cliente
integer x = 2688
integer y = 32
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_expositores_act_cliente
integer x = 2697
integer y = 216
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;string tipo_cli
tipo_cli = "N"
if ddlb_1.text="Si" then tipo_cli="S"
dw_listado.Retrieve(codigo_empresa,tipo_cli,uo_cliente.em_codigo.text)
f_imprimir_datawindow(dw_listado)
end event

type dw_listado from datawindow within w_con_expositores_act_cliente
boolean visible = false
integer width = 352
integer height = 136
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_con_expositores_act_cliente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_expositores_act_cliente
integer x = 2217
integer y = 168
end type

event valores;call super::valores;dw_data=dw_detalle
f_activar_campo(uo_cliente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type ddlb_1 from dropdownlistbox within w_con_expositores_act_cliente
integer x = 261
integer y = 200
integer width = 210
integer height = 260
integer taborder = 50
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

type dw_detalle from u_datawindow_consultas within w_con_expositores_act_cliente
integer y = 344
integer width = 1147
integer height = 1028
integer taborder = 0
string dataobject = "dw_con_expositores_act_cliente"
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;f_detalle(currentrow)
end event

event retrieveend;call super::retrieveend;IF rowcount <> 0 Then f_detalle(1)

end event

type dw_detalle2 from u_datawindow_consultas within w_con_expositores_act_cliente
integer x = 1147
integer y = 344
integer width = 1669
integer height = 1028
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_con_expositores_act_cliente2"
borderstyle borderstyle = styleraised!
end type

type cb_1 from u_boton within w_con_expositores_act_cliente
integer x = 1669
integer y = 200
integer height = 92
string text = "&Continuar"
end type

event clicked;call super::clicked;string tipo_cli
tipo_cli = "N"
if ddlb_1.text="Si" then tipo_cli="S"

dw_detalle.Retrieve(codigo_empresa,tipo_cli,uo_cliente.em_codigo.text)
end event

