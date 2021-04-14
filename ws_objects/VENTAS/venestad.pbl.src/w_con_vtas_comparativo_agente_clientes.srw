$PBExportHeader$w_con_vtas_comparativo_agente_clientes.srw
forward
global type w_con_vtas_comparativo_agente_clientes from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_vtas_comparativo_agente_clientes
end type
type em_periodo1 from u_em_campo within w_con_vtas_comparativo_agente_clientes
end type
type st_7 from statictext within w_con_vtas_comparativo_agente_clientes
end type
type dw_listado from datawindow within w_con_vtas_comparativo_agente_clientes
end type
type em_periodo2 from u_em_campo within w_con_vtas_comparativo_agente_clientes
end type
type st_4 from statictext within w_con_vtas_comparativo_agente_clientes
end type
type uo_mes1 from u_em_campo_2 within w_con_vtas_comparativo_agente_clientes
end type
type uo_mes2 from u_em_campo_2 within w_con_vtas_comparativo_agente_clientes
end type
type st_8 from statictext within w_con_vtas_comparativo_agente_clientes
end type
type uo_agente from u_em_campo_2 within w_con_vtas_comparativo_agente_clientes
end type
type cb_consulta from u_boton within w_con_vtas_comparativo_agente_clientes
end type
type dw_1 from datawindow within w_con_vtas_comparativo_agente_clientes
end type
type m2 from checkbox within w_con_vtas_comparativo_agente_clientes
end type
type pb_imprimir_preli from picturebutton within w_con_vtas_comparativo_agente_clientes
end type
type uo_1 from u_manejo_datawindow within w_con_vtas_comparativo_agente_clientes
end type
type gb_1 from groupbox within w_con_vtas_comparativo_agente_clientes
end type
end forward

global type w_con_vtas_comparativo_agente_clientes from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2962
integer height = 1664
string title = "Consulta de Movimientos"
pb_2 pb_2
em_periodo1 em_periodo1
st_7 st_7
dw_listado dw_listado
em_periodo2 em_periodo2
st_4 st_4
uo_mes1 uo_mes1
uo_mes2 uo_mes2
st_8 st_8
uo_agente uo_agente
cb_consulta cb_consulta
dw_1 dw_1
m2 m2
pb_imprimir_preli pb_imprimir_preli
uo_1 uo_1
gb_1 gb_1
end type
global w_con_vtas_comparativo_agente_clientes w_con_vtas_comparativo_agente_clientes

type variables
String ante_articulo,retrasos,sector="",arg_articulo

end variables

forward prototypes
public subroutine f_cargar (datawindow data)
public subroutine f_cargar_m2 (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);DataStore  dat
data.Retrieve(codigo_empresa,uo_mes1.em_campo.text,uo_mes2.em_campo.text)
data.SetRedraw(FALSE)
Dec total = 0

// CONTROLES
//if trim(uo_agente.em_campo.text)="" then 
//	f_mensaje("Atención","Debe introducir el agente")
//	f_activar_campo(uo_agente.em_campo)
//	REturn
//End if
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
f_mascara_columna(data,"importe2",f_mascara_decimales(0))
f_mascara_columna(data,"importe1",f_mascara_decimales(0))
f_mascara_columna(data,"diferencia",f_mascara_decimales(0))


Dec contador,j,anyo,diferencia,por,ln
Dec {0} importe1,importe2

String sel,nombre_cliente,cliente,agen

if Trim(uo_agente.em_codigo.text) = "" or IsNull(uo_agente.em_codigo.text) then
	agen = ""
else
	agen = " And    agente1 = '" + uo_agente.em_codigo.text + "'"
end if

String serie1,serie2,agente

sel = " Select anyo,agente1,cliente,sum((total_neto - impdtopp) * cambio) total_fac_pts from venfac" + &
		" Where  empresa      = '" + codigo_empresa + "'" + &
		" And    anyo         IN (" + em_periodo1.text + "," +em_periodo2.text+")" +&
		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
		agen +&
		" Group By anyo,agente1,cliente"
		
//dat = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, dat)
contador = 0
For j = 1 To dat.RowCount()
	importe1 = 0
	importe2 = 0
	cliente = dat.getItemSTring(j,"cliente")
	agente = dat.getItemSTring(j,"agente1")	
	anyo = dat.getItemNumber(j,"anyo")
	IF anyo = Dec(em_periodo1.text) Then importe1 = dat.getItemNumber(j,"total_fac_pts")	
	IF anyo = Dec(em_periodo2.text) Then importe2 = dat.getItemNumber(j,"total_fac_pts")	
	nombre_cliente = f_nombre_cliente(codigo_empresa,"C",cliente)
	sel = "cliente='" + cliente + "'"
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
	data.SetItem(ln,"cliente",cliente)
	//***
	//f_mensaje(agente, f_nombre_venagentes(codigo_empresa,agente))
	data.SetItem(ln,"agente",agente)
	data.SetItem(ln,"nombre_cliente",nombre_cliente)
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
	IF total = 0 Then
		data.SetItem(j,"porcentaje1",0)
	ELSE
   	data.SetItem(j,"porcentaje1",data.GetItemNumber(j,"importe2") * 100 / total)
	END IF
