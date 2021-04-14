$PBExportHeader$wi_mant_alm_orden_carga_old.srw
forward
global type wi_mant_alm_orden_carga_old from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_alm_orden_carga_old
end type
type p_imprimir_pendientes from picture within wi_mant_alm_orden_carga_old
end type
type dw_lineas_orden from u_datawindow within wi_mant_alm_orden_carga_old
end type
type dw_pedidos_pendientes from u_datawindow within wi_mant_alm_orden_carga_old
end type
type p_1 from picture within wi_mant_alm_orden_carga_old
end type
type dw_updatea_venliped from datawindow within wi_mant_alm_orden_carga_old
end type
end forward

global type wi_mant_alm_orden_carga_old from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 6985
integer height = 3808
pb_calculadora pb_calculadora
p_imprimir_pendientes p_imprimir_pendientes
dw_lineas_orden dw_lineas_orden
dw_pedidos_pendientes dw_pedidos_pendientes
p_1 p_1
dw_updatea_venliped dw_updatea_venliped
end type
global wi_mant_alm_orden_carga_old wi_mant_alm_orden_carga_old

type variables
long il_rows_dw_updatea_venliped
end variables

forward prototypes
public function long f_cargar_pedidos ()
public function long f_cargar_lineas_orden_carga ()
public function integer f_post_itemchanged (long row, dwobject dwo, string data)
public subroutine f_calculo_disponiblilidad (ref datastore ds_datos, string ls_filtro_cliente, string ls_filtro_envio)
end prototypes

public function long f_cargar_pedidos ();string ls_sel,ls_filtro_cliente,ls_filtro_envio,ls_cliente,ls_envio
long   ll_total,ll_row,ll_rows,ll_id_alm_orden_carga
datastore ds_datos

dw_pedidos_pendientes.reset()
dw_updatea_venliped.reset()

dw_pedidos_pendientes.setredraw(false)

