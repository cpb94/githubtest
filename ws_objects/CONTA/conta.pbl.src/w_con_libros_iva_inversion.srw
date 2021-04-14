$PBExportHeader$w_con_libros_iva_inversion.srw
$PBExportComments$€
forward
global type w_con_libros_iva_inversion from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_libros_iva_inversion
end type
type uo_ejercicio from u_ejercicio within w_con_libros_iva_inversion
end type
type cb_detalle from u_boton within w_con_libros_iva_inversion
end type
type em_fecha_desde from u_em_campo within w_con_libros_iva_inversion
end type
type st_4 from statictext within w_con_libros_iva_inversion
end type
type em_fecha_hasta from u_em_campo within w_con_libros_iva_inversion
end type
type st_3 from statictext within w_con_libros_iva_inversion
end type
type pb_2 from upb_imprimir within w_con_libros_iva_inversion
end type
type dw_listado1 from datawindow within w_con_libros_iva_inversion
end type
type dw_asiento from datawindow within w_con_libros_iva_inversion
end type
type uo_libro from u_em_campo_2 within w_con_libros_iva_inversion
end type
type st_44 from statictext within w_con_libros_iva_inversion
end type
type dw_1 from datawindow within w_con_libros_iva_inversion
end type
end forward

global type w_con_libros_iva_inversion from w_int_con_empresa
integer width = 2930
integer height = 2104
pb_1 pb_1
uo_ejercicio uo_ejercicio
cb_detalle cb_detalle
em_fecha_desde em_fecha_desde
st_4 st_4
em_fecha_hasta em_fecha_hasta
st_3 st_3
pb_2 pb_2
dw_listado1 dw_listado1
dw_asiento dw_asiento
uo_libro uo_libro
st_44 st_44
dw_1 dw_1
end type
global w_con_libros_iva_inversion w_con_libros_iva_inversion

type variables
Datawindow data
String tipo = "1", libro

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();String 	tip,orig,cuen
DateTime fecha1,fecha2
Int		cuantas,tantas,i,p
Dec{0}	mes,asien
Boolean	inversion

dw_1.Reset()
data.visible = FALSE
inversion = FALSE

libro = Trim(uo_libro.em_codigo.text)

fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha_hasta.text))
tip = f_tipo_cta_libro(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,libro)
cuantas = data.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,libro,fecha1,fecha2,tip)

FOR i = 1 TO cuantas
	dw_asiento.Reset()
	mes	 = dw_1.GetItemNumber(i,"mes")
	asien	 = dw_1.GetItemNumber(i,"asiento")
	orig	 = dw_1.GetItemString(i,"origen")
	tantas = dw_asiento.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,mes,orig,asien)
	FOR p = 1 TO tantas	
		cuen = dw_asiento.GetItemString(p,"cuenta") 
		IF cuen > '522999999' AND cuen < '524000000' THEN
			inversion = TRUE
			EXIT
		ELSE
			inversion = FALSE
		END IF
	NEXT
	IF not inversion THEN
		dw_1.SetItem(i,"diario","S")
	ELSE
		dw_1.SetItem(i,"diario","N")
	END IF
NEXT

String	filtro

filtro = "diario = " + "'" +"N"+ "'"
dw_1.setfilter(filtro)
dw_1.filter()
dw_1.Sort()
dw_1.GroupCalc()

data.visible = TRUE
end subroutine

event open;call super::open;DateTime fecha
   dw_1.SetTransObject(SQLCA)
	dw_asiento.SetTransObject(SQLCA)
   dw_listado1.SetTransObject(SQLCA)
      
istr_parametros.s_titulo_ventana  = "Consulta libros de I.V.A. Por Inversión"
istr_parametros.s_listado         = ""
This.title = istr_parametros.s_titulo_ventana
uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))
   
data = dw_1
em_fecha_desde.text = String(MDY(Month(Today()),1,Year(Today())),"dd-mm-yy")
fecha = DateTime(MDY(Month(Today())+1,1,Year(Today())))
fecha = DateTime(RelativeDate(Date(fecha),-1))
em_fecha_hasta.text = String(Date(fecha),"dd-mm-yy")
// mascaras
f_mascara_columna(dw_1,"impfra",f_mascara_decimales(2))
f_mascara_columna(dw_1,"impiva",f_mascara_decimales(2))
f_mascara_columna(dw_1,"imponible",f_mascara_decimales(2))
f_mascara_columna(dw_1,"totalimpfra",f_mascara_decimales(2))
f_mascara_columna(dw_1,"totalimpiva",f_mascara_decimales(2))
f_mascara_columna(dw_1,"totalimponible",f_mascara_decimales(2))


f_activar_campo(em_fecha_desde)	
end event

