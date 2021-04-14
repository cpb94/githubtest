$PBExportHeader$w_con_tasas_ventas.srw
forward
global type w_con_tasas_ventas from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_tasas_ventas
end type
type cb_consulta from commandbutton within w_con_tasas_ventas
end type
type pb_imprimir_preli from upb_imprimir within w_con_tasas_ventas
end type
type gb_2 from groupbox within w_con_tasas_ventas
end type
type st_titulo from statictext within w_con_tasas_ventas
end type
type p_logo from picture within w_con_tasas_ventas
end type
type dw_1 from datawindow within w_con_tasas_ventas
end type
type sel_anyo from u_em_campo within w_con_tasas_ventas
end type
type sel_periodo from dropdownlistbox within w_con_tasas_ventas
end type
type st_1 from statictext within w_con_tasas_ventas
end type
type dw_datos_grafica from datawindow within w_con_tasas_ventas
end type
type st_info from statictext within w_con_tasas_ventas
end type
type progreso from hprogressbar within w_con_tasas_ventas
end type
end forward

global type w_con_tasas_ventas from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5010
integer height = 3020
string title = "Estadística comparativa de Compras por Productos y Familias"
long backcolor = 67108864
string icon = "Application!"
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
gb_2 gb_2
st_titulo st_titulo
p_logo p_logo
dw_1 dw_1
sel_anyo sel_anyo
sel_periodo sel_periodo
st_1 st_1
dw_datos_grafica dw_datos_grafica
st_info st_info
progreso progreso
end type
global w_con_tasas_ventas w_con_tasas_ventas

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

event open;call super::open;long indice
int anyo, mes, dia

This.title = "Informe variación ventas"
this.st_titulo.text = this.st_empresa.text

anyo = year(Today())
mes = month (Today())

/*
sel_anyo.text = String(anyo)
if mes >= 1 and mes <= 3 then
	sel_periodo.text = "Enero - Marzo"
elseif mes >= 4 and mes <= 6 then
	sel_periodo.text = "Abril - Junio"
elseif mes >= 7 and mes <= 9 then
	sel_periodo.text = "Julio - Septiembre"
else
	sel_periodo.text = "Octubre - Diciembre"
end if
*/

if mes > 3 and mes <= 6 then
	sel_anyo.text = String(anyo)
	sel_periodo.text = "Enero - Marzo"
elseif mes > 6 and mes <= 9 then
	sel_anyo.text = String(anyo)
	sel_periodo.text = "Abril - Junio"
elseif mes > 9 and mes <= 12 then
	sel_anyo.text = String(anyo)
	sel_periodo.text = "Julio - Septiembre"
else
	sel_anyo.text = String(anyo - 1)
	sel_periodo.text = "Octubre - Diciembre"
end if

progreso.visible = false

//f_activar_campo(em_desde)



end event

on w_con_tasas_ventas.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.gb_2=create gb_2
this.st_titulo=create st_titulo
this.p_logo=create p_logo
this.dw_1=create dw_1
this.sel_anyo=create sel_anyo
this.sel_periodo=create sel_periodo
this.st_1=create st_1
this.dw_datos_grafica=create dw_datos_grafica
this.st_info=create st_info
this.progreso=create progreso
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.st_titulo
this.Control[iCurrent+6]=this.p_logo
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.sel_anyo
this.Control[iCurrent+9]=this.sel_periodo
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_datos_grafica
this.Control[iCurrent+12]=this.st_info
this.Control[iCurrent+13]=this.progreso
end on

on w_con_tasas_ventas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.gb_2)
destroy(this.st_titulo)
destroy(this.p_logo)
destroy(this.dw_1)
destroy(this.sel_anyo)
destroy(this.sel_periodo)
destroy(this.st_1)
destroy(this.dw_datos_grafica)
destroy(this.st_info)
destroy(this.progreso)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_tasas_ventas
integer x = 558
integer y = 24
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_tasas_ventas
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_tasas_ventas
boolean visible = false
integer width = 2738
integer height = 84
end type

