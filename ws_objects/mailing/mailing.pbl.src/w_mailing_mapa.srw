$PBExportHeader$w_mailing_mapa.srw
forward
global type w_mailing_mapa from window
end type
type cb_10 from commandbutton within w_mailing_mapa
end type
type cb_9 from commandbutton within w_mailing_mapa
end type
type sle_2 from statictext within w_mailing_mapa
end type
type sle_1 from statictext within w_mailing_mapa
end type
type cb_8 from u_boton within w_mailing_mapa
end type
type sle_3 from singlelineedit within w_mailing_mapa
end type
type pb_3 from picturebutton within w_mailing_mapa
end type
type cb_7 from u_boton within w_mailing_mapa
end type
type cb_6 from u_boton within w_mailing_mapa
end type
type pb_2 from picturebutton within w_mailing_mapa
end type
type cb_5 from u_boton within w_mailing_mapa
end type
type cb_4 from u_boton within w_mailing_mapa
end type
type cb_3 from u_boton within w_mailing_mapa
end type
type cb_2 from u_boton within w_mailing_mapa
end type
type cb_1 from u_boton within w_mailing_mapa
end type
type st_1 from statictext within w_mailing_mapa
end type
type pb_1 from picturebutton within w_mailing_mapa
end type
type gb_2 from groupbox within w_mailing_mapa
end type
type gb_1 from groupbox within w_mailing_mapa
end type
type ln_1 from line within w_mailing_mapa
end type
type ln_2 from line within w_mailing_mapa
end type
type ln_3 from line within w_mailing_mapa
end type
type ln_4 from line within w_mailing_mapa
end type
type ln_5 from line within w_mailing_mapa
end type
type ln_6 from line within w_mailing_mapa
end type
type ln_11 from line within w_mailing_mapa
end type
type ln_12 from line within w_mailing_mapa
end type
type ln_14 from line within w_mailing_mapa
end type
type ln_15 from line within w_mailing_mapa
end type
type ln_31 from line within w_mailing_mapa
end type
end forward

global type w_mailing_mapa from window
integer width = 2834
integer height = 1512
boolean titlebar = true
string title = "Gestión Mailing"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 12632256
boolean center = true
cb_10 cb_10
cb_9 cb_9
sle_2 sle_2
sle_1 sle_1
cb_8 cb_8
sle_3 sle_3
pb_3 pb_3
cb_7 cb_7
cb_6 cb_6
pb_2 pb_2
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_1 st_1
pb_1 pb_1
gb_2 gb_2
gb_1 gb_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
ln_6 ln_6
ln_11 ln_11
ln_12 ln_12
ln_14 ln_14
ln_15 ln_15
ln_31 ln_31
end type
global w_mailing_mapa w_mailing_mapa

type variables
Long id_ventana_activa
end variables

on w_mailing_mapa.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.cb_10=create cb_10
this.cb_9=create cb_9
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_8=create cb_8
this.sle_3=create sle_3
this.pb_3=create pb_3
this.cb_7=create cb_7
this.cb_6=create cb_6
this.pb_2=create pb_2
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.pb_1=create pb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_6=create ln_6
this.ln_11=create ln_11
this.ln_12=create ln_12
this.ln_14=create ln_14
this.ln_15=create ln_15
this.ln_31=create ln_31
this.Control[]={this.cb_10,&
this.cb_9,&
this.sle_2,&
this.sle_1,&
this.cb_8,&
this.sle_3,&
this.pb_3,&
this.cb_7,&
this.cb_6,&
this.pb_2,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.pb_1,&
this.gb_2,&
this.gb_1,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.ln_5,&
this.ln_6,&
this.ln_11,&
this.ln_12,&
this.ln_14,&
this.ln_15,&
this.ln_31}
end on

on w_mailing_mapa.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_8)
destroy(this.sle_3)
destroy(this.pb_3)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.pb_2)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_6)
destroy(this.ln_11)
destroy(this.ln_12)
destroy(this.ln_14)
destroy(this.ln_15)
destroy(this.ln_31)
end on

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

end event

event close;f_menu_cerrar_ventana(this, id_ventana_activa)
end event

type cb_10 from commandbutton within w_mailing_mapa
integer x = 2245
integer y = 1084
integer width = 320
integer height = 76
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clientes"
end type

event clicked;str_parametros lstr_param
OpenWithParm(w_int_etiquetas_clientes, lstr_param)
end event

type cb_9 from commandbutton within w_mailing_mapa
integer x = 2245
integer y = 1160
integer width = 320
integer height = 76
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Provincias"
end type

event clicked;str_parametros lstr_param
OpenWithParm(w_int_etiquetas_clientes_provincias, lstr_param)
end event

type sle_2 from statictext within w_mailing_mapa
integer x = 1829
integer y = 288
integer width = 773
integer height = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Emisión etiquetas cartas"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type sle_1 from statictext within w_mailing_mapa
integer x = 73
integer y = 288
integer width = 773
integer height = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Recepción de llamadas"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_8 from u_boton within w_mailing_mapa
integer x = 997
integer y = 1136
integer width = 695
integer height = 92
integer taborder = 130
string text = "Llamadas Por Provincias"
end type

