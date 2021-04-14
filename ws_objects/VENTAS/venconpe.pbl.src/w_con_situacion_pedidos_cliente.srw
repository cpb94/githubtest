$PBExportHeader$w_con_situacion_pedidos_cliente.srw
$PBExportComments$Situación de pedidos
forward
global type w_con_situacion_pedidos_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_situacion_pedidos_cliente
end type
type dw_listado from datawindow within w_con_situacion_pedidos_cliente
end type
type em_fechadesde from u_em_campo within w_con_situacion_pedidos_cliente
end type
type em_fechahasta from u_em_campo within w_con_situacion_pedidos_cliente
end type
type gb_5 from groupbox within w_con_situacion_pedidos_cliente
end type
type gb_4 from groupbox within w_con_situacion_pedidos_cliente
end type
type gb_1 from groupbox within w_con_situacion_pedidos_cliente
end type
type st_1 from statictext within w_con_situacion_pedidos_cliente
end type
type em_anyo from u_em_campo within w_con_situacion_pedidos_cliente
end type
type st_pedido from statictext within w_con_situacion_pedidos_cliente
end type
type em_pedido from u_em_campo within w_con_situacion_pedidos_cliente
end type
type pb_2 from upb_imprimir within w_con_situacion_pedidos_cliente
end type
type cb_1 from commandbutton within w_con_situacion_pedidos_cliente
end type
type gb_6 from groupbox within w_con_situacion_pedidos_cliente
end type
type uo_formato from u_em_campo_2 within w_con_situacion_pedidos_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_situacion_pedidos_cliente
end type
type gb_2 from groupbox within w_con_situacion_pedidos_cliente
end type
type uo_articulo from u_em_campo_2 within w_con_situacion_pedidos_cliente
end type
type gb_3 from groupbox within w_con_situacion_pedidos_cliente
end type
type dw_detalle from datawindow within w_con_situacion_pedidos_cliente
end type
type dd_situacion from dropdownlistbox within w_con_situacion_pedidos_cliente
end type
type uo_agente from u_em_campo_2 within w_con_situacion_pedidos_cliente
end type
type gb_7 from groupbox within w_con_situacion_pedidos_cliente
end type
type gb_8 from groupbox within w_con_situacion_pedidos_cliente
end type
type gb_9 from groupbox within w_con_situacion_pedidos_cliente
end type
end forward

global type w_con_situacion_pedidos_cliente from w_int_con_empresa
integer width = 4151
integer height = 3420
pb_1 pb_1
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
gb_5 gb_5
gb_4 gb_4
gb_1 gb_1
st_1 st_1
em_anyo em_anyo
st_pedido st_pedido
em_pedido em_pedido
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
uo_formato uo_formato
uo_cliente uo_cliente
gb_2 gb_2
uo_articulo uo_articulo
gb_3 gb_3
dw_detalle dw_detalle
dd_situacion dd_situacion
uo_agente uo_agente
gb_7 gb_7
gb_8 gb_8
gb_9 gb_9
end type
global w_con_situacion_pedidos_cliente w_con_situacion_pedidos_cliente

type variables
boolean detalle = true,valorado = true,muestras = false
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long      donde
Datetime  fecha1,fecha2
String    series[1 to 20],cliente,codigo,formatos, agente
datetime  fpedido
string    sel,sel2,sel3,referencia_cliente,articulo,pe_al_fa,situacion,alb_fac, tonochar,calidad, tono_imprimir, calibre_imprimir
string    tipo_unidad,divisa,formato,nombre_articulo,filtro_pedido,filtro_pedido_alb_fac, filtro_promocion, cliente_filtro
dec{2}    cantidad,precio,dto1,dto2,npalet,original
long      indice,total,pedido,anyo,situacion_n,anyo_pedido_buscar,pedido_buscar,linea
dec       importe1,importe2,importe, importe_euros
int  	calibre
datastore lineas_pedido,lineas_albaran,lineas_factura

fecha1 = Datetime(Date(String(em_fechadesde.Text)))
fecha2 = Datetime(Date(String(em_fechahasta.Text)))

if uo_cliente.em_codigo.text <> "" then
	cliente_filtro = uo_cliente.em_codigo.text
else
	cliente_filtro = "%"
end if

if uo_agente.em_codigo.text <> "" then
	agente = uo_agente.em_codigo.text
else
	agente = "%"
end if

if uo_articulo.em_codigo.text <> "" then
	codigo = uo_articulo.em_codigo.text
else
	codigo = "%"
end if

if uo_formato.em_codigo.text <> "" then
	formatos = uo_formato.em_codigo.text
else
	formatos = "%"
end if

anyo_pedido_buscar = dec(em_anyo.text)
pedido_buscar      = dec(em_pedido.text)

if isnull(anyo_pedido_buscar) then anyo_pedido_buscar = 0
if isnull(pedido_buscar) then pedido_buscar = 0


