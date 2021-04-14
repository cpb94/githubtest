$PBExportHeader$wtc_consulta_situacion_pedidos.srw
forward
global type wtc_consulta_situacion_pedidos from wt_consultas_padre
end type
type st_reservado from statictext within wtc_consulta_situacion_pedidos
end type
type pb_grabar_obs from picturebutton within wtc_consulta_situacion_pedidos
end type
type st_1 from statictext within wtc_consulta_situacion_pedidos
end type
type dw_etiquetas_bultos_100 from datawindow within wtc_consulta_situacion_pedidos
end type
type cbx_resumen from checkbox within wtc_consulta_situacion_pedidos
end type
type dw_stock from u_datawindow within wtc_consulta_situacion_pedidos
end type
type dwtc_reparto_fabricaciones from datawindow within wtc_consulta_situacion_pedidos
end type
end forward

global type wtc_consulta_situacion_pedidos from wt_consultas_padre
integer width = 4727
integer height = 3736
string title = "Situación Pedidos"
st_reservado st_reservado
pb_grabar_obs pb_grabar_obs
st_1 st_1
dw_etiquetas_bultos_100 dw_etiquetas_bultos_100
cbx_resumen cbx_resumen
dw_stock dw_stock
dwtc_reparto_fabricaciones dwtc_reparto_fabricaciones
end type
global wtc_consulta_situacion_pedidos wtc_consulta_situacion_pedidos

type variables
string sql_inicial, sql_final, orden_seleccionado
boolean ib_ubicaciones_activas,ib_apilado_en_bloque
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_consulta ()
public function string f_construir_group_by ()
public subroutine f_cargar_datawindow (string new_sql)
public subroutine f_calculo_disponibilidad (datastore ds_datos)
public subroutine f_calculo_disponibilidad_dw (datawindow ds_datos, string ls_filtro_cliente, string ls_filtro_envio, string ls_filtro_articulo_calidad, string ls_articulo, string ls_calidad)
public subroutine f_cargar_reparto_fabricaciones (long arg_row)
public subroutine f_calculo_disponibilidad_dw_old (datawindow ds_datos, string ls_filtro_cliente, string ls_filtro_envio, string ls_filtro_articulo_calidad, string ls_articulo, string ls_calidad)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j

montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()	
	if dw_montaje_filtro.object.aplicar_a_sql[j] = 'S' then
		//Filtros mediante DW
		//if pos(dw_montaje_filtro.object.linea[j], "Existencias") = 0 then		
		if montaje = '' then
			montaje = dw_montaje_filtro.object.filtro[j]
		else
			montaje = montaje +' AND '+ dw_montaje_filtro.object.filtro[j]
		end if
		//end if
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

//cadena =   "SELECT venped.empresa, ~n"+&
//			  "		 venped.anyo, ~n"+&
//			  "		 venped.pedido, ~n"+& 
//			  "		 venped.fpedido, ~n"+&
//			  "		 venped.cliente, ~n"+&
//			  "		 genter.razon, ~n"+&
//			  "		 venped.observaciones, ~n"+&
//			  "		 venped.numpedcli, ~n"+&
//			  "		 venped.envio, ~n"+&
//			  "		 venenvio.descripcion, ~n"+&
//			  "		 venliped.linea, ~n"+&
//			  "		 venliped.articulo, ~n"+&
//			  "		 articulos.descripcion, ~n"+&
//			  "		 articulos.familia, ~n"+&
//			  "		 familias.descripcion, ~n"+&
//			  "		 articulos.formato, ~n"+&
//			  "		 formatos.abreviado, ~n"+&
//			  "		 articulos.promocion, ~n"+&
//			  "		 articulos.unidad, ~n"+&
//			  "		 unidades.abreviado, ~n"+&
//			  "		 isnull(case when articulos.decimales_unidad is null then unidades.decimales else articulos.decimales_unidad end,0) as decimales_unidad, ~n"+&
//			  "		 venliped.calidad, ~n"+&
//			  "		 calidades.abreviado, ~n"+&
//			  "		 venliped.tonochar, ~n"+&
//			  "		 venliped.calibre, ~n"+&
//			  "		 venliped.tipo_pallet, ~n"+&
//			  "		 pallets.resumido, ~n"+&
//			  "		 venliped.caja, ~n"+&
//			  "		 almcajas.descripcion_abr, ~n"+&
//			  "		 venliped.cantidad, ~n"+&
//			  "		 venliped.pallets, ~n"+&
//			  "		 venliped.cajas, ~n"+&
//			  "		 venliped.situacion, ~n"+&
//			  "       isnull(venliped.id_alm_orden_carga,0) as id_alm_orden_carga, ~n"+&
//			  "       isnull(venliped.ordenacion_orden_carga,0) as ordenacion_orden_carga, ~n"+&
//			  "       isnull(venliped.bulto_desde_orden_carga,0) as bulto_desde_orden_carga, ~n"+&
//			  "       isnull(venliped.bulto_hasta_orden_carga,0) as bulto_hasta_orden_carga, ~n"+&
//			  "       venliped.tipolinea, ~n"+&
//			  "       convert(dec(10,2),venliped.peso) as peso_kg, ~n"+&
//			  "       -1 as id_alm_orden_carga_actual, ~n"+&
//			  "       -1.000 as disponible, ~n"+&
//			  "       0.000 as planificado, ~n"+&
//			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_minima, ~n"+&
//			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_maxima, ~n"+&
//			  "       case venliped.situacion when 'P' then 50 when 'C' then 40 else 10 end as estado_linea, ~n"+&
//			  "       convert(dec(16,2), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) * 100 else 0 end ) as porcentaje_pallet_pico, ~n"+&
//			  "       venped.usuario ~n"+&
//			  "FROM  venped ~n"+&
//			  "		LEFT OUTER JOIN venenvio ON venped.empresa = venenvio.empresa AND venped.cliente = venenvio.cliente AND venped.envio = venenvio.codigo, ~n"+&
//			  "		venliped ~n"+&
//			  "		LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo ~n"+&
//			  "		LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo ~n"+&
//			  "		LEFT OUTER JOIN almcajas ON venliped.empresa = almcajas.empresa AND venliped.caja = almcajas.codigo ~n"+&
//			  "		LEFT OUTER JOIN almartcajas ON venliped.empresa = almartcajas.empresa AND venliped.articulo = almartcajas.articulo AND venliped.caja = almartcajas.caja ~n"+&
//			  "		LEFT OUTER JOIN palarticulo ON venliped.empresa = palarticulo.empresa AND venliped.articulo = palarticulo.articulo AND venliped.tipo_pallet = palarticulo.codigo AND venliped.caja = palarticulo.caja, ~n"+&
//			  "		genter, ~n"+&
//			  "		articulos, ~n"+&  
//			  "		familias, ~n"+&
//			  "		formatos, ~n"+&
//			  "		unidades ~n"+&
//			  "WHERE ( venped.empresa    = venliped.empresa ) ~n"+&
//			  "AND   ( venped.anyo       = venliped.anyo ) ~n"+&
//			  "AND   ( venped.pedido     = venliped.pedido ) ~n"+&
//			  "AND   ( venped.empresa    = genter.empresa ) ~n"+&
//			  "AND   ( 'C'               = genter.tipoter ) ~n"+&
//			  "AND   ( venped.cliente    = genter.codigo ) ~n"+&
//			  "AND   ( venliped.empresa  = articulos.empresa ) ~n"+&
//			  "AND   ( venliped.articulo = articulos.codigo ) ~n"+&
//			  "AND   ( articulos.empresa = familias.empresa ) ~n"+&
//			  "AND   ( articulos.familia = familias.codigo ) ~n"+&
//			  "AND   ( articulos.empresa = formatos.empresa ) ~n"+&
//			  "AND   ( articulos.formato = formatos.codigo ) ~n"+&
//			  "AND   ( unidades.codigo   = articulos.unidad ) ~n"+&
//			  "AND   ( venped.es_proforma = 'N' ) ~n"+&
//			  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) ~n" 

//			  "       convert(dec(10,2),venliped.peso) as peso_kg, ~n"+&

cadena =   "SELECT venped.empresa, ~n"+&
			  "		 venped.anyo, ~n"+&
			  "		 venped.pedido, ~n"+& 
			  "		 venped.fpedido, ~n"+&
			  "		 venped.cliente, ~n"+&
			  "		 genter.razon, ~n"+&
			  "		 venped.observaciones, ~n"+&
			  "		 venped.numpedcli, ~n"+&
			  "		 venped.envio, ~n"+&
			  "		 venenvio.descripcion, ~n"+&
			  "		 venliped.linea, ~n"+&
			  "		 venliped.articulo, ~n"+&
			  "		 isnull(venliped.descripcion,articulos.descripcion), ~n"+&
			  "		 articulos.familia, ~n"+&
			  "		 familias.descripcion, ~n"+&
			  "		 articulos.formato, ~n"+&
			  "		 formatos.abreviado, ~n"+&
			  "		 articulos.promocion, ~n"+&
			  "		 case when ventipolin.gestionar_en_piezas = 'S' then '0' else articulos.unidad end as articulos_unidad, ~n"+&
			  "		 isnull(unidades.abreviado,'Uds') as unidades_abreviado, ~n"+&
			  "		 case when ventipolin.gestionar_en_piezas = 'S' then 0 else isnull(case when articulos.decimales_unidad is null then unidades.decimales else articulos.decimales_unidad end,0) end as decimales_unidad, ~n"+&
			  "		 venliped.calidad, ~n"+&
			  "		 calidades.abreviado, ~n"+&
			  "		 venliped.tonochar, ~n"+&
			  "		 venliped.calibre, ~n"+&
			  "		 venliped.tipo_pallet, ~n"+&
			  "		 pallets.resumido, ~n"+&
			  "		 venliped.caja, ~n"+&
			  "		 almcajas.descripcion_abr, ~n"+&
			  "		 case when ventipolin.gestionar_en_piezas = 'S' then venliped.cantidad_pzs else venliped.cantidad end as venliped_cantidad, ~n"+&
			  "		 venliped.pallets, ~n"+&
			  "		 venliped.cajas, ~n"+&
			  "		 case when isnull(venliped.articulo,'') = '' then 'C' else venliped.situacion end as venliped_situacion, ~n"+&
			  "       isnull(venliped.id_alm_orden_carga,0) as id_alm_orden_carga, ~n"+&
			  "       isnull(venliped.ordenacion_orden_carga,0) as ordenacion_orden_carga, ~n"+&
			  "       isnull(venliped.bulto_desde_orden_carga,0) as bulto_desde_orden_carga, ~n"+&
			  "       isnull(venliped.bulto_hasta_orden_carga,0) as bulto_hasta_orden_carga, ~n"+&
			  "       venliped.tipolinea, ~n"+&
			  "       convert(dec(10,2), venliped.peso + ( ( case when venliped.situacion = 'P' then 0 else convert(dec(16,2), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) else 0 end ) end) * pallets.peso ) ) as peso_bruto_calculado_kg, ~n"+&			  
			  "       -1 as id_alm_orden_carga_actual, ~n"+&
			  "       -1.000 as disponible, ~n"+&
			  "       0.000 as planificado, ~n"+&
			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_minima, ~n"+&
			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_maxima, ~n"+&
			  "       case when isnull(venliped.articulo,'') = '' then 40 else case venliped.situacion when 'P' then 50 when 'C' then 40 else 10 end end as estado_linea, ~n"+&
			  "       case when venliped.situacion = 'P' then 0 else convert(dec(16,6), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) * 100 else 0 end ) end as porcentaje_pallet_pico, ~n"+&
			  "       venped.fentrega, ~n"+&			  
			  "       venped.usuario, ~n"+&			  
			  "       alm_orden_carga.fecha as fecha_carga, ~n"+&
			  "       isnull(ventipolin.gestionar_en_piezas,'') as gestionar_en_piezas, ~n"+&
			  "       convert(dec(10,2),venliped.peso_neto) as peso_neto_kg, ~n"+&  
			  "		 isnull(venliped.cantidad_pzs,0) as cantidad_pzs, ~n"+&  
			  "		 isnull(venliped.precio_pzs,0) as precio_pzs, ~n"+&  
			  "		 0 as disponible_pzs, ~n"+&	
			  "       isnull((select count(*) from venliped as venliped_conteo_cerrado where venliped_conteo_cerrado.empresa = alm_orden_carga.empresa and venliped_conteo_cerrado.id_alm_orden_carga = alm_orden_carga.id and isnull(venliped_conteo_cerrado.articulo,'') <> '' and venliped_conteo_cerrado.situacion <> 'P'),0) as lineas_sin_cerrar, ~n"+&	
			  "       isnull(alm_orden_carga.confirmada,'N') as orden_confirmada, ~n"+&  
			  "       venped.es_courier as courier, ~n"+&
			  "       venliped.total_cajas as total_cajas ~n"+&
			  "FROM  venped ~n"+&
			  "      INNER JOIN venliped ON venped.empresa = venliped.empresa AND venped.anyo = venliped.anyo AND venped.pedido = venliped.pedido ~n"+&
			  "      LEFT OUTER JOIN ventipolin ON ventipolin.empresa = venliped.empresa and ventipolin.codigo = venliped.tipolinea ~n"+&
			  "      LEFT OUTER JOIN alm_orden_carga ON venliped.empresa = alm_orden_carga.empresa AND venliped.id_alm_orden_carga = alm_orden_carga.id ~n"+&  
			  "		LEFT OUTER JOIN venenvio ON venped.empresa = venenvio.empresa AND venped.cliente = venenvio.cliente AND venped.envio = venenvio.codigo ~n"+&
		 	  "		LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo ~n"+&
			  "      LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
			  "      LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo "+&			  
			  "      LEFT OUTER JOIN unidades ON ( case when ventipolin.gestionar_en_piezas = 'S' then '0' else articulos.unidad end ) = unidades.codigo ~n"+&
			  "		LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo ~n"+&
			  "		LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo ~n"+&
			  "		LEFT OUTER JOIN almcajas ON venliped.empresa = almcajas.empresa AND venliped.caja = almcajas.codigo ~n"+&
			  "		LEFT OUTER JOIN almartcajas ON venliped.empresa = almartcajas.empresa AND venliped.articulo = almartcajas.articulo AND venliped.caja = almartcajas.caja ~n"+&
			  "		LEFT OUTER JOIN palarticulo ON venliped.empresa = palarticulo.empresa AND venliped.articulo = palarticulo.articulo AND venliped.tipo_pallet = palarticulo.codigo AND venliped.caja = palarticulo.caja, ~n"+&			  
			  "		genter ~n"+&
			  "WHERE ( venped.empresa    = genter.empresa ) ~n"+&
			  "AND   ( 'C'               = genter.tipoter ) ~n"+&
			  "AND   ( venped.cliente    = genter.codigo ) ~n"+&
			  "AND   ( venped.es_proforma = 'N' ) ~n"+&
			  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) ~n"//+&
//			  "ORDER BY venped.anyo, ~n"+&
//			  "		   venped.pedido, ~n"+& 
//			  "		   venliped.linea"

return cadena





end function

public function string f_construir_group_by ();string cadena

cadena =   "ORDER BY venped.anyo, ~n"+&
			  "		   venped.pedido, ~n"+& 
			  "		   venliped.linea"

return cadena
end function

public subroutine f_cargar_datawindow (string new_sql);string ls_sel,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad
long   ll_total,ll_row,ll_rows
datastore ds_datos

pointer oldpointer
oldpointer = SetPointer(HourGlass!)

dw_datos.reset()
dw_datos.setredraw(false)
	
ll_rows = f_cargar_cursor_transaccion(sqlca,ds_datos,new_sql)

if ll_rows > 0 then
	//Primero calcularemos los datos de disponiblilidad y situacion de la disponiblilidad
	f_calculo_disponibilidad(ds_datos)
	
	dw_datos.object.data = ds_datos.object.data
	dw_datos.Event rowfocuschanged(1)
end if

destroy ds_datos

dw_datos.setredraw(true)

