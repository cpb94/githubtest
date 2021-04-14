$PBExportHeader$wi_mant_alm_orden_carga.srw
forward
global type wi_mant_alm_orden_carga from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_alm_orden_carga
end type
type p_imprimir_pendientes from picture within wi_mant_alm_orden_carga
end type
type dw_lineas_orden from u_datawindow within wi_mant_alm_orden_carga
end type
type dw_pedidos_pendientes from u_datawindow within wi_mant_alm_orden_carga
end type
type p_1 from picture within wi_mant_alm_orden_carga
end type
type dw_updatea_venliped from datawindow within wi_mant_alm_orden_carga
end type
type dw_stock from u_datawindow within wi_mant_alm_orden_carga
end type
type st_cabecera_orden from statictext within wi_mant_alm_orden_carga
end type
type st_lineas_orden from statictext within wi_mant_alm_orden_carga
end type
type dwtc_reparto_fabricaciones from datawindow within wi_mant_alm_orden_carga
end type
type cbx_ocultar_pedidos_en_orden_de_carga from checkbox within wi_mant_alm_orden_carga
end type
type uo_articulo from u_em_campo_2 within wi_mant_alm_orden_carga
end type
type cbx_filtrar_articulo from checkbox within wi_mant_alm_orden_carga
end type
type p_refrescar_pedidos from picture within wi_mant_alm_orden_carga
end type
type st_pedidos_pendientes from statictext within wi_mant_alm_orden_carga
end type
type dw_imprimir from u_datawindow within wi_mant_alm_orden_carga
end type
type cbx_promocion from checkbox within wi_mant_alm_orden_carga
end type
type cb_2 from commandbutton within wi_mant_alm_orden_carga
end type
type cb_3 from commandbutton within wi_mant_alm_orden_carga
end type
type ds_alm_orden_carga from datawindow within wi_mant_alm_orden_carga
end type
type ds_alm_orden_preparacion from datawindow within wi_mant_alm_orden_carga
end type
type cb_4 from commandbutton within wi_mant_alm_orden_carga
end type
type cb_1 from commandbutton within wi_mant_alm_orden_carga
end type
type dw_trans from datawindow within wi_mant_alm_orden_carga
end type
type dw_cargas from datawindow within wi_mant_alm_orden_carga
end type
type p_informacion from picture within wi_mant_alm_orden_carga
end type
end forward

global type wi_mant_alm_orden_carga from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 8576
integer height = 3996
string title = "Orden carga"
pb_calculadora pb_calculadora
p_imprimir_pendientes p_imprimir_pendientes
dw_lineas_orden dw_lineas_orden
dw_pedidos_pendientes dw_pedidos_pendientes
p_1 p_1
dw_updatea_venliped dw_updatea_venliped
dw_stock dw_stock
st_cabecera_orden st_cabecera_orden
st_lineas_orden st_lineas_orden
dwtc_reparto_fabricaciones dwtc_reparto_fabricaciones
cbx_ocultar_pedidos_en_orden_de_carga cbx_ocultar_pedidos_en_orden_de_carga
uo_articulo uo_articulo
cbx_filtrar_articulo cbx_filtrar_articulo
p_refrescar_pedidos p_refrescar_pedidos
st_pedidos_pendientes st_pedidos_pendientes
dw_imprimir dw_imprimir
cbx_promocion cbx_promocion
cb_2 cb_2
cb_3 cb_3
ds_alm_orden_carga ds_alm_orden_carga
ds_alm_orden_preparacion ds_alm_orden_preparacion
cb_4 cb_4
cb_1 cb_1
dw_trans dw_trans
dw_cargas dw_cargas
p_informacion p_informacion
end type
global wi_mant_alm_orden_carga wi_mant_alm_orden_carga

type variables
long il_rows_dw_updatea_venliped
datetime ldt_ultima_carga_pedidos_pendientes
end variables

forward prototypes
public function long f_cargar_lineas_orden_carga ()
public function integer f_post_itemchanged (long row, dwobject dwo, string data)
public subroutine f_calculo_disponibilidad (ref datastore ds_datos, string ls_filtro_cliente, string ls_filtro_envio, string ls_filtro_articulo_calidad)
public subroutine f_calculo_disponibilidad_dw (ref datawindow ds_datos, string ls_filtro_cliente, string ls_filtro_envio, string ls_filtro_articulo_calidad, string ls_articulo, string ls_calidad)
public subroutine f_cargar_reparto_fabricaciones (long arg_row)
public function integer f_post_itemchanged_old (long row, dwobject dwo, string data)
public function long f_cargar_pedidos (boolean arg_refrescar)
end prototypes

public function long f_cargar_lineas_orden_carga ();string ls_sel
long   ll_total,ll_rows,ll_id_alm_orden_carga
datastore ds_datos

dw_lineas_orden.reset()

dw_lineas_orden.setredraw(false)

if dw_1.rowcount() = 1 then
	
	ll_id_alm_orden_carga = dw_1.object.id[1]
	/*
		ls_sel ="SELECT venped.empresa, ~n"+&
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
				  "		 isnull(articulos.descripcion,venliped.descripcion), ~n"+&
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
				  "       convert(dec(10,2),venliped.peso) as peso_kg, ~n"+&
				  "      "+string(ll_id_alm_orden_carga)+" as id_alm_orden_carga_actual, ~n"+&
				  "       -1.000 as disponible, ~n"+&
				  "       0.000 as planificado, ~n"+&
				  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_minima, ~n"+&
				  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_maxima, ~n"+&
				  "       case when isnull(venliped.articulo,'') = '' then 40 else case venliped.situacion when 'P' then 50 when 'C' then 40 else 10 end end as estado_linea, ~n"+&
				  "       convert(dec(16,2), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) * 100 else 0 end ) as porcentaje_pallet_pico, ~n"+&
				  "       venliped.fentrega ~n"+&
				  "FROM  venped ~n"+&
				  "      INNER JOIN venliped ON venped.empresa = venliped.empresa AND venped.anyo = venliped.anyo AND venped.pedido = venliped.pedido ~n"+&
				  "      LEFT OUTER JOIN ventipolin ON ventipolin.empresa = venliped.empresa and ventipolin.codigo = venliped.tipolinea ~n"+&
				  "		LEFT OUTER JOIN venenvio ON venped.empresa = venenvio.empresa AND venped.cliente = venenvio.cliente AND venped.envio = venenvio.codigo ~n"+&
				  "		LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo ~n"+&
				  "      LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo ~n"+&
				  "      LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo ~n"+&		  
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
				  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) ~n"+&
				  ls_filtro_cliente+&
				  ls_filtro_envio+&
				  "ORDER BY venped.anyo, ~n"+&
				  "		   venped.pedido, ~n"+& 
				  "		   venliped.linea"	
	*/
		
//			  "       convert(dec(10,2),venliped.peso) as peso_kg, ~n"+&		
		
	ls_sel ="SELECT venped.empresa, ~n"+&
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
			  "		 venliped.situacion, ~n"+&
			  "       venliped.id_alm_orden_carga, ~n"+&
			  "       venliped.ordenacion_orden_carga, ~n"+&
			  "       venliped.bulto_desde_orden_carga, ~n"+&
			  "       venliped.bulto_hasta_orden_carga, ~n"+&
			  "       venliped.tipolinea, ~n"+&
			  "       convert(dec(10,2), venliped.peso + ( ( case when venliped.situacion = 'P' then 0 else convert(dec(16,2), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) else 0 end ) end) * pallets.peso ) ) as peso_bruto_calculado_kg, ~n"+&
			  "      "+string(ll_id_alm_orden_carga)+" as id_alm_orden_carga_actual, ~n"+&
			  "       -1.000 as disponible, ~n"+&
			  "       0.000 as planificado, ~n"+&
			  "       venliped.fentrega as fecha_fin_planificacion_minima, ~n"+&
			  "       venliped.fentrega as fecha_fin_planificacion_maxima, ~n"+&
			  "       case venliped.situacion when 'P' then 50 when 'C' then 40 else 10 end as estado_linea, ~n"+&
			  "       case when venliped.situacion = 'P' then 0 else convert(dec(16,2), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) * 100 else 0 end ) end as porcentaje_pallet_pico, ~n"+&
			  "       venliped.fentrega, ~n"+&
			  "       isnull(ventipolin.gestionar_en_piezas,'') as gestionar_en_piezas, ~n"+&
			  "       convert(dec(10,2),venliped.peso_neto) as peso_neto_kg, ~n"+&  
			  "		 isnull(venliped.cantidad_pzs,0) as cantidad_pzs, ~n"+&  
			  "		 isnull(venliped.precio_pzs,0) as precio_pzs, ~n"+&  
			  "		 0 as disponible_pzs, ~n"+&
			  "		 venliped.total_cajas ~n"+&
			  "FROM  venped ~n"+&
			  "      INNER JOIN venliped ON venped.empresa = venliped.empresa AND venped.anyo = venliped.anyo AND venped.pedido = venliped.pedido ~n"+&
			  "      LEFT OUTER JOIN ventipolin ON ventipolin.empresa = venliped.empresa and ventipolin.codigo = venliped.tipolinea ~n"+&			  
			  "		LEFT OUTER JOIN venenvio ON venped.empresa = venenvio.empresa AND venped.cliente = venenvio.cliente AND venped.envio = venenvio.codigo ~n"+&
		 	  "		LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo ~n"+&
			  "      LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo ~n"+&
			  "      LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo ~n"+&		  
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
			  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) ~n"+&
			  "AND   ( venliped.id_alm_orden_carga = '"+string(ll_id_alm_orden_carga,"#####0")+"' ) ~n"+&			  
			  "ORDER BY venped.anyo, ~n"+&
			  "		   venped.pedido, ~n"+& 
			  "		   venliped.linea"
			  		
	ll_rows = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	if ll_rows > 0 then
		dw_lineas_orden.object.data = ds_datos.object.data
	end if
	
	destroy ds_datos
end if

dw_lineas_orden.setredraw(true)

return ll_rows
end function

public function integer f_post_itemchanged (long row, dwobject dwo, string data);long fila 
string cadena
dec    cantidad_redondeada,cantidad_restante,cantidad_original
long   ll_pallets,ll_cajas,ll_donde,ll_pedido,ll_ultima_linea_insertada
integer posi, posi_aux,li_anyo,li_linea,li_nueva_linea,li_indice_array,li_total_array
str_venliped lstr_venliped[]
	
if dwo.name = "cantidad" then
	cadena = f_calculo_unidades_tipolin (codigo_empresa, dw_pedidos_pendientes.object.articulo[row], dw_pedidos_pendientes.object.tipo_pallet[row], dw_pedidos_pendientes.object.caja[row], 0, 0, dec (data), dw_pedidos_pendientes.object.tipolinea[row])

	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		ll_pallets = long(Mid(cadena,1,posi - 1))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
		ll_cajas = long(Mid(cadena,posi_aux,posi - posi_aux ))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		cantidad_redondeada = dec(Mid(cadena,posi_aux,posi - posi_aux ))
		posi_aux = posi + 1
	end if
	
	dw_pedidos_pendientes.object.pallets[row]  = ll_pallets
	dw_pedidos_pendientes.object.cajas[row]    = ll_cajas	
	dw_pedidos_pendientes.object.cantidad[row] = cantidad_redondeada
				
	li_anyo   = dw_pedidos_pendientes.object.anyo[row]
	ll_pedido = dw_pedidos_pendientes.object.pedido[row]
	li_linea  = dw_pedidos_pendientes.object.linea[row]
	
	select isnull(venliped.cantidad,0)
	into   :cantidad_original
	from   venliped
	where  venliped.empresa = :codigo_empresa
	and    venliped.anyo    = :li_anyo
	and    venliped.pedido  = :ll_pedido
	and    venliped.linea   = :li_linea;
	
	cantidad_restante = cantidad_original - cantidad_redondeada
	//f_dividir_linea_venliped_nueva(codigo_empresa, dw_pedidos_pendientes.object.anyo[row], dw_pedidos_pendientes.object.pedido[row], dw_pedidos_pendientes.object.linea[row], cantidad_redondeada,lstr_venliped)
	//li_nueva_linea = f_dividir_linea_venliped (codigo_empresa, dw_pedidos_pendientes.object.anyo[row], dw_pedidos_pendientes.object.pedido[row], dw_pedidos_pendientes.object.linea[row], cantidad_redondeada)
	
	if f_dividir_linea_venliped_nueva(codigo_empresa, dw_pedidos_pendientes.object.anyo[row], dw_pedidos_pendientes.object.pedido[row], dw_pedidos_pendientes.object.linea[row], cantidad_redondeada,lstr_venliped) then
		commit using sqlca;
		
		li_total_array = upperbound(lstr_venliped)
		
		ll_ultima_linea_insertada = row
		
		for li_indice_array = 1 to li_total_array
			
			ll_donde = dw_pedidos_pendientes.find("anyo = "+string(lstr_venliped[li_indice_array].anyo,"###0")+" and pedido = "+string(lstr_venliped[li_indice_array].pedido,"#####0")+" and linea = "+string(lstr_venliped[li_indice_array].linea,"###0"),1,dw_pedidos_pendientes.rowcount())
			
			if ll_donde = 0 then
				ll_donde = dw_pedidos_pendientes.insertrow(ll_ultima_linea_insertada +1)
				
				ll_ultima_linea_insertada = ll_donde
				
				dw_pedidos_pendientes.object.data[ll_donde] = dw_pedidos_pendientes.object.data[row]
				
				dw_pedidos_pendientes.object.pallets[ll_donde]            = lstr_venliped[li_indice_array].pallets
				dw_pedidos_pendientes.object.cajas[ll_donde]              = lstr_venliped[li_indice_array].cajas
				dw_pedidos_pendientes.object.cantidad[ll_donde]           = lstr_venliped[li_indice_array].cantidad
				dw_pedidos_pendientes.object.linea[ll_donde]              = lstr_venliped[li_indice_array].linea
				//Pesos
				dw_pedidos_pendientes.object.peso_kg[ll_donde]            = lstr_venliped[li_indice_array].peso
				dw_pedidos_pendientes.object.peso_neto_kg[ll_donde]       = lstr_venliped[li_indice_array].peso_neto
				
				dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = 0
				dw_pedidos_pendientes.SetItemStatus(ll_donde, 0, Primary!, NotModified!)
				
				ll_donde = dw_updatea_venliped.insertrow(0)
				dw_updatea_venliped.object.venliped_empresa[ll_donde]                 = lstr_venliped[li_indice_array].empresa
				dw_updatea_venliped.object.venliped_anyo[ll_donde]                    = lstr_venliped[li_indice_array].anyo
				dw_updatea_venliped.object.venliped_pedido[ll_donde]                  = lstr_venliped[li_indice_array].pedido
				dw_updatea_venliped.object.venliped_linea[ll_donde]                   = lstr_venliped[li_indice_array].linea
				dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde]      = 0
				dw_updatea_venliped.object.venliped_ordenacion_orden_carga[ll_donde]  = 0
				dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = 0
				dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = 0
				
				//No se puede pasar del status New! a NotModified! 
				//Si lo pasamos a DataModified! es como pasarlo a NotModified!
				dw_updatea_venliped.SetItemStatus(ll_donde, 0, Primary!, DataModified!)
				
				il_rows_dw_updatea_venliped = dw_updatea_venliped.rowcount()				
				
			else
				dw_pedidos_pendientes.object.pallets[ll_donde]            = lstr_venliped[li_indice_array].pallets
				dw_pedidos_pendientes.object.cajas[ll_donde]              = lstr_venliped[li_indice_array].cajas
				dw_pedidos_pendientes.object.cantidad[ll_donde]           = lstr_venliped[li_indice_array].cantidad
				dw_pedidos_pendientes.object.linea[ll_donde]              = lstr_venliped[li_indice_array].linea
				//Pesos
				dw_pedidos_pendientes.object.peso_kg[ll_donde]            = lstr_venliped[li_indice_array].peso
				dw_pedidos_pendientes.object.peso_neto_kg[ll_donde]       = lstr_venliped[li_indice_array].peso_neto
				
				//dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = 0
				//dw_pedidos_pendientes.SetItemStatus(ll_donde, 0, Primary!, NotModified!)				
			end if
															
		next
				
	else
		rollback using sqlca;
	end if
	
	//Refrescar la datawindow//pb_anyadir1.TriggerEvent ( clicked!)
	
	string ls_cliente,ls_envio,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_articulo,ls_calidad
	//Recalculamos los disponibles
	ls_cliente            = dw_1.object.cliente[1]
	ls_envio              = dw_1.object.envio[1]
	
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
	
	ls_articulo    = dw_pedidos_pendientes.object.articulo[row]
	ls_calidad     = dw_pedidos_pendientes.object.calidad[row]
	
	ls_filtro_articulo_calidad = " and venliped.articulo = '"+ls_articulo+"' and venliped.calidad = '"+ls_calidad+"' "	
	
	f_calculo_disponibilidad_dw(dw_pedidos_pendientes,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_articulo,ls_calidad)			
	
	dw_pedidos_pendientes.setrow(row)
	dw_pedidos_pendientes.ScrollToRow(row)    

end if

return 1
end function

public subroutine f_calculo_disponibilidad (ref datastore ds_datos, string ls_filtro_cliente, string ls_filtro_envio, string ls_filtro_articulo_calidad);string ls_sel,ls_find
long ll_indice,ll_total,ll_donde,ll_rows,ll_rows_datos_planificacion,ll_donde_datos_planificacion,ll_pedido,ll_linea
int  li_anyo
dec  ld_disponible,ld_planificado 
datetime ldt_fecha_fin_planificacion_minima,ldt_fecha_fin_planificacion_maxima