//AQUÍ FALLO GORDO
/*
if anyo_pedido_buscar <> 0 and pedido_buscar <> 0 then
	filtro_pedido         = " and pedido = "+string(pedido_buscar,"#######")
	filtro_pedido         = filtro_pedido + " and anyo = "+string(anyo_pedido_buscar,"####")+" "
	filtro_pedido_alb_fac = " and pedido_origen = "+string(pedido_buscar,"#######")
	filtro_pedido_alb_fac = filtro_pedido_alb_fac + " and anyo_pedido_origen = "+string(anyo_pedido_buscar,"####")+" "
*/
if anyo_pedido_buscar <> 0 and pedido_buscar <> 0 then
	filtro_pedido         = " and venliped.pedido = "+string(pedido_buscar,"#######")
	filtro_pedido         = filtro_pedido + " and venliped.anyo = "+string(anyo_pedido_buscar,"####")+" "
	filtro_pedido_alb_fac = " and pedido_origen = "+string(pedido_buscar,"#######")
	filtro_pedido_alb_fac = filtro_pedido_alb_fac + " and anyo_pedido_origen = "+string(anyo_pedido_buscar,"####")+" "
else
	filtro_pedido         = ""
	filtro_pedido_alb_fac = ""
end if

if dd_situacion.text = "Sí" then
	filtro_promocion = " and (venliped.articulo IN (SELECT codigo FROM articulos WHERE promocion = 'S')) "
elseif dd_situacion.text = "No" then
	filtro_promocion = " and (venliped.articulo NOT IN (SELECT codigo FROM articulos WHERE promocion = 'S')) "
else
	filtro_promocion = ""
end if


data.setredraw(false)
data.reset()
data.Retrieve(codigo_empresa,fecha1,fecha2,cliente)

long ll_total_totales,ll_donde_totales
string ls_busqueda_totales
datastore ds_totales

/*
sel = "select resultado.anyo as anyo,"+&
		"		resultado.pedido as pedido,"+&
		"		resultado.linea as linea,"+&
		"		resultado.articulo as articulo,"+&
		"		resultado.calidad as calidad,"+&
		"		sum(resultado.cantidad) as cantidad_original "+&
		"from (   select venliped.anyo as anyo,"+&
		"					venliped.pedido as pedido,"+&
		"					venliped.linea as linea,"+&
		"					venliped.articulo as articulo,"+&
		"					venliped.calidad as calidad,"+&
		"					venliped.cantidad as cantidad "+&
		"			from  venped,"+&
		"					venliped "+&
		"			where venped.empresa = venliped.empresa "+&
		"			and    venped.anyo = venliped.anyo "+&
		"			and    venped.pedido = venliped.pedido "+&
		"			and    venped.empresa = '"+codigo_empresa+"' "+&
		"			and    venped.fpedido between '"+String(fecha1,"dd/mm/yy")+"' and '"+String(fecha2,"dd/mm/yy")+"' "+&
		"			union all "+&
		"			select venlialb.anyo_pedido_origen as anyo,"+&
		"					venlialb.pedido_origen as pedido,"+&
		"					venlialb.linea_pedido_origen as linea,"+&
		"					venlialb.articulo as articulo,"+&
		"					venlialb.calidad as calidad,"+&
		"					sum(venlialb.cantidad) as cantidad "+&
		"			from  venlialb "+&
		"			where venlialb.empresa = '"+codigo_empresa+"' "+&
		"			and    venlialb.fpedido_origen between '"+String(fecha1,"dd/mm/yy")+"' and '"+String(fecha2,"dd/mm/yy")+"' "+&
		"			group by venlialb.anyo_pedido_origen,"+&
		"					venlialb.pedido_origen,"+&
		"					venlialb.linea_pedido_origen,"+&
		"					venlialb.articulo,"+&
		"					venlialb.calidad "+&
		"			union all "+&
		"			select venlifac.anyo_pedido_origen as anyo,"+&
		"					venlifac.pedido_origen as pedido,"+&
		"					venlifac.linea_pedido_origen as linea,"+&
		"					venlifac.articulo as articulo,"+&
		"					venlifac.calidad as calidad,"+&
		"					sum(venlifac.cantidad) as cantidad "+&
		"			from  venlifac "+&
		"			where venlifac.empresa = '"+codigo_empresa+"' "+&
		"			and    venlifac.fpedido_origen between '"+String(fecha1,"dd/mm/yy")+"' and '"+String(fecha2,"dd/mm/yy")+"' "+&
		"			group by venlifac.anyo_pedido_origen,"+&
		"					venlifac.pedido_origen,"+&
		"					venlifac.linea_pedido_origen,"+&
		"					venlifac.articulo,"+&
		"					venlifac.calidad ) as resultado "+&
		"group by resultado.anyo,"+&
		"		resultado.pedido,"+&
		"		resultado.linea,"+&
		"		resultado.articulo,"+&
		"		resultado.calidad "+&
		"order by resultado.anyo,"+&
		"		resultado.pedido,"+&
		"		resultado.linea,"+&
		"		resultado.articulo,"+&
		"		resultado.calidad"

ll_total_totales = f_cargar_cursor_transaccion(sqlca,ds_totales,sel)
*/

