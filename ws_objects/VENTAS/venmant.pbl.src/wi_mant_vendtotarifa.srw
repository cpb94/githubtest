$PBExportHeader$wi_mant_vendtotarifa.srw
$PBExportComments$Mant. lineas de tarifas.
forward
global type wi_mant_vendtotarifa from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_mant_vendtotarifa
end type
type st_1 from statictext within wi_mant_vendtotarifa
end type
type dw_datos from datawindow within wi_mant_vendtotarifa
end type
type dw_listado from datawindow within wi_mant_vendtotarifa
end type
type pb_imprimir from upb_imprimir within wi_mant_vendtotarifa
end type
type uo_articulo from u_em_campo_2 within wi_mant_vendtotarifa
end type
type cb_consulta from u_boton within wi_mant_vendtotarifa
end type
type cb_2 from commandbutton within wi_mant_vendtotarifa
end type
type uo_tarifa from u_em_campo_2 within wi_mant_vendtotarifa
end type
type st_2 from statictext within wi_mant_vendtotarifa
end type
type st_3 from statictext within wi_mant_vendtotarifa
end type
type uo_calidad from u_em_campo_2 within wi_mant_vendtotarifa
end type
type pb_anyadir from picturebutton within wi_mant_vendtotarifa
end type
type pb_borrar from picturebutton within wi_mant_vendtotarifa
end type
type pb_grabar from picturebutton within wi_mant_vendtotarifa
end type
end forward

global type wi_mant_vendtotarifa from w_int_con_empresa
integer x = 315
integer y = 32
integer width = 4681
integer height = 3228
long backcolor = 32238571
pb_1 pb_1
st_1 st_1
dw_datos dw_datos
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_articulo uo_articulo
cb_consulta cb_consulta
cb_2 cb_2
uo_tarifa uo_tarifa
st_2 st_2
st_3 st_3
uo_calidad uo_calidad
pb_anyadir pb_anyadir
pb_borrar pb_borrar
pb_grabar pb_grabar
end type
global wi_mant_vendtotarifa wi_mant_vendtotarifa

type variables

end variables

on wi_mant_vendtotarifa.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_datos=create dw_datos
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_articulo=create uo_articulo
this.cb_consulta=create cb_consulta
this.cb_2=create cb_2
this.uo_tarifa=create uo_tarifa
this.st_2=create st_2
this.st_3=create st_3
this.uo_calidad=create uo_calidad
this.pb_anyadir=create pb_anyadir
this.pb_borrar=create pb_borrar
this.pb_grabar=create pb_grabar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_datos
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.uo_articulo
this.Control[iCurrent+7]=this.cb_consulta
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.uo_tarifa
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.uo_calidad
this.Control[iCurrent+13]=this.pb_anyadir
this.Control[iCurrent+14]=this.pb_borrar
this.Control[iCurrent+15]=this.pb_grabar
end on

on wi_mant_vendtotarifa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_datos)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_articulo)
destroy(this.cb_consulta)
destroy(this.cb_2)
destroy(this.uo_tarifa)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.uo_calidad)
destroy(this.pb_anyadir)
destroy(this.pb_borrar)
destroy(this.pb_grabar)
end on

event open;call super::open;

istr_parametros.s_titulo_ventana =   "Descuentos par Tarifa y Artículo"
//istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana


dw_datos.SetTransObject(SQLCA)
dw_datos.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(uo_tarifa.em_campo)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_datos)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_datos)
end event

event ue_listar;//string articulo

//if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el artículo")
//	f_activar_campo(uo_1.em_campo)
//	return
////	articulo = "%"
//else
//	articulo = uo_1.em_codigo.text
//end if
//dw_1.Retrieve(codigo_empresa,articulo)
dw_report =dw_datos
Call Super::ue_listar
end event

event activate;call super::activate;w_con_historia_articulo = ventanas_activas[id_ventana_activa].ventana
end event

event closequery;call super::closequery;boolean resultado

dw_datos.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco

if dw_datos.DeletedCount() + dw_datos.ModifiedCount() > 0 then
	resultado = true
end if


if resultado and permiso_ventana > 1 then
	if MessageBox("Atención", "¿Desea grabar las modificaciones?", Exclamation!, YesNo!, 2) = 1 then
		pb_grabar.triggerevent(clicked!)
	end if
end if
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_vendtotarifa
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_vendtotarifa
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_tarifa.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_vendtotarifa
integer width = 4608
integer height = 84
end type

type pb_1 from upb_salir within wi_mant_vendtotarifa
integer x = 4421
integer y = 268
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\tencer_PB12\Log Out_24x24.png"
string powertiptext = "Salir"
end type

type st_1 from statictext within wi_mant_vendtotarifa
integer x = 55
integer y = 212
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 32238571
boolean enabled = false
string text = "Artículo:"
alignment alignment = center!
long bordercolor = 32238571
boolean focusrectangle = false
end type

type dw_datos from datawindow within wi_mant_vendtotarifa
integer x = 32
integer y = 428
integer width = 4562
integer height = 2556
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_mant_vendtotarifa"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_listado from datawindow within wi_mant_vendtotarifa
boolean visible = false
integer width = 521
integer height = 208
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_formatos_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_mant_vendtotarifa
event clicked pbm_bnclicked
integer x = 4210
integer y = 268
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = false
string picturename = "C:\tencer_PB12\printer-icon2_24x24.png"
string powertiptext = "Imprimir"
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF


parent.triggerEvent("ue_listar")
f_activar_campo(uo_tarifa.em_campo)
end event