datastore ds_datos_planificacion
pointer oldpointer
this.setredraw(false)
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
this.setredraw(true)
SetPointer(oldpointer)

/* script viejo
string ls_sel,ls_find
long ll_indice,ll_total,ll_donde,ll_rows,ll_rows_datos_planificacion,ll_donde_datos_planificacion,ll_pedido,ll_linea
int  li_anyo
dec  ld_disponible,ld_planificado 
datetime ldt_fecha_fin_planificacion_minima,ldt_fecha_fin_planificacion_maxima

datastore ds_datos_planificacion
pointer oldpointer
this.setredraw(false)
oldpointer = SetPointer(AppStarting!)//(HourGlass!)

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
this.setredraw(true)
SetPointer(oldpointer)
*/
end subroutine

public subroutine f_calculo_disponibilidad_dw (ref datawindow ds_datos, string ls_filtro_cliente, string ls_filtro_envio, string ls_filtro_articulo_calidad, string ls_articulo, string ls_calidad);string ls_sel,ls_find
long ll_indice,ll_total,ll_donde,ll_rows,ll_rows_datos_planificacion,ll_donde_datos_planificacion,ll_pedido,ll_linea
int  li_anyo
dec  ld_disponible,ld_planificado 
datetime ldt_fecha_fin_planificacion_minima,ldt_fecha_fin_planificacion_maxima

datastore ds_datos_planificacion
pointer oldpointer
this.setredraw(false)
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

for ll_indice = 1 to ll_total
	if ds_datos.object.situacion[ll_indice] = 'F' and ds_datos.object.articulo[ll_indice] = ls_articulo and ds_datos.object.calidad[ll_indice] = ls_calidad then
		ds_datos.object.disponible[ll_indice] = -1
	end if		
next

for ll_indice = 1 to ll_total
	//ds_datos.object.disponible[ll_indice] = -1 and 
	//if ds_datos.object.situacion[ll_indice] = 'F' and ds_datos.object.articulo[ll_indice] = ls_articulo and ds_datos.object.calidad[ll_indice] = ls_calidad then
	if ds_datos.object.disponible[ll_indice] = -1 and ds_datos.object.situacion[ll_indice] = 'F' and ds_datos.object.articulo[ll_indice] = ls_articulo and ds_datos.object.calidad[ll_indice] = ls_calidad then
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
this.setredraw(true)
SetPointer(oldpointer)

/* script viejo
string ls_sel,ls_find
long ll_indice,ll_total,ll_donde,ll_rows,ll_rows_datos_planificacion,ll_donde_datos_planificacion,ll_pedido,ll_linea
int  li_anyo
dec  ld_disponible,ld_planificado 
datetime ldt_fecha_fin_planificacion_minima,ldt_fecha_fin_planificacion_maxima

datastore ds_datos_planificacion
pointer oldpointer
this.setredraw(false)
oldpointer = SetPointer(AppStarting!)//(HourGlass!)

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

for ll_indice = 1 to ll_total
	//ds_datos.object.disponible[ll_indice] = -1 and 
	if ds_datos.object.situacion[ll_indice] = 'F' and ds_datos.object.articulo[ll_indice] = ls_articulo and ds_datos.object.calidad[ll_indice] = ls_calidad then
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

		if ds_datos.object.disponible[ll_indice] >= ds_datos.object.cantidad[ll_indice] then
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
				
				if ds_datos.object.disponible[ll_donde] >= ds_datos.object.cantidad[ll_donde] then
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
this.setredraw(true)
SetPointer(oldpointer)
*/
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
articulo = dw_pedidos_pendientes.object.articulo[arg_row]

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

public function integer f_post_itemchanged_old (long row, dwobject dwo, string data);long fila 
string cadena
dec    cantidad_redondeada,cantidad_restante,cantidad_original
long   ll_pallets,ll_cajas,ll_donde,ll_pedido
integer posi, posi_aux,li_anyo,li_linea,li_nueva_linea

	
if dwo.name = "cantidad" then
	cadena = f_calculo_unidades_tipolin (codigo_empresa, dw_pedidos_pendientes.object.articulo[row], dw_pedidos_pendientes.object.tipo_pallet[row], dw_pedidos_pendientes.object.caja[row], 0, 0, dec (data), dw_pedidos_pendientes.object.tipolinea[row])

	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		ll_pallets = long(Mid(cadena,1,posi - 1))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
		ll_cajas = long(Mid(cadena,posi_aux,posi - posi_aux ))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		cantidad_redondeada = dec(Mid(cadena,posi_aux,posi - posi_aux ))
		posi_aux = posi + 1
	end if
	
	dw_pedidos_pendientes.object.pallets[row]  = ll_pallets
	dw_pedidos_pendientes.object.cajas[row]    = ll_cajas	
	dw_pedidos_pendientes.object.cantidad[row] = cantidad_redondeada
	
	li_anyo   = dw_pedidos_pendientes.object.anyo[row]
	ll_pedido = dw_pedidos_pendientes.object.pedido[row]
	li_linea  = dw_pedidos_pendientes.object.linea[row]
	
	select isnull(venliped.cantidad,0)
	into   :cantidad_original
	from   venliped
	where  venliped.empresa = :codigo_empresa
	and    venliped.anyo    = :li_anyo
	and    venliped.pedido  = :ll_pedido
	and    venliped.linea   = :li_linea;
	
	cantidad_restante = cantidad_original - cantidad_redondeada
	//f_dividir_linea_venliped_nueva()
	li_nueva_linea = f_dividir_linea_venliped (codigo_empresa, dw_pedidos_pendientes.object.anyo[row], dw_pedidos_pendientes.object.pedido[row], dw_pedidos_pendientes.object.linea[row], cantidad_redondeada)
	
	if li_nueva_linea <> 0 then
		commit using sqlca;
	else
		rollback using sqlca;
	end if
	
	//Refrescar la datawindow//pb_anyadir1.TriggerEvent ( clicked!)
	if cantidad_restante > 0 then
		ll_donde = dw_pedidos_pendientes.insertrow(row+1)
		
		dw_pedidos_pendientes.object.data[ll_donde] = dw_pedidos_pendientes.object.data[row]
		
		cadena = f_calculo_unidades_tipolin (codigo_empresa, dw_pedidos_pendientes.object.articulo[row], dw_pedidos_pendientes.object.tipo_pallet[row], dw_pedidos_pendientes.object.caja[row], 0, 0, cantidad_restante, dw_pedidos_pendientes.object.tipolinea[row])
	
		posi_aux = 1
		posi = pos(cadena,"|",1)
		if posi <> 0 then
			ll_pallets = long(Mid(cadena,1,posi - 1))
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <> 0 then
			ll_cajas = long(Mid(cadena,posi_aux,posi - posi_aux ))
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			cantidad_redondeada = dec(Mid(cadena,posi_aux,posi - posi_aux ))
			posi_aux = posi + 1
		end if
		
		dw_pedidos_pendientes.object.pallets[ll_donde]            = ll_pallets
		dw_pedidos_pendientes.object.cajas[ll_donde]              = ll_cajas
		dw_pedidos_pendientes.object.cantidad[ll_donde]           = cantidad_redondeada		
		dw_pedidos_pendientes.object.linea[ll_donde]              = li_nueva_linea
		dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = 0
		dw_pedidos_pendientes.SetItemStatus(ll_donde, 0, Primary!, NotModified!)
		
		ll_donde = dw_updatea_venliped.insertrow(0)
		dw_updatea_venliped.object.venliped_empresa[ll_donde]                 = codigo_empresa
		dw_updatea_venliped.object.venliped_anyo[ll_donde]                    = li_anyo
		dw_updatea_venliped.object.venliped_pedido[ll_donde]                  = ll_pedido
		dw_updatea_venliped.object.venliped_linea[ll_donde]                   = li_nueva_linea
		dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde]      = 0
		dw_updatea_venliped.object.venliped_ordenacion_orden_carga[ll_donde]  = 0
		dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = 0
		dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = 0
		
		//No se puede pasar del status New! a NotModified! 
		//Si lo pasamos a DataModified! es como pasarlo a NotModified!
		dw_updatea_venliped.SetItemStatus(ll_donde, 0, Primary!, DataModified!)
		
		il_rows_dw_updatea_venliped = dw_updatea_venliped.rowcount()
	end if
	
	dw_pedidos_pendientes.setrow(row)
	dw_pedidos_pendientes.ScrollToRow(row)    

end if

return 1
end function

public function long f_cargar_pedidos (boolean arg_refrescar);string ls_sel,ls_filtro_cliente,ls_filtro_envio,ls_cliente,ls_envio,ls_filtro_articulo_calidad
long   ll_total,ll_row,ll_rows,ll_id_alm_orden_carga,ll_FirstRowOnPage,ll_pedido_inicia_pagina
long   ll_indice_oc,ll_donde,ll_pedido_orden,ll_st_pedidos_pendientes_textcolor
int    li_anyo_pedido_inicia_pagina,li_linea_pedido_inicia_pagina,li_anyo_pedido_orden,li_linea_pedido_orden
datastore ds_datos

ll_st_pedidos_pendientes_textcolor = st_pedidos_pendientes.textcolor
st_pedidos_pendientes.textcolor = rgb(255,0,0)//47917

dw_pedidos_pendientes.setredraw(false)

if arg_refrescar then
	st_pedidos_pendientes.text = 'Refrescando ....'
	ll_FirstRowOnPage = long(dw_pedidos_pendientes.Object.DataWindow.FirstRowOnPage)
	
	if ll_FirstRowOnPage > 0 then
		li_anyo_pedido_inicia_pagina  = dw_pedidos_pendientes.Object.anyo[ll_FirstRowOnPage]
		ll_pedido_inicia_pagina       = dw_pedidos_pendientes.Object.pedido[ll_FirstRowOnPage]
		li_linea_pedido_inicia_pagina = dw_pedidos_pendientes.Object.linea[ll_FirstRowOnPage]
	end if
else
	st_pedidos_pendientes.text = 'Cargando ....'
end if

if isnull(ldt_ultima_carga_pedidos_pendientes) or SecondsAfter(time(ldt_ultima_carga_pedidos_pendientes), now()) > 45 or arg_refrescar then
	
	dw_pedidos_pendientes.reset()
	dw_pedidos_pendientes.setfilter("")
	
	if not(arg_refrescar) then
		dw_updatea_venliped.reset()
	end if	
	
	if dw_1.rowcount() = 1 then
		ll_id_alm_orden_carga = dw_1.object.id[1]
		ls_cliente            = dw_1.object.cliente[1]
		ls_envio              = dw_1.object.envio[1]
		
		if trim(ls_cliente) <> "" then
			if not(arg_refrescar) then
				il_rows_dw_updatea_venliped = dw_updatea_venliped.retrieve(codigo_empresa,ls_cliente)
			else
				il_rows_dw_updatea_venliped = dw_updatea_venliped.rowcount()
			end if
			ls_filtro_cliente = "AND   ( venped.cliente = '"+ls_cliente+"' ) "
		else
			ls_filtro_cliente = ""
		end if
		
		if trim(ls_cliente) <> "" and trim(ls_envio) <> "" then
			ls_filtro_envio = "AND   ( venped.envio = '"+ls_envio+"' ) "
		else
			ls_filtro_envio = "AND   ( isnull(venped.envio,'') = '' ) "
		end if
		
//				  "       convert(dec(10,2),venliped.peso) as peso_kg, ~n"+&		
		
		ls_sel ="SELECT venped.empresa, ~n"+&
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
				  "      "+string(ll_id_alm_orden_carga)+" as id_alm_orden_carga_actual, ~n"+&
				  "       -1.000 as disponible, ~n"+&
				  "       0.000 as planificado, ~n"+&
				  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_minima, ~n"+&
				  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_maxima, ~n"+&
				  "       case when isnull(venliped.articulo,'') = '' then 40 else case venliped.situacion when 'P' then 50 when 'C' then 40 else 10 end end as estado_linea, ~n"+&
				  "       case when venliped.situacion = 'P' then 0 else convert(dec(16,6), case when isnull(palarticulo.cajaspallet,0) <> 0 and isnull(almartcajas.piezascaja,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) * 100 else 0 end ) end as porcentaje_pallet_pico, ~n"+&
				  "       venliped.fentrega, ~n"+&
				  "       isnull(ventipolin.gestionar_en_piezas,'') as gestionar_en_piezas, ~n"+&
				  "       convert(dec(10,2),venliped.peso_neto) as peso_neto_kg, ~n"+&  
				  "		 isnull(venliped.cantidad_pzs,0) as cantidad_pzs, ~n"+&  
				  "		 isnull(venliped.precio_pzs,0) as precio_pzs, ~n"+&  
				  "		 0 as disponible_pzs, ~n"+&
				  "		 venliped.total_cajas ~n"+&
				  "FROM  venped ~n"+&
				  "      INNER JOIN venliped ON venped.empresa = venliped.empresa AND venped.anyo = venliped.anyo AND venped.pedido = venliped.pedido ~n"+&
				  "      LEFT OUTER JOIN ventipolin ON ventipolin.empresa = venliped.empresa and ventipolin.codigo = venliped.tipolinea ~n"+&
				  "		LEFT OUTER JOIN venenvio ON venped.empresa = venenvio.empresa AND venped.cliente = venenvio.cliente AND venped.envio = venenvio.codigo ~n"+&
				  "		LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo ~n"+&
				  "      LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo ~n"+&
				  "      LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo ~n"+&		  
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
				  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) ~n"+&
				  ls_filtro_cliente+&
				  ls_filtro_envio+&
				  "ORDER BY venped.anyo, ~n"+&
				  "		   venped.pedido, ~n"+& 
				  "		   venliped.linea"
		
		
		ll_rows = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		//clipboard(ls_sel)
		
		if ll_rows > 0 then
			//Primero calcularemos los datos de disponiblilidad y situacion de la disponiblilidad
			f_calculo_disponibilidad(ds_datos,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad)
			//
			dw_pedidos_pendientes.object.data = ds_datos.object.data
			dw_pedidos_pendientes.Event rowfocuschanged(1)
		end if
		
		destroy ds_datos
	end if
	
//	cbx_ocultar_pedidos_en_orden_de_carga.event clicked()
//		
//	dw_pedidos_pendientes.sort()	
//	dw_pedidos_pendientes.groupcalc()		
	
	if arg_refrescar and ll_FirstRowOnPage > 0 then
		ll_FirstRowOnPage = dw_pedidos_pendientes.find("anyo = "+string(li_anyo_pedido_inicia_pagina)+" and pedido = "+string(ll_pedido_inicia_pagina)+" and linea = "+string(li_linea_pedido_inicia_pagina),1,ll_rows)
	
		dw_pedidos_pendientes.scrolltorow(ll_FirstRowOnPage)
	end if
	
	if arg_refrescar and dw_lineas_orden.rowcount() > 0 then
		for ll_indice_oc = 1 to dw_lineas_orden.rowcount()
			li_anyo_pedido_orden  = dw_lineas_orden.object.anyo[ll_indice_oc]
			ll_pedido_orden       = dw_lineas_orden.object.pedido[ll_indice_oc]
			li_linea_pedido_orden = dw_lineas_orden.object.linea[ll_indice_oc]
			
			ll_donde = dw_pedidos_pendientes.find("anyo = "+string(li_anyo_pedido_orden)+" and pedido = "+string(ll_pedido_orden)+" and linea = "+string(li_linea_pedido_orden)+" and id_alm_orden_carga <> "+string(ll_id_alm_orden_carga),1,ll_rows)
			
			if ll_donde > 0 then
				dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = ll_id_alm_orden_carga
			end if
		next
	end if
	
	cbx_ocultar_pedidos_en_orden_de_carga.event clicked()
		
	dw_pedidos_pendientes.sort()	
	dw_pedidos_pendientes.groupcalc()					
	
	ldt_ultima_carga_pedidos_pendientes = datetime(today(),now())
else
	ll_rows = dw_pedidos_pendientes.rowcount()
end if

st_pedidos_pendientes.textcolor = ll_st_pedidos_pendientes_textcolor
st_pedidos_pendientes.text = 'Pedidos Pendientes'

dw_pedidos_pendientes.setredraw(true)

return ll_rows
end function

event open;call super::open;dw_updatea_venliped.visible = false
dw_updatea_venliped.settransobject(sqlca)

istr_parametros.s_titulo_ventana = "Mantenimiento de Ordenes de Carga [ "+f_nombre_empresa(codigo_empresa)+" ]"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

dw_pedidos_pendientes.settransobject(sqlca)
dw_trans.settransobject(sqlca)
dw_cargas.settransobject(sqlca)

tipo_mantenimiento = 'N'

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	
	sle_valor.event modificado(0,0)
	
	this.show()
	this.event ue_recuperar(0,0)
//	IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
//		dw_1.Retrieve(codigo_empresa,sle_valor.text)
//	END IF
END IF

if nombre_usuario = "TENCER" or nombre_usuario = "PCOPIA" then
	cb_1.visible = true
	cb_2.visible = true
	cb_3.visible = true
end if
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"id",long(sle_valor.text))
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
//dw_1.setitem(dw_1.getrow(),"fecha",datetime(today()))
dw_1.setitem(dw_1.getrow(),"usuario",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"cliente","")
dw_1.setitem(dw_1.getrow(),"envio","")
dw_1.setitem(dw_1.getrow(),"observaciones","")
dw_1.setitem(dw_1.getrow(),"almtipotransportes_codigo","")
dw_1.setitem(dw_1.getrow(),"peso_maximo",0)
dw_1.setitem(dw_1.getrow(),"fecha_alta",datetime(today(),now()))
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo       =  This.title
longitud     =  len(Trim(sle_valor.text))
criterio[1]  =  trim(sle_valor.text)+space(20-longitud)
seleccion    =  criterio[1]//+criterio[2]
tabla        = "alm_orden_carga"

