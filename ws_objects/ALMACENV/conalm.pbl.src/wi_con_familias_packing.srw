$PBExportHeader$wi_con_familias_packing.srw
forward
global type wi_con_familias_packing from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_con_familias_packing
end type
type st_1 from statictext within wi_con_familias_packing
end type
type uo_1 from u_em_campo_2 within wi_con_familias_packing
end type
type dw_1 from datawindow within wi_con_familias_packing
end type
type dw_listado from datawindow within wi_con_familias_packing
end type
type pb_imprimir from upb_imprimir within wi_con_familias_packing
end type
type uo_manejo from u_manejo_datawindow within wi_con_familias_packing
end type
type pb_2 from upb_carpeta within wi_con_familias_packing
end type
type cbx_1 from checkbox within wi_con_familias_packing
end type
end forward

global type wi_con_familias_packing from w_int_con_empresa
integer width = 2926
integer height = 1652
pb_1 pb_1
st_1 st_1
uo_1 uo_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_manejo uo_manejo
pb_2 pb_2
cbx_1 cbx_1
end type
global wi_con_familias_packing wi_con_familias_packing

on wi_con_familias_packing.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_manejo=create uo_manejo
this.pb_2=create pb_2
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.pb_imprimir
this.Control[iCurrent+7]=this.uo_manejo
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.cbx_1
end on

on wi_con_familias_packing.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_manejo)
destroy(this.pb_2)
destroy(this.cbx_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Artículos por familia"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)

f_activar_campo(uo_1.em_campo)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;IF cbx_1.checked = TRUE Then
	dw_listado.DataObject = "report_con_familias_packing_ubi"
ELSE
	dw_listado.DataObject = "report_con_familias_packing"
END IF
dw_listado.SetTransObject(SQLCA)

dw_listado.Retrieve(codigo_empresa,uo_1.em_codigo.text)
dw_report =dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_familias_packing
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_familias_packing
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_con_familias_packing
end type

type pb_1 from upb_salir within wi_con_familias_packing
integer x = 2711
integer y = 28
integer width = 123
integer height = 108
integer taborder = 0
string picturename = "exit!"
end type

type st_1 from statictext within wi_con_familias_packing
integer x = 59
integer y = 192
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Familia"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_1 from u_em_campo_2 within wi_con_familias_packing
integer x = 357
integer y = 188
integer width = 1024
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_1.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Familias"
ue_datawindow ="dw_ayuda_familias"
ue_filtro = ""
end event

event modificado;call super::modificado;uo_1.em_campo.text=f_nombre_familia(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 
dw_1.Retrieve(codigo_empresa,uo_1.em_codigo.text)
end event

type dw_1 from datawindow within wi_con_familias_packing
integer x = 14
integer y = 308
integer width = 2834
integer height = 1124
boolean bringtotop = true
string dataobject = "dw_con_familias_packing"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="wi_con_formatos_articulos"
  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
  OpenWithParm(wi_mant_articulos,lstr_param)

end event

type dw_listado from datawindow within wi_con_familias_packing
boolean visible = false
integer width = 521
integer height = 208
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_familias_packing"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_con_familias_packing
event clicked pbm_bnclicked
integer x = 2706
integer y = 192
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;if trim( uo_1.em_codigo.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca la familia")
	  Return
END IF


Parent.triggerEvent("ue_listar")
f_activar_campo(uo_1.em_campo)
end event

type uo_manejo from u_manejo_datawindow within wi_con_familias_packing
event valores pbm_custom01
integer x = 2231
integer y = 148
integer width = 635
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_1.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type pb_2 from upb_carpeta within wi_con_familias_packing
integer x = 1390
integer y = 184
integer width = 110
integer height = 96
integer taborder = 0
string disabledname = "c:\bmp\carpeta.bmp"
end type

event clicked;call super::clicked;  f_activar_campo(uo_1.em_campo)
  str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="wi_con_formatos_modelos"
  lstr_param.s_argumentos[2]= uo_1.em_codigo.text
  OpenWithParm(wi_mant_familias,lstr_param)

end event

type cbx_1 from checkbox within wi_con_familias_packing
integer x = 1568
integer y = 184
integer width = 498
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Con ubicación"
boolean checked = true
boolean lefttext = true
end type

event clicked;f_activar_campo(uo_1.em_campo)
end event

