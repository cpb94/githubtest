$PBExportHeader$wtc_asigna_bultos_ocs.srw
forward
global type wtc_asigna_bultos_ocs from wt_consultas_padre
end type
type st_reservado from statictext within wtc_asigna_bultos_ocs
end type
type pb_grabar_obs from picturebutton within wtc_asigna_bultos_ocs
end type
type st_1 from statictext within wtc_asigna_bultos_ocs
end type
type dw_etiquetas_bultos_100 from datawindow within wtc_asigna_bultos_ocs
end type
type dw_stock from datawindow within wtc_asigna_bultos_ocs
end type
type cb_1 from commandbutton within wtc_asigna_bultos_ocs
end type
type dw_impresion_contenido_bulto from datawindow within wtc_asigna_bultos_ocs
end type
type cbx_mostrar_ubicaciones_originales from checkbox within wtc_asigna_bultos_ocs
end type
type dw_imprimir from u_datawindow within wtc_asigna_bultos_ocs
end type
type dw_cabecera_orden_preparacion from u_datawindow within wtc_asigna_bultos_ocs
end type
type dw_impresion_contenido_bulto_sin_prep from datawindow within wtc_asigna_bultos_ocs
end type
type cb_2 from commandbutton within wtc_asigna_bultos_ocs
end type
type pb_etiquetas_a_preparar from picturebutton within wtc_asigna_bultos_ocs
end type
type cb_3 from commandbutton within wtc_asigna_bultos_ocs
end type
end forward

global type wtc_asigna_bultos_ocs from wt_consultas_padre
integer width = 6615
integer height = 4012
string title = "ORDENES DE PREPARACION"
event marcar ( )
event desmarcar ( )
event asignar_mismo_bulto_a_resto_de_picos ( )
event asignar ( )
event desasignar ( )
st_reservado st_reservado
pb_grabar_obs pb_grabar_obs
st_1 st_1
dw_etiquetas_bultos_100 dw_etiquetas_bultos_100
dw_stock dw_stock
cb_1 cb_1
dw_impresion_contenido_bulto dw_impresion_contenido_bulto
cbx_mostrar_ubicaciones_originales cbx_mostrar_ubicaciones_originales
dw_imprimir dw_imprimir
dw_cabecera_orden_preparacion dw_cabecera_orden_preparacion
dw_impresion_contenido_bulto_sin_prep dw_impresion_contenido_bulto_sin_prep
cb_2 cb_2
pb_etiquetas_a_preparar pb_etiquetas_a_preparar
cb_3 cb_3
end type
global wtc_asigna_bultos_ocs wtc_asigna_bultos_ocs

type variables
string  sql_inicial, sql_final, orden_seleccionado
boolean ib_ubicaciones_activas,ib_apilado_en_bloque
string  is_campo_a_modificar
long    il_id_orden_carga,il_row_he_pulsado
boolean ib_mostrar_ubicacion_original = false
boolean ib_generando_orden_de_preparacion = false
boolean ib_asignando_en_automatico = false
boolean ib_abriendo_y_eliminando_linea = false
long    il_orden_preparacion_genero
boolean ib_nueva_gestion_preparacion = false
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_consulta ()
public function string f_construir_group_by ()
public subroutine f_cargar_datawindow (string new_sql)
public subroutine f_calculo_disponibilidad (datastore ds_datos)
public subroutine f_mostrar_bultos_linea (datawindow arg_datawindow, long arg_row)
public subroutine f_mostrar_bultos_asignados (datastore ds_datos)
public function boolean f_cerrar_orden (long arg_row)
public function boolean f_abrir_orden (long arg_row)
public function boolean f_abrir_linea (long arg_row)
public function boolean f_imprimir_bandas_orden (long arg_row)
public function boolean f_imprimir_bandas_linea (long arg_row)
public subroutine f_cargar_lineas_orden_carga_imprimir ()
public subroutine f_mostrar_bultos_linea_impresion (datawindow arg_datawindow, long arg_row)
public function boolean f_imprimir_bandas_orden_preparacion (long arg_orden_preparacion)
public function boolean f_imprimir_bandas_orden_2 (long arg_row)
public function boolean f_imprimir_bandas_linea_2 (long arg_row)
public function boolean f_abrir_y_eliminar_linea (long arg_row)
public function boolean f_cerrar_orden_sin_movimientos (long arg_row)
public function boolean f_imprimir_bandas_linea_2_old (long arg_row)
end prototypes

event marcar();//Marcar campo seleccionado
long ll_id_alm_orden_carga,ll_rowcount,ll_donde

if il_row_he_pulsado > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[il_row_he_pulsado]

	ll_rowcount = dw_datos.rowcount()
	
	ll_donde = 0
	
	do
		ll_donde = dw_datos.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and almacen_destino = '' and zona_destino = '' and fila_destino = 0 and altura_destino = 0 ",ll_donde+1,ll_rowcount)
		
		if ll_donde > 0 then
			//Asi se hacia antes
			//if dw_datos.object.ubicar_desde_cabecera[ll_donde] = 'N' then
			if dw_datos.object.situacion[ll_donde] <> 'P' then
				if dw_datos.event itemchanged(ll_donde,dw_datos.object.ubicar_desde_cabecera,'S') = 0 then
					dw_datos.object.ubicar_desde_cabecera[ll_donde] = 'S'
				end if
			end if
		end if
		
	loop while ll_donde > 0 and ll_donde < ll_rowcount	
	
end if
end event

event desmarcar();//Desmarcar campo seleccionado
long ll_id_alm_orden_carga,ll_rowcount,ll_donde

if il_row_he_pulsado > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[il_row_he_pulsado]

	ll_rowcount = dw_datos.rowcount()
	
	ll_donde = 0
	
	do
		ll_donde = dw_datos.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and almacen_destino = '' and zona_destino = '' and fila_destino = 0 and altura_destino = 0 ",ll_donde+1,ll_rowcount)
		
		if ll_donde > 0 then
			if dw_datos.object.ubicar_desde_cabecera[ll_donde] = 'S' then
				if dw_datos.event itemchanged(ll_donde,dw_datos.object.ubicar_desde_cabecera,'N') = 0 then
					dw_datos.object.ubicar_desde_cabecera[ll_donde] = 'N'
				end if
			end if
		end if
		
	loop while ll_donde > 0 and ll_donde < ll_rowcount	
	
end if
end event

event asignar_mismo_bulto_a_resto_de_picos();//Asigna mismo bulto a resto de picos
long ll_bulto_desde_orden_carga,ll_bulto_hasta_orden_carga
long ll_id_alm_orden_carga,ll_rowcount,ll_donde

if il_row_he_pulsado > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[il_row_he_pulsado]

	ll_bulto_desde_orden_carga = dw_datos.object.bulto_desde_orden_carga[il_row_he_pulsado]
	ll_bulto_hasta_orden_carga = dw_datos.object.bulto_hasta_orden_carga[il_row_he_pulsado]

	ll_rowcount = dw_datos.rowcount()
	
	ll_donde = 0
	
	do
		ll_donde = dw_datos.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and bulto_desde_orden_carga = 0 and pallets = 0 ",ll_donde+1,ll_rowcount)
		
		if ll_donde > 0 then
			if dw_datos.event itemchanged(ll_donde,dw_datos.object.bulto_desde_orden_carga,string(ll_bulto_desde_orden_carga)) = 0 then
				dw_datos.object.bulto_desde_orden_carga[ll_donde] = ll_bulto_desde_orden_carga
			end if
		end if
		
	loop while ll_donde > 0 and ll_donde < ll_rowcount	
	
end if
end event

event asignar();//Asignamos automaticamente todos los bultos

long ll_indice,ll_total

ll_total = dw_datos.rowcount()

for ll_indice = 1 to ll_total
	if dw_datos.object.venliped_reservas[ll_indice] = "" then
		dw_datos.setrow(ll_indice)
		dw_datos.scrolltorow(ll_indice)
		
		dw_datos.event clicked(0,0,ll_indice,dw_datos.object.venliped_reservas)
		
		if dw_stock.rowcount() > 0 then
			dw_stock.event clicked(0,0,0,dw_stock.object.seleccionar_automatico)
			
			dw_stock.event clicked(0,0,0,dw_stock.object.b_ok)
		end if
	end if
next
end event

event desasignar();//desasignamos automaticamente todos los bultos

long ll_indice,ll_total,ll_donde

ll_total = dw_datos.rowcount()

for ll_indice = 1 to ll_total
	if dw_datos.object.venliped_reservas[ll_indice] <> "" then
		dw_datos.event clicked(0,0,ll_indice,dw_datos.object.venliped_reservas)
		
		if dw_stock.rowcount() > 0 then
			ll_donde = 0
			
			do
				ll_donde = dw_stock.find("seleccionada = 1",ll_donde +1,dw_stock.rowcount())
				
				if ll_donde > 0 then
					dw_stock.object.seleccionada[ll_donde] = 0
				end if
			loop while ll_donde > 0 and ll_donde < dw_stock.rowcount()
			
			dw_stock.event clicked(0,0,0,dw_stock.object.b_ok)
		end if
	end if
next
end event

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
			  "       convert(dec(10,2),venliped.peso) as peso_kg, ~n"+&
			  "       -1 as id_alm_orden_carga_actual, ~n"+&
			  "       -1.000 as disponible, ~n"+&
			  "       0.000 as planificado, ~n"+&
			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_minima, ~n"+&
			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_maxima, ~n"+&
			  "       case when isnull(venliped.articulo,'') = '' then 40 else case venliped.situacion when 'P' then 50 when 'C' then 40 else 10 end end as estado_linea, ~n"+&
			  "       convert(dec(16,6), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) * 100 else 0 end ) as porcentaje_pallet_pico, ~n"+&
			  "       venped.usuario, ~n"+&	
			  "       alm_orden_carga.fecha as fecha_carga, ~n"+&	
			  "       isnull(alm_orden_carga.observaciones,'') as observaciones_carga, ~n"+&	
			  "       isnull(alm_orden_carga.almtipotransportes_codigo,'') as tipo_transporte, ~n"+&	
			  "       isnull(almtipotransportes.descripcion,'') as nombre_tipo_transporte, ~n"+&	
			  "       '' as venliped_reservas, ~n"+&	
			  "       '' as almacen_destino, ~n"+&	
			  "       '' as zona_destino, ~n"+&	
			  "       0 as fila_destino, ~n"+&	
			  "       0 as altura_destino, ~n"+&	
			  "       '' as almacen_destino_oc, ~n"+&	
			  "       '' as zona_destino_oc, ~n"+&	
			  "       0 as fila_destino_oc, ~n"+&	
			  "       0 as altura_destino_oc, ~n"+&				  
			  "       0 as id_alm_orden_carga_en_edicion, "+&
			  "       'N' as ubicar_desde_cabecera, ~n"+&
			  "       isnull(ventipolin.gestionar_en_piezas,'') as gestionar_en_piezas, ~n"+&
			  "       isnull(venliped.id_alm_orden_preparacion,0) as id_alm_orden_preparacion, ~n"+&
			  "       isnull(venliped.tipo_pallet_preparacion,isnull(venliped.tipo_pallet,'')) as tipo_pallet_preparacion ~n"+&
			  "FROM  venped ~n"+&
			  "      INNER JOIN venliped ON venped.empresa = venliped.empresa AND venped.anyo = venliped.anyo AND venped.pedido = venliped.pedido ~n"+&
			  "      LEFT OUTER JOIN ventipolin ON ventipolin.empresa = venliped.empresa and ventipolin.codigo = venliped.tipolinea ~n"+&			  
			  "      INNER JOIN alm_orden_carga ON venliped.id_alm_orden_carga = alm_orden_carga.id ~n"+&			  
			  "		LEFT OUTER JOIN venenvio ON venped.empresa = venenvio.empresa AND venped.cliente = venenvio.cliente AND venped.envio = venenvio.codigo ~n"+&
		 	  "		LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo ~n"+&
			  "      LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
			  "      LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo "+&			  
			  "      LEFT OUTER JOIN unidades ON ( case when ventipolin.gestionar_en_piezas = 'S' then '0' else articulos.unidad end ) = unidades.codigo ~n"+&
			  "		LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo ~n"+&
			  "		LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo ~n"+&
			  "		LEFT OUTER JOIN almcajas ON venliped.empresa = almcajas.empresa AND venliped.caja = almcajas.codigo ~n"+&
			  "		LEFT OUTER JOIN almartcajas ON venliped.empresa = almartcajas.empresa AND venliped.articulo = almartcajas.articulo AND venliped.caja = almartcajas.caja ~n"+&
			  "		LEFT OUTER JOIN palarticulo ON venliped.empresa = palarticulo.empresa AND venliped.articulo = palarticulo.articulo AND venliped.tipo_pallet = palarticulo.codigo AND venliped.caja = palarticulo.caja ~n"+&			  
			  "      LEFT OUTER JOIN almtipotransportes ON alm_orden_carga.empresa = almtipotransportes.empresa AND alm_orden_carga.almtipotransportes_codigo = almtipotransportes.codigo, ~n"+&			  
			  "		genter ~n"+&
			  "WHERE ( venped.empresa    = genter.empresa ) ~n"+&
			  "AND   ( 'C'               = genter.tipoter ) ~n"+&
			  "AND   ( venped.cliente    = genter.codigo ) ~n"+&
			  "AND   ( venped.es_proforma = 'N' ) ~n"+&
			  "AND   ( alm_orden_carga.confirmada = 'S' ) ~n"+&
			  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) ~n"//+&
//			  "ORDER BY venped.anyo, ~n"+&
//			  "		   venped.pedido, ~n"+& 
//			  "		   venliped.linea"


return cadena





end function

public function string f_construir_group_by ();string cadena

cadena =   "ORDER BY venliped.id_alm_orden_carga, ~n"+&
			  "         venped.anyo, ~n"+&
			  "		   venped.pedido, ~n"+& 
			  "		   venliped.linea"

return cadena
end function

public subroutine f_cargar_datawindow (string new_sql);string ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad
long   ll_total,ll_row,ll_rows
datastore ds_datos

dw_datos.reset()
dw_datos.setredraw(false)
	
//Reseteo de la orden de preparación
ib_generando_orden_de_preparacion = false
dw_cabecera_orden_preparacion.visible = false
dw_datos.modify("b_generar_orden_de_peparacion.text='Generar Orden Preparación'")
dw_datos.modify("datawindow.footer.height = 92")			
dw_datos.selectrow(0,false)
il_orden_preparacion_genero = 0
dw_cabecera_orden_preparacion.reset()	
	
ll_rows = f_cargar_cursor_transaccion(sqlca,ds_datos,new_sql)

dw_datos.ClearValues("tipo_pallet_preparacion")

datastore ds_pallets
long      ll_indice_pallets,ll_total_pallets
string    ls_codigo,ls_descripcion,ls_sel

ls_sel = "select isnull(pallets.codigo,'') as codigo, "+&
			"		 isnull(pallets.resumido,pallets.descripcion) as descripcion, "+&
			"		 case when pallets.usado_en_picking = 'S' then 1 else 2 end as orden "+&
			"from   pallets "+&
			"where  pallets.empresa = '"+codigo_empresa+"' "+&
			"and    pallets.usado_en_picking = 'S' "+&
			"union all "+&
			"select isnull(pallets.codigo,'') as codigo, "+&
			"		 isnull(pallets.resumido,pallets.descripcion) as descripcion, "+&
			"		 case when pallets.usado_en_picking = 'S' then 1 else 2 end as orden "+&
			"from   pallets "+&
			"where  pallets.empresa = '"+codigo_empresa+"' "+&
			"and    pallets.usado_en_picking <> 'S' "+&
			"order by orden,isnull(pallets.resumido,pallets.descripcion)"

ll_total_pallets = f_cargar_cursor_transaccion(sqlca,ds_pallets,ls_sel)

for ll_indice_pallets = 1 to ll_total_pallets
	ls_codigo      = ds_pallets.object.codigo[ll_indice_pallets]
	ls_descripcion = ds_pallets.object.descripcion[ll_indice_pallets]
	
	dw_datos.SetValue("tipo_pallet_preparacion", ll_indice_pallets, ls_descripcion+"~t"+ls_codigo )
next
destroy ds_pallets

if ll_rows > 0 then
	//Primero mostraremos los bultos ya asignados
	f_mostrar_bultos_asignados(ds_datos)
	
	dw_datos.object.data = ds_datos.object.data
	dw_datos.Event rowfocuschanged(1)
end if

destroy ds_datos

dw_datos.setredraw(true)

end subroutine

public subroutine f_calculo_disponibilidad (datastore ds_datos);string ls_sel,ls_find
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
end subroutine

public subroutine f_mostrar_bultos_linea (datawindow arg_datawindow, long arg_row);string ls_almacen,ls_zona,ls_descripcion_reservas,ls_sel,ls_fila,ls_altura,ls_bulto,ls_cantidad,ls_ubicacion
int    li_anyo,li_linea,li_fila,li_altura
dec    ld_cantidad
long   ll_pedido,ll_bulto,ll_indice,ll_total,ll_id_ubicacion_destino
string ls_almacen_ubicacion_destino,ls_zona_ubicacion_destino
int    li_fila_ubicacion_destino,li_altura_ubicacion_destino

datastore ds_datos

li_anyo   = arg_datawindow.object.anyo[arg_row]
ll_pedido = arg_datawindow.object.pedido[arg_row]
li_linea  = arg_datawindow.object.linea[arg_row]

if ib_mostrar_ubicacion_original then
	ls_sel = "select almubimapa_codbar.almacen, "+&
				"       almubimapa_codbar.zona, "+&
				"       almubimapa_codbar.fila, "+&
				"       almubimapa_codbar.altura, "+&
				"       isnull(venliped_reservas_ubi_orig.alm_bultos_id,0) as alm_bultos_id, "+&
				"       sum(venliped_reservas_ubi_orig.cantidad) as cantidad, "+&
				"       isnull(venliped_reservas_ubi_orig.anyo,0) as venliped_reservas_anyo, "+&
				"       isnull(venliped_reservas_ubi_orig.pedido,0) as venliped_reservas_pedido, "+&
				"       isnull(venliped_reservas_ubi_orig.linea,0) as venliped_reservas_linea, "+&
				"       isnull(venliped_reservas_ubi_orig.id_ubicacion_destino,0) as id_ubicacion_destino "+&
				"from   venliped_reservas_ubi_orig,almubimapa_codbar "+&
				"where  venliped_reservas_ubi_orig.id_ubicacion_original = almubimapa_codbar.id "+&
				"and    venliped_reservas_ubi_orig.empresa = '"+codigo_empresa+"' "+&
				"and    venliped_reservas_ubi_orig.anyo    = "+string(li_anyo,"###0")+" "+&
				"and    venliped_reservas_ubi_orig.pedido  = "+string(ll_pedido,"######0")+" "+&
				"and    venliped_reservas_ubi_orig.linea   = "+string(li_linea,"###0")+" "+&				
				"group by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         venliped_reservas_ubi_orig.alm_bultos_id, "+&
				"         venliped_reservas_ubi_orig.anyo, "+&
				"         venliped_reservas_ubi_orig.pedido, "+&
				"         venliped_reservas_ubi_orig.linea, "+&
				"         venliped_reservas_ubi_orig.id_ubicacion_destino "+&
				"order by venliped_reservas_ubi_orig.anyo, "+&
				"         venliped_reservas_ubi_orig.pedido, "+&
				"         venliped_reservas_ubi_orig.linea, "+&
				"         almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         venliped_reservas_ubi_orig.alm_bultos_id "	
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
end if

if not(ib_mostrar_ubicacion_original) or ll_total = 0 then
	ls_sel = "select almubimapa_codbar.almacen, "+&
				"       almubimapa_codbar.zona, "+&
				"       almubimapa_codbar.fila, "+&
				"       almubimapa_codbar.altura, "+&
				"       alm_bultos.id, "+&
				"       sum(venliped_reservas.cantidad) as cantidad, "+&
				"       venliped_reservas.id_ubicacion_original, "+&
				"       isnull(venliped_reservas.id_ubicacion_destino,0) as id_ubicacion_destino "+&
				"from   venliped_reservas,alm_bultos,alm_bultos_lineas,almubimapa_codbar "+&
				"where  venliped_reservas.empresa              = alm_bultos_lineas.empresa "+&
				"and    venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id "+&
				"and    alm_bultos_lineas.id_alm_bultos        = alm_bultos.id "+&
				"and    alm_bultos.id_ubicacion                = almubimapa_codbar.id "+&
				"and    venliped_reservas.empresa = '"+codigo_empresa+"' "+&
				"and    venliped_reservas.anyo    = "+string(li_anyo,"###0")+" "+&
				"and    venliped_reservas.pedido  = "+string(ll_pedido,"######0")+" "+&
				"and    venliped_reservas.linea   = "+string(li_linea,"###0")+" "+&
				"group by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id, "+&
				"         venliped_reservas.id_ubicacion_original, "+&
				"         venliped_reservas.id_ubicacion_destino "+&
				"order by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id, "+&
				"         venliped_reservas.id_ubicacion_original "
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)			
end if

if ll_total = 0 then
	ls_descripcion_reservas = ""	
else
	for ll_indice = 1 to ll_total
		ls_almacen  = ds_datos.object.almubimapa_codbar_almacen[ll_indice]
		ls_zona     = ds_datos.object.almubimapa_codbar_zona[ll_indice]
		li_fila     = ds_datos.object.almubimapa_codbar_fila[ll_indice]
		li_altura   = ds_datos.object.almubimapa_codbar_altura[ll_indice]
		ll_bulto    = ds_datos.object.alm_bultos_id[ll_indice]
		ld_cantidad = ds_datos.object.cantidad[ll_indice]
		ll_id_ubicacion_destino = ds_datos.object.id_ubicacion_destino[ll_indice]
						
		if ll_id_ubicacion_destino <> 0 then
			SELECT isnull(almubimapa_codbar.almacen,''), 
					 isnull(almubimapa_codbar.zona,''), 
					 isnull(almubimapa_codbar.fila,0), 
					 isnull(almubimapa_codbar.altura,0) 
			INTO   :ls_almacen_ubicacion_destino, 
					 :ls_zona_ubicacion_destino, 
					 :li_fila_ubicacion_destino, 
					 :li_altura_ubicacion_destino 
			FROM   almubimapa_codbar 
			WHERE  almubimapa_codbar.empresa = :codigo_empresa 
			AND    almubimapa_codbar.id      = :ll_id_ubicacion_destino;
			
			arg_datawindow.object.almacen_destino[arg_row] = ls_almacen_ubicacion_destino
			arg_datawindow.object.zona_destino[arg_row]    = ls_zona_ubicacion_destino
			arg_datawindow.object.fila_destino[arg_row]    = li_fila_ubicacion_destino
			arg_datawindow.object.altura_destino[arg_row]  = li_altura_ubicacion_destino		
		else		
			if arg_datawindow.object.situacion[arg_row] = 'P' and not(ib_mostrar_ubicacion_original) then
				arg_datawindow.object.almacen_destino[arg_row] = ls_almacen
				arg_datawindow.object.zona_destino[arg_row]    = ls_zona
				arg_datawindow.object.fila_destino[arg_row]    = li_fila
				arg_datawindow.object.altura_destino[arg_row]  = li_altura
			end if
		end if
		
		ls_almacen  = space(2 - len(ls_almacen)) + ls_almacen
		ls_zona     = space(2 - len(ls_zona)) + ls_zona
		ls_fila     = string(li_fila,"##0")
		ls_fila     = space(3 - len(ls_fila)) + ls_fila
		ls_altura   = string(li_altura,"#0")
		ls_altura   = space(2 - len(ls_altura)) + ls_altura
		ls_bulto    = string(ll_bulto,"0000000000")
		ls_cantidad = string(ld_cantidad,"######0.00")
		ls_cantidad = space(10 - len(ls_cantidad)) + ls_cantidad
		
		ls_ubicacion = ls_almacen+'-'+ls_zona+'-'+ls_fila+'-'+ls_altura
		
		if ll_indice = 1 then
			ls_descripcion_reservas = ls_ubicacion+' '+ls_bulto+' '+ls_cantidad
		else
			ls_descripcion_reservas += "~n"+ls_ubicacion+' '+ls_bulto+' '+ls_cantidad
		end if
	next
end if

arg_datawindow.object.venliped_reservas[arg_row] = ls_descripcion_reservas

destroy ds_datos
end subroutine

public subroutine f_mostrar_bultos_asignados (datastore ds_datos);string ls_almacen,ls_zona,ls_descripcion_reservas,ls_sel,ls_fila,ls_altura,ls_bulto,ls_cantidad,ls_ubicacion
int    li_anyo,li_linea,li_fila,li_altura
dec    ld_cantidad
long   ll_pedido,ll_bulto,ll_indice,ll_total,ll_indice_bultos,ll_total_bultos,ll_total_bultos2,ll_id_ubicacion_destino 
string ls_almacen_ubicacion_destino,ls_zona_ubicacion_destino 
int    li_fila_ubicacion_destino,li_altura_ubicacion_destino 
							 
datastore ds_datos_bultos,ds_datos_bultos2

pointer oldpointer
this.setredraw(false)
oldpointer = SetPointer(AppStarting!)//(HourGlass!)

if ib_mostrar_ubicacion_original then
	ls_sel = "select almubimapa_codbar.almacen, "+&
				"       almubimapa_codbar.zona, "+&
				"       almubimapa_codbar.fila, "+&
				"       almubimapa_codbar.altura, "+&
				"       isnull(venliped_reservas_ubi_orig.alm_bultos_id,0) as alm_bultos_id, "+&
				"       sum(venliped_reservas_ubi_orig.cantidad) as cantidad, "+&
				"       isnull(venliped_reservas_ubi_orig.anyo,0) as venliped_reservas_anyo, "+&
				"       isnull(venliped_reservas_ubi_orig.pedido,0) as venliped_reservas_pedido, "+&
				"       isnull(venliped_reservas_ubi_orig.linea,0) as venliped_reservas_linea, "+&
				"       isnull(venliped_reservas_ubi_orig.id_ubicacion_destino,0) as id_ubicacion_destino "+&
				"from   venliped_reservas_ubi_orig,almubimapa_codbar,venliped "+&
				"where  venliped_reservas_ubi_orig.empresa = venliped.empresa "+&
				"and    venliped_reservas_ubi_orig.anyo    = venliped.anyo "+&
				"and    venliped_reservas_ubi_orig.pedido  = venliped.pedido "+&
				"and    venliped_reservas_ubi_orig.linea   = venliped.linea "+&
				"and    venliped_reservas_ubi_orig.id_ubicacion_original = almubimapa_codbar.id "+&
				"and    venliped_reservas_ubi_orig.empresa = '"+codigo_empresa+"' "+&
				"group by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         venliped_reservas_ubi_orig.alm_bultos_id, "+&
				"         venliped_reservas_ubi_orig.anyo, "+&
				"         venliped_reservas_ubi_orig.pedido, "+&
				"         venliped_reservas_ubi_orig.linea, "+&
				"         venliped_reservas_ubi_orig.id_ubicacion_destino "+&
				"order by venliped_reservas_ubi_orig.anyo, "+&
				"         venliped_reservas_ubi_orig.pedido, "+&
				"         venliped_reservas_ubi_orig.linea, "+&
				"         almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         venliped_reservas_ubi_orig.alm_bultos_id "	
				
	ll_total_bultos = f_cargar_cursor_transaccion(sqlca,ds_datos_bultos,ls_sel)				

	ls_sel = "select almubimapa_codbar.almacen, "+&
				"       almubimapa_codbar.zona, "+&
				"       almubimapa_codbar.fila, "+&
				"       almubimapa_codbar.altura, "+&
				"       alm_bultos.id, "+&
				"       sum(venliped_reservas.cantidad) as cantidad, "+&
				"       venliped_reservas.anyo, "+&
				"       venliped_reservas.pedido, "+&
				"       venliped_reservas.linea, "+&
				"       isnull(venliped_reservas.id_ubicacion_destino,0) as id_ubicacion_destino "+&
				"from   venliped_reservas,alm_bultos,alm_bultos_lineas,almubimapa_codbar "+&
				"where  venliped_reservas.empresa              = alm_bultos_lineas.empresa "+&
				"and    venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id "+&
				"and    alm_bultos_lineas.id_alm_bultos        = alm_bultos.id "+&
				"and    alm_bultos.id_ubicacion                = almubimapa_codbar.id "+&
				"and    venliped_reservas.empresa = '"+codigo_empresa+"' "+&
				"group by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id, "+&
				"         venliped_reservas.anyo, "+&
				"         venliped_reservas.pedido, "+&
				"         venliped_reservas.linea, "+&
				"         venliped_reservas.id_ubicacion_destino "+&
				"order by venliped_reservas.anyo, "+&
				"         venliped_reservas.pedido, "+&
				"         venliped_reservas.linea, "+&
				"         almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id "
		
	ll_total_bultos2 = f_cargar_cursor_transaccion(sqlca,ds_datos_bultos2,ls_sel)				
