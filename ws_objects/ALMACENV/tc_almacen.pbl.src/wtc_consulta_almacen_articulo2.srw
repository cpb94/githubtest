$PBExportHeader$wtc_consulta_almacen_articulo2.srw
forward
global type wtc_consulta_almacen_articulo2 from wt_consultas_padre
end type
type st_info from statictext within wtc_consulta_almacen_articulo2
end type
type progreso from hprogressbar within wtc_consulta_almacen_articulo2
end type
type mermas from checkbox within wtc_consulta_almacen_articulo2
end type
type cb_calcular from commandbutton within wtc_consulta_almacen_articulo2
end type
type st_1 from statictext within wtc_consulta_almacen_articulo2
end type
type cb_detalle_stock from commandbutton within wtc_consulta_almacen_articulo2
end type
type dw_detalle_stock from datawindow within wtc_consulta_almacen_articulo2
end type
type ddlb_fechas from dropdownlistbox within wtc_consulta_almacen_articulo2
end type
type dw_export_excel from datawindow within wtc_consulta_almacen_articulo2
end type
type cb_exportar from u_boton within wtc_consulta_almacen_articulo2
end type
type gb_2 from groupbox within wtc_consulta_almacen_articulo2
end type
type gb_excel from groupbox within wtc_consulta_almacen_articulo2
end type
end forward

global type wtc_consulta_almacen_articulo2 from wt_consultas_padre
integer width = 7721
integer height = 3124
string title = "Consulta Stock Por Artículo Valorado (Coste Fabricación y Tarifa)"
st_info st_info
progreso progreso
mermas mermas
cb_calcular cb_calcular
st_1 st_1
cb_detalle_stock cb_detalle_stock
dw_detalle_stock dw_detalle_stock
ddlb_fechas ddlb_fechas
dw_export_excel dw_export_excel
cb_exportar cb_exportar
gb_2 gb_2
gb_excel gb_excel
end type
global wtc_consulta_almacen_articulo2 wtc_consulta_almacen_articulo2

type variables
string sql_inicial, sql_final
String orden_seleccionado
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Filtros mediante DW
	//if pos(dw_montaje_filtro.object.linea[j], "Existencias") = 0 then
	
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

on wtc_consulta_almacen_articulo2.create
int iCurrent
call super::create
this.st_info=create st_info
this.progreso=create progreso
this.mermas=create mermas
this.cb_calcular=create cb_calcular
this.st_1=create st_1
this.cb_detalle_stock=create cb_detalle_stock
this.dw_detalle_stock=create dw_detalle_stock
this.ddlb_fechas=create ddlb_fechas
this.dw_export_excel=create dw_export_excel
this.cb_exportar=create cb_exportar
this.gb_2=create gb_2
this.gb_excel=create gb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_info
this.Control[iCurrent+2]=this.progreso
this.Control[iCurrent+3]=this.mermas
this.Control[iCurrent+4]=this.cb_calcular
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_detalle_stock
this.Control[iCurrent+7]=this.dw_detalle_stock
this.Control[iCurrent+8]=this.ddlb_fechas
this.Control[iCurrent+9]=this.dw_export_excel
this.Control[iCurrent+10]=this.cb_exportar
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_excel
end on

on wtc_consulta_almacen_articulo2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_info)
destroy(this.progreso)
destroy(this.mermas)
destroy(this.cb_calcular)
destroy(this.st_1)
destroy(this.cb_detalle_stock)
destroy(this.dw_detalle_stock)
destroy(this.ddlb_fechas)
destroy(this.dw_export_excel)
destroy(this.cb_exportar)
destroy(this.gb_2)
destroy(this.gb_excel)
end on

event open;call super::open;string sel1
datastore fechas
long i

dw_datos.SetTransObject(SQLCA)

