$PBExportHeader$w_con_mov_entradas_inventario.srw
forward
global type w_con_mov_entradas_inventario from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_mov_entradas_inventario
end type
type uo_1 from u_manejo_datawindow within w_con_mov_entradas_inventario
end type
type pb_imprimir_preli from picturebutton within w_con_mov_entradas_inventario
end type
type dw_1 from datawindow within w_con_mov_entradas_inventario
end type
type em_fechadesde from u_em_campo within w_con_mov_entradas_inventario
end type
type dw_listado from datawindow within w_con_mov_entradas_inventario
end type
type cb_consulta from u_boton within w_con_mov_entradas_inventario
end type
type gb_2 from groupbox within w_con_mov_entradas_inventario
end type
type st_3 from statictext within w_con_mov_entradas_inventario
end type
type uo_articulo from u_em_campo_2 within w_con_mov_entradas_inventario
end type
type st_6 from statictext within w_con_mov_entradas_inventario
end type
type uo_calidad from u_em_campo_2 within w_con_mov_entradas_inventario
end type
type st_5 from statictext within w_con_mov_entradas_inventario
end type
type em_tono from u_em_campo within w_con_mov_entradas_inventario
end type
type st_9 from statictext within w_con_mov_entradas_inventario
end type
type em_calibre from u_em_campo within w_con_mov_entradas_inventario
end type
type st_4 from statictext within w_con_mov_entradas_inventario
end type
type uo_tipopallet from u_em_campo_2 within w_con_mov_entradas_inventario
end type
type st_f3 from statictext within w_con_mov_entradas_inventario
end type
end forward

global type w_con_mov_entradas_inventario from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2949
integer height = 2232
string title = "Consulta de movimientos - Entradas Inventario"
pb_2 pb_2
uo_1 uo_1
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
em_fechadesde em_fechadesde
dw_listado dw_listado
cb_consulta cb_consulta
gb_2 gb_2
st_3 st_3
uo_articulo uo_articulo
st_6 st_6
uo_calidad uo_calidad
st_5 st_5
em_tono em_tono
st_9 st_9
em_calibre em_calibre
st_4 st_4
uo_tipopallet uo_tipopallet
st_f3 st_f3
end type
global w_con_mov_entradas_inventario w_con_mov_entradas_inventario

type variables
STRING  tipos[]
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public function string f_filtro ()
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros

dw_data.reset()
dw_data.visible   = FALSE

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
dw_data.Setfilter(f_filtro())
dw_data.filter()
//fecha2=Datetime(Date(String(em_fechahasta.Text)))
dw_data.Retrieve(codigo_empresa,fecha1,uo_articulo.em_codigo.text,tipos[])
registros = dw_data.RowCount()
If registros = 0 Then Return
dw_data.visible   = TRUE
end subroutine

public function string f_filtro ();String filtro
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
	filtro = filtro + " (almmovhis_tipo_pallet = '" + uo_tipopallet.em_codigo.text + "')"
END IF	


Return filtro
end function

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = "Consulta de movimientos - Entradas Inventario"
f_mascara_columna(dw_1,"tono","##")
f_mascara_columna(dw_1,"calibre","##")

em_fechadesde.text = "20-07-97"
//em_fechahasta.text = String(Today())
dw_1.Setfocus()
IF istr_parametros.i_nargumentos>1 Then 
	f_posicion_inicio(This)
	uo_articulo.em_codigo.text = istr_parametros.s_argumentos[2]
   uo_articulo.em_campo.text  = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
   uo_calidad.em_codigo.text     =  istr_parametros.s_argumentos[3]
   uo_calidad.em_campo.text  = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
   em_tono.text        =   istr_parametros.s_argumentos[4]
   em_calibre.text     =   istr_parametros.s_argumentos[5]
   uo_tipopallet.em_codigo.text =   istr_parametros.s_argumentos[6]
   uo_tipopallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,uo_tipopallet.em_codigo.text)
	cb_consulta.TriggerEvent(Clicked!)
