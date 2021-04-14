$PBExportHeader$w_inicio_desarrollo.srw
forward
global type w_inicio_desarrollo from w_ventana_padre_inicio
end type
type st_8 from statictext within w_inicio_desarrollo
end type
type pb_8 from picturebutton within w_inicio_desarrollo
end type
type pb_u from picturebutton within w_inicio_desarrollo
end type
type st_u from statictext within w_inicio_desarrollo
end type
type pb_4 from picturebutton within w_inicio_desarrollo
end type
type pb_almacen from picturebutton within w_inicio_desarrollo
end type
type st_2 from statictext within w_inicio_desarrollo
end type
type pb_2 from picturebutton within w_inicio_desarrollo
end type
type st_1 from statictext within w_inicio_desarrollo
end type
type pb_cartera from picturebutton within w_inicio_desarrollo
end type
type st_cartera from statictext within w_inicio_desarrollo
end type
type st_contabilidad from statictext within w_inicio_desarrollo
end type
type st_almacenv from statictext within w_inicio_desarrollo
end type
type pb_generales from picturebutton within w_inicio_desarrollo
end type
type pb_1 from picturebutton within w_inicio_desarrollo
end type
type pb_d from picturebutton within w_inicio_desarrollo
end type
type st_d from statictext within w_inicio_desarrollo
end type
type pb_pagos from picturebutton within w_inicio_desarrollo
end type
type st_pagos from statictext within w_inicio_desarrollo
end type
type st_generales from statictext within w_inicio_desarrollo
end type
type pb_10 from picturebutton within w_inicio_desarrollo
end type
type st_10 from statictext within w_inicio_desarrollo
end type
type gb_21 from groupbox within w_inicio_desarrollo
end type
type gb_11 from groupbox within w_inicio_desarrollo
end type
type gb_10 from groupbox within w_inicio_desarrollo
end type
type gb_9 from groupbox within w_inicio_desarrollo
end type
type gb_6 from groupbox within w_inicio_desarrollo
end type
type gb_5 from groupbox within w_inicio_desarrollo
end type
type gb_4 from groupbox within w_inicio_desarrollo
end type
type gb_3 from groupbox within w_inicio_desarrollo
end type
type gb_2 from groupbox within w_inicio_desarrollo
end type
type gb_1 from groupbox within w_inicio_desarrollo
end type
type gb_7 from groupbox within w_inicio_desarrollo
end type
type gb_8 from groupbox within w_inicio_desarrollo
end type
type gb_14 from groupbox within w_inicio_desarrollo
end type
type pb_19 from picturebutton within w_inicio_desarrollo
end type
type st_19 from statictext within w_inicio_desarrollo
end type
type gb_20 from groupbox within w_inicio_desarrollo
end type
type gb_12 from groupbox within w_inicio_desarrollo
end type
type gb_17 from groupbox within w_inicio_desarrollo
end type
type st_20 from statictext within w_inicio_desarrollo
end type
type pb_20 from picturebutton within w_inicio_desarrollo
end type
type pb_disenyo from picturebutton within w_inicio_desarrollo
end type
type st_disenyo from statictext within w_inicio_desarrollo
end type
type gb_44 from groupbox within w_inicio_desarrollo
end type
type gb_13 from groupbox within w_inicio_desarrollo
end type
end forward

global type w_inicio_desarrollo from w_ventana_padre_inicio
integer height = 1768
string title = "Menu Principal"
string menuname = "mc_aplicaciones_desarrollo"
st_8 st_8
pb_8 pb_8
pb_u pb_u
st_u st_u
pb_4 pb_4
pb_almacen pb_almacen
st_2 st_2
pb_2 pb_2
st_1 st_1
pb_cartera pb_cartera
st_cartera st_cartera
st_contabilidad st_contabilidad
st_almacenv st_almacenv
pb_generales pb_generales
pb_1 pb_1
pb_d pb_d
st_d st_d
pb_pagos pb_pagos
st_pagos st_pagos
st_generales st_generales
pb_10 pb_10
st_10 st_10
gb_21 gb_21
gb_11 gb_11
gb_10 gb_10
gb_9 gb_9
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
gb_7 gb_7
gb_8 gb_8
gb_14 gb_14
pb_19 pb_19
st_19 st_19
gb_20 gb_20
gb_12 gb_12
gb_17 gb_17
st_20 st_20
pb_20 pb_20
pb_disenyo pb_disenyo
st_disenyo st_disenyo
gb_44 gb_44
gb_13 gb_13
end type
global w_inicio_desarrollo w_inicio_desarrollo

