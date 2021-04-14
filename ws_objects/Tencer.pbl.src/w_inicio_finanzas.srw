$PBExportHeader$w_inicio_finanzas.srw
forward
global type w_inicio_finanzas from w_ventana_padre_inicio
end type
type pb_u from picturebutton within w_inicio_finanzas
end type
type st_u from statictext within w_inicio_finanzas
end type
type pb_2 from picturebutton within w_inicio_finanzas
end type
type st_1 from statictext within w_inicio_finanzas
end type
type pb_cartera from picturebutton within w_inicio_finanzas
end type
type st_cartera from statictext within w_inicio_finanzas
end type
type st_contabilidad from statictext within w_inicio_finanzas
end type
type pb_generales from picturebutton within w_inicio_finanzas
end type
type pb_1 from picturebutton within w_inicio_finanzas
end type
type pb_pagos from picturebutton within w_inicio_finanzas
end type
type st_pagos from statictext within w_inicio_finanzas
end type
type pb_9 from picturebutton within w_inicio_finanzas
end type
type st_9 from statictext within w_inicio_finanzas
end type
type st_generales from statictext within w_inicio_finanzas
end type
type pb_10 from picturebutton within w_inicio_finanzas
end type
type st_10 from statictext within w_inicio_finanzas
end type
type gb_321 from groupbox within w_inicio_finanzas
end type
type gb_8 from groupbox within w_inicio_finanzas
end type
type gb_11 from groupbox within w_inicio_finanzas
end type
type gb_10 from groupbox within w_inicio_finanzas
end type
type gb_9 from groupbox within w_inicio_finanzas
end type
type gb_3 from groupbox within w_inicio_finanzas
end type
type gb_2 from groupbox within w_inicio_finanzas
end type
type gb_1 from groupbox within w_inicio_finanzas
end type
type gb_7 from groupbox within w_inicio_finanzas
end type
type pb_4 from picturebutton within w_inicio_finanzas
end type
type st_2 from statictext within w_inicio_finanzas
end type
type pb_almacen from picturebutton within w_inicio_finanzas
end type
type st_almacenv from statictext within w_inicio_finanzas
end type
type st_3 from statictext within w_inicio_finanzas
end type
type gb_4 from groupbox within w_inicio_finanzas
end type
end forward

global type w_inicio_finanzas from w_ventana_padre_inicio
integer width = 2747
integer height = 1424
string title = "Menu Principal"
pb_u pb_u
st_u st_u
pb_2 pb_2
st_1 st_1
pb_cartera pb_cartera
st_cartera st_cartera
st_contabilidad st_contabilidad
pb_generales pb_generales
pb_1 pb_1
pb_pagos pb_pagos
st_pagos st_pagos
pb_9 pb_9
st_9 st_9
st_generales st_generales
pb_10 pb_10
st_10 st_10
gb_321 gb_321
gb_8 gb_8
gb_11 gb_11
gb_10 gb_10
gb_9 gb_9
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
gb_7 gb_7
pb_4 pb_4
st_2 st_2
pb_almacen pb_almacen
st_almacenv st_almacenv
st_3 st_3
gb_4 gb_4
end type
global w_inicio_finanzas w_inicio_finanzas

on w_inicio_finanzas.create
int iCurrent
call super::create
this.pb_u=create pb_u
this.st_u=create st_u
this.pb_2=create pb_2
this.st_1=create st_1
this.pb_cartera=create pb_cartera
this.st_cartera=create st_cartera
this.st_contabilidad=create st_contabilidad
this.pb_generales=create pb_generales
this.pb_1=create pb_1
this.pb_pagos=create pb_pagos
this.st_pagos=create st_pagos
this.pb_9=create pb_9
this.st_9=create st_9
this.st_generales=create st_generales
this.pb_10=create pb_10
this.st_10=create st_10
this.gb_321=create gb_321
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_10=create gb_10
this.gb_9=create gb_9
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_7=create gb_7
this.pb_4=create pb_4
this.st_2=create st_2
this.pb_almacen=create pb_almacen
this.st_almacenv=create st_almacenv
this.st_3=create st_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_u
this.Control[iCurrent+2]=this.st_u
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.pb_cartera
this.Control[iCurrent+6]=this.st_cartera
this.Control[iCurrent+7]=this.st_contabilidad
this.Control[iCurrent+8]=this.pb_generales
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.pb_pagos
this.Control[iCurrent+11]=this.st_pagos
this.Control[iCurrent+12]=this.pb_9
this.Control[iCurrent+13]=this.st_9
this.Control[iCurrent+14]=this.st_generales
this.Control[iCurrent+15]=this.pb_10
this.Control[iCurrent+16]=this.st_10
this.Control[iCurrent+17]=this.gb_321
this.Control[iCurrent+18]=this.gb_8
this.Control[iCurrent+19]=this.gb_11
this.Control[iCurrent+20]=this.gb_10
this.Control[iCurrent+21]=this.gb_9
this.Control[iCurrent+22]=this.gb_3
this.Control[iCurrent+23]=this.gb_2
this.Control[iCurrent+24]=this.gb_1
this.Control[iCurrent+25]=this.gb_7
this.Control[iCurrent+26]=this.pb_4
this.Control[iCurrent+27]=this.st_2
this.Control[iCurrent+28]=this.pb_almacen
this.Control[iCurrent+29]=this.st_almacenv
this.Control[iCurrent+30]=this.st_3
this.Control[iCurrent+31]=this.gb_4
end on

