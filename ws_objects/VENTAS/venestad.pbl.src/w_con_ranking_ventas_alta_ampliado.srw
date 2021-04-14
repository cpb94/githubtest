$PBExportHeader$w_con_ranking_ventas_alta_ampliado.srw
forward
global type w_con_ranking_ventas_alta_ampliado from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ranking_ventas_alta_ampliado
end type
type pb_2 from upb_imprimir within w_con_ranking_ventas_alta_ampliado
end type
type cb_1 from commandbutton within w_con_ranking_ventas_alta_ampliado
end type
type gb_6 from groupbox within w_con_ranking_ventas_alta_ampliado
end type
type dw_resumen from datawindow within w_con_ranking_ventas_alta_ampliado
end type
type st_3 from statictext within w_con_ranking_ventas_alta_ampliado
end type
type st_4 from statictext within w_con_ranking_ventas_alta_ampliado
end type
type st_2 from statictext within w_con_ranking_ventas_alta_ampliado
end type
type em_desde_ventas from editmask within w_con_ranking_ventas_alta_ampliado
end type
type st_1 from statictext within w_con_ranking_ventas_alta_ampliado
end type
type em_hasta_ventas from editmask within w_con_ranking_ventas_alta_ampliado
end type
type cbx_sin_ventas from checkbox within w_con_ranking_ventas_alta_ampliado
end type
type st_5 from statictext within w_con_ranking_ventas_alta_ampliado
end type
type em_desde from editmask within w_con_ranking_ventas_alta_ampliado
end type
type st_6 from statictext within w_con_ranking_ventas_alta_ampliado
end type
type em_hasta from editmask within w_con_ranking_ventas_alta_ampliado
end type
type st_7 from statictext within w_con_ranking_ventas_alta_ampliado
end type
type gb_1 from groupbox within w_con_ranking_ventas_alta_ampliado
end type
type gb_2 from groupbox within w_con_ranking_ventas_alta_ampliado
end type
type gb_3 from groupbox within w_con_ranking_ventas_alta_ampliado
end type
end forward

global type w_con_ranking_ventas_alta_ampliado from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 5193
integer height = 3140
long backcolor = 67108864
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_resumen dw_resumen
st_3 st_3
st_4 st_4
st_2 st_2
em_desde_ventas em_desde_ventas
st_1 st_1
em_hasta_ventas em_hasta_ventas
cbx_sin_ventas cbx_sin_ventas
st_5 st_5
em_desde em_desde
st_6 st_6
em_hasta em_hasta
st_7 st_7
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_con_ranking_ventas_alta_ampliado w_con_ranking_ventas_alta_ampliado

type variables
String orden_informe
end variables

forward prototypes
public subroutine f_recalcular_porcentajes ()
end prototypes

public subroutine f_recalcular_porcentajes ();Long i
Dec acumulado_ventas = 0, acumulado_altas = 0, acumulado_colecciones = 0, acumulado_modelos = 0, acumulado_trabajos = 0

For i = 1 To dw_resumen.rowcount()
	acumulado_ventas += dw_resumen.object.porcentaje_ventas[i]
	acumulado_altas += dw_resumen.object.porcentaje_altas[i]
	acumulado_colecciones += dw_resumen.object.porcentaje_colecciones[i]
	acumulado_modelos += dw_resumen.object.porcentaje_modelos[i]
	acumulado_trabajos += dw_resumen.object.porcentaje_trabajos[i]
	
	dw_resumen.object.acumulado_ventas[i] = acumulado_ventas
	dw_resumen.object.acumulado_altas[i] = acumulado_altas
	dw_resumen.object.acumulado_colecciones[i] = acumulado_colecciones
	dw_resumen.object.acumulado_modelos[i] = acumulado_modelos
	dw_resumen.object.acumulado_trabajos[i] = acumulado_trabajos	
Next
end subroutine

event close;call super::close;
//dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Ranking de Ventas por Alta y Modelo"
This.title=istr_parametros.s_titulo_ventana

