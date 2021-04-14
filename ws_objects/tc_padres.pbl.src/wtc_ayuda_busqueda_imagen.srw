$PBExportHeader$wtc_ayuda_busqueda_imagen.srw
forward
global type wtc_ayuda_busqueda_imagen from window
end type
type pb_cerrar from picturebutton within wtc_ayuda_busqueda_imagen
end type
type pb_buscar from picturebutton within wtc_ayuda_busqueda_imagen
end type
type busqueda from singlelineedit within wtc_ayuda_busqueda_imagen
end type
type st_2 from statictext within wtc_ayuda_busqueda_imagen
end type
type dw_busqueda from datawindow within wtc_ayuda_busqueda_imagen
end type
end forward

global type wtc_ayuda_busqueda_imagen from window
integer width = 2382
integer height = 2232
boolean titlebar = true
string title = "Untitled"
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
global wtc_ayuda_busqueda_imagen wtc_ayuda_busqueda_imagen

type variables
str_wt_busquedas_entrada peticion
str_wt_busquedas_salida resultado
end variables

on wtc_ayuda_busqueda_imagen.create
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

on wtc_ayuda_busqueda_imagen.destroy
destroy(this.pb_cerrar)
destroy(this.pb_buscar)
destroy(this.busqueda)
destroy(this.st_2)
destroy(this.dw_busqueda)
end on

event open;string error_syntaxfromSQL, error_create, new_syntax, consulta
String codigo, descripcion, titulo = ""
int total 

// Lectura parámetros de entrada y validación
peticion = Message.PowerObjectParm
setnull(Message.PowerObjectParm)

if not isnull(peticion.titulo_ventana) and peticion.titulo_ventana <> "" then
	this.title = peticion.titulo_ventana
end if

resultado.error = ''
resultado.resultado = 0

if IsNull(peticion) Then 
	resultado.resultado = -1
	resultado.error = "No se ha especificado una estructura con los datos de búsqueda. Avise al administrador."
   CloseWithReturn(This, resultado)
	return
end if

if not IsNull(peticion.titulos) and UpperBound(peticion.titulos) > 0 Then 
	titulo = peticion.titulos[1]
end if

//Creación del data window de búsqueda
consulta = peticion.consulta
new_syntax = SQLCA.SyntaxFromSQL(consulta, 'Style(Type=Grid)', error_syntaxfromSQL)

IF Len(error_syntaxfromSQL) > 0 THEN
   // Display errors
	resultado.resultado = -1
	resultado.error = "Error en la consulta de la búsqueda. Avise al administrador."+error_syntaxfromSQL
	CloseWithReturn(this, resultado)
	return
ELSE
   // Generate new DataWindow
   dw_busqueda.Create(new_syntax, error_create)
   IF Len(error_create) > 0 THEN
		resultado.resultado = -1
		resultado.error = "Error en la creación del DW de búsqueda. Avise al administrador."+error_create
   		CloseWithReturn(this, resultado)
		return
   END IF
END IF

dw_busqueda.SetTransObject(SQLCA)
if dw_busqueda.Retrieve() <= 0 then
	CloseWithReturn(this, resultado)
	return
end if

total = integer(dw_busqueda.object.DataWindow.Column.Count)
if total < 2 then
	resultado.resultado = -1
	resultado.error = "La consulta no tiene al menos 2 parámetros para realizar el filtro. Avise al administrador."
   CloseWithReturn(this, resultado)
	return
end if

//Criterio principal
if not isnull(peticion.filtro) and peticion.filtro <> "" then
	busqueda.text = peticion.filtro
	pb_buscar.triggerevent(Clicked!)
end if

busqueda.setfocus()

//Importante tener en cuenta el orden de ejecución!!!! Y los eventos que se llaman

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

if not isnull(peticion.filtro_es_codigo) and peticion.filtro_es_codigo = true then
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
end if

if titulo <> "" then
	dw_busqueda.object.titulo = titulo
end if
end event

event close;CloseWithReturn(this,resultado)
end event

type pb_cerrar from picturebutton within wtc_ayuda_busqueda_imagen
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

type pb_buscar from picturebutton within wtc_ayuda_busqueda_imagen
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

type busqueda from singlelineedit within wtc_ayuda_busqueda_imagen
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

type st_2 from statictext within wtc_ayuda_busqueda_imagen
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

type dw_busqueda from datawindow within wtc_ayuda_busqueda_imagen
integer y = 88
integer width = 2368
integer height = 2060
integer taborder = 10
string title = "none"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;
String codigo, descripcion
if row > 0 then
	codigo = this.getItemString(row, 1)
	descripcion = this.getItemString(row, 2)
	resultado.valores[1] = codigo
	resultado.valores[2] = descripcion
	resultado.resultado = 2
	resultado.error = ""
	
	CloseWithReturn(Parent, resultado)
end if
end event

