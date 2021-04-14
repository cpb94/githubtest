$PBExportHeader$wtc_entradas_almacen_ventas.srw
forward
global type wtc_entradas_almacen_ventas from window
end type
type cbx_descontar_cajas from checkbox within wtc_entradas_almacen_ventas
end type
type dw_stock from datawindow within wtc_entradas_almacen_ventas
end type
type dw_pedidos from datawindow within wtc_entradas_almacen_ventas
end type
type dw_observaciones from datawindow within wtc_entradas_almacen_ventas
end type
type pb_nuevo from picturebutton within wtc_entradas_almacen_ventas
end type
type dw_detalle from datawindow within wtc_entradas_almacen_ventas
end type
type dw_movimientos from u_dw within wtc_entradas_almacen_ventas
end type
type pb_grabar from picturebutton within wtc_entradas_almacen_ventas
end type
type pb_salir from picturebutton within wtc_entradas_almacen_ventas
end type
type dp_fecha from datepicker within wtc_entradas_almacen_ventas
end type
type st_1 from statictext within wtc_entradas_almacen_ventas
end type
type st_2 from statictext within wtc_entradas_almacen_ventas
end type
end forward

global type wtc_entradas_almacen_ventas from window
integer width = 5655
integer height = 3380
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_cerrar_sin_abrir ( )
cbx_descontar_cajas cbx_descontar_cajas
dw_stock dw_stock
dw_pedidos dw_pedidos
dw_observaciones dw_observaciones
pb_nuevo pb_nuevo
dw_detalle dw_detalle
dw_movimientos dw_movimientos
pb_grabar pb_grabar
pb_salir pb_salir
dp_fecha dp_fecha
st_1 st_1
st_2 st_2
end type
global wtc_entradas_almacen_ventas wtc_entradas_almacen_ventas

type variables
str_colisiones param_colisiones

// Transaccion global de la ventana
transaction transaccion

long id_ventana_activa
boolean cerrar_sin_abrir
long permiso_ventana


end variables

forward prototypes
public function integer f_guardar ()
public function boolean hay_cambios ()
public function boolean f_insertar_movimiento ()
public function integer f_comprobar_campos_obligatorios ()
public function integer f_calcula_orden (transaction mi_transaccion)
public function integer f_insertar_movimiento_cajas_ventas (ref transaction mi_transaccion)
public subroutine f_calcular_pallets_caja (long pallets_intro, long cajas_intro, long piezas_intro)
public subroutine f_mostrar_bultos_destino ()
end prototypes

event ue_cerrar_sin_abrir();if cerrar_sin_abrir = true then
	close(this)
end if
end event

public function integer f_guardar ();long i, total_cajas
string campo, motivo
boolean falta_Campo, aceptado
string cod_inkcid, cod_inkcid2, inkcid, trabajo, dato
string v_coleccion
string fecha
string articulo, gestion_tono, gestion_calibre
string nuevo_codigo, uso
int rtn
boolean marcado	
str_ventana_alerta parametros
string botones[2]
string promocion

fecha = string (dp_fecha.value,'dd/mm/yyyy')
rtn = 1

dw_movimientos.SetTransObject(trans_ts)					
dw_observaciones.SetTransObject(trans_ts)								

if fecha <> String(today(), "dd/mm/yyyy") then
	parametros.titulo = "Atención"
	parametros.subtitulo = "Fecha Movimiento"
	parametros.mensaje = "La fecha del movimiento es distinta a la fecha actual, ¿desea continuar?"
	parametros.tipo = 2
	botones[1] = "Sí"
	botones[2] = "No"
	parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	if Int(Message.DoubleParm) <> 1 then
		return 0
	end if
end if

//HAY QUE PEDIR CAJA

/*
uso = dw_movimientos.object.articulos_uso[dw_movimientos.GetRow()] 
total_cajas = dw_movimientos.object.cajas[dw_movimientos.GetRow()]
if uso = '3' and total_cajas > 0 then
	dw_comlinubica.visible = true
	dw_comlinubica.retrieve(codigo_empresa, f_codigo_compras_caja ( codigo_empresa, dw_movimientos.object.caja[dw_movimientos.getrow( )] ) )
	
	if dw_comlinubica.rowcount() = 1 then
		dw_comlinubica.object.marcado[dw_comlinubica.getrow()] = 1
	end if
	
else
		dw_comlinubica.reset()
		dw_comlinubica.visible = false
end if	
*/
if f_comprobar_campos_obligatorios( ) = 0 then
	return 0
end if

dw_movimientos.accepttext()

//Codigo por si se desea mostrar aviso antes de guardar (Por defecto NO, si no utilizar Message.DoubleParm = 10001)



// Hacemos la salida de las cajas consumidas en el almacén de compras si hay alguna ubicación marcada.

IF rtn = 1 then
	/*
	if dw_comlinubica.rowcount() > 0 THEN   // Con caja
		marcado = false
		for i = 1 to dw_comlinubica.rowcount()
			if dw_comlinubica.object.marcado[i] = 1 then
				marcado = true
			end if
		next
		
		if marcado then
			if f_insertar_movimiento_cajas(trans_ts) = 0 then
				messagebox("Error", "No se ha realizado el movimiento de cajas")
				rtn = 0
			end if
		else 
			rtn = 0
			MessageBox("Aviso", "No ha marcado ninguna ubicación de cajas.",  Exclamation!) 			
		end if
	end if
	*/


	uso = dw_movimientos.object.articulos_uso[dw_movimientos.getrow()] 			
	promocion = dw_movimientos.object.articulos_promocion[dw_movimientos.getrow()] 			
	if promocion <> 'S' and cbx_descontar_cajas.checked then
		if uso = '3' and dw_movimientos.object.cajas[dw_movimientos.getrow()] > 0 and ( dw_movimientos.object.tipomov[dw_movimientos.getrow()] = '1' or dw_movimientos.object.tipomov[dw_movimientos.getrow()] = '3' ) then	
			if f_insertar_movimiento_cajas_ventas(trans_ts) = 0 then
				messagebox("Error", "No se ha realizado el movimiento de cajas")
				rtn = 0
			end if		
		end if
	end if
	
	if dw_movimientos.rowcount() > 0 and rtn = 1 then
		str_movimiento_almacen lstr_movimiento_almacen
		
		lstr_movimiento_almacen.empresa            = codigo_empresa//dw_movimientos.object.empresa[dw_movimientos.getrow()]
		lstr_movimiento_almacen.articulo           = dw_movimientos.object.articulo[dw_movimientos.getrow()]
		lstr_movimiento_almacen.calidad            = dw_movimientos.object.calidad[dw_movimientos.getrow()]
		lstr_movimiento_almacen.tono               = dw_movimientos.object.tono[dw_movimientos.getrow()]
		lstr_movimiento_almacen.calibre            = dw_movimientos.object.calibre[dw_movimientos.getrow()]
		lstr_movimiento_almacen.tipo_pallet        = dw_movimientos.object.tipo_pallet[dw_movimientos.getrow()]
		lstr_movimiento_almacen.caja               = dw_movimientos.object.caja[dw_movimientos.getrow()]
		lstr_movimiento_almacen.cantidad           = dw_movimientos.object.cantidade[dw_movimientos.getrow()]
		lstr_movimiento_almacen.orden_carga_anyo   = 0
		lstr_movimiento_almacen.orden_carga_codigo = ""
		lstr_movimiento_almacen.orden_carga_linea  = 0
		lstr_movimiento_almacen.tipo_movimiento    = dw_movimientos.object.tipomov[dw_movimientos.getrow()]
		lstr_movimiento_almacen.observaciones      = dw_movimientos.object.observaciones[dw_movimientos.getrow()]
		lstr_movimiento_almacen.almacen            = dw_movimientos.object.almacen[dw_movimientos.getrow()]
		lstr_movimiento_almacen.zona               = dw_movimientos.object.zona[dw_movimientos.getrow()]
		lstr_movimiento_almacen.fila               = dw_movimientos.object.fila[dw_movimientos.getrow()]
		lstr_movimiento_almacen.altura             = dw_movimientos.object.altura[dw_movimientos.getrow()]
		lstr_movimiento_almacen.tercero            = ""
		lstr_movimiento_almacen.documento          = ""
		lstr_movimiento_almacen.fecha              = datetime(dw_movimientos.object.fecha_mov[dw_movimientos.getrow()])
		lstr_movimiento_almacen.id_ubicacion       = 0
		lstr_movimiento_almacen.id_alm_bultos		 = dw_observaciones.object.id_bulto_destino[dw_observaciones.getrow()]
		
		//Introduce pallet a pallet
		if f_movimiento_almacen(lstr_movimiento_almacen) then
			rtn = 1
			//dw_movimientos.object.orden[dw_movimientos.getrow()] = long ( nuevo_codigo ) 

			//rtn = dw_movimientos.Update() 
			
			// Guardamos las observaciones por artículo y ubicación
			dw_observaciones.accepttext()
			if rtn = 1 then
				if dw_observaciones.object.observaciones[dw_observaciones.getrow( )] <> '' and not isnull (dw_observaciones.object.observaciones[dw_observaciones.getrow( )]) then
					dw_observaciones.object.empresa[dw_observaciones.getrow( )] = codigo_empresa
					dw_observaciones.object.almacen[dw_observaciones.getrow( )] = dw_movimientos.object.almacen[dw_movimientos.getrow()] 
					dw_observaciones.object.zona[dw_observaciones.getrow( )] = dw_movimientos.object.zona[dw_movimientos.getrow()] 
					dw_observaciones.object.fila[dw_observaciones.getrow( )] = dw_movimientos.object.fila[dw_movimientos.getrow()] 
					dw_observaciones.object.altura[dw_observaciones.getrow( )] = dw_movimientos.object.altura[dw_movimientos.getrow()] 
					dw_observaciones.object.articulo[dw_observaciones.getrow( )] = dw_movimientos.object.articulo[dw_movimientos.getrow()] 
					dw_observaciones.object.calidad[dw_observaciones.getrow( )] = dw_movimientos.object.calidad[dw_movimientos.getrow()] 
					dw_observaciones.object.tono[dw_observaciones.getrow( )] = dw_movimientos.object.tono[dw_movimientos.getrow()] 
					dw_observaciones.object.calibre[dw_observaciones.getrow( )] = dw_movimientos.object.calibre[dw_movimientos.getrow()] 
					dw_observaciones.object.tipo_pallet[dw_observaciones.getrow( )] = dw_movimientos.object.tipo_pallet[dw_movimientos.getrow()] 
					dw_observaciones.object.caja[dw_observaciones.getrow( )] = dw_movimientos.object.caja[dw_movimientos.getrow()] 
					
					rtn = dw_observaciones.Update() 
				end if
			end if
		else
			rtn = 0
		end if
	end if