on w_inicio_desarrollo.create
int iCurrent
call super::create
if this.MenuName = "mc_aplicaciones_desarrollo" then this.MenuID = create mc_aplicaciones_desarrollo
this.st_8=create st_8
this.pb_8=create pb_8
this.pb_u=create pb_u
this.st_u=create st_u
this.pb_4=create pb_4
this.pb_almacen=create pb_almacen
this.st_2=create st_2
this.pb_2=create pb_2
this.st_1=create st_1
this.pb_cartera=create pb_cartera
this.st_cartera=create st_cartera
this.st_contabilidad=create st_contabilidad
this.st_almacenv=create st_almacenv
this.pb_generales=create pb_generales
this.pb_1=create pb_1
this.pb_d=create pb_d
this.st_d=create st_d
this.pb_pagos=create pb_pagos
this.st_pagos=create st_pagos
this.st_generales=create st_generales
this.pb_10=create pb_10
this.st_10=create st_10
this.gb_21=create gb_21
this.gb_11=create gb_11
this.gb_10=create gb_10
this.gb_9=create gb_9
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_7=create gb_7
this.gb_8=create gb_8
this.gb_14=create gb_14
this.pb_19=create pb_19
this.st_19=create st_19
this.gb_20=create gb_20
this.gb_12=create gb_12
this.gb_17=create gb_17
this.st_20=create st_20
this.pb_20=create pb_20
this.pb_disenyo=create pb_disenyo
this.st_disenyo=create st_disenyo
this.gb_44=create gb_44
this.gb_13=create gb_13
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_8
this.Control[iCurrent+2]=this.pb_8
this.Control[iCurrent+3]=this.pb_u
this.Control[iCurrent+4]=this.st_u
this.Control[iCurrent+5]=this.pb_4
this.Control[iCurrent+6]=this.pb_almacen
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.pb_cartera
this.Control[iCurrent+11]=this.st_cartera
this.Control[iCurrent+12]=this.st_contabilidad
this.Control[iCurrent+13]=this.st_almacenv
this.Control[iCurrent+14]=this.pb_generales
this.Control[iCurrent+15]=this.pb_1
this.Control[iCurrent+16]=this.pb_d
this.Control[iCurrent+17]=this.st_d
this.Control[iCurrent+18]=this.pb_pagos
this.Control[iCurrent+19]=this.st_pagos
this.Control[iCurrent+20]=this.st_generales
this.Control[iCurrent+21]=this.pb_10
this.Control[iCurrent+22]=this.st_10
this.Control[iCurrent+23]=this.gb_21
this.Control[iCurrent+24]=this.gb_11
this.Control[iCurrent+25]=this.gb_10
this.Control[iCurrent+26]=this.gb_9
this.Control[iCurrent+27]=this.gb_6
this.Control[iCurrent+28]=this.gb_5
this.Control[iCurrent+29]=this.gb_4
this.Control[iCurrent+30]=this.gb_3
this.Control[iCurrent+31]=this.gb_2
this.Control[iCurrent+32]=this.gb_1
this.Control[iCurrent+33]=this.gb_7
this.Control[iCurrent+34]=this.gb_8
this.Control[iCurrent+35]=this.gb_14
this.Control[iCurrent+36]=this.pb_19
this.Control[iCurrent+37]=this.st_19
this.Control[iCurrent+38]=this.gb_20
this.Control[iCurrent+39]=this.gb_12
this.Control[iCurrent+40]=this.gb_17
this.Control[iCurrent+41]=this.st_20
this.Control[iCurrent+42]=this.pb_20
this.Control[iCurrent+43]=this.pb_disenyo
this.Control[iCurrent+44]=this.st_disenyo
this.Control[iCurrent+45]=this.gb_44
this.Control[iCurrent+46]=this.gb_13
end on

