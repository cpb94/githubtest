$PBExportHeader$w_compara_alb_fras_mes.srw
forward
global type w_compara_alb_fras_mes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_compara_alb_fras_mes
end type
type pb_2 from upb_imprimir within w_compara_alb_fras_mes
end type
type uo_manejo from u_manejo_datawindow within w_compara_alb_fras_mes
end type
type cb_1 from commandbutton within w_compara_alb_fras_mes
end type
type gb_6 from groupbox within w_compara_alb_fras_mes
end type
type gb_4 from groupbox within w_compara_alb_fras_mes
end type
type gb_3 from groupbox within w_compara_alb_fras_mes
end type
type gb_5 from groupbox within w_compara_alb_fras_mes
end type
type gb_1 from groupbox within w_compara_alb_fras_mes
end type
type dw_listado from datawindow within w_compara_alb_fras_mes
end type
type uo_mes1 from u_em_campo_2 within w_compara_alb_fras_mes
end type
type em_anyo from u_em_campo within w_compara_alb_fras_mes
end type
type unidad_a_convertir from dropdownlistbox within w_compara_alb_fras_mes
end type
type gb_2 from groupbox within w_compara_alb_fras_mes
end type
type uo_familia from u_marca_lista within w_compara_alb_fras_mes
end type
type cb_4 from commandbutton within w_compara_alb_fras_mes
end type
type dw_detalle from datawindow within w_compara_alb_fras_mes
end type
type cb_7 from commandbutton within w_compara_alb_fras_mes
end type
type uo_formato from u_marca_lista within w_compara_alb_fras_mes
end type
end forward

global type w_compara_alb_fras_mes from w_int_con_empresa
integer width = 2976
integer height = 1508
pb_1 pb_1
pb_2 pb_2
uo_manejo uo_manejo
cb_1 cb_1
gb_6 gb_6
gb_4 gb_4
gb_3 gb_3
gb_5 gb_5
gb_1 gb_1
dw_listado dw_listado
uo_mes1 uo_mes1
em_anyo em_anyo
unidad_a_convertir unidad_a_convertir
gb_2 gb_2
uo_familia uo_familia
cb_4 cb_4
dw_detalle dw_detalle
cb_7 cb_7
uo_formato uo_formato
end type
global w_compara_alb_fras_mes w_compara_alb_fras_mes

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string sel,articulo,calidad,caja,divisa,situacion,serie
string busqueda,unidad_conversion,unidad,fami,familia,form,formato
int    dia,indice2,indice_fam,i,indice_form
long   indice,total,donde
dec    total_neto,total_cantidad,cambio
date   f_desde,f_hasta
DataStore cargas


data.Reset()
data.SetRedraw(FALSE)
uo_familia.visible=false
uo_formato.visible=false

indice_fam = 0
familia=''
for i=1 to uo_familia.dw_marca.rowcount()
	if uo_familia.dw_marca.getitemstring(i,"marca")="S" then
		fami = uo_familia.dw_marca.getitemstring(i,"codigo")
		indice_fam ++		
		if indice_fam=1 then
			familia='('+"'"+fami+"'"
		else
			familia=familia+','+"'"+fami+"'"
		end if
	end if	
next

familia=familia+')'

indice_form = 0
formato=''
for i=1 to uo_formato.dw_marca.rowcount()
	if uo_formato.dw_marca.getitemstring(i,"marca")="S" then
		form = uo_formato.dw_marca.getitemstring(i,"codigo")
		indice_form ++		
		if indice_form=1 then
			formato='('+"'"+form+"'"
		else
			formato=formato+','+"'"+form+"'"
		end if
	end if	
next

formato=formato+')'

if unidad_a_convertir.text = "Unidades" then
	unidad_conversion = "0"
else
	unidad_conversion = "1"
end if
f_desde = mdy(dec(uo_mes1.em_codigo.text),1,dec(em_anyo.text))
if dec(uo_mes1.em_codigo.text) = 12 then
	f_hasta = mdy(1,1,dec(em_anyo.text)+1)	
else
	f_hasta = mdy(dec(uo_mes1.em_codigo.text) +1,1,dec(em_anyo.text))	
end if
f_hasta = relativedate(f_hasta,-1)

data.Retrieve(codigo_empresa,dec(em_anyo.text),dec(uo_mes1.em_codigo.text),unidad_conversion)

