$PBExportHeader$w_con_vtas_comparativo_articulos.srw
forward
global type w_con_vtas_comparativo_articulos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_vtas_comparativo_articulos
end type
type em_periodo1 from u_em_campo within w_con_vtas_comparativo_articulos
end type
type cb_consulta from u_boton within w_con_vtas_comparativo_articulos
end type
type pb_imprimir_preli from picturebutton within w_con_vtas_comparativo_articulos
end type
type st_7 from statictext within w_con_vtas_comparativo_articulos
end type
type dw_listado from datawindow within w_con_vtas_comparativo_articulos
end type
type em_periodo2 from u_em_campo within w_con_vtas_comparativo_articulos
end type
type st_4 from statictext within w_con_vtas_comparativo_articulos
end type
type uo_mes1 from u_em_campo_2 within w_con_vtas_comparativo_articulos
end type
type uo_mes2 from u_em_campo_2 within w_con_vtas_comparativo_articulos
end type
type dw_1 from datawindow within w_con_vtas_comparativo_articulos
end type
type uo_serie from u_em_campo_2 within w_con_vtas_comparativo_articulos
end type
type gb_6 from groupbox within w_con_vtas_comparativo_articulos
end type
type gb_4 from groupbox within w_con_vtas_comparativo_articulos
end type
type m2 from checkbox within w_con_vtas_comparativo_articulos
end type
type uo_1 from u_manejo_datawindow within w_con_vtas_comparativo_articulos
end type
type gb_5 from groupbox within w_con_vtas_comparativo_articulos
end type
type gb_9 from groupbox within w_con_vtas_comparativo_articulos
end type
end forward

global type w_con_vtas_comparativo_articulos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2990
integer height = 1668
string title = "Consulta de Movimientos"
pb_2 pb_2
em_periodo1 em_periodo1
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
st_7 st_7
dw_listado dw_listado
em_periodo2 em_periodo2
st_4 st_4
uo_mes1 uo_mes1
uo_mes2 uo_mes2
dw_1 dw_1
uo_serie uo_serie
gb_6 gb_6
gb_4 gb_4
m2 m2
uo_1 uo_1
gb_5 gb_5
gb_9 gb_9
end type
global w_con_vtas_comparativo_articulos w_con_vtas_comparativo_articulos

type variables
String ante_articulo,retrasos,sector="",arg_articulo

end variables

forward prototypes
public subroutine f_cargar (datawindow data)
public subroutine f_cargar_m2 (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);DataStore  dat,dat1
data.Retrieve(codigo_empresa,uo_mes1.em_campo.text,uo_mes2.em_campo.text)
data.SetRedraw(FALSE)
Dec total = 0,xx
SetPointer(HourGlass!)
f_mascara_columna(data,"t1",f_mascara_decimales(0))
f_mascara_columna(data,"t2",f_mascara_decimales(0))
f_mascara_columna(data,"t3",f_mascara_decimales(0))
f_mascara_columna(data,"t4",f_mascara_decimales(2))
f_mascara_columna(data,"importe1",f_mascara_decimales(0))
f_mascara_columna(data,"importe2",f_mascara_decimales(0))
f_mascara_columna(data,"diferencia",f_mascara_decimales(0))

Dec contador,j,anyo,diferencia,por,ln
Dec {0} importe1,importe2

String sel,nombre_articulo,articulo


String serie1,serie2
if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

//sel = " Select anyo,articulo,sum(neto * cambio) total_fac_pts from venlifac" + &
//		" Where  empresa      = '" + codigo_empresa + "'" + &
//		" And    anyo         IN (" + em_periodo1.text + "," +em_periodo2.text+")" +&
//		" And    serie  In ('" + serie1 + "','" +serie2+"')"+&
//		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
//		" Group By anyo,articulo"

contador = 0

sel = " Select anyo,articulo,sum((neto - impdtopp) * cambio) total_fac_pts from venlifac" + &
		" Where  empresa      = '" + codigo_empresa + "'" + &
		" And    anyo         = " + em_periodo1.text  +&
		" And    serie  between '" + serie1 + "' and '" +serie2+"'"+&
		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
		" Group By anyo,articulo"
		
//dat = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, dat)

sel = " Select anyo,articulo,sum((neto - impdtopp) * cambio) total_fac_pts from venlifac" + &
		" Where  empresa      = '" + codigo_empresa + "'" + &
		" And    anyo         = " + em_periodo2.text  +&
		" And    serie  between '" + serie1 + "' and '" +serie2+"'"+&
		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
		" Group By anyo,articulo"
		
//dat1 = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, dat1)