end if

IF rtn = 1 THEN
	COMMIT USING sqlca;
	COMMIT USING trans_ts;
	
	string ls_articulo,ls_calidad,ls_tono,ls_tipo_pallet,ls_caja
	int    li_calibre
	dec    ld_disponible
	
	//Asignamos el stock a pedidos
	ls_articulo    = dw_movimientos.object.articulo[dw_movimientos.getrow()] 
	ls_calidad     = dw_movimientos.object.calidad[dw_movimientos.getrow()] 
	ls_tono        = dw_movimientos.object.tono[dw_movimientos.getrow()] 
	li_calibre     = dw_movimientos.object.calibre[dw_movimientos.getrow()] 
	ls_tipo_pallet = dw_movimientos.object.tipo_pallet[dw_movimientos.getrow()] 
	ls_caja        = dw_movimientos.object.caja[dw_movimientos.getrow()] 	
	
	ld_disponible = f_disponible_art_cal_to_ca_tp_c(codigo_empresa,ls_articulo,ls_calidad,ls_tono,li_calibre,ls_tipo_pallet,ls_caja)
	
	//Ya no se hace la asignacion automatica
	if ld_disponible > 0 and f_promocion_articulo(codigo_empresa,ls_articulo) = 'N' and 0 = 1 then
		//Asignamos stock a pedidos
		string  ls_sel,ls_referencia,ls_calibre_imprimir 
		long    ll_indice,ll_total,ll_pedido,ll_linea
		int     li_anyo
		dec     ld_cantidad_pedido
		boolean lb_replicar_tono_calibre
		datastore ds_datos
		
		if f_familias_replica_tono_calibre(codigo_empresa,f_familia_articulo(codigo_empresa,ls_articulo)) = 'S' then
			lb_replicar_tono_calibre = true
			
			ls_calibre_imprimir = string(li_calibre,"##")
		else
			lb_replicar_tono_calibre = false
		end if				
		
		ls_referencia = f_componer_ref(ls_articulo,ls_calidad,ls_tono,li_calibre)
		
		ls_sel = "SELECT isnull(venliped.anyo,0) as anyo,"+&
					"       isnull(venliped.pedido,0) as pedido,"+&
					"       sum(venliped.cantidad) as cantidad_pedido, "+&
					"       'N' as asignado "+&
					"FROM   venped, "+&
					"       venliped "+&
					"WHERE  venped.empresa = venliped.empresa "+&
					"AND    venped.anyo    = venliped.anyo "+&
					"AND    venped.pedido  = venliped.pedido "+&
					"AND    venped.empresa = '"+codigo_empresa+"' "+&
					"AND    venped.es_proforma   = 'N' "+&
					"AND    venliped.articulo    = '"+ls_articulo+"' "+&
					"AND    venliped.calidad     = '"+ls_calidad+"' "+&
					"AND    venliped.tipo_pallet = '"+ls_tipo_pallet+"' "+&
					"AND    venliped.caja        = '"+ls_caja+"' "+&
					"AND    venliped.situacion   = 'F' "+&
					"GROUP BY venliped.anyo,"+&
					"         venliped.pedido "+&
					"ORDER BY venliped.anyo,"+&
					"         venliped.pedido"
					
//					"       isnull(venliped.linea,0) as linea,"+&					
					
//					"AND    venliped.tonochar    = '"+ls_tono+"' "+&
//					"AND    venliped.calibre     = "+string(li_calibre,"0")+" "+&					
										
//					"         venliped.linea "+&					

//					"         venliped.linea "

		ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice = 1 to ll_total
			f_mensaje_proceso("Asignando Stock a Pedidos",ll_indice,ll_total)	
			
			ld_cantidad_pedido = ds_datos.object.cantidad_pedido[ll_indice]
			ld_disponible      = f_disponible_art_cal_to_ca_tp_c(codigo_empresa,ls_articulo,ls_calidad,ls_tono,li_calibre,ls_tipo_pallet,ls_caja)
			if ld_disponible >= ld_cantidad_pedido then
				li_anyo   = ds_datos.object.anyo[ll_indice]
				ll_pedido = ds_datos.object.pedido[ll_indice]
//				ll_linea  = ds_datos.object.linea[ll_indice]
				
				if lb_replicar_tono_calibre then										
					UPDATE venliped
					set    situacion        = 'C',
							tonochar         = :ls_tono,
							calibre          = :li_calibre,
							referencia       = :ls_referencia,
							tono_imprimir    = :ls_tono,
							calibre_imprimir = :ls_calibre_imprimir 
					WHERE  venliped.empresa     = :codigo_empresa
					AND    venliped.anyo        = :li_anyo
					AND    venliped.pedido      = :ll_pedido
					AND    venliped.articulo    = :ls_articulo
					AND    venliped.calidad     = :ls_calidad
					AND    venliped.tipo_pallet = :ls_tipo_pallet
					AND    venliped.caja        = :ls_caja
					AND    venliped.situacion   = 'F';
					
				else
					UPDATE venliped
					set    situacion  = 'C',
							tonochar   = :ls_tono,
							calibre    = :li_calibre,
							referencia = :ls_referencia 
					WHERE  venliped.empresa     = :codigo_empresa
					AND    venliped.anyo        = :li_anyo
					AND    venliped.pedido      = :ll_pedido
					AND    venliped.articulo    = :ls_articulo
					AND    venliped.calidad     = :ls_calidad
					AND    venliped.tipo_pallet = :ls_tipo_pallet
					AND    venliped.caja        = :ls_caja
					AND    venliped.situacion   = 'F';
					
				end if
				
//				AND    venliped.linea       = :ll_linea	

//				AND    venliped.tonochar    = :ls_tono
//				AND    venliped.calibre     = :li_calibre
				
				if sqlca.sqlcode <> 0 then
					rollback;
				else
					commit;
					ds_datos.object.asignado[ll_indice] = 'S'
				end if
			end if
		next
		
		destroy ds_datos
	end if
	
ELSE
	ROLLBACK USING sqlca;
	ROLLBACK USING trans_ts;
	messagebox ("Error", "No se pudo guardar el movimiento")
END IF

dw_movimientos.Settransobject(SQLCA)
dw_observaciones.Settransobject(SQLCA)

if rtn = 1 then
	dw_movimientos.reset()
	dw_observaciones.reset()
	dw_pedidos.reset()
	f_insertar_movimiento()
	
	dw_detalle.retrieve (datetime (date(dp_fecha.value)) )
	dw_detalle.setsort( "orden D")
	dw_detalle.sort( )
	dw_movimientos.setfocus()
	dw_movimientos.SetColumn("tipomov")
end if

return rtn




end function

public function boolean hay_cambios ();Boolean resultado
resultado = false



dw_movimientos.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco

if dw_movimientos.object.tipomov[1] <> '' or not isnull (dw_movimientos.object.tipomov[1]) then 
		resultado = true
end if
/*
if dw_movimientos.DeletedCount() + dw_movimientos.ModifiedCount() > 0 then
	resultado = true
end if
*/
return resultado


end function

public function boolean f_insertar_movimiento ();dw_movimientos.insertrow( 0)
dw_movimientos.object.empresa[dw_movimientos.getrow( )] = codigo_empresa
dw_movimientos.object.fecha_mov[dw_movimientos.getrow( )] = datetime (dp_fecha.value) 
dw_movimientos.object.fecha_intr[dw_movimientos.getrow( )] = today()
//dw_movimientos.object.familia[dw_movimientos.getrow( )] = '1'
//dw_movimientos.object.calidad[dw_movimientos.getrow( )] = '1'
dw_movimientos.object.tipo_unidad[dw_movimientos.getrow( )] = '0' //DE momento, solo trabajamos a nivel de almacen en piezas. (se hacen conversiones en expedición)
dw_movimientos.object.cantidads[dw_movimientos.getrow( )] = 0
dw_movimientos.object.usuario[dw_movimientos.getrow( )] = nombre_usuario
dw_movimientos.object.origen[dw_movimientos.getrow( )] = ''
dw_movimientos.object.trazabilidad[dw_movimientos.getrow( )] = ''
if isnull(dw_movimientos.object.tono[dw_movimientos.getrow( )]) then
	dw_movimientos.object.tono[dw_movimientos.getrow( )] = ''
end if
if isnull(dw_movimientos.object.calibre[dw_movimientos.getrow( )]) then
	dw_movimientos.object.calibre[dw_movimientos.getrow( )] = 0
end if

return true
end function

public function integer f_comprobar_campos_obligatorios ();boolean falta_Campo
string campo, motivo
string articulo, gestion_tono, gestion_calibre, familia = ""
long i
string fila_desde, fila_hasta, almacen, zona, altura_desde, altura_hasta

str_ventana_alerta parametros
string botones[2]

// Campos obligatorios dw_movimientos 

if dw_movimientos.RowCount() < 1 then
	messagebox("Aviso", 'No se ha introducido ningún movimiento')
	return 0
end if