on w_con_libros_iva_inversion.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_ejercicio=create uo_ejercicio
this.cb_detalle=create cb_detalle
this.em_fecha_desde=create em_fecha_desde
this.st_4=create st_4
this.em_fecha_hasta=create em_fecha_hasta
this.st_3=create st_3
this.pb_2=create pb_2
this.dw_listado1=create dw_listado1
this.dw_asiento=create dw_asiento
this.uo_libro=create uo_libro
this.st_44=create st_44
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.cb_detalle
this.Control[iCurrent+4]=this.em_fecha_desde
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.em_fecha_hasta
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.dw_listado1
this.Control[iCurrent+10]=this.dw_asiento
this.Control[iCurrent+11]=this.uo_libro
this.Control[iCurrent+12]=this.st_44
this.Control[iCurrent+13]=this.dw_1
end on

on w_con_libros_iva_inversion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_ejercicio)
destroy(this.cb_detalle)
destroy(this.em_fecha_desde)
destroy(this.st_4)
destroy(this.em_fecha_hasta)
destroy(this.st_3)
destroy(this.pb_2)
destroy(this.dw_listado1)
destroy(this.dw_asiento)
destroy(this.uo_libro)
destroy(this.st_44)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_libros_iva_inversion
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_libros_iva_inversion
integer x = 5
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_fecha_desde)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_libros_iva_inversion
integer x = 14
integer y = 8
integer width = 2546
end type

type pb_1 from upb_salir within w_con_libros_iva_inversion
integer x = 2711
integer y = 20
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type uo_ejercicio from u_ejercicio within w_con_libros_iva_inversion
integer x = 2199
integer y = 172
boolean bringtotop = true
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type cb_detalle from u_boton within w_con_libros_iva_inversion
integer x = 1751
integer y = 180
integer width = 293
integer height = 76
integer taborder = 40
string text = "Consulta"
end type

event clicked;call super::clicked;data = dw_1
f_control()
end event

type em_fecha_desde from u_em_campo within w_con_libros_iva_inversion
integer x = 242
integer y = 160
integer width = 279
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "œ"
end type

type st_4 from statictext within w_con_libros_iva_inversion
integer x = 507
integer y = 160
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

type em_fecha_hasta from u_em_campo within w_con_libros_iva_inversion
integer x = 549
integer y = 160
integer width = 283
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_3 from statictext within w_con_libros_iva_inversion
integer x = 850
integer y = 160
integer width = 178
integer height = 84
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

type pb_2 from upb_imprimir within w_con_libros_iva_inversion
integer x = 2053
integer y = 168
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;String 	tip,orig,cuen
DateTime fecha1,fecha2
Int		cuantas,tantas,i,p
Dec{0}	mes,asien
Boolean	inversion

dw_listado1.Reset()
data = dw_listado1
libro = Trim(uo_libro.em_codigo.text)
fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha_hasta.text))
cuantas = data.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,libro,fecha1,fecha2)

FOR i = 1 TO cuantas
	dw_asiento.Reset()
	mes	 = dw_listado1.GetItemNumber(i,"contaapun_mes")
	asien	 = dw_listado1.GetItemNumber(i,"contaapun_asiento")
	orig	 = dw_listado1.GetItemString(i,"contaapun_origen")
	tantas = dw_asiento.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,mes,orig,asien)
	FOR p = 1 TO tantas	
		cuen = dw_asiento.GetItemString(p,"cuenta") 
		IF cuen > '522999999' AND cuen < '524000000' THEN
			inversion = TRUE
			EXIT
		ELSE
			inversion = FALSE
		END IF
	NEXT
	IF not inversion THEN
		dw_listado1.SetItem(i,"contaapun_diario","S")
	END IF
NEXT

String	filtro

filtro = "contaapun_diario = " + "'" + "'"
dw_listado1.setfilter(filtro)
dw_listado1.filter()
dw_listado1.Sort()
dw_listado1.GroupCalc()

f_imprimir_datawindow(data)
f_activar_campo(em_fecha_desde)

end event

type dw_listado1 from datawindow within w_con_libros_iva_inversion
boolean visible = false
integer x = 320
integer y = 12
integer width = 421
integer height = 80
boolean bringtotop = true
string dataobject = "report_con_libros_iva_inversion"
boolean livescroll = true
end type

type dw_asiento from datawindow within w_con_libros_iva_inversion
boolean visible = false
integer x = 2245
integer y = 44
integer width = 421
integer height = 120
boolean bringtotop = true
string dataobject = "dw_con_libros_iva_inversion_asien"
boolean livescroll = true
end type

type uo_libro from u_em_campo_2 within w_con_libros_iva_inversion
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1042
integer y = 160
integer width = 699
integer taborder = 30
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

type st_44 from statictext within w_con_libros_iva_inversion
integer x = 23
integer y = 160
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

type dw_1 from datawindow within w_con_libros_iva_inversion
boolean visible = false
integer y = 288
integer width = 2843
integer height = 1592
string dataobject = "dw_con_libros_iva_inversion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

