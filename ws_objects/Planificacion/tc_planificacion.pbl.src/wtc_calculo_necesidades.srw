$PBExportHeader$wtc_calculo_necesidades.srw
forward
global type wtc_calculo_necesidades from wt_consultas_padre
end type
type ddlb_meses_de_stock from dropdownlistbox within wtc_calculo_necesidades
end type
type cbx_stock_sugerido from checkbox within wtc_calculo_necesidades
end type
type ddlb_meses_stock_min from dropdownlistbox within wtc_calculo_necesidades
end type
type ddlb_rotura from dropdownlistbox within wtc_calculo_necesidades
end type
type dw_graf_ventas_mes from datawindow within wtc_calculo_necesidades
end type
type cbx_grafica from checkbox within wtc_calculo_necesidades
end type
type st_mensajes from statictext within wtc_calculo_necesidades
end type
type pb_2 from picturebutton within wtc_calculo_necesidades
end type
type dw_export_excel from datawindow within wtc_calculo_necesidades
end type
type pb_3 from picturebutton within wtc_calculo_necesidades
end type
type ddlb_sugerido from dropdownlistbox within wtc_calculo_necesidades
end type
type gb_1 from groupbox within wtc_calculo_necesidades
end type
type gb_2 from groupbox within wtc_calculo_necesidades
end type
type gb_3 from groupbox within wtc_calculo_necesidades
end type
type gb_excel from groupbox within wtc_calculo_necesidades
end type
type gb_4 from groupbox within wtc_calculo_necesidades
end type
end forward

global type wtc_calculo_necesidades from wt_consultas_padre
integer width = 8553
integer height = 4160
string title = "Cálculo Necesidades"
ddlb_meses_de_stock ddlb_meses_de_stock
cbx_stock_sugerido cbx_stock_sugerido
ddlb_meses_stock_min ddlb_meses_stock_min
ddlb_rotura ddlb_rotura
dw_graf_ventas_mes dw_graf_ventas_mes
cbx_grafica cbx_grafica
st_mensajes st_mensajes
pb_2 pb_2
dw_export_excel dw_export_excel
pb_3 pb_3
ddlb_sugerido ddlb_sugerido
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_excel gb_excel
gb_4 gb_4
end type
global wtc_calculo_necesidades wtc_calculo_necesidades

type variables
string sql_inicial
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_consulta ()
public subroutine f_cargar_datawindow (string new_sql)
public subroutine f_calculo_stock_sugerido ()
public function decimal f_consumo_mensual_desviacion_std (string arg_articulo, integer total_meses, datetime fecha_final)
public function integer f_planificar_wow ()
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''


for j = 1 to dw_montaje_filtro.rowcount()
	if montaje = '' then
		montaje = dw_montaje_filtro.object.filtro[j]
	else
		montaje = montaje +' AND '+ dw_montaje_filtro.object.filtro[j]
	end if
next
if montaje <> '' then
	montaje = consulta_inicial + " AND " + montaje
else
	montaje = consulta_inicial
end if


return montaje


end function

public function string f_construir_consulta ();string cadena