dw_movimientos.accepttext()
falta_campo = false
IF dw_movimientos.rowcount() > 0 THEN
	falta_campo = false
	i = 1
	DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
		IF IsNull(dw_movimientos.object.tipomov[i]) or Trim(String(dw_movimientos.object.tipomov[i]))="" THEN
			  campo="tipomov"
			  motivo  = "Campo Obligatorio: Introduzca el tipo de movimiento."
			  falta_campo = True
		ELSE 
			falta_campo = false
		END IF
		i++
	LOOP
	
	if not falta_campo then
		i = 1
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			IF IsNull(dw_movimientos.object.articulo[i]) or Trim(String(dw_movimientos.object.articulo[i]))="" THEN
				  campo="articulo"
				  motivo  = "Campo Obligatorio: Introduzca el artículo."
				  falta_campo = True
			ELSEIF IsNull(dw_movimientos.object.calidad[i]) or Trim(String(dw_movimientos.object.calidad[i]))="" THEN
				  campo="calidad"
				  motivo  = "Campo Obligatorio: Introduzca la calidad."
				  falta_campo = True
			ELSE 
				falta_campo = false
			END IF
			
			i++
		LOOP
	end if

	// Control de tono
	if not falta_campo then
		i = 1
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			articulo = dw_movimientos.object.articulo[i]
			select tono
			into :gestion_tono
			from articulos
			where empresa = :codigo_empresa
			and codigo = :articulo;
			
			IF gestion_tono = 'S' and ( IsNull(dw_movimientos.object.tono[i]) or Trim(String(dw_movimientos.object.tono[i]))="" ) THEN
				  campo="tono"
				  motivo  = "Campo Obligatorio: Introduzca el tono."
				  falta_campo = True
			ELSE 
				falta_campo = false
			END IF
			i++
		LOOP
	end if

	// Control de Calibre
	if not falta_campo then
		i = 1
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			articulo = dw_movimientos.object.articulo[i]
			select calibre
			into :gestion_calibre
			from articulos
			where empresa = :codigo_empresa
			and codigo = :articulo;
			
			IF gestion_calibre = 'S' and ( IsNull(dw_movimientos.object.Calibre[i]) or Trim(String(dw_movimientos.object.Calibre[i]))="" ) THEN
				  campo="Calibre"
				  motivo  = "Campo Obligatorio: Introduzca el Calibre."
				  falta_campo = True
			ELSE 
				falta_campo = false
			END IF
			i++
		LOOP
	end if

	if not falta_campo then
		i = 1		
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			IF IsNull(dw_movimientos.object.tipo_pallet[i]) or Trim(String(dw_movimientos.object.tipo_pallet[i]))="" THEN
				  campo="tipo_pallet"
				  motivo  = "Campo Obligatorio: Introduzca el Tipo de Pallet."
				  falta_campo = True
			ELSE 
				falta_campo = false
			END IF
			i++
		LOOP
	end if

	if not falta_campo then
		i = 1		
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			
			IF IsNull(dw_movimientos.object.caja[i]) or Trim(String(dw_movimientos.object.caja[i]))="" THEN
				  campo="caja"
				  motivo  = "Campo Obligatorio: Introduzca la caja."
				  falta_campo = True
			ELSE 
				falta_campo = false
			END IF
			i++
		LOOP
	end if
	
	if not falta_campo then
		i = 1		
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			
			IF IsNull(dw_movimientos.object.almacen[i]) or Trim(String(dw_movimientos.object.almacen[i]))="" THEN
				  campo="almacen"
				  motivo  = "Campo Obligatorio: Introduzca el almacén."
				  falta_campo = True
			ELSE 
				falta_campo = false
			END IF
			i++
		LOOP
	end if	
		
	if not falta_campo then
		i = 1		
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			articulo = dw_movimientos.object.articulo[i]
			familia = ""
			SELECT familia INTO:familia FROM articulos WHERE empresa = :codigo_empresa AND codigo = :articulo;
			IF IsNull(dw_movimientos.object.zona[i]) or Trim(String(dw_movimientos.object.zona[i]))="" THEN
				  campo="zona"
				  motivo  = "Campo Obligatorio: Introduzca la zona."
				  falta_campo = True
			ELSE 
				if dw_movimientos.object.zona[i] = "P" and familia = "2" then
					campo="zona"
					  motivo  = "Artículo de WOW: Utilice ordenes de preparación para entradas en zona de expedición."
					  falta_campo = True
				else
					falta_campo = false
				end if
			END IF
			i++
		LOOP
	end if			
	
	if not falta_campo then
		i = 1		
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			IF IsNull(dw_movimientos.object.fila[i]) or Trim(String(dw_movimientos.object.fila[i]))="" THEN
				  campo="fila"
				  motivo  = "Campo Obligatorio: Introduzca la fila."
				  falta_campo = True
			ELSE 
				falta_campo = false
			END IF
			i++
		LOOP
	end if		
	
	if not falta_campo then
		i = 1		
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			IF IsNull(dw_movimientos.object.altura[i]) or Trim(String(dw_movimientos.object.altura[i]))="" THEN
				  campo="altura"
				  motivo  = "Campo Obligatorio: Introduzca la altura."
				  falta_campo = True
			ELSE 
				falta_campo = false
			END IF
			i++
		LOOP
	end if					
		
	if not falta_campo then
		i = 1		
		DO WHILE ( i <= dw_movimientos.rowcount() AND NOT falta_campo )
			IF IsNull(dw_movimientos.object.cantidade[i]) or dw_movimientos.object.cantidade[i] = 0 THEN
				  campo="cantidade"
				  motivo  = "Campo Obligatorio: Introduzca la cantidad."
				  falta_campo = True
			ELSE 
				falta_campo = false
			END IF
			i++
		LOOP
	end if			
	
	if not falta_campo then
		almacen = dw_movimientos.object.almacen[dw_movimientos.getrow()]
		zona = dw_movimientos.object.zona[dw_movimientos.getrow()]
		
		select min(fila_desde), max(fila_hasta)
		into :fila_desde, :fila_hasta
		from almubimapa
		where empresa = :codigo_empresa
		and almacen = :almacen
		and zona = :zona;
		
		if dw_movimientos.object.fila[dw_movimientos.getrow()]  < long(fila_desde) or dw_movimientos.object.fila[dw_movimientos.getrow()] > long(fila_hasta) then
			campo="fila"
			motivo  = "No está definida esa fila para este almacén."
			falta_campo = True
		else
			falta_campo = false
		end if
	end if
	
	if not falta_campo then
		almacen = dw_movimientos.object.almacen[dw_movimientos.getrow()]
		zona = dw_movimientos.object.zona[dw_movimientos.getrow()]
		
		select min(altura_desde), max(altura_hasta)
		into :altura_desde, :altura_hasta
		from almubimapa
		where empresa = :codigo_empresa
		and almacen = :almacen
		and zona = :zona;
		
		if dw_movimientos.object.altura[dw_movimientos.getrow()]  < long(altura_desde) or dw_movimientos.object.altura[dw_movimientos.getrow()] > long(altura_hasta) then
			campo="altura"
			motivo  = "No está definida esa altura para este almacén."
			falta_campo = True
		else
			falta_campo = false
		end if
	end if
	
	IF falta_campo THEN
		MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
		dw_movimientos.setfocus()
		dw_movimientos.SetColumn(campo)
		return 0
	else
		return 1
	END IF
END IF





end function

public function integer f_calcula_orden (transaction mi_transaccion);string nuevo_orden
long i

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "comlinubicahis"
param_colisiones.campo = "orden"
param_colisiones.filtro = " anyo = '"+string(year(today()))+"' "
param_colisiones.buscar_huecos = false

//f_crear_transaccion(mi_transaccion ,"" ,"" ,false, "TS","")	
//CONNECT USING mi_transaccion;

nuevo_orden= f_colisiones ( mi_transaccion, param_colisiones)
if nuevo_orden = '0'  then
	messagebox("ERROR", "No se puede asignar un código.")
	return 0
else
	return long(nuevo_orden)	
end if



end function

public function integer f_insertar_movimiento_cajas_ventas (ref transaction mi_transaccion);// Devuelve 1 si es correcto
int rtn = 1
string caja_ventas,ls_articulo

str_movimiento_almacen lstr_movimiento_almacen

caja_ventas = dw_movimientos.object.caja[dw_movimientos.getrow()]
ls_articulo = f_codigo_ventas_caja( codigo_empresa, caja_ventas )

/*
com_ubihis.tipomov = '6'
com_ubihis.cantidads = dw_movimientos.object.cajas[1]
com_ubihis.zona = dw_comlinubica.object.comlinubica_zona[fila_actual]
com_ubihis.fila = dw_comlinubica.object.comlinubica_fila[fila_actual]
com_ubihis.altura = dw_comlinubica.object.comlinubica_altura[fila_actual]
com_ubihis.ubicacion = dw_comlinubica.object.comlinubica_ubicacion[fila_actual]
com_ubihis.anyo = year(date(String(dp_fecha.value)))	


if rtn = 1 then
	if not f_insert_commovhis_trans (com_mov, mi_transaccion) Then 
		rtn = 0
		messagebox("Error", "Error al insertar el movimiento en commovhis")			
	end if
end if

if rtn = 1 then
	if not f_insert_comlinubicahis_trans(com_ubihis, mi_transaccion) Then  
		rtn = 0
		messagebox("Error", "Error al insertar el movimiento en comlinubicahis")						
	end if
end if
*/

if trim(ls_articulo) <> "" then
	lstr_movimiento_almacen.empresa            = codigo_empresa
	lstr_movimiento_almacen.articulo           = ls_articulo
	lstr_movimiento_almacen.calidad            = "0"
	lstr_movimiento_almacen.tono               = ""
	lstr_movimiento_almacen.calibre            = 0
	lstr_movimiento_almacen.tipo_pallet        = "2"
	lstr_movimiento_almacen.caja               = "0"
	lstr_movimiento_almacen.cantidad           = dw_movimientos.object.cajas[1] * -1
	lstr_movimiento_almacen.orden_carga_anyo   = 0
	lstr_movimiento_almacen.orden_carga_codigo = ""
	lstr_movimiento_almacen.orden_carga_linea  = 0
	lstr_movimiento_almacen.tipo_movimiento    = "999"
	lstr_movimiento_almacen.observaciones      = ""
	lstr_movimiento_almacen.almacen            = "7"
	lstr_movimiento_almacen.zona               = "A"
	lstr_movimiento_almacen.fila               = 1
	lstr_movimiento_almacen.altura             = 1
	lstr_movimiento_almacen.tercero            = ""
	lstr_movimiento_almacen.documento          = ""
	lstr_movimiento_almacen.fecha              = datetime(dw_movimientos.object.fecha_mov[dw_movimientos.getrow()])
	lstr_movimiento_almacen.id_ubicacion       = 0
	lstr_movimiento_almacen.id_alm_bultos		 = 1//0 Siempre sacaremos el stock del bulto 1
	
	if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
		rtn = 0
	end if
