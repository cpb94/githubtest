$PBExportHeader$w_inicio_comercial_compras.srw
forward
global type w_inicio_comercial_compras from w_ventana_padre_inicio
end type
type pb_u from picturebutton within w_inicio_comercial_compras
end type
type st_u from statictext within w_inicio_comercial_compras
end type
type pb_2 from picturebutton within w_inicio_comercial_compras
end type
type st_1 from statictext within w_inicio_comercial_compras
end type
type pb_generales from picturebutton within w_inicio_comercial_compras
end type
type st_generales from statictext within w_inicio_comercial_compras
end type
type gb_58 from groupbox within w_inicio_comercial_compras
end type
type gb_12 from groupbox within w_inicio_comercial_compras
end type
type gb_14 from groupbox within w_inicio_comercial_compras
end type
type pb_4 from picturebutton within w_inicio_comercial_compras
end type
type pb_almacen from picturebutton within w_inicio_comercial_compras
end type
type st_2 from statictext within w_inicio_comercial_compras
end type
type st_almacenv from statictext within w_inicio_comercial_compras
end type
type pb_d from picturebutton within w_inicio_comercial_compras
end type
type st_d from statictext within w_inicio_comercial_compras
end type
type pb_19 from picturebutton within w_inicio_comercial_compras
end type
type st_19 from statictext within w_inicio_comercial_compras
end type
type pb_10 from picturebutton within w_inicio_comercial_compras
end type
type st_10 from statictext within w_inicio_comercial_compras
end type
type pb_20 from picturebutton within w_inicio_comercial_compras
end type
type st_20 from statictext within w_inicio_comercial_compras
end type
type pb_disenyo from picturebutton within w_inicio_comercial_compras
end type
type st_disenyo from statictext within w_inicio_comercial_compras
end type
type st_3 from statictext within w_inicio_comercial_compras
end type
type gb_6 from groupbox within w_inicio_comercial_compras
end type
type gb_1 from groupbox within w_inicio_comercial_compras
end type
end forward

global type w_inicio_comercial_compras from w_ventana_padre_inicio
integer x = 645
integer y = 416
integer width = 2304
integer height = 1596
string title = "Menu Principal"
windowstate windowstate = normal!
pb_u pb_u
st_u st_u
pb_2 pb_2
st_1 st_1
pb_generales pb_generales
st_generales st_generales
gb_58 gb_58
gb_12 gb_12
gb_14 gb_14
pb_4 pb_4
pb_almacen pb_almacen
st_2 st_2
st_almacenv st_almacenv
pb_d pb_d
st_d st_d
pb_19 pb_19
st_19 st_19
pb_10 pb_10
st_10 st_10
pb_20 pb_20
st_20 st_20
pb_disenyo pb_disenyo
st_disenyo st_disenyo
st_3 st_3
gb_6 gb_6
gb_1 gb_1
end type
global w_inicio_comercial_compras w_inicio_comercial_compras

on w_inicio_comercial_compras.create
int iCurrent
call super::create
this.pb_u=create pb_u
this.st_u=create st_u
this.pb_2=create pb_2
this.st_1=create st_1
this.pb_generales=create pb_generales
this.st_generales=create st_generales
this.gb_58=create gb_58
this.gb_12=create gb_12
this.gb_14=create gb_14
this.pb_4=create pb_4
this.pb_almacen=create pb_almacen
this.st_2=create st_2
this.st_almacenv=create st_almacenv
this.pb_d=create pb_d
this.st_d=create st_d
this.pb_19=create pb_19
this.st_19=create st_19
this.pb_10=create pb_10
this.st_10=create st_10
this.pb_20=create pb_20
this.st_20=create st_20
this.pb_disenyo=create pb_disenyo
this.st_disenyo=create st_disenyo
this.st_3=create st_3
this.gb_6=create gb_6
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_u
this.Control[iCurrent+2]=this.st_u
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.pb_generales
this.Control[iCurrent+6]=this.st_generales
this.Control[iCurrent+7]=this.gb_58
this.Control[iCurrent+8]=this.gb_12
this.Control[iCurrent+9]=this.gb_14
this.Control[iCurrent+10]=this.pb_4
this.Control[iCurrent+11]=this.pb_almacen
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_almacenv
this.Control[iCurrent+14]=this.pb_d
this.Control[iCurrent+15]=this.st_d
this.Control[iCurrent+16]=this.pb_19
this.Control[iCurrent+17]=this.st_19
this.Control[iCurrent+18]=this.pb_10
this.Control[iCurrent+19]=this.st_10
this.Control[iCurrent+20]=this.pb_20
this.Control[iCurrent+21]=this.st_20
this.Control[iCurrent+22]=this.pb_disenyo
this.Control[iCurrent+23]=this.st_disenyo
this.Control[iCurrent+24]=this.st_3
this.Control[iCurrent+25]=this.gb_6
this.Control[iCurrent+26]=this.gb_1
end on