if dw_1.Retrieve(codigo_empresa,long(sle_valor.Text)) = 0 then
	dw_1.SetTabOrder("cliente",20)
	dw_1.SetTabOrder("envio",30)	
else
	dw_1.SetTabOrder("cliente",0)
	dw_1.SetTabOrder("envio",0)	
end if

f_cargar_pedidos(false)
f_cargar_lineas_orden_carga()

if dw_lineas_orden.rowcount() = 0 then
	dw_1.SetTabOrder("cliente",20)
	dw_1.SetTabOrder("envio",30)	
end if

CALL Super::ue_recuperar



end event

on wi_mant_alm_orden_carga.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.p_imprimir_pendientes=create p_imprimir_pendientes
this.dw_lineas_orden=create dw_lineas_orden
this.dw_pedidos_pendientes=create dw_pedidos_pendientes
this.p_1=create p_1
this.dw_updatea_venliped=create dw_updatea_venliped
this.dw_stock=create dw_stock
this.st_cabecera_orden=create st_cabecera_orden
this.st_lineas_orden=create st_lineas_orden
this.dwtc_reparto_fabricaciones=create dwtc_reparto_fabricaciones
this.cbx_ocultar_pedidos_en_orden_de_carga=create cbx_ocultar_pedidos_en_orden_de_carga
this.uo_articulo=create uo_articulo
this.cbx_filtrar_articulo=create cbx_filtrar_articulo
this.p_refrescar_pedidos=create p_refrescar_pedidos
this.st_pedidos_pendientes=create st_pedidos_pendientes
this.dw_imprimir=create dw_imprimir
this.cbx_promocion=create cbx_promocion
this.cb_2=create cb_2
this.cb_3=create cb_3
this.ds_alm_orden_carga=create ds_alm_orden_carga
this.ds_alm_orden_preparacion=create ds_alm_orden_preparacion
this.cb_4=create cb_4
this.cb_1=create cb_1
this.dw_trans=create dw_trans
this.dw_cargas=create dw_cargas
this.p_informacion=create p_informacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.p_imprimir_pendientes
this.Control[iCurrent+3]=this.dw_lineas_orden
this.Control[iCurrent+4]=this.dw_pedidos_pendientes
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.dw_updatea_venliped
this.Control[iCurrent+7]=this.dw_stock
this.Control[iCurrent+8]=this.st_cabecera_orden
this.Control[iCurrent+9]=this.st_lineas_orden
this.Control[iCurrent+10]=this.dwtc_reparto_fabricaciones
this.Control[iCurrent+11]=this.cbx_ocultar_pedidos_en_orden_de_carga
this.Control[iCurrent+12]=this.uo_articulo
this.Control[iCurrent+13]=this.cbx_filtrar_articulo
this.Control[iCurrent+14]=this.p_refrescar_pedidos
this.Control[iCurrent+15]=this.st_pedidos_pendientes
this.Control[iCurrent+16]=this.dw_imprimir
this.Control[iCurrent+17]=this.cbx_promocion
this.Control[iCurrent+18]=this.cb_2
this.Control[iCurrent+19]=this.cb_3
this.Control[iCurrent+20]=this.ds_alm_orden_carga
this.Control[iCurrent+21]=this.ds_alm_orden_preparacion
this.Control[iCurrent+22]=this.cb_4
this.Control[iCurrent+23]=this.cb_1
this.Control[iCurrent+24]=this.dw_trans
this.Control[iCurrent+25]=this.dw_cargas
this.Control[iCurrent+26]=this.p_informacion
end on

on wi_mant_alm_orden_carga.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.p_imprimir_pendientes)
destroy(this.dw_lineas_orden)
destroy(this.dw_pedidos_pendientes)
destroy(this.p_1)
destroy(this.dw_updatea_venliped)
destroy(this.dw_stock)
destroy(this.st_cabecera_orden)
destroy(this.st_lineas_orden)
destroy(this.dwtc_reparto_fabricaciones)
destroy(this.cbx_ocultar_pedidos_en_orden_de_carga)
destroy(this.uo_articulo)
destroy(this.cbx_filtrar_articulo)
destroy(this.p_refrescar_pedidos)
destroy(this.st_pedidos_pendientes)
destroy(this.dw_imprimir)
destroy(this.cbx_promocion)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.ds_alm_orden_carga)
destroy(this.ds_alm_orden_preparacion)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.dw_trans)
destroy(this.dw_cargas)
destroy(this.p_informacion)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_actualiza_dw;long ll_Rows

ll_Rows = dw_updatea_venliped.ModifiedCount()
dw_updatea_venliped.AcceptText()

if dw_updatea_venliped.update(true) = 1 then
	//Vamos a eliminar las reservas de los pedidos que ya no tienen O.C.

	delete venliped_reservas
	where  venliped_reservas.empresa = :codigo_empresa
	and exists (select venliped.anyo,
							 venliped.pedido,
							 venliped.linea 
					from   venliped
					where  venliped.empresa = venliped_reservas.empresa
					and    venliped.anyo    = venliped_reservas.anyo
					and    venliped.pedido  = venliped_reservas.pedido
					and    venliped.linea   = venliped_reservas.linea
					and    venliped.id_alm_orden_carga = 0);
					
	if sqlca.sqlcode <> 0 then
		rollback;
		messagebox("¡Error!","Se ha producido un error al actualizar las reservas de los pedidos.")		
	else	
		call super::ue_actualiza_dw
	end if
else
	rollback;
	messagebox("¡Error!","Se ha producido un error al actualizar las lineas de los pedidos.")
end if
end event

event ue_borra_fila;long ll_Rows,ll_x,ll_y,ll_row

ll_x   = 0
ll_y   = 0
ll_row = -1

dw_lineas_orden.event clicked(ll_x,ll_y,ll_row,dw_lineas_orden.object.p_todo)

ll_Rows = dw_updatea_venliped.ModifiedCount()
dw_updatea_venliped.AcceptText()

if dw_updatea_venliped.update(true) = 1 then
	//Vamos a eliminar las reservas de los pedidos que ya no tienen O.C.

	delete venliped_reservas
	where  venliped_reservas.empresa = :codigo_empresa
	and exists (select venliped.anyo,
							 venliped.pedido,
							 venliped.linea 
					from   venliped
					where  venliped.empresa = venliped_reservas.empresa
					and    venliped.anyo    = venliped_reservas.anyo
					and    venliped.pedido  = venliped_reservas.pedido
					and    venliped.linea   = venliped_reservas.linea
					and    venliped.id_alm_orden_carga = 0);
					
	if sqlca.sqlcode <> 0 then
		rollback;
		messagebox("¡Error!","Se ha producido un error al actualizar las reservas de los pedidos.")		
	else		
		call super::ue_borra_fila
	end if
else
	rollback;
	messagebox("¡Error!","Se ha producido un error al actualizar las lineas de los pedidos.")
end if
end event

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_alm_orden_carga
integer x = 32
integer width = 4695
integer height = 752
string title = "Cabecera Orden"
string dataobject = "dw_mant_alm_orden_carga"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::itemchanged;call super::itemchanged;string ls_cliente,ls_envio
int    li_existe
long   ll_lineas_reservadas,ll_id_alm_orden_preparacion,ll_id_alm_orden_carga

choose case dwo.name 
	case "confirmada"
		if data = 'N' then
			ll_id_alm_orden_carga = long(sle_valor.text)
			
			select isnull(count(*),0)
			into   :ll_lineas_reservadas
			from   venliped_reservas 
					 inner join venliped on venliped_reservas.empresa = venliped.empresa and venliped_reservas.anyo = venliped.anyo and venliped_reservas.pedido = venliped.pedido and venliped_reservas.linea = venliped.linea 
			where  venliped_reservas.empresa   = :codigo_empresa
			and    venliped.id_alm_orden_carga = :ll_id_alm_orden_carga;
			
			select isnull(max(venliped.id_alm_orden_preparacion),0)
			into   :ll_id_alm_orden_preparacion
			from   venliped
			where  venliped.empresa            = :codigo_empresa
			and    venliped.id_alm_orden_carga = :ll_id_alm_orden_carga;
			
			if ll_id_alm_orden_preparacion = 0 and ll_lineas_reservadas = 0 then				
				
			else
				messagebox("¡Atención!","No se puede quitar la confirmación de una orden con reservas u orden de preparación asignada.")
				return 2
			end if
		end if
	case "cliente"
		if isnumber(data) then
			ls_cliente = data
			
			li_existe  = 0
			
			select isnull(count(*),0)
			into   :li_existe
			from   venclientes
			where  venclientes.empresa = :codigo_empresa
			and    venclientes.codigo  = :ls_cliente;
			
			if li_existe = 0 and data <> "" then
				return 2
			else
				this.object.envio[row] = ""
				setnull(ldt_ultima_carga_pedidos_pendientes)
				parent.post f_cargar_pedidos(false)
				parent.post f_cargar_lineas_orden_carga()
			end if
		end if
	case "envio"		
		if isnumber(data) then
			ls_cliente = this.object.cliente[row] 
			ls_envio   = data
			
			li_existe  = 0
			
			select isnull(count(*),0)
			into   :li_existe
			from   venenvio
			where  venenvio.empresa = :codigo_empresa
			and    venenvio.cliente = :ls_cliente
			and    venenvio.codigo  = :ls_envio;
			
			if li_existe = 0 and data <> "" then
				return 2
			else
				setnull(ldt_ultima_carga_pedidos_pendientes)
				parent.post f_cargar_pedidos(false)
				parent.post f_cargar_lineas_orden_carga()
			end if
		end if
		
	case "fecha"
		dw_trans.retrieve(codigo_empresa, datetime(data))
end choose
end event

event dw_1::key;bus_filtro=""
bus_titulo=""
valor_empresa = TRUE
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "cliente"
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE CLIENTES"
	CASE "envio"
		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo     = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
		bus_filtro     = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "almtipotransportes_codigo"
 		bus_datawindow = "dw_ayuda_almtipotransportes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE TRANSPORTES"			
	CASE "centro_logistico"
		bus_datawindow = "dw_ayuda_centro_logistico"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE LUGAR DE CARGA"
		valor_empresa  = FALSE
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::Key
end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 
 CHOOSE CASE bus_campo
	CASE "cliente"
		bus_titulo     = "VENTANA SELECCION CLIENTES"
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
	CASE "envio"
		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "almtipotransportes_codigo"
 		bus_datawindow = "dw_ayuda_almtipotransportes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE TRANSPORTES"				
	CASE "centro_logistico"
		bus_datawindow = "dw_ayuda_centro_logistico"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE LUGAR DE CARGA"
		valor_empresa  = FALSE			
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 
 CALL Super::rbuttondown
end event

event dw_1::retrieveend;call super::retrieveend;if rowcount > 0 then
	dw_trans.retrieve(codigo_empresa, dw_1.object.fecha[1])
end if
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_alm_orden_carga
integer x = 23
integer y = 36
integer width = 123
string text = "ID"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_alm_orden_carga
integer x = 3497
integer y = 20
end type

event cb_insertar::clicked;Integer li_opcion

reg_insertado = FALSE
if dw_1.rowcount() <> 0 then
	dw_trans.retrieve(codigo_empresa, dw_1.object.fecha[1])
end if
dw_1.AcceptText()
  
IF cb_insertar.enabled =TRUE THEN
     IF Not wc_control_columnas() then
        //MESSAGEBOX("","AQUI HACE EL RETURN")
        return
     END IF
     
     if (trim(dw_1.object.cliente[1]) <> '') and (isnull(dw_1.object.almtipotransportes_codigo[1]) or trim(dw_1.object.almtipotransportes_codigo[1]) = '') then
        messagebox("Campo Obligatorio","Debe indicar el tipo de transporte.")
        return 1
     elseif (trim(dw_1.object.cliente[1]) <> '') and (isnull(dw_1.object.centro_logistico[1]) or trim(dw_1.object.centro_logistico[1]) = '') then
        messagebox("Campo Obligatorio","Debe indicar el centro logístico.")
        return 1
     else
         IF insercion="N" THEN
             li_opcion = MessageBox("Proceso de Modificacion", "Desea modificar el registro", Question!, YesNo!,2)
         ELSE
             li_opcion=1
         END IF
         IF li_opcion=2 THEN
            dw_1.TriggerEvent("valores_numericos")
            cb_insertar.enabled = FALSE
            cb_borrar.enabled  =TRUE
            Parent.TriggerEvent("ue_recuperar")
            Parent.TriggerEvent("ue_activa_claves")
            Parent.TriggerEvent("ue_desbloquear")
         ELSE
            dw_1.TriggerEvent("valores_numericos")
            Parent.TriggerEvent("ue_actualiza_dw")       
            cb_insertar.enabled = FALSE
            cb_borrar.enabled  =TRUE
            Parent.TriggerEvent("ue_recuperar")
            Parent.TriggerEvent("ue_activa_claves")
            Parent.TriggerEvent("ue_desbloquear")
            reg_insertado = TRUE
         END IF
         // saldo de proceso de altas
         insercion= "N"
    end if
ELSE
        cb_insertar.enabled = TRUE
        cb_insertar.Text    = "&Aceptar"
        cb_borrar.enabled   = FALSE
       Parent.TriggerEvent("ue_inserta_fila")
        Parent.TriggerEvent("ue_desactiva_claves")
        control_tabulador.enabled = FALSE
END IF
end event

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_alm_orden_carga
integer x = 3899
integer y = 20
end type

event cb_borrar::clicked;long ll_donde

ll_donde = dw_lineas_orden.find("situacion = 'P' ",1,dw_lineas_orden.rowcount())

if ll_donde > 0 then
	messagebox("¡Atención!","No se puede eliminar un O.C. con lineas preparadas.")
else
	call super::clicked
end if
end event

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_alm_orden_carga
integer x = 146
integer y = 32
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION ORDENES DE CARGA"
ue_datawindow     = "dw_ayuda_alm_orden_carga"
ue_filtro         =  ""
valor_empresa     = true
isle_campo        = This

end event

event sle_valor::busqueda;call super::busqueda;dw_lineas_orden.reset()
dw_pedidos_pendientes.reset()
dw_updatea_venliped.reset()

setnull(ldt_ultima_carga_pedidos_pendientes)
end event

event sle_valor::cambia_valor;call super::cambia_valor;dw_lineas_orden.reset()
dw_pedidos_pendientes.reset()
dw_updatea_venliped.reset()

setnull(ldt_ultima_carga_pedidos_pendientes)
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_alm_orden_carga
integer x = 4302
integer y = 20
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_alm_orden_carga
end type

type pb_calculadora from u_calculadora within wi_mant_alm_orden_carga
integer x = 425
integer y = 28
integer taborder = 0
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled = TRUE THEN Return

long ll_id
//Integer registros
//Select count(*) Into :registros 
//From subformatos
//where empresa = :codigo_empresa;
//
//IF registros=0  Then
//   sle_valor.text="1"
// ELSE
//   Select max(convert(int,codigo)+1) 
//   Into   :sle_valor.text
//   From   subformatos
//	where empresa = :codigo_empresa;
//END IF

//ll_id = f_contador_automatico("cnt_alm_orden_carga",1) //No funciona
ll_id = f_contador_ordenes_carga("contador_ordenes_carga",1)

//messagebox("f_contador_automatico",ll_id)

//sle_valor.ue_ante_valor = sle_valor.text
sle_valor.text = string(ll_id,"###0")
setnull(ldt_ultima_carga_pedidos_pendientes)
dw_1.event clicked(0,0,0,dw_1.object.empresa)

//messagebox("sle_valor.text",sle_valor.text)
//dw_1.TriggerEvent("Clicked")

//sle_valor.ue_valor = sle_valor.text

//sle_valor.TriggerEvent("losefocus")
//sle_valor.TriggerEvent("modificado")
//sle_valor.ue_ante_valor = sle_valor.text

//dw_1.event clicked(0,0,0,dw_1.object.empresa)

end event

type p_imprimir_pendientes from picture within wi_mant_alm_orden_carga
integer x = 4626
integer y = 984
integer width = 101
integer height = 88
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\Print_24x24.png"
boolean border = true
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = dw_pedidos_pendientes.title
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

u_imp.event ue_imprimir(dw_pedidos_pendientes)

destroy u_imp

end event

type dw_lineas_orden from u_datawindow within wi_mant_alm_orden_carga
integer x = 4745
integer y = 224
integer width = 3808
integer height = 3560
integer taborder = 21
string title = "Lineas Orden"
string dataobject = "dw_mant_alm_orden_carga3"
boolean vscrollbar = true
boolean border = false
end type

event clicked;call super::clicked;string ls_objeto_y_row
long   ll_row,ll_total,ll_anyo,ll_pedido,ll_donde
integer li_anyo
long    ll_linea,ll_lineas_reservadas,ll_id_alm_orden_preparacion
			
if not(cb_insertar.enabled) and row >= 0 then
	dw_1.triggerevent(clicked!)