SetPointer(oldpointer)
end subroutine

public subroutine f_calculo_disponibilidad (datastore ds_datos);string ls_sel,ls_find, ls_articulo
long ll_indice,ll_total,ll_donde,ll_rows,ll_rows_datos_planificacion,ll_donde_datos_planificacion,ll_pedido,ll_linea
int  li_anyo
dec  ld_disponible,ld_planificado 
datetime ldt_fecha_fin_planificacion_minima,ldt_fecha_fin_planificacion_maxima

datastore ds_datos_planificacion
pointer oldpointer
//this.setredraw(false)
oldpointer = SetPointer(HourGlass!)//(AppStarting!)

ls_sel ="SELECT venliped.articulo, "+&
		  "		 articulos.familia, "+&
		  "       sum(isnull(planificacion.cantidad,0)) as planificado, "+&
		  "       min(planificacion.f_fin_estimada) as fecha_fin_planificacion_minima, "+&
		  "       max(planificacion.f_fin_estimada) as fecha_fin_planificacion_maxima "+&
		  "FROM  venped, "+&
		  "		venliped, "+&
		  "		articulos, "+&  
		  "		planificacion "+&
		  "WHERE ( venped.empresa    = venliped.empresa ) "+&
		  "AND   ( venped.anyo       = venliped.anyo ) "+&
		  "AND   ( venped.pedido     = venliped.pedido ) "+&
		  "AND   ( venliped.empresa  = articulos.empresa ) "+&
		  "AND   ( venliped.articulo = articulos.codigo ) "+&
		  "AND   ( articulos.empresa = planificacion.empresa ) "+&
		  "AND   ( articulos.codigo  = planificacion.cod_articulo ) "+&
		  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) "+&
		  "GROUP BY venliped.articulo, "+&
		  "		 articulos.familia "+&
		  "ORDER BY venliped.articulo "
	
ll_rows_datos_planificacion = f_cargar_cursor_transaccion(sqlca,ds_datos_planificacion,ls_sel)

//ds_datos.setfilter("situacion = 'F'")
//ds_datos.filter()

ll_total = ds_datos.rowcount()

for ll_indice = 1 to ll_total
	//ds_datos.object.disponible[ll_indice] = -1 and 
	ls_articulo = ds_datos.object.venliped_articulo[ll_indice]
	if ds_datos.object.disponible[ll_indice] = -1 and ds_datos.object.venliped_situacion[ll_indice] = 'F' then
		ll_donde_datos_planificacion = ds_datos_planificacion.find("venliped_articulo = '"+ds_datos.object.venliped_articulo[ll_indice]+"'",1,ll_rows_datos_planificacion)
	
		if ll_donde_datos_planificacion > 0 then
			ld_planificado                     = ds_datos_planificacion.object.planificado[ll_donde_datos_planificacion]
			ldt_fecha_fin_planificacion_minima = ds_datos_planificacion.object.fecha_fin_planificacion_minima[ll_donde_datos_planificacion]
			ldt_fecha_fin_planificacion_maxima = ds_datos_planificacion.object.fecha_fin_planificacion_maxima[ll_donde_datos_planificacion]
		else
			ld_planificado                     = 0
			setnull(ldt_fecha_fin_planificacion_minima)
			setnull(ldt_fecha_fin_planificacion_maxima)
		end if
		
		//Planificado					
		if ds_datos.object.articulos_familia[ll_indice] <> '2' and ds_datos.object.articulos_familia[ll_indice] <> '6' then
			ds_datos.object.planificado[ll_indice]                    = ld_planificado
			setnull(ldt_fecha_fin_planificacion_minima)
			setnull(ldt_fecha_fin_planificacion_maxima)			
			
			li_anyo   = ds_datos.object.venped_anyo[ll_indice]
			ll_pedido = ds_datos.object.venped_pedido[ll_indice]
			ll_linea  = ds_datos.object.venliped_linea[ll_indice]
			
			select venliped.fentrega,
					 venliped.fentrega 
			into   :ldt_fecha_fin_planificacion_minima,
					 :ldt_fecha_fin_planificacion_maxima 
			from   venliped 
			where  venliped.empresa = :codigo_empresa 
			and    venliped.anyo    = :li_anyo 
			and    venliped.pedido  = :ll_pedido 
			and    venliped.linea   = :ll_linea;
			
			
			/*MARCOS 16-02-2021*/ 
			if isnull(ldt_fecha_fin_planificacion_minima) then
				
				 SELECT top 1 f_fin_estimada
				 INTO :ldt_fecha_fin_planificacion_minima
				 FROM planificacion 
				 WHERE planificacion.cod_articulo = :ls_articulo
				 AND planificacion.f_fin_estimada IS NOT NULL 
				 ORDER BY planificacion.f_fin_estimada ASC;
				 
				 SELECT top 1 f_fin_estimada
				 INTO :ldt_fecha_fin_planificacion_maxima
				 FROM planificacion 
				 WHERE planificacion.cod_articulo = :ls_articulo
				 AND planificacion.f_fin_estimada IS NOT NULL 
				 ORDER BY planificacion.f_fin_estimada DESC;
								
			end if
			
			
			
			ds_datos.object.fecha_fin_planificacion_minima[ll_indice] = ldt_fecha_fin_planificacion_minima
			ds_datos.object.fecha_fin_planificacion_maxima[ll_indice] = ldt_fecha_fin_planificacion_maxima
			
		else
			ds_datos.object.planificado[ll_indice]                    = ld_planificado
			ds_datos.object.fecha_fin_planificacion_minima[ll_indice] = ldt_fecha_fin_planificacion_minima
			ds_datos.object.fecha_fin_planificacion_maxima[ll_indice] = ldt_fecha_fin_planificacion_maxima
		end if		
		
		ds_datos.object.disponible[ll_indice] = f_disponible_art_cal_tp_c( ds_datos.object.venped_empresa[ll_indice] ,&
																							ds_datos.object.venliped_articulo[ll_indice] ,&
																							ds_datos.object.venliped_calidad[ll_indice] ,&
																							ds_datos.object.venliped_tipo_pallet[ll_indice] ,&
																							ds_datos.object.venliped_caja[ll_indice] )

		ds_datos.object.disponible_pzs[ll_indice] = f_disponible_art_cal_tp_c_pzs( ds_datos.object.venped_empresa[ll_indice] ,&
																							ds_datos.object.venliped_articulo[ll_indice] ,&
																							ds_datos.object.venliped_calidad[ll_indice] ,&
																							ds_datos.object.venliped_tipo_pallet[ll_indice] ,&
																							ds_datos.object.venliped_caja[ll_indice] )

		if ds_datos.object.venliped_tipo_pallet[ll_indice] <> '00000' then
			//Vamos a añadir el disponible en ubicaciones con el pallet '00000' (Sin pallet, ubicaciones con bulto asignado)
			ds_datos.object.disponible_pzs[ll_indice] = ds_datos.object.disponible_pzs[ll_indice] +&
																		f_disponible_art_cal_tp_c_pzs( ds_datos.object.venped_empresa[ll_indice] ,&
																								ds_datos.object.venliped_articulo[ll_indice] ,&
																								ds_datos.object.venliped_calidad[ll_indice] ,&
																								'00000' ,&																								
																								ds_datos.object.venliped_caja[ll_indice] )			
																								
			ds_datos.object.disponible[ll_indice]     = ds_datos.object.disponible[ll_indice] +&
																		f_disponible_art_cal_tp_c( ds_datos.object.venped_empresa[ll_indice] ,&
																								ds_datos.object.venliped_articulo[ll_indice] ,&
																								ds_datos.object.venliped_calidad[ll_indice] ,&
																								'00000' ,&
																								ds_datos.object.venliped_caja[ll_indice] )																								
		end if																						

		//if ds_datos.object.disponible[ll_indice] >= ds_datos.object.cantidad[ll_indice] then
		if ( ds_datos.object.gestionar_en_piezas[ll_indice] = 'N' and ds_datos.object.disponible[ll_indice] >= ds_datos.object.venliped_cantidad[ll_indice] ) or ( ds_datos.object.gestionar_en_piezas[ll_indice] = 'S' and ds_datos.object.disponible_pzs[ll_indice] >= ds_datos.object.cantidad_pzs[ll_indice] ) then
			ds_datos.object.estado_linea[ll_indice] = 30 //Pdte Reservar
		else
			if ds_datos.object.planificado[ll_indice] > 0 and isnull(ldt_fecha_fin_planificacion_minima) then
				ds_datos.object.estado_linea[ll_indice] = 15 //Planificado sin Fecha
			else
				if ds_datos.object.planificado[ll_indice] > 0 then
					ds_datos.object.estado_linea[ll_indice] = 20 //Planificado
				else
					ds_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
				end if
			end if
			/*
			if isnull(ds_datos.object.fecha_fin[ll_indice]) then
				ds_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
			else
				ds_datos.object.estado_linea[ll_indice] = 20 //Planificado
			end if
			*/
			
		end if
							
		//case when articulos.familia = '2' then venliped.fentrega else null end )
							
		ls_find = "venliped_articulo    = '"+ds_datos.object.venliped_articulo[ll_indice]+"' and "+&
					 "venliped_calidad     = '"+ds_datos.object.venliped_calidad[ll_indice]+"' and "+&
					 "venliped_tipo_pallet = '"+ds_datos.object.venliped_tipo_pallet[ll_indice]+"' and "+&
					 "venliped_caja        = '"+ds_datos.object.venliped_caja[ll_indice]+"' and "+&
					 "venliped_situacion   = 'F'"
								 
		ll_donde = ll_indice																					
		do
			ll_donde ++
			ll_donde = ds_datos.find(ls_find,ll_donde,ll_total)
			if ll_donde > 0 then
				//Planificado					
				if ds_datos.object.articulos_familia[ll_indice] <> '2' and ds_datos.object.articulos_familia[ll_indice] <> '6' then
					ds_datos.object.planificado[ll_donde]                    = ds_datos.object.planificado[ll_indice]
					setnull(ldt_fecha_fin_planificacion_minima)
					setnull(ldt_fecha_fin_planificacion_maxima)
					li_anyo   = ds_datos.object.venped_anyo[ll_donde]
					ll_pedido = ds_datos.object.venped_pedido[ll_donde]
					ll_linea  = ds_datos.object.venliped_linea[ll_donde]
					
					select venliped.fentrega,
							 venliped.fentrega 
					into   :ldt_fecha_fin_planificacion_minima,
							 :ldt_fecha_fin_planificacion_maxima 
					from   venliped 
					where  venliped.empresa = :codigo_empresa 
					and    venliped.anyo    = :li_anyo 
					and    venliped.pedido  = :ll_pedido 
					and    venliped.linea   = :ll_linea;
					
					/*MARCOS 16-02-2021*/ 
					
					if isnull(ldt_fecha_fin_planificacion_minima) then
				
					 SELECT top 1 f_fin_estimada
					 INTO :ldt_fecha_fin_planificacion_minima
					 FROM planificacion 
					 WHERE planificacion.cod_articulo = :ls_articulo
					 AND planificacion.f_fin_estimada IS NOT NULL 
					 ORDER BY planificacion.f_fin_estimada ASC;
					 
					 SELECT top 1 f_fin_estimada
					 INTO :ldt_fecha_fin_planificacion_maxima
					 FROM planificacion 
					 WHERE planificacion.cod_articulo = :ls_articulo
					 AND planificacion.f_fin_estimada IS NOT NULL 
					 ORDER BY planificacion.f_fin_estimada DESC;
								
				
					end if
					
							
					ds_datos.object.fecha_fin_planificacion_minima[ll_donde] = ldt_fecha_fin_planificacion_minima
					ds_datos.object.fecha_fin_planificacion_maxima[ll_donde] = ldt_fecha_fin_planificacion_maxima
										
				else
					ds_datos.object.planificado[ll_donde]                    = ds_datos.object.planificado[ll_indice]
					ds_datos.object.fecha_fin_planificacion_minima[ll_donde] = ds_datos.object.fecha_fin_planificacion_minima[ll_indice]
					ds_datos.object.fecha_fin_planificacion_maxima[ll_donde] = ds_datos.object.fecha_fin_planificacion_maxima[ll_indice]
				end if				
				
				ds_datos.object.disponible[ll_donde] = ds_datos.object.disponible[ll_indice]
				ds_datos.object.disponible_pzs[ll_donde] = ds_datos.object.disponible_pzs[ll_indice]
				
				//if ds_datos.object.disponible[ll_donde] >= ds_datos.object.cantidad[ll_donde] then
				if ( ds_datos.object.gestionar_en_piezas[ll_donde] = 'N' and ds_datos.object.disponible[ll_donde] >= ds_datos.object.venliped_cantidad[ll_donde] ) or ( ds_datos.object.gestionar_en_piezas[ll_donde] = 'S' and ds_datos.object.disponible_pzs[ll_donde] >= ds_datos.object.cantidad_pzs[ll_donde] ) then
					ds_datos.object.estado_linea[ll_donde] = 30 //Pdte Reservar
				else
					if ds_datos.object.planificado[ll_donde] > 0 and isnull(ds_datos.object.fecha_fin_planificacion_minima[ll_donde]) then
						ds_datos.object.estado_linea[ll_donde] = 15 //Planificado sin Fecha
					else
						if ds_datos.object.planificado[ll_donde] > 0 then
							ds_datos.object.estado_linea[ll_donde] = 20 //Planificado
						else
							ds_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
						end if
					end if

					/*
					if isnull(ds_datos.object.fecha_fin[ll_donde]) then
						ds_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
					else
						ds_datos.object.estado_linea[ll_donde] = 20 //Planificado
					end if			
					*/
				end if				
								
			end if
		loop while ll_donde > 0 and ll_donde < ll_total
	end if
next

destroy ds_datos_planificacion

