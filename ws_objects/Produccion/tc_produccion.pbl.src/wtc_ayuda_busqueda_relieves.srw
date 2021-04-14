$PBExportHeader$wtc_ayuda_busqueda_relieves.srw
forward
global type wtc_ayuda_busqueda_relieves from window
end type
type pb_cerrar from picturebutton within wtc_ayuda_busqueda_relieves
end type
type pb_buscar from picturebutton within wtc_ayuda_busqueda_relieves
end type
type busqueda from singlelineedit within wtc_ayuda_busqueda_relieves
end type
type st_2 from statictext within wtc_ayuda_busqueda_relieves
end type
type dw_busqueda from datawindow within wtc_ayuda_busqueda_relieves
end type
end forward

global type wtc_ayuda_busqueda_relieves from window
integer width = 2382
integer height = 2232
boolean titlebar = true
string title = "Búsqueda de Relieves"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 30527953
string icon = "AppIcon!"
boolean center = true
pb_cerrar pb_cerrar
pb_buscar pb_buscar
busqueda busqueda
st_2 st_2
dw_busqueda dw_busqueda
end type
global wtc_ayuda_busqueda_relieves wtc_ayuda_busqueda_relieves

type variables
str_wt_busquedas_salida resultado
end variables

on wtc_ayuda_busqueda_relieves.create
this.pb_cerrar=create pb_cerrar
this.pb_buscar=create pb_buscar
this.busqueda=create busqueda
this.st_2=create st_2
this.dw_busqueda=create dw_busqueda
this.Control[]={this.pb_cerrar,&
this.pb_buscar,&
this.busqueda,&
this.st_2,&
this.dw_busqueda}
end on

on wtc_ayuda_busqueda_relieves.destroy
destroy(this.pb_cerrar)
destroy(this.pb_buscar)
destroy(this.busqueda)
destroy(this.st_2)
destroy(this.dw_busqueda)
end on

event open;String codigo, descripcion, titulo = ""
int total 

resultado.error = ''
resultado.resultado = 0

dw_busqueda.SetTransObject(SQLCA)
if dw_busqueda.Retrieve() <= 0 then
	CloseWithReturn(this, resultado)
	return
end if

if dw_busqueda.rowcount() = 1 then
	//Un solo resultado encontrado... devolver
	codigo = dw_busqueda.getItemString(dw_busqueda.getrow(), 1)
	descripcion = dw_busqueda.getItemString(dw_busqueda.getrow(), 2)
	resultado.valores[1] = codigo
	resultado.valores[2] = descripcion
	resultado.error = ""
	resultado.resultado = 2
	CloseWithReturn(this, resultado)
	return
end if

busqueda.setfocus()

end event

event close;CloseWithReturn(this,resultado)
end event

type pb_cerrar from picturebutton within wtc_ayuda_busqueda_relieves
integer x = 2267
integer width = 105
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\Tencer_PB12\Delete_24x24.png"
string powertiptext = "Buscar (Tecla rápida TAB)"
end type

event clicked;setnull(resultado.valores)
resultado.resultado = 0
resultado.error = ""

CloseWithReturn(Parent, resultado)
end event

type pb_buscar from picturebutton within wtc_ayuda_busqueda_relieves
integer x = 1445
integer y = 4
integer width = 101
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\TENCER_PB12\Search_24x24.png"
string powertiptext = "Buscar (Tecla rápida TAB)"
end type

event clicked;dw_busqueda.setFilter('#2 LIKE "%'+busqueda.text+'%"')
dw_busqueda.Filter()
busqueda.setfocus()
end event

type busqueda from singlelineedit within wtc_ayuda_busqueda_relieves
integer x = 389
integer y = 8
integer width = 1051
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
textcase textcase = upper!
boolean hideselection = false
end type

event getfocus;// Cambiamos el boton por defecto a Buscar
/*
IF Parent.visible = FALSE Then Return
selecttext(1,100)
*/

end event

event losefocus;// Cambiamos el boton por defecto a Aceptar
//cb_buscar.Default  = FALSE

end event

event modified;pb_buscar.Triggerevent(clicked!)
end event

type st_2 from statictext within wtc_ayuda_busqueda_relieves
integer x = 5
integer y = 8
integer width = 375
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24076881
boolean enabled = false
string text = "Búsqueda"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_busqueda from datawindow within wtc_ayuda_busqueda_relieves
integer y = 88
integer width = 2368
integer height = 2060
integer taborder = 10
string title = "none"
string dataobject = "dwtc_ayuda_relieves_imagen"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;String codigo, descripcion, cliente, razon

if row > 0 then
	codigo = this.getItemString(row, 1)
	descripcion = this.getItemString(row, 2)
	cliente = this.getItemString(row, 4)
	razon = this.getItemString(row, 5)
	resultado.valores[1] = codigo
	resultado.valores[2] = descripcion
	resultado.valores[3] = cliente
	resultado.valores[4] = razon
	resultado.resultado = 4
	resultado.error = ""
	CloseWithReturn(Parent, resultado)
end if
end event