else
	choose case dwo.name
		case "p_todo"			
			ll_total = this.rowcount()
			
			if ll_total > 0 then
				this.setredraw(false)
				
				ll_total = this.rowcount()
				
				if ll_total > 0 then
										
					for ll_row = ll_total to 1 step -1
						
						li_anyo   = this.object.anyo[ll_row]
						ll_pedido = this.object.pedido[ll_row]
						ll_linea  = this.object.linea[ll_row]
						
						select isnull(count(*),0)
						into   :ll_lineas_reservadas
						from   venliped_reservas
						where  venliped_reservas.empresa = :codigo_empresa
						and    venliped_reservas.anyo    = :li_anyo
						and    venliped_reservas.pedido  = :ll_pedido
						and    venliped_reservas.linea   = :ll_linea;
						
						select isnull(venliped.id_alm_orden_preparacion,0)
						into   :ll_id_alm_orden_preparacion
						from   venliped
						where  venliped.empresa = :codigo_empresa
						and    venliped.anyo    = :li_anyo
						and    venliped.pedido  = :ll_pedido
						and    venliped.linea   = :ll_linea;			
						
						if ll_id_alm_orden_preparacion = 0 and ll_lineas_reservadas = 0 then						
						
							ll_donde = dw_pedidos_pendientes.find("empresa = '"+this.object.empresa[ll_row]+"' and anyo = "+string(this.object.anyo[ll_row],"###0")+" and pedido = "+string(this.object.pedido[ll_row],"#######0")+" and linea = "+string(this.object.linea[ll_row],"###0")+" and situacion <> 'P' ",1,il_rows_dw_updatea_venliped)
							if ll_donde > 0 then
								dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = 0
								
								ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
								
								if ll_donde > 0 then
									dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde]      = 0
									dw_updatea_venliped.object.venliped_ordenacion_orden_carga[ll_donde]  = 0
									dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = 0
									dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = 0
								end if
								
								this.rowsmove(1,1,Primary!,this,1,Delete!)
							end if
						end if								
					next
				end if		
												
				this.sort()
				this.groupcalc()
				this.setredraw(true)
			end if		
		case "p_pedido"		
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then
				ll_anyo   = this.object.anyo[ll_row]
				ll_pedido = this.object.pedido[ll_row]
				
				this.setredraw(false)
				this.setfilter("anyo = "+string(ll_anyo,"#####0")+" and pedido = "+string(ll_pedido,"#####0"))
				this.filter()
				
				ll_total = this.rowcount()
				
				if ll_total > 0 then
					this.setredraw(false)
					
					for ll_row = ll_total to 1 step -1
						
						li_anyo   = this.object.anyo[ll_row]
						ll_pedido = this.object.pedido[ll_row]
						ll_linea  = this.object.linea[ll_row]
						
						select isnull(count(*),0)
						into   :ll_lineas_reservadas
						from   venliped_reservas
						where  venliped_reservas.empresa = :codigo_empresa
						and    venliped_reservas.anyo    = :li_anyo
						and    venliped_reservas.pedido  = :ll_pedido
						and    venliped_reservas.linea   = :ll_linea;
						
						select isnull(venliped.id_alm_orden_preparacion,0)
						into   :ll_id_alm_orden_preparacion
						from   venliped
						where  venliped.empresa = :codigo_empresa
						and    venliped.anyo    = :li_anyo
						and    venliped.pedido  = :ll_pedido
						and    venliped.linea   = :ll_linea;			
						
						if ll_id_alm_orden_preparacion = 0 and ll_lineas_reservadas = 0 then												
						
							ll_donde = dw_pedidos_pendientes.find("empresa = '"+this.object.empresa[ll_row]+"' and anyo = "+string(this.object.anyo[ll_row],"###0")+" and pedido = "+string(this.object.pedido[ll_row],"#######0")+" and linea = "+string(this.object.linea[ll_row],"###0")+" and situacion <> 'P' ",1,il_rows_dw_updatea_venliped)
							if ll_donde > 0 then
								dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = 0
								
								ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
								
								if ll_donde > 0 then
									dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde]      = 0
									dw_updatea_venliped.object.venliped_ordenacion_orden_carga[ll_donde]  = 0
									dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = 0
									dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = 0
								end if
								this.rowsmove(1,1,Primary!,this,1,Delete!)									
							end if
						end if							
					next				
					
					this.sort()
					this.groupcalc()
					this.setredraw(true)
				end if					
				
				this.setfilter("")
				this.filter()
				this.sort()
				this.groupcalc()
				this.scrolltorow(ll_row)
				this.setredraw(true)
				
			end if
					
		case "p_linea"
			
			li_anyo   = this.object.anyo[row]
			ll_pedido = this.object.pedido[row]
			ll_linea  = this.object.linea[row]
			
			select isnull(count(*),0)
			into   :ll_lineas_reservadas
			from   venliped_reservas
			where  venliped_reservas.empresa = :codigo_empresa
			and    venliped_reservas.anyo    = :li_anyo
			and    venliped_reservas.pedido  = :ll_pedido
			and    venliped_reservas.linea   = :ll_linea;
			
			select isnull(venliped.id_alm_orden_preparacion,0)
			into   :ll_id_alm_orden_preparacion
			from   venliped
			where  venliped.empresa = :codigo_empresa
			and    venliped.anyo    = :li_anyo
			and    venliped.pedido  = :ll_pedido
			and    venliped.linea   = :ll_linea;			
			
			if ll_id_alm_orden_preparacion = 0 and ll_lineas_reservadas = 0 then
				this.setredraw(false)
				ll_donde = dw_pedidos_pendientes.find("empresa = '"+this.object.empresa[row]+"' and anyo = "+string(this.object.anyo[row],"###0")+" and pedido = "+string(this.object.pedido[row],"#######0")+" and linea = "+string(this.object.linea[row],"###0")+" and situacion <> 'P' ",1,il_rows_dw_updatea_venliped)
				if ll_donde > 0 then
					dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = 0
				end if
				
				ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[row]+"' and venliped_anyo = "+string(this.object.anyo[row],"###0")+" and venliped_pedido = "+string(this.object.pedido[row],"#######0")+" and venliped_linea = "+string(this.object.linea[row],"###0"),1,il_rows_dw_updatea_venliped)
				
				if ll_donde > 0 then
					dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde]      = 0
					dw_updatea_venliped.object.venliped_ordenacion_orden_carga[ll_donde]  = 0
					dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = 0
					dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = 0
					
					this.rowsmove(row,row,Primary!,this,1,Delete!)
					this.sort()
					this.groupcalc()				
				end if					
	
				this.setredraw(true)		
			else
				messagebox("No se puede eliminar la linea","Linea con reservas o en orden de preparación.")
			end if
	end choose
end if
end event

event itemchanged;call super::itemchanged;int li_pallets,li_bulto_desde_orden_carga,li_bulto_hasta_orden_carga
long ll_donde

choose case dwo.name
	case "bulto_desde_orden_carga"
		li_pallets                 = this.object.pallets[row]
		if li_pallets = 0 then li_pallets = 1
		li_bulto_desde_orden_carga = integer(data)
		
		if li_bulto_desde_orden_carga > 0 then
			li_bulto_hasta_orden_carga = li_bulto_desde_orden_carga + (li_pallets -1)
		else
			li_bulto_hasta_orden_carga = 0
		end if
		
		this.object.bulto_hasta_orden_carga[row] = li_bulto_hasta_orden_carga
		
		ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[row]+"' and venliped_anyo = "+string(this.object.anyo[row],"###0")+" and venliped_pedido = "+string(this.object.pedido[row],"#######0")+" and venliped_linea = "+string(this.object.linea[row],"###0"),1,il_rows_dw_updatea_venliped)
		
		if ll_donde > 0 then
			dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = li_bulto_desde_orden_carga
			dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = li_bulto_hasta_orden_carga
		end if							
	case "bulto_hasta_orden_carga"
		li_pallets                 = this.object.pallets[row]
		if li_pallets = 0 then li_pallets = 1
		li_bulto_desde_orden_carga = this.object.bulto_desde_orden_carga[row]
		li_bulto_hasta_orden_carga = integer(data)
		
		if (li_bulto_hasta_orden_carga - li_bulto_desde_orden_carga +1) <> li_pallets then
			return 2		
		else
			ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[row]+"' and venliped_anyo = "+string(this.object.anyo[row],"###0")+" and venliped_pedido = "+string(this.object.pedido[row],"#######0")+" and venliped_linea = "+string(this.object.linea[row],"###0"),1,il_rows_dw_updatea_venliped)
			
			if ll_donde > 0 then
				dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = li_bulto_desde_orden_carga
				dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = li_bulto_hasta_orden_carga
			end if										
		end if
		
end choose
end event

event getfocus;call super::getfocus;if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
end event

type dw_pedidos_pendientes from u_datawindow within wi_mant_alm_orden_carga
integer x = 23
integer y = 1076
integer width = 4709
integer height = 2708
integer taborder = 11
string title = "Pedidos Pendientes"
string dataobject = "dw_mant_alm_orden_carga2"
boolean vscrollbar = true
boolean border = false
end type

event clicked;call super::clicked;string ls_objeto_y_row
long   ll_row,ll_total,ll_anyo,ll_pedido,ll_id_alm_orden_carga,ll_donde,ll_row_scroll

if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
else
	this.selectrow(0,false)
	this.setrow(row)
	//this.selectrow(row,true)
	
	this.setredraw(false)
	
	ll_row_scroll = long(this.Object.DataWindow.FirstRowOnPage)
	ll_id_alm_orden_carga = dw_1.object.id[1]
	
	choose case dwo.name
		case "fecha_fin_planificacion_minima_c"
			f_cargar_reparto_fabricaciones(row)
		case "p_todo"
			//Hacer esto sin filtro
//			this.setfilter("id_alm_orden_carga = 0 and situacion <> 'F'")
//			this.filter()
//			
//			ll_total = this.rowcount()
//			
//			if ll_total > 0 then
//				for ll_row = 1 to ll_total					
//					this.object.id_alm_orden_carga[ll_row] = ll_id_alm_orden_carga
//					
//					ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
//					
//					if ll_donde > 0 then
//						dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde] = ll_id_alm_orden_carga
//					end if
//
//				next
//				dw_lineas_orden.setredraw(false)
//				this.rowscopy(1,ll_total,Primary!,dw_lineas_orden,1,Primary!)
//				dw_lineas_orden.sort()
//				dw_lineas_orden.groupcalc()
//				dw_lineas_orden.setredraw(true)
//			end if		
//	
//			this.setfilter("")
//			this.filter()		
						
			//Sin filtro
			dw_lineas_orden.setredraw(false)
			ll_total = this.rowcount()
			ll_row   = 0
			
			do
				ll_row = this.find("id_alm_orden_carga = 0 and situacion <> 'F'",ll_row +1,ll_total)
			
				if ll_row > 0 then
					this.object.id_alm_orden_carga[ll_row] = ll_id_alm_orden_carga
					
					ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
					
					if ll_donde > 0 then
						dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde] = ll_id_alm_orden_carga
					end if				
					
					this.rowscopy(ll_row,ll_row,Primary!,dw_lineas_orden,1,Primary!)
				end if
			loop while ll_row > 0 and ll_row < ll_total 
			dw_lineas_orden.sort()
			dw_lineas_orden.groupcalc()
			dw_lineas_orden.setredraw(true)			
		case "p_pedido"		
			//Hacer esto sin filtro
//			ls_objeto_y_row = getobjectatpointer()
//			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
//			
//			if ll_row > 0 then
//				ll_anyo   = this.object.anyo[ll_row]
//				ll_pedido = this.object.pedido[ll_row]
//				
//				this.setredraw(false)
//				this.setfilter("anyo = "+string(ll_anyo,"#####0")+" and pedido = "+string(ll_pedido,"#####0")+" and id_alm_orden_carga = 0 and situacion <> 'F'")
//				this.filter()
//				
//				ll_total = this.rowcount()
//				
//				if ll_total > 0 then
//					for ll_row = 1 to ll_total
//						this.object.id_alm_orden_carga[ll_row] = ll_id_alm_orden_carga
//						ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
//						
//						if ll_donde > 0 then
//							dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde] = ll_id_alm_orden_carga
//						end if
//
//					next				
//					dw_lineas_orden.setredraw(false)
//					this.rowscopy(1,ll_total,Primary!,dw_lineas_orden,1,Primary!)
//					dw_lineas_orden.sort()
//					dw_lineas_orden.groupcalc()
//					dw_lineas_orden.setredraw(true)
//				end if					
//				
//				this.setfilter("")
//				this.filter()
//				this.sort()
//				this.groupcalc()
//				this.scrolltorow(ll_row)
//				this.setredraw(true)
//				
//			end if
					
			//Sin filtro
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then
				ll_anyo   = this.object.anyo[ll_row]
				ll_pedido = this.object.pedido[ll_row]
						
				dw_lineas_orden.setredraw(false)
				ll_total = this.rowcount()
				ll_row   = 0
				
				do
					ll_row = this.find("anyo = "+string(ll_anyo,"#####0")+" and pedido = "+string(ll_pedido,"#####0")+" and id_alm_orden_carga = 0 and situacion <> 'F'",ll_row +1,ll_total)
				
					if ll_row > 0 then
						this.object.id_alm_orden_carga[ll_row] = ll_id_alm_orden_carga
						
						ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
						
						if ll_donde > 0 then
							dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde] = ll_id_alm_orden_carga
						end if				
						
						this.rowscopy(ll_row,ll_row,Primary!,dw_lineas_orden,1,Primary!)
					end if
				loop while ll_row > 0 and ll_row < ll_total 
				dw_lineas_orden.sort()
				dw_lineas_orden.groupcalc()
				dw_lineas_orden.setredraw(true)								
			end if					
		case "p_linea"
			dw_lineas_orden.setredraw(false)
			this.object.id_alm_orden_carga[row] = ll_id_alm_orden_carga
			ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[row]+"' and venliped_anyo = "+string(this.object.anyo[row],"###0")+" and venliped_pedido = "+string(this.object.pedido[row],"#######0")+" and venliped_linea = "+string(this.object.linea[row],"###0"),1,il_rows_dw_updatea_venliped)
			
			if ll_donde > 0 then
				dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde] = ll_id_alm_orden_carga
			end if			

			this.rowscopy(row,row,Primary!,dw_lineas_orden,1,Primary!)
			dw_lineas_orden.sort()
			dw_lineas_orden.groupcalc()
			dw_lineas_orden.setredraw(true)		
	end choose
	
	//this.ScrollToRow ( ll_row_scroll )
	this.setrow(row)

	if dw_lineas_orden.rowcount() > 0 then
		dw_1.SetTabOrder("cliente",0)
		dw_1.SetTabOrder("envio",0)			
	end if
	
	this.setredraw(true)
end if
end event

event getfocus;call super::getfocus;if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
end event

event itemchanged;call super::itemchanged;if (isnull(this.object.id_alm_orden_carga[row]) or this.object.id_alm_orden_carga[row] = 0) and this.object.situacion[row] <> 'P' then
	if dec(data) > this.object.cantidad[row] and this.object.situacion[row] <> 'F' then
		messagebox("Atención", "No se puede incrementar una linea reservada") 
		return 2
	else
		if this.object.gestionar_en_piezas[row] = 'S' then
			messagebox("Atención", "No se puede modificar una linea gestionada en piezas") 
			return 2			
		else
			if messagebox("Atención", "Se va a modificar la cantidad del pedido. ¿Desea Continuar?", Exclamation!, YesNo!, 2)  = 1 then
				post f_post_itemchanged( row, dwo, data)
			else
				return 2
			end if
		end if
	end if
else	
	return 2  // Deja el valor original
end if

end event

event rowfocuschanged;//NO EXTENDER PADRE PARA PERMITIR SELECCION MULTIPLE EN EL CLICKED
String var_montaje

IF this.RowCount() > 0 then
	var_montaje = "cantidad.Edit.Format='"+ f_mascara_decimales(this.object.decimales_unidad[currentrow])+"'"	
	this.Modify(var_montaje)
end if
end event

event doubleclicked;call super::doubleclicked;string ls_cliente,ls_envio,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_find,ls_familia_articulo
boolean lb_recalcular_disponibles = false
string ls_articulo,ls_calidad,ls_tonochar,ls_tipo_pallet,ls_caja,ls_situacion,ls_banda_seleccionada,ls_gestionar_en_piezas,ls_pallets[]
int    li_anyo,li_linea,li_calibre,li_total_pallets
long   ll_pedido,ll_row,ll_lotes_asignables
dec    ld_disponible,ld_cantidad,ld_cantidad_pzs,ld_disponible_pzs

long   ll_pallets,ll_cajas
int    posi_aux,posi
string cadena		

string    ls_sel,ls_tono_imprimir,ls_calibre_imprimir,ls_referencia,ls_montajeartcal
int       li_lotes,ll_indice,ll_donde
boolean   lb_mostrar_stock

str_parametros  lstr_param

datastore ds_lotes,lds_pallets

if row > 0 then		
	//and this.object.situacion[row] = 'F' 
	if dwo.name = 'situacion' and this.object.id_alm_orden_carga[row] = 0 then
		
		ls_cliente            = dw_1.object.cliente[1]
		ls_envio              = dw_1.object.envio[1]
		
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
				
				f_calculo_disponibilidad_dw(dw_pedidos_pendientes,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_articulo,ls_calidad)
			end if				

		else
			//Para la familia marcas (2) solo pueden asignar y desasignar los usuarios del grupo exportacion (20)
	
			//if ( ls_familia_articulo = "2" and ( gs_usuarios_v_grupo = "20" or gs_usuarios_v_grupo = "12" ) ) or ls_familia_articulo <> "2" then		
			if ( ls_familia_articulo = "2" and gs_usuarios_v_grupo = "20" ) or ls_familia_articulo <> "2" &
					or nombre_usuario = "PCOPIA" or nombre_usuario = "DMUNYOZ" &
					or nombre_usuario = "TENCER" or nombre_usuario = "AMALLEN" or nombre_usuario = "PROMOCION" then			
					
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
						dw_1.enabled            = false
						dw_lineas_orden.enabled = false
						dw_stock.y = this.y + (ypos * 4) - dw_stock.height + 128
						
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
					f_calculo_disponibilidad_dw(dw_pedidos_pendientes,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_articulo,ls_calidad)				
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
			window lw_ventana 

			OpenWithParm(lw_ventana, lstr_param , "w_int_venped")
		end if
	end if	