//ds_datos.setfilter("")
//ds_datos.filter()
//this.setredraw(true)
SetPointer(oldpointer)
/* script viejo
string ls_sel,ls_find
long ll_indice,ll_total,ll_donde,ll_rows,ll_rows_datos_planificacion,ll_donde_datos_planificacion,ll_pedido,ll_linea
int  li_anyo
dec  ld_disponible,ld_planificado 
datetime ldt_fecha_fin_planificacion_minima,ldt_fecha_fin_planificacion_maxima

datastore ds_datos_planificacion
pointer oldpointer
//this.setredraw(false)
oldpointer = SetPointer(HourGlass!)//(AppStarting!)

ls_sel ="SELECT venliped.articulo, "+&
		  "		 articulos.familia, "+&
		  "       sum(isnull(planificacion.cantidad,0)) as planificado, "+&
		  "       min(planificacion.f_fin_estimada) as fecha_fin_planificacion_minima, "+&
		  "       max(planificacion.f_fin_estimada) as fecha_fin_planificacion_maxima "+&
		  "FROM  venped, "+&
		  "		venliped, "+&
		  "		articulos, "+&  
		  "		planificacion "+&
		  "WHERE ( venped.empresa    = venliped.empresa ) "+&
		  "AND   ( venped.anyo       = venliped.anyo ) "+&
		  "AND   ( venped.pedido     = venliped.pedido ) "+&
		  "AND   ( venliped.empresa  = articulos.empresa ) "+&
		  "AND   ( venliped.articulo = articulos.codigo ) "+&
		  "AND   ( articulos.empresa = planificacion.empresa ) "+&
		  "AND   ( articulos.codigo  = planificacion.cod_articulo ) "+&
		  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) "+&
		  "GROUP BY venliped.articulo, "+&
		  "		 articulos.familia "+&
		  "ORDER BY venliped.articulo "
	
ll_rows_datos_planificacion = f_cargar_cursor_transaccion(sqlca,ds_datos_planificacion,ls_sel)

//ds_datos.setfilter("situacion = 'F'")
//ds_datos.filter()

ll_total = ds_datos.rowcount()

for ll_indice = 1 to ll_total

	if ds_datos.object.disponible[ll_indice] = -1 and ds_datos.object.venliped_situacion[ll_indice] = 'F' then
		ll_donde_datos_planificacion = ds_datos_planificacion.find("venliped_articulo = '"+ds_datos.object.venliped_articulo[ll_indice]+"'",1,ll_rows_datos_planificacion)
		
		if ll_donde_datos_planificacion > 0 then
			ld_planificado                     = ds_datos_planificacion.object.planificado[ll_donde_datos_planificacion]
			ldt_fecha_fin_planificacion_minima = ds_datos_planificacion.object.fecha_fin_planificacion_minima[ll_donde_datos_planificacion]
			ldt_fecha_fin_planificacion_maxima = ds_datos_planificacion.object.fecha_fin_planificacion_maxima[ll_donde_datos_planificacion]
		else
			ld_planificado                     = 0
			setnull(ldt_fecha_fin_planificacion_minima)
			setnull(ldt_fecha_fin_planificacion_maxima)
		end if
		
		//Planificado					
		if ds_datos.object.articulos_familia[ll_indice] <> '2' then
			ds_datos.object.planificado[ll_indice]                    = ld_planificado
			setnull(ldt_fecha_fin_planificacion_minima)
			setnull(ldt_fecha_fin_planificacion_maxima)			
			
			li_anyo   = ds_datos.object.venped_anyo[ll_indice]
			ll_pedido = ds_datos.object.venped_pedido[ll_indice]
			ll_linea  = ds_datos.object.venliped_linea[ll_indice]
			
			select venliped.fentrega,
					 venliped.fentrega 
			into   :ldt_fecha_fin_planificacion_minima,
					 :ldt_fecha_fin_planificacion_maxima 
			from   venliped 
			where  venliped.empresa = :codigo_empresa 
			and    venliped.anyo    = :li_anyo 
			and    venliped.pedido  = :ll_pedido 
			and    venliped.linea   = :ll_linea;
			
			ds_datos.object.fecha_fin_planificacion_minima[ll_indice] = ldt_fecha_fin_planificacion_minima
			ds_datos.object.fecha_fin_planificacion_maxima[ll_indice] = ldt_fecha_fin_planificacion_maxima
			
		else
			ds_datos.object.planificado[ll_indice]                    = ld_planificado
			ds_datos.object.fecha_fin_planificacion_minima[ll_indice] = ldt_fecha_fin_planificacion_minima
			ds_datos.object.fecha_fin_planificacion_maxima[ll_indice] = ldt_fecha_fin_planificacion_maxima
		end if		
		
		ds_datos.object.disponible[ll_indice] = f_disponible_art_cal_tp_c( ds_datos.object.venped_empresa[ll_indice] ,&
																							ds_datos.object.venliped_articulo[ll_indice] ,&
																							ds_datos.object.venliped_calidad[ll_indice] ,&
																							ds_datos.object.venliped_tipo_pallet[ll_indice] ,&
																							ds_datos.object.venliped_caja[ll_indice] )

		if ds_datos.object.disponible[ll_indice] >= ds_datos.object.venliped_cantidad[ll_indice] then
			ds_datos.object.estado_linea[ll_indice] = 30 //Pdte Reservar
		else
			if ds_datos.object.planificado[ll_indice] > 0 and isnull(ldt_fecha_fin_planificacion_minima) then
				ds_datos.object.estado_linea[ll_indice] = 15 //Planificado sin Fecha
			else
				if ds_datos.object.planificado[ll_indice] > 0 then
					ds_datos.object.estado_linea[ll_indice] = 20 //Planificado
				else
					ds_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
				end if
			end if
			/*
			if isnull(ds_datos.object.fecha_fin[ll_indice]) then
				ds_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
			else
				ds_datos.object.estado_linea[ll_indice] = 20 //Planificado
			end if
			*/
			
		end if
							
		//case when articulos.familia = '2' then venliped.fentrega else null end )
							
		ls_find = "articulo    = '"+ds_datos.object.venliped_articulo[ll_indice]+"' and "+&
					 "calidad     = '"+ds_datos.object.venliped_calidad[ll_indice]+"' and "+&
					 "tipo_pallet = '"+ds_datos.object.venliped_tipo_pallet[ll_indice]+"' and "+&
					 "caja        = '"+ds_datos.object.venliped_caja[ll_indice]+"' and "+&
					 "situacion   = 'F'"
								 
		ll_donde = ll_indice																					
		do
			ll_donde ++
			ll_donde = ds_datos.find(ls_find,ll_donde,ll_total)
			if ll_donde > 0 then
				//Planificado					
				if ds_datos.object.articulos_familia[ll_indice] <> '2' then
					ds_datos.object.planificado[ll_donde]                    = ds_datos.object.planificado[ll_indice]
					
					li_anyo   = ds_datos.object.venped_anyo[ll_donde]
					ll_pedido = ds_datos.object.venped_pedido[ll_donde]
					ll_linea  = ds_datos.object.venliped_linea[ll_donde]
					
					select venliped.fentrega,
							 venliped.fentrega 
					into   :ldt_fecha_fin_planificacion_minima,
							 :ldt_fecha_fin_planificacion_maxima 
					from   venliped 
					where  venliped.empresa = :codigo_empresa 
					and    venliped.anyo    = :li_anyo 
					and    venliped.pedido  = :ll_pedido 
					and    venliped.linea   = :ll_linea;
					
					ds_datos.object.fecha_fin_planificacion_minima[ll_donde] = ldt_fecha_fin_planificacion_minima
					ds_datos.object.fecha_fin_planificacion_maxima[ll_donde] = ldt_fecha_fin_planificacion_maxima
										
				else
					ds_datos.object.planificado[ll_donde]                    = ds_datos.object.planificado[ll_indice]
					ds_datos.object.fecha_fin_planificacion_minima[ll_donde] = ds_datos.object.fecha_fin_planificacion_minima[ll_indice]
					ds_datos.object.fecha_fin_planificacion_maxima[ll_donde] = ds_datos.object.fecha_fin_planificacion_maxima[ll_indice]
				end if				
				
				ds_datos.object.disponible[ll_donde] = ds_datos.object.disponible[ll_indice]
				
				if ds_datos.object.disponible[ll_donde] >= ds_datos.object.venliped_cantidad[ll_donde] then
					ds_datos.object.estado_linea[ll_donde] = 30 //Pdte Reservar
				else
					if ds_datos.object.planificado[ll_donde] > 0 and isnull(ds_datos.object.fecha_fin_planificacion_minima[ll_donde]) then
						ds_datos.object.estado_linea[ll_donde] = 15 //Planificado sin Fecha
					else
						if ds_datos.object.planificado[ll_donde] > 0 then
							ds_datos.object.estado_linea[ll_donde] = 20 //Planificado
						else
							ds_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
						end if
					end if

					/*
					if isnull(ds_datos.object.fecha_fin[ll_donde]) then
						ds_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
					else
						ds_datos.object.estado_linea[ll_donde] = 20 //Planificado
					end if			
					*/
				end if				
								
			end if
		loop while ll_donde > 0 and ll_donde < ll_total
	end if
next

destroy ds_datos_planificacion

//ds_datos.setfilter("")
//ds_datos.filter()
//this.setredraw(true)
SetPointer(oldpointer)
*/
end subroutine

public subroutine f_calculo_disponibilidad_dw (datawindow ds_datos, string ls_filtro_cliente, string ls_filtro_envio, string ls_filtro_articulo_calidad, string ls_articulo, string ls_calidad);string ls_sel,ls_find
long ll_indice,ll_total,ll_donde,ll_rows,ll_rows_datos_planificacion,ll_donde_datos_planificacion,ll_pedido,ll_linea
int  li_anyo
dec  ld_disponible,ld_planificado 
datetime ldt_fecha_fin_planificacion_minima,ldt_fecha_fin_planificacion_maxima

datastore ds_datos_planificacion
pointer oldpointer
//this.setredraw(false)
oldpointer = SetPointer(HourGlass!)//(AppStarting!)

ls_sel ="SELECT venliped.articulo, "+&
		  "		 articulos.familia, "+&
		  "       sum(isnull(planificacion.cantidad,0)) as planificado, "+&
		  "       min(planificacion.f_fin_estimada) as fecha_fin_planificacion_minima, "+&
		  "       max(planificacion.f_fin_estimada) as fecha_fin_planificacion_maxima "+&
		  "FROM  venped, "+&
		  "		venliped, "+&
		  "		articulos, "+&  
		  "		planificacion "+&
		  "WHERE ( venped.empresa    = venliped.empresa ) "+&
		  "AND   ( venped.anyo       = venliped.anyo ) "+&
		  "AND   ( venped.pedido     = venliped.pedido ) "+&
		  "AND   ( venliped.empresa  = articulos.empresa ) "+&
		  "AND   ( venliped.articulo = articulos.codigo ) "+&
		  "AND   ( articulos.empresa = planificacion.empresa ) "+&
		  "AND   ( articulos.codigo  = planificacion.cod_articulo ) "+&
		  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) "+&
		  ls_filtro_cliente+&
		  ls_filtro_envio+&
		  ls_filtro_articulo_calidad+&
		  "GROUP BY venliped.articulo, "+&
		  "		 articulos.familia "+&
		  "ORDER BY venliped.articulo "
	
ll_rows_datos_planificacion = f_cargar_cursor_transaccion(sqlca,ds_datos_planificacion,ls_sel)

//ds_datos.setfilter("situacion = 'F'")
//ds_datos.filter()

ll_total = ds_datos.rowcount()

ls_find = "articulo    = '"+ls_articulo+"' and "+&
			 "calidad     = '"+ls_calidad+"' and "+&
			 "situacion   = 'F'"
						 
ll_donde = 0

do
	ll_donde ++
	ll_donde = ds_datos.find(ls_find,ll_donde,ll_total)
	if ll_donde > 0 then
		ds_datos.object.disponible[ll_donde] = -1
	end if
loop while ll_donde > 0 and ll_donde < ll_total	
	

ls_find = "articulo    = '"+ls_articulo+"' and "+&
			 "calidad     = '"+ls_calidad+"' and "+&
			 "situacion   = 'F' and "+&
			 "disponible  = -1"
						 
ll_donde = 0

do
	ll_donde ++
	ll_donde = ds_datos.find(ls_find,ll_donde,ll_total)
	if ll_donde > 0 then
		ll_indice = ll_donde
		ll_donde_datos_planificacion = ds_datos_planificacion.find("venliped_articulo = '"+ds_datos.object.articulo[ll_indice]+"'",1,ll_rows_datos_planificacion)
		
		if ll_donde_datos_planificacion > 0 then
			ld_planificado                     = ds_datos_planificacion.object.planificado[ll_donde_datos_planificacion]
			ldt_fecha_fin_planificacion_minima = ds_datos_planificacion.object.fecha_fin_planificacion_minima[ll_donde_datos_planificacion]
			ldt_fecha_fin_planificacion_maxima = ds_datos_planificacion.object.fecha_fin_planificacion_maxima[ll_donde_datos_planificacion]
		else
			ld_planificado                     = 0
			setnull(ldt_fecha_fin_planificacion_minima)
			setnull(ldt_fecha_fin_planificacion_maxima)
		end if
		
		//Planificado					
		if ds_datos.object.familia[ll_indice] <> '2' and ds_datos.object.familia[ll_indice] <> '6' then
			ds_datos.object.planificado[ll_indice]                    = ld_planificado
			setnull(ldt_fecha_fin_planificacion_minima)
			setnull(ldt_fecha_fin_planificacion_maxima)			
			
			li_anyo   = ds_datos.object.anyo[ll_indice]
			ll_pedido = ds_datos.object.pedido[ll_indice]
			ll_linea  = ds_datos.object.linea[ll_indice]
			
			select venliped.fentrega,
					 venliped.fentrega 
			into   :ldt_fecha_fin_planificacion_minima,
					 :ldt_fecha_fin_planificacion_maxima 
			from   venliped 
			where  venliped.empresa = :codigo_empresa 
			and    venliped.anyo    = :li_anyo 
			and    venliped.pedido  = :ll_pedido 
			and    venliped.linea   = :ll_linea;
			
			ds_datos.object.fecha_fin_planificacion_minima[ll_indice] = ldt_fecha_fin_planificacion_minima
			ds_datos.object.fecha_fin_planificacion_maxima[ll_indice] = ldt_fecha_fin_planificacion_maxima
			
		else
			ds_datos.object.planificado[ll_indice]                    = ld_planificado
			ds_datos.object.fecha_fin_planificacion_minima[ll_indice] = ldt_fecha_fin_planificacion_minima
			ds_datos.object.fecha_fin_planificacion_maxima[ll_indice] = ldt_fecha_fin_planificacion_maxima
		end if		
		
		ds_datos.object.disponible[ll_indice] = f_disponible_art_cal_tp_c( ds_datos.object.empresa[ll_indice] ,&
																							ds_datos.object.articulo[ll_indice] ,&
																							ds_datos.object.calidad[ll_indice] ,&
																							ds_datos.object.tipo_pallet[ll_indice] ,&
																							ds_datos.object.caja[ll_indice] )

		ds_datos.object.disponible_pzs[ll_indice] = f_disponible_art_cal_tp_c_pzs( ds_datos.object.empresa[ll_indice] ,&
																							ds_datos.object.articulo[ll_indice] ,&
																							ds_datos.object.calidad[ll_indice] ,&
																							ds_datos.object.tipo_pallet[ll_indice] ,&
																							ds_datos.object.caja[ll_indice] )

		if ds_datos.object.tipo_pallet[ll_indice] <> '00000' then
			//Vamos a añadir el disponible en ubicaciones con el pallet '00000' (Sin pallet, ubicaciones con bulto asignado)
			ds_datos.object.disponible_pzs[ll_indice] = ds_datos.object.disponible_pzs[ll_indice] +&
																		f_disponible_art_cal_tp_c_pzs( ds_datos.object.empresa[ll_indice] ,&
																								ds_datos.object.articulo[ll_indice] ,&
																								ds_datos.object.calidad[ll_indice] ,&
																								'00000' ,&																								
																								ds_datos.object.caja[ll_indice] )			
																								
			ds_datos.object.disponible[ll_indice]     = ds_datos.object.disponible[ll_indice] +&
																		f_disponible_art_cal_tp_c( ds_datos.object.empresa[ll_indice] ,&
																								ds_datos.object.articulo[ll_indice] ,&
																								ds_datos.object.calidad[ll_indice] ,&
																								'00000' ,&
																								ds_datos.object.caja[ll_indice] )																								
		end if																						

		//if ds_datos.object.disponible[ll_indice] >= ds_datos.object.cantidad[ll_indice] then
		if ( ds_datos.object.gestionar_en_piezas[ll_indice] = 'N' and ds_datos.object.disponible[ll_indice] >= ds_datos.object.cantidad[ll_indice] ) or ( ds_datos.object.gestionar_en_piezas[ll_indice] = 'S' and ds_datos.object.disponible_pzs[ll_indice] >= ds_datos.object.cantidad_pzs[ll_indice] ) then
			ds_datos.object.estado_linea[ll_indice] = 30 //Pdte Reservar
		else
			if ds_datos.object.planificado[ll_indice] > 0 and isnull(ldt_fecha_fin_planificacion_minima) then
				ds_datos.object.estado_linea[ll_indice] = 15 //Planificado sin Fecha
			else
				if ds_datos.object.planificado[ll_indice] > 0 then
					ds_datos.object.estado_linea[ll_indice] = 20 //Planificado
				else
					ds_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
				end if
			end if
			/*
			if isnull(ds_datos.object.fecha_fin[ll_indice]) then
				ds_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
			else
				ds_datos.object.estado_linea[ll_indice] = 20 //Planificado
			end if
			*/
			
		end if
							
		//case when articulos.familia = '2' then venliped.fentrega else null end )
							
		ls_find = "articulo    = '"+ds_datos.object.articulo[ll_indice]+"' and "+&
					 "calidad     = '"+ds_datos.object.calidad[ll_indice]+"' and "+&
					 "tipo_pallet = '"+ds_datos.object.tipo_pallet[ll_indice]+"' and "+&
					 "caja        = '"+ds_datos.object.caja[ll_indice]+"' and "+&
					 "situacion   = 'F'"
								 
		ll_donde = ll_indice																					
		do
			ll_donde ++
			ll_donde = ds_datos.find(ls_find,ll_donde,ll_total)
			if ll_donde > 0 then
				//Planificado					
				if ds_datos.object.familia[ll_indice] <> '2' and ds_datos.object.familia[ll_indice] <> '6' then
					ds_datos.object.planificado[ll_donde]                    = ds_datos.object.planificado[ll_indice]
					
					li_anyo   = ds_datos.object.anyo[ll_donde]
					ll_pedido = ds_datos.object.pedido[ll_donde]
					ll_linea  = ds_datos.object.linea[ll_donde]
					
					select venliped.fentrega,
							 venliped.fentrega 
					into   :ldt_fecha_fin_planificacion_minima,
							 :ldt_fecha_fin_planificacion_maxima 
					from   venliped 
					where  venliped.empresa = :codigo_empresa 
					and    venliped.anyo    = :li_anyo 
					and    venliped.pedido  = :ll_pedido 
					and    venliped.linea   = :ll_linea;
					
					ds_datos.object.fecha_fin_planificacion_minima[ll_donde] = ldt_fecha_fin_planificacion_minima
					ds_datos.object.fecha_fin_planificacion_maxima[ll_donde] = ldt_fecha_fin_planificacion_maxima
										
				else
					ds_datos.object.planificado[ll_donde]                    = ds_datos.object.planificado[ll_indice]
					ds_datos.object.fecha_fin_planificacion_minima[ll_donde] = ds_datos.object.fecha_fin_planificacion_minima[ll_indice]
					ds_datos.object.fecha_fin_planificacion_maxima[ll_donde] = ds_datos.object.fecha_fin_planificacion_maxima[ll_indice]
				end if				
				
				ds_datos.object.disponible[ll_donde] = ds_datos.object.disponible[ll_indice]
				ds_datos.object.disponible_pzs[ll_donde] = ds_datos.object.disponible_pzs[ll_indice]
				
				//if ds_datos.object.disponible[ll_donde] >= ds_datos.object.cantidad[ll_donde] then
				if ( ds_datos.object.gestionar_en_piezas[ll_donde] = 'N' and ds_datos.object.disponible[ll_donde] >= ds_datos.object.cantidad[ll_donde] ) or ( ds_datos.object.gestionar_en_piezas[ll_donde] = 'S' and ds_datos.object.disponible_pzs[ll_donde] >= ds_datos.object.cantidad_pzs[ll_donde] ) then
					ds_datos.object.estado_linea[ll_donde] = 30 //Pdte Reservar
				else
					if ds_datos.object.planificado[ll_donde] > 0 and isnull(ds_datos.object.fecha_fin_planificacion_minima[ll_donde]) then
						ds_datos.object.estado_linea[ll_donde] = 15 //Planificado sin Fecha
					else
						if ds_datos.object.planificado[ll_donde] > 0 then
							ds_datos.object.estado_linea[ll_donde] = 20 //Planificado
						else
							ds_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
						end if
					end if

					/*
					if isnull(ds_datos.object.fecha_fin[ll_donde]) then
						ds_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
					else
						ds_datos.object.estado_linea[ll_donde] = 20 //Planificado
					end if			
					*/
				end if				
								
			end if
		loop while ll_donde > 0 and ll_donde < ll_total
	end if