on w_inicio_desarrollo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_8)
destroy(this.pb_8)
destroy(this.pb_u)
destroy(this.st_u)
destroy(this.pb_4)
destroy(this.pb_almacen)
destroy(this.st_2)
destroy(this.pb_2)
destroy(this.st_1)
destroy(this.pb_cartera)
destroy(this.st_cartera)
destroy(this.st_contabilidad)
destroy(this.st_almacenv)
destroy(this.pb_generales)
destroy(this.pb_1)
destroy(this.pb_d)
destroy(this.st_d)
destroy(this.pb_pagos)
destroy(this.st_pagos)
destroy(this.st_generales)
destroy(this.pb_10)
destroy(this.st_10)
destroy(this.gb_21)
destroy(this.gb_11)
destroy(this.gb_10)
destroy(this.gb_9)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.gb_14)
destroy(this.pb_19)
destroy(this.st_19)
destroy(this.gb_20)
destroy(this.gb_12)
destroy(this.gb_17)
destroy(this.st_20)
destroy(this.pb_20)
destroy(this.pb_disenyo)
destroy(this.st_disenyo)
destroy(this.gb_44)
destroy(this.gb_13)
end on

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_desarrollo
integer x = 2523
integer y = 4
integer taborder = 10
end type

type st_8 from statictext within w_inicio_desarrollo
integer x = 1125
integer y = 472
integer width = 425
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Promoción"
boolean focusrectangle = false
end type

type pb_8 from picturebutton within w_inicio_desarrollo
event clicked pbm_bnclicked
integer x = 914
integer y = 456
integer width = 174
integer height = 152
integer taborder = 280
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\beach.bmp"
alignment htextalign = left!
end type

on clicked;open (w_promocion)
end on

type pb_u from picturebutton within w_inicio_desarrollo
event clicked pbm_bnclicked
integer x = 919
integer y = 116
integer width = 178
integer height = 152
integer taborder = 290
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

type st_u from statictext within w_inicio_desarrollo
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

type pb_4 from picturebutton within w_inicio_desarrollo
event clicked pbm_bnclicked
integer x = 1664
integer y = 456
integer width = 174
integer height = 152
integer taborder = 80
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

type pb_almacen from picturebutton within w_inicio_desarrollo
event clicked pbm_bnclicked
integer x = 923
integer y = 784
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
string picturename = "c:\bmp\almacenv.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_almacenv)
end on

type st_2 from statictext within w_inicio_desarrollo
integer x = 1874
integer y = 476
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

type pb_2 from picturebutton within w_inicio_desarrollo
event clicked pbm_bnclicked
integer x = 1659
integer y = 116
integer width = 183
integer height = 160
integer taborder = 70
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

type st_1 from statictext within w_inicio_desarrollo
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

type pb_cartera from picturebutton within w_inicio_desarrollo
event clicked pbm_bnclicked
integer x = 178
integer y = 1140
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
string picturename = "c:\bmp\cartera0.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_cartera)
end on

type st_cartera from statictext within w_inicio_desarrollo
integer x = 1129
integer y = 1160
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
string text = "Pagos"
boolean focusrectangle = false
end type

type st_contabilidad from statictext within w_inicio_desarrollo
integer x = 1870
integer y = 1160
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
string text = "Contabilidad"
boolean focusrectangle = false
end type

type st_almacenv from statictext within w_inicio_desarrollo
integer x = 1134
integer y = 808
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

type pb_generales from picturebutton within w_inicio_desarrollo
event clicked pbm_bnclicked
integer x = 178
integer y = 116
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
string picturename = "c:\bmp\general.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_general)
end on

type pb_1 from picturebutton within w_inicio_desarrollo
event clicked pbm_bnclicked
integer x = 1659
integer y = 1140
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
string picturename = "c:\bmp\conta.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_conta)
end on

type pb_d from picturebutton within w_inicio_desarrollo
event clicked pbm_bnclicked
integer x = 174
integer y = 456
integer width = 178
integer height = 152
integer taborder = 270
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

type st_d from statictext within w_inicio_desarrollo
integer x = 384
integer y = 472
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

type pb_pagos from picturebutton within w_inicio_desarrollo
integer x = 919
integer y = 1140
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
string picturename = "c:\bmp\cartera0.bmp"
alignment htextalign = left!
end type