sel = "select venliped.anyo,venliped.pedido,venliped.linea,"+&
		"venliped.fpedido,venliped.numpedcli,venliped.articulo,venliped.calidad,venliped.formato,venliped.cantidad,venliped.cantidad_original,venliped.tonochar,venliped.calibre,venliped.precio,venliped.dtoesp,venliped.dtoesp2,"+&
		"'P' pe_al_fa,venliped.situacion,"+&
		"venliped.cliente, venliped.agente1,venliped.tipo_unidad,venliped.divisa,"+&
		"0 albaran,'00/00/00' falbaran,0 factura,'00/00/00' ffactura ,venliped.descripcion,venliped.numpalet,venliped.cantidad_original, venliped.tono_imprimir, venliped.calibre_imprimir "+&
		"from  venliped "+&
		"INNER JOIN venped ON venped.empresa = venliped.empresa AND venped.anyo = venliped.anyo AND venped.pedido = venliped.pedido "+&
		"where venped.es_proforma = 'N' AND venliped.empresa = '"+codigo_empresa+"' "+&
		"and   venliped.cliente like '"+cliente_filtro+"' "+&
		"and   venliped.agente1 like '"+agente+"' "+&
		"and   venliped.articulo like '"+codigo+"' "+&
		"and   venliped.formato like '"+formatos+"' "+&
		"and   venliped.fpedido between '"+String(fecha1,"dd/mm/yy")+"' and '"+String(fecha2,"dd/mm/yy")+"' "+&
		filtro_pedido + filtro_promocion
		
f_cargar_cursor_nuevo(sel, lineas_pedido)
total = lineas_pedido.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Procesando Pedidos :",indice,total)
	fpedido            = lineas_pedido.object.venliped_fpedido[indice]
	pedido             = lineas_pedido.object.venliped_pedido[indice]
	anyo               = lineas_pedido.object.venliped_anyo[indice]
	linea               = lineas_pedido.object.venliped_linea[indice]
	referencia_cliente = lineas_pedido.object.venliped_numpedcli[indice]
	articulo           = lineas_pedido.object.venliped_articulo[indice]
	calidad            = lineas_pedido.object.venliped_calidad[indice]
	cantidad           = lineas_pedido.object.venliped_cantidad[indice]
	original           = lineas_pedido.object.venliped_cantidad_original[indice]
	/*
	ls_busqueda_totales = "anyo = "+string(anyo,"###0")+" and pedido = "+string(pedido,"###0")+" and linea = "+string(linea,"###0")+" and articulo = '"+articulo+"' and calidad = '"+calidad+"'"
	
	ll_donde_totales = ds_totales.find(ls_busqueda_totales,1,ll_total_totales)
	
	if ll_donde_totales > 0 then
		original           = ds_totales.object.cantidad_original[ll_donde_totales]
	else
		original           = cantidad
	end if
	*/	
	precio             = lineas_pedido.object.venliped_precio[indice]
	dto1               = lineas_pedido.object.venliped_dtoesp[indice]
	dto2               = lineas_pedido.object.venliped_dtoesp2[indice]
	pe_al_fa           = lineas_pedido.object.pe_al_fa[indice]
	situacion          = lineas_pedido.object.venliped_situacion[indice]
	cliente            = lineas_pedido.object.venliped_cliente[indice]
	tipo_unidad        = lineas_pedido.object.venliped_tipo_unidad[indice]
	divisa             = lineas_pedido.object.venliped_divisa[indice]
	npalet             = lineas_pedido.object.venliped_numpalet[indice]
	formato         	 = lineas_pedido.object.venliped_formato[indice]
	tonochar            = lineas_pedido.object.venliped_tonochar[indice]
	calibre             = lineas_pedido.object.venliped_calibre[indice]
	tono_imprimir            = lineas_pedido.object.venliped_tono_imprimir[indice]
	calibre_imprimir    = lineas_pedido.object.venliped_calibre_imprimir [indice]
	
	if isnull(articulo) then articulo = ""
	if trim(articulo) <> "" then
		//nombre_articulo = f_descripcion_almcliartdesc(codigo_empresa,cliente,articulo)
		nombre_articulo = lineas_pedido.object.venliped_descripcion[indice]
		if nombre_articulo = "" then
  		   nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
		end if
	else
		formato = ""
		tipo_unidad = ""
		nombre_articulo = lineas_pedido.object.venliped_descripcion[indice]
	end if
	
	if isnull(dto1) then dto1 = 0
	if isnull(dto2) then dto2 = 0
	
	if pe_al_fa = "P" then
		if situacion = "P" then
			//Linea de Pedido Preparada
			situacion_n = 2
		else
			//Linea de Pedido Pendiente
			situacion_n = 1
		end if
		alb_fac = ""
	else
		if pe_al_fa = "A" then
			//Linea de Pedido Albaraneada
			situacion_n = 3
			alb_fac = "Alb :"+string(lineas_pedido.object.albaran[indice],"###,###")
			alb_fac = alb_fac + " - "+string(lineas_pedido.object.falbaran[indice],"dd/mm/yy")
		else
			//Linea de Pedido facturada
			situacion_n = 4
			alb_fac = "Alb :"+string(lineas_pedido.object.albaran[indice],"###,###")
			alb_fac = alb_fac + " - "+string(lineas_pedido.object.falbaran[indice],"dd/mm/yy")
			alb_fac = alb_fac+" Fac :"+string(lineas_pedido.object.factura[indice],"###,###")
			alb_fac = alb_fac + " - "+string(lineas_pedido.object.ffactura[indice],"dd/mm/yy")
			
		end if		
	end if

	donde = data.insertrow(0)
	importe1 = cantidad * precio
	importe2 = importe1 - (importe1 * dto1 / 100)
	importe  = importe2 - (importe2 * dto2 / 100)
	importe_euros = importe / f_cambio_moneda( divisa ) 	
	
	data.object.empresa[donde]            = codigo_empresa
	data.object.fpedido[donde]            = fpedido
	data.object.pedido[donde]             = pedido
	data.object.anyo[donde]               = anyo
	data.object.referencia_cliente[donde] = referencia_cliente
	data.object.articulo[donde]           = articulo
	data.object.nombre_articulo[donde]    = nombre_articulo
	data.object.cantidad[donde]           = cantidad
	data.object.original[donde]           = original
	data.object.precio[donde]             = precio
	data.object.importe[donde]            = importe
	data.object.importe_euros[donde]      = importe_euros 
	data.object.dto1[donde]               = dto1
	data.object.dto2[donde]               = dto2
	data.object.situacion[donde]          = situacion_n
	data.object.nombre_formato[donde]     = f_nombre_formato(codigo_empresa,formato)
	if trim(tipo_unidad) <> "" then
		data.object.unidad[donde]             = tipo_unidad
		data.object.nombre_unidad[donde]      = f_nombre_unidad(tipo_unidad)
	else
		data.object.unidad[donde]             = "0"
		data.object.nombre_unidad[donde]      = "Un."
	end if
	data.object.moneda[donde]             = divisa
	data.object.nombre_moneda[donde]      = f_nombre_moneda_abr(divisa)
	data.object.alb_fac[donde]            = alb_fac
	data.object.cliente[donde]            = cliente
	data.object.nombre_cliente[donde]     = f_razon_genter(codigo_empresa,"C",cliente)
	data.object.numpalet[donde]           = npalet
	data.object.tonochar[donde]           = tonochar
	data.object.calibre[donde]           = calibre
	data.object.tono_imprimir[donde]           = tono_imprimir
	data.object.calibre_imprimir[donde]           = calibre_imprimir