end if

return rtn



end function

public subroutine f_calcular_pallets_caja (long pallets_intro, long cajas_intro, long piezas_intro);long pallets, cajas
Dec piezas, lineales, n_cajas, n_pallets, n_total
Int fila

string cod_caja, cod_articulo, cod_pallet, cod_formato, cod_unidad, ls_gestionar_en_piezas
Dec n_piezascaja, n_metroscaja, n_cajaspallet, total_cajas, total_cantidad, total_pallets, total_lineales, largo
string ls_almacen,ls_zona
int    li_fila,li_altura
fila = dw_movimientos.getrow()

n_pallets = pallets_intro
n_cajas = cajas_intro
n_total = piezas_intro
								
cod_articulo = dw_movimientos.object.articulo[fila]
cod_caja     = dw_movimientos.object.caja[fila]
cod_pallet   = dw_movimientos.object.tipo_pallet[fila]

ls_almacen = dw_movimientos.object.almacen[fila]
ls_zona    = dw_movimientos.object.zona[fila]
li_fila    = dw_movimientos.object.fila[fila]
li_altura  = dw_movimientos.object.altura[fila]

select isnull(almubimapa_codbar.gestionar_en_piezas,'') 
into  :ls_gestionar_en_piezas 
from  almubimapa_codbar 
where almubimapa_codbar.empresa = :codigo_empresa
and   almubimapa_codbar.almacen = :ls_almacen
and   almubimapa_codbar.zona    = :ls_zona
and	almubimapa_codbar.fila    = :li_fila
and	almubimapa_codbar.altura  = :li_altura;

//if ftc_calcular_unidades_almacen(codigo_empresa, dw_movimientos.object.articulo[fila], dw_movimientos.object.tipo_pallet[fila], &
//								dw_movimientos.object.caja[fila], pallets_intro, cajas_intro, piezas_intro, pallets, cajas, piezas, lineales) = 0 then	
//	dw_movimientos.object.pallets[1] = pallets
//	//dw_movimientos.object.cajas[1] = cajas
//	dw_movimientos.object.cantidade[1] = piezas
//else
//	dw_movimientos.object.pallets[1] = 0
//	//dw_movimientos.object.cajas[1] = 0
//	dw_movimientos.object.cantidade[1] = 0
//end if

SELECT  articulos.formato, articulos.unidad
INTO 	  	:cod_formato,:cod_unidad
FROM    	articulos
WHERE  articulos.empresa = :codigo_empresa
AND     	articulos.codigo  = :cod_articulo;

SELECT  almartcajas.piezascaja,almartcajas.metroscaja  
	INTO    	:n_piezascaja,:n_metroscaja  
	FROM    	almartcajas  
	WHERE  almartcajas.empresa   = :codigo_empresa
	AND     	almartcajas.articulo  = :cod_articulo
	AND     	almartcajas.caja      = :cod_caja;
	
if isnull(n_piezascaja) then n_piezascaja = 0
if isnull(n_metroscaja) then n_metroscaja = 0
	
n_metroscaja = round(n_metroscaja,2)

SELECT  palarticulo.cajaspallet			 
	INTO :n_cajaspallet
	FROM  palarticulo
	WHERE palarticulo.empresa  = :codigo_empresa
	AND   palarticulo.articulo = :cod_articulo
	AND   palarticulo.codigo   = :cod_pallet
	AND   palarticulo.caja     = :cod_caja;
	
if isnull(n_cajaspallet) then n_cajaspallet = 0

//EL ALMACEN SIEMPRE EN METROS

//  n_total=Dec(n_total)
IF n_total <> 0 THEN
	IF n_piezascaja = 0 or isnull(n_piezascaja) THEN 	
		total_cajas = 0											
	else	
		if ls_gestionar_en_piezas = 'S' or cod_unidad <> '1' then	
			//Gestion en piezas
			total_cantidad = n_total			
			
			// Quito el ceiling porque peta con Power Builder 12.5 y SQL 2008. David 07-02-2012
	//     		total_cajas = CEILING(n_total / n_piezascaja)  
			if mod (n_total , n_piezascaja ) =  0 then
				total_cajas = n_total / n_piezascaja 
			else
				total_cajas = n_total / n_piezascaja 
				total_cajas = truncate (total_cajas, 0)
				total_cajas ++
			end if
	
			cajas = TRUNCATE(n_total / n_piezascaja, 0)
			
			if n_cajaspallet > 0 then
				total_pallets  = truncate(total_cajas / n_cajaspallet,0) 
			else 
				total_pallets = 0
			end if
		else
			//Gestion em m2
			total_cantidad = n_total			
			
			// Quito el ceiling porque peta con Power Builder 12.5 y SQL 2008. David 07-02-2012
	//     		total_cajas = CEILING(n_total / n_piezascaja)  
			if mod (n_total , n_piezascaja ) =  0 then
				total_cajas = n_total / n_piezascaja 
			else
				total_cajas = n_total / n_piezascaja 
				total_cajas = truncate (total_cajas, 0)
				total_cajas ++
				
				n_total = total_cajas * n_piezascaja 
				total_cantidad = n_total
			end if
	
			cajas = TRUNCATE(n_total / n_piezascaja, 0)
			
			if n_cajaspallet > 0 then
				total_pallets  = truncate(total_cajas / n_cajaspallet,0) 
			else 
				total_pallets = 0
			end if						
		end if
	end if																
ELSE
	IF n_cajas <> 0 THEN
		total_cantidad = n_cajas * n_piezascaja
		total_cajas = n_cajas
		cajas = n_cajas
		IF n_cajaspallet <> 0 then
			total_pallets = truncate(n_cajas / n_cajaspallet,0) 
		ELSE
			total_pallets = 0
		END IF
	ELSE
		IF n_pallets <> 0 THEN
			cajas = TRUNCATE(n_pallets * n_cajaspallet, 0)
			total_cajas = cajas
			total_cantidad = cajas * n_piezascaja
			total_pallets = n_pallets
		END IF
	END IF
END IF

if cod_caja = "901" then //SIN CAJA
	cajas = 0
	total_cajas = 0
end if

dw_movimientos.object.pallets[1] = total_pallets
dw_movimientos.object.cajas[1] = cajas
dw_movimientos.object.cantidade[1] = total_cantidad

end subroutine

public subroutine f_mostrar_bultos_destino ();long    ll_id_ubicacion,ll_almubimapa_codbar_id_alm_bultos,ll_indice,ll_total
string  ls_almacen,ls_zona,ls_sel,ls_values
integer li_fila,li_altura

datastore ds_datos

ls_almacen = dw_movimientos.object.almacen[1]
ls_zona    = dw_movimientos.object.zona[1]
li_fila    = dw_movimientos.object.fila[1]
li_altura  = dw_movimientos.object.altura[1]

select isnull(almubimapa_codbar.id,0),
		 isnull(almubimapa_codbar.id_alm_bultos,0) 
into  :ll_id_ubicacion,
		:ll_almubimapa_codbar_id_alm_bultos 
from  almubimapa_codbar 
where almubimapa_codbar.empresa = :codigo_empresa
and   almubimapa_codbar.almacen = :ls_almacen
and   almubimapa_codbar.zona    = :ls_zona
and	almubimapa_codbar.fila    = :li_fila
and	almubimapa_codbar.altura  = :li_altura;

if ll_almubimapa_codbar_id_alm_bultos > 0 then
	ls_values = string(ll_almubimapa_codbar_id_alm_bultos,"0000000000")+"~t"+string(ll_almubimapa_codbar_id_alm_bultos,"##########")
	
	dw_observaciones.Object.id_bulto_destino.Values = ls_values
	dw_observaciones.Object.id_bulto_destino[1]     = ll_almubimapa_codbar_id_alm_bultos
else
	
	ls_sel = "SELECT isnull(alm_bultos.id,0) as id, "+&
				"		  sum(alm_bultos_lineas.cantidad) as cantidad "+&
				"FROM   alm_bultos, "+&
				"		  alm_bultos_lineas "+&
				"WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
				"AND   ( ( alm_bultos.empresa         = '"+codigo_empresa+"' ) "+&
				"AND     ( alm_bultos.id_ubicacion    = "+string(ll_id_ubicacion,"#########0")+" ) ) "+&
				"GROUP BY alm_bultos.id "+&
				"ORDER BY alm_bultos.id ASC"
	
	ls_values = "Nuevo~t0"	
	
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total
		ls_values += "/"+string(ds_datos.object.id[ll_indice],"0000000000")+" "+string(ds_datos.object.cantidad[ll_indice],"#####0")+"Pzs"+"~t"+string(ds_datos.object.id[ll_indice])
	next
	
	dw_observaciones.Object.id_bulto_destino.Values = ls_values
			
	dw_observaciones.Object.id_bulto_destino[1] = 0
			
	destroy ds_datos			
end if
end subroutine

on wtc_entradas_almacen_ventas.create
this.cbx_descontar_cajas=create cbx_descontar_cajas
this.dw_stock=create dw_stock
this.dw_pedidos=create dw_pedidos
this.dw_observaciones=create dw_observaciones
this.pb_nuevo=create pb_nuevo
this.dw_detalle=create dw_detalle
this.dw_movimientos=create dw_movimientos
this.pb_grabar=create pb_grabar
this.pb_salir=create pb_salir
this.dp_fecha=create dp_fecha
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.cbx_descontar_cajas,&
this.dw_stock,&
this.dw_pedidos,&
this.dw_observaciones,&
this.pb_nuevo,&
this.dw_detalle,&
this.dw_movimientos,&
this.pb_grabar,&
this.pb_salir,&
this.dp_fecha,&
this.st_1,&
this.st_2}
end on

on wtc_entradas_almacen_ventas.destroy
destroy(this.cbx_descontar_cajas)
destroy(this.dw_stock)
destroy(this.dw_pedidos)
destroy(this.dw_observaciones)
destroy(this.pb_nuevo)
destroy(this.dw_detalle)
destroy(this.dw_movimientos)
destroy(this.pb_grabar)
destroy(this.pb_salir)
destroy(this.dp_fecha)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;This.Title = "Entradas Almacén"