cadena = " SELECT "+&
"	  articulos.codigo    "+&
"	, articulos.descripcion "+& 
"	, articulos.submarcas_codigo "+& 
"	, formatos.abreviado "+&
"	, formatos.ancho "+&
"	, formatos.largo "+&
" 	, articulos.contra_stock "+&
"  	, articulos.lote_minimo as lote_minimo_pzs "+&
"	, (select isnull (sum (	case when vista_venliped.tipo_unidad  = 0  "+&
"							then vista_venliped.cantidad  "+&
"							else  "+&
"								case when almartcajas.piezascaja < 999  "+&
"								then ( ( vista_venliped.cantidad / almartcajas.metroscaja ) * almartcajas.piezascaja )  "+&
"								else   "+&
"									vista_venliped.cantidad / ((formatos.ancho * formatos.largo) /10000 )  "+&
"								END  "+&
"							END), 0 ) "+&
"	from vista_venliped "+&
"	inner join formatos on vista_venliped.empresa = formatos.empresa and vista_venliped.formato = formatos.codigo "+&
"	inner join almartcajas on vista_venliped.empresa = almartcajas.empresa and vista_venliped.articulo = almartcajas.articulo  and vista_venliped.caja = almartcajas.caja  "+&
"	where vista_venliped.articulo =  articulos.codigo and vista_venliped.fpedido >= DATEADD( month, -6, getdate()) ) as ventas_180_pzs  "+&
"	, (select isnull (sum (	case when vista_venliped.tipo_unidad  = 0  "+&
"							then vista_venliped.cantidad  "+&
"							else  "+&
"								case when almartcajas.piezascaja < 999  "+&
"								then ( ( vista_venliped.cantidad / almartcajas.metroscaja ) * almartcajas.piezascaja )  "+&
"								else   "+&
"									vista_venliped.cantidad / ((formatos.ancho * formatos.largo) /10000 )  "+&
"								END  "+&
"							END), 0 )  "+&
"	from vista_venliped "+&
"	inner join formatos on vista_venliped.empresa = formatos.empresa and vista_venliped.formato = formatos.codigo "+&
"	inner join almartcajas on vista_venliped.empresa = almartcajas.empresa and vista_venliped.articulo = almartcajas.articulo  and vista_venliped.caja = almartcajas.caja  "+&
"	where vista_venliped.articulo =  articulos.codigo and vista_venliped.fpedido >= DATEADD( month, -3, getdate()) ) as ventas_90_pzs  "+&
"	, ( select isnull (sum (	CASE WHEN venliped.tipo_unidad  = 0   "+&
"									then venliped.cantidad   "+&
"									ELSE   "+&
"										CASE WHEN almartcajas.piezascaja < 999   "+&
"										THEN ( ( venliped.cantidad / almartcajas.metroscaja ) * almartcajas.piezascaja )   "+&
"										ELSE    "+&
"											venliped.cantidad / ((formatos.ancho * formatos.largo) /10000 )   "+&
"										END   "+&
"									END), 0 )   "+&
"	from venliped   "+&
"	inner join formatos on venliped.empresa = formatos.empresa and venliped.formato = formatos.codigo  "+&
"	inner join venped on venliped.empresa = venped.empresa and venliped.anyo = venped.anyo and venliped.pedido = venped.pedido  "+&
"	inner join almartcajas on venliped.empresa = almartcajas.empresa and venliped.articulo = almartcajas.articulo  and venliped.caja = almartcajas.caja   "+&
"	where venliped.articulo =  articulos.codigo and  venped.es_proforma <> 'S'  ) pedidos_pendientes_pzs	"+&
"	, ( 			SELECT isnull (sum (almacenmovimientos.cantidade - almacenmovimientos.cantidads), 0)	"+&
"					FROM almacenmovimientos 	"+&
"					INNER JOIN almubimapa_codbar ON almacenmovimientos.empresa = almubimapa_codbar.empresa  "+&
"																AND almacenmovimientos.almacen = almubimapa_codbar.almacen "+&
"																AND almacenmovimientos.zona = almubimapa_codbar.zona "+&
"																AND almacenmovimientos.fila = almubimapa_codbar.fila "+&
"																AND almacenmovimientos.altura = almubimapa_codbar.altura "+&
"					WHERE almacenmovimientos.articulo = articulos.codigo 	"+&
"					AND almubimapa_codbar.permitir_reservas = 'S' 	"+&
"					AND almacenmovimientos.calidad = '1') stock_actual_pzs	"+&
"	, ( select isnull(sum ( cantidad ), 0 ) from planificacion where cod_articulo = articulos.codigo ) planificado_pzs "+&
"	, 0 as stock_sugerido_pzs "+&
"	, 0 as stock_minimo_pzs "+&
"  	, articulos.lote_minimo * ((formatos.ancho * formatos.largo) /10000 )  as lote_minimo_m2 "+&
"	, (select isnull (sum (	CASE when vista_venliped.tipo_unidad  = 1  "+&
"									THEN vista_venliped.cantidad  "+&
"									ELSE  "+&
"										vista_venliped.cantidad * ((formatos.ancho * formatos.largo) /10000 )  "+&
"									END), 0 ) "+&
"	from vista_venliped "+&
"	inner join formatos on vista_venliped.empresa = formatos.empresa and vista_venliped.formato = formatos.codigo "+&
"	inner join almartcajas on vista_venliped.empresa = almartcajas.empresa and vista_venliped.articulo = almartcajas.articulo  and vista_venliped.caja = almartcajas.caja  "+&
"	where vista_venliped.articulo =  articulos.codigo and vista_venliped.fpedido >= DATEADD( month, -6, getdate()) ) as ventas_180_m2  "+&
"	, (select isnull (sum (	CASE when vista_venliped.tipo_unidad  = 1  "+&
"									THEN vista_venliped.cantidad  "+&
"									ELSE  "+&
"										vista_venliped.cantidad * ((formatos.ancho * formatos.largo) /10000 )  "+&
"									END), 0 ) "+&
"	from vista_venliped "+&
"	inner join formatos on vista_venliped.empresa = formatos.empresa and vista_venliped.formato = formatos.codigo "+&
"	inner join almartcajas on vista_venliped.empresa = almartcajas.empresa and vista_venliped.articulo = almartcajas.articulo  and vista_venliped.caja = almartcajas.caja  "+&
"	where vista_venliped.articulo =  articulos.codigo and vista_venliped.fpedido >= DATEADD( month, -3, getdate()) ) as ventas_90_m2  "+&
"	, ( select isnull (sum (	CASE WHEN venliped.tipo_unidad  = 1   "+&
"									then venliped.cantidad   "+&
"									ELSE  "+&
"										venliped.cantidad * ((formatos.ancho * formatos.largo) /10000 )  "+&
"									END), 0 )   "+&
"	from venliped   "+&
"	inner join formatos on venliped.empresa = formatos.empresa and venliped.formato = formatos.codigo  "+&
"	inner join venped on venliped.empresa = venped.empresa and venliped.anyo = venped.anyo and venliped.pedido = venped.pedido  "+&
"	inner join almartcajas on venliped.empresa = almartcajas.empresa and venliped.articulo = almartcajas.articulo  and venliped.caja = almartcajas.caja   "+&
"	where venliped.articulo =  articulos.codigo and  venped.es_proforma <> 'S'  ) pedidos_pendientes_m2	"+&
"	, ( 			SELECT isnull (sum ((almacenmovimientos.cantidade - almacenmovimientos.cantidads ) *  ((formatos.ancho * formatos.largo) /10000 ) ), 0)	"+&
"					FROM almacenmovimientos 	"+&
"					INNER JOIN formatos on almacenmovimientos.empresa = formatos.empresa and almacenmovimientos.formato = formatos.codigo "+&
"					INNER JOIN almubimapa_codbar ON almacenmovimientos.empresa = almubimapa_codbar.empresa  "+&
"																AND almacenmovimientos.almacen = almubimapa_codbar.almacen "+&
"																AND almacenmovimientos.zona = almubimapa_codbar.zona "+&
"																AND almacenmovimientos.fila = almubimapa_codbar.fila "+&
"																AND almacenmovimientos.altura = almubimapa_codbar.altura "+&
"					WHERE almacenmovimientos.articulo = articulos.codigo 	"+&
"					AND almubimapa_codbar.permitir_reservas = 'S' 	"+&
"					AND almacenmovimientos.calidad = '1') AS stock_actual_m2	"+&
"	, ( select isnull(sum ( cantidad *  ((formatos.ancho * formatos.largo) /10000 ) ) , 0 ) "+&
"    from planificacion "+&
"	inner join formatos on planificacion.empresa = formatos.empresa and planificacion.formato = formatos.codigo "+&
"	where cod_articulo = articulos.codigo ) planificado_m2 "+&
"	, 0 as stock_sugerido_m2 "+&
"	, 0 as stock_minimo_m2 "+&
"   , 0 necesidad_stock_pzs "+&
"   , 0 sugerido2_pzs "+&
"   , '' marcado "+&
"   , 0 media_mensual_m2 "+&
"	FROM articulos  "+&
"	LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo  "+&
"	INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo  "+&
"	WHERE articulos.contra_stock = 'S'  "+&
" 	AND articulos.promocion = 'N'  "+&
"	AND articulos.uso = '3'  "+&
"	AND articulos.fecha_anulado is NULL "+&
"	AND articulos.empresa = '"+codigo_empresa+"' "

//"	WHERE articulos.familia = '2' "+&


return cadena