if dw_1.rowcount() = 1 then
	ll_id_alm_orden_carga = dw_1.object.id[1]
	ls_cliente            = dw_1.object.cliente[1]
	ls_envio              = dw_1.object.envio[1]
	
	if trim(ls_cliente) <> "" then
		il_rows_dw_updatea_venliped = dw_updatea_venliped.retrieve(codigo_empresa,ls_cliente)
		ls_filtro_cliente = "AND   ( venped.cliente = '"+ls_cliente+"' ) "
	else
		ls_filtro_cliente = ""
	end if
	
	if trim(ls_cliente) <> "" and trim(ls_envio) <> "" then
		ls_filtro_envio = "AND   ( venped.envio = '"+ls_envio+"' ) "
	else
		ls_filtro_envio = ""
	end if
	
	ls_sel ="SELECT venped.empresa, "+&
			  "		 venped.anyo, "+&
			  "		 venped.pedido, "+& 
			  "		 venped.fpedido, "+&
			  "		 venped.cliente, "+&
			  "		 genter.razon, "+&
			  "		 venped.observaciones, "+&
			  "		 venped.numpedcli, "+&
			  "		 venped.envio, "+&
			  "		 venenvio.descripcion, "+&
			  "		 venliped.linea, "+&
			  "		 venliped.articulo, "+&
			  "		 articulos.descripcion, "+&
			  "		 articulos.familia, "+&
			  "		 familias.descripcion, "+&
			  "		 articulos.formato, "+&
			  "		 formatos.abreviado, "+&
			  "		 articulos.promocion, "+&
			  "		 articulos.unidad, "+&
			  "		 unidades.abreviado, "+&
			  "		 isnull(case when articulos.decimales_unidad is null then unidades.decimales else articulos.decimales_unidad end,0) as decimales_unidad, "+&
			  "		 venliped.calidad, "+&
			  "		 calidades.abreviado, "+&
			  "		 venliped.tonochar, "+&
			  "		 venliped.calibre, "+&
			  "		 venliped.tipo_pallet, "+&
			  "		 pallets.resumido, "+&
			  "		 venliped.caja, "+&
			  "		 almcajas.descripcion_abr, "+&
			  "		 venliped.cantidad, "+&
			  "		 venliped.pallets, "+&
			  "		 venliped.cajas, "+&
			  "		 venliped.situacion, "+&
			  "       venliped.id_alm_orden_carga, "+&
			  "       venliped.ordenacion_orden_carga, "+&
			  "       isnull(venliped.bulto_desde_orden_carga,0) as bulto_desde_orden_carga, "+&
			  "       isnull(venliped.bulto_hasta_orden_carga,0) as bulto_hasta_orden_carga, "+&
			  "       venliped.tipolinea, "+&
			  "       convert(dec(10,2),venliped.peso) as peso_kg, "+&
			  "      "+string(ll_id_alm_orden_carga)+" as id_alm_orden_carga_actual, "+&
			  "       -1.000 as disponible, "+&
			  "       0.000 as planificado, "+&
			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_minima, "+&
			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_maxima, "+&
			  "       case venliped.situacion when 'P' then 50 when 'C' then 40 else 10 end as estado_linea "+&
			  "FROM  venped "+&
			  "		LEFT OUTER JOIN venenvio ON venped.empresa = venenvio.empresa AND venped.cliente = venenvio.cliente AND venped.envio = venenvio.codigo, "+&
			  "		venliped "+&
			  "		LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo "+&
			  "		LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo "+&
			  "		LEFT OUTER JOIN almcajas ON venliped.empresa = almcajas.empresa AND venliped.caja = almcajas.codigo, "+&
			  "		genter, "+&
			  "		articulos, "+&  
			  "		familias, "+&
			  "		formatos, "+&
			  "		unidades "+&
			  "WHERE ( venped.empresa    = venliped.empresa ) "+&
			  "AND   ( venped.anyo       = venliped.anyo ) "+&
			  "AND   ( venped.pedido     = venliped.pedido ) "+&
			  "AND   ( venped.empresa    = genter.empresa ) "+&
			  "AND   ( 'C'               = genter.tipoter ) "+&
			  "AND   ( venped.cliente    = genter.codigo ) "+&
			  "AND   ( venliped.empresa  = articulos.empresa ) "+&
			  "AND   ( venliped.articulo = articulos.codigo ) "+&
			  "AND   ( articulos.empresa = familias.empresa ) "+&
			  "AND   ( articulos.familia = familias.codigo ) "+&
			  "AND   ( articulos.empresa = formatos.empresa ) "+&
			  "AND   ( articulos.formato = formatos.codigo ) "+&
			  "AND   ( unidades.codigo   = articulos.unidad ) "+&
			  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) "+&
			  ls_filtro_cliente+&
			  ls_filtro_envio+&
			  "ORDER BY venped.anyo, "+&
			  "		   venped.pedido, "+& 
			  "		   venliped.linea"
	
	
	ll_rows = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	if ll_rows > 0 then
		//Primero calcularemos los datos de disponiblilidad y situacion de la disponiblilidad
		f_calculo_disponiblilidad(ds_datos,ls_filtro_cliente,ls_filtro_envio)
		//
		dw_pedidos_pendientes.object.data = ds_datos.object.data
		dw_pedidos_pendientes.Event rowfocuschanged(1)
	end if
	
	destroy ds_datos
end if

dw_pedidos_pendientes.setredraw(true)

return ll_rows
end function

public function long f_cargar_lineas_orden_carga ();string ls_sel
long   ll_total,ll_rows,ll_id_alm_orden_carga
datastore ds_datos

dw_lineas_orden.reset()

dw_lineas_orden.setredraw(false)