next

sel2=	"select anyo_pedido_origen,pedido_origen,linea_pedido_origen,"+&
		"fpedido_origen,numpedcli,articulo,calidad,formato,cantidad,cantidad_original,precio,dtoesp,dtoesp2, tonochar, calibre, "+&
		"'A' pe_al_fa,situacion,"+&
		"cliente, agente1, tipo_unidad,divisa,"+&
		"albaran,falbaran,0 factura,'00/00/00' ffactura ,descripcion, numpalet,cantidad_original, tono_imprimir, calibre_imprimir "+&		
		"from  venlialb "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and   cliente like '"+cliente_filtro+"' "+&
		"and   agente1 like '"+agente+"' "+&
		"and   articulo like '"+codigo+"' "+&
		"and   formato like '"+formatos+"' "+&
		"and   fpedido_origen between '"+String(fecha1,"dd/mm/yy")+"' and '"+String(fecha2,"dd/mm/yy")+"' "+&
		filtro_pedido_alb_fac
		
//lineas_albaran = f_cargar_cursor(sel2)		
f_cargar_cursor_nuevo(sel2, lineas_albaran)
total = lineas_albaran.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Procesando Albaranes:",indice,total)
	fpedido            = lineas_albaran.object.fpedido_origen[indice]
	pedido             = lineas_albaran.object.pedido_origen[indice]
	anyo               = lineas_albaran.object.anyo_pedido_origen[indice]
	linea               = lineas_albaran.object.linea_pedido_origen[indice]
	referencia_cliente = lineas_albaran.object.numpedcli[indice]
	articulo           = lineas_albaran.object.articulo[indice]
	calidad           = lineas_albaran.object.calidad[indice]
	cantidad           = lineas_albaran.object.cantidad[indice]
	original           = lineas_albaran.object.cantidad_original[indice]
	/*
	ls_busqueda_totales = "anyo = "+string(anyo,"###0")+" and pedido = "+string(pedido,"###0")+" and linea = "+string(linea,"###0")+" and articulo = '"+articulo+"' and calidad = '"+calidad+"'"
	
	ll_donde_totales = ds_totales.find(ls_busqueda_totales,1,ll_total_totales)
	
	if ll_donde_totales > 0 then
		original           = ds_totales.object.cantidad_original[ll_donde_totales]
	else
		original           = cantidad
	end if
	*/
	precio             = lineas_albaran.object.precio[indice]
	dto1               = lineas_albaran.object.dtoesp[indice]
	dto2               = lineas_albaran.object.dtoesp2[indice]
	pe_al_fa           = lineas_albaran.object.pe_al_fa[indice]
	situacion          = lineas_albaran.object.situacion[indice]
	cliente            = lineas_albaran.object.cliente[indice]
	tipo_unidad        = lineas_albaran.object.tipo_unidad[indice]
	divisa             = lineas_albaran.object.divisa[indice]
	npalet             = lineas_albaran.object.numpalet[indice]
	formato         	 = lineas_albaran.object.formato[indice]
	tonochar         	 = lineas_albaran.object.tonochar[indice]
	calibre         	 = lineas_albaran.object.calibre[indice]
	tono_imprimir         	 = lineas_albaran.object.tono_imprimir[indice]
	calibre_imprimir         	 = lineas_albaran.object.calibre_imprimir[indice]
	if isnull(articulo) then articulo = ""
	if trim(articulo) <> "" then
		//nombre_articulo = f_descripcion_almcliartdesc(codigo_empresa,cliente,articulo)
		nombre_articulo = lineas_albaran.object.descripcion[indice]
		/*
		if nombre_articulo = "" then
  		   nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
		end if
		*/
	else
		formato = ""
		tipo_unidad = ""
		nombre_articulo = lineas_albaran.object.descripcion[indice]
	end if
	
	if isnull(dto1) then dto1 = 0
	if isnull(dto2) then dto2 = 0
	
	if pe_al_fa = "P" then
		if situacion = "P" then
			//Linea de Pedido Preparada
			situacion_n = 2
		else
			//Linea de Pedido Pendiente
			situacion_n = 1
		end if
		alb_fac = ""
	else
		if pe_al_fa = "A" then
			//Linea de Pedido Albaraneada
			situacion_n = 3
			alb_fac = "Alb :"+string(lineas_albaran.object.albaran[indice],"###,###")
			alb_fac = alb_fac + " - "+string(lineas_albaran.object.falbaran[indice],"dd/mm/yy")
		else
			//Linea de Pedido facturada
			situacion_n = 4
			alb_fac = "Alb :"+string(lineas_albaran.object.albaran[indice],"###,###")
			alb_fac = alb_fac + " - "+string(lineas_albaran.object.falbaran[indice],"dd/mm/yy")
			alb_fac = alb_fac+" Fac :"+string(lineas_albaran.object.factura[indice],"###,###")
			alb_fac = alb_fac + " - "+string(lineas_albaran.object.ffactura[indice],"dd/mm/yy")
			
		end if		
	end if

	donde = data.insertrow(0)
	importe1 = cantidad * precio
	importe2 = importe1 - (importe1 * dto1 / 100)
	importe  = importe2 - (importe2 * dto2 / 100)
	importe_euros = importe / f_cambio_moneda( divisa ) 	
	
	data.object.empresa[donde]            = codigo_empresa
	data.object.fpedido[donde]            = fpedido
	data.object.pedido[donde]             = pedido
	data.object.anyo[donde]               = anyo
	data.object.referencia_cliente[donde] = referencia_cliente
	data.object.articulo[donde]           = articulo
	data.object.nombre_articulo[donde]    = nombre_articulo
	data.object.cantidad[donde]           = cantidad
	data.object.original[donde]           = original
	data.object.precio[donde]             = precio
	data.object.importe[donde]            = importe
	data.object.importe_euros[donde]      = importe_euros  
	data.object.dto1[donde]               = dto1
	data.object.dto2[donde]               = dto2
	data.object.situacion[donde]          = situacion_n
	data.object.nombre_formato[donde]     = f_nombre_formato(codigo_empresa,formato)
	if trim(tipo_unidad) <> "" then
		data.object.unidad[donde]             = tipo_unidad
		data.object.nombre_unidad[donde]      = f_nombre_unidad(tipo_unidad)
	else
		data.object.unidad[donde]             = "0"
		data.object.nombre_unidad[donde]      = "Un."
	end if
	data.object.moneda[donde]             = divisa
	data.object.nombre_moneda[donde]      = f_nombre_moneda_abr(divisa)
	data.object.alb_fac[donde]            = alb_fac
	data.object.cliente[donde]            = cliente
	data.object.nombre_cliente[donde]     = f_razon_genter(codigo_empresa,"C",cliente)
	data.object.numpalet[donde]           = npalet
	data.object.tonochar[donde]           = tonochar
	data.object.calibre[donde]           = calibre
	data.object.tono_imprimir[donde]           = tono_imprimir
	data.object.calibre_imprimir[donde]           = calibre_imprimir
