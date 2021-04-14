$PBExportHeader$w_con_material_tirado.srw
forward
global type w_con_material_tirado from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_material_tirado
end type
type st_1 from statictext within w_con_material_tirado
end type
type uo_1 from u_em_campo_2 within w_con_material_tirado
end type
type dw_1 from datawindow within w_con_material_tirado
end type
type dw_listado from datawindow within w_con_material_tirado
end type
type pb_imprimir from upb_imprimir within w_con_material_tirado
end type
type uo_manejo from u_manejo_datawindow within w_con_material_tirado
end type
type cb_1 from commandbutton within w_con_material_tirado
end type
type st_7 from statictext within w_con_material_tirado
end type
type em_fechadesde from u_em_campo within w_con_material_tirado
end type
type st_8 from statictext within w_con_material_tirado
end type
type em_fechahasta from u_em_campo within w_con_material_tirado
end type
end forward

global type w_con_material_tirado from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 3625
integer height = 2148
pb_1 pb_1
st_1 st_1
uo_1 uo_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_manejo uo_manejo
cb_1 cb_1
st_7 st_7
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
end type
global w_con_material_tirado w_con_material_tirado

on w_con_material_tirado.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
this.st_7=create st_7
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.pb_imprimir
this.Control[iCurrent+7]=this.uo_manejo
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.st_7
this.Control[iCurrent+10]=this.em_fechadesde
this.Control[iCurrent+11]=this.st_8
this.Control[iCurrent+12]=this.em_fechahasta
end on

on w_con_material_tirado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_manejo)
destroy(this.cb_1)
destroy(this.st_7)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Material tirado"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

em_fechadesde.text = string(date('01-'+'01-'+string(year(today()))))
em_fechahasta.text = string(today())

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

event ue_listar;dw_listado.Retrieve(codigo_empresa,uo_1.em_codigo.text)
dw_report =dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_material_tirado
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_material_tirado
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_material_tirado
integer y = 44
integer width = 2656
integer height = 84
integer textsize = -11
end type

type pb_1 from upb_salir within w_con_material_tirado
integer x = 3383
integer y = 32
integer width = 123
integer height = 108
integer taborder = 0
end type

type st_1 from statictext within w_con_material_tirado
integer x = 1335
integer y = 180
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_1 from u_em_campo_2 within w_con_material_tirado
integer x = 1632
integer y = 172
integer width = 1298
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_1.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Artículos"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

event modificado;uo_1.em_campo.text=f_nombre_articulo(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

end event

type dw_1 from datawindow within w_con_material_tirado
integer x = 14
integer y = 304
integer width = 3511
integer height = 1608
boolean bringtotop = true
string dataobject = "dw_con_material_tirado"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="wi_con_formatos_articulos"
  lstr_param.s_argumentos[2]=String(dw_1.object.almmattirado_codigo[This.GetRow()])
  OpenWithParm(w_mant_almmattirado,lstr_param)

end event

type dw_listado from datawindow within w_con_material_tirado
boolean visible = false
integer width = 521
integer height = 208
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_familia_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_material_tirado
event clicked pbm_bnclicked
integer x = 3191
integer y = 48
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;if trim( uo_1.em_codigo.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca la familia")
	  Return
END IF


PArent.triggerEvent("ue_listar")
f_activar_campo(uo_1.em_campo)
end event

type uo_manejo from u_manejo_datawindow within w_con_material_tirado
event valores pbm_custom01
integer x = 2706
integer width = 635
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_1.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from commandbutton within w_con_material_tirado
integer x = 2967
integer y = 168
integer width = 549
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string articulo

if uo_1.em_codigo.text = "" or isnull(uo_1.em_codigo.text ) then
	articulo = '%'
else
	articulo = uo_1.em_codigo.text
end if

dw_1.Retrieve(codigo_empresa, articulo , date(em_fechadesde.text), relativedate(date(em_fechahasta.text), 1))
end event

type st_7 from statictext within w_con_material_tirado
integer x = 649
integer y = 180
integer width = 206
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_material_tirado
integer x = 274
integer y = 168
integer width = 311
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_material_tirado
integer x = 32
integer y = 176
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_material_tirado
integer x = 869
integer y = 172
integer width = 311
integer height = 80
integer taborder = 21
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