sql_inicial = &
" SELECT almacenmovimientos.empresa "+&
"			, almacenmovimientos.articulo "+&
"			, articulos.descripcion "+&
"			, articulos.uso "+&
"			, genter.razon "+&
"			, formatos.abreviado "+&
"			, art_ver_tipooperacion.descripcion_abr "+&
"			, oanterior.descripcion_abr "+&
"			, almacenmovimientos.calidad "+&
"			, calidades.abreviado "+&
" 			, articulos.promocion "+&
"			, sum (almacenmovimientos.cantidade - almacenmovimientos.cantidads) AS stock_piezas "+&
"			, 0 AS coste "+&
"			, 0 AS coste_mp "+&
"			, 0 AS coste_fab "+&
"			, 0 AS coste_hist "+&
"			, 0 AS coste_cajas "+&
"			, 0 AS coste_compras "+&
"		, CASE 	WHEN articulos.unidad = '0'  "+&
"						THEN sum (CONVERT(float,almacenmovimientos.cantidade) - CONVERT(float,almacenmovimientos.cantidads) ) *  "+&
"								CASE WHEN ventarifas_precios_packs.precio is null or ventarifas_precios_packs.precio = 0  "+&
"										THEN isnull(ventarifas_precios.precio,0)   "+&
"										ELSE isnull(ventarifas_precios_packs.precio,0) "+&  
"								END   "+&
"					WHEN articulos.unidad = '1'  "+&
"						THEN (sum (CONVERT(float,almacenmovimientos.cantidade) - CONVERT(float,almacenmovimientos.cantidads) ) / almartcajas.piezascaja ) * almartcajas.metroscaja * "+&
"								CASE WHEN ventarifas_precios_packs.precio is null or ventarifas_precios_packs.precio = 0  "+&
"										THEN isnull(ventarifas_precios.precio,0)   "+&
"										ELSE isnull(ventarifas_precios_packs.precio,0) "+&  
"								END   "+&
"			END AS valor "+&
"			, ISNULL(( SELECT sum ( 	CASE WHEN venliped.tipo_unidad = '0'  "+&
"												THEN venliped.cantidad  "+&
"												ELSE (FLOOR (venliped.cantidad / av.metroscaja) * av.piezascaja)  "+&
"												END ) "+&
" 							FROM venliped "+&
" 							LEFT OUTER JOIN almartcajas av ON venliped.empresa = av.empresa AND venliped.articulo = av.articulo AND venliped.caja = av.caja "+&
" 							INNER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido "+&
" 							WHERE av.metroscaja <> 0  "+&
" 							AND venliped.empresa = almacenmovimientos.empresa  "+&
"							AND venliped.articulo = almacenmovimientos.articulo  "+&
"							AND venliped.calidad = almacenmovimientos.calidad  "+&
"							AND venliped.situacion in ('C','P')  "+&
"							AND venped.es_proforma <> 'S'), 0) AS reservado "+&
" 			, ISNULL (( SELECT sum (	CASE WHEN venliped.tipo_unidad = '0'  "+&
"												THEN venliped.cantidad  "+&
"												ELSE (FLOOR(venliped.cantidad / av.metroscaja) * av.piezascaja)  "+&
"												END ) "+&
" 							FROM venliped "+& 
" 							LEFT OUTER JOIN almartcajas av ON venliped.empresa = av.empresa AND venliped.articulo = av.articulo AND venliped.caja = av.caja "+&
" 							INNER JOIN orden_carga_linea on venliped.empresa = orden_carga_linea.empresa and venliped.anyo = orden_carga_linea.venliped_anyo and venliped.pedido = orden_carga_linea.venliped_pedido and venliped.linea = orden_carga_linea.venliped_linea "+&
" 							INNER JOIN orden_carga on orden_carga.empresa =  orden_carga_linea.empresa   and orden_carga.anyo =  orden_carga_linea.anyo and orden_carga.codigo =  orden_carga_linea.codigo "+&
" 							WHERE av.metroscaja <> 0  "+&
" 							AND venliped.empresa = almacenmovimientos.empresa  "+&
" 							AND venliped.articulo = almacenmovimientos.articulo  "+&
"							AND venliped.calidad = almacenmovimientos.calidad  "+&
" 							AND orden_carga.finalizada <> 'S' ), 0 ) AS en_preparacion "+&
" 			, ISNULL (( SELECT sum (alm2.cantidade - alm2.cantidads)  "+&
"							FROM almacenmovimientos alm2  "+&
"							WHERE alm2.empresa = almacenmovimientos.empresa  "+&
"							AND alm2.articulo = almacenmovimientos.articulo  "+&
"							AND alm2.calidad = almacenmovimientos.calidad  "+&
"							AND alm2.almacen = '1'  "+&
"							AND alm2.zona = 'P' ), 0 ) AS preparado  "+&
" 			, ISNULL (( SELECT COUNT(*)  "+&
"							FROM planificacion  "+&
"							WHERE planificacion.empresa = almacenmovimientos.empresa  "+&
"							AND planificacion.cod_articulo = almacenmovimientos.articulo),0) AS planificado "+&
"			, almartcajas.piezascaja, almartcajas.metroscaja, articulos.unidad, articulos.decimales_unidad "+&
"			, MAX(ventarifas_precios.precio) AS precio_pieza "+&
"			, MAX(ventarifas_precios_packs.precio) AS precio_unidad_pack   "+&
" FROM almacenmovimientos "+&
" INNER JOIN articulos on almacenmovimientos.empresa = articulos.empresa and almacenmovimientos.articulo = articulos.codigo "+&
" LEFT OUTER JOIN art_codestadistico on  articulos.empresa = art_codestadistico.empresa and articulos.codigo = art_codestadistico.codigo "+&
" LEFT OUTER JOIN formatos on articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo "+&
" LEFT OUTER JOIN genter on articulos.empresa = genter.empresa and articulos.cliente = genter.codigo and genter.tipoter = 'C' "+&
" LEFT OUTER JOIN ventarifas_precios on articulos.empresa = ventarifas_precios.empresa and articulos.codigo = ventarifas_precios.articulos_codigo and ventarifas_precios.ventarifas_codigo <> '5' and ventarifas_precios.calidades_codigo = '1' "+&
" LEFT OUTER JOIN ventarifas_precios_packs on articulos.empresa = ventarifas_precios_packs.empresa and articulos.codigo = ventarifas_precios_packs.articulos_codigo and ventarifas_precios_packs.ventarifas_codigo <> '5' and ventarifas_precios_packs.calidades_codigo = '1' "+&
" LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
" LEFT OUTER JOIN art_escandallo e1 ON articulos.empresa = e1.empresa  "+&
"			AND articulos.codigo = e1.articulo "+&
"			AND e1.articulo_ant = (	SELECT TOP 1 articulo_ant  "+&
"											FROM art_escandallo  "+&
"											WHERE empresa = articulos.empresa  "+&
"											AND articulo = articulos.codigo)  "+&
"			AND e1.version = (		SELECT TOP 1 version  "+&
"											FROM art_escandallo  "+&
"											WHERE empresa = articulos.empresa  "+&
"											AND articulo = articulos.codigo) "+&
" LEFT OUTER JOIN articulos anterior ON e1.empresa = anterior.empresa AND e1.articulo_ant = anterior.codigo  "+&
" LEFT OUTER JOIN art_ver_tipooperacion oanterior ON anterior.empresa = oanterior.empresa AND anterior.tipo_operacion = oanterior.codigo  "+&
" LEFT OUTER JOIN calidades ON almacenmovimientos.empresa = calidades.empresa AND almacenmovimientos.calidad = calidades.codigo "+&
" LEFT OUTER JOIN almartcajas ON almacenmovimientos.empresa = almartcajas.empresa AND almacenmovimientos.articulo = almartcajas.articulo AND almartcajas.pordefecto = 'S' "+&	
" WHERE  articulos.promocion <> 'S' and almacenmovimientos.empresa = '"+codigo_empresa+"'  "+&
" AND (ventarifas_precios.ventarifas_codigo = 		(	SELECT TOP 1 v.ventarifas_codigo  "+&
"																		FROM ventarifas_precios v  "+&
"																		WHERE articulos.empresa = v.empresa  "+&
"																		AND articulos.codigo = v.articulos_codigo  "+&
"																		AND v.ventarifas_codigo <> '5'  "+&
"																		AND v.calidades_codigo = '1'  "+&
"																		ORDER BY v.precio ASC) OR ventarifas_precios.ventarifas_codigo IS NULL ) " +&
" AND (ventarifas_precios_packs.ventarifas_codigo = (	SELECT TOP 1 v2.ventarifas_codigo  "+&
"																		FROM ventarifas_precios_packs v2  "+&
"																		WHERE articulos.empresa = v2.empresa  "+&
"																		AND articulos.codigo = v2.articulos_codigo  "+&
"																		AND v2.ventarifas_codigo <> '5' 	 "+&
"																		AND v2.calidades_codigo = '1'  "+&
"																		ORDER BY v2.precio ASC) OR ventarifas_precios_packs.ventarifas_codigo IS NULL) "


