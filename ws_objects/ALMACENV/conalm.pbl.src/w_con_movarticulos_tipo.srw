$PBExportHeader$w_con_movarticulos_tipo.srw
$PBExportComments$Consulta de Movimientos de Almacen por Articulo
forward
global type w_con_movarticulos_tipo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_movarticulos_tipo
end type
type cb_1 from u_boton within w_con_movarticulos_tipo
end type
type uo_tipo from u_marca_lista within w_con_movarticulos_tipo
end type
type dw_listado from datawindow within w_con_movarticulos_tipo
end type
type em_fechadesde from u_em_campo within w_con_movarticulos_tipo
end type
type em_fechahasta from u_em_campo within w_con_movarticulos_tipo
end type
type cb_consulta from u_boton within w_con_movarticulos_tipo
end type
type uo_articulo from u_em_campo_2 within w_con_movarticulos_tipo
end type
type pb_imprimir_preli from picturebutton within w_con_movarticulos_tipo
end type
type uo_calidad from u_em_campo_2 within w_con_movarticulos_tipo
end type
type em_tono from u_em_campo within w_con_movarticulos_tipo
end type
type em_calibre from u_em_campo within w_con_movarticulos_tipo
end type
type st_3 from statictext within w_con_movarticulos_tipo
end type
type st_6 from statictext within w_con_movarticulos_tipo
end type
type st_5 from statictext within w_con_movarticulos_tipo
end type
type st_4 from statictext within w_con_movarticulos_tipo
end type
type st_7 from statictext within w_con_movarticulos_tipo
end type
type st_8 from statictext within w_con_movarticulos_tipo
end type
type dw_1 from datawindow within w_con_movarticulos_tipo
end type
type dw_almlinubicahis from datawindow within w_con_movarticulos_tipo
end type
type uo_1 from u_manejo_datawindow within w_con_movarticulos_tipo
end type
type uo_tipopallet from u_em_campo_2 within w_con_movarticulos_tipo
end type
type st_9 from statictext within w_con_movarticulos_tipo
end type
type st_10 from statictext within w_con_movarticulos_tipo
end type
type uo_tipocaja from u_em_campo_2 within w_con_movarticulos_tipo
end type
type cb_2 from commandbutton within w_con_movarticulos_tipo
end type
type st_formato from statictext within w_con_movarticulos_tipo
end type
type st_1 from statictext within w_con_movarticulos_tipo
end type
end forward

global type w_con_movarticulos_tipo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3749
integer height = 3108
string title = "Consulta de Movimientos por Tipos y Artículo"
pb_2 pb_2
cb_1 cb_1
uo_tipo uo_tipo
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
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
st_8 st_8
dw_1 dw_1
dw_almlinubicahis dw_almlinubicahis
uo_1 uo_1
uo_tipopallet uo_tipopallet
st_9 st_9
st_10 st_10
uo_tipocaja uo_tipocaja
cb_2 cb_2
st_formato st_formato
st_1 st_1
end type
global w_con_movarticulos_tipo w_con_movarticulos_tipo

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_control_tono_calibre ()
end prototypes

public function string f_filtro ();Integer numero,registros,x1,y1
String filtro,filtro1
y1=0
filtro = " "
numero = uo_tipo.dw_marca.RowCount()
IF numero =0 Then return filtro

FOR x1 = 1 To numero
   IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
      y1=y1+1
      IF Trim(filtro) = "" Then
         filtro1 = " tipomov = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
       Else
         filtro1 = " Or tipomov = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      filtro = filtro  + filtro1
		filtro  = "(" + filtro + ")"
   END IF
NEXT

