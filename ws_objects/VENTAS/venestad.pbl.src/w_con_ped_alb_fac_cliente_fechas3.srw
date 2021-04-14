$PBExportHeader$w_con_ped_alb_fac_cliente_fechas3.srw
$PBExportComments$Informe de pedidos
forward
global type w_con_ped_alb_fac_cliente_fechas3 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas3
end type
type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas3
end type
type dw_listado from datawindow within w_con_ped_alb_fac_cliente_fechas3
end type
type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas3
end type
type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas3
end type
type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas3
end type
type gb_2 from groupbox within w_con_ped_alb_fac_cliente_fechas3
end type
type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas3
end type
type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas3
end type
type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas3
end type
type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas3
end type
type uo_series from u_marca_lista within w_con_ped_alb_fac_cliente_fechas3
end type
type gb_6 from groupbox within w_con_ped_alb_fac_cliente_fechas3
end type
type rb_detalle from radiobutton within w_con_ped_alb_fac_cliente_fechas3
end type
type rb_resumen from radiobutton within w_con_ped_alb_fac_cliente_fechas3
end type
type dw_listado_resumen from datawindow within w_con_ped_alb_fac_cliente_fechas3
end type
type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas3
end type
type rb_pm from radiobutton within w_con_ped_alb_fac_cliente_fechas3
end type
type dw_listado_resumen_pm from datawindow within w_con_ped_alb_fac_cliente_fechas3
end type
end forward

global type w_con_ped_alb_fac_cliente_fechas3 from w_int_con_empresa
integer width = 3525
integer height = 1996
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
uo_series uo_series
gb_6 gb_6
rb_detalle rb_detalle
rb_resumen rb_resumen
dw_listado_resumen dw_listado_resumen
dw_detalle dw_detalle
rb_pm rb_pm
dw_listado_resumen_pm dw_listado_resumen_pm
end type
global w_con_ped_alb_fac_cliente_fechas3 w_con_ped_alb_fac_cliente_fechas3

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_control_pm (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long      i,indice,total,donde,cantidad
Datetime  fecha1,fecha2,fecha
dec{2}    bruto,cambio,precio,dto1,dto2,bruto1,bruto2,metros,pm
String    series,cliente,sel,serie,divisa,moneda = "7",clientes,tarifa,calidad,articulo
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

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series)
//Cargamos los datos de los pedidos
sel = "select cliente,serie,sum(importe) bruto,divisa,fpedido "+&
		"from   venliped "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente like '"+clientes+"' "+&
		"and    fpedido between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
		"group  by cliente,serie,divisa,fpedido"
		
//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Cargando Pedidos",indice,total)
	cliente  = datos.object.cliente[indice]
	serie    = datos.object.serie[indice]
	bruto    = datos.object.bruto[indice]
	divisa   = datos.object.divisa[indice]	
//	cantidad = datos.object.cantidad[indice]	
//	articulo = datos.object.articulo[indice]	
	cambio   = f_cambio_moneda(divisa)
	fecha    = datos.object.fpedido[indice]
	if isnull(bruto) then bruto = 0
	bruto   = bruto / cambio
	donde   = data.find("fecha_calculo = '"+string(fecha,"dd-mm-yy")+"'",1,data.rowcount())
	if donde > 0 then
		choose case serie
			case "1"
				data.object.importe_nacional[donde]   = data.object.importe_nacional[donde]+bruto
			case "2"
				data.object.importe_cee[donde]        = data.object.importe_cee[donde]+bruto
			case "3"
				data.object.importe_export[donde]     = data.object.importe_export[donde]+bruto
		end choose
		data.object.importe_total[donde] = data.object.importe_total[donde] +bruto
		
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
//				data.object.piezas_nacional[donde]    = cantidad
//				data.object.metros_nacional[donde]    = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_cee[donde]        = 0
//				data.object.piezas_cee[donde]         = 0
//				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = 0
//				data.object.piezas_exportacion[donde] = 0
//				data.object.metros_exportacion[donde] = 0
         case "2"
				data.object.importe_nacional[donde]   = 0
