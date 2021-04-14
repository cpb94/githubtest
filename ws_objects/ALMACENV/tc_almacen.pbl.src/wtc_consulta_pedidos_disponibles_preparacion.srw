$PBExportHeader$wtc_consulta_pedidos_disponibles_preparacion.srw
forward
global type wtc_consulta_pedidos_disponibles_preparacion from wt_consultas_padre
end type
type dw_imprimir from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type cbx_resumen from checkbox within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_fecha from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type st_1 from statictext within wtc_consulta_pedidos_disponibles_preparacion
end type
type st_2 from statictext within wtc_consulta_pedidos_disponibles_preparacion
end type
type gb_2 from groupbox within wtc_consulta_pedidos_disponibles_preparacion
end type
type pb_2 from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_observaciones_pedidos from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type cbx_resumen_pesos from checkbox within wtc_consulta_pedidos_disponibles_preparacion
end type
type st_3 from statictext within wtc_consulta_pedidos_disponibles_preparacion
end type
type pb_3 from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_prepacking from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type pb_mas_exp from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
end type
type pb_menos_exp from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
end type
type st_4 from statictext within wtc_consulta_pedidos_disponibles_preparacion
end type
type pb_4 from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_oc from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_paletizado from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type st_5 from statictext within wtc_consulta_pedidos_disponibles_preparacion
end type
type pb_5 from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_proforma from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_traspaso_pico from u_dw within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_observaciones_pallet from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type cb_1 from commandbutton within wtc_consulta_pedidos_disponibles_preparacion
end type
type cbx_imprimir_observaciones from checkbox within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_orden from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_expedicion from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type dwtc_reparto_fabricaciones from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_lineas from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_orden_carga_linea_reservas from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_stock from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type cb_faltas_promocion from commandbutton within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_faltas_almacen_promocion from datawindow within wtc_consulta_pedidos_disponibles_preparacion
end type
type dw_mover from u_dw within wtc_consulta_pedidos_disponibles_preparacion
end type
end forward

global type wtc_consulta_pedidos_disponibles_preparacion from wt_consultas_padre
integer width = 8599
integer height = 3832
string title = "Mantenimiento de Preparación de Pedidos"
dw_imprimir dw_imprimir
cbx_resumen cbx_resumen
dw_fecha dw_fecha
st_1 st_1
st_2 st_2
gb_2 gb_2
pb_2 pb_2
dw_observaciones_pedidos dw_observaciones_pedidos
cbx_resumen_pesos cbx_resumen_pesos
st_3 st_3
pb_3 pb_3
dw_prepacking dw_prepacking
pb_mas_exp pb_mas_exp
pb_menos_exp pb_menos_exp
st_4 st_4
pb_4 pb_4
dw_oc dw_oc
dw_paletizado dw_paletizado
st_5 st_5
pb_5 pb_5
dw_proforma dw_proforma
dw_traspaso_pico dw_traspaso_pico
dw_observaciones_pallet dw_observaciones_pallet
cb_1 cb_1
cbx_imprimir_observaciones cbx_imprimir_observaciones
dw_orden dw_orden
dw_expedicion dw_expedicion
dwtc_reparto_fabricaciones dwtc_reparto_fabricaciones
dw_lineas dw_lineas
dw_orden_carga_linea_reservas dw_orden_carga_linea_reservas
dw_stock dw_stock
cb_faltas_promocion cb_faltas_promocion
dw_faltas_almacen_promocion dw_faltas_almacen_promocion
dw_mover dw_mover
end type
global wtc_consulta_pedidos_disponibles_preparacion wtc_consulta_pedidos_disponibles_preparacion

type variables
string sql_inicial, sql_final
String orden_seleccionado

// Nombre que pone al titulo de la ventana, el mantenimiento que la llama (Si está en blanco el título establecido)
string nombre_ventana_invoca

//Ventana que ha llamado a esta ventana
String ventana_invoca


// clave primaria de la tabla principal
string padre_codigo
Dec anyo_padre_codigo

// La variable estado tomará los siguientes valores
// 0: Inserción
// 1: Edición
integer estado

// Transaccion global de la ventana
transaction transaccion

// Parametrosde la Transaccion global de la ventana
str_param_transaccion param_transaccion

//Resultado de la transaccion
long rtn

// Devuelve 1 si confirmamos la grabación.
integer grabar

// Devuelve 1 si confirmamos el borrado
integer borrar

int modo_expedicion
string cliente_expedicion

Public:
	str_wt_busquedas_entrada padre_busqueda
	str_colisiones param_colisiones
	
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function boolean hay_cambios ()
public subroutine mostrar_controles_insercion ()
public subroutine mostrar_controles_edicion ()
public function integer f_guardar (boolean actualizar)
public subroutine f_buscar (string orden_carga, integer anyo)
public subroutine f_fin_orden_carga (boolean con_movimiento)
public subroutine f_marcar_solo_disponibles ()
public subroutine f_mostrar_estado (string estado_pedido)
public subroutine f_nuevo (integer expedicion_anyo, string expedicion_codigo, string cliente)
public subroutine f_salir ()
public function integer f_borrar (boolean sin_preguntar)
public subroutine f_imprimir_documentacion_pallet (integer numpalet)
public function integer f_post_itemchanged (long row, dwobject dwo, string data)
public subroutine f_fin_orden_carga_old (boolean con_movimiento)
public subroutine f_calcular_disponible (string arg_filtro_dw)
public subroutine f_distintos_pallets_articulo_calidad_caj ()
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
long j, esta

montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Filtros mediante DW
	esta = pos(dw_montaje_filtro.object.linea[j] , "Situación") + pos(dw_montaje_filtro.object.linea[j], "Cliente")  + pos(dw_montaje_filtro.object.linea[j] , "Pedido") 
//	esta = pos(dw_montaje_filtro.object.linea[j], "Cliente")  + pos(dw_montaje_filtro.object.linea[j] , "Pedido") 
	if esta = 0 then
		if montaje = '' then
			montaje = dw_montaje_filtro.object.filtro[j]
		else
			montaje = montaje +' AND '+ dw_montaje_filtro.object.filtro[j]
		end if
	end if
next
if montaje <> '' then
	montaje = consulta_inicial + " AND " + montaje
else
	montaje = consulta_inicial
end if
return montaje


end function

public function boolean hay_cambios ();//Boolean resultado
//resultado = false
//
//dw_orden.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco
//dw_lineas.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco
//dw_orden_carga_linea_reservas.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco
//
//if dw_lineas.DeletedCount() + dw_lineas.ModifiedCount() > 0 or dw_orden_carga_linea_reservas.DeletedCount() + dw_orden_carga_linea_reservas.ModifiedCount() > 0 then
//	resultado = true
//end if
//
//return resultado

return false
end function

public subroutine mostrar_controles_insercion ();//Activa desactiva los botones de la ventana cuando estamos en modo inserción

dw_orden.object.p_buscar.enabled = true
dw_orden.object.p_grabar.enabled = true

dw_orden.object.p_nuevo.enabled = false
dw_orden.object.p_borrar.enabled = false
end subroutine

public subroutine mostrar_controles_edicion ();// Activa y desactiva botones cuando estamos en modo de edición

dw_orden.object.p_buscar.enabled = true
dw_orden.object.p_grabar.enabled = true

dw_orden.object.p_nuevo.enabled = true
dw_orden.object.p_borrar.enabled = true

end subroutine

public function integer f_guardar (boolean actualizar);//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado, anyo
long i = 1, fila_actual, posicion, pallets_extra, linea
String codigo_oc_actual, var_tipo_pallet
dec anyo_oc_actual, anyo_pedido, codigo_pedido, linea_pedido, var_numpalet

rtn = 1

if dw_orden.rowcount() <= 0 then
	return -1
end if

codigo_oc_actual = ""
if dw_orden.rowcount() > 0 then
	codigo_oc_actual = dw_orden.object.codigo[dw_orden.getrow()]
	anyo_oc_actual = dw_orden.object.anyo[dw_orden.getrow()]
end if
anyo = year(today())

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "orden_carga"
param_colisiones.campo = "codigo"
param_colisiones.filtro = "anyo = "+String(anyo)
param_colisiones.buscar_huecos = false

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_orden 

dw_orden.accepttext()
dw_lineas.accepttext()
dw_orden_carga_linea_reservas.accepttext()


if dw_lineas.rowcount() <= 0 and (isnull(padre_codigo) or padre_codigo = "") then
	MessageBox("Error", "No ha introducido lineas de pedido en la orden de preparación.")
	return 0
end if

//EQUIVALE A PADRE de f_guardar
//rtn = super::f_guardar()

// El primer campo del datawindow será el que reciba el código generado. 
// Por tanto, al crear el datawindow maestro debemos situar en primera posición dicho campo

//Codigo por si se desea mostrar aviso antes de guardar (Por defecto NO, si no utilizar Message.DoubleParm = 10001)

//f_crear_transaccion(transaccion ,"" ,"" ,false, "TS","")	
dw_orden.SetTransObject(trans_ts)	
dw_lineas.SetTransObject(trans_ts)	
dw_orden_carga_linea_reservas.SetTransObject(trans_ts)	