next


sel3=	"select anyo_pedido_origen,pedido_origen,linea_pedido_origen,"+&
		"fpedido_origen,numpedcli,articulo,calidad,formato,cantidad,cantidad_original,precio,dtoesp,dtoesp2, tonochar, calibre, "+&
		"'F' pe_al_fa,situacion,"+&
		"cliente,tipo_unidad,divisa,"+&
		"albaran,falbaran,factura,ffactura ,descripcion, numpalet,cantidad_original, tono_imprimir, calibre_imprimir "+&		
		"from  venlifac "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and   cliente like '"+cliente_filtro+"' "+&
		"and   agente1 like '"+agente+"' "+&
		"and   articulo like '"+codigo+"' "+&
		"and   formato like '"+formatos+"' "+&
		"and   fpedido_origen between '"+String(fecha1,"dd/mm/yy")+"' and '"+String(fecha2,"dd/mm/yy")+"' "+&
		filtro_pedido_alb_fac

//lineas_factura = f_cargar_cursor(sel3)		
f_cargar_cursor_nuevo(sel3, lineas_factura)
total = lineas_factura.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Procesando Facturas:",indice,total)
	fpedido            = lineas_factura.object.fpedido_origen[indice]
	pedido             = lineas_factura.object.pedido_origen[indice]
	anyo               = lineas_factura.object.anyo_pedido_origen[indice]
	linea               = lineas_factura.object.linea_pedido_origen[indice]
	referencia_cliente = lineas_factura.object.numpedcli[indice]
	articulo           = lineas_factura.object.articulo[indice]
	calidad           = lineas_factura.object.calidad[indice]
	cantidad           = lineas_factura.object.cantidad[indice]
	original           = lineas_factura.object.cantidad_original[indice]
	/*
	ls_busqueda_totales = "anyo = "+string(anyo,"###0")+" and pedido = "+string(pedido,"###0")+" and linea = "+string(linea,"###0")+" and articulo = '"+articulo+"' and calidad = '"+calidad+"'"
	
	ll_donde_totales = ds_totales.find(ls_busqueda_totales,1,ll_total_totales)
	
	if ll_donde_totales > 0 then
		original           = ds_totales.object.cantidad_original[ll_donde_totales]
	else
		original           = cantidad
	end if
	*/
	precio             = lineas_factura.object.precio[indice]
	dto1               = lineas_factura.object.dtoesp[indice]
	dto2               = lineas_factura.object.dtoesp2[indice]
	pe_al_fa           = lineas_factura.object.pe_al_fa[indice]
	situacion          = lineas_factura.object.situacion[indice]
	cliente            = lineas_factura.object.cliente[indice]
	tipo_unidad        = lineas_factura.object.tipo_unidad[indice]
	divisa             = lineas_factura.object.divisa[indice]
	npalet             = lineas_factura.object.numpalet[indice]
	formato         	 = lineas_factura.object.formato[indice]
	tonochar         	 = lineas_factura.object.tonochar[indice]
	calibre         	 = lineas_factura.object.calibre[indice]
	tono_imprimir   	 = lineas_factura.object.tono_imprimir[indice]
	calibre_imprimir	 = lineas_factura.object.calibre_imprimir[indice]

	if isnull(articulo) then articulo = ""
	if trim(articulo) <> "" then
		//nombre_articulo = f_descripcion_almcliartdesc(codigo_empresa,cliente,articulo)
		nombre_articulo = lineas_factura.object.descripcion[indice]
		/*
		if nombre_articulo = "" then
  		   nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
		end if
		*/
	else
		formato = ""
		tipo_unidad = ""
		nombre_articulo = lineas_factura.object.descripcion[indice]
	end if
	
	if isnull(dto1) then dto1 = 0
	if isnull(dto2) then dto2 = 0
	
	if pe_al_fa = "P" then
		if situacion = "P" then
			//Linea de Pedido Preparada
			situacion_n = 2
		else
			//Linea de Pedido Pendiente
			situacion_n = 1
		end if
		alb_fac = ""
	else
		if pe_al_fa = "A" then
			//Linea de Pedido Albaraneada
			situacion_n = 3
			alb_fac = "Alb :"+string(lineas_factura.object.albaran[indice],"###,###")
			alb_fac = alb_fac + " - "+string(lineas_factura.object.falbaran[indice],"dd/mm/yy")
		else
			//Linea de Pedido facturada
			situacion_n = 4
			alb_fac = "Alb :"+string(lineas_factura.object.albaran[indice],"###,###")
			alb_fac = alb_fac + " - "+string(lineas_factura.object.falbaran[indice],"dd/mm/yy")
			alb_fac = alb_fac+" Fac :"+string(lineas_factura.object.factura[indice],"###,###")
			alb_fac = alb_fac + " - "+string(lineas_factura.object.ffactura[indice],"dd/mm/yy")
			
		end if		
		
	end if
	
	donde = data.insertrow(0)
	importe1 = cantidad * precio
	importe2 = importe1 - (importe1 * dto1 / 100)
	importe  = importe2 - (importe2 * dto2 / 100)
	importe_euros = importe / f_cambio_moneda( divisa ) 	
	
	data.object.empresa[donde]            = codigo_empresa
	data.object.fpedido[donde]            = fpedido
	data.object.pedido[donde]             = pedido
	data.object.anyo[donde]               = anyo
	data.object.referencia_cliente[donde] = referencia_cliente
	data.object.articulo[donde]           = articulo
	data.object.nombre_articulo[donde]    = nombre_articulo
	data.object.cantidad[donde]           = cantidad
	data.object.original[donde]           = original
	data.object.precio[donde]             = precio
	data.object.importe[donde]            = importe
	data.object.importe_euros[donde]      = importe_euros  
	data.object.dto1[donde]               = dto1
	data.object.dto2[donde]               = dto2
	data.object.situacion[donde]          = situacion_n
	data.object.nombre_formato[donde]     = f_nombre_formato(codigo_empresa,formato)
	if trim(tipo_unidad) <> "" then
		data.object.unidad[donde]             = tipo_unidad
		data.object.nombre_unidad[donde]      = f_nombre_unidad(tipo_unidad)
	else
		data.object.unidad[donde]             = "0"
		data.object.nombre_unidad[donde]      = "Un."
	end if
	data.object.moneda[donde]             = divisa
	data.object.nombre_moneda[donde]      = f_nombre_moneda_abr(divisa)
	data.object.alb_fac[donde]            = alb_fac
	data.object.cliente[donde]            = cliente
	data.object.nombre_cliente[donde]     = f_razon_genter(codigo_empresa,"C",cliente)
	data.object.numpalet[donde]           = npalet
	data.object.tonochar[donde]           = tonochar
	data.object.calibre[donde]           = calibre
	data.object.tono_imprimir[donde]           = tono_imprimir
	data.object.calibre_imprimir[donde]           = calibre_imprimir
