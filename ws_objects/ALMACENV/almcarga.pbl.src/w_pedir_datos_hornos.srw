$PBExportHeader$w_pedir_datos_hornos.srw
forward
global type w_pedir_datos_hornos from window
end type
type st_6 from statictext within w_pedir_datos_hornos
end type
type st_5 from statictext within w_pedir_datos_hornos
end type
type st_4 from statictext within w_pedir_datos_hornos
end type
type st_articulo from statictext within w_pedir_datos_hornos
end type
type articulo from u_em_campo within w_pedir_datos_hornos
end type
type pedido from u_em_campo within w_pedir_datos_hornos
end type
type linea from u_em_campo within w_pedir_datos_hornos
end type
type h from u_em_campo within w_pedir_datos_hornos
end type
type anyo from u_em_campo within w_pedir_datos_hornos
end type
type st_3 from statictext within w_pedir_datos_hornos
end type
type st_2 from statictext within w_pedir_datos_hornos
end type
type p_1 from picture within w_pedir_datos_hornos
end type
type cb_cancelar from commandbutton within w_pedir_datos_hornos
end type
type cb_ok from commandbutton within w_pedir_datos_hornos
end type
type mensaje from statictext within w_pedir_datos_hornos
end type
end forward

global type w_pedir_datos_hornos from window
integer x = 599
integer y = 420
integer width = 1920
integer height = 908
boolean titlebar = true
string title = "Introducción datos hornos"
windowtype windowtype = response!
long backcolor = 12632256
st_6 st_6
st_5 st_5
st_4 st_4
st_articulo st_articulo
articulo articulo
pedido pedido
linea linea
h h
anyo anyo
st_3 st_3
st_2 st_2
p_1 p_1
cb_cancelar cb_cancelar
cb_ok cb_ok
mensaje mensaje
end type
global w_pedir_datos_hornos w_pedir_datos_hornos

on w_pedir_datos_hornos.create
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_articulo=create st_articulo
this.articulo=create articulo
this.pedido=create pedido
this.linea=create linea
this.h=create h
this.anyo=create anyo
this.st_3=create st_3
this.st_2=create st_2
this.p_1=create p_1
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.mensaje=create mensaje
this.Control[]={this.st_6,&
this.st_5,&
this.st_4,&
this.st_articulo,&
this.articulo,&
this.pedido,&
this.linea,&
this.h,&
this.anyo,&
this.st_3,&
this.st_2,&
this.p_1,&
this.cb_cancelar,&
this.cb_ok,&
this.mensaje}
end on

on w_pedir_datos_hornos.destroy
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_articulo)
destroy(this.articulo)
destroy(this.pedido)
destroy(this.linea)
destroy(this.h)
destroy(this.anyo)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.mensaje)
end on

event open;tipo_array ent

ent =message.powerobjectparm

anyo.text      = ent.valor[1]
pedido.text    = ent.valor[2]
linea.text     = ent.valor[3]
articulo.text  = ent.valor[4]
st_articulo.text = ent.valor[5]
h.text = ent.valor[6]
end event

type st_6 from statictext within w_pedir_datos_hornos
integer x = 64
integer y = 480
integer width = 370
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
string text = "Artículo :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_pedir_datos_hornos
integer x = 64
integer y = 392
integer width = 370
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
string text = "Línea :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_pedir_datos_hornos
integer x = 64
integer y = 304
integer width = 370
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
string text = "Pedido :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_articulo from statictext within w_pedir_datos_hornos
integer x = 768
integer y = 480
integer width = 1102
integer height = 92
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type articulo from u_em_campo within w_pedir_datos_hornos
integer x = 453
integer y = 484
integer width = 306
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type pedido from u_em_campo within w_pedir_datos_hornos
integer x = 453
integer y = 304
integer width = 306
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type linea from u_em_campo within w_pedir_datos_hornos
integer x = 453
integer y = 392
integer width = 306
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type h from u_em_campo within w_pedir_datos_hornos
integer x = 453
integer y = 584
integer width = 306
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,###"
string displaydata = "Ä"
end type

type anyo from u_em_campo within w_pedir_datos_hornos
integer x = 453
integer y = 216
integer width = 306
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type st_3 from statictext within w_pedir_datos_hornos
integer x = 64
integer y = 224
integer width = 370
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
string text = "Año :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pedir_datos_hornos
integer x = 46
integer y = 580
integer width = 384
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Hornos :"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_1 from picture within w_pedir_datos_hornos
integer x = 73
integer y = 44
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "c:\bmp\pencil.bmp"
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_pedir_datos_hornos
integer x = 1559
integer y = 712
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
closewithreturn(parent,val)
end event

type cb_ok from commandbutton within w_pedir_datos_hornos
integer x = 1248
integer y = 712
integer width = 311
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
end type

event clicked;tipo_array  val
val.valor[1] = h.text
Closewithreturn(parent,val)

end event

type mensaje from statictext within w_pedir_datos_hornos
integer x = 256
integer y = 64
integer width = 1143
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Introducción datos  movimiento hornos"
alignment alignment = center!
boolean focusrectangle = false
end type

