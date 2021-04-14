$PBExportHeader$w_con_pedidos_interanuales.srw
forward
global type w_con_pedidos_interanuales from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_interanuales
end type
type pb_2 from upb_imprimir within w_con_pedidos_interanuales
end type
type dw_listado from datawindow within w_con_pedidos_interanuales
end type
type em_fechadesde from u_em_campo within w_con_pedidos_interanuales
end type
type em_fechahasta from u_em_campo within w_con_pedidos_interanuales
end type
type cb_1 from commandbutton within w_con_pedidos_interanuales
end type
type gb_1 from groupbox within w_con_pedidos_interanuales
end type
type st_1 from statictext within w_con_pedidos_interanuales
end type
type uo_series from u_marca_lista within w_con_pedidos_interanuales
end type
type gb_6 from groupbox within w_con_pedidos_interanuales
end type
type dw_listado_resumen from datawindow within w_con_pedidos_interanuales
end type
type dw_listado_resumen_pm from datawindow within w_con_pedidos_interanuales
end type
type cb_2 from commandbutton within w_con_pedidos_interanuales
end type
type cb_anyo_desde from singlelineedit within w_con_pedidos_interanuales
end type
type cb_anyo_hasta from singlelineedit within w_con_pedidos_interanuales
end type
type st_2 from statictext within w_con_pedidos_interanuales
end type
type st_3 from statictext within w_con_pedidos_interanuales
end type
type gb_2 from groupbox within w_con_pedidos_interanuales
end type
type gb_3 from groupbox within w_con_pedidos_interanuales
end type
type cb_3 from commandbutton within w_con_pedidos_interanuales
end type
type cb_4 from commandbutton within w_con_pedidos_interanuales
end type
type cb_5 from commandbutton within w_con_pedidos_interanuales
end type
type dw_grafico_pedidos_interanual from datawindow within w_con_pedidos_interanuales
end type
type dw_detalle from datawindow within w_con_pedidos_interanuales
end type
type dw_grafico_pedidos_interanual2 from datawindow within w_con_pedidos_interanuales
end type
end forward

global type w_con_pedidos_interanuales from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 5733
integer height = 3716
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_1 gb_1
st_1 st_1
uo_series uo_series
gb_6 gb_6
dw_listado_resumen dw_listado_resumen
dw_listado_resumen_pm dw_listado_resumen_pm
cb_2 cb_2
cb_anyo_desde cb_anyo_desde
cb_anyo_hasta cb_anyo_hasta
st_2 st_2
st_3 st_3
gb_2 gb_2
gb_3 gb_3
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
dw_grafico_pedidos_interanual dw_grafico_pedidos_interanual
dw_detalle dw_detalle
dw_grafico_pedidos_interanual2 dw_grafico_pedidos_interanual2
end type
global w_con_pedidos_interanuales w_con_pedidos_interanuales

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);
string cliente, v_empresa, sel, familia
date fecha1, fecha2
datetime fecha
integer dia1, mes1, anyo1, dia2, mes2, anyo2, v_anyo, v_pedido, v_linea
decimal importe, importe2, variacion, fila_actual
decimal v_piezas, v_metros, v_metros_lin
decimal v_piezas2, v_metros2, v_metros_lin2
datastore datos
long j, k, m

dw_detalle.visible = true
dw_grafico_pedidos_interanual.visible = false


