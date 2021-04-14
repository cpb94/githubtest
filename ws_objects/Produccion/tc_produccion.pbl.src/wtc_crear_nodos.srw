$PBExportHeader$wtc_crear_nodos.srw
forward
global type wtc_crear_nodos from window
end type
type st_label from statictext within wtc_crear_nodos
end type
type cb_2 from commandbutton within wtc_crear_nodos
end type
type cb_1 from commandbutton within wtc_crear_nodos
end type
end forward

global type wtc_crear_nodos from window
integer width = 3150
integer height = 524
boolean titlebar = true
string title = "Crear Nodos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_label st_label
cb_2 cb_2
cb_1 cb_1
end type
global wtc_crear_nodos wtc_crear_nodos

on wtc_crear_nodos.create
this.st_label=create st_label
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_label,&
this.cb_2,&
this.cb_1}
end on

on wtc_crear_nodos.destroy
destroy(this.st_label)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;string articulo

articulo = left (Message.StringParm, pos (Message.StringParm, " "))

st_label.text = Message.StringParm

end event

type st_label from statictext within wtc_crear_nodos
integer x = 27
integer y = 28
integer width = 3072
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within wtc_crear_nodos
integer x = 1605
integer y = 208
integer width = 402
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

type cb_1 from commandbutton within wtc_crear_nodos
integer x = 1074
integer y = 208
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Añadir Nodo"
end type

