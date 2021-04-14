$PBExportHeader$w_pedir_trimestre_rectificacion_349.srw
forward
global type w_pedir_trimestre_rectificacion_349 from window
end type
type ddlb_trimestre from dropdownlistbox within w_pedir_trimestre_rectificacion_349
end type
type st_4 from statictext within w_pedir_trimestre_rectificacion_349
end type
type ejercicio from u_em_campo within w_pedir_trimestre_rectificacion_349
end type
type st_2 from statictext within w_pedir_trimestre_rectificacion_349
end type
type st_texto1 from statictext within w_pedir_trimestre_rectificacion_349
end type
type p_1 from picture within w_pedir_trimestre_rectificacion_349
end type
type cb_cancelar from commandbutton within w_pedir_trimestre_rectificacion_349
end type
type cb_ok from commandbutton within w_pedir_trimestre_rectificacion_349
end type
type mensaje from statictext within w_pedir_trimestre_rectificacion_349
end type
end forward

global type w_pedir_trimestre_rectificacion_349 from window
integer x = 599
integer y = 420
integer width = 1957
integer height = 844
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 12632256
ddlb_trimestre ddlb_trimestre
st_4 st_4
ejercicio ejercicio
st_2 st_2
st_texto1 st_texto1
p_1 p_1
cb_cancelar cb_cancelar
cb_ok cb_ok
mensaje mensaje
end type
global w_pedir_trimestre_rectificacion_349 w_pedir_trimestre_rectificacion_349

on w_pedir_trimestre_rectificacion_349.create
this.ddlb_trimestre=create ddlb_trimestre
this.st_4=create st_4
this.ejercicio=create ejercicio
this.st_2=create st_2
this.st_texto1=create st_texto1
this.p_1=create p_1
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.mensaje=create mensaje
this.Control[]={this.ddlb_trimestre,&
this.st_4,&
this.ejercicio,&
this.st_2,&
this.st_texto1,&
this.p_1,&
this.cb_cancelar,&
this.cb_ok,&
this.mensaje}
end on

on w_pedir_trimestre_rectificacion_349.destroy
destroy(this.ddlb_trimestre)
destroy(this.st_4)
destroy(this.ejercicio)
destroy(this.st_2)
destroy(this.st_texto1)
destroy(this.p_1)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.mensaje)
end on

event open;string trimestre
str_parametros datos_rectificacion

datos_rectificacion = message.PowerObjectParm
trimestre           = datos_rectificacion.s_argumentos[2]
ejercicio.text      = datos_rectificacion.s_argumentos[1]
choose case trimestre
	case "1T"
		ddlb_trimestre.text = "Trimestre 4º"
		ejercicio.text      = string(dec(ejercicio.text) - 1)
	case "2T"
		ddlb_trimestre.text = "Trimestre 1º"
	case "3T"
		ddlb_trimestre.text = "Trimestre 2º"
	case "4T"
		ddlb_trimestre.text = "Trimestre 3º"
	case "01"
		ddlb_trimestre.text = "Diciembre"
		ejercicio.text      = string(dec(ejercicio.text) - 1)
	case "02"
		ddlb_trimestre.text = "Enero"
	case "03"
		ddlb_trimestre.text = "Febrero"
	case "04"
		ddlb_trimestre.text = "Marzo"
	case "05"
		ddlb_trimestre.text = "Abril"
	case "06"
		ddlb_trimestre.text = "Mayo"
	case "07"
		ddlb_trimestre.text = "Junio"
	case "08"
		ddlb_trimestre.text = "Julio"
	case "09"
		ddlb_trimestre.text = "Agosto"
	case "10"
		ddlb_trimestre.text = "Septiembre"
	case "11"
		ddlb_trimestre.text = "Octubre"
	case "12"
		ddlb_trimestre.text = "Noviembre"
	case "0A"
		ddlb_trimestre.text = "Todo el año"
		ejercicio.text      = string(dec(ejercicio.text) - 1)
end choose

st_texto1.text = "Introduzca a que periodo pertenece la rectificación de "
st_texto1.text = st_texto1.text+"~n"+datos_rectificacion.s_argumentos[3]
st_texto1.text = st_texto1.text+"~npor un total de"
st_texto1.text = st_texto1.text+"~n"+string(dec(datos_rectificacion.s_argumentos[4]),"###,###,###,##0.00")+" €."
end event

type ddlb_trimestre from dropdownlistbox within w_pedir_trimestre_rectificacion_349
integer x = 1079
integer y = 500
integer width = 535
integer height = 228
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Trimestre 1º","Trimestre 2º","Trimestre 3º","Trimestre 4º","Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre","Todo el año"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_pedir_trimestre_rectificacion_349
integer x = 745
integer y = 504
integer width = 306
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Periodo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ejercicio from u_em_campo within w_pedir_trimestre_rectificacion_349
integer x = 425
integer y = 504
integer taborder = 10
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#,###"
end type

type st_2 from statictext within w_pedir_trimestre_rectificacion_349
integer x = 59
integer y = 504
integer width = 306
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Ejercicio:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_texto1 from statictext within w_pedir_trimestre_rectificacion_349
integer x = 18
integer y = 184
integer width = 1897
integer height = 304
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_pedir_trimestre_rectificacion_349
integer x = 73
integer y = 44
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "\bmp\pencil.bmp"
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_pedir_trimestre_rectificacion_349
integer x = 1609
integer y = 644
integer width = 311
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;tipo_array  val
val.valor[1] = "RETURN"
val.valor[2] = ""

closewithreturn(parent,val)
end event

type cb_ok from commandbutton within w_pedir_trimestre_rectificacion_349
integer x = 1298
integer y = 644
integer width = 311
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
end type

event clicked;tipo_array  val
val.valor[1] = string(dec(ejercicio.text),"####")

choose case ddlb_trimestre.text
	case "Trimestre 1º"
		val.valor[2] = "1T"
	case "Trimestre 2º"
		val.valor[2] = "2T"
	case "Trimestre 3º"
		val.valor[2] = "3T"
	case "Trimestre 4º"
		val.valor[2] = "4T"
	case "Enero"
		val.valor[2] = "01"		
	case "Febrero"
		val.valor[2] = "02"		
	case "Marzo"
		val.valor[2] = "03"		
	case "Abril"
		val.valor[2] = "04"		
	case "Mayo"
		val.valor[2] = "05"		
	case "Junio"
		val.valor[2] = "06"		
	case "Julio"
		val.valor[2] = "07"		
	case "Agosto"
		val.valor[2] = "08"		
	case "Septiembre"
		val.valor[2] = "09"		
	case "Octubre"
		val.valor[2] = "10"		
	case "Noviembre"
		val.valor[2] = "11"		
	case "Diciembre"
		val.valor[2] = "12"			
	case "Todo el año"
		val.valor[2] = "0A"		
end choose

closewithreturn(parent,val)
end event

type mensaje from statictext within w_pedir_trimestre_rectificacion_349
integer x = 256
integer y = 64
integer width = 969
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Introducción datos modelo 349"
alignment alignment = center!
boolean focusrectangle = false
end type