if dw_orden.rowcount() > 0 then
	dw_orden.object.empresa[dw_orden.getrow()] = codigo_empresa		
	if String(dw_orden.object.#1[dw_orden.getrow()]) = '' or isnull (dw_orden.object.#1[dw_orden.getrow()]) then
		padre_codigo = String(f_colisiones ( trans_ts, param_colisiones))
		if padre_codigo = '0'  then
			messagebox("ERROR", "No se puede asignar un código.")
			rtn = -1
			padre_codigo = ""
		else
			dw_orden.object.#1[dw_orden.getrow()] = padre_codigo
			dw_orden.object.anyo[dw_orden.getrow()] = anyo
			anyo_padre_codigo = anyo
			rtn = 1
		end if
	end if
end if

if rtn = 1 then
	rtn = dw_orden.Update();
end if

if rtn = 1 then
	for i = 1 To dw_lineas.rowcount()
		dw_lineas.object.orden_carga_linea_empresa[i] = codigo_empresa
		dw_lineas.object.orden_carga_linea_anyo[i] = anyo_padre_codigo
		dw_lineas.object.orden_carga_linea_codigo[i] = padre_codigo
		linea = dw_lineas.object.orden_carga_linea_linea[i]
		pallets_extra = dw_lineas.object.orden_carga_linea_pallets_extra[i]
		
		anyo_pedido = dw_lineas.object.orden_carga_linea_venliped_anyo[i]
		codigo_pedido = dw_lineas.object.orden_carga_linea_venliped_pedido[i]
		linea_pedido = dw_lineas.object.orden_carga_linea_venliped_linea[i]
		
		var_numpalet = dw_lineas.object.venliped_numpalet[i]
		var_tipo_pallet = dw_lineas.object.venliped_tipo_pallet[i]
		
		
		//NO VA EL UPDATE DEL DATAWINDOW - PROBAMOS MANUAL
		DELETE FROM orden_carga_linea 
		WHERE empresa = :codigo_empresa 
		AND anyo = :anyo_padre_codigo 
		AND codigo = :padre_codigo 
		AND linea = :linea 
		USING trans_ts;
		
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("Error Línea Orden de Carga. No se guardarán los cambios. ", trans_ts.SQLErrText)
			rtn = -1
		end if
		
		INSERT INTO orden_carga_linea (empresa, anyo, codigo, linea, venliped_anyo, venliped_pedido, venliped_linea, pallets_extra) 
		VALUES (:codigo_empresa, :anyo_padre_codigo, :padre_codigo, :linea, :anyo_pedido, :codigo_pedido, :linea_pedido, : pallets_extra) 
		USING trans_ts;
		
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("Error Insertando Orden de Carga. No se guardarán los cambios. ", trans_ts.SQLErrText)
			rtn = -1
		end if
		
		//ACTUALIZACIÓN DEL PEDIDO
		if rtn = 1 then
			UPDATE venliped SET numpalet = :var_numpalet, tipo_pallet = :var_tipo_pallet
			WHERE empresa = :codigo_empresa AND anyo = :anyo_pedido AND pedido = :codigo_pedido AND linea = :linea_pedido 
			USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("Error actualizando el pedido. No se guardarán los cambios. ", trans_ts.SQLErrText)
				rtn = -1
			end if
		end if
		
	next
	
	//NO VA EL UPDATE DEL DATAWINDOW - PROBAMOS MANUAL
//	if rtn = 1 then
//		rtn = dw_lineas.Update()
//	end if
end if

if rtn = 1 then
	for i = 1 To dw_orden_carga_linea_reservas.rowcount()
		dw_orden_carga_linea_reservas.object.empresa[i] = codigo_empresa
		dw_orden_carga_linea_reservas.object.anyo[i] = anyo_padre_codigo
		dw_orden_carga_linea_reservas.object.codigo[i] = padre_codigo
	next
	
	rtn = dw_orden_carga_linea_reservas.Update()
end if

//FIN EQUIVALE A PADRE de f_guardar



IF rtn = 1 THEN
	COMMIT;
	COMMIT USING trans_ts;
	
	//Actualizamos los datos en la dw de lineas (dw_datos)
	long   ll_orden_anyo,ll_donde,ll_expedicion_anyo
	string ls_orden_codigo,ls_orden_finalizada,ls_expedicion_codigo,ls_busqueda,ls_null
	datetime ldt_orden_fecha
	
	ll_orden_anyo = dw_orden.object.anyo[dw_orden.getrow()]
	ls_orden_codigo = dw_orden.object.codigo[dw_orden.getrow()]
	ldt_orden_fecha = dw_orden.object.fecha[dw_orden.getrow()]
	ls_orden_finalizada = dw_orden.object.finalizada[dw_orden.getrow()]
	ll_expedicion_anyo = dw_orden.object.expedicion_anyo[dw_orden.getrow()]
	ls_expedicion_codigo = dw_orden.object.expedicion_codigo[dw_orden.getrow()]
	
	dw_datos.setredraw(false)	
	
	for i = 1 To dw_lineas.rowcount()		
		
		anyo_pedido   = dw_lineas.object.orden_carga_linea_venliped_anyo[i]
		codigo_pedido = dw_lineas.object.orden_carga_linea_venliped_pedido[i]
		linea_pedido  = dw_lineas.object.orden_carga_linea_venliped_linea[i]
		
		ls_busqueda = "venliped_anyo = "+string(anyo_pedido,"###0")+" and "+&
						  "venliped_pedido = "+string(codigo_pedido,"#######0")+" and "+&
						  "venliped_linea = "+string(linea_pedido,"#######0")
		
		ll_donde = dw_datos.find(ls_busqueda,1,dw_datos.rowcount())
		
		setnull(ls_null)
		
		if ll_donde > 0 then
			dw_datos.object.orden_carga[ll_donde] = string(ll_orden_anyo,"####")+"/"+ls_orden_codigo
			if ls_orden_finalizada = "S" then
				dw_datos.object.orden_carga_finalizada[ll_donde] = string(ll_orden_anyo,"####")+"/"+ls_orden_codigo
			else
				dw_datos.object.orden_carga_finalizada[ll_donde] = ls_null
			end if
			dw_datos.object.fecha_orden_carga[ll_donde] = ldt_orden_fecha
			
			dw_datos.object.codigo_expedicion[ll_donde] = string(ll_expedicion_anyo,"####")+"-"+ls_expedicion_codigo
		end if
		
	next
	
	dw_datos.setredraw(true)
	//
	mostrar_controles_edicion()

	dw_orden.setfocus()
	dw_orden.setcolumn(2)
ELSE
	ROLLBACK;
	ROLLBACK USING trans_ts;
END IF

dw_orden.SetTransObject(SQLCA)	
dw_lineas.SetTransObject(SQLCA)	
dw_orden_carga_linea_reservas.SetTransObject(SQLCA)

estado = 1 // Modo edición

//if actualizar then
//	fila_actual = dw_datos.getrow()
//	pb_anyadir1.triggerevent(clicked!)
//	if fila_actual > 0 then
//		dw_datos.setrow(fila_actual)
//		dw_datos.scrolltorow(fila_actual)
//		dw_datos.selectrow(fila_actual, true)
//	end if
//end if

//fila_actual = dw_datos.GetSelectedRow (0)//dw_datos.getrow()
//
////ojo Probando .....
////pb_anyadir1.triggerevent(clicked!)
//
//if fila_actual > 0 then
//	dw_datos.setrow(fila_actual)
//	dw_datos.scrolltorow(fila_actual)
//	dw_datos.selectrow(fila_actual, true)
//end if

//orden_carga = dw_datos.object.orden_carga[fila_actual]
//posicion = pos(lower(orden_carga), '/')
//anyo = Integer(mid(orden_carga, 1, posicion - 1))
//orden_carga = mid(orden_carga, posicion + 1)

if padre_codigo <> "" then
	f_buscar(padre_codigo, anyo_padre_codigo)		
end if


return rtn

end function

public subroutine f_buscar (string orden_carga, integer anyo);int newrow
string campo
long numero_valores, total
str_wt_busquedas_salida resultado_busqueda
integer columna

Dec pedido, anyo_pedido, pedido_anterior, anyo_pedido_anterior
Long i, fila
String texto_pedido_observaciones, texto_observaciones

if orden_carga = "" then
	padre_busqueda.filtro_es_codigo = true
	padre_busqueda.consulta =  "SELECT orden_carga.codigo, orden_carga.codigo, orden_carga.anyo, orden_carga.fecha "+&
										" FROM orden_carga "+&
										" WHERE orden_carga.empresa = '"+codigo_empresa+"' "+&
										" ORDER BY CONVERT(integer, orden_carga.codigo) desc"
	padre_busqueda.titulos[1] = "Código"
	padre_busqueda.titulos[2] = "Código"
	padre_busqueda.titulos[3] = "Anyo"
	padre_busqueda.titulos[4] = "Fecha"	
		
	if hay_cambios() = true and permiso_ventana > 1 then
		if MessageBox("Atención", "¿Desea grabar las modificaciones?", Exclamation!, YesNo!, 2) = 1 then
			if f_guardar(false) <> 1 then
				return //Fallo de validación en la grabación, no buscar
			end if
		end if
	end if
	
	columna = dw_orden.GetColumn()
	OpenWithParm(wt_busquedas, padre_busqueda)
	resultado_busqueda = Message.PowerObjectParm		// Devuelve el valor que encuentra ...
	if resultado_busqueda.error = '' then
		numero_valores = UpperBound(resultado_busqueda.valores)
		if not isnull(numero_valores) and numero_valores >= 1 then
			padre_codigo = resultado_busqueda.valores[1]
			anyo_padre_codigo = Dec(resultado_busqueda.valores[3])
			total = dw_orden.retrieve (codigo_empresa, anyo_padre_codigo, padre_codigo)
			estado = 1 // Modo edición
			dw_lineas.retrieve (codigo_empresa, anyo_padre_codigo, padre_codigo)
			dw_orden_carga_linea_reservas.retrieve (codigo_empresa, anyo_padre_codigo, padre_codigo)
		else
			padre_codigo = ""
			anyo_padre_codigo = 0
			if dw_orden.rowcount() > 0 then
				if dw_orden.getrow() > 0 and dw_orden.object.#1[dw_orden.getrow()] <> "" then
					padre_codigo = dw_orden.object.#1[dw_orden.getrow()]
					anyo_padre_codigo = dw_orden.object.anyo[dw_orden.getrow()]
				end if
			end if
		end if
	else
		messagebox("Error", resultado_busqueda.error )
	end if
	
	mostrar_controles_edicion()
	
	dw_orden.setfocus()
	if dw_orden.rowcount() > 0 then
		dw_orden.SetColumn(columna)
	end if
else
	total = dw_orden.retrieve (codigo_empresa, anyo, orden_carga)
	padre_codigo = orden_carga
	anyo_padre_codigo = anyo
	estado = 1 // Modo edición
	dw_lineas.retrieve (codigo_empresa, anyo, orden_carga)
	dw_orden_carga_linea_reservas.retrieve (codigo_empresa, anyo, orden_carga)
	mostrar_controles_edicion()
	
	dw_orden.setfocus()
	if dw_orden.rowcount() > 0 then
		dw_orden.SetColumn(columna)
	end if
end if

//OBSERVACIONES DE LOS PEDIDOS
dw_observaciones_pedidos.reset()
for i = 1 To dw_lineas.rowcount()
	anyo_pedido = dw_lineas.object.orden_carga_linea_venliped_anyo[i]
	pedido = dw_lineas.object.orden_carga_linea_venliped_pedido[i]
	
	if i = 1 then
		pedido_anterior = pedido
		anyo_pedido_anterior = anyo_pedido 
	end if
	
	if  i = 1 or (pedido <> pedido_anterior and anyo_pedido <> anyo_pedido_anterior) then
		texto_pedido_observaciones = String(anyo_pedido) + "/"+String(pedido)
		texto_observaciones = ""
		
		SELECT observaciones INTO :texto_observaciones FROM venped WHERE empresa = :codigo_empresa AND anyo = :anyo_pedido AND pedido = :pedido;
		if dw_observaciones_pedidos.find(" pedido LIKE '"+texto_pedido_observaciones+"' ", 1,dw_observaciones_pedidos.rowcount()) = 0 AND texto_observaciones <> "" then
			fila = dw_observaciones_pedidos.insertrow(0)
			
			dw_observaciones_pedidos.object.pedido [fila] = texto_pedido_observaciones
			dw_observaciones_pedidos.object.observaciones [fila] = texto_observaciones
		end if
	end if
	
	
	pedido_anterior = pedido
	anyo_pedido_anterior = anyo_pedido 
next
end subroutine

public subroutine f_fin_orden_carga (boolean con_movimiento);str_ventana_alerta parametros
string botones[2]
Int alerta
Boolean falta_numpallet

String new_sql
rtn = 1
Long i, j

str_almacenmovimientos movimiento
String orden_carga, articulo, cod_formato, almacen_destino, zona_destino, almacen_origen, zona_origen, familia, tono, calidad, pallets, cajas
Long linea
Int fila_destino, altura_destino, fila_origen, altura_origen, calibre
Dec cantidad
string cliente
string v_anyo, v_pedido, v_linea

if dw_orden.getrow() <= 0 then
	MessageBox("Error", "Debe seleccionar una orden de preparación antes de finalizarla")
	return
end if

if isnull(padre_codigo) or padre_codigo = "" then
	MessageBox("Error", "Debe guardar y añadir líneas antes de finalizar una orden de preparación")
	return
end if

if dw_lineas.rowcount() <= 0 then
	MessageBox("Error", "Debe  añadir líneas antes de finalizar una orden de preparación")
	return
end if

if isnull(dw_orden.object.almacen_destino[dw_orden.getrow()]) or trim(dw_orden.object.almacen_destino[dw_orden.getrow()]) = ""      &
			or isnull(dw_orden.object.zona_destino[dw_orden.getrow()]) or trim(dw_orden.object.zona_destino[dw_orden.getrow()]) = ""   & 
			or isnull(dw_orden.object.fila_destino[dw_orden.getrow()]) or dec(dw_orden.object.fila_destino[dw_orden.getrow()]) <= 0    &
			or isnull(dw_orden.object.altura_destino[dw_orden.getrow()]) or dec(dw_orden.object.altura_destino[dw_orden.getrow()]) <= 0 then
	MessageBox("Error", "Para finalizar una orden de preparación debe indicar el destino del material definitivo")
	return
end if

i = 1
falta_numpallet = false
do while i<= dw_lineas.rowcount() and not falta_numpallet
	if isnull(dw_lineas.object.venliped_numpalet[i]) or dec(dw_lineas.object.venliped_numpalet[i]) <= 0 then
		falta_numpallet = true
	end if
	i++
loop

//if falta_numpallet then
//	if MessageBox("Atención", "Falta introducir los números de los pallets preparados.  ¿Desea continuar? ", Exclamation!, YesNo!, 2 ) <> 1 then
//		return
//	end if
//end if

if falta_numpallet then
	parametros.titulo = "Importante"
	parametros.subtitulo = "Faltan Números de pallets"
	parametros.mensaje = "Falta introducir los números de los pallets preparados.  ¿Desea continuar?"
	parametros.tipo = 1
	botones[1] = "Sí"
	botones[2] = "No"
	parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	alerta = Int(Message.DoubleParm)
	if alerta = 2 then
		return
	end if
end if

rtn = 1 //Todo ok

if isnull(padre_codigo) or padre_codigo = "" or dw_orden.getrow() <= 0 then
	return 
end if

parametros.titulo = "Importante"
parametros.subtitulo = "Finalizar Orden de Carga"
parametros.mensaje = "No se admitirán cambios en la orden una vez finalizada. ¿Desea continuar?"
parametros.tipo = 2
botones[1] = "Sí"
botones[2] = "No"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
alerta = Int(Message.DoubleParm)
if alerta = 2 then
	return
end if

//Movimientos automáticos
long   ll_anyo_orden_carga,ll_linea_orden_carga,ll_venliped_numpallet,ll_donde_numpallet,ll_id_alm_bultos_origen,ll_existe_bulto_en_reservas 
dec    ld_cantidad_pendiente_bulto
string ls_orden_carga

if dw_orden.rowcount() > 0 and rtn = 1 then
	orden_carga = String(dw_orden.object.anyo[dw_orden.getrow()]) + " / "+ dw_orden.object.codigo[dw_orden.getrow()]
	ll_anyo_orden_carga = dw_orden.object.anyo[dw_orden.getrow()]
	ls_orden_carga      = dw_orden.object.codigo[dw_orden.getrow()]
	
	almacen_destino =  dw_orden.object.almacen_destino[dw_orden.getrow()]
	zona_destino =  dw_orden.object.zona_destino[dw_orden.getrow()]
	fila_destino =  dw_orden.object.fila_destino[dw_orden.getrow()]
	altura_destino =  dw_orden.object.altura_destino[dw_orden.getrow()]
	
	dw_lineas.setredraw(false)
	dw_lineas.setsort("orden_carga_linea_venliped_anyo A , orden_carga_linea_venliped_pedido A, orden_carga_linea_venliped_linea A")
	dw_lineas.sort()
	i = 1
	Do while i <= dw_lineas.rowcount() and rtn = 1
		
		v_anyo                = string(dw_lineas.object.orden_carga_linea_venliped_anyo [i]) 
		v_pedido              = string(dw_lineas.object.orden_carga_linea_venliped_pedido [i]) 
		v_linea               = string(dw_lineas.object.orden_carga_linea_venliped_linea [i]) 		
		
		select formato,
				 tipo_pallet,
				 caja,
				 familia,
				 cliente 
		into   :cod_formato,
				 :pallets,
				 :cajas,
				 :familia,
				 :cliente 
		from  venliped 
		where empresa = :codigo_empresa
		and   anyo    = :v_anyo
		and   pedido  = :v_pedido
		and   linea   = :v_linea 
		using trans_ts;
				
		// Una vez que hemos preparado la carga, marcaremos el pedido como fabricado
		update venliped 
		set    esta_fabricado = 'S',
				 situacion = 'P'
		where empresa = :codigo_empresa
		and   anyo    = :v_anyo
		and   pedido  = :v_pedido
		and   linea   = :v_linea 
		using trans_ts;
		
		if trans_ts.SQLCode = -1 then
			rtn = -1
		end if
		
		linea                 = dw_lineas.object.orden_carga_linea_linea[i]
		ll_linea_orden_carga  = dw_lineas.object.orden_carga_linea_linea[i]
		articulo              = dw_lineas.object.venliped_articulo[i]
		ll_venliped_numpallet = dw_lineas.object.venliped_numpalet[i]
		
		if not isnull(articulo) and articulo <> "" then
			if isnull(cod_formato) or cod_formato = "" then
				MessageBox("Error", "Artículo sin formato "+articulo)
				rtn = -1
			end if
		end if
			
		//LOS ARTÍCULOS SIN ALTA, NO REQUIREN MOVIMIENTO, EL RESTO SI
		if rtn= 1 and (not isnull(articulo) and articulo <> "") then
			dw_orden_carga_linea_reservas.setfilter("linea = "+String(linea))
			dw_orden_carga_linea_reservas.filter()
			dw_orden_carga_linea_reservas.sort()
			
			j = 1
			Do while j <= dw_orden_carga_linea_reservas.rowcount() and rtn = 1 
				//Aqui cambiamos a la nueva gestion de movimientos
				str_movimiento_almacen lstr_movimiento_almacen
				
				tono    = dw_orden_carga_linea_reservas.object.tono[j]
				calibre = dw_orden_carga_linea_reservas.object.calibre[j]
				calidad = dw_orden_carga_linea_reservas.object.calidad[j]						
				
				lstr_movimiento_almacen.empresa            = codigo_empresa
				lstr_movimiento_almacen.articulo           = articulo
				lstr_movimiento_almacen.calidad            = calidad
				lstr_movimiento_almacen.tono               = tono
				lstr_movimiento_almacen.calibre            = calibre
				lstr_movimiento_almacen.tipo_pallet        = pallets
				lstr_movimiento_almacen.caja               = cajas
				lstr_movimiento_almacen.cantidad           = (dw_orden_carga_linea_reservas.object.cantidad[j] * -1)
				lstr_movimiento_almacen.orden_carga_anyo   = 0
				lstr_movimiento_almacen.orden_carga_codigo = ""
				lstr_movimiento_almacen.orden_carga_linea  = 0
				lstr_movimiento_almacen.tipo_movimiento    = "204" //Salida Preparación
				lstr_movimiento_almacen.observaciones      = ""
				lstr_movimiento_almacen.almacen            = dw_orden_carga_linea_reservas.object.almacen[j]
				lstr_movimiento_almacen.zona               = dw_orden_carga_linea_reservas.object.zona[j]
				lstr_movimiento_almacen.fila               = dw_orden_carga_linea_reservas.object.fila[j]
				lstr_movimiento_almacen.altura             = dw_orden_carga_linea_reservas.object.altura[j]
				lstr_movimiento_almacen.tercero            = ""
				lstr_movimiento_almacen.documento          = ""
				lstr_movimiento_almacen.fecha              = datetime(today(),now())
				lstr_movimiento_almacen.id_ubicacion       = 0
				lstr_movimiento_almacen.id_alm_bultos		 = dw_orden_carga_linea_reservas.object.id_alm_bultos[j]
								
				if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
					rtn = 0
				end if
				
				//Si la salida ha sido de todo el bulto la entrada será tambien de ese mismo bulto a no ser que estemos agrupando sobre otro bulto
				//Esto lo controlamos mediante el numero de pallet
				
				lstr_movimiento_almacen.id_alm_bultos = 0	
				
				SELECT isnull(max(orden_carga_linea_reservas.id_alm_bultos),0)
				INTO   :lstr_movimiento_almacen.id_alm_bultos 
				FROM  orden_carga_linea_reservas,
						orden_carga_linea,
						venliped 
				WHERE orden_carga_linea_reservas.empresa = orden_carga_linea.empresa 
				AND   orden_carga_linea_reservas.anyo    = orden_carga_linea.anyo 
				AND   orden_carga_linea_reservas.codigo  = orden_carga_linea.codigo 	
				AND   orden_carga_linea_reservas.linea   = orden_carga_linea.linea 	
				AND   orden_carga_linea.empresa          = venliped.empresa
				AND   orden_carga_linea.venliped_anyo    = venliped.anyo
				AND   orden_carga_linea.venliped_pedido  = venliped.pedido
				AND   orden_carga_linea.venliped_linea   = venliped.linea	
				AND   orden_carga_linea_reservas.empresa = :codigo_empresa 
				AND   orden_carga_linea_reservas.anyo    = :ll_anyo_orden_carga 
				AND   orden_carga_linea_reservas.codigo  = :ls_orden_carga 
				AND   venliped.numpalet                  = :ll_venliped_numpallet;
				
				
				if lstr_movimiento_almacen.id_alm_bultos <> 0 then
					lstr_movimiento_almacen.tipo_pallet = ""
					
					select isnull(alm_bultos.tipo_pallet,'')
					into   :lstr_movimiento_almacen.tipo_pallet
					from   alm_bultos
					where  alm_bultos.id = :lstr_movimiento_almacen.id_alm_bultos;
					
					if trim(lstr_movimiento_almacen.tipo_pallet) = "" then
						lstr_movimiento_almacen.tipo_pallet   = pallets
					end if
				else
					lstr_movimiento_almacen.id_alm_bultos		 = dw_orden_carga_linea_reservas.object.id_alm_bultos[j]
					lstr_movimiento_almacen.tipo_pallet = pallets
										
					ld_cantidad_pendiente_bulto = 0
					
					SELECT isnull(sum(alm_bultos_lineas.cantidad),0)
					INTO   :ld_cantidad_pendiente_bulto
					FROM   alm_bultos,   
							 alm_bultos_lineas  
					WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
					AND ( ( alm_bultos.id = :lstr_movimiento_almacen.id_alm_bultos ) ) ;
					
					if ld_cantidad_pendiente_bulto = 0 and dw_lineas.object.id_alm_bultos[i] = 0 then
						dw_lineas.object.id_alm_bultos[i] = lstr_movimiento_almacen.id_alm_bultos
					end if
										
				end if				
				
				//Fin de lo nuevo
				
				//Debo controlar si traspaso el bulto o pongo las cajas en destino sobre otro que ya existe
				//Lo hacemos mediante venliped_numpallet
				
				lstr_movimiento_almacen.empresa            = codigo_empresa
				lstr_movimiento_almacen.articulo           = articulo
				lstr_movimiento_almacen.calidad            = calidad
				lstr_movimiento_almacen.tono               = tono
				lstr_movimiento_almacen.calibre            = calibre
				//lstr_movimiento_almacen.tipo_pallet        = pallets
				lstr_movimiento_almacen.caja               = cajas
				lstr_movimiento_almacen.cantidad           = dw_orden_carga_linea_reservas.object.cantidad[j]
				lstr_movimiento_almacen.orden_carga_anyo   = ll_anyo_orden_carga
				lstr_movimiento_almacen.orden_carga_codigo = ls_orden_carga
				lstr_movimiento_almacen.orden_carga_linea  = ll_linea_orden_carga
				lstr_movimiento_almacen.tipo_movimiento    = "205" //Entrada Preparación
				lstr_movimiento_almacen.observaciones      = ""
				lstr_movimiento_almacen.almacen            = almacen_destino
				lstr_movimiento_almacen.zona               = zona_destino
				lstr_movimiento_almacen.fila               = fila_destino
				lstr_movimiento_almacen.altura             = altura_destino
				lstr_movimiento_almacen.tercero            = ""
				lstr_movimiento_almacen.documento          = ""
				lstr_movimiento_almacen.fecha              = datetime(today(),now())
				lstr_movimiento_almacen.id_ubicacion       = 0
				lstr_movimiento_almacen.id_alm_bultos		 = dw_lineas.object.id_alm_bultos[i]
				
				//Introduce pallet a pallet
				if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
					rtn = 0
				end if								
				
				if dw_lineas.object.id_alm_bultos[i] = 0 then
					//Si no tenia id de pallet asignado la funcion f_movimiento_almacen asignara un id que debemos propagar al resto de articulos que van en ese numero de pallet
					ll_donde_numpallet = i
					do
						ll_donde_numpallet = dw_lineas.find("venliped_numpalet = "+string(ll_venliped_numpallet,"##0")+" and id_alm_bultos = 0",ll_donde_numpallet,dw_lineas.rowcount())
						
						if ll_donde_numpallet > 0 then
							dw_lineas.object.id_alm_bultos[ll_donde_numpallet] = lstr_movimiento_almacen.id_alm_bultos
							ll_donde_numpallet ++	
						end if
						
					loop while ll_donde_numpallet > 0 and ll_donde_numpallet <= dw_lineas.rowcount()
					
				end if
				
				if dw_orden_carga_linea_reservas.object.id_alm_bultos[j] <> lstr_movimiento_almacen.id_alm_bultos then
					//Vamos a cambiar la reserva al nuevo bulto
					ll_id_alm_bultos_origen = dw_orden_carga_linea_reservas.object.id_alm_bultos[j]
					
					ll_existe_bulto_en_reservas = 0
					
					SELECT isnull(count(*),0)
					INTO   :ll_existe_bulto_en_reservas
					FROM   orden_carga_linea_reservas
					WHERE  orden_carga_linea_reservas.empresa       = :lstr_movimiento_almacen.empresa
					AND    orden_carga_linea_reservas.anyo          = :lstr_movimiento_almacen.orden_carga_anyo
					AND    orden_carga_linea_reservas.codigo        = :lstr_movimiento_almacen.orden_carga_codigo
					AND    orden_carga_linea_reservas.linea         = :lstr_movimiento_almacen.orden_carga_linea
					AND    orden_carga_linea_reservas.id_alm_bultos = :lstr_movimiento_almacen.id_alm_bultos;
					
					if ll_existe_bulto_en_reservas = 0 then
						//Cambiamos la reserva de bulto
						UPDATE orden_carga_linea_reservas
						SET    orden_carga_linea_reservas.id_alm_bultos = :lstr_movimiento_almacen.id_alm_bultos
						WHERE  orden_carga_linea_reservas.empresa       = :lstr_movimiento_almacen.empresa
						AND    orden_carga_linea_reservas.anyo          = :lstr_movimiento_almacen.orden_carga_anyo
						AND    orden_carga_linea_reservas.codigo        = :lstr_movimiento_almacen.orden_carga_codigo
						AND    orden_carga_linea_reservas.linea         = :lstr_movimiento_almacen.orden_carga_linea
						AND    orden_carga_linea_reservas.id_alm_bultos = :ll_id_alm_bultos_origen;	
						
						if sqlca.sqlcode <> 0 then
							rtn = 0
						end if
					else
						//Cambiamos la cantidad reservada en el bulto
						UPDATE orden_carga_linea_reservas
						SET    orden_carga_linea_reservas.cantidad      = orden_carga_linea_reservas.cantidad + :lstr_movimiento_almacen.cantidad 
						WHERE  orden_carga_linea_reservas.empresa       = :lstr_movimiento_almacen.empresa
						AND    orden_carga_linea_reservas.anyo          = :lstr_movimiento_almacen.orden_carga_anyo
						AND    orden_carga_linea_reservas.codigo        = :lstr_movimiento_almacen.orden_carga_codigo
						AND    orden_carga_linea_reservas.linea         = :lstr_movimiento_almacen.orden_carga_linea
						AND    orden_carga_linea_reservas.id_alm_bultos = :lstr_movimiento_almacen.id_alm_bultos;		
						
						if sqlca.sqlcode <> 0 then
							rtn = 0
						end if						
						
						//Borramos la reserva original
						DELETE orden_carga_linea_reservas
						WHERE  orden_carga_linea_reservas.empresa       = :lstr_movimiento_almacen.empresa
						AND    orden_carga_linea_reservas.anyo          = :lstr_movimiento_almacen.orden_carga_anyo
						AND    orden_carga_linea_reservas.codigo        = :lstr_movimiento_almacen.orden_carga_codigo
						AND    orden_carga_linea_reservas.linea         = :lstr_movimiento_almacen.orden_carga_linea
						AND    orden_carga_linea_reservas.id_alm_bultos = :ll_id_alm_bultos_origen;											
						
						if sqlca.sqlcode <> 0 then
							rtn = 0
						end if						
					end if
					
				end if				
				
				j++
				/*
				cantidad = dw_orden_carga_linea_reservas.object.cantidad[j]
				
				tono = dw_orden_carga_linea_reservas.object.tono[j]
				calibre = dw_orden_carga_linea_reservas.object.calibre[j]
				calidad = dw_orden_carga_linea_reservas.object.calidad[j]		
				
				almacen_origen = dw_orden_carga_linea_reservas.object.almacen[j]
				zona_origen = dw_orden_carga_linea_reservas.object.zona[j]
				fila_origen = dw_orden_carga_linea_reservas.object.fila[j]
				altura_origen = dw_orden_carga_linea_reservas.object.altura[j]
				
				//Salida de origen
				movimiento.empresa = codigo_empresa
				movimiento.fecha_intr = Datetime(Today(), now())
				movimiento.fecha_mov = Today()
				movimiento.origen = ""
				movimiento.almacen = almacen_origen
				movimiento.zona = zona_origen
				movimiento.fila = fila_origen
				movimiento.altura = altura_origen
				movimiento.articulo = articulo
				movimiento.familia = familia
				movimiento.formato = cod_formato
				movimiento.calidad = calidad
				movimiento.tono = tono
				movimiento.calibre = calibre
				movimiento.tipo_pallet = pallets
				movimiento.caja = cajas
				movimiento.cantidade = 0
				movimiento.cantidads = cantidad
				movimiento.tipomov = "204" //Salida Preparación
				movimiento.tipo_unidad = "0"
				movimiento.usuario = nombre_usuario
				movimiento.observaciones = "ORDEN DE PREPARACIÓN - "+ orden_carga
				
				if ftc_movimiento_almacen(movimiento, trans_ts) <> 0 then
					rtn = -1 
				end if				
				
				//Entrada en Muelle
				if rtn = 1 then
					movimiento.empresa = codigo_empresa
					movimiento.fecha_intr = Datetime(Today(), now())
					movimiento.fecha_mov = Today()
					movimiento.origen = ""
					movimiento.almacen = almacen_destino
					movimiento.zona = zona_destino
					movimiento.fila = fila_destino
					movimiento.altura = altura_destino
					movimiento.articulo = articulo
					movimiento.familia = familia
					movimiento.formato = cod_formato
					movimiento.calidad = calidad
					movimiento.tono = tono
					movimiento.calibre = calibre
					movimiento.tipo_pallet = pallets
					movimiento.caja = cajas
					movimiento.cantidade = cantidad
					movimiento.cantidads = 0
					movimiento.tipomov = "205" //Entrada Preparación
					movimiento.tipo_unidad = "0"
					movimiento.usuario = nombre_usuario
					movimiento.observaciones = "ORDEN DE PREPARACIÓN - "+ orden_carga
					if ftc_movimiento_almacen(movimiento, trans_ts) <> 0 then
						rtn = -1 
					end if
				end if
				j++
				*/
			loop
		end if
		i++	
	loop
		
	dw_lineas.setsort("orden_carga_linea_linea A")
	dw_lineas.sort()
	dw_lineas.setredraw(true)
	
end if

if rtn = 1 then
	dw_orden.settransobject(trans_ts)
	dw_orden.accepttext()
	dw_orden.object.finalizada[dw_orden.getrow()] = 'S'
	dw_orden.object.fecha_fin[dw_orden.getrow()] = Datetime(Today(), Now())
	rtn = dw_orden.update()
	
end if

if rtn = 1 then
	COMMIT;
	
	COMMIT USING trans_ts;
	
	//Actualizamos los datos en la dw de lineas (dw_datos)
	long   ll_orden_anyo,ll_donde,anyo_pedido,codigo_pedido,linea_pedido,ll_expedicion_anyo
	string ls_orden_codigo,ls_orden_finalizada,ls_expedicion_codigo,ls_busqueda,ls_null
	datetime ldt_orden_fecha
	
	ll_orden_anyo = dw_orden.object.anyo[dw_orden.getrow()]
	ls_orden_codigo = dw_orden.object.codigo[dw_orden.getrow()]
	ldt_orden_fecha = dw_orden.object.fecha[dw_orden.getrow()]
	ls_orden_finalizada = dw_orden.object.finalizada[dw_orden.getrow()]
	ll_expedicion_anyo = dw_orden.object.expedicion_anyo[dw_orden.getrow()]
	ls_expedicion_codigo = dw_orden.object.expedicion_codigo[dw_orden.getrow()]
		
	setnull(ls_null)	
		
	for i = 1 To dw_lineas.rowcount()
		anyo_pedido   = dw_lineas.object.orden_carga_linea_venliped_anyo[i]
		codigo_pedido = dw_lineas.object.orden_carga_linea_venliped_pedido[i]
		linea_pedido  = dw_lineas.object.orden_carga_linea_venliped_linea[i]
		
		ls_busqueda = "venliped_anyo = "+string(anyo_pedido,"###0")+" and "+&
						  "venliped_pedido = "+string(codigo_pedido,"#######0")+" and "+&
						  "venliped_linea = "+string(linea_pedido,"#######0")
		
		ll_donde = dw_datos.find(ls_busqueda,1,dw_datos.rowcount())
		
		if ll_donde > 0 then
			dw_datos.object.orden_carga[ll_donde] = string(ll_orden_anyo,"####")+"/"+ls_orden_codigo
			if ls_orden_finalizada = "S" then
				dw_datos.object.orden_carga[ll_donde] = string(ll_orden_anyo,"####")+"/"+ls_orden_codigo
			else
				dw_datos.object.orden_carga[ll_donde] = ls_null
			end if
			dw_datos.object.fecha_orden_carga[ll_donde] = ldt_orden_fecha
			
			dw_datos.object.codigo_expedicion[ll_donde] = string(ll_expedicion_anyo,"####")+"-"+ls_expedicion_codigo
		end if
	next
	//	
	
else
	ROLLBACK;
	
	ROLLBACK USING trans_ts;
	MessageBox("Error de finalización", "No se ha podido finalizar la orden de preparación. Intentelo de nuevo y si el error se repite, póngase en contacto con el administrador.")
end if
dw_orden.settransobject(sqlca)	

//Las reservas las hemos updateado a mano. Hacemos de nuevo el retrieve para que no falle la funcion f_guardar
dw_orden_carga_linea_reservas.reset()
dw_orden_carga_linea_reservas.retrieve(codigo_empresa,ll_anyo_orden_carga,ls_orden_carga)

f_guardar(true)
end subroutine

public subroutine f_marcar_solo_disponibles ();Long i 

For i=1 To dw_datos.rowcount()
	if dw_datos.object.estado_pedido[i] = "DISPONIBLE" then
		dw_datos.object.visible[i] = 1
	else
		dw_datos.object.visible[i] = 0
	end if	
next

/*
Long i, j, linea_inicio = 1
Dec pedido_actual, pedido_anterior = -1, pedido_aux, disponible, solicitado
Integer visible_linea = 1

dw_datos.visible = false
For i=1 To dw_datos.rowcount()
	pedido_actual = dw_datos.object.venliped_pedido[i]
	if pedido_actual = 444 then
		pedido_actual = 444
	end if
	if pedido_actual = pedido_anterior or pedido_anterior = -1 then
		disponible = dw_datos.object.disponible[i]
		solicitado = dw_datos.object.venliped_cantidad[i]
		if isnull(disponible) or disponible < 0 then
			disponible = 0
		end if
		if isnull(solicitado) or solicitado < 0 then
			solicitado = 0
		end if
		if solicitado  > disponible then
			visible_linea = 0
		end if
	else
		//Actualizamos el estado de todas las líneas del pedido anterior
		if visible_linea = 0 then
			j = linea_inicio
			do while visible_linea = 0 and j < i
				pedido_aux =  dw_datos.object.venliped_pedido[j]
				dw_datos.object.visible[j] = 0
				j ++
			loop
		end if	
		visible_linea = 1
		linea_inicio = i
		//Controlamos la primera línea del pedido
		disponible = dw_datos.object.disponible[i]
		solicitado = dw_datos.object.venliped_cantidad[i]
		if isnull(disponible) or disponible < 0 then
			disponible = 0
		end if
		if isnull(solicitado) or solicitado < 0 then
			solicitado = 0
		end if
		if solicitado  > disponible then
			visible_linea = 0
		end if
	end if
	
	pedido_anterior = pedido_actual
Next

//Ultima linea
if visible_linea = 0 then
	j = linea_inicio
	do while visible_linea = 0 and j < i
		pedido_aux =  dw_datos.object.venliped_pedido[j]
		dw_datos.object.visible[j] = 0
		j ++
	loop
end if	
dw_datos.visible = true
*/

end subroutine

public subroutine f_mostrar_estado (string estado_pedido);//Long i 
//
////estado_pedido = "" muestra de nuevo todos los pedidos
//
//estado_pedido = trim(f_reemplazar(f_reemplazar(estado_pedido,"(",""),")",""))
//
//For i=1 To dw_datos.rowcount()
//	if estado_pedido <> "" then
//		if pos(dw_datos.object.estado_pedido[i], estado_pedido) > 0 then
//			dw_datos.object.visible[i] = 1
//		else
//			dw_datos.object.visible[i] = 0
//		end if	
//	else
//		dw_datos.object.visible[i] = 1
//	end if
//next
end subroutine

public subroutine f_nuevo (integer expedicion_anyo, string expedicion_codigo, string cliente);Long newrow, total_ordenes
Transaction trm

if dw_datos.getrow() <= 0 then
	return
end if

if hay_cambios() = true then
	if MessageBox("Atención", "¿Desea grabar las modificaciones?", Exclamation!, YesNo!, 2) = 1 then
		if f_guardar(false) <> 1 then
			return  //Fallo de validación en la grabación, no crear nuevo
		end if
	end if
end if

estado = 0 // Modo Inserción
padre_codigo = ''
anyo_padre_codigo = 0
dw_orden.reset()
dw_lineas.reset()
dw_orden_carga_linea_reservas.reset()	

newrow = dw_orden.insertRow(0);

dw_orden.scrollToRow(newrow);
dw_orden.setfocus()

mostrar_controles_insercion()

if dw_orden.rowcount() > 0 then
	dw_orden.SetColumn(2)
	dw_orden.object.empresa[dw_orden.getrow()] = codigo_empresa
	dw_orden.object.anyo[dw_orden.getrow()] = year(Today())
	dw_orden.object.fecha[dw_orden.getrow()] = Datetime(Today(), now())
	dw_orden.object.finalizada[dw_orden.getrow()] = 'N'
	dw_orden.object.cliente[dw_orden.getrow()] = cliente
	dw_orden.object.expedicion_anyo[dw_orden.getrow()] = expedicion_anyo
	dw_orden.object.expedicion_codigo[dw_orden.getrow()] = expedicion_codigo
end if

end subroutine

public subroutine f_salir ();padre_codigo = ""
dw_orden.reset()
dw_lineas.reset()
end subroutine

public function integer f_borrar (boolean sin_preguntar);str_ventana_alerta parametros
string botones[2]
Int anyo, fila_actual

rtn = 1 //Todo ok

if isnull(padre_codigo) or padre_codigo = "" or dw_orden.getrow() <= 0 then
	return -1
end if

if dw_orden.object.finalizada[dw_orden.getrow()] = 'S' and dw_lineas.rowcount() > 0 then
	MessageBox("Error", "No puede eliminar una orden finalizada con líneas. Primero debe borrar cada una de sus líneas.")
	return -1
end if

if not sin_preguntar then
	parametros.titulo = "Atención"
	parametros.subtitulo = "Borrar registro"
	parametros.mensaje = "¿Desea borrar el registro?"
	parametros.tipo = 1
	botones[1] = "Sí"
	botones[2] = "No"
	parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	borrar = Int(Message.DoubleParm)
end if

if borrar = 1 or sin_preguntar then
	dw_orden.SetTransObject(trans_ts)	

	padre_codigo = dw_orden.object.#1[dw_orden.GetRow()]
	anyo = dw_orden.object.anyo[dw_orden.GetRow()]
	rtn = dw_orden.deleterow(0)
	if rtn = 1 then
		rtn = dw_orden.update()
	end if
	
	if rtn = 1 then
		DELETE FROM orden_carga_linea WHERE empresa = :codigo_empresa AND anyo = :anyo AND codigo = :padre_codigo USING trans_ts;
		IF trans_ts.sqlcode <> 0 THEN
			rtn = -1
		END IF
	end if
	
	if rtn = 1 then
		DELETE FROM orden_carga_linea_origen WHERE empresa = :codigo_empresa AND anyo = :anyo AND codigo = :padre_codigo USING trans_ts;
		IF trans_ts.sqlcode <> 0 THEN
			rtn = -1
		END IF
	end if
	
	if rtn = 1 then
		DELETE FROM orden_carga_linea_reservas WHERE empresa = :codigo_empresa AND anyo = :anyo AND codigo = :padre_codigo USING trans_ts;
		IF trans_ts.sqlcode <> 0 THEN
			rtn = -1
		END IF
	end if	
	
	if rtn = 1 then
		COMMIT USING trans_ts;
		dw_orden.EVENT clicked(0, 0, 0, dw_orden.object.p_nuevo)
		
	else
		MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
		ROLLBACK USING trans_ts;
		dw_orden.object.#1[1] = padre_codigo
		dw_orden.object.anyo[1] = anyo_padre_codigo
	end if
	dw_orden.SetTransObject(SQLCA)	
end if


fila_actual = dw_datos.getrow()
//pb_anyadir1.triggerevent(clicked!)
if fila_actual > 0 then
	dw_datos.setrow(fila_actual)
	dw_datos.scrolltorow(fila_actual)
	dw_datos.selectrow(fila_actual, true)
end if

return rtn
end function

public subroutine f_imprimir_documentacion_pallet (integer numpalet);String sel, expedicion_codigo, cliente, familia, sql_numpalet
Int expedicion_anyo
Datastore consulta
Long i, numero, fila

//GUARDAR PRIMERO PARA ACTUALIZAR NUMERO DE PALLETS
f_guardar(true)

if dw_orden.rowcount() <= 0 then
	return
end if

expedicion_anyo = dw_orden.object.expedicion_anyo[dw_orden.getrow()]
expedicion_codigo = dw_orden.object.expedicion_codigo[dw_orden.getrow()]
cliente = dw_orden.object.cliente[dw_orden.getrow()]

if numpalet <> 0 then
	sql_numpalet = " AND venliped.numpalet = "+String(numpalet)+" "
end if

dw_paletizado.reset()
dw_paletizado.retrieve()

//BUSCAMOS TODOS LOS PALLETS DE LA ORDEN DE CARGA Y LOS INSERTAMOS EN EL REPORT PARA SU IMPRESIÓN
//sel =  "SELECT DISTINCT venliped.numpalet "+&
//		"FROM orden_carga_linea "+&
//		"INNER JOIN orden_carga ON orden_carga_linea.empresa = orden_carga.empresa AND orden_carga_linea.anyo = orden_carga.anyo AND orden_carga_linea.codigo = orden_carga.codigo "+&
//		"INNER JOIN venliped ON venliped.empresa = orden_carga_linea.empresa AND venliped.anyo = orden_carga_linea.venliped_anyo AND venliped.pedido = orden_carga_linea.venliped_pedido AND venliped.linea = orden_carga_linea.venliped_linea "+&
//		"WHERE orden_carga_linea.empresa = '"+codigo_empresa+"' "+&
//		"AND venliped.numpalet IS NOT NULL "+&
//		"AND orden_carga.expedicion_anyo = "+String(expedicion_anyo)+" "+&
//		"AND orden_carga.expedicion_codigo = '"+expedicion_codigo+"' "+&
//		"AND orden_carga.finalizada = 'S' "+sql_numpalet+&
//		"ORDER by venliped.numpalet ASC "

//POR ORDEN DE PREPARACIÓN
/*
sel =  "SELECT DISTINCT venliped.numpalet, venliped.observaciones_pallet, venped.envio, venliped.familia "+&
		"FROM orden_carga_linea "+&
		"INNER JOIN orden_carga ON orden_carga_linea.empresa = orden_carga.empresa AND orden_carga_linea.anyo = orden_carga.anyo AND orden_carga_linea.codigo = orden_carga.codigo "+&
		"INNER JOIN venliped ON venliped.empresa = orden_carga_linea.empresa AND venliped.anyo = orden_carga_linea.venliped_anyo AND venliped.pedido = orden_carga_linea.venliped_pedido AND venliped.linea = orden_carga_linea.venliped_linea "+&
		"INNER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido "+&
		"WHERE orden_carga_linea.empresa = '"+codigo_empresa+"' "+&
		"AND venliped.numpalet IS NOT NULL "+&
		"AND orden_carga.anyo = "+String(anyo_padre_codigo)+" "+&
		"AND orden_carga.codigo = '"+padre_codigo+"' "+&
		"AND orden_carga.finalizada = 'S' "+sql_numpalet+&
		"ORDER by venliped.numpalet ASC "
*/

sel =  "SELECT DISTINCT venliped.numpalet, venliped.observaciones_pallet, venped.envio, venliped.familia "+&
		"FROM orden_carga_linea "+&
		"INNER JOIN orden_carga ON orden_carga_linea.empresa = orden_carga.empresa AND orden_carga_linea.anyo = orden_carga.anyo AND orden_carga_linea.codigo = orden_carga.codigo "+&
		"INNER JOIN venliped ON venliped.empresa = orden_carga_linea.empresa AND venliped.anyo = orden_carga_linea.venliped_anyo AND venliped.pedido = orden_carga_linea.venliped_pedido AND venliped.linea = orden_carga_linea.venliped_linea "+&
		"INNER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido "+&
		"WHERE orden_carga_linea.empresa = '"+codigo_empresa+"' "+&
		"AND venliped.numpalet IS NOT NULL "+&
		"AND orden_carga.anyo = "+String(anyo_padre_codigo)+" "+&
		"AND orden_carga.codigo = '"+padre_codigo+"' "+&
		" "+sql_numpalet+&
		"ORDER by venliped.numpalet ASC "		
		
f_cargar_cursor_trans (SQLCA,  sel,  consulta)
numero = consulta.RowCount()
i = 1
do while (i <= numero) 	
	
	fila = dw_paletizado.insertrow(0)
	
	dw_paletizado.object.numpalet[fila] = consulta.object.venliped_numpalet[i]
	dw_paletizado.object.venped_envio[fila] = consulta.object.venped_envio[i]
	dw_paletizado.object.observaciones[fila] = consulta.object.venliped_observaciones_pallet[i]
	familia = consulta.object.venliped_familia[i]
	
	dw_paletizado.object.anyo[fila] = expedicion_anyo
	dw_paletizado.object.orden[fila] = expedicion_codigo
	
	dw_paletizado.object.empresa[fila] = codigo_empresa
	dw_paletizado.object.familia[fila] = familia
	dw_paletizado.object.venliped_familia[fila] = familia
	dw_paletizado.object.cliente[fila] = cliente
	dw_paletizado.object.razon[fila] = f_razon_genter(codigo_empresa, 'C', cliente)
	
	i++
loop

if dw_paletizado.rowcount() > 0 then
	fila = dw_paletizado.insertrow(0)
	
	dw_paletizado.deleterow(fila)
	
	f_imprimir_datawindow(dw_paletizado)
end if

Destroy consulta
end subroutine

public function integer f_post_itemchanged (long row, dwobject dwo, string data);long fila 
string cadena
dec cantidad_redondeada
integer posi, posi_aux

	
if dwo.name = "venliped_cantidad" then
	cadena = f_calculo_unidades_tipolin (codigo_empresa, dw_datos.object.venliped_articulo[row], dw_datos.object.venliped_tipo_pallet[row], dw_datos.object.venliped_caja[row], 0, 0, dec (data), dw_datos.object.venliped_tipolinea[row])

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
	
	dw_datos.object.venliped_cantidad[row] = cantidad_redondeada

end if


fila = dw_datos.GetRow()

if f_dividir_linea_venliped (codigo_empresa, dw_datos.object.venliped_anyo[row], dw_datos.object.venliped_pedido[row], dw_datos.object.venliped_linea[row], dec(data)) <> 0 then
	commit using sqlca;
else
	rollback using sqlca;
end if
pb_anyadir1.TriggerEvent ( clicked!)

dw_datos.setrow(fila - 1)
dw_datos.ScrollToRow(fila - 1)    

return 1
end function

public subroutine f_fin_orden_carga_old (boolean con_movimiento);str_ventana_alerta parametros
string botones[2]
Int alerta
Boolean falta_numpallet

String new_sql
rtn = 1
Long i, j

str_almacenmovimientos movimiento
String orden_carga, articulo, cod_formato, almacen_destino, zona_destino, almacen_origen, zona_origen, familia, tono, calidad, pallets, cajas
Long linea,ll_pallets
Int fila_destino, altura_destino, fila_origen, altura_origen, calibre
Dec cantidad
string cliente
string v_anyo, v_pedido, v_linea

if dw_orden.getrow() <= 0 then
	MessageBox("Error", "Debe seleccionar una orden de preparación antes de finalizarla")
	return
end if

if isnull(padre_codigo) or padre_codigo = "" then
	MessageBox("Error", "Debe guardar y añadir líneas antes de finalizar una orden de preparación")
	return
end if

if dw_lineas.rowcount() <= 0 then
	MessageBox("Error", "Debe  añadir líneas antes de finalizar una orden de preparación")
	return
end if

if isnull(dw_orden.object.almacen_destino[dw_orden.getrow()]) or trim(dw_orden.object.almacen_destino[dw_orden.getrow()]) = ""      &
			or isnull(dw_orden.object.zona_destino[dw_orden.getrow()]) or trim(dw_orden.object.zona_destino[dw_orden.getrow()]) = ""   & 
			or isnull(dw_orden.object.fila_destino[dw_orden.getrow()]) or dec(dw_orden.object.fila_destino[dw_orden.getrow()]) <= 0    &
			or isnull(dw_orden.object.altura_destino[dw_orden.getrow()]) or dec(dw_orden.object.altura_destino[dw_orden.getrow()]) <= 0 then
	MessageBox("Error", "Para finalizar una orden de preparación debe indicar el destino del material definitivo")
	return
end if

i = 1
falta_numpallet = false
do while i<= dw_lineas.rowcount() and not falta_numpallet
	if isnull(dw_lineas.object.venliped_numpalet[i]) or dec(dw_lineas.object.venliped_numpalet[i]) <= 0 then
		falta_numpallet = true
	end if
	i++
loop

//if falta_numpallet then
//	if MessageBox("Atención", "Falta introducir los números de los pallets preparados.  ¿Desea continuar? ", Exclamation!, YesNo!, 2 ) <> 1 then
//		return
//	end if
//end if

if falta_numpallet then
	parametros.titulo = "Importante"
	parametros.subtitulo = "Faltan Números de pallets"
	parametros.mensaje = "Falta introducir los números de los pallets preparados.  ¿Desea continuar?"
	parametros.tipo = 1
	botones[1] = "Sí"
	botones[2] = "No"
	parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	alerta = Int(Message.DoubleParm)
	if alerta = 2 then
		return
	end if
end if

rtn = 1 //Todo ok

if isnull(padre_codigo) or padre_codigo = "" or dw_orden.getrow() <= 0 then
	return 
end if

parametros.titulo = "Importante"
parametros.subtitulo = "Finalizar Orden de Carga"
parametros.mensaje = "No se admitirán cambios en la orden una vez finalizada. ¿Desea continuar?"
parametros.tipo = 2
botones[1] = "Sí"
botones[2] = "No"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
alerta = Int(Message.DoubleParm)
if alerta = 2 then
	return
end if

//Movimientos automáticos
long   ll_anyo_orden_carga,ll_linea_orden_carga,ll_venliped_numpallet,ll_donde_numpallet,ll_id_alm_bultos_origen,ll_existe_bulto_en_reservas 
dec    ld_cantidad_pendiente_bulto
string ls_orden_carga

if dw_orden.rowcount() > 0 and rtn = 1 then
	orden_carga = String(dw_orden.object.anyo[dw_orden.getrow()]) + " / "+ dw_orden.object.codigo[dw_orden.getrow()]
	ll_anyo_orden_carga = dw_orden.object.anyo[dw_orden.getrow()]
	ls_orden_carga      = dw_orden.object.codigo[dw_orden.getrow()]
	
	almacen_destino =  dw_orden.object.almacen_destino[dw_orden.getrow()]
	zona_destino =  dw_orden.object.zona_destino[dw_orden.getrow()]
	fila_destino =  dw_orden.object.fila_destino[dw_orden.getrow()]
	altura_destino =  dw_orden.object.altura_destino[dw_orden.getrow()]
	
	dw_lineas.setredraw(false)
	dw_lineas.setsort("orden_carga_linea_venliped_anyo A , orden_carga_linea_venliped_pedido A, orden_carga_linea_venliped_linea A")
	dw_lineas.sort()
	i = 1
	Do while i <= dw_lineas.rowcount() and rtn = 1
		
		v_anyo                = string(dw_lineas.object.orden_carga_linea_venliped_anyo [i]) 
		v_pedido              = string(dw_lineas.object.orden_carga_linea_venliped_pedido [i]) 
		v_linea               = string(dw_lineas.object.orden_carga_linea_venliped_linea [i]) 		
		
		select formato,
				 tipo_pallet,
				 caja,
				 familia,
				 cliente 
		into   :cod_formato,
				 :pallets,
				 :cajas,
				 :familia,
				 :cliente 
		from  venliped 
		where empresa = :codigo_empresa
		and   anyo    = :v_anyo
		and   pedido  = :v_pedido
		and   linea   = :v_linea 
		using trans_ts;
				
		// Una vez que hemos preparado la carga, marcaremos el pedido como fabricado
		update venliped 
		set    esta_fabricado = 'S',
				 situacion = 'P'
		where empresa = :codigo_empresa
		and   anyo    = :v_anyo
		and   pedido  = :v_pedido
		and   linea   = :v_linea 
		using trans_ts;
		
		if trans_ts.SQLCode = -1 then
			rtn = -1
		end if
		
		linea                 = dw_lineas.object.orden_carga_linea_linea[i]
		ll_linea_orden_carga  = dw_lineas.object.orden_carga_linea_linea[i]
		articulo              = dw_lineas.object.venliped_articulo[i]
		ll_venliped_numpallet = dw_lineas.object.venliped_numpalet[i]
		ll_pallets            = dw_lineas.object.venliped_pallets[i]
		
		if not isnull(articulo) and articulo <> "" then
			if isnull(cod_formato) or cod_formato = "" then
				MessageBox("Error", "Artículo sin formato "+articulo)
				rtn = -1
			end if
		end if
			
		//LOS ARTÍCULOS SIN ALTA, NO REQUIREN MOVIMIENTO, EL RESTO SI
		if rtn= 1 and (not isnull(articulo) and articulo <> "") then
			dw_orden_carga_linea_reservas.setfilter("linea = "+String(linea))
			dw_orden_carga_linea_reservas.filter()
			dw_orden_carga_linea_reservas.sort()
			
			j = 1
			Do while j <= dw_orden_carga_linea_reservas.rowcount() and rtn = 1 
				//Aqui cambiamos a la nueva gestion de movimientos
				str_movimiento_almacen lstr_movimiento_almacen
				
				tono    = dw_orden_carga_linea_reservas.object.tono[j]
				calibre = dw_orden_carga_linea_reservas.object.calibre[j]
				calidad = dw_orden_carga_linea_reservas.object.calidad[j]						
				
				lstr_movimiento_almacen.empresa            = codigo_empresa
				lstr_movimiento_almacen.articulo           = articulo
				lstr_movimiento_almacen.calidad            = calidad
				lstr_movimiento_almacen.tono               = tono
				lstr_movimiento_almacen.calibre            = calibre
				lstr_movimiento_almacen.tipo_pallet        = pallets
				lstr_movimiento_almacen.caja               = cajas
				lstr_movimiento_almacen.cantidad           = (dw_orden_carga_linea_reservas.object.cantidad[j] * -1)
				lstr_movimiento_almacen.orden_carga_anyo   = 0
				lstr_movimiento_almacen.orden_carga_codigo = ""
				lstr_movimiento_almacen.orden_carga_linea  = 0
				lstr_movimiento_almacen.tipo_movimiento    = "204" //Salida Preparación
				lstr_movimiento_almacen.observaciones      = ""
				lstr_movimiento_almacen.almacen            = dw_orden_carga_linea_reservas.object.almacen[j]
				lstr_movimiento_almacen.zona               = dw_orden_carga_linea_reservas.object.zona[j]
				lstr_movimiento_almacen.fila               = dw_orden_carga_linea_reservas.object.fila[j]
				lstr_movimiento_almacen.altura             = dw_orden_carga_linea_reservas.object.altura[j]
				lstr_movimiento_almacen.tercero            = ""
				lstr_movimiento_almacen.documento          = ""
				lstr_movimiento_almacen.fecha              = datetime(today(),now())
				lstr_movimiento_almacen.id_ubicacion       = 0
				lstr_movimiento_almacen.id_alm_bultos		 = dw_orden_carga_linea_reservas.object.id_alm_bultos[j]
								
				if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
					rtn = 0
				end if
				
				//Si la salida ha sido de todo el bulto la entrada será tambien de ese mismo bulto a no ser que estemos agrupando sobre otro bulto
				//Esto lo controlamos mediante el numero de pallet 
				//04-06-2018 a no ser que la linea conste de varios pallets
				
				lstr_movimiento_almacen.id_alm_bultos = 0	
				
				//Si estoy traspasando un bulto entero no busco para poder agrupar
				
				SELECT isnull(max(orden_carga_linea_reservas.id_alm_bultos),0)
				INTO   :lstr_movimiento_almacen.id_alm_bultos 
				FROM  orden_carga_linea_reservas,
						orden_carga_linea,
						venliped 
				WHERE orden_carga_linea_reservas.empresa = orden_carga_linea.empresa 
				AND   orden_carga_linea_reservas.anyo    = orden_carga_linea.anyo 
				AND   orden_carga_linea_reservas.codigo  = orden_carga_linea.codigo 	
				AND   orden_carga_linea_reservas.linea   = orden_carga_linea.linea 	
				AND   orden_carga_linea.empresa          = venliped.empresa
				AND   orden_carga_linea.venliped_anyo    = venliped.anyo
				AND   orden_carga_linea.venliped_pedido  = venliped.pedido
				AND   orden_carga_linea.venliped_linea   = venliped.linea	
				AND   orden_carga_linea_reservas.empresa = :codigo_empresa 
				AND   orden_carga_linea_reservas.anyo    = :ll_anyo_orden_carga 
				AND   orden_carga_linea_reservas.codigo  = :ls_orden_carga 
				AND   venliped.numpalet                  = :ll_venliped_numpallet;
				
				//Esto es mas complicado de lo que parece
				//De momento no agrupo
				lstr_movimiento_almacen.id_alm_bultos = 0
				
				if lstr_movimiento_almacen.id_alm_bultos <> 0 then
					//He encontrado un bulto sobre el que agrupar
					lstr_movimiento_almacen.tipo_pallet = ""
					
					select isnull(alm_bultos.tipo_pallet,'')
					into   :lstr_movimiento_almacen.tipo_pallet
					from   alm_bultos
					where  alm_bultos.id = :lstr_movimiento_almacen.id_alm_bultos;
					
					if trim(lstr_movimiento_almacen.tipo_pallet) = "" then
						lstr_movimiento_almacen.tipo_pallet   = pallets
					end if
				else
					lstr_movimiento_almacen.id_alm_bultos = dw_orden_carga_linea_reservas.object.id_alm_bultos[j]
					lstr_movimiento_almacen.tipo_pallet   = pallets
										
					ld_cantidad_pendiente_bulto = 0
					
					SELECT isnull(sum(alm_bultos_lineas.cantidad),0)
					INTO   :ld_cantidad_pendiente_bulto
					FROM   alm_bultos,   
							 alm_bultos_lineas  
					WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
					AND ( ( alm_bultos.id = :lstr_movimiento_almacen.id_alm_bultos ) ) ;
					
					if ld_cantidad_pendiente_bulto = 0 then
						dw_lineas.object.id_alm_bultos[i] = lstr_movimiento_almacen.id_alm_bultos
					else
						lstr_movimiento_almacen.id_alm_bultos = 0
					end if
										
				end if				
								
				//Fin de lo nuevo
				
				//Debo controlar si traspaso el bulto o pongo las cajas en destino sobre otro que ya existe
				//Lo hacemos mediante venliped_numpallet
				
				lstr_movimiento_almacen.empresa            = codigo_empresa
				lstr_movimiento_almacen.articulo           = articulo
				lstr_movimiento_almacen.calidad            = calidad
				lstr_movimiento_almacen.tono               = tono
				lstr_movimiento_almacen.calibre            = calibre
				//lstr_movimiento_almacen.tipo_pallet        = pallets
				lstr_movimiento_almacen.caja               = cajas
				lstr_movimiento_almacen.cantidad           = dw_orden_carga_linea_reservas.object.cantidad[j]
				lstr_movimiento_almacen.orden_carga_anyo   = ll_anyo_orden_carga
				lstr_movimiento_almacen.orden_carga_codigo = ls_orden_carga
				lstr_movimiento_almacen.orden_carga_linea  = ll_linea_orden_carga
				lstr_movimiento_almacen.tipo_movimiento    = "205" //Entrada Preparación
				lstr_movimiento_almacen.observaciones      = ""
				lstr_movimiento_almacen.almacen            = almacen_destino
				lstr_movimiento_almacen.zona               = zona_destino
				lstr_movimiento_almacen.fila               = fila_destino
				lstr_movimiento_almacen.altura             = altura_destino
				lstr_movimiento_almacen.tercero            = ""
				lstr_movimiento_almacen.documento          = ""
				lstr_movimiento_almacen.fecha              = datetime(today(),now())
				lstr_movimiento_almacen.id_ubicacion       = 0
				lstr_movimiento_almacen.id_alm_bultos		 = lstr_movimiento_almacen.id_alm_bultos
				
				//Introduce pallet a pallet
				if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
					rtn = 0
				end if								
				
				//Esto no lo hacemos de momento
				/*
				if dw_lineas.object.id_alm_bultos[i] = 0 then
					//Si no tenia id de pallet asignado la funcion f_movimiento_almacen asignara un id que debemos propagar al resto de articulos que van en ese numero de pallet
					ll_donde_numpallet = i
					do
						ll_donde_numpallet = dw_lineas.find("venliped_numpalet = "+string(ll_venliped_numpallet,"##0")+" and id_alm_bultos = 0",ll_donde_numpallet,dw_lineas.rowcount())
						
						if ll_donde_numpallet > 0 then
							dw_lineas.object.id_alm_bultos[ll_donde_numpallet] = lstr_movimiento_almacen.id_alm_bultos
							ll_donde_numpallet ++	
						end if
						
					loop while ll_donde_numpallet > 0 and ll_donde_numpallet <= dw_lineas.rowcount()
					
				end if
				*/
				//Esto no lo hacemos de momento
				
				if dw_orden_carga_linea_reservas.object.id_alm_bultos[j] <> lstr_movimiento_almacen.id_alm_bultos then
					//Vamos a cambiar la reserva al nuevo bulto
					ll_id_alm_bultos_origen = dw_orden_carga_linea_reservas.object.id_alm_bultos[j]
					
					ll_existe_bulto_en_reservas = 0
					
					SELECT isnull(count(*),0)
					INTO   :ll_existe_bulto_en_reservas
					FROM   orden_carga_linea_reservas
					WHERE  orden_carga_linea_reservas.empresa       = :lstr_movimiento_almacen.empresa
					AND    orden_carga_linea_reservas.anyo          = :lstr_movimiento_almacen.orden_carga_anyo
					AND    orden_carga_linea_reservas.codigo        = :lstr_movimiento_almacen.orden_carga_codigo
					AND    orden_carga_linea_reservas.linea         = :lstr_movimiento_almacen.orden_carga_linea
					AND    orden_carga_linea_reservas.id_alm_bultos = :lstr_movimiento_almacen.id_alm_bultos;
					
					if ll_existe_bulto_en_reservas = 0 then
						//Cambiamos la reserva de bulto
						UPDATE orden_carga_linea_reservas
						SET    orden_carga_linea_reservas.id_alm_bultos = :lstr_movimiento_almacen.id_alm_bultos
						WHERE  orden_carga_linea_reservas.empresa       = :lstr_movimiento_almacen.empresa
						AND    orden_carga_linea_reservas.anyo          = :lstr_movimiento_almacen.orden_carga_anyo
						AND    orden_carga_linea_reservas.codigo        = :lstr_movimiento_almacen.orden_carga_codigo
						AND    orden_carga_linea_reservas.linea         = :lstr_movimiento_almacen.orden_carga_linea
						AND    orden_carga_linea_reservas.id_alm_bultos = :ll_id_alm_bultos_origen;	
						
						if sqlca.sqlcode <> 0 then
							rtn = 0
						end if
					else
						//Cambiamos la cantidad reservada en el bulto
						UPDATE orden_carga_linea_reservas
						SET    orden_carga_linea_reservas.cantidad      = orden_carga_linea_reservas.cantidad + :lstr_movimiento_almacen.cantidad 
						WHERE  orden_carga_linea_reservas.empresa       = :lstr_movimiento_almacen.empresa
						AND    orden_carga_linea_reservas.anyo          = :lstr_movimiento_almacen.orden_carga_anyo
						AND    orden_carga_linea_reservas.codigo        = :lstr_movimiento_almacen.orden_carga_codigo
						AND    orden_carga_linea_reservas.linea         = :lstr_movimiento_almacen.orden_carga_linea
						AND    orden_carga_linea_reservas.id_alm_bultos = :lstr_movimiento_almacen.id_alm_bultos;		
						
						if sqlca.sqlcode <> 0 then
							rtn = 0
						end if						
						
						//Borramos la reserva original
						DELETE orden_carga_linea_reservas
						WHERE  orden_carga_linea_reservas.empresa       = :lstr_movimiento_almacen.empresa
						AND    orden_carga_linea_reservas.anyo          = :lstr_movimiento_almacen.orden_carga_anyo
						AND    orden_carga_linea_reservas.codigo        = :lstr_movimiento_almacen.orden_carga_codigo
						AND    orden_carga_linea_reservas.linea         = :lstr_movimiento_almacen.orden_carga_linea
						AND    orden_carga_linea_reservas.id_alm_bultos = :ll_id_alm_bultos_origen;											
						
						if sqlca.sqlcode <> 0 then
							rtn = 0
						end if						
					end if
					
				end if				
				
				j++
				/*
				cantidad = dw_orden_carga_linea_reservas.object.cantidad[j]
				
				tono = dw_orden_carga_linea_reservas.object.tono[j]
				calibre = dw_orden_carga_linea_reservas.object.calibre[j]
				calidad = dw_orden_carga_linea_reservas.object.calidad[j]		
				
				almacen_origen = dw_orden_carga_linea_reservas.object.almacen[j]
				zona_origen = dw_orden_carga_linea_reservas.object.zona[j]
				fila_origen = dw_orden_carga_linea_reservas.object.fila[j]
				altura_origen = dw_orden_carga_linea_reservas.object.altura[j]
				
				//Salida de origen
				movimiento.empresa = codigo_empresa
				movimiento.fecha_intr = Datetime(Today(), now())
				movimiento.fecha_mov = Today()
				movimiento.origen = ""
				movimiento.almacen = almacen_origen
				movimiento.zona = zona_origen
				movimiento.fila = fila_origen
				movimiento.altura = altura_origen
				movimiento.articulo = articulo
				movimiento.familia = familia
				movimiento.formato = cod_formato
				movimiento.calidad = calidad
				movimiento.tono = tono
				movimiento.calibre = calibre
				movimiento.tipo_pallet = pallets
				movimiento.caja = cajas
				movimiento.cantidade = 0
				movimiento.cantidads = cantidad
				movimiento.tipomov = "204" //Salida Preparación
				movimiento.tipo_unidad = "0"
				movimiento.usuario = nombre_usuario
				movimiento.observaciones = "ORDEN DE PREPARACIÓN - "+ orden_carga
				
				if ftc_movimiento_almacen(movimiento, trans_ts) <> 0 then
					rtn = -1 
				end if				
				
				//Entrada en Muelle
				if rtn = 1 then
					movimiento.empresa = codigo_empresa
					movimiento.fecha_intr = Datetime(Today(), now())
					movimiento.fecha_mov = Today()
					movimiento.origen = ""
					movimiento.almacen = almacen_destino
					movimiento.zona = zona_destino
					movimiento.fila = fila_destino
					movimiento.altura = altura_destino
					movimiento.articulo = articulo
					movimiento.familia = familia
					movimiento.formato = cod_formato
					movimiento.calidad = calidad
					movimiento.tono = tono
					movimiento.calibre = calibre
					movimiento.tipo_pallet = pallets
					movimiento.caja = cajas
					movimiento.cantidade = cantidad
					movimiento.cantidads = 0
					movimiento.tipomov = "205" //Entrada Preparación
					movimiento.tipo_unidad = "0"
					movimiento.usuario = nombre_usuario
					movimiento.observaciones = "ORDEN DE PREPARACIÓN - "+ orden_carga
					if ftc_movimiento_almacen(movimiento, trans_ts) <> 0 then
						rtn = -1 
					end if
				end if
				j++
				*/
			loop
		end if
		i++	
	loop
		
	dw_lineas.setsort("orden_carga_linea_linea A")
	dw_lineas.sort()
	dw_lineas.setredraw(true)
	
end if

if rtn = 1 then
	dw_orden.settransobject(trans_ts)
	dw_orden.accepttext()
	dw_orden.object.finalizada[dw_orden.getrow()] = 'S'
	dw_orden.object.fecha_fin[dw_orden.getrow()] = Datetime(Today(), Now())
	rtn = dw_orden.update()
	
end if

if rtn = 1 then
	COMMIT;
	
	COMMIT USING trans_ts;
	
	//Actualizamos los datos en la dw de lineas (dw_datos)
	long   ll_orden_anyo,ll_donde,anyo_pedido,codigo_pedido,linea_pedido,ll_expedicion_anyo
	string ls_orden_codigo,ls_orden_finalizada,ls_expedicion_codigo,ls_busqueda,ls_null
	datetime ldt_orden_fecha
	
	ll_orden_anyo = dw_orden.object.anyo[dw_orden.getrow()]
	ls_orden_codigo = dw_orden.object.codigo[dw_orden.getrow()]
	ldt_orden_fecha = dw_orden.object.fecha[dw_orden.getrow()]
	ls_orden_finalizada = dw_orden.object.finalizada[dw_orden.getrow()]
	ll_expedicion_anyo = dw_orden.object.expedicion_anyo[dw_orden.getrow()]
	ls_expedicion_codigo = dw_orden.object.expedicion_codigo[dw_orden.getrow()]
		
	setnull(ls_null)	
		
	for i = 1 To dw_lineas.rowcount()
		anyo_pedido   = dw_lineas.object.orden_carga_linea_venliped_anyo[i]
		codigo_pedido = dw_lineas.object.orden_carga_linea_venliped_pedido[i]
		linea_pedido  = dw_lineas.object.orden_carga_linea_venliped_linea[i]
		
		ls_busqueda = "venliped_anyo = "+string(anyo_pedido,"###0")+" and "+&
						  "venliped_pedido = "+string(codigo_pedido,"#######0")+" and "+&
						  "venliped_linea = "+string(linea_pedido,"#######0")
		
		ll_donde = dw_datos.find(ls_busqueda,1,dw_datos.rowcount())
		
		if ll_donde > 0 then
			dw_datos.object.orden_carga[ll_donde] = string(ll_orden_anyo,"####")+"/"+ls_orden_codigo
			if ls_orden_finalizada = "S" then
				dw_datos.object.orden_carga[ll_donde] = string(ll_orden_anyo,"####")+"/"+ls_orden_codigo
			else
				dw_datos.object.orden_carga[ll_donde] = ls_null
			end if
			dw_datos.object.fecha_orden_carga[ll_donde] = ldt_orden_fecha
			
			dw_datos.object.codigo_expedicion[ll_donde] = string(ll_expedicion_anyo,"####")+"-"+ls_expedicion_codigo
		end if
	next
	//	
	
else
	ROLLBACK;
	
	ROLLBACK USING trans_ts;
	MessageBox("Error de finalización", "No se ha podido finalizar la orden de preparación. Intentelo de nuevo y si el error se repite, póngase en contacto con el administrador.")
end if
dw_orden.settransobject(sqlca)	

//Las reservas las hemos updateado a mano. Hacemos de nuevo el retrieve para que no falle la funcion f_guardar
dw_orden_carga_linea_reservas.reset()
dw_orden_carga_linea_reservas.retrieve(codigo_empresa,ll_anyo_orden_carga,ls_orden_carga)

f_guardar(true)
end subroutine

public subroutine f_calcular_disponible (string arg_filtro_dw);string ls_find,ls_nuevo_filtro,ls_articulo
long ll_indice,ll_total,ll_donde
dec  ld_disponible
pointer oldpointer
time lt_inicio,lt_final

lt_inicio = now()

oldpointer = SetPointer(HourGlass!)

dw_datos.setredraw(false)

if trim(arg_filtro_dw) = "" then
	ls_nuevo_filtro = "situacion = 'P'"
else
	ls_nuevo_filtro = arg_filtro_dw+" and situacion = 'P'"
end if

dw_datos.setfilter(ls_nuevo_filtro)
dw_datos.filter()

ll_total = dw_datos.rowcount()

for ll_indice = 1 to ll_total
	dw_datos.object.estado_linea[ll_indice] = 50 //Preparado
next

if trim(arg_filtro_dw) = "" then
	ls_nuevo_filtro = "situacion = 'C'"
else
	ls_nuevo_filtro = arg_filtro_dw+" and situacion = 'C'"
end if

dw_datos.setfilter(ls_nuevo_filtro)
dw_datos.filter()

ll_total = dw_datos.rowcount()

for ll_indice = 1 to ll_total
	dw_datos.object.estado_linea[ll_indice] = 40 //Reservado
next

if trim(arg_filtro_dw) = "" then
	ls_nuevo_filtro = "situacion = 'F'"
else
	ls_nuevo_filtro = arg_filtro_dw+" and situacion = 'F'"
end if

dw_datos.setfilter(ls_nuevo_filtro)
dw_datos.filter()

ll_total = dw_datos.rowcount()

for ll_indice = 1 to ll_total
	
	if dw_datos.object.disponible[ll_indice] = -1 then
//		dw_datos.object.disponible[ll_indice] = f_disponible_art_cal_to_ca_tp_c( dw_datos.object.venliped_empresa[ll_indice] ,&
//																							dw_datos.object.venliped_articulo[ll_indice] ,&
//																							dw_datos.object.venliped_calidad[ll_indice] ,&
//																							dw_datos.object.venliped_tonochar[ll_indice] ,&
//																							dw_datos.object.venliped_calibre[ll_indice] ,&
//																							dw_datos.object.venliped_tipo_pallet[ll_indice] ,&
//																							dw_datos.object.venliped_caja[ll_indice] )

		if dw_datos.object.venliped_articulo[ll_indice] = '121192' then
			ls_articulo = '121192'
		end if

		dw_datos.object.disponible_pzs[ll_indice] = f_disponible_art_cal_tp_c_pzs( dw_datos.object.venliped_empresa[ll_indice] ,&
																							dw_datos.object.venliped_articulo[ll_indice] ,&
																							dw_datos.object.venliped_calidad[ll_indice] ,&
																							dw_datos.object.venliped_tipo_pallet[ll_indice] ,&
																							dw_datos.object.venliped_caja[ll_indice] )
																							
		dw_datos.object.disponible[ll_indice] = f_disponible_art_cal_tp_c( dw_datos.object.venliped_empresa[ll_indice] ,&
																							dw_datos.object.venliped_articulo[ll_indice] ,&
																							dw_datos.object.venliped_calidad[ll_indice] ,&
																							dw_datos.object.venliped_tipo_pallet[ll_indice] ,&
																							dw_datos.object.venliped_caja[ll_indice] )
																							
		if dw_datos.object.venliped_tipo_pallet[ll_indice] <> '00000' then
			//Vamos a añadir el disponible en ubicaciones con el pallet '00000' (Sin pallet, ubicaciones con bulto asignado)
			dw_datos.object.disponible_pzs[ll_indice] = dw_datos.object.disponible_pzs[ll_indice] +&
																		f_disponible_art_cal_tp_c_pzs( dw_datos.object.venliped_empresa[ll_indice] ,&
																								dw_datos.object.venliped_articulo[ll_indice] ,&
																								dw_datos.object.venliped_calidad[ll_indice] ,&
																								'00000' ,&																								
																								dw_datos.object.venliped_caja[ll_indice] )			
																								
			dw_datos.object.disponible[ll_indice]     = dw_datos.object.disponible[ll_indice] +&
																		f_disponible_art_cal_tp_c( dw_datos.object.venliped_empresa[ll_indice] ,&
																								dw_datos.object.venliped_articulo[ll_indice] ,&
																								dw_datos.object.venliped_calidad[ll_indice] ,&
																								'00000' ,&
																								dw_datos.object.venliped_caja[ll_indice] )																								
		end if																							

		if ( dw_datos.object.gestionar_en_piezas[ll_indice] = 'N' and dw_datos.object.disponible[ll_indice] >= dw_datos.object.venliped_cantidad[ll_indice] ) or ( dw_datos.object.gestionar_en_piezas[ll_indice] = 'S' and dw_datos.object.disponible_pzs[ll_indice] >= dw_datos.object.cantidad_pzs[ll_indice] ) then
			dw_datos.object.estado_linea[ll_indice] = 30 //Pdte Reservar
		else
			if dw_datos.object.planificado[ll_indice] > 0 and isnull(dw_datos.object.fecha_fin[ll_indice]) then
				dw_datos.object.estado_linea[ll_indice] = 15 //Planificado sin Fecha
			else
				if dw_datos.object.planificado[ll_indice] > 0 then
					dw_datos.object.estado_linea[ll_indice] = 20 //Planificado
				else
					dw_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
				end if
			end if
			/*
			if isnull(dw_datos.object.fecha_fin[ll_indice]) then
				dw_datos.object.estado_linea[ll_indice] = 10 //Rotura Stock
			else
				dw_datos.object.estado_linea[ll_indice] = 20 //Planificado
			end if
			*/
			
		end if
							
		ls_find = "venliped_articulo = '"+dw_datos.object.venliped_articulo[ll_indice]+"' and "+&
					 "venliped_calidad = '"+dw_datos.object.venliped_calidad[ll_indice]+"' and "+&
					 "venliped_tipo_pallet = '"+dw_datos.object.venliped_tipo_pallet[ll_indice]+"' and "+&
					 "venliped_caja = '"+dw_datos.object.venliped_caja[ll_indice]+"' "	
					 
//		ls_find = "venliped_articulo = '"+dw_datos.object.venliped_articulo[ll_indice]+"' and "+&
//					 "venliped_calidad = '"+dw_datos.object.venliped_calidad[ll_indice]+"' and "+&
//					 "venliped_tonochar = '"+dw_datos.object.venliped_tonochar[ll_indice]+"' and "+&
//					 "venliped_calibre = "+string(dw_datos.object.venliped_calibre[ll_indice],"0")+" and "+&
//					 "venliped_tipo_pallet = '"+dw_datos.object.venliped_tipo_pallet[ll_indice]+"' and "+&
//					 "venliped_caja = '"+dw_datos.object.venliped_caja[ll_indice]+"' "
					 
		ll_donde = ll_indice																					
		do
			ll_donde ++
			ll_donde = dw_datos.find(ls_find,ll_donde,ll_total)
			if ll_donde > 0 then
				dw_datos.object.disponible[ll_donde] = dw_datos.object.disponible[ll_indice]
				dw_datos.object.disponible_pzs[ll_donde] = dw_datos.object.disponible_pzs[ll_indice]
				
				if ( dw_datos.object.gestionar_en_piezas[ll_donde] = 'N' and dw_datos.object.disponible[ll_donde] >= dw_datos.object.venliped_cantidad[ll_donde] ) or ( dw_datos.object.gestionar_en_piezas[ll_donde] = 'S' and dw_datos.object.disponible_pzs[ll_donde] >= dw_datos.object.cantidad_pzs[ll_donde] ) then
					dw_datos.object.estado_linea[ll_donde] = 30 //Pdte Reservar
				else
					if dw_datos.object.planificado[ll_donde] > 0 and isnull(dw_datos.object.fecha_fin[ll_donde]) then
						dw_datos.object.estado_linea[ll_donde] = 15 //Planificado sin Fecha
					else
						if dw_datos.object.planificado[ll_donde] > 0 then
							dw_datos.object.estado_linea[ll_donde] = 20 //Planificado
						else
							dw_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
						end if
					end if

					/*
					if isnull(dw_datos.object.fecha_fin[ll_donde]) then
						dw_datos.object.estado_linea[ll_donde] = 10 //Rotura Stock
					else
						dw_datos.object.estado_linea[ll_donde] = 20 //Planificado
					end if			
					*/
				end if				
			end if
		loop while ll_donde > 0 and ll_donde < ll_total
	end if
next

dw_datos.setfilter(arg_filtro_dw)
dw_datos.filter()
dw_datos.setredraw(true)

SetPointer(oldpointer)

lt_final = now()
//messagebox("",string(lt_inicio)+" - "+string(lt_final))
end subroutine

public subroutine f_distintos_pallets_articulo_calidad_caj ();datastore lds_temp
string ls_err
integer i

// change the datastore definition according to the array data type
long ll_array[] = { 2, 3, 6, 5 }
string ls_dsdef = 'release 6; datawindow() table(column=(type=long name=a dbname="a") )'

lds_temp = CREATE datastore
lds_temp.Create(ls_dsdef, ls_err)

// put the array in the datastore
lds_temp.object.a.current = ll_array
lds_temp.SetSort("a ASC")
lds_temp.Sort()
// get back the array
ll_array = lds_temp.object.a.current

FOR i = 1 to Upperbound(ll_array)
  MessageBox("", string(ll_array[i]))
NEXT

DESTROY lds_temp
end subroutine

on wtc_consulta_pedidos_disponibles_preparacion.create
int iCurrent
call super::create
this.dw_imprimir=create dw_imprimir
this.cbx_resumen=create cbx_resumen
this.dw_fecha=create dw_fecha
this.st_1=create st_1
this.st_2=create st_2
this.gb_2=create gb_2
this.pb_2=create pb_2
this.dw_observaciones_pedidos=create dw_observaciones_pedidos
this.cbx_resumen_pesos=create cbx_resumen_pesos
this.st_3=create st_3
this.pb_3=create pb_3
this.dw_prepacking=create dw_prepacking
this.pb_mas_exp=create pb_mas_exp
this.pb_menos_exp=create pb_menos_exp
this.st_4=create st_4
this.pb_4=create pb_4
this.dw_oc=create dw_oc
this.dw_paletizado=create dw_paletizado
this.st_5=create st_5
this.pb_5=create pb_5
this.dw_proforma=create dw_proforma
this.dw_traspaso_pico=create dw_traspaso_pico
this.dw_observaciones_pallet=create dw_observaciones_pallet
this.cb_1=create cb_1
this.cbx_imprimir_observaciones=create cbx_imprimir_observaciones
this.dw_orden=create dw_orden
this.dw_expedicion=create dw_expedicion
this.dwtc_reparto_fabricaciones=create dwtc_reparto_fabricaciones
this.dw_lineas=create dw_lineas
this.dw_orden_carga_linea_reservas=create dw_orden_carga_linea_reservas
this.dw_stock=create dw_stock
this.cb_faltas_promocion=create cb_faltas_promocion
this.dw_faltas_almacen_promocion=create dw_faltas_almacen_promocion
this.dw_mover=create dw_mover
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imprimir
this.Control[iCurrent+2]=this.cbx_resumen
this.Control[iCurrent+3]=this.dw_fecha
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.pb_2
this.Control[iCurrent+8]=this.dw_observaciones_pedidos
this.Control[iCurrent+9]=this.cbx_resumen_pesos
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.pb_3
this.Control[iCurrent+12]=this.dw_prepacking
this.Control[iCurrent+13]=this.pb_mas_exp
this.Control[iCurrent+14]=this.pb_menos_exp
this.Control[iCurrent+15]=this.st_4
this.Control[iCurrent+16]=this.pb_4
this.Control[iCurrent+17]=this.dw_oc
this.Control[iCurrent+18]=this.dw_paletizado
this.Control[iCurrent+19]=this.st_5
this.Control[iCurrent+20]=this.pb_5
this.Control[iCurrent+21]=this.dw_proforma
this.Control[iCurrent+22]=this.dw_traspaso_pico
this.Control[iCurrent+23]=this.dw_observaciones_pallet
this.Control[iCurrent+24]=this.cb_1
this.Control[iCurrent+25]=this.cbx_imprimir_observaciones
this.Control[iCurrent+26]=this.dw_orden
this.Control[iCurrent+27]=this.dw_expedicion
this.Control[iCurrent+28]=this.dwtc_reparto_fabricaciones
this.Control[iCurrent+29]=this.dw_lineas
this.Control[iCurrent+30]=this.dw_orden_carga_linea_reservas
this.Control[iCurrent+31]=this.dw_stock
this.Control[iCurrent+32]=this.cb_faltas_promocion
this.Control[iCurrent+33]=this.dw_faltas_almacen_promocion
this.Control[iCurrent+34]=this.dw_mover
end on

on wtc_consulta_pedidos_disponibles_preparacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_imprimir)
destroy(this.cbx_resumen)
destroy(this.dw_fecha)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_2)
destroy(this.pb_2)
destroy(this.dw_observaciones_pedidos)
destroy(this.cbx_resumen_pesos)
destroy(this.st_3)
destroy(this.pb_3)
destroy(this.dw_prepacking)
destroy(this.pb_mas_exp)
destroy(this.pb_menos_exp)
destroy(this.st_4)
destroy(this.pb_4)
destroy(this.dw_oc)
destroy(this.dw_paletizado)
destroy(this.st_5)
destroy(this.pb_5)
destroy(this.dw_proforma)
destroy(this.dw_traspaso_pico)
destroy(this.dw_observaciones_pallet)
destroy(this.cb_1)
destroy(this.cbx_imprimir_observaciones)
destroy(this.dw_orden)
destroy(this.dw_expedicion)
destroy(this.dwtc_reparto_fabricaciones)
destroy(this.dw_lineas)
destroy(this.dw_orden_carga_linea_reservas)
destroy(this.dw_stock)
destroy(this.cb_faltas_promocion)
destroy(this.dw_faltas_almacen_promocion)
destroy(this.dw_mover)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_orden.SetTransObject(SQLCA)
dw_lineas.SetTransObject(SQLCA)
dw_stock.SetTransObject(SQLCA)
dw_orden_carga_linea_reservas.SetTransObject(SQLCA)
dw_fecha.SetTransObject(SQLCA)
dw_prepacking.SetTransObject(SQLCA)
dw_expedicion.SetTransObject(SQLCA)
dw_oc.SetTransObject(SQLCA)
dw_paletizado.SetTransObject(SQLCA)
dw_proforma.SetTransObject(SQLCA)
dwtc_reparto_fabricaciones.SetTransObject(SQLCA)