type uo_articulo from u_em_campo_2 within wi_mant_vendtotarifa
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 325
integer y = 212
integer width = 1678
integer taborder = 20
boolean border = true
long backcolor = 32238571
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
else

end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Articulos"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type cb_consulta from u_boton within wi_mant_vendtotarifa
integer x = 2053
integer y = 272
integer width = 315
integer height = 128
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;call super::clicked;string tarifa = '%', articulo = '%', calidad = '%'

if uo_tarifa.em_codigo.text <> '' then
	tarifa = uo_tarifa.em_codigo.text
end if
if uo_articulo.em_codigo.text <> '' then
	articulo = uo_articulo.em_codigo.text
end if
if uo_calidad.em_codigo.text <> '' then
	calidad = uo_calidad.em_codigo.text
end if


dw_datos.retrieve (codigo_empresa, tarifa, articulo, calidad)
end event

type cb_2 from commandbutton within wi_mant_vendtotarifa
boolean visible = false
integer x = 2043
integer y = 116
integer width = 416
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Coste Prueba"
end type

type uo_tarifa from u_em_campo_2 within wi_mant_vendtotarifa
integer x = 325
integer y = 116
integer width = 1678
integer taborder = 10
boolean bringtotop = true
boolean border = true
long backcolor = 32238571
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_tarifa.em_campo.text=f_nombre_ventarifa(codigo_empresa,uo_tarifa.em_codigo.text)
If Trim(uo_tarifa.em_campo.text)="" then
	uo_tarifa.em_campo.text=""
	uo_tarifa.em_codigo.text=""
	Return
else

end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Tarifas"
ue_datawindow ="dw_ayuda_ventarifas"
ue_filtro = ""
end event

on uo_tarifa.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within wi_mant_vendtotarifa
integer x = 82
integer y = 116
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 32238571
boolean enabled = false
string text = "Tarifa:"
alignment alignment = center!
long bordercolor = 32238571
boolean focusrectangle = false
end type

type st_3 from statictext within wi_mant_vendtotarifa
integer x = 55
integer y = 308
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 32238571
boolean enabled = false
string text = "Calidad:"
alignment alignment = center!
long bordercolor = 32238571
boolean focusrectangle = false
end type

type uo_calidad from u_em_campo_2 within wi_mant_vendtotarifa
integer x = 325
integer y = 308
integer width = 1678
integer taborder = 30
boolean bringtotop = true
boolean border = true
long backcolor = 32238571
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_calidad.em_campo.text=f_nombre_calidad(codigo_empresa,uo_calidad.em_codigo.text)
If Trim(uo_calidad.em_campo.text)="" then
	uo_calidad.em_campo.text=""
	uo_calidad.em_codigo.text=""
	Return
else

end if 

cb_consulta.triggerevent(clicked!)
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Calidades"
ue_datawindow ="dw_ayuda_calidades"
ue_filtro = ""
end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type pb_anyadir from picturebutton within wi_mant_vendtotarifa
integer x = 3781
integer y = 268
integer width = 146
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;integer nueva_fila
string unidad, des_unidad

if uo_tarifa.em_codigo.text = '' then
	messagebox ("Tarifa", "Debe introducir una tarifa")
	uo_tarifa.setfocus()
	return;
end if
if uo_articulo.em_codigo.text = ''  then
	messagebox ("Tarifa", "Debe introducir un artículo")
	uo_articulo.setfocus()
	return;
end if
if uo_calidad.em_codigo.text = ''   then
	messagebox ("Tarifa", "Debe introducir la calidad")
	uo_calidad.setfocus()
	return;
end if

select articulos.unidad
into :unidad
from articulos 
where articulos.empresa = :codigo_empresa
and codigo = :uo_articulo.em_codigo.text;

nueva_fila = dw_datos.InsertRow(0)

dw_datos.object.vendtotarifa_empresa[nueva_fila] = codigo_empresa
dw_datos.object.vendtotarifa_tarifa[nueva_fila] = uo_tarifa.em_codigo.text
dw_datos.object.ventarifas_descripcion[nueva_fila] = uo_tarifa.em_campo.text
dw_datos.object.vendtotarifa_articulo[nueva_fila] = uo_articulo.em_codigo.text
dw_datos.object.articulos_descripcion[nueva_fila] = uo_articulo.em_campo.text
dw_datos.object.unidades_abreviado[nueva_fila] = f_nombre_unidad_abr (unidad)
dw_datos.object.vendtotarifa_calidad[nueva_fila] = uo_calidad.em_codigo.text
dw_datos.object.calidades_descripcion[nueva_fila] = uo_calidad.em_campo.text

dw_datos.ScrollToRow(nueva_fila)
dw_datos.SelectRow(0, false)
dw_datos.SelectRow(nueva_fila, true)

dw_datos.SetFocus()
end event

type pb_borrar from picturebutton within wi_mant_vendtotarifa
integer x = 3927
integer y = 268
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
string powertiptext = "Eliminar Registro"
end type

event clicked;dw_datos.deleterow(dw_Datos.getrow())
end event

type pb_grabar from picturebutton within wi_mant_vendtotarifa
integer x = 4069
integer y = 268
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\tencer_PB12\Save_24x24.png"
alignment htextalign = left!
string powertiptext = "Grabar"
end type

event clicked;integer rtn

CONNECT USING SQLCA;

rtn = dw_Datos.Update()

IF rtn = 1 THEN        
	COMMIT USING SQLCA;
ELSE        
	ROLLBACK USING SQLCA;
END IF
end event

