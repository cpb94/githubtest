$PBExportHeader$wi_con_costes_articulos.srw
forward
global type wi_con_costes_articulos from w_int_con_empresa
end type
type st_1 from statictext within wi_con_costes_articulos
end type
type uo_1 from u_em_campo_2 within wi_con_costes_articulos
end type
type dw_1 from datawindow within wi_con_costes_articulos
end type
type dw_listado from datawindow within wi_con_costes_articulos
end type
type pb_imprimir from upb_imprimir within wi_con_costes_articulos
end type
type uo_3 from u_em_campo_2 within wi_con_costes_articulos
end type
type st_2 from statictext within wi_con_costes_articulos
end type
type cb_1 from commandbutton within wi_con_costes_articulos
end type
type coste_desde from editmask within wi_con_costes_articulos
end type
type coste_hasta from editmask within wi_con_costes_articulos
end type
type st_3 from statictext within wi_con_costes_articulos
end type
type st_4 from statictext within wi_con_costes_articulos
end type
type pb_1 from upb_salir within wi_con_costes_articulos
end type
end forward

global type wi_con_costes_articulos from w_int_con_empresa
integer x = 265
integer y = 16
integer width = 2821
integer height = 2280
st_1 st_1
uo_1 uo_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_3 uo_3
st_2 st_2
cb_1 cb_1
coste_desde coste_desde
coste_hasta coste_hasta
st_3 st_3
st_4 st_4
pb_1 pb_1
end type
global wi_con_costes_articulos wi_con_costes_articulos

on wi_con_costes_articulos.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_3=create uo_3
this.st_2=create st_2
this.cb_1=create cb_1
this.coste_desde=create coste_desde
this.coste_hasta=create coste_hasta
this.st_3=create st_3
this.st_4=create st_4
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.uo_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.coste_desde
this.Control[iCurrent+10]=this.coste_hasta
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.pb_1
end on

on wi_con_costes_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_3)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.coste_desde)
destroy(this.coste_hasta)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Artículos por familia"
istr_parametros.s_listado        =   "report_formatos_familias"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(uo_1.em_campo)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_costes_articulos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_costes_articulos
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_con_costes_articulos
end type

type st_1 from statictext within wi_con_costes_articulos
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

type uo_1 from u_em_campo_2 within wi_con_costes_articulos
integer x = 366
integer y = 188
integer width = 347
integer taborder = 10
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

event modificado;uo_1.em_campo.text=f_nombre_familia(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

end event

type dw_1 from datawindow within wi_con_costes_articulos
integer x = 78
integer y = 288
integer width = 2514
integer height = 1712
boolean bringtotop = true
string dataobject = "dw_con_costes_articulos"
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

type dw_listado from datawindow within wi_con_costes_articulos
boolean visible = false
integer width = 521
integer height = 208
boolean bringtotop = true
string dataobject = "report_con_costes_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_con_costes_articulos
event clicked pbm_bnclicked
integer x = 2606
integer y = 176
integer taborder = 60
end type

event clicked;string familia,formato,filtro,aux,coste_d,coste_h,articulo
long indice,total

if uo_1.em_codigo.text = "" then
	familia = "%"
else
	familia = uo_1.em_codigo.text
end if
if uo_3.em_codigo.text = "" then
	formato = "%"
else
	formato = uo_3.em_codigo.text
end if
if dec(coste_desde.text) > dec(coste_hasta.text) then
	aux = coste_desde.text
	coste_desde.text = coste_hasta.text
	coste_hasta.text = aux
end if

if long(coste_hasta.text)> 0 then
	filtro = "coste >= "+string(dec(coste_desde.text))+&
	         " and coste <= "+string(dec(coste_hasta.text))
	coste_d = coste_desde.text
	coste_h = coste_hasta.text
else 
	filtro = ""
	coste_d = ""
	coste_h = ""
end if
dw_listado.SetRedraw(FALSE)
dw_listado.setfilter("")
dw_listado.Retrieve(codigo_empresa,familia,formato,coste_d,coste_h)
total = dw_1.rowcount()
for indice = 1 to total
	articulo = dw_listado.object.codigo[indice]
	dw_listado.object.coste[indice] = f_calculo_coste_articulo(codigo_empresa,articulo)
next
dw_listado.setfilter(filtro)
dw_listado.filter()
dw_listado.sort()
dw_listado.SetRedraw(TRUE)

f_imprimir_datawindow(dw_listado)

end event

type uo_3 from u_em_campo_2 within wi_con_costes_articulos
integer x = 992
integer y = 188
integer width = 338
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_3.em_campo.text=f_nombre_formato(codigo_empresa,uo_3.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_3.em_campo.text=""
	uo_3.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formatos"
ue_datawindow ="dw_ayuda_formatos"
ue_filtro = ""
end event

on uo_3.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within wi_con_costes_articulos
integer x = 713
integer y = 192
integer width = 270
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

type cb_1 from commandbutton within wi_con_costes_articulos
integer x = 2290
integer y = 184
integer width = 293
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;string familia,formato,filtro,aux,articulo
long indice,total

if uo_1.em_codigo.text = "" then
	familia = "%"
else
	familia = uo_1.em_codigo.text
end if
if uo_3.em_codigo.text = "" then
	formato = "%"
else
	formato = uo_3.em_codigo.text
end if
if dec(coste_desde.text) > dec(coste_hasta.text) then
	aux = coste_desde.text
	coste_desde.text = coste_hasta.text
	coste_hasta.text = aux
end if

if long(coste_hasta.text)> 0 then
	filtro = "coste >= "+string(dec(coste_desde.text))+&
	         " and coste <= "+string(dec(coste_hasta.text))
else 
	filtro = ""
end if
dw_1.SetRedraw(FALSE)
dw_1.setfilter("")
dw_1.Retrieve(codigo_empresa,familia,formato)
total = dw_1.rowcount()
for indice = 1 to total
	articulo = dw_1.object.codigo[indice]
	dw_1.object.coste[indice] = f_calculo_coste_articulo(codigo_empresa,articulo)
next
dw_1.setfilter(filtro)
dw_1.filter()
dw_1.sort()
dw_1.SetRedraw(TRUE)
end event

type coste_desde from editmask within wi_con_costes_articulos
integer x = 1701
integer y = 188
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,###,##0"
end type

event getfocus;this.SelectText(1,Len(this.Text))
end event

type coste_hasta from editmask within wi_con_costes_articulos
integer x = 2034
integer y = 188
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,###,##0"
end type

event getfocus;this.SelectText(1,Len(this.Text))

end event

type st_3 from statictext within wi_con_costes_articulos
integer x = 1339
integer y = 192
integer width = 361
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Coste entre:"
boolean focusrectangle = false
end type

type st_4 from statictext within wi_con_costes_articulos
integer x = 1966
integer y = 192
integer width = 59
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "y"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within wi_con_costes_articulos
integer x = 2606
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

