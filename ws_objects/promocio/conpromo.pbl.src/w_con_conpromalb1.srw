$PBExportHeader$w_con_conpromalb1.srw
$PBExportComments$Consulta de albaranes por expositor
forward
global type w_con_conpromalb1 from w_int_con_empresa
end type
type st_conpromalb1 from statictext within w_con_conpromalb1
end type
type uo_conpromalb1 from u_em_campo_2 within w_con_conpromalb1
end type
type pb_1 from upb_salir within w_con_conpromalb1
end type
type pb_imprimir from upb_imprimir within w_con_conpromalb1
end type
type dw_listado_conpromalb1 from datawindow within w_con_conpromalb1
end type
type uo_manejo from u_manejo_datawindow within w_con_conpromalb1
end type
type dw_conpromalb1 from datawindow within w_con_conpromalb1
end type
end forward

global type w_con_conpromalb1 from w_int_con_empresa
integer width = 2999
integer height = 2132
st_conpromalb1 st_conpromalb1
uo_conpromalb1 uo_conpromalb1
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado_conpromalb1 dw_listado_conpromalb1
uo_manejo uo_manejo
dw_conpromalb1 dw_conpromalb1
end type
global w_con_conpromalb1 w_con_conpromalb1

on w_con_conpromalb1.create
int iCurrent
call super::create
this.st_conpromalb1=create st_conpromalb1
this.uo_conpromalb1=create uo_conpromalb1
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado_conpromalb1=create dw_listado_conpromalb1
this.uo_manejo=create uo_manejo
this.dw_conpromalb1=create dw_conpromalb1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_conpromalb1
this.Control[iCurrent+2]=this.uo_conpromalb1
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado_conpromalb1
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.dw_conpromalb1
end on

on w_con_conpromalb1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_conpromalb1)
destroy(this.uo_conpromalb1)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado_conpromalb1)
destroy(this.uo_manejo)
destroy(this.dw_conpromalb1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Albaranes por Tipo de Expositor"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromalb1.SetTransObject(SQLCA)
dw_listado_conpromalb1.SetTransObject(SQLCA)
f_activar_campo(uo_conpromalb1.em_campo)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromalb1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromalb1)
end event

event ue_listar;dw_listado_conpromalb1.Retrieve(codigo_empresa,uo_conpromalb1.em_codigo.text)
dw_report =dw_listado_conpromalb1
Call Super::ue_listar
end event

event activate;call super::activate;w_con_conpromalb1 = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_conpromalb1
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_conpromalb1
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_conpromalb1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_conpromalb1
end type

type st_conpromalb1 from statictext within w_con_conpromalb1
integer x = 64
integer y = 204
integer width = 448
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Tipo Expositor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_conpromalb1 from u_em_campo_2 within w_con_conpromalb1
integer x = 535
integer y = 200
integer width = 955
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_conpromalb1.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Expositores"
ue_datawindow ="dw_ayuda_promexpositores"
ue_filtro = ""
end event

event modificado;call super::modificado;uo_conpromalb1.em_campo.text=f_nombre_promexpositores(codigo_empresa,uo_conpromalb1.em_codigo.text)
If Trim(uo_conpromalb1.em_campo.text)="" then
	uo_conpromalb1.em_campo.text=""
	uo_conpromalb1.em_codigo.text=""
	Return
end if 
dw_conpromalb1.Retrieve(codigo_empresa,uo_conpromalb1.em_codigo.text)
end event

type pb_1 from upb_salir within w_con_conpromalb1
integer x = 2702
integer y = 36
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_conpromalb1
integer x = 2697
integer y = 196
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
string picturename = "print!"
end type

event clicked;call super::clicked;if trim( uo_conpromalb1.em_codigo.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca el tipo de expositor")
	  Return
END IF
f_activar_campo(uo_conpromalb1.em_campo)

Parent.triggerEvent("ue_listar")
end event

type dw_listado_conpromalb1 from datawindow within w_con_conpromalb1
boolean visible = false
integer x = 64
integer y = 8
integer width = 494
integer height = 264
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_conpromalb1"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_conpromalb1
integer x = 2222
integer y = 148
integer width = 622
integer height = 156
end type

event valores;call super::valores;dw_data=dw_conpromalb1
f_activar_campo(uo_conpromalb1.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_conpromalb1 from datawindow within w_con_conpromalb1
integer y = 308
integer width = 2843
integer height = 1556
string dataobject = "dw_con_conpromalb1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;string albaran
date fec
str_parametros lstr_param 
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[1]="w_con_conpromalb1"
  lstr_param.s_argumentos[2]=String(dw_conpromalb1.GetItemNumber(This.GetRow(),"anyo"))
  lstr_param.s_argumentos[3]=String(dw_conpromalb1.GetItemNumber(This.GetRow(),"albaran"))
  OpenWithParm(w_con_promalbaranes,lstr_param)

end event