on w_inicio_comercial_compras.destroy
call super::destroy
destroy(this.pb_u)
destroy(this.st_u)
destroy(this.pb_2)
destroy(this.st_1)
destroy(this.pb_generales)
destroy(this.st_generales)
destroy(this.gb_58)
destroy(this.gb_12)
destroy(this.gb_14)
destroy(this.pb_4)
destroy(this.pb_almacen)
destroy(this.st_2)
destroy(this.st_almacenv)
destroy(this.pb_d)
destroy(this.st_d)
destroy(this.pb_19)
destroy(this.st_19)
destroy(this.pb_10)
destroy(this.st_10)
destroy(this.pb_20)
destroy(this.st_20)
destroy(this.pb_disenyo)
destroy(this.st_disenyo)
destroy(this.st_3)
destroy(this.gb_6)
destroy(this.gb_1)
end on

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_comercial_compras
integer x = 1125
integer y = 1216
integer width = 183
integer height = 160
integer taborder = 10
boolean originalsize = false
end type

type pb_u from picturebutton within w_inicio_comercial_compras
event clicked pbm_bnclicked
integer x = 215
integer y = 332
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

type st_u from statictext within w_inicio_comercial_compras
integer x = 425
integer y = 356
integer width = 411
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
string text = "Utilidades"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_inicio_comercial_compras
event clicked pbm_bnclicked
integer x = 215
integer y = 496
integer width = 183
integer height = 160
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\tel32am.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_mailing)
end on

type st_1 from statictext within w_inicio_comercial_compras
integer x = 425
integer y = 520
integer width = 393
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
string text = "Mailing"
boolean focusrectangle = false
end type

type pb_generales from picturebutton within w_inicio_comercial_compras
event clicked pbm_bnclicked
integer x = 215
integer y = 164
integer width = 183
integer height = 160
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\general.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_general)
end on

type st_generales from statictext within w_inicio_comercial_compras
integer x = 425
integer y = 188
integer width = 421
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
string text = "Generales"
boolean focusrectangle = false
end type

type gb_58 from groupbox within w_inicio_comercial_compras
integer x = 114
integer y = 724
integer width = 896
integer height = 676
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

type gb_12 from groupbox within w_inicio_comercial_compras
integer x = 1038
integer y = 60
integer width = 896
integer height = 648
integer taborder = 100
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_14 from groupbox within w_inicio_comercial_compras
integer x = 105
integer y = 56
integer width = 910
integer height = 648
integer taborder = 40
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_4 from picturebutton within w_inicio_comercial_compras
integer x = 219
integer y = 1184
integer width = 178
integer height = 148
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\globo.bmp"
alignment htextalign = left!
end type

on clicked;open (w_ventas)
end on

type pb_almacen from picturebutton within w_inicio_comercial_compras
integer x = 1138
integer y = 160
integer width = 178
integer height = 148
integer taborder = 190
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

type st_2 from statictext within w_inicio_comercial_compras
integer x = 425
integer y = 1208
integer width = 297
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
string text = "Ventas"
boolean focusrectangle = false
end type

type st_almacenv from statictext within w_inicio_comercial_compras
integer x = 1353
integer y = 184
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

type pb_d from picturebutton within w_inicio_comercial_compras
integer x = 219
integer y = 836
integer width = 178
integer height = 148
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\granito.bmp"
alignment htextalign = left!
end type

event clicked;Open (w_depositos)
end event

type st_d from statictext within w_inicio_comercial_compras
integer x = 425
integer y = 864
integer width = 407
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
string text = "Depósitos"
boolean focusrectangle = false
end type

type pb_19 from picturebutton within w_inicio_comercial_compras
integer x = 1138
integer y = 328
integer width = 178
integer height = 148
integer taborder = 150
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

type st_19 from statictext within w_inicio_comercial_compras
integer x = 1353
integer y = 348
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

type pb_10 from picturebutton within w_inicio_comercial_compras
integer x = 219
integer y = 1008
integer width = 178
integer height = 148
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\cliente.bmp"
alignment htextalign = left!
end type

event clicked;open (w_compras)
end event

type st_10 from statictext within w_inicio_comercial_compras
integer x = 425
integer y = 1028
integer width = 384
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
string text = "Compras"
boolean focusrectangle = false
end type

type pb_20 from picturebutton within w_inicio_comercial_compras
integer x = 1143
integer y = 492
integer width = 178
integer height = 148
integer taborder = 200
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\colores.bmp"
alignment htextalign = left!
end type

event clicked;open (w_laboratorio)
end event

type st_20 from statictext within w_inicio_comercial_compras
integer x = 1353
integer y = 512
integer width = 457
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
string text = "Laboratorio"
boolean focusrectangle = false
end type

type pb_disenyo from picturebutton within w_inicio_comercial_compras
integer x = 1120
integer y = 796
integer width = 183
integer height = 160
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\uti.bmp"
alignment htextalign = left!
end type

event clicked;open(w_disenyo)
end event

type st_disenyo from statictext within w_inicio_comercial_compras
integer x = 1349
integer y = 820
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
string text = "I+D"
boolean focusrectangle = false
end type

type st_3 from statictext within w_inicio_comercial_compras
integer x = 1349
integer y = 1248
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

type gb_6 from groupbox within w_inicio_comercial_compras
integer x = 1029
integer y = 724
integer width = 905
integer height = 248
integer taborder = 80
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_inicio_comercial_compras
integer x = 1029
integer y = 1152
integer width = 905
integer height = 248
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