Sel = "SELECT articulo,calidad,caja,falbaran,cambio,divisa,serie"+&
		",sum(neto - impdtopp) total_neto,sum(cantidad_pedido) total_cantidad,'F' situacion "+&
      "FROM   venlifac "+&
		"WHERE  empresa = '"+codigo_empresa+"' "+&
		"And    falbaran between '"+STring(f_desde,"dd/mm/yy")+"'  and '"+STring(f_hasta,"dd/mm/yy")+"' "+&
		"and    (articulo <> '' and articulo is not null) "+&
		"and familia in "+familia+&
		" and formato in "+formato+&
		"GROUP By articulo,calidad,caja,falbaran,cambio,divisa,serie "+&
		"UNION "+&
      "SELECT articulo,calidad,caja,falbaran,0 cambio,divisa,serie "+&
      ",sum(neto - impdtopp) total_neto,sum(cantidad_pedido) total_cantidad,'A' situacion "+&
		"FROM   venlialb "+&
		"WHERE  empresa = '"+codigo_empresa+"' "+&
		"And    falbaran between '"+STring(f_desde,"dd/mm/yy")+"'  and '"+STring(f_hasta,"dd/mm/yy")+"' "+&
		"and    (articulo <> '' and articulo is not null) "+&		
		"and familia in "+familia+&
		" and formato in "+formato+&
		"GROUP By articulo,calidad,caja,falbaran,divisa,serie "
//cargas = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, cargas)
total  = cargas.rowcount()
for indice = 1 to total
	f_mensaje_proceso("Cargando Albaranes",indice,total)
	dia            = day(date(cargas.object.falbaran[indice]))
	articulo       = cargas.object.articulo[indice]
	calidad        = cargas.object.calidad[indice]
	caja           = cargas.object.caja[indice]	
	divisa         = cargas.object.divisa[indice]
	total_neto     = cargas.object.total_neto[indice]
	total_cantidad = cargas.object.total_cantidad[indice]
	situacion      = cargas.object.situacion[indice]
	serie          = cargas.object.serie[indice]
	if situacion = "A" then
		cambio = f_cambio_moneda(divisa)
	else
		cambio = cargas.object.cambio[indice]
	end if
	total_neto     = total_neto * cambio
	unidad = f_unidad_articulo(codigo_empresa,articulo)
	if unidad = "1" and unidad_conversion = "1" then
		total_cantidad =  f_m2_reales_articulo_caja(codigo_empresa,articulo,&
											      			  caja,total_cantidad)
	end if	
	if unidad_conversion = "1" and unidad <> "1" then 
		total_cantidad = f_conversion_cantidad_m2(codigo_empresa,articulo,total_cantidad)
	end if
	if unidad_conversion = "0" and unidad <> "0" then 
		total_cantidad = f_conversion_cantidad_piezas_old(codigo_empresa,articulo,total_cantidad)
	end if
	busqueda = "dia = "+string(dia)+" and calidad = '"+calidad+"'"
	donde    = data.find(busqueda,1,data.rowcount())
	if donde = 0 then
		donde = data.insertrow(0)
		data.object.empresa[donde] = codigo_empresa
		data.object.dia[donde]     = dia
		data.object.unidad[donde]  = unidad_conversion
		data.object.calidad[donde] = calidad
		data.object.moneda[donde]  = "1"
		for indice2 = 1 to 4
			if serie = string(indice2) then
				data.setitem(donde,"cantidad"+string(indice2)+"_albaranes",total_cantidad)
				data.setitem(donde,"importe"+string(indice2)+"_albaranes",total_neto)
				data.setitem(donde,"cantidad"+string(indice2)+"_facturas",0)
				data.setitem(donde,"importe"+string(indice2)+"_facturas",0)								
			else
				data.setitem(donde,"cantidad"+string(indice2)+"_albaranes",0)
				data.setitem(donde,"importe"+string(indice2)+"_albaranes",0)
				data.setitem(donde,"cantidad"+string(indice2)+"_facturas",0)
				data.setitem(donde,"importe"+string(indice2)+"_facturas",0)								
			end if
		next
	else
		for indice2 = 1 to 4
			if serie = string(indice2) then
				total_cantidad = total_cantidad + data.getitemnumber(donde,"cantidad"+string(indice2)+"_albaranes")
				total_neto     = total_neto     + data.getitemnumber(donde,"importe"+string(indice2)+"_albaranes")
				data.setitem(donde,"cantidad"+string(indice2)+"_albaranes",total_cantidad)
				data.setitem(donde,"importe"+string(indice2)+"_albaranes",total_neto)
			end if
		next		
	end if
next
Sel = "SELECT articulo,calidad,caja,ffactura,cambio,divisa,serie"+&
		",sum(neto - impdtopp) total_neto,sum(cantidad_pedido) total_cantidad "+&
      "FROM   venlifac "+&
		"WHERE  empresa = '"+codigo_empresa+"' "+&
		"And    ffactura between '"+STring(f_desde,"dd/mm/yy")+"'  and '"+STring(f_hasta,"dd/mm/yy")+"' "+&
		"and    (articulo <> '' and articulo is not null) "+&		
		"and familia in "+familia+&
		" and formato in "+formato+&		
		"GROUP By articulo,calidad,caja,ffactura,cambio,divisa,serie "