/*

cadena = " SELECT "+&
"	  articulos.codigo    "+&
"	, articulos.descripcion "+& 
"	, articulos.submarcas_codigo "+& 
"	, formatos.abreviado "+&
"	, formatos.ancho "+&
"	, formatos.largo "+&
" 	, articulos.contra_stock "+&
"  	, articulos.lote_minimo as lote_minimo_pzs "+&
"	, (select isnull (sum (	case when venlifac.tipo_unidad  = 0  "+&
"							then venlifac.cantidad  "+&
"							else  "+&
"								case when almartcajas.piezascaja < 999  "+&
"								then ( ( venlifac.cantidad / almartcajas.metroscaja ) * almartcajas.piezascaja )  "+&
"								else   "+&
"									venlifac.cantidad / ((formatos.ancho * formatos.largo) /10000 )  "+&
"								END  "+&
"							END), 0 ) "+&
"	from venlifac "+&
"	inner join formatos on venlifac.empresa = formatos.empresa and venlifac.formato = formatos.codigo "+&
"	inner join almartcajas on venlifac.empresa = almartcajas.empresa and venlifac.articulo = almartcajas.articulo  and venlifac.caja = almartcajas.caja  "+&
"	where venlifac.articulo =  articulos.codigo and venlifac.ffactura >= DATEADD( month, -6, getdate()) ) as ventas_180_pzs  "+&
"	, (select isnull (sum (	case when venlifac.tipo_unidad  = 0  "+&
"							then venlifac.cantidad  "+&
"							else  "+&
"								case when almartcajas.piezascaja < 999  "+&
"								then ( ( venlifac.cantidad / almartcajas.metroscaja ) * almartcajas.piezascaja )  "+&
"								else   "+&
"									venlifac.cantidad / ((formatos.ancho * formatos.largo) /10000 )  "+&
"								END  "+&
"							END), 0 )  "+&
"	from venlifac "+&
"	inner join formatos on venlifac.empresa = formatos.empresa and venlifac.formato = formatos.codigo "+&
"	inner join almartcajas on venlifac.empresa = almartcajas.empresa and venlifac.articulo = almartcajas.articulo  and venlifac.caja = almartcajas.caja  "+&
"	where venlifac.articulo =  articulos.codigo and venlifac.ffactura >= DATEADD( month, -3, getdate()) ) as ventas_90_pzs  "+&
"	, ( select isnull (sum (	CASE WHEN venliped.tipo_unidad  = 0   "+&
"									then venliped.cantidad   "+&
"									ELSE   "+&
"										CASE WHEN almartcajas.piezascaja < 999   "+&
"										THEN ( ( venliped.cantidad / almartcajas.metroscaja ) * almartcajas.piezascaja )   "+&
"										ELSE    "+&
"											venliped.cantidad / ((formatos.ancho * formatos.largo) /10000 )   "+&
"										END   "+&
"									END), 0 )   "+&
"	from venliped   "+&
"	inner join formatos on venliped.empresa = formatos.empresa and venliped.formato = formatos.codigo  "+&
"	inner join venped on venliped.empresa = venped.empresa and venliped.anyo = venped.anyo and venliped.pedido = venped.pedido  "+&
"	inner join almartcajas on venliped.empresa = almartcajas.empresa and venliped.articulo = almartcajas.articulo  and venliped.caja = almartcajas.caja   "+&
"	where venliped.articulo =  articulos.codigo and  venped.es_proforma <> 'S'  ) pedidos_pendientes_pzs	"+&
"	, ( select isnull (sum (almacenmovimientos.cantidade - almacenmovimientos.cantidads), 0)	"+&
"	from almacenmovimientos 	"+&
"	where almacenmovimientos.articulo = articulos.codigo 	"+&
"	and almacenmovimientos.calidad = '1') stock_actual_pzs	"+&
"	, ( select isnull(sum ( cantidad ), 0 ) from planificacion where cod_articulo = articulos.codigo ) planificado_pzs "+&
"	, 0 as stock_sugerido_pzs "+&
"	, 0 as stock_minimo_pzs "+&
"  	, articulos.lote_minimo * ((formatos.ancho * formatos.largo) /10000 )  as lote_minimo_m2 "+&
"	, (select isnull (sum (	CASE when venlifac.tipo_unidad  = 1  "+&
"									THEN venlifac.cantidad  "+&
"									ELSE  "+&
"										venlifac.cantidad * ((formatos.ancho * formatos.largo) /10000 )  "+&
"									END), 0 ) "+&
"	from venlifac "+&
"	inner join formatos on venlifac.empresa = formatos.empresa and venlifac.formato = formatos.codigo "+&
"	inner join almartcajas on venlifac.empresa = almartcajas.empresa and venlifac.articulo = almartcajas.articulo  and venlifac.caja = almartcajas.caja  "+&
"	where venlifac.articulo =  articulos.codigo and venlifac.ffactura >= DATEADD( month, -6, getdate()) ) as ventas_180_m2  "+&
"	, (select isnull (sum (	CASE when venlifac.tipo_unidad  = 1  "+&
"									THEN venlifac.cantidad  "+&
"									ELSE  "+&
"										venlifac.cantidad * ((formatos.ancho * formatos.largo) /10000 )  "+&
"									END), 0 ) "+&
"	from venlifac "+&
"	inner join formatos on venlifac.empresa = formatos.empresa and venlifac.formato = formatos.codigo "+&
"	inner join almartcajas on venlifac.empresa = almartcajas.empresa and venlifac.articulo = almartcajas.articulo  and venlifac.caja = almartcajas.caja  "+&
"	where venlifac.articulo =  articulos.codigo and venlifac.ffactura >= DATEADD( month, -3, getdate()) ) as ventas_90_m2  "+&
"	, ( select isnull (sum (	CASE WHEN venliped.tipo_unidad  = 1   "+&
"									then venliped.cantidad   "+&
"									ELSE  "+&
"										venliped.cantidad * ((formatos.ancho * formatos.largo) /10000 )  "+&
"									END), 0 )   "+&
"	from venliped   "+&
"	inner join formatos on venliped.empresa = formatos.empresa and venliped.formato = formatos.codigo  "+&
"	inner join venped on venliped.empresa = venped.empresa and venliped.anyo = venped.anyo and venliped.pedido = venped.pedido  "+&
"	inner join almartcajas on venliped.empresa = almartcajas.empresa and venliped.articulo = almartcajas.articulo  and venliped.caja = almartcajas.caja   "+&
"	where venliped.articulo =  articulos.codigo and  venped.es_proforma <> 'S'  ) pedidos_pendientes_m2	"+&
"	, ( select isnull (sum ((almacenmovimientos.cantidade - almacenmovimientos.cantidads ) *  ((formatos.ancho * formatos.largo) /10000 ) ), 0)	"+&
"	from almacenmovimientos 	"+&
"	inner join formatos on almacenmovimientos.empresa = formatos.empresa and almacenmovimientos.formato = formatos.codigo "+&
"	where almacenmovimientos.articulo = articulos.codigo 	"+&
"	and almacenmovimientos.calidad = '1') stock_actual_m2	"+&
"	, ( select isnull(sum ( cantidad *  ((formatos.ancho * formatos.largo) /10000 ) ) , 0 ) "+&
"    from planificacion "+&
"	inner join formatos on planificacion.empresa = formatos.empresa and planificacion.formato = formatos.codigo "+&
"	where cod_articulo = articulos.codigo ) planificado_m2 "+&
"	, 0 as stock_sugerido_m2 "+&
"	, 0 as stock_minimo_m2 "+&
"   , 0 necesidad_stock_pzs "+&
"   , 0 sugerido2_pzs "+&
"   , '' marcado "+&
"   , 0 media_mensual_m2 "+&
"	FROM articulos  "+&
"	LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo  "+&
"	INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo  "+&
"	WHERE articulos.contra_stock = 'S'  "+&
" 	AND articulos.promocion = 'N'  "+&
"	AND articulos.uso = '3'  "+&
"	AND articulos.fecha_anulado is NULL "+&
"	AND articulos.empresa = '"+codigo_empresa+"' "

//"	WHERE articulos.familia = '2' "+&


return cadena




*/
end function

public subroutine f_cargar_datawindow (string new_sql);datastore registros

dw_datos.reset()

f_cargar_cursor_nuevo (new_sql, registros)

if registros.rowcount() > 0 then
	dw_datos.object.data = registros.object.data
end if

destroy registros

if cbx_stock_sugerido.checked then
	f_calculo_stock_sugerido()
end if
end subroutine

public subroutine f_calculo_stock_sugerido ();// Cálculo stock sugerido utilizando la desviación estándar para descartar valores extremos. 
// Calculamos el consumo mensual para luego multiplicarlo por el número de meses que queremos tener como stock.
// Todos los cáclulos los haremos para la calidad std.

dec pedidos_pendientes_pzs, planificado_pzs, stock_actual_pzs, stock_sugerido_pzs, stock_min, pedido_min
dec necesidad_pzs,  disponible_pzs
dec consumo_mensual_pzs
int meses_stock, meses_stock_min, total_meses
long i
string articulo
integer mes, anyo
datetime fecha_final

meses_stock = integer (ddlb_meses_de_stock.text)
meses_stock_min = integer (ddlb_meses_stock_min.text)