else
	ls_sel = "select almubimapa_codbar.almacen, "+&
				"       almubimapa_codbar.zona, "+&
				"       almubimapa_codbar.fila, "+&
				"       almubimapa_codbar.altura, "+&
				"       alm_bultos.id, "+&
				"       sum(venliped_reservas.cantidad) as cantidad, "+&
				"       venliped_reservas.anyo, "+&
				"       venliped_reservas.pedido, "+&
				"       venliped_reservas.linea, "+&
				"       isnull(venliped_reservas.id_ubicacion_destino,0) as id_ubicacion_destino "+&
				"from   venliped_reservas,alm_bultos,alm_bultos_lineas,almubimapa_codbar "+&
				"where  venliped_reservas.empresa              = alm_bultos_lineas.empresa "+&
				"and    venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id "+&
				"and    alm_bultos_lineas.id_alm_bultos        = alm_bultos.id "+&
				"and    alm_bultos.id_ubicacion                = almubimapa_codbar.id "+&
				"and    venliped_reservas.empresa = '"+codigo_empresa+"' "+&
				"group by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id, "+&
				"         venliped_reservas.anyo, "+&
				"         venliped_reservas.pedido, "+&
				"         venliped_reservas.linea, "+&
				"         venliped_reservas.id_ubicacion_destino "+&
				"order by venliped_reservas.anyo, "+&
				"         venliped_reservas.pedido, "+&
				"         venliped_reservas.linea, "+&
				"         almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id "
				
	ll_total_bultos = f_cargar_cursor_transaccion(sqlca,ds_datos_bultos,ls_sel)
end if
			


if ll_total_bultos > 0 or ll_total_bultos2 > 0 then 
	ll_total = ds_datos.rowcount()
	
	for ll_indice = 1 to ll_total
	
		li_anyo   = ds_datos.object.venped_anyo[ll_indice]
		ll_pedido = ds_datos.object.venped_pedido[ll_indice]
		li_linea  = ds_datos.object.venliped_linea[ll_indice]
		
		ls_descripcion_reservas = ""
		
		ds_datos_bultos.setfilter("venliped_reservas_anyo = "+string(li_anyo,"###0")+" and venliped_reservas_pedido = "+string(ll_pedido,"#####0")+" and venliped_reservas_linea = "+string(li_linea,"###0"))
		ds_datos_bultos.filter()
		
		ll_total_bultos = ds_datos_bultos.rowcount()
		
		if ll_total_bultos > 0 then
			for ll_indice_bultos = 1 to ll_total_bultos
				ls_almacen  = ds_datos_bultos.object.almubimapa_codbar_almacen[ll_indice_bultos]
				ls_zona     = ds_datos_bultos.object.almubimapa_codbar_zona[ll_indice_bultos]
				li_fila     = ds_datos_bultos.object.almubimapa_codbar_fila[ll_indice_bultos]
				li_altura   = ds_datos_bultos.object.almubimapa_codbar_altura[ll_indice_bultos]
				ll_bulto    = ds_datos_bultos.object.alm_bultos_id[ll_indice_bultos]
				ld_cantidad = ds_datos_bultos.object.cantidad[ll_indice_bultos]
				ll_id_ubicacion_destino = ds_datos_bultos.object.id_ubicacion_destino[ll_indice_bultos]
				
				if ll_id_ubicacion_destino <> 0 then
					SELECT isnull(almubimapa_codbar.almacen,''), 
							 isnull(almubimapa_codbar.zona,''), 
							 isnull(almubimapa_codbar.fila,0), 
							 isnull(almubimapa_codbar.altura,0) 
					INTO   :ls_almacen_ubicacion_destino, 
							 :ls_zona_ubicacion_destino, 
							 :li_fila_ubicacion_destino, 
							 :li_altura_ubicacion_destino 
					FROM   almubimapa_codbar 
					WHERE  almubimapa_codbar.empresa = :codigo_empresa 
					AND    almubimapa_codbar.id      = :ll_id_ubicacion_destino;
					
					ds_datos.object.almacen_destino[ll_indice] = ls_almacen_ubicacion_destino
					ds_datos.object.zona_destino[ll_indice]    = ls_zona_ubicacion_destino
					ds_datos.object.fila_destino[ll_indice]    = li_fila_ubicacion_destino
					ds_datos.object.altura_destino[ll_indice]  = li_altura_ubicacion_destino						
				else
					if ds_datos.object.venliped_situacion[ll_indice] = 'P' and not(ib_mostrar_ubicacion_original) then
						ds_datos.object.almacen_destino[ll_indice] = ls_almacen
						ds_datos.object.zona_destino[ll_indice]    = ls_zona
						ds_datos.object.fila_destino[ll_indice]    = li_fila
						ds_datos.object.altura_destino[ll_indice]  = li_altura
					end if								
				end if
				
				ls_almacen  = space(2 - len(ls_almacen)) + ls_almacen
				ls_zona     = space(2 - len(ls_zona)) + ls_zona
				ls_fila     = string(li_fila,"##0")
				ls_fila     = space(3 - len(ls_fila)) + ls_fila
				ls_altura   = string(li_altura,"#0")
				ls_altura   = space(2 - len(ls_altura)) + ls_altura
				ls_bulto    = string(ll_bulto,"0000000000")
				ls_cantidad = string(ld_cantidad,"######0.00")
				ls_cantidad = space(10 - len(ls_cantidad)) + ls_cantidad
				
				ls_ubicacion = ls_almacen+'-'+ls_zona+'-'+ls_fila+'-'+ls_altura
				
				if ll_indice_bultos = 1 then
					ls_descripcion_reservas = ls_ubicacion+' '+ls_bulto+' '+ls_cantidad
				else
					ls_descripcion_reservas += "~n"+ls_ubicacion+' '+ls_bulto+' '+ls_cantidad
				end if
			next
		else
			if ib_mostrar_ubicacion_original then
				//Vamos a buscar en el segundo cursor si hemos elegido mostrar las ubicaciones originales
				ds_datos_bultos2.setfilter("venliped_reservas_anyo = "+string(li_anyo,"###0")+" and venliped_reservas_pedido = "+string(ll_pedido,"#####0")+" and venliped_reservas_linea = "+string(li_linea,"###0"))
				ds_datos_bultos2.filter()
				
				ll_total_bultos = ds_datos_bultos2.rowcount()			
				
				for ll_indice_bultos = 1 to ll_total_bultos
					ls_almacen  = ds_datos_bultos2.object.almubimapa_codbar_almacen[ll_indice_bultos]
					ls_zona     = ds_datos_bultos2.object.almubimapa_codbar_zona[ll_indice_bultos]
					li_fila     = ds_datos_bultos2.object.almubimapa_codbar_fila[ll_indice_bultos]
					li_altura   = ds_datos_bultos2.object.almubimapa_codbar_altura[ll_indice_bultos]
					ll_bulto    = ds_datos_bultos2.object.alm_bultos_id[ll_indice_bultos]
					ld_cantidad = ds_datos_bultos2.object.cantidad[ll_indice_bultos]
					ll_id_ubicacion_destino = ds_datos_bultos2.object.id_ubicacion_destino[ll_indice_bultos]
									
					SELECT isnull(almubimapa_codbar.almacen,''), 
							 isnull(almubimapa_codbar.zona,''), 
							 isnull(almubimapa_codbar.fila,0), 
							 isnull(almubimapa_codbar.altura,0) 
					INTO   :ls_almacen_ubicacion_destino, 
							 :ls_zona_ubicacion_destino, 
							 :li_fila_ubicacion_destino, 
							 :li_altura_ubicacion_destino 
					FROM   almubimapa_codbar 
					WHERE  almubimapa_codbar.empresa = :codigo_empresa 
					AND    almubimapa_codbar.id      = :ll_id_ubicacion_destino;
					
					ds_datos.object.almacen_destino[ll_indice] = ls_almacen_ubicacion_destino
					ds_datos.object.zona_destino[ll_indice]    = ls_zona_ubicacion_destino
					ds_datos.object.fila_destino[ll_indice]    = li_fila_ubicacion_destino
					ds_datos.object.altura_destino[ll_indice]  = li_altura_ubicacion_destino						
					
//					if ds_datos.object.venliped_situacion[ll_indice] = 'P' then
//						ds_datos.object.almacen_destino[ll_indice] = ls_almacen
//						ds_datos.object.zona_destino[ll_indice]    = ls_zona
//						ds_datos.object.fila_destino[ll_indice]    = li_fila
//						ds_datos.object.altura_destino[ll_indice]  = li_altura
//					end if			
					
					ls_almacen  = space(2 - len(ls_almacen)) + ls_almacen
					ls_zona     = space(2 - len(ls_zona)) + ls_zona
					ls_fila     = string(li_fila,"##0")
					ls_fila     = space(3 - len(ls_fila)) + ls_fila
					ls_altura   = string(li_altura,"#0")
					ls_altura   = space(2 - len(ls_altura)) + ls_altura
					ls_bulto    = string(ll_bulto,"0000000000")
					ls_cantidad = string(ld_cantidad,"######0.00")
					ls_cantidad = space(10 - len(ls_cantidad)) + ls_cantidad
					
					ls_ubicacion = ls_almacen+'-'+ls_zona+'-'+ls_fila+'-'+ls_altura
					
					if ll_indice_bultos = 1 then
						ls_descripcion_reservas = ls_ubicacion+' '+ls_bulto+' '+ls_cantidad
					else
						ls_descripcion_reservas += "~n"+ls_ubicacion+' '+ls_bulto+' '+ls_cantidad
					end if
				next			
			end if
		end if
		
		ds_datos.object.venliped_reservas[ll_indice] = ls_descripcion_reservas
	next
end if

destroy ds_datos_bultos
destroy ds_datos_bultos2

this.setredraw(true)
SetPointer(oldpointer)
end subroutine

public function boolean f_cerrar_orden (long arg_row);long   ll_id_alm_orden_carga,ll_rowcount,ll_donde,ll_indice,ll_total,ll_donde_destino
string ls_almacen_destino,ls_zona_destino,ls_sel
long   ll_alm_bultos_id,ll_alm_bultos_lineas_id
int    li_venliped_anyo_destino,li_venliped_linea_destino			
long   ll_alm_bultos_id_destino,ll_venliped_pedido_destino
dec    ll_venliped_reservas_cantidad,ll_alm_bultos_lineas_cantidad
string ls_almacen_origen_bulto,ls_zona_origen_bulto 
long   ll_fila_origen_bulto,ll_altura_origen_bulto,ll_cantidad_bulto
int    li_fila_destino,li_altura_destino,li_lineas_en_venliped_reservas_ubi_orig
string is_tipo_movimiento_salida = '204',is_tipo_movimiento_entrada = '205',ls_ubicacion_con_bulto_asociado
boolean lb_correcto = true,lb_salida_realizada,lb_entrada_realizada,lb_pasar_a_venliped_reservas_original = true

str_venliped lstr_venliped
str_venliped_reservas lstr_venliped_reservas
str_venliped_reservas_ubi_orig lstr_venliped_reservas_ubi_orig

str_movimiento_almacen_traspaso_bultos lstr_movimiento_almacen_traspaso_bultos
str_movimiento_almacen lstr_movimiento_almacen

datastore ds_datos

pointer oldpointer

oldpointer = SetPointer(HourGlass!)

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]

	ll_rowcount = dw_datos.rowcount()
	
	ll_donde = 0
	
	do
		ll_donde = dw_datos.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and situacion <> 'P' and almacen_destino <> '' and zona_destino <> '' and fila_destino <> 0 and altura_destino <> 0 and articulo <> '' and venliped_reservas <> '' ",ll_donde+1,ll_rowcount)
		
		if ll_donde > 0 then
			if ll_donde = 23 then
				ll_donde = 23
			end if
			
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = dw_datos.object.anyo[ll_donde]
			lstr_venliped.pedido  = dw_datos.object.pedido[ll_donde]
			lstr_venliped.linea   = dw_datos.object.linea[ll_donde]
			
			li_lineas_en_venliped_reservas_ubi_orig = 0
			
			select isnull(count(*),0)
			into   :li_lineas_en_venliped_reservas_ubi_orig
			from   venliped_reservas_ubi_orig
			where  venliped_reservas_ubi_orig.empresa = :lstr_venliped.empresa
			and    venliped_reservas_ubi_orig.anyo    = :lstr_venliped.anyo
			and    venliped_reservas_ubi_orig.pedido  = :lstr_venliped.pedido
			and    venliped_reservas_ubi_orig.linea   = :lstr_venliped.linea;
			
			if li_lineas_en_venliped_reservas_ubi_orig > 0 then
				lb_pasar_a_venliped_reservas_original = false
			else
				lb_pasar_a_venliped_reservas_original = true
			end if
			
			if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then			
				ls_almacen_destino = dw_datos.object.almacen_destino[ll_donde]
				ls_zona_destino    = dw_datos.object.zona_destino[ll_donde]
				li_fila_destino    = dw_datos.object.fila_destino[ll_donde]
				li_altura_destino  = dw_datos.object.altura_destino[ll_donde]				
				
				ls_sel = "SELECT isnull(alm_bultos.id,0) as alm_bultos_id, "+&
							"		  isnull(venliped_reservas.alm_bultos_lineas_id,0) as alm_bultos_lineas_id, "+&
							"		  isnull(venliped_reservas.cantidad,0) as venliped_reservas_cantidad, "+&
							"		  isnull(alm_bultos_lineas.cantidad,0) as alm_bultos_lineas_cantidad "+&
							"FROM   venliped_reservas, "+&
							"		  alm_bultos, "+&
							"		  alm_bultos_lineas "+&
							"WHERE ( venliped_reservas.empresa              = alm_bultos_lineas.empresa ) "+&
							"AND	 ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) "+&
							"AND	 ( alm_bultos_lineas.empresa              = alm_bultos.empresa ) "+&
							"AND	 ( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) "+&
							"AND ( ( venliped_reservas.empresa              = '"+lstr_venliped.empresa+"' ) "+&
							"AND	 ( venliped_reservas.anyo                 = "+string(lstr_venliped.anyo,"###0")+" ) "+&
							"AND	 ( venliped_reservas.pedido               = "+string(lstr_venliped.pedido,"######0")+" ) "+&
							"AND 	 ( venliped_reservas.linea                = "+string(lstr_venliped.linea,"###0")+" ) )"						
							
				ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)			
							
				lb_salida_realizada  = false
				lb_entrada_realizada	= false
							
				for ll_indice = 1 to ll_total
					ll_alm_bultos_id              = ds_datos.object.alm_bultos_id[ll_indice]
					ll_alm_bultos_lineas_id       = ds_datos.object.alm_bultos_lineas_id[ll_indice]
					ll_venliped_reservas_cantidad = ds_datos.object.venliped_reservas_cantidad[ll_indice]
					ll_alm_bultos_lineas_cantidad = ds_datos.object.alm_bultos_lineas_cantidad[ll_indice]
					
					if lb_pasar_a_venliped_reservas_original then
						if f_cargar_str_venliped_reservas(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,ll_alm_bultos_lineas_id,lstr_venliped_reservas) then
							lstr_venliped_reservas_ubi_orig.empresa               = lstr_venliped_reservas.empresa
							lstr_venliped_reservas_ubi_orig.anyo                  = lstr_venliped_reservas.anyo
							lstr_venliped_reservas_ubi_orig.pedido                = lstr_venliped_reservas.pedido
							lstr_venliped_reservas_ubi_orig.linea                 = lstr_venliped_reservas.linea
							lstr_venliped_reservas_ubi_orig.alm_bultos_lineas_id  = lstr_venliped_reservas.alm_bultos_lineas_id
							lstr_venliped_reservas_ubi_orig.cantidad              = lstr_venliped_reservas.cantidad
							lstr_venliped_reservas_ubi_orig.id_ubicacion_original = lstr_venliped_reservas.id_ubicacion_original
							lstr_venliped_reservas_ubi_orig.alm_bultos_id         = ll_alm_bultos_id
							lstr_venliped_reservas_ubi_orig.id_ubicacion_destino  = lstr_venliped_reservas.id_ubicacion_destino 
							
							if not(f_insert_str_venliped_reservas_ubi_orig(lstr_venliped_reservas_ubi_orig)) then
								messagebox("¡Error!","Se ha producido un error al guardar las ubicaciones originales de la O.C.")
								lb_correcto = false							
							end if
						else
							messagebox("¡Error!","Se ha producido un error al guardar las ubicaciones originales de la O.C.")
							lb_correcto = false
						end if
					end if
					
					ls_almacen_origen_bulto = ""
					ls_zona_origen_bulto    = ""
					ll_fila_origen_bulto    = 0
					ll_altura_origen_bulto  = 0
					ll_cantidad_bulto       = 0
					
					SELECT isnull(almubimapa_codbar.almacen,''), 
							 isnull(almubimapa_codbar.zona,''), 
							 isnull(almubimapa_codbar.fila,0), 
							 isnull(almubimapa_codbar.altura,0), 
							 isnull(sum(alm_bultos_lineas.cantidad),0),
							 case when isnull(almubimapa_codbar.id_alm_bultos,0) = alm_bultos.id then 'S' else 'N' end as ubicacion_con_bulto_asociado
					INTO   :ls_almacen_origen_bulto, 
							 :ls_zona_origen_bulto, 
							 :ll_fila_origen_bulto, 
							 :ll_altura_origen_bulto, 
							 :ll_cantidad_bulto,
							 :ls_ubicacion_con_bulto_asociado
					FROM   almubimapa_codbar,   
							 alm_bultos,   
							 alm_bultos_lineas  
					WHERE ( almubimapa_codbar.id      = alm_bultos.id_ubicacion ) 
					AND  	( almubimapa_codbar.empresa = alm_bultos.empresa ) 
					AND  	( alm_bultos.id             = alm_bultos_lineas.id_alm_bultos ) 
					AND ( ( alm_bultos.empresa        = :lstr_venliped.empresa ) 
					AND 	( alm_bultos.id             = :ll_alm_bultos_id ) )
					GROUP BY isnull(almubimapa_codbar.almacen,''),   
							 	isnull(almubimapa_codbar.zona,''),   
							 	isnull(almubimapa_codbar.fila,0),   
							 	isnull(almubimapa_codbar.altura,0),
								isnull(almubimapa_codbar.id_alm_bultos,0),
								alm_bultos.id;
						
					//Vamos a buscar bultos con el mismo numero que el actual para asignarles la misma ubicacion
					ll_rowcount = dw_datos.rowcount()
					
					ll_donde_destino = 0
					
					ll_donde_destino = dw_datos.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and getrow() <> "+string(ll_donde,"####0")+" and situacion = 'P' and ( "+string(lstr_venliped.bulto_desde_orden_carga)+" <= bulto_desde_orden_carga and bulto_hasta_orden_carga <= "+string(lstr_venliped.bulto_hasta_orden_carga)+" ) ",1,ll_rowcount)
												
					//Tengo que controlar si hay varias lineas de reserva de esta linea de pedido para agruparlas al traspasar en una sola	
					if ll_venliped_reservas_cantidad = ll_alm_bultos_lineas_cantidad and ll_alm_bultos_lineas_cantidad = ll_cantidad_bulto and ll_donde_destino = 0 and ll_total = 1 and ls_ubicacion_con_bulto_asociado = 'N' and dw_datos.object.porcentaje_pallet_pico[arg_row] = 0 then
						//Traspasamos directamente el bulto si la cantidad reservada se corresponde con la cantidad del bulto y no hay ningun otro bulto 
						//con el mismo numero de pallet dentro de la oc y una sola linea de reserva
						lstr_movimiento_almacen_traspaso_bultos.empresa                   = lstr_venliped.empresa
						lstr_movimiento_almacen_traspaso_bultos.articulo                  = lstr_venliped.articulo
						lstr_movimiento_almacen_traspaso_bultos.calidad                   = lstr_venliped.calidad
						lstr_movimiento_almacen_traspaso_bultos.tono                      = lstr_venliped.tonochar
						lstr_movimiento_almacen_traspaso_bultos.calibre                   = lstr_venliped.calibre
						lstr_movimiento_almacen_traspaso_bultos.tipo_pallet               = lstr_venliped.tipo_pallet
						lstr_movimiento_almacen_traspaso_bultos.caja                      = lstr_venliped.caja
						lstr_movimiento_almacen_traspaso_bultos.cantidad                  = -1 * ( ll_venliped_reservas_cantidad )
						lstr_movimiento_almacen_traspaso_bultos.orden_carga_anyo          = 0
						lstr_movimiento_almacen_traspaso_bultos.orden_carga_codigo        = "" //Cambiar esto en la gestion del movimiento
						lstr_movimiento_almacen_traspaso_bultos.orden_carga_linea         = 0
						lstr_movimiento_almacen_traspaso_bultos.tipo_movimiento_salida    = is_tipo_movimiento_salida
						lstr_movimiento_almacen_traspaso_bultos.observaciones             = ""
						lstr_movimiento_almacen_traspaso_bultos.almacen_salida            = ls_almacen_origen_bulto
						lstr_movimiento_almacen_traspaso_bultos.zona_salida               = ls_zona_origen_bulto
						lstr_movimiento_almacen_traspaso_bultos.fila_salida               = ll_fila_origen_bulto
						lstr_movimiento_almacen_traspaso_bultos.altura_salida             = ll_altura_origen_bulto
						lstr_movimiento_almacen_traspaso_bultos.tercero                   = ""
						lstr_movimiento_almacen_traspaso_bultos.documento                 = ""
						lstr_movimiento_almacen_traspaso_bultos.fecha                     = datetime(today())
						lstr_movimiento_almacen_traspaso_bultos.id_ubicacion_salida       = 0
						lstr_movimiento_almacen_traspaso_bultos.id_alm_bultos		         = ll_alm_bultos_id		
						lstr_movimiento_almacen_traspaso_bultos.tipo_movimiento_entrada   = is_tipo_movimiento_entrada
						lstr_movimiento_almacen_traspaso_bultos.almacen_entrada           = ls_almacen_destino
						lstr_movimiento_almacen_traspaso_bultos.zona_entrada              = ls_zona_destino
						lstr_movimiento_almacen_traspaso_bultos.fila_entrada              = li_fila_destino
						lstr_movimiento_almacen_traspaso_bultos.altura_entrada            = li_altura_destino
						lstr_movimiento_almacen_traspaso_bultos.id_ubicacion_entrada      = 0
						lstr_movimiento_almacen_traspaso_bultos.venliped_anyo             = lstr_venliped.anyo
						lstr_movimiento_almacen_traspaso_bultos.venliped_pedido           = lstr_venliped.pedido
						lstr_movimiento_almacen_traspaso_bultos.venliped_linea            = lstr_venliped.linea
						
						if not(f_movimiento_almacen_traspaso_bultos(lstr_movimiento_almacen_traspaso_bultos)) then
							lb_correcto = false
						end if	
						
						lb_salida_realizada  = true
						lb_entrada_realizada	= true
						
					else						
						if ll_venliped_reservas_cantidad = ll_alm_bultos_lineas_cantidad and ll_alm_bultos_lineas_cantidad = ll_cantidad_bulto and ll_donde_destino > 0 and ll_total = 1 then
							//Traspasamos toda la cantidad del bulto pero tenemos otro bulto con el mismo numero de pallet ya traspasado 
							//y una sola linea de reserva
							lstr_movimiento_almacen.empresa                   = lstr_venliped.empresa
							lstr_movimiento_almacen.articulo                  = lstr_venliped.articulo
							lstr_movimiento_almacen.calidad                   = lstr_venliped.calidad
							lstr_movimiento_almacen.tono                      = lstr_venliped.tonochar
							lstr_movimiento_almacen.calibre                   = lstr_venliped.calibre
							lstr_movimiento_almacen.tipo_pallet               = lstr_venliped.tipo_pallet
							lstr_movimiento_almacen.caja                      = lstr_venliped.caja
							lstr_movimiento_almacen.cantidad                  = -1 * ( ll_venliped_reservas_cantidad )
							lstr_movimiento_almacen.orden_carga_anyo          = 0
							lstr_movimiento_almacen.orden_carga_codigo        = ""
							lstr_movimiento_almacen.orden_carga_linea         = 0
							lstr_movimiento_almacen.tipo_movimiento           = is_tipo_movimiento_salida
							lstr_movimiento_almacen.observaciones             = ""
							lstr_movimiento_almacen.almacen                   = ls_almacen_origen_bulto
							lstr_movimiento_almacen.zona                      = ls_zona_origen_bulto
							lstr_movimiento_almacen.fila                      = ll_fila_origen_bulto
							lstr_movimiento_almacen.altura                    = ll_altura_origen_bulto
							lstr_movimiento_almacen.tercero                   = ""
							lstr_movimiento_almacen.documento                 = ""
							lstr_movimiento_almacen.fecha                     = datetime(today())
							lstr_movimiento_almacen.id_ubicacion              = 0
							lstr_movimiento_almacen.id_alm_bultos		        = ll_alm_bultos_id		
							lstr_movimiento_almacen.venliped_anyo             = lstr_venliped.anyo
							lstr_movimiento_almacen.venliped_pedido           = lstr_venliped.pedido
							lstr_movimiento_almacen.venliped_linea            = lstr_venliped.linea							

							if ll_donde = 23 then
								ll_donde = 23
							end if

							if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
								lb_correcto = false
							else		
								//Vamos a buscar el id del bulto de destino
																
								li_venliped_anyo_destino   = dw_datos.object.anyo[ll_donde_destino]
								ll_venliped_pedido_destino = dw_datos.object.pedido[ll_donde_destino]
								li_venliped_linea_destino  = dw_datos.object.linea[ll_donde_destino]
								
								ll_alm_bultos_id_destino = 0
								
								SELECT isnull(alm_bultos.id,0) 
								into   :ll_alm_bultos_id_destino
								FROM   venliped_reservas, 
										 alm_bultos, 
										 alm_bultos_lineas 
								WHERE ( venliped_reservas.empresa              = alm_bultos_lineas.empresa ) 
								AND	( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) 
								AND	( alm_bultos_lineas.empresa              = alm_bultos.empresa ) 
								AND	( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) 
								AND ( ( venliped_reservas.empresa              = :lstr_venliped.empresa ) 
								AND	( venliped_reservas.anyo                 = :li_venliped_anyo_destino ) 
								AND	( venliped_reservas.pedido               = :ll_venliped_pedido_destino ) 
								AND 	( venliped_reservas.linea                = :li_venliped_linea_destino ) );
								
								lstr_movimiento_almacen.empresa                   = lstr_venliped.empresa
								lstr_movimiento_almacen.articulo                  = lstr_venliped.articulo
								lstr_movimiento_almacen.calidad                   = lstr_venliped.calidad
								lstr_movimiento_almacen.tono                      = lstr_venliped.tonochar
								lstr_movimiento_almacen.calibre                   = lstr_venliped.calibre
								lstr_movimiento_almacen.tipo_pallet               = lstr_venliped.tipo_pallet
								lstr_movimiento_almacen.caja                      = lstr_venliped.caja
								lstr_movimiento_almacen.cantidad                  = ll_venliped_reservas_cantidad
								lstr_movimiento_almacen.orden_carga_anyo          = 0
								lstr_movimiento_almacen.orden_carga_codigo        = ""
								lstr_movimiento_almacen.orden_carga_linea         = 0
								lstr_movimiento_almacen.tipo_movimiento           = is_tipo_movimiento_entrada
								lstr_movimiento_almacen.observaciones             = ""
								lstr_movimiento_almacen.almacen                   = ls_almacen_destino
								lstr_movimiento_almacen.zona                      = ls_zona_destino
								lstr_movimiento_almacen.fila                      = li_fila_destino
								lstr_movimiento_almacen.altura                    = li_altura_destino
								lstr_movimiento_almacen.tercero                   = ""
								lstr_movimiento_almacen.documento                 = ""
								lstr_movimiento_almacen.fecha                     = datetime(today())
								lstr_movimiento_almacen.id_ubicacion              = 0
								lstr_movimiento_almacen.id_alm_bultos		        = ll_alm_bultos_id_destino		
								lstr_movimiento_almacen.venliped_anyo             = lstr_venliped.anyo
								lstr_movimiento_almacen.venliped_pedido           = lstr_venliped.pedido
								lstr_movimiento_almacen.venliped_linea            = lstr_venliped.linea			
								
								if ll_donde = 23 then
									ll_donde = 23
								end if								
								
								if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
									lb_correcto = false
								end if
								
							end if
							
							lb_salida_realizada  = true
							lb_entrada_realizada	= true							
							
						else
							//Solo hacemos la salida
							//Traspasamos una parte del bulto o hay mas de una linea de reservas
							lstr_movimiento_almacen.empresa                   = lstr_venliped.empresa
							lstr_movimiento_almacen.articulo                  = lstr_venliped.articulo
							lstr_movimiento_almacen.calidad                   = lstr_venliped.calidad
							lstr_movimiento_almacen.tono                      = lstr_venliped.tonochar
							lstr_movimiento_almacen.calibre                   = lstr_venliped.calibre
							lstr_movimiento_almacen.tipo_pallet               = lstr_venliped.tipo_pallet
							lstr_movimiento_almacen.caja                      = lstr_venliped.caja
							lstr_movimiento_almacen.cantidad                  = -1 * ( ll_venliped_reservas_cantidad )
							lstr_movimiento_almacen.orden_carga_anyo          = 0
							lstr_movimiento_almacen.orden_carga_codigo        = ""
							lstr_movimiento_almacen.orden_carga_linea         = 0
							lstr_movimiento_almacen.tipo_movimiento           = is_tipo_movimiento_salida
							lstr_movimiento_almacen.observaciones             = ""
							lstr_movimiento_almacen.almacen                   = ls_almacen_origen_bulto
							lstr_movimiento_almacen.zona                      = ls_zona_origen_bulto
							lstr_movimiento_almacen.fila                      = ll_fila_origen_bulto
							lstr_movimiento_almacen.altura                    = ll_altura_origen_bulto
							lstr_movimiento_almacen.tercero                   = ""
							lstr_movimiento_almacen.documento                 = ""
							lstr_movimiento_almacen.fecha                     = datetime(today())
							lstr_movimiento_almacen.id_ubicacion              = 0
							lstr_movimiento_almacen.id_alm_bultos		        = ll_alm_bultos_id		
							lstr_movimiento_almacen.venliped_anyo             = lstr_venliped.anyo
							lstr_movimiento_almacen.venliped_pedido           = lstr_venliped.pedido
							lstr_movimiento_almacen.venliped_linea            = lstr_venliped.linea							


							if ll_donde = 23 then
								ll_donde = 23
							end if
							
							if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
								lb_correcto = false
							end if
							
							lb_salida_realizada  = true						
							
							//Fin de solo hacemos la salida
						end if
					end if
						
				next
										
				if not lb_entrada_realizada then
					//Si solo hemos hecho la salidad
					//Vamos a buscar el id del bulto de destino
					ll_alm_bultos_id_destino = 0
					
					if ll_donde_destino > 0 then
						li_venliped_anyo_destino   = dw_datos.object.anyo[ll_donde_destino]
						ll_venliped_pedido_destino = dw_datos.object.pedido[ll_donde_destino]
						li_venliped_linea_destino  = dw_datos.object.linea[ll_donde_destino]
											
						
						SELECT isnull(alm_bultos.id,0) 
						into   :ll_alm_bultos_id_destino
						FROM   venliped_reservas, 
								 alm_bultos, 
								 alm_bultos_lineas 
						WHERE ( venliped_reservas.empresa              = alm_bultos_lineas.empresa ) 
						AND	( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) 
						AND	( alm_bultos_lineas.empresa              = alm_bultos.empresa ) 
						AND	( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) 
						AND ( ( venliped_reservas.empresa              = :lstr_venliped.empresa ) 
						AND	( venliped_reservas.anyo                 = :li_venliped_anyo_destino ) 
						AND	( venliped_reservas.pedido               = :ll_venliped_pedido_destino ) 
						AND 	( venliped_reservas.linea                = :li_venliped_linea_destino ) );
					end if
					
					//Sumo todas las cantidades de la reserva
					ll_venliped_reservas_cantidad = 0
					
					for ll_indice = 1 to ll_total
						ll_venliped_reservas_cantidad += ds_datos.object.venliped_reservas_cantidad[ll_indice]					
					next
					
					lstr_movimiento_almacen.empresa                   = lstr_venliped.empresa
					lstr_movimiento_almacen.articulo                  = lstr_venliped.articulo
					lstr_movimiento_almacen.calidad                   = lstr_venliped.calidad
					lstr_movimiento_almacen.tono                      = lstr_venliped.tonochar
					lstr_movimiento_almacen.calibre                   = lstr_venliped.calibre
					lstr_movimiento_almacen.tipo_pallet               = lstr_venliped.tipo_pallet
					lstr_movimiento_almacen.caja                      = lstr_venliped.caja
					lstr_movimiento_almacen.cantidad                  = ll_venliped_reservas_cantidad
					lstr_movimiento_almacen.orden_carga_anyo          = 0
					lstr_movimiento_almacen.orden_carga_codigo        = ""
					lstr_movimiento_almacen.orden_carga_linea         = 0
					lstr_movimiento_almacen.tipo_movimiento           = is_tipo_movimiento_entrada
					lstr_movimiento_almacen.observaciones             = ""
					lstr_movimiento_almacen.almacen                   = ls_almacen_destino
					lstr_movimiento_almacen.zona                      = ls_zona_destino
					lstr_movimiento_almacen.fila                      = li_fila_destino
					lstr_movimiento_almacen.altura                    = li_altura_destino
					lstr_movimiento_almacen.tercero                   = ""
					lstr_movimiento_almacen.documento                 = ""
					lstr_movimiento_almacen.fecha                     = datetime(today())
					lstr_movimiento_almacen.id_ubicacion              = 0
					lstr_movimiento_almacen.id_alm_bultos		        = ll_alm_bultos_id_destino		
					lstr_movimiento_almacen.venliped_anyo             = lstr_venliped.anyo
					lstr_movimiento_almacen.venliped_pedido           = lstr_venliped.pedido
					lstr_movimiento_almacen.venliped_linea            = lstr_venliped.linea			
					
					if ll_donde = 23 then
						ll_donde = 23
					end if					
					
					if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
						lb_correcto = false
					end if
				
					lb_entrada_realizada = true
					
					//Si solo hemos hecho la salida
				end if		
				
				destroy ds_datos
				//situacion
			else			
				//Error al leer la linea
			end if
			
			//Hemos hecho la entrada y la salida
			if lb_salida_realizada and lb_entrada_realizada	and lb_correcto then
				update venliped 
				set    venliped.esta_fabricado = 'S',
						 venliped.situacion      = 'P'
				where venliped.empresa = :lstr_venliped.empresa
				and   venliped.anyo    = :lstr_venliped.anyo
				and   venliped.pedido  = :lstr_venliped.pedido
				and   venliped.linea   = :lstr_venliped.linea;							
				
				if sqlca.sqlcode <> 0 then
					lb_correcto = false
				else
					dw_datos.object.situacion[ll_donde] = 'P'
					f_mostrar_bultos_linea(dw_datos,ll_donde)
				end if 
			end if
		end if
		
	loop while ll_donde > 0 and ll_donde < ll_rowcount	
	
