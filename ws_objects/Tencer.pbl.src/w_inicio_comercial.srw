$PBExportHeader$w_inicio_comercial.srw
forward
global type w_inicio_comercial from w_ventana_padre_inicio
end type
type pb_u from picturebutton within w_inicio_comercial
end type
type st_u from statictext within w_inicio_comercial
end type
type pb_4 from picturebutton within w_inicio_comercial
end type
type pb_almacen from picturebutton within w_inicio_comercial
end type
type st_2 from statictext within w_inicio_comercial
end type
type pb_2 from picturebutton within w_inicio_comercial
end type
type st_1 from statictext within w_inicio_comercial
end type
type st_almacenv from statictext within w_inicio_comercial
end type
type pb_generales from picturebutton within w_inicio_comercial
end type
type pb_d from picturebutton within w_inicio_comercial
end type
type st_d from statictext within w_inicio_comercial
end type
type pb_9 from picturebutton within w_inicio_comercial
end type
type st_9 from statictext within w_inicio_comercial
end type
type st_generales from statictext within w_inicio_comercial
end type
type gb_21 from groupbox within w_inicio_comercial
end type
type gb_77 from groupbox within w_inicio_comercial
end type
type gb_6 from groupbox within w_inicio_comercial
end type
type gb_5 from groupbox within w_inicio_comercial
end type
type gb_3 from groupbox within w_inicio_comercial
end type
type gb_2 from groupbox within w_inicio_comercial
end type
type gb_1 from groupbox within w_inicio_comercial
end type
type gb_8 from groupbox within w_inicio_comercial
end type
type pb_19 from picturebutton within w_inicio_comercial
end type
type st_19 from statictext within w_inicio_comercial
end type
type gb_20 from groupbox within w_inicio_comercial
end type
type pb_disenyo from picturebutton within w_inicio_comercial
end type
type st_disenyo from statictext within w_inicio_comercial
end type
type pb_20 from picturebutton within w_inicio_comercial
end type
type st_20 from statictext within w_inicio_comercial
end type
type st_3 from statictext within w_inicio_comercial
end type
type gb_4 from groupbox within w_inicio_comercial
end type
end forward

global type w_inicio_comercial from w_ventana_padre_inicio
integer height = 1256
string title = "Menu Principal"
pb_u pb_u
st_u st_u
pb_4 pb_4
pb_almacen pb_almacen
st_2 st_2
pb_2 pb_2
st_1 st_1
st_almacenv st_almacenv
pb_generales pb_generales
pb_d pb_d
st_d st_d
pb_9 pb_9
st_9 st_9
st_generales st_generales
gb_21 gb_21
gb_77 gb_77
gb_6 gb_6
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
gb_8 gb_8
pb_19 pb_19
st_19 st_19
gb_20 gb_20
pb_disenyo pb_disenyo
st_disenyo st_disenyo
pb_20 pb_20
st_20 st_20
st_3 st_3
gb_4 gb_4
end type
global w_inicio_comercial w_inicio_comercial

on w_inicio_comercial.create
int iCurrent
call super::create
this.pb_u=create pb_u
this.st_u=create st_u
this.pb_4=create pb_4
this.pb_almacen=create pb_almacen
this.st_2=create st_2
this.pb_2=create pb_2
this.st_1=create st_1
this.st_almacenv=create st_almacenv
this.pb_generales=create pb_generales
this.pb_d=create pb_d
this.st_d=create st_d
this.pb_9=create pb_9
this.st_9=create st_9
this.st_generales=create st_generales
this.gb_21=create gb_21
this.gb_77=create gb_77
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_8=create gb_8
this.pb_19=create pb_19
this.st_19=create st_19
this.gb_20=create gb_20
this.pb_disenyo=create pb_disenyo
this.st_disenyo=create st_disenyo
this.pb_20=create pb_20
this.st_20=create st_20
this.st_3=create st_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_u
this.Control[iCurrent+2]=this.st_u
this.Control[iCurrent+3]=this.pb_4
this.Control[iCurrent+4]=this.pb_almacen
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_almacenv
this.Control[iCurrent+9]=this.pb_generales
this.Control[iCurrent+10]=this.pb_d
this.Control[iCurrent+11]=this.st_d
this.Control[iCurrent+12]=this.pb_9
this.Control[iCurrent+13]=this.st_9
this.Control[iCurrent+14]=this.st_generales
this.Control[iCurrent+15]=this.gb_21
this.Control[iCurrent+16]=this.gb_77
this.Control[iCurrent+17]=this.gb_6
this.Control[iCurrent+18]=this.gb_5
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.gb_8
this.Control[iCurrent+23]=this.pb_19
this.Control[iCurrent+24]=this.st_19
this.Control[iCurrent+25]=this.gb_20
this.Control[iCurrent+26]=this.pb_disenyo
this.Control[iCurrent+27]=this.st_disenyo
this.Control[iCurrent+28]=this.pb_20
this.Control[iCurrent+29]=this.st_20
this.Control[iCurrent+30]=this.st_3
this.Control[iCurrent+31]=this.gb_4
end on