//cargas = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, cargas)
total  = cargas.rowcount()
for indice = 1 to total
	f_mensaje_proceso("Cargando Facturas",indice,total)
	dia            = day(date(cargas.object.ffactura[indice]))
	articulo       = cargas.object.articulo[indice]
	calidad        = cargas.object.calidad[indice]
	caja           = cargas.object.caja[indice]	
	divisa         = cargas.object.divisa[indice]
	total_neto     = cargas.object.total_neto[indice]
	total_cantidad = cargas.object.total_cantidad[indice]
	serie          = cargas.object.serie[indice]
	cambio         = cargas.object.cambio[indice]
	total_neto     = total_neto * cambio
	unidad = f_unidad_articulo(codigo_empresa,articulo)
	if unidad = "1" and unidad_conversion = "1" then
		total_cantidad =  f_m2_reales_articulo_caja(codigo_empresa,articulo,&
											      			  caja,total_cantidad)
	end if	
	if unidad_conversion = "1" and unidad <> "1" then 
		total_cantidad = f_conversion_cantidad_m2(codigo_empresa,articulo,total_cantidad)
	end if
	if unidad_conversion = "0" and unidad <> "0" then 
		total_cantidad = f_conversion_cantidad_piezas_old(codigo_empresa,articulo,total_cantidad)
	end if
	busqueda = "dia = "+string(dia)+" and calidad = '"+calidad+"'"
	donde    = data.find(busqueda,1,data.rowcount())
	if donde = 0 then
		donde = data.insertrow(0)
		data.object.empresa[donde] = codigo_empresa
		data.object.dia[donde]     = dia
		data.object.unidad[donde]  = unidad_conversion
		data.object.calidad[donde] = calidad
		data.object.moneda[donde]  = "1"
		for indice2 = 1 to 4
			if serie = string(indice2) then
				data.setitem(donde,"cantidad"+string(indice2)+"_facturas",total_cantidad)
				data.setitem(donde,"importe"+string(indice2)+"_facturas",total_neto)
			else
				data.setitem(donde,"cantidad"+string(indice2)+"_facturas",0)
				data.setitem(donde,"importe"+string(indice2)+"_facturas",0)				
			end if
		next
	else
		for indice2 = 1 to 4
			if serie = string(indice2) then
				total_cantidad = total_cantidad + data.getitemnumber(donde,"cantidad"+string(indice2)+"_facturas")
				total_neto     = total_neto     + data.getitemnumber(donde,"importe"+string(indice2)+"_facturas")
				data.setitem(donde,"cantidad"+string(indice2)+"_facturas",total_cantidad)
				data.setitem(donde,"importe"+string(indice2)+"_facturas",total_neto)
			end if
		next		
	end if
next

data.sort()
data.SetRedraw(TRUE)

destroy cargas

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;integer cont

istr_parametros.s_titulo_ventana="Resumen cargas entre fechas"
This.title=istr_parametros.s_titulo_ventana
em_anyo.text           = String(year(Today()))
uo_mes1.em_codigo.text = String(month(Today()))
uo_mes1.em_campo.text  = f_nombre_mes(Dec(uo_mes1.em_codigo.text))
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

uo_familia.f_cargar_datos("dw_ayuda_familias","","","Familia","Descripción")
uo_formato.f_cargar_datos("dw_ayuda_formatos","","","Formato","Descripción")

for cont=1 to uo_familia.dw_marca.rowcount()
	uo_familia.dw_marca.object.marca[cont]='S'
next

for cont=1 to uo_formato.dw_marca.rowcount()
	uo_formato.dw_marca.object.marca[cont]='S'
next
end event

on w_compara_alb_fras_mes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
this.gb_6=create gb_6
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_5=create gb_5
this.gb_1=create gb_1
this.dw_listado=create dw_listado
this.uo_mes1=create uo_mes1
this.em_anyo=create em_anyo
this.unidad_a_convertir=create unidad_a_convertir
this.gb_2=create gb_2
this.uo_familia=create uo_familia
this.cb_4=create cb_4
this.dw_detalle=create dw_detalle
this.cb_7=create cb_7
this.uo_formato=create uo_formato
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_5
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.dw_listado
this.Control[iCurrent+11]=this.uo_mes1
this.Control[iCurrent+12]=this.em_anyo
this.Control[iCurrent+13]=this.unidad_a_convertir
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.uo_familia
this.Control[iCurrent+16]=this.cb_4
this.Control[iCurrent+17]=this.dw_detalle
this.Control[iCurrent+18]=this.cb_7
this.Control[iCurrent+19]=this.uo_formato
end on