event clicked;call super::clicked;str_parametros lstr_param
OpenWithParm(w_list_llamadas, lstr_param)
end event

type sle_3 from singlelineedit within w_mailing_mapa
integer x = 2245
integer y = 696
integer width = 320
integer height = 76
integer taborder = 150
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Contactos"
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type pb_3 from picturebutton within w_mailing_mapa
integer x = 2245
integer y = 800
integer width = 329
integer height = 288
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\impresra.bmp"
end type

event clicked;str_parametros lstr_param
OpenWithParm(w_int_etiquetas_clientes, lstr_param)
end event

type cb_7 from u_boton within w_mailing_mapa
integer x = 1079
integer y = 1036
integer width = 521
integer height = 92
integer taborder = 110
string text = "Llamadas"
end type

event clicked;call super::clicked;str_parametros lstr_param
OpenWithParm(w_con_llamadas, lstr_param)
end event

type cb_6 from u_boton within w_mailing_mapa
integer x = 1079
integer y = 940
integer width = 517
integer height = 92
integer taborder = 90
string text = "Distribuidores"
end type

event clicked;call super::clicked;str_parametros lstr_param
OpenWithParm(w_con_distribuidores, lstr_param)
end event

type pb_2 from picturebutton within w_mailing_mapa
integer x = 2245
integer y = 416
integer width = 329
integer height = 288
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\impresra.bmp"
end type

event clicked;str_parametros lstr_param
OpenWithParm(w_int_etiquetas_contactos, lstr_param)
end event

type cb_5 from u_boton within w_mailing_mapa
integer x = 1070
integer y = 712
integer width = 517
integer height = 92
integer taborder = 80
string text = "Revistas"
end type

event clicked;call super::clicked;str_parametros lstr_param
OpenWithParm(wi_mant_revistas, lstr_param)
end event

type cb_4 from u_boton within w_mailing_mapa
integer x = 1070
integer y = 604
integer width = 517
integer height = 92
integer taborder = 30
string text = "Contactos"
end type

event clicked;call super::clicked;str_parametros lstr_param
OpenWithParm(wi_mant_contactos, lstr_param)
end event

type cb_3 from u_boton within w_mailing_mapa
integer x = 1070
integer y = 496
integer width = 517
integer height = 92
integer taborder = 70
string text = "Tipos de llamadas"
end type

event clicked;call super::clicked;str_parametros lstr_param
OpenWithParm(wi_mant_tipollamada, lstr_param)
end event

type cb_2 from u_boton within w_mailing_mapa
integer x = 1070
integer y = 388
integer width = 517
integer height = 92
integer taborder = 20
string text = "Tipos De Cartas"
end type

event clicked;call super::clicked;str_parametros lstr_param
OpenWithParm(wi_mant_tipo_cartas, lstr_param)
end event

type cb_1 from u_boton within w_mailing_mapa
integer x = 1070
integer y = 284
integer width = 517
integer height = 92
integer taborder = 140
string text = "Cartas"
end type

event clicked;call super::clicked;str_parametros lstr_param
OpenWithParm(wi_mant_cartas, lstr_param)
end event

type st_1 from statictext within w_mailing_mapa
integer x = 46
integer y = 56
integer width = 2674
integer height = 120
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Gestión Mailing"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_mailing_mapa
integer x = 110
integer y = 416
integer width = 329
integer height = 288
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\telef.bmp "
end type

event clicked;str_parametros lstr_param
OpenWithParm(w_int_llamadas, lstr_param)
end event

type gb_2 from groupbox within w_mailing_mapa
integer x = 937
integer y = 856
integer width = 795
integer height = 388
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "--------- Consultas -----------"
end type

type gb_1 from groupbox within w_mailing_mapa
integer x = 933
integer y = 200
integer width = 795
integer height = 640
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "------Mantenimientos--------"
end type

type ln_1 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 485
integer beginy = 520
integer endx = 603
integer endy = 520
end type

type ln_2 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 672
integer beginy = 520
integer endx = 791
integer endy = 520
end type

type ln_3 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 846
integer beginy = 520
integer endx = 965
integer endy = 520
end type

type ln_4 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 1710
integer beginy = 520
integer endx = 1829
integer endy = 520
end type

type ln_5 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 1897
integer beginy = 520
integer endx = 2016
integer endy = 520
end type

type ln_6 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 2080
integer beginy = 520
integer endx = 2199
integer endy = 520
end type

type ln_11 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 1897
integer beginy = 904
integer endx = 2016
integer endy = 904
end type

type ln_12 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 2080
integer beginy = 904
integer endx = 2199
integer endy = 904
end type

type ln_14 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 1870
integer beginy = 672
integer endx = 1870
integer endy = 764
end type

type ln_15 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 1870
integer beginy = 548
integer endx = 1870
integer endy = 640
end type

type ln_31 from line within w_mailing_mapa
long linecolor = 16711680
integer linethickness = 12
integer beginx = 1870
integer beginy = 792
integer endx = 1870
integer endy = 884
end type