next

destroy ds_totales		
destroy lineas_pedido
destroy lineas_albaran
destroy lineas_factura

data.sort()
data.groupcalc()
data.setredraw(true)



end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta Situación Pedidos Cliente"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dd_situacion.text = "Todos"
end event

on w_con_situacion_pedidos_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_1=create gb_1
this.st_1=create st_1
this.em_anyo=create em_anyo
this.st_pedido=create st_pedido
this.em_pedido=create em_pedido
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.uo_formato=create uo_formato
this.uo_cliente=create uo_cliente
this.gb_2=create gb_2
this.uo_articulo=create uo_articulo
this.gb_3=create gb_3
this.dw_detalle=create dw_detalle
this.dd_situacion=create dd_situacion
this.uo_agente=create uo_agente
this.gb_7=create gb_7
this.gb_8=create gb_8
this.gb_9=create gb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_anyo
this.Control[iCurrent+10]=this.st_pedido
this.Control[iCurrent+11]=this.em_pedido
this.Control[iCurrent+12]=this.pb_2
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.gb_6
this.Control[iCurrent+15]=this.uo_formato
this.Control[iCurrent+16]=this.uo_cliente
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.uo_articulo
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.dw_detalle
this.Control[iCurrent+21]=this.dd_situacion
this.Control[iCurrent+22]=this.uo_agente
this.Control[iCurrent+23]=this.gb_7
this.Control[iCurrent+24]=this.gb_8
this.Control[iCurrent+25]=this.gb_9
end on

