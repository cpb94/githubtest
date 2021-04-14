$PBExportHeader$w_con_vtas_comparativo_provincias.srw
forward
global type w_con_vtas_comparativo_provincias from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_vtas_comparativo_provincias
end type
type em_periodo1 from u_em_campo within w_con_vtas_comparativo_provincias
end type
type cb_consulta from u_boton within w_con_vtas_comparativo_provincias
end type
type uo_pais from u_em_campo_2 within w_con_vtas_comparativo_provincias
end type
type st_3 from statictext within w_con_vtas_comparativo_provincias
end type
type st_7 from statictext within w_con_vtas_comparativo_provincias
end type
type dw_1 from datawindow within w_con_vtas_comparativo_provincias
end type
type dw_listado from datawindow within w_con_vtas_comparativo_provincias
end type
type em_periodo2 from u_em_campo within w_con_vtas_comparativo_provincias
end type
type st_4 from statictext within w_con_vtas_comparativo_provincias
end type
type uo_mes1 from u_em_campo_2 within w_con_vtas_comparativo_provincias
end type
type uo_mes2 from u_em_campo_2 within w_con_vtas_comparativo_provincias
end type
type uo_1 from u_manejo_datawindow within w_con_vtas_comparativo_provincias
end type
type pb_imprimir_preli from picturebutton within w_con_vtas_comparativo_provincias
end type
end forward

global type w_con_vtas_comparativo_provincias from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2935
integer height = 1660
string title = "Consulta de Movimientos"
pb_2 pb_2
em_periodo1 em_periodo1
cb_consulta cb_consulta
uo_pais uo_pais
st_3 st_3
st_7 st_7
dw_1 dw_1
dw_listado dw_listado
em_periodo2 em_periodo2
st_4 st_4
uo_mes1 uo_mes1
uo_mes2 uo_mes2
uo_1 uo_1
pb_imprimir_preli pb_imprimir_preli
end type
global w_con_vtas_comparativo_provincias w_con_vtas_comparativo_provincias

type variables
String ante_articulo,retrasos,sector="",arg_articulo

end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);DataStore  dat
data.Retrieve(codigo_empresa, uo_mes1.em_campo.text, uo_mes2.em_campo.text)
data.SetRedraw(FALSE)
Dec {0} importe1,importe2
Dec total = 0

if Trim(uo_pais.em_campo.text) ="" then 
	f_mensaje("Atención","Introduzca un Pais")
	f_activar_campo(uo_pais.em_campo)
	REturn
End if

if Dec(em_periodo1.text) =0 then 
	f_mensaje("Atención","Error en periodo desde")
	f_activar_campo(em_periodo1)
	REturn
End if
if Dec(em_periodo2.text) =0 then 
	f_mensaje("Atención","Error en periodo hasta")
	f_activar_campo(em_periodo2)
	REturn
End if
if Trim(uo_mes1.em_campo.text) ="" then 
	f_mensaje("Atención","Error en mes desde")
	f_activar_campo(uo_mes1.em_campo)
	REturn
End if
if Trim(uo_mes2.em_campo.text) ="" then 
	f_mensaje("Atención","Error en mes hasta")
	f_activar_campo(uo_mes2.em_campo)
	REturn
End if

f_mascara_columna(data,"t1",f_mascara_decimales(0))
f_mascara_columna(data,"t2",f_mascara_decimales(0))
f_mascara_columna(data,"t3",f_mascara_decimales(0))
f_mascara_columna(data,"t4",f_mascara_decimales(2))

Dec contador,j,anyo,diferencia,por,ln

String sel,provincia,nombre_provincia,pais

pais =  uo_pais.em_codigo.text

sel = " Select anyo,provincia,Sum((total_neto - impdtopp) * cambio) total_fac_pts from venfac" + &
		" Where  empresa      = '" + codigo_empresa + "'" + &
		" And    anyo         IN (" + em_periodo1.text + "," +em_periodo2.text+")" +&
		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
		" And    pais = '"+String(pais) + "'" +&
		" Group By anyo,provincia"
		
//dat = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, dat)
contador = 0
For j = 1 To dat.RowCount()
	importe1 = 0
	importe2 = 0

	provincia = dat.getItemSTring(j,"provincia")
	anyo = dat.getItemNumber(j,"anyo")
	IF anyo = Dec(em_periodo1.text) Then importe1 = dat.getItemNumber(j,"total_fac_pts")	
	IF anyo = Dec(em_periodo2.text) Then importe2 = dat.getItemNumber(j,"total_fac_pts")	
	nombre_provincia = f_nombre_provincia(pais,provincia)
	sel = " provincia = '"+provincia+"'"
	ln = data.find(sel,1,contador)
	IF ln = 0 Then
		contador = contador +1
		ln = contador
		data.InsertRow(contador)
	ELSE
		IF importe1 = 0 Then importe1 = data.GetItemNumber(ln,"importe1")
		IF importe2 = 0 Then importe2 = data.GetItemNumber(ln,"importe2")
	END IF
	diferencia = importe2 - importe1
	data.SetItem(ln,"provincia",provincia)
	data.SetItem(ln,"nombre_provincia",nombre_provincia)
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
	IF total = 0 or data.GetItemNumber(j,"importe2")=0 Then
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
This.title = " CONSULTA VENTAS POR PROVINCIAS"
dw_1.Setfocus()
Integer x1,registros 
String var_codigo,var_texto,marca

