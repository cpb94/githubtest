$PBExportHeader$w_con_libros_facturas_recibidas.srw
$PBExportComments$€
forward
global type w_con_libros_facturas_recibidas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_libros_facturas_recibidas
end type
type cb_detalle from u_boton within w_con_libros_facturas_recibidas
end type
type em_fecha_desde from u_em_campo within w_con_libros_facturas_recibidas
end type
type st_4 from statictext within w_con_libros_facturas_recibidas
end type
type em_fecha_hasta from u_em_campo within w_con_libros_facturas_recibidas
end type
type st_3 from statictext within w_con_libros_facturas_recibidas
end type
type gb_1 from groupbox within w_con_libros_facturas_recibidas
end type
type cb_resumen from u_boton within w_con_libros_facturas_recibidas
end type
type pb_2 from upb_imprimir within w_con_libros_facturas_recibidas
end type
type dw_listado1 from datawindow within w_con_libros_facturas_recibidas
end type
type gb_2 from groupbox within w_con_libros_facturas_recibidas
end type
type dw_resumen from datawindow within w_con_libros_facturas_recibidas
end type
type dw_1 from datawindow within w_con_libros_facturas_recibidas
end type
type uo_ejercicio from u_ejercicio within w_con_libros_facturas_recibidas
end type
type dw_listado2 from datawindow within w_con_libros_facturas_recibidas
end type
type cb_1 from u_boton within w_con_libros_facturas_recibidas
end type
end forward

global type w_con_libros_facturas_recibidas from w_int_con_empresa
integer width = 3607
integer height = 3652
pb_1 pb_1
cb_detalle cb_detalle
em_fecha_desde em_fecha_desde
st_4 st_4
em_fecha_hasta em_fecha_hasta
st_3 st_3
gb_1 gb_1
cb_resumen cb_resumen
pb_2 pb_2
dw_listado1 dw_listado1
gb_2 gb_2
dw_resumen dw_resumen
dw_1 dw_1
uo_ejercicio uo_ejercicio
dw_listado2 dw_listado2
cb_1 cb_1
end type
global w_con_libros_facturas_recibidas w_con_libros_facturas_recibidas

type variables
Datawindow data
String tipo = "1"
end variables

forward prototypes
public subroutine f_control ()
public function long f_calcula_contador (string empresa, integer ejercicio, datetime fecha)
end prototypes

public subroutine f_control ();String   tip1,tip2,tip3
DateTime fecha1,fecha2
Long     contador,total,i

dw_1.Reset()
dw_resumen.Reset()
contador = 0

fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha_hasta.text))
		
dw_1.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,fecha1,fecha2)
dw_resumen.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,fecha1,fecha2)

//contador = f_calcula_contador(codigo_empresa,Dec(uo_ejercicio.em_ejercicio.text),fecha1)
//contador ++
dw_1.SetRedraw(TRUE)
dw_1.SetSort("fregistro A,registro A")
dw_1.Sort()
//total = dw_1.RowCount()
//for i = 1 to total
//	dw_1.Setitem(i,"registro",contador)
//	contador++
//next
dw_1.SetRedraw(TRUE)
end subroutine

public function long f_calcula_contador (string empresa, integer ejercicio, datetime fecha);Long registros
  
SELECT count(*)
INTO :registros
FROM contaapun  
WHERE ( contaapun.ejercicio = :ejercicio ) AND  
		( contaapun.empresa = :empresa ) AND  
		( (contaapun.tipoapu = "2" OR
			contaapun.tipoapu = "7" OR
			contaapun.tipoapu = "9") ) AND  
		( contaapun.fregistro < :fecha );    
		
if isnull(registros) then registros = 0

return registros
end function

event open;call super::open;DateTime fecha

dw_1.SetTransObject(SQLCA)
dw_listado1.SetTransObject(SQLCA)
dw_listado2.SetTransObject(SQLCA)
dw_resumen.SetTransObject(SQLCA)

istr_parametros.s_titulo_ventana  = "Consulta Libros de IVA Oficiales Facturas Recibidas"
istr_parametros.s_listado         = ""
This.title = istr_parametros.s_titulo_ventana
uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))

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

on w_con_libros_facturas_recibidas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_detalle=create cb_detalle
this.em_fecha_desde=create em_fecha_desde
this.st_4=create st_4
this.em_fecha_hasta=create em_fecha_hasta
this.st_3=create st_3
this.gb_1=create gb_1
this.cb_resumen=create cb_resumen
this.pb_2=create pb_2
this.dw_listado1=create dw_listado1
this.gb_2=create gb_2
this.dw_resumen=create dw_resumen
this.dw_1=create dw_1
this.uo_ejercicio=create uo_ejercicio
this.dw_listado2=create dw_listado2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_detalle
this.Control[iCurrent+3]=this.em_fecha_desde
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.em_fecha_hasta
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.cb_resumen
this.Control[iCurrent+9]=this.pb_2
this.Control[iCurrent+10]=this.dw_listado1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.dw_resumen
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.uo_ejercicio
this.Control[iCurrent+15]=this.dw_listado2
this.Control[iCurrent+16]=this.cb_1
end on