IF Trim(uo_calidad.em_codigo.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro =  filtro + "and"
	filtro = filtro + " (calidad = '" + uo_calidad.em_codigo.text + "')"
END IF	
IF Trim(em_tono.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro =  filtro + "and"
	filtro = filtro + " (tonochar = '" + em_tono.text + "')"
END IF	
IF Trim(em_calibre.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro = filtro + "and"
	filtro = filtro + " (calibre = " + em_calibre.text + ")"
END IF	
//IF Trim(uo_tipopallet.em_codigo.text) <> "" Then
//	IF Trim(filtro)<> "" Then filtro =  filtro + "and"
//	filtro = filtro + " (tipo_pallet = '" + uo_tipopallet.em_codigo.text + "')"
//END IF	
//IF Trim(uo_tipocaja.em_codigo.text) <> "" Then
//	IF Trim(filtro)<> "" Then filtro =  filtro + "and"
//	filtro = filtro + " (almmovhis_caja = '" + uo_tipocaja.em_codigo.text + "')"
//END IF	


Return filtro
end function

public subroutine f_control_tono_calibre (); em_tono.enabled    =  TRUE
 em_calibre.enabled =  TRUE
IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
  em_tono.enabled    =  FALSE
  em_tono.text       =  ""
END IF
IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
  em_calibre.enabled =  FALSE
  em_calibre.text    =  "0"
END IF  
end subroutine

event ue_listar;//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//CALL Super::ue_listar

dw_report= dw_1
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = "Consulta de Movimientos por Tipos y Artículo"
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_1.Setfocus()

Integer x1,registros 
String var_codigo,var_texto,marca
DataStore dd

//dd = f_cargar_cursor("Select * from almtipomov Where empresa = '" + codigo_empresa+"'")
f_cargar_cursor_nuevo("Select * from almtipomov Where empresa = '" + codigo_empresa+"'", dd)

 FOR x1= 1 To dd.RowcOunt()
  var_codigo  = dd.GetItemString(x1,"tipomov")
  var_texto   = dd.GetItemString(x1,"descripcion")
  marca="S"
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT


uo_tipo.st_titulo1.text="Tipo Mov."
uo_tipo.st_titulo2.text="Descripcion"
Destroy dd

// Si recibo el código de un artículo como parámetro, lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	uo_articulo.em_codigo.text   = istr_parametros.s_argumentos[2]
	uo_calidad.em_codigo.text    = istr_parametros.s_argumentos[3]
	em_tono.text                 = istr_parametros.s_argumentos[4]
	em_calibre.text              = istr_parametros.s_argumentos[5]
	uo_tipopallet.em_codigo.text = istr_parametros.s_argumentos[6]
	uo_tipocaja.em_codigo.text   = istr_parametros.s_argumentos[7]
	uo_articulo.em_campo.text    = f_nombre_articulo (codigo_empresa, uo_articulo.em_codigo.text)
	uo_calidad.em_campo.text     = f_nombre_calidad_abr (codigo_empresa, uo_calidad.em_codigo.text)
	uo_tipopallet.em_campo.text  = f_nombre_pallet_abr (codigo_empresa, uo_tipopallet.em_codigo.text)
	uo_tipocaja.em_campo.text    = f_nombre_caja_abr (codigo_empresa, uo_tipocaja.em_codigo.text)	
	
	IF len(uo_articulo.em_codigo.text) <> 0   Then
	 cb_consulta.TriggerEvent("clicked")
	 f_activar_campo(uo_articulo.em_campo)
	END IF
else
	f_activar_campo(uo_articulo.em_campo)
END IF




end event

on w_con_movarticulos_tipo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.uo_tipo=create uo_tipo
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
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
this.st_8=create st_8
this.dw_1=create dw_1
this.dw_almlinubicahis=create dw_almlinubicahis
this.uo_1=create uo_1
this.uo_tipopallet=create uo_tipopallet
this.st_9=create st_9
this.st_10=create st_10
this.uo_tipocaja=create uo_tipocaja
this.cb_2=create cb_2
this.st_formato=create st_formato
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_tipo
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.em_fechadesde
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.cb_consulta
this.Control[iCurrent+8]=this.uo_articulo
this.Control[iCurrent+9]=this.pb_imprimir_preli
this.Control[iCurrent+10]=this.uo_calidad
this.Control[iCurrent+11]=this.em_tono
this.Control[iCurrent+12]=this.em_calibre
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.st_8
this.Control[iCurrent+19]=this.dw_1
this.Control[iCurrent+20]=this.dw_almlinubicahis
this.Control[iCurrent+21]=this.uo_1
this.Control[iCurrent+22]=this.uo_tipopallet
this.Control[iCurrent+23]=this.st_9
this.Control[iCurrent+24]=this.st_10
this.Control[iCurrent+25]=this.uo_tipocaja
this.Control[iCurrent+26]=this.cb_2
this.Control[iCurrent+27]=this.st_formato
this.Control[iCurrent+28]=this.st_1
end on

on w_con_movarticulos_tipo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.uo_tipo)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
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
destroy(this.st_8)
destroy(this.dw_1)
destroy(this.dw_almlinubicahis)
destroy(this.uo_1)
destroy(this.uo_tipopallet)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.uo_tipocaja)
destroy(this.cb_2)
destroy(this.st_formato)
destroy(this.st_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_movarticulos_tipo
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_movarticulos_tipo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_movarticulos_tipo
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_movarticulos_tipo
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type cb_1 from u_boton within w_con_movarticulos_tipo
integer x = 681
integer y = 400
integer width = 288
integer height = 84
integer taborder = 120
string text = "&Tipo Mov."
end type

on clicked;call u_boton::clicked;uo_tipo.visible = TRUE
dw_1.visible = FALSE
end on

type uo_tipo from u_marca_lista within w_con_movarticulos_tipo
boolean visible = false
integer x = 672
integer y = 488
integer width = 1454
integer taborder = 140
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_listado from datawindow within w_con_movarticulos_tipo
boolean visible = false
integer x = 2089
integer y = 380
integer width = 224
integer height = 88
boolean bringtotop = true
string dataobject = "report_con_movarticulos_tipo"
boolean livescroll = true
end type

type em_fechadesde from u_em_campo within w_con_movarticulos_tipo
integer x = 37
integer y = 396
integer width = 311
integer height = 88
integer taborder = 100
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_movarticulos_tipo
integer x = 357
integer y = 396
integer width = 311
integer height = 88
integer taborder = 110
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_consulta from u_boton within w_con_movarticulos_tipo
integer x = 997
integer y = 400
integer width = 416
integer height = 84
integer taborder = 130
string text = "&Consulta"
end type

event clicked;Integer registros,registro,contador,var_mov
DateTime	var_fecha   
String	var_numdoc,var_tipomov,var_calidad,var_tipo_pallet,var_codtercero,var_tipo,ante_montaje,montaje
Dec{0}   var_tono,var_calibre
Dec{2}	var_cantidade  ,var_cantidads,var_progresivo
string 	articulo

dw_1.reset()
dw_1.visible      = FALSE
uo_tipo.visible   = FALSE
string is_filtro=""

dw_1.SetTransObject(sqlca)
dw_1.SetFilter("")
dw_1.Filter()

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))
dw_1.SetFilter(f_filtro())
dw_1.Filter()

