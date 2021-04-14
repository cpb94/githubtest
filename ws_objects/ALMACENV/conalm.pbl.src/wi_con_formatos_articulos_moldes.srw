$PBExportHeader$wi_con_formatos_articulos_moldes.srw
forward
global type wi_con_formatos_articulos_moldes from w_int_con_empresa
end type
type st_1 from statictext within wi_con_formatos_articulos_moldes
end type
type dw_1 from datawindow within wi_con_formatos_articulos_moldes
end type
type dw_listado from datawindow within wi_con_formatos_articulos_moldes
end type
type pb_imprimir from upb_imprimir within wi_con_formatos_articulos_moldes
end type
type uo_manejo from u_manejo_datawindow within wi_con_formatos_articulos_moldes
end type
type pb_2 from upb_carpeta within wi_con_formatos_articulos_moldes
end type
type uo_1 from u_em_campo_2 within wi_con_formatos_articulos_moldes
end type
type cb_1 from u_boton within wi_con_formatos_articulos_moldes
end type
type pb_1 from upb_salir within wi_con_formatos_articulos_moldes
end type
end forward

global type wi_con_formatos_articulos_moldes from w_int_con_empresa
integer width = 3552
integer height = 1636
st_1 st_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_manejo uo_manejo
pb_2 pb_2
uo_1 uo_1
cb_1 cb_1
pb_1 pb_1
end type
global wi_con_formatos_articulos_moldes wi_con_formatos_articulos_moldes

on wi_con_formatos_articulos_moldes.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_manejo=create uo_manejo
this.pb_2=create pb_2
this.uo_1=create uo_1
this.cb_1=create cb_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.pb_1
end on

on wi_con_formatos_articulos_moldes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_manejo)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Artículos por formato"
istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

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

event ue_listar;string formato

if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el formato")
//	f_activar_campo(uo_1.em_campo)
//	return
	formato = "%"
else
	formato = uo_1.em_codigo.text
end if
dw_listado.Retrieve(codigo_empresa,formato)
dw_report =dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_formatos_articulos_moldes
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_formatos_articulos_moldes
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_con_formatos_articulos_moldes
end type

type st_1 from statictext within wi_con_formatos_articulos_moldes
integer x = 18
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
string text = "Formato"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type dw_1 from datawindow within wi_con_formatos_articulos_moldes
integer x = 5
integer y = 284
integer width = 3474
integer height = 1136
boolean bringtotop = true
string dataobject = "dw_con_formatos_articulos_moldes"
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

type dw_listado from datawindow within wi_con_formatos_articulos_moldes
boolean visible = false
integer width = 521
integer height = 208
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_formatos_articulos_moldes"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_con_formatos_articulos_moldes
event clicked pbm_bnclicked
integer x = 2702
integer y = 172
integer taborder = 0
string picturename = "print!"
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF


Parent.triggerEvent("ue_listar")
f_activar_campo(uo_1.em_campo)
end event

type uo_manejo from u_manejo_datawindow within wi_con_formatos_articulos_moldes
event valores pbm_custom01
integer x = 2226
integer y = 128
integer width = 635
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_1.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type pb_2 from upb_carpeta within wi_con_formatos_articulos_moldes
integer x = 997
integer y = 188
integer width = 110
integer height = 96
integer taborder = 0
string disabledname = "c:\bmp\carpeta.bmp"
end type

event clicked;call super::clicked;  f_activar_campo(uo_1.em_campo)
  str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="wi_con_formatos_articulos"
  lstr_param.s_argumentos[2]= uo_1.em_codigo.text
  OpenWithParm(wi_mant_formatos,lstr_param)

end event

type uo_1 from u_em_campo_2 within wi_con_formatos_articulos_moldes
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 325
integer y = 188
integer width = 663
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_1.em_campo.text=f_nombre_formato(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formatos"
ue_datawindow ="dw_ayuda_formatos"
ue_filtro = ""
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within wi_con_formatos_articulos_moldes
integer x = 1911
integer y = 168
integer width = 315
integer height = 104
integer taborder = 30
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;string formato

if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el formato")
//	f_activar_campo(uo_1.em_campo)
//	return
	formato = "%"
else
	formato = uo_1.em_codigo.text
end if

dw_1.Retrieve(codigo_empresa,formato)

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if
end event

type pb_1 from upb_salir within wi_con_formatos_articulos_moldes
integer x = 2711
integer y = 28
integer width = 123
integer height = 112
integer taborder = 0
boolean bringtotop = true
string picturename = "exit!"
end type