end if

SetPointer(oldpointer)

return lb_correcto
end function

public function boolean f_abrir_orden (long arg_row);long   ll_id_alm_orden_carga,ll_rowcount,ll_donde
boolean lb_correcto = true

str_venliped lstr_venliped

pointer oldpointer

oldpointer = SetPointer(HourGlass!)

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]

	ll_rowcount = dw_datos.rowcount()
	
	ll_donde = 0
	
	do
		ll_donde = dw_datos.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and situacion = 'P' ",ll_donde+1,ll_rowcount)
		
		if ll_donde > 0 then
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = dw_datos.object.anyo[ll_donde]
			lstr_venliped.pedido  = dw_datos.object.pedido[ll_donde]
			lstr_venliped.linea   = dw_datos.object.linea[ll_donde]
			
			if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then			
				update venliped 
				set    venliped.situacion      = 'C'
				where venliped.empresa = :lstr_venliped.empresa
				and   venliped.anyo    = :lstr_venliped.anyo
				and   venliped.pedido  = :lstr_venliped.pedido
				and   venliped.linea   = :lstr_venliped.linea;							
				
				if sqlca.sqlcode <> 0 then
					lb_correcto = false
				else
					dw_datos.object.situacion[ll_donde] = 'C'
				end if 
			else			
				lb_correcto = false
			end if
			
		end if
		
	loop while ll_donde > 0 and ll_donde < ll_rowcount	
	
end if

SetPointer(oldpointer)

return lb_correcto
end function

public function boolean f_abrir_linea (long arg_row);long   ll_id_alm_orden_carga,ll_rowcount
boolean lb_correcto = true

str_venliped lstr_venliped

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]

	lstr_venliped.empresa = codigo_empresa
	lstr_venliped.anyo    = dw_datos.object.anyo[arg_row]
	lstr_venliped.pedido  = dw_datos.object.pedido[arg_row]
	lstr_venliped.linea   = dw_datos.object.linea[arg_row]
	
	if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then			
		update venliped 
		set    venliped.situacion      = 'C'
		where venliped.empresa = :lstr_venliped.empresa
		and   venliped.anyo    = :lstr_venliped.anyo
		and   venliped.pedido  = :lstr_venliped.pedido
		and   venliped.linea   = :lstr_venliped.linea;							
		
		if sqlca.sqlcode <> 0 then
			lb_correcto = false
		else
			dw_datos.object.situacion[arg_row] = 'C'
		end if 
	else			
		lb_correcto = false
	end if
				
end if

return lb_correcto
end function

public function boolean f_imprimir_bandas_orden (long arg_row);long    ll_id_alm_orden_carga,ll_rowcount,ll_donde,ll_indice,ll_total,ll_bulto_desde,ll_bulto_hasta,ll_bulto,ll_lineas_banda
string  ls_sel,ls_ean_13
long    ll_alm_bultos_id,ll_bulto_orden_carga,ll_indice_bultos,ll_total_bultos
boolean lb_impresion_cancelada = false

str_venliped lstr_venliped

datastore ds_datos,ds_datos_bultos

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]

	//ld_total = dec(dw_1.Describe("evaluate ('sum(if ( id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+",bulto_desde_orden_carga,0) for all)',1)"))
	
	ll_bulto_hasta = long(dw_datos.Describe("evaluate ('max(if ( id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+",bulto_hasta_orden_carga,0) for all)',1)"))
	ll_bulto_desde = long(dw_datos.Describe("evaluate ('min(if ( id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+",bulto_desde_orden_carga,"+string(ll_bulto_hasta,"##0")+") for all)',1)"))	

	ll_rowcount = dw_datos.rowcount()		

	for ll_bulto = ll_bulto_desde to ll_bulto_hasta
		ll_donde = 0
		ll_donde = dw_datos.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and situacion = 'P' and bulto_desde_orden_carga = "+string(ll_bulto,"##0")+" ",1,ll_rowcount)
		
		if ll_donde = 0 then
			//No estaba preparado
			ll_lineas_banda = dw_impresion_contenido_bulto_sin_prep.retrieve(ll_id_alm_orden_carga,ll_bulto)
			
			if ll_lineas_banda > 0 then
				if ll_indice_bultos <= ll_total_bultos then		
					ls_ean_13 = ds_datos_bultos.object.alm_bultos_ean13[ll_indice_bultos]
					dw_impresion_contenido_bulto_sin_prep.object.alm_bultos_ean13[1] = ls_ean_13
				end if
				
				if ll_indice = 1 then
					f_imprimir_datawindow(dw_impresion_contenido_bulto_sin_prep)
				else
					dw_impresion_contenido_bulto_sin_prep.print(false)
				end if
			end if				
			//No estaba preparado
		else
			lstr_venliped.empresa                 = codigo_empresa
			lstr_venliped.anyo                    = dw_datos.object.anyo[ll_donde]
			lstr_venliped.pedido                  = dw_datos.object.pedido[ll_donde]
			lstr_venliped.linea                   = dw_datos.object.linea[ll_donde]
			lstr_venliped.bulto_desde_orden_carga = dw_datos.object.bulto_desde_orden_carga[ll_donde]
			lstr_venliped.bulto_desde_orden_carga = dw_datos.object.bulto_desde_orden_carga[ll_donde]
			
			ls_sel = "SELECT isnull(alm_bultos.id,0) as alm_bultos_id "+&
						"FROM   venliped_reservas, "+&
						"		  alm_bultos, "+&
						"		  alm_bultos_lineas "+&
						"WHERE ( venliped_reservas.empresa              = alm_bultos_lineas.empresa ) "+&
						"AND	 ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) "+&
						"AND	 ( alm_bultos_lineas.empresa              = alm_bultos.empresa ) "+&
						"AND	 ( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) "+&
						"AND ( ( venliped_reservas.empresa              = '"+lstr_venliped.empresa+"' ) "+&
						"AND	 ( venliped_reservas.anyo                 = "+string(lstr_venliped.anyo,"###0")+" ) "+&
						"AND	 ( venliped_reservas.pedido               = "+string(lstr_venliped.pedido,"######0")+" ) "+&
						"AND 	 ( venliped_reservas.linea                = "+string(lstr_venliped.linea,"###0")+" ) ) "+&
						"GROUP BY isnull(alm_bultos.id,0) "+&
						"ORDER BY isnull(alm_bultos.id,0) "
						
			ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)			
													
			for ll_indice = 1 to ll_total
				ll_alm_bultos_id     = ds_datos.object.alm_bultos_id[ll_indice]
				ll_bulto_orden_carga = lstr_venliped.bulto_desde_orden_carga + (ll_indice -1)
				
				ll_lineas_banda = dw_impresion_contenido_bulto.retrieve(ll_alm_bultos_id,ll_bulto_orden_carga)
				
				if ll_lineas_banda > 0 then
					if ll_bulto = ll_bulto_desde then
						if not(f_imprimir_datawindow(dw_impresion_contenido_bulto)) then
							lb_impresion_cancelada = true
						end if
					else
						if not(lb_impresion_cancelada) then
							dw_impresion_contenido_bulto.print(false)
						end if
					end if
				end if
				
				ll_bulto = ll_bulto_orden_carga
			next			
						
		end if	
		
	next
	
end if

return true
end function

public function boolean f_imprimir_bandas_linea (long arg_row);long   ll_id_alm_orden_carga,ll_rowcount,ll_donde,ll_indice,ll_total,ll_bulto_desde,ll_bulto_hasta,ll_bulto,ll_lineas_banda
string ls_sel
long   ll_alm_bultos_id,ll_bulto_orden_carga

str_venliped lstr_venliped

datastore ds_datos

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]

	ll_bulto_hasta = dw_datos.object.bulto_desde_orden_carga[arg_row]//long(dw_datos.Describe("evaluate ('max(if ( id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+",bulto_hasta_orden_carga,0) for all)',1)"))
	ll_bulto_desde = dw_datos.object.bulto_desde_orden_carga[arg_row]//long(dw_datos.Describe("evaluate ('min(if ( id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+",bulto_desde_orden_carga,"+string(ll_bulto_hasta,"##0")+") for all)',1)"))	

	ll_rowcount = dw_datos.rowcount()		

	for ll_bulto = ll_bulto_desde to ll_bulto_hasta
		ll_donde = 0
		ll_donde = dw_datos.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and situacion = 'P' and bulto_desde_orden_carga = "+string(ll_bulto,"##0")+" ",1,ll_rowcount)
		
		if ll_donde > 0 then
			lstr_venliped.empresa                 = codigo_empresa
			lstr_venliped.anyo                    = dw_datos.object.anyo[ll_donde]
			lstr_venliped.pedido                  = dw_datos.object.pedido[ll_donde]
			lstr_venliped.linea                   = dw_datos.object.linea[ll_donde]
			lstr_venliped.bulto_desde_orden_carga = dw_datos.object.bulto_desde_orden_carga[ll_donde]
			lstr_venliped.bulto_hasta_orden_carga = dw_datos.object.bulto_hasta_orden_carga[ll_donde]
			
			ls_sel = "SELECT isnull(alm_bultos.id,0) as alm_bultos_id "+&
						"FROM   venliped_reservas, "+&
						"		  alm_bultos, "+&
						"		  alm_bultos_lineas "+&
						"WHERE ( venliped_reservas.empresa              = alm_bultos_lineas.empresa ) "+&
						"AND	 ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) "+&
						"AND	 ( alm_bultos_lineas.empresa              = alm_bultos.empresa ) "+&
						"AND	 ( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) "+&
						"AND ( ( venliped_reservas.empresa              = '"+lstr_venliped.empresa+"' ) "+&
						"AND	 ( venliped_reservas.anyo                 = "+string(lstr_venliped.anyo,"###0")+" ) "+&
						"AND	 ( venliped_reservas.pedido               = "+string(lstr_venliped.pedido,"######0")+" ) "+&
						"AND 	 ( venliped_reservas.linea                = "+string(lstr_venliped.linea,"###0")+" ) ) "+&
						"GROUP BY isnull(alm_bultos.id,0) "+&
						"ORDER BY isnull(alm_bultos.id,0) "
						
			ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)			
													
			for ll_indice = 1 to ll_total
				ll_alm_bultos_id     = ds_datos.object.alm_bultos_id[ll_indice]
				ll_bulto_orden_carga = lstr_venliped.bulto_desde_orden_carga + (ll_indice -1)
				
				ll_lineas_banda = dw_impresion_contenido_bulto.retrieve(ll_alm_bultos_id,ll_bulto_orden_carga)
				
				if ll_lineas_banda > 0 then
					if ll_bulto = ll_bulto_desde then
						f_imprimir_datawindow(dw_impresion_contenido_bulto)
					else
						dw_impresion_contenido_bulto.print(false)
					end if
				end if
				
				ll_bulto = ll_bulto_orden_carga
			next			
						
		end if	
		
	next
	
end if

return true
end function

public subroutine f_cargar_lineas_orden_carga_imprimir ();string ls_sel,ls_filtro_orden_preparacion
long   ll_total,ll_row,ll_rows,ll_id_alm_orden_carga
datastore ds_datos

dw_imprimir.reset()

dw_imprimir.setredraw(false)

if dw_datos.rowcount() > 0 then
	
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[1]
	
	if il_orden_preparacion_genero <> 0 then
		ls_filtro_orden_preparacion = " and venliped.id_alm_orden_preparacion = "+string(il_orden_preparacion_genero,"#######0")+" "
		dw_imprimir.modify("t_orden_preparacion.visible = 1")
		dw_imprimir.modify("t_orden_preparacion.text = 'ORDEN DE PREPARACION Nº "+string(il_orden_preparacion_genero,"#######0")+"'")
	else
		ls_filtro_orden_preparacion = ""
		dw_imprimir.modify("t_orden_preparacion.visible = 0")
	end if
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
			  "       convert(dec(16,6), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) * 100 else 0 end ) as porcentaje_pallet_pico, ~n"+&
			  "       venliped.fentrega, ~n"+&
			  "       isnull(ventipolin.gestionar_en_piezas,'') as gestionar_en_piezas, ~n"+&
			  "       convert(dec(10,2),venliped.peso_neto) as peso_neto_kg, ~n"+&
			  "       '' as almacen_destino, ~n"+&
			  "       '' as zona_destino, ~n"+&
			  "       0 as fila_destino, ~n"+&
			  "       0 as altura_destino, ~n"+&
			   " 	 case when venliped.total_cajas <> 0 then  ( select SUM(alm_bultos_lineas.cantidad/cajas.piezascaja) "+&
			  "		 from venliped as venliped2 "+&
			  "		 inner join almartcajas as cajas on venliped2.empresa = cajas.empresa and venliped2.articulo = cajas.articulo and venliped2.caja = cajas.caja, "+&
			  " 		 venliped_reservas, alm_bultos, alm_bultos_lineas "+&
			  "		 WHERE ( venliped2.empresa = venliped_reservas.empresa ) and "+&
      		  " 		 ( venliped2.anyo = venliped_reservas.anyo ) and "+&
      		  " 		 ( venliped2.pedido = venliped_reservas.pedido ) and  "+&
     		  " 		 ( venliped2.linea = venliped_reservas.linea ) and  "+&
    			  " 		 ( venliped_reservas.empresa = alm_bultos_lineas.empresa ) and  "+&
    			  " 		 ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) and  "+&
   			  " 		 ( alm_bultos_lineas.empresa = alm_bultos.empresa ) and  "+&
     		  " 		 ( alm_bultos_lineas.id_alm_bultos = alm_bultos.id ) and  "+&
			  " 		 ( ( venliped2.empresa = venliped.empresa ) AND "+&
         	  " 		 ( venliped2.anyo = venliped.anyo ) AND  "+&
       		  "  	 ( venliped2.pedido = venliped.pedido) and "+&
			 "		 ( venliped2.linea = venliped.linea) ) "+&
        		  "		 ) end - venliped.total_cajas as cajasrest "+&
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
			  ls_filtro_orden_preparacion+&
			  "ORDER BY venped.anyo, ~n"+&
			  "		   venped.pedido, ~n"+& 
			  "		   venliped.linea"
			  		
	ll_rows = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	if ll_rows > 0 then
		dw_imprimir.object.data = ds_datos.object.data
		
		for ll_row = 1 to ll_rows
			f_mostrar_bultos_linea_impresion(dw_imprimir,ll_row)
		next
	end if
	
	destroy ds_datos
end if
dw_imprimir.sort()
dw_imprimir.groupcalc()
dw_imprimir.setredraw(true)
end subroutine

public subroutine f_mostrar_bultos_linea_impresion (datawindow arg_datawindow, long arg_row);string ls_almacen,ls_zona,ls_descripcion_reservas,ls_sel,ls_fila,ls_altura,ls_bulto,ls_cantidad,ls_ubicacion
int    li_anyo,li_linea,li_fila,li_altura
dec    ld_cantidad
long   ll_pedido,ll_bulto,ll_indice,ll_total,ll_id_ubicacion_destino
string ls_almacen_ubicacion_destino,ls_zona_ubicacion_destino
int    li_fila_ubicacion_destino,li_altura_ubicacion_destino

datastore ds_datos

li_anyo   = arg_datawindow.object.anyo[arg_row]
ll_pedido = arg_datawindow.object.pedido[arg_row]
li_linea  = arg_datawindow.object.linea[arg_row]

//if ib_mostrar_ubicacion_original then
	ls_sel = "select almubimapa_codbar.almacen, "+&
				"       almubimapa_codbar.zona, "+&
				"       almubimapa_codbar.fila, "+&
				"       almubimapa_codbar.altura, "+&
				"       isnull(venliped_reservas_ubi_orig.alm_bultos_id,0) as alm_bultos_id, "+&
				"       sum(venliped_reservas_ubi_orig.cantidad) as cantidad, "+&
				"       isnull(venliped_reservas_ubi_orig.anyo,0) as venliped_reservas_anyo, "+&
				"       isnull(venliped_reservas_ubi_orig.pedido,0) as venliped_reservas_pedido, "+&
				"       isnull(venliped_reservas_ubi_orig.linea,0) as venliped_reservas_linea, "+&
				"       isnull(venliped_reservas_ubi_orig.id_ubicacion_destino,0) as id_ubicacion_destino "+&
				"from   venliped_reservas_ubi_orig,almubimapa_codbar "+&
				"where  venliped_reservas_ubi_orig.id_ubicacion_original = almubimapa_codbar.id "+&
				"and    venliped_reservas_ubi_orig.empresa = '"+codigo_empresa+"' "+&
				"and    venliped_reservas_ubi_orig.anyo    = "+string(li_anyo,"###0")+" "+&
				"and    venliped_reservas_ubi_orig.pedido  = "+string(ll_pedido,"######0")+" "+&
				"and    venliped_reservas_ubi_orig.linea   = "+string(li_linea,"###0")+" "+&				
				"group by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         venliped_reservas_ubi_orig.alm_bultos_id, "+&
				"         venliped_reservas_ubi_orig.anyo, "+&
				"         venliped_reservas_ubi_orig.pedido, "+&
				"         venliped_reservas_ubi_orig.linea, "+&
				"         venliped_reservas_ubi_orig.id_ubicacion_destino "+&
				"order by venliped_reservas_ubi_orig.anyo, "+&
				"         venliped_reservas_ubi_orig.pedido, "+&
				"         venliped_reservas_ubi_orig.linea, "+&
				"         almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         venliped_reservas_ubi_orig.alm_bultos_id "	
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
//end if

//if not(ib_mostrar_ubicacion_original) or ll_total = 0 then
if ll_total = 0 then
	ls_sel = "select almubimapa_codbar.almacen, "+&
				"       almubimapa_codbar.zona, "+&
				"       almubimapa_codbar.fila, "+&
				"       almubimapa_codbar.altura, "+&
				"       alm_bultos.id, "+&
				"       sum(venliped_reservas.cantidad) as cantidad, "+&
				"       venliped_reservas.id_ubicacion_original, "+&
				"       isnull(venliped_reservas.id_ubicacion_destino,0) as id_ubicacion_destino "+&
				"from   venliped_reservas,alm_bultos,alm_bultos_lineas,almubimapa_codbar "+&
				"where  venliped_reservas.empresa              = alm_bultos_lineas.empresa "+&
				"and    venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id "+&
				"and    alm_bultos_lineas.id_alm_bultos        = alm_bultos.id "+&
				"and    alm_bultos.id_ubicacion                = almubimapa_codbar.id "+&
				"and    venliped_reservas.empresa = '"+codigo_empresa+"' "+&
				"and    venliped_reservas.anyo    = "+string(li_anyo,"###0")+" "+&
				"and    venliped_reservas.pedido  = "+string(ll_pedido,"######0")+" "+&
				"and    venliped_reservas.linea   = "+string(li_linea,"###0")+" "+&
				"group by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id, "+&
				"         venliped_reservas.id_ubicacion_original, "+&
				"         venliped_reservas.id_ubicacion_destino "+&
				"order by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id, "+&
				"         venliped_reservas.id_ubicacion_original "
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)			
end if

if ll_total > 0 then
	for ll_indice = 1 to ll_total
		ls_almacen  = ds_datos.object.almubimapa_codbar_almacen[ll_indice]
		ls_zona     = ds_datos.object.almubimapa_codbar_zona[ll_indice]
		li_fila     = ds_datos.object.almubimapa_codbar_fila[ll_indice]
		li_altura   = ds_datos.object.almubimapa_codbar_altura[ll_indice]
		ll_bulto    = ds_datos.object.alm_bultos_id[ll_indice]
		ld_cantidad = ds_datos.object.cantidad[ll_indice]
		ll_id_ubicacion_destino = ds_datos.object.id_ubicacion_destino[ll_indice]
						
		if ll_id_ubicacion_destino <> 0 then
			SELECT isnull(almubimapa_codbar.almacen,''), 
					 isnull(almubimapa_codbar.zona,''), 
					 isnull(almubimapa_codbar.fila,0), 
					 isnull(almubimapa_codbar.altura,0) 
			INTO   :ls_almacen_ubicacion_destino, 
					 :ls_zona_ubicacion_destino, 
					 :li_fila_ubicacion_destino, 
					 :li_altura_ubicacion_destino 
			FROM   almubimapa_codbar 
			WHERE  almubimapa_codbar.empresa = :codigo_empresa 
			AND    almubimapa_codbar.id      = :ll_id_ubicacion_destino;
			
			arg_datawindow.object.almacen_destino[arg_row] = ls_almacen_ubicacion_destino
			arg_datawindow.object.zona_destino[arg_row]    = ls_zona_ubicacion_destino
			arg_datawindow.object.fila_destino[arg_row]    = li_fila_ubicacion_destino
			arg_datawindow.object.altura_destino[arg_row]  = li_altura_ubicacion_destino		
		else		
			if arg_datawindow.object.situacion[arg_row] = 'P' and not(ib_mostrar_ubicacion_original) then
				arg_datawindow.object.almacen_destino[arg_row] = ls_almacen
				arg_datawindow.object.zona_destino[arg_row]    = ls_zona
				arg_datawindow.object.fila_destino[arg_row]    = li_fila
				arg_datawindow.object.altura_destino[arg_row]  = li_altura
			end if
		end if
	
	next
end if

destroy ds_datos
end subroutine

public function boolean f_imprimir_bandas_orden_preparacion (long arg_orden_preparacion);long   ll_id_alm_orden_carga,ll_rowcount,ll_donde,ll_indice,ll_total,ll_bulto_desde,ll_bulto_hasta,ll_bulto,ll_lineas_banda
string ls_find,ls_filtro_bultos_ya_impresos,ls_ean_13
long   ll_alm_bultos_id,ll_bulto_orden_carga
string ls_sel
long   ll_total_bultos,ll_indice_bultos
datastore ds_datos_bultos
str_venliped lstr_venliped

datastore ds_datos