/*
sql_inicial = &
" SELECT almacenmovimientos.empresa "+&
"			, almacenmovimientos.articulo "+&
"			, articulos.descripcion "+&
"			, articulos.uso "+&
"			, genter.razon "+&
"			, formatos.abreviado "+&
"			, art_ver_tipooperacion.descripcion_abr "+&
"			, oanterior.descripcion_abr "+&
"			, almacenmovimientos.calidad "+&
"			, calidades.abreviado "+&
" 			, articulos.promocion "+&
"			, sum (almacenmovimientos.cantidade - almacenmovimientos.cantidads) AS stock_piezas "+&
"			, 0 AS coste "+&
"			, 0 AS coste_mp "+&
"			, 0 AS coste_fab "+&
"			, 0 AS coste_hist "+&
"			, 0 AS coste_cajas "+&
"			, 0 AS coste_compras "+&
"			, sum (CONVERT(float,almacenmovimientos.cantidade) - CONVERT(float,almacenmovimientos.cantidads) ) *  "+&
"																							CASE WHEN ventarifas_precios_packs.precio is null or ventarifas_precios_packs.precio = 0  "+&
"																							THEN isnull(ventarifas_precios.precio,0)   "+&
"																							ELSE isnull(ventarifas_precios_packs.precio,0)  "+&  
"																							END  AS valor  "+&
"			, ISNULL(( SELECT sum ( 	CASE WHEN venliped.tipo_unidad = '0'  "+&
"												THEN venliped.cantidad  "+&
"												ELSE (FLOOR (venliped.cantidad / av.metroscaja) * av.piezascaja)  "+&
"												END ) "+&
" 							FROM venliped "+&
" 							LEFT OUTER JOIN almartcajas av ON venliped.empresa = av.empresa AND venliped.articulo = av.articulo AND venliped.caja = av.caja "+&
" 							INNER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido "+&
" 							WHERE av.metroscaja <> 0  "+&
" 							AND venliped.empresa = almacenmovimientos.empresa  "+&
"							AND venliped.articulo = almacenmovimientos.articulo  "+&
"							AND venliped.calidad = almacenmovimientos.calidad  "+&
"							AND venliped.situacion in ('C','P')  "+&
"							AND venped.es_proforma <> 'S'), 0) AS reservado "+&
" 			, ISNULL (( SELECT sum (	CASE WHEN venliped.tipo_unidad = '0'  "+&
"												THEN venliped.cantidad  "+&
"												ELSE (FLOOR(venliped.cantidad / av.metroscaja) * av.piezascaja)  "+&
"												END ) "+&
" 							FROM venliped "+& 
" 							LEFT OUTER JOIN almartcajas av ON venliped.empresa = av.empresa AND venliped.articulo = av.articulo AND venliped.caja = av.caja "+&
" 							INNER JOIN orden_carga_linea on venliped.empresa = orden_carga_linea.empresa and venliped.anyo = orden_carga_linea.venliped_anyo and venliped.pedido = orden_carga_linea.venliped_pedido and venliped.linea = orden_carga_linea.venliped_linea "+&
" 							INNER JOIN orden_carga on orden_carga.empresa =  orden_carga_linea.empresa   and orden_carga.anyo =  orden_carga_linea.anyo and orden_carga.codigo =  orden_carga_linea.codigo "+&
" 							WHERE av.metroscaja <> 0  "+&
" 							AND venliped.empresa = almacenmovimientos.empresa  "+&
" 							AND venliped.articulo = almacenmovimientos.articulo  "+&
"							AND venliped.calidad = almacenmovimientos.calidad  "+&
" 							AND orden_carga.finalizada <> 'S' ), 0 ) AS en_preparacion "+&
" 			, ISNULL (( SELECT sum (alm2.cantidade - alm2.cantidads)  "+&
"							FROM almacenmovimientos alm2  "+&
"							WHERE alm2.empresa = almacenmovimientos.empresa  "+&
"							AND alm2.articulo = almacenmovimientos.articulo  "+&
"							AND alm2.calidad = almacenmovimientos.calidad  "+&
"							AND alm2.almacen = '1'  "+&
"							AND alm2.zona = 'P' ), 0 ) AS preparado  "+&
" 			, ISNULL (( SELECT COUNT(*)  "+&
"							FROM planificacion  "+&
"							WHERE planificacion.empresa = almacenmovimientos.empresa  "+&
"							AND planificacion.cod_articulo = almacenmovimientos.articulo),0) AS planificado "+&
"			, almartcajas.piezascaja, almartcajas.metroscaja, articulos.unidad, articulos.decimales_unidad "+&
"			, MAX(ventarifas_precios.precio) AS precio_pieza "+&
"			, MAX(ventarifas_precios_packs.precio) AS precio_unidad_pack   "+&
" FROM almacenmovimientos "+&
" INNER JOIN articulos on almacenmovimientos.empresa = articulos.empresa and almacenmovimientos.articulo = articulos.codigo "+&
" INNER JOIN art_codestadistico on  articulos.empresa = art_codestadistico.empresa and articulos.codigo = art_codestadistico.codigo "+&
" LEFT OUTER JOIN formatos on articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo "+&
" LEFT OUTER JOIN genter on articulos.empresa = genter.empresa and articulos.cliente = genter.codigo and genter.tipoter = 'C' "+&
" LEFT OUTER JOIN ventarifas_precios on articulos.empresa = ventarifas_precios.empresa and articulos.codigo = ventarifas_precios.articulos_codigo and ventarifas_precios.ventarifas_codigo <> '5' and ventarifas_precios.calidades_codigo = '1' "+&
" LEFT OUTER JOIN ventarifas_precios_packs on articulos.empresa = ventarifas_precios_packs.empresa and articulos.codigo = ventarifas_precios_packs.articulos_codigo and ventarifas_precios_packs.ventarifas_codigo <> '5' and ventarifas_precios_packs.calidades_codigo = '1' "+&
" LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
" LEFT OUTER JOIN art_escandallo e1 ON articulos.empresa = e1.empresa  "+&
"			AND articulos.codigo = e1.articulo "+&
"			AND e1.articulo_ant = (	SELECT TOP 1 articulo_ant  "+&
"											FROM art_escandallo  "+&
"											WHERE empresa = articulos.empresa  "+&
"											AND articulo = articulos.codigo)  "+&
"			AND e1.version = (		SELECT TOP 1 version  "+&
"											FROM art_escandallo  "+&
"											WHERE empresa = articulos.empresa  "+&
"											AND articulo = articulos.codigo) "+&
" LEFT OUTER JOIN articulos anterior ON e1.empresa = anterior.empresa AND e1.articulo_ant = anterior.codigo  "+&
" LEFT OUTER JOIN art_ver_tipooperacion oanterior ON anterior.empresa = oanterior.empresa AND anterior.tipo_operacion = oanterior.codigo  "+&
" LEFT OUTER JOIN calidades ON almacenmovimientos.empresa = calidades.empresa AND almacenmovimientos.calidad = calidades.codigo "+&
" LEFT OUTER JOIN almartcajas ON almacenmovimientos.empresa = almartcajas.empresa AND almacenmovimientos.articulo = almartcajas.articulo AND almartcajas.pordefecto = 'S' "+&	
" WHERE ((art_codestadistico.G2 <> 'N')  OR (art_codestadistico.G2 is null ))   "+&
" AND articulos.promocion <> 'S' and almacenmovimientos.empresa = '"+codigo_empresa+"'  "+&
" AND (ventarifas_precios.ventarifas_codigo = 		(	SELECT TOP 1 v.ventarifas_codigo  "+&
"																		FROM ventarifas_precios v  "+&
"																		WHERE articulos.empresa = v.empresa  "+&
"																		AND articulos.codigo = v.articulos_codigo  "+&
"																		AND v.ventarifas_codigo <> '5'  "+&
"																		AND v.calidades_codigo = '1'  "+&
"																		ORDER BY v.precio ASC) OR ventarifas_precios.ventarifas_codigo IS NULL ) " +&
" AND (ventarifas_precios_packs.ventarifas_codigo = (	SELECT TOP 1 v2.ventarifas_codigo  "+&
"																		FROM ventarifas_precios_packs v2  "+&
"																		WHERE articulos.empresa = v2.empresa  "+&
"																		AND articulos.codigo = v2.articulos_codigo  "+&
"																		AND v2.ventarifas_codigo <> '5' 	 "+&
"																		AND v2.calidades_codigo = '1'  "+&
"																		ORDER BY v2.precio ASC) OR ventarifas_precios_packs.ventarifas_codigo IS NULL) "

*/