END IF
f_activar_campo(em_fechadesde)


end event

on w_con_mov_entradas_inventario.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.dw_listado=create dw_listado
this.cb_consulta=create cb_consulta
this.gb_2=create gb_2
this.st_3=create st_3
this.uo_articulo=create uo_articulo
this.st_6=create st_6
this.uo_calidad=create uo_calidad
this.st_5=create st_5
this.em_tono=create em_tono
this.st_9=create st_9
this.em_calibre=create em_calibre
this.st_4=create st_4
this.uo_tipopallet=create uo_tipopallet
this.st_f3=create st_f3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.em_fechadesde
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.cb_consulta
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.uo_articulo
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.uo_calidad
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.em_tono
this.Control[iCurrent+15]=this.st_9
this.Control[iCurrent+16]=this.em_calibre
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.uo_tipopallet
this.Control[iCurrent+19]=this.st_f3
end on

on w_con_mov_entradas_inventario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.dw_listado)
destroy(this.cb_consulta)
destroy(this.gb_2)
destroy(this.st_3)
destroy(this.uo_articulo)
destroy(this.st_6)
destroy(this.uo_calidad)
destroy(this.st_5)
destroy(this.em_tono)
destroy(this.st_9)
destroy(this.em_calibre)
destroy(this.st_4)
destroy(this.uo_tipopallet)
destroy(this.st_f3)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_mov_entradas_inventario
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_mov_entradas_inventario
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_mov_entradas_inventario
integer x = 27
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_mov_entradas_inventario
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type uo_1 from u_manejo_datawindow within w_con_mov_entradas_inventario
integer x = 2245
integer y = 144
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type pb_imprimir_preli from picturebutton within w_con_mov_entradas_inventario
integer x = 2720
integer y = 188
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
dw_listado.visible = FALSE
end event

type dw_1 from datawindow within w_con_mov_entradas_inventario
integer x = 14
integer y = 312
integer width = 2862
integer height = 1700
integer taborder = 70
string dataobject = "dw_con_mov_entradas_inventario"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_fechadesde from u_em_campo within w_con_mov_entradas_inventario
integer x = 1335
integer y = 216
integer width = 315
integer height = 76
integer taborder = 80
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_mov_entradas_inventario
boolean visible = false
integer width = 41
integer height = 40
string dataobject = "report_con_mov_entradas_inventario"
boolean livescroll = true
end type

type cb_consulta from u_boton within w_con_mov_entradas_inventario
integer x = 1851
integer y = 192
integer width = 325
integer height = 84
integer taborder = 90
boolean bringtotop = true
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)

end event

type gb_2 from groupbox within w_con_mov_entradas_inventario
integer x = 1829
integer y = 152
integer width = 366
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_3 from statictext within w_con_mov_entradas_inventario
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

type uo_articulo from u_em_campo_2 within w_con_mov_entradas_inventario
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 32
integer y = 212
integer width = 727
integer taborder = 10
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

type st_6 from statictext within w_con_mov_entradas_inventario
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

type uo_calidad from u_em_campo_2 within w_con_mov_entradas_inventario
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 763
integer y = 212
integer width = 151
integer taborder = 20
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

f_activar_campo(uo_calidad.em_campo)


end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type st_5 from statictext within w_con_mov_entradas_inventario
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

type em_tono from u_em_campo within w_con_mov_entradas_inventario
integer x = 919
integer y = 212
integer width = 133
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "##"
end type

type st_9 from statictext within w_con_mov_entradas_inventario
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

type em_calibre from u_em_campo within w_con_mov_entradas_inventario
integer x = 1061
integer y = 212
integer width = 91
integer taborder = 40
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "#"
end type

type st_4 from statictext within w_con_mov_entradas_inventario
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

type uo_tipopallet from u_em_campo_2 within w_con_mov_entradas_inventario
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1152
integer y = 212
integer width = 151
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

type st_f3 from statictext within w_con_mov_entradas_inventario
integer x = 1335
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
string text = "F.Desde"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

