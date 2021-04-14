$PBExportHeader$w_inicio_rf_global_old.srw
forward
global type w_inicio_rf_global_old from w_ventana_padre_inicio
end type
type cb_1 from commandbutton within w_inicio_rf_global_old
end type
type cb_3 from commandbutton within w_inicio_rf_global_old
end type
type cb_5 from commandbutton within w_inicio_rf_global_old
end type
type cb_7 from commandbutton within w_inicio_rf_global_old
end type
type cb_9 from commandbutton within w_inicio_rf_global_old
end type
type cb_10 from commandbutton within w_inicio_rf_global_old
end type
type cb_2 from commandbutton within w_inicio_rf_global_old
end type
type st_empresa from statictext within w_inicio_rf_global_old
end type
type cb_6 from commandbutton within w_inicio_rf_global_old
end type
type cb_11 from commandbutton within w_inicio_rf_global_old
end type
type cb_4 from commandbutton within w_inicio_rf_global_old
end type
type cb_8 from commandbutton within w_inicio_rf_global_old
end type
type cb_12 from commandbutton within w_inicio_rf_global_old
end type
type cb_13 from commandbutton within w_inicio_rf_global_old
end type
type cb_14 from commandbutton within w_inicio_rf_global_old
end type
type cb_15 from commandbutton within w_inicio_rf_global_old
end type
type cb_16 from commandbutton within w_inicio_rf_global_old
end type
type st_1 from statictext within w_inicio_rf_global_old
end type
type st_2 from statictext within w_inicio_rf_global_old
end type
type st_3 from statictext within w_inicio_rf_global_old
end type
type cb_17 from commandbutton within w_inicio_rf_global_old
end type
type cb_18 from commandbutton within w_inicio_rf_global_old
end type
type r_1 from rectangle within w_inicio_rf_global_old
end type
type r_2 from rectangle within w_inicio_rf_global_old
end type
type r_3 from rectangle within w_inicio_rf_global_old
end type
end forward

global type w_inicio_rf_global_old from w_ventana_padre_inicio
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
cb_16 cb_16
st_1 st_1
st_2 st_2
st_3 st_3
cb_17 cb_17
cb_18 cb_18
r_1 r_1
r_2 r_2
r_3 r_3
end type
global w_inicio_rf_global_old w_inicio_rf_global_old

forward prototypes
public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso)
end prototypes

public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso);
end subroutine

on w_inicio_rf_global_old.create
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
this.cb_16=create cb_16
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.cb_17=create cb_17
this.cb_18=create cb_18
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
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
this.Control[iCurrent+17]=this.cb_16
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.st_3
this.Control[iCurrent+21]=this.cb_17
this.Control[iCurrent+22]=this.cb_18
this.Control[iCurrent+23]=this.r_1
this.Control[iCurrent+24]=this.r_2
this.Control[iCurrent+25]=this.r_3
end on

on w_inicio_rf_global_old.destroy
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
destroy(this.cb_16)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_17)
destroy(this.cb_18)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
end on

event closequery;call super::closequery;f_menu_cerrar_aplicacion(false)
//Activar en producción
//run("C:\Windows\System32\shutdown.exe -L")

end event

event open;call super::open;st_empresa.text = f_nombre_empresa_abr(codigo_empresa)
end event

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_rf_global_old
integer x = 4037
integer y = 2152
integer width = 608
integer height = 504
integer taborder = 10
boolean originalsize = false
string picturename = "C:\bmp\RF\salir.png"
end type

type cb_1 from commandbutton within w_inicio_rf_global_old
integer x = 50
integer y = 260
integer width = 1463
integer height = 504
integer taborder = 20
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "E. PRODUCCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 1
	
	if nombre_usuario = 'T02' or nombre_usuario = 'T03' then
		ll_rf_parametros_ventanas_id = 2
	end if
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_entradas_produccion")
end if
end event

type cb_3 from commandbutton within w_inicio_rf_global_old
integer x = 3173
integer y = 264
integer width = 1463
integer height = 504
integer taborder = 30
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TRASPASO UBICACIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 11
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_traspasos_bultos")
end if
end event

type cb_5 from commandbutton within w_inicio_rf_global_old
integer x = 3177
integer y = 912
integer width = 1463
integer height = 504
integer taborder = 40
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TRASP. ENTRE BULTOS"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
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