em_hasta.text = String(today(), 'dd-mm-yyyy')
em_desde.text = String(RelativeDate (today(), -365), 'dd-mm-yyyy')
em_hasta_ventas.text = em_hasta.text
em_desde_ventas.text = em_desde.text
orden_informe = "ventas_alta D"
end event

on w_con_ranking_ventas_alta_ampliado.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_resumen=create dw_resumen
this.st_3=create st_3
this.st_4=create st_4
this.st_2=create st_2
this.em_desde_ventas=create em_desde_ventas
this.st_1=create st_1
this.em_hasta_ventas=create em_hasta_ventas
this.cbx_sin_ventas=create cbx_sin_ventas
this.st_5=create st_5
this.em_desde=create em_desde
this.st_6=create st_6
this.em_hasta=create em_hasta
this.st_7=create st_7
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_resumen
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.em_desde_ventas
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.em_hasta_ventas
this.Control[iCurrent+12]=this.cbx_sin_ventas
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.em_desde
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.em_hasta
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.gb_2
this.Control[iCurrent+20]=this.gb_3
end on

on w_con_ranking_ventas_alta_ampliado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_resumen)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.em_desde_ventas)
destroy(this.st_1)
destroy(this.em_hasta_ventas)
destroy(this.cbx_sin_ventas)
destroy(this.st_5)
destroy(this.em_desde)
destroy(this.st_6)
destroy(this.em_hasta)
destroy(this.st_7)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_f5;//f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ranking_ventas_alta_ampliado
integer x = 841
integer y = 1204
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ranking_ventas_alta_ampliado
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ranking_ventas_alta_ampliado
integer x = 14
integer y = 8
integer width = 5106
integer height = 80
integer textsize = -9
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 553648127
end type

type pb_1 from upb_salir within w_con_ranking_ventas_alta_ampliado
integer x = 4974
integer y = 136
integer width = 110
integer height = 96
integer taborder = 0
string text = "1"
end type

type pb_2 from upb_imprimir within w_con_ranking_ventas_alta_ampliado
integer x = 4818
integer y = 136
integer taborder = 0
end type

event clicked;f_imprimir_datawindow(dw_resumen)

end event

type cb_1 from commandbutton within w_con_ranking_ventas_alta_ampliado
integer x = 4521
integer y = 136
integer width = 288
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;Datetime fecha_desde, fecha_hasta
String sel, hasta, desde, desde_ventas, hasta_ventas
Datastore clientes
Long i, numero, fila, rtn = 1
String cliente
Dec ventas, altas, colecciones, modelos, trabajos

dw_resumen.reset()

em_desde.GetData(fecha_desde)
em_hasta.GetData(fecha_hasta)
desde_ventas = em_desde_ventas.text
hasta_ventas = em_hasta_ventas.text
desde = em_desde.text
hasta = em_hasta.text
dw_resumen.object.titulo.text = "Ranking de Ventas por Alta y Modelo (" + desde + " a " +hasta+")"