if arg_orden_preparacion > 0 then
	
	ll_total  = dw_datos.rowcount()
	ll_indice = 1
	ls_filtro_bultos_ya_impresos = ""
	do
		ls_find = "id_alm_orden_preparacion = "+string(arg_orden_preparacion,"#########0")+ls_filtro_bultos_ya_impresos
		ll_donde = dw_datos.find(ls_find,ll_indice,ll_total)
		
		if ll_donde > 0 then
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = dw_datos.object.anyo[ll_donde]
			lstr_venliped.pedido  = dw_datos.object.pedido[ll_donde]
			lstr_venliped.linea   = dw_datos.object.linea[ll_donde]			
			ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[ll_donde]
			ll_bulto_desde        = dw_datos.object.bulto_desde_orden_carga[ll_donde]
			ll_bulto_hasta        = dw_datos.object.bulto_hasta_orden_carga[ll_donde]
			
			select isnull(venliped.es_pico,'')
			into   :lstr_venliped.es_pico
			from   venliped 
			where  venliped.empresa = :lstr_venliped.empresa
			and    venliped.anyo    = :lstr_venliped.anyo
			and    venliped.pedido  = :lstr_venliped.pedido
			and    venliped.linea   = :lstr_venliped.linea;
			
			if lstr_venliped.es_pico = 'N' then
				ls_sel = "SELECT isnull(alm_bultos.ean13,'') as alm_bultos_ean13 "+&
							"FROM   venliped, "+&
							"       venliped_reservas, "+&
							"		  alm_bultos, "+&
							"		  alm_bultos_lineas "+&
							"WHERE ( venliped.empresa                       = venliped_reservas.empresa ) "+&
							"AND   ( venliped.anyo                          = venliped_reservas.anyo ) "+&
							"AND   ( venliped.pedido                        = venliped_reservas.pedido ) "+&
							"AND   ( venliped.linea                         = venliped_reservas.linea ) "+&
							"AND   ( venliped_reservas.empresa              = alm_bultos_lineas.empresa ) "+&
							"AND	 ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) "+&
							"AND	 ( alm_bultos_lineas.empresa              = alm_bultos.empresa ) "+&
							"AND	 ( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) "+&
							"AND ( ( venliped_reservas.empresa              = '"+lstr_venliped.empresa+"' ) "+&
							"AND	 ( venliped_reservas.anyo                 = "+string(lstr_venliped.anyo,"###0")+" ) "+&
							"AND	 ( venliped_reservas.pedido               = "+string(lstr_venliped.pedido,"######0")+" ) "+&
							"AND 	 ( venliped_reservas.linea                = "+string(lstr_venliped.linea,"###0")+" ) ) "+&
							"GROUP BY isnull(alm_bultos.ean13,'') "+&
							"ORDER BY isnull(alm_bultos.ean13,'') "
							
				ll_total_bultos  = f_cargar_cursor_transaccion(sqlca,ds_datos_bultos,ls_sel)			
				ll_indice_bultos = 0
			else
				ll_total_bultos  = 0
				ll_indice_bultos = 0				
			end if
			
			ls_filtro_bultos_ya_impresos += " and bulto_desde_orden_carga <> "+string(ll_bulto_desde,"###0")
			
			for ll_bulto = ll_bulto_desde to ll_bulto_hasta
				ll_indice_bultos ++
				ll_lineas_banda = dw_impresion_contenido_bulto_sin_prep.retrieve(ll_id_alm_orden_carga,ll_bulto)
				
				if ll_lineas_banda > 0 then
					if ll_indice_bultos <= ll_total_bultos then		
						ls_ean_13 = ds_datos_bultos.object.alm_bultos_ean13[ll_indice_bultos]
						dw_impresion_contenido_bulto_sin_prep.object.alm_bultos_ean13[1] = ls_ean_13
					end if
					
					if ll_indice = 1 then
						f_imprimir_datawindow(dw_impresion_contenido_bulto_sin_prep)
					else
						dw_impresion_contenido_bulto_sin_prep.print(false)
					end if
				end if				
				
			next
			
			ll_indice = ll_donde +1
		end if
	loop while ll_donde >0 and ll_donde < ll_total
	
end if

return true
end function

public function boolean f_imprimir_bandas_orden_2 (long arg_row);long   ll_id_alm_orden_carga,ll_rowcount,ll_donde,ll_indice,ll_total,ll_bulto_desde,ll_bulto_hasta,ll_bulto,ll_lineas_banda
string ls_find,ls_filtro_bultos_ya_impresos,ls_ean_13
long   ll_alm_bultos_id,ll_bulto_orden_carga
string ls_sel
long   ll_total_bultos,ll_indice_bultos
integer li_lineas_bulto,li_banda,li_bandas_bulto,li_lineas_banda = 15,li_row_desde_detalle,li_row_hasta_detalle
boolean lb_impresion_cancelada = false

datastore ds_datos_bultos
str_venliped lstr_venliped

datastore ds_datos

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]
	ll_total  = dw_datos.rowcount()
	ll_indice = 1
	ls_filtro_bultos_ya_impresos = ""
	do
		ls_find = "id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+ls_filtro_bultos_ya_impresos
		ll_donde = dw_datos.find(ls_find,ll_indice,ll_total)
		
		if ll_donde > 0 then
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = dw_datos.object.anyo[ll_donde]
			lstr_venliped.pedido  = dw_datos.object.pedido[ll_donde]
			lstr_venliped.linea   = dw_datos.object.linea[ll_donde]			
			ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[ll_donde]
			ll_bulto_desde        = dw_datos.object.bulto_desde_orden_carga[ll_donde]
			ll_bulto_hasta        = dw_datos.object.bulto_hasta_orden_carga[ll_donde]
			
			select isnull(venliped.es_pico,''),
					 isnull(venliped.situacion,'')
			into   :lstr_venliped.es_pico,
					 :lstr_venliped.situacion 
			from   venliped 
			where  venliped.empresa = :lstr_venliped.empresa
			and    venliped.anyo    = :lstr_venliped.anyo
			and    venliped.pedido  = :lstr_venliped.pedido
			and    venliped.linea   = :lstr_venliped.linea;
			
			if lstr_venliped.es_pico = 'N' or lstr_venliped.situacion = 'P' then
				ls_sel = "SELECT isnull(alm_bultos.ean13,'') as alm_bultos_ean13 "+&
							"FROM   venliped, "+&
							"       venliped_reservas, "+&
							"		  alm_bultos, "+&
							"		  alm_bultos_lineas "+&
							"WHERE ( venliped.empresa                       = venliped_reservas.empresa ) "+&
							"AND   ( venliped.anyo                          = venliped_reservas.anyo ) "+&
							"AND   ( venliped.pedido                        = venliped_reservas.pedido ) "+&
							"AND   ( venliped.linea                         = venliped_reservas.linea ) "+&
							"AND   ( venliped_reservas.empresa              = alm_bultos_lineas.empresa ) "+&
							"AND	 ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) "+&
							"AND	 ( alm_bultos_lineas.empresa              = alm_bultos.empresa ) "+&
							"AND	 ( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) "+&
							"AND ( ( venliped_reservas.empresa              = '"+lstr_venliped.empresa+"' ) "+&
							"AND	 ( venliped_reservas.anyo                 = "+string(lstr_venliped.anyo,"###0")+" ) "+&
							"AND	 ( venliped_reservas.pedido               = "+string(lstr_venliped.pedido,"######0")+" ) "+&
							"AND 	 ( venliped_reservas.linea                = "+string(lstr_venliped.linea,"###0")+" ) ) "+&
							"GROUP BY isnull(alm_bultos.ean13,'') "+&
							"ORDER BY isnull(alm_bultos.ean13,'') "
							
							//clipboard(ls_sel)
							
				ll_total_bultos  = f_cargar_cursor_transaccion(sqlca,ds_datos_bultos,ls_sel)			
				ll_indice_bultos = 0
			else
				ll_total_bultos  = 1
				ll_indice_bultos = 0				
			end if
			
			ls_filtro_bultos_ya_impresos += " and bulto_desde_orden_carga <> "+string(ll_bulto_desde,"###0")
			
			for ll_bulto = ll_bulto_desde to ll_bulto_hasta
				
				SELECT count(*) as lineas
				INTO   :li_lineas_bulto
				FROM   venliped,   
						 articulos,   
						 almartcajas,   
						 formatos,
						 ventipolin  
				WHERE ( venliped.empresa  = articulos.empresa ) 
				AND   ( venliped.articulo = articulos.codigo ) 
				AND   ( venliped.empresa  = almartcajas.empresa ) 
				AND   ( venliped.articulo = almartcajas.articulo ) 
				AND   ( venliped.caja     = almartcajas.caja ) 
				AND   ( articulos.empresa = formatos.empresa ) 
				AND   ( articulos.formato = formatos.codigo ) 
				AND   ( venliped.empresa  = ventipolin.empresa ) 
				AND   ( venliped.tipolinea = ventipolin.codigo ) 
				AND ( ( venliped.empresa  = :codigo_empresa ) 
				AND   ( venliped.id_alm_orden_carga = :ll_id_alm_orden_carga ) 
				AND   ( venliped.bulto_desde_orden_carga <= :ll_bulto and venliped.bulto_hasta_orden_carga >= :ll_bulto ) );				
				
				li_bandas_bulto = Truncate(li_lineas_bulto / li_lineas_banda, 0)
				
				if Mod(li_lineas_bulto,li_lineas_banda) > 0 then li_bandas_bulto ++
				
				ll_indice_bultos ++
				
				li_row_hasta_detalle = 0
				
				for li_banda = 1 to li_bandas_bulto
					//Imprimimos banda a banda por la capacidad limitada de mostrar el contenido
					
					li_row_desde_detalle = li_row_hasta_detalle +1
					li_row_hasta_detalle = li_banda * li_lineas_banda
					
					ll_lineas_banda = dw_impresion_contenido_bulto_sin_prep.retrieve(ll_id_alm_orden_carga,ll_bulto,li_row_desde_detalle,li_row_hasta_detalle)
					
					if ll_lineas_banda > 0 then
						if ll_indice_bultos <= ll_total_bultos then		
							ls_ean_13 = ds_datos_bultos.object.alm_bultos_ean13[ll_indice_bultos]
							dw_impresion_contenido_bulto_sin_prep.object.alm_bultos_ean13[1] = ls_ean_13
						end if
						
						if ll_indice = 1 and li_banda = 1 then
							if not(f_imprimir_datawindow(dw_impresion_contenido_bulto_sin_prep)) then
								lb_impresion_cancelada = true
							end if
						else
							if not(lb_impresion_cancelada) then
								dw_impresion_contenido_bulto_sin_prep.print(false)
							end if
						end if
					end if				
				next				
			next
			
			ll_indice = ll_donde +1
		end if
	loop while ll_donde >0 and ll_donde < ll_total
	
end if

return true
end function

public function boolean f_imprimir_bandas_linea_2 (long arg_row);long   ll_id_alm_orden_carga,ll_rowcount,ll_donde,ll_indice,ll_total,ll_bulto_desde,ll_bulto_hasta,ll_bulto,ll_lineas_banda
string ls_find,ls_filtro_bultos_ya_impresos,ls_ean_13
long   ll_alm_bultos_id,ll_bulto_orden_carga
string ls_sel
long   ll_total_bultos,ll_indice_bultos
integer li_lineas_bulto,li_banda,li_bandas_bulto,li_lineas_banda = 15,li_row_desde_detalle,li_row_hasta_detalle
boolean lb_impresion_cancelada = false

datastore ds_datos_bultos
str_venliped lstr_venliped

datastore ds_datos

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]
	ll_total  = dw_datos.rowcount()
	ll_indice = 1
	ls_filtro_bultos_ya_impresos = ""
	//do
		ls_find = "id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+ls_filtro_bultos_ya_impresos
		ll_donde = arg_row //dw_datos.find(ls_find,ll_indice,ll_total)
		
		if ll_donde > 0 then
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = dw_datos.object.anyo[ll_donde]
			lstr_venliped.pedido  = dw_datos.object.pedido[ll_donde]
			lstr_venliped.linea   = dw_datos.object.linea[ll_donde]			
			ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[ll_donde]
			ll_bulto_desde        = dw_datos.object.bulto_desde_orden_carga[ll_donde]
			ll_bulto_hasta        = dw_datos.object.bulto_hasta_orden_carga[ll_donde]
			
			select isnull(venliped.es_pico,''),
					 isnull(venliped.situacion,'')
			into   :lstr_venliped.es_pico,
					 :lstr_venliped.situacion 
			from   venliped 
			where  venliped.empresa = :lstr_venliped.empresa
			and    venliped.anyo    = :lstr_venliped.anyo
			and    venliped.pedido  = :lstr_venliped.pedido
			and    venliped.linea   = :lstr_venliped.linea;
			
			if lstr_venliped.es_pico = 'N' or lstr_venliped.situacion = 'P' then
				ls_sel = "SELECT isnull(alm_bultos.ean13,'') as alm_bultos_ean13 "+&
							"FROM   venliped, "+&
							"       venliped_reservas, "+&
							"		  alm_bultos, "+&
							"		  alm_bultos_lineas "+&
							"WHERE ( venliped.empresa                       = venliped_reservas.empresa ) "+&
							"AND   ( venliped.anyo                          = venliped_reservas.anyo ) "+&
							"AND   ( venliped.pedido                        = venliped_reservas.pedido ) "+&
							"AND   ( venliped.linea                         = venliped_reservas.linea ) "+&
							"AND   ( venliped_reservas.empresa              = alm_bultos_lineas.empresa ) "+&
							"AND	 ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) "+&
							"AND	 ( alm_bultos_lineas.empresa              = alm_bultos.empresa ) "+&
							"AND	 ( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) "+&
							"AND ( ( venliped_reservas.empresa              = '"+lstr_venliped.empresa+"' ) "+&
							"AND	 ( venliped_reservas.anyo                 = "+string(lstr_venliped.anyo,"###0")+" ) "+&
							"AND	 ( venliped_reservas.pedido               = "+string(lstr_venliped.pedido,"######0")+" ) "+&
							"AND 	 ( venliped_reservas.linea                = "+string(lstr_venliped.linea,"###0")+" ) ) "+&
							"GROUP BY isnull(alm_bultos.ean13,'') "+&
							"ORDER BY isnull(alm_bultos.ean13,'') "
							
							//clipboard(ls_sel)
							
				ll_total_bultos  = f_cargar_cursor_transaccion(sqlca,ds_datos_bultos,ls_sel)			
				ll_indice_bultos = 0
			else
				ll_total_bultos  = 1
				ll_indice_bultos = 0				
			end if
			
			ls_filtro_bultos_ya_impresos += " and bulto_desde_orden_carga <> "+string(ll_bulto_desde,"###0")
			
			for ll_bulto = ll_bulto_desde to ll_bulto_hasta
				
				SELECT count(*) as lineas
				INTO   :li_lineas_bulto
				FROM   venliped,   
						 articulos,   
						 almartcajas,   
						 formatos,
						 ventipolin  
				WHERE ( venliped.empresa  = articulos.empresa ) 
				AND   ( venliped.articulo = articulos.codigo ) 
				AND   ( venliped.empresa  = almartcajas.empresa ) 
				AND   ( venliped.articulo = almartcajas.articulo ) 
				AND   ( venliped.caja     = almartcajas.caja ) 
				AND   ( articulos.empresa = formatos.empresa ) 
				AND   ( articulos.formato = formatos.codigo ) 
				AND   ( venliped.empresa  = ventipolin.empresa ) 
				AND   ( venliped.tipolinea = ventipolin.codigo ) 
				AND ( ( venliped.empresa  = :codigo_empresa ) 
				AND   ( venliped.id_alm_orden_carga = :ll_id_alm_orden_carga ) 
				AND   ( venliped.bulto_desde_orden_carga <= :ll_bulto and venliped.bulto_hasta_orden_carga >= :ll_bulto ) );				
				
				li_bandas_bulto = Truncate(li_lineas_bulto / li_lineas_banda, 0)
				
				if Mod(li_lineas_bulto,li_lineas_banda) > 0 then li_bandas_bulto ++
				
				ll_indice_bultos ++
				
				li_row_hasta_detalle = 0
				
				for li_banda = 1 to li_bandas_bulto
					//Imprimimos banda a banda por la capacidad limitada de mostrar el contenido
					
					li_row_desde_detalle = li_row_hasta_detalle +1
					li_row_hasta_detalle = li_banda * li_lineas_banda
					
					ll_lineas_banda = dw_impresion_contenido_bulto_sin_prep.retrieve(ll_id_alm_orden_carga,ll_bulto,li_row_desde_detalle,li_row_hasta_detalle)
					
					if ll_lineas_banda > 0 then
						if ll_indice_bultos <= ll_total_bultos then		
							ls_ean_13 = ds_datos_bultos.object.alm_bultos_ean13[ll_indice_bultos]
							dw_impresion_contenido_bulto_sin_prep.object.alm_bultos_ean13[1] = ls_ean_13
						end if
						
						if ll_indice = 1 and li_banda = 1 then
							if not(f_imprimir_datawindow(dw_impresion_contenido_bulto_sin_prep)) then
								lb_impresion_cancelada = true
							end if
						else
							if not(lb_impresion_cancelada) then
								dw_impresion_contenido_bulto_sin_prep.print(false)
							end if
						end if
					end if				
				next				
			next
			
			ll_indice = ll_donde +1
		end if
	//loop while ll_donde >0 and ll_donde < ll_total
	
end if

return true
end function

public function boolean f_abrir_y_eliminar_linea (long arg_row);long   ll_id_alm_orden_carga,ll_rowcount
boolean lb_correcto = true

str_venliped lstr_venliped

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]

	lstr_venliped.empresa = codigo_empresa
	lstr_venliped.anyo    = dw_datos.object.anyo[arg_row]
	lstr_venliped.pedido  = dw_datos.object.pedido[arg_row]
	lstr_venliped.linea   = dw_datos.object.linea[arg_row]
	
	if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then			
		update venliped 
		set    venliped.situacion                = 'C',
				 venliped.id_alm_orden_carga       = 0,
				 venliped.ordenacion_orden_carga   = 0,
				 venliped.bulto_desde_orden_carga  = 0,
				 venliped.bulto_hasta_orden_carga  = 0,
				 venliped.id_alm_orden_preparacion = 0 
		where venliped.empresa = :lstr_venliped.empresa
		and   venliped.anyo    = :lstr_venliped.anyo
		and   venliped.pedido  = :lstr_venliped.pedido
		and   venliped.linea   = :lstr_venliped.linea;							
		
		if sqlca.sqlcode <> 0 then
			lb_correcto = false
		else
			delete venliped_reservas 
			where venliped_reservas.empresa = :lstr_venliped.empresa
			and   venliped_reservas.anyo    = :lstr_venliped.anyo
			and   venliped_reservas.pedido  = :lstr_venliped.pedido
			and   venliped_reservas.linea   = :lstr_venliped.linea;							
			
			if sqlca.sqlcode <> 0 then
				lb_correcto = false
			else				
				ib_abriendo_y_eliminando_linea = true
				dw_datos.event itemchanged(arg_row,dw_datos.object.bulto_desde_orden_carga,"0")
				ib_abriendo_y_eliminando_linea = false
				dw_datos.deleterow(arg_row)
				dw_datos.groupcalc()
			end if 
		end if 
	else			
		lb_correcto = false
	end if
				
end if

return lb_correcto
end function

public function boolean f_cerrar_orden_sin_movimientos (long arg_row);long   ll_id_alm_orden_carga,ll_rowcount,ll_donde,ll_indice,ll_total,ll_donde_destino
string ls_almacen_destino,ls_zona_destino,ls_sel
long   ll_alm_bultos_id,ll_alm_bultos_lineas_id
int    li_venliped_anyo_destino,li_venliped_linea_destino			
long   ll_alm_bultos_id_destino,ll_venliped_pedido_destino
dec    ll_venliped_reservas_cantidad,ll_alm_bultos_lineas_cantidad
string ls_almacen_origen_bulto,ls_zona_origen_bulto 
long   ll_fila_origen_bulto,ll_altura_origen_bulto,ll_cantidad_bulto
int    li_fila_destino,li_altura_destino,li_lineas_en_venliped_reservas_ubi_orig
string is_tipo_movimiento_salida = '204',is_tipo_movimiento_entrada = '205',ls_ubicacion_con_bulto_asociado
boolean lb_correcto = true,lb_salida_realizada,lb_entrada_realizada,lb_pasar_a_venliped_reservas_original = true

str_venliped lstr_venliped
str_venliped_reservas lstr_venliped_reservas
str_venliped_reservas_ubi_orig lstr_venliped_reservas_ubi_orig

str_movimiento_almacen_traspaso_bultos lstr_movimiento_almacen_traspaso_bultos
str_movimiento_almacen lstr_movimiento_almacen

datastore ds_datos

pointer oldpointer

oldpointer = SetPointer(HourGlass!)

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]

	ll_rowcount = dw_datos.rowcount()
	
	ll_donde = 0
	
	do
		ll_donde = dw_datos.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and situacion <> 'P' and articulo <> '' and venliped_reservas <> '' ",ll_donde+1,ll_rowcount)
		
		if ll_donde > 0 then
			
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = dw_datos.object.anyo[ll_donde]
			lstr_venliped.pedido  = dw_datos.object.pedido[ll_donde]
			lstr_venliped.linea   = dw_datos.object.linea[ll_donde]
			
			if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then			

				update venliped 
				set    venliped.esta_fabricado = 'S',
						 venliped.situacion      = 'P'
				where venliped.empresa = :lstr_venliped.empresa
				and   venliped.anyo    = :lstr_venliped.anyo
				and   venliped.pedido  = :lstr_venliped.pedido
				and   venliped.linea   = :lstr_venliped.linea;							
				
				if sqlca.sqlcode <> 0 then
					lb_correcto = false
				else
					dw_datos.object.situacion[ll_donde] = 'P'
					f_mostrar_bultos_linea(dw_datos,ll_donde)
				end if 
			end if
		end if
		
	loop while ll_donde > 0 and ll_donde < ll_rowcount	
	
end if

SetPointer(oldpointer)

return lb_correcto
end function

public function boolean f_imprimir_bandas_linea_2_old (long arg_row);long   ll_id_alm_orden_carga,ll_rowcount,ll_donde,ll_indice,ll_total,ll_bulto_desde,ll_bulto_hasta,ll_bulto,ll_lineas_banda
string ls_find,ls_filtro_bultos_ya_impresos,ls_ean_13
long   ll_alm_bultos_id,ll_bulto_orden_carga
string ls_sel
long   ll_total_bultos,ll_indice_bultos
boolean lb_impresion_cancelada = false

datastore ds_datos_bultos
str_venliped lstr_venliped

datastore ds_datos

if arg_row > 0 then
	ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[arg_row]
	ll_total  = dw_datos.rowcount()
	ll_indice = 1
	ls_filtro_bultos_ya_impresos = ""
	//do
		ls_find = "id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+ls_filtro_bultos_ya_impresos
		ll_donde =  arg_row//dw_datos.find(ls_find,ll_indice,ll_total)
		
		if ll_donde > 0 then
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = dw_datos.object.anyo[ll_donde]
			lstr_venliped.pedido  = dw_datos.object.pedido[ll_donde]
			lstr_venliped.linea   = dw_datos.object.linea[ll_donde]			
			ll_id_alm_orden_carga = dw_datos.object.id_alm_orden_carga[ll_donde]
			ll_bulto_desde        = dw_datos.object.bulto_desde_orden_carga[ll_donde]
			ll_bulto_hasta        = dw_datos.object.bulto_hasta_orden_carga[ll_donde]
			
			select isnull(venliped.es_pico,'')
			into   :lstr_venliped.es_pico
			from   venliped 
			where  venliped.empresa = :lstr_venliped.empresa
			and    venliped.anyo    = :lstr_venliped.anyo
			and    venliped.pedido  = :lstr_venliped.pedido
			and    venliped.linea   = :lstr_venliped.linea;
			
			if lstr_venliped.es_pico = 'N' or 1 = 1 then
				ls_sel = "SELECT isnull(alm_bultos.ean13,'') as alm_bultos_ean13 "+&
							"FROM   venliped, "+&
							"       venliped_reservas, "+&
							"		  alm_bultos, "+&
							"		  alm_bultos_lineas "+&
							"WHERE ( venliped.empresa                       = venliped_reservas.empresa ) "+&
							"AND   ( venliped.anyo                          = venliped_reservas.anyo ) "+&
							"AND   ( venliped.pedido                        = venliped_reservas.pedido ) "+&
							"AND   ( venliped.linea                         = venliped_reservas.linea ) "+&
							"AND   ( venliped_reservas.empresa              = alm_bultos_lineas.empresa ) "+&
							"AND	 ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) "+&
							"AND	 ( alm_bultos_lineas.empresa              = alm_bultos.empresa ) "+&
							"AND	 ( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) "+&
							"AND ( ( venliped_reservas.empresa              = '"+lstr_venliped.empresa+"' ) "+&
							"AND	 ( venliped_reservas.anyo                 = "+string(lstr_venliped.anyo,"###0")+" ) "+&
							"AND	 ( venliped_reservas.pedido               = "+string(lstr_venliped.pedido,"######0")+" ) "+&
							"AND 	 ( venliped_reservas.linea                = "+string(lstr_venliped.linea,"###0")+" ) ) "+&
							"GROUP BY isnull(alm_bultos.ean13,'') "+&
							"ORDER BY isnull(alm_bultos.ean13,'') "
							
				ll_total_bultos  = f_cargar_cursor_transaccion(sqlca,ds_datos_bultos,ls_sel)			
				ll_indice_bultos = 0
			else
				ll_total_bultos  = 0
				ll_indice_bultos = 0				
			end if
			
			ls_filtro_bultos_ya_impresos += " and bulto_desde_orden_carga <> "+string(ll_bulto_desde,"###0")
			
			for ll_bulto = ll_bulto_desde to ll_bulto_hasta
				ll_indice_bultos ++
				ll_lineas_banda = dw_impresion_contenido_bulto_sin_prep.retrieve(ll_id_alm_orden_carga,ll_bulto, arg_row, arg_row)
				
				if ll_lineas_banda > 0 then
					if ll_indice_bultos <= ll_total_bultos then		
						ls_ean_13 = ds_datos_bultos.object.alm_bultos_ean13[ll_indice_bultos]
						dw_impresion_contenido_bulto_sin_prep.object.alm_bultos_ean13[1] = ls_ean_13
					end if
					
					if ll_bulto = ll_bulto_desde then
						if not(f_imprimir_datawindow(dw_impresion_contenido_bulto_sin_prep)) then
							lb_impresion_cancelada = true
						end if
					else
						if not(lb_impresion_cancelada) then
							dw_impresion_contenido_bulto_sin_prep.print(false)
						end if
					end if
				end if				
				
			next
			
			ll_indice = ll_donde +1
		end if
	//loop while ll_donde >0 and ll_donde < ll_total
	
end if

return true
end function

on wtc_asigna_bultos_ocs.create
int iCurrent
call super::create
this.st_reservado=create st_reservado
this.pb_grabar_obs=create pb_grabar_obs
this.st_1=create st_1
this.dw_etiquetas_bultos_100=create dw_etiquetas_bultos_100
this.dw_stock=create dw_stock
this.cb_1=create cb_1
this.dw_impresion_contenido_bulto=create dw_impresion_contenido_bulto
this.cbx_mostrar_ubicaciones_originales=create cbx_mostrar_ubicaciones_originales
this.dw_imprimir=create dw_imprimir
this.dw_cabecera_orden_preparacion=create dw_cabecera_orden_preparacion
this.dw_impresion_contenido_bulto_sin_prep=create dw_impresion_contenido_bulto_sin_prep
this.cb_2=create cb_2
this.pb_etiquetas_a_preparar=create pb_etiquetas_a_preparar
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_reservado
this.Control[iCurrent+2]=this.pb_grabar_obs
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_etiquetas_bultos_100
this.Control[iCurrent+5]=this.dw_stock
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_impresion_contenido_bulto
this.Control[iCurrent+8]=this.cbx_mostrar_ubicaciones_originales
this.Control[iCurrent+9]=this.dw_imprimir
this.Control[iCurrent+10]=this.dw_cabecera_orden_preparacion
this.Control[iCurrent+11]=this.dw_impresion_contenido_bulto_sin_prep
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.pb_etiquetas_a_preparar
this.Control[iCurrent+14]=this.cb_3
end on

on wtc_asigna_bultos_ocs.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_reservado)
destroy(this.pb_grabar_obs)
destroy(this.st_1)
destroy(this.dw_etiquetas_bultos_100)
destroy(this.dw_stock)
destroy(this.cb_1)
destroy(this.dw_impresion_contenido_bulto)
destroy(this.cbx_mostrar_ubicaciones_originales)
destroy(this.dw_imprimir)
destroy(this.dw_cabecera_orden_preparacion)
destroy(this.dw_impresion_contenido_bulto_sin_prep)
destroy(this.cb_2)
destroy(this.pb_etiquetas_a_preparar)
destroy(this.cb_3)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_stock.SetTransObject(SQLCA)
dw_impresion_contenido_bulto.SetTransObject(SQLCA)
dw_impresion_contenido_bulto_sin_prep.SetTransObject(SQLCA)
dw_imprimir.SetTransObject(SQLCA)
dw_cabecera_orden_preparacion.SetTransObject(SQLCA)

ib_mostrar_ubicacion_original = cbx_mostrar_ubicaciones_originales.checked

ddlb_campo.event selectionchanged(1)

if nombre_usuario = 'PCOPIA' then
	ib_nueva_gestion_preparacion = true
else
	ib_nueva_gestion_preparacion = false
