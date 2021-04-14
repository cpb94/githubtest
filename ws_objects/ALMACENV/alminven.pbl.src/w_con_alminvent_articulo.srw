$PBExportHeader$w_con_alminvent_articulo.srw
forward
global type w_con_alminvent_articulo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_alminvent_articulo
end type
type dw_listado from datawindow within w_con_alminvent_articulo
end type
type em_fecha from u_em_campo within w_con_alminvent_articulo
end type
type cb_consulta from u_boton within w_con_alminvent_articulo
end type
type uo_articulo from u_em_campo_2 within w_con_alminvent_articulo
end type
type pb_imprimir_preli from picturebutton within w_con_alminvent_articulo
end type
type uo_calidad from u_em_campo_2 within w_con_alminvent_articulo
end type
type em_tono from u_em_campo within w_con_alminvent_articulo
end type
type em_calibre from u_em_campo within w_con_alminvent_articulo
end type
type st_3 from statictext within w_con_alminvent_articulo
end type
type st_6 from statictext within w_con_alminvent_articulo
end type
type st_5 from statictext within w_con_alminvent_articulo
end type
type st_4 from statictext within w_con_alminvent_articulo
end type
type st_7 from statictext within w_con_alminvent_articulo
end type
type dw_1 from datawindow within w_con_alminvent_articulo
end type
type uo_1 from u_manejo_datawindow within w_con_alminvent_articulo
end type
type uo_tipopallet from u_em_campo_2 within w_con_alminvent_articulo
end type
type st_9 from statictext within w_con_alminvent_articulo
end type
end forward

global type w_con_alminvent_articulo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3557
integer height = 2132
string title = "Consulta de Inventario por Artículo"
pb_2 pb_2
dw_listado dw_listado
em_fecha em_fecha
cb_consulta cb_consulta
uo_articulo uo_articulo
pb_imprimir_preli pb_imprimir_preli
uo_calidad uo_calidad
em_tono em_tono
em_calibre em_calibre
st_3 st_3
st_6 st_6
st_5 st_5
st_4 st_4
st_7 st_7
dw_1 dw_1
uo_1 uo_1
uo_tipopallet uo_tipopallet
st_9 st_9
end type
global w_con_alminvent_articulo w_con_alminvent_articulo

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_control_tono_calibre ()
public subroutine f_cargar (datawindow d)
end prototypes

public function string f_filtro ();Integer numero,registros,x1,y1
String filtro,filtro1
y1=0
filtro = " "

IF Trim(uo_calidad.em_codigo.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro =  filtro + "and"
	filtro = filtro + " (calidad = '" + uo_calidad.em_codigo.text + "')"
END IF	
IF Trim(em_tono.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro =  filtro + "and"
	filtro = filtro + " (tono = " + em_tono.text + ")"
END IF	
IF Trim(em_calibre.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro = filtro + "and"
	filtro = filtro + " (calibre = " + em_calibre.text + ")"
END IF	
IF Trim(uo_tipopallet.em_codigo.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro =  filtro + "and"
	filtro = filtro + " (tipo_pallet = '" + uo_tipopallet.em_codigo.text + "')"
END IF	


Return filtro
end function

public subroutine f_control_tono_calibre (); em_tono.enabled    =  TRUE
 em_calibre.enabled =  TRUE
IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
  em_tono.enabled    =  FALSE
  em_tono.text       =  "0"
END IF
IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
  em_calibre.enabled =  FALSE
  em_calibre.text    =  "0"
END IF  
end subroutine

public subroutine f_cargar (datawindow d);Integer registros,registro,contador,var_mov
DateTime	var_fecha   
String	var_numdoc,var_tipomov,var_calidad,var_tipo_pallet,var_codtercero,var_tipo,ante_montaje,montaje
Dec{0}   var_tono,var_calibre
Dec{2}	var_cantidade  ,var_cantidads,var_progresivo

d.reset()
d.SetRedraw(FALSE)
string is_filtro=""
d.SetTransObject(sqlca)
d.SetFilter("")
d.Filter()

Datetime fecha
fecha=Datetime(Date(String(em_fecha.Text)))
d.SetFilter(f_filtro())
d.Filter()
registros=d.Retrieve(codigo_empresa,fecha,uo_articulo.em_codigo.text )

registros = d.RowCount()
d.SetRedraw(TRUE)
If registros = 0 Then Return


end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = "Consulta de Inventario por Artículo"
em_fecha.text = String(today())
dw_1.Setfocus()
IF istr_parametros.i_nargumentos>1 Then 
	f_posicion_inicio(This)
	uo_articulo.em_codigo.text = istr_parametros.s_argumentos[2]
	uo_articulo.em_campo.text  = f_nombre_articulo(codigo_empresa,istr_parametros.s_argumentos[2])
	uo_calidad.em_codigo.text  = istr_parametros.s_argumentos[3]
	uo_calidad.em_campo.text   = f_nombre_calidad_abr(codigo_empresa,istr_parametros.s_argumentos[3])
	em_tono.text  = istr_parametros.s_argumentos[4]
	em_calibre.text  = istr_parametros.s_argumentos[5]
	uo_tipopallet.em_codigo.text  = istr_parametros.s_argumentos[6]
	uo_tipopallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,istr_parametros.s_argumentos[6])
	em_fecha.text      = istr_parametros.s_argumentos[7]
	cb_consulta.TriggerEvent(Clicked!)
END IF

f_activar_campo(uo_articulo.em_campo)


end event

on w_con_alminvent_articulo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_fecha=create em_fecha
this.cb_consulta=create cb_consulta
this.uo_articulo=create uo_articulo
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_calidad=create uo_calidad
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.st_3=create st_3
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_7=create st_7
this.dw_1=create dw_1
this.uo_1=create uo_1
this.uo_tipopallet=create uo_tipopallet
this.st_9=create st_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.em_fecha
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.uo_articulo
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.uo_calidad
this.Control[iCurrent+8]=this.em_tono
this.Control[iCurrent+9]=this.em_calibre
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.dw_1
this.Control[iCurrent+16]=this.uo_1
this.Control[iCurrent+17]=this.uo_tipopallet
this.Control[iCurrent+18]=this.st_9
end on

on w_con_alminvent_articulo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_fecha)
destroy(this.cb_consulta)
destroy(this.uo_articulo)
destroy(this.pb_imprimir_preli)
destroy(this.uo_calidad)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_7)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.uo_tipopallet)
destroy(this.st_9)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_alminvent_articulo
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_alminvent_articulo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_alminvent_articulo
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_alminvent_articulo
integer x = 3209
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_listado from datawindow within w_con_alminvent_articulo
boolean visible = false
integer width = 64
integer height = 88
boolean bringtotop = true
string dataobject = "report_alminvent_articulo"
boolean livescroll = true
end type

