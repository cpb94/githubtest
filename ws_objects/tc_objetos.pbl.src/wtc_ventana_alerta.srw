$PBExportHeader$wtc_ventana_alerta.srw
forward
global type wtc_ventana_alerta from window
end type
type st_subtitulo from statictext within wtc_ventana_alerta
end type
type cb_3 from commandbutton within wtc_ventana_alerta
end type
type cb_2 from commandbutton within wtc_ventana_alerta
end type
type cb_1 from commandbutton within wtc_ventana_alerta
end type
type st_texto from statictext within wtc_ventana_alerta
end type
type p_3 from picture within wtc_ventana_alerta
end type
type p_2 from picture within wtc_ventana_alerta
end type
type p_1 from picture within wtc_ventana_alerta
end type
end forward

global type wtc_ventana_alerta from window
integer width = 1911
integer height = 788
boolean titlebar = true
string title = "Untitled"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_subtitulo st_subtitulo
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_texto st_texto
p_3 p_3
p_2 p_2
p_1 p_1
end type
global wtc_ventana_alerta wtc_ventana_alerta

on wtc_ventana_alerta.create
this.st_subtitulo=create st_subtitulo
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_texto=create st_texto
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.Control[]={this.st_subtitulo,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_texto,&
this.p_3,&
this.p_2,&
this.p_1}
end on

on wtc_ventana_alerta.destroy
destroy(this.st_subtitulo)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_texto)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
end on

event open;String texto
Int i, numero_botones
str_ventana_alerta parametros

parametros = Message.PowerObjectParm

this.title = parametros.titulo

if not isnull(parametros.subtitulo) and parametros.subtitulo <> "" then
	st_subtitulo.text = parametros.subtitulo
	if not isnull(parametros.mensaje) and parametros.mensaje <> "" then
		st_texto.text = parametros.mensaje
	else
		st_texto.visible = false
		st_subtitulo.y = 200
	end if
else
	if not isnull(parametros.mensaje) and parametros.mensaje <> "" then
		st_texto.text = parametros.mensaje
	end if
	st_subtitulo.visible = false
	st_texto.y = st_subtitulo.y
end if

if parametros.tipo = 1 then
	this.backcolor = rgb(236,46,56)
	st_texto.textcolor = rgb(255,255,255)
	st_subtitulo.textcolor = rgb(255,255,255)
elseif parametros.tipo = 2 then
	this.backcolor = rgb(239,228,67)
	
elseif parametros.tipo = 3 then
	this.backcolor = rgb(81,98,111)
	
end if

numero_botones = Upperbound(parametros.botones)

If numero_botones = 0 then
	cb_3.visible = false
	cb_2.x = cb_3.x
elseif numero_botones = 1 then
	cb_2.visible = false
	cb_3.visible = false
	cb_1.x = cb_2.x
	cb_1.text = parametros.botones[1]
elseif numero_botones = 2 then
	cb_3.visible = false
	cb_2.x = cb_3.x
	cb_1.text = parametros.botones[1]
	cb_2.text = parametros.botones[2]
elseif numero_botones = 3 then
	cb_1.text = parametros.botones[1]
	cb_2.text = parametros.botones[2]
	cb_3.text = parametros.botones[3]
end if
	
if parametros.mostrar_imagen = true then
	if parametros.tipo = 1 then
		p_1.visible = true
		p_2.visible = false
		p_3.visible = false
	elseif parametros.tipo = 2 then
		p_1.visible = false
		p_2.visible = true
		p_3.visible = false
	elseif parametros.tipo = 3 then
		p_1.visible = false
		p_2.visible = false
		p_3.visible = true
	end if
else
	p_1.visible = false
	p_2.visible = false
	p_3.visible = false
	st_texto.x = 82
	st_texto.width = 1751
	st_subtitulo.x = 82
	st_subtitulo.width = 1751
end if

	
	



end event

type st_subtitulo from statictext within wtc_ventana_alerta
integer x = 558
integer y = 72
integer width = 1275
integer height = 84
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within wtc_ventana_alerta
integer x = 1358
integer y = 508
integer width = 475
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Extra"
end type

event clicked;CloseWithReturn(Parent, 3)
end event

type cb_2 from commandbutton within wtc_ventana_alerta
integer x = 722
integer y = 508
integer width = 475
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;CloseWithReturn(Parent, 2)
end event

type cb_1 from commandbutton within wtc_ventana_alerta
integer x = 82
integer y = 508
integer width = 475
integer height = 112
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;CloseWithReturn(Parent, 1)
end event

type st_texto from statictext within wtc_ventana_alerta
integer x = 571
integer y = 192
integer width = 1262
integer height = 216
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
alignment alignment = center!
boolean focusrectangle = false
end type

type p_3 from picture within wtc_ventana_alerta
integer x = 91
integer y = 88
integer width = 393
integer height = 320
string picturename = "C:\Tencer_PB12\Information_256x256.png"
boolean focusrectangle = false
end type

type p_2 from picture within wtc_ventana_alerta
integer x = 91
integer y = 88
integer width = 393
integer height = 320
string picturename = "C:\Tencer_PB12\Warning.png"
boolean focusrectangle = false
end type

type p_1 from picture within wtc_ventana_alerta
integer x = 91
integer y = 88
integer width = 393
integer height = 320
string picturename = "C:\Tencer_PB12\Remove_256x256.png"
boolean focusrectangle = false
end type

