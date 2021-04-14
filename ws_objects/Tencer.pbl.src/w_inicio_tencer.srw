$PBExportHeader$w_inicio_tencer.srw
forward
global type w_inicio_tencer from w_ventana_padre_inicio
end type
type gb_2 from groupbox within w_inicio_tencer
end type
type st_8 from statictext within w_inicio_tencer
end type
type pb_8 from picturebutton within w_inicio_tencer
end type
type pb_u from picturebutton within w_inicio_tencer
end type
type st_u from statictext within w_inicio_tencer
end type
type pb_4 from picturebutton within w_inicio_tencer
end type
type pb_almacen from picturebutton within w_inicio_tencer
end type
type st_2 from statictext within w_inicio_tencer
end type
type pb_2 from picturebutton within w_inicio_tencer
end type
type st_1 from statictext within w_inicio_tencer
end type
type pb_cartera from picturebutton within w_inicio_tencer
end type
type st_cartera from statictext within w_inicio_tencer
end type
type st_contabilidad from statictext within w_inicio_tencer
end type
type st_almacenv from statictext within w_inicio_tencer
end type
type pb_generales from picturebutton within w_inicio_tencer
end type
type pb_1 from picturebutton within w_inicio_tencer
end type
type pb_d from picturebutton within w_inicio_tencer
end type
type st_d from statictext within w_inicio_tencer
end type
type pb_pagos from picturebutton within w_inicio_tencer
end type
type st_pagos from statictext within w_inicio_tencer
end type
type st_generales from statictext within w_inicio_tencer
end type
type pb_10 from picturebutton within w_inicio_tencer
end type
type st_10 from statictext within w_inicio_tencer
end type
type gb_14 from groupbox within w_inicio_tencer
end type
type pb_19 from picturebutton within w_inicio_tencer
end type
type st_19 from statictext within w_inicio_tencer
end type
type st_20 from statictext within w_inicio_tencer
end type
type pb_20 from picturebutton within w_inicio_tencer
end type
type pb_disenyo from picturebutton within w_inicio_tencer
end type
type st_disenyo from statictext within w_inicio_tencer
end type
type tv_menu from treeview within w_inicio_tencer
end type
type st_titulo from statictext within w_inicio_tencer
end type
type st_3 from statictext within w_inicio_tencer
end type
type gb_13 from groupbox within w_inicio_tencer
end type
type gb_5 from groupbox within w_inicio_tencer
end type
type gb_4 from groupbox within w_inicio_tencer
end type
type gb_1 from groupbox within w_inicio_tencer
end type
end forward

global type w_inicio_tencer from w_ventana_padre_inicio
integer width = 3963
integer height = 1096
string title = "Menu Principal"
string menuname = "mc_aplicaciones_desarrollo"
boolean resizable = true
gb_2 gb_2
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
gb_14 gb_14
pb_19 pb_19
st_19 st_19
st_20 st_20
pb_20 pb_20
pb_disenyo pb_disenyo
st_disenyo st_disenyo
tv_menu tv_menu
st_titulo st_titulo
st_3 st_3
gb_13 gb_13
gb_5 gb_5
gb_4 gb_4
gb_1 gb_1
end type
global w_inicio_tencer w_inicio_tencer

forward prototypes
public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso)
end prototypes

public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso);
end subroutine

on w_inicio_tencer.create
int iCurrent
call super::create
if this.MenuName = "mc_aplicaciones_desarrollo" then this.MenuID = create mc_aplicaciones_desarrollo
this.gb_2=create gb_2
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
this.gb_14=create gb_14
this.pb_19=create pb_19
this.st_19=create st_19
this.st_20=create st_20
this.pb_20=create pb_20
this.pb_disenyo=create pb_disenyo
this.st_disenyo=create st_disenyo
this.tv_menu=create tv_menu
this.st_titulo=create st_titulo
this.st_3=create st_3
this.gb_13=create gb_13
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.st_8
this.Control[iCurrent+3]=this.pb_8
this.Control[iCurrent+4]=this.pb_u
this.Control[iCurrent+5]=this.st_u
this.Control[iCurrent+6]=this.pb_4
this.Control[iCurrent+7]=this.pb_almacen
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.pb_2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.pb_cartera
this.Control[iCurrent+12]=this.st_cartera
this.Control[iCurrent+13]=this.st_contabilidad
this.Control[iCurrent+14]=this.st_almacenv
this.Control[iCurrent+15]=this.pb_generales
this.Control[iCurrent+16]=this.pb_1
this.Control[iCurrent+17]=this.pb_d
this.Control[iCurrent+18]=this.st_d
this.Control[iCurrent+19]=this.pb_pagos
this.Control[iCurrent+20]=this.st_pagos
this.Control[iCurrent+21]=this.st_generales
this.Control[iCurrent+22]=this.pb_10
this.Control[iCurrent+23]=this.st_10
this.Control[iCurrent+24]=this.gb_14
this.Control[iCurrent+25]=this.pb_19
this.Control[iCurrent+26]=this.st_19
this.Control[iCurrent+27]=this.st_20
this.Control[iCurrent+28]=this.pb_20
this.Control[iCurrent+29]=this.pb_disenyo
this.Control[iCurrent+30]=this.st_disenyo
this.Control[iCurrent+31]=this.tv_menu
this.Control[iCurrent+32]=this.st_titulo
this.Control[iCurrent+33]=this.st_3
this.Control[iCurrent+34]=this.gb_13
this.Control[iCurrent+35]=this.gb_5
this.Control[iCurrent+36]=this.gb_4
this.Control[iCurrent+37]=this.gb_1
end on