on w_compara_alb_fras_mes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.uo_manejo)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.dw_listado)
destroy(this.uo_mes1)
destroy(this.em_anyo)
destroy(this.unidad_a_convertir)
destroy(this.gb_2)
destroy(this.uo_familia)
destroy(this.cb_4)
destroy(this.dw_detalle)
destroy(this.cb_7)
destroy(this.uo_formato)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_compara_alb_fras_mes
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_compara_alb_fras_mes
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_compara_alb_fras_mes
integer x = 18
integer y = 4
integer width = 2432
integer height = 104
end type

type pb_1 from upb_salir within w_compara_alb_fras_mes
integer x = 2720
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_compara_alb_fras_mes
integer x = 2706
integer y = 204
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type uo_manejo from u_manejo_datawindow within w_compara_alb_fras_mes
integer x = 2235
integer y = 156
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from commandbutton within w_compara_alb_fras_mes
integer x = 1874
integer y = 152
integer width = 347
integer height = 108
integer taborder = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;f_control(dw_detalle)


end event

type gb_6 from groupbox within w_compara_alb_fras_mes
integer x = 1550
integer y = 128
integer width = 293
integer height = 144
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_compara_alb_fras_mes
integer x = 1271
integer y = 128
integer width = 293
integer height = 144
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_compara_alb_fras_mes
integer x = 645
integer y = 128
integer width = 635
integer height = 144
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar cantidades en"
end type

type gb_5 from groupbox within w_compara_alb_fras_mes
integer x = 1856
integer y = 108
integer width = 384
integer height = 164
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_compara_alb_fras_mes
integer x = 293
integer y = 128
integer width = 352
integer height = 144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mes"
end type

type dw_listado from datawindow within w_compara_alb_fras_mes
integer x = 2569
integer y = 32
integer width = 46
integer height = 36
string dataobject = "report_compara_alb_fras_mes"
boolean livescroll = true
end type

type uo_mes1 from u_em_campo_2 within w_compara_alb_fras_mes
event destroy ( )
integer x = 311
integer y = 172
integer width = 315
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_mes1.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_mes1.em_campo.text=f_nombre_mes(Dec(uo_mes1.em_codigo.text))
IF Trim(uo_mes1.em_campo.text)="" THEN 
 IF Trim(uo_mes1.em_codigo.text)<>"" Then uo_mes1.em_campo.SetFocus()
 uo_mes1.em_campo.text=""
 uo_mes1.em_codigo.text=""
END IF

end event

type em_anyo from u_em_campo within w_compara_alb_fras_mes
integer x = 37
integer y = 172
integer width = 233
integer taborder = 50
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#,###"
string displaydata = ""
end type

type unidad_a_convertir from dropdownlistbox within w_compara_alb_fras_mes
integer x = 663
integer y = 176
integer width = 594
integer height = 228
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Metros Cuadrados"
boolean vscrollbar = true
string item[] = {"Unidades","Metros Cuadrados"}
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_compara_alb_fras_mes
integer x = 18
integer y = 128
integer width = 274
integer height = 144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año"
end type

type uo_familia from u_marca_lista within w_compara_alb_fras_mes
event destroy ( )
boolean visible = false
integer x = 1248
integer y = 300
integer taborder = 90
boolean border = false
end type

on uo_familia.destroy
call u_marca_lista::destroy
end on

type cb_4 from commandbutton within w_compara_alb_fras_mes
integer x = 1285
integer y = 168
integer width = 265
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familia"
end type

event clicked;if uo_familia.visible = True then
   uo_familia.visible = False
else
	uo_familia.visible = True
End if

uo_formato.visible=false
end event

type dw_detalle from datawindow within w_compara_alb_fras_mes
integer x = 9
integer y = 296
integer width = 2871
integer height = 964
string dataobject = "dw_compara_alb_fras_mes"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_7 from commandbutton within w_compara_alb_fras_mes
integer x = 1563
integer y = 168
integer width = 265
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formato"
end type

event clicked;if uo_formato.visible = True then
   uo_formato.visible = False
else
	uo_formato.visible = True
End if

uo_familia.visible=false
end event

type uo_formato from u_marca_lista within w_compara_alb_fras_mes
event destroy ( )
boolean visible = false
integer x = 1486
integer y = 300
integer taborder = 100
boolean border = false
end type

on uo_formato.destroy
call u_marca_lista::destroy
end on