if uo_articulo.em_codigo.text <> '' then
	articulo = uo_articulo.em_codigo.text
else
	articulo = '%'
end if
registros=dw_1.Retrieve(codigo_empresa,fecha1,fecha2,articulo )

registros = dw_1.RowCount()

If registros = 0 Then Return

dw_1.Visible = TRUE
end event

type uo_articulo from u_em_campo_2 within w_con_movarticulos_tipo
integer x = 457
integer y = 212
integer width = 1719
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF
String mascara,var_formato
mascara = f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text))

SELECT formato
INTO :var_formato
FROM articulos  
WHERE articulos.empresa = :codigo_empresa
AND   articulos.codigo  = :uo_articulo.em_codigo.text;

st_formato.text = f_nombre_formato(codigo_empresa,var_formato)

f_mascara_columna(dw_1,"cantidads",mascara)
f_mascara_columna(dw_1,"cantidade",mascara)
f_mascara_columna(dw_1,"stock",mascara)
f_mascara_columna(dw_listado,"cantidads",mascara)
f_mascara_columna(dw_listado,"cantidade",mascara)
f_mascara_columna(dw_listado,"stock",mascara)
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type pb_imprimir_preli from picturebutton within w_con_movarticulos_tipo
integer x = 1906
integer y = 380
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