on w_inicio_finanzas.destroy
call super::destroy
destroy(this.pb_u)
destroy(this.st_u)
destroy(this.pb_2)
destroy(this.st_1)
destroy(this.pb_cartera)
destroy(this.st_cartera)
destroy(this.st_contabilidad)
destroy(this.pb_generales)
destroy(this.pb_1)
destroy(this.pb_pagos)
destroy(this.st_pagos)
destroy(this.pb_9)
destroy(this.st_9)
destroy(this.st_generales)
destroy(this.pb_10)
destroy(this.st_10)
destroy(this.gb_321)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_10)
destroy(this.gb_9)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_7)
destroy(this.pb_4)
destroy(this.st_2)
destroy(this.pb_almacen)
destroy(this.st_almacenv)
destroy(this.st_3)
destroy(this.gb_4)
end on

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_finanzas
integer x = 942
integer y = 1016
integer width = 183
integer height = 160
integer taborder = 10
boolean originalsize = false
end type

type pb_u from picturebutton within w_inicio_finanzas
event clicked pbm_bnclicked
integer x = 919
integer y = 116
integer width = 178
integer height = 152
integer taborder = 210
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

type st_u from statictext within w_inicio_finanzas
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

type pb_2 from picturebutton within w_inicio_finanzas
event clicked pbm_bnclicked
integer x = 1659
integer y = 116
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
string picturename = "c:\bmp\tel32am.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_mailing)
end on

type st_1 from statictext within w_inicio_finanzas
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

type pb_cartera from picturebutton within w_inicio_finanzas
event clicked pbm_bnclicked
integer x = 187
integer y = 408
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
string picturename = "c:\bmp\cartera0.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_cartera)
end on

type st_cartera from statictext within w_inicio_finanzas
integer x = 1138
integer y = 428
integer width = 302
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

type st_contabilidad from statictext within w_inicio_finanzas
integer x = 1879
integer y = 428
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

type pb_generales from picturebutton within w_inicio_finanzas
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

type pb_1 from picturebutton within w_inicio_finanzas
event clicked pbm_bnclicked
integer x = 1669
integer y = 408
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

type pb_pagos from picturebutton within w_inicio_finanzas
integer x = 928
integer y = 408
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

event clicked;Open (w_cartera_pagos)
end event

type st_pagos from statictext within w_inicio_finanzas
integer x = 389
integer y = 428
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

type pb_9 from picturebutton within w_inicio_finanzas
boolean visible = false
integer x = 905
integer y = 1220
integer width = 183
integer height = 148
integer taborder = 230
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

type st_9 from statictext within w_inicio_finanzas
boolean visible = false
integer x = 1138
integer y = 1240
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

type st_generales from statictext within w_inicio_finanzas
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

type pb_10 from picturebutton within w_inicio_finanzas
integer x = 928
integer y = 708
integer width = 178
integer height = 152
integer taborder = 240
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

type st_10 from statictext within w_inicio_finanzas
integer x = 1129
integer y = 736
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

type gb_321 from groupbox within w_inicio_finanzas
integer x = 1669
integer y = 648
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

type gb_8 from groupbox within w_inicio_finanzas
integer x = 169
integer y = 652
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

type gb_11 from groupbox within w_inicio_finanzas
integer x = 1655
integer y = 352
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
long backcolor = 12632256
end type

type gb_10 from groupbox within w_inicio_finanzas
integer x = 914
integer y = 352
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
long backcolor = 12632256
end type

type gb_9 from groupbox within w_inicio_finanzas
integer x = 174
integer y = 352
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

type gb_3 from groupbox within w_inicio_finanzas
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
long backcolor = 12632256
end type

type gb_2 from groupbox within w_inicio_finanzas
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
long backcolor = 12632256
end type

type gb_1 from groupbox within w_inicio_finanzas
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

type gb_7 from groupbox within w_inicio_finanzas
integer x = 914
integer y = 652
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

type pb_4 from picturebutton within w_inicio_finanzas
integer x = 183
integer y = 712
integer width = 174
integer height = 152
integer taborder = 220
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

type st_2 from statictext within w_inicio_finanzas
integer x = 393
integer y = 728
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

type pb_almacen from picturebutton within w_inicio_finanzas
integer x = 1687
integer y = 700
integer width = 183
integer height = 160
integer taborder = 140
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

type st_almacenv from statictext within w_inicio_finanzas
integer x = 1897
integer y = 724
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

type st_3 from statictext within w_inicio_finanzas
integer x = 1152
integer y = 1040
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

type gb_4 from groupbox within w_inicio_finanzas
integer x = 923
integer y = 964
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