if messagebox("Aviso","¿Desea volver a generar los datos?", Exclamation!, YesNo!, 2) = 1 then
	cliente = '%'
	
	//dw_detalle.Setredraw(false)
	dw_detalle.reset()
	
	anyo1 = integer(cb_anyo_desde.text)
	anyo2 = integer(cb_anyo_hasta.text)
	
	
	delete from tmp_pedidosinteranual 
	where year(fecha) >= :anyo1 
	and year(fecha) >= :anyo2 
	using SQLCA;
	
	commit using SQLCA;
	
	for j = anyo1 to anyo2
		for k = 1 to 12 
			for m = 1 to 3  //Familias
				familia = string(m)
			
				importe = 0
				importe2 = 0
	//			f_piezas_metros_metrosl_importe_cliente (v_piezas, v_metros, importe, v_metros_lin, date(j - 2,k,1), date(j - 1,k,1), cliente)
	//			f_piezas_metros_metrosl_importe_cliente (v_piezas2, v_metros2, importe2, v_metros_lin2, date(j - 1,k,1), date(j,k,1),  cliente)
	
				f_piezas_metros_metrosl_importe_familia (v_piezas, v_metros, importe, v_metros_lin, date(j - 2,k,1), date(j - 1,k,1), cliente, familia)
				f_piezas_metros_metrosl_importe_familia (v_piezas2, v_metros2, importe2, v_metros_lin2, date(j - 1,k,1), date(j,k,1),  cliente, familia)
				
				if isnull(v_piezas) then v_piezas = 0
				if isnull(v_metros) then v_metros = 0
				if isnull(importe) then importe = 0
				if isnull(v_piezas2) then v_piezas2 = 0
				if isnull(v_metros2) then v_metros2 = 0
				if isnull(importe2) then importe2 = 0
				
				fila_actual = dw_detalle.insertrow(0)
				
				fecha =  Datetime(Date( j, k, 1))
				dw_detalle.object.fecha[fila_actual] = fecha
				dw_detalle.object.importe[fila_actual] = importe
				dw_detalle.object.importe2[fila_actual] = importe2
				dw_detalle.object.familia[fila_actual] = familia
				if importe > 0 and importe2 > 0 then
					variacion = ( ( importe2 - importe ) / importe ) * 100
				else
					variacion = 0
				end if
				insert into tmp_pedidosinteranual (fecha, importe, importe2, variacion, familia) values (:fecha, :importe, :importe2, :variacion, :familia) 	using SQLCA;			
				
				dw_detalle.object.variacion[fila_actual] = variacion
	
				dw_detalle.ScrollToRow(fila_Actual)
				dw_detalle.SetRow(fila_actual)
				dw_detalle.SelectRow(fila_actual, TRUE)
				dw_detalle.SelectRow(fila_actual - 1, FALSE)
			next
		next
	next
	
	commit using SQLCA;
		
	importe = 0
	importe2 = 0
		
	dw_detalle.setsort("")
	dw_detalle.sort()
	//dw_detalle.Setredraw(True)
else
	sel = " Select fecha, importe, importe2, variacion "+&
			" from tmp_pedidosinteranual "	+&
			" order by fecha , familia "	
			
	f_cargar_cursor_nuevo (sel, datos)
	
	
	for j = 1 to datos.rowcount()
		fila_actual = dw_detalle.insertrow(0)
		
		dw_detalle.object.fecha[fila_actual] = datos.object.fecha[j]
		dw_detalle.object.importe[fila_actual] = datos.object.importe[j]
		dw_detalle.object.importe2[fila_actual] = datos.object.importe2[j]
		dw_detalle.object.variacion[fila_actual] = datos.object.variacion[j]
		
		dw_detalle.ScrollToRow(fila_Actual)
		dw_detalle.SetRow(fila_actual)
		dw_detalle.SelectRow(fila_actual, TRUE)
		dw_detalle.SelectRow(fila_actual - 1, FALSE)
		

	next
	
	destroy datos