event clicked;//Integer registros,registro,contador,var_mov
//DateTime	var_fecha   
//String	var_numdoc,var_tipomov,var_calidad,var_tipo_pallet,var_codtercero,var_tipo,ante_montaje,montaje
//Dec{0}   var_tono,var_calibre
//Dec{2}	var_cantidade  ,var_cantidads,var_progresivo
//
//dw_listado.reset()
//dw_listado.visible      = FALSE
//uo_tipo.visible   = FALSE
//string is_filtro=""
//
//dw_listado.SetTransObject(sqlca)
//dw_listado.SetFilter("")
//dw_listado.Filter()
//
//Datetime fecha1,fecha2
//fecha1=Datetime(Date(String(em_fechadesde.Text)))
//fecha2=Datetime(Date(String(em_fechahasta.Text)))
//
//dw_listado.SetFilter(f_filtro())
//dw_listado.Filter()
//registros=dw_listado.Retrieve(codigo_empresa,fecha1,fecha2,uo_articulo.em_codigo.text )
//If registros = 0 Then Return
Parent.TriggerEvent("ue_listar")

end event

type uo_calidad from u_em_campo_2 within w_con_movarticulos_tipo
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 2185
integer y = 212
integer width = 233
integer height = 88
integer taborder = 50
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

type em_tono from u_em_campo within w_con_movarticulos_tipo
integer x = 2427
integer y = 212
integer width = 178
integer height = 88
integer taborder = 60
fontcharset fontcharset = ansi!
alignment alignment = center!
string mask = "!!!!"
end type

type em_calibre from u_em_campo within w_con_movarticulos_tipo
integer x = 2610
integer y = 212
integer width = 91
integer height = 88
integer taborder = 70
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "0"
end type

type st_3 from statictext within w_con_movarticulos_tipo
integer x = 457
integer y = 132
integer width = 1719
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

type st_6 from statictext within w_con_movarticulos_tipo
integer x = 2185
integer y = 132
integer width = 238
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cal"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_movarticulos_tipo
integer x = 2427
integer y = 132
integer width = 178
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

type st_4 from statictext within w_con_movarticulos_tipo
boolean visible = false
integer x = 416
integer y = 320
integer width = 402
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

type st_7 from statictext within w_con_movarticulos_tipo
integer x = 37
integer y = 316
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
string text = "Desde"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_8 from statictext within w_con_movarticulos_tipo
integer x = 357
integer y = 316
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
string text = "Hasta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_movarticulos_tipo
integer y = 528
integer width = 3643
integer height = 2340
string dataobject = "report_con_movarticulos_tipo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row<>0 THEN
 integer registros
 dec vanyo,vnummov
 string valmacen
 registros = dw_1.RowCount()
 IF registros>0 THEN
 This.SelectRow(0,FALSE)
 This.SelectRow(row,TRUE)
 
  vanyo    =  GetItemNumber(row,"anyo")
  valmacen =  GetItemString(row,"almacen")
  vnummov  =  GetItemNumber(row,"nummov")
  dw_almlinubicahis.SetTransObject(SQLCA)
  dw_almlinubicahis.retrieve(codigo_empresa,vanyo,valmacen,vnummov)
  dw_almlinubicahis.visible=true
 END IF
END IF
end event

type dw_almlinubicahis from datawindow within w_con_movarticulos_tipo
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
boolean visible = false
integer x = 41
integer y = 488
integer width = 1184
integer height = 684
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle ubicación de la linea "
string dataobject = "dw_int_movarticulos_tipo"
boolean controlmenu = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type uo_1 from u_manejo_datawindow within w_con_movarticulos_tipo
integer x = 1435
integer y = 336
integer width = 663
integer height = 172
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type uo_tipopallet from u_em_campo_2 within w_con_movarticulos_tipo
event modificado pbm_custom01
event getfocus pbm_custom04
boolean visible = false
integer x = 416
integer y = 400
integer width = 402
integer height = 88
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
uo_tipopallet.em_campo.text = f_nombre_palarticulo_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_tipopallet.em_codigo.text)
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

type st_9 from statictext within w_con_movarticulos_tipo
integer x = 2610
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

type st_10 from statictext within w_con_movarticulos_tipo
boolean visible = false
integer x = 818
integer y = 320
integer width = 466
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tc"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_tipocaja from u_em_campo_2 within w_con_movarticulos_tipo
boolean visible = false
integer x = 818
integer y = 400
integer width = 466
integer height = 88
integer taborder = 90
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_tipocaja.em_campo.text=f_nombre_almartcaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_tipocaja.em_codigo.text)