loop while ll_donde > 0 and ll_donde < ll_total		

destroy ds_datos_planificacion

//ds_datos.setfilter("")
//ds_datos.filter()
//this.setredraw(true)
SetPointer(oldpointer)
end subroutine

public subroutine f_cargar_reparto_fabricaciones (long arg_row);String articulo, cliente, banda_seleccionada, peso_seleccionadas, calidad, tono, unidad, caja, tipo_pallet, formato
Int calibre, pedido_anyo, pedido_linea
Long i, j, posicion, maximo_valor_dw, nuevo_codigo, fila_dw, actual, fin
Dec stock, anyo, pedido, pedido_codigo, cantidad_pedido
String orden_carga,ls_situacion
string sel
datastore pedidos, planificado
datetime fecha_planificado
long cantidad_planificada

setnull(fecha_planificado)

dwtc_reparto_fabricaciones.visible = true
dwtc_reparto_fabricaciones.reset()
articulo = dw_datos.object.articulo[arg_row]

sel = " SELECT genter.razon "+&
		" , venliped.anyo "+&
		" , venliped.pedido "+&
		" , venliped.linea "+&
		" , venliped.fpedido "+&
		" ,  CASE venliped.tipo_unidad "+&
		"		WHEN 0 THEN venliped.cantidad  "+&
		"		WHEN 1 THEN ( venliped.cantidad / metroscaja ) * piezascaja "+&
		"	END AS Cantidad "+&
		" , venliped.situacion "+&
		" ,  0 as planificacion_cantidad "+&
		" , '' as fecha " +&
		" FROM venliped "+&
		" INNER JOIN genter ON venliped.empresa = genter.empresa AND venliped.cliente = genter.codigo "+&
		" INNER JOIN almartcajas ON venliped.empresa = almartcajas.empresa AND venliped.articulo = almartcajas.articulo AND venliped.caja = almartcajas.caja "+&
		" INNER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo  AND venliped.pedido = venped.pedido "+&
		" WHERE genter.tipoter = 'C' "+&
		" AND venliped.situacion = 'F' "+&
		" AND venped.es_proforma = 'N' "+&
		" AND venliped.articulo = '"+articulo+"' "+&
		" ORDER BY  venliped.fpedido, venliped.anyo, venliped.pedido, venliped.linea "
		
f_cargar_cursor_transaccion(sqlca,pedidos,sel)
	
if pedidos.rowcount() > 0 then
	dwtc_reparto_fabricaciones.object.data = pedidos.object.data
end if

sel = " SELECT cantidad, f_fin_estimada "+&
		" FROM planificacion "+&
		" WHERE planificacion.cod_articulo = '"+articulo+"' "+&
		" AND planificacion.f_fin_estimada IS NOT NULL "+&
		" ORDER BY planificacion.f_fin_estimada"
		
f_cargar_cursor_transaccion(sqlca,planificado,sel)

j= 1
cantidad_planificada = 0
for i = 1 to planificado.rowcount()
	cantidad_planificada = cantidad_planificada  + planificado.object.cantidad[i]
	do while cantidad_planificada >= dwtc_reparto_fabricaciones.object.acumulado[j] and j <= dwtc_reparto_fabricaciones.rowcount()
			dwtc_reparto_fabricaciones.object.fecha[j] = string (planificado.object.f_fin_estimada[i], "dd-mm-yyyy")
		//	messagebox ("",string (planificado.object.f_fin_estimada[i], "dd-mm-yyyy"))
			j++
	loop
next

destroy planificado
destroy pedidos	


end subroutine

public subroutine f_calculo_disponibilidad_dw_old (datawindow ds_datos, string ls_filtro_cliente, string ls_filtro_envio, string ls_filtro_articulo_calidad, string ls_articulo, string ls_calidad);string ls_sel,ls_find
long ll_indice,ll_total,ll_donde,ll_rows,ll_rows_datos_planificacion,ll_donde_datos_planificacion,ll_pedido,ll_linea
int  li_anyo
dec  ld_disponible,ld_planificado 
datetime ldt_fecha_fin_planificacion_minima,ldt_fecha_fin_planificacion_maxima

datastore ds_datos_planificacion
pointer oldpointer
//this.setredraw(false)
oldpointer = SetPointer(HourGlass!)//(AppStarting!)

ls_sel ="SELECT venliped.articulo, "+&
		  "		 articulos.familia, "+&
		  "       sum(isnull(planificacion.cantidad,0)) as planificado, "+&
		  "       min(planificacion.f_fin_estimada) as fecha_fin_planificacion_minima, "+&
		  "       max(planificacion.f_fin_estimada) as fecha_fin_planificacion_maxima "+&
		  "FROM  venped, "+&
		  "		venliped, "+&
		  "		articulos, "+&  
		  "		planificacion "+&
		  "WHERE ( venped.empresa    = venliped.empresa ) "+&
		  "AND   ( venped.anyo       = venliped.anyo ) "+&
		  "AND   ( venped.pedido     = venliped.pedido ) "+&
		  "AND   ( venliped.empresa  = articulos.empresa ) "+&
		  "AND   ( venliped.articulo = articulos.codigo ) "+&
		  "AND   ( articulos.empresa = planificacion.empresa ) "+&
		  "AND   ( articulos.codigo  = planificacion.cod_articulo ) "+&
		  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) "+&
		  ls_filtro_cliente+&
		  ls_filtro_envio+&
		  ls_filtro_articulo_calidad+&
		  "GROUP BY venliped.articulo, "+&
		  "		 articulos.familia "+&
		  "ORDER BY venliped.articulo "
	
ll_rows_datos_planificacion = f_cargar_cursor_transaccion(sqlca,ds_datos_planificacion,ls_sel)

//ds_datos.setfilter("situacion = 'F'")
//ds_datos.filter()

ll_total = ds_datos.rowcount()

ls_find = "articulo    = '"+ls_articulo+"' and "+&
			 "calidad     = '"+ls_calidad+"' and "+&
			 "situacion   = 'F'"
						 
ll_donde = 0

do
	ll_donde ++
	ll_donde = ds_datos.find(ls_find,ll_donde,ll_total)
	if ll_donde > 0 then
		ds_datos.object.disponible[ll_donde] = -1
	end if
loop while ll_donde > 0 and ll_donde < ll_total	
	
//for ll_indice = 1 to ll_total
//	if ds_datos.object.situacion[ll_indice] = 'F' and ds_datos.object.articulo[ll_indice] = ls_articulo and ds_datos.object.calidad[ll_indice] = ls_calidad then
//		ds_datos.object.disponible[ll_indice] = -1
//	end if		
//next

for ll_indice = 1 to ll_total	
	//if ds_datos.object.situacion[ll_indice] = 'F' and ds_datos.object.articulo[ll_indice] = ls_articulo and ds_datos.object.calidad[ll_indice] = ls_calidad then
	if ds_datos.object.disponible[ll_indice] = -1 and  ds_datos.object.situacion[ll_indice] = 'F' then
		ll_donde_datos_planificacion = ds_datos_planificacion.find("venliped_articulo = '"+ds_datos.object.articulo[ll_indice]+"'",1,ll_rows_datos_planificacion)
		
		if ll_donde_datos_planificacion > 0 then
			ld_planificado                     = ds_datos_planificacion.object.planificado[ll_donde_datos_planificacion]
			ldt_fecha_fin_planificacion_minima = ds_datos_planificacion.object.fecha_fin_planificacion_minima[ll_donde_datos_planificacion]
			ldt_fecha_fin_planificacion_maxima = ds_datos_planificacion.object.fecha_fin_planificacion_maxima[ll_donde_datos_planificacion]
		else
			ld_planificado                     = 0
			setnull(ldt_fecha_fin_planificacion_minima)
			setnull(ldt_fecha_fin_planificacion_maxima)
		end if
		
		//Planificado					
		if ds_datos.object.familia[ll_indice] <> '2' then
			ds_datos.object.planificado[ll_indice]                    = ld_planificado
			setnull(ldt_fecha_fin_planificacion_minima)
			setnull(ldt_fecha_fin_planificacion_maxima)			
			
			li_anyo   = ds_datos.object.anyo[ll_indice]
			ll_pedido = ds_datos.object.pedido[ll_indice]
			ll_linea  = ds_datos.object.linea[ll_indice]
			
			select venliped.fentrega,
					 venliped.fentrega 
			into   :ldt_fecha_fin_planificacion_minima,
					 :ldt_fecha_fin_planificacion_maxima 
			from   venliped 
			where  venliped.empresa = :codigo_empresa 
			and    venliped.anyo    = :li_anyo 
			and    venliped.pedido  = :ll_pedido 
			and    venliped.linea   = :ll_linea;
			
			ds_datos.object.fecha_fin_planificacion_minima[ll_indice] = ldt_fecha_fin_planificacion_minima
			ds_datos.object.fecha_fin_planificacion_maxima[ll_indice] = ldt_fecha_fin_planificacion_maxima
			
		else
			ds_datos.object.planificado[ll_indice]                    = ld_planificado
			ds_datos.object.fecha_fin_planificacion_minima[ll_indice] = ldt_fecha_fin_planificacion_minima
			ds_datos.object.fecha_fin_planificacion_maxima[ll_indice] = ldt_fecha_fin_planificacion_maxima
		end if		
		
		ds_datos.object.disponible[ll_indice] = f_disponible_art_cal_tp_c( ds_datos.object.empresa[ll_indice] ,&
																							ds_datos.object.articulo[ll_indice] ,&
																							ds_datos.object.calidad[ll_indice] ,&
																							ds_datos.object.tipo_pallet[ll_indice] ,&
																							ds_datos.object.caja[ll_indice] )

		ds_datos.object.disponible_pzs[ll_indice] = f_disponible_art_cal_tp_c_pzs( ds_datos.object.empresa[ll_indice] ,&
																							ds_datos.object.articulo[ll_indice] ,&
																							ds_datos.object.calidad[ll_indice] ,&
																							ds_datos.object.tipo_pallet[ll_indice] ,&
																							ds_datos.object.caja[ll_indice] )

		if ds_datos.object.tipo_pallet[ll_indice] <> '00000' then
			//Vamos a añadir el disponible en ubicaciones con el pallet '00000' (Sin pallet, ubicaciones con bulto asignado)
			ds_datos.object.disponible_pzs[ll_indice] = ds_datos.object.disponible_pzs[ll_indice] +&
																		f_disponible_art_cal_tp_c_pzs( ds_datos.object.empresa[ll_indice] ,&
																								ds_datos.object.articulo[ll_indice] ,&
																								ds_datos.object.calidad[ll_indice] ,&
																								'00000' ,&																								
																								ds_datos.object.caja[ll_indice] )			
																								
			ds_datos.object.disponible[ll_indice]     = ds_datos.object.disponible[ll_indice] +&
																		f_disponible_art_cal_tp_c( ds_datos.object.empresa[ll_indice] ,&
																								ds_datos.object.articulo[ll_indice] ,&
																								ds_datos.object.calidad[ll_indice] ,&
																								'00000' ,&
																								ds_datos.object.caja[ll_indice] )																								
		end if																						

		//if ds_datos.object.disponible[ll_indice] >= ds_datos.object.cantidad[ll_indice] then
		if ( ds_datos.object.gestionar_en_piezas[ll_indice] = 'N' and ds_datos.object.disponible[ll_indice] >= ds_datos.object.cantidad[ll_indice] ) or ( ds_datos.object.gestionar_en_piezas[ll_indice] = 'S' and ds_datos.object.disponible_pzs[ll_indice] >= ds_datos.object.cantidad_pzs[ll_indice] ) then
			ds_datos.object.estado_linea[ll_indice] = 30 //Pdte Reservar
		else
			if ds_datos.object.planificado[ll_indice] > 0 and isnull(ldt_fecha_fin_planificacion_minima) then
				ds_datos.object.estado_linea[ll_indice] = 15 //Planificado sin Fecha
			else
				if ds_datos.object.planificado[ll_indice] > 0 then
					ds_datos.object.estado_linea[ll_indice] = 20 //Planificado
				else
					ds_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
				end if
			end if
			/*
			if isnull(ds_datos.object.fecha_fin[ll_indice]) then
				ds_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
			else
				ds_datos.object.estado_linea[ll_indice] = 20 //Planificado
			end if
			*/
			
		end if
							
		//case when articulos.familia = '2' then venliped.fentrega else null end )
							
		ls_find = "articulo    = '"+ds_datos.object.articulo[ll_indice]+"' and "+&
					 "calidad     = '"+ds_datos.object.calidad[ll_indice]+"' and "+&
					 "tipo_pallet = '"+ds_datos.object.tipo_pallet[ll_indice]+"' and "+&
					 "caja        = '"+ds_datos.object.caja[ll_indice]+"' and "+&
					 "situacion   = 'F'"
								 
		ll_donde = ll_indice																					
		do
			ll_donde ++
			ll_donde = ds_datos.find(ls_find,ll_donde,ll_total)
			if ll_donde > 0 then
				//Planificado					
				if ds_datos.object.familia[ll_indice] <> '2' then
					ds_datos.object.planificado[ll_donde]                    = ds_datos.object.planificado[ll_indice]
					
					li_anyo   = ds_datos.object.anyo[ll_donde]
					ll_pedido = ds_datos.object.pedido[ll_donde]
					ll_linea  = ds_datos.object.linea[ll_donde]
					
					select venliped.fentrega,
							 venliped.fentrega 
					into   :ldt_fecha_fin_planificacion_minima,
							 :ldt_fecha_fin_planificacion_maxima 
					from   venliped 
					where  venliped.empresa = :codigo_empresa 
					and    venliped.anyo    = :li_anyo 
					and    venliped.pedido  = :ll_pedido 
					and    venliped.linea   = :ll_linea;
					
					ds_datos.object.fecha_fin_planificacion_minima[ll_donde] = ldt_fecha_fin_planificacion_minima
					ds_datos.object.fecha_fin_planificacion_maxima[ll_donde] = ldt_fecha_fin_planificacion_maxima
										
				else
					ds_datos.object.planificado[ll_donde]                    = ds_datos.object.planificado[ll_indice]
					ds_datos.object.fecha_fin_planificacion_minima[ll_donde] = ds_datos.object.fecha_fin_planificacion_minima[ll_indice]
					ds_datos.object.fecha_fin_planificacion_maxima[ll_donde] = ds_datos.object.fecha_fin_planificacion_maxima[ll_indice]
				end if				
				
				ds_datos.object.disponible[ll_donde] = ds_datos.object.disponible[ll_indice]
				ds_datos.object.disponible_pzs[ll_donde] = ds_datos.object.disponible_pzs[ll_indice]
				
				//if ds_datos.object.disponible[ll_donde] >= ds_datos.object.cantidad[ll_donde] then
				if ( ds_datos.object.gestionar_en_piezas[ll_donde] = 'N' and ds_datos.object.disponible[ll_donde] >= ds_datos.object.cantidad[ll_donde] ) or ( ds_datos.object.gestionar_en_piezas[ll_donde] = 'S' and ds_datos.object.disponible_pzs[ll_donde] >= ds_datos.object.cantidad_pzs[ll_donde] ) then
					ds_datos.object.estado_linea[ll_donde] = 30 //Pdte Reservar
				else
					if ds_datos.object.planificado[ll_donde] > 0 and isnull(ds_datos.object.fecha_fin_planificacion_minima[ll_donde]) then
						ds_datos.object.estado_linea[ll_donde] = 15 //Planificado sin Fecha
					else
						if ds_datos.object.planificado[ll_donde] > 0 then
							ds_datos.object.estado_linea[ll_donde] = 20 //Planificado
						else
							ds_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
						end if
					end if

					/*
					if isnull(ds_datos.object.fecha_fin[ll_donde]) then
						ds_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
					else
						ds_datos.object.estado_linea[ll_donde] = 20 //Planificado
					end if			
					*/
				end if				
								
			end if
		loop while ll_donde > 0 and ll_donde < ll_total
	end if