for i = 1 to dw_datos.rowcount()
	articulo = dw_datos.object.cod_articulo[i]
	
	anyo = year(today())
	mes = month(today())
	
	fecha_final = datetime(date ("1/"+string (mes)+"/"+ string (anyo)))
	fecha_final = datetime( RelativeDate ( date(fecha_final), -1 ))
	
	SELECT datediff(month, min(ffactura), :fecha_final )
	INTO :total_meses
	FROM venlifac
	WHERE empresa = :codigo_empresa
	AND articulo = :articulo;	
	
	if total_meses > 3 then
		consumo_mensual_pzs = f_consumo_mensual_desviacion_std (articulo, total_meses, fecha_final )
	else
		consumo_mensual_pzs = 0
	end if
	
	dw_datos.object.media_mensual_m2[i] = consumo_mensual_pzs * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
	
	pedidos_pendientes_pzs = dw_datos.object.pedidos_pendientes_pzs[i]
	planificado_pzs = dw_datos.object.planificado_pzs[i]
	stock_actual_pzs = dw_datos.object.stock_actual_pzs[i]
	pedido_min = dw_datos.object.lote_minimo_pzs[i]
	disponible_pzs = planificado_pzs + stock_actual_pzs

	stock_min = consumo_mensual_pzs * dec (ddlb_meses_stock_min.text)
	necesidad_pzs = pedidos_pendientes_pzs + ( consumo_mensual_pzs * dec (ddlb_meses_de_stock.text))
	
	dw_datos.object.stock_minimo_pzs[i] = stock_min
	dw_datos.object.stock_minimo_m2[i] = stock_min * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
	
	
	/*
	
	IF (necesidad_pzs > disponible_pzs  AND disponible_pzs - pedidos_pendientes_pzs < stock_min) THEN
		IF ( total_meses > 0 AND total_meses <= 3)  THEN		
			dw_datos.object.stock_sugerido_pzs[i] = pedido_min
			dw_datos.object.stock_sugerido_m2[i] = pedido_min  * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
		ELSE
			IF (necesidad_pzs - disponible_pzs < pedido_min)  THEN
				dw_datos.object.stock_sugerido_pzs[i] = pedido_min
				dw_datos.object.stock_sugerido_m2[i] = pedido_min  * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
			ELSE
				dw_datos.object.stock_sugerido_pzs[i] =  necesidad_pzs - disponible_pzs  
				dw_datos.object.stock_sugerido_m2[i] = ( necesidad_pzs - disponible_pzs ) * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
			END IF
		END IF
	END IF
	
	*/
IF (necesidad_pzs > disponible_pzs  AND disponible_pzs - necesidad_pzs < stock_min) THEN
		IF ( total_meses > 0 AND total_meses <= 3)  THEN		
			if pedidos_pendientes_pzs - disponible_pzs > pedido_min then
				dw_datos.object.stock_sugerido_pzs[i] = pedidos_pendientes_pzs
				dw_datos.object.stock_sugerido_m2[i] = pedidos_pendientes_pzs * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
			else
				dw_datos.object.stock_sugerido_pzs[i] = pedido_min
				dw_datos.object.stock_sugerido_m2[i] = pedido_min * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
			end if
		ELSE
			IF (necesidad_pzs - disponible_pzs < pedido_min)  THEN
				dw_datos.object.stock_sugerido_pzs[i] = pedido_min
				dw_datos.object.stock_sugerido_m2[i] = pedido_min * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
			ELSE
				dw_datos.object.stock_sugerido_pzs[i] =  necesidad_pzs - disponible_pzs  
				dw_datos.object.stock_sugerido_m2[i] = ( necesidad_pzs - disponible_pzs ) * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
			END IF
		END IF

ELSE	
		IF (planificado_pzs <> 0) then
			
			IF planificado_pzs > -(necesidad_pzs - disponible_pzs)  THEN
			
				dw_datos.object.stock_sugerido_pzs[i] =  necesidad_pzs - disponible_pzs  
				dw_datos.object.stock_sugerido_m2[i] = ( necesidad_pzs - disponible_pzs ) * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 )
				
			ELSE
				
				dw_datos.object.stock_sugerido_pzs[i] = -(planificado_pzs)
				dw_datos.object.stock_sugerido_m2[i] = -(( planificado_pzs ) * ( ( dw_datos.object.ancho[i] * dw_datos.object.largo[i] ) / 10000 ))
				
			END IF
		
	ELSE
			
			dw_datos.object.stock_sugerido_pzs[i] =  0
			dw_datos.object.stock_sugerido_m2[i] =0
			
		END IF
		
	END IF
	
	dw_datos.object.necesidad_pzs[i] = necesidad_pzs

next




end subroutine

public function decimal f_consumo_mensual_desviacion_std (string arg_articulo, integer total_meses, datetime fecha_final);dec consumo_mensual, media, suma_valores, suma_desviaciones, desviacion_estandar, suma_valores2 , suma_prueba, n2
datetime ffactura
integer  i,  n
dec valores[]
string sel
datastore datos

//anyo = year(today())
//mes = month(today())
//
//fecha_final = datetime(date ("1/"+string (mes)+"/"+ string (anyo)))
//fecha_final = datetime( RelativeDate ( date(fecha_final), -1 ))
//
//SELECT datediff(month, min(ffactura), :fecha_final )
//INTO :total_meses
//FROM venlifac
//WHERE empresa = :codigo_empresa
//AND articulo = :arg_articulo;

total_meses = total_meses + 1
if total_meses >= 12 then
	n = 12
else
	n = total_meses 
end if


sel = " SELECT year(vista_venliped.fpedido), month (vista_venliped.fpedido) "+&
		"	, sum(CASE WHEN vista_venliped.tipo_unidad = 0 "+&
		" 				THEN cantidad   "+&
		" 				ELSE cantidad / ((formatos.ancho * formatos.largo) /10000 )  "+&
		" 			END ) as metros "+&
		" FROM vista_venliped  "+&
		" INNER JOIN articulos on vista_venliped.empresa = articulos.empresa and vista_venliped.articulo = articulos.codigo  "+&
		" INNER JOIN formatos on articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo  "+&
		" WHERE articulos.codigo = '"+arg_articulo+"'  "+&
		" AND vista_venliped.empresa = '"+codigo_empresa+"'  "+&
		" AND vista_venliped.fpedido >= dateadd ( year, -1, '"+string(date(fecha_final))+"' ) "+&
		" AND vista_venliped.fpedido  <= '"+string(date(fecha_final))+"' "+&
		" GROUP BY year(vista_venliped.fpedido),  month (vista_venliped.fpedido) "+&
		" ORDER BY  year(vista_venliped.fpedido) asc, month (vista_venliped.fpedido) ASC "

f_cargar_cursor_nuevo (sel, datos)

suma_valores = 0
media = 0
suma_desviaciones  = 0
if total_meses > 3 then
	// Cálculo de la media
//	if n<> 0 then
//		media = dec(datos.describe("evaluate('sum(metros for all)', 1)") )/ n 
//	end if
	
	for i = 1 to datos.rowcount()  
		valores[i] = datos.object.metros[i]
		suma_valores = suma_valores + datos.object.metros[i]		
	next
	if n <> 0 then
		media = suma_valores / n
	end if
	
//	if n<> 0 then
//		desviacion_estandar = sqrt (dec(datos.describe("evaluate('sum( ( metros - "+string(media)+") ^2 for all)', 1)") ) / n )
//	end if

	for i = 1 to datos.rowcount()  
		suma_desviaciones =  suma_desviaciones + (datos.object.metros[i] - media)^2
	next
	if n <> 0 then 	
		desviacion_estandar = sqrt(suma_desviaciones / n) 
	end if