type em_fecha from u_em_campo within w_con_alminvent_articulo
integer x = 1349
integer y = 212
integer width = 311
integer height = 88
integer taborder = 70
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_consulta from u_boton within w_con_alminvent_articulo
integer x = 2400
integer y = 200
integer width = 325
integer height = 84
integer taborder = 80
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
end event

type uo_articulo from u_em_campo_2 within w_con_alminvent_articulo
integer x = 32
integer y = 212
integer width = 727
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF
String mascara
mascara = f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text))

f_mascara_columna(dw_1,"cantidads",mascara)
f_mascara_columna(dw_1,"cantidade",mascara)
f_mascara_columna(dw_1,"stock",mascara)
f_mascara_columna(dw_listado,"cantidads",mascara)
f_mascara_columna(dw_listado,"cantidade",mascara)
f_mascara_columna(dw_listado,"stock",mascara)
end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type pb_imprimir_preli from picturebutton within w_con_alminvent_articulo
integer x = 3214
integer y = 180
integer width = 105
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type uo_calidad from u_em_campo_2 within w_con_alminvent_articulo
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 763
integer y = 212
integer width = 151
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text) <> "" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text  = ""
 uo_calidad.em_codigo.text = ""
END IF

f_control_tono_calibre()
f_activar_campo(uo_calidad.em_campo)


end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type em_tono from u_em_campo within w_con_alminvent_articulo
integer x = 919
integer y = 212
integer width = 137
integer height = 88
integer taborder = 40
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "##"
end type

type em_calibre from u_em_campo within w_con_alminvent_articulo
integer x = 1061
integer y = 212
integer width = 91
integer height = 88
integer taborder = 50
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "#"
end type

type st_3 from statictext within w_con_alminvent_articulo
integer x = 32
integer y = 132
integer width = 731
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_con_alminvent_articulo
integer x = 763
integer y = 132
integer width = 155
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_alminvent_articulo
integer x = 919
integer y = 132
integer width = 142
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_alminvent_articulo
integer x = 1152
integer y = 132
integer width = 151
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tp"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_7 from statictext within w_con_alminvent_articulo
integer x = 1349
integer y = 132
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F.Invent"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_alminvent_articulo
integer y = 312
integer width = 3465
integer height = 1576
string dataobject = "dw_con_alminvent_articulo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type uo_1 from u_manejo_datawindow within w_con_alminvent_articulo
integer x = 2738
integer y = 136
integer width = 663
integer height = 172
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type uo_tipopallet from u_em_campo_2 within w_con_alminvent_articulo
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1152
integer y = 212
integer width = 151
integer height = 88
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_tipopallet.em_campo.text = f_nombre_almartpallet_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_tipopallet.em_codigo.text)
IF Trim(uo_tipopallet.em_campo.text)="" THEN 
 IF Trim(uo_tipopallet.em_codigo.text) <> "" Then uo_tipopallet.em_campo.SetFocus()
 uo_tipopallet.em_campo.text  = ""
 uo_tipopallet.em_codigo.text = ""
END IF

f_activar_campo(uo_tipopallet.em_campo)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_almartpallets_abr"
ue_filtro     = "almartpallet_articulo = '" + uo_articulo.em_codigo.text+ "'"

end event

on uo_tipopallet.destroy
call u_em_campo_2::destroy
end on

type st_9 from statictext within w_con_alminvent_articulo
integer x = 1061
integer y = 132
integer width = 91
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