sql_inicial = "SELECT formatos.largo, formatos.ancho, venliped.empresa, venliped.anyo, venliped.envio, venliped.pedido, venliped.linea, venliped.fpedido, venliped.articulo, articulos.descripcion, articulos.formato, formatos.abreviado, venliped.calidad, calidades.abreviado, "+&
				"venliped.tonochar, venliped.calibre, articulos.familia, familias.descripcion, venliped.caja, almcajas.descripcion_abr, almcajas.descripcion, venliped.total_cajas, venliped.tipo_pallet, pallets.resumido, "+&
				"pallets.descripcion, venliped.pallets, venliped.cantidad, venliped.fentrega, genter.pais, "+&
				"CONVERT(decimal(16,0),ISNULL((SELECT SUM(m1.cantidade - m1.cantidads) FROM almacenmovimientos m1 WHERE m1.empresa = venliped.empresa AND m1.articulo = venliped.articulo AND m1.calidad = venliped.calidad  AND not  ( almacen = '1' and zona = 'P' )),0)) as stock, "+&
				"CONVERT(decimal(16,0),ISNULL((SELECT SUM(ISNULL(p1.cantidad,0)) FROM planificacion p1 WHERE p1.empresa = venliped.empresa AND venliped.calidad = '1' AND p1.cod_articulo = venliped.articulo ),0)) as planificado, "+&
				"0 as consumido,		"+&
				"0 as reservado, "+&
				"-1 as disponible, "+&
				"CONVERT(decimal(16,0),ISNULL((SELECT SUM( case when a1.unidad = '1' then ISNULL(p1.cantidad * ((f1.largo * f1.ancho) / 10000),0) else ISNULL(p1.cantidad,0) end ) "+&
				"											FROM planificacion p1 "+&
				"                                				INNER JOIN articulos a1 ON p1.empresa = a1.empresa AND p1.cod_articulo = a1.codigo "+&
				"                                				INNER JOIN formatos f1 ON a1.empresa = f1.empresa AND a1.formato = f1.codigo "+&
				"											WHERE  p1.empresa = venliped.empresa "+&
				"											AND venliped.calidad = '1' "+&
				"											AND p1.cod_articulo = venliped.articulo ),0)) as disponible_mas_planificado, "+&
				"venliped.descripcion, venliped.peso, venliped.peso_neto, venliped.tipolinea, ventipolin.descripcion, venliped.cliente, genter.codigo, genter.razon, 1 as visible, venped.fecha_carga_prevista, venliped.numpalet,  venped.observaciones, articulos.cliente, unidades.abreviado, articulos.decimales_unidad, venliped.tipo_unidad, almartcajas.piezascaja, almartcajas.metroscaja, "+&
				"(SELECT MIN(p2.f_fin_estimada) FROM planificacion p2 WHERE p2.empresa = venliped.empresa AND p2.cod_articulo = venliped.articulo) as fecha_fin, "+&
				"(SELECT MAX(p2.f_fin_estimada) FROM planificacion p2 WHERE p2.empresa = venliped.empresa AND p2.cod_articulo = venliped.articulo ) as fecha_fin_max, "+&
				"(SELECT CONVERT(char(4),c.anyo) + '/' + c.codigo FROM orden_carga_linea c INNER JOIN orden_carga oc1 ON c.empresa = oc1.empresa AND c.anyo = oc1.anyo AND c.codigo = oc1.codigo WHERE venliped.empresa = c.empresa AND venliped.anyo = c.venliped_anyo AND venliped.pedido = c.venliped_pedido AND venliped.linea = c.venliped_linea) as orden_carga, "+&
				"(SELECT CONVERT(char(4),f.anyo) + '/' + f.codigo FROM orden_carga_linea f INNER JOIN orden_carga oc ON f.empresa = oc.empresa AND f.anyo = oc.anyo AND f.codigo = oc.codigo WHERE venliped.empresa = f.empresa AND venliped.anyo = f.venliped_anyo AND venliped.pedido = f.venliped_pedido AND venliped.linea = f.venliped_linea AND oc.finalizada = 'S') as orden_carga_finalizada, "+&
				"(SELECT oc2.fecha FROM orden_carga_linea cf INNER JOIN orden_carga oc2 ON cf.empresa = oc2.empresa AND cf.anyo = oc2.anyo AND cf.codigo = oc2.codigo WHERE venliped.empresa = cf.empresa AND venliped.anyo = cf.venliped_anyo 	AND venliped.pedido = cf.venliped_pedido AND venliped.linea = cf.venliped_linea) as fecha_orden_carga, "+&
				"(ISNULL((SELECT oclp.pallets_extra FROM orden_carga_linea oclp WHERE venliped.empresa = oclp.empresa AND venliped.anyo = oclp.venliped_anyo AND venliped.pedido = oclp.venliped_pedido AND venliped.linea = oclp.venliped_linea), 0) * ISNULL(pallets.peso, 0) + ISNULL(venliped.peso,0)) as peso_linea, "+&
				"(SELECT CONVERT(char(4),e.expedicion_anyo) + '-' + e.expedicion_codigo FROM orden_carga e INNER JOIN orden_carga_linea eocl ON e.empresa = eocl.empresa AND e.anyo = eocl.anyo AND e.codigo = eocl.codigo WHERE venliped.empresa = e.empresa AND venliped.anyo = eocl.venliped_anyo AND venliped.pedido = eocl.venliped_pedido AND venliped.linea = eocl.venliped_linea) as codigo_expedicion,  "+&
				"isnull(venped.numpedcli,'') as referencia_cliente, "+&
				"isnull(venliped.situacion,'') as situacion, "+&
				"0 as estado_linea, "+&
				"isnull(ventipolin.gestionar_en_piezas,'') as gestionar_en_piezas, "+&
				"isnull(venliped.cantidad_pzs,0) as cantidad_pzs, "+&
				"isnull(venliped.precio_pzs,0) as precio_pzs, "+&
				"-1 as disponible_pzs "+&
				"FROM venliped "+&
				"LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo "+&
				"LEFT OUTER JOIN almcajas ON venliped.empresa = almcajas.empresa AND venliped.caja = almcajas.codigo "+&
				"LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo "+& 
				"LEFT OUTER JOIN ventipolin ON venliped.empresa = ventipolin.empresa AND venliped.tipolinea = ventipolin.codigo "+&
				"LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo "+&
				"LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
				"LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo "+&
				"LEFT OUTER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido "+&
				"LEFT OUTER JOIN genter ON venped.empresa = genter.empresa AND venped.cliente = genter.codigo AND genter.tipoter = 'C' "+&
				"LEFT OUTER JOIN venclientes ON venped.empresa = venclientes.empresa AND venped.cliente = venclientes.codigo  "+&
				"LEFT OUTER JOIN unidades ON (case when ventipolin.gestionar_en_piezas = 'S' then '0' else articulos.unidad end) = unidades.codigo  "+&
				"LEFT OUTER JOIN almartcajas ON venliped.empresa = almartcajas.empresa AND venliped.articulo = almartcajas.articulo and venliped.caja = almartcajas.caja "+&
				"WHERE venliped.empresa = '"+codigo_empresa+"' AND venped.es_proforma = 'N'"