next

destroy ds_datos_planificacion

//ds_datos.setfilter("")
//ds_datos.filter()
//this.setredraw(true)
SetPointer(oldpointer)
end subroutine

on wtc_consulta_situacion_pedidos.create
int iCurrent
call super::create
this.st_reservado=create st_reservado
this.pb_grabar_obs=create pb_grabar_obs
this.st_1=create st_1
this.dw_etiquetas_bultos_100=create dw_etiquetas_bultos_100
this.cbx_resumen=create cbx_resumen
this.dw_stock=create dw_stock
this.dwtc_reparto_fabricaciones=create dwtc_reparto_fabricaciones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_reservado
this.Control[iCurrent+2]=this.pb_grabar_obs
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_etiquetas_bultos_100
this.Control[iCurrent+5]=this.cbx_resumen
this.Control[iCurrent+6]=this.dw_stock
this.Control[iCurrent+7]=this.dwtc_reparto_fabricaciones
end on

on wtc_consulta_situacion_pedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_reservado)
destroy(this.pb_grabar_obs)
destroy(this.st_1)
destroy(this.dw_etiquetas_bultos_100)
destroy(this.cbx_resumen)
destroy(this.dw_stock)
destroy(this.dwtc_reparto_fabricaciones)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)


/*
sql_inicial = "select almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura,  "+&
"		alm_bultos_lineas.articulo, articulos.descripcion, formatos.abreviado, genter.razon,  "+&
"		alm_bultos_lineas.calidad, alm_bultos_lineas.tono, alm_bultos_lineas.calibre, alm_bultos_lineas.caja,  "+&
"		sum (alm_bultos_lineas.cantidad), alm_bultos.anyo_orden_carga, alm_bultos.codigo_orden_carga, alm_bultos.observaciones "+&
" from alm_bultos_lineas "+&
" inner join articulos on alm_bultos_lineas.empresa = articulos.empresa and alm_bultos_lineas.articulo = articulos.codigo "+&
" inner join formatos on articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo "+&
" inner join alm_bultos on alm_bultos_lineas.empresa = alm_bultos.empresa and alm_bultos_lineas.id_alm_bultos = alm_bultos.id  "+&
" inner join almubimapa_codbar on alm_bultos.empresa = almubimapa_codbar.empresa and alm_bultos.id_ubicacion = almubimapa_codbar.id "+&
" left outer join orden_carga on  orden_carga.empresa = alm_bultos.empresa and orden_carga.anyo = alm_bultos.anyo_orden_carga  and orden_carga.codigo = alm_bultos.codigo_orden_carga   "+&
" left outer join genter on genter.empresa = orden_carga.empresa and genter.codigo = orden_carga.cliente and genter.tipoter = 'C' "+&
"WHERE almacenmovimientos.empresa = '"+codigo_empresa+"' "

sql_final = "group by genter.razon, almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura, "+&
"		alm_bultos_lineas.articulo, articulos.descripcion, formatos.abreviado, genter.razon,  "+&
"		alm_bultos_lineas.calidad, alm_bultos_lineas.tono, alm_bultos_lineas.calibre, alm_bultos_lineas.caja, "+&
" 	alm_bultos.anyo_orden_carga, alm_bultos.codigo_orden_carga, alm_bultos.observaciones "+&
" order by almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura "

*/

/*
select almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura, 
		alm_bultos_lineas.articulo, articulos.descripcion, formatos.abreviado, genter.razon, 
		alm_bultos_lineas.calidad, alm_bultos_lineas.tono, alm_bultos_lineas.calibre, alm_bultos_lineas.caja, 
		sum (alm_bultos_lineas.cantidad), alm_bultos.anyo_orden_carga, alm_bultos.codigo_orden_carga, alm_bultos.observaciones
from alm_bultos_lineas
inner join articulos on alm_bultos_lineas.empresa = articulos.empresa and alm_bultos_lineas.articulo = articulos.codigo
inner join formatos on articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo
inner join alm_bultos on alm_bultos_lineas.empresa = alm_bultos.empresa and alm_bultos_lineas.id_alm_bultos = alm_bultos.id 
inner join almubimapa_codbar on alm_bultos.empresa = almubimapa_codbar.empresa and alm_bultos.id_ubicacion = almubimapa_codbar.id
left outer join orden_carga on  orden_carga.empresa = alm_bultos.empresa and orden_carga.anyo = alm_bultos.anyo_orden_carga  and orden_carga.codigo = alm_bultos.codigo_orden_carga  
left outer join genter on genter.empresa = orden_carga.empresa and genter.codigo = orden_carga.cliente and genter.tipoter = 'C'
group by genter.razon, almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura,
		alm_bultos_lineas.articulo, articulos.descripcion, formatos.abreviado, genter.razon, 
		alm_bultos_lineas.calidad, alm_bultos_lineas.tono, alm_bultos_lineas.calibre, alm_bultos_lineas.caja,
 	alm_bultos.anyo_orden_carga, alm_bultos.codigo_orden_carga, alm_bultos.observaciones
order by almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura;

*/







end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_situacion_pedidos
integer x = 3621
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_situacion_pedidos
integer x = 3863
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_situacion_pedidos
integer x = 4064
integer y = 96
integer taborder = 0
end type

event pb_imprimir::clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = ""
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

//Con esto forzamos a que el reporte se ajuste al tamaño del papel
//dw_detalle.Object.DataWindow.Zoom = 100

//dw_datos.modify("observaciones_pedido.visible = 1")

u_imp.event ue_imprimir(dw_datos)

//dw_datos.modify("observaciones_pedido.visible = 0")

destroy u_imp
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_situacion_pedidos
integer x = 4219
integer y = 96
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_situacion_pedidos
integer width = 4622
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_situacion_pedidos
integer x = 3913
integer y = 96
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

st_reservado.text = ''

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
filtro_dw = "1 = 1"
For j = 1 To dw_montaje_filtro.rowcount()
	if dw_montaje_filtro.object.aplicar_a_sql[j] = 'N' then
	//if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
		filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
	//end if
	end if
Next
dw_datos.setfilter(filtro_dw)
dw_datos.filter()
dw_datos.sort()
dw_datos.groupcalc()

//if dw_montaje_filtro.rowcount() > 3 then
//	dw_montaje_filtro.height = dw_montaje_filtro.height -75
//	dw_datos.y = dw_datos.y - 75
//	dw_datos.height = dw_datos.height + 75
//else
//	dw_datos.y = 512
//	dw_datos.height = 2192
//	dw_montaje_filtro.height = 225
//end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_situacion_pedidos
integer x = 4375
integer y = 96
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_situacion_pedidos
integer x = 3762
integer y = 96
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila,posicion,anyo
long i, j, k, filas,ll_indice,ll_total,pedido
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw,ls_aplicar_a_sql = 'S'
boolean crear_filtro

sql_inicial = f_construir_consulta ()
sql_final = f_construir_group_by ()
st_reservado.text = ''

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Piezas Sueltas"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " articulos.promocion = 'N' and venliped.tipolinea = '4' "
							cadena_or_visible = " Piezas Sueltas "
						else
							cadena_or = "  "
							cadena_or_visible = "  "
						end if
					end if
				end if				
			next			
		CASE "Sin Fecha Entrega"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " venped.fentrega is null "
							cadena_or_visible = " Sin Fecha Entrega "				
						else
							cadena_or = " venped.fentrega is not null "
							cadena_or_visible = " Con Fecha Entrega "					
						end if
					end if
				end if				
			next				
		
		
		case "Courier"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " venped.es_courier = 'S' "
							cadena_or_visible = " Courier "
						else
							cadena_or = " venped.es_courier = 'N' "
							cadena_or_visible = "  No courier "
						end if
					end if
				end if				
			next		
			
		CASE "Orden de carga"
			if cadena_or = '' then
				descripcion_extra = ""

				cadena_or = " venliped.id_alm_orden_carga "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Orden Carga "+ddlb_operador.text+" "+sle_valor1.text+" "
			end if			
		case "Agente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " venped.agente1 = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Agente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR venped.agente1 = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 				
		case "Artículo (Descripción)"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " venliped.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Articulo = "+dw_filtro.object.#1[i]+" "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR venliped.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#1[i]//+" "+dw_filtro.object.#2[i] //Demasiado largo
					end if
				end if
			next 
		case "Artículo (Código)"
			if cadena_or = '' then
				descripcion_extra = ""
				SELECT descripcion INTO :descripcion_extra FROM articulos WHERE empresa = :codigo_empresa AND codigo = :sle_valor1.text;
				cadena_or = " venliped.articulo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Artículo "+ddlb_operador.text+" '"+sle_valor1.text+" "+descripcion_extra+"' "
			end if
		case "Fecha"
			if cadena_or = '' then
				cadena_or = " venped.fpedido "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha "+ddlb_operador.text+" '"+em_fecha1.text+"' "
			end if
		case "Fecha Carga"
			if cadena_or = '' then
				cadena_or = " alm_orden_carga.fecha "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Carga "+ddlb_operador.text+" '"+em_fecha1.text+"' "
			end if
		case "Fecha Entrega"
			if cadena_or = '' then
				cadena_or = " venped.fentrega "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Entrega "+ddlb_operador.text+" '"+em_fecha1.text+"' "
			end if			
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
		case "País"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " genter.pais = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " País = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR genter.pais = '"+dw_filtro.object.#1[i]+"' "
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
		case "Situación"
			ls_aplicar_a_sql = 'N'
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						choose case lb_lista.Text (k)
							case "Rotura Stock"
								cadena_or = " estado_linea = 10 "
							case "Planificado Sin Fecha"
								cadena_or = " estado_linea = 15 "								
							case "Planificado"
								cadena_or = " estado_linea = 20 "
							case "Pdte. Reserva"
								cadena_or = " estado_linea = 30 "
							case "Reservado"
								cadena_or = " estado_linea = 40 "
							case "Preparado"
								cadena_or = " estado_linea = 50 "
						end choose
						cadena_or_visible = " Situación: "+lb_lista.Text (k)
					end if
				end if			
			next	
		case "Pedido (Año/Pedido)"
			if cadena_or = '' then
				posicion = pos(lower(sle_valor1.text), '/')
				if posicion > 0 then
					anyo = Integer(mid(sle_valor1.text, 1, posicion - 1))
					pedido = dec(mid(sle_valor1.text, posicion + 1))
					cadena_or = " venliped.anyo "+ddlb_operador.text+" "+String(anyo)+" AND venliped.pedido "+ddlb_operador.text+" "+String(pedido)
					cadena_or_visible = " Pedido "+ddlb_operador.text+" "+sle_valor1.text
				else
					cadena_or = " 0 = 1 "
					cadena_or_visible = " Pedido "+ddlb_operador.text+" "+sle_valor1.text					
					MessageBox("Error", "Debe introducir el código del Pedido en Formato AÑO/PEDIDO")
				end if
			end if
		case "Familia"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " EXISTS (SELECT * FROM venliped vfam WHERE vfam.empresa = venliped.empresa AND vfam.anyo = venliped.anyo AND vfam.pedido = venliped.pedido AND vfam.familia = '"+dw_filtro.object.#1[i]+"')"
						cadena_or_visible = " Familia = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR EXISTS (SELECT * FROM venliped vfam WHERE vfam.empresa = venliped.empresa AND vfam.anyo = venliped.anyo AND vfam.pedido = venliped.pedido AND vfam.familia = '"+dw_filtro.object.#1[i]+"')"
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 	
		CASE "Situación Pedido O.C."
//Lineas de pedidos de pedidos totalmente en O.C.
//			select venliped.anyo,
//					 venliped.pedido,
//					 venliped.linea,
//					 venliped.descripcion,''
//			from   venliped
//			where  venliped.empresa = '1'
//			and not exists (select venliped_oc.anyo,
//										 venliped_oc.pedido 
//								from   venliped as venliped_oc 
//								where  venliped_oc.empresa = venliped.empresa 
//								and    venliped_oc.anyo    = venliped.anyo 
//								and    venliped_oc.pedido  = venliped.pedido 
//								and    isnull(venliped_oc.id_alm_orden_carga,0) = 0
//								group by venliped_oc.anyo,
//											venliped_oc.pedido)
//			order by venliped.anyo,
//						venliped.pedido,
//						venliped.linea,
//						venliped.descripcion;			