dw_movimientos.Settransobject( SQLCA)
dw_observaciones.Settransobject( SQLCA)
dw_pedidos.Settransobject( SQLCA)
dw_stock.Settransobject( SQLCA)

dw_detalle.Settransobject( SQLCA)
dw_detalle.retrieve ( datetime(date(dp_fecha.value)) )
dw_detalle.setsort( "orden D")
dw_detalle.sort( )

f_insertar_movimiento()

dw_movimientos.setfocus()



str_parametros lstr_param

cerrar_sin_abrir = false

////PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//SELECT P.permiso 
//INTO :permiso_ventana 
//FROM uti_permisos_ventana P 
//INNER JOIN uti_ventana V ON P.ventana = V.codigo 
//	AND P.empresa = V.empresa 
//WHERE P.empresa = :codigo_empresa 
//AND V.nombre = :nombre_ventana 
//AND P.usuario = :nombre_usuario
//USING SQLCA;
//
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//elseif permiso_ventana = 2 then
//	//OK acceso total
//	
//else
//	//Opción no contemplada -> Salir
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//end if
//
//if cerrar_sin_abrir = true then
//	this.Post Event ue_cerrar_sin_abrir()
//end if
end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)
end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

event closequery;if hay_cambios() = true and permiso_ventana > 1 then
	if MessageBox("Atención", "¿Desea grabar las modificaciones?", Exclamation!, YesNo!, 2) = 1 then
		if f_guardar() <> 1 then
			return 1 //Fallo de validación en la grabación, no cerrar
		end if
	end if
end if


end event

event key;If KeyFlags = 2 then
	choose case key
//		case KeyEnter!
//		case KeyN!
//			pb_nuevo.triggerevent(clicked!)
//		case KeyB!
//			pb_borrar.triggerevent(clicked!)
		case KeyS!
			pb_grabar.triggerevent(clicked!)
//		case KeyZ!
//			pb_cancelar.triggerevent(clicked!)
	end choose		
else
	choose case key
//		case KeyEnter!
//		case KeyF2!
//			pb_nuevo.triggerevent(clicked!)
//		case KeyF3!
//			pb_borrar.triggerevent(clicked!)
//		case KeyF4!
//			pb_grabar.triggerevent(clicked!)
//		case KeyF8!
//			pb_buscar.triggerevent(clicked!)
		case KeyEscape!
			pb_salir.triggerevent(clicked!)
	end choose		
end if


end event

type cbx_descontar_cajas from checkbox within wtc_entradas_almacen_ventas
integer x = 4297
integer y = 60
integer width = 521
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Descontar Cajas"
boolean lefttext = true
end type

type dw_stock from datawindow within wtc_entradas_almacen_ventas
integer x = 23
integer y = 2016
integer width = 5577
integer height = 612
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_stock_articulo_1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_pedidos from datawindow within wtc_entradas_almacen_ventas
integer x = 14
integer y = 2680
integer width = 5577
integer height = 612
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ver_pedidos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_observaciones from datawindow within wtc_entradas_almacen_ventas
integer x = 18
integer y = 392
integer width = 5573
integer height = 308
integer taborder = 30
string title = "none"
string dataobject = "dwtc_observaciones_almacen"
boolean border = false
boolean livescroll = true
end type

type pb_nuevo from picturebutton within wtc_entradas_almacen_ventas
boolean visible = false
integer x = 4951
integer y = 32
integer width = 146
integer height = 128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Search_24x24.png"
alignment htextalign = left!
end type

event clicked;dw_movimientos.reset()
f_insertar_movimiento( )

dw_detalle.retrieve (datetime (date(dp_fecha.value)) )
dw_detalle.setsort( "orden D")
dw_detalle.sort( )


end event

type dw_detalle from datawindow within wtc_entradas_almacen_ventas
integer x = 18
integer y = 704
integer width = 5573
integer height = 1236
string title = "none"
string dataobject = "dwtc_entradas_almacen_ventas"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_movimientos from u_dw within wtc_entradas_almacen_ventas
integer x = 18
integer y = 184
integer width = 5568
integer height = 208
integer taborder = 20
string dataobject = "dwtc_entradas_almacen_ventas"
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;string mp, caja_ventas, articulo
string resultado, resultado1, tipomov
dec  resultado2, resultado3
datetime resultado_fecha
string articulos_codigo, articulos_descripcion, articulos_formato, formatos_abreviado, almartcajas_caja, almcajas_descripcion_abr, palarticulo_codigo, pallets_descripcion, tono, calibre
string almamacen_descripcion
string almubizonas_descripcion, almubizonas_almacen, almubizonas_zona 
Int almubizonas_fila, almubizonas_altura, res2
string uso, promocion
dec piezascaja
string encajados[]
string fila_desde, fila_hasta, almacen, zona, familia = ""
String codigo_compras = ''
Long existe_precio = 0
string cajas_descripcion,ls_activo

this.Accepttext()

if isnull(row) then 
	return
end if 

if not isnull(row) then

	CHOOSE CASE dwo.name
		CASE "tipomov"
	
			SELECT almtipomov.descripcion
			INTO :resultado
			FROM almtipomov
			WHERE empresa = :codigo_empresa  
			AND CODIGO_REAL = 'E' AND interno = 'N' 
			and almtipomov.tipomov = :data
			USING SQLCA;
			
			if SQLCA.sqlcode <> 100 then
				this.object.almtipomov_descripcion[Row] 		= resultado
			else
				this.object.tipomov[Row] 	= ''
				this.object.almtipomov_descripcion [row] = ''
				return 2			
			end if
	
			
		CASE "articulo"
			this.object.tono[this.GetRow()] = ""
			this.object.calibre[this.GetRow()] = 0
			
			
			SELECT ARTICULOS.CODIGO, ARTICULOS.DESCRIPCION, ARTICULOS.FORMATO, FORMATOS.ABREVIADO, ALMARTCAJAS.CAJA ,
						ALMCAJAS.DESCRIPCION_ABR, PALARTICULO.CODIGO, PALLETS.DESCRIPCION, TONO, CALIBRE, ARTICULOS.USO, ALMARTCAJAS.PIEZASCAJA, ARTICULOS.FAMILIA, ARTICULOS.PROMOCION
			INTO :articulos_codigo, :articulos_descripcion, :articulos_formato, :formatos_abreviado, :almartcajas_caja, 
					:almcajas_descripcion_abr, :palarticulo_codigo, :pallets_descripcion, :tono, :calibre, :uso, :piezascaja, :familia, :promocion
			FROM ARTICULOS, FORMATOS, ALMARTCAJAS, ALMCAJAS, PALARTICULO, PALLETS  
			WHERE ARTICULOS.EMPRESA = :codigo_empresa
			AND ARTICULOS.EMPRESA = FORMATOS.EMPRESA 
			AND ARTICULOS.FORMATO = FORMATOS.CODIGO 	
			AND ARTICULOS.EMPRESA = ALMARTCAJAS.EMPRESA 
			AND ARTICULOS.CODIGO = ALMARTCAJAS.ARTICULO 
			AND ALMARTCAJAS.EMPRESA  = ALMCAJAS.EMPRESA 
			AND ALMARTCAJAS.CAJA = ALMCAJAS.CODIGO 																																	
			AND ALMARTCAJAS.EMPRESA = PALARTICULO.EMPRESA 
			AND ALMARTCAJAS.ARTICULO = PALARTICULO.ARTICULO 
			AND ALMARTCAJAS.CAJA = PALARTICULO.CAJA 
			AND PALARTICULO.EMPRESA = PALLETS.EMPRESA 
			AND PALARTICULO.CODIGO = PALLETS.CODIGO 
			AND PALARTICULO.PORDEFECTO = 'S' 		
			AND ARTICULOS.CODIGO = :data
			USING SQLCA;
			 
			if SQLCA.sqlcode <> 100 then
				this.object.articulo[this.GetRow()] 						= articulos_codigo
				this.object.articulos_descripcion[this.GetRow()] 		= articulos_descripcion
				this.object.formato[this.GetRow()] 						= articulos_formato			
				this.object.caja[this.GetRow()] 							= almartcajas_caja
				this.object.almcajas_descripcion_abr[this.GetRow()] 	= almcajas_descripcion_abr
				this.object.tipo_pallet[this.GetRow()] 					= palarticulo_codigo
				this.object.pallets_Descripcion[this.GetRow()] 			= pallets_descripcion
				this.object.articulos_tono[this.GetRow()] 				= ""
				this.object.articulos_calibre[this.GetRow()] 				= ""
				this.object.articulos_tono[this.GetRow()] 				= tono
				this.object.articulos_calibre[this.GetRow()] 				= calibre
				this.object.almartcajas_piezascaja[this.GetRow()] 	= piezascaja
				this.object.articulos_familia[this.GetRow()] 	= familia
				this.object.articulos_uso[this.GetRow()] 	= uso
				this.object.articulos_promocion[this.GetRow()] 	= promocion
				
				SELECT codigo_compras 
				INTO:codigo_compras 
				FROM articulos 
				WHERE empresa = :codigo_empresa 
					AND codigo = :articulos_codigo
				USING SQLCA;
				
				if uso = '1' and not isnull(codigo_compras) and codigo_compras <> '' then
					//comprobar si el artículo es una base comprada para avisar
					SELECT COUNT(*) 
					INTO :existe_precio 
					FROM comartpro 
					WHERE precio > 0 
						and mprima = :codigo_compras
					USING SQLCA;
					
					if existe_precio > 0 then
						MessageBox("Atención Base Comprada", "Entrada de base comprada. Por favor, haga fotocopia del albarán para el departamento de compras.")
					end if
				end if

			else
				dwo.Primary[row] = ''
				this.object.articulo[this.GetRow()] 						= ''
				this.object.articulos_descripcion[this.GetRow()] 		= ''
				this.object.formato[this.GetRow()] 						= ''
				this.object.caja[this.GetRow()] 							= ''
				this.object.almcajas_descripcion_abr[this.GetRow()] 	= ''
				this.object.tipo_pallet[this.GetRow()] 					= ''
				this.object.pallets_Descripcion[this.GetRow()] 			= ''
				this.object.articulos_tono[this.GetRow()] 				= ''
				this.object.articulos_calibre[this.GetRow()] 				= ''
				this.object.almartcajas_piezascaja[this.GetRow()] 	= 0
				this.object.articulos_familia[this.GetRow()] 	= ''
				
				dw_pedidos.reset()
				
				return 2			
			end if
						
			/*
			if uso = '3' and this.object.cajas[this.GetRow()] > 0 then
				dw_comlinubica.settransobject( SQLCA)
				caja_ventas = dw_movimientos.object.caja[dw_movimientos.getrow( )]
				
				mp = f_codigo_compras_caja ( codigo_empresa, caja_ventas )
						
				dw_comlinubica.visible = true
				dw_comlinubica.retrieve(codigo_empresa, mp )
	
				if dw_comlinubica.rowcount() = 1 then
					dw_comlinubica.object.marcado[dw_comlinubica.getrow()] = 1
				end if
				
			else
					dw_comlinubica.reset()
					dw_comlinubica.visible = false
			end if
			*/
			
			dw_pedidos.reset()
			if uso <> '1' then
				f_busca_encajados (articulos_codigo,  encajados)
			end if
			
			if upperbound(encajados) = 0 then
				encajados[1] = articulos_codigo
			end if
			dw_pedidos.retrieve (codigo_empresa, encajados)
			dw_stock.retrieve (codigo_empresa, articulos_codigo)
			
			CASE "calidad"	
				articulo = this.object.articulo[this.getrow()]
				
				if not isnull(articulo) and articulo <> "" then
					SELECT calidades.descripcion
					into :resultado
					FROM almartcal 
					INNER JOIN calidades ON almartcal.empresa = calidades.empresa AND almartcal.calidad = calidades.codigo 
					WHERE almartcal.empresa = :codigo_empresa 
					AND almartcal.articulo = :articulo 
					and almartcal.calidad= :data
					USING SQLCA;
					
					if SQLCA.sqlcode <> 100 then
						this.object.calidades_descripcion[Row] 		= resultado
					else
						this.object.calidad[Row] 		= ''
						this.object.calidades_descripcion[Row] = ''
						return 2			
					end if
				else
					this.object.calidad[Row] 		= ''
					this.object.calidades_descripcion[Row] = ''
					return 2			
				end if
			CASE "almacen"
				SELECT  almalmacen.descripcion
				into :almamacen_descripcion
				FROM almalmacen 
				WHERE empresa = :codigo_empresa
				and almalmacen.codigo = :data
				USING SQLCA;
											
				if SQLCA.sqlcode <> 100 then
					this.object.almalmacen_descripcion[Row] 		= almamacen_descripcion
					
					this.object.zona[Row] 							= ""		
					this.object.almubizonas_descripcion[Row] 	= ""	
				
					this.object.fila[Row] 		= 0
					this.object.altura[Row] 		= 0
				else
					this.object.almacen[Row] 	= ''
					this.object.almalmacen_descripcion[Row] = ' '
					this.object.zona[Row] 							= ""		
					this.object.almubizonas_descripcion[Row] 	= ""	
					this.object.fila[Row] 		= 0
					this.object.altura[Row] 		= 0
					return 2			
				end if
				
				post event itemchanged(row,this.object.cantidade,string(this.object.cantidade[row]))
			CASE "caja"
				
				if dw_movimientos.rowcount() > 0 then
					articulo = dw_movimientos.object.articulo[dw_movimientos.getrow()]
				end if
				SELECT  almcajas.descripcion
				into :cajas_descripcion
				FROM almcajas
				WHERE almcajas.empresa = :codigo_empresa
				and almcajas.codigo = :data
				USING SQLCA;
			
				if SQLCA.sqlcode <> 100 then
					this.object.almcajas_descripcion_abr[this.GetRow()] = cajas_descripcion
				else
					this.object.tipo_pallet[Row] 	= ''
					this.object.pallets_descripcion [row] = ''
					return 2			
				end if
				this.object.tipo_pallet[this.GetRow()] 				= ""		
				this.object.pallets_descripcion[this.GetRow()] 	= ""

				
			CASE "tipo_pallet"
				if dw_movimientos.rowcount() > 0 then
					articulo = dw_movimientos.object.articulo[dw_movimientos.getrow()]
				end if
				SELECT  pallets.descripcion
				into :pallets_descripcion
				FROM pallets
				inner join palarticulo on pallets.empresa = palarticulo.empresa and pallets.codigo = palarticulo.codigo
				WHERE pallets.empresa = :codigo_empresa
				and pallets.codigo = :data
				and palarticulo.articulo = :articulo
				USING SQLCA;
			
				if SQLCA.sqlcode <> 100 then
					this.object.pallets_descripcion[Row] 		= pallets_descripcion
				else
					this.object.tipo_pallet[Row] 	= ''
					this.object.pallets_descripcion [row] = ''
					return 2			
				end if
				
			CASE "zona"	
				almubizonas_almacen = this.object.almacen[this.GetRow()]
	
				SELECT almubizonas.descripcion
				into :almubizonas_descripcion
				FROM almubizonas 
				WHERE almubizonas.empresa = :codigo_empresa
				and almubizonas.almacen = :almubizonas_almacen
				and almubizonas.zona = :data
				USING SQLCA;
				
				if SQLCA.sqlcode <> 100 then
					articulo = this.object.articulo[row]