sql_final = "GROUP BY almacenmovimientos.empresa, "+&
							" almacenmovimientos.articulo,  "+&
							" articulos.descripcion,  "+&
							" articulos.uso,  "+&
							" genter.razon,  "+&
							" formatos.abreviado,  "+&
							" art_ver_tipooperacion.descripcion_abr,  "+&
							" oanterior.descripcion_abr,  "+&
							" almacenmovimientos.calidad,  "+&
							" calidades.abreviado,  "+&
							" articulos.promocion,  "+&
							" almartcajas.piezascaja,  "+&
							" almartcajas.metroscaja,  "+&
							" articulos.unidad,  "+&
							" articulos.decimales_unidad, "+&
							" ventarifas_precios_packs.precio , "+&
							" ventarifas_precios.precio  "+&
				"HAVING sum (almacenmovimientos.cantidade - almacenmovimientos.cantidads) <> 0  "

orden_seleccionado = "articulos_descripcion A"



// Rellenamos el desplegable de fechas del histórico de coste de artículo
sel1 = " select distinct fecha from articulos_coste where empresa = '"+codigo_empresa+"' order by fecha desc "
f_cargar_cursor_nuevo (sel1, fechas)

/*
for i = 1 to fechas.rowcount()
	ddlb_fechas.AddItem ( string( fechas.object.fecha[i], "dd-mm-yyyy" ) )
next
*/
	
end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_almacen_articulo2
integer x = 2807
integer y = 20
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_almacen_articulo2
integer x = 3049
integer y = 20
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_almacen_articulo2
integer x = 6926
integer y = 124
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_almacen_articulo2
integer x = 7081
integer y = 124
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_almacen_articulo2
integer width = 3273
integer height = 224
integer taborder = 40
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_almacen_articulo2
integer x = 3186
integer y = 108
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

dw_datos.object.coste.visible = false
dw_datos.object.t_coste.visible = false
dw_datos.object.coste_total.visible = false

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
if dw_montaje_filtro.rowcount() > 0 then
	new_sql = f_montar_filtro(sql_inicial)  + sql_final
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
else
	dw_datos.reset()
end if

//Filtros mediante Datawindow
/*
filtro_dw = "1 = 1"
For j = 1 To dw_montaje_filtro.rowcount()
	if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
		filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
	end if
Next
dw_datos.setfilter(filtro_dw)
dw_datos.filter()
*/

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 2192
	dw_montaje_filtro.height = 225
end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if

dw_datos.setsort(orden_seleccionado)
dw_datos.sort()
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_almacen_articulo2
integer x = 7237
integer y = 124
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_almacen_articulo2
integer x = 3035
integer y = 108
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw
boolean crear_filtro