f_activar_campo(uo_pais.em_campo)


end event

on w_con_vtas_comparativo_provincias.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_periodo1=create em_periodo1
this.cb_consulta=create cb_consulta
this.uo_pais=create uo_pais
this.st_3=create st_3
this.st_7=create st_7
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.em_periodo2=create em_periodo2
this.st_4=create st_4
this.uo_mes1=create uo_mes1
this.uo_mes2=create uo_mes2
this.uo_1=create uo_1
this.pb_imprimir_preli=create pb_imprimir_preli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_periodo1
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.uo_pais
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_7
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.dw_listado
this.Control[iCurrent+9]=this.em_periodo2
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.uo_mes1
this.Control[iCurrent+12]=this.uo_mes2
this.Control[iCurrent+13]=this.uo_1
this.Control[iCurrent+14]=this.pb_imprimir_preli
end on

on w_con_vtas_comparativo_provincias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_periodo1)
destroy(this.cb_consulta)
destroy(this.uo_pais)
destroy(this.st_3)
destroy(this.st_7)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.em_periodo2)
destroy(this.st_4)
destroy(this.uo_mes1)
destroy(this.uo_mes2)
destroy(this.uo_1)
destroy(this.pb_imprimir_preli)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_vtas_comparativo_provincias
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_vtas_comparativo_provincias
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_vtas_comparativo_provincias
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_vtas_comparativo_provincias
integer x = 2738
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type em_periodo1 from u_em_campo within w_con_vtas_comparativo_provincias
integer x = 745
integer y = 212
integer width = 224
integer height = 88
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "0000"
string displaydata = ""
end type

type cb_consulta from u_boton within w_con_vtas_comparativo_provincias
integer x = 1925
integer y = 216
integer width = 283
integer height = 84
integer taborder = 60
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
end event

type uo_pais from u_em_campo_2 within w_con_vtas_comparativo_provincias
integer x = 32
integer y = 212
integer width = 709
integer height = 88
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)
IF Trim(uo_pais.em_campo.text)="" THEN 
 IF Trim(uo_pais.em_codigo.text)<>"" Then uo_pais.em_campo.SetFocus()
 uo_pais.em_campo.text=""
 uo_pais.em_codigo.text=""
END IF
//String mascara
//mascara = f_mascara_unidad(f_unidad_pais(codigo_empresa,uo_pais.em_codigo.text))
//
//f_mascara_columna(dw_1,"cantidads",mascara)
//f_mascara_columna(dw_1,"cantidade",mascara)
//f_mascara_columna(dw_1,"stock",mascara)
//f_mascara_columna(dw_listado,"cantidads",mascara)
//f_mascara_columna(dw_listado,"cantidade",mascara)
//f_mascara_columna(dw_listado,"stock",mascara)
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de paises"
ue_datawindow = "dw_ayuda_paises"
ue_filtro     = ""
valor_empresa = FALSE
end event

on uo_pais.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within w_con_vtas_comparativo_provincias
integer x = 32
integer y = 132
integer width = 713
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
string text = "Pais"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_7 from statictext within w_con_vtas_comparativo_provincias
integer x = 745
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

type dw_1 from datawindow within w_con_vtas_comparativo_provincias
integer x = 18
integer y = 316
integer width = 2834
integer height = 1116
string dataobject = "dw_ventas_comparativo_provincias"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_listado from datawindow within w_con_vtas_comparativo_provincias
boolean visible = false
integer x = 5
integer width = 46
integer height = 40
boolean bringtotop = true
string dataobject = "report_ventas_comparativo_provincias"
boolean livescroll = true
end type

type em_periodo2 from u_em_campo within w_con_vtas_comparativo_provincias
integer x = 969
integer y = 212
integer width = 233
integer height = 88
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "0000"
string displaydata = "~r"
end type

type st_4 from statictext within w_con_vtas_comparativo_provincias
integer x = 1202
integer y = 132
integer width = 709
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

type uo_mes1 from u_em_campo_2 within w_con_vtas_comparativo_provincias
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1202
integer y = 212
integer width = 361
integer height = 88
integer taborder = 40
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

type uo_mes2 from u_em_campo_2 within w_con_vtas_comparativo_provincias
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1568
integer y = 212
integer width = 343
integer height = 88
integer taborder = 50
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

type uo_1 from u_manejo_datawindow within w_con_vtas_comparativo_provincias
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

type pb_imprimir_preli from picturebutton within w_con_vtas_comparativo_provincias
integer x = 2711
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

event clicked;dw_listado.visible = True
f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
dw_listado.visible = False
end event