end if

end event

type p_1 from picture within wi_mant_alm_orden_carga
integer x = 8457
integer y = 124
integer width = 101
integer height = 88
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\Print_24x24.png"
boolean border = true
boolean focusrectangle = false
end type

event clicked;//u_imprimir u_imp
long   ll_indice,ll_total
string ls_observaciones,ls_observaciones_tratadas,ls_caracter,ls_caracter_ant

dw_imprimir.reset()
dw_lineas_orden.RowsCopy(1,dw_lineas_orden.RowCount(),Primary!,dw_imprimir,1,Primary!)
if dw_1.rowcount() > 0 then
	dw_imprimir.modify("t_fecha.text='"+string(dw_1.object.fecha[1],"dd-mm-yyyy")+"'")
	
	ls_observaciones = dw_1.object.observaciones[1]
	ls_observaciones_tratadas = ""
	
	ll_total = len(ls_observaciones)
	
	for ll_indice = 1 to ll_total
		ls_caracter = mid(ls_observaciones,ll_indice,1)
		
		if ls_caracter = char(13) or ls_caracter = char(10) then
			if ls_caracter_ant <> "~n" then
				ls_caracter = "~n"
			else
				ls_caracter = ""
			end if
		end if
		ls_observaciones_tratadas += ls_caracter
		
		ls_caracter_ant = ls_caracter
	next
	
	dw_imprimir.modify("t_observaciones.text='"+ls_observaciones_tratadas+"'")
end if

dw_imprimir.sort()
dw_imprimir.groupcalc()

f_imprimir_datawindow(dw_imprimir)

//u_imp = create u_imprimir
//u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
//u_imp.isTitulo    = parent.title
//u_imp.isSubTitulo = dw_lineas_orden.title
//u_imp.ibLandscape = false
//parent.OpenUserObject(u_imp.report)
//
//u_imp.event ue_imprimir(dw_imprimir)
//
//destroy u_imp
//
end event

type dw_updatea_venliped from datawindow within wi_mant_alm_orden_carga
boolean visible = false
integer x = 3493
integer width = 3474
integer height = 1316
integer taborder = 20
boolean titlebar = true
string title = "Updatea Venliped"
string dataobject = "dw_mant_alm_orden_carga4"
boolean livescroll = true
end type

type dw_stock from u_datawindow within wi_mant_alm_orden_carga
boolean visible = false
integer x = 3877
integer y = 1044
integer width = 3849
integer height = 668
integer taborder = 11
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
		
		ll_row_pedido = dw_pedidos_pendientes.getrow()
	
		if ll_row_pedido > 0 then		
			if dw_pedidos_pendientes.object.situacion[ll_row_pedido] = 'F' then
							
				ls_cliente            = dw_1.object.cliente[1]
				ls_envio              = dw_1.object.envio[1]
				
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
							
				li_anyo        = dw_pedidos_pendientes.object.anyo[ll_row_pedido]
				ll_pedido      = dw_pedidos_pendientes.object.pedido[ll_row_pedido]
				li_linea       = dw_pedidos_pendientes.object.linea[ll_row_pedido]
				
				ls_articulo    = dw_pedidos_pendientes.object.articulo[ll_row_pedido]
				ls_calidad     = dw_pedidos_pendientes.object.calidad[ll_row_pedido]
				ls_tonochar    = dw_pedidos_pendientes.object.tono[ll_row_pedido]
				li_calibre     = dw_pedidos_pendientes.object.calibre[ll_row_pedido]
				ls_tipo_pallet = dw_pedidos_pendientes.object.tipo_pallet[ll_row_pedido]
				ls_caja        = dw_pedidos_pendientes.object.caja[ll_row_pedido]
				ld_cantidad    = dw_pedidos_pendientes.object.cantidad[ll_row_pedido]
				ls_situacion   = dw_pedidos_pendientes.object.situacion[ll_row_pedido]
				
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
						dw_pedidos_pendientes.object.situacion[ll_row_pedido]    = 'C'
						dw_pedidos_pendientes.object.tono[ll_row_pedido]         = ls_tonochar
						dw_pedidos_pendientes.object.calibre[ll_row_pedido]      = li_calibre
						dw_pedidos_pendientes.object.estado_linea[ll_row_pedido] = 40 //Reservado
						
						f_calculo_disponibilidad_dw(dw_pedidos_pendientes,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad,ls_articulo,ls_calidad)	
					end if
					
					dw_1.enabled                  = true
					dw_pedidos_pendientes.enabled = true
					dw_lineas_orden.enabled       = true
					this.visible = false
	
				end if
			end if
		end if
		
	case 'p_salir'
		dw_1.enabled                  = true
		dw_pedidos_pendientes.enabled = true
		dw_lineas_orden.enabled       = true
		this.visible = false		
end choose
end event

event doubleclicked;call super::doubleclicked;if row > 0 then
	this.event clicked(xpos,ypos,row,this.object.p_linea)
end if
end event

type st_cabecera_orden from statictext within wi_mant_alm_orden_carga
integer x = 27
integer y = 128
integer width = 4704
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Cabecera Orden"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_lineas_orden from statictext within wi_mant_alm_orden_carga
integer x = 4745
integer y = 128
integer width = 3698
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Líneas Orden"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dwtc_reparto_fabricaciones from datawindow within wi_mant_alm_orden_carga
boolean visible = false
integer x = 4151
integer y = 764
integer width = 3301
integer height = 2484
integer taborder = 80
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

type cbx_ocultar_pedidos_en_orden_de_carga from checkbox within wi_mant_alm_orden_carga
integer x = 3387
integer y = 992
integer width = 1097
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Ocultar pedidos en orden de carga"
boolean checked = true
end type

event clicked;long ll_id_alm_orden_carga

ll_id_alm_orden_carga = long(sle_valor.text)

if this.checked then
	if cbx_filtrar_articulo.checked and uo_articulo.em_codigo.text <> "" then
		if cbx_promocion.checked then
			dw_pedidos_pendientes.setfilter("(id_alm_orden_carga = 0 or id_alm_orden_carga = "+string(ll_id_alm_orden_carga)+") and articulo = '"+uo_articulo.em_codigo.text+"' and tipolinea = '4'")				
		else
			dw_pedidos_pendientes.setfilter("(id_alm_orden_carga = 0 or id_alm_orden_carga = "+string(ll_id_alm_orden_carga)+") and articulo = '"+uo_articulo.em_codigo.text+"'")	
		end if
	else
		if cbx_promocion.checked then
			dw_pedidos_pendientes.setfilter("(id_alm_orden_carga = 0 or id_alm_orden_carga = "+string(ll_id_alm_orden_carga)+" ) and tipolinea = '4'")	
		else
			dw_pedidos_pendientes.setfilter("id_alm_orden_carga = 0 or id_alm_orden_carga = "+string(ll_id_alm_orden_carga))
		end if
	end if
else
	if cbx_filtrar_articulo.checked and uo_articulo.em_codigo.text <> "" then
		if cbx_promocion.checked then
			dw_pedidos_pendientes.setfilter("articulo = '"+uo_articulo.em_codigo.text+"' and tipolinea = '4'")
		else		
			dw_pedidos_pendientes.setfilter("articulo = '"+uo_articulo.em_codigo.text+"'")	
		end if
	else
		if cbx_promocion.checked then
			dw_pedidos_pendientes.setfilter("tipolinea = '4'")	
		else		
			dw_pedidos_pendientes.setfilter("")	
		end if
	end if		
end if	

dw_pedidos_pendientes.filter()	
dw_pedidos_pendientes.sort()	
dw_pedidos_pendientes.groupcalc()	

end event

type uo_articulo from u_em_campo_2 within wi_mant_alm_orden_carga
integer x = 608
integer y = 988
integer width = 1157
integer height = 76
integer taborder = 40
boolean bringtotop = true
end type

event modificado;call super::modificado;uo_articulo.em_campo.text = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)

IF Trim(uo_articulo.em_campo.text)="" THEN 
	IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
END IF

if cbx_filtrar_articulo.checked then
	cbx_filtrar_articulo.event clicked()
end if


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type cbx_filtrar_articulo from checkbox within wi_mant_alm_orden_carga
integer x = 46
integer y = 992
integer width = 544
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Filtrar articulo:"
boolean checked = true
end type

event clicked;cbx_ocultar_pedidos_en_orden_de_carga.event clicked()
end event

type p_refrescar_pedidos from picture within wi_mant_alm_orden_carga
integer x = 4507
integer y = 984
integer width = 101
integer height = 88
string picturename = "C:\bmp\db-Refresh.jpg"
boolean border = true
end type

event clicked;f_cargar_pedidos(true)
end event

type st_pedidos_pendientes from statictext within wi_mant_alm_orden_carga
integer x = 32
integer y = 984
integer width = 4457
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Pedidos Pendientes"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_imprimir from u_datawindow within wi_mant_alm_orden_carga
boolean visible = false
integer x = 1088
integer width = 2007
integer height = 200
integer taborder = 31
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión Orden"
string dataobject = "dw_mant_alm_orden_carga_impresion"
boolean vscrollbar = true
boolean border = false
end type

type cbx_promocion from checkbox within wi_mant_alm_orden_carga
integer x = 2939
integer y = 992
integer width = 402
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Promoción"
end type

event clicked;cbx_filtrar_articulo.event clicked()
end event

type cb_2 from commandbutton within wi_mant_alm_orden_carga
boolean visible = false
integer x = 1458
integer y = 20
integer width = 805
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambio Almacenmovimientos"
end type

event clicked;string  ls_sel
boolean lb_correcto = true
long    ll_indice,ll_total,ll_contador

str_almacenmovimientos lstr_almacenmovimientos

datastore ds_datos

delete almacenmovimientos_2;
commit;

ls_sel = "select * from almacenmovimientos"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	ll_contador ++
	f_mensaje_proceso(string(ll_indice)+"/"+string(ll_total),ll_indice,ll_total)

	lstr_almacenmovimientos.empresa = ds_datos.object.empresa[ll_indice] 
	lstr_almacenmovimientos.fecha_mov = ds_datos.object.fecha_mov[ll_indice]
	lstr_almacenmovimientos.orden = ds_datos.object.orden[ll_indice] 
	lstr_almacenmovimientos.fecha_intr = ds_datos.object.fecha_intr[ll_indice] 
	lstr_almacenmovimientos.origen = ds_datos.object.origen[ll_indice] 
	lstr_almacenmovimientos.almacen = ds_datos.object.almacen[ll_indice] 
	lstr_almacenmovimientos.zona = ds_datos.object.zona[ll_indice] 
	lstr_almacenmovimientos.fila = ds_datos.object.fila[ll_indice] 
	lstr_almacenmovimientos.altura = ds_datos.object.altura[ll_indice] 
	lstr_almacenmovimientos.articulo = ds_datos.object.articulo[ll_indice] 
	lstr_almacenmovimientos.familia = ds_datos.object.familia[ll_indice] 
	lstr_almacenmovimientos.formato = ds_datos.object.formato[ll_indice] 
	lstr_almacenmovimientos.calidad = ds_datos.object.calidad[ll_indice] 
	lstr_almacenmovimientos.tono = ds_datos.object.tono[ll_indice] 
	lstr_almacenmovimientos.calibre = ds_datos.object.calibre[ll_indice] 
	lstr_almacenmovimientos.tipo_pallet = ds_datos.object.tipo_pallet[ll_indice] 
	lstr_almacenmovimientos.caja = ds_datos.object.caja[ll_indice] 
	lstr_almacenmovimientos.cantidade = ds_datos.object.cantidade[ll_indice] 
	lstr_almacenmovimientos.cantidads = ds_datos.object.cantidads[ll_indice] 
	lstr_almacenmovimientos.tipomov = ds_datos.object.tipomov[ll_indice] 
	lstr_almacenmovimientos.tipo_unidad = ds_datos.object.tipo_unidad[ll_indice] 
	lstr_almacenmovimientos.usuario = ds_datos.object.usuario[ll_indice] 
	lstr_almacenmovimientos.observaciones = ds_datos.object.observaciones[ll_indice] 
	lstr_almacenmovimientos.trazabilidad = ds_datos.object.trazabilidad[ll_indice] 
	lstr_almacenmovimientos.id_ubicacion = ds_datos.object.id_ubicacion[ll_indice] 
	lstr_almacenmovimientos.id_alm_bultos = ds_datos.object.id_alm_bultos[ll_indice]
	
//	if lstr_almacenmovimientos.fecha_mov < datetime(date("01-01-2001")) then
//		lstr_almacenmovimientos.fecha_mov = datetime(date(lstr_almacenmovimientos.fecha_intr))
//		lstr_almacenmovimientos.observaciones = ""
//	end if
	
	insert into almacenmovimientos_2
		(  almacenmovimientos_2.empresa, 
			almacenmovimientos_2.fecha_mov, 
			almacenmovimientos_2.fecha_intr, 
			almacenmovimientos_2.origen, 
			almacenmovimientos_2.almacen, 
			almacenmovimientos_2.zona, 
			almacenmovimientos_2.fila, 
			almacenmovimientos_2.altura, 
			almacenmovimientos_2.articulo, 
			almacenmovimientos_2.familia, 
			almacenmovimientos_2.formato, 
			almacenmovimientos_2.calidad, 
			almacenmovimientos_2.tono, 
			almacenmovimientos_2.calibre, 
			almacenmovimientos_2.tipo_pallet, 
			almacenmovimientos_2.caja, 
			almacenmovimientos_2.cantidade, 
			almacenmovimientos_2.cantidads, 
			almacenmovimientos_2.tipomov, 
			almacenmovimientos_2.tipo_unidad, 
			almacenmovimientos_2.usuario, 
			almacenmovimientos_2.observaciones, 
			almacenmovimientos_2.trazabilidad, 
			almacenmovimientos_2.id_ubicacion, 
			almacenmovimientos_2.id_alm_bultos	)
	values
		(  :lstr_almacenmovimientos.empresa, 
			:lstr_almacenmovimientos.fecha_mov, 
			:lstr_almacenmovimientos.fecha_intr, 
			:lstr_almacenmovimientos.origen, 
			:lstr_almacenmovimientos.almacen, 
			:lstr_almacenmovimientos.zona, 
			:lstr_almacenmovimientos.fila, 
			:lstr_almacenmovimientos.altura, 
			:lstr_almacenmovimientos.articulo, 
			:lstr_almacenmovimientos.familia, 
			:lstr_almacenmovimientos.formato, 
			:lstr_almacenmovimientos.calidad, 
			:lstr_almacenmovimientos.tono, 
			:lstr_almacenmovimientos.calibre, 
			:lstr_almacenmovimientos.tipo_pallet, 
			:lstr_almacenmovimientos.caja, 
			:lstr_almacenmovimientos.cantidade, 
			:lstr_almacenmovimientos.cantidads, 
			:lstr_almacenmovimientos.tipomov, 
			:lstr_almacenmovimientos.tipo_unidad, 
			:lstr_almacenmovimientos.usuario, 
			:lstr_almacenmovimientos.observaciones, 
			:lstr_almacenmovimientos.trazabilidad, 
			:lstr_almacenmovimientos.id_ubicacion, 
			:lstr_almacenmovimientos.id_alm_bultos	);	
			
	if sqlca.sqlcode <> 0 then lb_correcto = false
	
	if not(lb_correcto) then
		messagebox("Error",sqlca.sqlerrtext+"~n"+lstr_almacenmovimientos.empresa+"~n"+string(lstr_almacenmovimientos.fecha_mov))
		rollback;
		exit
	end if
	
	if ll_contador = 500 then
		ll_contador = 0
		
		commit;
	end if
next

commit;

destroy ds_datos
end event

type cb_3 from commandbutton within wi_mant_alm_orden_carga
boolean visible = false
integer x = 2295
integer y = 20
integer width = 805
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambio Gestión O.C."
end type

event clicked;//Proceso de cambio de la gestión de Ordenes de Carga y Reservas
string ls_sel
long   ll_indice_ordenes,ll_total_ordenes
string ls_orden_carga_almacen_destino,ls_orden_carga_zona_destino,ls_orden_carga_cliente
int    li_orden_carga_expedicion_anyo,li_orden_carga_fila_destino,li_orden_carga_altura_destino
string   ls_orden_carga_expedicion_codigo
datetime ldt_orden_carga_fecha

long ll_indice_ordenes_preparacion,ll_total_ordenes_preparacion
int  li_orden_carga_anyo
string ls_orden_carga_codigo

long ll_indice_lineas_ordenes_preparacion,ll_total_lineas_ordenes_preparacion

long ll_venliped_pedido
int  li_venliped_anyo,li_venliped_linea,li_venliped_ordenacion_orden_carga,li_venliped_numpalet,li_venliped_pallets
int  li_venliped_bulto_desde_orden_carga,li_venliped_bulto_hasta_orden_carga,li_orden_carga_linea_pallets_extra,li_venliped_pallets_updateo
long ll_venliped_id_alm_orden_carga,ll_venliped_id_alm_orden_preparacion,ll_almubimapa_codbar_id_destino
int  li_orden_carga_linea_linea
long ll_indice_lineas_ordenes_preparacion_reservas,ll_total_lineas_ordene_preparacion_reservas,ll_orden_carga_linea_reservas_id_alm_bultos
long ll_orden_carga_linea_reservas_cantidad,ll_alm_bultos_id_ubicacion,ll_alm_bultos_lineas_id 
string ls_venliped_articulo,ls_venliped_calidad,ls_venliped_tonochar,ls_venliped_caja 
int    li_venliped_calibre
string ls_venped_envio

str_alm_orden_carga lstr_alm_orden_carga

