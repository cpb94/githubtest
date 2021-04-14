$PBExportHeader$w_con_ubi_articulos.srw
forward
global type w_con_ubi_articulos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_ubi_articulos
end type
type uo_articulo from u_em_campo_2 within w_con_ubi_articulos
end type
type pb_imprimir_preli from picturebutton within w_con_ubi_articulos
end type
type uo_calidad from u_em_campo_2 within w_con_ubi_articulos
end type
type em_tono from u_em_campo within w_con_ubi_articulos
end type
type em_calibre from u_em_campo within w_con_ubi_articulos
end type
type st_3 from statictext within w_con_ubi_articulos
end type
type st_6 from statictext within w_con_ubi_articulos
end type
type st_5 from statictext within w_con_ubi_articulos
end type
type st_4 from statictext within w_con_ubi_articulos
end type
type uo_1 from u_manejo_datawindow within w_con_ubi_articulos
end type
type dw_listado from datawindow within w_con_ubi_articulos
end type
type uo_tipo from u_marca_lista within w_con_ubi_articulos
end type
type cb_1 from u_boton within w_con_ubi_articulos
end type
type dw_1 from datawindow within w_con_ubi_articulos
end type
type cb_continuar from u_boton within w_con_ubi_articulos
end type
type st_1 from statictext within w_con_ubi_articulos
end type
type st_formato from statictext within w_con_ubi_articulos
end type
end forward

global type w_con_ubi_articulos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3726
integer height = 2140
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_articulo uo_articulo
pb_imprimir_preli pb_imprimir_preli
uo_calidad uo_calidad
em_tono em_tono
em_calibre em_calibre
st_3 st_3
st_6 st_6
st_5 st_5
st_4 st_4
uo_1 uo_1
dw_listado dw_listado
uo_tipo uo_tipo
cb_1 cb_1
dw_1 dw_1
cb_continuar cb_continuar
st_1 st_1
st_formato st_formato
end type
global w_con_ubi_articulos w_con_ubi_articulos

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_control_tono_calibre ()
public subroutine f_control ()
end prototypes

public function string f_filtro ();String filtro="",filtro1=""
Integer numero,registros,x1,y1

y1=0

IF Trim(uo_calidad.em_codigo.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro =  filtro + "and"
	filtro = filtro + " (almlinubica_calidad = '" + uo_calidad.em_codigo.text + "')"
END IF	
IF Trim(em_tono.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro =  filtro + "and"
	filtro = filtro + " (almlinubica_tono = '" + Trim(em_tono.text) + "')"
END IF	
IF Trim(em_calibre.text) <> "" Then
	IF Trim(filtro)<> "" Then filtro = filtro + "and"
	filtro = filtro + " (almlinubica_calibre = " + em_calibre.text + ")"
END IF	

numero = uo_tipo.dw_marca.RowCount()
IF numero =0 Then return filtro


//tipos={""}

FOR x1 = 1 To numero
   IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
		//tipos[x1] = uo_tipo.dw_marca.GetItemString(x1,"codigo")
      y1=y1+1
      IF Trim(filtro) = "" Then
         filtro1 = " almlinubica_almacen = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
       Else
         filtro1 = " Or almlinubica_almacen = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      filtro = filtro  + filtro1
		filtro  = "(" + filtro + ")"
   END IF
NEXT

Return filtro


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

public subroutine f_control ();string is_filtro=""

dw_1.SetFilter("")
dw_1.Filter()
dw_1.SetFilter(f_filtro())
dw_1.Filter()

if uo_articulo.em_codigo.text <> "" and not isnull(uo_articulo.em_codigo.text) then
   dw_1.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
else
   dw_1.Retrieve(codigo_empresa,"%")
end if

end subroutine

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
This.title = " CONSULTA UBICACIONES POR ARTICULO"

uo_tipo.f_cargar_datos("dw_ayuda_almacenes","","","Código","Descripción")

f_activar_campo(uo_articulo.em_campo)


end event

on w_con_ubi_articulos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_articulo=create uo_articulo
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_calidad=create uo_calidad
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.st_3=create st_3
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.uo_1=create uo_1
this.dw_listado=create dw_listado
this.uo_tipo=create uo_tipo
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_continuar=create cb_continuar
this.st_1=create st_1
this.st_formato=create st_formato
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_articulo
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.uo_calidad
this.Control[iCurrent+5]=this.em_tono
this.Control[iCurrent+6]=this.em_calibre
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.uo_1
this.Control[iCurrent+12]=this.dw_listado
this.Control[iCurrent+13]=this.uo_tipo
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.dw_1
this.Control[iCurrent+16]=this.cb_continuar
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.st_formato
end on

on w_con_ubi_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_articulo)
destroy(this.pb_imprimir_preli)
destroy(this.uo_calidad)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.uo_1)
destroy(this.dw_listado)
destroy(this.uo_tipo)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_continuar)
destroy(this.st_1)
destroy(this.st_formato)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ubi_articulos
integer x = 91
integer y = 1292
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ubi_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ubi_articulos
integer y = 20
integer width = 2377
end type