on w_con_libros_facturas_recibidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_detalle)
destroy(this.em_fecha_desde)
destroy(this.st_4)
destroy(this.em_fecha_hasta)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.cb_resumen)
destroy(this.pb_2)
destroy(this.dw_listado1)
destroy(this.gb_2)
destroy(this.dw_resumen)
destroy(this.dw_1)
destroy(this.uo_ejercicio)
destroy(this.dw_listado2)
destroy(this.cb_1)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_libros_facturas_recibidas
integer x = 69
integer y = 1104
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_libros_facturas_recibidas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_libros_facturas_recibidas
integer y = 24
integer width = 2670
end type

type pb_1 from upb_salir within w_con_libros_facturas_recibidas
integer x = 2711
integer y = 20
integer width = 105
integer height = 104
integer taborder = 0
end type

type cb_detalle from u_boton within w_con_libros_facturas_recibidas
integer x = 1719
integer y = 176
integer width = 293
integer height = 100
integer taborder = 40
string text = "Consulta"
end type

event clicked;tipo= "1"
f_control()
end event

type em_fecha_desde from u_em_campo within w_con_libros_facturas_recibidas
integer x = 242
integer y = 180
integer width = 279
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "œ"
end type

type st_4 from statictext within w_con_libros_facturas_recibidas
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

type em_fecha_hasta from u_em_campo within w_con_libros_facturas_recibidas
integer x = 549
integer y = 180
integer width = 283
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_3 from statictext within w_con_libros_facturas_recibidas
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

type gb_1 from groupbox within w_con_libros_facturas_recibidas
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

type cb_resumen from u_boton within w_con_libros_facturas_recibidas
event clicked pbm_bnclicked
boolean visible = false
integer x = 1719
integer y = 212
integer width = 293
integer height = 64
integer taborder = 50
boolean enabled = false
string text = "&Resumen"
end type

event clicked;call super::clicked;data = dw_resumen
tipo = "2"
f_control()

f_activar_campo(em_fecha_desde)
end event

type pb_2 from upb_imprimir within w_con_libros_facturas_recibidas
integer x = 2021
integer y = 176
integer height = 100
integer taborder = 0
boolean originalsize = false
end type

event clicked;DateTime fecha1,fecha2
Long contador,i,total

dw_listado1.Reset()

fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha_hasta.text))

dw_listado1.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,fecha1,fecha2)
//dw_listado1.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,DateTime(date('01-05-05')),DateTime(date('31-12-05')))

//contador = f_calcula_contador(codigo_empresa,Dec(uo_ejercicio.em_ejercicio.text),fecha1)
//contador ++

//dw_listado1.SetSort("fregistro A,registro A")
dw_listado1.SetSort("")
dw_listado1.Sort()
//total = dw_listado1.RowCount()
//for i = 1 to total
//	dw_listado1.Setitem(i,"registro",contador)
//	contador++
//next
f_imprimir_datawindow(dw_listado1)
f_activar_campo(em_fecha_desde)	

end event

type dw_listado1 from datawindow within w_con_libros_facturas_recibidas
boolean visible = false
integer x = 773
integer y = 480
integer width = 1509
integer height = 628
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_con_libros_facturas_recibidas"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_libros_facturas_recibidas
integer x = 1705
integer y = 136
integer width = 443
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_resumen from datawindow within w_con_libros_facturas_recibidas
integer x = 18
integer y = 1296
integer width = 2839
integer height = 2120
string dataobject = "dw_con_libros_facturas_recibidas_resumen"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within w_con_libros_facturas_recibidas
integer x = 18
integer y = 288
integer width = 3186
integer height = 984
string dataobject = "dw_con_libros_facturas_recibidas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type uo_ejercicio from u_ejercicio within w_con_libros_facturas_recibidas
integer x = 2199
integer y = 172
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_listado2 from datawindow within w_con_libros_facturas_recibidas
boolean visible = false
integer x = 3013
integer y = 1552
integer width = 375
integer height = 568
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_libros_facturas_recibidas2"
boolean livescroll = true
end type

type cb_1 from u_boton within w_con_libros_facturas_recibidas
integer x = 1033
integer y = 168
integer width = 608
integer height = 100
integer taborder = 50
boolean bringtotop = true
string text = "Imprimir Resumen"
end type

event clicked;DateTime fecha1,fecha2
Long contador,i,total

dw_listado1.Reset()

fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha_hasta.text))

dw_listado2.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,fecha1,fecha2)
//dw_listado1.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,DateTime(date('01-05-05')),DateTime(date('31-12-05')))

//contador = f_calcula_contador(codigo_empresa,Dec(uo_ejercicio.em_ejercicio.text),fecha1)
//contador ++

//dw_listado1.SetSort("fregistro A,registro A")
dw_listado2.SetSort("")
dw_listado2.Sort()
//total = dw_listado1.RowCount()
//for i = 1 to total
//	dw_listado1.Setitem(i,"registro",contador)
//	contador++
//next
f_imprimir_datawindow(dw_listado2)
f_activar_campo(em_fecha_desde)	

end event