end if

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

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_asigna_bultos_ocs
integer x = 5463
integer y = 48
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_asigna_bultos_ocs
integer x = 5705
integer y = 48
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_asigna_bultos_ocs
integer x = 5906
integer y = 132
integer taborder = 0
end type

event pb_imprimir::clicked;//u_imprimir u_imp
//u_imp = create u_imprimir
//u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
//u_imp.isTitulo    = parent.title
//u_imp.isSubTitulo = ""
//u_imp.ibLandscape = true
//parent.OpenUserObject(u_imp.report)
//
////Con esto forzamos a que el reporte se ajuste al tamaño del papel
////dw_detalle.Object.DataWindow.Zoom = 100
//
//u_imp.event ue_imprimir(dw_datos)
//
//destroy u_imp

f_cargar_lineas_orden_carga_imprimir()
f_imprimir_datawindow(dw_imprimir)

/*
u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = ""
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

//Con esto forzamos a que el reporte se ajuste al tamaño del papel
//dw_detalle.Object.DataWindow.Zoom = 100

u_imp.event ue_imprimir(dw_imprimir)

destroy u_imp
*/
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_asigna_bultos_ocs
integer x = 6062
integer y = 132
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_asigna_bultos_ocs
integer width = 4210
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_asigna_bultos_ocs
integer x = 5755
integer y = 132
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
	ddlb_campo.SelectItem ( 1 )
	ddlb_campo.event selectionchanged(1)
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