datastore ds_datos_ordenes
datastore ds_datos_ordenes_preparacion
datastore ds_datos_ordenes_carga_lineas
datastore ds_datos_ordenes_carga_linea_reservas

ds_alm_orden_carga.settransobject(sqlca)
ds_alm_orden_preparacion.settransobject(sqlca)

delete alm_orden_carga;
commit;

delete alm_orden_preparacion;
commit;

delete venliped_reservas;
commit;

delete venliped_reservas_ubi_orig;
commit;

ls_sel = "SELECT orden_carga.expedicion_anyo, "+&
			"		  orden_carga.expedicion_codigo, "+&
			"		  min(orden_carga.fecha) as fecha, "+&
			"		  orden_carga.cliente "+&
			"FROM   orden_carga "+&
			"WHERE  orden_carga.empresa = '"+codigo_empresa+"' "+&
			"AND    isnull(orden_carga.cliente,'') <> '' "+&
			"GROUP BY orden_carga.expedicion_anyo, "+&
			"		    orden_carga.expedicion_codigo, "+&
			"		    orden_carga.cliente "+&
			"ORDER BY orden_carga.expedicion_anyo, "+&
			"		    convert(decimal(16,0),orden_carga.expedicion_codigo)"

ll_total_ordenes = f_cargar_cursor_transaccion(sqlca,ds_datos_ordenes,ls_sel)

for ll_indice_ordenes = 1 to ll_total_ordenes
	f_mensaje_proceso("",ll_indice_ordenes,ll_total_ordenes)
	
	li_venliped_ordenacion_orden_carga = 0
	
	li_orden_carga_expedicion_anyo   = ds_datos_ordenes.object.expedicion_anyo[ll_indice_ordenes]
	ls_orden_carga_expedicion_codigo = ds_datos_ordenes.object.expedicion_codigo[ll_indice_ordenes]
	ldt_orden_carga_fecha            = datetime(date(ds_datos_ordenes.object.fecha[ll_indice_ordenes]))
	ls_orden_carga_cliente           = ds_datos_ordenes.object.cliente[ll_indice_ordenes]

	//Vamos a crear la orden de carga nueva
	/*
	ls_sel = "select alm_orden_carga.id, "+&
				"       alm_orden_carga.empresa, "+&
				"       alm_orden_carga.fecha, "+&
				"       alm_orden_carga.usuario, "+&
				"       alm_orden_carga.cliente, "+&
				"       alm_orden_carga.envio, "+&
				"       alm_orden_carga.observaciones, "+&
				"       alm_orden_carga.almtipotransportes_codigo, "+&
				"       alm_orden_carga.peso_maximo, "+&
				"       alm_orden_carga.fecha_alta, "+&
				"       alm_orden_carga.confirmada "+&
				"from   alm_orden_carga "+&
				"where  0 = 1"
				
	f_cargar_cursor_transaccion(sqlca,ds_alm_orden_carga,ls_sel)			
	*/
	ds_alm_orden_carga.reset()
	ds_alm_orden_carga.insertrow(1)
	
	ds_alm_orden_carga.object.id[1]                        = f_contador_ordenes_carga("contador_ordenes_carga",1)
	ds_alm_orden_carga.object.empresa[1]                   = codigo_empresa
	ds_alm_orden_carga.object.fecha[1]                     = ldt_orden_carga_fecha
	ds_alm_orden_carga.object.usuario[1]                   = "PORTING"
	ds_alm_orden_carga.object.cliente[1]                   = ls_orden_carga_cliente
	ds_alm_orden_carga.object.envio[1]                     = ""
	ds_alm_orden_carga.object.observaciones[1]             = "CARGA ORIGEN : "+ls_orden_carga_expedicion_codigo+"/"+string(li_orden_carga_expedicion_anyo,"###0")
	ds_alm_orden_carga.object.almtipotransportes_codigo[1] = ""
	ds_alm_orden_carga.object.peso_maximo[1]               = 0
	ds_alm_orden_carga.object.fecha_alta[1]                = ldt_orden_carga_fecha
	ds_alm_orden_carga.object.confirmada[1]                = "S"

	if ds_alm_orden_carga.update(true) = 1 then
		commit;
		
		ll_venliped_id_alm_orden_carga = ds_alm_orden_carga.object.id[1]
		
		ls_sel = "SELECT orden_carga.anyo, "+&
					"		  orden_carga.codigo, "+&
					"		  orden_carga.almacen_destino, "+&
					"		  orden_carga.zona_destino, "+&
					"		  orden_carga.fila_destino, "+&
					"		  orden_carga.altura_destino "+&					
					"FROM   orden_carga "+&
					"WHERE  orden_carga.empresa = '"+codigo_empresa+"' "+&
					"AND    orden_carga.expedicion_anyo   = "+string(li_orden_carga_expedicion_anyo,"###0")+" "+&
					"AND    orden_carga.expedicion_codigo = '"+ls_orden_carga_expedicion_codigo+"' "+&
					"ORDER BY orden_carga.anyo, "+&
					"		    convert(decimal(16,0),orden_carga.codigo)"
	
		ll_total_ordenes_preparacion = f_cargar_cursor_transaccion(sqlca,ds_datos_ordenes_preparacion,ls_sel)
		
		for ll_indice_ordenes_preparacion = 1 to ll_total_ordenes_preparacion
			li_orden_carga_anyo            = ds_datos_ordenes_preparacion.object.anyo[ll_indice_ordenes_preparacion]
			ls_orden_carga_codigo          = ds_datos_ordenes_preparacion.object.codigo[ll_indice_ordenes_preparacion]		
			ls_orden_carga_almacen_destino = ds_datos_ordenes_preparacion.object.almacen_destino[ll_indice_ordenes_preparacion]
			ls_orden_carga_zona_destino    = ds_datos_ordenes_preparacion.object.zona_destino[ll_indice_ordenes_preparacion]
			li_orden_carga_fila_destino    = ds_datos_ordenes_preparacion.object.fila_destino[ll_indice_ordenes_preparacion]
			li_orden_carga_altura_destino  = ds_datos_ordenes_preparacion.object.altura_destino[ll_indice_ordenes_preparacion]
			
			SELECT almubimapa_codbar.id
			INTO   :ll_almubimapa_codbar_id_destino
			FROM   almubimapa_codbar
			WHERE  almubimapa_codbar.empresa = :codigo_empresa
			AND    almubimapa_codbar.almacen = :ls_orden_carga_almacen_destino
			AND    almubimapa_codbar.zona    = :ls_orden_carga_zona_destino
			AND    almubimapa_codbar.fila    = :li_orden_carga_fila_destino
			AND    almubimapa_codbar.altura  = :li_orden_carga_altura_destino;
			
			/*
			ls_sel = "select alm_orden_preparacion.id, "+&
						"       alm_orden_preparacion.empresa, "+&
						"       alm_orden_preparacion.fecha_alta, "+&
						"       alm_orden_preparacion.usuario, "+&
						"       alm_orden_preparacion.observaciones, "+&
						"       alm_orden_preparacion.id_maquina, "+&
						"       alm_orden_preparacion.id_operario, "+&
						"       alm_orden_preparacion.en_proceso, "+&
						"       alm_orden_preparacion.en_proceso_inicio, "+&
						"       alm_orden_preparacion.en_proceso_fin "+&
						"from   alm_orden_preparacion "+&
						"where  0 = 1"

			f_cargar_cursor_transaccion(sqlca,ds_alm_orden_preparacion,ls_sel)			
			*/
			
			ds_alm_orden_preparacion.reset()
			ds_alm_orden_preparacion.insertrow(1)
									
			//ds_alm_orden_preparacion.object.id[1]                =
			ds_alm_orden_preparacion.object.empresa[1]           = codigo_empresa
			ds_alm_orden_preparacion.object.fecha_alta[1]        = ldt_orden_carga_fecha
			ds_alm_orden_preparacion.object.usuario[1]           = "PORTING"
			ds_alm_orden_preparacion.object.observaciones[1]     = "PREPARACIÓN ORIGEN : "+ls_orden_carga_codigo+"/"+string(li_orden_carga_anyo,"###0")
			ds_alm_orden_preparacion.object.id_maquina[1]        = 0
			ds_alm_orden_preparacion.object.id_operario[1]       = 0
			ds_alm_orden_preparacion.object.en_proceso[1]        = "N"
			ds_alm_orden_preparacion.object.en_proceso_inicio[1] = ldt_orden_carga_fecha
			ds_alm_orden_preparacion.object.en_proceso_fin[1]    = ldt_orden_carga_fecha
			
			if ds_alm_orden_preparacion.update(true) = 1 then
				commit;			
						
				ll_venliped_id_alm_orden_preparacion = ds_alm_orden_preparacion.object.id[1]		
						
				ls_sel = "SELECT orden_carga_linea.linea, "+&
							"       orden_carga_linea.venliped_anyo, "+&
							"		  orden_carga_linea.venliped_pedido, "+&
							"		  orden_carga_linea.venliped_linea, "+&
							"       isnull(orden_carga_linea.pallets_extra,0) as pallets_extra "+&
							"FROM   orden_carga_linea "+&
							"WHERE  orden_carga_linea.empresa = '"+codigo_empresa+"' "+&
							"AND    orden_carga_linea.anyo   = "+string(li_orden_carga_anyo,"###0")+" "+&
							"AND    orden_carga_linea.codigo = '"+ls_orden_carga_codigo+"' "+&
							"ORDER BY orden_carga_linea.linea "
			
				ll_total_lineas_ordenes_preparacion = f_cargar_cursor_transaccion(sqlca,ds_datos_ordenes_carga_lineas,ls_sel)
				
				for ll_indice_lineas_ordenes_preparacion = 1 to ll_total_lineas_ordenes_preparacion				
					li_venliped_anyo   = ds_datos_ordenes_carga_lineas.object.venliped_anyo[ll_indice_lineas_ordenes_preparacion]
					ll_venliped_pedido = ds_datos_ordenes_carga_lineas.object.venliped_pedido[ll_indice_lineas_ordenes_preparacion]
					li_venliped_linea  = ds_datos_ordenes_carga_lineas.object.venliped_linea[ll_indice_lineas_ordenes_preparacion]
					li_orden_carga_linea_pallets_extra = ds_datos_ordenes_carga_lineas.object.pallets_extra[ll_indice_lineas_ordenes_preparacion]										
					li_orden_carga_linea_linea         = ds_datos_ordenes_carga_lineas.object.linea[ll_indice_lineas_ordenes_preparacion]										
					
					li_venliped_ordenacion_orden_carga ++
					
					ls_venped_envio = ''
					
					select isnull(venliped.numpalet,0),
							 isnull(venliped.pallets,0),
							 isnull(venliped.articulo,''),
							 isnull(venliped.calidad,''),
							 isnull(venliped.tonochar,''),
							 isnull(venliped.calibre,0),
							 isnull(venliped.caja,''),
							 isnull(venped.envio,'') 
					into   :li_venliped_numpalet,
							 :li_venliped_pallets,
							 :ls_venliped_articulo,
							 :ls_venliped_calidad,
							 :ls_venliped_tonochar,
							 :li_venliped_calibre,
							 :ls_venliped_caja,
							 :ls_venped_envio 
					from   venliped,venped
					where  venliped.empresa = venped.empresa 
					and    venliped.anyo    = venped.anyo 
					and    venliped.pedido  = venped.pedido 
					and    venliped.empresa = :codigo_empresa
					and    venliped.anyo    = :li_venliped_anyo
					and    venliped.pedido  = :ll_venliped_pedido
					and    venliped.linea   = :li_venliped_linea;
					
					if trim(ls_venped_envio) <> '' and ds_alm_orden_carga.object.envio[1] <> ls_venped_envio then
						ds_alm_orden_carga.object.envio[1] = ls_venped_envio
						if ds_alm_orden_carga.update(true) = 1 then
							commit;
						else
							rollback;
						end if
					end if
					
					li_venliped_pallets_updateo = li_venliped_pallets
					
					if li_orden_carga_linea_pallets_extra > 0 then
						li_venliped_pallets_updateo += li_orden_carga_linea_pallets_extra
					end if
					
					if li_venliped_pallets = 0 then li_venliped_pallets = 1
					
					li_venliped_bulto_desde_orden_carga = li_venliped_numpalet
					li_venliped_bulto_hasta_orden_carga = li_venliped_numpalet + li_venliped_pallets - 1
					
					update venliped
					set    venliped.id_alm_orden_carga       = :ll_venliped_id_alm_orden_carga,
							 venliped.ordenacion_orden_carga   = :li_venliped_ordenacion_orden_carga,
							 venliped.bulto_desde_orden_carga  = :li_venliped_bulto_desde_orden_carga,
							 venliped.bulto_hasta_orden_carga  = :li_venliped_bulto_hasta_orden_carga,
							 venliped.id_alm_orden_preparacion = :ll_venliped_id_alm_orden_preparacion,
							 venliped.pallets                  = :li_venliped_pallets_updateo 
					where  venliped.empresa = :codigo_empresa
					and    venliped.anyo    = :li_venliped_anyo
					and    venliped.pedido  = :ll_venliped_pedido
					and    venliped.linea   = :li_venliped_linea;
					
					if sqlca.sqlcode <> 0 then
						messagebox("Error 3",sqlca.sqlerrtext)
						rollback;
					else
						commit;
						
						ls_sel = "SELECT isnull(orden_carga_linea_reservas.id_alm_bultos,0) as id_alm_bultos, "+&
									"       isnull(orden_carga_linea_reservas.cantidad,0) as cantidad "+&
									"FROM   orden_carga_linea_reservas "+&
									"WHERE  orden_carga_linea_reservas.empresa = '"+codigo_empresa+"' "+&
									"AND    orden_carga_linea_reservas.anyo    = "+string(li_orden_carga_anyo,"###0")+" "+&
									"AND    orden_carga_linea_reservas.codigo  = '"+ls_orden_carga_codigo+"' "+&
									"AND    orden_carga_linea_reservas.linea   = "+string(li_orden_carga_linea_linea,"##0")+" "+&
									"ORDER BY orden_carga_linea_reservas.id_alm_bultos "
					
						ll_total_lineas_ordene_preparacion_reservas = f_cargar_cursor_transaccion(sqlca,ds_datos_ordenes_carga_linea_reservas,ls_sel)
						
						for ll_indice_lineas_ordenes_preparacion_reservas = 1 to ll_total_lineas_ordene_preparacion_reservas
							ll_orden_carga_linea_reservas_id_alm_bultos = ds_datos_ordenes_carga_linea_reservas.object.id_alm_bultos[ll_indice_lineas_ordenes_preparacion_reservas]
							ll_orden_carga_linea_reservas_cantidad      = ds_datos_ordenes_carga_linea_reservas.object.cantidad[ll_indice_lineas_ordenes_preparacion_reservas]
							
							ll_alm_bultos_id_ubicacion= 0
							
							SELECT isnull(alm_bultos.id_ubicacion,0)
							INTO   :ll_alm_bultos_id_ubicacion
							FROM   alm_bultos 
							WHERE  alm_bultos.id = :ll_orden_carga_linea_reservas_id_alm_bultos;
							
							
							SELECT alm_bultos_lineas.id  
							INTO   :ll_alm_bultos_lineas_id  
							FROM   alm_bultos,   
									 alm_bultos_lineas  
							WHERE ( alm_bultos.id             = alm_bultos_lineas.id_alm_bultos ) 
							AND ( ( alm_bultos.id             = :ll_orden_carga_linea_reservas_id_alm_bultos ) 
							AND  ( alm_bultos_lineas.empresa  = :codigo_empresa )
							AND  ( alm_bultos_lineas.articulo = :ls_venliped_articulo ) 
							AND  ( alm_bultos_lineas.calidad  = :ls_venliped_calidad ) 
							AND  ( alm_bultos_lineas.tono     = :ls_venliped_tonochar ) 
							AND  ( alm_bultos_lineas.calibre  = :li_venliped_calibre ) 
							AND  ( alm_bultos_lineas.caja     = :ls_venliped_caja ) )   ;

							
							insert into venliped_reservas
								( venliped_reservas.empresa, 
								  venliped_reservas.anyo, 
								  venliped_reservas.pedido, 
								  venliped_reservas.linea, 
								  venliped_reservas.alm_bultos_lineas_id, 
								  venliped_reservas.cantidad, 
								  venliped_reservas.id_ubicacion_original, 
								  venliped_reservas.id_ubicacion_destino )
							values
								( :codigo_empresa, 
								  :li_venliped_anyo, 
								  :ll_venliped_pedido, 
								  :li_venliped_linea, 
								  :ll_alm_bultos_lineas_id, 
								  :ll_orden_carga_linea_reservas_cantidad, 
								  :ll_alm_bultos_id_ubicacion, 
								  :ll_almubimapa_codbar_id_destino );							
							
							if sqlca.sqlcode <> 0 then
								rollback;
							else
								commit;
								
								insert into venliped_reservas_ubi_orig
									( venliped_reservas_ubi_orig.empresa, 
									  venliped_reservas_ubi_orig.anyo, 
									  venliped_reservas_ubi_orig.pedido, 
									  venliped_reservas_ubi_orig.linea, 
									  venliped_reservas_ubi_orig.alm_bultos_lineas_id, 
									  venliped_reservas_ubi_orig.cantidad, 
									  venliped_reservas_ubi_orig.id_ubicacion_original, 
									  venliped_reservas_ubi_orig.alm_bultos_id, 
									  venliped_reservas_ubi_orig.id_ubicacion_destino )
								values
									( :codigo_empresa, 
									  :li_venliped_anyo, 
									  :ll_venliped_pedido, 
									  :li_venliped_linea, 
									  :ll_alm_bultos_lineas_id, 
									  :ll_orden_carga_linea_reservas_cantidad, 
									  :ll_alm_bultos_id_ubicacion, 
									  :ll_orden_carga_linea_reservas_id_alm_bultos,
									  :ll_almubimapa_codbar_id_destino );							
								
								if sqlca.sqlcode <> 0 then
									rollback;
								else
									commit;
								end if
								
							end if
							
						next
						
						destroy ds_datos_ordenes_carga_linea_reservas
						
					end if
				next
				
				destroy ds_datos_ordenes_carga_lineas
				
			else
				//Error
				messagebox("Error 2",sqlca.sqlerrtext)
				rollback;
			end if
			
			//destroy ds_alm_orden_preparacion
		next
		
		destroy ds_datos_ordenes_preparacion
		
	else
		//Error
		messagebox("Error 1",sqlca.sqlerrtext)
		rollback;
	end if
	
	//destroy ds_alm_orden_carga