type pb_2 from upb_salir within w_con_tasas_ventas
integer x = 4818
integer y = 164
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\TENCER_PB12\Log Out_24x24Gris.png"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type cb_consulta from commandbutton within w_con_tasas_ventas
event clicked pbm_bnclicked
integer x = 1568
integer y = 152
integer width = 361
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;String t1, t2, t3, t4
Datetime t1_inicio, t2_inicio, t3_inicio, t4_inicio, t1_fin, t2_fin, t3_fin, t4_fin
Date ahora
Long anyo, mes, fila
String empresa
Dec tasa

empresa = codigo_empresa

if isnull(sel_periodo.text) or sel_periodo.text = "" or isnull(sel_anyo.text) or sel_anyo.text = "" then
	MessageBox("Error Consulta", "Debe indicar el periodo y el año para realizar el informe")
	return
end if

st_info.text = "Calculando datos. Por favor, espere."

CHOOSE CASE String(sel_periodo.text)
	CASE "Enero - Marzo"
		mes = 1
	CASE "Abril - Junio"
		mes = 4
	CASE "Julio - Septiembre"
		mes = 7
	CASE "Octubre - Diciembre"
		mes = 10
END CHOOSE
anyo = Long(sel_anyo.text)

if (mes = 1 or mes = 2 or mes = 3) then
	
	anyo = anyo - 2
	
	t1 = "Abril - Junio"
	t1 = "T1: " + t1 + " " + String(anyo + 1)
	t1_inicio = Datetime(Date("01-04-"+String(anyo)),time(0))
	t1_fin = Datetime(Date("30-06-"+String(anyo)),time(0))
	
	t2 = "Julio - Septiembre"
	t2 = "T2: " + t2 + " " + String(anyo + 1)
	t2_inicio = Datetime(Date("01-07-"+String(anyo)),time(0))
	t2_fin = Datetime(Date("30-09-"+String(anyo)),time(0))
	
	t3 = "Octubre - Diciembre"
	t3 = "T3: " + t3 + " " + String(anyo + 1)
	t3_inicio = Datetime(Date("01-10-"+String(anyo)),time(0))
	t3_fin = Datetime(Date("31-12-"+String(anyo)),time(0))
	
	anyo = anyo + 1
	
	t4 = "Enero - Marzo"
	t4 = "T4: " + t4 + " " + String(anyo + 1)
	t4_inicio = Datetime(Date("01-01-"+String(anyo)),time(0))
	t4_fin = Datetime(Date("31-03-"+String(anyo)),time(0))
	
	
elseif (mes = 4 or mes = 5 or mes = 6) then
	
	anyo = anyo - 2
	
	t1 = "Julio - Septiembre"
	t1 = "T1: " + t1 + " " + String(anyo + 1)
	t1_inicio = Datetime(Date("01-07-"+String(anyo)),time(0))
	t1_fin = Datetime(Date("30-09-"+String(anyo)),time(0))
	
	t2 = "Octubre - Diciembre"
	t2 = "T2: " + t2 + " " + String(anyo + 1)
	t2_inicio = Datetime(Date("01-10-"+String(anyo)),time(0))
	t2_fin = Datetime(Date("31-12-"+String(anyo)),time(0))
	
	anyo = anyo + 1
	
	t3 = "Enero - Marzo"
	t3 = "T3: " + t3 + " " + String(anyo + 1)
	t3_inicio = Datetime(Date("01-01-"+String(anyo)),time(0))
	t3_fin = Datetime(Date("31-03-"+String(anyo)),time(0))
	
	t4 =  "Abril - Junio"
	t4 = "T4: " + t4 + " " + String(anyo + 1)
	t4_inicio = Datetime(Date("01-04-"+String(anyo)),time(0))
	t4_fin = Datetime(Date("30-06-"+String(anyo)),time(0))
	