Next


data.SetRedraw(TRUE)
//data.SetSort("importe2 D")
//data.Sort()

destroy daT
end subroutine

public subroutine f_cargar_m2 (datawindow data);DataStore  dat
data.Retrieve(codigo_empresa,uo_mes1.em_campo.text,uo_mes2.em_campo.text)
data.SetRedraw(FALSE)
Dec total = 0

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


f_mascara_columna(data,"t1",f_mascara_decimales(2))
f_mascara_columna(data,"t2",f_mascara_decimales(2))
f_mascara_columna(data,"t3",f_mascara_decimales(2))
f_mascara_columna(data,"t4",f_mascara_decimales(2))
f_mascara_columna(data,"importe2",f_mascara_decimales(2))
f_mascara_columna(data,"importe1",f_mascara_decimales(2))
f_mascara_columna(data,"diferencia",f_mascara_decimales(2))

Dec contador,j,anyo,diferencia,por,ln
Dec {2} importe1,importe2,importe1_aux,importe2_aux

String sel,nombre_cliente,cliente,agen

if Trim(uo_agente.em_codigo.text) = "" or IsNull(uo_agente.em_codigo.text) then
	agen = ""
else
	agen = " And    agente1 = '" + uo_agente.em_codigo.text + "'"
end if

String serie1,serie2,agente

sel = " Select anyo,agente1,cliente,Sum(cantidad) cantidad,max(articulo) articulo from venlifac" + &
				" Where  empresa      = '" + codigo_empresa + "'" + &
		" And    anyo         IN (" + em_periodo1.text + "," +em_periodo2.text+")" +&
		" And    mes    between " + uo_mes1.em_codigo.text + " and " +uo_mes2.em_codigo.text +&
		agen +&
		" Group By anyo,agente1,cliente,formato" +&
		" Order By anyo,agente1,cliente,formato"
//dat = f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, dat)

long cantidad
string articulo

importe1_aux = 0
importe2_aux = 0
contador = 0

For j = 1 To dat.RowCount()

	importe1 = 0
   importe2 = 0

	cliente = dat.getItemSTring(j,"cliente")
	agente = dat.getItemSTring(j,"agente1")
	anyo = dat.getItemNumber(j,"anyo")
	cantidad = dat.getItemNumber(j,"cantidad")
	articulo = dat.getItemSTring(j,"articulo")
	
	
	IF anyo = Dec(em_periodo1.text) Then
		importe1 = f_conversion_cantidad_m2(codigo_empresa,articulo,cantidad)	
	end if
	IF anyo = Dec(em_periodo2.text) Then
		importe2 = f_conversion_cantidad_m2(codigo_empresa,articulo,cantidad)						
	end if
	
	nombre_cliente = f_nombre_cliente(codigo_empresa,"C",cliente)
	sel = "cliente='" + cliente + "'"
	ln = data.find(sel,1,contador)
	
	If ln = 0 Then		
		contador = contador +1
		ln = data.InsertRow(contador)
		
	ELSE		
		importe1_aux = data.GetItemNumber(ln,"importe1")
		IF IsNull(importe1_aux) Then importe1_aux = 0 
		importe1 = importe1 + importe1_aux				
		
		importe2_aux = data.GetItemNumber(ln,"importe2")
		IF IsNull(importe2_aux) Then importe2_aux = 0 
		importe2 = importe2 + importe2_aux				
		
	END IF
	
	diferencia = importe2 - importe1
	data.SetItem(ln,"cliente",cliente)
	data.SetItem(ln,"agente",agente)
	data.SetItem(ln,"nombre_cliente",nombre_cliente)
	data.SetItem(ln,"importe1",importe1)
	data.SetItem(ln,"importe2",importe2)	
	data.SetItem(ln,"diferencia",diferencia)	
	data.SetItem(ln,"unidad","M2")
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
	IF total = 0 Then
		data.SetItem(j,"porcentaje1",0)
	ELSE
   	data.SetItem(j,"porcentaje1",data.GetItemNumber(j,"importe2") * 100 / total)
	END IF
Next


data.SetRedraw(TRUE)

destroy dat
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)

dw_listado.SetTransObject(sqlca)
This.title = " CONSULTA VENTAS POR AGENTE/CLIENTES"

em_periodo1.text = string(year(today()))
em_periodo2.text = string(year(today())-1)
uo_mes1.em_codigo.text = "1"
uo_mes1.em_campo.text =f_nombre_mes(Dec(uo_mes1.em_codigo.text))
uo_mes2.em_codigo.text = string(month(today()))
uo_mes2.em_campo.text =f_nombre_mes(Dec(uo_mes2.em_codigo.text))

dw_1.Setfocus()
Integer x1,registros 
String var_codigo,var_texto,marca
f_activar_campo(uo_agente.em_campo)