if dw_1.rowcount() = 1 then
	
	ll_id_alm_orden_carga = dw_1.object.id[1]
		
	ls_sel ="SELECT venped.empresa, "+&
			  "		 venped.anyo, "+&
			  "		 venped.pedido, "+& 
			  "		 venped.fpedido, "+&
			  "		 venped.cliente, "+&
			  "		 genter.razon, "+&
			  "		 venped.observaciones, "+&
			  "		 venped.numpedcli, "+&
			  "		 venped.envio, "+&
			  "		 venenvio.descripcion, "+&
			  "		 venliped.linea, "+&
			  "		 venliped.articulo, "+&
			  "		 articulos.descripcion, "+&
			  "		 articulos.familia, "+&
			  "		 familias.descripcion, "+&
			  "		 articulos.formato, "+&
			  "		 formatos.abreviado, "+&
			  "		 articulos.promocion, "+&
			  "		 articulos.unidad, "+&
			  "		 unidades.abreviado, "+&
			  "		 isnull(case when articulos.decimales_unidad is null then unidades.decimales else articulos.decimales_unidad end,0) as decimales_unidad, "+&
			  "		 venliped.calidad, "+&
			  "		 calidades.abreviado, "+&
			  "		 venliped.tonochar, "+&
			  "		 venliped.calibre, "+&
			  "		 venliped.tipo_pallet, "+&
			  "		 pallets.resumido, "+&
			  "		 venliped.caja, "+&
			  "		 almcajas.descripcion_abr, "+&
			  "		 venliped.cantidad, "+&
			  "		 venliped.pallets, "+&
			  "		 venliped.cajas, "+&
			  "		 venliped.situacion, "+&
			  "       venliped.id_alm_orden_carga, "+&
			  "       venliped.ordenacion_orden_carga, "+&
			  "       venliped.bulto_desde_orden_carga, "+&
			  "       venliped.bulto_hasta_orden_carga, "+&
			  "       venliped.tipolinea, "+&
			  "       convert(dec(10,2),venliped.peso) as peso_kg, "+&
			  "      "+string(ll_id_alm_orden_carga)+" as id_alm_orden_carga_actual, "+&
			  "       -1.000 as disponible, "+&
			  "       0.000 as planificado, "+&
			  "       venliped.fentrega as fecha_fin_planificacion_minima, "+&
			  "       venliped.fentrega as fecha_fin_planificacion_maxima, "+&
			  "       case venliped.situacion when 'P' then 50 when 'C' then 40 else 10 end as estado_linea "+&
			  "FROM  venped "+&
			  "		LEFT OUTER JOIN venenvio ON venped.empresa = venenvio.empresa AND venped.cliente = venenvio.cliente AND venped.envio = venenvio.codigo, "+&
			  "		venliped "+&
			  "		LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo "+&
			  "		LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo "+&
			  "		LEFT OUTER JOIN almcajas ON venliped.empresa = almcajas.empresa AND venliped.caja = almcajas.codigo, "+&
			  "		genter, "+&
			  "		articulos, "+&  
			  "		familias, "+&
			  "		formatos, "+&
			  "		unidades "+&
			  "WHERE ( venped.empresa    = venliped.empresa ) "+&
			  "AND   ( venped.anyo       = venliped.anyo ) "+&
			  "AND   ( venped.pedido     = venliped.pedido ) "+&
			  "AND   ( venped.empresa    = genter.empresa ) "+&
			  "AND   ( 'C'               = genter.tipoter ) "+&			  
			  "AND   ( venped.cliente    = genter.codigo ) "+&
			  "AND   ( venliped.empresa  = articulos.empresa ) "+&
			  "AND   ( venliped.articulo = articulos.codigo ) "+&
			  "AND   ( articulos.empresa = familias.empresa ) "+&
			  "AND   ( articulos.familia = familias.codigo ) "+&
			  "AND   ( articulos.empresa = formatos.empresa ) "+&
			  "AND   ( articulos.formato = formatos.codigo ) "+&
			  "AND   ( unidades.codigo   = articulos.unidad ) "+&
			  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) "+&
			  "AND   ( venliped.id_alm_orden_carga = '"+string(ll_id_alm_orden_carga,"#####0")+"' ) "+&			  
			  "ORDER BY venped.anyo, "+&
			  "		   venped.pedido, "+& 
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
dec cantidad_redondeada
integer posi, posi_aux

	
if dwo.name = "cantidad" then
	cadena = f_calculo_unidades_tipolin (codigo_empresa, dw_pedidos_pendientes.object.articulo[row], dw_pedidos_pendientes.object.tipo_pallet[row], dw_pedidos_pendientes.object.caja[row], 0, 0, dec (data), dw_pedidos_pendientes.object.tipolinea[row])

	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
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
	
	dw_pedidos_pendientes.object.cantidad[row] = cantidad_redondeada

end if

fila = dw_pedidos_pendientes.GetRow()

if f_dividir_linea_venliped (codigo_empresa, dw_pedidos_pendientes.object.anyo[row], dw_pedidos_pendientes.object.pedido[row], dw_pedidos_pendientes.object.linea[row], dec(data)) <> 0 then
	commit using sqlca;
else
	rollback using sqlca;
end if

//Refrescar la datawindow//pb_anyadir1.TriggerEvent ( clicked!)

dw_pedidos_pendientes.setrow(fila - 1)
dw_pedidos_pendientes.ScrollToRow(fila - 1)    