dw_datos.object.coste.visible = false
dw_datos.object.t_coste.visible = false
dw_datos.object.coste_total.visible = false
dw_datos.object.coste_hist.visible = false
dw_datos.object.t_coste_hist.visible = false
dw_datos.object.coste_hist_total.visible = false
dw_datos.object.t_coste_cajas.visible = false
dw_datos.object.coste_cajas.visible = false
dw_datos.object.coste_cajas_total.visible = false
dw_datos.object.t_coste_compras.visible = false
dw_datos.object.coste_compras.visible = false
dw_datos.object.coste_compras_total.visible = false
dw_datos.object.t_coste_mp.visible = false
dw_datos.object.coste_mp.visible = false
dw_datos.object.coste_mp_total.visible = false
dw_datos.object.t_coste_fab.visible = false
dw_datos.object.coste_fab.visible = false
dw_datos.object.coste_fab_total.visible = false

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Articulo (Descripción)"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almacenmovimientos.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Articulo = "+dw_filtro.object.#1[i]+" "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almacenmovimientos.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#1[i]//+" "+dw_filtro.object.#2[i] //Demasiado largo
					end if
				end if
			next 
		case "Artículo (Código)"
			if cadena_or = '' then
				descripcion_extra = ""
				SELECT descripcion INTO :descripcion_extra FROM articulos WHERE empresa = :codigo_empresa AND codigo = :sle_valor1.text;
				cadena_or = " almacenmovimientos.articulo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Artículo "+ddlb_operador.text+" '"+sle_valor1.text+" "+descripcion_extra+"' "
			end if
		CASE "Formato"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almacenmovimientos.formato = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Formato = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almacenmovimientos.formato = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Fecha"
			if cadena_or = '' then
				cadena_or = " almacenmovimientos.fecha_mov "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				
				ddlb_fechas.AddItem ( em_fecha1.text )
				
			end if
		case "Uso"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.uso = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Uso = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.uso = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " genter.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR genter.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Stock Obsoleto"
			if cadena_or = '' then
				cadena_or = " NOT EXISTS (SELECT * FROM almacenmovimientos AM1 WHERE AM1.empresa = almacenmovimientos.empresa AND AM1.articulo = almacenmovimientos.articulo AND AM1.fecha_mov >= '"+em_fecha1.text+"' AND ( AM1.tipomov = 1  or AM1.tipomov = 100 or AM1.tipomov = 204 or AM1.tipomov = 206 or  AM1.tipomov = 208 or AM1.tipomov = 209 )) "
				cadena_or_visible = " Stock Obsoleto "+ddlb_operador.text+" '"+em_fecha1.text+"' "
			end if			
		case "Base Cliente"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'N' then
							cadena_or = " ((art_codestadistico.G2 <> 'N')  or (art_codestadistico.G2 is null )) "
							cadena_or_visible = " Base Cliente = NO "
						else
							cadena_or = " (art_codestadistico.G2 = 'N') "
							cadena_or_visible = " Base Cliente = SI "
						end if
					end if
				end if				
			next	
		case "Ubicado P-1-1"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " (almacenmovimientos.almacen = '1' AND almacenmovimientos.zona = 'P' AND almacenmovimientos.fila = 1 AND almacenmovimientos.altura = 1) "
							cadena_or_visible = " Ubicado P-1-1 "
						end if
					end if
				end if				
			next		
		case "Ubicado Todos los P"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " (almacenmovimientos.almacen = '1' AND almacenmovimientos.zona = 'P' ) "
							cadena_or_visible = " Ubicado Todos los P "
						end if
					end if
				end if				
			next
		case "Familia"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almacenmovimientos.articulo IN ( SELECT codigo FROM articulos WHERE familia = '"+dw_filtro.object.#1[i]+"' ) "
						cadena_or_visible = " Familia = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almacenmovimientos.articulo IN ( SELECT codigo FROM articulos WHERE familia = '"+dw_filtro.object.#1[i]+"' ) "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 		
		case "Submarca"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almacenmovimientos.articulo IN ( SELECT codigo FROM articulos WHERE submarcas_codigo = '"+dw_filtro.object.#1[i]+"' ) "
						cadena_or_visible = " Submarca = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almacenmovimientos.articulo IN ( SELECT codigo FROM articulos WHERE submarcas_codigo = '"+dw_filtro.object.#1[i]+"' ) "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 		
			
		case "Calidad"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almacenmovimientos.calidad = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Calidad = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almacenmovimientos.calidad = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 		
		case "Promoción"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " articulos.promocion = 'S' "
							cadena_or_visible = " Solo Promoción "
						else
							cadena_or = " articulos.promocion = 'N' "
							cadena_or_visible = " Promoción = NO "
						end if
					end if
				end if				
			next	
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
			
			new_sql = f_montar_filtro(sql_inicial) + sql_final
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		else
			new_sql = sql_inicial + sql_final
		end if
	else
		new_sql = sql_inicial + sql_final
	end if
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	//Filtros mediante Datawindow
	/*
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	*/
	
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
	
	//Para evitar solapamiento con otros datawindows
	dw_filtro.Height = 260
	
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
	end if
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
else
	
	new_sql = f_montar_filtro(sql_inicial) + sql_final
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	//Filtros mediante Datawindow
	/*
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	*/
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
end if

//Al hacer más quieren que se restablezca el orden
orden_seleccionado = "articulos_descripcion A"