event clicked;Open (w_cartera_pagos)
end event

type st_pagos from statictext within w_inicio_desarrollo
integer x = 379
integer y = 1160
integer width = 315
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
string text = "Cartera"
boolean focusrectangle = false
end type

type st_generales from statictext within w_inicio_desarrollo
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

type pb_10 from picturebutton within w_inicio_desarrollo
integer x = 1659
integer y = 1332
integer width = 178
integer height = 152
integer taborder = 320
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

type st_10 from statictext within w_inicio_desarrollo
integer x = 1861
integer y = 1360
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

type gb_21 from groupbox within w_inicio_desarrollo
integer x = 1659
integer y = 732
integer width = 736
integer height = 220
integer taborder = 200
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_11 from groupbox within w_inicio_desarrollo
integer x = 1646
integer y = 1084
integer width = 736
integer height = 220
integer taborder = 250
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_10 from groupbox within w_inicio_desarrollo
integer x = 905
integer y = 1084
integer width = 736
integer height = 220
integer taborder = 240
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_9 from groupbox within w_inicio_desarrollo
integer x = 169
integer y = 1080
integer width = 736
integer height = 220
integer taborder = 230
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_6 from groupbox within w_inicio_desarrollo
integer x = 901
integer y = 400
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
long backcolor = 67108864
end type

type gb_5 from groupbox within w_inicio_desarrollo
integer x = 160
integer y = 400
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
long backcolor = 67108864
end type

type gb_4 from groupbox within w_inicio_desarrollo
integer x = 910
integer y = 732
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
long backcolor = 67108864
end type

type gb_3 from groupbox within w_inicio_desarrollo
integer x = 1646
integer y = 60
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
long backcolor = 67108864
end type

type gb_2 from groupbox within w_inicio_desarrollo
integer x = 905
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
long backcolor = 67108864
end type

type gb_1 from groupbox within w_inicio_desarrollo
integer x = 165
integer y = 60
integer width = 736
integer height = 220
integer taborder = 190
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_7 from groupbox within w_inicio_desarrollo
integer x = 1646
integer y = 1276
integer width = 736
integer height = 220
integer taborder = 220
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_8 from groupbox within w_inicio_desarrollo
integer x = 1650
integer y = 400
integer width = 736
integer height = 220
integer taborder = 260
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_14 from groupbox within w_inicio_desarrollo
integer x = 114
integer y = 8
integer width = 2322
integer height = 328
integer taborder = 160
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type pb_19 from picturebutton within w_inicio_desarrollo
integer x = 160
integer y = 792
integer width = 178
integer height = 148
integer taborder = 350
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

type st_19 from statictext within w_inicio_desarrollo
integer x = 384
integer y = 812
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

type gb_20 from groupbox within w_inicio_desarrollo
integer x = 146
integer y = 732
integer width = 736
integer height = 220
integer taborder = 210
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_12 from groupbox within w_inicio_desarrollo
integer x = 114
integer y = 344
integer width = 2322
integer height = 328
integer taborder = 120
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_17 from groupbox within w_inicio_desarrollo
integer x = 119
integer y = 676
integer width = 2322
integer height = 328
integer taborder = 150
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_20 from statictext within w_inicio_desarrollo
integer x = 1897
integer y = 812
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

type pb_20 from picturebutton within w_inicio_desarrollo
integer x = 1673
integer y = 792
integer width = 178
integer height = 148
integer taborder = 360
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

type pb_disenyo from picturebutton within w_inicio_desarrollo
integer x = 183
integer y = 1344
integer width = 174
integer height = 140
integer taborder = 300
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\uti.bmp"
alignment htextalign = left!
end type

event clicked;open(w_disenyo)
end event

type st_disenyo from statictext within w_inicio_desarrollo
integer x = 393
integer y = 1364
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

type gb_44 from groupbox within w_inicio_desarrollo
integer x = 165
integer y = 1280
integer width = 736
integer height = 212
integer taborder = 190
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_13 from groupbox within w_inicio_desarrollo
integer x = 110
integer y = 1028
integer width = 2322
integer height = 504
integer taborder = 130
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

