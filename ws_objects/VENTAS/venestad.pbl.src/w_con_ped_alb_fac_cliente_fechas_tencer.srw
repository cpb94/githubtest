$PBExportHeader$w_con_ped_alb_fac_cliente_fechas_tencer.srw
forward
global type w_con_ped_alb_fac_cliente_fechas_tencer from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type dw_listado from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type gb_2 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type rb_detalle from radiobutton within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type rb_resumen from radiobutton within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type dw_listado_resumen from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type rb_pm from radiobutton within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type dw_listado_resumen_pm from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type dw_detalle2 from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type rb_resumen_g2 from radiobutton within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type uo_series from u_marca_lista within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type uo_familia from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type gb_5 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type gb_4 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type em_faltadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type st_2 from statictext within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type em_faltahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type dw_resumen from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type dw_resumen_g2 from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
end type
type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
end type
end forward

global type w_con_ped_alb_fac_cliente_fechas_tencer from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 4462
integer height = 2700
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
rb_detalle rb_detalle
rb_resumen rb_resumen
dw_listado_resumen dw_listado_resumen
rb_pm rb_pm
dw_listado_resumen_pm dw_listado_resumen_pm
dw_detalle2 dw_detalle2
rb_resumen_g2 rb_resumen_g2
uo_series uo_series
uo_familia uo_familia
gb_5 gb_5
gb_4 gb_4
em_faltadesde em_faltadesde
st_2 st_2
em_faltahasta em_faltahasta
dw_resumen dw_resumen
dw_resumen_g2 dw_resumen_g2
dw_detalle dw_detalle
end type
global w_con_ped_alb_fac_cliente_fechas_tencer w_con_ped_alb_fac_cliente_fechas_tencer

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_control_pm (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long      i,indice,total,donde,cantidad
Datetime fecha1, fecha2, fecha3, fecha4, fecha, falta1, falta2
dec{2}    bruto,cambio,precio,dto1,dto2,bruto1,bruto2,metros,pm, a, b, v_metros_lin, v_metros_lin_tot
String    series,cliente,sel,serie,divisa,moneda = "7",clientes,tarifa,calidad,articulo, familia
datastore datos
integer dia1, mes1, anyo1, dia2, mes2, anyo2
integer dia_alta1, mes_alta1, anyo_alta1, dia_alta2, mes_alta2, anyo_alta2


dw_detalle.Reset()
dw_detalle2.Reset()
dw_detalle.object.porcentaje_imp.text =  '0.0'+" %"
dw_detalle.object.porcentaje_metros.text =  '0'+" %"
dw_detalle.object.porcentaje_piezas.text =  '0'+" %"

fecha1 = datetime(date(em_fechadesde.text))
fecha2 = datetime(date(em_fechahasta.text))
fecha3 = datetime(date(em_fechadesde.text))
fecha4 = datetime(date(em_fechahasta.text))

falta1 = datetime(date(em_faltadesde.text))
falta2 = datetime(date(em_faltahasta.text))



if uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	cliente = "%"
else
	cliente = uo_cliente.em_codigo.text
end if

if uo_familia.em_codigo.text = '' or isnull (uo_familia.em_codigo.text) then
	familia = "%"
else
	familia = uo_familia.em_codigo.text
end if

if rb_detalle.checked then
	dw_resumen.visible = false
	dw_detalle.visible = true
	dw_detalle2.visible = true
	dw_detalle.SetTransObject(SQLCA)
	dw_detalle2.SetTransObject(SQLCA)
	dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series, familia)

	
	dia1 = day(date(fecha1))
	mes1 = month(date(fecha1))
	anyo1 = year(date(fecha1)) - 1
	dia2 = day(date(fecha2))
	mes2 = month(date(fecha2) )
	anyo2 = year(date(fecha2) )- 1
	
	fecha1 = Datetime(date ( anyo1, mes1, dia1))
	fecha2 = Datetime (date( anyo2, mes2, dia2))
	fecha3 = Datetime(date ( anyo1, mes1, dia1))
	fecha4 = Datetime (date( anyo2, mes2, dia2))
	
	dia_alta1 = day(date(falta1))
	mes_alta1 = month(date(falta1))
	anyo_alta1 = year(date(falta1)) - 1
	dia_alta2 = day(date(falta2))
	mes_alta2 = month(date(falta2) )
	anyo_alta2 = year(date(falta2)) - 1

	falta1 = datetime( date(dia_alta1, mes_alta1, anyo_alta1))
	falta2 = datetime(date(dia_alta2,  mes_alta2, anyo_alta2))
		
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	datastore ds_clientes
	long fila_Actual
	string sel1, v_empresa
	date   v_fpedido
	integer  v_anyo, v_pedido, v_linea
	decimal v_importe, v_piezas, v_metros, v_importe_tot = 0, v_piezas_tot = 0, v_metros_tot = 0
	
	if cliente = '' or isnull(cliente) then cliente = '%'
		
	v_importe_tot = 0
	v_piezas_tot = 0
	v_metros_tot = 0
	v_metros_lin_tot = 0
	
	if cliente = '%' then
		 f_piezas_metros_metrosl_importe_cliente (v_piezas, v_metros, v_importe, v_metros_lin, date(fecha1), date(fecha2), cliente)
		 
		 if isnull(v_piezas) then v_piezas = 0
		if isnull(v_metros) then v_metros = 0
		if isnull(v_importe) then v_importe = 0
		v_importe_tot = v_importe_tot + v_importe
		v_piezas_tot = v_piezas_tot + v_piezas
		v_metros_tot = v_metros_tot + v_metros
		v_metros_lin_tot = v_metros_lin_tot + v_metros_lin 
		 
	else
	
		sel1 = " select genter.codigo, genter.razon from genter inner join venclientes ON venclientes.empresa = genter.empresa AND venclientes.codigo = genter.codigo where genter.empresa =  "+codigo_empresa+"  and genter.tipoter = 'C' "+&
					" and genter.codigo like '"+cliente+"' AND venclientes.grupo LIKE '"+familia+"' "
		f_cargar_cursor_nuevo (sel1, ds_clientes)
		
		dw_detalle2.Setredraw(false)
		dw_detalle2.reset()
	
		
		for i = 1 to ds_clientes.rowcount()
			cliente = ds_clientes.object.genter_codigo[i]
			v_piezas = 0
			v_metros = 0
			v_importe = 0
	
			f_piezas_metros_metrosl_importe_cliente (v_piezas, v_metros, v_importe, v_metros_lin, date(fecha1), date(fecha2), cliente)
			if isnull(v_piezas) then v_piezas = 0
			if isnull(v_metros) then v_metros = 0
			if isnull(v_importe) then v_importe = 0
			v_importe_tot = v_importe_tot + v_importe
			v_piezas_tot = v_piezas_tot + v_piezas
			v_metros_tot = v_metros_tot + v_metros
			v_metros_lin_tot = v_metros_lin_tot + v_metros_lin
			f_mensaje_proceso ("Clientes:", i, ds_clientes.rowcount())
		next
	end if
	
	fila_actual = dw_detalle2.insertrow(0)
	dw_detalle2.object.piezas[fila_actual] = v_piezas_tot
	dw_detalle2.object.importe[fila_actual] = v_importe_tot
	dw_detalle2.object.metros[fila_actual] = v_metros_tot
	dw_detalle2.object.metrosl[fila_actual] = v_metros_lin_tot

	dw_detalle2.setsort("")
	dw_detalle2.setsort("importe D")
	dw_detalle2.sort()
	dw_detalle2.Setredraw(True)
	
	destroy ds_clientes

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	if dw_detalle.RowCount() > 0 and dw_detalle2.RowCount() > 0 then
		/////////////////////////////////////////////////////////////////////////////////////
		if isnull(dw_detalle.object.total_importe[dw_detalle.GetRow()]) then
			a = 0
		else
			a = dec(dw_detalle.object.total_importe[dw_detalle.GetRow()])
		end if
		if isnull(dw_detalle.object.total_importe[dw_detalle2.GetRow()]) then
			b = 0
		else
			b = dec(dw_detalle2.object.importe[dw_detalle2.GetRow()])
		end if
		if b = 0 then
			dw_detalle.object.porcentaje_imp.text =  '0.0'+" %"
		else
			dw_detalle.object.porcentaje_imp.text =  String(  round(((a - b) / b) * 100, 1))+" %"
		end if													
		/////////////////////////////////////////////////////////////////////////////////////
		
		if isnull(dw_detalle.object.total_metros[dw_detalle.GetRow()]) then
			a = 0
		else
			a = dec(dw_detalle.object.total_metros[dw_detalle.GetRow()])
		end if
		if isnull(dw_detalle.object.total_metros[dw_detalle2.GetRow()]) then
			b = 0
		else
			b = dec(dw_detalle2.object.metros[dw_detalle2.GetRow()])
		end if
		if b = 0 then
			dw_detalle.object.porcentaje_metros.text =  '0'+" %"
		else
			dw_detalle.object.porcentaje_metros.text =  String(  round(((a - b) / b) * 100, 1))+" %"
		end if													

		/////////////////////////////////////////////////////////////////////////////////////
		
		if isnull(dw_detalle.object.total_piezas[dw_detalle.GetRow()]) then
			a = 0
		else
			a = dec(dw_detalle.object.total_piezas[dw_detalle.GetRow()])
		end if
		if isnull(dw_detalle.object.total_piezas[dw_detalle2.GetRow()]) then
			b = 0
		else
			b = dec(dw_detalle2.object.piezas[dw_detalle2.GetRow()])
		end if
		if b = 0 then
			dw_detalle.object.porcentaje_piezas.text =  '0.0'+" %"
		else
			dw_detalle.object.porcentaje_piezas.text =  String(  round(((a - b) / b) * 100, 1))+" %"
		end if													

		/////////////////////////////////////////////////////////////////////////////////////
		
