$PBExportHeader$w_inputboxgrande2.srw
forward
global type w_inputboxgrande2 from window
end type
type texto from multilineedit within w_inputboxgrande2
end type
type texto_fecha from u_em_campo within w_inputboxgrande2
end type
type p_1 from picture within w_inputboxgrande2
end type
type cb_cancelar from commandbutton within w_inputboxgrande2
end type
type cb_ok from commandbutton within w_inputboxgrande2
end type
type mensaje from statictext within w_inputboxgrande2
end type
end forward

global type w_inputboxgrande2 from window
integer x = 718
integer y = 784
integer width = 1582
integer height = 556
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
texto texto
texto_fecha texto_fecha
p_1 p_1
cb_cancelar cb_cancelar
cb_ok cb_ok
mensaje mensaje
end type
global w_inputboxgrande2 w_inputboxgrande2

on w_inputboxgrande2.create
this.texto=create texto
this.texto_fecha=create texto_fecha
this.p_1=create p_1
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.mensaje=create mensaje
this.Control[]={this.texto,&
this.texto_fecha,&
this.p_1,&
this.cb_cancelar,&
this.cb_ok,&
this.mensaje}
end on

on w_inputboxgrande2.destroy
destroy(this.texto)
destroy(this.texto_fecha)
destroy(this.p_1)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.mensaje)
end on

event open;str_parametros param
param=message.PowerObjectParm
this.title=param.s_argumentos[1]
mensaje.text=param.s_argumentos[2]
if isnull(param.s_argumentos[4]) or param.s_argumentos[4]="" then
	texto.visible=true
	texto_fecha.visible=false
	texto.text=param.s_argumentos[3]
	texto.SetFocus()
else
	texto.visible=false
	texto_fecha.visible=true
	texto_fecha.text=param.s_argumentos[3]
	texto_fecha.SetFocus()
end if
end event

type texto from multilineedit within w_inputboxgrande2
integer x = 32
integer y = 352
integer width = 1467
integer height = 80
integer taborder = 2
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type texto_fecha from u_em_campo within w_inputboxgrande2
boolean visible = false
integer x = 512
integer y = 336
integer width = 338
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "<8"
end type

type p_1 from picture within w_inputboxgrande2
integer x = 73
integer y = 44
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "\bmp\pencil.bmp"
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_inputboxgrande2
integer x = 1184
integer y = 204
integer width = 320
integer height = 88
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;closewithreturn(parent,"")
end event

type cb_ok from commandbutton within w_inputboxgrande2
integer x = 1184
integer y = 104
integer width = 320
integer height = 88
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
end type

event clicked;if texto.visible=true then
	closewithreturn(parent,texto.text)
else
	closewithreturn(parent,texto_fecha.text)
end if
end event

type mensaje from statictext within w_inputboxgrande2
integer x = 261
integer y = 36
integer width = 878
integer height = 260
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