on w_inicio_comercial.destroy
call super::destroy
destroy(this.pb_u)
destroy(this.st_u)
destroy(this.pb_4)
destroy(this.pb_almacen)
destroy(this.st_2)
destroy(this.pb_2)
destroy(this.st_1)
destroy(this.st_almacenv)
destroy(this.pb_generales)
destroy(this.pb_d)
destroy(this.st_d)
destroy(this.pb_9)
destroy(this.st_9)
destroy(this.st_generales)
destroy(this.gb_21)
destroy(this.gb_77)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_8)
destroy(this.pb_19)
destroy(this.st_19)
destroy(this.gb_20)
destroy(this.pb_disenyo)
destroy(this.st_disenyo)
destroy(this.pb_20)
destroy(this.st_20)
destroy(this.st_3)
destroy(this.gb_4)
end on

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_comercial
integer x = 919
integer y = 892
integer width = 183
integer height = 160
integer taborder = 10
boolean originalsize = false
end type

type pb_u from picturebutton within w_inicio_comercial
event clicked pbm_bnclicked
integer x = 919
integer y = 116
integer width = 178
integer height = 152
integer taborder = 200
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

type st_u from statictext within w_inicio_comercial
integer x = 1129
integer y = 140
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

type pb_4 from picturebutton within w_inicio_comercial
event clicked pbm_bnclicked
integer x = 1664
integer y = 372
integer width = 174
integer height = 152
integer taborder = 50
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

type pb_almacen from picturebutton within w_inicio_comercial
event clicked pbm_bnclicked
integer x = 955
integer y = 372
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
string picturename = "c:\bmp\almacenv.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_almacenv)
end on

type st_2 from statictext within w_inicio_comercial
integer x = 1874
integer y = 392
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

type pb_2 from picturebutton within w_inicio_comercial
event clicked pbm_bnclicked
integer x = 1659
integer y = 116
integer width = 183
integer height = 160
integer taborder = 40
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

type st_1 from statictext within w_inicio_comercial
integer x = 1870
integer y = 140
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

type st_almacenv from statictext within w_inicio_comercial
integer x = 1166
integer y = 392
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

type pb_generales from picturebutton within w_inicio_comercial
event clicked pbm_bnclicked
integer x = 178
integer y = 116
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

type pb_d from picturebutton within w_inicio_comercial
event clicked pbm_bnclicked
integer x = 174
integer y = 372
integer width = 178
integer height = 152
integer taborder = 190
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

type st_d from statictext within w_inicio_comercial
integer x = 384
integer y = 388
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

type pb_9 from picturebutton within w_inicio_comercial
boolean visible = false
integer x = 1463
integer y = 1164
integer width = 183
integer height = 148
integer taborder = 210
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

type st_9 from statictext within w_inicio_comercial
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

type st_generales from statictext within w_inicio_comercial
integer x = 379
integer y = 140
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

type gb_21 from groupbox within w_inicio_comercial
integer x = 1650
integer y = 576
integer width = 741
integer height = 220
integer taborder = 150
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_77 from groupbox within w_inicio_comercial
integer x = 905
integer y = 576
integer width = 736
integer height = 220
integer taborder = 140
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_6 from groupbox within w_inicio_comercial
integer x = 901
integer y = 316
integer width = 736
integer height = 220
integer taborder = 150
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_5 from groupbox within w_inicio_comercial
integer x = 160
integer y = 316
integer width = 736
integer height = 220
integer taborder = 130
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_inicio_comercial
integer x = 1646
integer y = 60
integer width = 736
integer height = 220
integer taborder = 90
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_inicio_comercial
integer x = 905
integer y = 60
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

type gb_1 from groupbox within w_inicio_comercial
integer x = 165
integer y = 60
integer width = 736
integer height = 220
integer taborder = 160
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_8 from groupbox within w_inicio_comercial
integer x = 1650
integer y = 316
integer width = 736
integer height = 220
integer taborder = 180
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_19 from picturebutton within w_inicio_comercial
integer x = 201
integer y = 636
integer width = 178
integer height = 148
integer taborder = 220
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

type st_19 from statictext within w_inicio_comercial
integer x = 425
integer y = 656
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

type gb_20 from groupbox within w_inicio_comercial
integer x = 165
integer y = 576
integer width = 736
integer height = 220
integer taborder = 170
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_disenyo from picturebutton within w_inicio_comercial
integer x = 937
integer y = 632
integer width = 183
integer height = 160
integer taborder = 80
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

type st_disenyo from statictext within w_inicio_comercial
integer x = 1152
integer y = 656
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

type pb_20 from picturebutton within w_inicio_comercial
integer x = 1669
integer y = 632
integer width = 183
integer height = 156
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\spgrande.bmp"
alignment htextalign = left!
end type

event clicked;open (w_laboratorio)
end event

type st_20 from statictext within w_inicio_comercial
integer x = 1888
integer y = 656
integer width = 462
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

type st_3 from statictext within w_inicio_comercial
integer x = 1152
integer y = 916
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

type gb_4 from groupbox within w_inicio_comercial
integer x = 905
integer y = 836
integer width = 736
integer height = 220
integer taborder = 160
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