on w_con_situacion_pedidos_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.em_anyo)
destroy(this.st_pedido)
destroy(this.em_pedido)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.uo_formato)
destroy(this.uo_cliente)
destroy(this.gb_2)
destroy(this.uo_articulo)
destroy(this.gb_3)
destroy(this.dw_detalle)
destroy(this.dd_situacion)
destroy(this.uo_agente)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.gb_9)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_situacion_pedidos_cliente
integer x = 64
integer y = 1364
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_situacion_pedidos_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_situacion_pedidos_cliente
integer y = 8
integer width = 4087
integer height = 76
end type

type pb_1 from upb_salir within w_con_situacion_pedidos_cliente
integer x = 3918
integer y = 156
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type dw_listado from datawindow within w_con_situacion_pedidos_cliente
boolean visible = false
integer x = 2770
integer y = 160
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_situacion_pedidos_cliente"
boolean livescroll = true
end type

type em_fechadesde from u_em_campo within w_con_situacion_pedidos_cliente
integer x = 37
integer y = 164
integer width = 320
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fechahasta from u_em_campo within w_con_situacion_pedidos_cliente
integer x = 425
integer y = 164
integer width = 320
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type gb_5 from groupbox within w_con_situacion_pedidos_cliente
integer x = 786
integer y = 272
integer width = 1637
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Artículo"
end type