elseif (mes = 7 or mes = 8 or mes = 9) then
	
	anyo = anyo - 2
	
	t1 = "Octubre - Diciembre"
	t1 = "T1: " + t1 + " " + String(anyo + 1)
	t1_inicio = Datetime(Date("01-10-"+String(anyo)),time(0))
	t1_fin = Datetime(Date("31-12-"+String(anyo)),time(0))
	
	anyo = anyo + 1
	
	t2 = "Enero - Marzo" 
	t2 = "T2: " + t2 + " " + String(anyo + 1)
	t2_inicio = Datetime(Date("01-01-"+String(anyo)),time(0))
	t2_fin = Datetime(Date("31-03-"+String(anyo)),time(0))
	
	t3 = "Abril - Junio" 
	t3 = "T3: " + t3 + " " + String(anyo + 1)
	t3_inicio = Datetime(Date("01-04-"+String(anyo)),time(0))
	t3_fin = Datetime(Date("30-06-"+String(anyo)),time(0))
	
	t4 = "Julio - Septiembre"
	t4 = "T4: " + t4 + " " + String(anyo + 1)
	t4_inicio = Datetime(Date("01-07-"+String(anyo)),time(0))
	t4_fin = Datetime(Date("30-09-"+String(anyo)),time(0))
		
elseif (mes = 10 or mes = 11 or mes = 12) then
	
	anyo = anyo - 1
	
	t1 = "Enero - Marzo"
	t1 = "T1: " + t1 + " " + String(anyo + 1)
	t1_inicio = Datetime(Date("01-01-"+String(anyo)),time(0))
	t1_fin = Datetime(Date("31-03-"+String(anyo)),time(0))
	
	t2 = "Abril - Junio"
	t2 = "T2: " + t2 + " " + String(anyo + 1)
	t2_inicio = Datetime(Date("01-04-"+String(anyo)),time(0))
	t2_fin = Datetime(Date("30-06-"+String(anyo)),time(0))
	
	t3 = "Julio - Septiembre"
	t3 = "T3: " + t3 + " " + String(anyo + 1)
	t3_inicio = Datetime(Date("01-07-"+String(anyo)),time(0))
	t3_fin = Datetime(Date("30-09-"+String(anyo)),time(0))
	
	t4 = "Octubre - Diciembre"
	t4 = "T4: " + t4 + " " + String(anyo + 1)
	t4_inicio = Datetime(Date("01-10-"+String(anyo)),time(0))
	t4_fin = Datetime(Date("31-12-"+String(anyo)),time(0))
	
end if

progreso.position = 0
progreso.visible = true

dw_1.reset()
dw_1.setredraw(false)

dw_datos_grafica.reset()
dw_datos_grafica.insertrow(0)

dw_datos_grafica.object.tasa1[1] = "Tasa Variación Interanual"
dw_datos_grafica.object.tasa2[1] = 'Tasa de variación Intertrimestral'

//CALCULOS TRIMESTRE 1

dw_datos_grafica.object.t1[1] = t1

//Interanual

SELECT	(((SUM(V1.neto / V1.cambio) - SUM(V2.neto / V2.cambio)) / SUM(V2.neto / V2.cambio)) * 100) INTO :tasa
FROM	venlifac V1, 
		venlifac V2
WHERE 	V1.empresa = :empresa AND 
		V2.empresa = :empresa AND 
		V1.ffactura >= DATEADD(year,1,:t1_inicio) AND V1.ffactura < DATEADD(year,1,:t1_fin) AND 
		V2.ffactura >= :t1_inicio AND V2.ffactura < :t1_fin;

dw_datos_grafica.object.valort11[1] = tasa
fila = dw_1.insertrow(0)
dw_1.object.trimestre[fila] = t1
dw_1.object.tasa[fila] = dw_datos_grafica.object.tasa1[1]
dw_1.object.valor[fila] = tasa
progreso.StepIt()

