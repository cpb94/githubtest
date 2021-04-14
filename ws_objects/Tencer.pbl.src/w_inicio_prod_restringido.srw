$PBExportHeader$w_inicio_prod_restringido.srw
forward
global type w_inicio_prod_restringido from w_ventana_padre_inicio
end type
type gb_4 from groupbox within w_inicio_prod_restringido
end type
type pb_u from picturebutton within w_inicio_prod_restringido
end type
type st_u from statictext within w_inicio_prod_restringido
end type
type pb_almacen from picturebutton within w_inicio_prod_restringido
end type
type st_almacenv from statictext within w_inicio_prod_restringido
end type
type pb_9 from picturebutton within w_inicio_prod_restringido
end type
type st_9 from statictext within w_inicio_prod_restringido
end type
type gb_6 from groupbox within w_inicio_prod_restringido
end type
type gb_2 from groupbox within w_inicio_prod_restringido
end type
type pb_19 from picturebutton within w_inicio_prod_restringido
end type
type st_19 from statictext within w_inicio_prod_restringido
end type
type gb_20 from groupbox within w_inicio_prod_restringido
end type
type pb_disenyo from picturebutton within w_inicio_prod_restringido
end type
type st_disenyo from statictext within w_inicio_prod_restringido
end type
type st_1 from statictext within w_inicio_prod_restringido
end type
type gb_1 from groupbox within w_inicio_prod_restringido
end type
end forward

global type w_inicio_prod_restringido from w_ventana_padre_inicio
integer x = 965
integer y = 576
integer width = 1280
integer height = 1448
string title = "Menu Principal"
string menuname = "mc_aplicaciones_prod_restringido"
windowstate windowstate = normal!
gb_4 gb_4
pb_u pb_u
st_u st_u
pb_almacen pb_almacen
st_almacenv st_almacenv
pb_9 pb_9
st_9 st_9
gb_6 gb_6
gb_2 gb_2
pb_19 pb_19
st_19 st_19
gb_20 gb_20
pb_disenyo pb_disenyo
st_disenyo st_disenyo
st_1 st_1
gb_1 gb_1
end type
global w_inicio_prod_restringido w_inicio_prod_restringido

on w_inicio_prod_restringido.create
int iCurrent
call super::create
if this.MenuName = "mc_aplicaciones_prod_restringido" then this.MenuID = create mc_aplicaciones_prod_restringido
this.gb_4=create gb_4
this.pb_u=create pb_u
this.st_u=create st_u
this.pb_almacen=create pb_almacen
this.st_almacenv=create st_almacenv
this.pb_9=create pb_9
this.st_9=create st_9
this.gb_6=create gb_6
this.gb_2=create gb_2
this.pb_19=create pb_19
this.st_19=create st_19
this.gb_20=create gb_20
this.pb_disenyo=create pb_disenyo
this.st_disenyo=create st_disenyo
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.pb_u
this.Control[iCurrent+3]=this.st_u
this.Control[iCurrent+4]=this.pb_almacen
this.Control[iCurrent+5]=this.st_almacenv
this.Control[iCurrent+6]=this.pb_9
this.Control[iCurrent+7]=this.st_9
this.Control[iCurrent+8]=this.gb_6
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.pb_19
this.Control[iCurrent+11]=this.st_19
this.Control[iCurrent+12]=this.gb_20
this.Control[iCurrent+13]=this.pb_disenyo
this.Control[iCurrent+14]=this.st_disenyo
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.gb_1
end on

on w_inicio_prod_restringido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_4)
destroy(this.pb_u)
destroy(this.st_u)
destroy(this.pb_almacen)
destroy(this.st_almacenv)
destroy(this.pb_9)
destroy(this.st_9)
destroy(this.gb_6)
destroy(this.gb_2)
destroy(this.pb_19)
destroy(this.st_19)
destroy(this.gb_20)
destroy(this.pb_disenyo)
destroy(this.st_disenyo)
destroy(this.st_1)
destroy(this.gb_1)
end on

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_prod_restringido
integer x = 155
integer y = 1060
integer width = 174
integer height = 152
integer taborder = 10
fontcharset fontcharset = ansi!
boolean originalsize = false
end type

type gb_4 from groupbox within w_inicio_prod_restringido
integer x = 137
integer y = 764
integer width = 736
integer height = 220
integer taborder = 110
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_u from picturebutton within w_inicio_prod_restringido
event clicked pbm_bnclicked
integer x = 155
integer y = 140
integer width = 178
integer height = 152
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\usuarios.bmp"
alignment htextalign = left!
end type

on clicked;IF f_pedir_clave("1") THEN Open (w_utilidad)
end on

type st_u from statictext within w_inicio_prod_restringido
integer x = 398
integer y = 164
integer width = 411
integer height = 104
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Utilidades"
boolean focusrectangle = false
end type

type pb_almacen from picturebutton within w_inicio_prod_restringido
event clicked pbm_bnclicked
integer x = 155
integer y = 356
integer width = 174
integer height = 152
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\almacenv.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_almacenv)
end on

type st_almacenv from statictext within w_inicio_prod_restringido
integer x = 398
integer y = 380
integer width = 370
integer height = 104
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Almacén "
boolean focusrectangle = false
end type

type pb_9 from picturebutton within w_inicio_prod_restringido
boolean visible = false
integer x = 1463
integer y = 1164
integer width = 183
integer height = 148
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\page.bmp"
alignment htextalign = left!
end type

event clicked;open (w_produccion)
end event

type st_9 from statictext within w_inicio_prod_restringido
boolean visible = false
integer x = 1696
integer y = 1184
integer width = 503
integer height = 104
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Producción"
boolean focusrectangle = false
end type

type gb_6 from groupbox within w_inicio_prod_restringido
integer x = 133
integer y = 304
integer width = 736
integer height = 220
integer taborder = 50
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_inicio_prod_restringido
integer x = 146
integer y = 84
integer width = 736
integer height = 220
integer taborder = 30
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_19 from picturebutton within w_inicio_prod_restringido
integer x = 155
integer y = 596
integer width = 178
integer height = 148
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\fabrica.bmp"
alignment htextalign = left!
end type

event clicked;open (w_produccion)
end event

type st_19 from statictext within w_inicio_prod_restringido
integer x = 398
integer y = 616
integer width = 443
integer height = 108
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Producción"
boolean focusrectangle = false
end type

type gb_20 from groupbox within w_inicio_prod_restringido
integer x = 128
integer y = 536
integer width = 736
integer height = 220
integer taborder = 60
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_disenyo from picturebutton within w_inicio_prod_restringido
integer x = 155
integer y = 824
integer width = 174
integer height = 152
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\uti.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;open(w_disenyo)
end event

type st_disenyo from statictext within w_inicio_prod_restringido
integer x = 398
integer y = 840
integer width = 370
integer height = 104
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "I+D "
boolean focusrectangle = false
end type

type st_1 from statictext within w_inicio_prod_restringido
integer x = 398
integer y = 1084
integer width = 370
integer height = 104
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Salir"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_inicio_prod_restringido
integer x = 137
integer y = 1004
integer width = 736
integer height = 220
integer taborder = 120
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