type gb_4 from groupbox within w_con_situacion_pedidos_cliente
integer x = 2743
integer y = 108
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
string text = "Año             Pedido"
end type

type gb_1 from groupbox within w_con_situacion_pedidos_cliente
integer x = 9
integer y = 108
integer width = 768
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fechas de Pedido"
end type

type st_1 from statictext within w_con_situacion_pedidos_cliente
integer x = 361
integer y = 152
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

type em_anyo from u_em_campo within w_con_situacion_pedidos_cliente
integer x = 2770
integer y = 160
integer width = 238
integer taborder = 80
boolean bringtotop = true
end type

type st_pedido from statictext within w_con_situacion_pedidos_cliente
integer x = 3008
integer y = 160
integer width = 55
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_pedido from u_em_campo within w_con_situacion_pedidos_cliente
integer x = 3058
integer y = 160
integer width = 256
integer taborder = 90
boolean bringtotop = true
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pedidos"
ue_datawindow = "dw_ayuda_preparacion_pedidos"
ue_filtro     = " venped_anyo  =  " + em_anyo.text


end event

type pb_2 from upb_imprimir within w_con_situacion_pedidos_cliente
integer x = 3707
integer y = 156
integer taborder = 130
boolean bringtotop = true
end type

event clicked;dw_listado.Reset()
f_control(dw_listado)
f_imprimir_datawindow(dw_listado)

end event

type cb_1 from commandbutton within w_con_situacion_pedidos_cliente
integer x = 3429
integer y = 156
integer width = 270
integer height = 96
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;dw_detalle.Reset()
f_control(dw_detalle)

end event

type gb_6 from groupbox within w_con_situacion_pedidos_cliente
integer x = 3401
integer y = 116
integer width = 448
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

type uo_formato from u_em_campo_2 within w_con_situacion_pedidos_cliente
event destroy ( )
integer x = 46
integer y = 324
integer width = 704
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato(codigo_empresa,uo_formato.em_codigo.text)
If Trim(uo_formato.em_campo.text)="" then
	uo_formato.em_campo.text=""
	uo_formato.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formatos"
ue_datawindow ="dw_ayuda_formatos"
ue_filtro = ""
end event

type uo_cliente from u_em_campo_2 within w_con_situacion_pedidos_cliente
event destroy ( )
integer x = 809
integer y = 160
integer width = 1595
integer taborder = 40
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

type gb_2 from groupbox within w_con_situacion_pedidos_cliente
integer x = 2738
integer y = 272
integer width = 402
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Promoción"
end type

type uo_articulo from u_em_campo_2 within w_con_situacion_pedidos_cliente
event destroy ( )
integer x = 805
integer y = 328
integer width = 1600
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_descripcion_almcliartdesc(codigo_empresa,uo_cliente.em_codigo.text,uo_articulo.em_codigo.text)
if Trim(uo_articulo.em_campo.text) = "" then
   uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
end if
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Clientes"
//ue_datawindow ="dw_ayuda_articulos_2_criterios"
ue_datawindow  = "dw_ayuda_articulos_almcliartdesc"
ue_filtro = ""
end event

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type gb_3 from groupbox within w_con_situacion_pedidos_cliente
integer x = 786
integer y = 108
integer width = 1632
integer height = 160
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

type dw_detalle from datawindow within w_con_situacion_pedidos_cliente
integer x = 9
integer y = 444
integer width = 4073
integer height = 2756
string dataobject = "report_con_situacion_pedidos_cliente"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//str_parametros lstr_param
//IF Row <> 0 Then
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
//  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
//  OpenWithParm(w_int_venped,lstr_param) 
//End If
end event

type dd_situacion from dropdownlistbox within w_con_situacion_pedidos_cliente
integer x = 2775
integer y = 328
integer width = 329
integer height = 352
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"Sí","No","Todos"}
borderstyle borderstyle = stylelowered!
end type

type uo_agente from u_em_campo_2 within w_con_situacion_pedidos_cliente
event destroy ( )
integer x = 3177
integer y = 324
integer width = 887
integer taborder = 110
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_agente(codigo_empresa, uo_agente.em_codigo.text)
If Trim(uo_Agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Agentes"
ue_datawindow ="dw_ayuda_venagentes"
ue_filtro = ""
end event

type gb_7 from groupbox within w_con_situacion_pedidos_cliente
integer x = 3895
integer y = 116
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

type gb_8 from groupbox within w_con_situacion_pedidos_cliente
integer x = 23
integer y = 272
integer width = 750
integer height = 164
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Formato"
end type

type gb_9 from groupbox within w_con_situacion_pedidos_cliente
integer x = 3154
integer y = 272
integer width = 923
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Agente"
end type