IF Trim(uo_tipocaja.em_campo.text)=""  or IsNull(uo_tipocaja.em_campo.text)THEN 
 IF Trim(uo_tipocaja.em_codigo.text)<>"" Then 
   uo_tipocaja.em_campo.SetFocus()
 END IF
 uo_tipocaja.em_campo.text=""
 uo_tipocaja.em_codigo.text=""
END IF

f_activar_campo(uo_tipocaja.em_campo)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"
//campo_actual = "CAJA"

end event

on uo_tipocaja.destroy
call u_em_campo_2::destroy
end on

type cb_2 from commandbutton within w_con_movarticulos_tipo
boolean visible = false
integer x = 165
integer y = 24
integer width = 247
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;String sel,tono,v_emp,v_alm
Dec v_anyo,v_mov
Datastore dd
Long cont,total

//sel = " SELECT * FROM almmovhis "
//
//dd = f_cargar_cursor (sel)
//
//dd.SetTransObject(sqlca)
//
//total = dd.RowCount()
//
//for cont = 1 to total
//	tono = dd.GetItemString(cont,"tonochar")
//	v_emp = dd.GetItemString(cont,"empresa")
//	v_alm = dd.GetItemString(cont,"almacen")
//	v_anyo = dd.GetItemNumber(cont,"anyo")	
//	v_mov = dd.GetItemNumber(cont,"nummov")	
//	tono = Trim(tono)
//	
//	UPDATE almmovhis
//	   SET tonochar =:tono
//	 WHERE empresa =:v_emp 
//	   AND almacen =:v_alm
//	   AND anyo =:v_anyo
//		AND nummov =:v_mov
//	 USING sqlca;
//	 
//	 if sqlca.sqlcode = 0 then
//		COMMIT USING sqlca;
//	ELSE
//		ROLLBACK USING SQLCA;
//		F_MENSAJE("ERROR","")
//	END IF
//
//	f_mensaje_proceso("almmovhis",cont,total)
//	
//next
//
//sel = " SELECT * FROM almLINUBICA "
//
//dd = f_cargar_cursor (sel)
//
//total = dd.RowCount()
//String v_ubi
//Dec v_linea
//for cont = 1 to total
//	tono = dd.GetItemString(cont,"tonochar")
//	v_emp = dd.GetItemString(cont,"empresa")
//	v_ubi = dd.GetItemString(cont,"ubicacion")
//	v_linea = dd.GetItemNumber(cont,"linea")	
//	tono = Trim(tono)
//	
//	UPDATE almlinubica
//	   SET tonochar =:tono
//	 WHERE empresa =:v_emp 
//	   AND ubicacion =:v_ubi
//	   AND linea =:v_linea
//	 USING sqlca;
//	 
//	 if sqlca.sqlcode = 0 then
//		COMMIT USING sqlca;
//	ELSE
//		ROLLBACK USING SQLCA;
//		F_MENSAJE("ERROR","")
//	END IF
//
//	f_mensaje_proceso("almlinubica",cont,total)
//	
//next
//
sel = " SELECT * FROM almLINUBICAhis "

//dd = f_cargar_cursor (sel)
f_cargar_cursor_nuevo(sel, dd)


total = dd.RowCount()
Dec v_ord
for cont = 1 to total
	tono = dd.GetItemString(cont,"tonochar")
	v_emp = dd.GetItemString(cont,"empresa")
	v_anyo = dd.GetItemNumber(cont,"anyo")	
	v_alm = dd.GetItemString(cont,"almacen")
	v_ord = dd.GetItemNumber(cont,"orden")	
	tono = Trim(tono)
	
	UPDATE almlinubicahis
	   SET tonochar =:tono
	 WHERE empresa =:v_emp 
	   AND anyo =:v_anyo
	   AND almacen =:v_alm
	   AND orden =:v_ord		
	 USING sqlca;
	 
	 if sqlca.sqlcode = 0 then
		COMMIT USING sqlca;
	ELSE
		ROLLBACK USING SQLCA;
		F_MENSAJE("ERROR","")
	END IF

	f_mensaje_proceso("almlinubicahis",cont,total)
	
next

destroy dd
end event

type st_formato from statictext within w_con_movarticulos_tipo
integer x = 37
integer y = 212
integer width = 411
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_con_movarticulos_tipo
integer x = 41
integer y = 132
integer width = 407
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Formato"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