dat1.RowsCopy(dat1.GetRow(),  &
             dat1.RowCount(), Primary!, dat,dat.RowCount(), Primary!)

For j = 1 To dat.RowCount()
			f_mensaje_proceso("Procesando Facturas...",j,dat.RowCount())
			importe1 = 0
			importe2 = 0
			articulo = dat.getItemSTring(j,"articulo")
			anyo     = dat.getItemNumber(j,"anyo")
			IF anyo  = Dec(em_periodo1.text) Then importe1 = dat.getItemNumber(j,"total_fac_pts")	
			IF anyo  = Dec(em_periodo2.text) Then importe2 = dat.getItemNumber(j,"total_fac_pts")	
			nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
			sel = "articulo='" + articulo + "'"
			ln = data.find(sel,1,contador)
			If ln = 0 Then
				contador = contador +1
				data.InsertRow(contador)
				ln = contador
			ELSE
				IF importe1 = 0 Then importe1 = data.GetItemNumber(ln,"importe1")
				IF importe2 = 0 Then importe2 = data.GetItemNumber(ln,"importe2")
			END IF
			if isnull(importe2) then importe2=0
			if isnull(importe1) then importe1=0
			diferencia = importe2 - importe1
			data.SetItem(ln,"articulo",articulo)
			data.SetItem(ln,"nombre_articulo",nombre_articulo)
			data.SetItem(ln,"importe1",importe1)
			data.SetItem(ln,"importe2",importe2)	
			data.SetItem(ln,"diferencia",diferencia)		
			iF importe2 = 0 Then
				por = 0
			ELSE
				por = (diferencia * 100) / importe2
			END IF
			data.SetItem(ln,"porcentaje",por)		
			data.SetItem(ln,"anyo1",Dec(em_periodo1.text))
			data.SetItem(ln,"anyo2",Dec(em_periodo2.text))	
			total = total + importe2
		Next
		
		For j = 1 To data.RowCount()
			importe2 = data.GetItemNumber(j,"importe2")
			IF total = 0 or importe2=0 Then
				data.SetItem(j,"porcentaje1",0)
			ELSE
				data.SetItem(j,"porcentaje1",data.GetItemNumber(j,"importe2") * 100 / total)
			END IF
      Next

data.SetRedraw(TRUE)
data.SetSort("importe2 D")
data.Sort()
SetPointer(Arrow!)

destroy dat
destroy dat1
end subroutine

public subroutine f_cargar_m2 (datawindow data);DataStore  dat,dat1
data.Retrieve(codigo_empresa,uo_mes1.em_campo.text,uo_mes2.em_campo.text)
data.SetRedraw(FALSE)
Dec total = 0,xx
SetPointer(HourGlass!)
f_mascara_columna(data,"t1",f_mascara_decimales(2))
f_mascara_columna(data,"t2",f_mascara_decimales(2))
f_mascara_columna(data,"t3",f_mascara_decimales(2))
f_mascara_columna(data,"t4",f_mascara_decimales(2))
f_mascara_columna(data,"importe1",f_mascara_decimales(2))
f_mascara_columna(data,"importe2",f_mascara_decimales(2))
f_mascara_columna(data,"diferencia",f_mascara_decimales(2))

Dec contador,j,anyo,diferencia,por,ln
Dec {2} importe1,importe2

String sel,nombre_articulo,articulo


String serie1,serie2
if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

//sel = " Select anyo,articulo,sum(neto * cambio) total_fac_pts from venlifac" + &
//		" Where  empresa      = '" + codigo_empresa + "'" + &
//		" And    anyo         IN (" + em_periodo1.text + "," +em_periodo2.text+")" +&
//		" And    serie  In ('" + serie1 + "','" +serie2+"')"+&
//		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
//		" Group By anyo,articulo"

contador = 0

sel = " Select anyo,articulo,sum(cantidad) cantidad from venlifac" + &
		" Where  empresa      = '" + codigo_empresa + "'" + &
		" And    anyo         = " + em_periodo1.text  +&
		" And    serie  between '" + serie1 + "' and '" +serie2+"'"+&
		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
		" Group By anyo,articulo"
		
//dat = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, dat)

sel = " Select anyo,articulo,sum(cantidad) cantidad from venlifac" + &
		" Where  empresa      = '" + codigo_empresa + "'" + &
		" And    anyo         = " + em_periodo2.text  +&
		" And    serie  between '" + serie1 + "' and '" +serie2+"'"+&
		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
		" Group By anyo,articulo"
		
//dat1 = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, dat)

dat1.RowsCopy(dat1.GetRow(),  &
             dat1.RowCount(), Primary!, dat,dat.RowCount(), Primary!)