next

destroy ds_datos_ordenes
end event

type ds_alm_orden_carga from datawindow within wi_mant_alm_orden_carga
boolean visible = false
integer x = 2930
integer y = 8
integer width = 306
integer height = 100
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Porting 1"
string dataobject = "dw_mant_alm_orden_carga"
boolean border = false
boolean livescroll = true
end type

type ds_alm_orden_preparacion from datawindow within wi_mant_alm_orden_carga
boolean visible = false
integer x = 3241
integer y = 8
integer width = 306
integer height = 100
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Porting 2"
string dataobject = "dw_mant_alm_orden_preparacion"
boolean border = false
boolean livescroll = true
end type

type cb_4 from commandbutton within wi_mant_alm_orden_carga
boolean visible = false
integer x = 521
integer y = 4
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "sqls errores"
end type

event clicked;//select almubimapa_codbar.almacen, 
//       almubimapa_codbar.zona, 
//       almubimapa_codbar.fila, 
//       almubimapa_codbar.altura, 
//       alm_bultos.id, 
//       sum(venliped_reservas.cantidad) as cantidad,
//		 venliped_reservas.linea
//from   venliped_reservas,alm_bultos,alm_bultos_lineas,almubimapa_codbar 
//where  venliped_reservas.empresa              = alm_bultos_lineas.empresa 
//and    venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id 
//and    alm_bultos_lineas.id_alm_bultos        = alm_bultos.id 
//and    alm_bultos.id_ubicacion                = almubimapa_codbar.id 
//and    venliped_reservas.empresa = '1' 
//and    venliped_reservas.anyo    = 2020 
//and    venliped_reservas.pedido  = 5758
//group by almubimapa_codbar.almacen, 
//         almubimapa_codbar.zona, 
//         almubimapa_codbar.fila, 
//         almubimapa_codbar.altura, 
//         alm_bultos.id,
//			 venliped_reservas.linea
//order by almubimapa_codbar.almacen, 
//         almubimapa_codbar.zona, 
//         almubimapa_codbar.fila, 
//         almubimapa_codbar.altura, 
//         alm_bultos.id,
//			venliped_reservas.linea;

//SELECT * FROM ALM_BULTOS_LINEAS WHERE ID_ALM_BULTOS = 281907;

//SELECT * FROM VENLIPED_RESERVAS WHERE venliped_reservas.empresa = '1' 
//and    venliped_reservas.anyo    = 2019 
//and (( venliped_reservas.pedido  = 10368 and venliped_reservas.linea = 52 ) or ( venliped_reservas.pedido  = 12140 and venliped_reservas.linea = 68 ));

//SELECT anyo,pedido,linea,articulo,calidad,tonochar,calibre,tipo_pallet,caja,cantidad_pzs,id_alm_orden_carga FROM venliped WHERE venliped.empresa = '1' 
//and    venliped.anyo    = 2019 
//and (( venliped.pedido  = 10368 and venliped.linea = 52 ) or ( venliped.pedido  = 12140 and venliped.linea = 68 ));


//select * from venliped_reservas where empresa = '1'
//and alm_bultos_lineas_id in(select alm_bultos_lineas_id from venliped_reservas group by alm_bultos_lineas_id having count(*) > 1)
//order by alm_bultos_lineas_id,anyo,pedido,linea;


//select * from alm_bultos_lineas 
//where id_alm_bultos in(select id_alm_bultos from alm_bultos_lineas where id = 356777)
//order by id;

//select * from alm_bultos_lineas 
//where articulo = '119077'
//and   calidad  = '1'
//and   tono     = ''
//and   calibre  = 0
//and   caja     = '1143';

// in(select id_alm_bultos from alm_bultos_lineas where id = 356777)
//order by id;

//and   exists (select * from alm_bultos_lineas as alm_bultos_lineas_aux where alm_bultos_lineas_aux.empresa = alm_bultos_lineas.empresa
//																							  and   alm_bultos_lineas_aux.articulo = alm_bultos_lineas.articulo
//																							  and   alm_bultos_lineas_aux.calidad = alm_bultos_lineas.calidad
//																							  and   alm_bultos_lineas_aux.tono = alm_bultos_lineas.tono
//																							  and   alm_bultos_lineas_aux.calibre = alm_bultos_lineas.calibre
//																							  and   alm_bultos_lineas_aux.caja = alm_bultos_lineas.caja
//																							  and   alm_bultos_lineas_aux.id = 356777)
//order by id;

//select * from alm_bultos_lineas where id = 358056;
end event

type cb_1 from commandbutton within wi_mant_alm_orden_carga
boolean visible = false
integer x = 731
integer y = 20
integer width = 709
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Arreglar Traspasos"
end type

event clicked;string ls_sel,ls_find,ls_describe
long   ll_indice,ll_total,ll_donde,ll_indice_movimientos,ll_total_movimientos,ll_nueva_linea,ll_total_regularizado
int    li_insertados
datetime ldt_fecha_mov,ldt_fecha_null,ldt_alm_bultos_fecha_hora_alta  
datastore ds_datos,ds_movimientos

setnull(ldt_fecha_null)

//select * from almacenmovimientos
//where usuario      = "ERROR SGA";

//delete almacenmovimientos
//where usuario      = "ERROR SGA";

ls_sel = "  select resultado.almacen, ~n"+&
			"			 resultado.zona, ~n"+&
			"			 resultado.fila, ~n"+&
			"			 resultado.altura, ~n"+&
			"			 resultado.articulo, ~n"+&
			"			 resultado.calidad, ~n"+&
			"			 resultado.tono, ~n"+&
			"			 resultado.calibre, ~n"+&
			"			 resultado.caja, ~n"+&
			"			 sum(resultado.cantidad_movimientos) as cantidad_movimientos, ~n"+&
			"			 sum(resultado.cantidad_bultos) as cantidad_bultos, ~n"+&
			"         convert(datetime,null) as fecha_regularizado, ~n"+&
			"         0 as entrada_regularizado, ~n"+&
			"         0 as salida_regularizado, ~n"+&
			"         0 as entrada_regularizado_para_salida, ~n"+&
			"         0 as salida_regularizado_para_entrada ~n"+&
			"	from ~n"+&
			"	(select almacen, ~n"+&
			"			 zona, ~n"+&
			"			 fila, ~n"+&
			"			 altura, ~n"+&
			"			 articulo, ~n"+&
			"			 calidad, ~n"+&
			"			 tono, ~n"+&
			"			 calibre, ~n"+&
			"			 caja, ~n"+&
			"			 sum(cantidade - cantidads) as cantidad_movimientos, ~n"+&
			"			 0 as cantidad_bultos ~n"+&
			"	from almacenmovimientos ~n"+&
			"	where empresa = '"+codigo_empresa+"' ~n"+&
			"	group by almacen, ~n"+&
			"			 zona, ~n"+&
			"			 fila, ~n"+&
			"			 altura, ~n"+&
			"			 articulo, ~n"+&
			"			 calidad, ~n"+&
			"			 tono, ~n"+&
			"			 calibre, ~n"+&
			"			 caja ~n"+&
			"	union all ~n"+&
			"	  SELECT almubimapa_codbar.almacen, ~n"+&
			"				almubimapa_codbar.zona, ~n"+&
			"				almubimapa_codbar.fila, ~n"+&
			"				almubimapa_codbar.altura, ~n"+&
			"				alm_bultos_lineas.articulo, ~n"+&
			"				alm_bultos_lineas.calidad, ~n"+& 
			"				alm_bultos_lineas.tono, ~n"+&
			"				alm_bultos_lineas.calibre, ~n"+&
			"				alm_bultos_lineas.caja, ~n"+&
			"				0 as cantidad_movimientos, ~n"+&
			"				sum(alm_bultos_lineas.cantidad) as cantidad_bultos ~n"+&
			"		 FROM alm_bultos, ~n"+&
			"				alm_bultos_lineas, ~n"+&
			"				almubimapa_codbar ~n"+&
			"		WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) ~n"+&
			"    and 	( alm_bultos.id_ubicacion = almubimapa_codbar.id ) ~n"+&
			"	GROUP BY almubimapa_codbar.almacen, ~n"+&
			"				almubimapa_codbar.zona, ~n"+&
			"				almubimapa_codbar.fila, ~n"+&
			"				almubimapa_codbar.altura, ~n"+&
			"				alm_bultos_lineas.articulo, ~n"+&
			"				alm_bultos_lineas.calidad, ~n"+&
			"				alm_bultos_lineas.tono, ~n"+&
			"				alm_bultos_lineas.calibre, ~n"+&
			"				alm_bultos_lineas.caja ) as resultado ~n"+&
			"	group by resultado.almacen, ~n"+&
			"			 resultado.zona, ~n"+&
			"			 resultado.fila, ~n"+&
			"			 resultado.altura, ~n"+&
			"			 resultado.articulo, ~n"+&
			"			 resultado.calidad, ~n"+&
			"			 resultado.tono, ~n"+&
			"			 resultado.calibre, ~n"+&
			"			 resultado.caja ~n"+&
			"	having sum(resultado.cantidad_movimientos) <> sum(resultado.cantidad_bultos) "+&
			"  order by resultado.articulo, ~n"+&
			"			 resultado.calidad, ~n"+&
			"			 resultado.tono, ~n"+&
			"			 resultado.calibre, ~n"+&
			"			 resultado.caja, ~n"+&
			"         sum(resultado.cantidad_movimientos), ~n"+&
			"         resultado.almacen, ~n"+&
			"			 resultado.zona, ~n"+&
			"			 resultado.fila, ~n"+&
			"			 resultado.altura"
			
ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)			

string ls_almacen,ls_zona,ls_articulo,ls_calidad,ls_tono,ls_caja,ls_pallet
int    li_fila,li_altura,li_calibre
long   ll_cantidad_mov,ll_cantidad_bul

for ll_indice = 1 to ll_total
	f_mensaje_proceso(string(ll_indice)+"/"+string(ll_total),ll_indice,ll_total)
	
	ls_almacen  = ds_datos.object.almacen[ll_indice]
	ls_zona     = ds_datos.object.zona[ll_indice]
	li_fila     = ds_datos.object.fila[ll_indice]
	li_altura   = ds_datos.object.altura[ll_indice]
	ls_articulo = ds_datos.object.articulo[ll_indice]
	ls_calidad  = ds_datos.object.calidad[ll_indice]
	ls_tono     = ds_datos.object.tono[ll_indice]
	li_calibre  = ds_datos.object.calibre[ll_indice]
	ls_caja     = ds_datos.object.caja[ll_indice]
	//ls_pallet   = ftc_pallet_articulo(codigo_empresa,ls_articulo,ls_caja)
	ll_cantidad_mov = ds_datos.object.cantidad_movimientos[ll_indice]
	ll_cantidad_bul = ds_datos.object.cantidad_bultos[ll_indice]
	
	if ll_cantidad_mov < ll_cantidad_bul then
		//Debemos hacer un movimiento de entrada traspaso
		ls_sel = "  select almacenmovimientos.fecha_mov, ~n"+&
					"		  ( select sum(cantidade - cantidads) from almacenmovimientos as mov_acum ~n"+&
					"												 where  mov_acum.empresa    = almacenmovimientos.empresa ~n"+&
					"												 and    mov_acum.fecha_mov <= almacenmovimientos.fecha_mov ~n"+&
					"												 and    mov_acum.almacen    = almacenmovimientos.almacen ~n"+&
					"												 and    mov_acum.zona       = almacenmovimientos.zona ~n"+&
					"												 and    mov_acum.fila       = almacenmovimientos.fila ~n"+&
					"												 and    mov_acum.altura     = almacenmovimientos.altura ~n"+&
					"												 and    mov_acum.articulo   = almacenmovimientos.articulo ~n"+&
					"												 and    mov_acum.calidad    = almacenmovimientos.calidad ~n"+&
					"												 and    mov_acum.tono       = almacenmovimientos.tono ~n"+&
					"												 and    mov_acum.calibre    = almacenmovimientos.calibre ~n"+&
					"												 and    mov_acum.caja       = almacenmovimientos.caja ) as stock_fecha ~n"+&
					"	from   almacenmovimientos ~n"+&
					"	where  almacenmovimientos.empresa  = '"+codigo_empresa+"' ~n"+&
					"	and    almacenmovimientos.articulo = '"+ls_articulo+"' ~n"+&
					"	and    almacenmovimientos.calidad  = '"+ls_calidad+"' ~n"+&
					"	and    almacenmovimientos.tono     = '"+ls_tono+"' ~n"+&
					"	and    almacenmovimientos.calibre  = "+string(li_calibre,"#0")+" ~n"+&
					"	and    almacenmovimientos.caja     = '"+ls_caja+"' ~n"+&
					"	and    almacenmovimientos.almacen  = '"+ls_almacen+"' ~n"+&
					"	and    almacenmovimientos.zona     = '"+ls_zona+"' ~n"+&
					"	and    almacenmovimientos.fila     = "+string(li_fila,"##0")+" ~n"+&
					"	and    almacenmovimientos.altura   = "+string(li_altura,"##0")+" ~n"+&
					"	group by almacenmovimientos.empresa, ~n"+&
					"				almacenmovimientos.fecha_mov, ~n"+&
					"				almacenmovimientos.articulo, ~n"+&
					"				almacenmovimientos.calidad, ~n"+&
					"				almacenmovimientos.tono, ~n"+&
					"				almacenmovimientos.calibre, ~n"+&
					"				almacenmovimientos.caja, ~n"+&
					"				almacenmovimientos.almacen, ~n"+&
					"				almacenmovimientos.zona, ~n"+&
					"				almacenmovimientos.fila, ~n"+&
					"				almacenmovimientos.altura ~n"+&
					"	order by almacenmovimientos.fecha_mov"
					
		ll_total_movimientos = f_cargar_cursor_transaccion(sqlca,ds_movimientos,ls_sel)
		
		if ll_total_movimientos > 0 then
			ll_indice_movimientos = ds_movimientos.find("stock_fecha < 0",1,ll_total_movimientos)
			
			if ll_indice_movimientos > 0 then
				ldt_fecha_mov = datetime(ds_movimientos.object.fecha_mov[ll_indice_movimientos])
				//Marcamos en el ds la fecha de regularizacion 
				ds_datos.object.fecha_regularizado[ll_indice]   = ldt_fecha_mov
				ds_datos.object.entrada_regularizado[ll_indice] = ll_cantidad_bul - ll_cantidad_mov
			else
				//No hay fecha en negativo
			end if
		else
			//No hay movimientos Busco el alta del bulto
		end if
		
		destroy ds_movimientos
	else
		//Debemos hacer un movimiento de salida traspaso
		//Voy a buscar movimiento de entrada regularizado con la misma cantidad
		
		ls_find = "articulo = '"+ls_articulo+"' and calidad = '"+ls_calidad+"' and tono = '"+ls_tono+"' and calibre = "+string(li_calibre,"#0")+" and caja = '"+ls_caja+"' and entrada_regularizado = "+string(ll_cantidad_mov - ll_cantidad_bul,"######0")+" and entrada_regularizado_para_salida = 0"
		
		ll_donde = ds_datos.find(ls_find,1,ll_total)
		
		if ll_donde > 0 then
			ds_datos.object.fecha_regularizado[ll_indice]  = ds_datos.object.fecha_regularizado[ll_donde]
			ds_datos.object.salida_regularizado[ll_indice] = ds_datos.object.entrada_regularizado[ll_donde]
			ds_datos.object.entrada_regularizado_para_salida[ll_donde] = ds_datos.object.salida_regularizado[ll_indice]
		else
			//Busco entradas con diferente cantidad
			ls_find = "articulo = '"+ls_articulo+"' and calidad = '"+ls_calidad+"' and tono = '"+ls_tono+"' and calibre = "+string(li_calibre,"#0")+" and caja = '"+ls_caja+"' and entrada_regularizado > 0 and entrada_regularizado < "+string(ll_cantidad_mov - ll_cantidad_bul,"######0")+" and entrada_regularizado_para_salida = 0"
			
			ll_donde = ds_datos.find(ls_find,1,ll_total)
			
			if ll_donde > 0 then
				ds_datos.object.fecha_regularizado[ll_indice]  = ds_datos.object.fecha_regularizado[ll_donde]
				ds_datos.object.salida_regularizado[ll_indice] = ds_datos.object.entrada_regularizado[ll_donde]
				ds_datos.object.entrada_regularizado_para_salida[ll_donde] = ds_datos.object.salida_regularizado[ll_indice]			
									