end if
/*

string cliente, v_empresa, sel
date fecha1, fecha2
datetime fecha
integer dia1, mes1, anyo1, dia2, mes2, anyo2, v_anyo, v_pedido, v_linea
decimal importe, importe2, variacion, fila_actual
decimal v_piezas, v_metros, v_metros_lin
decimal v_piezas2, v_metros2, v_metros_lin2, j, k
datastore datos


dw_detalle.visible = true
dw_grafico_pedidos_interanual.visible = false


if messagebox("Aviso","¿Desea volver a generar los datos?", Exclamation!, YesNo!, 2) = 1 then

	//fecha1 = date(em_fechadesde.text)
	//fecha2 = date(em_fechahasta.text)
	//
	//dia1 = day(fecha1)
	//mes1 = month(fecha1)
	//anyo1 = year(fecha1) 
	//
	//dia2 = day(fecha2)
	//mes2 = month(fecha2) 
	//anyo2 = year(fecha2) 
	
	cliente = '%'
	
	//dw_detalle.Setredraw(false)
	dw_detalle.reset()
	
	anyo1 = integer(cb_anyo_desde.text)
	anyo2 = integer(cb_anyo_hasta.text)
	
	
	delete from tmp_pedidosinteranual 
	where year(fecha) >= :anyo1 
	and year(fecha) >= :anyo2 
	using SQLCA;
	
	commit using SQLCA;

	string familia = '1'	
	
	for j = anyo1 to anyo2
		for k = 1 to 12 

			familia = string (integer (familia) +1 )

			importe = 0
			importe2 = 0
			f_piezas_metros_metrosl_importe_cliente (v_piezas, v_metros, importe, v_metros_lin, date(j - 2,k,1), date(j - 1,k,1), cliente)
			f_piezas_metros_metrosl_importe_cliente (v_piezas2, v_metros2, importe2, v_metros_lin2, date(j - 1,k,1), date(j,k,1),  cliente)

			
			if isnull(v_piezas) then v_piezas = 0
			if isnull(v_metros) then v_metros = 0
			if isnull(importe) then importe = 0
			if isnull(v_piezas2) then v_piezas = 0
			if isnull(v_metros2) then v_metros = 0
			if isnull(importe2) then importe2 = 0
			
			fila_actual = dw_detalle.insertrow(0)
			
			fecha =  Datetime(Date( j, k, 1))
			dw_detalle.object.fecha[fila_actual] = fecha
			dw_detalle.object.importe[fila_actual] = importe
			dw_detalle.object.importe2[fila_actual] = importe2
			if importe > 0 and importe2 > 0 then
				variacion = ( ( importe2 - importe ) / importe ) * 100

				insert into tmp_pedidosinteranual (fecha, importe, importe2, variacion, familia) values (:fecha, :importe, :importe2, :variacion, :familia) 	using SQLCA;			
			else 
				variacion = 0
			end if
			
			dw_detalle.object.variacion[fila_actual] = variacion

			dw_detalle.ScrollToRow(fila_Actual)
			dw_detalle.SetRow(fila_actual)
			dw_detalle.SelectRow(fila_actual, TRUE)
			dw_detalle.SelectRow(fila_actual - 1, FALSE)
			
		next
	next
	
	commit using SQLCA;
		
	importe = 0
	importe2 = 0
		
	dw_detalle.setsort("")
	dw_detalle.sort()
	//dw_detalle.Setredraw(True)
else
	sel = " Select fecha, importe, importe2, variacion "+&
			" from tmp_pedidosinteranual "	+&
			" order by fecha "	
			
	f_cargar_cursor_nuevo (sel, datos)
	
	
	for j = 1 to datos.rowcount()
		fila_actual = dw_detalle.insertrow(0)
		
		dw_detalle.object.fecha[fila_actual] = datos.object.fecha[j]
		dw_detalle.object.importe[fila_actual] = datos.object.importe[j]
		dw_detalle.object.importe2[fila_actual] = datos.object.importe2[j]
		dw_detalle.object.variacion[fila_actual] = datos.object.variacion[j]
		
		dw_detalle.ScrollToRow(fila_Actual)
		dw_detalle.SetRow(fila_actual)
		dw_detalle.SelectRow(fila_actual, TRUE)
		dw_detalle.SelectRow(fila_actual - 1, FALSE)
		

	next
	
	destroy datos
end if
*/
end subroutine

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
dw_listado_resumen.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Pedidos Interanual"
This.title=istr_parametros.s_titulo_ventana
//em_fechadesde.text = String(MDY(01,01,Year(Today())))