type cb_7 from commandbutton within w_inicio_rf_global_old
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

type cb_9 from commandbutton within w_inicio_rf_global_old
integer x = 50
integer y = 912
integer width = 1463
integer height = 504
integer taborder = 60
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "E. COMPRAS"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 3
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_entradas_compras")
end if
end event

type cb_10 from commandbutton within w_inicio_rf_global_old
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

type cb_2 from commandbutton within w_inicio_rf_global_old
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

type st_empresa from statictext within w_inicio_rf_global_old
integer x = 3182
integer y = 2680
integer width = 1463
integer height = 80
boolean bringtotop = true
integer textsize = -12
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

type cb_6 from commandbutton within w_inicio_rf_global_old
integer x = 1618
integer y = 260
integer width = 1463
integer height = 504
integer taborder = 50
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S. ROTURA"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
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

type cb_11 from commandbutton within w_inicio_rf_global_old
integer x = 3182
integer y = 2152
integer width = 837
integer height = 504
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

type cb_4 from commandbutton within w_inicio_rf_global_old
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

type cb_8 from commandbutton within w_inicio_rf_global_old
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

type cb_12 from commandbutton within w_inicio_rf_global_old
integer x = 1618
integer y = 912
integer width = 1467
integer height = 504
integer taborder = 60
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S. CONSUMO PROD."
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 7
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_salidas_consumo_produccion")
end if

end event

type cb_13 from commandbutton within w_inicio_rf_global_old
integer x = 3182
integer y = 1544
integer width = 1463
integer height = 504
integer taborder = 40
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TRASP. A PROMOCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
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

type cb_14 from commandbutton within w_inicio_rf_global_old
integer x = 1618
integer y = 1544
integer width = 1463
integer height = 504
integer taborder = 70
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S. REGULARIZACION"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 8
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_salidas_regularizacion")
end if

end event

type cb_15 from commandbutton within w_inicio_rf_global_old
integer x = 50
integer y = 2152
integer width = 1463
integer height = 504
integer taborder = 80
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "E. REGULARIZACIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 5
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_entradas_regularizacion")
end if
end event

type cb_16 from commandbutton within w_inicio_rf_global_old
integer x = 50
integer y = 1544
integer width = 1463
integer height = 504
integer taborder = 50
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "E. PROMOCIÓN"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
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

type st_1 from statictext within w_inicio_rf_global_old
integer x = 18
integer y = 20
integer width = 1541
integer height = 168
boolean bringtotop = true
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 32768
string text = "ENTRADAS"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_inicio_rf_global_old
integer x = 1582
integer y = 20
integer width = 1541
integer height = 168
boolean bringtotop = true
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 20590053
string text = "SALIDAS"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_3 from statictext within w_inicio_rf_global_old
integer x = 3141
integer y = 20
integer width = 1536
integer height = 168
boolean bringtotop = true
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "TRASPASOS"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_17 from commandbutton within w_inicio_rf_global_old
integer x = 1618
integer y = 2152
integer width = 731
integer height = 504
integer taborder = 80
boolean bringtotop = true
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S. PREP PZS"
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
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

type cb_18 from commandbutton within w_inicio_rf_global_old
integer x = 2373
integer y = 2152
integer width = 731
integer height = 504
integer taborder = 90
boolean bringtotop = true
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S. PREP."
end type

event clicked;window lw_ventana 
str_parametros lstr_param 

if nombre_usuario = 'PRF' or nombre_usuario = 'T02' or nombre_usuario = 'T03' then
	string ls_tipo_ventana
	long   ll_rf_parametros_ventanas_id = 10
	
	ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
	
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
	
	OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
else
	OpenWithParm(lw_ventana, lstr_param , "rf_traspasos_lineas_a_preparar_nueva")
end if

end event

type r_1 from rectangle within w_inicio_rf_global_old
integer linethickness = 4
long fillcolor = 32768
integer x = 14
integer y = 196
integer width = 1550
integer height = 2536
end type

type r_2 from rectangle within w_inicio_rf_global_old
integer linethickness = 4
long fillcolor = 20590053
integer x = 1582
integer y = 196
integer width = 1545
integer height = 2536
end type

type r_3 from rectangle within w_inicio_rf_global_old
integer linethickness = 4
long fillcolor = 134217741
integer x = 3145
integer y = 196
integer width = 1531
integer height = 1928
end type