sql_final = " "

orden_seleccionado = "venliped_fpedido A, venliped_empresa A, venliped_anyo A, venliped_pedido A, venliped_linea A"

MESSAGEBOX("CONTROL PEDIDOS DEL USUARIO","¿DESEA ELIMINAR SUS PEDIDOS OBSOLETOS?",Question!,OK!)

LONG LL_INDICE,LL_TOTAL

LL_TOTAL = 2500

FOR LL_INDICE = 1 TO LL_TOTAL
	F_MENSAJE_PROCESO("ELIMINANDO PEDIDOS",LL_INDICE,LL_TOTAL)
NEXT

MESSAGEBOX("SIN PEDIDOS DEL USUARIO","SE VA A CERRAR LA VENTANA")

close(this)


end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 3360
integer y = 136
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 3602
integer y = 136
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_pedidos_disponibles_preparacion
integer x = 7045
integer y = 140
integer width = 137
integer height = 112
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
rtn = 1
Long i, j, fila_interior = 0, fila_ini
Boolean varios_clientes = false, pesado = true

String cliente, articulo_descripcion, formato, cod_formato, pedido, pedido_anterior = "", pallet, caja, codigo_articulo, clase_linea = "", observaciones_pedidos = "", tipo_unidad
Long linea, pallets, cajas, piezascaja
Dec peso_bruto, peso_neto, peso_pallet, total_peso_bruto = 0, total_peso_neto = 0, total_peso_bascula = 0, piezas, anyo_pedido, codigo_pedido, linea_pedido, metroscaja
Int decimales_unidad

if dw_orden.rowcount() > 0 then
	
	if isnull(dw_orden.object.almacen_destino[dw_orden.getrow()]) or trim(dw_orden.object.almacen_destino[dw_orden.getrow()]) = "" or isnull(dw_orden.object.zona_destino[dw_orden.getrow()]) or trim(dw_orden.object.zona_destino[dw_orden.getrow()]) = "" or isnull(dw_orden.object.fila_destino[dw_orden.getrow()]) or dec(dw_orden.object.fila_destino[dw_orden.getrow()]) <= 0 or isnull(dw_orden.object.altura_destino[dw_orden.getrow()]) or dec(dw_orden.object.altura_destino[dw_orden.getrow()]) <= 0 then
		MessageBox("Error", "Para imprimir una orden de preparación debe indicar el destino del material")
		return
	end if
	
	f_guardar(true)
	
	dw_imprimir.reset()
	dw_imprimir.accepttext()
	
	//OBSERVACIONES PEDIDOS
	//observaciones_pedido
	
	observaciones_pedidos = ""
	For i = 1 to dw_observaciones_pedidos.rowcount()
		observaciones_pedidos = observaciones_pedidos + "Pedido "+dw_observaciones_pedidos.object.pedido[i] + ": "+  dw_observaciones_pedidos.object.observaciones[i] + "~r"
	next	
	
	fila_ini = dw_imprimir.insertrow(0)
	dw_imprimir.object.orden_carga[fila_ini] = String(dw_orden.object.anyo[dw_orden.getrow()]) + "/" + dw_orden.object.codigo[dw_orden.getrow()]
	dw_imprimir.object.fecha[fila_ini] = dw_orden.object.fecha[dw_orden.getrow()]
	dw_imprimir.object.destino[fila_ini] = dw_orden.object.almacen_destino[dw_orden.getrow()] + "-"+ dw_orden.object.zona_destino[dw_orden.getrow()] + "-"+ String(dw_orden.object.fila_destino[dw_orden.getrow()]) + "-"+ String(dw_orden.object.altura_destino[dw_orden.getrow()])
	
	//Comprobamos que la orden de carga es de un mismo cliente
	cliente = ""
	i = 1 
	Do while i<= dw_lineas.rowcount() and varios_clientes = false
		if cliente = "" then
			cliente = dw_lineas.object.venped_cliente[i]
		else
			if cliente <> dw_lineas.object.venped_cliente[i] then
				varios_clientes = true
				cliente = ""
			end if
		end if
		i++
	loop
	
	dw_imprimir.object.empresa[fila_ini] =  codigo_empresa
	dw_imprimir.object.cliente[fila_ini] =  cliente
	dw_imprimir.object.familia[fila_ini] =  "2" //WOW
	
	dw_lineas.setredraw(false)
	dw_lineas.setsort("orden_carga_linea_venliped_anyo A , orden_carga_linea_venliped_pedido A, orden_carga_linea_venliped_linea A")
	dw_lineas.sort()
	For i = 1 To dw_lineas.rowcount()
		anyo_pedido = dw_lineas.object.orden_carga_linea_venliped_anyo[i]
		codigo_pedido = dw_lineas.object.orden_carga_linea_venliped_pedido[i]
		linea_pedido = dw_lineas.object.orden_carga_linea_venliped_linea[i]
		
		pedido = String(anyo_pedido) + "/" + String(codigo_pedido)
		
		clase_linea = ""
		SELECT clase INTO :clase_linea FROM venliped WHERE empresa = :codigo_empresa AND anyo = :anyo_pedido AND pedido = :codigo_pedido and linea = :linea_pedido;
		
		if pedido_anterior <> pedido then
			if not isnull(dw_lineas.object.venped_peso_bascula_kg[i]) and  dec(dw_lineas.object.venped_peso_bascula_kg[i]) > 0 and pesado then
				total_peso_bascula = total_peso_bascula + dec(dw_lineas.object.venped_peso_bascula_kg[i])
			else
				pesado = false
			end if
		end if
		
		linea = dw_lineas.object.orden_carga_linea_linea[i]
		codigo_articulo = trim(dw_lineas.object.venliped_articulo[i])
		decimales_unidad = ftc_decimales_articulo(codigo_empresa, codigo_articulo)
		articulo_descripcion = codigo_articulo + " " + dw_lineas.object.venliped_descripcion[i]
		if clase_linea = "M" then
			articulo_descripcion = "(M) "+ articulo_descripcion
		end if
		
		cod_formato = dw_lineas.object.venliped_formato[i]
		SELECT abreviado INTO :formato FROM formatos WHERE empresa = :codigo_empresa AND codigo = :cod_formato;
		tipo_unidad = dw_lineas.object.venliped_tipo_unidad[i]
		pallet = dw_lineas.object.venliped_tipo_pallet[i]		
		pallets = dw_lineas.object.venliped_pallets[i] 
		peso_pallet = dw_lineas.object.peso_pallet[i] 
		peso_neto = dw_lineas.object.venliped_peso_neto[i] 
		peso_bruto = dw_lineas.object.venliped_peso[i] 
		if pallets = 0 and dw_lineas.object.orden_carga_linea_pallets_extra[i] = 1 then
			pallets = 1
			peso_bruto = peso_bruto + peso_pallet
		end if
		caja = dw_lineas.object.venliped_caja[i]
		//cajas = dw_lineas.object.venliped_total_cajas[i]  //CAJAS TOTALES DEL PEDIDO, calcular cajas de cada ubicación
		total_peso_bruto = total_peso_bruto + peso_bruto
		total_peso_neto = total_peso_neto + peso_neto
		
		dw_orden_carga_linea_reservas.setfilter("linea = "+String(linea))
		dw_orden_carga_linea_reservas.filter()
		dw_orden_carga_linea_reservas.sort()
		
		For j = 1 To dw_orden_carga_linea_reservas.rowcount()
			
			if fila_interior = 0 then
				fila_interior = fila_ini
			else
				fila_interior = dw_imprimir.insertrow(0)				
			end if
			
//			dw_imprimir.object.cliente[fila_interior] =  cliente
//			dw_imprimir.object.familia[fila_interior] =  "2" //WOW
//			
			piezas = dw_orden_carga_linea_reservas.object.cantidad[j]

			if j = 1 then
				//CAJAS, M2, ... 
				dw_imprimir.object.pallets[fila_interior] = pallets
			else
				dw_imprimir.object.pallets[fila_interior] = 0
			end if
			dw_imprimir.object.articulo[fila_interior] = articulo_descripcion
			dw_imprimir.object.clase_linea[fila_interior] = clase_linea
			dw_imprimir.object.formato[fila_interior] = formato
			
			SELECT metroscaja, piezascaja INTO :metroscaja, :piezascaja
			FROM almartcajas 
			WHERE empresa = :codigo_empresa AND articulo = :codigo_articulo AND caja = :caja;
			if isnull(metroscaja) then metroscaja = 0
			if isnull(piezascaja) then piezascaja = 0
			
			cajas = truncate((piezas / piezascaja),0)
			if piezascaja > 0 then
				//metroscaja = round(metroscaja,2)
				dw_imprimir.object.total_cajas[fila_interior] = cajas
			end if
			
			if tipo_unidad = "1" then
				dw_imprimir.object.piezas[fila_interior] = piezas				
				dw_imprimir.object.metros[fila_interior] = cajas * metroscaja
			else
				//cajas = f_calculo_cajas(codigo_empresa, codigo_articulo, pallet, caja, 0, piezas)
				dw_imprimir.object.metros[fila_interior] = f_calculo_metros_desde_cajas(codigo_empresa, dw_lineas.object.venliped_articulo[i], caja, cajas)
				dw_imprimir.object.piezas[fila_interior] = piezas
			end if
			
			dw_imprimir.object.tono[fila_interior] = dw_orden_carga_linea_reservas.object.tono[j]
			dw_imprimir.object.calibre[fila_interior] = dw_orden_carga_linea_reservas.object.calibre[j]
			dw_imprimir.object.calidad[fila_interior] = dw_orden_carga_linea_reservas.object.calidades_abreviado[j]		
			dw_imprimir.object.alm_bultos_id[fila_interior] = dw_orden_carga_linea_reservas.object.id_alm_bultos[j]		
			
			dw_imprimir.object.origen[fila_interior] = dw_orden_carga_linea_reservas.object.almacen[j] + " - " +  dw_orden_carga_linea_reservas.object.zona[j] + " - " +  String(dw_orden_carga_linea_reservas.object.fila[j]) + " - " +  String(dw_orden_carga_linea_reservas.object.altura[j])
			dw_imprimir.object.pedido[fila_interior] = pedido + "-" + String(dw_lineas.object.orden_carga_linea_venliped_linea[i])
			
			dw_imprimir.object.observaciones_pedido[fila_interior] = observaciones_pedidos
			
			pedido_anterior = pedido
			
			//repetidos para el final
			dw_imprimir.object.empresa[fila_interior] =  codigo_empresa
			dw_imprimir.object.familia[fila_interior] =  "2" //WOW
			dw_imprimir.object.decimales_unidad[fila_interior] = decimales_unidad
			
		next		
	next
	dw_lineas.setsort("orden_carga_linea_linea A")
	dw_lineas.sort()
	dw_lineas.setredraw(true)
	dw_imprimir.object.var_peso_neto[fila_ini] = total_peso_neto
	dw_imprimir.object.var_peso_bruto[fila_ini] = total_peso_bruto
//	if total_peso_bascula > 0 then
//		dw_imprimir.object.var_peso_bascula[fila_ini] =  String( total_peso_bascula ,"##,###") + "  KG"
//	else
//		dw_imprimir.object.var_peso_bascula[fila_ini] = "No pesado"
//	end if
	
	
	dw_imprimir.GroupCalc()
	
	if rtn = 1 then
		f_imprimir_datawindow(dw_imprimir)
	end if
end if

end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_pedidos_disponibles_preparacion
integer x = 8082
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_pedidos_disponibles_preparacion
integer x = 137
integer width = 8155
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_pedidos_disponibles_preparacion
integer x = 3186
integer y = 108
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
if dw_montaje_filtro.rowcount() > 0 then
	new_sql = f_montar_filtro(sql_inicial)  + sql_final
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
else
	dw_datos.reset()
end if

f_mostrar_estado("")

//Filtros mediante Datawindow
filtro_dw = "1 = 1"
For j = 1 To dw_montaje_filtro.rowcount()
	if pos(dw_montaje_filtro.object.linea[j] , "Cliente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Pedido") <> 0 then
		filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
	elseif pos(dw_montaje_filtro.object.linea[j] , "Situación") <> 0 then
		filtro_dw = filtro_dw + " and visible = 1 "
		f_mostrar_estado(dw_montaje_filtro.object.filtro[j])
	end if
Next
dw_datos.setfilter(filtro_dw)
dw_datos.filter()

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 3100
	dw_montaje_filtro.height = 225
end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if

pb_anyadir1.triggerevent("clicked")

dw_datos.setsort(orden_seleccionado)
dw_datos.sort()
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_pedidos_disponibles_preparacion
integer x = 8238
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_pedidos_disponibles_preparacion
integer x = 3035
integer y = 108
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, posicion
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw
Dec anyo, pedido
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
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
				cadena_or = " almacenmovimientos.fecha_mov "+ddlb_operador.text+" '"+em_fecha1.text+"' "
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
						cadena_or = " genter_codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR genter_codigo = '"+dw_filtro.object.#1[i]+"' "
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
			
		case "Situación"
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
					cadena_or = " venliped_anyo "+ddlb_operador.text+" "+String(anyo)+" AND venliped_pedido "+ddlb_operador.text+" "+String(pedido)
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
	if dw_montaje_filtro.rowcount() > 0 then
		dw_datos.retrieve()
	end if
	
	dw_datos.setsort(orden_seleccionado)
	dw_datos.sort()
	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Cliente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Situación") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Pedido") <> 0 then
//			if pos(dw_montaje_filtro.object.linea[j] , "Situación") <> 0 then
//				f_mostrar_estado(upper(dw_montaje_filtro.object.filtro[j]))
//				filtro_dw = filtro_dw + " and visible = 1 "
//			else
				filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
//			end if
		end if
	Next	
//	For j = 1 To dw_montaje_filtro.rowcount()
//		if pos(dw_montaje_filtro.object.linea[j] , "Cliente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Situación") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Pedido") <> 0 then
//			if pos(dw_montaje_filtro.object.linea[j] , "Situación") <> 0 then
//				f_mostrar_estado(upper(dw_montaje_filtro.object.filtro[j]))
//				filtro_dw = filtro_dw + " and visible = 1 "
//			else
//				filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
//			end if
//		end if
//	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	
	dw_datos.setsort(orden_seleccionado)
	dw_datos.sort()
	
	
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
	if dw_montaje_filtro.rowcount() > 0 then
		dw_datos.retrieve()
	end if
	
	dw_datos.setsort(orden_seleccionado)
	dw_datos.sort()
	
	//Filtros mediante Datawindow (OJO: Copiar en PREPAKING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)
	filtro_dw = "1 = 1"

	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Cliente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Situación") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Pedido") <> 0 then
//			if pos(dw_montaje_filtro.object.linea[j] , "Situación") <> 0 then
//				f_mostrar_estado(upper(dw_montaje_filtro.object.filtro[j]))
//				filtro_dw = filtro_dw + " and visible = 1 "
//			else
				filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
//			end if
		end if
	Next
//	For j = 1 To dw_montaje_filtro.rowcount()
//		if pos(dw_montaje_filtro.object.linea[j] , "Cliente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Situación") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Pedido") <> 0 then
//			if pos(dw_montaje_filtro.object.linea[j] , "Situación") <> 0 then
//				f_mostrar_estado(upper(dw_montaje_filtro.object.filtro[j]))
//				filtro_dw = filtro_dw + " and visible = 1 "
//			else
//				filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
//			end if
//		end if
//	Next	
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
		
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
end if

dw_datos.setsort(orden_seleccionado)
dw_datos.sort()

