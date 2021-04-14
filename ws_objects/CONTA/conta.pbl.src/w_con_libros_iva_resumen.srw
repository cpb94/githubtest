$PBExportHeader$w_con_libros_iva_resumen.srw
$PBExportComments$€
forward
global type w_con_libros_iva_resumen from w_int_con_empresa
end type
type st_2 from statictext within w_con_libros_iva_resumen
end type
type pb_1 from upb_salir within w_con_libros_iva_resumen
end type
type uo_ejercicio from u_ejercicio within w_con_libros_iva_resumen
end type
type uo_libro from u_em_campo_2 within w_con_libros_iva_resumen
end type
type cb_detalle from u_boton within w_con_libros_iva_resumen
end type
type em_fecha_desde from u_em_campo within w_con_libros_iva_resumen
end type
type st_4 from statictext within w_con_libros_iva_resumen
end type
type em_fecha_hasta from u_em_campo within w_con_libros_iva_resumen
end type
type st_3 from statictext within w_con_libros_iva_resumen
end type
type gb_1 from groupbox within w_con_libros_iva_resumen
end type
type pb_2 from upb_imprimir within w_con_libros_iva_resumen
end type
type dw_listado1 from datawindow within w_con_libros_iva_resumen
end type
type gb_2 from groupbox within w_con_libros_iva_resumen
end type
type dw_1 from datawindow within w_con_libros_iva_resumen
end type
end forward

global type w_con_libros_iva_resumen from w_int_con_empresa
integer width = 2949
integer height = 2152
st_2 st_2
pb_1 pb_1
uo_ejercicio uo_ejercicio
uo_libro uo_libro
cb_detalle cb_detalle
em_fecha_desde em_fecha_desde
st_4 st_4
em_fecha_hasta em_fecha_hasta
st_3 st_3
gb_1 gb_1
pb_2 pb_2
dw_listado1 dw_listado1
gb_2 gb_2
dw_1 dw_1
end type
global w_con_libros_iva_resumen w_con_libros_iva_resumen

type variables
Datawindow data
String tipo = "1"
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.visible = FALSE
dw_1.Reset()

String tip
data.visible = TRUE
DateTime  fecha1,fecha2
fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha_hasta.text))
tip = f_tipo_cta_libro(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_libro.em_codigo.text)
data.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_libro.em_codigo.text,fecha1,fecha2,tip)

end subroutine

event open;call super::open;DateTime fecha
   dw_1.SetTransObject(SQLCA)
   dw_listado1.SetTransObject(SQLCA)
   istr_parametros.s_titulo_ventana  = "Resumen ventas/compras "
	istr_parametros.s_listado         = ""
   This.title = istr_parametros.s_titulo_ventana
    uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_ejercicio.em_ejercicio.text=istr_parametros.s_argumentos[2]
      uo_libro.em_codigo.text=istr_parametros.s_argumentos[3]
      uo_libro.em_campo.text=f_nombre_contalibros(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_libro.em_codigo.text)
   END IF
data = dw_1
em_fecha_desde.text = String(MDY(Month(Today()),1,Year(Today())),"dd-mm-yy")
fecha = DateTime(MDY(Month(Today())+1,1,Year(Today())))
fecha = DateTime(RelativeDate(Date(fecha),-1))
em_fecha_hasta.text = String(Date(fecha),"dd-mm-yy")

f_activar_campo(uo_ejercicio.em_ejercicio)	

end event

on w_con_libros_iva_resumen.create
int iCurrent
call super::create
this.st_2=create st_2
this.pb_1=create pb_1
this.uo_ejercicio=create uo_ejercicio
this.uo_libro=create uo_libro
this.cb_detalle=create cb_detalle
this.em_fecha_desde=create em_fecha_desde
this.st_4=create st_4
this.em_fecha_hasta=create em_fecha_hasta
this.st_3=create st_3
this.gb_1=create gb_1
this.pb_2=create pb_2
this.dw_listado1=create dw_listado1
this.gb_2=create gb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.uo_ejercicio
this.Control[iCurrent+4]=this.uo_libro
this.Control[iCurrent+5]=this.cb_detalle
this.Control[iCurrent+6]=this.em_fecha_desde
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.em_fecha_hasta
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.dw_listado1
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.dw_1
end on