//Lineas de pedidos de pedidos con alguna linea sin O.C.
//			select venliped.anyo,
//					 venliped.pedido,
//					 venliped.linea,
//					 venliped.descripcion,''
//			from   venliped
//			where  venliped.empresa = '1'
//			and    venliped.anyo    = 2018
//			and    exists (select venliped_oc.anyo,
//										 venliped_oc.pedido 
//								from   venliped as venliped_oc 
//								where  venliped_oc.empresa = venliped.empresa 
//								and    venliped_oc.anyo    = venliped.anyo 
//								and    venliped_oc.pedido  = venliped.pedido 
//								and    isnull(venliped_oc.id_alm_orden_carga,0) = 0
//								group by venliped_oc.anyo,
//											venliped_oc.pedido)
//			order by venliped.anyo,
//						venliped.pedido,
//						venliped.linea,
//						venliped.descripcion;
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						choose case lb_lista.Text (k)
							case "Pedidos con O.C."
								cadena_or = "  not exists (select venliped_oc.anyo, "+&
												"							 venliped_oc.pedido "+&
												"					from   venliped as venliped_oc "+&
												"					where  venliped_oc.empresa = venliped.empresa "+&
												"					and    venliped_oc.anyo    = venliped.anyo "+&
												"					and    venliped_oc.pedido  = venliped.pedido "+&
												"					and    isnull(venliped_oc.id_alm_orden_carga,0) = 0 "+&
												"					group by venliped_oc.anyo, "+&
												"								venliped_oc.pedido)"							
							case "Pedidos pendientes de O.C."
								cadena_or = "      exists (select venliped_oc.anyo, "+&
												"							 venliped_oc.pedido "+&
												"					from   venliped as venliped_oc "+&
												"					where  venliped_oc.empresa = venliped.empresa "+&
												"					and    venliped_oc.anyo    = venliped.anyo "+&
												"					and    venliped_oc.pedido  = venliped.pedido "+&
												"					and    isnull(venliped_oc.id_alm_orden_carga,0) = 0 "+&
												"					group by venliped_oc.anyo, "+&
												"								venliped_oc.pedido)"							
						end choose
						cadena_or_visible = " Situación: "+lb_lista.Text (k)
					end if
				end if			
			next			

		case "Dirección"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " venliped.envio = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Dirección = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR venliped.envio = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 	
		case "Usuario"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " venped.usuario = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Usuario = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR venped.usuario = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 		
		case "Tipo Transporte"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " alm_orden_carga.almtipotransportes_codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Tipo Transporte = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR alm_orden_carga.almtipotransportes_codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
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
			dw_montaje_filtro.object.filtro[fila]        = cadena_or
			dw_montaje_filtro.object.linea[fila]         = cadena_or_visible
			dw_montaje_filtro.object.aplicar_a_sql[fila] = ls_aplicar_a_sql
			
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
	
	f_cargar_datawindow (new_sql)
	
//	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if	
	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if dw_montaje_filtro.object.aplicar_a_sql[j] = 'N' then
		//if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
		//end if
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	dw_datos.sort()
	dw_datos.groupcalc()	
	
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
	
	f_cargar_datawindow (new_sql)
	
	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
	
/*	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
	*/
end if


//Al hacer más quieren que se restablezca el orden
//orden_seleccionado = "articulos_descripcion A"
//dw_datos.setsort("integer(almacen) A, zona A, fila A, altura A")

pb_grabar_obs.visible = false

dw_datos.sort()


end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_situacion_pedidos
integer x = 951
integer taborder = 0
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_situacion_pedidos
integer width = 878
integer height = 1308
integer taborder = 0
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Cliente","Artículo (Descripción)","Artículo (Código)","Situación","Pedido (Año/Pedido)","Familia","Dirección","Promoción","Fecha","País","Fecha Carga","Usuario","Situación Pedido O.C.","Agente","Fecha Entrega","Tipo Transporte","Orden de carga","Sin Fecha Entrega","Piezas Sueltas","Courier"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()
lb_lista.multiselect = true

CHOOSE CASE ddlb_campo.text
	CASE "Piezas Sueltas"
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
	CASE "Orden de carga"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="		
	CASE "Agente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select venagentes.agente as Código, venagentes.nombre as Descripción from venagentes INNER JOIN venclientes ON venagentes.empresa = venclientes.empresa AND venagentes.agente = venclientes.agente1 where venagentes.empresa = '"+codigo_empresa+"' group by venagentes.agente, venagentes.nombre order by venagentes.nombre ASC"
		
				
	CASE "Artículo (Descripción)"
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
						"where almacenmovimientos.empresa = '"+codigo_empresa+"' and articulos.familia in ('2', '6') order by CONVERT(char(60), articulos.descripcion)"
	CASE "Artículo (Código)", "Pedido (Año/Pedido)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
	CASE "Fecha", "Fecha Carga", "Fecha Entrega"
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
		consulta = "Select genter.codigo as Código, genter.razon as Descripción from genter INNER JOIN venclientes ON genter.empresa = venclientes.empresa AND genter.codigo = venclientes.codigo where genter.empresa = '"+codigo_empresa+"' AND genter.tipoter = 'C' order by genter.razon ASC"
		
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
	
	CASE "Sin Fecha Entrega"
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
	
	CASE "Situación"
		//Solo se puede añadir un filtro de situación
		if dw_montaje_filtro.rowcount() > 0 and dw_montaje_filtro.Find(" Linea LIKE '%Situación%' ", 1, dw_montaje_filtro.rowcount()) > 0 then
			MessageBox("Error", "Sólo puede añadir un filtro de situación.")
		else
			dw_filtro.visible = false
			pb_buscar.visible = false
			sle_texto.visible = false
			em_fecha1.visible = false
			sle_valor1.visible = false
			lb_lista.visible = true
			
			lb_lista.multiselect = false
			lb_lista.AddItem ("Rotura Stock")
			lb_lista.AddItem ("Planificado Sin Fecha")
			lb_lista.AddItem ("Planificado")
			lb_lista.AddItem ("Pdte. Reserva")
			lb_lista.AddItem ("Reservado")
			lb_lista.AddItem ("Preparado")
			
			ddlb_operador.AddItem ("=")
			ddlb_operador.text = "="	
		end if			
	CASE "Situación Pedido O.C."
		if dw_montaje_filtro.rowcount() > 0 and dw_montaje_filtro.Find(" Linea LIKE '%Situación%' ", 1, dw_montaje_filtro.rowcount()) > 0 then
			MessageBox("Error", "Sólo puede añadir un filtro de situación.")
		else
			dw_filtro.visible = false
			pb_buscar.visible = false
			sle_texto.visible = false
			em_fecha1.visible = false
			sle_valor1.visible = false
			lb_lista.visible = true
			
			lb_lista.multiselect = false
			lb_lista.AddItem ("Pedidos con O.C.")
			lb_lista.AddItem ("Pedidos pendientes de O.C.")
			
			ddlb_operador.AddItem ("=")
			ddlb_operador.text = "="	
		end if					
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

	CASE "País"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select paises.pais as Código, paises.nombre as Descripción from paises  order by paises.nombre ASC"

	 CASE "Courier"
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


	CASE "Dirección"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select venenvio.codigo as Código, venenvio.descripcion as Descripción, venenvio.cliente as Cliente from venenvio where venenvio.empresa = '"+codigo_empresa+"' order by venenvio.descripcion ASC"
	CASE "Usuario"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select usuarios.v_usuario as Código, usuarios.v_usuario as Descripción from usuarios where usuarios.v_empresa = '"+codigo_empresa+"' order by usuarios.v_usuario ASC"
	CASE "Tipo Transporte"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select almtipotransportes.codigo as Código, almtipotransportes.descripcion as Descripción from almtipotransportes where almtipotransportes.empresa = '"+codigo_empresa+"' order by almtipotransportes.descripcion ASC"		
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_situacion_pedidos
integer y = 512
integer width = 4626
integer height = 3008
integer taborder = 40
string dataobject = "dw_consulta_situacion_pedidos"
end type

event dw_datos::itemchanged;call super::itemchanged;//if dwo.name = "activo" then
	pb_grabar_obs.visible = true
	this.SetItemStatus(row, 0, Primary!, DataModified!)
//end if
end event

event dw_datos::retrieveend;call super::retrieveend;
f_mascara_columna(this,"largo_cm","###,##0")
f_mascara_columna(this,"ancho_cm","###,##0")
f_mascara_columna(this,"alto_cm","###,##0")
f_mascara_columna(this,"peso_maximo_kg","###,##0")

ib_ubicaciones_activas = true
ib_apilado_en_bloque   = false
end event

event dw_datos::doubleclicked;call super::doubleclicked;string ls_cliente,ls_envio,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_find,ls_familia_articulo,ls_tipo_pallet_anterior
boolean lb_recalcular_disponibles = false,lb_pallet_cambiado = false
string ls_articulo,ls_calidad,ls_tonochar,ls_tipo_pallet,ls_caja,ls_situacion,ls_banda_seleccionada,ls_gestionar_en_piezas
int    li_anyo,li_linea,li_calibre
long   ll_pedido,ll_row,ll_lotes_asignables
dec    ld_disponible,ld_cantidad,ld_cantidad_pzs,ld_disponible_pzs

string ls_pallets[]
int    li_indice_pallets,li_total_pallets

long   ll_pallets,ll_cajas,ll_id_alm_orden_carga
int    posi_aux,posi
string cadena		

string    ls_sel,ls_tono_imprimir,ls_calibre_imprimir,ls_referencia,ls_montajeartcal
int       li_lotes,ll_indice,ll_donde
boolean   lb_mostrar_stock

window lw_ventana 

str_parametros  lstr_param

datastore ds_lotes,lds_pallets