end event

on w_con_vtas_comparativo_agente_clientes.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_periodo1=create em_periodo1
this.st_7=create st_7
this.dw_listado=create dw_listado
this.em_periodo2=create em_periodo2
this.st_4=create st_4
this.uo_mes1=create uo_mes1
this.uo_mes2=create uo_mes2
this.st_8=create st_8
this.uo_agente=create uo_agente
this.cb_consulta=create cb_consulta
this.dw_1=create dw_1
this.m2=create m2
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_periodo1
this.Control[iCurrent+3]=this.st_7
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.em_periodo2
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.uo_mes1
this.Control[iCurrent+8]=this.uo_mes2
this.Control[iCurrent+9]=this.st_8
this.Control[iCurrent+10]=this.uo_agente
this.Control[iCurrent+11]=this.cb_consulta
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.m2
this.Control[iCurrent+14]=this.pb_imprimir_preli
this.Control[iCurrent+15]=this.uo_1
this.Control[iCurrent+16]=this.gb_1
end on

on w_con_vtas_comparativo_agente_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_periodo1)
destroy(this.st_7)
destroy(this.dw_listado)
destroy(this.em_periodo2)
destroy(this.st_4)
destroy(this.uo_mes1)
destroy(this.uo_mes2)
destroy(this.st_8)
destroy(this.uo_agente)
destroy(this.cb_consulta)
destroy(this.dw_1)
destroy(this.m2)
destroy(this.pb_imprimir_preli)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_vtas_comparativo_agente_clientes
integer taborder = 80
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_vtas_comparativo_agente_clientes
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_vtas_comparativo_agente_clientes
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_vtas_comparativo_agente_clientes
integer x = 2729
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
end type

type em_periodo1 from u_em_campo within w_con_vtas_comparativo_agente_clientes
integer x = 855
integer y = 216
integer width = 169
integer taborder = 40
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "0000"
string displaydata = "<xw_con_vtas_comparativo_clientes"
end type

type st_7 from statictext within w_con_vtas_comparativo_agente_clientes
integer x = 18
integer y = 136
integer width = 832
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Agente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_vtas_comparativo_agente_clientes
boolean visible = false
integer x = 9
integer width = 50
integer height = 64
boolean bringtotop = true
string dataobject = "report_ventas_comparativo_clientes"
boolean livescroll = true
end type

type em_periodo2 from u_em_campo within w_con_vtas_comparativo_agente_clientes
integer x = 1024
integer y = 216
integer width = 165
integer taborder = 50
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "0000"
string displaydata = "ð"
end type

type st_4 from statictext within w_con_vtas_comparativo_agente_clientes
integer x = 1193
integer y = 136
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

type uo_mes1 from u_em_campo_2 within w_con_vtas_comparativo_agente_clientes
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1193
integer y = 216
integer width = 393
integer taborder = 60
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

type uo_mes2 from u_em_campo_2 within w_con_vtas_comparativo_agente_clientes
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1591
integer y = 216
integer width = 384
integer taborder = 70
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

type st_8 from statictext within w_con_vtas_comparativo_agente_clientes
integer x = 850
integer y = 136
integer width = 343
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

type uo_agente from u_em_campo_2 within w_con_vtas_comparativo_agente_clientes
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 23
integer y = 216
integer width = 827
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)

If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;	ue_titulo = "Selección de Agente"
	ue_datawindow ="dw_ayuda_venagentes"
	ue_filtro = ""

end event

on uo_agente.destroy
call u_em_campo_2::destroy
end on

type cb_consulta from u_boton within w_con_vtas_comparativo_agente_clientes
integer x = 1998
integer y = 208
integer width = 242
integer height = 84
integer taborder = 20
string text = "&Consulta"
end type

event clicked;if m2.checked then
	f_cargar_m2(dw_1)
else
	f_cargar(dw_1)
end if	

end event

type dw_1 from datawindow within w_con_vtas_comparativo_agente_clientes
integer x = 18
integer y = 312
integer width = 2834
integer height = 1120
string dataobject = "dw_ventas_comparativo_agentes_clientes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type m2 from checkbox within w_con_vtas_comparativo_agente_clientes
integer x = 1998
integer y = 144
integer width = 155
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "m2"
boolean lefttext = true
end type

type pb_imprimir_preli from picturebutton within w_con_vtas_comparativo_agente_clientes
integer x = 2729
integer y = 168
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;dw_listado.visible = True
if m2.checked then
	f_cargar_m2(dw_listado)
else
	f_cargar(dw_listado)
end if	

f_imprimir_datawindow(dw_listado)
dw_listado.visible = False
end event

type uo_1 from u_manejo_datawindow within w_con_vtas_comparativo_agente_clientes
integer x = 2249
integer y = 124
integer width = 599
integer height = 164
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type gb_1 from groupbox within w_con_vtas_comparativo_agente_clientes
integer x = 1984
integer y = 100
integer width = 270
integer height = 204
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