// Descartamos los valores extremos (media +- desviación estandar)
//n = 	dec(datos.describe("evaluate('sum( if ( metros < "+string(media + desviacion_estandar)+" and metros > "+string(media - desviacion_estandar)+" , 1, 0)      for all)', 1)") ) 
//
//if n<> 0 then
//	consumo_mensual = 	dec(datos.describe("evaluate('sum( if ( metros < "+string(media + desviacion_estandar)+" and metros > "+string(media - desviacion_estandar)+" , metros, 0)      for all)', 1)") ) / n
//end if


	suma_valores2  = 0
	for i = 1 to datos.rowcount()  
		if datos.object.metros[i] < media + desviacion_estandar and datos.object.metros[i] > media - desviacion_estandar then
			suma_valores2 = suma_valores2 + datos.object.metros[i]
		else
			n = n - 1
		end if
		if n<> 0 then
			consumo_mensual = suma_valores2 / n
		end if
	next
end if	
destroy datos
return consumo_mensual
end function

public function integer f_planificar_wow ();// Devuelve 0 si todo ha ido bien

date v_f_entrega
boolean bien = True
dec i,j, total_lineaspedido, total_operaciones, ordent, v_cantidad, v_ordenoperacion
long v_pedido, v_linped, v_anyo, maximo_orden, v_factor
string v_operacion, tipooperacion, articulo, v_base, v_formato, v_version = "1", v_lineaprod = "1", v_reajuste = "N"
string v_descripcion_formato, sel
datawindow DW
str_escandallo vector_escandallo[300]
integer  k, indice , m
string v_g2, v_uso
decimal factor_Acumulado = 1
long cantidad_pedido
time hora_inicio
long segundos, minutos, total_lineas
integer nivel
int  li_calibre
long ll_lote

nivel = 0

hora_inicio = now()
minutos = 0

DW = dw_datos

st_mensajes.visible = true

if MessageBox("Atención", "¿Desea generar nuevas OT´s", Exclamation!, YesNo!, 2) = 2 then
	return 1
else
	
	for i = 1 to dw_datos.Rowcount() 		
		if dw_datos.object.sugerido2_pzs[i] > 0 and not isnull (dw_datos.object.sugerido2_pzs[i]) then
			v_cantidad = dw_datos.object.sugerido2_pzs[i]
		else
			v_cantidad = dw_datos.object.stock_sugerido_pzs[i]
		end if
		
		if dw_datos.object.marcado[i] = 'S' and v_cantidad > 0 then   //and  ( ( dw_datos.object.sugerido[i] > 0 and not isnull (dw_datos.object.sugerido[i] ) ) or  ( dw_datos.object.sugerido2[i] > 0 and not isnull (dw_datos.object.sugerido2[i] ) ) ) 
			st_mensajes.text = " Generando pedido "+string(i)+" de "+ string (dw_datos.object.total_marcados[i])+".  Quedan "+string(minutos)+ " minutos."
			articulo = dw_datos.object.cod_articulo[i]
		
			v_pedido = 0
			v_linped = f_numero_linea_pedido_interno()
			v_anyo = year(today())
				
			v_operacion = '';
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// Recorremos recursivamente el árbol del artículo y llamamos a la función generar OT´s para cada nodo
			
			cantidad_pedido = v_cantidad 
			indice = 1
			for m = 1 to 300
				setnull(vector_Escandallo[m].articulo)
				setnull(vector_Escandallo[m].version)
				setnull(vector_Escandallo[m].factor)
			next
			if articulo <> '' and not isnull(articulo) then
				v_uso = ""
				SELECT uso INTO :v_uso FROM articulos WHERE empresa = :codigo_empresa AND codigo = :articulo;

//				if cbx_promo.checked then
//					f_escandallo_factores_promocion(vector_Escandallo, articulo, indice, factor_Acumulado, nivel)		
//				else
					if v_uso = '1' then
						f_escandallo_factores_con_sin_base(vector_Escandallo, articulo, indice, factor_Acumulado, nivel, true)		
					else
						f_escandallo_factores_con_sin_base(vector_Escandallo, articulo, indice, factor_Acumulado, nivel, false)		
					end if 
//				end if

				ll_lote    = f_contador_lotes("contador_lotes",1) //El segundo parametro es el valor inicial en caso de que no exista el contador
				li_calibre = 5	
				for k=1 to indice
					
					select g2
					into :v_g2
					from art_codestadistico
					where codigo = :vector_Escandallo[k].articulo
					and empresa = :codigo_empresa;
					
					// Debe permitir que se programen las bases si hay pedido.
					//if (v_g2 <> "B" and v_g2 <> "Z" and v_g2 <> "N") or isnull(v_g2) or (articulo_linea =  vector_Escandallo[k].articulo) then //Error. El codigo estadistico no es significativo para saber si es base. Controlado en f_escandallo_factores_con_sin_base y usar funcion ftc_articulo_base()
						if vector_Escandallo[k].factor <> 0 and not isnull(vector_Escandallo[k].factor) then
							v_cantidad = cantidad_pedido / vector_Escandallo[k].factor
						else
							v_cantidad = cantidad_pedido
						end if
						f_generar_ots(vector_Escandallo[k].articulo, v_version, v_operacion, v_pedido, v_linped, &
										  v_anyo, v_cantidad, v_f_entrega, v_reajuste, articulo, vector_escandallo[k].factor, vector_Escandallo[k].nivel,ll_lote,li_calibre) 
						
					//end if
				next
			end if
			commit using SQLCA;
			// fin del recorrido del árbol
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			segundos = secondsafter ( hora_inicio, now())
			minutos =  ( (segundos / i) * (total_lineas - i) ) / 60
		end if		
	next

end if

st_mensajes.visible = false

return 0;
end function

on wtc_calculo_necesidades.create
int iCurrent
call super::create
this.ddlb_meses_de_stock=create ddlb_meses_de_stock
this.cbx_stock_sugerido=create cbx_stock_sugerido
this.ddlb_meses_stock_min=create ddlb_meses_stock_min
this.ddlb_rotura=create ddlb_rotura
this.dw_graf_ventas_mes=create dw_graf_ventas_mes
this.cbx_grafica=create cbx_grafica
this.st_mensajes=create st_mensajes
this.pb_2=create pb_2
this.dw_export_excel=create dw_export_excel
this.pb_3=create pb_3
this.ddlb_sugerido=create ddlb_sugerido
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_excel=create gb_excel
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_meses_de_stock
this.Control[iCurrent+2]=this.cbx_stock_sugerido
this.Control[iCurrent+3]=this.ddlb_meses_stock_min
this.Control[iCurrent+4]=this.ddlb_rotura
this.Control[iCurrent+5]=this.dw_graf_ventas_mes
this.Control[iCurrent+6]=this.cbx_grafica
this.Control[iCurrent+7]=this.st_mensajes
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.dw_export_excel
this.Control[iCurrent+10]=this.pb_3
this.Control[iCurrent+11]=this.ddlb_sugerido
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_3
this.Control[iCurrent+15]=this.gb_excel
this.Control[iCurrent+16]=this.gb_4
end on

on wtc_calculo_necesidades.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_meses_de_stock)
destroy(this.cbx_stock_sugerido)
destroy(this.ddlb_meses_stock_min)
destroy(this.ddlb_rotura)
destroy(this.dw_graf_ventas_mes)
destroy(this.cbx_grafica)
destroy(this.st_mensajes)
destroy(this.pb_2)
destroy(this.dw_export_excel)
destroy(this.pb_3)
destroy(this.ddlb_sugerido)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_excel)
destroy(this.gb_4)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
ddlb_meses_de_stock.text = '3'
ddlb_meses_stock_min.text = '2'
ddlb_sugerido.text = 'Todos'