on w_con_libros_iva_resumen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.pb_1)
destroy(this.uo_ejercicio)
destroy(this.uo_libro)
destroy(this.cb_detalle)
destroy(this.em_fecha_desde)
destroy(this.st_4)
destroy(this.em_fecha_hasta)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.pb_2)
destroy(this.dw_listado1)
destroy(this.gb_2)
destroy(this.dw_1)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_libros_iva_resumen
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_libros_iva_resumen
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_libro.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_libros_iva_resumen
integer x = 14
integer y = 12
integer width = 2683
integer height = 112
end type

type st_2 from statictext within w_con_libros_iva_resumen
integer x = 859
integer y = 180
integer width = 183
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Libro:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_con_libros_iva_resumen
integer x = 2711
integer y = 20
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type uo_ejercicio from u_ejercicio within w_con_libros_iva_resumen
integer x = 2199
integer y = 172
integer taborder = 10
boolean bringtotop = true
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type uo_libro from u_em_campo_2 within w_con_libros_iva_resumen
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1051
integer y = 176
integer width = 567
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;String var_tipo_unidad,var_cliente
uo_libro.em_campo.text=f_nombre_contalibros(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_libro.em_codigo.text)
IF Trim(uo_libro.em_campo.text)="" THEN 
 IF Trim(uo_libro.em_codigo.text)<>"" Then 
	uo_libro.em_campo.SetFocus()
END IF
 uo_libro.em_campo.text=""
 uo_libro.em_codigo.text=""
 Return
END IF




 
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de libros"
ue_datawindow = "dw_ayuda_contalibros"
ue_filtro     = "ejercicio = " + uo_ejercicio.em_ejercicio.text

end event

on uo_libro.destroy
call u_em_campo_2::destroy
end on

type cb_detalle from u_boton within w_con_libros_iva_resumen
integer x = 1678
integer y = 164
integer width = 338
integer height = 96
integer taborder = 50
string text = "&Continuar"
end type

event clicked;call super::clicked;data = dw_1
tipo= "1"
f_control()
end event

type em_fecha_desde from u_em_campo within w_con_libros_iva_resumen
integer x = 242
integer y = 180
integer width = 279
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "œ"
end type

type st_4 from statictext within w_con_libros_iva_resumen
integer x = 507
integer y = 180
integer width = 41
integer height = 84
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_hasta from u_em_campo within w_con_libros_iva_resumen
integer x = 549
integer y = 180
integer width = 283
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_3 from statictext within w_con_libros_iva_resumen
integer x = 23
integer y = 180
integer width = 210
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_libros_iva_resumen
integer x = 9
integer y = 128
integer width = 841
integer height = 152
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_2 from upb_imprimir within w_con_libros_iva_resumen
integer x = 2021
integer y = 164
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;dw_listado1.Reset()
sTRING TIP
DateTime  fecha1,fecha2
data = dw_listado1
fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha_hasta.text))
tip = f_tipo_cta_libro(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_libro.em_codigo.text)
data.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_libro.em_codigo.text,fecha1,fecha2,tip)
f_imprimir_datawindow(data)
f_activar_campo(uo_libro.em_campo)

end event

type dw_listado1 from datawindow within w_con_libros_iva_resumen
boolean visible = false
integer width = 421
integer height = 80
boolean bringtotop = true
string dataobject = "report_con_libros_iva_resumen1"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_libros_iva_resumen
integer x = 1664
integer y = 128
integer width = 485
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_1 from datawindow within w_con_libros_iva_resumen
boolean visible = false
integer y = 296
integer width = 2843
integer height = 1588
string dataobject = "dw_con_libros_iva_resumen"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

