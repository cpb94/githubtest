$PBExportHeader$w_con_ventas_itc2.srw
$PBExportComments$Nuevo Sin Acabar
forward
global type w_con_ventas_itc2 from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_ventas_itc2
end type
type cb_consulta from commandbutton within w_con_ventas_itc2
end type
type pb_imprimir_preli from upb_imprimir within w_con_ventas_itc2
end type
type gb_2 from groupbox within w_con_ventas_itc2
end type
type st_titulo from statictext within w_con_ventas_itc2
end type
type p_logo from picture within w_con_ventas_itc2
end type
type dw_1 from datawindow within w_con_ventas_itc2
end type
type sel_anyo from u_em_campo within w_con_ventas_itc2
end type
type sel_periodo from dropdownlistbox within w_con_ventas_itc2
end type
type st_1 from statictext within w_con_ventas_itc2
end type
end forward

global type w_con_ventas_itc2 from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3337
integer height = 2232
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
end type
global w_con_ventas_itc2 w_con_ventas_itc2

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

event open;call super::open;long indice
int anyo, mes, dia

This.title = "Informe de Ventas para ITC"
this.st_titulo.text = this.st_empresa.text

dw_1.SetTransObject(sqlca)

anyo = year(Today())
mes = month (today())

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

//f_activar_campo(em_desde)




end event

on w_con_ventas_itc2.create
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
end on

on w_con_ventas_itc2.destroy
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
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ventas_itc2
integer x = 558
integer y = 24
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ventas_itc2
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ventas_itc2
boolean visible = false
integer width = 2738
integer height = 84
end type

type pb_2 from upb_salir within w_con_ventas_itc2
integer x = 3136
integer y = 144
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

type cb_consulta from commandbutton within w_con_ventas_itc2
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

event clicked;Datetime fecha_inicio_p1, fecha_fin_p1, fecha_inicio_p2, fecha_fin_p2, fecha_inicio_p3, fecha_fin_p3, fecha_inicio_p4, fecha_fin_p4
Dec piezas, importe, metros

if dw_1.rowcount() > 0 then
	dw_1.accepttext()
	if not isnull(dw_1.object.importe_p4[dw_1.getrow()]) and dw_1.object.importe_p4[dw_1.getrow()] > 0 then
		if MessageBox("Atención", "Si realiza una nueva consulta borrará los datos que haya introducido en el apartado de expectativas. ¿Desea continuar?", Question!, YesNo!, 2) = 2 then
			return
		end if
	end if
end if

dw_1.reset()
dw_1.insertrow(0)

dw_1.object.periodo1[1] = sel_periodo.text + " " + String(Long(sel_anyo.text) - 1)
dw_1.object.periodo2[1] =  sel_periodo.text + " " + String(sel_anyo.text)

