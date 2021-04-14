$PBExportHeader$w_con_vtas_comparativo_formatos.srw
forward
global type w_con_vtas_comparativo_formatos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_vtas_comparativo_formatos
end type
type uo_1 from u_manejo_datawindow within w_con_vtas_comparativo_formatos
end type
type em_periodo1 from u_em_campo within w_con_vtas_comparativo_formatos
end type
type cb_consulta from u_boton within w_con_vtas_comparativo_formatos
end type
type pb_imprimir_preli from picturebutton within w_con_vtas_comparativo_formatos
end type
type st_7 from statictext within w_con_vtas_comparativo_formatos
end type
type dw_listado from datawindow within w_con_vtas_comparativo_formatos
end type
type em_periodo2 from u_em_campo within w_con_vtas_comparativo_formatos
end type
type st_4 from statictext within w_con_vtas_comparativo_formatos
end type
type uo_mes1 from u_em_campo_2 within w_con_vtas_comparativo_formatos
end type
type uo_mes2 from u_em_campo_2 within w_con_vtas_comparativo_formatos
end type
type dw_1 from datawindow within w_con_vtas_comparativo_formatos
end type
type uo_serie from u_em_campo_2 within w_con_vtas_comparativo_formatos
end type
type gb_4 from groupbox within w_con_vtas_comparativo_formatos
end type
end forward

global type w_con_vtas_comparativo_formatos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2944
integer height = 1680
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_1 uo_1
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
gb_4 gb_4
end type
global w_con_vtas_comparativo_formatos w_con_vtas_comparativo_formatos

type variables
String ante_articulo,retrasos,sector="",arg_articulo

end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);DataStore  dat
data.Retrieve(codigo_empresa,uo_mes1.em_campo.text,uo_mes2.em_campo.text)
data.SetRedraw(FALSE)
Dec total = 0

f_mascara_columna(data,"t1",f_mascara_decimales(0))
f_mascara_columna(data,"t2",f_mascara_decimales(0))
f_mascara_columna(data,"t3",f_mascara_decimales(0))
f_mascara_columna(data,"t4",f_mascara_decimales(2))


Dec contador,j,anyo,diferencia,por,ln
Dec {0} importe1,importe2

String sel,nombre_formato,formato


String serie1,serie2
if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

sel = " Select anyo,formato,Sum((neto - impdtopp) * cambio) total_fac_pts from venlifac" + &
		" Where  empresa      = '" + codigo_empresa + "'" + &
		" And    anyo         IN (" + em_periodo1.text + "," +em_periodo2.text+")" +&
		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
		" And    serie  between '" + serie1 + "' and '" +serie2+"'" +&
		" Group By anyo,formato"
		
//dat = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, dat)
contador = 0
For j = 1 To dat.RowCount()
	importe1 = 0
	importe2 = 0
	formato = dat.getItemSTring(j,"formato")
	anyo = dat.getItemNumber(j,"anyo")
	IF anyo = Dec(em_periodo1.text) Then importe1 = dat.getItemNumber(j,"total_fac_pts")	
	IF anyo = Dec(em_periodo2.text) Then importe2 = dat.getItemNumber(j,"total_fac_pts")	
	nombre_formato = f_nombre_formato(codigo_empresa,formato)
	sel = "formato='" + formato + "'"
	ln = data.find(sel,1,contador)
	If ln = 0 Then
		contador = contador +1
		data.InsertRow(contador)
		ln = contador
	ELSE
		IF importe1 = 0 Then importe1 = data.GetItemNumber(ln,"importe1")
		IF importe2 = 0 Then importe2 = data.GetItemNumber(ln,"importe2")
	END IF
	diferencia = importe2 - importe1
	data.SetItem(ln,"formato",formato)
	data.SetItem(ln,"nombre_formato",nombre_formato)
	data.SetItem(ln,"importe1",importe1)
	data.SetItem(ln,"importe2",importe2)	
	data.SetItem(ln,"diferencia",diferencia)		
	iF importe1 = 0 Then
		por = 0
	ELSE
		por = (diferencia * 100) / importe1
	END IF
	data.SetItem(ln,"porcentaje",por)		
	data.SetItem(ln,"anyo1",Dec(em_periodo1.text))
	data.SetItem(ln,"anyo2",Dec(em_periodo2.text))	
	total = total + importe2