/*			  
sql_inicial = " SELECT DISTINCT articulos.empresa,    "+&
"	articulos.codigo,    "+&
"	articulos.descripcion,   "+& 
"	articulos.cliente,    "+&
"	articulos.familia,    "+&
"	m2_sugeridos, "+&
"	articulos.lote_minimo, "+&
"	articulos.stock_min,    "+&
"	articulos.stocksugerido,    "+&
"	familias.descripcion,    "+&
"	formatos.abreviado, "+&
"	formatos.ancho, "+&
"	formatos.largo "+&
"	FROM articulos  "+&
"	LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo  "+&
"	INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo  "+&
"	WHERE articulos.empresa = '"+codigo_empresa+"' "
*/
end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_calculo_necesidades
integer x = 6473
integer y = 156
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_calculo_necesidades
integer x = 6715
integer y = 156
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_calculo_necesidades
integer x = 7822
integer y = 128
end type

event pb_imprimir::clicked;if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if

end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_calculo_necesidades
integer x = 7977
integer y = 128
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_calculo_necesidades
integer width = 8379
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_calculo_necesidades
integer x = 7406
integer y = 128
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql
long fila

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)

f_cargar_datawindow (new_sql)

dw_datos.retrieve()

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 3108
	dw_montaje_filtro.height = 225
end if

dw_datos.setfocus()
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_calculo_necesidades
integer x = 8133
integer y = 128
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_calculo_necesidades
integer x = 7255
integer y = 128
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, filas
string cadena_or, cadena_or_visible
string new_sql, filtro, filter
boolean crear_filtro
datastore registros

sql_inicial = f_construir_consulta ()

// Consturimos el filtro de WHERE
if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Artículo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Artículo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 

		case "Molde"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.plato_inf = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Plato = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.plato_inf = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 

		case "Molde (Código)"
			if cadena_or = '' then
				cadena_or = " articulos.molde "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Molde "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if

		case "Submarca"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.submarcas_codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Submarca = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.submarcas_codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		
		
		case "Artículo (Código)"
			if cadena_or = '' then
				cadena_or = " articulos.codigo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Artículo (Código) "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
			
		case "Promoción"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " articulos.promocion = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = "Promoción = " + lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR articulos.promocion = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = cadena_or_visible+", Promoción = "+lb_lista.Text (k)
					end if
				end if
			next
//		case "Familia"
//			for i = 1 to dw_filtro.rowcount()
//				if dw_filtro.IsSelected (i)  then
//					if cadena_or = '' then
//						cadena_or = " EXISTS (SELECT * FROM venliped vfam WHERE vfam.empresa = venliped.empresa AND vfam.anyo = venliped.anyo AND vfam.pedido = venliped.pedido AND vfam.familia = '"+dw_filtro.object.#1[i]+"')"
//						cadena_or_visible = " Familia = "+dw_filtro.object.#2[i]
//					else
//						cadena_or = cadena_or+" OR EXISTS (SELECT * FROM venliped vfam WHERE vfam.empresa = venliped.empresa AND vfam.anyo = venliped.anyo AND vfam.pedido = venliped.pedido AND vfam.familia = '"+dw_filtro.object.#1[i]+"')"
//						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
//					end if
//				end if
//			next 	

		case "Familia"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.familia = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Familia = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.familia = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 

//		case "Largo"
//			if cadena_or = '' then
//				cadena_or = " formatos.largo "+ddlb_operador.text+" "+sle_valor1.text+" "
//				cadena_or_visible = " Largo "+ddlb_operador.text+" "+sle_valor1.text
//			end if
//			
//		case "Ancho"
//			if cadena_or = '' then
//				cadena_or = " formatos.ancho "+ddlb_operador.text+" "+sle_valor1.text+" "
//				cadena_or_visible = " Ancho "+ddlb_operador.text+" "+sle_valor1.text
//			end if
			

//		case "Uso"
//			for i = 1 to dw_filtro.rowcount()
//				if dw_filtro.IsSelected (i)  then
//					if cadena_or = '' then
//						cadena_or = " articulos.uso = '"+dw_filtro.object.#1[i]+"' "
//						cadena_or_visible = " Uso = "+dw_filtro.object.#2[i]
//					else
//						cadena_or = cadena_or+" OR articulos.uso = '"+dw_filtro.object.#1[i]+"' "
//						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
//					end if
//				end if
//			next 
//			
//		case "Cliente"
//			for i = 1 to dw_filtro.rowcount()
//				if dw_filtro.IsSelected (i)  then
//					if cadena_or = '' then
//						cadena_or = " articulos.cliente = '"+dw_filtro.object.#1[i]+"' "
//						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
//					else
//						cadena_or = cadena_or+" OR articulos.cliente = '"+dw_filtro.object.#1[i]+"' "
//						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
//					end if
//				end if
//			next 
			
	end choose
	
	
	// Comprobamos que rellene algo en los objetos de filtro
	crear_filtro = false
	if ddlb_campo.text <> '' and ddlb_operador.text <> '' then
		if dw_filtro.visible then
			if dw_filtro.GetSelectedRow(0) >0 then
				crear_filtro = true
			end if
		end if
		if em_fecha1.visible then
			if not isnull (em_fecha1) and em_fecha1.text <> '' then
				crear_filtro = true
			end if
		end if
		if sle_valor1.visible then
			if sle_valor1.text <> '' then
				crear_filtro = true
			end if
		end if
	
		if lb_lista.visible then
			if lb_lista.selectedindex() <> -1 then
				crear_filtro = true
			end if
		end if
		
	end if
	
	if crear_filtro then
		if cadena_or <> '' then
			cadena_or = " ( "+cadena_or+" ) "
			fila = dw_montaje_filtro.insertrow(0)
			dw_montaje_filtro.object.filtro[fila] = cadena_or
			dw_montaje_filtro.object.linea[fila] = cadena_or_visible
			
			new_sql = f_montar_filtro(sql_inicial)
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		end if
	else
		new_sql = sql_inicial
	end if

	f_cargar_datawindow (new_sql)
	
	filas = dw_datos.retrieve()
	
	em_fecha1.visible = false
	sle_valor1.visible = false
	dw_filtro.visible = false
	pb_buscar.visible = false
	sle_texto.visible = false
	lb_lista.visible = false
	
	sle_texto.text = ''
	
	sle_valor1.text = ''
	dw_filtro.reset()
	ddlb_campo.selectitem(0) 
	ddlb_operador.selectitem(0) 
	
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
	end if
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
	
else
	new_sql =  f_montar_filtro(sql_inicial)
	
	f_cargar_datawindow (new_sql)
	
	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
	
end if

if ddlb_sugerido.text = "Positivos" then
		
	filter="stock_sugerido_m2 > 0"
		
elseif ddlb_sugerido.text = "Negativos" then
		
	filter="stock_sugerido_m2 < 0"
		
end if

if filter <> "" then
	
	dw_datos.setfilter(filter)
	dw_datos.filter()
	
end if



end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_calculo_necesidades
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_calculo_necesidades
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Artículo","Artículo (Código)","Submarca","Molde","Molde (Código)","Familia"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()
dw_filtro.width = 1673