CHOOSE CASE String(sel_periodo.text)
	CASE "Enero - Marzo"
		fecha_inicio_p1 = Datetime(Date("01-01-"+String(Long(sel_anyo.text) - 1)),time(0))
		fecha_fin_p1 = Datetime(Date("31-03-"+String(Long(sel_anyo.text) - 1)),time(0))
		fecha_inicio_p2 = Datetime(Date("01-01-"+String(sel_anyo.text)),time(0))
		fecha_fin_p2 = Datetime(Date("31-03-"+String(sel_anyo.text)),time(0))
		//Trimestre pasado
		dw_1.object.periodo3[1] =  "Octubre - Diciembre " + String(Long(sel_anyo.text) - 1)
		fecha_inicio_p3 = Datetime(Date("01-10-"+String(Long(sel_anyo.text) - 1)),time(0))
		fecha_fin_p3 = Datetime(Date("31-12-"+String(Long(sel_anyo.text) - 1)),time(0))
		//Expectativas
		dw_1.object.periodo4[1] =  "Abril - Junio " + String(sel_anyo.text)
		fecha_inicio_p4 = Datetime(Date("01-04-"+String(sel_anyo.text)),time(0))
		fecha_fin_p4 = Datetime(Date("30-06-"+String(sel_anyo.text)),time(0))
	CASE "Abril - Junio"
		fecha_inicio_p1 = Datetime(Date("01-04-"+String(Long(sel_anyo.text) - 1)),time(0))
		fecha_fin_p1 = Datetime(Date("30-06-"+String(Long(sel_anyo.text) - 1)),time(0))
		fecha_inicio_p2 = Datetime(Date("01-04-"+String(sel_anyo.text)),time(0))
		fecha_fin_p2 = Datetime(Date("30-06-"+String(sel_anyo.text)),time(0))
		//Trimestre pasado
		dw_1.object.periodo3[1] =  "Enero - Marzo " + String(sel_anyo.text)
		fecha_inicio_p3 = Datetime(Date("01-01-"+String(sel_anyo.text)),time(0))
		fecha_fin_p3 = Datetime(Date("31-03-"+String(sel_anyo.text)),time(0))
		//Expectativas
		dw_1.object.periodo4[1] =  "Julio - Septiembre " + String(sel_anyo.text)
		fecha_inicio_p4 = Datetime(Date("01-07-"+String(sel_anyo.text)),time(0))
		fecha_fin_p4 = Datetime(Date("30-09-"+String(sel_anyo.text)),time(0))
	CASE "Julio - Septiembre"
		fecha_inicio_p1 = Datetime(Date("01-07-"+String(Long(sel_anyo.text) - 1)),time(0))
		fecha_fin_p1 = Datetime(Date("30-09-"+String(Long(sel_anyo.text) - 1)),time(0))
		fecha_inicio_p2 = Datetime(Date("01-07-"+String(sel_anyo.text)),time(0))
		fecha_fin_p2 = Datetime(Date("30-09-"+String(sel_anyo.text)),time(0))
		//Trimestre pasado
		dw_1.object.periodo3[1] =  "Abril - Junio " + String(sel_anyo.text)
		fecha_inicio_p3 = Datetime(Date("01-04-"+String(sel_anyo.text)),time(0))
		fecha_fin_p3 = Datetime(Date("30-06-"+String(sel_anyo.text)),time(0))
		//Expectativas
		dw_1.object.periodo4[1] =  "Octubre - Diciembre " + String(sel_anyo.text)
		fecha_inicio_p4 = Datetime(Date("01-10-"+String(sel_anyo.text)),time(0))
		fecha_fin_p4 = Datetime(Date("31-12-"+String(sel_anyo.text)),time(0))
	CASE "Octubre - Diciembre"
		fecha_inicio_p1 = Datetime(Date("01-10-"+String(Long(sel_anyo.text) - 1)),time(0))
		fecha_fin_p1 = Datetime(Date("31-12-"+String(Long(sel_anyo.text) - 1)),time(0))
		fecha_inicio_p2 = Datetime(Date("01-10-"+String(sel_anyo.text)),time(0))
		fecha_fin_p2 = Datetime(Date("31-12-"+String(sel_anyo.text)),time(0))
		//Trimestre pasado
		dw_1.object.periodo3[1] =  "Julio - Septiembre " + String(sel_anyo.text)
		fecha_inicio_p3 = Datetime(Date("01-07-"+String(sel_anyo.text)),time(0))
		fecha_fin_p3 = Datetime(Date("30-09-"+String(sel_anyo.text)),time(0))
		//Expectativas
		dw_1.object.periodo4[1] =  "Enero - Marzo " + String(Long(sel_anyo.text) + 1)
		fecha_inicio_p4 = Datetime(Date("01-01-"+String(Long(sel_anyo.text) + 1)),time(0))
		fecha_fin_p4 = Datetime(Date("31-03-"+String(Long(sel_anyo.text) + 1)),time(0))
END CHOOSE

//PERIODO 1 (Trimestre año anterior)
dw_1.object.t1[1] = "1."
//BASE PROPIA

importe = 0
piezas = 0
metros = 0

SELECT	SUM(venlifac.cantidad),
	   	SUM(venlifac.neto / venlifac.cambio), 
	   	SUM((formatos.largo * formatos.ancho / 10000) * venlifac.cantidad) 
