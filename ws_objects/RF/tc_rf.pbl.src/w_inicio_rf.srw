$PBExportHeader$w_inicio_rf.srw
forward
global type w_inicio_rf from w_ventana_padre_inicio
end type
type cb_1 from commandbutton within w_inicio_rf
end type
type cb_3 from commandbutton within w_inicio_rf
end type
type cb_5 from commandbutton within w_inicio_rf
end type
type cb_7 from commandbutton within w_inicio_rf
end type
type cb_9 from commandbutton within w_inicio_rf
end type
type cb_10 from commandbutton within w_inicio_rf
end type
type cb_2 from commandbutton within w_inicio_rf
end type
type st_empresa from statictext within w_inicio_rf
end type
type cb_6 from commandbutton within w_inicio_rf
end type
type cb_11 from commandbutton within w_inicio_rf
end type
type cb_4 from commandbutton within w_inicio_rf
end type
type cb_8 from commandbutton within w_inicio_rf
end type
type cb_12 from commandbutton within w_inicio_rf
end type
type cb_13 from commandbutton within w_inicio_rf
end type
type cb_14 from commandbutton within w_inicio_rf
end type
type cb_15 from commandbutton within w_inicio_rf
end type
end forward

global type w_inicio_rf from w_ventana_padre_inicio
string tag = "INICIO"
integer width = 4718
integer height = 2916
string title = "RADIO FRECUENCIA"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = true
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = topslide!
cb_1 cb_1
cb_3 cb_3
cb_5 cb_5
cb_7 cb_7
cb_9 cb_9
cb_10 cb_10
cb_2 cb_2
st_empresa st_empresa
cb_6 cb_6
cb_11 cb_11
cb_4 cb_4
cb_8 cb_8
cb_12 cb_12
cb_13 cb_13
cb_14 cb_14
cb_15 cb_15
end type
global w_inicio_rf w_inicio_rf

forward prototypes
public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso)
end prototypes

public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso);
end subroutine

on w_inicio_rf.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_5=create cb_5
this.cb_7=create cb_7
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_2=create cb_2
this.st_empresa=create st_empresa
this.cb_6=create cb_6
this.cb_11=create cb_11
this.cb_4=create cb_4
this.cb_8=create cb_8
this.cb_12=create cb_12
this.cb_13=create cb_13
this.cb_14=create cb_14
this.cb_15=create cb_15
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.cb_7
this.Control[iCurrent+5]=this.cb_9
this.Control[iCurrent+6]=this.cb_10
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_empresa
this.Control[iCurrent+9]=this.cb_6
this.Control[iCurrent+10]=this.cb_11
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.cb_8
this.Control[iCurrent+13]=this.cb_12
this.Control[iCurrent+14]=this.cb_13
this.Control[iCurrent+15]=this.cb_14
this.Control[iCurrent+16]=this.cb_15
end on

on w_inicio_rf.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_5)
destroy(this.cb_7)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_2)
destroy(this.st_empresa)
destroy(this.cb_6)
destroy(this.cb_11)
destroy(this.cb_4)
destroy(this.cb_8)
destroy(this.cb_12)
destroy(this.cb_13)
destroy(this.cb_14)
destroy(this.cb_15)
end on

event closequery;call super::closequery;f_menu_cerrar_aplicacion(false)
//Activar en producción
//run("C:\Windows\System32\shutdown.exe -L")

end event

event open;call super::open;st_empresa.text = f_nombre_empresa_abr(codigo_empresa)
end event

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_rf
integer x = 4046
integer y = 2260
integer width = 631
integer height = 552
integer taborder = 10
boolean originalsize = false
string picturename = "C:\bmp\RF\salir.png"
end type

type cb_1 from commandbutton within w_inicio_rf
integer x = 5
integer y = 4
integer width = 2299
integer height = 552
integer taborder = 20
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "MONTAR BULTO PRODUCCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_entradas_produccion")
end event

type cb_3 from commandbutton within w_inicio_rf
integer x = 5
integer y = 568
integer width = 2299
integer height = 552
integer taborder = 30
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TRASPASOS UBICACIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_traspasos_bultos")
end event

type cb_5 from commandbutton within w_inicio_rf
integer x = 5
integer y = 1696
integer width = 2299
integer height = 552
integer taborder = 40
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TRASPASOS ENTRE BULTOS"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_traspasos_lineas")
end event

type cb_7 from commandbutton within w_inicio_rf
boolean visible = false
integer x = 5
integer y = 1132
integer width = 2299
integer height = 552
integer taborder = 50
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "MONTAR BULTO BASE CLIENTE"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_entradas_bases_clientes")
end event

type cb_9 from commandbutton within w_inicio_rf
integer x = 5
integer y = 2260
integer width = 2299
integer height = 552
integer taborder = 60
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "MONTAR BULTO COMPRAS"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_entradas_compras")
end event

type cb_10 from commandbutton within w_inicio_rf
boolean visible = false
integer x = 2368
integer y = 1696
integer width = 2299
integer height = 552
integer taborder = 70
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "DESPREPARACIÓN ORDENES"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_salidas")
end event

type cb_2 from commandbutton within w_inicio_rf
boolean visible = false
integer x = 2377
integer y = 4
integer width = 2299
integer height = 552
integer taborder = 30
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "TRASPASO A PRODUCCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_salidas_produccion")
end event

type st_empresa from statictext within w_inicio_rf
integer x = 2377
integer y = 2660
integer width = 1659
integer height = 120
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19136731
long backcolor = 553648127
string text = "EMPRESA"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_inicio_rf
integer x = 2368
integer y = 568
integer width = 2299
integer height = 552
integer taborder = 50
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SALIDAS ROTURA"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_salidas_roturas")
end event

type cb_11 from commandbutton within w_inicio_rf
integer x = 2368
integer y = 4
integer width = 2299
integer height = 552
integer taborder = 50
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CONSULTA"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "wtc_consulta_almacen_ubicacion_bultos")
end event

type cb_4 from commandbutton within w_inicio_rf
boolean visible = false
integer x = 2377
integer y = 568
integer width = 2299
integer height = 552
integer taborder = 40
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "DEVOLUCIÓN DE PRODUCCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_devolucion_desde_produccion")
end event

type cb_8 from commandbutton within w_inicio_rf
boolean visible = false
integer x = 2368
integer y = 2260
integer width = 2299
integer height = 552
integer taborder = 60
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "PREPARACIÓN ORDENES"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_salidas")
end event

type cb_12 from commandbutton within w_inicio_rf
integer x = 2368
integer y = 1132
integer width = 2299
integer height = 552
integer taborder = 60
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SALIDAS CONSUMO PRODUCCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_salidas_consumo_produccion")
end event

type cb_13 from commandbutton within w_inicio_rf
integer x = 9
integer y = 1132
integer width = 2299
integer height = 552
integer taborder = 40
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TRASPASO A PROMOCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_traspasos_lineas_a_promocion")
end event

type cb_14 from commandbutton within w_inicio_rf
integer x = 2368
integer y = 1696
integer width = 1140
integer height = 552
integer taborder = 70
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "REG. SALIDA"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_salidas_regularizacion")
end event

type cb_15 from commandbutton within w_inicio_rf
integer x = 3529
integer y = 1696
integer width = 1138
integer height = 552
integer taborder = 80
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "REG. ENTRADA"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 
OpenWithParm(lw_ventana, lstr_param , "rf_entradas_regularizacion")
end event