//Intertrimestral

SELECT	(((SUM(V1.neto / V1.cambio) - SUM(V2.neto / V2.cambio)) / SUM(V2.neto / V2.cambio)) * 100) INTO :tasa
FROM	venlifac V1, 
		venlifac V2
WHERE 	V1.empresa = :empresa AND 
		V2.empresa = :empresa AND 
		V1.ffactura >= DATEADD(year,1,:t1_inicio) AND V1.ffactura < DATEADD(year,1,:t1_fin) AND 
		V2.ffactura >= :t4_inicio AND V2.ffactura < :t4_fin;

dw_datos_grafica.object.valort21[1] = tasa
fila = dw_1.insertrow(0)
dw_1.object.trimestre[fila] = t1
dw_1.object.tasa[fila] = dw_datos_grafica.object.tasa2[1]
dw_1.object.valor[fila] = tasa
progreso.StepIt()


//CALCULOS TRIMESTRE 2
dw_datos_grafica.object.t2[1] = t2

//Interanual

SELECT	(((SUM(V1.neto / V1.cambio) - SUM(V2.neto / V2.cambio)) / SUM(V2.neto / V2.cambio)) * 100) INTO :tasa
FROM	venlifac V1, 
		venlifac V2
WHERE 	V1.empresa = :empresa AND 
		V2.empresa = :empresa AND 
		V1.ffactura >= DATEADD(year,1,:t2_inicio) AND V1.ffactura < DATEADD(year,1,:t2_fin) AND 
		V2.ffactura >= :t2_inicio AND V2.ffactura < :t2_fin;

dw_datos_grafica.object.valort12[1] = tasa
fila = dw_1.insertrow(0)
dw_1.object.trimestre[fila] = t2
dw_1.object.tasa[fila] = dw_datos_grafica.object.tasa1[1]
dw_1.object.valor[fila] = tasa
progreso.StepIt()

//Intertrimestral

SELECT	(((SUM(V1.neto / V1.cambio) - SUM(V2.neto / V2.cambio)) / SUM(V2.neto / V2.cambio)) * 100) INTO :tasa
FROM	venlifac V1, 
		venlifac V2
WHERE 	V1.empresa = :empresa AND 
		V2.empresa = :empresa AND 
		V1.ffactura >= DATEADD(year,1,:t2_inicio) AND V1.ffactura < DATEADD(year,1,:t2_fin) AND 
		V2.ffactura >= DATEADD(year,1,:t1_inicio) AND V2.ffactura < DATEADD(year,1,:t1_fin);

dw_datos_grafica.object.valort22[1] = tasa
fila = dw_1.insertrow(0)
dw_1.object.trimestre[fila] = t2
dw_1.object.tasa[fila] = dw_datos_grafica.object.tasa2[1]
dw_1.object.valor[fila] = tasa
progreso.StepIt()

//CALCULOS TRIMESTRE 3
dw_datos_grafica.object.t3[1] = t3

//Interanual

SELECT	(((SUM(V1.neto / V1.cambio) - SUM(V2.neto / V2.cambio)) / SUM(V2.neto / V2.cambio)) * 100) INTO :tasa
FROM	venlifac V1, 
		venlifac V2
WHERE 	V1.empresa = :empresa AND 
		V2.empresa = :empresa AND 
		V1.ffactura >= DATEADD(year,1,:t3_inicio) AND V1.ffactura < DATEADD(year,1,:t3_fin) AND 
		V2.ffactura >= :t3_inicio AND V2.ffactura < :t3_fin;

dw_datos_grafica.object.valort13[1] = tasa
fila = dw_1.insertrow(0)
dw_1.object.trimestre[fila] = t3
dw_1.object.tasa[fila] = dw_datos_grafica.object.tasa1[1]
dw_1.object.valor[fila] = tasa
progreso.StepIt()

//Intertrimestral