For j = 1 To dat.RowCount()
			f_mensaje_proceso("Procesando Facturas...",j,dat.RowCount())
			importe1 = 0
			importe2 = 0
			articulo = dat.getItemSTring(j,"articulo")
			anyo     = dat.getItemNumber(j,"anyo")
			IF anyo  = Dec(em_periodo1.text) Then importe1 = dat.getItemNumber(j,"cantidad")	
			IF anyo  = Dec(em_periodo2.text) Then importe2 = dat.getItemNumber(j,"cantidad")	
			nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
			importe1 = f_conversion_cantidad_m2(codigo_empresa,articulo,importe1)
			importe2 = f_conversion_cantidad_m2(codigo_empresa,articulo,importe2)
			sel = "articulo='" + articulo + "'"
			ln = data.find(sel,1,contador)
			If ln = 0 Then
				contador = contador +1
				data.InsertRow(contador)
				ln = contador
				data.SetItem(ln,"unidad","M2")
			ELSE
				IF importe1 = 0 Then importe1 = data.GetItemNumber(ln,"importe1")
				IF importe2 = 0 Then importe2 = data.GetItemNumber(ln,"importe2")
			END IF
			if isnull(importe2) then importe2=0
			if isnull(importe1) then importe1=0
			diferencia = importe2 - importe1
			data.SetItem(ln,"articulo",articulo)
			data.SetItem(ln,"nombre_articulo",nombre_articulo)
			data.SetItem(ln,"importe1",importe1)
			data.SetItem(ln,"importe2",importe2)	
			data.SetItem(ln,"diferencia",diferencia)		
			iF importe2 = 0 Then
				por = 0
			ELSE
				por = (diferencia * 100) / importe2
			END IF
			data.SetItem(ln,"porcentaje",por)		
			data.SetItem(ln,"anyo1",Dec(em_periodo1.text))
			data.SetItem(ln,"anyo2",Dec(em_periodo2.text))	
			total = total + importe2
		Next
		
		For j = 1 To data.RowCount()
			importe2 = data.GetItemNumber(j,"importe2")
			IF total = 0 or importe2=0 Then
				data.SetItem(j,"porcentaje1",0)
			ELSE
				data.SetItem(j,"porcentaje1",data.GetItemNumber(j,"importe2") * 100 / total)
			END IF
      Next

data.SetRedraw(TRUE)
data.SetSort("importe2 D")
data.Sort()
SetPointer(Arrow!)

destroy dat
destroy dat1
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)

dw_listado.SetTransObject(sqlca)
This.title = " CONSULTA VENTAS POR ARTICULOS"

em_periodo1.text = string(year(today()))
em_periodo2.text = string(year(today())-1)
uo_mes1.em_codigo.text = "1"
uo_mes1.em_campo.text =f_nombre_mes(Dec(uo_mes1.em_codigo.text))
uo_mes2.em_codigo.text = string(month(today()))
uo_mes2.em_campo.text =f_nombre_mes(Dec(uo_mes2.em_codigo.text))

dw_1.Setfocus()
Integer x1,registros 
String var_codigo,var_texto,marca
f_activar_campo(em_periodo1)


end event

on w_con_vtas_comparativo_articulos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_periodo1=create em_periodo1
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_7=create st_7
this.dw_listado=create dw_listado
this.em_periodo2=create em_periodo2
this.st_4=create st_4
this.uo_mes1=create uo_mes1
this.uo_mes2=create uo_mes2
this.dw_1=create dw_1
this.uo_serie=create uo_serie
this.gb_6=create gb_6
this.gb_4=create gb_4
this.m2=create m2
this.uo_1=create uo_1
this.gb_5=create gb_5
this.gb_9=create gb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_periodo1
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.st_7
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.em_periodo2
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.uo_mes1
this.Control[iCurrent+10]=this.uo_mes2
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.uo_serie
this.Control[iCurrent+13]=this.gb_6
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.m2
this.Control[iCurrent+16]=this.uo_1
this.Control[iCurrent+17]=this.gb_5
this.Control[iCurrent+18]=this.gb_9
end on

on w_con_vtas_comparativo_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_periodo1)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.st_7)
destroy(this.dw_listado)
destroy(this.em_periodo2)
destroy(this.st_4)
destroy(this.uo_mes1)
destroy(this.uo_mes2)
destroy(this.dw_1)
destroy(this.uo_serie)
destroy(this.gb_6)
destroy(this.gb_4)
destroy(this.m2)
destroy(this.uo_1)
destroy(this.gb_5)
destroy(this.gb_9)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_vtas_comparativo_articulos
integer taborder = 90
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_vtas_comparativo_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_vtas_comparativo_articulos
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_vtas_comparativo_articulos
integer x = 2798
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type em_periodo1 from u_em_campo within w_con_vtas_comparativo_articulos
integer x = 169
integer y = 212
integer width = 224
integer height = 88
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "####"
string displaydata = "~r"
end type