if row > 0 then		
	//and this.object.situacion[row] = 'F' 
	if dwo.name = 'id_alm_orden_carga' then
		if this.object.id_alm_orden_carga[row] > 0 then
			ll_id_alm_orden_carga = this.object.id_alm_orden_carga[row]
			
			lstr_param.s_argumentos[1] = codigo_empresa
			lstr_param.s_argumentos[2] = String(ll_id_alm_orden_carga)
			lstr_param.i_nargumentos   = 2

			//OpenWithParm(w_int_venped, lstr_param)
			//window lw_ventana 

			OpenWithParm(lw_ventana, lstr_param , "wi_mant_alm_orden_carga")			
		end if
	end if
	if dwo.name = 'situacion' and this.object.id_alm_orden_carga[row] = 0 then
		
		ls_cliente            = ""//this.object.cliente[1]
		ls_envio              = ""//this.object.envio[1]
		
		if trim(ls_cliente) <> "" then
			ls_filtro_cliente = "AND   ( venped.cliente = '"+ls_cliente+"' ) "
		else
			ls_filtro_cliente = ""
		end if
		
		if trim(ls_cliente) <> "" and trim(ls_envio) <> "" then
			ls_filtro_envio = "AND   ( venped.envio = '"+ls_envio+"' ) "
		else
			ls_filtro_envio = ""
		end if		
		
		li_anyo        = this.object.anyo[row]
		ll_pedido      = this.object.pedido[row]
		li_linea       = this.object.linea[row]
		
		ls_articulo    = this.object.articulo[row]
		ls_calidad     = this.object.calidad[row]
		ls_tonochar    = this.object.tono[row]
		li_calibre     = this.object.calibre[row]
		ls_tipo_pallet = this.object.tipo_pallet[row]
		ls_caja        = this.object.caja[row]
		ld_cantidad    = this.object.cantidad[row]
		ld_cantidad_pzs = this.object.cantidad_pzs[row]
		ls_gestionar_en_piezas = this.object.gestionar_en_piezas[row]		
		ls_situacion   = this.object.situacion[row]
		
		ls_familia_articulo = f_familia_articulo(codigo_empresa,ls_articulo)
		
		ls_filtro_articulo_calidad = " and venliped.articulo = '"+ls_articulo+"' and venliped.calidad = '"+ls_calidad+"' "
		
		ld_disponible_pzs = f_disponible_art_cal_to_ca_tp_c_pzs( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , ls_tipo_pallet , ls_caja )
		
		if ls_gestionar_en_piezas = 'S' and ld_disponible_pzs >= ld_cantidad_pzs and ls_situacion = 'F' then						
			update venliped
			set    venliped.situacion        = 'C' 
			where  venliped.empresa = :codigo_empresa
			and    venliped.anyo    = :li_anyo
			and    venliped.pedido  = :ll_pedido
			and    venliped.linea   = :li_linea;		
			
			if sqlca.sqlcode <> 0 then
				rollback;
			else
				commit;
				this.object.situacion[row]         = 'C'
				this.object.estado_linea[row]      = 40 //Reservado
				lb_recalcular_disponibles = true					
				
				ls_sel = "select venliped.tipo_pallet "+&
							"from   venliped "+&
							"where  venliped.empresa  = '"+codigo_empresa+"' "+&
							"and    venliped.articulo = '"+ls_articulo+"' "+&
							"and    venliped.calidad  = '"+ls_calidad+"' "+&
							"and    venliped.caja     = '"+ls_caja+"' "+&
							"group by venliped.tipo_pallet "+&
							"union "+&
							"select '00000'"
					
				li_total_pallets = f_cargar_cursor_transaccion(sqlca,lds_pallets,ls_sel)
				
				ls_pallets = lds_pallets.object.tipo_pallet.current
				
				destroy lds_pallets				
				
				f_calculo_disponibilidad_dw(this,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_articulo,ls_calidad)
			end if				

		else
			//Para la familia marcas (2) solo pueden asignar y desasignar los usuarios del grupo exportacion (20)
			//if ( ls_familia_articulo = "2" and ( gs_usuarios_v_grupo = "20" or gs_usuarios_v_grupo = "12" ) ) or ls_familia_articulo <> "2" then		
			if ( ls_familia_articulo = "2" and gs_usuarios_v_grupo = "20" ) or ls_familia_articulo <> "2" &
					or nombre_usuario = "PCOPIA" or nombre_usuario = "DMUNYOZ" &
					or nombre_usuario = "TENCER" or nombre_usuario = "AMALLEN" or nombre_usuario = "PROMOCION" then	
	
				//Distintos pallets del articulo que vamos a asignar o desasignar
				
				ls_sel = "select venliped.tipo_pallet "+&
							"from   venliped "+&
							"where  venliped.empresa  = '"+codigo_empresa+"' "+&
							"and    venliped.articulo = '"+ls_articulo+"' "+&
							"and    venliped.calidad  = '"+ls_calidad+"' "+&
							"and    venliped.caja     = '"+ls_caja+"' "+&
							"group by venliped.tipo_pallet "+&
							"union "+&
							"select '00000'"
					
				li_total_pallets = f_cargar_cursor_transaccion(sqlca,lds_pallets,ls_sel)
				
				ls_pallets = lds_pallets.object.tipo_pallet.current
				
				destroy lds_pallets	
	
				if ls_situacion = 'F' then
					//Vamos a comprobar si hay un solo lote para poder reservar
					
					ls_sel =   "SELECT alm_bultos_lineas.tono, "+&
								  "		 alm_bultos_lineas.calibre "+&
								  "FROM   alm_bultos, "+&
								  "		 alm_bultos_lineas "+&
								  "WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
								  "AND  	( ( alm_bultos.empresa       = '"+codigo_empresa+"' ) "+&
								  "AND  	( alm_bultos_lineas.articulo = '"+ls_articulo+"' ) "+&
								  "AND  	( alm_bultos_lineas.calidad  = '"+ls_calidad+"' ) "+&
								  "AND  	( alm_bultos.tipo_pallet     = '"+ls_tipo_pallet+"' ) "+&
								  "AND  	( alm_bultos_lineas.caja     = '"+ls_caja+"' ) ) "+& 
								  "GROUP BY alm_bultos_lineas.tono, "+&
								  "			alm_bultos_lineas.calibre"
	
					li_lotes = f_cargar_cursor_transaccion(sqlca,ds_lotes,ls_sel)
					
					if li_lotes = 1 then				
						ls_tonochar    = ds_lotes.object.alm_bultos_lineas_tono[1]
						li_calibre     = ds_lotes.object.alm_bultos_lineas_calibre[1]					
						
						ls_referencia    = f_componer_ref(ls_articulo,ls_calidad,ls_tonochar,li_calibre)
						ls_montajeartcal = f_componer_artcal(ls_articulo,ls_calidad)
						
						if f_familias_replica_tono_calibre(codigo_empresa,f_familia_articulo(codigo_empresa,ls_articulo)) = 'S' then
							ls_tono_imprimir    = ls_tonochar
							ls_calibre_imprimir = string(li_calibre,"##")
						else
							select isnull(venliped.tono_imprimir,''),
									 isnull(venliped.calibre_imprimir,'') 
							into   :ls_tono_imprimir,
									 :ls_calibre_imprimir 
							from   venliped
							where  venliped.empresa = :codigo_empresa
							and    venliped.anyo    = :li_anyo
							and    venliped.pedido  = :ll_pedido
							and    venliped.linea   = :li_linea;						
						end if					
						
						ld_disponible = f_disponible_art_cal_to_ca_tp_c( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , ls_tipo_pallet , ls_caja )
						
						ld_disponible_pzs = f_disponible_art_cal_to_ca_tp_c_pzs( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , ls_tipo_pallet , ls_caja )
						
						if ( ls_gestionar_en_piezas = "N" and ld_disponible >= ld_cantidad ) or ( ls_gestionar_en_piezas = "S" and ld_disponible_pzs >= ld_cantidad_pzs ) then
													
							update venliped
							set    venliped.situacion        = 'C',
									 venliped.tonochar         = :ls_tonochar,
									 venliped.calibre          = :li_calibre, 
									 venliped.referencia       = :ls_referencia,
									 venliped.montajeartcal    = :ls_montajeartcal, 
									 venliped.tono_imprimir    = :ls_tono_imprimir,
									 venliped.calibre_imprimir = :ls_calibre_imprimir 
							where  venliped.empresa = :codigo_empresa
							and    venliped.anyo    = :li_anyo
							and    venliped.pedido  = :ll_pedido
							and    venliped.linea   = :li_linea;
							
							if sqlca.sqlcode <> 0 then
								rollback;
							else
								commit;
								this.object.situacion[row]    = 'C'
								this.object.tono[row]         = ls_tonochar
								this.object.calibre[row]      = li_calibre
								this.object.estado_linea[row] = 40 //Reservado
								lb_recalcular_disponibles     = true					
							end if
						else
							
						end if
					else
						if li_lotes = 0 then
							//Vamos a ver si hay lotes con pallet = '00000'
							//Vamos a comprobar si hay un solo lote para poder reservar
							
							ls_sel =   "SELECT alm_bultos_lineas.tono, "+&
										  "		 alm_bultos_lineas.calibre "+&
										  "FROM   alm_bultos, "+&
										  "		 alm_bultos_lineas "+&
										  "WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
										  "AND  	( ( alm_bultos.empresa       = '"+codigo_empresa+"' ) "+&
										  "AND  	( alm_bultos_lineas.articulo = '"+ls_articulo+"' ) "+&
										  "AND  	( alm_bultos_lineas.calidad  = '"+ls_calidad+"' ) "+&
										  "AND  	( alm_bultos.tipo_pallet     = '00000' ) "+&
										  "AND  	( alm_bultos_lineas.caja     = '"+ls_caja+"' ) ) "+& 
										  "GROUP BY alm_bultos_lineas.tono, "+&
										  "			alm_bultos_lineas.calibre"
			
							li_lotes = f_cargar_cursor_transaccion(sqlca,ds_lotes,ls_sel)
							
							if li_lotes = 1 then				
								ls_tonochar    = ds_lotes.object.alm_bultos_lineas_tono[1]
								li_calibre     = ds_lotes.object.alm_bultos_lineas_calibre[1]					
								
								ls_referencia    = f_componer_ref(ls_articulo,ls_calidad,ls_tonochar,li_calibre)
								ls_montajeartcal = f_componer_artcal(ls_articulo,ls_calidad)
								
								if f_familias_replica_tono_calibre(codigo_empresa,f_familia_articulo(codigo_empresa,ls_articulo)) = 'S' then
									ls_tono_imprimir    = ls_tonochar
									ls_calibre_imprimir = string(li_calibre,"##")
								else
									select isnull(venliped.tono_imprimir,''),
											 isnull(venliped.calibre_imprimir,'') 
									into   :ls_tono_imprimir,
											 :ls_calibre_imprimir 
									from   venliped
									where  venliped.empresa = :codigo_empresa
									and    venliped.anyo    = :li_anyo
									and    venliped.pedido  = :ll_pedido
									and    venliped.linea   = :li_linea;						
								end if					
								
								ld_disponible = f_disponible_art_cal_to_ca_tp_c( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , '00000' , ls_caja )
								
								ld_disponible_pzs = f_disponible_art_cal_to_ca_tp_c_pzs( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , '00000' , ls_caja )
								
								if ( ls_gestionar_en_piezas = "N" and ld_disponible >= ld_cantidad ) or ( ls_gestionar_en_piezas = "S" and ld_disponible_pzs >= ld_cantidad_pzs ) then
															
									update venliped
									set    venliped.situacion        = 'C',
											 venliped.tonochar         = :ls_tonochar,
											 venliped.calibre          = :li_calibre, 
											 venliped.referencia       = :ls_referencia,
											 venliped.montajeartcal    = :ls_montajeartcal, 
											 venliped.tono_imprimir    = :ls_tono_imprimir,
											 venliped.calibre_imprimir = :ls_calibre_imprimir,
											 venliped.tipo_pallet      = '00000'
									where  venliped.empresa = :codigo_empresa
									and    venliped.anyo    = :li_anyo
									and    venliped.pedido  = :ll_pedido
									and    venliped.linea   = :li_linea;
									
									if sqlca.sqlcode <> 0 then
										rollback;
									else
										commit;
										this.object.situacion[row]    = 'C'
										this.object.tono[row]         = ls_tonochar
										this.object.calibre[row]      = li_calibre
										this.object.tipo_pallet[row]  = '00000'
										this.object.estado_linea[row] = 40 //Reservado
										lb_recalcular_disponibles = true					
										
										lb_pallet_cambiado = true
										ls_tipo_pallet_anterior = ls_tipo_pallet
									end if
								else
									
								end if
							else
								if li_lotes = 0 then
								else
									//Mas de un lote
									lb_mostrar_stock = true
									//messagebox("¡Atención!","Hay mas de un lote.~nDebe asignar desde la introducción de pedidos.")
								end if
							end if				
							
							//Fin de Vamos a ver si hay lotes con pallet = '00000'							
							//lb_mostrar_stock = false
						else
							/*
							//Mas de un lote
							*/
							lb_mostrar_stock = true
						end if
					end if				
				
					if lb_mostrar_stock then
						this.selectrow(0,false)
						this.selectrow(row,true)
						this.setrow(row)
						this.enabled            = false
						this.enabled            = false
	
						dw_stock.y = this.y + (ypos * 4) - dw_stock.height - 32//+ 128
						
						dw_stock.reset()
						dw_stock.setredraw(false)
						
						ll_lotes_asignables = 0
						
						for ll_indice = 1 to li_lotes
							ls_tonochar    = ds_lotes.object.alm_bultos_lineas_tono[ll_indice]
							li_calibre     = ds_lotes.object.alm_bultos_lineas_calibre[ll_indice]					
														
							ld_disponible = f_disponible_art_cal_to_ca_tp_c( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , ls_tipo_pallet , ls_caja )
							
							cadena = f_calculo_unidades_tipolin(codigo_empresa,ls_articulo,&
															 ls_tipo_pallet,&
															 ls_caja,&
															 0,&
															 0,&
															 ld_disponible,&
															 '')
							
							posi_aux = 1
							posi = pos(cadena,"|",1)
							if posi <> 0 then
								ll_pallets = dec(Mid(cadena,1,posi - 1))
								posi_aux = posi + 1
							end if
							
							posi = pos(cadena,"|",posi_aux)
							if posi <> 0 then
								ll_cajas = dec(Mid(cadena,posi_aux,posi - posi_aux ))
								posi_aux = posi + 1
							end if							
							
							ll_donde = dw_stock.insertrow(0)
							dw_stock.object.empresa[ll_donde]            = codigo_empresa
							dw_stock.object.articulo[ll_donde]           = this.object.articulo[row]
							dw_stock.object.nombre_articulo[ll_donde]    = this.object.nombre_articulo[row]
							dw_stock.object.familia[ll_donde]            = this.object.familia[row]
							dw_stock.object.nombre_familia[ll_donde]     = this.object.nombre_familia[row]
							dw_stock.object.formato[ll_donde]            = this.object.formato[row]
							dw_stock.object.nombre_formato[ll_donde]     = this.object.nombre_formato[row]
							dw_stock.object.promocion[ll_donde]          = this.object.promocion[row]
							dw_stock.object.unidad[ll_donde]             = this.object.unidad[row]
							dw_stock.object.nombre_unidad[ll_donde]      = this.object.nombre_unidad[row]
							dw_stock.object.decimales_unidad[ll_donde]   = this.object.decimales_unidad[row]
							dw_stock.object.calidad[ll_donde]            = this.object.calidad[row]
							dw_stock.object.nombre_calidad[ll_donde]     = this.object.nombre_calidad[row]
							dw_stock.object.tono[ll_donde]               = ls_tonochar
							dw_stock.object.calibre[ll_donde]            = li_calibre
							dw_stock.object.tipo_pallet[ll_donde]        = this.object.tipo_pallet[row]
							dw_stock.object.nombre_tipo_pallet[ll_donde] = this.object.nombre_tipo_pallet[row]
							dw_stock.object.caja[ll_donde]               = this.object.caja[row]
							dw_stock.object.nombre_caja[ll_donde]        = this.object.nombre_caja[row]
							dw_stock.object.cantidad[ll_donde]           = this.object.cantidad[row]
							dw_stock.object.pallets[ll_donde]            = ll_pallets
							dw_stock.object.cajas[ll_donde]              = ll_cajas
							dw_stock.object.disponible[ll_donde]         = ld_disponible
							
							if ld_disponible >= ld_cantidad then
								ll_lotes_asignables ++
							end if
						next
						dw_stock.sort()
						dw_stock.groupcalc()
						dw_stock.setredraw(true)
						
						if ll_lotes_asignables = 1 then
							ll_donde = dw_stock.find("disponible >= "+string(ld_cantidad),1,dw_stock.rowcount())
							
							if ll_donde > 0 then
								//Llamar al itemchanged de la datawindow
								dw_stock.event clicked(0,0,ll_donde,dw_stock.object.p_linea)
							end if
						else
							dw_stock.visible = true
						end if
														
					end if
				
					destroy ds_lotes				
				else
					if ls_situacion = 'C' then
						update venliped
						set    venliped.situacion = 'F',
								 venliped.tonochar  = '',
								 venliped.calibre   = 0
						where  venliped.empresa = :codigo_empresa
						and    venliped.anyo    = :li_anyo
						and    venliped.pedido  = :ll_pedido
						and    venliped.linea   = :li_linea;
						
						if sqlca.sqlcode <> 0 then
							rollback;
						else
							commit;
							this.object.situacion[row] = 'F'
							this.object.tono[row]      = ''
							this.object.calibre[row]   = 0
							
							lb_recalcular_disponibles = true
						end if				
					else
						//Situacion 'P' Preparado no hacemos nada
					end if
				end if
				
				if lb_recalcular_disponibles then
					//Recalculamos los disponibles
					f_calculo_disponibilidad_dw(this,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_articulo,ls_calidad)	
				end if
			end if
		end if
						
	end if
else
	//row = 0
	if dwo.name = 'pedido' then

		//Abrimos el pedido
		ls_banda_seleccionada = this.GetBandAtPointer()
		//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
		ll_row = Long(Mid(ls_banda_seleccionada, LastPos(ls_banda_seleccionada, "~t") + 1))
		
		if ll_row > 0 then
			ll_pedido = this.object.pedido[ll_row]
			li_anyo   = this.object.anyo[ll_row]
			
			lstr_param.s_argumentos[1] = codigo_empresa
			lstr_param.s_argumentos[2] = String(li_anyo)
			lstr_param.s_argumentos[3] = String(ll_pedido)
			lstr_param.i_nargumentos   = 3

			//OpenWithParm(w_int_venped, lstr_param)
			//window lw_ventana 

			OpenWithParm(lw_ventana, lstr_param , "w_int_venped")
		end if
	end if	
end if