type pb_reset from wt_consultas_padre`pb_reset within wtc_asigna_bultos_ocs
integer x = 6217
integer y = 132
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_asigna_bultos_ocs
integer x = 5605
integer y = 132
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
				cadena_or = " venped.fecha_carga_prevista "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Carga "+ddlb_operador.text+" '"+em_fecha1.text+"' "
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
		case "Orden Carga"
			if cadena_or = '' then
				cadena_or = " alm_orden_carga.id "+ddlb_operador.text+" '"+sle_valor1.text+"' "						
				cadena_or_visible = " Orden Carga "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if			
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

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_asigna_bultos_ocs
integer x = 951
integer taborder = 0
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_asigna_bultos_ocs
integer width = 878
integer height = 1308
integer taborder = 0
integer weight = 700
long textcolor = 24076881
string text = "Orden Carga"
boolean sorted = false
string item[] = {"Orden Carga"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()
lb_lista.multiselect = true

CHOOSE CASE ddlb_campo.text
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
						"where almacenmovimientos.empresa = '"+codigo_empresa+"' and articulos.familia = '2' order by CONVERT(char(60), articulos.descripcion)"
	CASE "Artículo (Código)", "Pedido (Año/Pedido)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
	CASE "Fecha", "Fecha Carga"
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
		
		
	CASE "Reservado + Rotura Stock"
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
	CASE "Orden Carga"				
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")		
		ddlb_operador.text = "="		
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_asigna_bultos_ocs
integer y = 512
integer width = 6501
integer height = 3300
integer taborder = 40
string dataobject = "dw_asigna_bultos_ocs1"
end type

event dw_datos::itemchanged;call super::itemchanged;string ls_resultado,ls_almacen,ls_zona,ls_almacen_cabecera,ls_zona_cabecera
int    li_fila,li_res2,li_altura,li_fila_cabecera,li_altura_cabecera
int    li_pallets,li_bulto_desde,li_bulto_hasta
long   ll_row_ubicar_desde_cabecera,ll_almubimapa_codbar_id,ll_id_alm_orden_carga,ll_bulto_desde_orden_carga,ll_bulto_hasta_orden_carga
long   ll_rowcount,ll_donde
boolean lb_actualizar_linea = false
str_venliped lstr_venliped

if ib_generando_orden_de_preparacion then
	return 2
else
	choose case dwo.name
		case "tipo_pallet_preparacion"
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = this.object.anyo[row]
			lstr_venliped.pedido  = this.object.pedido[row]
			lstr_venliped.linea   = this.object.linea[row]
			
			lstr_venliped.tipo_pallet_preparacion = data
			
			update venliped
			set    venliped.tipo_pallet_preparacion = :lstr_venliped.tipo_pallet_preparacion 
			where  venliped.empresa = :lstr_venliped.empresa 
			and    venliped.anyo    = :lstr_venliped.anyo 
			and    venliped.pedido  = :lstr_venliped.pedido 
			and    venliped.linea   = :lstr_venliped.linea;
			
			if sqlca.sqlcode = 0 then
				commit;	
				
				if not(f_actualizar_linea_venpedido(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea)) then
					rollback;
				else			
					if not(f_actualizar_venpedido(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido)) then
						rollback;
					else
						commit;
						if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then
							this.object.pallets[row] = lstr_venliped.pallets
							this.object.peso_kg[row] = lstr_venliped.peso
						end if
					end if
				end if				
			else
				rollback;
				return 2
			end if
		case "bulto_desde_orden_carga"
			li_pallets     = this.object.pallets[row]
			li_bulto_desde = integer(data)
			li_bulto_hasta = this.object.bulto_hasta_orden_carga[row]
	
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = this.object.anyo[row]
			lstr_venliped.pedido  = this.object.pedido[row]
			lstr_venliped.linea   = this.object.linea[row]
			
			if not(f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped)) then
				return 2
			end if
	
			if li_pallets = 0 then li_pallets = 1
			
			if li_bulto_desde > 0 then			
				li_bulto_hasta = li_bulto_desde + li_pallets - 1						
			else
				li_bulto_hasta = 0
			end if
	
			if lstr_venliped.es_pico = 'S' and li_bulto_desde > 0 then
				ll_donde = this.find("id_alm_orden_carga = "+string(this.object.id_alm_orden_carga[row],"#########0")+" and ( "+string(li_bulto_desde)+" <= bulto_desde_orden_carga and bulto_hasta_orden_carga <= "+string(li_bulto_hasta)+" ) and getrow() <> "+string(row,"#####0")+" and pallets > 0 ",1,rowcount())
				
				if ll_donde = 0 then
					//Debemos indicar que el bulto va sobre un pallet para el recalculo de los pesos
					if this.object.pallets[row] = 0 then
						lstr_venliped.pallets = 1
					end if
					lb_actualizar_linea   = true
				else
					lstr_venliped.pallets = 0
				end if
			else
				if lstr_venliped.es_pico = 'S' and li_bulto_desde = 0 then
					//Debemos indicar que el bulto no va sobre un pallet para el recalculo de los pesos
					if this.object.pallets[row] = 1 then
						lstr_venliped.pallets = 0
					end if
					lb_actualizar_linea   = true
					
					//Vamos a ver si el bulto conserva pallet asignado
					
					ll_donde = this.find("id_alm_orden_carga = "+string(this.object.id_alm_orden_carga[row],"#########0")+" and ( "+string(this.object.bulto_desde_orden_carga[row])+" <= bulto_desde_orden_carga and bulto_hasta_orden_carga <= "+string(this.object.bulto_desde_orden_carga[row])+" ) and getrow() <> "+string(row,"#####0")+" and pallets > 0 ",1,rowcount())
					
					if ll_donde = 0 then
						//No hay pallet asignado para el bulto
						ll_donde = this.find("id_alm_orden_carga = "+string(this.object.id_alm_orden_carga[row],"#########0")+" and ( "+string(this.object.bulto_desde_orden_carga[row])+" <= bulto_desde_orden_carga and bulto_hasta_orden_carga <= "+string(this.object.bulto_desde_orden_carga[row])+" ) and getrow() <> "+string(row,"#####0")+" and pallets = 0 ",1,rowcount())					
						
						if ll_donde > 0 then
							if ib_abriendo_y_eliminando_linea and ll_donde > row then
								ll_donde --
								if ll_donde > 0 then
									post event itemchanged(ll_donde,dwo,string(this.object.bulto_desde_orden_carga[ll_donde]))
								end if
							else
								post event itemchanged(ll_donde,dwo,string(this.object.bulto_desde_orden_carga[ll_donde]))
							end if
						end if
					end if
				else
					lstr_venliped.pallets = li_pallets
				end if
			end if
					
			lstr_venliped.bulto_desde_orden_carga = li_bulto_desde
			lstr_venliped.bulto_hasta_orden_carga = li_bulto_hasta
			
			update venliped
			set    venliped.bulto_desde_orden_carga = :lstr_venliped.bulto_desde_orden_carga,
					 venliped.bulto_hasta_orden_carga = :lstr_venliped.bulto_hasta_orden_carga,
					 venliped.pallets                 = :lstr_venliped.pallets 
			where  venliped.empresa = :lstr_venliped.empresa 
			and    venliped.anyo    = :lstr_venliped.anyo 
			and    venliped.pedido  = :lstr_venliped.pedido 
			and    venliped.linea   = :lstr_venliped.linea;
			
			if sqlca.sqlcode = 0 then
				commit;
				
				if lb_actualizar_linea then
					if not(f_actualizar_linea_venpedido(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea)) then
						rollback;
					else			
						if not(f_actualizar_venpedido(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido)) then
							rollback;
						else
							commit;
							if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then
								this.object.pallets[row] = lstr_venliped.pallets
								this.object.peso_kg[row] = lstr_venliped.peso
							end if
						end if
					end if
				end if
				
				this.object.bulto_hasta_orden_carga[row] = li_bulto_hasta
				
				ll_donde = this.find("id_alm_orden_carga = "+string(this.object.id_alm_orden_carga[row],"#########0")+" and ( "+string(li_bulto_desde)+" <= bulto_desde_orden_carga and bulto_hasta_orden_carga <= "+string(li_bulto_hasta)+" ) and getrow() <> "+string(row,"#####0")+" and altura_destino <> 0 ",1,rowcount())
				
				if ll_donde > 0 then
	
					this.object.almacen_destino[row] = this.object.almacen_destino[ll_donde]
					this.object.zona_destino[row]    = this.object.zona_destino[ll_donde]
					this.object.fila_destino[row]    = this.object.fila_destino[ll_donde]
					this.object.altura_destino[row]  = this.object.altura_destino[ll_donde]
					
				end if			
			else
				rollback;
				return 2
			end if
		case "bulto_hasta_orden_carga"
			li_pallets     = this.object.pallets[row]
			li_bulto_desde = this.object.bulto_desde_orden_carga[row]
			li_bulto_hasta = integer(data)
			
			if li_pallets = 0 then li_pallets = 1
			
			li_bulto_desde = li_bulto_hasta - li_pallets + 1		
			
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = this.object.anyo[row]
			lstr_venliped.pedido  = this.object.pedido[row]
			lstr_venliped.linea   = this.object.linea[row]
			
			lstr_venliped.bulto_desde_orden_carga = li_bulto_desde
			lstr_venliped.bulto_hasta_orden_carga = li_bulto_hasta
			
			update venliped
			set    venliped.bulto_desde_orden_carga = :lstr_venliped.bulto_desde_orden_carga,
					 venliped.bulto_hasta_orden_carga = :lstr_venliped.bulto_hasta_orden_carga 
			where  venliped.empresa = :lstr_venliped.empresa 
			and    venliped.anyo    = :lstr_venliped.anyo 
			and    venliped.pedido  = :lstr_venliped.pedido 
			and    venliped.linea   = :lstr_venliped.linea;
			
			if sqlca.sqlcode = 0 then
				commit;
				this.object.bulto_desde_orden_carga[row] = li_bulto_desde
				
				ll_donde = this.find("id_alm_orden_carga = "+string(this.object.id_alm_orden_carga[row],"#########0")+" and ( "+string(li_bulto_desde)+" <= bulto_desde_orden_carga and bulto_hasta_orden_carga <= "+string(li_bulto_hasta)+" ) and getrow() <> "+string(row,"#####0")+" and altura_destino <> 0 ",1,rowcount())
				
				if ll_donde > 0 then
	
					this.object.almacen_destino[row] = this.object.almacen_destino[ll_donde]
					this.object.zona_destino[row]    = this.object.zona_destino[ll_donde]
					this.object.fila_destino[row]    = this.object.fila_destino[ll_donde]
					this.object.altura_destino[row]  = this.object.altura_destino[ll_donde]
					
				end if			
				
			else
				rollback;
				return 2
			end if		
					
		case "almacen_destino"
				SELECT isnull(almalmacen.descripcion,'')
				into   :ls_resultado
				FROM   almalmacen 
				WHERE  almalmacen.empresa = :codigo_empresa
				and    almalmacen.codigo  = :data;
											
				if sqlca.sqlcode <> 100 then
					//OK
					this.object.zona_destino[Row]   = ''
					this.object.fila_destino[Row]   = 0
					this.object.altura_destino[Row] = 0
				else
					this.object.zona_destino[Row]   = ''
					this.object.fila_destino[Row]   = 0
					this.object.altura_destino[Row] = 0
					return 2			
				end if
				
		case "zona_destino"	
			ls_almacen = this.object.almacen_destino[row]
	
			SELECT isnull(almubizonas.descripcion,'')
			into   :ls_resultado
			FROM   almubizonas 
			WHERE  almubizonas.empresa = :codigo_empresa
			and    almubizonas.almacen = :ls_almacen
			and    almubizonas.zona    = :data;
			
			if sqlca.sqlcode <> 100 then
				//OK
				this.object.fila_destino[Row]   = 0
				this.object.altura_destino[Row] = 0
			else
				this.object.zona[Row]   = ''
				this.object.fila[Row]   = 0
				this.object.altura[Row] = 0
				return 2			
			end if
			
		case "fila_destino"
			ls_almacen = this.object.almacen_destino[row]
			ls_zona    = this.object.zona_destino[row]
			li_fila    = Integer(data)
			
			if li_fila <= 0 then
				this.object.fila_destino[Row] 	= 0
				this.object.altura_destino[Row] = 0
				return 2
			else
				SELECT isnull(almubimapa.fila_hasta,0)
				into   :li_res2
				FROM   almubimapa 
				WHERE  almubimapa.empresa = :codigo_empresa
				and    almubimapa.almacen = :ls_almacen
				and    almubimapa.zona    = :ls_zona
				and    almubimapa.fila_desde <= :li_fila AND almubimapa.fila_hasta >= :li_fila;
				
				if sqlca.sqlcode <> 100 then
					//OK
					this.object.altura_destino[Row] = 0
				else
					this.object.fila_destino[Row]   = 0
					this.object.altura_destino[Row] = 0
					return 2			
				end if
			end if
			
		case "altura_destino"
			ls_almacen = this.object.almacen_destino[row]
			ls_zona    = this.object.zona_destino[row]
			li_fila    = this.object.fila_destino[row]
			li_altura  = Integer(data)
			
			if li_altura <= 0 then
				this.object.altura_destino[Row] = 0
				return 2
			else
				
				SELECT isnull(almubimapa_codbar.id,0) 
				INTO   :ll_almubimapa_codbar_id 
				FROM   almubimapa_codbar
				WHERE  almubimapa_codbar.empresa = :codigo_empresa
				AND    almubimapa_codbar.almacen = :ls_almacen
				AND    almubimapa_codbar.zona    = :ls_zona
				AND    almubimapa_codbar.fila    = :li_fila
				AND    almubimapa_codbar.altura  = :li_altura
				AND    almubimapa_codbar.activo  = 'S';
				
				if ll_almubimapa_codbar_id > 0 then
					//OK				
					//Vamos a updatear la tabla venliped_reservas
					lstr_venliped.empresa = codigo_empresa
					lstr_venliped.anyo    = this.object.anyo[row]
					lstr_venliped.pedido  = this.object.pedido[row]
					lstr_venliped.linea   = this.object.linea[row]
					
					update venliped_reservas
					set    venliped_reservas.id_ubicacion_destino = :ll_almubimapa_codbar_id
					where  venliped_reservas.empresa = :lstr_venliped.empresa 
					and    venliped_reservas.anyo    = :lstr_venliped.anyo 
					and    venliped_reservas.pedido  = :lstr_venliped.pedido 
					and    venliped_reservas.linea   = :lstr_venliped.linea;
					
					if sqlca.sqlcode <> 0 then
						rollback;
						messagebox("Error","Se ha producido un error al actualizar venliped_reservas")
					else
						commit;
					end if
					//, , , , venliped_reservas.alm_bultos_lineas_id, venliped_reservas.cantidad, venliped_reservas.id_ubicacion_original, venliped_reservas.id_ubicacion_destino
					
					ll_id_alm_orden_carga      = this.object.id_alm_orden_carga[row]
					ll_bulto_desde_orden_carga = this.object.bulto_desde_orden_carga[row]
					ll_bulto_hasta_orden_carga = this.object.bulto_hasta_orden_carga[row]
					
					if ll_bulto_desde_orden_carga <> 0 and ll_bulto_hasta_orden_carga <> 0 then
						//Vamos a buscar bultos con el mismo numero que el actual para asignarles la misma ubicacion
						ll_rowcount = this.rowcount()
						
						ll_donde = 0
						
						do
							ll_donde = this.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and ( "+string(ll_bulto_desde_orden_carga)+" <= bulto_desde_orden_carga and bulto_hasta_orden_carga <= "+string(ll_bulto_hasta_orden_carga)+" ) ",ll_donde+1,ll_rowcount)
							
							if ll_donde > 0 and ll_donde <> row then
								this.object.almacen_destino[ll_donde] = this.object.almacen_destino[row]
								this.object.zona_destino[ll_donde]    = this.object.zona_destino[row]
								this.object.fila_destino[ll_donde]    = this.object.fila_destino[row]
								this.object.altura_destino[ll_donde]  = integer(data)
								
								lstr_venliped.empresa = codigo_empresa
								lstr_venliped.anyo    = this.object.anyo[ll_donde]
								lstr_venliped.pedido  = this.object.pedido[ll_donde]
								lstr_venliped.linea   = this.object.linea[ll_donde]
								
								update venliped_reservas
								set    venliped_reservas.id_ubicacion_destino = :ll_almubimapa_codbar_id
								where  venliped_reservas.empresa = :lstr_venliped.empresa 
								and    venliped_reservas.anyo    = :lstr_venliped.anyo 
								and    venliped_reservas.pedido  = :lstr_venliped.pedido 
								and    venliped_reservas.linea   = :lstr_venliped.linea;
								
								if sqlca.sqlcode <> 0 then
									rollback;
									messagebox("Error","Se ha producido un error al actualizar venliped_reservas")
								else
									commit;
								end if							
								
							end if
							
						loop while ll_donde > 0 and ll_donde < ll_rowcount				
					end if				
				else
					this.object.altura_destino[Row] = 0
					return 2			
				end if
			end if
			
		case "almacen_destino_oc"
				SELECT isnull(almalmacen.descripcion,'')
				into   :ls_resultado
				FROM   almalmacen 
				WHERE  almalmacen.empresa = :codigo_empresa
				and    almalmacen.codigo  = :data;
											
				if sqlca.sqlcode <> 100 then
					//OK
					this.object.zona_destino_oc[Row]   = ''
					this.object.fila_destino_oc[Row]   = 0
					this.object.altura_destino_oc[Row] = 0
				else
					this.object.zona_destino_oc[Row]   = ''
					this.object.fila_destino_oc[Row]   = 0
					this.object.altura_destino_oc[Row] = 0
					return 2			
				end if
				
		case "zona_destino_oc"	
			ls_almacen = this.object.almacen_destino_oc[row]
	
			SELECT isnull(almubizonas.descripcion,'')
			into   :ls_resultado
			FROM   almubizonas 
			WHERE  almubizonas.empresa = :codigo_empresa
			and    almubizonas.almacen = :ls_almacen
			and    almubizonas.zona    = :data;
			
			if sqlca.sqlcode <> 100 then
				//OK
				this.object.fila_destino_oc[Row]   = 0
				this.object.altura_destino_oc[Row] = 0
			else
				this.object.zona[Row]   = ''
				this.object.fila[Row]   = 0
				this.object.altura[Row] = 0
				return 2			
			end if
			
		case "fila_destino_oc"
			ls_almacen = this.object.almacen_destino_oc[row]
			ls_zona    = this.object.zona_destino_oc[row]
			li_fila    = Integer(data)
			
			if li_fila <= 0 then
				this.object.fila[Row] 	= 0
				this.object.altura[Row] = 0
				return 2
			else
				SELECT isnull(almubimapa.fila_hasta,0)
				into   :li_res2
				FROM   almubimapa 
				WHERE  almubimapa.empresa = :codigo_empresa
				and    almubimapa.almacen = :ls_almacen
				and    almubimapa.zona    = :ls_zona
				and    almubimapa.fila_desde <= :li_fila AND almubimapa.fila_hasta >= :li_fila;
				
				if sqlca.sqlcode <> 100 then
					//OK
					this.object.altura_destino_oc[Row] = 0
				else
					this.object.fila_destino_oc[Row]   = 0
					this.object.altura_destino_oc[Row] = 0
					return 2			
				end if
			end if
			
		case "altura_destino_oc"
			ls_almacen = this.object.almacen_destino_oc[row]
			ls_zona    = this.object.zona_destino_oc[row]
			li_altura  = Integer(data)
			
			if li_altura <= 0 then
				this.object.altura_destino_oc[Row] = 0
				return 2
			else
				SELECT isnull(almubimapa.altura_hasta,0)
				into   :li_res2
				FROM   almubimapa 
				WHERE  almubimapa.empresa = :codigo_empresa
				and    almubimapa.almacen = :ls_almacen
				and    almubimapa.zona    = :ls_zona
				and    almubimapa.altura_desde <= :li_altura AND almubimapa.altura_hasta >= :li_altura;
				
				if SQLCA.sqlcode <> 100 then
					//OK				
				else
					this.object.altura_destino_oc[Row] = 0
					return 2			
				end if
			end if
	
		case "ubicar_desde_cabecera"
			ll_id_alm_orden_carga = this.object.id_alm_orden_carga[row]
			ll_row_ubicar_desde_cabecera = this.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga),1,this.rowcount())
			
			if ll_row_ubicar_desde_cabecera > 0 then
				ls_almacen_cabecera = this.object.almacen_destino_oc[ll_row_ubicar_desde_cabecera]
				ls_zona_cabecera    = this.object.zona_destino_oc[ll_row_ubicar_desde_cabecera]
				li_fila_cabecera    = this.object.fila_destino_oc[ll_row_ubicar_desde_cabecera]
				li_altura_cabecera  = this.object.altura_destino_oc[ll_row_ubicar_desde_cabecera]
				
				SELECT isnull(almubimapa_codbar.id,0) 
				INTO   :ll_almubimapa_codbar_id 
				FROM   almubimapa_codbar
				WHERE  almubimapa_codbar.empresa = :codigo_empresa
				AND    almubimapa_codbar.almacen = :ls_almacen_cabecera
				AND    almubimapa_codbar.zona    = :ls_zona_cabecera
				AND    almubimapa_codbar.fila    = :li_fila_cabecera
				AND    almubimapa_codbar.altura  = :li_altura_cabecera
				AND    almubimapa_codbar.activo  = 'S';
				
				if ll_almubimapa_codbar_id > 0 then
					/*Esto lo haremos desde el boton de validar la ubicacion de cabecera
					this.object.almacen_destino[row] = ls_almacen_cabecera
					this.object.zona_destino[row]    = ls_zona_cabecera
					this.object.fila_destino[row]    = li_fila_cabecera
					this.object.altura_destino[row]  = li_altura_cabecera
					  
					lstr_venliped.empresa = codigo_empresa
					lstr_venliped.anyo    = this.object.anyo[row]
					lstr_venliped.pedido  = this.object.pedido[row]
					lstr_venliped.linea   = this.object.linea[row]
					
					update venliped_reservas
					set    venliped_reservas.id_ubicacion_destino = :ll_almubimapa_codbar_id
					where  venliped_reservas.empresa = :lstr_venliped.empresa 
					and    venliped_reservas.anyo    = :lstr_venliped.anyo 
					and    venliped_reservas.pedido  = :lstr_venliped.pedido 
					and    venliped_reservas.linea   = :lstr_venliped.linea;
					
					if sqlca.sqlcode <> 0 then
						rollback;
						messagebox("Error","Se ha producido un error al actualizar venliped_reservas")
					else
						commit;
					end if								  
					*/
					
					ll_bulto_desde_orden_carga = this.object.bulto_desde_orden_carga[row]
					ll_bulto_hasta_orden_carga = this.object.bulto_hasta_orden_carga[row]
					
					if ll_bulto_desde_orden_carga <> 0 and ll_bulto_hasta_orden_carga <> 0 then
						//Vamos a buscar bultos con el mismo numero que el actual para asignarles la misma ubicacion
						ll_rowcount = this.rowcount()
						
						ll_donde = 0
						
						do
							ll_donde = this.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and ( "+string(ll_bulto_desde_orden_carga)+" <= bulto_desde_orden_carga and bulto_hasta_orden_carga <= "+string(ll_bulto_hasta_orden_carga)+" ) ",ll_donde+1,ll_rowcount)
							
							if ll_donde > 0 and ll_donde <> row then
								this.object.ubicar_desde_cabecera[ll_donde] = data	
								/*Lanzar el itemchanged desde aqui falla 	
								if this.event itemchanged(ll_donde,this.object.ubicar_desde_cabecera,data) = 0 then														
								end if
								*/
							end if
							
						loop while ll_donde > 0 and ll_donde < ll_rowcount				
					end if				
				else
					messagebox("Datos Incorrectos","La ubicación seleccionada no existe en el mapa de almacén")
					return 2
				end if
	
			end if
	end choose
end if

//if dwo.name = "activo" then
//	pb_grabar_obs.visible = true
//	this.SetItemStatus(row, 0, Primary!, DataModified!)
//end if
end event

event dw_datos::clicked;call super::clicked;string ls_articulo,ls_calidad,ls_tono,ls_unidad,ls_tipo_pallet,ls_caja,ls_formato,ls_sel,ls_find,ls_objeto_y_row,ls_max_bulto_oc
int    li_calibre,li_anyo,li_linea
long   ll_indice,ll_pedido,ll_donde,ll_total_reservas,ll_alm_bultos_lineas_id,ll_row,ll_id_alm_orden_carga,ll_max_bulto_oc,ll_rowcount
dec    ld_stock,ld_metroscaja
long   ll_row_ubicar_desde_cabecera,ll_almubimapa_codbar_id,ll_bulto_desde_orden_carga,ll_bulto_hasta_orden_carga,ll_total_stock
string ls_almacen_cabecera,ls_zona_cabecera,ls_gestionar_en_piezas,ls_tipo_pallet_linea_preparada
int    li_fila_cabecera,li_altura_cabecera,li_piezascaja
boolean lb_ya_existe_orden_preparacion = false 
str_venliped lstr_venliped
datastore ds_datos

if ib_generando_orden_de_preparacion and dwo.name <> 'b_generar_orden_de_peparacion' then
	//Todo el proceso de marcado de la orden de preparacion
	if row > 0 then
		if this.IsSelected(row) then
			this.selectrow(row,false)
		else
			if dw_cabecera_orden_preparacion.rowcount() = 0 then
				this.selectrow(row,true)
				il_orden_preparacion_genero = this.object.id_alm_orden_preparacion[row]
				if dw_cabecera_orden_preparacion.retrieve(il_orden_preparacion_genero) = 0 then
					dw_cabecera_orden_preparacion.insertrow(1)

					//dw_cabecera_orden_preparacion.object.id[1]                =  
					dw_cabecera_orden_preparacion.object.empresa[1]           = codigo_empresa 
					dw_cabecera_orden_preparacion.object.fecha_alta[1]        = datetime(today(),now())
					dw_cabecera_orden_preparacion.object.usuario[1]           = nombre_usuario
					dw_cabecera_orden_preparacion.object.observaciones[1]     = ""
					dw_cabecera_orden_preparacion.object.id_maquina[1]        = 0
					dw_cabecera_orden_preparacion.object.id_operario[1]       = 0
					dw_cabecera_orden_preparacion.object.en_proceso[1]        = "N"
					dw_cabecera_orden_preparacion.object.en_proceso_inicio[1] = datetime(date("01-01-1900"))
					dw_cabecera_orden_preparacion.object.en_proceso_fin[1]    = datetime(date("01-01-1900"))
				else
					lb_ya_existe_orden_preparacion = true
					//Es una orden que ya existe
					//Busco todas las lineas que la componen
					ll_donde = 1
					ll_rowcount = this.rowcount()
					do
							
						ll_donde = dw_datos.find("id_alm_orden_preparacion = "+string(il_orden_preparacion_genero),ll_donde,ll_rowcount)
						
						if ll_donde > 0 then
							dw_datos.selectrow(ll_donde,true)
							ll_donde ++
						end if
						
					loop while ll_donde > 0 and ll_donde <= ll_rowcount		
															
				end if
			else
				if il_orden_preparacion_genero = this.object.id_alm_orden_preparacion[row] or this.object.id_alm_orden_preparacion[row] = 0 then
					this.selectrow(row,true)	
				else
					this.selectrow(row,false)
				end if
			end if
			
			//Si he marcado voy a comprobar si debo marcar el resto de lineas del bulto
			if this.IsSelected(row) and not(lb_ya_existe_orden_preparacion) then
				//Vamos a marcar todas las lineas del mismo bulto
				ll_id_alm_orden_carga      = this.object.id_alm_orden_carga[row]
				ll_bulto_desde_orden_carga = this.object.bulto_desde_orden_carga[row]
				ll_bulto_hasta_orden_carga = this.object.bulto_hasta_orden_carga[row]
				
				if ll_bulto_desde_orden_carga <> 0 and ll_bulto_hasta_orden_carga <> 0 then
					//Vamos a buscar bultos con el mismo numero que el actual para asignarles la misma orden de preparación
					ll_rowcount = this.rowcount()
					
					ll_donde = 0
					
					do
						ll_donde = this.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and id_alm_orden_preparacion = 0 and ( "+string(ll_bulto_desde_orden_carga)+" <= bulto_desde_orden_carga and bulto_hasta_orden_carga <= "+string(ll_bulto_hasta_orden_carga)+" ) ",ll_donde+1,ll_rowcount)
						
						if ll_donde > 0 and ll_donde <> row then
							this.selectrow(ll_donde,true)
							ll_donde ++
							/*Lanzar el itemchanged desde aqui falla 	
							if this.event itemchanged(ll_donde,this.object.ubicar_desde_cabecera,data) = 0 then														
							end if
							*/
						end if
						
					loop while ll_donde > 0 and ll_donde < ll_rowcount				
				end if									
			end if
			
		end if
	end if
	
	//Cuantas lineas hay marcadas para activar o desactivar el boton de borrar
	long ll_indice_dw_datos
	
	dw_cabecera_orden_preparacion.modify("b_borrar.visible = 0")
	
	for ll_indice_dw_datos = 1 to dw_datos.rowcount()
		if dw_datos.IsSelected(ll_indice_dw_datos) then
			dw_cabecera_orden_preparacion.modify("b_borrar.visible = 1")
		end if
	next						

else
	
	choose case dwo.name
		case 'b_generar_orden_de_peparacion'
			if ib_generando_orden_de_preparacion then
				dw_cabecera_orden_preparacion.visible = false
				this.modify("b_generar_orden_de_peparacion.text='Generar Orden Preparación'")
				this.modify("datawindow.footer.height = 92")			
				this.selectrow(0,false)
				il_orden_preparacion_genero = 0
				dw_cabecera_orden_preparacion.reset()
			else			
				this.modify("b_generar_orden_de_peparacion.text='Ocultar Orden Preparación'")
				this.modify("datawindow.footer.height = 616") //850
				dw_cabecera_orden_preparacion.visible = true
				this.selectrow(0,false)
			end if
			
			ib_generando_orden_de_preparacion = not(ib_generando_orden_de_preparacion)
		case 'venliped_reservas'
			this.selectrow(0,false)
			this.setrow(row)
			this.selectrow(row,true)
			
			if this.object.situacion[row] <> 'P' then
				this.enabled = false
				
				li_anyo        = this.object.anyo[row]
				ll_pedido      = this.object.pedido[row]
				li_linea       = this.object.linea[row]
				ls_articulo    = this.object.articulo[row]
				ls_calidad     = this.object.calidad[row]
				ls_tono        = this.object.tono[row]
				li_calibre     = this.object.calibre[row]
				ls_unidad      = this.object.unidad[row]
				ls_tipo_pallet = this.object.tipo_pallet[row]
				ls_caja        = this.object.caja[row]
				ls_formato     = this.object.formato[row]
				ls_gestionar_en_piezas = this.object.gestionar_en_piezas[row]
				
				select isnull(almartcajas.piezascaja,0),
						 isnull(almartcajas.metroscaja,0) 
				into   :li_piezascaja,
						 :ld_metroscaja
				from   almartcajas
				where  almartcajas.empresa  = :codigo_empresa
				and    almartcajas.articulo = :ls_articulo
				and    almartcajas.caja     = :ls_caja;
				
				ls_sel = "select venliped_reservas.alm_bultos_lineas_id, "+&
							"       venliped_reservas.cantidad "+&
							"from   venliped_reservas "+&
							"where  venliped_reservas.empresa = '"+codigo_empresa+"' "+&
							"and    venliped_reservas.anyo    = "+string(li_anyo,"###0")+" "+&
							"and    venliped_reservas.pedido  = "+string(ll_pedido,"######0")+" "+&
							"and    venliped_reservas.linea   = "+string(li_linea,"###0")+" "+&
							"order by venliped_reservas.alm_bultos_lineas_id "
				
				ls_sel = "select almubimapa_codbar.almacen, "+&
							"       almubimapa_codbar.zona, "+&
							"       almubimapa_codbar.fila, "+&
							"       almubimapa_codbar.altura, "+&
							"       isnull(alm_bultos.id,0) as alm_bultos_id, "+&
							"       isnull(venliped_reservas.alm_bultos_lineas_id,0) as alm_bultos_lineas_id, "+&
							"       sum(venliped_reservas.cantidad) as cantidad, "+&
							"       isnull(venliped_reservas.id_ubicacion_destino,0) as id_ubicacion_destino "+&
							"from   venliped_reservas,alm_bultos,alm_bultos_lineas,almubimapa_codbar "+&
							"where  venliped_reservas.empresa              = alm_bultos_lineas.empresa "+&
							"and    venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id "+&
							"and    alm_bultos_lineas.id_alm_bultos        = alm_bultos.id "+&
							"and    alm_bultos.id_ubicacion                = almubimapa_codbar.id "+&
							"and    venliped_reservas.empresa = '"+codigo_empresa+"' "+&
							"and    venliped_reservas.anyo    = "+string(li_anyo,"###0")+" "+&
							"and    venliped_reservas.pedido  = "+string(ll_pedido,"######0")+" "+&
							"and    venliped_reservas.linea   = "+string(li_linea,"###0")+" "+&
							"group by almubimapa_codbar.almacen, "+&
							"         almubimapa_codbar.zona, "+&
							"         almubimapa_codbar.fila, "+&
							"         almubimapa_codbar.altura, "+&
							"         alm_bultos.id, "+&
							"         venliped_reservas.alm_bultos_lineas_id, "+&
							"         venliped_reservas.anyo, "+&
							"         venliped_reservas.pedido, "+&
							"         venliped_reservas.linea, "+&
							"         venliped_reservas.id_ubicacion_destino "+&
							"order by venliped_reservas.anyo, "+&
							"         venliped_reservas.pedido, "+&
							"         venliped_reservas.linea, "+&
							"         almubimapa_codbar.almacen, "+&
							"         almubimapa_codbar.zona, "+&
							"         almubimapa_codbar.fila, "+&
							"         almubimapa_codbar.altura, "+&
							"         alm_bultos.id "				
				
				ll_total_reservas = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
				
				dw_stock.setfilter("")
				dw_stock.filter()
				
				ll_total_stock = dw_stock.retrieve(codigo_empresa,ls_articulo,ls_calidad,ls_tono,li_calibre,ls_unidad,ls_tipo_pallet,ls_caja,ls_formato,li_anyo,ll_pedido,li_linea)
				
				if ll_total_stock = 0 and ll_total_reservas > 0 then
					ll_alm_bultos_lineas_id = ds_datos.object.alm_bultos_lineas_id[1]
					
					SELECT isnull(alm_bultos.tipo_pallet,'')
					INTO   :ls_tipo_pallet_linea_preparada 
					FROM   alm_bultos,   
					       alm_bultos_lineas  
					WHERE ( alm_bultos.id        = alm_bultos_lineas.id_alm_bultos ) 
					and ( ( alm_bultos_lineas.id = :ll_alm_bultos_lineas_id ) )   
					GROUP BY alm_bultos.tipo_pallet;
															
					ll_total_stock = dw_stock.retrieve(codigo_empresa,ls_articulo,ls_calidad,ls_tono,li_calibre,ls_unidad,ls_tipo_pallet_linea_preparada,ls_caja,ls_formato,li_anyo,ll_pedido,li_linea)
				end if
				
				if ll_total_stock > 0 then
					ld_stock = 0
					for ll_indice = 1 To dw_stock.rowcount()
						ll_alm_bultos_lineas_id = dw_stock.object.alm_bultos_lineas_id[ll_indice]
						
						ls_find = "alm_bultos_lineas_id = "+string(ll_alm_bultos_lineas_id,"#########0")
						
						ll_donde = ds_datos.find(ls_find,1,ll_total_reservas)
						
						if ll_donde > 0 then
							if ls_unidad = '1' and li_piezascaja <> 0 then
								dw_stock.object.cantidad[ll_indice]     = ( ds_datos.object.cantidad[ll_donde] / li_piezascaja ) * ld_metroscaja
							else
								dw_stock.object.cantidad[ll_indice]     = ds_datos.object.cantidad[ll_donde]
							end if
							dw_stock.object.seleccionada[ll_indice] = 1
							
							ds_datos.deleterow(ll_donde)
							ll_total_reservas --
						end if
						
						ld_stock += dw_stock.object.existencias[ll_indice]
					next
					
					if ll_total_reservas > 0 then
						//Añadimos lineas reservadas
						for ll_indice = 1 To ll_total_reservas
							ll_alm_bultos_lineas_id = ds_datos.object.alm_bultos_lineas_id[ll_indice]
							dw_stock.insertrow(ll_indice)
							
							dw_stock.object.almacenmovimientos_empresa[ll_indice]                     = codigo_empresa
							dw_stock.object.almacen[ll_indice]                                        = ds_datos.object.almubimapa_codbar_almacen[ll_indice]
							dw_stock.object.zona[ll_indice]                                           = ds_datos.object.almubimapa_codbar_zona[ll_indice]
							dw_stock.object.fila[ll_indice]                                           = ds_datos.object.almubimapa_codbar_fila[ll_indice]
							dw_stock.object.altura[ll_indice]                                         = ds_datos.object.almubimapa_codbar_altura[ll_indice]
							dw_stock.object.articulo[ll_indice]                                       = ls_articulo
							dw_stock.object.articulos_descripcion[ll_indice]                          = f_nombre_articulo(codigo_empresa,ls_articulo)
							dw_stock.object.almacenmovimientos_calidad[ll_indice]                     = ls_calidad
							dw_stock.object.calidades_abreviado[ll_indice]                            = f_nombre_calidad_abr(codigo_empresa,ls_calidad)
							dw_stock.object.calibre[ll_indice]                                        = li_calibre							
							dw_stock.object.tono[ll_indice]                                           = ls_tono
							dw_stock.object.existencias[ll_indice]                                    = 0
							dw_stock.object.seleccionada[ll_indice]                                   = 1
							if ls_unidad = '1' and li_piezascaja <> 0 then
								dw_stock.object.cantidad[ll_indice]     = ( ds_datos.object.cantidad[ll_indice] / li_piezascaja ) * ld_metroscaja
							else
								dw_stock.object.cantidad[ll_indice]     = ds_datos.object.cantidad[ll_indice]
							end if
							dw_stock.object.existencias[ll_indice]                                    = dw_stock.object.cantidad[ll_indice]
							dw_stock.object.almacenmovimientos_observaciones_observaciones[ll_indice] = ""
							dw_stock.object.articulos_unidad[ll_indice]                               = ls_unidad
							dw_stock.object.unidades_abreviado[ll_indice]                             = f_nombre_unidad_abr(ls_unidad)
							dw_stock.object.almacenmovimientos_caja[ll_indice]                        = ls_caja
							dw_stock.object.almcajas_descripcion_abr[ll_indice]                       = f_nombre_caja_abr(codigo_empresa,ls_caja)
							dw_stock.object.almartcajas_metroscaja[ll_indice]                         = ld_metroscaja
							dw_stock.object.almartcajas_piezascaja[ll_indice]                         = li_piezascaja
							dw_stock.object.articulos_decimales_unidad[ll_indice]                     = f_decimales_unidad(ls_unidad)
							dw_stock.object.almacenmovimientos_tipo_pallet[ll_indice]                 = ls_tipo_pallet
							dw_stock.object.almacenmovimientos_formato[ll_indice]                     = ls_formato
							dw_stock.object.formatos_formato_abreviado[ll_indice]                     = f_nombre_formato_abr(codigo_empresa,ls_formato)
							dw_stock.object.pallets_pallet_abreviado[ll_indice]                       = f_nombre_pallet_abr(codigo_empresa,ls_tipo_pallet)
							dw_stock.object.alm_bultos_id[ll_indice]                                  = ds_datos.object.alm_bultos_id[ll_indice]
							dw_stock.object.alm_bultos_lineas_id[ll_indice]                           = ll_alm_bultos_lineas_id
							dw_stock.object.clasificacion_abc_ubicacion[ll_indice]                    = ""
							dw_stock.object.clasificacion_abc_articulo[ll_indice]                     = ""							
							dw_stock.object.alm_bultos_id_ubicacion[ll_indice]                        = 0 
							dw_stock.object.gestionar_en_piezas[ll_indice]                            = ls_gestionar_en_piezas		
							
							dw_stock.groupcalc()
							ld_stock += dw_stock.object.existencias[ll_indice]
						next						
					end if
					
					if ld_stock >= this.object.cantidad[row] then
						dw_stock.visible = true
						//dw_stock.setfilter (" existencias_unidad <> 0 or (gestionar_en_piezas = '"+ls_gestionar_en_piezas+"' or seleccionada = 1)")
						if f_unidad_articulo(codigo_empresa,ls_articulo) = '1' then
							dw_stock.setfilter ("( existencias_unidad > 0 and gestionar_en_piezas = '"+ls_gestionar_en_piezas+"' ) or ( seleccionada = 1 )")							
						else
							dw_stock.setfilter ("( existencias_unidad > 0 ) or ( seleccionada = 1 )")
						end if
						dw_stock.filter()
					else
						MessageBox("Atención", "No ha stock del artículo seleccionado")
						this.enabled = true
					end if
				else
					if ll_total_reservas > 0 then
						//Añadimos lineas reservadas
						for ll_indice = 1 To ll_total_reservas
							ll_alm_bultos_lineas_id = ds_datos.object.alm_bultos_lineas_id[ll_indice]
							dw_stock.insertrow(ll_indice)
							
							dw_stock.object.almacenmovimientos_empresa[ll_indice]                     = codigo_empresa
							dw_stock.object.almacen[ll_indice]                                        = ds_datos.object.almubimapa_codbar_almacen[ll_indice]
							dw_stock.object.zona[ll_indice]                                           = ds_datos.object.almubimapa_codbar_zona[ll_indice]
							dw_stock.object.fila[ll_indice]                                           = ds_datos.object.almubimapa_codbar_fila[ll_indice]
							dw_stock.object.altura[ll_indice]                                         = ds_datos.object.almubimapa_codbar_altura[ll_indice]
							dw_stock.object.articulo[ll_indice]                                       = ls_articulo
							dw_stock.object.articulos_descripcion[ll_indice]                          = f_nombre_articulo(codigo_empresa,ls_articulo)
							dw_stock.object.almacenmovimientos_calidad[ll_indice]                     = ls_calidad
							dw_stock.object.calidades_abreviado[ll_indice]                            = f_nombre_calidad_abr(codigo_empresa,ls_calidad)
							dw_stock.object.calibre[ll_indice]                                        = li_calibre							
							dw_stock.object.tono[ll_indice]                                           = ls_tono
							dw_stock.object.existencias[ll_indice]                                    = 0
							dw_stock.object.seleccionada[ll_indice]                                   = 1
							if ls_unidad = '1' and li_piezascaja <> 0 then
								dw_stock.object.cantidad[ll_indice]     = ( ds_datos.object.cantidad[ll_indice] / li_piezascaja ) * ld_metroscaja
							else
								dw_stock.object.cantidad[ll_indice]     = ds_datos.object.cantidad[ll_indice]
							end if
							dw_stock.object.existencias[ll_indice]                                    = dw_stock.object.cantidad[ll_indice]
							dw_stock.object.almacenmovimientos_observaciones_observaciones[ll_indice] = ""
							dw_stock.object.articulos_unidad[ll_indice]                               = ls_unidad
							dw_stock.object.unidades_abreviado[ll_indice]                             = f_nombre_unidad_abr(ls_unidad)
							dw_stock.object.almacenmovimientos_caja[ll_indice]                        = ls_caja
							dw_stock.object.almcajas_descripcion_abr[ll_indice]                       = f_nombre_caja_abr(codigo_empresa,ls_caja)
							dw_stock.object.almartcajas_metroscaja[ll_indice]                         = ld_metroscaja
							dw_stock.object.almartcajas_piezascaja[ll_indice]                         = li_piezascaja
							dw_stock.object.articulos_decimales_unidad[ll_indice]                     = f_decimales_unidad(ls_unidad)
							dw_stock.object.almacenmovimientos_tipo_pallet[ll_indice]                 = ls_tipo_pallet
							dw_stock.object.almacenmovimientos_formato[ll_indice]                     = ls_formato
							dw_stock.object.formatos_formato_abreviado[ll_indice]                     = f_nombre_formato_abr(codigo_empresa,ls_formato)
							dw_stock.object.pallets_pallet_abreviado[ll_indice]                       = f_nombre_pallet_abr(codigo_empresa,ls_tipo_pallet)
							dw_stock.object.alm_bultos_id[ll_indice]                                  = ds_datos.object.alm_bultos_id[ll_indice]
							dw_stock.object.alm_bultos_lineas_id[ll_indice]                           = ll_alm_bultos_lineas_id
							dw_stock.object.clasificacion_abc_ubicacion[ll_indice]                    = ""
							dw_stock.object.clasificacion_abc_articulo[ll_indice]                     = ""							
							dw_stock.object.alm_bultos_id_ubicacion[ll_indice]                        = 0 
							dw_stock.object.gestionar_en_piezas[ll_indice]                            = ls_gestionar_en_piezas		
							
							dw_stock.groupcalc()
						next
						
						dw_stock.visible = true
					else
						MessageBox("Atención", "No ha stock del artículo seleccionado")
						this.enabled = true
					end if
				end if
			end if	
		case 'c_renumerar_oc'
			accepttext()
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then
				ll_rowcount = this.rowcount()
				
				ll_id_alm_orden_carga = this.object.id_alm_orden_carga[ll_row]
				
				//ll_max_bulto_oc = long(this.modify())
				ls_max_bulto_oc = this.describe("evaluate('max( if(id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" , bulto_hasta_orden_carga , 0 ) for all )',1)")
				ll_max_bulto_oc = long(ls_max_bulto_oc)
				
				ll_donde = 0
				
				do
					ll_donde = this.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" and bulto_desde_orden_carga = 0 and pallets > 0 ",ll_donde+1,ll_rowcount)
					
					if ll_donde > 0 then
						ll_max_bulto_oc ++
						this.object.bulto_desde_orden_carga[ll_donde] = ll_max_bulto_oc
						
						this.event itemchanged(ll_donde,this.object.bulto_desde_orden_carga,string(this.object.bulto_desde_orden_carga[ll_donde]))
						
						ll_max_bulto_oc = this.object.bulto_hasta_orden_carga[ll_donde]
					end if
					
				loop while ll_donde > 0 and ll_donde < ll_rowcount
			end if
	
		case 'c_ubicar_oc'
			accepttext()
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then
				ll_rowcount = this.rowcount()
				
				ll_id_alm_orden_carga = this.object.id_alm_orden_carga[ll_row]
				
				//ll_max_bulto_oc = long(this.modify())
				ls_max_bulto_oc = this.describe("evaluate('max( if(id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" , bulto_hasta_orden_carga , 0 ) for all )',1)")
				ll_max_bulto_oc = long(ls_max_bulto_oc)
				
				ll_donde = 0
				
				do
					ll_donde = this.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" ",ll_donde+1,ll_rowcount)
					
					if ll_donde > 0 then
						if this.object.id_alm_orden_carga_en_edicion[ll_donde] = 0 then
							this.object.id_alm_orden_carga_en_edicion[ll_donde] = ll_id_alm_orden_carga
							this.object.ubicar_desde_cabecera[ll_donde]         = 'N'
						else
							this.object.id_alm_orden_carga_en_edicion[ll_donde] = 0
							this.object.ubicar_desde_cabecera[ll_donde]         = 'N'
						end if
					end if
					
				loop while ll_donde > 0 and ll_donde < ll_rowcount
			end if
	
		case 'p_validar_ubicar'
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then
				ll_id_alm_orden_carga        = this.object.id_alm_orden_carga[ll_row]
				ll_row_ubicar_desde_cabecera = this.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga),1,this.rowcount())
				
				if ll_row_ubicar_desde_cabecera > 0 then
					ls_almacen_cabecera = this.object.almacen_destino_oc[ll_row_ubicar_desde_cabecera]
					ls_zona_cabecera    = this.object.zona_destino_oc[ll_row_ubicar_desde_cabecera]
					li_fila_cabecera    = this.object.fila_destino_oc[ll_row_ubicar_desde_cabecera]
					li_altura_cabecera  = this.object.altura_destino_oc[ll_row_ubicar_desde_cabecera]
					
					SELECT isnull(almubimapa_codbar.id,0) 
					INTO   :ll_almubimapa_codbar_id 
					FROM   almubimapa_codbar
					WHERE  almubimapa_codbar.empresa = :codigo_empresa
					AND    almubimapa_codbar.almacen = :ls_almacen_cabecera
					AND    almubimapa_codbar.zona    = :ls_zona_cabecera
					AND    almubimapa_codbar.fila    = :li_fila_cabecera
					AND    almubimapa_codbar.altura  = :li_altura_cabecera
					AND    almubimapa_codbar.activo  = 'S';
					
					if ll_almubimapa_codbar_id > 0 then			
						ll_rowcount = this.rowcount()						
									
						ll_donde = 0
						
						do
							ll_donde = this.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" ",ll_donde+1,ll_rowcount)
							
							if ll_donde > 0 then
								if this.object.ubicar_desde_cabecera[ll_donde] = 'S' then
									this.object.almacen_destino[ll_donde] = ls_almacen_cabecera
									this.object.zona_destino[ll_donde]    = ls_zona_cabecera
									this.object.fila_destino[ll_donde]    = li_fila_cabecera
									this.object.altura_destino[ll_donde]  = li_altura_cabecera							
									
									lstr_venliped.empresa = codigo_empresa
									lstr_venliped.anyo    = this.object.anyo[ll_donde]
									lstr_venliped.pedido  = this.object.pedido[ll_donde]
									lstr_venliped.linea   = this.object.linea[ll_donde]
									
									update venliped_reservas
									set    venliped_reservas.id_ubicacion_destino = :ll_almubimapa_codbar_id
									where  venliped_reservas.empresa = :lstr_venliped.empresa 
									and    venliped_reservas.anyo    = :lstr_venliped.anyo 
									and    venliped_reservas.pedido  = :lstr_venliped.pedido 
									and    venliped_reservas.linea   = :lstr_venliped.linea;
									
									if sqlca.sqlcode <> 0 then
										rollback;
										messagebox("Error","Se ha producido un error al actualizar venliped_reservas")
									else
										commit;
									end if								  								
																									
									this.object.ubicar_desde_cabecera[ll_donde] = 'N'
								end if							
								
								this.object.id_alm_orden_carga_en_edicion[ll_donde] = 0
								
							end if
							
						loop while ll_donde > 0 and ll_donde < ll_rowcount
						
						this.object.almacen_destino_oc[ll_row_ubicar_desde_cabecera] = ""
						this.object.zona_destino_oc[ll_row_ubicar_desde_cabecera]    = ""
						this.object.fila_destino_oc[ll_row_ubicar_desde_cabecera]    = 0
						this.object.altura_destino_oc[ll_row_ubicar_desde_cabecera]	 = 0		
					else
						messagebox("Datos Incorrectos","La ubicación seleccionada no existe en el mapa de almacén")
					end if
				else
					//No encuentra row de cabecera
				end if
			end if				
		case 'p_cancelar_ubicar'
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then
				ll_rowcount = this.rowcount()
				
				ll_id_alm_orden_carga = this.object.id_alm_orden_carga[ll_row]
							
				ll_donde = 0
				
				do
					ll_donde = this.find("id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" ",ll_donde+1,ll_rowcount)
					
					if ll_donde > 0 then
						this.object.id_alm_orden_carga_en_edicion[ll_donde] = 0
						this.object.ubicar_desde_cabecera[ll_donde]         = 'N'
					end if
					
				loop while ll_donde > 0 and ll_donde < ll_rowcount
			end if		
		case 'p_abrir_oc'
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then		
				if messagebox("Confirmación","¿Desea abrir la orden?",Question!,YesNo!,1) = 1 then
					if f_abrir_orden(ll_row) then
						commit;
					else
						rollback;
					end if
				end if
			end if		
		case 'p_cerrar_oc'
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then		
				if messagebox("Confirmación","¿Desea cerrar la orden?",Question!,YesNo!,1) = 1 then
					if not(ib_nueva_gestion_preparacion) then 
						if f_cerrar_orden(ll_row) then
							commit;
						else
							rollback;
						end if
					else
						if f_cerrar_orden_sin_movimientos(ll_row) then
							commit;
						else
							rollback;
						end if						
					end if
				end if
			end if
		case 'p_abrir_linea'
			if messagebox("Confirmación","¿Desea abrir la linea?",Question!,YesNo!,1) = 1 then
				if f_abrir_linea(row) then
					commit;
				else
					rollback;
				end if
			end if
		case 'p_abrir_y_eliminar_linea'
			if messagebox("Confirmación","¿Desea abrir y eliminar la linea?",Question!,YesNo!,1) = 1 then
				if f_abrir_y_eliminar_linea(row) then
					commit;
				else
					rollback;
				end if
			end if			
		case 'p_imprimir_bandas'
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then		
				if messagebox("Confirmación","¿Desea imprimir las bandas de la orden?",Question!,YesNo!,1) = 1 then
					if f_imprimir_bandas_orden_2(ll_row) then
	
					end if
				end if
			end if	
		case 'p_imprimir_banda_bulto'
			if messagebox("Confirmación","¿Desea imprimir las bandas de la linea?",Question!,YesNo!,1) = 1 then
				if f_imprimir_bandas_linea_2(row) then
		
				end if
			end if	
			
		case 'p_igual'
			if row > 0 then
				if this.object.bulto_desde_orden_carga[row] = 0 then
					ll_id_alm_orden_carga = this.object.id_alm_orden_carga[row]
					ls_max_bulto_oc = this.describe("evaluate('max( if(id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" , bulto_hasta_orden_carga , 0 ) for all )',1)")
					ll_max_bulto_oc = long(ls_max_bulto_oc)			
															
					if this.event itemchanged(row,this.object.bulto_desde_orden_carga,string(ll_max_bulto_oc)) = 0 then
						this.object.bulto_desde_orden_carga[row] = ll_max_bulto_oc	
					end if
				end if
			end if						
		case 'p_mas'
			if row > 0 then
				if this.object.bulto_desde_orden_carga[row] = 0 then
					ll_id_alm_orden_carga = this.object.id_alm_orden_carga[row]
					ls_max_bulto_oc = this.describe("evaluate('max( if(id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" , bulto_hasta_orden_carga , 0 ) for all )',1)")
					ll_max_bulto_oc = long(ls_max_bulto_oc)			
					
					ll_max_bulto_oc ++
															
					if this.event itemchanged(row,this.object.bulto_desde_orden_carga,string(ll_max_bulto_oc)) = 0 then
						this.object.bulto_desde_orden_carga[row] = ll_max_bulto_oc	
					end if
				end if
			end if
		case 'p_menos'
			if row > 0 then
				if this.object.bulto_desde_orden_carga[row] <> 0 then										
					
					if this.event itemchanged(row,this.object.bulto_desde_orden_carga,string(0)) = 0 then
						this.object.bulto_desde_orden_carga[row] = 0
					end if
				end if
			end if			
	end choose
end if
end event

event dw_datos::rbuttondown;call super::rbuttondown;string ls_height,ls_autosize_height
mi_marcar_desmarcar lmi_marcar_desmarcar
mi_mismo_bulto_resto_picos lmi_mismo_bulto_resto_picos
mi_asignar_desasignar_bultos lmi_asignar_desasignar_bultos

if not(ib_generando_orden_de_preparacion) then
	if dwo.name = 'ubicar_desde_cabecera' then
		is_campo_a_modificar = ""
		il_id_orden_carga    = 0
		il_row_he_pulsado    = row
		
		lmi_marcar_desmarcar = create mi_marcar_desmarcar
		mi_marcar_desmarcar.PopMenu(Parent.PointerX(),Parent.PointerY())
		
		destroy(mi_marcar_desmarcar)
	end if
	
	if dwo.name = 'bultos_t' then
		is_campo_a_modificar = ""
		il_id_orden_carga    = 0
		il_row_he_pulsado    = row
		
		lmi_asignar_desasignar_bultos = create mi_asignar_desasignar_bultos
		mi_asignar_desasignar_bultos.PopMenu(Parent.PointerX(),Parent.PointerY())
		
		destroy(mi_asignar_desasignar_bultos)
	end if	
	
	if dwo.name = 'bulto_desde_orden_carga' or dwo.name = 'bulto_hasta_orden_carga' then
		if this.object.bulto_desde_orden_carga[row] > 0 then
			il_row_he_pulsado    = row
			
			lmi_mismo_bulto_resto_picos = create mi_mismo_bulto_resto_picos
			mi_mismo_bulto_resto_picos.PopMenu(Parent.PointerX(),Parent.PointerY())
			
			destroy(mi_mismo_bulto_resto_picos)			
		end if
	end if
	
	if dwo.name = 'venliped_reservas' then
		
		ls_height = this.describe("venliped_reservas["+string(row)+"].height")
		ls_autosize_height = this.describe("venliped_reservas.height.autosize")
		
		if ls_autosize_height = 'yes' then
			this.modify("venliped_reservas.height.autosize = 'no'")
		else
			this.modify("venliped_reservas.height.autosize = 'yes'")
		end if
		
	end if	
	
end if
end event

event dw_datos::usr_dwnkey;call super::usr_dwnkey;/*
string ls_max_bulto_oc
long   ll_id_alm_orden_carga,ll_max_bulto_oc

if not(ib_generando_orden_de_preparacion) then
	choose case key
		case KeyAdd!
			if this.getrow() > 0 then
				if this.object.bulto_desde_orden_carga[this.getrow()] = 0 then
					ll_id_alm_orden_carga = this.object.id_alm_orden_carga[this.getrow()]
					ls_max_bulto_oc = this.describe("evaluate('max( if(id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" , bulto_hasta_orden_carga , 0 ) for all )',1)")
					ll_max_bulto_oc = long(ls_max_bulto_oc)			
					
					ll_max_bulto_oc ++
					
					this.object.bulto_desde_orden_carga[this.getrow()] = ll_max_bulto_oc
					
					this.event itemchanged(this.getrow(),this.object.bulto_desde_orden_carga,string(this.object.bulto_desde_orden_carga[this.getrow()]))
				end if
			end if
			//messagebox("Key","KeyAdd!")
			
		case KeyEqual!
			//messagebox("Key","KeyEqual!")
			
		case Key0!
			if keyflags = 1 then
				if this.getrow() > 0 then
					if this.object.bulto_desde_orden_carga[this.getrow()] = 0 then
						ll_id_alm_orden_carga = this.object.id_alm_orden_carga[this.getrow()]
						ls_max_bulto_oc = this.describe("evaluate('max( if(id_alm_orden_carga = "+string(ll_id_alm_orden_carga,"#########0")+" , bulto_hasta_orden_carga , 0 ) for all )',1)")
						ll_max_bulto_oc = long(ls_max_bulto_oc)			
						
						this.object.bulto_desde_orden_carga[this.getrow()] = ll_max_bulto_oc
						
						this.event itemchanged(this.getrow(),this.object.bulto_desde_orden_carga,string(this.object.bulto_desde_orden_carga[this.getrow()]))					
					end if
				end if			
				//messagebox("keyflags = 1","KeyEqual!")
				
			else
				//messagebox("Key","Key0!")
				
			end if
		case else
			//messagebox("Key",string(key))
			
	end choose
end if	
*/

end event

event dw_datos::rowfocuschanged;//No hacemos lo que hace el padre
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_asigna_bultos_ocs
integer x = 6373
integer y = 132
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_asigna_bultos_ocs
end type

type p_logo from wt_consultas_padre`p_logo within wtc_asigna_bultos_ocs
integer x = 6002
integer y = 36
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_asigna_bultos_ocs
integer x = 46
integer width = 3675
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_asigna_bultos_ocs
integer x = 2871
integer y = 132
integer taborder = 150
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_asigna_bultos_ocs
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 10
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_asigna_bultos_ocs
integer x = 1307
integer height = 96
integer taborder = 160
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_asigna_bultos_ocs
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_asigna_bultos_ocs
integer x = 1312
integer y = 132
integer width = 462
integer height = 356
integer taborder = 140
long textcolor = 24076881
end type

