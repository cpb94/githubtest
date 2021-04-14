$PBExportHeader$w_mant_borrar_desmodelos.srw
forward
global type w_mant_borrar_desmodelos from window
end type
type pb_salir from picturebutton within w_mant_borrar_desmodelos
end type
type st_1 from statictext within w_mant_borrar_desmodelos
end type
type sle_modelo from singlelineedit within w_mant_borrar_desmodelos
end type
type pb_borrar from picturebutton within w_mant_borrar_desmodelos
end type
end forward

global type w_mant_borrar_desmodelos from window
integer width = 1317
integer height = 428
boolean titlebar = true
string title = "Borrar Modelos de Desarrollo"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 8421376
string icon = "AppIcon!"
boolean center = true
pb_salir pb_salir
st_1 st_1
sle_modelo sle_modelo
pb_borrar pb_borrar
end type
global w_mant_borrar_desmodelos w_mant_borrar_desmodelos

on w_mant_borrar_desmodelos.create
this.pb_salir=create pb_salir
this.st_1=create st_1
this.sle_modelo=create sle_modelo
this.pb_borrar=create pb_borrar
this.Control[]={this.pb_salir,&
this.st_1,&
this.sle_modelo,&
this.pb_borrar}
end on

on w_mant_borrar_desmodelos.destroy
destroy(this.pb_salir)
destroy(this.st_1)
destroy(this.sle_modelo)
destroy(this.pb_borrar)
end on

type pb_salir from picturebutton within w_mant_borrar_desmodelos
integer x = 1189
integer y = 12
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Exit!"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type st_1 from statictext within w_mant_borrar_desmodelos
integer x = 165
integer y = 144
integer width = 425
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "Modelo a borrar:"
boolean focusrectangle = false
end type

type sle_modelo from singlelineedit within w_mant_borrar_desmodelos
integer x = 617
integer y = 136
integer width = 402
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type

type pb_borrar from picturebutton within w_mant_borrar_desmodelos
integer x = 1083
integer y = 12
integer width = 110
integer height = 96
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

event clicked;if messagebox("Atención","¿Seguro que desea borrar el modelo: "+sle_modelo.text,Exclamation!, YesNo!, 2) = 1 then
	f_borrar_desmodelos (codigo_empresa, sle_modelo.text)
end if




end event

