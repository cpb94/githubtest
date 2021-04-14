$PBExportHeader$w_mant_grid.srw
forward
global type w_mant_grid from window
end type
type pb_salir from picturebutton within w_mant_grid
end type
type pb_borrar from picturebutton within w_mant_grid
end type
type pb_nuevo from picturebutton within w_mant_grid
end type
type pb_grabar from picturebutton within w_mant_grid
end type
type st_titulo from statictext within w_mant_grid
end type
type dw_datos from datawindow within w_mant_grid
end type
end forward

global type w_mant_grid from window
integer width = 3122
integer height = 1756
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "C:\Bmp\Bmp\tencer.ico"
boolean center = true
pb_salir pb_salir
pb_borrar pb_borrar
pb_nuevo pb_nuevo
pb_grabar pb_grabar
st_titulo st_titulo
dw_datos dw_datos
end type
global w_mant_grid w_mant_grid

on w_mant_grid.create
this.pb_salir=create pb_salir
this.pb_borrar=create pb_borrar
this.pb_nuevo=create pb_nuevo
this.pb_grabar=create pb_grabar
this.st_titulo=create st_titulo
this.dw_datos=create dw_datos
this.Control[]={this.pb_salir,&
this.pb_borrar,&
this.pb_nuevo,&
this.pb_grabar,&
this.st_titulo,&
this.dw_datos}
end on

on w_mant_grid.destroy
destroy(this.pb_salir)
destroy(this.pb_borrar)
destroy(this.pb_nuevo)
destroy(this.pb_grabar)
destroy(this.st_titulo)
destroy(this.dw_datos)
end on

event open;string nombre

dw_datos.SetTransObject(SQLCA)

select nombre
into :nombre
from empresas
where empresa = :codigo_empresa;

st_titulo.text = nombre + "    USUARIO: "+nombre_usuario
end event

type pb_salir from picturebutton within w_mant_grid
integer x = 2958
integer y = 8
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Exit!"
alignment htextalign = left!
end type

event clicked;Close(Parent)
end event

type pb_borrar from picturebutton within w_mant_grid
integer x = 2743
integer y = 8
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Clear!"
alignment htextalign = left!
end type

event clicked;dw_datos.DeleteRow(dw_datos.GetRow())
end event

type pb_nuevo from picturebutton within w_mant_grid
integer x = 2638
integer y = 8
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "ScriptNo!"
alignment htextalign = left!
end type

event clicked;long fila

fila = dw_datos.insertrow(0)
dw_datos.object.empresa[fila] = codigo_empresa
dw_datos.setfocus()
dw_datos.scrolltorow(fila)
end event

type pb_grabar from picturebutton within w_mant_grid
integer x = 2848
integer y = 8
integer width = 101
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;dw_datos.update()
end event

type st_titulo from statictext within w_mant_grid
integer y = 8
integer width = 2633
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type dw_datos from datawindow within w_mant_grid
integer x = 5
integer y = 104
integer width = 3067
integer height = 1496
integer taborder = 10
string title = "none"
boolean border = false
boolean livescroll = true
end type