//		if isnull(dw_detalle.object.total_metrosl[dw_detalle.GetRow()]) then
//			a = 0
//		else
//			a = dec(dw_detalle.object.total_metrosl[dw_detalle.GetRow()])
//		end if
//		if isnull(dw_detalle.object.total_metrosl[dw_detalle2.GetRow()]) then
//			b = 0
//		else
//			b = dec(dw_detalle2.object.metrosl[dw_detalle2.GetRow()])
//		end if
//		if b = 0 then
//			dw_detalle.object.porcentaje_metrosl.text =  '0.0'+" %"
//		else
//			dw_detalle.object.porcentaje_metrosl.text =  String(  round(((a - b) / b) * 100, 1))+" %"
//		end if													
	end if
end if

if rb_resumen.checked then
	dw_detalle.visible = false
	dw_detalle2.visible = false
	dw_resumen_g2.visible = false
	dw_resumen.visible = true
	dw_resumen.SetTransObject(SQLCA)
	dw_resumen.Reset()
	dw_resumen.Retrieve(codigo_empresa, cliente, fecha1, fecha2, fecha3, fecha4, familia, '%')
end if

if rb_resumen_g2.checked then
	dw_detalle.visible = false
	dw_detalle2.visible = false
	dw_resumen.visible = false
	dw_resumen_g2.visible = true
	dw_resumen_g2.SetTransObject(SQLCA)
	dw_resumen_g2.Reset()
	dw_resumen_g2.Retrieve(codigo_empresa, cliente, fecha1, fecha2, familia)