type st_reservado from statictext within wtc_asigna_bultos_ocs
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

type pb_grabar_obs from picturebutton within wtc_asigna_bultos_ocs
boolean visible = false
integer x = 5367
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

type st_1 from statictext within wtc_asigna_bultos_ocs
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

type dw_etiquetas_bultos_100 from datawindow within wtc_asigna_bultos_ocs
boolean visible = false
integer x = 3671
integer y = 20
integer width = 983
integer height = 168
integer taborder = 41
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiquetas_bultos_ubicaciones_100x60"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_stock from datawindow within wtc_asigna_bultos_ocs
boolean visible = false
integer x = 55
integer y = 1284
integer width = 3136
integer height = 1688
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "Asignar Bultos"
string dataobject = "dw_asigna_bultos_ocs2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;int  li_anyo,li_linea
long ll_pedido,ll_indice,ll_total,ll_alm_bultos_lineas_id,row_dw_datos,ll_id_ubicacion_original,ll_id_ubicacion_destino
dec  ld_cantidad_total,ld_cantidad_pedido,ld_cantidad_falta,ld_cantidad
boolean lb_correcto = true
string  ls_gestionar_en_piezas
string  ls_almacen_destino,ls_zona_destino
int     li_fila_destino,li_altura_destino
		
//this.accepttext()

if not isnull(dwo.name) then
	row_dw_datos = dw_datos.getrow()
	
	choose case dwo.name
			
	case "seleccionar_automatico"
		string ls_articulo,ls_tipo_pallet,ls_caja,ls_unidad
		string ls_clasificacion_abc_ubicacion,ls_clasificacion_abc_articulo 
		int    li_cajas_pallet,li_piezascaja,li_decimales_unidad 
		dec    ld_metroscaja,ld_cantidad_pallet 
		long   ll_rowcount,ll_donde
		
		ib_asignando_en_automatico = true
		
		ls_articulo            = dw_datos.object.articulo[row_dw_datos] 
		ls_tipo_pallet         = dw_datos.object.tipo_pallet[row_dw_datos] 
		ls_caja                = dw_datos.object.caja[row_dw_datos] 
		ls_unidad              = dw_datos.object.unidad[row_dw_datos] 
		li_decimales_unidad    = dw_datos.object.decimales_unidad[row_dw_datos] 
		ld_cantidad_pedido     = dw_datos.object.cantidad[row_dw_datos] 
		ls_gestionar_en_piezas = dw_datos.object.gestionar_en_piezas[row_dw_datos] 
		
		ls_clasificacion_abc_ubicacion = this.object.clasificacion_abc_ubicacion[1]
		ls_clasificacion_abc_articulo  = this.object.clasificacion_abc_articulo[1]
		 
		SELECT isnull(palarticulo.cajaspallet,0),
				 isnull(almartcajas.piezascaja,0),
				 isnull(almartcajas.metroscaja,0) 
		INTO   :li_cajas_pallet,
				 :li_piezascaja,
				 :ld_metroscaja 
		FROM   palarticulo,
			    almartcajas
		WHERE  palarticulo.empresa  = almartcajas.empresa
		AND    palarticulo.articulo = almartcajas.articulo
		AND	 palarticulo.caja     = almartcajas.caja
		AND    palarticulo.empresa  = :codigo_empresa 
		AND    palarticulo.articulo = :ls_articulo
		AND    palarticulo.codigo   = :ls_tipo_pallet
		AND    palarticulo.caja     = :ls_caja;				 		
		 
		if ls_unidad = "1" then
			ld_cantidad_pallet = li_cajas_pallet * ld_metroscaja
		else
			ld_cantidad_pallet = li_cajas_pallet * li_piezascaja
		end if
		
		ll_rowcount = this.rowcount()
		//Primero voy a desmarcar las lineas que esten marcadas
		ll_donde = 0
		do
			ll_donde = this.find("seleccionada = 1 ",ll_donde+1,ll_rowcount)
			
			if ll_donde > 0 then
				if this.event itemchanged(ll_donde,this.object.seleccionada,'0') = 0 then
					this.object.seleccionada[ll_donde] = 0
				end if
			end if
			
		loop while ll_donde > 0 and ll_donde < ll_rowcount						
		//
		
		if ld_cantidad_pedido < ld_cantidad_pallet then
			//Estamos asignando un pico
			//Empezamos marcando pallets enteros
			ll_donde = 0
			do
				ll_donde = this.find("seleccionada = 0 ",ll_donde+1,ll_rowcount)
				
				if ll_donde > 0 then
					if round(this.object.existencias_unidad[ll_donde],li_decimales_unidad) = ld_cantidad_pedido then
						if this.event itemchanged(ll_donde,this.object.seleccionada,'1') = 0 then
							this.object.seleccionada[ll_donde] = 1
						end if
					end if
				end if
				
			loop while ll_donde > 0 and ll_donde < ll_rowcount														
			
			//Vamos marcando las lineas de menos stock a mas por si no hemos marcado todo el stock que necesitamos
			ll_donde = 0
			do
				ll_donde = this.find("seleccionada = 0 ",ll_donde+1,ll_rowcount)
				
				if ll_donde > 0 then
					if this.event itemchanged(ll_donde,this.object.seleccionada,'1') = 0 then
						this.object.seleccionada[ll_donde] = 1
					end if
				end if
				
			loop while ll_donde > 0 and ll_donde < ll_rowcount											

		else
			//Empezamos marcando pallets enteros
			ll_donde = 0
			do
				ll_donde = this.find("seleccionada = 0 ",ll_donde+1,ll_rowcount)
				
				if ll_donde > 0 then
					if round(this.object.existencias_unidad[ll_donde],li_decimales_unidad) = ld_cantidad_pallet then
						if this.event itemchanged(ll_donde,this.object.seleccionada,'1') = 0 then
							this.object.seleccionada[ll_donde] = 1
						end if
					end if
				end if
				
			loop while ll_donde > 0 and ll_donde < ll_rowcount														
			
			//Vamos marcando las lineas de menos stock a mas por si no hemos marcado todo el stock que necesitamos
			ll_donde = 0
			do
				ll_donde = this.find("seleccionada = 0 ",ll_donde+1,ll_rowcount)
				
				if ll_donde > 0 then
					if this.event itemchanged(ll_donde,this.object.seleccionada,'1') = 0 then
						this.object.seleccionada[ll_donde] = 1
					end if
				end if
				
			loop while ll_donde > 0 and ll_donde < ll_rowcount											
			
			if ld_cantidad_pedido = ld_cantidad_pallet then
				//Estamos asignando un pallet
				//Vamos a empezar buscando pallets que esten fuera de su clasificacion
			else
				//Estamos asignando mas de un pallet
				//Vamos a empezar buscando pallets que esten fuera de su clasificacion
			end if			
		end if
		
		ib_asignando_en_automatico = false
		/* Asi se hacia antes:
		ll_total = this.rowcount()
		
		for ll_indice = 1 to ll_total
			if this.object.seleccionada[ll_indice] = 0 then
				this.event clicked(0,0,ll_indice,this.object.seleccionada)
				
				if this.object.cantidad[ll_indice] > 0 then
					this.object.seleccionada[ll_indice] = 1
				end if
			end if
		next			
		*/
	case "b_cerrar"
		this.visible = false
		this.reset()
		
		f_mostrar_bultos_linea(dw_datos,row_dw_datos)
		dw_datos.enabled = true

	case "b_ok"
		//VALIDACIÓN ********************************************************************		
		this.accepttext()
		
		li_anyo   = dw_datos.object.anyo[row_dw_datos]
		ll_pedido = dw_datos.object.pedido[row_dw_datos]
		li_linea  = dw_datos.object.linea[row_dw_datos]
		ls_almacen_destino = dw_datos.object.almacen_destino[row_dw_datos]
		ls_zona_destino    = dw_datos.object.zona_destino[row_dw_datos]
		li_fila_destino    = dw_datos.object.fila_destino[row_dw_datos]
		li_altura_destino  = dw_datos.object.altura_destino[row_dw_datos]
				
		SELECT isnull(almubimapa_codbar.id,0) 
		INTO   :ll_id_ubicacion_destino 
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :codigo_empresa
		AND    almubimapa_codbar.almacen = :ls_almacen_destino
		AND    almubimapa_codbar.zona    = :ls_zona_destino
		AND    almubimapa_codbar.fila    = :li_fila_destino
		AND    almubimapa_codbar.altura  = :li_altura_destino
		AND    almubimapa_codbar.activo  = 'S';				
		
		ld_cantidad_total = 0

		update venliped 
		set    venliped.esta_fabricado = 'S'
		where  venliped.empresa = :codigo_empresa 
		and    venliped.anyo    = :li_anyo 
		and    venliped.pedido  = :ll_pedido 
		and    venliped.linea   = :li_linea;
		
		if sqlca.sqlcode <> 0 then
			MessageBox("Error", sqlca.sqlerrtext)
			lb_correcto = false
		end if
		
		delete venliped_reservas
		where  venliped_reservas.empresa = :codigo_empresa 
		and    venliped_reservas.anyo    = :li_anyo 
		and    venliped_reservas.pedido  = :ll_pedido 
		and    venliped_reservas.linea   = :li_linea;
		
		if sqlca.sqlcode <> 0 then
			MessageBox("Error", sqlca.sqlerrtext)
			lb_correcto = false
		end if		
		
		For ll_indice = 1 To this.rowcount()
			if this.object.seleccionada[ll_indice] = 1 then
				if this.object.cantidad[ll_indice] > 0 then 
					ld_cantidad_total = ld_cantidad_total + this.object.cantidad[ll_indice]			
					
					ll_alm_bultos_lineas_id  = this.object.alm_bultos_lineas_id[ll_indice]
					ll_id_ubicacion_original = this.object.alm_bultos_id_ubicacion[ll_indice]
					
					if this.object.articulos_unidad[ll_indice] = "1" and this.object.almartcajas_metroscaja[ll_indice] <> 0 and dw_datos.object.gestionar_en_piezas[row_dw_datos] = "N" then
						ld_cantidad = int(this.object.cantidad[ll_indice] / this.object.almartcajas_metroscaja[ll_indice]) * this.object.almartcajas_piezascaja[ll_indice]
					else
						ld_cantidad = this.object.cantidad[ll_indice]
					end if					
					
					insert into venliped_reservas
						(venliped_reservas.empresa,
						 venliped_reservas.anyo,
						 venliped_reservas.pedido,
						 venliped_reservas.linea,
						 venliped_reservas.alm_bultos_lineas_id,
						 venliped_reservas.cantidad,
						 venliped_reservas.id_ubicacion_original,
						 venliped_reservas.id_ubicacion_destino,
						 venliped_reservas.bulto_orden_carga,
						 venliped_reservas.preparado)
					values
						(:codigo_empresa,
						 :li_anyo,
						 :ll_pedido,
						 :li_linea,
						 :ll_alm_bultos_lineas_id,
						 :ld_cantidad,
						 :ll_id_ubicacion_original,
						 :ll_id_ubicacion_destino,
						 0,
						 'N');
						 
					if sqlca.sqlcode <> 0 then
						MessageBox("Error", sqlca.sqlerrtext)
						lb_correcto = false
					end if						 
											
				else
					lb_correcto = false				
					MessageBox("Error", "No pueden existir líneas con cantidades negativas")
				end if
			end if
		next
		
		ld_cantidad_pedido = dw_datos.object.cantidad[row_dw_datos]
		
		if ld_cantidad_total <> ld_cantidad_pedido and ld_cantidad_total <> 0 then
			lb_correcto = false
			MessageBox("Error", "La cantidad reservada debe coincidir con la cantidad del pedido")
		end if
				
		//INSERCIÓN EN RESERVAS *******************************************************		
		
		if lb_correcto then
			commit;
		else
			rollback;
		end if
		
		f_mostrar_bultos_linea(dw_datos,row_dw_datos)
		dw_datos.enabled = true
		
		this.visible = false
		this.reset()
		
	case "t_1","t_2","t_3","t_4","t_5","t_6","t_7","t_8","t_9","t_10" //ORDENES CABECERAS
		this.setsort("almacen A, zona A, fila A, altura A")
		this.sort()
	case "t_existencias" //ORDENES CABECERAS
		this.setsort("existencias D")
		this.sort()

//	case "seleccionada"
//
//		ld_cantidad_pedido = dw_datos.object.cantidad[row_dw_datos]
//		ld_cantidad_falta  = 0
//		ld_cantidad_total  = 0
//		
//		For ll_indice = 1 To this.rowcount()
//			if ll_indice <> row and this.object.seleccionada[ll_indice] = 1 then
//				ld_cantidad_total = ld_cantidad_total + this.object.cantidad[ll_indice]
//			end if
//		next
//		ld_cantidad_falta = ld_cantidad_pedido - ld_cantidad_total
//		if ld_cantidad_falta < 0 then
//			ld_cantidad_falta = 0
//		end if
//		
//		if ld_cantidad_falta <= dec(this.object.existencias_unidad[row]) then
//			this.object.cantidad[row] = ld_cantidad_falta
//		else
//			this.object.cantidad[row] = dec(this.object.existencias_unidad[row])
//		end if
//		
//		this.SetColumn("cantidad")
		
	case "b_pico"
//		articulo_codigo = this.object.articulo[row]
//		articulo_descripcion = this.object.articulos_descripcion[row]
//		piezas = this.object.pico[row]
//		caja = this.object.almacenmovimientos_caja[row]
//		tipo_pallet = this.object.almacenmovimientos_tipo_pallet[row]
//		formato = this.object.almacenmovimientos_formato[row]
//		calidad = this.object.almacenmovimientos_calidad[row]
//		tono = this.object.tono[row]
//		calibre = this.object.calibre[row]
//		almacen = this.object.almacen[row]
//		zona = this.object.zona[row]
//		fila_origen = this.object.fila[row]
//		altura = this.object.altura[row]
//		unidad_pedido = this.object.unidad_pedido[row]
//						
//		if piezas > 0 then
//			dw_traspaso_pico.reset()
//			fila = dw_traspaso_pico.insertrow(0)
//			
//			dw_traspaso_pico.object.articulo_codigo[fila] = articulo_codigo
//			dw_traspaso_pico.object.articulo_descripcion[fila] = articulo_descripcion
//			dw_traspaso_pico.object.piezas[fila] = piezas
//			dw_traspaso_pico.object.caja[fila] = caja
//			dw_traspaso_pico.object.tipo_pallet[fila] = tipo_pallet
//			dw_traspaso_pico.object.calidad[fila] = calidad
//			dw_traspaso_pico.object.tono[fila] = tono
//			dw_traspaso_pico.object.calibre[fila] = calibre
//			dw_traspaso_pico.object.formato[fila] = formato
//			dw_traspaso_pico.object.almacen_origen[fila] = almacen
//			dw_traspaso_pico.object.zona_origen[fila] = zona
//			dw_traspaso_pico.object.fila_origen[fila] = fila_origen
//			dw_traspaso_pico.object.altura_origen[fila] = altura
//			dw_traspaso_pico.object.unidad_pedido[fila] = unidad_pedido
//			dw_traspaso_pico.object.id_bulto_origen[fila]  = this.object.alm_bultos_id[row]
//			
//			if this.object.pico[row] = this.object.existencias[row] then
//				dw_traspaso_pico.object.id_bulto_destino[fila] = this.object.alm_bultos_id[row]
//				dw_traspaso_pico.object.movemos_todo_el_bulto[fila] = 'S'
//				
//				ls_values = "Nuevo~t0/El Mismo~t"+string(dw_traspaso_pico.object.id_bulto_destino[fila])+""																					
//				dw_traspaso_pico.Object.id_bulto_destino.Values = ls_values					
//				
//			else
//				dw_traspaso_pico.object.id_bulto_destino[fila] = 0
//				dw_traspaso_pico.object.movemos_todo_el_bulto[fila] = 'N'
//				
//				ls_values = "Nuevo~t0"
//				dw_traspaso_pico.Object.id_bulto_destino.Values = ls_values					
//			end if
//			
//			dw_traspaso_pico.visible = true
//		end if
	end choose
end if

//this.accepttext()
end event

event itemchanged;//this.accepttext()
//
//if row > 0 then
//	if dwo.name = "cantidad" then
//		if this.object.cantidad[row] > this.object.existencias_unidad[row] then
//			dwo.Primary[row] = this.object.existencias_unidad[row]
//			return 2
//		else
//			if this.object.cantidad[row] < 0 then
//				dwo.Primary[row] = 0
//				return 2
//			end if
//		end if		
//	end if
//end if

dec ld_cantidad_pedido,ld_cantidad_falta,ld_cantidad_total
long row_dw_datos,ll_indice

row_dw_datos = dw_datos.getrow()

choose case dwo.name
		
	case "cantidad"
		if dec(data) <= 0 then
			this.object.seleccionada[row] = 0
		else
			if dec(data) > dec(this.object.existencias_unidad[row]) then
				return 2
			end if
		end if
	case "seleccionada"
		if data = '1' then
			if dw_datos.object.gestionar_en_piezas[row_dw_datos] = this.object.gestionar_en_piezas[row] or ( this.object.articulos_unidad[row] <> '1' ) then			
				ld_cantidad_pedido = dw_datos.object.cantidad[row_dw_datos]
				ld_cantidad_falta  = 0
				ld_cantidad_total  = 0
				
				For ll_indice = 1 To this.rowcount()
					if ll_indice <> row then
						ld_cantidad_total = ld_cantidad_total + this.object.cantidad[ll_indice]
					end if
				next
				ld_cantidad_falta = ld_cantidad_pedido - ld_cantidad_total
				if ld_cantidad_falta < 0 then
					ld_cantidad_falta = 0
				end if
				
				if ld_cantidad_falta = 0 then
					return 2
				else
					if ld_cantidad_falta <= dec(this.object.existencias_unidad[row]) then
						this.object.cantidad[row] = ld_cantidad_falta
					else
						this.object.cantidad[row] = dec(this.object.existencias_unidad[row])
					end if
				end if
			else
				if not(ib_asignando_en_automatico) then
					messagebox("No se puede asignar","La ubicación está gestionada en piezas y la linea de pedido en m2")
				end if
				return 2
			end if
		else
			this.object.cantidad[row] = 0
		end if
		
	case else
		//
end choose
end event

type cb_1 from commandbutton within wtc_asigna_bultos_ocs
integer x = 4014
integer y = 56
integer width = 1294
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "imprimir dw añadiendo campos dinamicamente"
end type

event clicked;//Ejemplo de crear objetos en dw para imprimir
/*
//http://conpb.blogspot.com/2007/02/encabezados-dinamicos-con-un-par.html

string      ls_objects, ls_object, ls_where, ls_type, ls_create
string      ls_aux, ls_modify
long         ll_len, ll_from, ll_to, ll_x, ll_widthObject, ll_width
long         ll_addWidth, ll_posY, ll_posY1, ll_posY2, ll_height
integer      li_r, li_orientation, li_width
datawindow   ldw_aux
datastore   lds_aux
string      ls_typeObject

CONSTANT integer DISPLACEMENT = 300
CONSTANT integer WIDTHA4V       = 3140
CONSTANT integer WIDTHA4H       = 4640

ls_objects = apo_aux.DYNAMIC describe('datawindow.objects')

/******************************************************************/
/*  OBTENEMOS LA ORIENTACIÓN ADECUADA Y DESPLAZAMOS LOS OBJETOS   */
/******************************************************************/
// Por defecto será vertical.
li_orientation = 2

// Recorremos los todos objetos.
ll_len = len(ls_objects)

If ll_len > 0 Then
   ll_from = 1

   Do
      
      ll_to = pos(ls_objects, "~t", ll_from)
      
      If ll_to = 0 Then
         ls_object = mid(ls_objects, ll_from)
      Else
         ls_object = mid(ls_objects, ll_from, ll_to - ll_from)
      End If
      
      If len(ls_object) > 0 Then
         ll_x            = long(apo_aux.DYNAMIC describe(ls_object + '.x'))
         ll_widthObject = long(apo_aux.DYNAMIC describe(ls_object + '.width'))
         
         // Obtenemos hasta donde llegan horizontalmente.
         If ll_x + ll_widthObject > ll_width Then
            ll_width = ll_x + ll_widthObject
         End If
         
         // Lo desplazamos verticalmente si esta en el encabezado.
         ls_where = apo_aux.DYNAMIC describe(ls_object + '.band')
         
         If ls_where = 'header' Then
            ls_type = apo_aux.DYNAMIC describe(ls_object + '.type')
            
            If ls_type = 'line' Then
               ll_posY1 = long(apo_aux.DYNAMIC describe(ls_object + '.y1'))
               ll_posY2 = long(apo_aux.DYNAMIC describe(ls_object + '.y2'))
               
               ls_aux = apo_aux.DYNAMIC modify(ls_object + ".y1 = ~'" + string(ll_posY1 + DISPLACEMENT) + "~'")
               ls_aux = apo_aux.DYNAMIC modify(ls_object + ".y2 = ~'" + string(ll_posY2 + DISPLACEMENT) + "~'")
            Else
               ll_posY = long(apo_aux.DYNAMIC describe(ls_object + '.y'))
               
               ls_aux = apo_aux.DYNAMIC modify(ls_object + ".y = ~'" + string(ll_posY + DISPLACEMENT) + "~'")
            End If
         End If
      End If
               
      ll_from = ll_to + 1
   Loop While (ll_to > 0)
   
   // Determinamos la orientación.
   If ll_width > WIDTHA4V Then
      // Horizontal
      li_orientation = 1
      ll_addWidth = WIDTHA4H - WIDTHA4V 
   End If
   
   /******************************************************************/
   /*               ASIGNAMOS LAS OPCIONES DE IMPRESIÓN                  */
   /******************************************************************/
   ls_aux = as_application + "/" + as_title
   If len(ls_aux) > 31 Then
      ls_aux = left(ls_aux, 28) + "..."
   End If
   
   ls_modify = "datawindow.print.margin.top=212  datawindow.print.margin.left=242 " &
             + "datawindow.print.margin.right=242 datawindow.print.margin.bottom=212" &
             + "datawindow.print.orientation=" + string(li_orientation) + " " &
             + "datawindow.print.documentname=~"" + ls_aux + "~""
   ls_aux    = apo_aux.DYNAMIC modify(ls_modify)
   
   /******************************************************************/
   /*               MODIFICAMOS EL ENCABEZADO DINÁMICAMENTE            */
   /******************************************************************/
   // Modificamos la altura del encabezado.
   ll_height  = long(apo_aux.DYNAMIC describe("datawindow.header.height"))
   ll_height += DISPLACEMENT
   
   ls_aux = apo_aux.DYNAMIC modify("datawindow.header.height=" + string(ll_height))
   
   // Creamos el rectangulo superior.
   ls_create = "create rectangle(band=header x=~"0~" y=~"0~" height=~"224~" " &
             + "width=~"" + string(WIDTHA4V + ll_addWidth) + "~" " &
             + "brush.hatch=~"7~" brush.color=~"553648127~" pen.style=~"0~" pen.width=~"5~" " &
             + "pen.color=~"0~" background.mode=~"2~" background.color=~"16777215~")"
   ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   
   // Creamos el rectangulo inferior.
   ls_create = "create rectangle(band=header x=~"0~" y=~"220~" height=~"80~" " &
             + "width=~"" + string(WIDTHA4V + ll_addWidth) + "~" " &
             + "brush.hatch=~"6~" brush.color=~"14869218~" pen.style=~"0~" pen.width=~"5~" " &
             + "pen.color=~"0~" background.mode=~"1~" background.color=~"553648127~")"
   ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   
   // Creamos el bitmap.
   ls_create = "create bitmap(band=Header x=~"25~" y=~"25~" height=~"180~" width=~"750~" " &
             + "filename=~"G:\Data\desdes01\Bmpaplic\logo.bmp~")"
   ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   
   // Creamos la etiqueta con la entidad.
   ls_create = "create text(band=header color=~"0~" alignment=~"0~" border=~"0~" x=~"27~" y=~"228~" " &
             + "height=~"64~" width=~"530~" text=~"Nombre organización.~" font.face=~"Arial~" " &
             + "font.height=~"55~" font.weight=~"400~" font.family=~"2~" font.pitch=~"2~" " &
             + "font.charset=~"0~" background.mode=~"1~" background.color=~"553648127~")"
   ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   
   // Creamos la etiqueta con el usuario que lanzó la impresión.
   ls_create = "create text(band=header color=~"0~" alignment=~"1~" border=~"0~" " &
             + "x=~"" + string((WIDTHA4V + ll_addWidth) - 526) + "~" y=~"228~" " &
             + "height=~"64~" width=~"503~" text=~"" + upper(gs_usuario) + "~" font.face=~"Arial~" " &
             + "font.height=~"55~" font.weight=~"400~" font.family=~"2~" font.pitch=~"2~" " &
             + "font.charset=~"0~" background.mode=~"1~" background.color=~"553648127~")"
   ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   
   // Creamos etiqueta con el título del informe.
   If li_orientation = 1 Then 
      // Horizontal
      li_width  = 66
   Else
      // Verical
      li_width = 36
   End If

   If len(as_title) > li_width Then
      as_title = left(as_title, li_width - 3) + '...'
   End If
   
   ls_create = "create text(band=header color=~"0~" alignment=~"2~" border=~"0~" x=~"791~" y=~"60~" " &
             + "height=~"104~" width=~"" + string((WIDTHA4V + ll_addWidth) - (791 * 2)) + "~" text=~"" + as_title + "~" " &
             + "font.face=~"Arial~" font.height=~"85~" font.weight=~"700~" " &
             + "font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"1~" " & 
             + "background.color=~"553648127~")"
   ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   
   // Creamos la etiqueta con el nombre de la aplicación.
   ls_create = "create text(band=header color=~"0~" alignment=~"2~" border=~"0~" x=~"791~" y=~"228~" " &
             + "height=~"60~" width=~"" + string((WIDTHA4V + ll_addWidth) - (791 * 2)) + "~" " &
             + "text=~"" + as_application + "~" font.face=~"Arial~" " &
             + "font.height=~"55~" font.weight=~"400~" font.family=~"2~" font.pitch=~"2~" " &
             + "font.charset=~"0~" background.mode=~"1~" background.color=~"553648127~")"
   ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   
   // Montamos la etiqueta con la fecha y hora.
   ls_create = "create text(band=header color=~"0~" alignment=~"1~" border=~"0~" " &
             + "x=~"" + string((WIDTHA4V + ll_addWidth) - 526) + "~" y=~"24~" " &
             + "height=~"64~" width=~"503~" text=~"" + string(today(),'d/mm/yyyy hh:mm') + "~" " &
             + "font.face=~"Arial~" font.height=~"55~" font.weight=~"400~" font.family=~"2~" " & 
             + "font.pitch=~"2~" font.charset=~"0~" background.mode=~"1~" background.color=~"553648127~")"
   ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   
   // Montamos el computado con la información de las páginas.
   ls_create = "create compute(band=header color=~"0~" alignment=~"1~" border=~"0~" " &
             + "x=~"" + string((WIDTHA4V + ll_addWidth) - 526) + "~" y=~"92~" " &
             + "height=~"64~" width=~"503~" format=~"[GENERAL]~" " &
             + "expression=~"page() + '/' + pageCount()~" " &
             + "font.face=~"Arial~" font.height=~"55~" font.weight=~"400~" font.family=~"2~" " & 
             + "font.pitch=~"2~" font.charset=~"0~" background.mode=~"1~" background.color=~"553648127~")"
   ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   
   /******************************************************************/
   /*                  MODIFICAMOS EL PIE DINÁMICAMENTE                  */
   /******************************************************************/
   // Recogemos y modificamos la altura del pie.
   If trim(as_footer) <> '' Then
      ll_height  = long(apo_aux.DYNAMIC describe("DataWindow.Footer.Height"))
      
      ls_aux = apo_aux.DYNAMIC modify("DataWindow.Footer.Height=" + string(ll_height + 100))
      
      // Montamos la etiqueta solo si corresponde.
      ls_create = "create text(band=footer alignment=~"2~" text=~"" + as_footer + "~" border=~"0~" color=~"0~" " &
                + "x=~"0~" y=~"" + string(ll_height) + "~" height=~"80~" width=~"558~" font.face=~"Arial~" font.height=~"-12~" " &
                + "font.weight=~"700~" font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" " &
                + "background.mode=~"2~" background.color=~"16777215~")"
      ls_aux     = apo_aux.DYNAMIC modify(ls_create)
   End If