return 1
end function

public subroutine f_calculo_disponiblilidad (ref datastore ds_datos, string ls_filtro_cliente, string ls_filtro_envio);string ls_sel,ls_find
long ll_indice,ll_total,ll_donde,ll_rows,ll_rows_datos_planificacion,ll_donde_datos_planificacion
dec  ld_disponible,ld_planificado 
datetime ldt_fecha_fin_planificacion_minima,ldt_fecha_fin_planificacion_maxima

datastore ds_datos_planificacion
pointer oldpointer

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
		  "GROUP BY venliped.articulo, "+&
		  "		 articulos.familia "+&
		  "ORDER BY venliped.articulo "
	
ll_rows_datos_planificacion = f_cargar_cursor_transaccion(sqlca,ds_datos_planificacion,ls_sel)

ds_datos.setfilter("venliped_situacion = 'F'")
ds_datos.filter()

ll_total = ds_datos.rowcount()

for ll_indice = 1 to ll_total

	if ds_datos.object.disponible[ll_indice] = -1 then
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
		if ds_datos.object.articulos_familia[ll_indice] = '2' then
			ds_datos.object.planificado[ll_indice]                    = ld_planificado
			setnull(ldt_fecha_fin_planificacion_minima)
			setnull(ldt_fecha_fin_planificacion_maxima)			
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
							
		ls_find = "articulo = '"+ds_datos.object.venliped_articulo[ll_indice]+"' and "+&
					 "calidad = '"+ds_datos.object.venliped_calidad[ll_indice]+"' and "+&
					 "tipo_pallet = '"+ds_datos.object.venliped_tipo_pallet[ll_indice]+"' and "+&
					 "caja = '"+ds_datos.object.venliped_caja[ll_indice]+"' "	
								 
		ll_donde = ll_indice																					
		do
			ll_donde ++
			ll_donde = ds_datos.find(ls_find,ll_donde,ll_total)
			if ll_donde > 0 then
				//Planificado					
				if ds_datos.object.articulos_familia[ll_indice] = '2' then
					ds_datos.object.planificado[ll_donde]                    = ds_datos.object.planificado[ll_indice]
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

ds_datos.setfilter("")
ds_datos.filter()

SetPointer(oldpointer)
end subroutine

event open;call super::open;dw_updatea_venliped.visible = false
dw_updatea_venliped.settransobject(sqlca)

istr_parametros.s_titulo_ventana = "Mantenimiento de Ordenes de Carga [ "+f_nombre_empresa(codigo_empresa)+" ]"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

dw_pedidos_pendientes.settransobject(sqlca)

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
		dw_1.Retrieve(codigo_empresa,sle_valor.text)
	END IF
END IF
end event

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"id",long(sle_valor.text))
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"fecha",datetime(today()))
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

f_cargar_pedidos()
f_cargar_lineas_orden_carga()

CALL Super::ue_recuperar



end event

on wi_mant_alm_orden_carga_old.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.p_imprimir_pendientes=create p_imprimir_pendientes
this.dw_lineas_orden=create dw_lineas_orden
this.dw_pedidos_pendientes=create dw_pedidos_pendientes
this.p_1=create p_1
this.dw_updatea_venliped=create dw_updatea_venliped
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.p_imprimir_pendientes
this.Control[iCurrent+3]=this.dw_lineas_orden
this.Control[iCurrent+4]=this.dw_pedidos_pendientes
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.dw_updatea_venliped
end on

on wi_mant_alm_orden_carga_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.p_imprimir_pendientes)
destroy(this.dw_lineas_orden)
destroy(this.dw_pedidos_pendientes)
destroy(this.p_1)
destroy(this.dw_updatea_venliped)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_actualiza_dw;long ll_Rows

ll_Rows = dw_updatea_venliped.ModifiedCount()
dw_updatea_venliped.AcceptText()

if dw_updatea_venliped.update(true) = 1 then
	call super::ue_actualiza_dw
else
	rollback;
	messagebox("¡Error!","Se ha producido un error al actualizar las lineas de los pedidos.")
end if
end event

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_alm_orden_carga_old
integer x = 14
integer y = 96
integer width = 3474
integer height = 852
boolean titlebar = true
string title = "Cabecera Orden"
string dataobject = "dw_mant_alm_orden_carga"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::itemchanged;call super::itemchanged;string ls_cliente,ls_envio
int    li_existe