CHOOSE CASE ddlb_campo.text
	CASE "Artículo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		dw_filtro.width = 2200
		consulta = "Select codigo as Código, descripcion as Descripción from articulos where empresa = '"+codigo_empresa+"' AND uso = '3' and promocion = 'N' and familia = '2' "

	CASE "Submarca"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = " SELECT codigo AS Código,  descripcion as Descripción FROM submarcas WHERE empresa = '"+codigo_empresa+"' AND familias_codigo = '2' AND marcas_codigo = '1' "

	CASE "Molde"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		dw_filtro.width = 3000
		consulta = 	" SELECT prodplatos.codigo as Plato ,  prodmoldes.descripcion as Molde, Prodmoldes.codigo as Molde, prodplatos.descripcion as Plato "+&
						" FROM prodplatos "+&
						" INNER JOIN prodmoldes on prodplatos.empresa = prodmoldes.empresa and prodplatos.molde = prodmoldes.codigo  "+&
						" WHERE tipo = 'Inferior' "+&
						" AND prodplatos.empresa = '"+codigo_empresa+"' "+&
						" ORDER BY prodmoldes.descripcion, prodplatos.descripcion "
		
	CASE "Molde (Código)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
//		dw_filtro.width = 3000
//		consulta = 	" SELECT prodplatos.codigo as Plato, Prodmoldes.codigo as Molde ,  prodmoldes.descripcion as Molde, prodplatos.descripcion as Plato "+&
//						" FROM prodplatos "+&
//						" INNER JOIN prodmoldes on prodplatos.empresa = prodmoldes.empresa and prodplatos.molde = prodmoldes.codigo  "+&
//						" WHERE tipo = 'Inferior' "+&
//						" AND prodplatos.empresa = '"+codigo_empresa+"' "+&
//						" ORDER BY convert(integer, prodmoldes.codigo) , prodplatos.descripcion "
		
	CASE "Cliente"
		
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where empresa = '"+codigo_empresa+"' AND tipoter = 'C' "
		
	CASE "Artículo (Código)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
	
	CASE "Promoción"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("S")
		lb_lista.AddItem ("N")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
	CASE "Familia"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select familias.codigo as Código, familias.descripcion as Descripción from familias where familias.empresa = '"+codigo_empresa+"' order by familias.descripcion ASC"

	
END CHOOSE


//Creación del data window de búsqueda
new_syntax = SQLCA.SyntaxFromSQL(consulta, 'Style(Type=Grid)', error_syntaxfromSQL)

IF Len(error_syntaxfromSQL) > 0 THEN
	// Display errors
	mensaje_error = "Error en la consulta de la búsqueda. Avise al administrador."+error_syntaxfromSQL
ELSE
	// Generate new DataWindow
	dw_filtro.Create(new_syntax, error_create)
	IF Len(error_create) > 0 THEN
		mensaje_error  = "Error en la creación del DW de búsqueda. Avise al administrador."+error_create
	END IF
END IF

//dw_filtro.visible = true
dw_filtro.SetTransObject(SQLCA)
dw_filtro.Retrieve(codigo_empresa)

end event

type dw_datos from wt_consultas_padre`dw_datos within wtc_calculo_necesidades
integer y = 524
integer width = 8421
integer height = 3404
integer taborder = 60
string dataobject = "dwtc_calculo_necesidades"
end type

event dw_datos::itemchanged;call super::itemchanged;/*
String articulo
Dec stock_min, stocksugerido, m2_sugeridos, lote_minimo
dec ancho, largo, piezas

if row > 0 then
	articulo = this.object.codigo[row]
	ancho = this.object.formatos_ancho[row]
	largo = this.object.formatos_largo[row]

	if dwo.name = "m2_sugeridos" then
		if ancho > 0 and largo > 0 then
			piezas = dec(data) / ( ancho * largo / 10000 )
			
			// Esto es para que la cantidad de piezas sea múltiplo de 250 (250, 500, 750, .......) redondeando al alza.
			if mod (piezas , 250) <> 0 then
				piezas = (truncate ( (piezas / 250 ), 0 ) + 1 ) * 250
			end if
			this.object.articulos_lote_minimo[row] = 	piezas
		end if

		m2_sugeridos = this.object.m2_sugeridos[row] 
	end if


	if dwo.name = "stock_min"   then
		stock_min = Dec(data)
	else
		stock_min = this.object.stock_min[row]
	
	end if

	if dwo.name = "stocksugerido" then
		stocksugerido = Dec(data)
	else
		stocksugerido = this.object.stocksugerido[row]
	end if

	if dwo.name = "articulos_lote_minimo" then
		lote_minimo = Dec(data)
		m2_sugeridos = lote_minimo  * ancho * largo / 10000
		this.object.m2_sugeridos[row] = m2_sugeridos
	else
		lote_minimo = this.object.articulos_lote_minimo[row]
	end if

end if

/*
UPDATE articulos SET stock_min = :stock_min, stocksugerido = :stocksugerido , m2_sugeridos = :m2_sugeridos, lote_minimo = :lote_minimo
WHERE empresa = :codigo_empresa AND codigo = :articulo using sqlca;
if sqlca.sqlcode = 0 then
	commit using sqlca;
else
	rollback using sqlca;
end if

*/

*/
end event

event dw_datos::clicked;call super::clicked;int i

if dwo.name = 't_articulo' then
	this.SetSort("articulos_descripcion A")
	this.Sort()
end if

if dwo.name = 'plan_sug_t' then
	this.SetSort("pla_sug D")
	this.Sort()
end if

if dwo.name = 'formato t' then
	this.SetSort("formatos_abreviado A")
	this.Sort()
end if	             

if dwo.name = 'lote_minimo_pzs_t' then
	this.SetSort("lote_minimo_pzs D")
	this.Sort()
end if	             

if dwo.name = 'ventas_180_pzs_t' then
	this.SetSort("ventas_180_pzs D")
	this.Sort()
end if	             

if dwo.name = 'ventas_90_pzs_t' then
	this.SetSort("ventas_90_pzs D")
	this.Sort()
end if	             

if dwo.name = 'pedidos_pendientes_pzs_t' then
	this.SetSort("pedidos_pendientes_pzs D")
	this.Sort()
end if	             

if dwo.name = 'stock_actual_pzs_t' then
	this.SetSort("stock_actual_pzs D")
	this.Sort()
end if	             

if dwo.name = 'planificado_pzs_t' then
	this.SetSort("planificado_pzs D")
	this.Sort()
end if	             

if dwo.name = 'rotura_stock_pzs_t' then
	this.SetSort("rotura_stock_pzs A")
	this.Sort()
end if	             

if dwo.name = 'stock_sugerido_pzs_t' then
	this.SetSort("stock_sugerido_pzs D")
	this.Sort()
end if	             

////////////////////////////////////////////////////////

if dwo.name = 'lote_minimo_m2_t' then
	this.SetSort("lote_minimo_m2 D")
	this.Sort()
end if	             

if dwo.name = 'ventas_180_m2_t' then
	this.SetSort("ventas_180_m2 D")
	this.Sort()
end if	             

if dwo.name = 'ventas_90_m2_t' then
	this.SetSort("ventas_90_m2 D")
	this.Sort()
end if	             

if dwo.name = 'pedidos_pendientes_m2_t' then
	this.SetSort("pedidos_pendientes_m2 D")
	this.Sort()
end if	             

if dwo.name = 'stock_actual_m2_t' then
	this.SetSort("stock_actual_m2 D")
	this.Sort()
end if	             

if dwo.name = 'planificado_m2_t' then
	this.SetSort("planificado_m2 D")
	this.Sort()
end if	             

if dwo.name = 'rotura_stock_m2_t' then
	this.SetSort("rotura_stock_m2 A")
	this.Sort()
end if	             

if dwo.name = 'stock_sugerido_m2_t' then
	this.SetSort("stock_sugerido_m2 D")
	this.Sort()
end if	             



if dwo.name = 'b_marcar' then
	for i = 1 to this.rowcount() 
		this.object.marcado[i] = 'S'
	next
end if	             

if dwo.name = 'b_desmarcar' then
	for i = 1 to this.rowcount() 
		this.object.marcado[i] = 'N'
	next
end if	             

if dwo.name = 'b_planificar' then
	for i = 1 to this.rowcount() 
		if ( ( this.object.stock_sugerido_pzs[i] = 0 or  isnull (this.object.stock_sugerido_pzs[i] ) ) and  ( this.object.sugerido2_pzs[i] = 0 or isnull (this.object.sugerido2_pzs[i] ) ) ) 	 then
			this.object.marcado[i] = 'N'
		end if
	next
	

	f_planificar_wow()

end if	             


end event

event dw_datos::retrieveend;call super::retrieveend;//f_calculo_stock_sugerido()
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;integer mes, i, anyo, fila
dec cantidad
string articulo

if cbx_grafica.checked then
	if this.rowcount() > 0 then
		dw_graf_ventas_mes.setredraw(false)
		dw_graf_ventas_mes.reset()
		articulo = this.object.cod_articulo[currentrow]
		anyo = year(today())
		mes = month (today()) -1
		if mes = 0 then 
			mes = 12
			anyo = anyo -1
		end if
		
		for i = 1 to 12
			cantidad = 0
			select sum(cantidad)
			into :cantidad
			from vista_venliped
			where year(fpedido) = :anyo
			and month (fpedido) = :mes
			and articulo = :articulo;
			
			if isnull(cantidad) then cantidad = 0
			
			fila = dw_graf_ventas_mes.insertrow(0)
			dw_graf_ventas_mes.object.anyo_mes[fila] = string(anyo)+'-'+string(mes,"00")
			dw_graf_ventas_mes.object.cantidad[fila] = cantidad
			
			mes = mes -1
			if mes = 0 then 
				mes = 12
				anyo = anyo -1
			end if
			
		next
		
		dw_graf_ventas_mes.setredraw(true)
	end if
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_calculo_necesidades
integer x = 8288
integer y = 132
integer taborder = 0
string picturename = "C:\Tencer_PB12\Log Out_24x24.png"
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_calculo_necesidades
integer width = 1243
end type

type p_logo from wt_consultas_padre`p_logo within wtc_calculo_necesidades
integer x = 7913
integer y = 12
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_calculo_necesidades
integer x = 1298
integer y = 232
integer width = 1673
integer height = 132
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_calculo_necesidades
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_calculo_necesidades
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_calculo_necesidades
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_calculo_necesidades
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_calculo_necesidades
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
long textcolor = 24076881
end type