//				data.object.piezas_nacional[donde]    = 0
//				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = bruto
//				data.object.piezas_cee[donde]         = cantidad
//				data.object.metros_cee[donde]         = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_export[donde]     = 0
//				data.object.piezas_exportacion[donde] = 0
//				data.object.metros_exportacion[donde] = 0
			case "3"
				data.object.importe_nacional[donde]   = 0
//				data.object.piezas_nacional[donde]    = 0
//				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = 0
//				data.object.piezas_cee[donde]         = 0
//				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = bruto
//				data.object.piezas_exportacion[donde] = cantidad
//				data.object.metros_exportacion[donde] = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde]     = bruto
//		data.object.piezas_total[donde]      = cantidad
//		data.object.metros_total[donde]      = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		data.object.moneda[donde]            = moneda
		data.object.fecha_ini[donde]         = fecha1
		data.object.fecha_fin[donde]         = fecha2
		data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
		data.object.fecha_calculo2[donde]    = fecha
end if
next

destroy datos
//Cargamos los datos de los albaranes
sel = "select cliente,serie,sum(importe) bruto,divisa,fpedido_origen "+&
		"from   venlialb "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente like '"+clientes+"' "+&
		"and    fpedido_origen between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
		"group  by cliente,serie,divisa,fpedido_origen,cantidad,articulo"
		
//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Cargando Albaranes",indice,total)
	cliente = datos.object.cliente[indice]
	serie   = datos.object.serie[indice]
	bruto   = datos.object.bruto[indice]
	divisa  = datos.object.divisa[indice]
//	cantidad = datos.object.cantidad[indice]	
//	articulo = datos.object.articulo[indice]	
	cambio  = f_cambio_moneda(divisa)
	fecha   = datos.object.fpedido_origen[indice]
	if isnull(bruto) then bruto = 0
	bruto   = bruto / cambio
	donde   = data.find("fecha_calculo = '"+string(fecha,"dd-mm-yy")+"'",1,data.rowcount())
	if donde > 0 then
		choose case serie
			case "1"
				data.object.importe_nacional[donde]   = data.object.importe_nacional[donde]+bruto
//				data.object.piezas_nacional[donde]    = data.object.piezas_nacional[donde]+cantidad
//				data.object.metros_nacional[donde]    = data.object.metros_nacional[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "2"
				data.object.importe_cee[donde]        = data.object.importe_cee[donde]+bruto
//				data.object.piezas_cee[donde]         = data.object.piezas_cee[donde]+cantidad
//				data.object.metros_cee[donde]         = data.object.metros_cee[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "3"
				data.object.importe_export[donde]     = data.object.importe_export[donde]+bruto
//				data.object.piezas_exportacion[donde] = data.object.piezas_exportacion[donde]+cantidad
//				data.object.metros_exportacion[donde] = data.object.metros_exportacion[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde] = data.object.importe_total[donde] +bruto
//		data.object.piezas_total[donde]  = data.object.piezas_total[donde] +cantidad
//		data.object.metros_total[donde]  = data.object.metros_total[donde] +f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
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
//				data.object.piezas_nacional[donde]    = cantidad
//				data.object.metros_nacional[donde]    = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_cee[donde]        = 0
//				data.object.piezas_cee[donde]         = 0
//				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = 0
//				data.object.piezas_exportacion[donde] = 0
//				data.object.metros_exportacion[donde] = 0
         case "2"
				data.object.importe_nacional[donde]   = 0
//				data.object.piezas_nacional[donde]    = 0
//				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = bruto
//				data.object.piezas_cee[donde]         = cantidad
//				data.object.metros_cee[donde]         = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_export[donde]     = 0
//				data.object.piezas_exportacion[donde] = 0
//				data.object.metros_exportacion[donde] = 0
			case "3"
				data.object.importe_nacional[donde]   = 0
//				data.object.piezas_nacional[donde]    = 0
//				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = 0
//				data.object.piezas_cee[donde]         = 0
//				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = bruto
//				data.object.piezas_exportacion[donde] = cantidad
//				data.object.metros_exportacion[donde] = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde]     = bruto
//		data.object.piezas_total[donde]      = cantidad
//		data.object.metros_total[donde]      = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		data.object.moneda[donde]            = moneda
		data.object.fecha_ini[donde]         = fecha1
		data.object.fecha_fin[donde]         = fecha2
		data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
		data.object.fecha_calculo2[donde]    = fecha
	end if