//					//NO PERMITIR TRASPASOS MANUALES DE P PARA ARTÍCULOS DE LA FAMILIA DE WOW - 04/2015
//					SELECT familia INTO:familia FROM articulos WHERE empresa = :codigo_empresa AND codigo = :articulo;
//					if familia = "2" and data = "P" then
//						MessageBox("Error", "No se permiten entradas de material de forma manual de la familia WOW en la zona de expedición. Utilice las órdenes de preparación.")
//						this.object.zona[Row] 		= ''
//						this.object.almubizonas_descripcion[Row] = ''
//						return 2			
//					end if
					
					this.object.almubizonas_descripcion[Row] 		= almubizonas_descripcion
					this.object.fila[Row] 		= 0
					this.object.altura[Row] 		= 0
				else
					this.object.zona[Row] 		= ''
					this.object.almubizonas_descripcion[Row] = ''
					this.object.fila[Row] 		= 0
					this.object.altura[Row] 		= 0
					return 2			
				end if
	
			CASE "fila"
				almubizonas_almacen = this.object.almacen[this.GetRow()]
				almubizonas_zona = this.object.zona[this.GetRow()]
				almubizonas_fila = Integer(data)
				
				if almubizonas_fila <= 0 then
					this.object.fila[Row] 		= 0
					return 2
				else
					SELECT almubimapa.fila_desde
					into :res2
					FROM almubimapa 
					WHERE almubimapa.empresa = :codigo_empresa
						and almubimapa.almacen = :almubizonas_almacen
						and almubimapa.zona = :almubizonas_zona
						and almubimapa.fila_desde <= :almubizonas_fila 
						AND almubimapa.fila_hasta >= :almubizonas_fila
					USING SQLCA;
					
					if SQLCA.sqlcode <> 100 then
						//OK
						
						//NO PERMITIR ENTRADAS AL MUELLE DE DISTRIBUCIÓN - 08/2015
						if this.object.almacen[row] = "1" and this.object.zona[row] = "P" and almubizonas_fila >= 10 then
							MessageBox("Error", "No se permiten entradas directas al muelle de distribución (1 P fila >= 10). Utilice las órdenes de preparación.")
							this.object.fila[Row] 		= 0
							this.object.altura[Row] 		= 0
							return 2
						end if
						this.object.altura[Row] 		= 0
					else
						this.object.fila[Row] 		= 0
						this.object.altura[Row] 		= 0
						return 2			
					end if
				end if
			CASE "altura"
				almubizonas_almacen = this.object.almacen[this.GetRow()]
				almubizonas_zona    = this.object.zona[this.GetRow()]
				almubizonas_fila    = this.object.fila[this.GetRow()]
				almubizonas_altura  = Integer(data)
				
				if almubizonas_altura <= 0 then
					this.object.altura[Row] 		= 0
					return 2
				else
					SELECT almubimapa.altura_desde
					into :res2
					FROM almubimapa 
					WHERE almubimapa.empresa = :codigo_empresa
						and almubimapa.almacen = :almubizonas_almacen
						and almubimapa.zona = :almubizonas_zona
						and :almubizonas_fila between almubimapa.fila_desde and almubimapa.fila_hasta
						and almubimapa.altura_desde <= :almubizonas_altura 
						AND almubimapa.altura_hasta >= :almubizonas_altura
					USING SQLCA;
					
					if SQLCA.sqlcode <> 100 then
						//OK
						//Chequeo si la ubicación está activa
						select isnull(almubimapa_codbar.activo,'') 
						into   :ls_activo 
						from   almubimapa_codbar 
						where  almubimapa_codbar.empresa = :codigo_empresa 
						and    almubimapa_codbar.almacen = :almubizonas_almacen
						and    almubimapa_codbar.zona    = :almubizonas_zona
						and    almubimapa_codbar.fila    = :almubizonas_fila
						and    almubimapa_codbar.altura  = :almubizonas_altura;	
						
						if ls_activo = "N" then
							this.object.altura[Row] = 0
							return 2			
						else							
														
						end if
					else
						this.object.altura[Row] = 0
						return 2			
					end if
				end if
		CASE "pallets"
			post f_calcular_pallets_caja(integer(data), 0 , 0)
		CASE "cantidade"
			post f_calcular_pallets_caja(0, 0 , dec(data))
	END CHOOSE
	
	this.Accepttext()
	this.groupcalc( )
	
	dw_observaciones.settransobject(SQLCA)
	if dw_observaciones.retrieve(codigo_empresa, this.object.almacen[Row], this.object.zona[Row], this.object.fila[Row], this.object.altura[Row], this.object.articulo[Row], this.object.calidad[Row], this.object.tono[Row], this.object.calibre[Row], this.object.tipo_pallet[Row], this.object.caja[Row]) = 0 then
		dw_observaciones.insertrow(0)
	end if
	
	f_mostrar_bultos_destino()
end if
	
	
end event

event usr_dwnkey;call super::usr_dwnkey;string campo, tipomov, articulo, familia = ""
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda
string caja_ventas, mp
string encajados[]
string caja

