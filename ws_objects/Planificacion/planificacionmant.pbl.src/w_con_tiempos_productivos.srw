$PBExportHeader$w_con_tiempos_productivos.srw
forward
global type w_con_tiempos_productivos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_tiempos_productivos
end type
type pb_2 from upb_imprimir within w_con_tiempos_productivos
end type
type cb_1 from commandbutton within w_con_tiempos_productivos
end type
type gb_1 from groupbox within w_con_tiempos_productivos
end type
type gb_6 from groupbox within w_con_tiempos_productivos
end type
type dw_informe from datawindow within w_con_tiempos_productivos
end type
type em_fdesde from u_em_campo within w_con_tiempos_productivos
end type
type em_fhasta from u_em_campo within w_con_tiempos_productivos
end type
type st_1 from statictext within w_con_tiempos_productivos
end type
type sle_semanas from singlelineedit within w_con_tiempos_productivos
end type
type cb_2 from commandbutton within w_con_tiempos_productivos
end type
type gb_2 from groupbox within w_con_tiempos_productivos
end type
type gb_3 from groupbox within w_con_tiempos_productivos
end type
type dw_informe2 from datawindow within w_con_tiempos_productivos
end type
end forward

global type w_con_tiempos_productivos from w_int_con_empresa
integer width = 3753
integer height = 3552
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
st_1 st_1
sle_semanas sle_semanas
cb_2 cb_2
gb_2 gb_2
gb_3 gb_3
dw_informe2 dw_informe2
end type
global w_con_tiempos_productivos w_con_tiempos_productivos

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);datastore lineas
string sel, v_calendario
long i, fila_actual
decimal horas_cal
datetime v_fdesde, v_fhasta

//data.object.periodo.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text
data.object.titulo.text = "Tiempos de producción desde "+em_fdesde.text+" a "+em_fhasta.text

dw_informe.reset()
sel = " select prodsecciones.descripcion_abr, prodsecciones.calendario, prodpartes_ot.linea, "+& 
		" prodlineas.resumido, prodlineas.calendario, sum(prodpartes_ot.segundos / 3600) as HORAS_PROD "+&
		" from prodpartes_ot, prodlineas, prodsecciones "+&
		" where prodpartes_ot.empresa = '"+codigo_empresa+"' "+&
		" and prodpartes_ot.fecha >= '"+em_fdesde.text+"' "+&
		" and prodpartes_ot.fecha <= '"+em_fhasta.text+"' "+&
		" and prodpartes_ot.linea = prodlineas.codigo  "+&
		" and prodpartes_ot.seccion = prodsecciones.codigo  "+&
		" group by prodsecciones.descripcion_abr, prodsecciones.calendario, prodpartes_ot.linea, prodlineas.resumido, prodlineas.calendario "+&
		" order by prodsecciones.descripcion_abr, prodlineas.resumido "

// Estas dos líneas las he quitado de la consulta para que contemple fines de semana
//		" and datename(dw, prodpartes_ot.fecha) <> 'Domingo' "+&	
//		" and datename(dw, prodpartes_ot.fecha) <> 'Sábado' "+&	


f_cargar_cursor_nuevo(sel, lineas)

dw_informe.SetRedraw(false)

for i= 1 to lineas.RowCount()
	fila_actual = dw_informe.InsertRow(0)

	dw_informe.object.seccion[fila_actual] = lineas.object.prodsecciones_descripcion_abr[i]
	dw_informe.object.linea[fila_actual] = lineas.object.prodlineas_resumido[i]
	dw_informe.object.tiempo_produccion[fila_actual] = lineas.object.horas_prod[i]
	
	if lineas.object.prodlineas_calendario[i] <> '' and not isnull(lineas.object.prodlineas_calendario[i]) then
		v_calendario = lineas.object.prodlineas_calendario[i]
	else
		if lineas.object.prodsecciones_calendario[i] <> '' and not isnull(lineas.object.prodsecciones_calendario[i]) then
			v_calendario = lineas.object.prodsecciones_calendario[i]
		end if 
	end if
	
	horas_cal = 0
	v_fdesde = datetime(date(em_fdesde.text))
	v_fhasta = datetime(date(em_fhasta.text))
	
	select sum(horas)
	into :horas_cal
	from prodmeses
	where calendario = :v_calendario
	and convert(datetime, convert(char,dia)+'/'+convert(char, mes)+'/'+convert(char,anyo)) >= :v_fdesde
	and convert(datetime, convert(char,dia)+'/'+convert(char, mes)+'/'+convert(char,anyo)) <= :v_fhasta;
	