type cb_consulta from u_boton within w_con_vtas_comparativo_articulos
integer x = 1682
integer y = 324
integer width = 411
integer height = 92
integer taborder = 80
string text = "&Consulta"
end type

event clicked;if m2.checked then
	f_cargar_m2(dw_1)
else
	f_cargar(dw_1)
end if


end event

type pb_imprimir_preli from picturebutton within w_con_vtas_comparativo_articulos
integer x = 2583
integer y = 324
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;if m2.checked then
	f_cargar_m2(dw_listado)
else
	f_cargar(dw_listado)
end if
f_imprimir_datawindow(dw_listado)
end event

type st_7 from statictext within w_con_vtas_comparativo_articulos
integer x = 169
integer y = 132
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Periodo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_vtas_comparativo_articulos
boolean visible = false
integer x = 5
integer width = 914
integer height = 88
boolean bringtotop = true
string dataobject = "report_ventas_comparativo_articulos"
boolean livescroll = true
end type

type em_periodo2 from u_em_campo within w_con_vtas_comparativo_articulos
integer x = 393
integer y = 212
integer width = 233
integer height = 88
integer taborder = 40
maskdatatype maskdatatype = numericmask!
string mask = "####"
string displaydata = "~r"
end type

type st_4 from statictext within w_con_vtas_comparativo_articulos
integer x = 631
integer y = 132
integer width = 786
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
string text = "Mes"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_mes1 from u_em_campo_2 within w_con_vtas_comparativo_articulos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 631
integer y = 212
integer width = 393
integer height = 88
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_mes1.em_campo.text=f_nombre_mes(Dec(uo_mes1.em_codigo.text))
IF Trim(uo_mes1.em_campo.text)="" THEN 
 IF Trim(uo_mes1.em_codigo.text)<>"" Then uo_mes1.em_campo.SetFocus()
 uo_mes1.em_campo.text=""
 uo_mes1.em_codigo.text=""
END IF

end event

on uo_mes1.destroy
call u_em_campo_2::destroy
end on

type uo_mes2 from u_em_campo_2 within w_con_vtas_comparativo_articulos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1029
integer y = 212
integer width = 384
integer height = 88
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_mes2.em_campo.text=f_nombre_mes(Dec(uo_mes2.em_codigo.text))
IF Trim(uo_mes2.em_campo.text)="" THEN 
 IF Trim(uo_mes2.em_codigo.text)<>"" Then uo_mes2.em_campo.SetFocus()
 uo_mes2.em_campo.text=""
 uo_mes2.em_codigo.text=""
END IF

end event

on uo_mes2.destroy
call u_em_campo_2::destroy
end on

type dw_1 from datawindow within w_con_vtas_comparativo_articulos
integer x = 18
integer y = 432
integer width = 2889
integer height = 1000
boolean bringtotop = true
string dataobject = "dw_ventas_comparativo_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type uo_serie from u_em_campo_2 within w_con_vtas_comparativo_articulos
event destroy ( )
integer x = 1458
integer y = 184
integer width = 453
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_serie.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_serie.em_campo.text=f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)

If Trim(uo_serie.em_campo.text)="" then
	uo_serie.em_campo.text=""
	uo_serie.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Series"
	ue_datawindow ="dw_ayuda_venseries"
	ue_filtro = ""

end event

type gb_6 from groupbox within w_con_vtas_comparativo_articulos
integer x = 1929
integer y = 124
integer width = 773
integer height = 176
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_con_vtas_comparativo_articulos
integer x = 1440
integer y = 124
integer width = 489
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

type m2 from checkbox within w_con_vtas_comparativo_articulos
integer x = 1952
integer y = 200
integer width = 713
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Convertir unidades a m2"
boolean lefttext = true
end type

type uo_1 from u_manejo_datawindow within w_con_vtas_comparativo_articulos
integer x = 2103
integer y = 280
integer width = 613
integer height = 164
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type gb_5 from groupbox within w_con_vtas_comparativo_articulos
integer x = 1669
integer y = 280
integer width = 439
integer height = 148
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_9 from groupbox within w_con_vtas_comparativo_articulos
integer x = 169
integer y = 280
integer width = 1495
integer height = 148
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