//				ll_total_regularizado = long(ds_datos.describe('evaluate("sum(if (almacen = ~''+ls_almacen+'~' and zona = ~''+ls_zona+'~' and fila = '+string(li_fila,"##0")+' and altura = '+string(li_altura,"#0")+' and articulo = ~''+ls_articulo+'~' and calidad = ~''+ls_calidad+'~' and tono = ~''+ls_tono+'~' and calibre = '+string(li_calibre,"#0")+' and caja = ~''+ls_caja+'~',salida_regularizado,0) for all)",1)'))
//				
//				if ll_total_regularizado < (ll_cantidad_mov - ll_cantidad_bul) then
					//Divido la linea
					li_insertados  ++
					
					ll_nueva_linea = ds_datos.insertrow(ll_indice+1)
					ds_datos.object.data[ll_nueva_linea] = ds_datos.object.data[ll_indice]
					
					ds_datos.object.cantidad_movimientos[ll_nueva_linea] = ds_datos.object.cantidad_movimientos[ll_nueva_linea] - ds_datos.object.salida_regularizado[ll_indice]
					
					ds_datos.object.fecha_regularizado[ll_nueva_linea]  = ldt_fecha_null
					ds_datos.object.salida_regularizado[ll_nueva_linea] = 0
					//ds_datos.object.cantidad_movimientos[ll_indice] = ?
					//ds_datos.object.cantidad_bultos[ll_indice]      = ?	
					
					ll_total ++
					//salgo del bucle si inserto en exceso
					if li_insertados = 10000 then
						ll_indice = ll_total
					end if
//				end if
			else
				//Busco entradas con diferente cantidad2
				ls_find = "articulo = '"+ls_articulo+"' and calidad = '"+ls_calidad+"' and tono = '"+ls_tono+"' and calibre = "+string(li_calibre,"#0")+" and caja = '"+ls_caja+"' and entrada_regularizado > 0 and entrada_regularizado > "+string(ll_cantidad_mov - ll_cantidad_bul,"######0")+" and entrada_regularizado_para_salida = 0"
				
				ll_donde = ds_datos.find(ls_find,1,ll_total)
				
				if ll_donde > 0 then
					ds_datos.object.fecha_regularizado[ll_indice]  = ds_datos.object.fecha_regularizado[ll_donde]
					ds_datos.object.salida_regularizado[ll_indice] = ll_cantidad_mov - ll_cantidad_bul
					ds_datos.object.entrada_regularizado_para_salida[ll_donde] = ds_datos.object.salida_regularizado[ll_indice]			
										
	//				ll_total_regularizado = long(ds_datos.describe('evaluate("sum(if (almacen = ~''+ls_almacen+'~' and zona = ~''+ls_zona+'~' and fila = '+string(li_fila,"##0")+' and altura = '+string(li_altura,"#0")+' and articulo = ~''+ls_articulo+'~' and calidad = ~''+ls_calidad+'~' and tono = ~''+ls_tono+'~' and calibre = '+string(li_calibre,"#0")+' and caja = ~''+ls_caja+'~',salida_regularizado,0) for all)",1)'))
	//				
	//				if ll_total_regularizado < (ll_cantidad_mov - ll_cantidad_bul) then
						//Divido la linea
						li_insertados  ++
						
						ll_nueva_linea = ds_datos.insertrow(ll_indice+1)
						ds_datos.object.data[ll_nueva_linea] = ds_datos.object.data[ll_indice]
						
						ds_datos.object.cantidad_movimientos[ll_nueva_linea] = ds_datos.object.cantidad_movimientos[ll_nueva_linea] - ds_datos.object.salida_regularizado[ll_indice]
						
						ds_datos.object.fecha_regularizado[ll_nueva_linea]  = ldt_fecha_null
						ds_datos.object.salida_regularizado[ll_nueva_linea] = 0
						//ds_datos.object.cantidad_movimientos[ll_indice] = ?
						//ds_datos.object.cantidad_bultos[ll_indice]      = ?	
						
						ll_total ++
						//salgo del bucle si inserto en exceso
						if li_insertados = 10000 then
							ll_indice = ll_total
						end if
	//				end if
				else
					//Voy a buscar un dia en el que el stock en esa ubicacion fuese igual al de la diferencia
					ls_sel = "  select almacenmovimientos.fecha_mov, ~n"+&
								"		  ( select sum(cantidade - cantidads) from almacenmovimientos as mov_acum ~n"+&
								"												 where  mov_acum.empresa    = almacenmovimientos.empresa ~n"+&
								"												 and    mov_acum.fecha_mov <= almacenmovimientos.fecha_mov ~n"+&
								"												 and    mov_acum.almacen    = almacenmovimientos.almacen ~n"+&
								"												 and    mov_acum.zona       = almacenmovimientos.zona ~n"+&
								"												 and    mov_acum.fila       = almacenmovimientos.fila ~n"+&
								"												 and    mov_acum.altura     = almacenmovimientos.altura ~n"+&
								"												 and    mov_acum.articulo   = almacenmovimientos.articulo ~n"+&
								"												 and    mov_acum.calidad    = almacenmovimientos.calidad ~n"+&
								"												 and    mov_acum.tono       = almacenmovimientos.tono ~n"+&
								"												 and    mov_acum.calibre    = almacenmovimientos.calibre ~n"+&
								"												 and    mov_acum.caja       = almacenmovimientos.caja ) as stock_fecha ~n"+&
								"	from   almacenmovimientos ~n"+&
								"	where  almacenmovimientos.empresa  = '"+codigo_empresa+"' ~n"+&
								"	and    almacenmovimientos.articulo = '"+ls_articulo+"' ~n"+&
								"	and    almacenmovimientos.calidad  = '"+ls_calidad+"' ~n"+&
								"	and    almacenmovimientos.tono     = '"+ls_tono+"' ~n"+&
								"	and    almacenmovimientos.calibre  = "+string(li_calibre,"#0")+" ~n"+&
								"	and    almacenmovimientos.caja     = '"+ls_caja+"' ~n"+&
								"	and    almacenmovimientos.almacen  = '"+ls_almacen+"' ~n"+&
								"	and    almacenmovimientos.zona     = '"+ls_zona+"' ~n"+&
								"	and    almacenmovimientos.fila     = "+string(li_fila,"##0")+" ~n"+&
								"	and    almacenmovimientos.altura   = "+string(li_altura,"##0")+" ~n"+&
								"	group by almacenmovimientos.empresa, ~n"+&
								"				almacenmovimientos.fecha_mov, ~n"+&
								"				almacenmovimientos.articulo, ~n"+&
								"				almacenmovimientos.calidad, ~n"+&
								"				almacenmovimientos.tono, ~n"+&
								"				almacenmovimientos.calibre, ~n"+&
								"				almacenmovimientos.caja, ~n"+&
								"				almacenmovimientos.almacen, ~n"+&
								"				almacenmovimientos.zona, ~n"+&
								"				almacenmovimientos.fila, ~n"+&
								"				almacenmovimientos.altura ~n"+&
								"	order by almacenmovimientos.fecha_mov"
								
					ll_total_movimientos = f_cargar_cursor_transaccion(sqlca,ds_movimientos,ls_sel)
					
					if ll_total_movimientos > 0 then		
											
						ll_indice_movimientos = ds_movimientos.find("stock_fecha = "+string((ll_cantidad_mov - ll_cantidad_bul),"#####0"),1,ll_total_movimientos)
						
						if ll_indice_movimientos > 0 then
							ldt_fecha_mov = datetime(ds_movimientos.object.fecha_mov[ll_indice_movimientos])
							//Marcamos en el ds la fecha de regularizacion 
							ds_datos.object.fecha_regularizado[ll_indice]  = ldt_fecha_mov
							ds_datos.object.salida_regularizado[ll_indice] = ll_cantidad_mov - ll_cantidad_bul
						else
							//Busco el dia en el que hay el mismo stock que en el total de movimientos
							ll_indice_movimientos = ds_movimientos.find("stock_fecha = "+string((ll_cantidad_mov),"#####0"),1,ll_total_movimientos)
							
							if ll_indice_movimientos > 0 then
								ldt_fecha_mov = datetime(ds_movimientos.object.fecha_mov[ll_indice_movimientos])
								//Marcamos en el ds la fecha de regularizacion 
								ds_datos.object.fecha_regularizado[ll_indice]  = ldt_fecha_mov
								ds_datos.object.salida_regularizado[ll_indice] = ll_cantidad_mov - ll_cantidad_bul							
							end if
						end if
					end if
					//Voy a buscar un dia en el que el stock en esa ubicacion fuese igual al de la diferencia
				end if
				//Busco entradas con diferente cantidad2
			end if
			//Busco entradas con diferente cantidad
		end if
		
	end if
								
next

//Volvemos a recorrer para regularizar las entradas que no hemos regularizado antes
for ll_indice = 1 to ll_total
	f_mensaje_proceso(string(ll_indice)+"/"+string(ll_total),ll_indice,ll_total)
	
	ls_almacen  = ds_datos.object.almacen[ll_indice]
	ls_zona     = ds_datos.object.zona[ll_indice]
	li_fila     = ds_datos.object.fila[ll_indice]
	li_altura   = ds_datos.object.altura[ll_indice]
	ls_articulo = ds_datos.object.articulo[ll_indice]
	ls_calidad  = ds_datos.object.calidad[ll_indice]
	ls_tono     = ds_datos.object.tono[ll_indice]
	li_calibre  = ds_datos.object.calibre[ll_indice]
	ls_caja     = ds_datos.object.caja[ll_indice]
	//ls_pallet   = ftc_pallet_articulo(codigo_empresa,ls_articulo,ls_caja)
	ll_cantidad_mov = ds_datos.object.cantidad_movimientos[ll_indice]
	ll_cantidad_bul = ds_datos.object.cantidad_bultos[ll_indice]
	
	if ll_cantidad_mov < ll_cantidad_bul and ds_datos.object.entrada_regularizado[ll_indice] = 0 then
		ls_find = "articulo = '"+ls_articulo+"' and calidad = '"+ls_calidad+"' and tono = '"+ls_tono+"' and calibre = "+string(li_calibre,"#0")+" and caja = '"+ls_caja+"' and salida_regularizado = "+string(ll_cantidad_bul - ll_cantidad_mov,"######0")+" and salida_regularizado_para_entrada = 0"
		
		ll_donde = ds_datos.find(ls_find,1,ll_total)
		
		if ll_donde > 0 then
			ds_datos.object.fecha_regularizado[ll_indice]  = ds_datos.object.fecha_regularizado[ll_donde]
			ds_datos.object.entrada_regularizado[ll_indice] = ds_datos.object.salida_regularizado[ll_donde]
			ds_datos.object.salida_regularizado_para_entrada[ll_donde] = ds_datos.object.entrada_regularizado[ll_indice]
		else
			//Busco la fecha de alta del bulto en la ubicacion
			setnull(ldt_alm_bultos_fecha_hora_alta)
			
			SELECT alm_bultos.fecha_hora_alta 
			INTO   :ldt_alm_bultos_fecha_hora_alta  
			FROM  alm_bultos, 
					alm_bultos_lineas, 
					almubimapa_codbar 
			WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
			AND 	( alm_bultos.id_ubicacion = almubimapa_codbar.id ) 
			AND     almubimapa_codbar.almacen  = :ls_almacen
			AND     almubimapa_codbar.zona     = :ls_zona
			AND     almubimapa_codbar.fila     = :li_fila
			AND     almubimapa_codbar.altura   = :li_altura 
			AND     alm_bultos_lineas.articulo = :ls_articulo
			AND     alm_bultos_lineas.calidad  = :ls_calidad
			AND     alm_bultos_lineas.tono     = :ls_tono
			AND     alm_bultos_lineas.calibre  = :li_calibre
			AND     alm_bultos_lineas.caja     = :ls_caja
			GROUP BY almubimapa_codbar.almacen, 
					almubimapa_codbar.zona, 
					almubimapa_codbar.fila, 
					almubimapa_codbar.altura, 
					alm_bultos_lineas.articulo, 
					alm_bultos_lineas.calidad, 
					alm_bultos_lineas.tono, 
					alm_bultos_lineas.calibre, 
					alm_bultos_lineas.caja,
					alm_bultos.fecha_hora_alta;	
					
			if not(isnull(ldt_alm_bultos_fecha_hora_alta)) then
				ds_datos.object.fecha_regularizado[ll_indice]   = datetime(date(ldt_alm_bultos_fecha_hora_alta))
				ds_datos.object.entrada_regularizado[ll_indice] = ll_cantidad_bul - ll_cantidad_mov
			end if
		end if		
	end if
next

string ls_nombre_fichero,ls_ruta_fichero

if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
	//dw_detalle.SaveAs(ls_ruta_fichero, Excel!, true)
	uf_save_ds_as_excel(ds_datos,ls_ruta_fichero)
end if

//Vamos a grabar los movimientos
long 	ll_entrada_regularizado,ll_salida_regularizado
string is_tipo_movimiento_salida = '102'
string is_tipo_movimiento_entrada = '103'
str_movimiento_almacen lstr_movimiento_almacen

for ll_indice = 1 to ll_total
	f_mensaje_proceso("Grabando "+string(ll_indice)+"/"+string(ll_total),ll_indice,ll_total)
	
	ls_almacen  = ds_datos.object.almacen[ll_indice]
	ls_zona     = ds_datos.object.zona[ll_indice]
	li_fila     = ds_datos.object.fila[ll_indice]
	li_altura   = ds_datos.object.altura[ll_indice]
	ls_articulo = ds_datos.object.articulo[ll_indice]
	ls_calidad  = ds_datos.object.calidad[ll_indice]
	ls_tono     = ds_datos.object.tono[ll_indice]
	li_calibre  = ds_datos.object.calibre[ll_indice]
	ls_caja     = ds_datos.object.caja[ll_indice]
	ls_pallet   = ftc_pallet_articulo(codigo_empresa,ls_articulo,ls_caja)
	ls_caja     = ds_datos.object.caja[ll_indice]
	ll_entrada_regularizado = ds_datos.object.entrada_regularizado[ll_indice]
	ll_salida_regularizado  = ds_datos.object.salida_regularizado[ll_indice]
	
	if ll_entrada_regularizado > 0 or ll_salida_regularizado > 0 then
		
		if ls_articulo = '122301' and ls_zona = 'AB' and li_fila = 54 then
			lstr_movimiento_almacen.empresa            = codigo_empresa
		end if
		
		lstr_movimiento_almacen.empresa            = codigo_empresa
		lstr_movimiento_almacen.articulo           = ls_articulo
		lstr_movimiento_almacen.calidad            = ls_calidad
		lstr_movimiento_almacen.tono               = ls_tono
		lstr_movimiento_almacen.calibre            = li_calibre
		lstr_movimiento_almacen.tipo_pallet        = ls_pallet
		lstr_movimiento_almacen.caja               = ls_caja
		if ll_salida_regularizado > 0 then
			lstr_movimiento_almacen.cantidad           = -1 * ll_salida_regularizado
			lstr_movimiento_almacen.tipo_movimiento    = is_tipo_movimiento_salida
		else
			lstr_movimiento_almacen.cantidad           = ll_entrada_regularizado
			lstr_movimiento_almacen.tipo_movimiento    = is_tipo_movimiento_entrada			
		end if
		lstr_movimiento_almacen.orden_carga_anyo   = 0
		lstr_movimiento_almacen.orden_carga_codigo = ""
		lstr_movimiento_almacen.orden_carga_linea  = 0		
		lstr_movimiento_almacen.observaciones      = ""
		lstr_movimiento_almacen.almacen            = ls_almacen
		lstr_movimiento_almacen.zona               = ls_zona
		lstr_movimiento_almacen.fila               = li_fila
		lstr_movimiento_almacen.altura             = li_altura
		lstr_movimiento_almacen.tercero            = ""
		lstr_movimiento_almacen.documento          = ""
		lstr_movimiento_almacen.fecha              = ds_datos.object.fecha_regularizado[ll_indice]
		lstr_movimiento_almacen.id_ubicacion       = 0
		lstr_movimiento_almacen.id_alm_bultos		 = 0	
		
		if f_movimiento_almacen_sin_alm_bultos(lstr_movimiento_almacen) then
			commit;
		else
			messagebox("¡Error!",sqlca.sqlerrtext)
			rollback;
		end if
	end if
next
//Vamos a grabar los movimientos

destroy ds_datos
end event

type dw_trans from datawindow within wi_mant_alm_orden_carga
integer x = 3538
integer y = 356
integer width = 1175
integer height = 600
integer taborder = 41
boolean bringtotop = true
string title = "none"
string dataobject = "dw_con_tipo_trans_carga"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;datetime fecha
string codigo_transporte, centro_logistico


if dw_trans.rowcount() > 0 and row > 0 then
	
	fecha = dw_1.object.fecha[1] 
	
	codigo_transporte = dw_trans.object.codigo_transporte[row]
	
	centro_logistico = dw_trans.object.codigo_cl[row]
	
	dw_cargas.retrieve(codigo_empresa,fecha,codigo_transporte,centro_logistico)
	
	dw_cargas.visible = true
			
	
end if
end event

type dw_cargas from datawindow within wi_mant_alm_orden_carga
boolean visible = false
integer x = 1486
integer y = 592
integer width = 3986
integer height = 2072
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Ordenes de carga por transporte y cl"
string dataobject = "dw_cargas_cl_trans"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;decimal oc
str_parametros  lstr_param
window lw_ventana

if dwo.name = 'b_oc' then


	oc = this.object.id[row]

			
	lstr_param.s_argumentos[1] = codigo_empresa
	lstr_param.s_argumentos[2] = String(oc)
	lstr_param.i_nargumentos   = 2
			
	OpenWithParm(lw_ventana, lstr_param , "wi_mant_alm_orden_carga")
	
end if
	
end event

type p_informacion from picture within wi_mant_alm_orden_carga
integer x = 4503
integer y = 364
integer width = 91
integer height = 72
boolean bringtotop = true
string picturename = "C:\Fuentes_tencer_PB12\Information_16x16.png"
boolean focusrectangle = false
string powertiptext = "Doble click encima de una linea para ver detalle"
end type

