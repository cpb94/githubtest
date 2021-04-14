$PBExportHeader$w_inicio_produccion.srw
forward
global type w_inicio_produccion from w_ventana_padre_inicio
end type
type pb_u from picturebutton within w_inicio_produccion
end type
type st_u from statictext within w_inicio_produccion
end type
type pb_4 from picturebutton within w_inicio_produccion
end type
type pb_almacen from picturebutton within w_inicio_produccion
end type
type st_2 from statictext within w_inicio_produccion
end type
type pb_2 from picturebutton within w_inicio_produccion
end type
type st_1 from statictext within w_inicio_produccion
end type
type st_almacenv from statictext within w_inicio_produccion
end type
type pb_generales from picturebutton within w_inicio_produccion
end type
type pb_9 from picturebutton within w_inicio_produccion
end type
type st_9 from statictext within w_inicio_produccion
end type
type st_generales from statictext within w_inicio_produccion
end type
type gb_65 from groupbox within w_inicio_produccion
end type
type gb_6 from groupbox within w_inicio_produccion
end type
type gb_5 from groupbox within w_inicio_produccion
end type
type gb_4 from groupbox within w_inicio_produccion
end type
type gb_3 from groupbox within w_inicio_produccion
end type
type gb_2 from groupbox within w_inicio_produccion
end type
type gb_1 from groupbox within w_inicio_produccion
end type
type gb_8 from groupbox within w_inicio_produccion
end type
type pb_19 from picturebutton within w_inicio_produccion
end type
type st_19 from statictext within w_inicio_produccion
end type
type st_20 from statictext within w_inicio_produccion
end type
type pb_20 from picturebutton within w_inicio_produccion
end type
type pb_disenyo from picturebutton within w_inicio_produccion
end type
type st_disenyo from statictext within w_inicio_produccion
end type
type st_3 from statictext within w_inicio_produccion
end type
type gb_7 from groupbox within w_inicio_produccion
end type
end forward

global type w_inicio_produccion from w_ventana_padre_inicio
integer width = 2848
integer height = 1300
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
pb_9 pb_9
st_9 st_9
st_generales st_generales
gb_65 gb_65
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
gb_8 gb_8
pb_19 pb_19
st_19 st_19
st_20 st_20
pb_20 pb_20
pb_disenyo pb_disenyo
st_disenyo st_disenyo
st_3 st_3
gb_7 gb_7
end type
global w_inicio_produccion w_inicio_produccion

on w_inicio_produccion.create
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
this.pb_9=create pb_9
this.st_9=create st_9
this.st_generales=create st_generales
this.gb_65=create gb_65
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_8=create gb_8
this.pb_19=create pb_19
this.st_19=create st_19
this.st_20=create st_20
this.pb_20=create pb_20
this.pb_disenyo=create pb_disenyo
this.st_disenyo=create st_disenyo
this.st_3=create st_3
this.gb_7=create gb_7
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
this.Control[iCurrent+10]=this.pb_9
this.Control[iCurrent+11]=this.st_9
this.Control[iCurrent+12]=this.st_generales
this.Control[iCurrent+13]=this.gb_65
this.Control[iCurrent+14]=this.gb_6
this.Control[iCurrent+15]=this.gb_5
this.Control[iCurrent+16]=this.gb_4
this.Control[iCurrent+17]=this.gb_3
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.gb_8
this.Control[iCurrent+21]=this.pb_19
this.Control[iCurrent+22]=this.st_19
this.Control[iCurrent+23]=this.st_20
this.Control[iCurrent+24]=this.pb_20
this.Control[iCurrent+25]=this.pb_disenyo
this.Control[iCurrent+26]=this.st_disenyo
this.Control[iCurrent+27]=this.st_3
this.Control[iCurrent+28]=this.gb_7
end on

on w_inicio_produccion.destroy
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
destroy(this.pb_9)
destroy(this.st_9)
destroy(this.st_generales)
destroy(this.gb_65)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_8)
destroy(this.pb_19)
destroy(this.st_19)
destroy(this.st_20)
destroy(this.pb_20)
destroy(this.pb_disenyo)
destroy(this.st_disenyo)
destroy(this.st_3)
destroy(this.gb_7)
end on

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_produccion
integer x = 1687
integer y = 732
integer width = 178
integer height = 148
integer taborder = 10
boolean originalsize = false
end type

type pb_u from picturebutton within w_inicio_produccion
event clicked pbm_bnclicked
integer x = 919
integer y = 116
integer width = 178
integer height = 152
integer taborder = 170
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

type st_u from statictext within w_inicio_produccion
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

type pb_4 from picturebutton within w_inicio_produccion
event clicked pbm_bnclicked
integer x = 1664
integer y = 420
integer width = 174
integer height = 152
integer taborder = 60
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

type pb_almacen from picturebutton within w_inicio_produccion
event clicked pbm_bnclicked
integer x = 928
integer y = 424
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

type st_2 from statictext within w_inicio_produccion
integer x = 1893
integer y = 448
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

type pb_2 from picturebutton within w_inicio_produccion
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

type st_1 from statictext within w_inicio_produccion
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

type st_almacenv from statictext within w_inicio_produccion
integer x = 1170
integer y = 452
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

type pb_generales from picturebutton within w_inicio_produccion
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

type pb_9 from picturebutton within w_inicio_produccion
boolean visible = false
integer x = 1463
integer y = 1164
integer width = 183
integer height = 148
integer taborder = 180
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

type st_9 from statictext within w_inicio_produccion
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

type st_generales from statictext within w_inicio_produccion
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

type gb_65 from groupbox within w_inicio_produccion
integer x = 160
integer y = 672
integer width = 736
integer height = 220
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

type gb_6 from groupbox within w_inicio_produccion
integer x = 901
integer y = 364
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

type gb_5 from groupbox within w_inicio_produccion
integer x = 160
integer y = 364
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

type gb_4 from groupbox within w_inicio_produccion
integer x = 901
integer y = 672
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

type gb_3 from groupbox within w_inicio_produccion
integer x = 1646
integer y = 60
integer width = 736
integer height = 220
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

type gb_2 from groupbox within w_inicio_produccion
integer x = 905
integer y = 60
integer width = 736
integer height = 220
integer taborder = 70
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_inicio_produccion
integer x = 165
integer y = 60
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

type gb_8 from groupbox within w_inicio_produccion
integer x = 1650
integer y = 364
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

type pb_19 from picturebutton within w_inicio_produccion
integer x = 928
integer y = 732
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
string picturename = "c:\bmp\fabrica.bmp"
alignment htextalign = left!
end type

event clicked;open (w_produccion)
end event

type st_19 from statictext within w_inicio_produccion
integer x = 1125
integer y = 752
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

type st_20 from statictext within w_inicio_produccion
integer x = 398
integer y = 448
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

type pb_20 from picturebutton within w_inicio_produccion
integer x = 183
integer y = 424
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

type pb_disenyo from picturebutton within w_inicio_produccion
integer x = 233
integer y = 728
integer width = 183
integer height = 160
integer taborder = 50
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

type st_disenyo from statictext within w_inicio_produccion
integer x = 448
integer y = 756
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

type st_3 from statictext within w_inicio_produccion
integer x = 1902
integer y = 752
integer width = 293
integer height = 108
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

type gb_7 from groupbox within w_inicio_produccion
integer x = 1664
integer y = 672
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