End If

Return li_r
*/
end event

type dw_impresion_contenido_bulto from datawindow within wtc_asigna_bultos_ocs
boolean visible = false
integer x = 2002
integer y = 8
integer width = 1627
integer height = 204
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion Contenido Bulto"
string dataobject = "dw_banda_bulto_oc"
boolean border = false
boolean livescroll = true
end type

type cbx_mostrar_ubicaciones_originales from checkbox within wtc_asigna_bultos_ocs
integer x = 4667
integer y = 176
integer width = 887
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar ubicaciones originales"
end type

event clicked;long ll_indice,ll_total,ll_donde

ib_mostrar_ubicacion_original = cbx_mostrar_ubicaciones_originales.checked

//ll_total = dw_datos.rowcount()
//ll_donde = 0
//
//do 
//	ll_donde = dw_datos.find("situacion = 'P'",ll_donde +1,ll_total)
//	
//	if ll_donde > 0 then
//		f_mostrar_bultos_linea(dw_datos,ll_donde)
//	end if
//					
//loop while ll_donde > 0 and ll_donde < ll_total			

ll_total = dw_datos.rowcount()

for ll_donde = 1 to ll_total 
	f_mostrar_bultos_linea(dw_datos,ll_donde)					
next

end event

type dw_imprimir from u_datawindow within wtc_asigna_bultos_ocs
boolean visible = false
integer x = 1632
integer y = 220
integer width = 2007
integer height = 200
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión Orden"
string dataobject = "dw_asigna_bultos_ocs_impresion"
boolean vscrollbar = true
boolean border = false
end type

type dw_cabecera_orden_preparacion from u_datawindow within wtc_asigna_bultos_ocs
boolean visible = false
integer x = 46
integer y = 3288
integer width = 6231
integer height = 524
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_mant_alm_orden_preparacion"
end type

event clicked;call super::clicked;long ll_ultima_linea,ll_ultima_linea_seleccionada,ll_donde,ll_rowcount,ll_pedido
integer li_anyo_pedido,li_linea_pedido
boolean lb_correcto = true

if dwo.name = "b_aceptar" then
	this.accepttext()
	
	if this.update(true) = 1 then	
		if il_orden_preparacion_genero <> 0 then
			//Estoy modificando una orden que ya existia
			//Voy a buscar lineas de esta orden que no esten marcadas
			ll_donde = 1
			ll_rowcount = dw_datos.rowcount()
			do
					
				ll_donde = dw_datos.find("id_alm_orden_preparacion = "+string(il_orden_preparacion_genero),ll_donde,ll_rowcount)
				
				if ll_donde > 0 then
					if not(dw_datos.IsSelected(ll_donde)) then
						//Debemos updatear la linea del pedido con la orden 0
						li_anyo_pedido  = dw_datos.object.anyo[ll_donde]
						ll_pedido       = dw_datos.object.pedido[ll_donde]
						li_linea_pedido = dw_datos.object.linea[ll_donde]
						
						update venliped 
						set    venliped.id_alm_orden_preparacion = 0
						where  venliped.empresa = :codigo_empresa
						and    venliped.anyo    = :li_anyo_pedido
						and    venliped.pedido  = :ll_pedido
						and    venliped.linea   = :li_linea_pedido;
						
						if sqlca.sqlcode <> 0 then
							lb_correcto = false
						end if
					end if
					ll_donde ++
				end if
				
			loop while ll_donde > 0 and ll_donde < ll_rowcount		
		end if
		
		ll_ultima_linea_seleccionada = 0
		ll_ultima_linea = dw_datos.rowcount()
		il_orden_preparacion_genero = this.object.id[1]
		
		do
				
			ll_ultima_linea_seleccionada = dw_datos.GetSelectedRow(ll_ultima_linea_seleccionada)
			
			if ll_ultima_linea_seleccionada > 0 then				
				li_anyo_pedido  = dw_datos.object.anyo[ll_ultima_linea_seleccionada]
				ll_pedido       = dw_datos.object.pedido[ll_ultima_linea_seleccionada]
				li_linea_pedido = dw_datos.object.linea[ll_ultima_linea_seleccionada]
				
				update venliped 
				set    venliped.id_alm_orden_preparacion = :il_orden_preparacion_genero
				where  venliped.empresa = :codigo_empresa
				and    venliped.anyo    = :li_anyo_pedido
				and    venliped.pedido  = :ll_pedido
				and    venliped.linea   = :li_linea_pedido;
				
				if sqlca.sqlcode <> 0 then
					lb_correcto = false
				end if
			end if
			
		loop while ll_ultima_linea_seleccionada > 0 and ll_ultima_linea_seleccionada <= ll_ultima_linea
		
		if lb_correcto then
			commit;
			//Ahora vamos a actualizar el dato en la datawindow
			ll_donde = 1
			ll_rowcount = dw_datos.rowcount()
			//Primero actualizo las lineas desmarcadas
			do
					
				ll_donde = dw_datos.find("id_alm_orden_preparacion = "+string(il_orden_preparacion_genero),ll_donde,ll_rowcount)
				
				if ll_donde > 0 then
					if not(dw_datos.IsSelected(ll_donde)) then
						//Debemos marcar la linea del pedido con la orden 0
						dw_datos.object.id_alm_orden_preparacion[ll_donde] = 0
					end if
					ll_donde ++
				end if
				
			loop while ll_donde > 0 and ll_donde <= ll_rowcount					

			//Despues actualizo las lineas marcadas
			ll_ultima_linea_seleccionada = 0
			ll_ultima_linea = dw_datos.rowcount()
			
			do
					
				ll_ultima_linea_seleccionada = dw_datos.GetSelectedRow(ll_ultima_linea_seleccionada)
				
				if ll_ultima_linea_seleccionada > 0 then				
					//Debemos marcar la linea del pedido con la orden actual
					dw_datos.object.id_alm_orden_preparacion[ll_ultima_linea_seleccionada] = il_orden_preparacion_genero
				end if
				
			loop while ll_ultima_linea_seleccionada > 0 and ll_ultima_linea_seleccionada <= ll_ultima_linea			
		else
			rollback;
			messagebox("¡Error!","Se ha producido un error al actualizar las lineas")			
		end if
	else
		rollback;
		messagebox("¡Error!","Se ha producido un error al actualizar la orden de preparación")
	end if
else
	if dwo.name = "b_cancelar" then
		this.reset()
		dw_datos.selectrow(0,false)
		//ib_generando_orden_de_preparacion = false
		il_orden_preparacion_genero		 = 0
	else
		if dwo.name = 'p_imprimir' or dwo.name = 't_imprimir' then
			f_cargar_lineas_orden_carga_imprimir()
			f_imprimir_datawindow(dw_imprimir)		
		else
			if dwo.name = 'p_imprimir_bandas' or dwo.name = 't_imprimir_bandas' then
				if f_imprimir_bandas_orden_preparacion(this.object.id[row]) then
					
				end if
			else
				if dwo.name = 'b_borrar' then
					//Desmarcamos todas las lineas marcadas
					dw_datos.selectrow(0,false)
				end if
			end if			
		end if
	end if
end if
end event

event key;bus_filtro    = ""
bus_titulo    = ""
valor_empresa = TRUE
bus_campo     = This.GetColumnName()

choose case bus_campo
	case "id_usuario"
		valor_empresa  = false
		bus_datawindow = "dw_ayuda_usuarios"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE USUARIOS"				
	case else
		SetNull(bus_campo)
end choose

CALL Super::Key
end event

event rbuttondown;bus_filtro    = ""
bus_titulo    = ""
valor_empresa = TRUE
bus_campo     = dwo.name

choose case bus_campo
	case "id_usuario"
		valor_empresa  = false
		bus_datawindow = "dw_ayuda_usuarios"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE USUARIOS"				
	case else
		SetNull(bus_campo)
end choose

CALL Super::rbuttondown
end event

type dw_impresion_contenido_bulto_sin_prep from datawindow within wtc_asigna_bultos_ocs
boolean visible = false
integer x = 3735
integer y = 264
integer width = 1627
integer height = 224
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion Contenido Bulto Sin Preparar"
string dataobject = "dw_banda_bulto_oc_sin_preparar"
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within wtc_asigna_bultos_ocs
boolean visible = false
integer x = 5536
integer y = 344
integer width = 814
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Arreglar Cagada Preparación"
end type

event clicked;string ls_sel
long   ll_indice,ll_total,ll_stock_original

str_movimiento_almacen lstr_movimiento_almacen

datastore ds_datos

transaction trans_pruebas

trans_pruebas = create transaction

trans_pruebas.AutoCommit    = sqlca.AutoCommit
trans_pruebas.Database      = 'COPIA_SEGURIDAD'//sqlca.Database
trans_pruebas.DBMS          = sqlca.DBMS
trans_pruebas.DBParm        = replace(sqlca.DBParm,pos(sqlca.DBParm,'TENCER'),len('TENCER'),'COPIA_SEGURIDAD')
trans_pruebas.DBPass        = sqlca.DBPass
trans_pruebas.Lock          = sqlca.Lock
trans_pruebas.LogID         = sqlca.LogID
trans_pruebas.LogPass       = sqlca.LogPass
trans_pruebas.ServerName    = sqlca.ServerName
trans_pruebas.UserID        = sqlca.UserID

connect using trans_pruebas;

if trans_pruebas.sqlcode = 0 then

	ls_sel = "select isnull(almacenmovimientos.almacen,'') as almacen, "+&
				"		isnull(almacenmovimientos.zona,'') as zona, "+&
				"		isnull(almacenmovimientos.fila,'') as fila, "+&
				"		isnull(almacenmovimientos.altura,'') as altura, "+&
				"		isnull(almacenmovimientos.articulo,'') as articulo, "+&
				"		isnull(almacenmovimientos.calidad,'') as calidad, "+&
				"		isnull(almacenmovimientos.tono,'') as tono, "+&
				"		isnull(almacenmovimientos.calibre,0) as calibre, "+&
				"		isnull(almacenmovimientos.tipo_pallet,'') as tipo_pallet, "+&
				"		isnull(almacenmovimientos.caja,'') as caja, "+&
				"		isnull(sum(almacenmovimientos.cantidads),0) as cantidads, "+&
				"		isnull(almacenmovimientos.id_alm_bultos,0) as id_alm_bultos, "+&
				"		isnull((palarticulo.cajaspallet * almartcajas.piezascaja),0) as piezas_pallet "+&
				"from almacenmovimientos, "+&
				"		almartcajas, "+&
				"		palarticulo "+&
				"where	almacenmovimientos.empresa     = almartcajas.empresa "+&
				"and	almacenmovimientos.articulo    = almartcajas.articulo "+&
				"and	almacenmovimientos.caja        = almartcajas.caja "+&
				"and	almartcajas.empresa            = palarticulo.empresa "+&
				"and	almartcajas.articulo           = palarticulo.articulo "+&
				"and	almartcajas.caja               = palarticulo.caja "+&
				"and	almacenmovimientos.tipo_pallet = palarticulo.codigo "+&
				"and  	almacenmovimientos.tipomov     = '204' "+&
				"and  	almacenmovimientos.fecha_mov   = '01-06-2020' "+&
				"and  	almacenmovimientos.fecha_intr <= '01-06-2020 14:00' "+&
				"and   almacenmovimientos.id_alm_bultos <> 1312 "+& 
				"and   almacenmovimientos.cantidads <> (palarticulo.cajaspallet * almartcajas.piezascaja) "+&
				"group by almacenmovimientos.almacen, "+&
				"		almacenmovimientos.zona, "+&
				"		almacenmovimientos.fila, "+&
				"		almacenmovimientos.altura, "+&
				"		almacenmovimientos.articulo, "+&
				"		almacenmovimientos.calidad, "+&
				"		almacenmovimientos.tono, "+&
				"		almacenmovimientos.calibre, "+&
				"		almacenmovimientos.tipo_pallet, "+&
				"		almacenmovimientos.caja, "+&
				"		almacenmovimientos.id_alm_bultos, "+&
				"		palarticulo.cajaspallet,almartcajas.piezascaja "+&
				"union "+&
				"select almacenmovimientos.almacen, "+&
				"		almacenmovimientos.zona, "+&
				"		almacenmovimientos.fila, "+&
				"		almacenmovimientos.altura, "+&
				"		almacenmovimientos.articulo, "+&
				"		almacenmovimientos.calidad, "+&
				"		almacenmovimientos.tono, "+&
				"		almacenmovimientos.calibre, "+&
				"		almacenmovimientos.tipo_pallet, "+&
				"		almacenmovimientos.caja, "+&
				"		sum(almacenmovimientos.cantidads), "+&
				"		almacenmovimientos.id_alm_bultos, "+&
				"		0 as piezas_pallet "+&
				"from  almacenmovimientos "+& 
				"where	almacenmovimientos.tipomov     = '204' "+&
				"and  	almacenmovimientos.fecha_mov   = '01-06-2020' "+&
				"and  	almacenmovimientos.fecha_intr <= '01-06-2020 14:00' "+&
				"and   almacenmovimientos.id_alm_bultos <> 1312 "+&
				"and	almacenmovimientos.tipo_pallet = '00000' "+&
				"group by almacenmovimientos.almacen, "+&
				"		almacenmovimientos.zona, "+&
				"		almacenmovimientos.fila, "+&
				"		almacenmovimientos.altura, "+&
				"		almacenmovimientos.articulo, "+&
				"		almacenmovimientos.calidad, "+&
				"		almacenmovimientos.tono, "+&
				"		almacenmovimientos.calibre, "+&
				"		almacenmovimientos.tipo_pallet, "+&
				"		almacenmovimientos.caja, "+&
				"		almacenmovimientos.id_alm_bultos"
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total
		
		lstr_movimiento_almacen.empresa                   = codigo_empresa
		lstr_movimiento_almacen.articulo                  = ds_datos.object.articulo[ll_indice]
		lstr_movimiento_almacen.calidad                   = ds_datos.object.calidad[ll_indice]
		lstr_movimiento_almacen.tono                      = ds_datos.object.tono[ll_indice]
		lstr_movimiento_almacen.calibre                   = ds_datos.object.calibre[ll_indice]
		lstr_movimiento_almacen.tipo_pallet               = ds_datos.object.tipo_pallet[ll_indice]
		lstr_movimiento_almacen.caja                      = ds_datos.object.caja[ll_indice]
		lstr_movimiento_almacen.cantidad                  = ds_datos.object.cantidads[ll_indice]
		lstr_movimiento_almacen.orden_carga_anyo          = 0
		lstr_movimiento_almacen.orden_carga_codigo        = ""
		lstr_movimiento_almacen.orden_carga_linea         = 0
		lstr_movimiento_almacen.tipo_movimiento           = ""
		lstr_movimiento_almacen.observaciones             = ""
		lstr_movimiento_almacen.almacen                   = ds_datos.object.almacen[ll_indice]
		lstr_movimiento_almacen.zona                      = ds_datos.object.zona[ll_indice]
		lstr_movimiento_almacen.fila                      = ds_datos.object.fila[ll_indice]
		lstr_movimiento_almacen.altura                    = ds_datos.object.altura[ll_indice]
		lstr_movimiento_almacen.tercero                   = ""
		lstr_movimiento_almacen.documento                 = ""
		lstr_movimiento_almacen.fecha                     = datetime(today())
		lstr_movimiento_almacen.id_ubicacion              = 0
		lstr_movimiento_almacen.id_alm_bultos		        = ds_datos.object.id_alm_bultos[ll_indice]
		lstr_movimiento_almacen.venliped_anyo             = 0
		lstr_movimiento_almacen.venliped_pedido           = 0
		lstr_movimiento_almacen.venliped_linea            = 0
				
		ll_stock_original = 0		
		
		SELECT isnull(sum(alm_bultos_lineas.cantidad),0)
		INTO  :ll_stock_original  
		FROM  alm_bultos,   
				alm_bultos_lineas  
		WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
		and ( ( alm_bultos.id              = :lstr_movimiento_almacen.id_alm_bultos ) 
		AND  	( alm_bultos_lineas.empresa  = :lstr_movimiento_almacen.empresa ) 
		AND  	( alm_bultos_lineas.articulo = :lstr_movimiento_almacen.articulo ) 
		AND  	( alm_bultos_lineas.calidad  = :lstr_movimiento_almacen.calidad ) 
		AND  	( alm_bultos_lineas.tono     = :lstr_movimiento_almacen.tono ) 
		AND  	( alm_bultos_lineas.calibre  = :lstr_movimiento_almacen.calibre ) 
		AND  	( alm_bultos_lineas.caja     = :lstr_movimiento_almacen.caja ) )		
		using trans_pruebas;
		
		lstr_movimiento_almacen.cantidad = ll_stock_original - ds_datos.object.cantidads[ll_indice]
		
		//messagebox(string(lstr_movimiento_almacen.id_alm_bultos),string(ll_stock_original)+" "+string(lstr_movimiento_almacen.cantidad))
		
		if lstr_movimiento_almacen.cantidad > 0 then
			if not(f_movimiento_almacen_sin_almacenmovimientos(lstr_movimiento_almacen)) then
				rollback;
				messagebox("Error",string(lstr_movimiento_almacen.id_alm_bultos))
			else
				commit;
			end if
		end if
	next
	
	destroy ds_datos
	
end if

disconnect using trans_pruebas;

destroy trans_pruebas
end event

type pb_etiquetas_a_preparar from picturebutton within wtc_asigna_bultos_ocs
integer x = 5906
integer y = 296
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\Bar Code.png"
string disabledname = "C:\bmp\RF\Bar Code_dis.png"
string powertiptext = "Imprimir etiquetas de los bultos reservados"
end type

event clicked;string ls_ean_13,ls_almacen,ls_zona,ls_sel,ls_descripcion_bulto
long ll_donde,ll_desde,ll_hasta,ll_indice,ll_total,ll_lineas_bulto
int  li_row_etiqueta,li_fila,li_altura
str_alm_bultos lstr_alm_bultos

datastore ds_datos

if dw_datos.rowcount() > 0 then
	
	il_id_orden_carga = dw_datos.object.id_alm_orden_carga[1]
	
	ls_sel = "select almubimapa_codbar.almacen, "+&
				"       almubimapa_codbar.zona, "+&
				"       almubimapa_codbar.fila, "+&
				"       almubimapa_codbar.altura, "+&
				"       alm_bultos.id, "+&
				"       sum(venliped_reservas.cantidad) as cantidad, "+&
				"       venliped_reservas.anyo, "+&
				"       venliped_reservas.pedido, "+&
				"       venliped_reservas.linea "+&
				"from   venliped,venliped_reservas,alm_bultos,alm_bultos_lineas,almubimapa_codbar "+&
				"where  venliped.empresa                       = venliped_reservas.empresa "+&
				"and    venliped.anyo                          = venliped_reservas.anyo "+&
				"and    venliped.pedido                        = venliped_reservas.pedido "+&
				"and    venliped.linea                         = venliped_reservas.linea "+&
				"and    venliped_reservas.empresa              = alm_bultos_lineas.empresa "+&
				"and    venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id "+&
				"and    alm_bultos_lineas.id_alm_bultos        = alm_bultos.id "+&
				"and    alm_bultos.id_ubicacion                = almubimapa_codbar.id "+&
				"and    venliped.empresa                       = '"+codigo_empresa+"' "+&
				"and    venliped.id_alm_orden_carga            = "+string(il_id_orden_carga,"#####0")+" "+&
				"group by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id, "+&
				"         venliped_reservas.anyo, "+&
				"         venliped_reservas.pedido, "+&
				"         venliped_reservas.linea, "+&
				"         venliped_reservas.id_ubicacion_destino "+&
				"order by venliped_reservas.anyo, "+&
				"         venliped_reservas.pedido, "+&
				"         venliped_reservas.linea, "+&
				"         almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id "
	
	ll_desde = 1
	ll_hasta = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	dw_etiquetas_bultos_100.reset()
	
	for ll_donde = 1 to ll_hasta		
		ls_almacen = ds_datos.object.almubimapa_codbar_almacen[ll_donde]
		ls_zona    = ds_datos.object.almubimapa_codbar_zona[ll_donde]
		li_fila    = ds_datos.object.almubimapa_codbar_fila[ll_donde]
		li_altura  = ds_datos.object.almubimapa_codbar_altura[ll_donde]
		lstr_alm_bultos.id = ds_datos.object.alm_bultos_id[ll_donde]
				
		if f_cargar_str_alm_bultos(lstr_alm_bultos.id,lstr_alm_bultos) then
			ls_descripcion_bulto = ''
			ll_lineas_bulto = 0
			
			select isnull(count(*),0)
			into   :ll_lineas_bulto
			from   alm_bultos_lineas
			where  alm_bultos_lineas.id_alm_bultos = :lstr_alm_bultos.id;
			
			if ll_lineas_bulto = 1 then
				select 'B '+ltrim(rtrim(isnull(articulos.descripcion,'')))+' '+ltrim(rtrim(isnull(formatos.descripcion,'')))+' '+ltrim(rtrim(convert(char(10),isnull(convert(dec(16,0),alm_bultos_lineas.cantidad),0))))+' UDS'
				into   :ls_descripcion_bulto 
				from   alm_bultos_lineas,
						 articulos,
						 formatos 
				where  alm_bultos_lineas.empresa  = articulos.empresa 
				and    alm_bultos_lineas.articulo = articulos.codigo 
				and    alm_bultos_lineas.empresa  = formatos.empresa 
				and    articulos.formato          = formatos.codigo 
				and    alm_bultos_lineas.id_alm_bultos = :lstr_alm_bultos.id;					
			else
				ls_descripcion_bulto = 'B MULTIREFERENCIA'
			end if
			
			ls_ean_13 = lstr_alm_bultos.ean13
			if isnull(ls_ean_13) then ls_ean_13 = ""
		
			if trim(ls_ean_13) = "" then
				ls_ean_13 = "25"+string(lstr_alm_bultos.id,"0000000000")
				ls_ean_13 = f_calcula_ean13(ls_ean_13)
			end if
			
			li_row_etiqueta = dw_etiquetas_bultos_100.insertrow(0)
		
			dw_etiquetas_bultos_100.object.codigo_barras[li_row_etiqueta] = f_imprimir_ean_13(ls_ean_13)
			dw_etiquetas_bultos_100.object.descripcion[li_row_etiqueta]   = ls_almacen+'-'+ls_zona+'-'+string(li_fila,"###0")+'-'+string(li_altura,"##0")+'   '+ls_ean_13//"B"+string(lstr_alm_bultos.id,"0000000000")
			dw_etiquetas_bultos_100.object.almacen[li_row_etiqueta]       = ls_descripcion_bulto
			dw_etiquetas_bultos_100.object.zona[li_row_etiqueta]          = ""
			dw_etiquetas_bultos_100.object.fila[li_row_etiqueta]          = ""
			dw_etiquetas_bultos_100.object.altura[li_row_etiqueta]        = ""
			dw_etiquetas_bultos_100.object.color_fondo[li_row_etiqueta]   = rgb(255,255,255)//ds_datos.object.color_fondo[ll_donde] //
			dw_etiquetas_bultos_100.object.color_texto[li_row_etiqueta]   = rgb(0,0,0)//ds_datos.object.color_texto[ll_donde] //
			dw_etiquetas_bultos_100.object.texto_control[li_row_etiqueta] = ls_almacen+'-'+ls_zona+'-'+string(li_fila,"###0")+'-'+string(li_altura,"##0")
		
			dw_etiquetas_bultos_100.object.flecha_abajo[li_row_etiqueta]  = 'N'
			dw_etiquetas_bultos_100.object.flecha_arriba[li_row_etiqueta] = 'N'												
		end if
	
	next
	
	destroy ds_datos
	
	if li_row_etiqueta > 0 then
		dw_etiquetas_bultos_100.setredraw(false)
		//dw_etiquetas_bultos_100.Object.DataWindow.Zoom = 100
		dw_etiquetas_bultos_100.groupcalc()
		f_imprimir_datawindow(dw_etiquetas_bultos_100)
		//dw_etiquetas_bultos_100.Object.DataWindow.Zoom = 50
		dw_etiquetas_bultos_100.setredraw(true)
		
		dw_etiquetas_bultos_100.reset()
	end if
end if
end event

type cb_3 from commandbutton within wtc_asigna_bultos_ocs
boolean visible = false
integer x = 4768
integer y = 340
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Kakota"
end type

event clicked;
		update venliped
		set    venliped.situacion = 'P'
		from   venliped,
				 venliped_reservas 
		where  venliped.empresa = venliped_reservas.empresa 
		and    venliped.anyo    = venliped_reservas.anyo 
		and    venliped.pedido  = venliped_reservas.pedido 
		and    venliped.linea   = venliped_reservas.linea 
		and    venliped.situacion <> 'P'
		and    ( select isnull(count(*),0) 
					from   venliped_reservas as venliped_reservas_no_preparadas 
					where  venliped_reservas_no_preparadas.empresa = venliped.empresa
					and    venliped_reservas_no_preparadas.anyo    = venliped.anyo
					and    venliped_reservas_no_preparadas.pedido  = venliped.pedido
					and    venliped_reservas_no_preparadas.linea   = venliped.linea
					and    isnull(venliped_reservas_no_preparadas.preparado,'') <> 'S' ) = 0;
					
		if sqlca.sqlcode <> 0 then
			rollback;
		else
			commit;
		end if									
end event