SELECT	(((SUM(V1.neto / V1.cambio) - SUM(V2.neto / V2.cambio)) / SUM(V2.neto / V2.cambio)) * 100) INTO :tasa
FROM	venlifac V1, 
		venlifac V2
WHERE 	V1.empresa = :empresa AND 
		V2.empresa = :empresa AND 
		V1.ffactura >= DATEADD(year,1,:t3_inicio) AND V1.ffactura < DATEADD(year,1,:t3_fin) AND 
		V2.ffactura >= DATEADD(year,1,:t2_inicio) AND V2.ffactura < DATEADD(year,1,:t2_fin);

dw_datos_grafica.object.valort23[1] = tasa
fila = dw_1.insertrow(0)
dw_1.object.trimestre[fila] = t3
dw_1.object.tasa[fila] = dw_datos_grafica.object.tasa2[1]
dw_1.object.valor[fila] = tasa
progreso.StepIt()

//CALCULOS TRIMESTRE 4
dw_datos_grafica.object.t4[1] = t4

//Interanual

SELECT	(((SUM(V1.neto / V1.cambio) - SUM(V2.neto / V2.cambio)) / SUM(V2.neto / V2.cambio)) * 100) INTO :tasa
FROM	venlifac V1, 
		venlifac V2
WHERE 	V1.empresa = :empresa AND 
		V2.empresa = :empresa AND 
		V1.ffactura >= DATEADD(year,1,:t4_inicio) AND V1.ffactura < DATEADD(year,1,:t4_fin) AND 
		V2.ffactura >= :t4_inicio AND V2.ffactura < :t4_fin;

dw_datos_grafica.object.valort14[1] = tasa
fila = dw_1.insertrow(0)
dw_1.object.trimestre[fila] = t4
dw_1.object.tasa[fila] = dw_datos_grafica.object.tasa1[1]
dw_1.object.valor[fila] = tasa
progreso.StepIt()

//Intertrimestral

SELECT	(((SUM(V1.neto / V1.cambio) - SUM(V2.neto / V2.cambio)) / SUM(V2.neto / V2.cambio)) * 100) INTO :tasa
FROM	venlifac V1, 
		venlifac V2
WHERE 	V1.empresa = :empresa AND 
		V2.empresa = :empresa AND 
		V1.ffactura >= DATEADD(year,1,:t4_inicio) AND V1.ffactura < DATEADD(year,1,:t4_fin) AND 
		V2.ffactura >= DATEADD(year,1,:t3_inicio) AND V2.ffactura < DATEADD(year,1,:t3_fin);

dw_datos_grafica.object.valort24[1] = tasa
fila = dw_1.insertrow(0)
dw_1.object.trimestre[fila] = t4
dw_1.object.tasa[fila] = dw_datos_grafica.object.tasa2[1]
dw_1.object.valor[fila] = tasa
progreso.StepIt()

progreso.visible = false
dw_1.setredraw(true)




st_info.text = ""

end event

type pb_imprimir_preli from upb_imprimir within w_con_tasas_ventas
event clicked pbm_bnclicked
integer x = 4645
integer y = 164
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\TENCER_PB12\printer-icon2_24x24.png"
end type

event clicked;if dw_1.getrow() > 0 then
	if isnull(dw_1.object.periodo1[dw_1.getrow()]) or dw_1.object.periodo1[dw_1.getrow()] = "" then
		MessageBox("Atención", "Debe hacer clic en consulta y rellenar los datos relativos a las expectativas antes de imprimir.")
		return
	end if
else
	MessageBox("Atención", "Debe hacer clic en consulta y rellenar los datos relativos a las expectativas antes de imprimir.")
	return
end if