If KeyFlags = 2 then
	choose case key
		case KeyEnter!
		case KeyN!
//			pb_nuevo.triggerevent(clicked!)
		case KeyB!
//			pb_borrar.triggerevent(clicked!)
		case KeyS!
			pb_grabar.triggerevent(clicked!)
		case KeyZ!
//			pb_cancelar.triggerevent(clicked!)
	end choose		
else
	choose case Key
		case KeyEnter!
		case KeyF2!
//			pb_nuevo.triggerevent(clicked!)
		case KeyF3!
//			pb_borrar.triggerevent(clicked!)
		case KeyF4!
			pb_grabar.triggerevent(clicked!)
		case KeyF8!
//			pb_buscar.triggerevent(clicked!)
		case KeyEscape!
			pb_salir.triggerevent(clicked!)
	end choose		
end if


busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "tipomov"
			busqueda.filtro_es_codigo = true
			tipomov = dw_movimientos.object.tipomov[dw_movimientos.getrow()]
			busqueda.consulta  = " SELECT TIPOMOV, TIPOMOV, DESCRIPCION "+&
										" FROM almtipomov "+&
										" WHERE empresa = '"+codigo_empresa+"' AND CODIGO_REAL = 'E' AND interno = 'N' ORDER BY DESCRIPCION"
										
			busqueda.titulo_ventana = "Búsqueda de Tipos de Movimientos"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Código"
			busqueda.titulos[3] = "Tipo Movimiento"
			
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.tipomov[this.GetRow()] 							= resultado.valores[2]		
				this.object.almtipomov_descripcion[this.GetRow()] 		= resultado.valores[3]		
			end if

	CASE "articulo"
			busqueda.filtro_es_codigo = false		
			busqueda.titulo_ventana = "Búsqueda de Artículos"
//			busqueda.consulta  = "SELECT ARTICULOS.CODIGO, ARTICULOS.DESCRIPCION,  ARTICULOS.FORMATO, FORMATOS.ABREVIADO, ARTICULOS.USO, ALMUSOS.DESCRIPCION, "+&
//										" ALMARTCAJAS.CAJA , ALMCAJAS.DESCRIPCION_ABR, PALARTICULO.CODIGO, PALLETS.DESCRIPCION, TONO, CALIBRE, ALMARTCAJAS.PIEZASCAJA "+&
//										" FROM ARTICULOS, FORMATOS, ALMARTCAJAS, ALMCAJAS, PALARTICULO, PALLETS, ALMUSOS  "+&
//										" WHERE ARTICULOS.EMPRESA = '"+codigo_empresa+"' "+& 
//										" AND ARTICULOS.EMPRESA = FORMATOS.EMPRESA "+&
//										" AND ARTICULOS.FORMATO = FORMATOS.CODIGO "+&	
//										" AND ARTICULOS.EMPRESA = ALMARTCAJAS.EMPRESA "+&
//										" AND ARTICULOS.CODIGO = ALMARTCAJAS.ARTICULO "+&
//										" AND ARTICULOS.EMPRESA = ALMUSOS.EMPRESA "+&
//										" AND ARTICULOS.USO = ALMUSOS.CODIGO "+&
//										" AND ALMARTCAJAS.EMPRESA  = ALMCAJAS.EMPRESA "+&
//										" AND ALMARTCAJAS.CAJA = ALMCAJAS.CODIGO "+&																																		
//										" AND ALMARTCAJAS.PORDEFECTO = 'S' "+&																																		
//										" AND ALMARTCAJAS.EMPRESA = PALARTICULO.EMPRESA "+&
//										" AND ALMARTCAJAS.ARTICULO = PALARTICULO.ARTICULO "+&
//										" AND ALMARTCAJAS.CAJA = PALARTICULO.CAJA "+&
//										" AND PALARTICULO.PORDEFECTO = 'S' "+&		
//										" AND PALARTICULO.EMPRESA = PALLETS.EMPRESA "+&
//										" AND PALARTICULO.CODIGO = PALLETS.CODIGO "+&
//										" ORDER BY ARTICULOS.DESCRIPCION "
			
			busqueda.consulta  = "select articulos.codigo, CONVERT(char(60),articulos.descripcion),  genter.razon, articulos.formato, formatos.abreviado, "+&
											" art_ver_tipooperacion.descripcion_abr, oanterior.descripcion_abr, articulos.uso, almusos.descripcion, "+&
										" almartcajas.caja , almcajas.descripcion_abr, palarticulo.codigo, pallets.descripcion, articulos.tono, articulos.calibre, almartcajas.piezascaja , articulos.familia"+&
										" from articulos  "+&
										" left outer join genter on articulos.empresa = genter.empresa and articulos.cliente = genter.codigo  and genter.tipoter = 'C' "+&
										" inner join formatos on articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo "+&
										" inner join almartcajas on articulos.empresa = almartcajas.empresa and articulos.codigo = almartcajas.articulo "+&
										" inner join almcajas on almartcajas.empresa  = almcajas.empresa and almartcajas.caja = almcajas.codigo "+&
										" inner join palarticulo on almartcajas.empresa = palarticulo.empresa and almartcajas.articulo = palarticulo.articulo and almartcajas.caja = palarticulo.caja and palarticulo.pordefecto = 's'  "+&
										" inner join pallets on palarticulo.empresa = pallets.empresa and palarticulo.codigo = pallets.codigo "+&
										" inner join almusos on articulos.empresa = almusos.empresa and articulos.uso = almusos.codigo "+&
										" LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
										" LEFT OUTER JOIN art_escandallo e1 ON articulos.empresa = e1.empresa AND articulos.codigo = e1.articulo AND "+&
																		" e1.articulo_ant = (SELECT TOP 1 articulo_ant FROM art_escandallo WHERE empresa = articulos.empresa AND articulo = articulos.codigo) "+&
																		" AND e1.version = (SELECT TOP 1 version FROM art_escandallo WHERE empresa = articulos.empresa AND articulo = articulos.codigo) "+&
										" LEFT OUTER JOIN articulos anterior ON e1.empresa = anterior.empresa AND e1.articulo_ant = anterior.codigo  "+&
										" LEFT OUTER JOIN art_ver_tipooperacion oanterior ON anterior.empresa = oanterior.empresa AND anterior.tipo_operacion = oanterior.codigo  "+&
										" where articulos.empresa = '"+codigo_empresa+"' "+&
										" order by CONVERT(char(60), articulos.descripcion) "
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Cliente"
			
			busqueda.titulos[4] = "Cod. F."
			busqueda.titulos[5] = "Formato"
			
			busqueda.titulos[6] = "Operación"
			busqueda.titulos[7] = "Op. Anterior"
			
			busqueda.titulos[8] = "Cod. Uso"
			busqueda.titulos[9] = "Uso"
			busqueda.titulos[10] = "Cod. Caja"
			busqueda.titulos[11] = "Des. Caja"
			busqueda.titulos[12] = "Cod. Pallet"
			busqueda.titulos[13] = "Des. Pallet"
			busqueda.titulos[14] = "Gest. Tono"
			busqueda.titulos[15] = "Gest. Calibre"
			busqueda.titulos[16] = "Pzs. Caja"
			busqueda.titulos[17] = "Familia"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.articulo[this.GetRow()] 							= resultado.valores[1]							
				this.object.articulos_descripcion[this.GetRow()] 		= resultado.valores[2]			
				this.object.formato[this.GetRow()] 							= resultado.valores[4]		
				this.object.articulos_uso[this.GetRow()] 					= resultado.valores[8]
				this.object.caja[this.GetRow()] 									= resultado.valores[10]	
				this.object.almcajas_descripcion_abr[this.GetRow()] 	= resultado.valores[11]
				this.object.tipo_pallet[this.GetRow()] 						= resultado.valores[12]			
				this.object.pallets_Descripcion[this.GetRow()] 			= resultado.valores[13]		
				this.object.articulos_tono[this.GetRow()]  					= ""
				this.object.articulos_calibre[this.GetRow()] 				= ""
				this.object.articulos_tono[this.GetRow()] 					= resultado.valores[14]											
				this.object.articulos_calibre[this.GetRow()] 				= resultado.valores[15]
										
				this.object.almartcajas_piezascaja[this.GetRow()] 		= long(resultado.valores[16])
				this.object.articulos_familia[this.GetRow()] 				= resultado.valores[17]
				
				
				dw_pedidos.reset()
				if this.object.articulos_uso[this.GetRow()] <> '1' then
					f_busca_encajados (resultado.valores[1],  encajados)
				end if
				
				if upperbound(encajados) = 0 then
					encajados[1] = resultado.valores[1]
				end if
				dw_pedidos.retrieve (codigo_empresa, encajados)
				
				dw_stock.retrieve (codigo_empresa, resultado.valores[1])
				
				/*
				dw_pedidos.reset()
				if resultado.valores[12] <> '1' then
					f_busca_encajados ( resultado.valores[2],  encajados)
				end if
				
				if upperbound(encajados) = 0 then
					encajados[1] =  resultado.valores[2]	
				end if
				dw_pedidos.retrieve (codigo_empresa, encajados)
				*/
				
				String codigo_compras
				Long existe_precio
				SELECT codigo_compras INTO:codigo_compras FROM articulos WHERE empresa = :codigo_empresa AND codigo = :resultado.valores[1];
				
				if resultado.valores[8] = '1' and not isnull(codigo_compras) and codigo_compras <> '' then
					//comprobar si el artículo es una base comprada para avisar
					SELECT COUNT(*) INTO :existe_precio FROM comartpro WHERE precio > 0 and mprima = :codigo_compras;
					if existe_precio > 0 then
						MessageBox("Atención Base Comprada", "Entrada de base comprada. Por favor, haga fotocopia del albarán para el departamento de compras.")
					end if
				end if
				
			end if		
			
				
			
		CASE "almacen"
			busqueda.filtro_es_codigo = true
			tipomov = dw_movimientos.object.tipomov[dw_movimientos.getrow()]
			busqueda.consulta  = " SELECT almalmacen.codigo, almalmacen.codigo, almalmacen.DESCRIPCION "+&
										" FROM almalmacen "+&
										" WHERE empresa = '"+codigo_empresa+"' "
										
			busqueda.titulo_ventana = "Búsqueda de Tipos de Movimientos"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Código"
			busqueda.titulos[3] = "Descripción"
			
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.almacen[this.GetRow()] 							= resultado.valores[2]		
				this.object.almalmacen_descripcion[this.GetRow()] 		= resultado.valores[3]	
				
				this.object.zona[this.GetRow()] 							= ""		
				this.object.almubizonas_descripcion[this.GetRow()] 	= ""	
				
				this.object.fila[this.GetRow()] 		= 0
				this.object.altura[this.GetRow()] 		= 0
				
			end if		
			
		CASE "zona"
			busqueda.filtro_es_codigo = false
			//tipomov = dw_movimientos.object.tipomov[dw_movimientos.getrow()]
			busqueda.consulta  = " SELECT almubizonas.zona, almubizonas.zona, almubizonas.descripcion"+&
										" FROM almubizonas "+&
										" WHERE almubizonas.empresa = '"+codigo_empresa+"'  and almubizonas.almacen = '"+this.object.almacen[this.GetRow()]+"' "
										
			busqueda.titulo_ventana = "Búsqueda de Zonas"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				articulo = this.object.articulo[this.GetRow()]
				
				this.object.zona[this.GetRow()] 							= resultado.valores[1]		
				this.object.almubizonas_descripcion[this.GetRow()] 	= resultado.valores[2]		
				
				this.object.fila[this.GetRow()] 		= 0
				this.object.altura[this.GetRow()] 		= 0
				
			end if					
		CASE "calidad"
			busqueda.filtro_es_codigo = false
			articulo = this.object.articulo[this.getrow()]
			
			busqueda.consulta  = " SELECT calidades.codigo, calidades.descripcion "+&
										" FROM almartcal "+&
										" INNER JOIN calidades ON almartcal.empresa = calidades.empresa AND almartcal.calidad = calidades.codigo "+&
										" WHERE almartcal.empresa = '"+codigo_empresa+"' "+&
										" AND almartcal.articulo = '"+articulo+"' "
										
			busqueda.titulo_ventana = "Búsqueda de Calidades"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.calidad[this.GetRow()] 						= resultado.valores[1]		
				this.object.calidades_descripcion[this.GetRow()] 	= resultado.valores[2]		
			end if				

 CASE "caja"
			busqueda.filtro_es_codigo = false
			articulo = this.object.articulo[this.getrow()]
			
			busqueda.consulta  = " SELECT almartcajas.caja, almcajas.descripcion "+&
										" FROM almartcajas "+&
										" INNER JOIN almcajas on almartcajas.empresa = almcajas.empresa and almartcajas.caja = almcajas.codigo "+&
										" WHERE almartcajas.empresa = '"+codigo_empresa+"' "+&
										" AND almartcajas.articulo = '"+articulo+"' "
										
			busqueda.titulo_ventana = "Búsqueda de Cajas"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.caja[this.GetRow()] 								= resultado.valores[1]		
				this.object.almcajas_descripcion_abr[this.GetRow()] 	= resultado.valores[2]		
				
				this.object.tipo_pallet[this.GetRow()] 				= ""		
				this.object.pallets_descripcion[this.GetRow()] 	= ""
				
				
			end if				

	CASE "tipo_pallet"
			busqueda.filtro_es_codigo = false
			articulo = this.object.articulo[this.getrow()]
			caja = this.object.caja[this.GetRow()]
			busqueda.consulta  = " SELECT pallets.codigo, pallets.descripcion "+&
										" FROM pallets "+&
										" INNER JOIN  palarticulo ON pallets.empresa = palarticulo.empresa AND pallets.codigo = palarticulo.codigo "+&
										" WHERE palarticulo.empresa = '"+codigo_empresa+"' "+&
										" AND palarticulo.caja = '"+caja+"' "+&
										" AND palarticulo.articulo = '"+articulo+"' "
										
			busqueda.titulo_ventana = "Búsqueda de Pallets"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.tipo_pallet[this.GetRow()] 				= resultado.valores[1]		
				this.object.pallets_descripcion[this.GetRow()] 	= resultado.valores[2]		
			end if				

			
	END CHOOSE