Next
For j = 1 To data.RowCount()
	importe2 = data.GetItemNumber(j,"importe2")
	IF total = 0 Then
		data.SetItem(j,"porcentaje1",0)
	ELSE
   	data.SetItem(j,"porcentaje1",data.GetItemNumber(j,"importe2") * 100 / total)
	END IF
Next


data.SetRedraw(TRUE)
data.SetSort("importe2 D")
data.Sort()

destroy dat
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)

dw_listado.SetTransObject(sqlca)
This.title = " CONSULTA VENTAS POR ARTICULOS"
dw_1.Setfocus()
Integer x1,registros 
String var_codigo,var_texto,marca
f_activar_campo(em_periodo1)


end event

on w_con_vtas_comparativo_formatos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
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
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.em_periodo1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.pb_imprimir_preli
this.Control[iCurrent+6]=this.st_7
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.em_periodo2
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.uo_mes1
this.Control[iCurrent+11]=this.uo_mes2
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.uo_serie
this.Control[iCurrent+14]=this.gb_4
end on

on w_con_vtas_comparativo_formatos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
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
destroy(this.gb_4)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_vtas_comparativo_formatos
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_vtas_comparativo_formatos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_vtas_comparativo_formatos
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_vtas_comparativo_formatos
integer x = 2738
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type uo_1 from u_manejo_datawindow within w_con_vtas_comparativo_formatos
integer x = 2235
integer y = 160
integer width = 613
integer height = 164
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type em_periodo1 from u_em_campo within w_con_vtas_comparativo_formatos
integer x = 41
integer y = 212
integer width = 224
integer height = 88
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "####"
string displaydata = "~r"
end type

type cb_consulta from u_boton within w_con_vtas_comparativo_formatos
integer x = 1838
integer y = 208
integer width = 393
integer height = 88
integer taborder = 60
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)

end event

type pb_imprimir_preli from picturebutton within w_con_vtas_comparativo_formatos
integer x = 2715
integer y = 204
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

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type st_7 from statictext within w_con_vtas_comparativo_formatos
integer x = 41
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

type dw_listado from datawindow within w_con_vtas_comparativo_formatos
boolean visible = false
integer x = 5
integer width = 914
integer height = 88
boolean bringtotop = true
string dataobject = "report_ventas_comparativo_formatos"
boolean livescroll = true
end type

type em_periodo2 from u_em_campo within w_con_vtas_comparativo_formatos
integer x = 265
integer y = 212
integer width = 233
integer height = 88
integer taborder = 20
maskdatatype maskdatatype = numericmask!
string mask = "####"
string displaydata = "~r"
end type

type st_4 from statictext within w_con_vtas_comparativo_formatos
integer x = 503
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

type uo_mes1 from u_em_campo_2 within w_con_vtas_comparativo_formatos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 503
integer y = 212
integer width = 393
integer height = 88
integer taborder = 30
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

type uo_mes2 from u_em_campo_2 within w_con_vtas_comparativo_formatos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 901
integer y = 212
integer width = 384
integer height = 88
integer taborder = 40
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

type dw_1 from datawindow within w_con_vtas_comparativo_formatos
integer x = 18
integer y = 316
integer width = 2821
integer height = 1116
boolean bringtotop = true
string dataobject = "dw_ventas_comparativo_formatos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type uo_serie from u_em_campo_2 within w_con_vtas_comparativo_formatos
event destroy ( )
integer x = 1321
integer y = 188
integer width = 453
integer taborder = 50
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

type gb_4 from groupbox within w_con_vtas_comparativo_formatos
integer x = 1303
integer y = 128
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