f_calcular_disponible(filtro_dw)
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_pedidos_disponibles_preparacion
integer x = 951
integer taborder = 0
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_pedidos_disponibles_preparacion
integer width = 878
integer height = 1308
integer taborder = 0
integer weight = 700
long textcolor = 24076881
string text = "0"
boolean sorted = false
string item[] = {"Cliente","Artículo (Descripción)","Artículo (Código)","Situación","Pedido (Año/Pedido)","Familia","Dirección","Promoción","Piezas Sueltas","Fecha Carga","País","Reservado + Rotura Stock","Courier"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()
lb_lista.multiselect = true

CHOOSE CASE ddlb_campo.text
	CASE "Artículo (Descripción)"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		/*
		consulta = "Select distinct almacenmovimientos.articulo as Código, CONVERT(char(60),articulos.descripcion) as Descripción, formatos.abreviado as Formato, art_ver_tipooperacion.descripcion_abr as Operación, almusos.descripcion AS Uso "+&
						"from almacenmovimientos LEFT OUTER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
						"LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
						"LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
						"LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
						"where almacenmovimientos.empresa = '"+codigo_empresa+"' and articulos.familia = '2' order by CONVERT(char(60), articulos.descripcion)"
						
		*/
		consulta = "Select distinct articulos.codigo as Código, CONVERT(char(60),articulos.descripcion) as Descripción, formatos.abreviado as Formato, art_ver_tipooperacion.descripcion_abr as Operación, almusos.descripcion AS Uso "+&
					  "from articulos "+&
					  "LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+& 
					  "LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
					  "LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
					  "where articulos.empresa = '"+codigo_empresa+"' AND articulos.uso = '3' and articulos.fecha_anulado is null  "+&
					  "order by CONVERT(char(60), articulos.descripcion) "
					  
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_pedidos_disponibles_preparacion
integer x = 55
integer y = 492
integer width = 5403
integer height = 3100
integer taborder = 40
string dataobject = "dwtc_consulta_pedidos_disponibles_preparacion"
end type

event dw_datos::doubleclicked;call super::doubleclicked;String orden_carga, banda_seleccionada
Int anyo, posicion
Dec pedido
str_parametros  lstr_param
long id_ventana, fila
str_venliped venliped
long ll_donde,ll_total,ll_row
string ls_find,ls_familia_articulo,ls_tipo_pallet_anterior
boolean lb_recalcular_disponibles = false,lb_pallet_cambiado = false
datastore lds_pallets
string ls_pallets[]
int    li_indice_pallets,li_total_pallets
			
if row > 0 then
	if dwo.name = "orden_carga" or dwo.name = "fecha_orden_carga" or dwo.name ="codigo_expedicion" then
		orden_carga = this.object.orden_carga[row]
		posicion = pos(lower(orden_carga), '/')
		anyo = Integer(mid(orden_carga, 1, posicion - 1))
		orden_carga = mid(orden_carga, posicion + 1)
		f_buscar(orden_carga, anyo)		
	end if	
	
	if dwo.name = 'c_disponible' then
		string ls_articulo,ls_calidad,ls_tonochar,ls_tipo_pallet,ls_caja,ls_situacion,ls_gestionar_en_piezas
		int    li_anyo,li_linea,li_calibre
		long   ll_pedido
		dec    ld_disponible,ld_cantidad,ld_cantidad_pzs,ld_disponible_pzs
		
		string    ls_sel,ls_tono_imprimir,ls_calibre_imprimir,ls_referencia,ls_montajeartcal
		int       li_lotes
		datastore ds_lotes
		
		li_anyo        = this.object.venliped_anyo[row]
		ll_pedido      = this.object.venliped_pedido[row]
		li_linea       = this.object.venliped_linea[row]
		
		ls_articulo    = this.object.venliped_articulo[row]
		ls_calidad     = this.object.venliped_calidad[row]
		ls_tonochar    = this.object.venliped_tonochar[row]
		li_calibre     = this.object.venliped_calibre[row]
		ls_tipo_pallet = this.object.venliped_tipo_pallet[row]
		ls_caja        = this.object.venliped_caja[row]
		ld_cantidad    = this.object.venliped_cantidad[row]
		ld_cantidad_pzs = this.object.cantidad_pzs[row]
		ls_gestionar_en_piezas = this.object.gestionar_en_piezas[row]
		ls_situacion   = this.object.situacion[row]
		
		ls_familia_articulo = f_familia_articulo(codigo_empresa,ls_articulo)
		
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
				
			end if				

		else
			//No gestionado en piezas o disponible < que pedido o no a fabricar
			//Para la familia marcas (2) solo pueden asignar y desasignar los usuarios del grupo exportacion (20)
	
			if ( ls_familia_articulo = "2" and gs_usuarios_v_grupo = "20" ) or ls_familia_articulo <> "2" &
				or nombre_usuario = "PCOPIA" or nombre_usuario = "DMUNYOZ" &
				or nombre_usuario = "TENCER" or nombre_usuario = "AMALLEN" or nombre_usuario = "PROMOCION"then		
				
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
								this.object.situacion[row]         = 'C'
								this.object.venliped_tonochar[row] = ls_tonochar
								this.object.venliped_calibre[row]  = li_calibre
								this.object.estado_linea[row]      = 40 //Reservado
								lb_recalcular_disponibles = true					
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
										this.object.situacion[row]            = 'C'
										this.object.venliped_tonochar[row]    = ls_tonochar
										this.object.venliped_calibre[row]     = li_calibre
										this.object.venliped_tipo_pallet[row] = '00000'
										this.object.estado_linea[row]         = 40 //Reservado
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
									messagebox("¡Atención!","Hay mas de un lote.~nDebe asignar desde la introducción de pedidos.")
								end if
							end if				
							
							//Fin de Vamos a ver si hay lotes con pallet = '00000'
						else
							//Mas de un lote
							messagebox("¡Atención!","Hay mas de un lote.~nDebe asignar desde la introducción de pedidos.")
						end if
					end if				
					
					destroy ds_lotes				
				else
					if ls_situacion = 'C' then
						update venliped
						set    venliped.situacion = 'F'
						where  venliped.empresa = :codigo_empresa
						and    venliped.anyo    = :li_anyo
						and    venliped.pedido  = :ll_pedido
						and    venliped.linea   = :li_linea;
						
						if sqlca.sqlcode <> 0 then
							rollback;
						else
							commit;
							this.object.situacion[row] = 'F'
							
							this.object.disponible[row] = f_disponible_art_cal_to_ca_tp_c( this.object.venliped_empresa[row] ,&
																												this.object.venliped_articulo[row] ,&
																												this.object.venliped_calidad[row] ,&
																												this.object.venliped_tonochar[row] ,&
																												this.object.venliped_calibre[row] ,&
																												this.object.venliped_tipo_pallet[row] ,&
																												this.object.venliped_caja[row] )					
																												
							this.object.disponible_pzs[row] = f_disponible_art_cal_to_ca_tp_c_pzs( this.object.venliped_empresa[row] ,&
																												this.object.venliped_articulo[row] ,&
																												this.object.venliped_calidad[row] ,&
																												this.object.venliped_tonochar[row] ,&
																												this.object.venliped_calibre[row] ,&
																												this.object.venliped_tipo_pallet[row] ,&
																												this.object.venliped_caja[row] )																																
							
							if this.object.venliped_tipo_pallet[row] <> '00000' then
								this.object.disponible[row] = this.object.disponible[row] +&
																		f_disponible_art_cal_to_ca_tp_c( this.object.venliped_empresa[row] ,&
																													this.object.venliped_articulo[row] ,&
																													this.object.venliped_calidad[row] ,&
																													this.object.venliped_tonochar[row] ,&
																													this.object.venliped_calibre[row] ,&
																													'00000' ,&
																													this.object.venliped_caja[row] )					
																													
								this.object.disponible_pzs[row] = this.object.disponible_pzs[row] +&
																  f_disponible_art_cal_to_ca_tp_c_pzs( this.object.venliped_empresa[row] ,&
																													this.object.venliped_articulo[row] ,&
																													this.object.venliped_calidad[row] ,&
																													this.object.venliped_tonochar[row] ,&
																													this.object.venliped_calibre[row] ,&
																													'00000' ,&
																													this.object.venliped_caja[row] )																
							end if
							
							if ( this.object.gestionar_en_piezas[row] = "N" and this.object.disponible[row] >= this.object.venliped_cantidad[row] ) or ( this.object.gestionar_en_piezas[row] = "S" and this.object.disponible_pzs[row] >= this.object.cantidad_pzs[row] ) then
								this.object.estado_linea[row] = 30 //Pdte Reservar
							else
								if this.object.planificado[row] > 0 and isnull(this.object.fecha_fin[row]) then
									this.object.estado_linea[row] = 15 //Planificado sin Fecha
								else
									if this.object.planificado[row] > 0 then
										this.object.estado_linea[row] = 20 //Planificado
									else
										this.object.estado_linea[row] = 10 //Rotura Stock
									end if
								end if						
								/*
								if isnull(this.object.fecha_fin[row]) then
									this.object.estado_linea[row] = 10 //Rotura Stock
								else
									this.object.estado_linea[row] = 20 //Planificado
								end if
								*/
							end if			
							
							lb_recalcular_disponibles = true
						end if				
					else
						//Situacion 'P' Preparado no hacemos nada
					end if
				end if
			end if
		end if
		
			
		if lb_recalcular_disponibles then
			//Recalculamos los disponibles
			this.setredraw(false)
			ll_total = this.rowcount()
			
//				this.object.disponible[row] = f_disponible_art_cal_to_ca_tp_c( this.object.venliped_empresa[row] ,&
//																									this.object.venliped_articulo[row] ,&
//																									this.object.venliped_calidad[row] ,&
//																									this.object.venliped_tonochar[row] ,&
//																									this.object.venliped_calibre[row] ,&
//																									this.object.venliped_tipo_pallet[row] ,&
//																									this.object.venliped_caja[row] )
//																									
//				ls_find = "venliped_articulo = '"+this.object.venliped_articulo[row]+"' and "+&
//							 "venliped_calidad = '"+this.object.venliped_calidad[row]+"' and "+&
//							 "venliped_tonochar = '"+this.object.venliped_tonochar[row]+"' and "+&
//							 "venliped_calibre = "+string(this.object.venliped_calibre[row],"0")+" and "+&
//							 "venliped_tipo_pallet = '"+this.object.venliped_tipo_pallet[row]+"' and "+&
//							 "venliped_caja = '"+this.object.venliped_caja[row]+"' "

			for li_indice_pallets = 1 to li_total_pallets
				ls_articulo    = this.object.venliped_articulo[row]
				ls_calidad     = this.object.venliped_calidad[row]
				ls_tipo_pallet = ls_pallets[li_indice_pallets]
				ls_caja        = this.object.venliped_caja[row]

				ls_find = "venliped_articulo = '"+ls_articulo+"' and "+&
							 "venliped_calidad = '"+ls_calidad+"' and "+&
							 "venliped_tipo_pallet = '"+ls_tipo_pallet+"' and "+&
							 "venliped_caja = '"+ls_caja+"' "

				ll_row = this.find(ls_find,1,ll_total)

				if ll_row > 0 then
					this.object.disponible[ll_row] = f_disponible_art_cal_tp_c( codigo_empresa ,ls_articulo ,ls_calidad ,ls_tipo_pallet ,ls_caja )
																										
					this.object.disponible_pzs[ll_row] = f_disponible_art_cal_tp_c_pzs( codigo_empresa ,ls_articulo ,ls_calidad ,ls_tipo_pallet ,ls_caja )																									
					
					if ls_tipo_pallet <> '00000' then
						this.object.disponible[ll_row] = this.object.disponible[ll_row] + f_disponible_art_cal_tp_c( codigo_empresa ,ls_articulo ,ls_calidad ,'00000' ,ls_caja )
																											
						this.object.disponible_pzs[ll_row] = this.object.disponible_pzs[ll_row] + f_disponible_art_cal_tp_c_pzs( codigo_empresa ,ls_articulo ,ls_calidad ,'00000' ,ls_caja )
					end if
						
					ls_find = "venliped_articulo = '"+ls_articulo+"' and "+&
								 "venliped_calidad = '"+ls_calidad+"' and "+&
								 "venliped_tipo_pallet = '"+ls_tipo_pallet+"' and "+&
								 "venliped_caja = '"+ls_caja+"' "
								 
					ll_donde = 0
					do
						ll_donde ++
						ll_donde = this.find(ls_find,ll_donde,ll_total)
						if ll_donde > 0 and ll_donde <> ll_row then
							this.object.disponible[ll_donde] = this.object.disponible[ll_row]
							this.object.disponible_pzs[ll_donde] = this.object.disponible_pzs[ll_row]
							
							if this.object.situacion[ll_donde] = 'F' then
								if ( this.object.gestionar_en_piezas[ll_donde] = "N" and this.object.disponible[ll_donde] >= this.object.venliped_cantidad[ll_donde] ) or ( this.object.gestionar_en_piezas[ll_donde] = "S" and this.object.disponible_pzs[ll_donde] >= this.object.cantidad_pzs[ll_donde] ) then
									this.object.estado_linea[ll_donde] = 30 //Pdte Reservar
								else
									if this.object.planificado[ll_donde] > 0 and isnull(this.object.fecha_fin[ll_donde]) then
										this.object.estado_linea[ll_donde] = 15 //Planificado sin Fecha
									else
										if this.object.planificado[ll_donde] > 0 then
											this.object.estado_linea[ll_donde] = 20 //Planificado
										else
											this.object.estado_linea[ll_donde] = 10 //Rotura Stock
										end if
									end if							
									/*
									if isnull(this.object.fecha_fin[ll_donde]) then
										this.object.estado_linea[ll_donde] = 10 //Rotura Stock
									else
										this.object.estado_linea[ll_donde] = 20 //Planificado
									end if
									*/
								end if								
							end if
						end if
					loop while ll_donde > 0 and ll_donde < ll_total		
				end if										
			next
											
			this.setredraw(true)				
		
		end if
	end if
else
	
	banda_seleccionada = this.GetBandAtPointer()
	//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
	fila = Long(Mid(banda_seleccionada, LastPos(banda_seleccionada, "~t") + 1))
	
	if dwo.name = "venliped_pedido" or dwo.name = "venliped_anyo" then
		pedido = dec(this.object.venliped_pedido[fila])
		anyo = int(this.object.venliped_anyo[fila])
		
		ddlb_campo.text = "Pedido (Año/Pedido)"
		ddlb_campo.TriggerEvent (Selectionchanged!)
		sle_valor1.text = string(anyo)+"/"+string(pedido)
		pb_anyadir1.TriggerEvent (Clicked!)
		cbx_resumen.checked = false
		cbx_resumen.TriggerEvent (Clicked!)
		/*
		lstr_param.s_argumentos[1] = codigo_empresa
		lstr_param.s_argumentos[2] = String(anyo)
		lstr_param.s_argumentos[3] = String(pedido)
		lstr_param.i_nargumentos = 3
		lstr_param.nombre_ventana = "wtc_consulta_pedidos_disponibles_preparacion"
		lstr_param.resultado = ''
		id_ventana = f_menu_ventana_esta_abierta("w_int_venped")
		if id_ventana <> -1 then
			close(wtc_mant_pruebas)
			OpenWithParm(w_int_venped, lstr_param)
		else
			OpenWithParm(w_int_venped, lstr_param)
		end if
		*/
	end if
end if

/*
String orden_carga, banda_seleccionada
Int anyo, posicion
Dec pedido
str_parametros  lstr_param
long id_ventana, fila
str_venliped venliped
long ll_donde,ll_total
string ls_find
boolean lb_recalcular_disponibles = false

if row > 0 then
	if dwo.name = "orden_carga" or dwo.name = "fecha_orden_carga" or dwo.name ="codigo_expedicion" then
		orden_carga = this.object.orden_carga[row]
		posicion = pos(lower(orden_carga), '/')
		anyo = Integer(mid(orden_carga, 1, posicion - 1))
		orden_carga = mid(orden_carga, posicion + 1)
		f_buscar(orden_carga, anyo)		
	end if	
	
	if dwo.name = 'c_disponible' then
		string ls_articulo,ls_calidad,ls_tonochar,ls_tipo_pallet,ls_caja,ls_situacion
		int    li_anyo,li_linea,li_calibre
		long   ll_pedido
		dec    ld_disponible,ld_cantidad
		
		li_anyo        = this.object.venliped_anyo[row]
		ll_pedido      = this.object.venliped_pedido[row]
		li_linea       = this.object.venliped_linea[row]
		
		ls_articulo    = this.object.venliped_articulo[row]
		ls_calidad     = this.object.venliped_calidad[row]
		ls_tonochar    = this.object.venliped_tonochar[row]
		li_calibre     = this.object.venliped_calibre[row]
		ls_tipo_pallet = this.object.venliped_tipo_pallet[row]
		ls_caja        = this.object.venliped_caja[row]
		ld_cantidad    = this.object.venliped_cantidad[row]
		ls_situacion   = this.object.situacion[row]
		
		if ls_situacion = 'F' then
			ld_disponible = f_disponible_art_cal_to_ca_tp_c( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , ls_tipo_pallet , ls_caja )
			
			if ld_disponible >= ld_cantidad then
				update venliped
				set    venliped.situacion = 'C'
				where  venliped.empresa = :codigo_empresa
				and    venliped.anyo    = :li_anyo
				and    venliped.pedido  = :ll_pedido
				and    venliped.linea   = :li_linea;
				
				if sqlca.sqlcode <> 0 then
					rollback;
				else
					commit;
					this.object.situacion[row] = 'C'
					this.object.estado_linea[row] = 40 //Reservado
					lb_recalcular_disponibles = true					
				end if
			else
				
			end if
						
		else
			if ls_situacion = 'C' then
				update venliped
				set    venliped.situacion = 'F'
				where  venliped.empresa = :codigo_empresa
				and    venliped.anyo    = :li_anyo
				and    venliped.pedido  = :ll_pedido
				and    venliped.linea   = :li_linea;
				
				if sqlca.sqlcode <> 0 then
					rollback;
				else
					commit;
					this.object.situacion[row] = 'F'
					
					this.object.disponible[row] = f_disponible_art_cal_to_ca_tp_c( this.object.venliped_empresa[row] ,&
																										this.object.venliped_articulo[row] ,&
																										this.object.venliped_calidad[row] ,&
																										this.object.venliped_tonochar[row] ,&
																										this.object.venliped_calibre[row] ,&
																										this.object.venliped_tipo_pallet[row] ,&
																										this.object.venliped_caja[row] )					
					
					if this.object.disponible[row] >= this.object.venliped_cantidad[row] then
						this.object.estado_linea[row] = 30 //Pdte Reservar
					else
						if isnull(this.object.fecha_fin[row]) then
							this.object.estado_linea[row] = 10 //Rotura Stock
						else
							this.object.estado_linea[row] = 20 //Planificado
						end if
					end if			
					
					lb_recalcular_disponibles = true
				end if				
			else
				//Situacion 'P' Preparado no hacemos nada
			end if
		end if
		
		if lb_recalcular_disponibles then
			//Recalculamos los disponibles
			ll_total = this.rowcount()
			
			this.object.disponible[row] = f_disponible_art_cal_to_ca_tp_c( this.object.venliped_empresa[row] ,&
																								this.object.venliped_articulo[row] ,&
																								this.object.venliped_calidad[row] ,&
																								this.object.venliped_tonochar[row] ,&
																								this.object.venliped_calibre[row] ,&
																								this.object.venliped_tipo_pallet[row] ,&
																								this.object.venliped_caja[row] )
																								
			ls_find = "venliped_articulo = '"+this.object.venliped_articulo[row]+"' and "+&
						 "venliped_calidad = '"+this.object.venliped_calidad[row]+"' and "+&
						 "venliped_tonochar = '"+this.object.venliped_tonochar[row]+"' and "+&
						 "venliped_calibre = "+string(this.object.venliped_calibre[row],"0")+" and "+&
						 "venliped_tipo_pallet = '"+this.object.venliped_tipo_pallet[row]+"' and "+&
						 "venliped_caja = '"+this.object.venliped_caja[row]+"' "
						 
			ll_donde = 0
			do
				ll_donde ++
				ll_donde = this.find(ls_find,ll_donde,ll_total)
				if ll_donde > 0 and ll_donde <> row then
					this.object.disponible[ll_donde] = this.object.disponible[row]
					
					if this.object.situacion[ll_donde] = 'F' then
						if this.object.disponible[ll_donde] >= this.object.venliped_cantidad[ll_donde] then
							this.object.estado_linea[ll_donde] = 30 //Pdte Reservar
						else
							if isnull(this.object.fecha_fin[ll_donde]) then
								this.object.estado_linea[ll_donde] = 10 //Rotura Stock
							else
								this.object.estado_linea[ll_donde] = 20 //Planificado
							end if
						end if								
					end if
				end if
			loop while ll_donde > 0 and ll_donde < ll_total			
			
		end if
	end if
else
	
	banda_seleccionada = this.GetBandAtPointer()
	//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
	fila = Long(Mid(banda_seleccionada, LastPos(banda_seleccionada, "~t") + 1))
	
	if dwo.name = "venliped_pedido" or dwo.name = "venliped_anyo" then
		pedido = dec(this.object.venliped_pedido[fila])
		anyo = int(this.object.venliped_anyo[fila])
		
		ddlb_campo.text = "Pedido (Año/Pedido)"
		ddlb_campo.TriggerEvent (Selectionchanged!)
		sle_valor1.text = string(anyo)+"/"+string(pedido)
		pb_anyadir1.TriggerEvent (Clicked!)
		cbx_resumen.checked = false
		cbx_resumen.TriggerEvent (Clicked!)
		/*
		lstr_param.s_argumentos[1] = codigo_empresa
		lstr_param.s_argumentos[2] = String(anyo)
		lstr_param.s_argumentos[3] = String(pedido)
		lstr_param.i_nargumentos = 3
		lstr_param.nombre_ventana = "wtc_consulta_pedidos_disponibles_preparacion"
		lstr_param.resultado = ''
		id_ventana = f_menu_ventana_esta_abierta("w_int_venped")
		if id_ventana <> -1 then
			close(wtc_mant_pruebas)
			OpenWithParm(w_int_venped, lstr_param)
		else
			OpenWithParm(w_int_venped, lstr_param)
		end if
		*/
	end if
end if

*/



end event

event dw_datos::clicked;call super::clicked;String articulo, cliente, banda_seleccionada, peso_seleccionadas, calidad, tono, unidad, caja, tipo_pallet, formato
Int calibre, pedido_anyo, pedido_linea
Long i, j, posicion, maximo_valor_dw, nuevo_codigo, fila_dw, actual, fin
Dec stock, anyo, pedido, pedido_codigo, cantidad_pedido,ld_stock_no_seleccionable,ld_cantidad_pedido
String orden_carga,ls_situacion
string sel,ls_gestionar_en_piezas,ls_unidad_articulo
datastore pedidos, planificado
datetime fecha_planificado
long cantidad_planificada

setnull(fecha_planificado)

if dwo.name = "t_pedido" then
	this.setsort("venliped_fpedido A,venliped_anyo A,venliped_pedido A,venliped_linea A")
	this.sort()	
	
	this.modify("t_pedido.text='PEDIDO \/'")
	this.modify("t_fecha_carga.text='F. CARGA'")
else
	if dwo.name = "t_fecha_carga" then
		this.setsort("venped_fecha_carga_prevista A,venliped_anyo A,venliped_pedido A,venliped_linea A")
		this.sort()
		
		this.modify("t_pedido.text='PEDIDO'")
		this.modify("t_fecha_carga.text='F. CARGA \/'")		
	end if
end if

if dwo.name = "p_detalle_fechas" then
	dwtc_reparto_fabricaciones.visible = true
	dwtc_reparto_fabricaciones.reset()
	articulo = this.object.venliped_articulo[row]
//	messagebox("", string(articulo))

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
			
	f_cargar_cursor_trans (SQLCA, sel, pedidos)
		
	if pedidos.rowcount() > 0 then
		dwtc_reparto_fabricaciones.object.data = pedidos.object.data
	end if
	


	sel = " SELECT cantidad, f_fin_estimada "+&
			" FROM planificacion "+&
			" WHERE planificacion.cod_articulo = '"+articulo+"' "+&
			" AND planificacion.f_fin_estimada IS NOT NULL "+&
			" ORDER BY planificacion.f_fin_estimada"
			
	f_cargar_cursor_trans (SQLCA, sel, planificado)
	
	j= 1
	long ll_cantidad_disponible
	ll_cantidad_disponible = f_disponible_art_cal_pzs(codigo_empresa,articulo,'1')
	cantidad_planificada   = ll_cantidad_disponible //0
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
	
	return
end if


if dwo.name = "venped_fecha_carga_prevista" or dwo.name = "p_fecha" and permiso_ventana = 2 then
	
	//Utilizamos GetBandAtPointer(), que nos muestra la banda seleccionada y la primera fila del grupo seleccionado en un string separado por un tabulador.
	banda_seleccionada = this.GetBandAtPointer()
	//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
	posicion = Long(Mid(banda_seleccionada, LastPos(banda_seleccionada, "~t") + 1))
	
	anyo = this.object.venliped_anyo[posicion]
	pedido = this.object.venliped_pedido[posicion]
	
	if dw_fecha.retrieve(codigo_empresa, anyo, pedido) = 0 then
		i = dw_fecha.insertrow(0)
		
		dw_fecha.object.empresa [i] = codigo_empresa
		dw_fecha.object.anyo [i] = anyo
		dw_fecha.object.pedido [i] = pedido
	end if
	dw_fecha.visible = true
elseif dwo.name = "p_carga" or xpos = -1 then //XPOS -1 permite entrar de nuevo a seleccionar material cuando se acaba de crear una orden de carga
	dw_stock.visible = false

	this.setredraw(false)
	
	ls_gestionar_en_piezas = this.object.gestionar_en_piezas[row]	
				
	string ls_cantidad_pzs_visible,ls_venliped_cantidad_visible
	
	ls_cantidad_pzs_visible = this.describe('cantidad_pzs.visible')
	ls_venliped_cantidad_visible = this.describe('venliped_cantidad.visible')	
		
	this.modify('cantidad_pzs.visible = 1')	
	this.modify('venliped_cantidad.visible = 1')	
		
//	this.SetTabOrder("cantidad_pzs",0)
//	this.SetTabOrder("venliped_cantidad",0)		
		
	this.selectrow(0,false)
	this.setrow(row)
	this.selectrow(row,true)    	
	
//	if this.getrow() <> row then
		if ls_gestionar_en_piezas = "S" then
			this.SetColumn ("cantidad_pzs")
		else
			this.SetColumn ("venliped_cantidad")
		end if
		
//		this.setrow(row)
//	end if
	
	this.modify('cantidad_pzs.visible = '+ls_cantidad_pzs_visible)	
	this.modify('venliped_cantidad.visible = '+ls_venliped_cantidad_visible)		
	
	this.setredraw(true)
	
	//dw_1.Modify("salary.Color = '0 ~t if(salary <12000,255,0)' ")
	
//	this.SetTabOrder("cantidad_pzs",1)
//	this.SetTabOrder("venliped_cantidad",2)			
	
	articulo               = this.object.venliped_articulo[row]
	if isnull(articulo) then articulo = ''
	ls_unidad_articulo     = f_unidad_articulo(codigo_empresa,articulo)
	calidad                = this.object.venliped_calidad[row]
	tono                   = this.object.venliped_tonochar[row]
	calibre                = this.object.venliped_calibre[row]
	cliente                = this.object.venliped_cliente[row]
	unidad                 = this.object.venliped_tipo_unidad[row]
	caja                   = this.object.venliped_caja[row]
	tipo_pallet            = this.object.venliped_tipo_pallet[row]
	formato                = this.object.venliped_formato[row]
	ls_situacion           = this.object.situacion[row]

	
	if ls_situacion <> 'C' and trim(articulo) <> '' then
		//Solo se pueden preparar las lineas reservadas (Situación = 'C')
		return		
	end if
	
	if dw_orden.rowcount() <= 0 then
		if MessageBox("¿Nueva Orden de Preparación?", "No ha seleccionado ninguna orden de preparación. ¿Desea crear una nueva?", Question!, YesNo!, 2) = 2 then		
			return
		end if
		//PROCESO DE CREACIÓN /SELECCIÓN DE ORDENES DE CARGA
		dw_expedicion.retrieve(codigo_empresa, cliente)
		dw_expedicion.visible = true
		pb_mas_exp.visible = true
		pb_menos_exp.visible = true
		
		//VARIABLES DE INSTANCIA QUE REGULAN COMPORTAMIENTO DE dw_expedicion
		modo_expedicion = 1 
		cliente_expedicion = cliente
		
		dw_expedicion.object.t_titulo.text = "Listado Órdenes Carga: "+f_razon_genter(codigo_empresa, "C", cliente_expedicion)
		
		return
	else
		//OBTENEMOS DATOS DE LA ORDEN DE CARGA, PARA EVITAR INTRODUCIR NUEVAS LINEAS EN ÓRDENES DE CARGA FINALIZADAS
		if dw_orden.object.finalizada[dw_orden.getrow()] = 'S' then
			MessageBox("Orden de Preparación Finalizada", "No se pueden introducir nuevas líneas en ordenes de preparación ya finalizadas. Cree una nueva orden de preparación.", StopSign!)
			return
		end if		
	end if
	
	
	
	if dw_lineas.rowcount() > 0 then
		if cliente <> dw_lineas.object.venped_cliente[1] then
			MessageBox("Error", "Las órdenes de preparación solo pueden ser de un mismo cliente")
			return
		end if
	end if
	
	
	//CONTROLAMOS SI EL ARTÍCULO TIENE CÓDIGO O NO (Líneas de sportes y fletes, artículos sin alta, ..)
	if isnull(articulo) or articulo = "" then
		//CASO ARTÍCULO SIN ALTA (sin stocks)
		orden_carga = dw_datos.object.orden_carga[row]	
		
		pedido_anyo     = dw_datos.object.venliped_anyo[row]
		pedido_codigo   = dw_datos.object.venliped_pedido[row]
		pedido_linea    = dw_datos.object.venliped_linea[row]		
		cantidad_pedido = Dec(dw_datos.object.venliped_cantidad[row])
		
		//INSERCIÓN EN ORDEN DE CARGA ********************************************************************
		maximo_valor_dw = long(dw_lineas.Describe("Evaluate('Max(orden_carga_linea_linea)', 0)"))
		if isnull(maximo_valor_dw) then maximo_valor_dw = 0
		nuevo_codigo = maximo_valor_dw +1
		
		fila_dw = dw_lineas.insertrow(0)
		
//		dw_lineas.object.orden_carga_linea_empresa[fila_dw] = codigo_empresa
//		dw_lineas.object.orden_carga_linea_anyo[fila_dw] = anyo
//		dw_lineas.object.orden_carga_linea_codigo[fila_dw] = orden_carga
		dw_lineas.object.orden_carga_linea_linea[fila_dw] = nuevo_codigo
		
		dw_lineas.object.orden_carga_linea_venliped_anyo[fila_dw] = pedido_anyo
		dw_lineas.object.orden_carga_linea_venliped_pedido[fila_dw] = pedido_codigo
		dw_lineas.object.orden_carga_linea_venliped_linea[fila_dw] = pedido_linea

//		dw_lineas.object.venliped_articulo[fila_dw] = ""
//		dw_lineas.object.venliped_descripcion[fila_dw] = dw_datos.object.venliped_descripcion[row]
//		dw_lineas.object.genter_razon[fila_dw] = dw_datos.object.genter_razon[row]
//		dw_lineas.object.venliped_cantidad[fila_dw] = dw_datos.object.venliped_cantidad[row]
//		dw_lineas.object.venped_cliente[fila_dw] = dw_datos.object.venliped_cliente[row]
//		
		dw_lineas.object.orden_carga_linea_pallets_extra[fila_dw] = 0
		
		f_guardar(true)
		
		//NO HAY ALTA, POR LO QUE NO HAY INFORMACIÓN DE PALLETS, CAJAS, ...
//		num_pallets = dw_datos.object.venliped_pallets[row]
//		tipo_pallet = dw_datos.object.venliped_tipo_pallet[row]
//		pallets_resumido = dw_datos.object.pallets_resumido[row]
//		pallets_descripcion = dw_datos.object.pallets_descripcion[row]
		
//		dw_lineas.object.venliped_pallets[fila_dw] = num_pallets
//		dw_lineas.object.venliped_tipo_pallet[fila_dw] = tipo_pallet
//		dw_lineas.object.venliped_numpalet[fila_dw] = numpalet
//		dw_lineas.object.pallets_resumido[fila_dw] = pallets_resumido
//		dw_lineas.object.pallets_descripcion[fila_dw] = pallets_descripcion

//		dw_lineas.object.venliped_peso[fila_dw] = dw_datos.object.venliped_peso[row]
//		dw_lineas.object.orden_carga_linea_pallets_extra[fila_dw] = 0

	else
		//CASO CON ARTÍCULO NORMAL (Con stocks)
		if dw_stock.retrieve(codigo_empresa, articulo, calidad, tono, calibre, unidad, tipo_pallet, caja, formato) > 0 then
			stock                     = 0
			ld_stock_no_seleccionable = 0
			
			if ls_gestionar_en_piezas = 'S' then
				ld_cantidad_pedido = this.object.cantidad_pzs[row]
			else
				ld_cantidad_pedido = this.object.venliped_cantidad[row]
			end if
			
			for i = 1 To dw_stock.rowcount()
				//dw_stock.object.existencias[i] //Este campo tiene las piezas
				if dw_stock.object.gestionar_en_piezas[i] = ls_gestionar_en_piezas or ( ls_gestionar_en_piezas = 'S' and ls_unidad_articulo <> '1' ) then
					stock += dw_stock.object.existencias_unidad[i] //Este campo tiene la cantidad en la unidad del articulo o en pzs según el parametro de la ubicación
				else
					ld_stock_no_seleccionable += dw_stock.object.existencias_unidad[i] //Este campo tiene la cantidad en la unidad del articulo o en pzs según el parametro de la ubicación
				end if
			next
			
			if ls_gestionar_en_piezas = 'S' then
				//El no seleccionable estará en m2
				ld_stock_no_seleccionable = f_conversion_cantidad_piezas(codigo_empresa,articulo,caja,ld_stock_no_seleccionable)
			else
				//El no seleccionable estará en pzs
				ld_stock_no_seleccionable = f_conversion_piezas_cantidad(codigo_empresa,articulo,caja,ld_stock_no_seleccionable)
			end if
			
			if ( stock + ld_stock_no_seleccionable ) >= this.object.venliped_cantidad[row] then
				dw_stock.visible = true
				dw_stock.setfilter (" existencias_unidad <> 0 ")
				dw_stock.filter()
			else
				MessageBox("Atención", "No ha stock del artículo seleccionado")
			end if
		else
			MessageBox("Atención", "No ha stock del artículo seleccionado")
		end if
	end if
else
	if row > 0 then
		//SELECCIÓN DE FILAS
		if keydown(KeyControl!) then
			if IsSelected(row) then
				SelectRow(row,false)
			else
				SelectRow(row,true) 
			end if
		elseif keydown(KeyShift!) then
			i = 1
			actual = 0
			Do while i < this.rowcount() and actual = 0
				 if this.IsSelected(i) then
					actual = i
				end if
				i++
			Loop
			
			selectrow(0,false)
			
			if row < actual then
				i = row
				fin = actual
			else 
				i = actual 
				fin = row
			end if
			
			Do while i <= fin
				SelectRow(i,true)
				i++
			Loop
		else
			selectrow(0,false)
			selectrow(row,true)    
		end if
		//peso_seleccionadas = String(this.describe("Evaluate('SUM(if (IsSelected(), peso_linea, 0))', 0)"))
		//this.object.peso_seleccionadas.text = peso_seleccionadas
	end if
end if


end event

event dw_datos::rowfocuschanged;//NO EXTENDER PADRE PARA PERMITIR SELECCION MULTIPLE EN EL CLICKED
String var_montaje

//if dwo.name = "venliped_cantidad" then
//var_montaje = "venliped_cantidad.editmask.mask=" +"'"+ f_mascara_decimales(this.object.articulos_decimales_unidad[currentrow])    +"'"
IF this.RowCount() > 0 then
	var_montaje = "venliped_cantidad.Edit.Format=" +"'"+ f_mascara_decimales(this.object.articulos_decimales_unidad[currentrow])    +"'"	
	this.Modify(var_montaje)
	var_montaje = "cantidad_pzs.Edit.Format=" +"'"+ f_mascara_decimales(0)    +"'"	
	this.Modify(var_montaje)	
end if
//end if
end event

event dw_datos::rbuttondown;call super::rbuttondown;String orden_carga, banda_seleccionada
Int anyo, posicion
Dec pedido
str_parametros  lstr_param
long id_ventana, fila

banda_seleccionada = this.GetBandAtPointer()
//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
fila = Long(Mid(banda_seleccionada, LastPos(banda_seleccionada, "~t") + 1))


pedido = dec(this.object.venliped_pedido[fila])
anyo = int(this.object.venliped_anyo[fila])


lstr_param.s_argumentos[1] = codigo_empresa
lstr_param.s_argumentos[2] = String(anyo)
lstr_param.s_argumentos[3] = String(pedido)
lstr_param.i_nargumentos = 3
lstr_param.nombre_ventana = "wtc_consulta_pedidos_disponibles_preparacion"
lstr_param.resultado = ''
id_ventana = f_menu_ventana_esta_abierta("w_int_venped")
if id_ventana <> -1 then
	close(wtc_mant_pruebas)
	OpenWithParm(w_int_venped, lstr_param)
else
	OpenWithParm(w_int_venped, lstr_param)
end if



end event

event dw_datos::itemfocuschanged;call super::itemfocuschanged;String var_montaje

if dwo.name = "venliped_cantidad" or dwo.name = "cantidad_pzs" then
	this.SelectText(1, 9999)
end if

end event

event dw_datos::itemchanged;call super::itemchanged;if dwo.name = 'venliped_articulo' then
	return 2
else
	if dwo.name = 'cantidad_pzs' then
		//No se pueden cambiar las cantidades gestionadas en pzs
		messagebox("Atención", "No se puede modificar una linea gestionada en pzs") 
		return 2
	else	
		if (isnull(dw_datos.object.orden_carga[row]) or dw_datos.object.orden_carga[row] = '') and this.object.situacion[row] <> 'P' then
			if dec(data) > this.object.venliped_cantidad[row] and this.object.situacion[row] <> 'F' then
				messagebox("Atención", "No se puede incrementar una linea reservada") 
				return 2
			else
				if messagebox("Atención", "Se va a modificar la cantidad del pedido. ¿Desea Continuar?", Exclamation!, YesNo!, 2)  = 1 then
					POST f_post_itemchanged(row, dwo, data)
				end if
			end if
		else	
			return 2  // Deja el valor original
		end if
	end if
end if
end event

event dw_datos::retrieveend;call super::retrieveend;/*
string ls_find
long ll_indice,ll_total,ll_donde
dec  ld_disponible
pointer oldpointer
time lt_inicio,lt_final

lt_inicio = now()

oldpointer = SetPointer(HourGlass!)

this.setredraw(false)

this.setfilter("situacion = 'P'")
this.filter()

ll_total = this.rowcount()

for ll_indice = 1 to ll_total
	this.object.estado_linea[ll_indice] = 50 //Preparado
next

this.setfilter("situacion = 'C'")
this.filter()

ll_total = this.rowcount()

for ll_indice = 1 to ll_total
	this.object.estado_linea[ll_indice] = 40 //Reservado
next

this.setfilter("situacion = 'F'")
this.filter()

ll_total = this.rowcount()

for ll_indice = 1 to ll_total
	
	if this.object.disponible[ll_indice] = -1 then
//		this.object.disponible[ll_indice] = f_disponible_art_cal_to_ca_tp_c( this.object.venliped_empresa[ll_indice] ,&
//																							this.object.venliped_articulo[ll_indice] ,&
//																							this.object.venliped_calidad[ll_indice] ,&
//																							this.object.venliped_tonochar[ll_indice] ,&
//																							this.object.venliped_calibre[ll_indice] ,&
//																							this.object.venliped_tipo_pallet[ll_indice] ,&
//																							this.object.venliped_caja[ll_indice] )

		this.object.disponible_pzs[ll_indice] = f_disponible_art_cal_tp_c_pzs( this.object.venliped_empresa[ll_indice] ,&
																							this.object.venliped_articulo[ll_indice] ,&
																							this.object.venliped_calidad[ll_indice] ,&
																							this.object.venliped_tipo_pallet[ll_indice] ,&
																							this.object.venliped_caja[ll_indice] )

		this.object.disponible[ll_indice] = f_disponible_art_cal_tp_c( this.object.venliped_empresa[ll_indice] ,&
																							this.object.venliped_articulo[ll_indice] ,&
																							this.object.venliped_calidad[ll_indice] ,&
																							this.object.venliped_tipo_pallet[ll_indice] ,&
																							this.object.venliped_caja[ll_indice] )

		if ( this.object.gestionar_en_piezas[ll_indice] = 'N' and this.object.disponible[ll_indice] >= this.object.venliped_cantidad[ll_indice] ) or ( this.object.gestionar_en_piezas[ll_indice] = 'S' and this.object.disponible_pzs[ll_indice] >= this.object.cantidad_pzs[ll_indice] ) then
			this.object.estado_linea[ll_indice] = 30 //Pdte Reservar
		else
			if this.object.planificado[ll_indice] > 0 and isnull(this.object.fecha_fin[ll_indice]) then
				this.object.estado_linea[ll_indice] = 15 //Planificado sin Fecha
			else
				if this.object.planificado[ll_indice] > 0 then
					this.object.estado_linea[ll_indice] = 20 //Planificado
				else
					this.object.estado_linea[ll_indice] = 10 //Rotura Stock
				end if
			end if
			/*
			if isnull(this.object.fecha_fin[ll_indice]) then
				this.object.estado_linea[ll_indice] = 10 //Rotura Stock
			else
				this.object.estado_linea[ll_indice] = 20 //Planificado
			end if
			*/
			
		end if
							
		ls_find = "venliped_articulo = '"+this.object.venliped_articulo[ll_indice]+"' and "+&
					 "venliped_calidad = '"+this.object.venliped_calidad[ll_indice]+"' and "+&
					 "venliped_tipo_pallet = '"+this.object.venliped_tipo_pallet[ll_indice]+"' and "+&
					 "venliped_caja = '"+this.object.venliped_caja[ll_indice]+"' "	
					 
//		ls_find = "venliped_articulo = '"+this.object.venliped_articulo[ll_indice]+"' and "+&
//					 "venliped_calidad = '"+this.object.venliped_calidad[ll_indice]+"' and "+&
//					 "venliped_tonochar = '"+this.object.venliped_tonochar[ll_indice]+"' and "+&
//					 "venliped_calibre = "+string(this.object.venliped_calibre[ll_indice],"0")+" and "+&
//					 "venliped_tipo_pallet = '"+this.object.venliped_tipo_pallet[ll_indice]+"' and "+&
//					 "venliped_caja = '"+this.object.venliped_caja[ll_indice]+"' "
					 
		ll_donde = ll_indice																					
		do
			ll_donde ++
			ll_donde = this.find(ls_find,ll_donde,ll_total)
			if ll_donde > 0 then
				this.object.disponible[ll_donde] = this.object.disponible[ll_indice]
				this.object.disponible_pzs[ll_donde] = this.object.disponible_pzs[ll_indice]
				
				if ( this.object.gestionar_en_piezas[ll_donde] = 'N' and this.object.disponible[ll_donde] >= this.object.venliped_cantidad[ll_donde] ) or ( this.object.gestionar_en_piezas[ll_donde] = 'S' and this.object.disponible_pzs[ll_donde] >= this.object.cantidad_pzs[ll_donde] ) then
					this.object.estado_linea[ll_donde] = 30 //Pdte Reservar
				else
					if this.object.planificado[ll_donde] > 0 and isnull(this.object.fecha_fin[ll_donde]) then
						this.object.estado_linea[ll_donde] = 15 //Planificado sin Fecha
					else
						if this.object.planificado[ll_donde] > 0 then
							this.object.estado_linea[ll_donde] = 20 //Planificado
						else
							this.object.estado_linea[ll_donde] = 10 //Rotura Stock
						end if
					end if

					/*
					if isnull(this.object.fecha_fin[ll_donde]) then
						this.object.estado_linea[ll_donde] = 10 //Rotura Stock
					else
						this.object.estado_linea[ll_donde] = 20 //Planificado
					end if			
					*/
				end if				
			end if
		loop while ll_donde > 0 and ll_donde < ll_total
	end if
next

this.setfilter("")
this.filter()
this.setredraw(true)

SetPointer(oldpointer)

lt_final = now()
messagebox("",string(lt_inicio)+" - "+string(lt_final))

*/

/*

string ls_find
long ll_indice,ll_total,ll_donde
dec  ld_disponible
pointer oldpointer


oldpointer = SetPointer(HourGlass!)

this.setredraw(false)

this.setfilter("situacion = 'P'")
this.filter()

ll_total = this.rowcount()

for ll_indice = 1 to ll_total
	this.object.estado_linea[ll_indice] = 50 //Preparado
next

this.setfilter("situacion = 'C'")
this.filter()

ll_total = this.rowcount()

for ll_indice = 1 to ll_total
	this.object.estado_linea[ll_indice] = 40 //Reservado
next

this.setfilter("situacion = 'F'")
this.filter()

ll_total = this.rowcount()

for ll_indice = 1 to ll_total
	
	if this.object.disponible[ll_indice] = -1 then
		this.object.disponible[ll_indice] = f_disponible_art_cal_to_ca_tp_c( this.object.venliped_empresa[ll_indice] ,&
																							this.object.venliped_articulo[ll_indice] ,&
																							this.object.venliped_calidad[ll_indice] ,&
																							this.object.venliped_tonochar[ll_indice] ,&
																							this.object.venliped_calibre[ll_indice] ,&
																							this.object.venliped_tipo_pallet[ll_indice] ,&
																							this.object.venliped_caja[ll_indice] )

		if this.object.disponible[ll_indice] >= this.object.venliped_cantidad[ll_indice] then
			this.object.estado_linea[ll_indice] = 30 //Pdte Reservar
		else
			if isnull(this.object.fecha_fin[ll_indice]) then
				this.object.estado_linea[ll_indice] = 10 //Rotura Stock
			else
				this.object.estado_linea[ll_indice] = 20 //Planificado
			end if
		end if
																							
		ls_find = "venliped_articulo = '"+this.object.venliped_articulo[ll_indice]+"' and "+&
					 "venliped_calidad = '"+this.object.venliped_calidad[ll_indice]+"' and "+&
					 "venliped_tonochar = '"+this.object.venliped_tonochar[ll_indice]+"' and "+&
					 "venliped_calibre = "+string(this.object.venliped_calibre[ll_indice],"0")+" and "+&
					 "venliped_tipo_pallet = '"+this.object.venliped_tipo_pallet[ll_indice]+"' and "+&
					 "venliped_caja = '"+this.object.venliped_caja[ll_indice]+"' "
					 
		ll_donde = ll_indice																					
		do
			ll_donde ++
			ll_donde = this.find(ls_find,ll_donde,ll_total)
			if ll_donde > 0 then
				this.object.disponible[ll_donde] = this.object.disponible[ll_indice]
				
				if this.object.disponible[ll_donde] >= this.object.venliped_cantidad[ll_donde] then
					this.object.estado_linea[ll_donde] = 30 //Pdte Reservar
				else
					if isnull(this.object.fecha_fin[ll_donde]) then
						this.object.estado_linea[ll_donde] = 10 //Rotura Stock
					else
						this.object.estado_linea[ll_donde] = 20 //Planificado
					end if					
				end if				
			end if
		loop while ll_donde > 0 and ll_donde < ll_total
	end if
next

this.setfilter("")
this.filter()
this.setredraw(true)

SetPointer(oldpointer)
*/
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_pedidos_disponibles_preparacion
integer x = 8393
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_pedidos_disponibles_preparacion
integer width = 3863
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_pedidos_disponibles_preparacion
integer x = 8027
integer y = 8
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_pedidos_disponibles_preparacion
integer x = 1298
integer width = 2802
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_pedidos_disponibles_preparacion
integer x = 2871
integer y = 132
integer taborder = 70
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_pedidos_disponibles_preparacion
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 10
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_pedidos_disponibles_preparacion
integer x = 1307
integer height = 96
integer taborder = 80
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_pedidos_disponibles_preparacion
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_pedidos_disponibles_preparacion
integer x = 1312
integer y = 136
integer width = 695
integer height = 472
integer taborder = 60
long textcolor = 24076881
end type

type dw_imprimir from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 4407
integer y = 28
integer width = 178
integer height = 128
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_report_orden_carga"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_resumen from checkbox within wtc_consulta_pedidos_disponibles_preparacion
integer x = 3666
integer y = 132
integer width = 695
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
string text = "Mostrar Resumen"
end type

event clicked;if this.checked then
	dw_datos.modify("DataWindow.Detail.height=0")
	dw_datos.modify("DataWindow.Header.height=164")
	dw_datos.modify("DataWindow.Trailer.1.height=96")
	dw_datos.modify("separador.visible=0")
	//dw_datos.modify("DataWindow.Trailer.1.height=8")
	//dw_datos.modify("separador.visible=1")
else
	dw_datos.modify("DataWindow.Detail.height=96")
	dw_datos.modify("DataWindow.Header.height=240")
	dw_datos.modify("DataWindow.Trailer.1.height=96")
	dw_datos.modify("separador.visible=0")
	//dw_datos.modify("DataWindow.Trailer.1.height=96")
	//dw_datos.modify("separador.visible=0")
end if

cbx_resumen_pesos.triggerevent("clicked")
end event

type dw_fecha from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 2775
integer y = 600
integer width = 686
integer height = 500
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_fecha_carga_prevista"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;if dwo.name = "b_cerrar" then
	this.visible = false
elseif dwo.name = "b_guardar" then
	if this.update() = 1 then
		commit using sqlca;
	else
		rollback using sqlca;
		messagebox ("Error", "Error Grabando")
	end if
	this.visible = false
end if
end event

type st_1 from statictext within wtc_consulta_pedidos_disponibles_preparacion
integer x = 6939
integer y = 32
integer width = 338
integer height = 112
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Orden Preparación"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within wtc_consulta_pedidos_disponibles_preparacion
integer x = 6592
integer y = 72
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prepacking"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within wtc_consulta_pedidos_disponibles_preparacion
integer x = 6249
integer width = 1714
integer height = 256
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 20722727
long backcolor = 67108864
string text = "Imprimir"
end type

type pb_2 from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
integer x = 6679
integer y = 140
integer width = 137
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Print_24x24.png"
end type

event clicked;integer contador, i
string actual

if dw_datos.rowcount() > 0 then
	if integer(dw_datos.Describe("Evaluate('count(venliped_cliente FOR all DISTINCT)', 0)")) > 1 then
		MessageBox("Error", "Debe elegir un cliente para imprimir su packing list")
		return
	end if
	
	f_guardar(true)
	
	dw_prepacking.retrieve(codigo_empresa, dw_datos.object.venliped_cliente[1])
	contador = 0
	actual = ''
	for i = 1 to dw_prepacking.rowcount()
		if actual <> dw_prepacking.object.numpallet[i] then
			contador = contador +1
			actual = dw_prepacking.object.numpallet[i]
		end if
	next 
	dw_prepacking.object.t_bultos.text = "Bultos: "+string (contador)
	f_imprimir_datawindow(dw_prepacking)
end if
end event

type dw_observaciones_pedidos from datawindow within wtc_consulta_pedidos_disponibles_preparacion
integer x = 5467
integer y = 3048
integer width = 3058
integer height = 564
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_observaciones_pedidos_oc"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cbx_resumen_pesos from checkbox within wtc_consulta_pedidos_disponibles_preparacion
integer x = 4407
integer y = 132
integer width = 987
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
string text = "Mostrar Resumen con pesos"
end type

event clicked;if cbx_resumen.checked then
	if this.checked then
		dw_datos.modify("DataWindow.Trailer.1.height=96")
		dw_datos.modify("separador.visible=0")
	else
		dw_datos.modify("DataWindow.Trailer.1.height=8")
		dw_datos.modify("separador.visible=1")
	end if
end if
end event

type st_3 from statictext within wtc_consulta_pedidos_disponibles_preparacion
integer x = 6235
integer y = 72
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pedidos"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_3 from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
integer x = 6322
integer y = 140
integer width = 137
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Print_24x24.png"
end type

event clicked;if dw_datos.rowcount() > 0 then
	f_guardar(true)
	
	dw_datos.modify("p_fecha.visible = 0")
	if not cbx_imprimir_observaciones.checked then
		dw_datos.modify("venped_observaciones.visible = 0")
	else
			dw_datos.modify("venped_observaciones.visible = 1")
	end if
	
	f_imprimir_datawindow(dw_datos)
	
	dw_datos.modify("p_fecha.visible = 1")
	dw_datos.modify("venped_observaciones.visible = 1")
end if
	
end event

type dw_prepacking from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 4151
integer y = 28
integer width = 219
integer height = 100
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_prepacking_orden_preparacion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_mas_exp from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 5435
integer y = 1548
integer width = 146
integer height = 128
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Add_24x24.png"
end type

event clicked;Long fila 
String expedicion_codigo, cliente


dw_expedicion.settransobject(trans_ts)
fila = dw_expedicion.insertrow(0)


param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "expedicion"
param_colisiones.campo = "codigo"
param_colisiones.filtro = "anyo = "+String(year(today()))
param_colisiones.buscar_huecos = false

expedicion_codigo = String(f_colisiones (trans_ts, param_colisiones))

dw_expedicion.object.empresa[fila] = codigo_empresa
dw_expedicion.object.anyo[fila] = year(today())
dw_expedicion.object.codigo[fila] = expedicion_codigo
dw_expedicion.object.fecha[fila] = datetime(Today(), Now())
dw_expedicion.object.cliente[fila] = cliente_expedicion


rtn = dw_expedicion.update()
if rtn = 1 then
	commit using trans_ts;
else
	rollback using trans_ts;
	MessageBox("SQL error", trans_ts.SQLErrText +" Error inserción en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
end if

dw_expedicion.settransobject(sqlca)

end event

type pb_menos_exp from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 5641
integer y = 1548
integer width = 146
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_minus.png"
end type

event clicked;Long fila, total = 0
Int anyo
String codigo

rtn = 1
dw_expedicion.settransobject(trans_ts)

anyo = dw_expedicion.object.anyo[dw_expedicion.getrow()]
codigo = dw_expedicion.object.codigo[dw_expedicion.getrow()]

SELECT COUNT(*) INTO :total 
FROM orden_carga 
WHERE empresa = :codigo_empresa
AND expedicion_anyo = :anyo 
AND expedicion_codigo = :codigo using trans_ts;

if total > 0 then
	MessageBox("Error", "No se puede borrar una orden de carga que tiene materiales preparados asociados.")
	rtn = -1
else
	if dw_expedicion.deleterow(dw_expedicion.getrow()) <> 1 then
		MessageBox("Error al borrar", "No se ha podido borrar la orden de carga")
		rtn = -1
	else
		rtn = dw_expedicion.update()
		if rtn = -1 then
			MessageBox("SQL error", trans_ts.SQLErrText +" Error inserción en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
		end if
	end if
end if

if rtn = 1 then
	commit using trans_ts;
else
	rollback using trans_ts;
end if

dw_expedicion.settransobject(sqlca)

end event

type st_4 from statictext within wtc_consulta_pedidos_disponibles_preparacion
integer x = 7314
integer y = 32
integer width = 306
integer height = 112
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Orden de Carga"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_4 from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
integer x = 7397
integer y = 136
integer width = 137
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Print_24x24.png"
end type

event clicked;String expedicion_codigo
Int expedicion_anyo 

if dw_orden.rowcount() > 0 then
	expedicion_anyo = dw_orden.object.expedicion_anyo[1]
	expedicion_codigo = dw_orden.object.expedicion_codigo[1]
	
	if dw_oc.retrieve(codigo_empresa, expedicion_anyo, expedicion_codigo) > 0 then
		f_imprimir_datawindow(dw_oc)
	end if
end if
	
end event

type dw_oc from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 4626
integer y = 28
integer width = 219
integer height = 100
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_imprimir_expedicion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_paletizado from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 4882
integer y = 24
integer width = 247
integer height = 108
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_impresion_etiqueta_pallet"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 7534
integer y = 32
integer width = 302
integer height = 112
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proforma Carga"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_5 from picturebutton within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 7616
integer y = 136
integer width = 137
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Print_24x24.png"
end type

event clicked;String expedicion_codigo
Int expedicion_anyo 

if dw_orden.rowcount() > 0 then
	expedicion_anyo = dw_orden.object.expedicion_anyo[1]
	expedicion_codigo = dw_orden.object.expedicion_codigo[1]
	
	if dw_proforma.retrieve(codigo_empresa, expedicion_anyo, expedicion_codigo) > 0 then
		f_imprimir_datawindow(dw_proforma)
	end if
end if
	
end event

type dw_proforma from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 5161
integer y = 24
integer width = 219
integer height = 100
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_imprimir_lineas_pedido"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;Long i = 1, j, fila_descuento, fila_insercion
Int anyo, anyo_anterior = 0
String texto_descuento, texto_incremento
Dec {4} importe, importe_final, descuento, incremento, descuento1, descuento2, descuento3, descuento4, descuentopp, iva, recargo 
Dec pedido, pedido_anterior = 0 

if rowcount <= 0 then
	return
end if

i = 1
importe_final = 0
Do while i <= this.rowcount()
	if i < this.rowcount() then
		anyo = this.object.venliped_anyo[i]
		pedido = this.object.venliped_pedido[i]
	else
		anyo = -1
		pedido = -1
	end if
	
	if i = 1 then
		anyo_anterior = anyo
		pedido_anterior = pedido
	end if
	
	if anyo <> anyo_anterior or  pedido <> pedido_anterior then
		if i < this.rowcount() then
			fila_descuento = i - 1 //La del anterior pedido
			j = i
		else
			fila_descuento = i
			j = i + 1
		end if
		importe = this.object.importe_bruto_total[fila_descuento]
		//Extraemos los descuentos	e insertamos lineas	
		
		descuento1 = this.object.venped_dtoesp1[fila_descuento] 
		descuento2 = this.object.venped_dtoesp2[fila_descuento] 
		descuento3 = this.object.venped_dtoesp3[fila_descuento] 
		descuento4 = this.object.venped_dtoesp4[fila_descuento] 
		descuentopp = this.object.venped_dtopp[fila_descuento] 
		iva = ftc_iva_pedido( codigo_empresa,  anyo_anterior ,  pedido_anterior)
		recargo = ftc_recargo_pedido( codigo_empresa,  anyo_anterior ,  pedido_anterior )
		
		//INSERTAMOS IMPORTE ACUMULADO PEDIDO
		fila_insercion = this.insertrow(j)
		this.object.venliped_anyo[fila_insercion] = anyo_anterior
		this.object.venliped_pedido[fila_insercion] = pedido_anterior
		this.object.venliped_linea[fila_insercion] = 1000 + j
		this.object.importe_linea[fila_insercion] = importe
		this.object.texto_linea[fila_insercion] = "GROSS TOTAL"
		j++
		
		if descuento1 <> 0 then
			fila_insercion = this.insertrow(j)
			
			descuento = round(- 1 * descuento1 / 100 * importe, 2) 
			importe = importe + descuento
			texto_descuento = this.object.venped_explicaciondto1[fila_descuento] + " " + String(descuento1, "###,##0.00") + " %"
			
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.venliped_linea[fila_insercion] = 1000 + j
			this.object.texto_linea[fila_insercion] = texto_descuento
			this.object.descuento_linea[fila_insercion] = descuento
			j++
			
			fila_insercion = this.insertrow(j)
			this.object.importe_linea[fila_insercion] = importe
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.texto_linea[fila_insercion] = " "
			this.object.venliped_linea[fila_insercion] = 1000 + j
			j++
		end if
		
		if descuento2<> 0 then
			fila_insercion = this.insertrow(j)
			
			descuento = round(- 1 * (descuento2 / 100) * importe, 2)
			importe = importe + descuento
			texto_descuento = this.object.venped_explicaciondto2[fila_descuento] + " " + String(descuento2, "###,##0.00") + " %"
			
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.venliped_linea[fila_insercion] = 1000 + j
			this.object.texto_linea[fila_insercion] = texto_descuento
			this.object.descuento_linea[fila_insercion] = descuento
			j++
			
			fila_insercion = this.insertrow(j)
			this.object.importe_linea[fila_insercion] = importe
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.texto_linea[fila_insercion] = " "
			this.object.venliped_linea[fila_insercion] = 1000 + j
			j++
		end if
		
		if descuento3 <> 0 then
			fila_insercion = this.insertrow(j)
			
			descuento = round(- 1 * descuento3 / 100 * importe, 2) 
			importe = importe + descuento
			texto_descuento = this.object.venped_explicaciondto3[fila_descuento] + " " + String(descuento3, "###,##0.00") + " %"
			
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.venliped_linea[fila_insercion] = 1000 + j
			this.object.texto_linea[fila_insercion] = texto_descuento
			this.object.descuento_linea[fila_insercion] = descuento
			j++
			
			fila_insercion = this.insertrow(j)
			this.object.importe_linea[fila_insercion] = importe
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.texto_linea[fila_insercion] = " "
			this.object.venliped_linea[fila_insercion] = 1000 + j
			j++
		end if
		
		if descuento4 <> 0 then
			fila_insercion = this.insertrow(j)
			
			descuento = round(- 1 * descuento4 / 100 * importe, 2) 
			importe = importe + descuento
			texto_descuento = this.object.venped_explicaciondto4[fila_descuento] + " " + String(descuento4, "###,##0.00") + " %"
			
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.venliped_linea[fila_insercion] = 1000 + j
			this.object.texto_linea[fila_insercion] = texto_descuento
			this.object.descuento_linea[fila_insercion] = descuento
			j++
			
			fila_insercion = this.insertrow(j)
			this.object.importe_linea[fila_insercion] = importe
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.texto_linea[fila_insercion] = " "
			this.object.venliped_linea[fila_insercion] = 1000 + j
			j++
		end if
		
		if descuentopp <> 0 then
			fila_insercion = this.insertrow(j)
			
			descuento = round(- 1 * descuentopp / 100 * importe, 2) 
			importe = importe + descuento
			texto_descuento =" Descuento Pronto Pago / Early Payment Discount: " + String(descuentopp, "###,##0.00") + " %"
			
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.venliped_linea[fila_insercion] = 1000 + j
			this.object.texto_linea[fila_insercion] = texto_descuento
			this.object.descuento_linea[fila_insercion] = descuento
			j++
			
			fila_insercion = this.insertrow(j)
			this.object.importe_linea[fila_insercion] = importe
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.texto_linea[fila_insercion] = " "
			this.object.venliped_linea[fila_insercion] = 1000 + j
			j++
		end if
		
		if iva <> 0 then
			fila_insercion = this.insertrow(j)
			
			incremento = round((iva / 100) * importe,2) 
			importe = importe + incremento
			texto_incremento =" IVA / VAT: " + String(incremento, "###,##0.00") + " %"
			
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.venliped_linea[fila_insercion] = 1000 + j
			this.object.texto_linea[fila_insercion] = texto_incremento 
			this.object.descuento_linea[fila_insercion] = incremento
			j++
			
			fila_insercion = this.insertrow(j)
			this.object.importe_linea[fila_insercion] = importe
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.texto_linea[fila_insercion] = " "
			this.object.venliped_linea[fila_insercion] = 1000 + j
			j++
		end if
		
		if recargo <> 0 then
			fila_insercion = this.insertrow(j)
			
			incremento = round((recargo / 100) * importe, 2)
			importe = importe + incremento
			texto_incremento =" Recargo / Surcharge: " + String(incremento, "###,##0.00") + " %"
			
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.venliped_linea[fila_insercion] = 1000 + j
			this.object.texto_linea[fila_insercion] = texto_incremento 
			this.object.descuento_linea[fila_insercion] = incremento
			j++
			
			fila_insercion = this.insertrow(j)
			this.object.importe_linea[fila_insercion] = importe
			this.object.venliped_anyo[fila_insercion] = anyo_anterior
			this.object.venliped_pedido[fila_insercion] = pedido_anterior
			this.object.texto_linea[fila_insercion] = " "
			this.object.venliped_linea[fila_insercion] = 1000 + j
			j++
		end if
		
		importe_final += importe
		anyo_anterior = anyo
		pedido_anterior = pedido	
		
		i = j
		
	else
		i++
	end if
loop

this.object.importe_final[this.rowcount()] = importe_final

end event

type dw_traspaso_pico from u_dw within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 2373
integer y = 1440
integer width = 3003
integer height = 488
integer taborder = 60
boolean bringtotop = true
string dataobject = "dwtc_aux_traspasar_pico"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;
String familia, tipo_unidad, orden, almacen_destino, zona_destino, observaciones_destino, observaciones_nuevas, calidad, tono, tipo_pallet, caja, articulo, formato, unidad_pedido
String almacen_origen, zona_origen
Int fila_alm_origen, altura_origen
String articulos[1]
Int fila_destino, altura_destino, calibre, res
Long i, fila, fila_orden, fila_lineas, fila_origen, fila_origen_material
Dec piezas, cantidad_total, cantidad_origen
Datetime fecha_intr

str_almacenmovimientos movimiento

str_movimiento_almacen lstr_movimiento_almacen

str_ventana_alerta parametros
string botones[2]

//this.triggerevent("itemchanged") //Así recogemos todos los valores cuando se hace click en el botón
this.accepttext()

if dwo.name = "b_cancelar" then
	
	this.visible = false

elseif dwo.name = "b_salida" then 
	
	//this.triggerevent("itemchanged")
	
	//VALIDACIÓN Y RECOGIDA DATOS
	
	articulo = this.object.articulo_codigo[1]
	piezas = this.object.piezas[1]
	
	almacen_destino = this.object.almacen[1]
	zona_destino = upper(this.object.zona[1])
	fila_destino = this.object.fila[1]
	altura_destino = this.object.altura[1]	
	
	tipo_pallet = this.object.tipo_pallet[1]
	caja = this.object.caja[1]		
	formato = this.object.formato[1]
	familia = this.object.familia[1]	
	calidad = this.object.calidad[1]
	tono = this.object.tono[1]
	calibre = this.object.calibre[1]
	
	unidad_pedido = this.object.unidad_pedido[1]
	
	//La salida es desde el origen seleccionado
	almacen_origen = this.object.almacen_origen[1]
	zona_origen = upper(this.object.zona_origen[1])
	fila_origen_material = this.object.fila_origen[1]
	altura_origen = this.object.altura_origen[1]
	
	if isnull(almacen_destino) or trim(almacen_destino) = "" then
		MessageBox("Error","Debe introducir el almacen de destino.")
		return
	end if
	if isnull(zona_destino) or trim(zona_destino) = "" then
		MessageBox("Error","Debe introducir la zona de destino.")
		return
	end if
	if isnull(fila_destino) or fila_destino <= 0 then
		MessageBox("Error","Debe introducir la fila de destino.")
		return
	end if
	if isnull(altura_destino) or altura_destino <= 0 then
		MessageBox("Error","Debe introducir la altura de destino.")
		return
	end if
	if zona_destino = 'P' then
		MessageBox("Error", "No puede reubicar material en el muelle (solo material preparado)")
		return
	end if
	
	rtn = 1
	
	//SALIDA
	if rtn = 1 then
		
		lstr_movimiento_almacen.empresa            = codigo_empresa
		lstr_movimiento_almacen.articulo           = articulo
		lstr_movimiento_almacen.calidad            = calidad
		lstr_movimiento_almacen.tono               = tono
		lstr_movimiento_almacen.calibre            = calibre
		lstr_movimiento_almacen.tipo_pallet        = tipo_pallet
		lstr_movimiento_almacen.caja               = caja
		lstr_movimiento_almacen.cantidad           = piezas * -1
		lstr_movimiento_almacen.orden_carga_anyo   = 0
		lstr_movimiento_almacen.orden_carga_codigo = ""
		lstr_movimiento_almacen.orden_carga_linea  = 0
		lstr_movimiento_almacen.tipo_movimiento    = "102" 
		lstr_movimiento_almacen.observaciones      = ""
		lstr_movimiento_almacen.almacen            = almacen_origen
		lstr_movimiento_almacen.zona               = zona_origen
		lstr_movimiento_almacen.fila               = fila_origen_material
		lstr_movimiento_almacen.altura             = altura_origen
		lstr_movimiento_almacen.tercero            = ""
		lstr_movimiento_almacen.documento          = ""
		lstr_movimiento_almacen.fecha              = datetime(today(),now())
		lstr_movimiento_almacen.id_ubicacion       = 0
		lstr_movimiento_almacen.id_alm_bultos		 = this.object.id_bulto_origen[1]
						
		if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
			rtn = -1
		end if
					
		lstr_movimiento_almacen.empresa            = codigo_empresa
		lstr_movimiento_almacen.articulo           = articulo
		lstr_movimiento_almacen.calidad            = calidad
		lstr_movimiento_almacen.tono               = tono
		lstr_movimiento_almacen.calibre            = calibre
		lstr_movimiento_almacen.tipo_pallet        = tipo_pallet
		lstr_movimiento_almacen.caja               = caja
		lstr_movimiento_almacen.cantidad           = piezas
		lstr_movimiento_almacen.orden_carga_anyo   = 0
		lstr_movimiento_almacen.orden_carga_codigo = ""
		lstr_movimiento_almacen.orden_carga_linea  = 0
		lstr_movimiento_almacen.tipo_movimiento    = "103" 
		lstr_movimiento_almacen.observaciones      = ""
		lstr_movimiento_almacen.almacen            = almacen_destino
		lstr_movimiento_almacen.zona               = zona_destino
		lstr_movimiento_almacen.fila               = fila_destino
		lstr_movimiento_almacen.altura             = altura_destino
		lstr_movimiento_almacen.tercero            = ""
		lstr_movimiento_almacen.documento          = ""
		lstr_movimiento_almacen.fecha              = datetime(today(),now())
		lstr_movimiento_almacen.id_ubicacion       = 0
		lstr_movimiento_almacen.id_alm_bultos		 = this.object.id_bulto_destino[1]
						
		if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
			rtn = -1
		end if
	
	
		/*
		movimiento.empresa = codigo_empresa
		movimiento.fecha_intr = Datetime(Today(), now())
		movimiento.fecha_mov = datetime(Today())
		movimiento.origen = ""
		movimiento.almacen = almacen_origen
		movimiento.zona = zona_origen
		movimiento.fila = fila_origen_material
		movimiento.altura = altura_origen
		movimiento.articulo = articulo
		movimiento.familia = familia
		movimiento.formato = formato
		movimiento.calidad = calidad
		movimiento.tono = tono
		movimiento.calibre = calibre
		movimiento.tipo_pallet = tipo_pallet
		movimiento.caja = caja
		movimiento.cantidade = 0
		movimiento.cantidads = piezas
		movimiento.tipomov = "102"
		movimiento.tipo_unidad = "0"
		movimiento.usuario = nombre_usuario
		movimiento.observaciones = "MOVIMIENTO DE PICO - PREPARACIÓN OP "+orden
		
		res = ftc_movimiento_almacen(movimiento, trans_ts)
		if res <> 0 then
			rtn = -1 
		end if
		
		//ENTRADA A NUEVA UBICACION
		if rtn = 1 then
			movimiento.empresa = codigo_empresa
			movimiento.fecha_intr = Datetime(Today(), now())
			movimiento.fecha_mov = datetime(Today())
			movimiento.origen = ""
			movimiento.almacen = almacen_destino
			movimiento.zona = zona_destino
			movimiento.fila = fila_destino
			movimiento.altura = altura_destino
			movimiento.articulo = articulo
			movimiento.familia = familia
			movimiento.formato = formato
			movimiento.calidad = calidad
			movimiento.tono = tono
			movimiento.calibre = calibre
			movimiento.tipo_pallet = tipo_pallet
			movimiento.caja = caja
			movimiento.cantidade = piezas
			movimiento.cantidads = 0
			movimiento.tipomov = "103" //Despreparación
			movimiento.tipo_unidad = "0"
			movimiento.usuario = nombre_usuario
			movimiento.observaciones = "MOVIMIENTO DE PICO - PREPARACIÓN OP "+orden
			
			res = ftc_movimiento_almacen(movimiento, trans_ts)
			if res <> 0 then
				rtn = -1 
			end if
		end if
		*/
	end if
	
	if rtn = 1 then
		COMMIT USING trans_ts;
		
		dw_stock.retrieve(codigo_empresa, articulo, calidad, tono, calibre, unidad_pedido, tipo_pallet, caja, formato)
		dw_stock.setfilter (" existencias_unidad <> 0 ")
		dw_stock.filter()

	else
		
		ROLLBACK USING trans_ts;
		MessageBox("Error de guardado", "No ha sido posible realizar el guardado. Intentelo de nuevo y si el error se repite, póngase en contacto con el administrador.")
	end if
	
	this.visible = false
	this.reset()
	
end if

end event

event itemchanged;call super::itemchanged;string resultado, almacen, zona
Int fila, altura, res2

this.Accepttext()

if isnull(row) then 
	return
end if 

CHOOSE CASE dwo.name
	CASE "piezas"
		//Vemos sobre que bultos podemos agrupar en la ubicacion destino
		string ls_sel,ls_articulo,ls_calidad,ls_tono,ls_caja,ls_almacen,ls_zona,ls_values
		int    li_calibre,li_fila,li_altura
		long   ll_id_ubicacion,ll_indice,ll_total
		dec    ld_piezas_a_mover
		datastore ds_datos
		
		ld_piezas_a_mover      = dec(data)
		
		ls_almacen = this.object.almacen[row]
		ls_zona    = this.object.zona[row]
		li_fila    = this.object.fila[row]
		li_altura  = this.object.altura[row]
		
		select isnull(almubimapa_codbar.id,0) 
		into  :ll_id_ubicacion
		from  almubimapa_codbar 
		where almubimapa_codbar.empresa = :codigo_empresa
		and   almubimapa_codbar.almacen = :ls_almacen
		and   almubimapa_codbar.zona    = :ls_zona
		and	almubimapa_codbar.fila    = :li_fila
		and	almubimapa_codbar.altura  = :li_altura;
		
		ls_articulo = this.object.articulo_codigo[row]
		ls_calidad  = this.object.calidad[row]
		ls_tono     = this.object.tono[row]
		li_calibre  = this.object.calibre[row]
		ls_caja     = this.object.caja[row]
		
		ls_sel = "SELECT isnull(alm_bultos.id,0) as id, "+&
					"		  sum(alm_bultos_lineas.cantidad) as cantidad "+&
					"FROM   alm_bultos, "+&
					"		  alm_bultos_lineas, "+&
					"		  palarticulo, "+&
					"		  almartcajas "+&
					"WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
					"AND   ( alm_bultos.empresa = palarticulo.empresa ) "+&
					"AND   ( alm_bultos_lineas.articulo = palarticulo.articulo ) "+&
					"AND   ( alm_bultos.tipo_pallet = palarticulo.codigo ) "+&
					"AND   ( alm_bultos_lineas.caja = palarticulo.caja ) "+&
					"AND   ( alm_bultos.empresa = almartcajas.empresa ) "+&
					"AND   ( alm_bultos_lineas.articulo = almartcajas.articulo ) "+&
					"AND   ( alm_bultos_lineas.caja = almartcajas.caja ) "+&
					"AND   ( ( alm_bultos.empresa         = '"+codigo_empresa+"' ) "+&
					"AND     ( alm_bultos.id_ubicacion    = "+string(ll_id_ubicacion,"#########0")+" ) "+&
					"AND     ( alm_bultos_lineas.articulo = '"+ls_articulo+"' ) "+&
					"AND     ( alm_bultos_lineas.calidad  = '"+ls_calidad+"' ) "+&
					"AND     ( alm_bultos_lineas.tono     = '"+ls_tono+"' ) "+&
					"AND     ( alm_bultos_lineas.calibre  = "+string(li_calibre,"0")+" ) "+&
					"AND     ( alm_bultos_lineas.caja     = '"+ls_caja+"' ) ) "+&
					"GROUP BY alm_bultos.id, "+&
					"			 palarticulo.cajaspallet, "+&
					"			 almartcajas.piezascaja "+&
					"HAVING  ( ( isnull( palarticulo.cajaspallet ,0) * isnull( almartcajas.piezascaja ,0) ) - isnull( sum( alm_bultos_lineas.cantidad ) ,0)  >= "+string(ld_piezas_a_mover,"#####0")+" ) "+&
					"ORDER BY alm_bultos.id ASC"
		
		
		if this.object.movemos_todo_el_bulto[row] = 'S' then
			ls_values = "Nuevo~t0/El Mismo~t"+string(this.object.id_bulto_origen[row])+""
		else
			ls_values = "Nuevo~t0"
		end if
		
		ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice = 1 to ll_total
			ls_values += "/"+string(ds_datos.object.id[ll_indice],"0000000000")+" "+string(ds_datos.object.cantidad[ll_indice],"#####0")+"Pzs"+"~t"+string(ds_datos.object.id[ll_indice])
		next
		
		destroy ds_datos
		
		this.Object.id_bulto_destino.Values = ls_values
				
		if this.object.movemos_todo_el_bulto[row] = 'N' then
			//Marcamos generar nuevo bulto
			this.object.id_bulto_destino[row] = 0
		else
			//Marcamos mismo bulto
			this.object.id_bulto_destino[row] = this.object.id_bulto_origen[row]
		end if			
	CASE "almacen"
			SELECT  almalmacen.descripcion
			into :resultado
			FROM almalmacen 
			WHERE empresa = :codigo_empresa
			and almalmacen.codigo = :data;
										
			if SQLCA.sqlcode <> 100 then
				//OK
				this.object.zona[Row] 	= ''
				this.object.fila[Row] 	= 0
				this.object.altura[Row] 	= 0
			else
				this.object.almacen[Row] 	= ''
				this.object.zona[Row] 	= ''
				this.object.fila[Row] 	= 0
				this.object.altura[Row] 	= 0
				return 2			
			end if
			
		CASE "zona"	
			almacen = this.object.almacen[this.GetRow()]

			SELECT almubizonas.descripcion
			into :resultado
			FROM almubizonas 
			WHERE almubizonas.empresa = :codigo_empresa
			and almubizonas.almacen = :almacen
			and almubizonas.zona = :data;
			
			if SQLCA.sqlcode <> 100 then
				//OK
				this.object.fila[Row] 	= 0
				this.object.altura[Row] 	= 0
			else
				this.object.zona[Row] 		= ''
				this.object.fila[Row] 	= 0
				this.object.altura[Row] 	= 0
				return 2			
			end if
			
		CASE "fila"
			almacen = this.object.almacen[this.GetRow()]
			zona = this.object.zona[this.GetRow()]
			fila = Integer(data)
			
			if fila <= 0 then
				this.object.fila[Row] 		= 0
				this.object.altura[Row] 	= 0
				return 2
			else
				SELECT almubimapa.fila_hasta
				into :res2
				FROM almubimapa 
				WHERE almubimapa.empresa = :codigo_empresa
				and almubimapa.almacen = :almacen
				and almubimapa.zona = :zona
				and almubimapa.fila_desde <= :fila AND almubimapa.fila_hasta >= :fila;
				
				if SQLCA.sqlcode <> 100 then
					//OK
					this.object.altura[Row] 	= 0
				else
					this.object.fila[Row] 		= 0
					this.object.altura[Row] 	= 0
					return 2			
				end if
			end if
		CASE "altura"
			almacen = this.object.almacen[this.GetRow()]
			zona = this.object.zona[this.GetRow()]
			altura = Integer(data)
			
			if altura <= 0 then
				this.object.altura[Row] 	= 0
				return 2
			else
				SELECT almubimapa.altura_hasta
				into :res2
				FROM almubimapa 
				WHERE almubimapa.empresa = :codigo_empresa
				and almubimapa.almacen = :almacen
				and almubimapa.zona = :zona
				and almubimapa.altura_desde <= :altura AND almubimapa.altura_hasta >= :altura;
				
				if SQLCA.sqlcode <> 100 then
					//OK
					this.event itemchanged(row,this.object.piezas,string(this.object.piezas[row]))
				else
					this.object.altura[Row] 	= 0
					return 2			
				end if
			end if
END CHOOSE




end event

event usr_dwnkey;call super::usr_dwnkey;string campo, almacen
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
			
		CASE "almacen"
			busqueda.titulo_ventana = "Búsqueda de Almacén"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM almalmacen "+&
										" WHERE empresa = '"+codigo_empresa+"' "+&
										" ORDER BY CONVERT(integer, codigo) "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.almacen[this.GetRow()] 					= resultado.valores[1]		
				this.object.zona[this.GetRow()] 	= ''
				this.object.fila[this.GetRow()] 	= 0
				this.object.altura[this.GetRow()] 	= 0
			end if
			
		CASE "zona"
			almacen = this.object.almacen[this.GetRow()]
			
			busqueda.titulo_ventana = "Búsqueda de Zona"
			busqueda.consulta  = " SELECT zona, descripcion "+&
										" FROM almubizonas "+&
										" WHERE empresa = '"+codigo_empresa+"' AND almacen = '"+almacen+"' "+&
										" ORDER BY zona ASC "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.zona[this.GetRow()] 					= resultado.valores[1]		
				this.object.fila[this.GetRow()] 	= 0
				this.object.altura[this.GetRow()] 	= 0
			end if
			
	END CHOOSE
end if	
end event

type dw_observaciones_pallet from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 5614
integer y = 1148
integer width = 2523
integer height = 608
integer taborder = 60
string title = "none"
string dataobject = "dwtc_aux_observaciones_pallet"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;Int expedicion_anyo
String expedicion_codigo, observaciones
Long numpalet

this.accepttext()

if dwo.name = "b_guardar" then
	expedicion_anyo = this.object.expedicion_anyo[1]
	expedicion_codigo = this.object.expedicion_codigo[1]
	numpalet = this.object.numpalet[1]
	observaciones = this.object.observaciones[1]
	
	UPDATE venliped 
	SET observaciones_pallet = :observaciones 
	WHERE empresa = :codigo_empresa 
	AND numpalet = :numpalet 
	AND EXISTS (	SELECT * 
						FROM orden_carga_linea l 
						INNER JOIN orden_carga o ON l.empresa = o.empresa AND l.anyo = o.anyo AND l.codigo = o.codigo 
						WHERE l.empresa = venliped.empresa 
						AND l.venliped_anyo = venliped.anyo 
						AND l.venliped_pedido = venliped.pedido  
						AND o.expedicion_anyo = :expedicion_anyo  
						AND o.expedicion_codigo = :expedicion_codigo ) using sqlca;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		messagebox ("Error", "Error grabando observaciones del pedido")
	else
		commit using sqlca;
	end if
						
	this.visible = false
elseif dwo.name = "b_cerrar" then
	this.visible = false
end if
end event

type cb_1 from commandbutton within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 5664
integer y = 80
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
string text = "Asignar"
end type

event clicked;long ll_indice,ll_total

ll_total = dw_datos.rowcount()

for ll_indice = 1 to ll_total
	f_mensaje_proceso("",ll_indice,ll_total)
	dw_datos.setrow(ll_indice)
	dw_datos.scrolltorow(ll_indice)
	
	if dw_datos.object.situacion[ll_indice] = 'F' then
		dw_datos.event doubleclicked(0,0,ll_indice,dw_datos.object.c_disponible)
	end if
	
next
end event

type cbx_imprimir_observaciones from checkbox within wtc_consulta_pedidos_disponibles_preparacion
integer x = 5435
integer y = 132
integer width = 805
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
string text = "Imprimir Observaciones"
end type

event clicked;if cbx_resumen.checked then
	if this.checked then
		dw_datos.modify("DataWindow.Trailer.1.height=96")
		dw_datos.modify("separador.visible=0")
	else
		dw_datos.modify("DataWindow.Trailer.1.height=8")
		dw_datos.modify("separador.visible=1")
	end if
end if
end event

type dw_orden from datawindow within wtc_consulta_pedidos_disponibles_preparacion
event usr_dwnkey pbm_dwnkey
integer x = 5472
integer y = 488
integer width = 3058
integer height = 560
integer taborder = 50
string title = "none"
string dataobject = "dwtc_orden_carga"
boolean border = false
boolean livescroll = true
end type

event usr_dwnkey;string campo, almacen, finalizada
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

if dw_orden.getrow()> 0 then
	finalizada = dw_orden.object.finalizada[dw_orden.getrow()]
	if finalizada = 'S' then
		MessageBox("Error", "Una orden finalizada no se puede modificar")
		return
	end if
end if

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
			
		CASE "almacen"
			busqueda.titulo_ventana = "Búsqueda de Almacén"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM almalmacen "+&
										" WHERE empresa = '"+codigo_empresa+"' "+&
										" ORDER BY CONVERT(integer, codigo) "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.almacen_destino[this.GetRow()] 					= resultado.valores[1]		
				this.object.zona_destino[this.GetRow()] 	= ''
				this.object.fila_destino[this.GetRow()] 	= 0
				this.object.altura_destino[this.GetRow()] 	= 0
			end if
			
		CASE "zona"
			almacen = this.object.almacen[this.GetRow()]
			
			busqueda.titulo_ventana = "Búsqueda de Zona"
			busqueda.consulta  = " SELECT zona, descripcion "+&
										" FROM almubizonas "+&
										" WHERE empresa = '"+codigo_empresa+"' AND almacen = '"+almacen+"' "+&
										" ORDER BY zona ASC "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.zona_destino[this.GetRow()] 					= resultado.valores[1]		
				this.object.fila_destino[this.GetRow()] 	= 0
				this.object.altura_destino[this.GetRow()] 	= 0
			end if
			
	END CHOOSE
end if	
end event

event clicked;int newrow
string campo
long numero_valores, total
str_wt_busquedas_salida resultado_busqueda
integer columna

dw_orden.AcceptText()
dw_lineas.AcceptText()

if dwo.name = "p_nuevo" then
	//f_nuevo() //USADO AL SELECCIONAR LINEAS 
elseif dwo.name = "p_imprimir" then
	pb_imprimir.triggerevent(clicked!)
elseif dwo.name = "p_pallet" then
	f_imprimir_documentacion_pallet(0)
elseif dwo.name = "p_buscar" then
	f_buscar("", 0)
elseif dwo.name = "p_grabar" then
	f_guardar(false)
elseif dwo.name = "p_borrar" then
	f_borrar(false)
elseif dwo.name = "p_salir" then
	f_salir()
elseif dwo.name = "b_cambiar" then
	if this.rowcount() <= 0 then
		return
	end if
	dw_expedicion.retrieve(codigo_empresa, this.object.cliente[1])
	dw_expedicion.visible = true
	pb_mas_exp.visible = true
	pb_menos_exp.visible = true
	//HAY QUE DESPREPARAR
	if not isnull(this.object.expedicion_codigo[1]) and this.object.expedicion_codigo[1] <> "" then
		dw_expedicion.modify("p_carga.visible = 0")
	end if
	//VARIABLES DE INSTANCIA QUE REGULAN COMPORTAMIENTO DE dw_expedicion
	modo_expedicion = 2
	cliente_expedicion = this.object.cliente[1]
	
	dw_expedicion.object.t_titulo.text = "Listado Órdenes Carga: "+f_razon_genter(codigo_empresa, "C", cliente_expedicion)
	
elseif dwo.name = "b_fin_sin" then
	f_fin_orden_carga(false)
elseif dwo.name = "b_fin_con" then
	f_fin_orden_carga(true)
end if
end event

event itemchanged;string resultado, almacen, zona, finalizada
Int fila, altura, res2

this.Accepttext()

if isnull(row) or row <= 0 then 
	return
end if 

finalizada = dw_orden.object.finalizada[row]
if finalizada = 'S' then
	MessageBox("Error", "Una orden finalizada no se puede modificar")
	return
end if

CHOOSE CASE dwo.name
		//tipomov - Traspaso
		
	CASE "almacen_destino"
			SELECT  almalmacen.descripcion
			into :resultado
			FROM almalmacen 
			WHERE empresa = :codigo_empresa
			and almalmacen.codigo = :data;
										
			if SQLCA.sqlcode <> 100 then
				//OK
				this.object.zona_destino[Row] 	= ''
				this.object.fila_destino[Row] 	= 0
				this.object.altura_destino[Row] 	= 0
//				this.update()
			else
				this.object.almacen_destino[Row] 	= ''
				this.object.zona_destino[Row] 	= ''
				this.object.fila_destino[Row] 	= 0
				this.object.altura_destino[Row] 	= 0
				return 2			
			end if
			
		CASE "zona_destino"	
			almacen = this.object.almacen_destino[this.GetRow()]

			SELECT almubizonas.descripcion
			into :resultado
			FROM almubizonas 
			WHERE almubizonas.empresa = :codigo_empresa
			and almubizonas.almacen = :almacen
			and almubizonas.zona = :data;
			
			if SQLCA.sqlcode <> 100 then
				//OK
				this.object.fila_destino[Row] 	= 0
				this.object.altura_destino[Row] 	= 0
	//			this.update()
			else
				this.object.zona_destino[Row] 		= ''
				this.object.fila_destino[Row] 	= 0
				this.object.altura_destino[Row] 	= 0
				return 2			
			end if
			
		CASE "fila_destino"
			almacen = this.object.almacen_destino[this.GetRow()]
			zona = this.object.zona_destino[this.GetRow()]
			fila = Integer(data)
			
			if fila <= 0 then
				this.object.fila_destino[Row] 		= 0
				this.object.altura_destino[Row] 	= 0
				return 2
			else
				SELECT almubimapa.fila_hasta
				into :res2
				FROM almubimapa 
				WHERE almubimapa.empresa = :codigo_empresa
				and almubimapa.almacen = :almacen
				and almubimapa.zona = :zona
				and almubimapa.fila_desde <= :fila AND almubimapa.fila_hasta >= :fila;
				
				if SQLCA.sqlcode <> 100 then
					//OK
					this.object.altura_destino[Row] 	= 0
	//				this.update()
				else
					this.object.fila_destino[Row] 		= 0
					this.object.altura_destino[Row] 	= 0
					return 2			
				end if
			end if
		CASE "altura_destino"
			almacen = this.object.almacen_destino[this.GetRow()]
			zona = this.object.zona_destino[this.GetRow()]
			altura = Integer(data)
			
			if altura <= 0 then
				this.object.altura_destino[Row] 	= 0
				return 2
			else
				SELECT almubimapa.altura_hasta
				into :res2
				FROM almubimapa 
				WHERE almubimapa.empresa = :codigo_empresa
				and almubimapa.almacen = :almacen
				and almubimapa.zona = :zona
				and almubimapa.altura_desde <= :altura AND almubimapa.altura_hasta >= :altura;
				
				if SQLCA.sqlcode <> 100 then
					//OK
//					this.update()
				else
					this.object.altura_destino[Row] 	= 0
					return 2			
				end if
			end if
END CHOOSE

this.Accepttext()


end event

type dw_expedicion from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 5376
integer y = 512
integer width = 3063
integer height = 1216
integer taborder = 70
string dataobject = "dwtc_expedicion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;String codigo, cliente
Int anyo

this.accepttext()
if dwo.name = "b_cancelar" then
	dw_expedicion.visible = false
	pb_mas_exp.visible = false
	pb_menos_exp.visible = false
	dw_expedicion.modify("p_carga.visible = 1")
	
	f_salir()
end if
end event

event itemchanged;
if dw_expedicion.update() = 1 then
	commit using sqlca;
else
	rollback using sqlca;
end if


end event

event clicked;String codigo, cliente
Int anyo

if row > 0 then
	if dwo.name = "p_carga" then
		this.accepttext()
		anyo = this.object.anyo[row]
		codigo = this.object.codigo[row]
		cliente = this.object.cliente[row]

		if this.update() = 1 then
			commit using sqlca;
		else
			rollback using sqlca;
		end if
		
		if modo_expedicion = 1 then
			f_nuevo(anyo, codigo, cliente)
			dw_datos.EVENT clicked(-1,0,dw_datos.getrow(), dw_datos.object.venliped_pedido)
		elseif modo_expedicion = 2 then
			dw_orden.accepttext()
			dw_orden.object.expedicion_anyo[1] = anyo
			dw_orden.object.expedicion_codigo[1] = codigo
		end if
		dw_expedicion.visible = false
		pb_mas_exp.visible = false
		pb_menos_exp.visible = false
		dw_expedicion.modify("p_carga.visible = 1")
	end if
end if
end event

event rowfocuschanged;selectrow(0,false)
selectrow(currentrow,true)
end event

type dwtc_reparto_fabricaciones from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 4361
integer y = 588
integer width = 3301
integer height = 2484
integer taborder = 70
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

type dw_lineas from datawindow within wtc_consulta_pedidos_disponibles_preparacion
integer x = 5467
integer y = 1064
integer width = 3063
integer height = 1968
integer taborder = 50
string title = "none"
string dataobject = "dwtc_orden_carga_lineas"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;str_ventana_alerta parametros
string botones[2]
Long fila, linea, i
String articulo, expedicion_codigo, observaciones
Dec numpalet = 0
Int expedicion_anyo,li_total
boolean fallo
string fabricado

this.accepttext()

if row > 0 then
	if dwo.name = "p_info" then
		dw_orden_carga_linea_reservas.setfilter("linea = "+String(this.object.orden_carga_linea_linea[row]))
		dw_orden_carga_linea_reservas.filter()
		dw_orden_carga_linea_reservas.sort()
		
		dw_orden_carga_linea_reservas.visible = true
	elseif dwo.name = "p_pallet" then
		numpalet = this.object.venliped_numpalet[row]
		
		f_imprimir_documentacion_pallet(numpalet)
	elseif dwo.name = "p_observaciones" then
		numpalet = this.object.venliped_numpalet[row]
		expedicion_anyo  = dw_orden.object.expedicion_anyo[dw_orden.getrow()]
		expedicion_codigo = dw_orden.object.expedicion_codigo[dw_orden.getrow()]
		observaciones = ""
		
		SELECT TOP 1 observaciones_pallet INTO :observaciones 
		FROM venliped
		WHERE empresa = :codigo_empresa 
		AND numpalet = :numpalet 
		AND EXISTS (SELECT * 
						FROM orden_carga_linea l 
						INNER JOIN orden_carga o ON l.empresa = o.empresa AND l.anyo = o.anyo AND l.codigo = o.codigo 
						WHERE l.empresa = venliped.empresa 
						AND l.venliped_anyo = venliped.anyo 
						AND l.venliped_pedido = venliped.pedido  
						AND o.expedicion_anyo = :expedicion_anyo  
						AND o.expedicion_codigo = :expedicion_codigo );
		
		dw_observaciones_pallet.reset()
		fila = dw_observaciones_pallet.insertrow(0)
		dw_observaciones_pallet.object.numpalet[fila] = numpalet
		dw_observaciones_pallet.object.expedicion_anyo[fila] = expedicion_anyo
		dw_observaciones_pallet.object.expedicion_codigo[fila] = expedicion_codigo
		dw_observaciones_pallet.object.observaciones[fila] = observaciones
		
		dw_observaciones_pallet.object.t_observaciones.text = "Observaciones del Pallet "+String(numpalet)		
		dw_observaciones_pallet.visible = true
	elseif dwo.name = "p_borrar" then
		articulo = dw_lineas.object.venliped_articulo[row]
		if dw_orden.object.finalizada[dw_orden.getrow()] = 'N' or (isnull(articulo) or articulo = "") then
			linea = dw_lineas.object.orden_carga_linea_linea[row]
			dw_orden_carga_linea_reservas.setfilter("linea = "+String(linea))
			dw_orden_carga_linea_reservas.filter()
			dw_orden_carga_linea_reservas.sort()
			
			li_total = dw_orden_carga_linea_reservas.rowcount()
			
			For i = 1 To li_total
				dw_orden_carga_linea_reservas.deleterow(1)
			next
			
			dw_orden_carga_linea_reservas.setfilter("")
			dw_orden_carga_linea_reservas.filter()
			dw_orden_carga_linea_reservas.sort()
			
			String op_codigo
			Long op_anyo, op_linea
			op_anyo = dw_lineas.object.orden_carga_linea_anyo[row]
			op_codigo = dw_lineas.object.orden_carga_linea_codigo[row]
			op_linea = dw_lineas.object.orden_carga_linea_linea[row]
			
			long venliped_anyo, venliped_pedido, venliped_linea
			venliped_anyo = dw_lineas.object.orden_carga_linea_venliped_anyo[row]
			venliped_pedido = dw_lineas.object.orden_carga_linea_venliped_pedido[row]
			venliped_linea = dw_lineas.object.orden_carga_linea_venliped_linea[row]

			DELETE FROM orden_carga_linea 
			WHERE empresa = :codigo_empresa 
			AND anyo = :op_anyo 
			AND codigo = :op_codigo 
			AND linea = :op_linea using sqlca;
		
			IF SQLCA.SQLCode = -1 THEN         
				MessageBox("SQL error", SQLCA.SQLErrText)
				rollback using sqlca;
				fallo = true
			else 
				//commit using sqlca;
				fallo = false
	
//				i = dw_orden_carga_linea_reservas.rowcount()
//				do while i >= 1 and rtn = 1 
//					rtn = dw_orden_carga_linea_reservas.deleterow(i)
//					
//					i --
//				loop	

	
				//Actualizamos los datos en la dw de lineas (dw_datos)
				long   ll_orden_anyo,ll_donde,anyo_pedido,codigo_pedido,linea_pedido
				string ls_orden_codigo,ls_orden_finalizada,ls_expedicion_anyo,ls_expedicion_codigo,ls_busqueda,ls_null
				datetime ldt_orden_fecha
				
				setnull(ldt_orden_fecha)
					
				anyo_pedido   = venliped_anyo
				codigo_pedido = venliped_pedido
				linea_pedido  = venliped_linea
				
				update venliped 
				set       venliped.situacion = 'C'
				where  venliped.empresa = :codigo_empresa
				and     venliped.anyo = :venliped_anyo
				and     venliped.pedido = :venliped_pedido
				and     venliped.linea = :venliped_linea;				
				
				if sqlca.sqlcode <> 0 then
					rollback;
					fallo = true
				else
					//commit;
				end if
				
				ls_busqueda = "venliped_anyo = "+string(anyo_pedido,"###0")+" and "+&
								  "venliped_pedido = "+string(codigo_pedido,"#######0")+" and "+&
								  "venliped_linea = "+string(linea_pedido,"#######0")
				
				ll_donde = dw_datos.find(ls_busqueda,1,dw_datos.rowcount())
				
				setnull(ls_null)
				
				if ll_donde > 0 then
					dw_datos.object.orden_carga[ll_donde] = ls_null
					dw_datos.object.orden_carga_finalizada[ll_donde] = ls_null
					dw_datos.object.fecha_orden_carga[ll_donde] = ldt_orden_fecha					
					dw_datos.object.codigo_expedicion[ll_donde] = ls_null
				end if
				
				//	
	
				this.deleterow(row)				
				f_guardar (true)

				if this.rowcount() = 0 then
					f_borrar(true) //Borra sin preguntar
				end if
				
			END IF
/*			
			this.deleterow(row)
			f_guardar(true)

			if this.rowcount() = 0 then
				f_borrar(true) //Borra sin preguntar
			end if
*/			
		else			
			parametros.titulo = "Atención"
			parametros.subtitulo = "Borrar Línea Finalizada"
			parametros.mensaje = "La línea está finalizada y deberá indicar donde recolocar el material. ¿Desea continuar?"
			parametros.tipo = 1
			botones[1] = "Sí"
			botones[2] = "No"
			parametros.botones = botones
			parametros.mostrar_imagen = true
			openwithparm(wtc_ventana_alerta, parametros)
			borrar = Int(Message.DoubleParm)
			if borrar = 2 then 
				return
			else
				this.selectrow(0,false)
				this.selectrow(row,true)
				this.enabled = false
			end if
			
			long ll_id_alm_bultos_origen,ll_piezas_a_despreparar
			
			dw_mover.reset()
			fila = dw_mover.insertrow(0)
			
			//Aqui añadimos si se puede despreparar sobre el mismo bulto o no
			linea = dw_lineas.object.orden_carga_linea_linea[row]
			dw_orden_carga_linea_reservas.setfilter("linea = "+String(linea))
			dw_orden_carga_linea_reservas.filter()
			dw_orden_carga_linea_reservas.sort()
			
			if dw_orden_carga_linea_reservas.rowcount() = 1 then
				ll_id_alm_bultos_origen = dw_orden_carga_linea_reservas.object.id_alm_bultos[1]
				
				ll_piezas_a_despreparar = dw_orden_carga_linea_reservas.object.cantidad[1]
				
				//Filtramos para ver la composicion del bulto
				dw_orden_carga_linea_reservas.setfilter("id_alm_bultos = "+String(ll_id_alm_bultos_origen))
				dw_orden_carga_linea_reservas.filter()
				dw_orden_carga_linea_reservas.sort()				
				
				if dw_orden_carga_linea_reservas.rowcount() > 1 then
					//Si el bulto tiene mas de un articulo no dejaremos que el bulto destino sea el mismo
					ll_id_alm_bultos_origen = 0
				end if
				dw_orden_carga_linea_reservas.setfilter("linea = "+String(linea))
				dw_orden_carga_linea_reservas.filter()
				dw_orden_carga_linea_reservas.sort()								
			else
				//Si algun bulto tiene mas de un articulo no dejaremos que el bulto destino sea el mismo
				long    ll_indice,ll_total,ll_lineas_bulto
				boolean lb_bultos_con_varios_articulos = false
				
				ll_total = dw_orden_carga_linea_reservas.rowcount()
				
				for ll_indice = 1 to ll_total
					ll_id_alm_bultos_origen = dw_orden_carga_linea_reservas.object.id_alm_bultos[ll_indice]
					
					ll_lineas_bulto = 0
					
					select isnull(count(*),0)
					into   :ll_lineas_bulto
					from   orden_carga_linea_reservas
					where  orden_carga_linea_reservas.empresa       = :codigo_empresa
					and    orden_carga_linea_reservas.id_alm_bultos = :ll_id_alm_bultos_origen;
					
					if ll_lineas_bulto > 0 then
						lb_bultos_con_varios_articulos = true
					end if
				next
				
				if lb_bultos_con_varios_articulos then
					ll_id_alm_bultos_origen = 0
				else
					ll_id_alm_bultos_origen = ll_id_alm_bultos_origen
				end if
				ll_piezas_a_despreparar = dec(dw_orden_carga_linea_reservas.describe("evaluate('sum(cantidad for all)',1)"))
			end if
			dw_mover.object.articulo[fila]         = this.object.venliped_articulo[row]
			dw_mover.object.calidad[fila]          = this.object.venliped_calidad[row]
			dw_mover.object.tono[fila]             = this.object.venliped_tonochar[row]
			dw_mover.object.calibre[fila]          = this.object.venliped_calibre[row]
			dw_mover.object.caja[fila]             = this.object.venliped_caja[row]
			dw_mover.object.piezas[fila]           = ll_piezas_a_despreparar
			
			dw_mover.object.id_bulto_origen[fila]  = ll_id_alm_bultos_origen
			dw_mover.object.id_bulto_destino[fila] = ll_id_alm_bultos_origen
			dw_mover.visible = true

			dw_mover.event itemchanged(fila,dw_mover.object.piezas,string(dw_mover.object.piezas[fila]))
			dw_mover.visible = true
		end if
	end if
end if


end event

type dw_orden_carga_linea_reservas from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 2363
integer y = 1324
integer width = 2647
integer height = 1596
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_orden_carga_linea_reservas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if dwo.name = "b_cerrar" then
	this.setfilter("")
	this.filter()
	this.visible = false
end if
end event

type dw_stock from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 5230
integer y = 512
integer width = 3214
integer height = 2408
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_stock_disponible_articulo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;Int anyo, pedido_anyo, pedido_linea, fila, altura, calibre
Long fila_dw, maximo_valor_dw, nuevo_codigo, piezas_caja, piezas, maximo_valor_dw2
String empresa, almacen, zona, orden_carga, tipo_pallet, calidad, tono, tipo_unidad, articulo_codigo, articulo_descripcion, caja, formato, familia, unidad_pedido
Dec cantidad_total, cantidad_pedido, pedido_codigo, peso_pallet, num_pallets, cantidad_falta, numpalet, linea_nueva, cantidad_resto, cantidad_origen, metros_caja
Long i,fila_origen 
String pallets_resumido, pallets_descripcion
Boolean preparar_menos = false
str_ventana_alerta parametros
string botones[2],ls_values,ls_gestionar_en_piezas
Int alerta


this.accepttext()

if dwo.name = 'seleccionar_todo' then
	long    ll_indice,ll_total
	
	ll_total = this.rowcount()
	
	for ll_indice = 1 to ll_total
		if this.object.seleccionada[ll_indice] = 0 then
			this.event clicked(0,0,ll_indice,this.object.seleccionada)
			
			if this.object.cantidad[ll_indice] > 0 then
				this.object.seleccionada[ll_indice] = 1
			end if
		end if
	next
end if


if row <= 0 and not isnull(dwo.name) then
	if dwo.name = "b_cerrar" then
		this.visible = false
		this.reset()
		if dw_lineas.rowcount() <= 0 and dw_orden.rowcount() > 0 then
			f_salir()
		end if
	elseif dwo.name = "b_ok" then
		
		//VALIDACIÓN ********************************************************************
		orden_carga = dw_datos.object.orden_carga[dw_datos.getrow()]	
		
		if not isnull(orden_carga) and orden_carga <> "" then
			MessageBox("Error", "La linea indicada ya está en la orden de preparación "+orden_carga)
			return
		end if
		
		if dw_orden.rowcount() <= 0 then
			MessageBox("Error", "Debe buscar o crear una nueva orden de preparación")
			return
		end if
		
		pedido_anyo    = dw_datos.object.venliped_anyo[dw_datos.getrow()]
		pedido_codigo  = dw_datos.object.venliped_pedido[dw_datos.getrow()]
		pedido_linea   = dw_datos.object.venliped_linea[dw_datos.getrow()]
		cantidad_total = 0

		update venliped 
		set    esta_fabricado = 'S'
		where  anyo   = :pedido_anyo
		and    pedido = :pedido_codigo
		and    linea  = :pedido_linea
		using trans_ts;
		
		For i = 1 To this.rowcount()
			if this.object.seleccionada[i] = 1 then
				if this.object.seleccionada[i] >= 0 then 
					cantidad_total = cantidad_total + Dec(this.object.cantidad[i])				
				else
					rollback using trans_ts;					
					MessageBox("Error", "No pueden existir líneas con cantidades negativas")
					return
				end if
			end if
		next
		
		ls_gestionar_en_piezas = dw_datos.object.gestionar_en_piezas[dw_datos.getrow()]
		
		if ls_gestionar_en_piezas = 'S' then
			cantidad_pedido = dw_datos.object.cantidad_pzs[dw_datos.getrow()]
		else
			cantidad_pedido = dw_datos.object.venliped_cantidad[dw_datos.getrow()]
		end if
	
		if cantidad_total <> cantidad_pedido then
			rollback using trans_ts;	
			MessageBox("Error", "La cantidad a mover, debe coincidir con la cantidad del pedido")
			return
		end if
		
		
		//FIN VALIDACIÓN ********************************************************************
		//INSERCIÓN EN ORDEN DE CARGA *******************************************************
		
		maximo_valor_dw = long(dw_lineas.Describe("Evaluate('Max(orden_carga_linea_linea)', 0)"))
		if isnull(maximo_valor_dw) then maximo_valor_dw = 0
		
		//Nuevo control del maximo numero de linea teniendo en cuenta la dw de reservas 22-11-2018
		maximo_valor_dw2 = long(dw_orden_carga_linea_reservas.Describe("Evaluate('Max(linea)', 0)"))
		if isnull(maximo_valor_dw2) then maximo_valor_dw2 = 0
		
		if maximo_valor_dw2 > maximo_valor_dw then maximo_valor_dw2 = maximo_valor_dw 
		
		nuevo_codigo = maximo_valor_dw +1
		
		fila_dw = dw_lineas.insertrow(0)
		
		//dw_lineas.object.orden_carga_linea_empresa[fila] = empresa
		//dw_lineas.object.orden_carga_linea_anyo[fila] = anyo
		//dw_lineas.object.orden_carga_linea_codigo[fila] = orden_carga
		dw_lineas.object.orden_carga_linea_linea[fila_dw] = nuevo_codigo
		
		dw_lineas.object.orden_carga_linea_venliped_anyo[fila_dw]   = pedido_anyo
		dw_lineas.object.orden_carga_linea_venliped_pedido[fila_dw] = pedido_codigo
		dw_lineas.object.orden_carga_linea_venliped_linea[fila_dw]  = pedido_linea

		
		dw_lineas.object.venliped_articulo[fila_dw]     = dw_datos.object.venliped_articulo[dw_datos.getrow()]
		dw_lineas.object.venliped_descripcion[fila_dw]  = dw_datos.object.venliped_descripcion[dw_datos.getrow()]
		dw_lineas.object.genter_razon[fila_dw]          = dw_datos.object.genter_razon[dw_datos.getrow()]
		dw_lineas.object.venliped_cantidad[fila_dw]     = dw_datos.object.venliped_cantidad[dw_datos.getrow()]
		dw_lineas.object.venliped_cantidad_pzs[fila_dw] = dw_datos.object.cantidad_pzs[dw_datos.getrow()]
		dw_lineas.object.venped_cliente[fila_dw]        = dw_datos.object.venliped_cliente[dw_datos.getrow()]
		dw_lineas.object.gestionar_en_piezas[fila_dw]   = dw_datos.object.gestionar_en_piezas[dw_datos.getrow()]
		
		//IMPORTANTE WOW: Se debe separar siempre por bultos. Por tanto, si el pallet está incompleto nº pallets 0 y en el peso bruto, el peso del pallet no está contemplado. 
		//Si el pallet está completo, pallets = 1 y el peso del pallet está contemplado en el peso bruto.
		
		num_pallets         = dw_datos.object.venliped_pallets[dw_datos.getrow()]
		tipo_pallet         = dw_datos.object.venliped_tipo_pallet[dw_datos.getrow()]
		pallets_resumido    = dw_datos.object.pallets_resumido[dw_datos.getrow()]
		pallets_descripcion = dw_datos.object.pallets_descripcion[dw_datos.getrow()]
		tipo_unidad         = dw_datos.object.venliped_tipo_unidad[dw_datos.getrow()]
		piezas_caja         = dw_datos.object.almartcajas_piezascaja[dw_datos.getrow()]
		metros_caja         = dw_datos.object.almartcajas_metroscaja[dw_datos.getrow()]
		
		dw_lineas.object.venliped_pallets[fila_dw]     = num_pallets
		dw_lineas.object.venliped_tipo_pallet[fila_dw] = tipo_pallet
		dw_lineas.object.venliped_numpalet[fila_dw]    = numpalet
		dw_lineas.object.pallets_resumido[fila_dw]     = pallets_resumido
		dw_lineas.object.pallets_descripcion[fila_dw]  = pallets_descripcion
		
		peso_pallet = 0
		
		SELECT peso 
		INTO  :peso_pallet 
		FROM   pallets 
		WHERE  empresa = :codigo_empresa 
		AND    codigo = :tipo_pallet 
		using  SQLCA;		
		
		dw_lineas.object.peso_pallet[fila_dw] = peso_pallet
		
		if num_pallets = 0 then
			dw_lineas.object.venliped_peso[fila_dw] = dw_datos.object.venliped_peso[dw_datos.getrow()]
			dw_lineas.object.orden_carga_linea_pallets_extra[fila_dw] = 0
		else
			dw_lineas.object.venliped_peso[fila_dw] = dw_datos.object.venliped_peso[dw_datos.getrow()]
			dw_lineas.object.orden_carga_linea_pallets_extra[fila_dw] = 0
		end if
		
		//ORIGENES SELECCIONADOS
		dw_orden_carga_linea_reservas.setfilter("")
		dw_orden_carga_linea_reservas.filter()
		dw_orden_carga_linea_reservas.sort()
		
		For i = 1 To this.rowcount()
			if this.object.seleccionada[i] = 1 and this.object.cantidad[i] > 0 then
				almacen = this.object.almacen[i]
				zona    = this.object.zona[i]
				fila    = this.object.fila[i]
				altura  = this.object.altura[i]
				calidad = this.object.almacenmovimientos_calidad[i]
				tono    = this.object.tono[i]
				calibre = this.object.calibre[i]
				
				fila_origen = dw_orden_carga_linea_reservas.insertrow(0)
				
				dw_orden_carga_linea_reservas.object.empresa[fila_origen] = dw_orden.object.empresa[dw_orden.getrow()]
				dw_orden_carga_linea_reservas.object.anyo[fila_origen]    = dw_orden.object.anyo[dw_orden.getrow()]
				dw_orden_carga_linea_reservas.object.codigo[fila_origen]  = dw_orden.object.codigo[dw_orden.getrow()]
				dw_orden_carga_linea_reservas.object.linea[fila_origen]   = nuevo_codigo
				
				dw_orden_carga_linea_reservas.object.almacen[fila_origen] = almacen
				dw_orden_carga_linea_reservas.object.zona[fila_origen]    = zona
				dw_orden_carga_linea_reservas.object.fila[fila_origen]    = fila
				dw_orden_carga_linea_reservas.object.altura[fila_origen]  = altura
				dw_orden_carga_linea_reservas.object.calidad[fila_origen] = calidad
				dw_orden_carga_linea_reservas.object.tono[fila_origen]    = tono
				dw_orden_carga_linea_reservas.object.calibre[fila_origen] = calibre
				
				if tipo_unidad = "1" and piezas_caja <> 0 and ls_gestionar_en_piezas <> "S" then
					//cantidad_origen = int(this.object.cantidad[i] / metros_caja) * piezas_caja
					if this.object.cantidad[i] = this.object.existencias_unidad[i] then
						//Si cogemos toda la cantidad del bulto asignamos directamente el numero de piezas que tenemos en la dw
						cantidad_origen = this.object.existencias[i]
					else
						//Si no cogemos toda la cantidad del bulto calculamos el numero de piezas
						cantidad_origen = truncate((this.object.cantidad[i] / metros_caja) * piezas_caja,0)
					end if
					//cantidad_origen = truncate(this.object.cantidad[i] / metros_caja, 0) * piezas_caja
				else
					cantidad_origen = this.object.cantidad[i]
				end if
				
				dw_orden_carga_linea_reservas.object.cantidad[fila_origen]      = cantidad_origen
				dw_orden_carga_linea_reservas.object.id_alm_bultos[fila_origen] = this.object.alm_bultos_id[i]
			end if
		next
		
		this.visible = false
		this.reset()
		
		//ojo
		f_guardar(true)
/****************************************************************************************************************************************************************/		
/*		date ld_date
		SetNull(ld_date)

		dw_datos.object.situacion[dw_datos.getrow()] = "F" // Lo pongo a F para que no muesre nada en el campo c_disponible. Sólo a nivel visual
		dw_datos.object.fecha_fin[dw_datos.getrow()] = ld_date
		dw_datos.object.venliped_fentrega[dw_datos.getrow()] = ld_date
		dw_datos.object.codigo_expedicion[dw_datos.getrow()] = dw_orden.object.orden_carga[dw_orden.getrow()]
		dw_datos.object.orden_carga[dw_datos.getrow()] = string(dw_orden.object.anyo[dw_orden.getrow()])+"/"+string(dw_orden.object.codigo[dw_orden.getrow()])
		dw_datos.object.fecha_orden_carga[dw_datos.getrow()] = dw_orden.object.fecha[dw_orden.getrow()]
*/
/****************************************************************************************************************************************************************/				
	elseif dwo.name = "t_1" or dwo.name = "t_2" or dwo.name = "t_3" or dwo.name = "t_4" or dwo.name = "t_5" or dwo.name = "t_6" or dwo.name = "t_7" or dwo.name = "t_8" or dwo.name = "t_9" or dwo.name = "t_10" then //ORDENES CABECERAS
		this.setsort("almacen A, zona A, fila A, altura A")
		this.sort()
	elseif dwo.name = "t_existencias" then//ORDENES CABECERAS
		this.setsort("existencias D")
		this.sort()
	end if
else
	if row > 0 then
		if dwo.name = "seleccionada" then
			string ls_unidad_articulo
			//Gestionar pedido en m2 o piezas
			
			ls_unidad_articulo = f_unidad_articulo(codigo_empresa,dw_datos.object.venliped_articulo[dw_datos.getrow()])
			
			if dw_datos.object.gestionar_en_piezas[dw_datos.getrow()] = 'S' then
				cantidad_pedido = dw_datos.object.cantidad_pzs[dw_datos.getrow()]
			else
				cantidad_pedido = dw_datos.object.venliped_cantidad[dw_datos.getrow()]
			end if
			
			cantidad_falta = 0
			cantidad_total = 0
			For i = 1 To this.rowcount()
				if i <> row and this.object.seleccionada[i] = 1 then
					cantidad_total = cantidad_total + this.object.cantidad[i]
				end if
			next
			cantidad_falta = cantidad_pedido - cantidad_total
			
			if cantidad_falta < 0 then
				cantidad_falta = 0
			end if
			
			if dw_datos.object.gestionar_en_piezas[dw_datos.getrow()] = this.object.gestionar_en_piezas[row] or ( ls_unidad_articulo <> '1' ) then
				if cantidad_falta <= dec(this.object.existencias_unidad[row]) then
					this.object.cantidad[row] = cantidad_falta
				else
					this.object.cantidad[row] = dec(this.object.existencias_unidad[row])
				end if
			else
				this.object.cantidad[row] = 0
			end if
			//this.setfocus()
			//this.Setrow(row)
			//this.scrolltorow(fila)
	  		this.SetColumn("cantidad")
		elseif dwo.name = "b_pico" then
			articulo_codigo = this.object.articulo[row]
			articulo_descripcion = this.object.articulos_descripcion[row]
			piezas = this.object.pico[row]
			caja = this.object.almacenmovimientos_caja[row]
			tipo_pallet = this.object.almacenmovimientos_tipo_pallet[row]
			formato = this.object.almacenmovimientos_formato[row]
			calidad = this.object.almacenmovimientos_calidad[row]
			tono = this.object.tono[row]
			calibre = this.object.calibre[row]
			almacen = this.object.almacen[row]
			zona = this.object.zona[row]
			fila_origen = this.object.fila[row]
			altura = this.object.altura[row]
			unidad_pedido = this.object.unidad_pedido[row]
			
//			SELECT familia INTO :familia 
//			FROM articulos 
//			WHERE empresa = :codigo_empresa AND codigo = :articulo_codigo;
			
			if piezas > 0 then
				dw_traspaso_pico.reset()
				fila = dw_traspaso_pico.insertrow(0)
				
				dw_traspaso_pico.object.articulo_codigo[fila] = articulo_codigo
				dw_traspaso_pico.object.articulo_descripcion[fila] = articulo_descripcion
				dw_traspaso_pico.object.piezas[fila] = piezas
				dw_traspaso_pico.object.caja[fila] = caja
				dw_traspaso_pico.object.tipo_pallet[fila] = tipo_pallet
				dw_traspaso_pico.object.calidad[fila] = calidad
				dw_traspaso_pico.object.tono[fila] = tono
				dw_traspaso_pico.object.calibre[fila] = calibre
				dw_traspaso_pico.object.formato[fila] = formato
				dw_traspaso_pico.object.almacen_origen[fila] = almacen
				dw_traspaso_pico.object.zona_origen[fila] = zona
				dw_traspaso_pico.object.fila_origen[fila] = fila_origen
				dw_traspaso_pico.object.altura_origen[fila] = altura
				dw_traspaso_pico.object.unidad_pedido[fila] = unidad_pedido
				dw_traspaso_pico.object.id_bulto_origen[fila]  = this.object.alm_bultos_id[row]
				
				if this.object.pico[row] = this.object.existencias[row] then
					dw_traspaso_pico.object.id_bulto_destino[fila] = this.object.alm_bultos_id[row]
					dw_traspaso_pico.object.movemos_todo_el_bulto[fila] = 'S'
					
					ls_values = "Nuevo~t0/El Mismo~t"+string(dw_traspaso_pico.object.id_bulto_destino[fila])+""																					
					dw_traspaso_pico.Object.id_bulto_destino.Values = ls_values					
					
				else
					dw_traspaso_pico.object.id_bulto_destino[fila] = 0
					dw_traspaso_pico.object.movemos_todo_el_bulto[fila] = 'N'
					
					ls_values = "Nuevo~t0"
					dw_traspaso_pico.Object.id_bulto_destino.Values = ls_values					
				end if
				
				dw_traspaso_pico.visible = true
			end if
		end if
	end if
end if

this.accepttext()
end event

event itemchanged;this.accepttext()
if row > 0 then
	if dwo.name = "cantidad" then
		if this.object.cantidad[row] > this.object.existencias_unidad[row] then
			dwo.Primary[row] = this.object.existencias_unidad[row]
			return 2
		elseif this.object.cantidad[row] < 0 then
			dwo.Primary[row] = 0
			return 2
		end if		
	end if
end if
end event

type cb_faltas_promocion from commandbutton within wtc_consulta_pedidos_disponibles_preparacion
integer x = 2203
integer y = 112
integer width = 727
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Faltas Almacén Promoción"
end type

event clicked;dw_faltas_almacen_promocion.settransobject(sqlca)

if dw_faltas_almacen_promocion.retrieve(codigo_empresa) > 0 then
	u_imprimir u_imp
	u_imp = create u_imprimir
	u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
	u_imp.isTitulo    = this.text
	u_imp.isSubTitulo = ""
	u_imp.ibLandscape = false
	parent.OpenUserObject(u_imp.report)
	
	u_imp.event ue_imprimir(dw_faltas_almacen_promocion)
	
	destroy u_imp

else
	
end if
/*
SELECT isnull(articulos.codigo,'') as codigo,   
		 isnull(articulos.descripcion,'') as articulo,   
		 isnull(calidades.abreviado,'') as Cl,   
		 convert(decimal(2,0),almartcajas.piezascaja) as piezascaja,   
		 convert(decimal(5,3),almartcajas.metroscaja) as metroscaja,   
		 convert(decimal(12,0),sum(venliped.cantidad_pzs)) as pzs_pedidos,   
		 convert(decimal(12,0),( select isnull(sum(alm_bultos_lineas.cantidad),0) 
									    from  alm_bultos_lineas,
											    alm_bultos,   
											    almubimapa_codbar 
									    where ( alm_bultos_lineas.id_alm_bultos = alm_bultos.id ) 
									    and   ( alm_bultos.id_ubicacion = almubimapa_codbar.id ) 
									    and   ( venliped.empresa = alm_bultos_lineas.empresa )
									    and   ( articulos.codigo = alm_bultos_lineas.articulo )
									    and   ( venliped.calidad = alm_bultos_lineas.calidad )
									    and   ( venliped.caja = alm_bultos_lineas.caja )
									    and   ( almubimapa_codbar.gestionar_en_piezas = 'S' ) ) ) as pzs_almacen_promocion  
FROM   venliped,
		 ventipolin,   
		 articulos,   
		 calidades,   
		 almartcajas 
WHERE ( venliped.empresa = ventipolin.empresa ) 
AND   ( venliped.tipolinea = ventipolin.codigo ) 
AND   ( venliped.empresa = articulos.empresa ) 
AND   ( venliped.articulo = articulos.codigo ) 
AND   ( venliped.empresa = calidades.empresa ) 
AND   ( venliped.calidad = calidades.codigo ) 
AND   ( venliped.empresa = almartcajas.empresa ) 
AND   ( venliped.articulo = almartcajas.articulo ) 
AND   ( venliped.caja = almartcajas.caja ) 
AND   ( ( venliped.empresa = '1' ) 
AND   ( ventipolin.gestionar_en_piezas = 'S' ) )
GROUP BY venliped.empresa,
			articulos.codigo,   
         articulos.descripcion,   
			venliped.calidad,
         calidades.abreviado,   
			venliped.caja,
         almartcajas.piezascaja,   
         almartcajas.metroscaja ;
*/
end event

type dw_faltas_almacen_promocion from datawindow within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 2578
integer width = 1463
integer height = 444
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_faltas_almacen_promocion"
boolean border = false
boolean livescroll = true
end type

type dw_mover from u_dw within wtc_consulta_pedidos_disponibles_preparacion
boolean visible = false
integer x = 2373
integer y = 1932
integer width = 3003
integer height = 356
integer taborder = 50
boolean bringtotop = true
string dataobject = "dwtc_aux_restablecer_salida"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;
String familia, tipo_unidad, orden, almacen_destino, zona_destino, observaciones_destino, observaciones_nuevas, calidad, tono, tipo_pallet, caja, articulo, formato
String almacen_origen, zona_origen
Int fila_alm_origen, altura_origen
String articulos[1]
Int fila_destino, altura_destino, calibre, res
Long i, fila, fila_orden, fila_lineas, fila_origen, fila_origen_material
Dec piezas, cantidad_total, cantidad_origen
Datetime fecha_intr

str_almacenmovimientos movimiento

str_ventana_alerta parametros
string botones[2]
str_movimiento_almacen lstr_movimiento_almacen
			
//this.triggerevent("itemchanged") //Así recogemos todos los valores cuando se hace click en el botón
this.accepttext()

if dwo.name = "b_cancelar" then
	dw_lineas.selectrow(0,false)
	dw_lineas.enabled = true
	
	this.visible = false

elseif dwo.name = "b_salida" then 
	
	//this.triggerevent("itemchanged")
	
	//VALIDACIÓN Y RECOGIDA DATOS
	
	fila_lineas = dw_lineas.getrow()
	fila_orden = dw_orden.getrow()
	
	articulo = dw_lineas.object.venliped_articulo[fila_lineas]
	
	almacen_destino = this.object.almacen[1]
	zona_destino = upper(this.object.zona[1])
	fila_destino = this.object.fila[1]
	altura_destino = this.object.altura[1]	
	
	orden = String(dw_orden.object.anyo[fila_orden]) + "/"+dw_orden.object.codigo[fila_orden]
	
	tipo_pallet = dw_lineas.object.venliped_tipo_pallet[fila_lineas]
	caja = dw_lineas.object.venliped_caja[fila_lineas]	
	formato = dw_lineas.object.venliped_formato[fila_lineas]
	familia = dw_lineas.object.venliped_familia[fila_lineas]	
	
//	formato = ""
//	familia = ""
//	SELECT formato, familia INTO :formato, :familia
//	FROM articulos 
//	WHERE empresa = :codigo_empresa AND codigo = :articulo;	
	
	//La salida es desde el muelle
	almacen_origen = dw_orden.object.almacen_destino[fila_orden]
	zona_origen = upper(dw_orden.object.zona_destino[fila_orden])
	fila_origen_material = dw_orden.object.fila_destino[fila_orden]
	altura_origen = dw_orden.object.altura_destino[fila_orden]
	
	if isnull(almacen_destino) or trim(almacen_destino) = "" then
		MessageBox("Error","Debe introducir el almacen de destino.")
		return
	end if
	if isnull(zona_destino) or trim(zona_destino) = "" then
		MessageBox("Error","Debe introducir la zona de destino.")
		return
	end if
	if isnull(fila_destino) or fila_destino <= 0 then
		MessageBox("Error","Debe introducir la fila de destino.")
		return
	end if
	if isnull(altura_destino) or altura_destino <= 0 then
		MessageBox("Error","Debe introducir la altura de destino.")
		return
	end if
	if zona_destino = 'P' then
		MessageBox("Error", "No puede reubicar material en el muelle (solo material preparado)")
		return
	end if
	
	rtn = 1
	
	//SALIDA DE P
	if rtn = 1 then
		fila_origen = 1
		cantidad_total = 0
		dw_orden_carga_linea_reservas.setfilter("anyo = "+String(dw_lineas.object.orden_carga_linea_anyo[fila_lineas])+" and codigo = '"+dw_lineas.object.orden_carga_linea_codigo[fila_lineas]+"' and linea = "+String(dw_lineas.object.orden_carga_linea_linea[fila_lineas]))
		dw_orden_carga_linea_reservas.filter()
		dw_orden_carga_linea_reservas.sort()
		
		do while fila_origen <= dw_orden_carga_linea_reservas.rowcount() and rtn = 1
			//Aqui cambiamos a la nueva gestion de movimientos
			
			tono    = dw_orden_carga_linea_reservas.object.tono[fila_origen]
			calibre = dw_orden_carga_linea_reservas.object.calibre[fila_origen]
			calidad = dw_orden_carga_linea_reservas.object.calidad[fila_origen]						
			
			lstr_movimiento_almacen.empresa            = codigo_empresa
			lstr_movimiento_almacen.articulo           = articulo
			lstr_movimiento_almacen.calidad            = calidad
			lstr_movimiento_almacen.tono               = tono
			lstr_movimiento_almacen.calibre            = calibre
			lstr_movimiento_almacen.tipo_pallet        = tipo_pallet
			lstr_movimiento_almacen.caja               = caja
			lstr_movimiento_almacen.cantidad           = (dw_orden_carga_linea_reservas.object.cantidad[fila_origen] * -1)
			lstr_movimiento_almacen.orden_carga_anyo   = dw_orden.object.anyo[fila_orden]
			lstr_movimiento_almacen.orden_carga_codigo = dw_orden.object.codigo[fila_orden]
			lstr_movimiento_almacen.orden_carga_linea  = dw_lineas.object.orden_carga_linea_linea[fila_lineas]
			lstr_movimiento_almacen.tipo_movimiento    = "204" //Salida Preparación
			lstr_movimiento_almacen.observaciones      = ""
			lstr_movimiento_almacen.almacen            = dw_orden_carga_linea_reservas.object.almacen[fila_origen]
			lstr_movimiento_almacen.zona               = dw_orden_carga_linea_reservas.object.zona[fila_origen]
			lstr_movimiento_almacen.fila               = dw_orden_carga_linea_reservas.object.fila[fila_origen]
			lstr_movimiento_almacen.altura             = dw_orden_carga_linea_reservas.object.altura[fila_origen]
			lstr_movimiento_almacen.tercero            = ""
			lstr_movimiento_almacen.documento          = ""
			lstr_movimiento_almacen.fecha              = datetime(today(),now())
			lstr_movimiento_almacen.id_ubicacion       = 0
			lstr_movimiento_almacen.id_alm_bultos		 = dw_orden_carga_linea_reservas.object.id_alm_bultos[fila_origen]
							
			if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
				rtn = -1
			end if
						
			lstr_movimiento_almacen.empresa            = codigo_empresa
			lstr_movimiento_almacen.articulo           = articulo
			lstr_movimiento_almacen.calidad            = calidad
			lstr_movimiento_almacen.tono               = tono
			lstr_movimiento_almacen.calibre            = calibre
			lstr_movimiento_almacen.tipo_pallet        = tipo_pallet
			lstr_movimiento_almacen.caja               = caja
			lstr_movimiento_almacen.cantidad           = dw_orden_carga_linea_reservas.object.cantidad[fila_origen]
			lstr_movimiento_almacen.orden_carga_anyo   = 0
			lstr_movimiento_almacen.orden_carga_codigo = ""
			lstr_movimiento_almacen.orden_carga_linea  = 0
			lstr_movimiento_almacen.tipo_movimiento    = "207" //Despreparación
			lstr_movimiento_almacen.observaciones      = ""
			lstr_movimiento_almacen.almacen            = this.object.almacen[1]
			lstr_movimiento_almacen.zona               = this.object.zona[1]
			lstr_movimiento_almacen.fila               = this.object.fila[1]
			lstr_movimiento_almacen.altura             = this.object.altura[1]
			lstr_movimiento_almacen.tercero            = ""
			lstr_movimiento_almacen.documento          = ""
			lstr_movimiento_almacen.fecha              = datetime(today(),now())
			lstr_movimiento_almacen.id_ubicacion       = 0
			//Esto lo hacemos para poder gestionar lineas con varios pallets
			//De momento siempre creamos bulto nuevo
			/*
			if this.object.id_bulto_origen[1] = this.object.id_bulto_destino[1] then
				lstr_movimiento_almacen.id_alm_bultos   = dw_orden_carga_linea_reservas.object.id_alm_bultos[fila_origen]
			else
				lstr_movimiento_almacen.id_alm_bultos   = this.object.id_bulto_destino[1]
			end if
			*/
			
			lstr_movimiento_almacen.id_alm_bultos   = 0	
			
			if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
				rtn = -1
			end if
			
			fila_origen++
			/*
//			almacen_origen = dw_orden_carga_linea_reservas.object.almacen[fila_origen]
//			zona_origen = dw_orden_carga_linea_reservas.object.zona[fila_origen]
//			fila_origen_material = dw_orden_carga_linea_reservas.object.fila[fila_origen]
//			altura_origen = dw_orden_carga_linea_reservas.object.altura[fila_origen]
			cantidad_origen = dw_orden_carga_linea_reservas.object.cantidad[fila_origen]
			cantidad_total = cantidad_total + cantidad_origen
			
			calidad = dw_orden_carga_linea_reservas.object.calidad[fila_origen]
			tono = dw_orden_carga_linea_reservas.object.tono[fila_origen]
			calibre = dw_orden_carga_linea_reservas.object.calibre[fila_origen]
			
			movimiento.empresa = codigo_empresa
			movimiento.fecha_intr = Datetime(Today(), now())
			movimiento.fecha_mov = Today()
			movimiento.origen = ""
			movimiento.almacen = almacen_origen
			movimiento.zona = zona_origen
			movimiento.fila = fila_origen_material
			movimiento.altura = altura_origen
			movimiento.articulo = articulo
			movimiento.familia = familia
			movimiento.formato = formato
			movimiento.calidad = calidad
			movimiento.tono = tono
			movimiento.calibre = calibre
			movimiento.tipo_pallet = tipo_pallet
			movimiento.caja = caja
			movimiento.cantidade = 0
			movimiento.cantidads = cantidad_origen
			movimiento.tipomov = "204"
			movimiento.tipo_unidad = "0"
			movimiento.usuario = nombre_usuario
			movimiento.observaciones = "DESPREPARACIÓN ORDEN "+orden
			
			res = ftc_movimiento_almacen(movimiento, trans_ts)
			if res <> 0 then
				rtn = -1 
			end if
			
			//ENTRADA A NUEVA UBICACION
			if rtn = 1 then
				movimiento.empresa = codigo_empresa
				movimiento.fecha_intr = Datetime(Today(), now())
				movimiento.fecha_mov = Today()
				movimiento.origen = ""
				movimiento.almacen = almacen_destino
				movimiento.zona = zona_destino
				movimiento.fila = fila_destino
				movimiento.altura = altura_destino
				movimiento.articulo = articulo
				movimiento.familia = familia
				movimiento.formato = formato
				movimiento.calidad = calidad
				movimiento.tono = tono
				movimiento.calibre = calibre
				movimiento.tipo_pallet = tipo_pallet
				movimiento.caja = caja
				movimiento.cantidade = cantidad_origen
				movimiento.cantidads = 0
				movimiento.tipomov = "207" //Despreparación
				movimiento.tipo_unidad = "0"
				movimiento.usuario = nombre_usuario
				movimiento.observaciones = "DESPREPARACIÓN ORDEN "+orden
				
				res = ftc_movimiento_almacen(movimiento, trans_ts)
				if res <> 0 then
					rtn = -1 
				end if
			end if
			
			fila_origen++
			*/
		loop 		
		
		i = dw_orden_carga_linea_reservas.rowcount()
		do while i >= 1 and rtn = 1 
			rtn = dw_orden_carga_linea_reservas.deleterow(i)
			
			i --
		loop
		
		dw_orden_carga_linea_reservas.setfilter("")
		dw_orden_carga_linea_reservas.filter()
		dw_orden_carga_linea_reservas.sort()
		
	end if
	
	
	if rtn = 1 then
		//NO VA EL UPDATE DEL DATAWINDOW - PROBAMOS MANUAL
		String op_codigo
		int  li_anyo_pedido
		Long op_anyo, op_linea,ll_pedido,ll_linea_pedido
		op_anyo = dw_lineas.object.orden_carga_linea_anyo[fila_lineas]
		op_codigo = dw_lineas.object.orden_carga_linea_codigo[fila_lineas]
		op_linea = dw_lineas.object.orden_carga_linea_linea[fila_lineas]
		
		SELECT venliped_anyo,
				 venliped_pedido,
				 venliped_linea 
		INTO   :li_anyo_pedido,
				 :ll_pedido,
				 :ll_linea_pedido
		FROM orden_carga_linea 
		WHERE empresa = :codigo_empresa 
		AND anyo = :op_anyo 
		AND codigo = :op_codigo 
		AND linea = :op_linea;		
		
		UPDATE venliped
		SET    situacion = 'C'
		WHERE  empresa = :codigo_empresa 
		AND    anyo    = :li_anyo_pedido 
		AND    pedido  = :ll_pedido 
		AND    linea   = :ll_linea_pedido 		
		USING trans_ts;
		
		if trans_ts.sqlcode = 0 then
			DELETE FROM orden_carga_linea 
			WHERE empresa = :codigo_empresa 
			AND anyo = :op_anyo 
			AND codigo = :op_codigo 
			AND linea = :op_linea 
			USING trans_ts;
			
			if trans_ts.sqlcode = 0 then
				commit;
				COMMIT USING trans_ts;
				
				//Actualizamos los datos en la dw de lineas (dw_datos)
				long   ll_orden_anyo,ll_donde,anyo_pedido,codigo_pedido,linea_pedido
				string ls_orden_codigo,ls_orden_finalizada,ls_expedicion_anyo,ls_expedicion_codigo,ls_busqueda,ls_null
				datetime ldt_orden_fecha
				
				setnull(ldt_orden_fecha)
					
				anyo_pedido   = li_anyo_pedido
				codigo_pedido = ll_pedido
				linea_pedido  = ll_linea_pedido
				
				ls_busqueda = "venliped_anyo = "+string(anyo_pedido,"###0")+" and "+&
								  "venliped_pedido = "+string(codigo_pedido,"#######0")+" and "+&
								  "venliped_linea = "+string(linea_pedido,"#######0")
				
				ll_donde = dw_datos.find(ls_busqueda,1,dw_datos.rowcount())
				
				setnull(ls_null)
				
				if ll_donde > 0 then
					dw_datos.object.orden_carga[ll_donde] = ls_null
					dw_datos.object.orden_carga_finalizada[ll_donde] = ls_null
					dw_datos.object.fecha_orden_carga[ll_donde] = ldt_orden_fecha					
					dw_datos.object.codigo_expedicion[ll_donde] = ls_null
				end if
				
				//					
				
				dw_lineas.deleterow(fila_lineas)
								
				f_guardar(true)
			else
				rollback;
				ROLLBACK using trans_ts;				
				MessageBox("Error de guardado", "No ha sido posible realizar el guardado. Intentelo de nuevo y si el error se repite, póngase en contacto con el administrador.")
			end if

		else
			rollback;
			ROLLBACK using trans_ts;
			MessageBox("Error de guardado", "No ha sido posible realizar el guardado. Intentelo de nuevo y si el error se repite, póngase en contacto con el administrador.")
		end if		
						
	else
		rollback;
		ROLLBACK USING trans_ts;
		MessageBox("Error de guardado", "No ha sido posible realizar el guardado. Intentelo de nuevo y si el error se repite, póngase en contacto con el administrador.")
		f_buscar(padre_codigo, anyo_padre_codigo)

	end if
	
	dw_lineas.selectrow(0,false)
	dw_lineas.enabled = true
	
	this.visible = false
	
	this.object.almacen[1] 	= ''
	this.object.zona[1] 	= ''
	this.object.fila[1] 	= 0
	this.object.altura[1] 	= 0
	this.reset()
	
end if

end event

event itemchanged;call super::itemchanged;string resultado, almacen, zona
Int fila, altura, res2

//this.Accepttext()

if isnull(row) or row = 0 or row > this.rowcount() then 
	return
end if 

CHOOSE CASE dwo.name
	CASE "piezas"
		//Vemos sobre que bultos podemos agrupar en la ubicacion destino
		string ls_sel,ls_articulo,ls_calidad,ls_tono,ls_caja,ls_almacen,ls_zona,ls_values
		int    li_calibre,li_fila,li_altura
		long   ll_id_ubicacion,ll_indice,ll_total
		dec    ld_piezas_a_mover
		datastore ds_datos
		
		ld_piezas_a_mover      = dec(data)
		
		ls_almacen = this.object.almacen[row]
		ls_zona    = this.object.zona[row]
		li_fila    = this.object.fila[row]
		li_altura  = this.object.altura[row]
		
		select isnull(almubimapa_codbar.id,0) 
		into  :ll_id_ubicacion
		from  almubimapa_codbar 
		where almubimapa_codbar.empresa = :codigo_empresa
		and   almubimapa_codbar.almacen = :ls_almacen
		and   almubimapa_codbar.zona    = :ls_zona
		and	almubimapa_codbar.fila    = :li_fila
		and	almubimapa_codbar.altura  = :li_altura;
		
		ls_articulo = this.object.articulo[row]
		ls_calidad  = this.object.calidad[row]
		ls_tono     = this.object.tono[row]
		li_calibre  = this.object.calibre[row]
		ls_caja     = this.object.caja[row]
		
		ls_sel = "SELECT isnull(alm_bultos.id,0) as id, "+&
					"		  sum(alm_bultos_lineas.cantidad) as cantidad "+&
					"FROM   alm_bultos, "+&
					"		  alm_bultos_lineas, "+&
					"		  palarticulo, "+&
					"		  almartcajas "+&
					"WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
					"AND   ( alm_bultos.empresa = palarticulo.empresa ) "+&
					"AND   ( alm_bultos_lineas.articulo = palarticulo.articulo ) "+&
					"AND   ( alm_bultos.tipo_pallet = palarticulo.codigo ) "+&
					"AND   ( alm_bultos_lineas.caja = palarticulo.caja ) "+&
					"AND   ( alm_bultos.empresa = almartcajas.empresa ) "+&
					"AND   ( alm_bultos_lineas.articulo = almartcajas.articulo ) "+&
					"AND   ( alm_bultos_lineas.caja = almartcajas.caja ) "+&
					"AND   ( ( alm_bultos.empresa         = '"+codigo_empresa+"' ) "+&
					"AND     ( alm_bultos.id_ubicacion    = "+string(ll_id_ubicacion,"#########0")+" ) "+&
					"AND     ( alm_bultos_lineas.articulo = '"+ls_articulo+"' ) "+&
					"AND     ( alm_bultos_lineas.calidad  = '"+ls_calidad+"' ) "+&
					"AND     ( alm_bultos_lineas.tono     = '"+ls_tono+"' ) "+&
					"AND     ( alm_bultos_lineas.calibre  = "+string(li_calibre,"0")+" ) "+&
					"AND     ( alm_bultos_lineas.caja     = '"+ls_caja+"' ) ) "+&
					"GROUP BY alm_bultos.id, "+&
					"			 palarticulo.cajaspallet, "+&
					"			 almartcajas.piezascaja "+&
					"HAVING  ( ( isnull( palarticulo.cajaspallet ,0) * isnull( almartcajas.piezascaja ,0) ) - isnull( sum( alm_bultos_lineas.cantidad ) ,0)  >= "+string(ld_piezas_a_mover,"#####0")+" ) "+&
					"ORDER BY alm_bultos.id ASC"
		
		if this.object.id_bulto_origen[row] <> 0 then
			ls_values = "Nuevo~t0/El Mismo~t"+string(this.object.id_bulto_origen[row])+""
		else
			ls_values = "Nuevo~t0"
		end if
		
		ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice = 1 to ll_total
			ls_values += "/"+string(ds_datos.object.id[ll_indice],"0000000000")+" "+string(ds_datos.object.cantidad[ll_indice],"#####0")+"Pzs"+"~t"+string(ds_datos.object.id[ll_indice])
		next
		
		destroy ds_datos
		
		this.Object.id_bulto_destino.Values = ls_values
				
		if this.object.id_bulto_origen[row] = 0 then
			//Marcamos generar nuevo bulto
			this.object.id_bulto_destino[row] = 0
		else
			//Marcamos mismo bulto
			this.object.id_bulto_destino[row] = this.object.id_bulto_origen[row]
		end if		
	CASE "almacen"
			SELECT  almalmacen.descripcion
			into :resultado
			FROM almalmacen 
			WHERE empresa = :codigo_empresa
			and almalmacen.codigo = :data;
										
			if SQLCA.sqlcode <> 100 then
				//OK
				this.object.zona[Row] 	= ''
				this.object.fila[Row] 	= 0
				this.object.altura[Row] 	= 0
			else
				this.object.almacen[Row] 	= ''
				this.object.zona[Row] 	= ''
				this.object.fila[Row] 	= 0
				this.object.altura[Row] 	= 0
				return 2			
			end if
			
		CASE "zona"	
			almacen = this.object.almacen[this.GetRow()]

			SELECT almubizonas.descripcion
			into :resultado
			FROM almubizonas 
			WHERE almubizonas.empresa = :codigo_empresa
			and almubizonas.almacen = :almacen
			and almubizonas.zona = :data;
			
			if SQLCA.sqlcode <> 100 then
				//OK
				this.object.fila[Row] 	= 0
				this.object.altura[Row] 	= 0
			else
				this.object.zona[Row] 		= ''
				this.object.fila[Row] 	= 0
				this.object.altura[Row] 	= 0
				return 2			
			end if
			
		CASE "fila"
			almacen = this.object.almacen[this.GetRow()]
			zona = this.object.zona[this.GetRow()]
			fila = Integer(data)
			
			if fila <= 0 then
				this.object.fila[Row] 		= 0
				this.object.altura[Row] 	= 0
				return 2
			else
				SELECT almubimapa.fila_hasta
				into :res2
				FROM almubimapa 
				WHERE almubimapa.empresa = :codigo_empresa
				and almubimapa.almacen = :almacen
				and almubimapa.zona = :zona
				and almubimapa.fila_desde <= :fila AND almubimapa.fila_hasta >= :fila;
				
				if SQLCA.sqlcode <> 100 then
					//OK
					this.object.altura[Row] 	= 0
				else
					this.object.fila[Row] 		= 0
					this.object.altura[Row] 	= 0
					return 2			
				end if
			end if
		CASE "altura"
			almacen = this.object.almacen[this.GetRow()]
			zona = this.object.zona[this.GetRow()]
			altura = Integer(data)
			
			if altura <= 0 then
				this.object.altura[Row] 	= 0
				return 2
			else
				SELECT almubimapa.altura_hasta
				into :res2
				FROM almubimapa 
				WHERE almubimapa.empresa = :codigo_empresa
				and almubimapa.almacen = :almacen
				and almubimapa.zona = :zona
				and almubimapa.altura_desde <= :altura AND almubimapa.altura_hasta >= :altura;
				
				if SQLCA.sqlcode <> 100 then
					//OK					
					this.Post Event itemchanged(row,this.object.piezas,string(this.object.piezas[row]))					
				else
					this.object.altura[Row] 	= 0
					return 2			
				end if
			end if
END CHOOSE

this.Accepttext()


end event

event losefocus;call super::losefocus;//this.triggerevent("itemchanged")
end event

event usr_dwnkey;call super::usr_dwnkey;string campo, almacen
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
			
		CASE "almacen"
			busqueda.titulo_ventana = "Búsqueda de Almacén"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM almalmacen "+&
										" WHERE empresa = '"+codigo_empresa+"' "+&
										" ORDER BY CONVERT(integer, codigo) "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.almacen[this.GetRow()] 					= resultado.valores[1]		
				this.object.zona[this.GetRow()] 	= ''
				this.object.fila[this.GetRow()] 	= 0
				this.object.altura[this.GetRow()] 	= 0
			end if
			
		CASE "zona"
			almacen = this.object.almacen[this.GetRow()]
			
			busqueda.titulo_ventana = "Búsqueda de Zona"
			busqueda.consulta  = " SELECT zona, descripcion "+&
										" FROM almubizonas "+&
										" WHERE empresa = '"+codigo_empresa+"' AND almacen = '"+almacen+"' "+&
										" ORDER BY zona ASC "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.zona[this.GetRow()] 					= resultado.valores[1]		
				this.object.fila[this.GetRow()] 	= 0
				this.object.altura[this.GetRow()] 	= 0
			end if
			
	END CHOOSE
end if	
end event