on w_inicio_tencer.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
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
destroy(this.gb_14)
destroy(this.pb_19)
destroy(this.st_19)
destroy(this.st_20)
destroy(this.pb_20)
destroy(this.pb_disenyo)
destroy(this.st_disenyo)
destroy(this.tv_menu)
destroy(this.st_titulo)
destroy(this.st_3)
destroy(this.gb_13)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_1)
end on

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_tencer
integer x = 2990
integer y = 544
integer width = 174
integer height = 152
integer taborder = 10
boolean originalsize = false
end type

type gb_2 from groupbox within w_inicio_tencer
integer x = 2953
integer y = 156
integer width = 690
integer height = 384
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

type st_8 from statictext within w_inicio_tencer
integer x = 1056
integer y = 416
integer width = 425
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Promoción"
boolean focusrectangle = false
end type

type pb_8 from picturebutton within w_inicio_tencer
event clicked pbm_bnclicked
integer x = 841
integer y = 384
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

type pb_u from picturebutton within w_inicio_tencer
event clicked pbm_bnclicked
integer x = 128
integer y = 384
integer width = 174
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

event clicked;IF f_pedir_clave("1") THEN 
	Open (w_utilidad)
end if





end event

type st_u from statictext within w_inicio_tencer
integer x = 329
integer y = 416
integer width = 411
integer height = 104
boolean bringtotop = true
integer textsize = -13
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

type pb_4 from picturebutton within w_inicio_tencer
event clicked pbm_bnclicked
integer x = 841
integer y = 544
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

type pb_almacen from picturebutton within w_inicio_tencer
event clicked pbm_bnclicked
integer x = 2267
integer y = 544
integer width = 174
integer height = 152
integer taborder = 40
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

type st_2 from statictext within w_inicio_tencer
integer x = 1056
integer y = 568
integer width = 297
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Ventas"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_inicio_tencer
event clicked pbm_bnclicked
integer x = 128
integer y = 544
integer width = 174
integer height = 152
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\tel32am.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_mailing)
end on

type st_1 from statictext within w_inicio_tencer
integer x = 329
integer y = 568
integer width = 393
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Mailing"
boolean focusrectangle = false
end type

type pb_cartera from picturebutton within w_inicio_tencer
event clicked pbm_bnclicked
integer x = 1554
integer y = 224
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
string picturename = "c:\bmp\cartera0.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_cartera)
end on

type st_cartera from statictext within w_inicio_tencer
integer x = 1760
integer y = 416
integer width = 297
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pagos"
boolean focusrectangle = false
end type

type st_contabilidad from statictext within w_inicio_tencer
integer x = 1760
integer y = 568
integer width = 425
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Contabilidad"
boolean focusrectangle = false
end type

type st_almacenv from statictext within w_inicio_tencer
integer x = 2469
integer y = 568
integer width = 320
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Almacén "
boolean focusrectangle = false
end type

type pb_generales from picturebutton within w_inicio_tencer
event clicked pbm_bnclicked
integer x = 128
integer y = 224
integer width = 174
integer height = 152
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\general.bmp"
alignment htextalign = left!
end type

event clicked;Open (w_general)






end event

type pb_1 from picturebutton within w_inicio_tencer
event clicked pbm_bnclicked
integer x = 1554
integer y = 544
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
string picturename = "c:\bmp\conta.bmp"
alignment htextalign = left!
end type

on clicked;Open (w_conta)
end on

type pb_d from picturebutton within w_inicio_tencer
event clicked pbm_bnclicked
integer x = 841
integer y = 224
integer width = 174
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

type st_d from statictext within w_inicio_tencer
integer x = 1056
integer y = 264
integer width = 407
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Depósitos"
boolean focusrectangle = false
end type

type pb_pagos from picturebutton within w_inicio_tencer
integer x = 1554
integer y = 384
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
string picturename = "c:\bmp\cartera0.bmp"
alignment htextalign = left!
end type

event clicked;Open (w_cartera_pagos)
end event

type st_pagos from statictext within w_inicio_tencer
integer x = 1760
integer y = 264
integer width = 315
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cartera"
boolean focusrectangle = false
end type

type st_generales from statictext within w_inicio_tencer
integer x = 329
integer y = 264
integer width = 421
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Generales"
boolean focusrectangle = false
end type