sel =  "	SELECT genter.codigo, "+&
		"	genter.razon, "+&
		"	(SELECT COUNT(DISTINCT v.articulo) "+&
		"		FROM articulos INNER JOIN venlifac v ON articulos.empresa = v.empresa AND articulos.codigo = v.articulo "+&
		"		WHERE articulos.cliente = genter.codigo AND articulos.uso = '3' "+&
		"		AND v.ffactura > '"+desde+"' "+&
		"		AND v.ffactura < '"+hasta+"') AS altas, "+&
		"	(SELECT COUNT(DISTINCT descoleccionsol.codigo) "+&
		"		FROM deshistorico "+&
		"		INNER JOIN descoleccionsol ON deshistorico.empresa = descoleccionsol.empresa AND deshistorico.coleccion = descoleccionsol.codigo "+&
		"		WHERE deshistorico.cliente = genter.codigo "+&
		"		AND descoleccionsol.fecha_coleccion > '"+desde+"' "+&
		"		AND descoleccionsol.fecha_coleccion < '"+hasta+"') AS colecciones, "+&
		"	(SELECT COUNT(DISTINCT modelo_cliente.modelo) "+&
		"		FROM modelo_cliente "+&
		"		INNER JOIN modelo ON modelo_cliente.empresa = modelo.empresa AND modelo_cliente.modelo = modelo.modelo "+&
		"		WHERE modelo_cliente.cliente = genter.codigo "+&
		"		AND EXISTS (SELECT * FROM modelo_trabajo T1 "+&
		"						WHERE T1.empresa = modelo.empresa "+&
		"						AND T1.modelo = modelo.modelo "+&
		"						AND T1.cliente = genter.codigo "+&
		"						AND T1.fecha_fin >= '"+desde+"' "+&
		"						AND T1.fecha_fin <= '"+hasta+"' "+&
		"						AND T1.fecha_fin = (SELECT MIN(T2.fecha_fin) FROM modelo_trabajo T2 "+&
		"													WHERE T2.empresa = modelo.empresa "+&
		"													AND T2.modelo = modelo.modelo))) AS modelos, "+&
		"	(SELECT COUNT(modelo_trabajo.codigo) "+&
		"		FROM modelo_trabajo "+&
		"		WHERE modelo_trabajo.cliente = genter.codigo "+&
		"		AND modelo_trabajo.fecha_fin > '"+desde+"' "+&
		"		AND modelo_trabajo.fecha_fin < '"+hasta+"') AS trabajos, "+&
		"	sum(venlifac.neto / venlifac.cambio) as importe "+&
		"	FROM	venlifac INNER JOIN genter ON venlifac.empresa = genter.empresa AND venlifac.cliente = genter.codigo AND genter.tipoter = 'C'  "+&
  		"   WHERE genter.empresa = '"+codigo_empresa +"' "+&
		"	AND venlifac.ffactura > '"+desde_ventas+"' "+&
		"	AND venlifac.ffactura < '"+hasta_ventas+"' "+&
		"	GROUP BY genter.codigo, genter.razon"
		
f_cargar_cursor_trans (sqlca,  sel, clientes)
numero = clientes.RowCount()
i = 1
do while (i <= numero AND rtn = 1) 
	cliente = clientes.GetItemString(i, 2)
	altas = Dec(clientes.GetItemNumber(i, 3))
	colecciones = Dec(clientes.GetItemNumber(i, 4))
	modelos = Dec(clientes.GetItemNumber(i, 5))
	trabajos = Dec(clientes.GetItemNumber(i, 6))
	ventas = Dec(clientes.GetItemDecimal(i, 7))
	
	fila = dw_resumen.insertrow(0)
	dw_resumen.object.cliente[fila] = cliente
	dw_resumen.object.altas[fila] = altas 
	dw_resumen.object.colecciones[fila] = colecciones
	dw_resumen.object.modelos[fila] = modelos
	dw_resumen.object.trabajos[fila] = trabajos
	dw_resumen.object.ventas[fila] = ventas
	
	i++
loop

dw_resumen.setsort(orden_informe)
dw_resumen.sort()

if not cbx_sin_ventas.checked then
	dw_resumen.setfilter("ventas <> 0")
else 
	dw_resumen.setfilter("")
end if
dw_resumen.filter()

f_recalcular_porcentajes()

Destroy clientes
end event

type gb_6 from groupbox within w_con_ranking_ventas_alta_ampliado
integer x = 4503
integer y = 96
integer width = 439
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
end type

type dw_resumen from datawindow within w_con_ranking_ventas_alta_ampliado
integer x = 27
integer y = 284
integer width = 5088
integer height = 2508
string dataobject = "dwtc_con_ranking_ventas_alta_ampliado"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;if dwo.name = "t_cliente" then
	orden_informe = "cliente A"
elseif dwo.name = "t_ventas" then
	orden_informe = "ventas D"
elseif dwo.name = "t_porcentaje_ventas" then
	orden_informe = "porcentaje_ventas D"
elseif dwo.name = "t_altas" then
	orden_informe = "altas D"
elseif dwo.name = "t_porcentaje_altas" then
	orden_informe = "porcentaje_altas D"