next

destroy datos
//Cargamos los datos de las facturas
sel = "select cliente,serie,sum(importe / cambio) bruto,divisa,fpedido_origen "+&
		"from   venlifac "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente like '"+clientes+"' "+&
		"and    fpedido_origen between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
		"group  by cliente,serie,divisa,cambio,fpedido_origen"
		
//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Cargando Facturas",indice,total)
	cliente = datos.object.cliente[indice]
	serie   = datos.object.serie[indice]
	bruto   = datos.object.bruto[indice]
	divisa  = datos.object.divisa[indice]
//	cantidad = datos.object.cantidad[indice]	
//	articulo = datos.object.articulo[indice]	
	fecha   = datos.object.fpedido_origen[indice]
	//cambio  = datos.object.cambio[indice]
	if isnull(bruto) then bruto = 0
	//bruto   = bruto * cambio
	donde   = data.find("fecha_calculo = '"+string(fecha,"dd-mm-yy")+"'",1,data.rowcount())
	if donde > 0 then
		choose case serie
			case "1"
				data.object.importe_nacional[donde]   = data.object.importe_nacional[donde]+bruto
//				data.object.piezas_nacional[donde]    = data.object.piezas_nacional[donde]+cantidad
//				data.object.metros_nacional[donde]    = data.object.metros_nacional[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "2"
				data.object.importe_cee[donde]        = data.object.importe_cee[donde]+bruto
//				data.object.piezas_cee[donde]         = data.object.piezas_cee[donde]+cantidad
//				data.object.metros_cee[donde]         = data.object.metros_cee[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			case "3"
				data.object.importe_export[donde]     = data.object.importe_export[donde]+bruto
//				data.object.piezas_exportacion[donde] = data.object.piezas_exportacion[donde]+cantidad
//				data.object.metros_exportacion[donde] = data.object.metros_exportacion[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde] = data.object.importe_total[donde] +bruto
//		data.object.piezas_total[donde]  = data.object.piezas_total[donde] +cantidad
//		data.object.metros_total[donde]  = data.object.metros_total[donde] +f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
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
//				data.object.piezas_nacional[donde]    = cantidad
//				data.object.metros_nacional[donde]    = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_cee[donde]        = 0
//				data.object.piezas_cee[donde]         = 0
//				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = 0
//				data.object.piezas_exportacion[donde] = 0
//				data.object.metros_exportacion[donde] = 0
         case "2"
				data.object.importe_nacional[donde]   = 0
//				data.object.piezas_nacional[donde]    = 0
//				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = bruto
//				data.object.piezas_cee[donde]         = cantidad
//				data.object.metros_cee[donde]         = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.importe_export[donde]     = 0
//				data.object.piezas_exportacion[donde] = 0
//				data.object.metros_exportacion[donde] = 0
			case "3"
				data.object.importe_nacional[donde]   = 0
//				data.object.piezas_nacional[donde]    = 0
//				data.object.metros_nacional[donde]    = 0
				data.object.importe_cee[donde]        = 0
//				data.object.piezas_cee[donde]         = 0
//				data.object.metros_cee[donde]         = 0
				data.object.importe_export[donde]     = bruto
//				data.object.piezas_exportacion[donde] = cantidad
//				data.object.metros_exportacion[donde] = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
		end choose
		data.object.importe_total[donde]     = bruto
//		data.object.piezas_total[donde]      = cantidad
//		data.object.metros_total[donde]      = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
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

public subroutine f_control_pm (datawindow data);long      i,indice,total,donde,cantidad
Datetime  fecha1,fecha2,fecha
dec{2}    bruto,cambio,precio,dto1,dto2,bruto1,bruto2,metros,pm
String    series,cliente,sel,serie,divisa,moneda = "7",clientes,tarifa,calidad,articulo
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

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series)
//Cargamos los datos de los pedidos
sel = "select cliente,serie,sum(importe) bruto,divisa,fpedido,cantidad,articulo "+&
		"from   venliped "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente like '"+clientes+"' "+&
		"and    fpedido between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
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
		"from   venlialb "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente like '"+clientes+"' "+&
		"and    fpedido_origen between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
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

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Pedidos"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
dw_detalle.DataObject = "report_con_ped_alb_fac_cliente_fechas3"
end event