type pb_10 from picturebutton within w_inicio_tencer
integer x = 2263
integer y = 224
integer width = 174
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

type st_10 from statictext within w_inicio_tencer
integer x = 2469
integer y = 264
integer width = 384
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Compras"
boolean focusrectangle = false
end type

type gb_14 from groupbox within w_inicio_tencer
integer x = 96
integer y = 156
integer width = 690
integer height = 560
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

type pb_19 from picturebutton within w_inicio_tencer
integer x = 2267
integer y = 384
integer width = 174
integer height = 152
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

type st_19 from statictext within w_inicio_tencer
integer x = 2469
integer y = 416
integer width = 393
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Producción"
boolean focusrectangle = false
end type

type st_20 from statictext within w_inicio_tencer
integer x = 3200
integer y = 264
integer width = 407
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Laboratorio"
boolean focusrectangle = false
end type

type pb_20 from picturebutton within w_inicio_tencer
integer x = 2990
integer y = 224
integer width = 174
integer height = 152
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

type pb_disenyo from picturebutton within w_inicio_tencer
integer x = 2990
integer y = 384
integer width = 174
integer height = 152
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

type st_disenyo from statictext within w_inicio_tencer
integer x = 3200
integer y = 416
integer width = 242
integer height = 104
boolean bringtotop = true
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "I+D "
boolean focusrectangle = false
end type

type tv_menu from treeview within w_inicio_tencer
boolean visible = false
integer x = 1152
integer y = 240
integer width = 1998
integer height = 2520
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = styleshadowbox!
string picturename[] = {"C:\Bmp\bola_roja.gif","C:\Bmp\bola_amarilla.gif","C:\Bmp\bola_verde.gif","C:\Bmp\CARPETA1.BMP","C:\Bmp\CARPETA2.BMP"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
end type

event doubleclicked;Menu v_menu
TreeViewItem nodo
int i1,i2,i3,i4,i5, nivel[]

//Open (w_general)

v_menu = w_inicio_tencer.MenuID
//v_menu = mc_aplicaciones_desarrollo

tv_menu.GetItem(handle, nodo )

nivel[] = nodo.data

choose case UpperBound(nivel)
	case 1
		v_menu.item[nivel[1]].TriggerEvent (clicked!)
	case 2
		v_menu.item[nivel[1]].item[nivel[2]].TriggerEvent (clicked!)
	case 3
		v_menu.item[nivel[1]].item[nivel[2]].item[nivel[3]].TriggerEvent (clicked!)
	case 4
		v_menu.item[nivel[1]].item[nivel[2]].item[nivel[3]].item[nivel[4]].TriggerEvent (clicked!)
	case 5
		v_menu.item[nivel[1]].item[nivel[2]].item[nivel[3]].item[nivel[4]].item[nivel[5]].TriggerEvent (clicked!)
end choose
end event

event rightclicked;//TreeviewItem nodo
//str_nodo_menu str_nodo
//
//tv_menu.GetItem (handle, nodo)
//str_nodo = nodo.data
//
//if str_nodo.permiso <> 1 then
//	f_abrir_ventana(str_nodo.programa, str_nodo.permiso)
//end if
//
////this.event key(keyenter!, 0)

end event

event key;//string programa
//
//if key = keyenter! then
//	
////	f_abrir_ventana (tv_tencer.data.programa, tv_tencer.data.permiso)
//
//	programa = 'w_mant_articulos_tencer'
//	
//	open (w_ventana_general)
//	
//	CHOOSE CASE programa
//	
//	CASE 'w_mant_articulos_tencer'
//		str_parametros lstr_param
//		OpenSheetWithParm(w_mant_articulos_tencer, lstr_param, w_ventana_general, 3, original!)
//	
//	CASE ELSE
//			messagebox("Aviso",'No está dada de alta la ventana: "w_mant_articulos_tencer"')
//	
//	END CHOOSE
//end if



end event

event itemexpanded;treeviewitem nodo
str_nodo_menu str_nodo

this.GetItem(handle, nodo)
str_nodo = nodo.data

if str_nodo.permiso = 1 then
	this.CollapseItem(handle)
end if



end event

type st_titulo from statictext within w_inicio_tencer
boolean visible = false
integer x = 1152
integer y = 120
integer width = 1998
integer height = 104
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_3 from statictext within w_inicio_tencer
integer x = 3200
integer y = 568
integer width = 210
integer height = 104
boolean bringtotop = true
integer textsize = -13
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

type gb_13 from groupbox within w_inicio_tencer
integer x = 2953
integer y = 480
integer width = 690
integer height = 236
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

type gb_5 from groupbox within w_inicio_tencer
integer x = 1522
integer y = 156
integer width = 690
integer height = 560
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

type gb_4 from groupbox within w_inicio_tencer
integer x = 809
integer y = 156
integer width = 690
integer height = 560
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

type gb_1 from groupbox within w_inicio_tencer
integer x = 2235
integer y = 156
integer width = 690
integer height = 560
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