/* asi se hacia antes
string ls_cliente,ls_envio,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_find,ls_familia_articulo
boolean lb_recalcular_disponibles = false
string ls_articulo,ls_calidad,ls_tonochar,ls_tipo_pallet,ls_caja,ls_situacion,ls_banda_seleccionada
int    li_anyo,li_linea,li_calibre
long   ll_pedido,ll_row,ll_lotes_asignables
dec    ld_disponible,ld_cantidad

long   ll_pallets,ll_cajas
int    posi_aux,posi
string cadena		

string    ls_sel,ls_tono_imprimir,ls_calibre_imprimir,ls_referencia,ls_montajeartcal
int       li_lotes,ll_indice,ll_donde
boolean   lb_mostrar_stock

str_parametros  lstr_param

datastore ds_lotes

if row > 0 then		
	//and this.object.situacion[row] = 'F' 
	if dwo.name = 'situacion' and this.object.id_alm_orden_carga[row] = 0 then
		
		ls_cliente            = this.object.cliente[row]
		ls_envio              = this.object.envio[row]
		
		if trim(ls_cliente) <> "" then
			ls_filtro_cliente = "AND   ( venped.cliente = '"+ls_cliente+"' ) "
		else
			ls_filtro_cliente = ""
		end if
		
		if trim(ls_cliente) <> "" and trim(ls_envio) <> "" then
			ls_filtro_envio = "AND   ( venped.envio = '"+ls_envio+"' ) "
		else
			ls_filtro_envio = ""
		end if		
		
		li_anyo        = this.object.anyo[row]
		ll_pedido      = this.object.pedido[row]
		li_linea       = this.object.linea[row]
		
		ls_articulo    = this.object.articulo[row]
		ls_calidad     = this.object.calidad[row]
		ls_tonochar    = this.object.tono[row]
		li_calibre     = this.object.calibre[row]
		ls_tipo_pallet = this.object.tipo_pallet[row]
		ls_caja        = this.object.caja[row]
		ld_cantidad    = this.object.cantidad[row]
		ls_situacion   = this.object.situacion[row]
		
		ls_familia_articulo = f_familia_articulo(codigo_empresa,ls_articulo)
		
		ls_filtro_articulo_calidad = " and venliped.articulo = '"+ls_articulo+"' and venliped.calidad = '"+ls_calidad+"' "
		
		//Para la familia marcas (2) solo pueden asignar y desasignar los usuarios del grupo exportacion (20)

		if ( ls_familia_articulo = "2" and ( gs_usuarios_v_grupo = "20" or gs_usuarios_v_grupo = "12" ) ) or ls_familia_articulo <> "2" then		
			if ls_situacion = 'F' then
				//Vamos a comprobar si hay un solo lote para poder reservar
				
				ls_sel =   "SELECT alm_bultos_lineas.tono, "+&
							  "		 alm_bultos_lineas.calibre "+&
							  "FROM   alm_bultos, "+&
							  "		 alm_bultos_lineas "+&
							  "WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
							  "AND  	( ( alm_bultos.empresa       = '"+codigo_empresa+"' ) "+&
							  "AND  	( alm_bultos_lineas.articulo = '"+ls_articulo+"' ) "+&
							  "AND  	( alm_bultos_lineas.calidad  = '"+ls_calidad+"' ) "+&
							  "AND  	( alm_bultos.tipo_pallet     = '"+ls_tipo_pallet+"' ) "+&
							  "AND  	( alm_bultos_lineas.caja     = '"+ls_caja+"' ) ) "+& 
							  "GROUP BY alm_bultos_lineas.tono, "+&
							  "			alm_bultos_lineas.calibre"

				li_lotes = f_cargar_cursor_transaccion(sqlca,ds_lotes,ls_sel)
				
				if li_lotes = 1 then				
					ls_tonochar    = ds_lotes.object.alm_bultos_lineas_tono[1]
					li_calibre     = ds_lotes.object.alm_bultos_lineas_calibre[1]					
					
					ls_referencia    = f_componer_ref(ls_articulo,ls_calidad,ls_tonochar,li_calibre)
					ls_montajeartcal = f_componer_artcal(ls_articulo,ls_calidad)
					
					if f_familias_replica_tono_calibre(codigo_empresa,f_familia_articulo(codigo_empresa,ls_articulo)) = 'S' then
						ls_tono_imprimir    = ls_tonochar
						ls_calibre_imprimir = string(li_calibre,"##")
					else
						select isnull(venliped.tono_imprimir,''),
								 isnull(venliped.calibre_imprimir,'') 
						into   :ls_tono_imprimir,
								 :ls_calibre_imprimir 
						from   venliped
						where  venliped.empresa = :codigo_empresa
						and    venliped.anyo    = :li_anyo
						and    venliped.pedido  = :ll_pedido
						and    venliped.linea   = :li_linea;						
					end if					
					
					ld_disponible = f_disponible_art_cal_to_ca_tp_c( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , ls_tipo_pallet , ls_caja )
					
					if ld_disponible >= ld_cantidad then
												
						update venliped
						set    venliped.situacion        = 'C',
								 venliped.tonochar         = :ls_tonochar,
								 venliped.calibre          = :li_calibre, 
								 venliped.referencia       = :ls_referencia,
								 venliped.montajeartcal    = :ls_montajeartcal, 
								 venliped.tono_imprimir    = :ls_tono_imprimir,
								 venliped.calibre_imprimir = :ls_calibre_imprimir 
						where  venliped.empresa = :codigo_empresa
						and    venliped.anyo    = :li_anyo
						and    venliped.pedido  = :ll_pedido
						and    venliped.linea   = :li_linea;
						
						if sqlca.sqlcode <> 0 then
							rollback;
						else
							commit;
							this.object.situacion[row]    = 'C'
							this.object.tono[row]         = ls_tonochar
							this.object.calibre[row]      = li_calibre
							this.object.estado_linea[row] = 40 //Reservado
							lb_recalcular_disponibles     = true					
						end if
					else
						
					end if
				else
					if li_lotes = 0 then
						lb_mostrar_stock = false
					else
						/*
						//Mas de un lote
						*/
						lb_mostrar_stock = true
					end if
				end if				
			
				if lb_mostrar_stock then
					this.selectrow(0,false)
					this.selectrow(row,true)
					this.setrow(row)
					this.enabled            = false
					this.enabled            = false

					dw_stock.y = this.y + (ypos * 4) - dw_stock.height - 32 //+ 128
					
					dw_stock.reset()
					dw_stock.setredraw(false)
					
					ll_lotes_asignables = 0
					
					for ll_indice = 1 to li_lotes
						ls_tonochar    = ds_lotes.object.alm_bultos_lineas_tono[ll_indice]
						li_calibre     = ds_lotes.object.alm_bultos_lineas_calibre[ll_indice]					
													
						ld_disponible = f_disponible_art_cal_to_ca_tp_c( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , ls_tipo_pallet , ls_caja )
						
						cadena = f_calculo_unidades_tipolin(codigo_empresa,ls_articulo,&
														 ls_tipo_pallet,&
														 ls_caja,&
														 0,&
														 0,&
														 ld_disponible,&
														 '')
						
						posi_aux = 1
						posi = pos(cadena,"|",1)
						if posi <> 0 then
							ll_pallets = dec(Mid(cadena,1,posi - 1))
							posi_aux = posi + 1
						end if
						
						posi = pos(cadena,"|",posi_aux)
						if posi <> 0 then
							ll_cajas = dec(Mid(cadena,posi_aux,posi - posi_aux ))
							posi_aux = posi + 1
						end if							
						
						ll_donde = dw_stock.insertrow(0)
						dw_stock.object.empresa[ll_donde]            = codigo_empresa
						dw_stock.object.articulo[ll_donde]           = this.object.articulo[row]
						dw_stock.object.nombre_articulo[ll_donde]    = this.object.nombre_articulo[row]
						dw_stock.object.familia[ll_donde]            = this.object.familia[row]
						dw_stock.object.nombre_familia[ll_donde]     = this.object.nombre_familia[row]
						dw_stock.object.formato[ll_donde]            = this.object.formato[row]
						dw_stock.object.nombre_formato[ll_donde]     = this.object.nombre_formato[row]
						dw_stock.object.promocion[ll_donde]          = this.object.promocion[row]
						dw_stock.object.unidad[ll_donde]             = this.object.unidad[row]
						dw_stock.object.nombre_unidad[ll_donde]      = this.object.nombre_unidad[row]
						dw_stock.object.decimales_unidad[ll_donde]   = this.object.decimales_unidad[row]
						dw_stock.object.calidad[ll_donde]            = this.object.calidad[row]
						dw_stock.object.nombre_calidad[ll_donde]     = this.object.nombre_calidad[row]
						dw_stock.object.tono[ll_donde]               = ls_tonochar
						dw_stock.object.calibre[ll_donde]            = li_calibre
						dw_stock.object.tipo_pallet[ll_donde]        = this.object.tipo_pallet[row]
						dw_stock.object.nombre_tipo_pallet[ll_donde] = this.object.nombre_tipo_pallet[row]
						dw_stock.object.caja[ll_donde]               = this.object.caja[row]
						dw_stock.object.nombre_caja[ll_donde]        = this.object.nombre_caja[row]
						dw_stock.object.cantidad[ll_donde]           = this.object.cantidad[row]
						dw_stock.object.pallets[ll_donde]            = ll_pallets
						dw_stock.object.cajas[ll_donde]              = ll_cajas
						dw_stock.object.disponible[ll_donde]         = ld_disponible
						
						if ld_disponible >= ld_cantidad then
							ll_lotes_asignables ++
						end if
					next
					dw_stock.sort()
					dw_stock.groupcalc()
					dw_stock.setredraw(true)
					
					if ll_lotes_asignables = 1 then
						ll_donde = dw_stock.find("disponible >= "+string(ld_cantidad),1,dw_stock.rowcount())
						
						if ll_donde > 0 then
							//Llamar al itemchanged de la datawindow
							dw_stock.event clicked(0,0,ll_donde,dw_stock.object.p_linea)
						end if
					else
						dw_stock.visible = true
					end if
													
				end if
			
				destroy ds_lotes				
			else
				if ls_situacion = 'C' then
					update venliped
					set    venliped.situacion = 'F',
							 venliped.tonochar  = '',
							 venliped.calibre   = 0
					where  venliped.empresa = :codigo_empresa
					and    venliped.anyo    = :li_anyo
					and    venliped.pedido  = :ll_pedido
					and    venliped.linea   = :li_linea;
					
					if sqlca.sqlcode <> 0 then
						rollback;
					else
						commit;
						this.object.situacion[row] = 'F'
						this.object.tono[row]      = ''
						this.object.calibre[row]   = 0
						
						lb_recalcular_disponibles = true
					end if				
				else
					//Situacion 'P' Preparado no hacemos nada
				end if
			end if
			
			if lb_recalcular_disponibles then
				//Recalculamos los disponibles
				f_calculo_disponibilidad_dw(this,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_articulo,ls_calidad)				
			end if
		end if
	end if
else
	//row = 0
	if dwo.name = 'pedido' then

		//Abrimos el pedido
		ls_banda_seleccionada = this.GetBandAtPointer()
		//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
		ll_row = Long(Mid(ls_banda_seleccionada, LastPos(ls_banda_seleccionada, "~t") + 1))
		
		if ll_row > 0 then
			ll_pedido = this.object.pedido[ll_row]
			li_anyo   = this.object.anyo[ll_row]
			
			lstr_param.s_argumentos[1] = codigo_empresa
			lstr_param.s_argumentos[2] = String(li_anyo)
			lstr_param.s_argumentos[3] = String(ll_pedido)
			lstr_param.i_nargumentos   = 3

			//OpenWithParm(w_int_venped, lstr_param)
			window lw_ventana 

			OpenWithParm(lw_ventana, lstr_param , "w_int_venped")
		end if
	end if	
end if

*/
end event

event dw_datos::clicked;call super::clicked;
choose case dwo.name
	case "fecha_fin_planificacion_minima_c"
		if row > 0 then
			f_cargar_reparto_fabricaciones(row)
		end if
	case else
		
end choose
end event

event dw_datos::rowfocuschanged;//Para que no ejecute el padre
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_situacion_pedidos
integer x = 4530
integer y = 96
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_situacion_pedidos
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_situacion_pedidos
integer x = 4160
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_situacion_pedidos
integer x = 46
integer width = 3675
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_situacion_pedidos
integer x = 2871
integer y = 132
integer taborder = 150
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_situacion_pedidos
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 10
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_situacion_pedidos
integer x = 1307
integer height = 96
integer taborder = 160
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_situacion_pedidos
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_situacion_pedidos
integer x = 1312
integer y = 132
integer width = 599
integer height = 600
integer taborder = 140
long textcolor = 24076881
boolean vscrollbar = true
end type

type st_reservado from statictext within wtc_consulta_situacion_pedidos
integer x = 3109
integer y = 356
integer width = 1006
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type pb_grabar_obs from picturebutton within wtc_consulta_situacion_pedidos
boolean visible = false
integer x = 3209
integer y = 96
integer width = 146
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;if dw_datos.update(true) = -1 then
	MessageBox("SQL error " + String(SQLCA.SQLDBCode),  SQLCA.SQLErrText )
	rollback using SQLCA;
else
	commit using SQLCA;
end if

pb_grabar_obs.visible = false

end event

type st_1 from statictext within wtc_consulta_situacion_pedidos
integer x = 2272
integer y = 16
integer width = 910
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
boolean focusrectangle = false
end type

type dw_etiquetas_bultos_100 from datawindow within wtc_consulta_situacion_pedidos
boolean visible = false
integer x = 2446
integer width = 567
integer height = 140
integer taborder = 41
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiquetas_bultos_ubicaciones_100x60"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cbx_resumen from checkbox within wtc_consulta_situacion_pedidos
integer x = 4293
integer y = 244
integer width = 379
integer height = 64
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
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;if this.checked then
	dw_datos.modify("datawindow.detail.height=0")
else
	dw_datos.modify("datawindow.detail.height=64")
end if
end event

type dw_stock from u_datawindow within wtc_consulta_situacion_pedidos
boolean visible = false
integer x = 329
integer y = 1296
integer width = 3849
integer height = 668
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Asignación Stock"
string dataobject = "dw_mant_alm_orden_carga5"
boolean vscrollbar = true
end type

event clicked;call super::clicked;string  ls_cliente,ls_envio,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_find,ls_familia_articulo
boolean lb_recalcular_disponibles = false
string ls_articulo,ls_calidad,ls_tonochar,ls_tipo_pallet,ls_caja,ls_situacion
int    li_anyo,li_linea,li_calibre
long   ll_pedido,ll_row_pedido
dec    ld_disponible,ld_cantidad

string    ls_sel,ls_tono_imprimir,ls_calibre_imprimir,ls_referencia,ls_montajeartcal

choose case dwo.name
	case 'p_linea'
		
		ll_row_pedido = dw_datos.getrow()
	
		if ll_row_pedido > 0 then		
			if dw_datos.object.situacion[ll_row_pedido] = 'F' then
							
				ls_cliente            = dw_datos.object.cliente[ll_row_pedido]
				ls_envio              = dw_datos.object.envio[ll_row_pedido]
				
				if trim(ls_cliente) <> "" then
					ls_filtro_cliente = "AND   ( venped.cliente = '"+ls_cliente+"' ) "
				else
					ls_filtro_cliente = ""
				end if
				
				if trim(ls_cliente) <> "" and trim(ls_envio) <> "" then
					ls_filtro_envio = "AND   ( venped.envio = '"+ls_envio+"' ) "
				else
					ls_filtro_envio = ""
				end if								
							
				li_anyo        = dw_datos.object.anyo[ll_row_pedido]
				ll_pedido      = dw_datos.object.pedido[ll_row_pedido]
				li_linea       = dw_datos.object.linea[ll_row_pedido]
				
				ls_articulo    = dw_datos.object.articulo[ll_row_pedido]
				ls_calidad     = dw_datos.object.calidad[ll_row_pedido]
				ls_tonochar    = dw_datos.object.tono[ll_row_pedido]
				li_calibre     = dw_datos.object.calibre[ll_row_pedido]
				ls_tipo_pallet = dw_datos.object.tipo_pallet[ll_row_pedido]
				ls_caja        = dw_datos.object.caja[ll_row_pedido]
				ld_cantidad    = dw_datos.object.cantidad[ll_row_pedido]
				ls_situacion   = dw_datos.object.situacion[ll_row_pedido]
				
				ls_familia_articulo = f_familia_articulo(codigo_empresa,ls_articulo)
				
				ls_filtro_articulo_calidad = " and venliped.articulo = '"+ls_articulo+"' and venliped.calidad = '"+ls_calidad+"' "
				
				ls_tonochar    = this.object.tono[row]
				li_calibre     = this.object.calibre[row]					
				
				ls_referencia    = f_componer_ref(ls_articulo,ls_calidad,ls_tonochar,li_calibre)
				ls_montajeartcal = f_componer_artcal(ls_articulo,ls_calidad)
				
				if f_familias_replica_tono_calibre(codigo_empresa,f_familia_articulo(codigo_empresa,ls_articulo)) = 'S' then
					ls_tono_imprimir    = ls_tonochar
					ls_calibre_imprimir = string(li_calibre,"##")
				else
					select isnull(venliped.tono_imprimir,''),
							 isnull(venliped.calibre_imprimir,'') 
					into   :ls_tono_imprimir,
							 :ls_calibre_imprimir 
					from   venliped
					where  venliped.empresa = :codigo_empresa
					and    venliped.anyo    = :li_anyo
					and    venliped.pedido  = :ll_pedido
					and    venliped.linea   = :li_linea;						
				end if					
				
				ld_disponible = f_disponible_art_cal_to_ca_tp_c( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , ls_tipo_pallet , ls_caja )
				
				if ld_disponible >= ld_cantidad then
											
					update venliped
					set    venliped.situacion        = 'C',
							 venliped.tonochar         = :ls_tonochar,
							 venliped.calibre          = :li_calibre, 
							 venliped.referencia       = :ls_referencia,
							 venliped.montajeartcal    = :ls_montajeartcal, 
							 venliped.tono_imprimir    = :ls_tono_imprimir,
							 venliped.calibre_imprimir = :ls_calibre_imprimir 
					where  venliped.empresa = :codigo_empresa
					and    venliped.anyo    = :li_anyo
					and    venliped.pedido  = :ll_pedido
					and    venliped.linea   = :li_linea;
					
					if sqlca.sqlcode <> 0 then
						rollback;
						Messagebox("¡Error!","No se ha podido actualizar la linea del pedido.")
					else
						commit;
						dw_datos.object.situacion[ll_row_pedido]    = 'C'
						dw_datos.object.tono[ll_row_pedido]         = ls_tonochar
						dw_datos.object.calibre[ll_row_pedido]      = li_calibre
						dw_datos.object.estado_linea[ll_row_pedido] = 40 //Reservado
						
						f_calculo_disponibilidad_dw(dw_datos,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_articulo,ls_calidad)	
					end if
					
					dw_datos.enabled = true
					dw_datos.enabled = true
					this.visible     = false
	
				end if
			end if
		end if
		
	case 'p_salir'
		dw_datos.enabled = true
		dw_datos.enabled = true
		this.visible     = false		
end choose
end event

event doubleclicked;call super::doubleclicked;if dwo.name = 'disponible' then
	this.event clicked(xpos,ypos,row,this.object.p_linea)
end if
end event

type dwtc_reparto_fabricaciones from datawindow within wtc_consulta_situacion_pedidos
boolean visible = false
integer x = 709
integer y = 676
integer width = 3301
integer height = 2484
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_reparto_fabricaciones"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if dwo.name = "p_salir" then
	this.visible = false
end if
end event