choose case dwo.name 
	case "cliente"
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
			parent.post f_cargar_pedidos()
		end if
	case "envio"		
		
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
			parent.post f_cargar_pedidos()
		end if
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
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 
 CALL Super::rbuttondown
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_alm_orden_carga_old
integer x = 23
integer y = 8
integer width = 123
string text = "ID"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_alm_orden_carga_old
integer x = 2281
integer y = 0
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_alm_orden_carga_old
integer x = 2683
integer y = 0
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_alm_orden_carga_old
integer x = 146
integer y = 4
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
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_alm_orden_carga_old
integer x = 3086
integer y = 0
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_alm_orden_carga_old
end type

type pb_calculadora from u_calculadora within wi_mant_alm_orden_carga_old
integer x = 425
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

ll_id = f_contador_automatico("cnt_alm_orden_carga",1)

sle_valor.text = string(ll_id)

dw_1.TriggerEvent("Clicked")
end event

type p_imprimir_pendientes from picture within wi_mant_alm_orden_carga_old
integer x = 3296
integer y = 968
integer width = 101
integer height = 88
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\Print_24x24.png"
boolean border = true
boolean focusrectangle = false
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

type dw_lineas_orden from u_datawindow within wi_mant_alm_orden_carga_old
integer x = 3493
integer y = 96
integer width = 3474
integer height = 3548
integer taborder = 21
boolean titlebar = true
string title = "Lineas Orden"
string dataobject = "dw_mant_alm_orden_carga3"
boolean vscrollbar = true
end type

event clicked;call super::clicked;string ls_objeto_y_row
long   ll_row,ll_total,ll_anyo,ll_pedido,ll_donde

if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
else
	choose case dwo.name
		case "p_todo"
			ll_total = this.rowcount()
			
			if ll_total > 0 then
				this.setredraw(false)
				
				ll_total = this.rowcount()
				
				if ll_total > 0 then
					for ll_row = 1 to ll_total					
						ll_donde = dw_pedidos_pendientes.find("empresa = '"+this.object.empresa[ll_row]+"' and anyo = "+string(this.object.anyo[ll_row],"###0")+" and pedido = "+string(this.object.pedido[ll_row],"#######0")+" and linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
						if ll_donde > 0 then
							dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = 0
						end if
						
						ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
						
						if ll_donde > 0 then
							dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde]      = 0
							dw_updatea_venliped.object.venliped_ordenacion_orden_carga[ll_donde]  = 0
							dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = 0
							dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = 0
						end if
	
					next
				end if		
				
				
				this.rowsmove(1,ll_total,Primary!,this,1,Delete!)
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
					for ll_row = 1 to ll_total					
						ll_donde = dw_pedidos_pendientes.find("empresa = '"+this.object.empresa[ll_row]+"' and anyo = "+string(this.object.anyo[ll_row],"###0")+" and pedido = "+string(this.object.pedido[ll_row],"#######0")+" and linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
						if ll_donde > 0 then
							dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = 0
						end if
						
						ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
						
						if ll_donde > 0 then
							dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde]      = 0
							dw_updatea_venliped.object.venliped_ordenacion_orden_carga[ll_donde]  = 0
							dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = 0
							dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = 0
						end if
	
					next				
					
					this.setredraw(false)
					this.rowsmove(1,ll_total,Primary!,this,1,Delete!)
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
			this.setredraw(false)
			ll_donde = dw_pedidos_pendientes.find("empresa = '"+this.object.empresa[row]+"' and anyo = "+string(this.object.anyo[row],"###0")+" and pedido = "+string(this.object.pedido[row],"#######0")+" and linea = "+string(this.object.linea[row],"###0"),1,il_rows_dw_updatea_venliped)
			if ll_donde > 0 then
				dw_pedidos_pendientes.object.id_alm_orden_carga[ll_donde] = 0
			end if
			
			ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[row]+"' and venliped_anyo = "+string(this.object.anyo[row],"###0")+" and venliped_pedido = "+string(this.object.pedido[row],"#######0")+" and venliped_linea = "+string(this.object.linea[row],"###0"),1,il_rows_dw_updatea_venliped)
			
			if ll_donde > 0 then
				dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde]      = 0
				dw_updatea_venliped.object.venliped_ordenacion_orden_carga[ll_donde]  = 0
				dw_updatea_venliped.object.venliped_bulto_desde_orden_carga[ll_donde] = 0
				dw_updatea_venliped.object.venliped_bulto_hasta_orden_carga[ll_donde] = 0
			end if					
			this.rowsmove(row,row,Primary!,this,1,Delete!)
			this.sort()
			this.groupcalc()
			this.setredraw(true)		
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

