$PBExportHeader$w_inicio_rf_promocion.srw
forward
global type w_inicio_rf_promocion from w_ventana_padre_inicio
end type
type cb_3 from commandbutton within w_inicio_rf_promocion
end type
type cb_5 from commandbutton within w_inicio_rf_promocion
end type
type cb_2 from commandbutton within w_inicio_rf_promocion
end type
type st_empresa from statictext within w_inicio_rf_promocion
end type
type cb_6 from commandbutton within w_inicio_rf_promocion
end type
type cb_11 from commandbutton within w_inicio_rf_promocion
end type
type cb_4 from commandbutton within w_inicio_rf_promocion
end type
type cb_12 from commandbutton within w_inicio_rf_promocion
end type
type cb_1 from commandbutton within w_inicio_rf_promocion
end type
type cb_7 from commandbutton within w_inicio_rf_promocion
end type
end forward

global type w_inicio_rf_promocion from w_ventana_padre_inicio
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
cb_3 cb_3
cb_5 cb_5
cb_2 cb_2
st_empresa st_empresa
cb_6 cb_6
cb_11 cb_11
cb_4 cb_4
cb_12 cb_12
cb_1 cb_1
cb_7 cb_7
end type
global w_inicio_rf_promocion w_inicio_rf_promocion

forward prototypes
public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso)
end prototypes

public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso);
end subroutine

on w_inicio_rf_promocion.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_5=create cb_5
this.cb_2=create cb_2
this.st_empresa=create st_empresa
this.cb_6=create cb_6
this.cb_11=create cb_11
this.cb_4=create cb_4
this.cb_12=create cb_12
this.cb_1=create cb_1
this.cb_7=create cb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_5
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_empresa
this.Control[iCurrent+5]=this.cb_6
this.Control[iCurrent+6]=this.cb_11
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_12
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_7
end on

on w_inicio_rf_promocion.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.st_empresa)
destroy(this.cb_6)
destroy(this.cb_11)
destroy(this.cb_4)
destroy(this.cb_12)
destroy(this.cb_1)
destroy(this.cb_7)
end on

event closequery;call super::closequery;f_menu_cerrar_aplicacion(false)
//Activar en producción
//run("C:\Windows\System32\shutdown.exe -L")

end event

event open;call super::open;st_empresa.text = f_nombre_empresa_abr(codigo_empresa)
end event

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_rf_promocion
integer x = 4046
integer y = 2260
integer width = 631
integer height = 552
integer taborder = 10
boolean originalsize = false
string picturename = "C:\bmp\RF\salir.png"
end type

type cb_3 from commandbutton within w_inicio_rf_promocion
integer x = 5
integer y = 4
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
string text = "TRASPASO A PROMOCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 13
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_traspasos_lineas_a_promocion")
end if
end event

type cb_5 from commandbutton within w_inicio_rf_promocion
integer x = 5
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
string text = "PREPARACIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 9
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_traspasos_lineas_a_preparar")
end if
end event

type cb_2 from commandbutton within w_inicio_rf_promocion
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

type st_empresa from statictext within w_inicio_rf_promocion
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

type cb_6 from commandbutton within w_inicio_rf_promocion
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

if nombre_usuario = 'PRF' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 6
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_salidas_roturas")
end if
end event

type cb_11 from commandbutton within w_inicio_rf_promocion
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

type cb_4 from commandbutton within w_inicio_rf_promocion
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

type cb_12 from commandbutton within w_inicio_rf_promocion
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
string text = "SALIDAS CONSUMO PROMOCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 7
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_salidas_consumo_promocion")
end if
end event

type cb_1 from commandbutton within w_inicio_rf_promocion
integer x = 5
integer y = 568
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
string text = "UBICAR PROMOCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 4
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_traspasos_lineas_ubicar_promocion")
end if
end event

type cb_7 from commandbutton within w_inicio_rf_promocion
integer x = 5
integer y = 1696
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
string text = "TRASPASOS"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 12
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_traspasos_lineas")
end if
end event