end if	
	
end event

event losefocus;call super::losefocus;this.triggerevent("itemchanged")
end event

event itemfocuschanged;call super::itemfocuschanged;string uso, mp
string caja_ventas


uso = this.object.articulos_uso[this.GetRow()] 	

if uso = '3' and this.object.cajas[this.GetRow()] > 0 then
	caja_ventas = dw_movimientos.object.caja[dw_movimientos.getrow( )]
	
	mp = f_codigo_compras_caja ( codigo_empresa, caja_ventas )
			
else

end if

end event

type pb_grabar from picturebutton within wtc_entradas_almacen_ventas
integer x = 5179
integer y = 28
integer width = 146
integer height = 128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Save_24x24.png"
alignment htextalign = right!
string powertiptext = "Guardar (Crtl + S)"
end type

event clicked;long fila, i
fila = 0

f_guardar( )


/*
string articulos_codigo, codigo_compras, caja_ventas, mp

/*

this.object.articulos_descripcion[this.GetRow()] 		= articulos_descripcion
this.object.formato[this.GetRow()] 						= articulos_formato			
this.object.caja[this.GetRow()] 							= almartcajas_caja
this.object.almcajas_descripcion_abr[this.GetRow()] 	= almcajas_descripcion_abr
this.object.tipo_pallet[this.GetRow()] 					= palarticulo_codigo
this.object.pallets_Descripcion[this.GetRow()] 			= pallets_descripcion
this.object.articulos_tono[this.GetRow()] 				= ""
this.object.articulos_calibre[this.GetRow()] 				= ""
this.object.articulos_tono[this.GetRow()] 				= tono
this.object.articulos_calibre[this.GetRow()] 				= calibre
this.object.almartcajas_piezascaja[this.GetRow()] 	= piezascaja
this.object.articulos_familia[this.GetRow()] 	= familia
this.object.articulos_uso[this.GetRow()] 	= uso
*/
articulos_codigo = dw_movimientos.object.articulo[dw_movimientos.GetRow()] 		

SELECT codigo_compras 
INTO:codigo_compras 
FROM articulos 
WHERE empresa = :codigo_empresa 
	AND codigo = :articulos_codigo
USING SQLCA;

if dw_movimientos.object.articulos_uso[dw_movimientos.GetRow()] = '3' and dw_movimientos.object.cajas[dw_movimientos.GetRow()] > 0 then
	dw_comlinubica.settransobject( SQLCA)
	caja_ventas = dw_movimientos.object.caja[dw_movimientos.getrow( )]
	
	mp = f_codigo_compras_caja ( codigo_empresa, caja_ventas )
			
	dw_comlinubica.visible = true
	dw_comlinubica.retrieve(codigo_empresa, mp )

	if dw_comlinubica.rowcount() = 1 then
		dw_comlinubica.object.marcado[dw_comlinubica.getrow()] = 1
	end if
	
else
		dw_comlinubica.reset()
		dw_comlinubica.visible = false
end if

if dw_comlinubica.visible then
	if dw_comlinubica.rowcount( ) = 1 then
		dw_comlinubica.object.marcado[1] = 1 
	else
		if dw_movimientos.rowcount( ) > 1 and dw_comlinubica.rowcount() > 1 then
			if dw_movimientos.object.cajas[dw_movimientos.getrow( )] <= dw_comlinubica.object.comlinubica_existencias [fila] then
				f_guardar()
			else 
				messagebox("Error", "No hay suficientes cajas para hacer el movimiento")
				dw_comlinubica.reset()
				dw_comlinubica.visible = false
				dw_movimientos.reset()
				f_insertar_movimiento()	
			end if
		else
			messagebox("Error", "No hay suficientes cajas para hacer el movimiento")
			dw_comlinubica.reset()
			dw_comlinubica.visible = false
			dw_movimientos.reset()
			f_insertar_movimiento()	
		end if
	end if
end if
	
f_guardar( )
*/

/*
if dw_comlinubica.visible then
	if dw_comlinubica.rowcount( ) > 0 then
		fila = 0
		i = 1
		do while  i <= dw_comlinubica.rowcount( ) and fila = 0 
			if dw_comlinubica.object.marcado[i] = 1 then
				fila = i
			end if 
			i++
		loop
	end if
	if fila = 0 then
		messagebox("Error", "Debe marcar una caja")
	else
		if dw_movimientos.rowcount( ) > 0 and dw_comlinubica.rowcount() > 0 then
			if dw_movimientos.object.cajas[dw_movimientos.getrow( )] <= dw_comlinubica.object.comlinubica_existencias [fila] then
				f_guardar()
			else 
				messagebox("Error", "No hay suficientes cajas para hacer el movimiento")
				dw_comlinubica.reset()
				dw_comlinubica.visible = false
				dw_movimientos.reset()
				f_insertar_movimiento()	
			end if
		else
			messagebox("Error", "No hay suficientes cajas para hacer el movimiento")
			dw_comlinubica.reset()
			dw_comlinubica.visible = false
			dw_movimientos.reset()
			f_insertar_movimiento()	
		end if
	end if
else
	f_guardar( )
end if
*/
end event

type pb_salir from picturebutton within wtc_entradas_almacen_ventas
integer x = 5403
integer y = 28
integer width = 146
integer height = 128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Log Out_24x24Gris.png"
string powertiptext = "Salir (ESC)"
end type

event clicked;close(parent)
end event

type dp_fecha from datepicker within wtc_entradas_almacen_ventas
integer x = 27
integer y = 40
integer width = 466
integer height = 100
integer taborder = 10
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-01-07"), Time("13:28:38.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;
dw_movimientos.reset()
f_insertar_movimiento()

dw_detalle.retrieve(datetime(date(dtm)))
dw_detalle.setsort("orden D")
dw_detalle.sort( )

end event

type st_1 from statictext within wtc_entradas_almacen_ventas
integer x = 23
integer y = 2620
integer width = 5568
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24076881
string text = "LISTADO PEDIDOS PENDIENTES"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within wtc_entradas_almacen_ventas
integer x = 32
integer y = 1944
integer width = 5568
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24076881
string text = "STOCK ARTÍCULO"
alignment alignment = center!
boolean focusrectangle = false
end type