// Estas dos líneas las he quitado de la consulta para que contemple fines de semana
//	and datename(dw,convert(datetime, convert(char,dia)+'/'+convert(char, mes)+'/'+convert(char,anyo))) <> 'Domingo'
//	and datename(dw,convert(datetime, convert(char,dia)+'/'+convert(char, mes)+'/'+convert(char,anyo))) <> 'Sábado';

	dw_informe.object.tiempo_calendario[fila_actual] = horas_cal

	dw_informe.Sort()
	dw_informe.groupcalc()
	
	f_mensaje_proceso ("Calculando ..... ", i, lineas.RowCount())

next

dw_informe.SetRedraw(True)

destroy lineas


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Consulta Tiempos de Producción"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = String(RelativeDate(today(), -31), "dd-mm-yy")
em_fhasta.text = String(RelativeDate(today(), -1), "dd-mm-yy")


end event

on w_con_tiempos_productivos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.st_1=create st_1
this.sle_semanas=create sle_semanas
this.cb_2=create cb_2
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_informe2=create dw_informe2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.sle_semanas
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.dw_informe2
end on

on w_con_tiempos_productivos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.st_1)
destroy(this.sle_semanas)
destroy(this.cb_2)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_informe2)
end on

event ue_f5;f_control(dw_informe)
end event

event activate;call super::activate;w_con_tiempos_productivos = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_tiempos_productivos
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_tiempos_productivos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_tiempos_productivos
integer x = 41
integer width = 3611
integer height = 112
end type

type pb_1 from upb_salir within w_con_tiempos_productivos
integer x = 3506
integer y = 156
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_tiempos_productivos
integer x = 3378
integer y = 156
integer taborder = 0
end type

event clicked;f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_tiempos_productivos
integer x = 3081
integer y = 156
integer width = 288
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_con_tiempos_productivos
integer x = 50
integer y = 116
integer width = 763
integer height = 156
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type gb_6 from groupbox within w_con_tiempos_productivos
integer x = 3063
integer y = 116
integer width = 585
integer height = 156
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe from datawindow within w_con_tiempos_productivos
integer x = 9
integer y = 284
integer width = 3657
integer height = 2964
boolean bringtotop = true
string dataobject = "dw_con_tiempos_productivos"
boolean vscrollbar = true
boolean livescroll = true
end type

type em_fdesde from u_em_campo within w_con_tiempos_productivos
integer x = 69
integer y = 172
integer width = 357
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_tiempos_productivos
integer x = 434
integer y = 172
integer width = 357
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type st_1 from statictext within w_con_tiempos_productivos
integer x = 855
integer y = 180
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Semanas:"
boolean focusrectangle = false
end type

type sle_semanas from singlelineedit within w_con_tiempos_productivos
integer x = 1179
integer y = 172
integer width = 201
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event losefocus;if long(sle_semanas.text) = 1 then
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")
else
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), ( -7 * ( long( sle_semanas.text ) -1 ) ) - 6 ),"dd-mm-yy")
end if

end event

type cb_2 from commandbutton within w_con_tiempos_productivos
boolean visible = false
integer x = 1975
integer y = 160
integer width = 1056
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tiempo Teórico de Utilización del Horno "
end type

event clicked;datastore regs
string sel, orientacion, linea, linea_ant, cod_seccion, cod_linea, cod_seccion_ant, cod_linea_ant
long i, fila_actual
datetime v_fdesde, v_fhasta
dec horas, total_piezas, largo, piezas_fila, ciclo, longitud_horno, minutos, minutos_tot

dw_informe2.reset()