INTO 		:piezas, :importe, :metros 
FROM	 	venlifac 
	  		INNER JOIN articulos ON venlifac.empresa = articulos.empresa AND venlifac.articulo = articulos.codigo 
	  		INNER JOIN art_codestadistico ON venlifac.empresa = articulos.empresa AND venlifac.articulo = art_codestadistico.codigo 
		   INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo 
WHERE 	venlifac.empresa = :codigo_empresa AND 
			venlifac.ffactura >= :fecha_inicio_p1 AND venlifac.ffactura < :fecha_fin_p1 AND 
			art_codestadistico.N = 'N';
			
dw_1.object.importe_p1_bt[1] = importe
dw_1.object.piezas_p1_bt[1] = piezas
dw_1.object.metros_p1_bt[1] = metros

//BASE AJENA

importe = 0
piezas = 0
metros = 0

SELECT	SUM(venlifac.cantidad),
	   	SUM(venlifac.neto / venlifac.cambio), 
	   	SUM((formatos.largo * formatos.ancho / 10000) * venlifac.cantidad) 
INTO 		:piezas, :importe, :metros 
FROM	 	venlifac 
	  		INNER JOIN articulos ON venlifac.empresa = articulos.empresa AND venlifac.articulo = articulos.codigo 
	  		INNER JOIN art_codestadistico ON venlifac.empresa = articulos.empresa AND venlifac.articulo = art_codestadistico.codigo 
		   INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo 
WHERE 	venlifac.empresa = :codigo_empresa AND 
			venlifac.ffactura >= :fecha_inicio_p1 AND venlifac.ffactura < :fecha_fin_p1 AND 
			art_codestadistico.N = 'S';
			
dw_1.object.importe_total_p1[1] = dw_1.object.importe_p1_bt[1] + importe
dw_1.object.piezas_total_p1[1] = dw_1.object.piezas_p1_bt[1] + piezas
dw_1.object.metros_total_p1[1] = dw_1.object.metros_p1_bt[1] + metros

dw_1.object.importe_p1[1] = importe
dw_1.object.piezas_p1[1] = piezas
dw_1.object.metros_p1[1] = metros

//PERIODO 2 (Trimestre actual)
//BASE PROPIA

importe = 0
piezas = 0
metros = 0

SELECT	SUM(venlifac.cantidad),
	   	SUM(venlifac.neto / venlifac.cambio), 
	   	SUM((formatos.largo * formatos.ancho / 10000) * venlifac.cantidad) 
INTO 		:piezas, :importe, :metros 
FROM	 	venlifac 
	  		INNER JOIN articulos ON venlifac.empresa = articulos.empresa AND venlifac.articulo = articulos.codigo 
	  		INNER JOIN art_codestadistico ON venlifac.empresa = articulos.empresa AND venlifac.articulo = art_codestadistico.codigo 
		   INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo 
WHERE 	venlifac.empresa = :codigo_empresa AND 
			venlifac.ffactura >= :fecha_inicio_p2 AND venlifac.ffactura < :fecha_fin_p2 AND 
			art_codestadistico.N = 'N';
			
dw_1.object.importe_p2_bt[1] = importe
dw_1.object.piezas_p2_bt[1] = piezas
dw_1.object.metros_p2_bt[1] = metros

//BASE AJENA

importe = 0
piezas = 0
metros = 0

SELECT	SUM(venlifac.cantidad),
	   	SUM(venlifac.neto / venlifac.cambio), 
	   	SUM((formatos.largo * formatos.ancho / 10000) * venlifac.cantidad) 
INTO 		:piezas, :importe, :metros 
FROM	 	venlifac 
	  		INNER JOIN articulos ON venlifac.empresa = articulos.empresa AND venlifac.articulo = articulos.codigo 
	  		INNER JOIN art_codestadistico ON venlifac.empresa = articulos.empresa AND venlifac.articulo = art_codestadistico.codigo 
		   INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo 
WHERE 	venlifac.empresa = :codigo_empresa AND 
			venlifac.ffactura >= :fecha_inicio_p2 AND venlifac.ffactura < :fecha_fin_p2 AND 
			art_codestadistico.N = 'S';