on w_con_ped_alb_fac_cliente_fechas3.create
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
this.uo_series=create uo_series
this.gb_6=create gb_6
this.rb_detalle=create rb_detalle
this.rb_resumen=create rb_resumen
this.dw_listado_resumen=create dw_listado_resumen
this.dw_detalle=create dw_detalle
this.rb_pm=create rb_pm
this.dw_listado_resumen_pm=create dw_listado_resumen_pm
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
this.Control[iCurrent+12]=this.uo_series
this.Control[iCurrent+13]=this.gb_6
this.Control[iCurrent+14]=this.rb_detalle
this.Control[iCurrent+15]=this.rb_resumen
this.Control[iCurrent+16]=this.dw_listado_resumen
this.Control[iCurrent+17]=this.dw_detalle
this.Control[iCurrent+18]=this.rb_pm
this.Control[iCurrent+19]=this.dw_listado_resumen_pm
end on

on w_con_ped_alb_fac_cliente_fechas3.destroy
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
destroy(this.uo_series)
destroy(this.gb_6)
destroy(this.rb_detalle)
destroy(this.rb_resumen)
destroy(this.dw_listado_resumen)
destroy(this.dw_detalle)
destroy(this.rb_pm)
destroy(this.dw_listado_resumen_pm)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ped_alb_fac_cliente_fechas3
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ped_alb_fac_cliente_fechas3
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ped_alb_fac_cliente_fechas3
integer x = 9
integer y = 8
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas3
integer x = 3323
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas3
integer x = 3296
integer y = 292
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
f_imprimir_datawindow(dw_detalle)

end event

type dw_listado from datawindow within w_con_ped_alb_fac_cliente_fechas3
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

type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas3
integer x = 27
integer y = 168
integer width = 302
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas3
integer x = 398
integer y = 168
integer width = 279
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas3
integer x = 2999
integer y = 292
integer width = 288
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;if rb_pm.checked then
	f_control_pm(dw_detalle)
else
	f_control(dw_detalle)
end if

end event

type gb_2 from groupbox within w_con_ped_alb_fac_cliente_fechas3
integer x = 2578
integer y = 116
integer width = 864
integer height = 160
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas3
integer x = 9
integer y = 116
integer width = 690
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha de Pedido"
end type

type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas3
event destroy ( )
integer x = 722
integer y = 168
integer width = 1829
integer taborder = 30
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

type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas3
integer x = 704
integer y = 116
integer width = 1865
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas3
integer x = 343
integer y = 168
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
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_series from u_marca_lista within w_con_ped_alb_fac_cliente_fechas3
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type gb_6 from groupbox within w_con_ped_alb_fac_cliente_fechas3
integer x = 2981
integer y = 252
integer width = 462
integer height = 160
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

type rb_detalle from radiobutton within w_con_ped_alb_fac_cliente_fechas3
integer x = 2606
integer y = 156
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detalle"
boolean checked = true
end type

event clicked;if rb_detalle.checked = true then
	rb_resumen.checked = false
	rb_pm.checked = false
	dw_detalle.DataObject = "report_con_ped_alb_fac_cliente_fechas3"
end if

end event

type rb_resumen from radiobutton within w_con_ped_alb_fac_cliente_fechas3
integer x = 2606
integer y = 204
integer width = 329
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumen"
end type

event clicked;if rb_resumen.checked = true then
	rb_detalle.checked = false
	rb_pm.checked = false
	dw_detalle.DataObject = "report_con_ped_alb_fac_cliente_fechas3_r"
end if

end event

type dw_listado_resumen from datawindow within w_con_ped_alb_fac_cliente_fechas3
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

type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas3
integer x = 5
integer y = 420
integer width = 3442
integer height = 1332
boolean bringtotop = true
string dataobject = "dw_con_ped_alb_fac_cliente_fechas3"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type rb_pm from radiobutton within w_con_ped_alb_fac_cliente_fechas3
boolean visible = false
integer x = 2985
integer y = 192
integer width = 421
integer height = 76
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

type dw_listado_resumen_pm from datawindow within w_con_ped_alb_fac_cliente_fechas3
boolean visible = false
integer x = 2898
integer y = 12
integer width = 160
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3pm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