end if
end subroutine

public subroutine f_control_pm (datawindow data);long      i,indice,total,donde,cantidad
Datetime  fecha1,fecha2,fecha
dec{2}    bruto,cambio,precio,dto1,dto2,bruto1,bruto2,metros,pm
String    series,cliente,sel,serie,divisa,moneda = "7",clientes,tarifa,calidad,articulo, familia
datastore datos

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_listado_resumen.SetTransObject(SQLCA)

dw_detalle.Reset()
dw_listado.Reset()
dw_listado_resumen.Reset()

data.setredraw(false)
uo_series.visible = false

fecha1 = Datetime(Date(em_fechadesde.Text))
fecha2 = Datetime(Date(em_fechahasta.Text))

if uo_cliente.em_codigo.text <> "" then
	clientes = uo_cliente.em_codigo.text
else
	clientes = "%"
end if

if uo_familia.em_codigo.text = '' or isnull (uo_familia.em_codigo.text) then
	familia = "%"
else
	familia = uo_familia.em_codigo.text
end if

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series)
//Cargamos los datos de los pedidos
sel = "select cliente,serie,sum(importe) bruto,divisa,fpedido,cantidad,articulo "+&
		"from   venliped "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente like '"+clientes+"' "+&
		"and    fpedido between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
		"and familia LIKE '"+familia+"' "+&
		"group  by cliente,serie,divisa,fpedido,cantidad,articulo"
		