dw_1.object.importe_total_p2[1] = dw_1.object.importe_p2_bt[1] + importe
dw_1.object.piezas_total_p2[1] = dw_1.object.piezas_p2_bt[1] + piezas
dw_1.object.metros_total_p2[1] = dw_1.object.metros_p2_bt[1] + metros
			
dw_1.object.importe_p2[1] = importe
dw_1.object.piezas_p2[1] = piezas
dw_1.object.metros_p2[1] = metros

//PERIODO 3 (Trimestre anterior)
dw_1.object.t2[1] = "2."
//BASE PROPIA

importe = 0
piezas = 0
metros = 0

SELECT	SUM(venlifac.cantidad),
	   	SUM(venlifac.neto / venlifac.cambio), 
	   	SUM((formatos.largo * formatos.ancho / 10000) * venlifac.cantidad) 
INTO 		:piezas, :importe, :metros 
FROM	 	venlifac 
	  		INNER JOIN articulos ON venlifac.empresa = articulos.empresa AND venlifac.articulo = articulos.codigo 
	  		INNER JOIN art_codestadistico ON venlifac.empresa = articulos.empresa AND venlifac.articulo = art_codestadistico.codigo 
		   INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo 
WHERE 	venlifac.empresa = :codigo_empresa AND 
			venlifac.ffactura >= :fecha_inicio_p3 AND venlifac.ffactura < :fecha_fin_p3 AND 
			art_codestadistico.N = 'N';
			
dw_1.object.importe_p3_bt[1] = importe
dw_1.object.piezas_p3_bt[1] = piezas
dw_1.object.metros_p3_bt[1] = metros

//BASE AJENA

importe = 0
piezas = 0
metros = 0

SELECT	SUM(venlifac.cantidad),
	   	SUM(venlifac.neto / venlifac.cambio), 
	   	SUM((formatos.largo * formatos.ancho / 10000) * venlifac.cantidad) 
INTO 		:piezas, :importe, :metros 
FROM	 	venlifac 
	  		INNER JOIN articulos ON venlifac.empresa = articulos.empresa AND venlifac.articulo = articulos.codigo 
	  		INNER JOIN art_codestadistico ON venlifac.empresa = articulos.empresa AND venlifac.articulo = art_codestadistico.codigo 
		   INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo 
WHERE 	venlifac.empresa = :codigo_empresa AND 
			venlifac.ffactura >= :fecha_inicio_p3 AND venlifac.ffactura < :fecha_fin_p3 AND 
			art_codestadistico.N = 'S';

dw_1.object.importe_total_p3[1] = dw_1.object.importe_p3_bt[1] + importe
dw_1.object.piezas_total_p3[1] = dw_1.object.piezas_p3_bt[1] + piezas
dw_1.object.metros_total_p3[1] = dw_1.object.metros_p3_bt[1] + metros
			
dw_1.object.importe_p3[1] = importe
dw_1.object.piezas_p3[1] = piezas
dw_1.object.metros_p3[1] = metros

//PERIODO 4 (Expectativas Próximo Trimestre)
dw_1.object.t3[1] = "3."

end event

type pb_imprimir_preli from upb_imprimir within w_con_ventas_itc2
event clicked pbm_bnclicked
integer x = 2962
integer y = 144
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

type gb_2 from groupbox within w_con_ventas_itc2
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

type st_titulo from statictext within w_con_ventas_itc2
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

type p_logo from picture within w_con_ventas_itc2
integer x = 2761
integer y = 8
integer width = 517
integer height = 96
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_ventas_itc2
integer x = 27
integer y = 316
integer width = 3255
integer height = 1704
integer taborder = 80
string title = "none"
string dataobject = "dw_con_ventas_itc_completo2"
boolean livescroll = true
end type

type sel_anyo from u_em_campo within w_con_ventas_itc2
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

type sel_periodo from dropdownlistbox within w_con_ventas_itc2
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

type st_1 from statictext within w_con_ventas_itc2
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