dw_datos.setsort(orden_seleccionado)
dw_datos.sort()
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_almacen_articulo2
integer x = 951
integer taborder = 0
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_almacen_articulo2
integer width = 878
integer height = 1308
integer taborder = 0
integer weight = 700
long textcolor = 24076881
string text = "0"
boolean sorted = false
string item[] = {"Fecha","Articulo (Descripción)","Artículo (Código)","Formato","Uso","Cliente","Stock Obsoleto","Base Cliente","Ubicado P-1-1","Ubicado Todos los P","Familia","Calidad","Promoción","Submarca"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Uso"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from almusos where empresa = '"+codigo_empresa+"' order by codigo ASC"
	CASE "Articulo (Descripción)"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select distinct almacenmovimientos.articulo as Código, CONVERT(char(60),articulos.descripcion) as Descripción, formatos.abreviado as Formato, art_ver_tipooperacion.descripcion_abr as Operación, almusos.descripcion AS Uso "+&
						"from almacenmovimientos LEFT OUTER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
						"LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
						"LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
						"LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
						"where almacenmovimientos.empresa = '"+codigo_empresa+"' order by CONVERT(char(60), articulos.descripcion)"
	CASE "Artículo (Código)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
	CASE "Formato"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
//		consulta = "Select formatos.codigo as Código, formatos.abreviado as Descripción "+&
//						"from formatos "+&
//						"where formatos.empresa = '"+codigo_empresa+"' order by formatos.descripcion ASC"	
		consulta = "Select formatos.codigo as Código, CONVERT(char(10), formatos.descripcion) as Descripcion, CONVERT(decimal(5,2), formatos.ancho) as Ancho, CONVERT(decimal(5,2),formatos.largo) as Largo, formatos.abreviado as Comercial "+&
						"from formatos "+&
						"where formatos.empresa = '"+codigo_empresa+"' order by formatos.descripcion ASC"	
	CASE "Fecha"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = true
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem (">")
		ddlb_operador.AddItem ("<")
		ddlb_operador.AddItem (">=")
		ddlb_operador.AddItem ("<=")
		
		ddlb_operador.text = "<="
		
	CASE "Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where empresa = '"+codigo_empresa+"' AND tipoter = 'C' order by razon ASC"
		
	CASE "Stock Obsoleto"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = true
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		
		ddlb_operador.text = "="
	
	CASE "Base Cliente", "Promoción"
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
	CASE "Ubicado P-1-1"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("S")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="	
	CASE "Ubicado Todos los P"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("S")
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
		consulta = "Select codigo as Código, descripcion as Descripción from familias where empresa = '"+codigo_empresa+"' order by codigo ASC"	
	CASE "Submarca"  // Sólo mostraremos submarcas de la familia WOW y marca WOW.
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from submarcas where empresa = '"+codigo_empresa+"' and familias_codigo = '2' and marcas_codigo = '1'  order by codigo ASC"	
		
	CASE "Calidad"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from calidades where empresa = '"+codigo_empresa+"' order by codigo ASC"	
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_almacen_articulo2
integer y = 512
integer width = 7543
integer height = 2216
integer taborder = 50
string dataobject = "dwtc_consulta_almacen_articulo"
end type

event dw_datos::doubleclicked;call super::doubleclicked;/*
Long id_ventana
str_parametros lstr_param 

if row > 0 then	
	
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(row,"modelo_pieza_codigo_lab")
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_consulta_disenyo"
	lstr_param.resultado = ''
	id_ventana = f_menu_ventana_esta_abierta("wtc_mant_pruebas")
	if id_ventana <> -1 then
		close(wtc_mant_pruebas)
		OpenWithParm(wtc_mant_pruebas, lstr_param)
	else
		OpenWithParm(wtc_mant_pruebas,lstr_param)
	end if
	
end if
*/
end event

event dw_datos::clicked;call super::clicked;if row = 0 then
	choose case dwo.name 
		case "t_articulo" 
			orden_seleccionado = "articulos_descripcion A"
		case "t_uso" 
			orden_seleccionado = "articulos_uso A"
		case "t_cliente" 
			orden_seleccionado = "genter_razon A"
		case "t_piezas" 
			orden_seleccionado = "stock_piezas D"
		case "t_coste" 
			orden_seleccionado = "coste D"
		case "t_valor" 
			orden_seleccionado = "valor D"
		case "t_operacion" 
			orden_seleccionado = "art_ver_tipooperacion_descripcion_abr A"
	end choose
	
	dw_datos.setsort(orden_seleccionado)
	dw_datos.sort()
end if
end event

event dw_datos::retrieveend;call super::retrieveend;/*
string articulo, formato
dec cantidad_pedido, m2_pieza, disponible

dw_datos.object.t_reservado.visible = false
dw_datos.object.t_disponible_pzs.visible = false
dw_datos.object.t_disponible_m2.visible = false
dw_datos.object.titulo_reservado.visible = false
dw_datos.object.titulo_disponible.visible = false
dw_datos.object.titulo_pzs1.visible = false
dw_datos.object.titulo_pzs2.visible = false
dw_datos.object.titulo_m2.visible = false

if dw_datos.rowcount() = 1 then
	dw_datos.object.t_reservado.visible = true
	dw_datos.object.t_disponible_pzs.visible = true
	dw_datos.object.t_disponible_m2.visible = true
	dw_datos.object.titulo_reservado.visible = true
	dw_datos.object.titulo_disponible.visible = true
	dw_datos.object.titulo_pzs1.visible = true
	dw_datos.object.titulo_pzs2.visible = true
	dw_datos.object.titulo_m2.visible = true
	
	articulo = dw_datos.object.articulo[1]
	
	cantidad_pedido = 0
	select sum (venliped.cantidad)
	into :cantidad_pedido
	from venliped, venped
	where  venliped.empresa = venped.empresa
	and venliped.anyo = venped.anyo
	and venliped.pedido = venped.pedido
	and venliped.empresa = :codigo_empresa
	and venliped.articulo = :articulo
	and venped.es_proforma <> 'S'
	group by venliped.formato;
	 
	 SELECT formato INTO :formato 
	 FROM articulos 
	 WHERE empresa = :codigo_empresa AND codigo = :articulo;
	 
	dw_datos.object.t_reservado.text = string (cantidad_pedido, "###,###,###")
	
	disponible = dec(dw_datos.object.piezas_totales[1]) - dec(cantidad_pedido)
	
	dw_datos.object.t_disponible_pzs.text = string(disponible, "###,###,###")
	select (formatos.ancho * formatos.largo ) / 10000
	into :m2_pieza
	from formatos
	where empresa = :codigo_empresa
	and codigo = :formato;
	
	dw_datos.object.t_disponible_m2.text = string(disponible * m2_pieza, "###,###,###")
	 
end if
*/
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_almacen_articulo2
integer x = 7392
integer y = 124
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_almacen_articulo2
integer width = 2670
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_almacen_articulo2
integer x = 7026
integer y = 16
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_almacen_articulo2
integer x = 1303
integer y = 240
integer width = 3849
integer height = 260
integer taborder = 60
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_almacen_articulo2
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_almacen_articulo2
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 20
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_almacen_articulo2
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_almacen_articulo2
integer x = 1312
integer y = 132
integer height = 96
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_almacen_articulo2
integer x = 1312
integer y = 132
integer width = 462
integer height = 356
long textcolor = 24076881
end type

type st_info from statictext within wtc_consulta_almacen_articulo2
boolean visible = false
integer x = 4727
integer y = 2748
integer width = 2034
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Calculando Costes. Espere, por favor."
alignment alignment = center!
boolean focusrectangle = false
end type

type progreso from hprogressbar within wtc_consulta_almacen_articulo2
boolean visible = false
integer x = 4727
integer y = 2844
integer width = 2030
integer height = 68
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 1
end type

type mermas from checkbox within wtc_consulta_almacen_articulo2
integer x = 5650
integer y = 228
integer width = 699
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
boolean enabled = false
string text = "Calcular con Mermas"
end type

type cb_calcular from commandbutton within wtc_consulta_almacen_articulo2
integer x = 5637
integer y = 340
integer width = 1106
integer height = 112
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calcular v. stock "
end type

event clicked;Int i, con_mermas
Decimal piezas, coste_cajas
decimal coste,  coste_mp, coste_fab, coste_packing, coste_compras
decimal {6} coste_lotes
boolean coste_mermas 
string articulo, calidad
datetime fecha

progreso.MinPosition = 0
progreso.MaxPosition = dw_datos.rowcount() 
progreso.SetStep = 1
progreso.Position = 0
cb_calcular.visible = false
st_info.visible = true
progreso.visible = true

if mermas.checked = true then
	con_mermas = 1
	coste_mermas  = true
else
	con_mermas = 0	
	coste_mermas = false
end if

fecha = datetime (ddlb_fechas.text)

For i = 1 To dw_datos.rowcount()
	
	piezas =  Dec(dw_datos.object.stock_piezas[i])
	articulo = String(dw_datos.object.articulo[i]) 
	calidad = String(dw_datos.object.almacenmovimientos_calidad[i])
	coste = 0
	coste_mp = 0
	coste_fab = 0
	coste_packing = 0
	coste_compras = 0
	
	select isnull(sum(cantidad_pzs * case when coste_estimado > 0 
								then coste_estimado 
								else (coste_mp_acumulado + coste_fabricacion_teorico_acumulado + coste_compras_acumulado + coste_packing_acumulado)
							end),0) as coste_lotes,
		sum (isnull(cantidad_pzs * coste_mp_acumulado,0)) as coste_mp_acumulado,
		sum(isnull(cantidad_pzs * coste_fabricacion_teorico_acumulado,0)) coste_fabricacion_teorico_acumulado,
		sum(isnull(cantidad_pzs * coste_compras_acumulado,0)) coste_compras_acumulado,
		sum(isnull(cantidad_pzs * coste_packing_acumulado,0)) coste_packing_acumulado					
		into : coste, :coste_mp, :coste_fab, :coste_compras, :coste_packing
		from (
			select 
					tabla.articulo,
					lotes.operacion,
					tabla.cantidad_pzs,
					tabla.tono,
					lotes.coste_mp_acumulado,
					lotes.coste_fabricacion_teorico_acumulado,
					lotes.coste_compras_acumulado,
					lotes.coste_packing_acumulado,
					lotes.coste_fabricacion_mermas_acumulado,
					lotes.coste_mp_mermas_acumulado,
					art.coste_estimado,
					lotes.fecha_ultimo_parte
			from 
				 (
				 select isnull ( sum(lineas.cantidade - lineas.cantidads), 0 ) AS cantidad_pzs,
				 case 
					when isnull(tono, '') <> '' 
						then tono 
						else '0'
					end as tono,
				 lineas.articulo
				 from almacenmovimientos as lineas
				 where empresa = :codigo_empresa 
				 and articulo = :articulo 
				 and fecha_mov <= :fecha
				 and calidad = :calidad
				 group by articulo,tono,calidad
				 having isnull ( sum(lineas.cantidade - lineas.cantidads), 0 ) > 0
				 ) as tabla
			left join (select * from articulos_coste_lote where empresa = :codigo_empresa) as lotes on lotes.articulo = tabla.articulo and lotes.lote =  case when tabla.tono = '' then '0' else isnull(tabla.tono,0) end
			left join (select * from articulos where empresa = :codigo_empresa ) as art on art.codigo = tabla.articulo
			) as auxiliar;
		
	if coste < 0 then
		MessageBox(String(dw_datos.object.articulo[i]), coste)
	end if
	
	/*
	coste_cajas = piezas * coste_packing
	dw_datos.object.coste[i] = piezas * coste
	dw_datos.object.coste_mp[i] = piezas * coste_mp
	dw_datos.object.coste_fab[i] = piezas * coste_fab
	dw_datos.object.coste_cajas[i] = coste_cajas
	dw_datos.object.coste_compras[i] = piezas * coste_compras
	*/
	
	coste_cajas = coste_packing
	dw_datos.object.coste[i] = coste
	dw_datos.object.coste_mp[i] =  coste_mp
	dw_datos.object.coste_fab[i] =  coste_fab
	dw_datos.object.coste_cajas[i] = coste_cajas
	dw_datos.object.coste_compras[i] =  coste_compras
	
	progreso.StepIt()
	
Next

dw_datos.object.coste.visible = true
dw_datos.object.t_coste.visible = true
dw_datos.object.coste_total.visible = true
dw_datos.object.t_coste_cajas.visible = true
dw_datos.object.coste_cajas.visible = true
dw_datos.object.coste_cajas_total.visible = true
dw_datos.object.t_coste_compras.visible = true
dw_datos.object.coste_compras.visible = true
dw_datos.object.coste_compras_total.visible = true
dw_datos.object.t_coste_mp.visible = true
dw_datos.object.coste_mp.visible = true
dw_datos.object.coste_mp_total.visible = true
dw_datos.object.t_coste_fab.visible = true
dw_datos.object.coste_fab.visible = true
dw_datos.object.coste_fab_total.visible = true

st_info.visible = false
progreso.visible = false
cb_calcular.visible = true

orden_seleccionado = "coste D"
dw_datos.setsort(orden_seleccionado)
dw_datos.sort()
end event

type st_1 from statictext within wtc_consulta_almacen_articulo2
integer x = 101
integer y = 2764
integer width = 2597
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "* En caso de existir más de una tarifa para un articulo, se realiza el cálculo con la de menor valor."
boolean focusrectangle = false
end type

type cb_detalle_stock from commandbutton within wtc_consulta_almacen_articulo2
integer x = 4315
integer y = 328
integer width = 466
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle Stock"
end type

event clicked;datastore datos
string sel, articulo 

dw_detalle_stock.visible = true

articulo = dw_datos.object.articulo[dw_datos.GetRow()]


sel = " SELECT	vista_almacen.articulo "+&
" , articulos.descripcion "+&
" , formatos.abreviado "+&
" , articulos.unidad "+&
" , vista_almacen.calidad "+&
" , vista_almacen.tono "+&
" , vista_almacen.calibre "+&
" , vista_almacen.caja "+&
" , almcajas.descripcion "+&
" , sum(vista_almacen.cantidad) PIEZAS "+&
" , sum ( ROUND ( ( vista_almacen.cantidad / almartcajas.piezascaja), 0 ,1 ) * almartcajas.metroscaja  ) M2 "+&
" , ISNULL (( select sum (venliped.cantidad )  "+&
" 				from venliped  "+&
"				inner join venped on venliped.anyo = venped.anyo and venliped.pedido = venped.pedido   "+&
" 				where vista_almacen.empresa = venliped.empresa and vista_almacen.articulo = venliped.articulo  "+&
" 				and vista_almacen.tono = venliped.tonochar and venliped.calibre = vista_almacen.calibre and venped.es_proforma <> 'S' "+&
" 				and vista_almacen.caja = almartcajas.caja and venliped.situacion  <> 'F' and vista_almacen.tipo_pallet = venliped.tipo_pallet), 0) PEDIDO "+&
" , vista_almacen.tipo_pallet "+&
" , pallets.descripcion "+&
" from vista_almacen "+&
" inner join almartcajas on vista_almacen.empresa = almartcajas.empresa and vista_almacen.articulo = almartcajas.articulo and vista_almacen.caja = almartcajas.caja "+&
" inner join almcajas on almartcajas.empresa = almcajas.empresa and almartcajas.caja = almcajas.codigo "+&
" inner join articulos on vista_almacen.empresa = articulos.empresa and vista_almacen.articulo = articulos.codigo "+&
" inner join formatos on articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo "+&
" left join pallets on vista_almacen.empresa = pallets.empresa and vista_almacen.tipo_pallet = pallets.codigo "+&
" where vista_almacen.articulo = '"+articulo+"' "+&
" group by vista_almacen.empresa "+&
" , vista_almacen.articulo "+&
" , articulos.descripcion "+&
" , formatos.abreviado "+&
" , articulos.unidad "+&
" , vista_almacen.calidad "+&
" , vista_almacen.tono "+&
" , vista_almacen.calibre "+&
" , vista_almacen.caja "+&
" , almartcajas.caja "+&
" , almcajas.descripcion " +&
" , vista_almacen.tipo_pallet "+&
" , pallets.descripcion "


 
f_cargar_cursor_trans (SQLCA, sel, datos)

if datos.rowcount() > 0 then
	dw_detalle_stock.object.data = datos.object.data
end if

destroy datos


end event

type dw_detalle_stock from datawindow within wtc_consulta_almacen_articulo2
boolean visible = false
integer x = 1399
integer y = 680
integer width = 5193
integer height = 1616
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_detalle_stock"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if dwo.name = "p_salir" then
	dw_detalle_stock.reset()
	dw_detalle_stock.visible = false
end if

end event

type ddlb_fechas from dropdownlistbox within wtc_consulta_almacen_articulo2
integer x = 4896
integer y = 340
integer width = 622
integer height = 368
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean vscrollbar = true
end type

type dw_export_excel from datawindow within wtc_consulta_almacen_articulo2
boolean visible = false
integer x = 6153
integer y = 88
integer width = 635
integer height = 112
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Export Excel"
string dataobject = "dwtc_consulta_almacen_articulo"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_exportar from u_boton within wtc_consulta_almacen_articulo2
integer x = 7182
integer y = 348
integer width = 347
integer height = 84
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;call super::clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_datos.rowcount()

if ll_registros > 0 then
	dw_export_excel.reset()
	dw_export_excel.object.data = dw_datos.object.data
	
	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
		//dw_detalle.SaveAs(ls_ruta_fichero, Excel!, true)
		uf_save_dw_as_excel(dw_export_excel,ls_ruta_fichero)
		
	end if

//	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
//		//dw_detalle.SaveAs(ls_ruta_fichero, Excel!, true)
//		
//		guardaraexcel2(dw_export_excel,ls_ruta_fichero)
//	end if

end if

end event

type gb_2 from groupbox within wtc_consulta_almacen_articulo2
integer x = 4850
integer y = 276
integer width = 731
integer height = 184
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19474154
long backcolor = 553648127
string text = "Coste Histórico Artículo"
borderstyle borderstyle = stylebox!
end type

type gb_excel from groupbox within wtc_consulta_almacen_articulo2
integer x = 7173
integer y = 304
integer width = 366
integer height = 136
integer taborder = 160
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