em_fechadesde.text = String(MDY(06,01,2003))
em_fechahasta.text = String(Today())
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
//dw_detalle.DataObject = "dw_con_ped_alb_fac_cliente_fechas_tencer"
dw_grafico_pedidos_interanual.SetTransObject(SQLCA)
dw_grafico_pedidos_interanual2.SetTransObject(SQLCA)


cb_anyo_hasta.text = string(year(today()))
cb_anyo_desde.text = string(year(today()))
end event

on w_con_pedidos_interanuales.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_1=create gb_1
this.st_1=create st_1
this.uo_series=create uo_series
this.gb_6=create gb_6
this.dw_listado_resumen=create dw_listado_resumen
this.dw_listado_resumen_pm=create dw_listado_resumen_pm
this.cb_2=create cb_2
this.cb_anyo_desde=create cb_anyo_desde
this.cb_anyo_hasta=create cb_anyo_hasta
this.st_2=create st_2
this.st_3=create st_3
this.gb_2=create gb_2
this.gb_3=create gb_3
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.dw_grafico_pedidos_interanual=create dw_grafico_pedidos_interanual
this.dw_detalle=create dw_detalle
this.dw_grafico_pedidos_interanual2=create dw_grafico_pedidos_interanual2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.uo_series
this.Control[iCurrent+10]=this.gb_6
this.Control[iCurrent+11]=this.dw_listado_resumen
this.Control[iCurrent+12]=this.dw_listado_resumen_pm
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.cb_anyo_desde
this.Control[iCurrent+15]=this.cb_anyo_hasta
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.cb_3
this.Control[iCurrent+21]=this.cb_4
this.Control[iCurrent+22]=this.cb_5
this.Control[iCurrent+23]=this.dw_grafico_pedidos_interanual
this.Control[iCurrent+24]=this.dw_detalle
this.Control[iCurrent+25]=this.dw_grafico_pedidos_interanual2
end on

on w_con_pedidos_interanuales.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.uo_series)
destroy(this.gb_6)
destroy(this.dw_listado_resumen)
destroy(this.dw_listado_resumen_pm)
destroy(this.cb_2)
destroy(this.cb_anyo_desde)
destroy(this.cb_anyo_hasta)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.dw_grafico_pedidos_interanual)
destroy(this.dw_detalle)
destroy(this.dw_grafico_pedidos_interanual2)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_interanuales
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_interanuales
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_interanuales
integer y = 8
integer width = 5641
integer height = 80
end type

type pb_1 from upb_salir within w_con_pedidos_interanuales
integer x = 5490
integer y = 144
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_pedidos_interanuales
integer x = 5312
integer y = 144
integer taborder = 0
boolean originalsize = false
end type

event clicked;//if rb_pm.checked then
//	f_control_pm(dw_detalle)
//else
//	f_control(dw_detalle)
//end if
f_imprimir_datawindow(dw_detalle)

end event

type dw_listado from datawindow within w_con_pedidos_interanuales
boolean visible = false
integer x = 2523
integer y = 12
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_fechadesde from u_em_campo within w_con_pedidos_interanuales
integer x = 41
integer y = 148
integer width = 325
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fechahasta from u_em_campo within w_con_pedidos_interanuales
integer x = 411
integer y = 148
integer width = 325
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type cb_1 from commandbutton within w_con_pedidos_interanuales
integer x = 4855
integer y = 144
integer width = 430
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Datos"
end type

event clicked;	f_control(dw_detalle)


end event

type gb_1 from groupbox within w_con_pedidos_interanuales
integer x = 9
integer y = 96
integer width = 754
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Perido a Analizar"
end type