sel = " select prodlineas.resumido, prodlineas.codigo, prodlineas.seccion, prodpartes_ot.articulo, prodpartes_ot.version, prodpartes_ot.ordenoperacion, art_ver_operaciones.piezas_fila, "+&
		" art_ver_operaciones.orientacion, art_ver_op_aplicaciones.ciclo,  formatos.largo, formatos.ancho,  "+&
		" (prodpartes_ot.buenas + prodpartes_ot.malas ) as total_piezas "+&
		" from prodpartes_ot, art_ver_operaciones, art_ver_op_aplicaciones, formatos, prodlineas "+&
		" where prodpartes_ot.empresa = '"+codigo_empresa+"' "+&
		" and prodpartes_ot.fecha >= '"+em_fdesde.text+"' "+&
		" and prodpartes_ot.fecha <= '"+em_fhasta.text+"' "+&
		" and datename(dw, prodpartes_ot.fecha) <> 'Domingo' "+&
		" and datename(dw, prodpartes_ot.fecha) <> 'Sábado'  "+&	
		" and prodpartes_ot.empresa = art_ver_operaciones.empresa "+& 
		" and prodpartes_ot.articulo = art_ver_operaciones.articulo  "+&
		" and prodpartes_ot.version = art_ver_operaciones.version  "+&
		" and prodpartes_ot.ordenoperacion = art_ver_operaciones.orden "+& 
		" and prodpartes_ot.seccion = '3' "+&
		" and art_ver_operaciones.empresa = art_ver_op_aplicaciones.empresa "+&
		" and art_ver_operaciones.version = art_ver_op_aplicaciones.version "+&
		" and art_ver_operaciones.articulo = art_ver_op_aplicaciones.articulo "+&
		" and art_ver_operaciones.operacion = art_ver_op_aplicaciones.operacion "+&
		" and prodpartes_ot.empresa = formatos.empresa "+&
		" and prodpartes_ot.formato = formatos.codigo "+&
		" and prodpartes_ot.empresa = prodlineas.empresa "+&
		" and prodpartes_ot.linea = prodlineas.codigo "+&
		" order by prodlineas.resumido "
	
f_cargar_cursor_nuevo(sel, regs)

if regs.rowcount() > 0 then

	v_fdesde = datetime(date(em_fdesde.text))
	v_fhasta = datetime(date(em_fhasta.text))
	
	horas = 0
	longitud_horno = 29.4
	minutos_tot = 0
	linea_ant = regs.object.prodlineas_resumido[1]
	cod_linea_ant = regs.object.prodlineas_codigo[1]
	cod_seccion_ant = regs.object.prodlineas_seccion[1]

	for i= 1 to regs.RowCount()
		cod_linea = regs.object.prodlineas_codigo[i]
		cod_seccion = regs.object.prodlineas_seccion[i]
		if isnull (regs.object.total_piezas[i] ) then
			total_piezas = 0
		else
			total_piezas = regs.object.total_piezas[i]
		end if
		orientacion = regs.object.art_ver_operaciones_orientacion[i]
		if isnull (regs.object.art_ver_operaciones_piezas_fila[i]) then
			piezas_fila = 0
		else
			piezas_fila = regs.object.art_ver_operaciones_piezas_fila[i]
		end if
		
		if isnull (regs.object.art_ver_op_aplicaciones_ciclo[i]) then
			ciclo = 0
		else
			ciclo = dec(regs.object.art_ver_op_aplicaciones_ciclo[i])
		end if
	
		if orientacion = 'A' then
			largo = regs.object.formatos_ancho[i]
		else
			largo = regs.object.formatos_largo[i]
		end if
		if piezas_fila <> 0 then
			minutos = ( total_piezas * (largo / 100 ) * ciclo) / ( longitud_horno * piezas_fila )
		end if
		
		linea = regs.object.prodlineas_resumido[i]
	
		if linea = linea_ant and i <> regs.rowcount() then
			minutos_tot = minutos_tot + minutos
		else
			fila_actual = dw_informe2.insertrow(0)
			dw_informe2.object.linea[fila_actual] = linea_ant
			dw_informe2.object.tiempo_produccion[fila_actual] = minutos_tot / 60
			dw_informe2.object.tiempo_linea_cal[fila_actual] = f_horas_calendario (codigo_empresa, cod_seccion_ant, cod_linea_ant, v_fdesde, v_fhasta)
			minutos_tot = minutos
		end if
		
		linea_ant = linea
		cod_linea_ant = cod_linea
		cod_seccion_ant = cod_seccion
		
	
		f_mensaje_proceso ("Calculando ..... ", i, regs.RowCount())
	next
	
	
	
	dw_informe2.Sort()
	dw_informe2.groupcalc()	
else
	messagebox("Aviso", "No hay datos")
end if
destroy regs


end event

type gb_2 from groupbox within w_con_tiempos_productivos
boolean visible = false
integer x = 1947
integer y = 116
integer width = 1106
integer height = 156
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_con_tiempos_productivos
integer x = 818
integer y = 116
integer width = 599
integer height = 156
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe2 from datawindow within w_con_tiempos_productivos
boolean visible = false
integer x = 9
integer y = 2612
integer width = 3657
integer height = 748
integer taborder = 40
string dataobject = "dw_con_tiempos_productivos2"
boolean vscrollbar = true
boolean livescroll = true
end type