elseif dwo.name = "t_colecciones" then
	orden_informe = "colecciones D"
elseif dwo.name = "t_porcentaje_colecciones" then
	orden_informe = "porcentaje_colecciones D"
elseif dwo.name = "t_modelos" then
	orden_informe = "modelos D"
elseif dwo.name = "t_porcentaje_modelos" then
	orden_informe = "porcentaje_modelos D"
elseif dwo.name = "t_trabajos" then
	orden_informe = "trabajos D"
elseif dwo.name = "t_porcentaje_trabajos" then
	orden_informe = "porcentaje_trabajos D"
elseif dwo.name = "t_ventas_alta" then
	orden_informe = "ventas_alta D"
elseif dwo.name = "t_ventas_coleccion" then
	orden_informe = "ventas_coleccion D"
elseif dwo.name = "t_ventas_modelo" then
	orden_informe = "ventas_modelo D"
elseif dwo.name = "t_ventas_trabajo" then
	orden_informe = "ventas_trabajo D"
end if
dw_resumen.setsort(orden_informe)
dw_resumen.sort()
f_recalcular_porcentajes()
end event

type st_3 from statictext within w_con_ranking_ventas_alta_ampliado
integer x = 46
integer y = 2828
integer width = 1349
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 553648127
string text = "No incluye facturas ajenas a la activdad."
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_ranking_ventas_alta_ampliado
integer x = 46
integer y = 2876
integer width = 1275
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 553648127
string text = "Incluye todos los dtos excepto rappel y dtopp."
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_ranking_ventas_alta_ampliado
integer x = 37
integer y = 164
integer width = 247
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_desde_ventas from editmask within w_con_ranking_ventas_alta_ampliado
integer x = 338
integer y = 164
integer width = 402
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean border = false
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
boolean dropdowncalendar = true
end type

type st_1 from statictext within w_con_ranking_ventas_alta_ampliado
integer x = 814
integer y = 164
integer width = 247
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_hasta_ventas from editmask within w_con_ranking_ventas_alta_ampliado
integer x = 1115
integer y = 164
integer width = 402
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean border = false
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
boolean dropdowncalendar = true
end type

type cbx_sin_ventas from checkbox within w_con_ranking_ventas_alta_ampliado
integer x = 3593
integer y = 152
integer width = 827
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Mostrar clientes sin ventas"
boolean checked = true
end type

event clicked;if not cbx_sin_ventas.checked then
	dw_resumen.setfilter("ventas <> 0")
else 
	dw_resumen.setfilter("")
end if
dw_resumen.filter()
end event

type st_5 from statictext within w_con_ranking_ventas_alta_ampliado
integer x = 1641
integer y = 156
integer width = 247
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_desde from editmask within w_con_ranking_ventas_alta_ampliado
integer x = 1943
integer y = 156
integer width = 402
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean border = false
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
boolean dropdowncalendar = true
end type

type st_6 from statictext within w_con_ranking_ventas_alta_ampliado
integer x = 2418
integer y = 156
integer width = 247
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_hasta from editmask within w_con_ranking_ventas_alta_ampliado
integer x = 2720
integer y = 156
integer width = 402
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean border = false
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
boolean dropdowncalendar = true
end type

type st_7 from statictext within w_con_ranking_ventas_alta_ampliado
integer x = 1897
integer y = 2840
integer width = 3191
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 553648127
string text = "El periodo de altas es el utilizado para la fecha de las colecciones, la fecha de creación de los modelos y la fecha de finalización de los trabajos."
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_ranking_ventas_alta_ampliado
integer x = 4951
integer y = 96
integer width = 160
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
end type

type gb_2 from groupbox within w_con_ranking_ventas_alta_ampliado
integer x = 1586
integer y = 84
integer width = 1632
integer height = 180
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Periodo Altas"
end type

type gb_3 from groupbox within w_con_ranking_ventas_alta_ampliado
integer x = 32
integer y = 84
integer width = 1541
integer height = 180
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Periodo Ventas"
end type