//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	cliente  = datos.object.cliente[indice]
	serie    = datos.object.serie[indice]
	bruto    = datos.object.bruto[indice]
	divisa   = datos.object.divisa[indice]	
	cantidad = datos.object.cantidad[indice]	
	articulo = datos.object.articulo[indice]	
	cambio   = f_cambio_moneda(divisa)
	fecha    = datos.object.fpedido[indice]
	if isnull(bruto) then bruto = 0
	bruto   = bruto / cambio
	
	donde   = data.find("fecha_calculo = '"+string(fecha,"dd-mm-yy")+"'",1,data.rowcount())
	if donde > 0 then
		choose case serie
			case "1"
				data.object.importe_nacional[donde]   = data.object.importe_nacional[donde]+bruto
				data.object.piezas_nacional[donde]    = data.object.piezas_nacional[donde]+cantidad
				data.object.metros_nacional[donde]    = data.object.metros_nacional[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "2"
				data.object.importe_cee[donde]        = data.object.importe_cee[donde]+bruto
				data.object.piezas_cee[donde]         = data.object.piezas_cee[donde]+cantidad
				data.object.metros_cee[donde]         = data.object.metros_cee[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "3"
				data.object.importe_export[donde]     = data.object.importe_export[donde]+bruto
				data.object.piezas_exportacion[donde] = data.object.piezas_exportacion[donde]+cantidad
				data.object.metros_exportacion[donde] = data.object.metros_exportacion[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde] = data.object.importe_total[donde] +bruto
		data.object.piezas_total[donde]  = data.object.piezas_total[donde] +cantidad
		data.object.metros_total[donde]  = data.object.metros_total[donde] +f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
	else
		donde = data.insertrow(0)
		data.object.empresa[donde]           = codigo_empresa
		data.object.serie[donde]             = serie
		data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
		data.object.cliente[donde]           = cliente
		data.object.nombre_cliente[donde]    = f_razon_genter(codigo_empresa,"C",cliente)
		choose case serie
			case "1"
				data.object.importe_nacional[donde]   = bruto
				data.object.piezas_nacional[donde]    = cantidad
				data.object.metros_nacional[donde]    = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_cee[donde]        = 0
				data.object.piezas_cee[donde]         = 0
				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = 0
				data.object.piezas_exportacion[donde] = 0
				data.object.metros_exportacion[donde] = 0
         case "2"
				data.object.importe_nacional[donde]   = 0
				data.object.piezas_nacional[donde]    = 0
				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = bruto
				data.object.piezas_cee[donde]         = cantidad
				data.object.metros_cee[donde]         = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_export[donde]     = 0
				data.object.piezas_exportacion[donde] = 0
				data.object.metros_exportacion[donde] = 0
			case "3"
				data.object.importe_nacional[donde]   = 0
				data.object.piezas_nacional[donde]    = 0
				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = 0
				data.object.piezas_cee[donde]         = 0
				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = bruto
				data.object.piezas_exportacion[donde] = cantidad
				data.object.metros_exportacion[donde] = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde]     = bruto
		data.object.piezas_total[donde]      = cantidad
		data.object.metros_total[donde]      = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		data.object.moneda[donde]            = moneda
		data.object.fecha_ini[donde]         = fecha1
		data.object.fecha_fin[donde]         = fecha2
		data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
		data.object.fecha_calculo2[donde]    = fecha
end if
next

destroy datos
//Cargamos los datos de los albaranes
sel = "select cliente,serie,sum(importe) bruto,divisa,fpedido_origen,cantidad,articulo "+&
		"from   venlialb  "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente like '"+clientes+"' "+&
		"and    fpedido_origen between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
		"and familia LIKE '"+familia+"' "+&
		"group  by cliente,serie,divisa,fpedido_origen,cantidad,articulo"
		
//datos = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	cliente = datos.object.cliente[indice]
	serie   = datos.object.serie[indice]
	bruto   = datos.object.bruto[indice]
	divisa  = datos.object.divisa[indice]
	cantidad = datos.object.cantidad[indice]	
	articulo = datos.object.articulo[indice]	
	cambio  = f_cambio_moneda(divisa)
	fecha   = datos.object.fpedido_origen[indice]
	if isnull(bruto) then bruto = 0
	bruto   = bruto / cambio
	donde   = data.find("fecha_calculo = '"+string(fecha,"dd-mm-yy")+"'",1,data.rowcount())
	if donde > 0 then
		choose case serie
			case "1"
				data.object.importe_nacional[donde]   = data.object.importe_nacional[donde]+bruto
				data.object.piezas_nacional[donde]    = data.object.piezas_nacional[donde]+cantidad
				data.object.metros_nacional[donde]    = data.object.metros_nacional[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "2"
				data.object.importe_cee[donde]        = data.object.importe_cee[donde]+bruto
				data.object.piezas_cee[donde]         = data.object.piezas_cee[donde]+cantidad
				data.object.metros_cee[donde]         = data.object.metros_cee[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "3"
				data.object.importe_export[donde]     = data.object.importe_export[donde]+bruto
				data.object.piezas_exportacion[donde] = data.object.piezas_exportacion[donde]+cantidad
				data.object.metros_exportacion[donde] = data.object.metros_exportacion[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde] = data.object.importe_total[donde] +bruto
		data.object.piezas_total[donde]  = data.object.piezas_total[donde] +cantidad
		data.object.metros_total[donde]  = data.object.metros_total[donde] +f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
	else
		donde = data.insertrow(0)
		data.object.empresa[donde]           = codigo_empresa
		data.object.serie[donde]             = serie
		data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
		data.object.cliente[donde]           = cliente
		data.object.nombre_cliente[donde]    = f_razon_genter(codigo_empresa,"C",cliente)
		choose case serie
			case "1"
				data.object.importe_nacional[donde]   = bruto
				data.object.piezas_nacional[donde]    = cantidad
				data.object.metros_nacional[donde]    = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_cee[donde]        = 0
				data.object.piezas_cee[donde]         = 0
				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = 0
				data.object.piezas_exportacion[donde] = 0
				data.object.metros_exportacion[donde] = 0
         case "2"
				data.object.importe_nacional[donde]   = 0
				data.object.piezas_nacional[donde]    = 0
				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = bruto
				data.object.piezas_cee[donde]         = cantidad
				data.object.metros_cee[donde]         = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_export[donde]     = 0
				data.object.piezas_exportacion[donde] = 0
				data.object.metros_exportacion[donde] = 0
			case "3"
				data.object.importe_nacional[donde]   = 0
				data.object.piezas_nacional[donde]    = 0
				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = 0
				data.object.piezas_cee[donde]         = 0
				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = bruto
				data.object.piezas_exportacion[donde] = cantidad
				data.object.metros_exportacion[donde] = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde]     = bruto
		data.object.piezas_total[donde]      = cantidad
		data.object.metros_total[donde]      = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		data.object.moneda[donde]            = moneda
		data.object.fecha_ini[donde]         = fecha1
		data.object.fecha_fin[donde]         = fecha2
		data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
		data.object.fecha_calculo2[donde]    = fecha
	end if
next

destroy datos
//Cargamos los datos de las facturas
sel = "select cliente,serie,sum(importe / cambio) bruto,divisa,fpedido_origen,cantidad,articulo "+&
		"from   venlifac "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente like '"+clientes+"' "+&
		"and    fpedido_origen between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
		"and familia LIKE '"+familia+"' "+&
		"group  by cliente,serie,divisa,cambio,fpedido_origen,cantidad,articulo"
		
//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	cliente = datos.object.cliente[indice]
	serie   = datos.object.serie[indice]
	bruto   = datos.object.bruto[indice]
	divisa  = datos.object.divisa[indice]
	cantidad = datos.object.cantidad[indice]	
	articulo = datos.object.articulo[indice]	
	fecha   = datos.object.fpedido_origen[indice]
	//cambio  = datos.object.cambio[indice]
	if isnull(bruto) then bruto = 0
	//bruto   = bruto * cambio
	donde   = data.find("fecha_calculo = '"+string(fecha,"dd-mm-yy")+"'",1,data.rowcount())
	if donde > 0 then
		choose case serie
			case "1"
				data.object.importe_nacional[donde]   = data.object.importe_nacional[donde]+bruto
				data.object.piezas_nacional[donde]    = data.object.piezas_nacional[donde]+cantidad
				data.object.metros_nacional[donde]    = data.object.metros_nacional[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "2"
				data.object.importe_cee[donde]        = data.object.importe_cee[donde]+bruto
				data.object.piezas_cee[donde]         = data.object.piezas_cee[donde]+cantidad
				data.object.metros_cee[donde]         = data.object.metros_cee[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "3"
				data.object.importe_export[donde]     = data.object.importe_export[donde]+bruto
				data.object.piezas_exportacion[donde] = data.object.piezas_exportacion[donde]+cantidad
				data.object.metros_exportacion[donde] = data.object.metros_exportacion[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde] = data.object.importe_total[donde] +bruto
		data.object.piezas_total[donde]  = data.object.piezas_total[donde] +cantidad
		data.object.metros_total[donde]  = data.object.metros_total[donde] +f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
	else
		donde = data.insertrow(0)
		data.object.empresa[donde]           = codigo_empresa
		data.object.serie[donde]             = serie
		data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
		data.object.cliente[donde]           = cliente
		data.object.nombre_cliente[donde]    = f_razon_genter(codigo_empresa,"C",cliente)
		choose case serie
			case "1"
				data.object.importe_nacional[donde]   = bruto
				data.object.piezas_nacional[donde]    = cantidad
				data.object.metros_nacional[donde]    = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_cee[donde]        = 0
				data.object.piezas_cee[donde]         = 0
				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = 0
				data.object.piezas_exportacion[donde] = 0
				data.object.metros_exportacion[donde] = 0
         case "2"
				data.object.importe_nacional[donde]   = 0
				data.object.piezas_nacional[donde]    = 0
				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = bruto
				data.object.piezas_cee[donde]         = cantidad
				data.object.metros_cee[donde]         = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_export[donde]     = 0
				data.object.piezas_exportacion[donde] = 0
				data.object.metros_exportacion[donde] = 0
			case "3"
				data.object.importe_nacional[donde]   = 0
				data.object.piezas_nacional[donde]    = 0
				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = 0
				data.object.piezas_cee[donde]         = 0
				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = bruto
				data.object.piezas_exportacion[donde] = cantidad
				data.object.metros_exportacion[donde] = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde]     = bruto
		data.object.piezas_total[donde]      = cantidad
		data.object.metros_total[donde]      = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		data.object.moneda[donde]            = moneda
		data.object.fecha_ini[donde]         = fecha1
		data.object.fecha_fin[donde]         = fecha2
		data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
		data.object.fecha_calculo2[donde]    = fecha
	end if
next

destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
dw_listado_resumen.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Pedidos (Nuevo)"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
em_faltadesde.text = String(MDY(01,01,2001))
em_faltahasta.text = String(Today())
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
dw_detalle.DataObject = "dw_con_ped_alb_fac_cliente_fechas_tencer"
end event

on w_con_ped_alb_fac_cliente_fechas_tencer.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.st_1=create st_1
this.rb_detalle=create rb_detalle
this.rb_resumen=create rb_resumen
this.dw_listado_resumen=create dw_listado_resumen
this.rb_pm=create rb_pm
this.dw_listado_resumen_pm=create dw_listado_resumen_pm
this.dw_detalle2=create dw_detalle2
this.rb_resumen_g2=create rb_resumen_g2
this.uo_series=create uo_series
this.uo_familia=create uo_familia
this.gb_5=create gb_5
this.gb_4=create gb_4
this.em_faltadesde=create em_faltadesde
this.st_2=create st_2
this.em_faltahasta=create em_faltahasta
this.dw_resumen=create dw_resumen
this.dw_resumen_g2=create dw_resumen_g2
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.uo_cliente
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.rb_detalle
this.Control[iCurrent+13]=this.rb_resumen
this.Control[iCurrent+14]=this.dw_listado_resumen
this.Control[iCurrent+15]=this.rb_pm
this.Control[iCurrent+16]=this.dw_listado_resumen_pm
this.Control[iCurrent+17]=this.dw_detalle2
this.Control[iCurrent+18]=this.rb_resumen_g2
this.Control[iCurrent+19]=this.uo_series
this.Control[iCurrent+20]=this.uo_familia
this.Control[iCurrent+21]=this.gb_5
this.Control[iCurrent+22]=this.gb_4
this.Control[iCurrent+23]=this.em_faltadesde
this.Control[iCurrent+24]=this.st_2
this.Control[iCurrent+25]=this.em_faltahasta
this.Control[iCurrent+26]=this.dw_resumen
this.Control[iCurrent+27]=this.dw_resumen_g2
this.Control[iCurrent+28]=this.dw_detalle
end on

on w_con_ped_alb_fac_cliente_fechas_tencer.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.rb_detalle)
destroy(this.rb_resumen)
destroy(this.dw_listado_resumen)
destroy(this.rb_pm)
destroy(this.dw_listado_resumen_pm)
destroy(this.dw_detalle2)
destroy(this.rb_resumen_g2)
destroy(this.uo_series)
destroy(this.uo_familia)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.em_faltadesde)
destroy(this.st_2)
destroy(this.em_faltahasta)
destroy(this.dw_resumen)
destroy(this.dw_resumen_g2)
destroy(this.dw_detalle)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ped_alb_fac_cliente_fechas_tencer
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ped_alb_fac_cliente_fechas_tencer
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ped_alb_fac_cliente_fechas_tencer
integer y = 8
integer width = 4201
integer height = 88
boolean italic = true
end type

type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 4261
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 4247
integer y = 144
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;//if rb_pm.checked then
//	f_control_pm(dw_detalle)
//else
//	f_control(dw_detalle)
//end if
if rb_detalle.checked then
	f_imprimir_datawindow(dw_detalle)
end if

if rb_resumen.checked then
	f_imprimir_datawindow(dw_resumen)
end if

if rb_resumen_g2.checked then
	f_imprimir_datawindow(dw_resumen_g2)
end if

end event

type dw_listado from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
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

type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 27
integer y = 152
integer height = 76
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 329
integer y = 152
integer height = 76
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 3950
integer y = 144
integer width = 288
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;	
	f_control(dw_detalle)

/*
if rb_pm.checked then
	f_control_pm(dw_detalle)
else
	f_control(dw_detalle)
end if
*/
end event

type gb_2 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 14
integer y = 256
integer width = 3771
integer height = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 9
integer y = 100
integer width = 594
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha de Pedido"
end type

type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas_tencer
event destroy ( )
integer x = 626
integer y = 152
integer width = 1957
integer height = 80
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 603
integer y = 100
integer width = 1993
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 283
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

type rb_detalle from radiobutton within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 37
integer y = 296
integer width = 251
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detalle"
boolean checked = true
end type

event clicked;if rb_detalle.checked = true then
	rb_resumen.checked = false
	rb_resumen_g2.checked = false
	rb_pm.checked = false
	dw_detalle.visible = True
	dw_resumen.visible = false
	dw_resumen_g2.visible = false
end if

end event

type rb_resumen from radiobutton within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 338
integer y = 296
integer width = 315
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Resumen"
end type

event clicked;if rb_resumen.checked = true then
	rb_detalle.checked = false
	rb_resumen_g2.checked = false
	rb_pm.checked = false
	dw_detalle.visible = false
	dw_resumen.visible = true
	dw_resumen_g2.visible = false
end if

end event

type dw_listado_resumen from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
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

type rb_pm from radiobutton within w_con_ped_alb_fac_cliente_fechas_tencer
boolean visible = false
integer x = 1129
integer y = 288
integer width = 421
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Precio medio"
end type

event clicked;if rb_pm.checked = true then
	rb_detalle.checked = false
	rb_resumen.checked = false
	dw_detalle.DataObject = "report_con_ped_alb_fac_cliente_fechas3pm"
end if
end event

type dw_listado_resumen_pm from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
boolean visible = false
integer x = 2898
integer y = 12
integer width = 160
integer height = 96
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3pm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle2 from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 18
integer y = 2260
integer width = 4370
integer height = 224
string dataobject = "dw_con_ped_alb_fac_cliente_fechas_ten2"
boolean border = false
end type

type rb_resumen_g2 from radiobutton within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 709
integer y = 296
integer width = 421
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Resumen G2"
end type

event clicked;if rb_resumen_g2.checked = true then
	rb_detalle.checked = false
	rb_resumen.checked = false
	rb_pm.checked = false
	dw_detalle.visible = false
	dw_resumen.visible = false
	dw_resumen_g2.visible = true
end if

end event

type uo_series from u_marca_lista within w_con_ped_alb_fac_cliente_fechas_tencer
event destroy ( )
boolean visible = false
integer x = 1211
integer y = 264
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type uo_familia from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas_tencer
event destroy ( )
integer x = 2619
integer y = 152
integer width = 1051
integer height = 80
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string familia

select descripcion
into :familia
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= familia
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type gb_5 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 2597
integer y = 100
integer width = 1184
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Familia"
end type

type gb_4 from groupbox within w_con_ped_alb_fac_cliente_fechas_tencer
boolean visible = false
integer x = 603
integer y = 100
integer width = 594
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha de Alta"
end type

type em_faltadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas_tencer
boolean visible = false
integer x = 622
integer y = 152
integer height = 76
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_2 from statictext within w_con_ped_alb_fac_cliente_fechas_tencer
boolean visible = false
integer x = 869
integer y = 144
integer width = 46
integer height = 64
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_faltahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas_tencer
boolean visible = false
integer x = 923
integer y = 152
integer height = 76
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_resumen from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
boolean visible = false
integer x = 23
integer y = 412
integer width = 4366
integer height = 2072
integer taborder = 70
string dataobject = "dw_resumen_pedidos_meses_anyos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_resumen_g2 from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
boolean visible = false
integer x = 14
integer y = 416
integer width = 4366
integer height = 2072
integer taborder = 80
string dataobject = "dw_resumen_pedidos_meses_anyos_g2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas_tencer
integer x = 23
integer y = 392
integer width = 4366
integer height = 1872
integer taborder = 80
string dataobject = "dw_con_ped_alb_fac_cliente_fechas_tencer"
boolean vscrollbar = true
boolean border = false
end type