dw_1.accepttext()
/*
if isnull(dw_1.object.importe_p4_bt[dw_1.getrow()]) or dw_1.object.importe_p4_bt[dw_1.getrow()] = 0 then
	MessageBox("Atención", "Debe rellenar el importe esperado sobre base propia.")
	dw_1.setfocus()
	dw_1.SetColumn("importe_p4_bt")
	return
elseif isnull(dw_1.object.importe_p4[dw_1.getrow()]) or dw_1.object.importe_p4[dw_1.getrow()] = 0 then
	MessageBox("Atención", "Debe rellenar el importe esperado sobre base ajena.")
	dw_1.setfocus()
	dw_1.SetColumn("importe_p4")
	return
elseif isnull(dw_1.object.piezas_p4_bt[dw_1.getrow()]) or dw_1.object.piezas_p4_bt[dw_1.getrow()] = 0 then
	MessageBox("Atención", "Debe rellenar las piezas esperadas sobre base propia.")
	dw_1.setfocus()
	dw_1.SetColumn("piezas_p4_bt")
	return
elseif isnull(dw_1.object.piezas_p4[dw_1.getrow()]) or dw_1.object.piezas_p4[dw_1.getrow()] = 0 then
	MessageBox("Atención", "Debe rellenar las piezas esperadas sobre base ajena.")
	dw_1.setfocus()
	dw_1.SetColumn("piezas_p4")
	return
elseif isnull(dw_1.object.metros_p4_bt[dw_1.getrow()]) or dw_1.object.metros_p4_bt[dw_1.getrow()] = 0 then
	MessageBox("Atención", "Debe rellenar los metros esperados sobre base propia.")
	dw_1.setfocus()
	dw_1.SetColumn("metros_p4_bt")
	return
elseif isnull(dw_1.object.metros_p4[dw_1.getrow()]) or dw_1.object.metros_p4[dw_1.getrow()] = 0 then
	MessageBox("Atención", "Debe rellenar los metros esperados sobre base ajena.")
	dw_1.setfocus()
	dw_1.SetColumn("metros_p4")
	return
end if
*/
f_imprimir_datawindow(dw_1)


end event

type gb_2 from groupbox within w_con_tasas_ventas
integer x = 32
integer y = 104
integer width = 1490
integer height = 192
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Período"
end type

type st_titulo from statictext within w_con_tasas_ventas
integer x = 23
integer y = 20
integer width = 1710
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Nombre Empresa"
boolean focusrectangle = false
end type

type p_logo from picture within w_con_tasas_ventas
integer x = 4443
integer y = 28
integer width = 517
integer height = 96
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_tasas_ventas
integer x = 27
integer y = 316
integer width = 4937
integer height = 2152
integer taborder = 80
string title = "none"
string dataobject = "graf_tasas_ventas_anual2"
boolean livescroll = true
end type

type sel_anyo from u_em_campo within w_con_tasas_ventas
integer x = 1166
integer y = 176
integer width = 293
integer height = 92
integer taborder = 30
boolean bringtotop = true
long backcolor = 16777215
maskdatatype maskdatatype = numericmask!
string mask = "####"
boolean spin = true
double increment = 1
string minmax = "2001~~"
end type

type sel_periodo from dropdownlistbox within w_con_tasas_ventas
integer x = 82
integer y = 176
integer width = 832
integer height = 352
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean sorted = false
string item[] = {"Enero - Marzo","Abril - Junio","Julio - Septiembre","Octubre - Diciembre"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_con_tasas_ventas
integer x = 987
integer y = 188
integer width = 169
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
boolean focusrectangle = false
end type

type dw_datos_grafica from datawindow within w_con_tasas_ventas
integer x = 32
integer y = 2488
integer width = 4933
integer height = 340
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dw_tasas_ventas_anual2"
boolean livescroll = true
end type

type st_info from statictext within w_con_tasas_ventas
integer x = 2258
integer y = 160
integer width = 2025
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type progreso from hprogressbar within w_con_tasas_ventas
boolean visible = false
integer x = 2834
integer y = 48
integer width = 1445
integer height = 68
boolean bringtotop = true
unsignedinteger maxposition = 8
integer setstep = 1
end type