type st_1 from statictext within w_con_pedidos_interanuales
integer x = 366
integer y = 144
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_series from u_marca_lista within w_con_pedidos_interanuales
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type gb_6 from groupbox within w_con_pedidos_interanuales
integer x = 4837
integer y = 104
integer width = 631
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_listado_resumen from datawindow within w_con_pedidos_interanuales
boolean visible = false
integer x = 2711
integer y = 12
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3_r"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado_resumen_pm from datawindow within w_con_pedidos_interanuales
boolean visible = false
integer x = 2898
integer y = 12
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3pm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_con_pedidos_interanuales
integer x = 805
integer y = 144
integer width = 379
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Decoración"
end type

event clicked;string familia[]

em_fechadesde.text = String(MDY(01,01,2004))

dw_detalle.visible = false
dw_grafico_pedidos_interanual.visible = true

dw_grafico_pedidos_interanual.object.t_titulo.text = "Decoración"

familia[1] = '1' // Decoracion
dw_grafico_pedidos_interanual.retrieve(datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)), familia)



end event

type cb_anyo_desde from singlelineedit within w_con_pedidos_interanuales
integer x = 4201
integer y = 152
integer width = 174
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2001"
borderstyle borderstyle = stylelowered!
end type

type cb_anyo_hasta from singlelineedit within w_con_pedidos_interanuales
integer x = 4635
integer y = 152
integer width = 178
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_con_pedidos_interanuales
integer x = 3835
integer y = 164
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Desde el Año"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_pedidos_interanuales
integer x = 4379
integer y = 164
integer width = 251
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "hasta el"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_con_pedidos_interanuales
integer x = 786
integer y = 100
integer width = 1824
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_con_pedidos_interanuales
integer x = 5477
integer y = 104
integer width = 146
integer height = 148
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_3 from commandbutton within w_con_pedidos_interanuales
integer x = 1225
integer y = 144
integer width = 379
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcas"
end type

event clicked;string familia[]

em_fechadesde.text = String(MDY(01,05,2016))

dw_detalle.visible = false
dw_grafico_pedidos_interanual.visible = true

dw_grafico_pedidos_interanual.object.t_titulo.text = "Marcas"

familia[1] = '2'
dw_grafico_pedidos_interanual.retrieve(datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)), familia)


end event

type cb_4 from commandbutton within w_con_pedidos_interanuales
integer x = 1655
integer y = 144
integer width = 398
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Custom Made"
end type

event clicked;string familia[]

em_fechadesde.text = String(MDY(01,05,2016))

dw_detalle.visible = false
dw_grafico_pedidos_interanual.visible = true

dw_grafico_pedidos_interanual.object.t_titulo.text = "Custom Made"

familia[1] = '3'
dw_grafico_pedidos_interanual.retrieve(datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)), familia)


end event

type cb_5 from commandbutton within w_con_pedidos_interanuales
integer x = 2130
integer y = 144
integer width = 398
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Todo"
end type

event clicked;
dw_detalle.visible = false
dw_grafico_pedidos_interanual.visible = false
dw_grafico_pedidos_interanual2.visible = true

dw_grafico_pedidos_interanual2.retrieve(datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)))


end event

type dw_grafico_pedidos_interanual from datawindow within w_con_pedidos_interanuales
integer x = 18
integer y = 276
integer width = 5632
integer height = 3216
integer taborder = 50
string title = "none"
string dataobject = "dw_grafico_pedidos_interanual"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_detalle from datawindow within w_con_pedidos_interanuales
integer x = 14
integer y = 276
integer width = 5595
integer height = 3224
string dataobject = "dw_pedidos_interanuales"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type dw_grafico_pedidos_interanual2 from datawindow within w_con_pedidos_interanuales
integer x = 14
integer y = 276
integer width = 5632
integer height = 3216
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_grafico_pedidos_interanual2"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