type dw_pedidos_pendientes from u_datawindow within wi_mant_alm_orden_carga_old
integer x = 14
integer y = 956
integer width = 3474
integer height = 2688
integer taborder = 11
boolean titlebar = true
string title = "Pedidos Pendientes"
string dataobject = "dw_mant_alm_orden_carga2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;string ls_objeto_y_row
long   ll_row,ll_total,ll_anyo,ll_pedido,ll_id_alm_orden_carga,ll_donde,ll_row_scroll

if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
else
	this.setredraw(false)
	
	ll_row_scroll = long(this.Object.DataWindow.FirstRowOnPage)
	ll_id_alm_orden_carga = dw_1.object.id[1]
	
	choose case dwo.name
		case "p_todo"
			this.setfilter("id_alm_orden_carga = 0 and situacion <> 'F'")
			this.filter()
			
			ll_total = this.rowcount()
			
			if ll_total > 0 then
				for ll_row = 1 to ll_total					
					this.object.id_alm_orden_carga[ll_row] = ll_id_alm_orden_carga
					
					ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
					
					if ll_donde > 0 then
						dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde] = ll_id_alm_orden_carga
					end if

				next
				dw_lineas_orden.setredraw(false)
				this.rowscopy(1,ll_total,Primary!,dw_lineas_orden,1,Primary!)
				dw_lineas_orden.sort()
				dw_lineas_orden.groupcalc()
				dw_lineas_orden.setredraw(true)
			end if		
	
			this.setfilter("")
			this.filter()		
		case "p_pedido"		
			ls_objeto_y_row = getobjectatpointer()
			ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))		
			
			if ll_row > 0 then
				ll_anyo   = this.object.anyo[ll_row]
				ll_pedido = this.object.pedido[ll_row]
				
				this.setredraw(false)
				this.setfilter("anyo = "+string(ll_anyo,"#####0")+" and pedido = "+string(ll_pedido,"#####0")+" and id_alm_orden_carga = 0 and situacion <> 'F'")
				this.filter()
				
				ll_total = this.rowcount()
				
				if ll_total > 0 then
					for ll_row = 1 to ll_total
						this.object.id_alm_orden_carga[ll_row] = ll_id_alm_orden_carga
						ll_donde = dw_updatea_venliped.find("venliped_empresa = '"+this.object.empresa[ll_row]+"' and venliped_anyo = "+string(this.object.anyo[ll_row],"###0")+" and venliped_pedido = "+string(this.object.pedido[ll_row],"#######0")+" and venliped_linea = "+string(this.object.linea[ll_row],"###0"),1,il_rows_dw_updatea_venliped)
						
						if ll_donde > 0 then
							dw_updatea_venliped.object.venliped_id_alm_orden_carga[ll_donde] = ll_id_alm_orden_carga
						end if

					next				
					dw_lineas_orden.setredraw(false)
					this.rowscopy(1,ll_total,Primary!,dw_lineas_orden,1,Primary!)
					dw_lineas_orden.sort()
					dw_lineas_orden.groupcalc()
					dw_lineas_orden.setredraw(true)
				end if					
				
				this.setfilter("")
				this.filter()
				this.sort()
				this.groupcalc()
				this.scrolltorow(ll_row)
				this.setredraw(true)
				
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
	
	this.ScrollToRow ( ll_row_scroll )
	
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
		if messagebox("Atención", "Se va a modificar la cantidad del pedido. ¿Desea Continuar?", Exclamation!, YesNo!, 2)  = 1 then
			post f_post_itemchanged( row, dwo, data)
		else
			return 2
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

type p_1 from picture within wi_mant_alm_orden_carga_old
integer x = 6775
integer y = 108
integer width = 101
integer height = 88
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\Print_24x24.png"
boolean border = true
boolean focusrectangle = false
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = dw_lineas_orden.title
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

u_imp.event ue_imprimir(dw_lineas_orden)

destroy u_imp

end event

type dw_updatea_venliped from datawindow within wi_mant_alm_orden_carga_old
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

