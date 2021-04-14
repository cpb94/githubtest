$PBExportHeader$w_con_paneles_medidas.srw
$PBExportComments$Consulta paneles por medida
forward
global type w_con_paneles_medidas from w_int_con_empresa
end type
type st_prommedidas from statictext within w_con_paneles_medidas
end type
type uo_prommedidas from u_em_campo_2 within w_con_paneles_medidas
end type
type pb_1 from upb_salir within w_con_paneles_medidas
end type
type pb_imprimir from upb_imprimir within w_con_paneles_medidas
end type
type dw_listado from datawindow within w_con_paneles_medidas
end type
type uo_manejo from u_manejo_datawindow within w_con_paneles_medidas
end type
type dw_detalle from datawindow within w_con_paneles_medidas
end type
type em_1 from u_em_campo within w_con_paneles_medidas
end type
type st_busqueda from statictext within w_con_paneles_medidas
end type
type cb_1 from commandbutton within w_con_paneles_medidas
end type
end forward

global type w_con_paneles_medidas from w_int_con_empresa
integer width = 2926
integer height = 2124
st_prommedidas st_prommedidas
uo_prommedidas uo_prommedidas
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
dw_detalle dw_detalle
em_1 em_1
st_busqueda st_busqueda
cb_1 cb_1
end type
global w_con_paneles_medidas w_con_paneles_medidas

on w_con_paneles_medidas.create
int iCurrent
call super::create
this.st_prommedidas=create st_prommedidas
this.uo_prommedidas=create uo_prommedidas
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.dw_detalle=create dw_detalle
this.em_1=create em_1
this.st_busqueda=create st_busqueda
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_prommedidas
this.Control[iCurrent+2]=this.uo_prommedidas
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.dw_detalle
this.Control[iCurrent+8]=this.em_1
this.Control[iCurrent+9]=this.st_busqueda
this.Control[iCurrent+10]=this.cb_1
end on

on w_con_paneles_medidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_prommedidas)
destroy(this.uo_prommedidas)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.dw_detalle)
destroy(this.em_1)
destroy(this.st_busqueda)
destroy(this.cb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Paneles por Medidas"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
//dw_detalle.SetRowFocusIndicator(Hand!) 
dw_listado.SetTransObject(SQLCA)
f_activar_campo(uo_prommedidas.em_campo)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_listar;String filtro=""
if trim(em_1.text)<>"" then
   filtro = "%"+em_1.text+"%"
else
	filtro = "%%"
End if


dw_listado.Retrieve(codigo_empresa,uo_prommedidas.em_codigo.text,filtro)
dw_report =dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_paneles_medidas
integer x = 718
integer y = 856
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_paneles_medidas
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_prommedidas.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_paneles_medidas
integer y = 44
integer width = 2139
end type

type st_prommedidas from statictext within w_con_paneles_medidas
integer x = 32
integer y = 224
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Medida:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_prommedidas from u_em_campo_2 within w_con_paneles_medidas
integer x = 283
integer y = 216
integer width = 1083
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_prommedidas.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Medidas"
ue_datawindow ="dw_ayuda_prommedidas"
ue_filtro = ""
//valor_empresa = True
end event

event modificado;call super::modificado;uo_prommedidas.em_campo.text=f_nombre_prommedidas(codigo_empresa,uo_prommedidas.em_codigo.text)
If Trim(uo_prommedidas.em_campo.text)="" then
	uo_prommedidas.em_campo.text=""
	uo_prommedidas.em_codigo.text=""
	Return
end if 


end event

type pb_1 from upb_salir within w_con_paneles_medidas
integer x = 2683
integer y = 32
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_paneles_medidas
integer x = 2702
integer y = 216
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;if trim( uo_prommedidas.em_codigo.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca la Medida")
	  Return
END IF
f_activar_campo(uo_prommedidas.em_campo)
Parent.triggerEvent("ue_listar")
end event

type dw_listado from datawindow within w_con_paneles_medidas
boolean visible = false
integer x = 64
integer y = 8
integer width = 494
integer height = 264
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_paneles_medidas"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_paneles_medidas
integer x = 2217
integer y = 168
end type

event valores;call super::valores;dw_data=dw_detalle
f_activar_campo(uo_prommedidas.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_detalle from datawindow within w_con_paneles_medidas
integer x = 9
integer y = 324
integer width = 2811
integer height = 1548
boolean bringtotop = true
string dataobject = "dw_con_paneles_medidas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if row=0 then return

This.SelectRow(0, FALSE)
This.SelectRow(row, TRUE)

str_parametros lstr_param 
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=dw_detalle.GetItemString(This.GetRow(),"prompaneles_codigo")

OpenWithParm(wi_mant_prompaneles,lstr_param)

This.SelectRow(0, FALSE)
end event

type em_1 from u_em_campo within w_con_paneles_medidas
integer x = 1381
integer y = 216
integer width = 466
integer taborder = 40
end type

type st_busqueda from statictext within w_con_paneles_medidas
integer x = 1381
integer y = 144
integer width = 466
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "F i l t r o"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_con_paneles_medidas
integer x = 1856
integer y = 220
integer width = 329
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;String filtro=""
if trim(em_1.text)<>"" then
   filtro = "%"+em_1.text+"%"
else
	filtro = "%%"
End if

dw_detalle.Retrieve(codigo_empresa,uo_prommedidas.em_codigo.text,filtro)

end event