type pb_2 from upb_salir within w_con_ubi_articulos
integer x = 3255
integer y = 28
integer width = 128
integer height = 112
integer taborder = 0
end type

type uo_articulo from u_em_campo_2 within w_con_ubi_articulos
integer x = 457
integer y = 212
integer width = 1074
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF
String mascara
mascara = f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text))
f_mascara_columna(dw_1,"existencias",mascara)
st_formato.text = f_nombre_formato(codigo_empresa,f_formato_articulo(codigo_empresa,uo_articulo.em_codigo.text))

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

type pb_imprimir_preli from picturebutton within w_con_ubi_articulos
integer x = 3287
integer y = 200
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

event clicked;

string is_filtro=""
dw_listado.SetFilter("")
dw_listado.Filter()
dw_listado.SetFilter(f_filtro())
dw_listado.Filter()

if uo_articulo.em_codigo.text <> "" and not isnull(uo_articulo.em_codigo.text) then
   dw_listado.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
else
   dw_listado.Retrieve(codigo_empresa,"%")
end if


f_imprimir_datawindow(dw_listado)





end event

type uo_calidad from u_em_campo_2 within w_con_ubi_articulos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1541
integer y = 212
integer width = 169
integer height = 88
integer taborder = 40
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




end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type em_tono from u_em_campo within w_con_ubi_articulos
integer x = 1714
integer y = 212
integer width = 114
integer height = 88
integer taborder = 50
alignment alignment = center!
string mask = "!!!!"
end type

type em_calibre from u_em_campo within w_con_ubi_articulos
integer x = 1838
integer y = 212
integer width = 91
integer height = 88
integer taborder = 70
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "#"
end type

type st_3 from statictext within w_con_ubi_articulos
integer x = 457
integer y = 132
integer width = 1079
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

type st_6 from statictext within w_con_ubi_articulos
integer x = 1541
integer y = 132
integer width = 169
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

type st_5 from statictext within w_con_ubi_articulos
integer x = 1714
integer y = 132
integer width = 119
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

type st_4 from statictext within w_con_ubi_articulos
integer x = 1838
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

type uo_1 from u_manejo_datawindow within w_con_ubi_articulos
integer x = 2811
integer y = 156
integer width = 617
integer height = 168
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_con_ubi_articulos
boolean visible = false
integer x = 2441
integer y = 28
integer width = 174
integer height = 132
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_con_ubi_articulos"
boolean livescroll = true
end type

type uo_tipo from u_marca_lista within w_con_ubi_articulos
boolean visible = false
integer x = 46
integer y = 424
integer width = 1454
integer taborder = 60
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type cb_1 from u_boton within w_con_ubi_articulos
event clicked pbm_bnclicked
integer x = 2368
integer y = 204
integer width = 430
integer height = 84
integer taborder = 80
string text = "&Continuar"
end type

event clicked;call super::clicked;uo_tipo.visible = False
f_control()
end event

type dw_1 from datawindow within w_con_ubi_articulos
integer x = 23
integer y = 344
integer width = 3593
integer height = 1548
string dataobject = "dw_con_ubi_articulos1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_continuar from u_boton within w_con_ubi_articulos
event clicked pbm_bnclicked
integer x = 1993
integer y = 204
integer width = 320
integer height = 84
integer taborder = 0
string text = "&Almacenes"
end type

event clicked;call super::clicked;if uo_tipo.visible = TRUE then
	uo_tipo.visible = False
 else
	uo_tipo.visible = TRUE
End if

end event

type st_1 from statictext within w_con_ubi_articulos
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

type st_formato from statictext within w_con_ubi_articulos
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