type ddlb_meses_de_stock from dropdownlistbox within wtc_calculo_necesidades
integer x = 4878
integer y = 132
integer width = 366
integer height = 400
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"1","2","3","4","5","6","7","8","9","10","11","12"}
borderstyle borderstyle = stylelowered!
end type

type cbx_stock_sugerido from checkbox within wtc_calculo_necesidades
integer x = 5381
integer y = 164
integer width = 791
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calcular sugerido"
end type

type ddlb_meses_stock_min from dropdownlistbox within wtc_calculo_necesidades
integer x = 4288
integer y = 132
integer width = 494
integer height = 400
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"1","2","3","4","5","6","7","8","9","10","11","12"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_rotura from dropdownlistbox within wtc_calculo_necesidades
integer x = 3086
integer y = 132
integer width = 494
integer height = 400
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Todos","Roturas"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
choose case ddlb_rotura.text 
	case "Todos"		
		dw_datos.Setfilter("")
	case "Roturas"
		dw_datos.Setfilter (" planificado_pzs + stock_actual_pzs < pedidos_pendientes_pzs  ")
	case else
		dw_datos.Setfilter("")
end choose

dw_datos.filter()

end event

type dw_graf_ventas_mes from datawindow within wtc_calculo_necesidades
boolean visible = false
integer x = 4206
integer y = 1988
integer width = 4174
integer height = 1632
integer taborder = 230
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_graf_ventas_mes"
boolean livescroll = true
end type

type cbx_grafica from checkbox within wtc_calculo_necesidades
integer x = 5381
integer y = 72
integer width = 791
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Pedidos Meses (Gráfico)"
end type

event clicked;if this.checked = true then
	dw_graf_ventas_mes.visible = true
	dw_datos.EVENT RowFocusChanged(dw_datos.getrow())   
else
	dw_graf_ventas_mes.visible = false
end if		
end event

type st_mensajes from statictext within wtc_calculo_necesidades
integer x = 6464
integer y = 8
integer width = 1408
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19993310
long backcolor = 67108864
boolean focusrectangle = false
end type

type pb_2 from picturebutton within wtc_calculo_necesidades
boolean visible = false
integer x = 7067
integer y = 128
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Save_24x24.png"
end type

type dw_export_excel from datawindow within wtc_calculo_necesidades
boolean visible = false
integer x = 6560
integer width = 635
integer height = 112
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Export Excel"
string dataobject = "dwtc_calculo_necesidades"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_3 from picturebutton within wtc_calculo_necesidades
integer x = 7634
integer y = 124
integer width = 146
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\printer-icon_24x24.png"
end type

event clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_datos.rowcount()

if ll_registros > 0 then
	dw_export_excel.reset()
	dw_export_excel.object.data = dw_datos.object.data
	
	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
		//dw_detalle.SaveAs(ls_ruta_fichero, Excel!, true)
		uf_save_dw_as_excel(dw_export_excel,ls_ruta_fichero)
		
	end if


end if

end event

type ddlb_sugerido from dropdownlistbox within wtc_calculo_necesidades
integer x = 3680
integer y = 132
integer width = 494
integer height = 400
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Todos","Positivos","Negativos"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
choose case ddlb_rotura.text 
	case "Todos"		
		dw_datos.Setfilter("")
	case "Roturas"
		dw_datos.Setfilter (" planificado_pzs + stock_actual_pzs < pedidos_pendientes_pzs  ")
	case else
		dw_datos.Setfilter("")
end choose

dw_datos.filter()

end event

type gb_1 from groupbox within wtc_calculo_necesidades
integer x = 4832
integer y = 68
integer width = 453
integer height = 188
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Meses Stock"
end type

type gb_2 from groupbox within wtc_calculo_necesidades
integer x = 3031
integer y = 72
integer width = 581
integer height = 188
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rotura Stock"
end type

type gb_3 from groupbox within wtc_calculo_necesidades
integer x = 4242
integer y = 68
integer width = 581
integer height = 192
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Meses Stock Min."
end type

type gb_excel from groupbox within wtc_calculo_necesidades
integer x = 7593
integer y = 76
integer width = 219
integer height = 180
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Excel"
end type

type gb_4 from groupbox within wtc_calculo_necesidades
integer x = 3625
integer y = 72
integer width = 581
integer height = 188
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sugerido"
end type

