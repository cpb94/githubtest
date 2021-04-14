$PBExportHeader$wtc_mant_almacen_traspaso.srw
forward
global type wtc_mant_almacen_traspaso from wt_ventana_padre
end type
type dw_salidas from datawindow within wtc_mant_almacen_traspaso
end type
type dw_mover from u_dw within wtc_mant_almacen_traspaso
end type
type pb_busqueda_codigo from picturebutton within wtc_mant_almacen_traspaso
end type
type dw_pedidos from datawindow within wtc_mant_almacen_traspaso
end type
type st_1 from statictext within wtc_mant_almacen_traspaso
end type
end forward

global type wtc_mant_almacen_traspaso from wt_ventana_padre
integer width = 5591
integer height = 3156
string title = "Traspasos Almacen"
dw_salidas dw_salidas
dw_mover dw_mover
pb_busqueda_codigo pb_busqueda_codigo
dw_pedidos dw_pedidos
st_1 st_1
end type
global wtc_mant_almacen_traspaso wtc_mant_almacen_traspaso

forward prototypes
public function integer f_guardar ()
public function integer f_borrar ()
public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key)
public subroutine f_traspaso_bulto_completo ()
public subroutine f_traspaso_bulto_parcial ()
protected subroutine f_calcular_pallets_caja (integer pallets_introducidos, integer cajas_introducidas, decimal piezas_introducidas, string arg_reservado_no_reservado_todo)
end prototypes

public function integer f_guardar ();
return 1
end function

public function integer f_borrar ();/*
setnull(param_transaccion.dbms)
setnull(param_transaccion.database)
setnull(param_transaccion.servername)
setnull(param_transaccion.logid)
setnull(param_transaccion.userid)
setnull(param_transaccion.logpass)
setnull(param_transaccion.autocommit)
setnull(param_transaccion.lock)
setnull(param_transaccion.dbparm)
rtn = super::f_borrar()
return rtn
*/
return 1
end function

public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key);If arg_KeyFlags = 2 then
	choose case arg_key
		case KeyEnter!
		case KeyN!
			pb_nuevo.triggerevent(clicked!)
		case KeyB!
			pb_borrar.triggerevent(clicked!)
		case KeyS!
			pb_grabar.triggerevent(clicked!)
		case KeyZ!
			pb_cancelar.triggerevent(clicked!)
	end choose		
else
	choose case arg_Key
		case KeyEnter!
		case KeyF2!
			pb_nuevo.triggerevent(clicked!)
		case KeyF3!
			pb_borrar.triggerevent(clicked!)
		case KeyF4!
			pb_grabar.triggerevent(clicked!)
		case KeyF8!
			pb_buscar.triggerevent(clicked!)
		case KeyF9!
			pb_busqueda_codigo.triggerevent(clicked!)
		case KeyEscape!
			pb_salir.triggerevent(clicked!)
	end choose		
end if
end subroutine

public subroutine f_traspaso_bulto_completo ();String familia, tipo_unidad, orden, almacen_destino, zona_destino, observaciones_destino, observaciones_nuevas, calidad, tono, tipo_pallet, caja
String almacen_origen, zona_origen
Int fila_alm_origen, altura_origen
String articulos[1]
Int fila_destino, altura_destino, calibre
Long fila, fila_origen
Dec piezas
Datetime fecha_intr

str_ventana_alerta parametros
string botones[2]


//VALIDACIÓN

almacen_destino = dw_mover.object.almacen[1]
zona_destino = dw_mover.object.zona[1]
fila_destino = dw_mover.object.fila[1]
altura_destino = dw_mover.object.altura[1]

fila_origen = dw_1.getrow()

calidad = dw_1.object.almacenmovimientos_calidad[fila_origen]
tono = dw_1.object.almacenmovimientos_tono[fila_origen]
calibre = dw_1.object.almacenmovimientos_calibre[fila_origen]
tipo_pallet = dw_1.object.almacenmovimientos_tipo_pallet[fila_origen]
caja = dw_1.object.almacenmovimientos_caja[fila_origen]	

if isnull(padre_codigo) or padre_codigo = "" then
	MessageBox("Error","Debe seleccionar un artículo para realizar el traspaso.")
	return
end if
if isnull(dw_mover.object.piezas[1]) or dw_mover.object.piezas[1] <= 0 then
	MessageBox("Error","Debe introducir las piezas que desea sacar.")
	return
end if
if dw_mover.object.piezas[1] > dw_1.object.stock[dw_1.getrow()] then
	MessageBox("Error","No puede sacar más piezas de las existentes en la ubicación.")
	return
end if

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

//	if almacen_destino = dw_1.object.almacenmovimientos_almacen[fila_origen] AND zona_destino = dw_1.object.almacenmovimientos_zona[fila_origen] AND fila_destino = dw_1.object.almacenmovimientos_fila[fila_origen] AND altura_destino = dw_1.object.almacenmovimientos_altura[fila_origen] then 
//		MessageBox("Error","No puede realizar un traspaso con origen y destino la misma ubicación.")
//		return
//	end if

if String(dw_mover.object.fecha_mov[1], "dd/mm/yyyy") <> String(today(), "dd/mm/yyyy") then
	parametros.titulo = "Atención"
	parametros.subtitulo = "Fecha Movimiento"
	parametros.mensaje = "La fecha del movimiento es distinta a la fecha actual, ¿desea continuar?"
	parametros.tipo = 2
	botones[1] = "Sí"
	botones[2] = "No"
	parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	borrar = Int(Message.DoubleParm)
	if borrar <> 1 then
		return
	end if
end if

SELECT familia INTO :familia 
FROM articulos 
WHERE empresa = :codigo_empresa AND codigo = :padre_codigo 
using trans_ts;

//	//CALCULO DEL ORDEN	
//	str_colisiones p_colisiones
//	rtn = 1
//	
//	p_colisiones.empresa = codigo_empresa
//	p_colisiones.tabla = "almacenmovimientos"
//	p_colisiones.campo = "orden"
//	p_colisiones.filtro = " fecha_mov = '"+String(dw_mover.object.fecha_mov[1], "dd/mm/yyyy")+"' "
//	p_colisiones.buscar_huecos = false
//	orden = f_colisiones(trans_ts, p_colisiones)

//Comprobamos las observaciones de la ubicación de destino y en caso de existir preguntamos si se desean sobreescribir
observaciones_nuevas = trim(dw_mover.object.observacion[1])

SELECT observaciones INTO :observaciones_destino 
FROM almacenmovimientos_observaciones 
WHERE empresa = :codigo_empresa AND almacen = :almacen_destino AND zona = :zona_destino 
	AND fila = :fila_destino AND altura = :altura_destino AND articulo = :padre_codigo 
	AND calidad = :calidad AND tono = :tono AND calibre = :calibre AND tipo_pallet = :tipo_pallet AND caja = :caja 
USING trans_ts;

if not isnull(observaciones_destino) and observaciones_destino <> "" then
	if not isnull(observaciones_nuevas) AND observaciones_nuevas <> "" then
		if MessageBox("Atención", "En el almacén de destino existen las siguientes observaciones: "+observaciones_destino+" ¿Desea sobreescribirlas y realizar el traspaso?", Question!, YesNo!, 2) <> 1 then 
			ROLLBACK using trans_ts;
			return
		end if
	else
		if MessageBox("Atención", "En el almacén de destino existen las siguientes observaciones: "+observaciones_destino+" ¿Desea continuar con el traspaso de material? SE MANTENDRAN LAS OBSERVACIONES EXISTENTES.", Question!, YesNo!, 2) <> 1 then 
			ROLLBACK using trans_ts;
			return
		end if
	end if
else 
	if not isnull(observaciones_nuevas) AND observaciones_nuevas <> "" then
		if MessageBox("Atención", "Se añadirán observaciones nuevas a todo el material que haya en esa ubicación del mismo articulo. ¿Desea continuar?", Question!, YesNo!, 2) <> 1 then 
			ROLLBACK using trans_ts;
			return
		end if
	end if
end if

//INSERCIÓN 
rtn = 1

fila = dw_salidas.insertrow(0)
if fila > 0 then
	str_movimiento_almacen_traspaso_bultos lstr_movimiento_almacen_traspaso_bultos
	
	lstr_movimiento_almacen_traspaso_bultos.empresa                 = codigo_empresa
	lstr_movimiento_almacen_traspaso_bultos.articulo                = padre_codigo
	lstr_movimiento_almacen_traspaso_bultos.calidad                 = calidad
	lstr_movimiento_almacen_traspaso_bultos.tono                    = tono
	lstr_movimiento_almacen_traspaso_bultos.calibre                 = calibre
	lstr_movimiento_almacen_traspaso_bultos.tipo_pallet             = tipo_pallet
	lstr_movimiento_almacen_traspaso_bultos.caja                    = caja
	lstr_movimiento_almacen_traspaso_bultos.cantidad                = ((dw_mover.object.piezas_reservado[1] + dw_mover.object.piezas_no_reservado[1]) * -1)
	lstr_movimiento_almacen_traspaso_bultos.orden_carga_anyo        = 0
	lstr_movimiento_almacen_traspaso_bultos.orden_carga_codigo      = ""
	lstr_movimiento_almacen_traspaso_bultos.orden_carga_linea       = 0
	lstr_movimiento_almacen_traspaso_bultos.tipo_movimiento_salida  = '102'
	lstr_movimiento_almacen_traspaso_bultos.observaciones           = ""
	lstr_movimiento_almacen_traspaso_bultos.almacen_salida          = dw_1.object.almacenmovimientos_almacen[fila_origen]
	lstr_movimiento_almacen_traspaso_bultos.zona_salida             = dw_1.object.almacenmovimientos_zona[fila_origen]
	lstr_movimiento_almacen_traspaso_bultos.fila_salida             = dw_1.object.almacenmovimientos_fila[fila_origen]
	lstr_movimiento_almacen_traspaso_bultos.altura_salida           = dw_1.object.almacenmovimientos_altura[fila_origen]
	lstr_movimiento_almacen_traspaso_bultos.tercero                 = ""
	lstr_movimiento_almacen_traspaso_bultos.documento               = ""
	lstr_movimiento_almacen_traspaso_bultos.fecha                   = datetime(dw_mover.object.fecha_mov[1])
	lstr_movimiento_almacen_traspaso_bultos.id_ubicacion_salida     = 0
	lstr_movimiento_almacen_traspaso_bultos.id_alm_bultos		      = dw_mover.object.id_bulto_origen[1]
	lstr_movimiento_almacen_traspaso_bultos.tipo_movimiento_entrada = '103'
	lstr_movimiento_almacen_traspaso_bultos.almacen_entrada         = almacen_destino
	lstr_movimiento_almacen_traspaso_bultos.zona_entrada            = zona_destino
	lstr_movimiento_almacen_traspaso_bultos.fila_entrada            = fila_destino
	lstr_movimiento_almacen_traspaso_bultos.altura_entrada          = altura_destino
	lstr_movimiento_almacen_traspaso_bultos.id_ubicacion_entrada    = 0
	//Introduce pallet a pallet
	if not(f_movimiento_almacen_traspaso_bultos(lstr_movimiento_almacen_traspaso_bultos)) then
		rtn = 0
	end if
			
	piezas = dw_mover.object.piezas[1]
	fecha_intr = datetime(today(), now())
	
	almacen_origen  = dw_1.object.almacenmovimientos_almacen[fila_origen]
	zona_origen     = dw_1.object.almacenmovimientos_zona[fila_origen]
	fila_alm_origen = dw_1.object.almacenmovimientos_fila[fila_origen]
	altura_origen   = dw_1.object.almacenmovimientos_altura[fila_origen]
	
	//SALIDA TRASPASO
	dw_salidas.object.almacenmovimientos_empresa[fila] = codigo_empresa
	dw_salidas.object.fecha_mov[fila] = dw_mover.object.fecha_mov[1]
	dw_salidas.object.orden[fila] = Long(orden)
	dw_salidas.object.fecha_intr[fila] = fecha_intr
	dw_salidas.object.origen[fila] = ""
	dw_salidas.object.almacenmovimientos_almacen[fila] = almacen_origen
	dw_salidas.object.almacenmovimientos_zona[fila] = zona_origen
	dw_salidas.object.almacenmovimientos_fila[fila] = fila_alm_origen
	dw_salidas.object.almacenmovimientos_altura[fila] = altura_origen
	dw_salidas.object.almacenmovimientos_articulo[fila] = padre_codigo
	dw_salidas.object.familia[fila] = familia
	dw_salidas.object.almacenmovimientos_formato[fila] = dw_1.object.almacenmovimientos_formato[fila_origen]
	dw_salidas.object.almacenmovimientos_calidad[fila] = calidad
	dw_salidas.object.almacenmovimientos_tono[fila] = tono
	dw_salidas.object.almacenmovimientos_calibre[fila] = calibre
	dw_salidas.object.almacenmovimientos_tipo_pallet[fila] = tipo_pallet
	dw_salidas.object.almacenmovimientos_caja[fila] = caja
	dw_salidas.object.cantidade[fila] = 0
	dw_salidas.object.cantidads[fila] = piezas
	dw_salidas.object.tipomov[fila] = '102' //Tipo Salida Trapaso
	dw_salidas.object.tipo_unidad[fila] = "0"
	dw_salidas.object.usuario[fila] = nombre_usuario
	//dw_salidas.object.observaciones[fila] = 
	//dw_salidas.object.trazabilidad[fila] = 
	
	fila = dw_salidas.insertrow(0)
	
	if fila > 0 then
		//ENTRADA TRASPASO
//			lstr_movimiento_almacen_traspaso_bultos.empresa            = codigo_empresa
//			lstr_movimiento_almacen_traspaso_bultos.articulo           = padre_codigo
//			lstr_movimiento_almacen_traspaso_bultos.calidad            = calidad
//			lstr_movimiento_almacen_traspaso_bultos.tono               = tono
//			lstr_movimiento_almacen_traspaso_bultos.calibre            = calibre
//			lstr_movimiento_almacen_traspaso_bultos.tipo_pallet        = tipo_pallet
//			lstr_movimiento_almacen_traspaso_bultos.caja               = caja
//			lstr_movimiento_almacen_traspaso_bultos.cantidad           = dw_mover.object.piezas[1]
//			lstr_movimiento_almacen_traspaso_bultos.orden_carga_anyo   = 0
//			lstr_movimiento_almacen_traspaso_bultos.orden_carga_codigo = ""
//			lstr_movimiento_almacen_traspaso_bultos.orden_carga_linea  = 0
//			lstr_movimiento_almacen_traspaso_bultos.tipo_movimiento    = '103'
//			lstr_movimiento_almacen_traspaso_bultos.observaciones      = ""
//			lstr_movimiento_almacen_traspaso_bultos.almacen            = almacen_destino
//			lstr_movimiento_almacen_traspaso_bultos.zona               = zona_destino
//			lstr_movimiento_almacen_traspaso_bultos.fila               = fila_destino
//			lstr_movimiento_almacen_traspaso_bultos.altura             = altura_destino
//			lstr_movimiento_almacen_traspaso_bultos.tercero            = ""
//			lstr_movimiento_almacen_traspaso_bultos.documento          = ""
//			lstr_movimiento_almacen_traspaso_bultos.fecha              = datetime(dw_mover.object.fecha_mov[1])
//			lstr_movimiento_almacen_traspaso_bultos.id_ubicacion       = 0
//			lstr_movimiento_almacen_traspaso_bultos.id_alm_bultos		 = dw_mover.object.id_bulto_destino[1]
//			
//			//Introduce pallet a pallet
//			if not(f_movimiento_almacen(lstr_movimiento_almacen_traspaso_bultos)) then
//				rtn = 0
//			end if			
					
		dw_salidas.object.almacenmovimientos_empresa[fila] = codigo_empresa
		dw_salidas.object.fecha_mov[fila] = dw_mover.object.fecha_mov[1]
		dw_salidas.object.orden[fila] = Long(orden) + 1
		dw_salidas.object.fecha_intr[fila] = fecha_intr
		dw_salidas.object.origen[fila] = ""
		dw_salidas.object.almacenmovimientos_almacen[fila] = almacen_destino
		dw_salidas.object.almacenmovimientos_zona[fila] = zona_destino
		dw_salidas.object.almacenmovimientos_fila[fila] = fila_destino
		dw_salidas.object.almacenmovimientos_altura[fila] = altura_destino
		dw_salidas.object.almacenmovimientos_articulo[fila] = padre_codigo
		dw_salidas.object.familia[fila] = familia
		dw_salidas.object.almacenmovimientos_formato[fila] = dw_1.object.almacenmovimientos_formato[fila_origen]
		dw_salidas.object.almacenmovimientos_calidad[fila] = calidad
		dw_salidas.object.almacenmovimientos_tono[fila] = tono
		dw_salidas.object.almacenmovimientos_calibre[fila] = calibre
		dw_salidas.object.almacenmovimientos_tipo_pallet[fila] = tipo_pallet
		dw_salidas.object.almacenmovimientos_caja[fila] = caja
		dw_salidas.object.cantidade[fila] = piezas
		dw_salidas.object.cantidads[fila] = 0
		dw_salidas.object.tipomov[fila] = '103' //Tipo Entrada Trapaso
		dw_salidas.object.tipo_unidad[fila] = "0"
		dw_salidas.object.usuario[fila] = nombre_usuario
		//dw_salidas.object.observaciones[fila] = 
		//dw_salidas.object.trazabilidad[fila] = 
		
	else 
		rtn = 0
	end if			
	
else 
	rtn = 0
end if

//GUARDADO

if rtn = 1 then
	if not isnull(observaciones_nuevas) AND observaciones_nuevas <> "" then
		//Existen observaciones nuevas - Se sobreescribirán las existentes
		if not isnull(observaciones_destino) AND observaciones_destino <> "" then 
			DELETE FROM almacenmovimientos_observaciones 
			WHERE empresa = :codigo_empresa AND almacen = :almacen_destino AND zona = :zona_destino 
			AND fila = :fila_destino AND altura = :altura_destino AND articulo = :padre_codigo 
			AND calidad = :calidad AND tono = :tono AND calibre = :calibre AND tipo_pallet = :tipo_pallet AND caja = :caja 
			USING trans_ts;	
			if trans_ts.Sqlcode <> 0 then
				rtn = 0
			end if
		end if
		if rtn = 1 then
			INSERT INTO almacenmovimientos_observaciones (empresa, almacen, zona, fila, altura, articulo, calidad, tono, calibre, tipo_pallet, caja, observaciones) 
			VALUES (:codigo_empresa, :almacen_destino, :zona_destino, :fila_destino, :altura_destino, :padre_codigo, :calidad, :tono, :calibre, :tipo_pallet, :caja, :observaciones_nuevas) 
			USING trans_ts;	
			if trans_ts.Sqlcode <> 0 then
				rtn = 0
			end if
		end if
	else
		//No hay observaciones nuevas por lo que se mantrendrá lo que había			
	end if	
	//Si se traspasa todo el materias existente se deben borrar observaciones del origen
	if rtn = 1 and piezas = dw_1.object.stock[fila_origen] then
		DELETE FROM almacenmovimientos_observaciones 
		WHERE empresa = :codigo_empresa AND almacen = :almacen_origen AND zona = :zona_origen AND fila = :fila_alm_origen 
		AND altura = :altura_origen AND articulo = :padre_codigo AND calidad = :calidad AND tono = :tono 
		AND calibre = :calibre AND tipo_pallet = :tipo_pallet AND caja = :caja 
		USING trans_ts;
		if trans_ts.Sqlcode <> 0 then
			rtn = 0
		end if
	end if
end if	

if rtn = 1 then
	//dw_salidas.SetTransObject(trans_ts)	
	//rtn = dw_salidas.update()
end if

if rtn = 1 then
	COMMIT USING sqlca;
	COMMIT USING trans_ts;
else
	ROLLBACK USING sqlca;
	ROLLBACK USING trans_ts;
	MessageBox("Error de guardado", "No ha sido posible realizar el guardado. Intentelo de nuevo y si el error se repite, póngase en contacto con el administrador.")
end if

dw_salidas.SetTransObject(SQLCA)
dw_1.retrieve(codigo_empresa, padre_codigo)
dw_salidas.retrieve(codigo_empresa, today())
articulos[1] = padre_codigo
dw_pedidos.retrieve(codigo_empresa, articulos)
dw_mover.visible = false
dw_1.selectrow(0, false)
dw_mover.object.almacen[1] 	= ''
dw_mover.object.zona[1] 	= ''
dw_mover.object.fila[1] 	= 0
dw_mover.object.altura[1] 	= 0
dw_mover.reset()
end subroutine

public subroutine f_traspaso_bulto_parcial ();String familia, tipo_unidad, orden, almacen_destino, zona_destino, observaciones_destino, observaciones_nuevas, calidad, tono, tipo_pallet, caja
String almacen_origen, zona_origen
Int fila_alm_origen, altura_origen
String articulos[1]
Int fila_destino, altura_destino, calibre
Long fila, fila_origen
Dec piezas
Datetime fecha_intr

str_ventana_alerta parametros
string botones[2]


//VALIDACIÓN

almacen_destino = dw_mover.object.almacen[1]
zona_destino = dw_mover.object.zona[1]
fila_destino = dw_mover.object.fila[1]
altura_destino = dw_mover.object.altura[1]

fila_origen = dw_1.getrow()

calidad = dw_1.object.almacenmovimientos_calidad[fila_origen]
tono = dw_1.object.almacenmovimientos_tono[fila_origen]
calibre = dw_1.object.almacenmovimientos_calibre[fila_origen]
tipo_pallet = dw_1.object.almacenmovimientos_tipo_pallet[fila_origen]
caja = dw_1.object.almacenmovimientos_caja[fila_origen]	

if isnull(padre_codigo) or padre_codigo = "" then
	MessageBox("Error","Debe seleccionar un artículo para realizar el traspaso.")
	return
end if
if isnull(dw_mover.object.piezas[1]) or dw_mover.object.piezas[1] <= 0 then
	MessageBox("Error","Debe introducir las piezas que desea sacar.")
	return
end if
if dw_mover.object.piezas[1] > dw_1.object.stock[dw_1.getrow()] then
	MessageBox("Error","No puede sacar más piezas de las existentes en la ubicación.")
	return
end if

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

if String(dw_mover.object.fecha_mov[1], "dd/mm/yyyy") <> String(today(), "dd/mm/yyyy") then
	parametros.titulo = "Atención"
	parametros.subtitulo = "Fecha Movimiento"
	parametros.mensaje = "La fecha del movimiento es distinta a la fecha actual, ¿desea continuar?"
	parametros.tipo = 2
	botones[1] = "Sí"
	botones[2] = "No"
	parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	borrar = Int(Message.DoubleParm)
	if borrar <> 1 then
		return
	end if
end if

SELECT familia INTO :familia 
FROM articulos 
WHERE empresa = :codigo_empresa AND codigo = :padre_codigo 
using trans_ts;

//Comprobamos las observaciones de la ubicación de destino y en caso de existir preguntamos si se desean sobreescribir
observaciones_nuevas = trim(dw_mover.object.observacion[1])

SELECT observaciones INTO :observaciones_destino 
FROM almacenmovimientos_observaciones 
WHERE empresa = :codigo_empresa AND almacen = :almacen_destino AND zona = :zona_destino 
	AND fila = :fila_destino AND altura = :altura_destino AND articulo = :padre_codigo 
	AND calidad = :calidad AND tono = :tono AND calibre = :calibre AND tipo_pallet = :tipo_pallet AND caja = :caja 
USING trans_ts;

if not isnull(observaciones_destino) and observaciones_destino <> "" then
	if not isnull(observaciones_nuevas) AND observaciones_nuevas <> "" then
		if MessageBox("Atención", "En el almacén de destino existen las siguientes observaciones: "+observaciones_destino+" ¿Desea sobreescribirlas y realizar el traspaso?", Question!, YesNo!, 2) <> 1 then 
			ROLLBACK using trans_ts;
			return
		end if
	else
		if MessageBox("Atención", "En el almacén de destino existen las siguientes observaciones: "+observaciones_destino+" ¿Desea continuar con el traspaso de material? SE MANTENDRAN LAS OBSERVACIONES EXISTENTES.", Question!, YesNo!, 2) <> 1 then 
			ROLLBACK using trans_ts;
			return
		end if
	end if
else 
	if not isnull(observaciones_nuevas) AND observaciones_nuevas <> "" then
		if MessageBox("Atención", "Se añadirán observaciones nuevas a todo el material que haya en esa ubicación del mismo articulo. ¿Desea continuar?", Question!, YesNo!, 2) <> 1 then 
			ROLLBACK using trans_ts;
			return
		end if
	end if
end if

//INSERCIÓN 
rtn = 1

fila = dw_salidas.insertrow(0)
if fila > 0 then
	str_movimiento_almacen lstr_movimiento_almacen
	
	lstr_movimiento_almacen.empresa                 = codigo_empresa
	lstr_movimiento_almacen.articulo                = padre_codigo
	lstr_movimiento_almacen.calidad                 = calidad
	lstr_movimiento_almacen.tono                    = tono
	lstr_movimiento_almacen.calibre                 = calibre
	lstr_movimiento_almacen.tipo_pallet             = tipo_pallet
	lstr_movimiento_almacen.caja                    = caja
	lstr_movimiento_almacen.cantidad                = (dw_mover.object.piezas_no_reservado[1] * -1) //(dw_mover.object.piezas[1] * -1)
	lstr_movimiento_almacen.orden_carga_anyo        = 0
	lstr_movimiento_almacen.orden_carga_codigo      = ""
	lstr_movimiento_almacen.orden_carga_linea       = 0
	lstr_movimiento_almacen.tipo_movimiento         = '102'
	lstr_movimiento_almacen.observaciones           = ""
	lstr_movimiento_almacen.almacen                 = dw_1.object.almacenmovimientos_almacen[fila_origen]
	lstr_movimiento_almacen.zona                    = dw_1.object.almacenmovimientos_zona[fila_origen]
	lstr_movimiento_almacen.fila                    = dw_1.object.almacenmovimientos_fila[fila_origen]
	lstr_movimiento_almacen.altura                  = dw_1.object.almacenmovimientos_altura[fila_origen]
	lstr_movimiento_almacen.tercero                 = ""
	lstr_movimiento_almacen.documento               = ""
	lstr_movimiento_almacen.fecha                   = datetime(dw_mover.object.fecha_mov[1])
	lstr_movimiento_almacen.id_ubicacion            = 0
	lstr_movimiento_almacen.id_alm_bultos		      = dw_mover.object.id_bulto_origen[1]

	//Introduce pallet a pallet
	if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
		rtn = 0
	end if
			
	piezas = dw_mover.object.piezas[1]
	fecha_intr = datetime(today(), now())
	
	almacen_origen  = dw_1.object.almacenmovimientos_almacen[fila_origen]
	zona_origen     = dw_1.object.almacenmovimientos_zona[fila_origen]
	fila_alm_origen = dw_1.object.almacenmovimientos_fila[fila_origen]
	altura_origen   = dw_1.object.almacenmovimientos_altura[fila_origen]
	
	//SALIDA TRASPASO
	dw_salidas.object.almacenmovimientos_empresa[fila] = codigo_empresa
	dw_salidas.object.fecha_mov[fila] = dw_mover.object.fecha_mov[1]
	dw_salidas.object.orden[fila] = Long(orden)
	dw_salidas.object.fecha_intr[fila] = fecha_intr
	dw_salidas.object.origen[fila] = ""
	dw_salidas.object.almacenmovimientos_almacen[fila] = almacen_origen
	dw_salidas.object.almacenmovimientos_zona[fila] = zona_origen
	dw_salidas.object.almacenmovimientos_fila[fila] = fila_alm_origen
	dw_salidas.object.almacenmovimientos_altura[fila] = altura_origen
	dw_salidas.object.almacenmovimientos_articulo[fila] = padre_codigo
	dw_salidas.object.familia[fila] = familia
	dw_salidas.object.almacenmovimientos_formato[fila] = dw_1.object.almacenmovimientos_formato[fila_origen]
	dw_salidas.object.almacenmovimientos_calidad[fila] = calidad
	dw_salidas.object.almacenmovimientos_tono[fila] = tono
	dw_salidas.object.almacenmovimientos_calibre[fila] = calibre
	dw_salidas.object.almacenmovimientos_tipo_pallet[fila] = tipo_pallet
	dw_salidas.object.almacenmovimientos_caja[fila] = caja
	dw_salidas.object.cantidade[fila] = 0
	dw_salidas.object.cantidads[fila] = piezas
	dw_salidas.object.tipomov[fila] = '102' //Tipo Salida Trapaso
	dw_salidas.object.tipo_unidad[fila] = "0"
	dw_salidas.object.usuario[fila] = nombre_usuario
	//dw_salidas.object.observaciones[fila] = 
	//dw_salidas.object.trazabilidad[fila] = 
	
	fila = dw_salidas.insertrow(0)
	
	if fila > 0 then
		//ENTRADA TRASPASO
		lstr_movimiento_almacen.empresa            = codigo_empresa
		lstr_movimiento_almacen.articulo           = padre_codigo
		lstr_movimiento_almacen.calidad            = calidad
		lstr_movimiento_almacen.tono               = tono
		lstr_movimiento_almacen.calibre            = calibre
		lstr_movimiento_almacen.tipo_pallet        = tipo_pallet
		lstr_movimiento_almacen.caja               = caja
		lstr_movimiento_almacen.cantidad           = dw_mover.object.piezas_no_reservado[1]
		lstr_movimiento_almacen.orden_carga_anyo   = 0
		lstr_movimiento_almacen.orden_carga_codigo = ""
		lstr_movimiento_almacen.orden_carga_linea  = 0
		lstr_movimiento_almacen.tipo_movimiento    = '103'
		lstr_movimiento_almacen.observaciones      = ""
		lstr_movimiento_almacen.almacen            = almacen_destino
		lstr_movimiento_almacen.zona               = zona_destino
		lstr_movimiento_almacen.fila               = fila_destino
		lstr_movimiento_almacen.altura             = altura_destino
		lstr_movimiento_almacen.tercero            = ""
		lstr_movimiento_almacen.documento          = ""
		lstr_movimiento_almacen.fecha              = datetime(dw_mover.object.fecha_mov[1])
		lstr_movimiento_almacen.id_ubicacion       = 0
		lstr_movimiento_almacen.id_alm_bultos		 = dw_mover.object.id_bulto_destino[1]
		
		//Introduce pallet a pallet
		if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
			rtn = 0
		end if			
					
		dw_salidas.object.almacenmovimientos_empresa[fila] = codigo_empresa
		dw_salidas.object.fecha_mov[fila] = dw_mover.object.fecha_mov[1]
		dw_salidas.object.orden[fila] = Long(orden) + 1
		dw_salidas.object.fecha_intr[fila] = fecha_intr
		dw_salidas.object.origen[fila] = ""
		dw_salidas.object.almacenmovimientos_almacen[fila] = almacen_destino
		dw_salidas.object.almacenmovimientos_zona[fila] = zona_destino
		dw_salidas.object.almacenmovimientos_fila[fila] = fila_destino
		dw_salidas.object.almacenmovimientos_altura[fila] = altura_destino
		dw_salidas.object.almacenmovimientos_articulo[fila] = padre_codigo
		dw_salidas.object.familia[fila] = familia
		dw_salidas.object.almacenmovimientos_formato[fila] = dw_1.object.almacenmovimientos_formato[fila_origen]
		dw_salidas.object.almacenmovimientos_calidad[fila] = calidad
		dw_salidas.object.almacenmovimientos_tono[fila] = tono
		dw_salidas.object.almacenmovimientos_calibre[fila] = calibre
		dw_salidas.object.almacenmovimientos_tipo_pallet[fila] = tipo_pallet
		dw_salidas.object.almacenmovimientos_caja[fila] = caja
		dw_salidas.object.cantidade[fila] = piezas
		dw_salidas.object.cantidads[fila] = 0
		dw_salidas.object.tipomov[fila] = '103' //Tipo Entrada Trapaso
		dw_salidas.object.tipo_unidad[fila] = "0"
		dw_salidas.object.usuario[fila] = nombre_usuario
		//dw_salidas.object.observaciones[fila] = 
		//dw_salidas.object.trazabilidad[fila] = 
		
	else 
		rtn = 0
	end if			
	
else 
	rtn = 0
end if

//GUARDADO

if rtn = 1 then
	if not isnull(observaciones_nuevas) AND observaciones_nuevas <> "" then
		//Existen observaciones nuevas - Se sobreescribirán las existentes
		if not isnull(observaciones_destino) AND observaciones_destino <> "" then 
			DELETE FROM almacenmovimientos_observaciones 
			WHERE empresa = :codigo_empresa AND almacen = :almacen_destino AND zona = :zona_destino 
			AND fila = :fila_destino AND altura = :altura_destino AND articulo = :padre_codigo 
			AND calidad = :calidad AND tono = :tono AND calibre = :calibre AND tipo_pallet = :tipo_pallet AND caja = :caja 
			USING trans_ts;	
			if trans_ts.Sqlcode <> 0 then
				rtn = 0
			end if
		end if
		if rtn = 1 then
			INSERT INTO almacenmovimientos_observaciones (empresa, almacen, zona, fila, altura, articulo, calidad, tono, calibre, tipo_pallet, caja, observaciones) 
			VALUES (:codigo_empresa, :almacen_destino, :zona_destino, :fila_destino, :altura_destino, :padre_codigo, :calidad, :tono, :calibre, :tipo_pallet, :caja, :observaciones_nuevas) 
			USING trans_ts;	
			if trans_ts.Sqlcode <> 0 then
				rtn = 0
			end if
		end if
	else
		//No hay observaciones nuevas por lo que se mantrendrá lo que había			
	end if	
	//Si se traspasa todo el materias existente se deben borrar observaciones del origen
	if rtn = 1 and piezas = dw_1.object.stock[fila_origen] then
		DELETE FROM almacenmovimientos_observaciones 
		WHERE empresa = :codigo_empresa AND almacen = :almacen_origen AND zona = :zona_origen AND fila = :fila_alm_origen 
		AND altura = :altura_origen AND articulo = :padre_codigo AND calidad = :calidad AND tono = :tono 
		AND calibre = :calibre AND tipo_pallet = :tipo_pallet AND caja = :caja 
		USING trans_ts;
		if trans_ts.Sqlcode <> 0 then
			rtn = 0
		end if
	end if
end if	

if rtn = 1 then
	//dw_salidas.SetTransObject(trans_ts)	
	//rtn = dw_salidas.update()
end if

if rtn = 1 then
	COMMIT USING sqlca;
	COMMIT USING trans_ts;
else
	ROLLBACK USING sqlca;
	ROLLBACK USING trans_ts;
	MessageBox("Error de guardado", "No ha sido posible realizar el guardado. Intentelo de nuevo y si el error se repite, póngase en contacto con el administrador.")
end if

dw_salidas.SetTransObject(SQLCA)
dw_1.retrieve(codigo_empresa, padre_codigo)
dw_salidas.retrieve(codigo_empresa, today())
articulos[1] = padre_codigo
dw_pedidos.retrieve(codigo_empresa, articulos)
dw_mover.visible = false
dw_1.selectrow(0, false)
dw_mover.object.almacen[1] 	= ''
dw_mover.object.zona[1] 	= ''
dw_mover.object.fila[1] 	= 0
dw_mover.object.altura[1] 	= 0
dw_mover.reset()
end subroutine

protected subroutine f_calcular_pallets_caja (integer pallets_introducidos, integer cajas_introducidas, decimal piezas_introducidas, string arg_reservado_no_reservado_todo);Integer pallets, cajas
Dec    piezas, lineales, n_cajas, n_pallets, n_total,ll_piezaspallet
Int    fila
long   ll_almubimapa_codbar_id_alm_bultos
string cod_caja, cod_articulo, cod_pallet, cod_formato, cod_unidad, ls_gestionar_en_piezas
Dec    n_piezascaja, n_metroscaja, n_cajaspallet, total_cajas, total_cantidad, total_pallets, total_lineales, largo

fila = dw_1.getrow()

n_pallets = pallets_introducidos
n_cajas   = cajas_introducidas
n_total   = piezas_introducidas
								
cod_articulo = dw_1.object.almacenmovimientos_articulo[fila]
cod_caja     = dw_1.object.almacenmovimientos_caja[fila]
cod_pallet   = dw_1.object.almacenmovimientos_tipo_pallet[fila]
ls_gestionar_en_piezas = dw_1.object.gestionar_en_piezas[fila]

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
	
//n_metroscaja = round(n_metroscaja,2) //METROS a decimales especificados en el articulo

SELECT  palarticulo.cajaspallet			 
	INTO :n_cajaspallet
	FROM  palarticulo
	WHERE palarticulo.empresa  = :codigo_empresa
	AND   palarticulo.articulo = :cod_articulo
	AND   palarticulo.codigo   = :cod_pallet
	AND   palarticulo.caja     = :cod_caja;
	
if isnull(n_cajaspallet) then n_cajaspallet = 0

ll_piezaspallet = n_cajaspallet * n_piezascaja
//EL ALMACEN SIEMPRE EN METROS

//  n_total=Dec(n_total)
IF n_total <> 0 THEN
	IF n_piezascaja = 0 or isnull(n_piezascaja) THEN 	
		total_cajas = 0											
	ELSE							
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
				
				choose case arg_reservado_no_reservado_todo
					case "TODO"
						if n_total > dw_1.object.stock_total[fila] then n_total = dw_1.object.stock_total[fila]
					case "NO RESERVADO"
						if n_total > dw_1.object.stock[fila] then n_total = dw_1.object.stock[fila]
					case "RESERVADO"
						if n_total > dw_1.object.reservado[fila] then n_total = dw_1.object.reservado[fila]						
				end choose
				total_cantidad = n_total
			end if
	
			cajas = TRUNCATE(n_total / n_piezascaja, 0)
			
			if n_cajaspallet > 0 then
				total_pallets  = truncate(total_cajas / n_cajaspallet,0) 
			else 
				total_pallets = 0
			end if						
		end if
	END IF																
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

IF largo<>0 THEN
	total_lineales = total_cantidad * (largo / 100)
END IF

if cod_caja = "901" then //SIN CAJA
	cajas = 0
	total_cajas = 0
end if

choose case arg_reservado_no_reservado_todo
	case "TODO"
		dw_mover.object.pallets[1] = total_pallets
		dw_mover.object.cajas[1]   = total_cajas
		dw_mover.object.piezas[1]  = total_cantidad
	case "NO RESERVADO"
		dw_mover.object.pallets_no_reservado[1] = total_pallets
		dw_mover.object.cajas_no_reservado[1]   = total_cajas
		dw_mover.object.piezas_no_reservado[1]  = total_cantidad
		
		dw_mover.object.piezas[1] = dw_mover.object.piezas_no_reservado[1] + dw_mover.object.piezas_reservado[1]
	case "RESERVADO"
		dw_mover.object.pallets_reservado[1] = total_pallets
		dw_mover.object.cajas_reservado[1]   = total_cajas
		dw_mover.object.piezas_reservado[1]  = total_cantidad
		
		dw_mover.object.piezas[1] = dw_mover.object.piezas_no_reservado[1] + dw_mover.object.piezas_reservado[1]		
end choose

string ls_sel,ls_articulo,ls_calidad,ls_tono,ls_caja,ls_almacen,ls_zona,ls_values
int    li_calibre,li_fila,li_altura
long   ll_id_ubicacion,ll_indice,ll_total
dec ld_piezas_a_mover,ld_piezas_bulto_origen
datastore ds_datos

ld_piezas_a_mover = 0

if dw_mover.object.traspasar_reservado[1] = 'S' then
	ld_piezas_a_mover += dw_mover.object.piezas_reservado[1]
end if

if dw_mover.object.traspasar_no_reservado[1] = 'S' then
	ld_piezas_a_mover += dw_mover.object.piezas_no_reservado[1]
end if

ld_piezas_bulto_origen = dw_1.object.stock_total[fila]

ls_almacen = dw_mover.object.almacen[1]
ls_zona    = dw_mover.object.zona[1]
li_fila    = dw_mover.object.fila[1]
li_altura  = dw_mover.object.altura[1]

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
	
	dw_mover.Object.id_bulto_destino.Values = ls_values
	dw_mover.Object.id_bulto_destino[1]     = ll_almubimapa_codbar_id_alm_bultos
else
	ls_articulo = dw_1.object.almacenmovimientos_articulo[fila]
	ls_calidad  = dw_1.object.almacenmovimientos_calidad[fila]
	ls_tono     = dw_1.object.almacenmovimientos_tono[fila]
	li_calibre  = dw_1.object.almacenmovimientos_calibre[fila]
	ls_caja     = dw_1.object.almacenmovimientos_caja[fila]
	
	if dw_mover.object.mostrar_todos_los_bultos[1] = 'S' then
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
					"AND     ( alm_bultos.id_ubicacion    = "+string(ll_id_ubicacion,"#########0")+" ) ) "+&
					"GROUP BY alm_bultos.id, "+&
					"			 palarticulo.cajaspallet, "+&
					"			 almartcajas.piezascaja "+&
					"ORDER BY alm_bultos.id ASC"		
	else	
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
	end if
	
	if ld_piezas_a_mover = ld_piezas_bulto_origen then
		ls_values = "Nuevo~t0/El Mismo~t"+string(dw_1.object.alm_bultos_id[fila])+""	
	else
		ls_values = "Nuevo~t0"	
	end if
	
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total
		ls_values += "/"+string(ds_datos.object.id[ll_indice],"0000000000")+" "+string(ds_datos.object.cantidad[ll_indice],"#####0")+"Pzs"+"~t"+string(ds_datos.object.id[ll_indice])
	next
	
	dw_mover.Object.id_bulto_destino.Values = ls_values
			
	if dw_mover.object.traspasar_reservado[1] = 'S' then		
		dw_mover.SetTabOrder("id_bulto_destino",0)
		dw_mover.Object.id_bulto_destino[1] = dw_1.object.alm_bultos_id[fila]
	else	
		dw_mover.SetTabOrder("id_bulto_destino",55)
		if ll_total > 0 then
			dw_mover.Object.id_bulto_destino[1] = ds_datos.object.id[1]
		else
			dw_mover.Object.id_bulto_destino[1] = 0
		end if
	end if
			
	destroy ds_datos			
end if


		
/* Esto lo controlamos en el itemchanged de la dw_mover
if ld_piezas_a_mover <> ld_piezas_bulto_origen then
	//Marcamos generar nuevo bulto
	dw_mover.object.id_bulto_destino[1] = 0
else
	//Marcamos mismo bulto
	dw_mover.object.id_bulto_destino[1] = dw_mover.object.id_bulto_origen[1]
end if
*/

//if ftc_calcular_unidades_almacen(codigo_empresa, padre_codigo, dw_1.object.almacenmovimientos_tipo_pallet[dw_1.getrow()], dw_1.object.almacenmovimientos_caja[dw_1.getrow()], pallets_introducidos, cajas_introducidas, piezas_introducidas, pallets, cajas, piezas, lineales) = 0 then	
//	dw_mover.object.pallets[1] = pallets
//	dw_mover.object.cajas[1] = cajas
//	dw_mover.object.piezas[1] = piezas
//else
//	dw_mover.object.pallets[1] = 0
//	dw_mover.object.cajas[1] = 0
//	dw_mover.object.piezas[1] = 0
//end if
//
//


end subroutine

on wtc_mant_almacen_traspaso.create
int iCurrent
call super::create
this.dw_salidas=create dw_salidas
this.dw_mover=create dw_mover
this.pb_busqueda_codigo=create pb_busqueda_codigo
this.dw_pedidos=create dw_pedidos
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_salidas
this.Control[iCurrent+2]=this.dw_mover
this.Control[iCurrent+3]=this.pb_busqueda_codigo
this.Control[iCurrent+4]=this.dw_pedidos
this.Control[iCurrent+5]=this.st_1
end on

on wtc_mant_almacen_traspaso.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_salidas)
destroy(this.dw_mover)
destroy(this.pb_busqueda_codigo)
destroy(this.dw_pedidos)
destroy(this.st_1)
end on

event open;call super::open;dw_salidas.settransobject(SQLCA)
dw_pedidos.settransobject(SQLCA)
dw_salidas.retrieve(codigo_empresa, today())

dw_mover.insertrow(0)

padre_codigo = ""
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_almacen_traspaso
boolean visible = false
integer x = 2560
integer y = 48
boolean enabled = false
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_almacen_traspaso
integer x = 4974
integer y = 8
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_almacen_traspaso
integer width = 5467
integer height = 820
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_almacen_traspaso"
boolean vscrollbar = true
boolean border = false
end type

event dw_1::clicked;call super::clicked;String familia = ""

if row > 0 then
	if dwo.name = "p_salida" then
		
		//NO PERMITIR TRASPASOS DESDE Y HACIA EL MUELLE DE DISTRIBUCIÓN - 08/2015
		//SELECT familia INTO:familia FROM articulos WHERE empresa = :codigo_empresa AND codigo = :padre_codigo;
		
		//if this.object.almacenmovimientos_almacen[row] = "1" and this.object.almacenmovimientos_zona[row] = "P" and this.object.almacenmovimientos_fila[row] >= 10 then
			//MessageBox("Error", "No se permite traspasar material desde el muelle de distribución (1 P fila >= 10). Desprepare el material desde el mantenimiento de órdenes de preparación.")
			
//		if this.object.reservado[row] > 0 then
//			MessageBox("Error", "No se permite traspasar material preparado. Desprepare el material desde el mantenimiento de órdenes de preparación.")
//			return
//		end if
		
		dw_mover.visible = true
		dw_1.setrow(row)
		dw_1.selectrow(row, true)
		
		//Veamos que cantidad tenemos reservada del bulto
		dec ld_cantidad_reservada
		long ll_id_bulto_traspaso,ll_id_linea_traspaso
		
		ll_id_bulto_traspaso = dw_1.object.alm_bultos_id[row]
		ll_id_linea_traspaso = dw_1.object.alm_bultos_lineas_id[row]
		
		SELECT isnull(sum(venliped_reservas.cantidad),0) as cantidad_reservada 
		INTO   :ld_cantidad_reservada
		FROM   venliped_reservas,   
				 alm_bultos,   
				 alm_bultos_lineas  
		WHERE ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) 
		AND   ( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) 
		AND ( ( venliped_reservas.empresa              = :codigo_empresa ) 
		AND   ( alm_bultos.id                          = :ll_id_bulto_traspaso ) 
		AND   ( venliped_reservas.alm_bultos_lineas_id = :ll_id_linea_traspaso ) );
		//
		
		dw_mover.object.fecha_mov[1]           = today()
		dw_mover.object.piezas[1]              = dw_1.object.stock_total[row] // Dec(dw_1.object.stock[row])
		dw_mover.object.piezas_reservado[1]    = ld_cantidad_reservada
		
		if ld_cantidad_reservada > 0 then
			dw_mover.object.traspasar_reservado[1] = "S"
			dw_mover.SetTabOrder("piezas_no_reservado",0)
			dw_mover.SetTabOrder("cajas_no_reservado",0)
			dw_mover.SetTabOrder("pallets_no_reservado",0)			
		else
			dw_mover.object.traspasar_reservado[1] = "N"
			dw_mover.SetTabOrder("piezas_no_reservado",70)
			dw_mover.SetTabOrder("cajas_no_reservado",80)
			dw_mover.SetTabOrder("pallets_no_reservado",90)			
		end if
		
		dw_mover.object.piezas_no_reservado[1] = Dec(dw_1.object.stock[row]) - ld_cantidad_reservada
		if Dec(dw_1.object.stock[row]) - ld_cantidad_reservada > 0 then
			dw_mover.object.traspasar_no_reservado[1] = "S"
		else
			dw_mover.object.traspasar_no_reservado[1] = "N"
		end if		
		dw_mover.object.observacion[1]         = dw_1.object.almacenmovimientos_observaciones_observaciones[row]
		dw_mover.object.id_bulto_origen[1]     = dw_1.object.alm_bultos_id[row]
		
		dw_mover.Object.id_bulto_destino.Values = "Nuevo~t0/El Mismo~t"+string(dw_1.object.alm_bultos_id[row])+""
		
		//if Dec(dw_1.object.stock[row]) = dw_1.object.stock_total[row] then
			dw_mover.object.id_bulto_destino[1] = dw_1.object.alm_bultos_id[row]
		//else
			//dw_mover.object.id_bulto_destino[1] = 0 //Marcamos generar nuevo bulto
		//end if
		
		dw_mover.EVENT itemchanged(1, dw_mover.object.piezas_reservado, String(dw_mover.object.piezas_reservado[1]))
		dw_mover.EVENT itemchanged(1, dw_mover.object.piezas_no_reservado, String(dw_mover.object.piezas_no_reservado[1]))
		dw_mover.EVENT itemchanged(1, dw_mover.object.piezas, String(dw_mover.object.piezas[1]))
		
		dw_mover.setfocus()
		dw_mover.SetColumn("almacen")
	end if
end if
end event

event dw_1::doubleclicked;call super::doubleclicked;if row > 0 then
	this.EVENT clicked(xpos, ypos, row, this.object.p_salida)
end if
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_almacen_traspaso
boolean visible = false
integer x = 3063
integer y = 52
boolean enabled = false
end type

event pb_borrar::clicked;//No se aplica funcionalidad de borrar
end event

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_almacen_traspaso
integer x = 5330
integer y = 124
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_almacen_traspaso
boolean visible = false
integer x = 2734
integer y = 52
boolean enabled = false
end type

event pb_grabar::clicked;//No se aplica funcionalidad de guardar 
end event

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_almacen_traspaso
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_almacen_traspaso
boolean visible = false
integer x = 2894
integer y = 52
boolean enabled = false
end type

event pb_nuevo::clicked;//No se aplica funcionalidad de nuevo
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_almacen_traspaso
boolean visible = false
integer x = 3218
integer y = 52
boolean enabled = false
end type

event pb_cancelar::clicked;//No se aplica funcionalidad de deshacer
end event

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_almacen_traspaso
integer x = 37
string powertiptext = "Buscar por Descripción (F8)"
end type

event pb_buscar::clicked;string campo

dw_mover.reset()
dw_mover.visible = false

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
padre_busqueda.consulta =  " SELECT articulos.codigo, CONVERT(char(60),articulos.descripcion), almusos.descripcion, formatos.abreviado "+&
											" FROM articulos "+&
											" LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
											" LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
											" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(char(60), articulos.descripcion) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"
		padre_busqueda.titulos[3] = "Uso"
		padre_busqueda.titulos[4] = "Formato"
/*
choose case campo
	case "almacenmovimientos_articulo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT articulos.codigo, articulos.codigo, articulos.descripcion "+&
											" FROM articulos "+&
											" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, articulos.codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
	
	case "articulos_descripcion"
		padre_busqueda.consulta =  " SELECT articulos.codigo, articulos.descripcion "+&
											" FROM articulos "+&
											" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY articulos.descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"			
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT articulos.codigo, articulos.codigo, articulos.descripcion "+&
											" FROM articulos "+&
											" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, articulos.codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
end choose
*/

//call super :: clicked

long numero_valores, total
str_wt_busquedas_salida resultado_busqueda
integer columna
String articulos[1]

columna = dw_1.GetColumn()
OpenWithParm(wt_busquedas, padre_busqueda)
resultado_busqueda = Message.PowerObjectParm		// Devuelve el valor que encuentra ...
if resultado_busqueda.error = '' then
	numero_valores = UpperBound(resultado_busqueda.valores)
	if not isnull(numero_valores) and numero_valores >= 1 then
		total = dw_1.retrieve (codigo_empresa, resultado_busqueda.valores[1])
		if total > 0 then
			padre_codigo = resultado_busqueda.valores[1]
			estado = 1 // Modo edición
			articulos[1] = padre_codigo
			dw_pedidos.retrieve(codigo_empresa, articulos)
		else			
			MessageBox("Atención", "No queda stock en ninguna ubicación del artículo "+resultado_busqueda.valores[2])
		end if
	end if
else
	messagebox("Error", resultado_busqueda.error )
end if

mostrar_controles_edicion()

dw_1.setfocus()
if dw_1.rowcount() > 0 then
	dw_1.SetColumn(columna)
end if

end event

type dw_salidas from datawindow within wtc_mant_almacen_traspaso
integer x = 23
integer y = 1092
integer width = 5467
integer height = 1128
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_almacen_traspaso_dia"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_mover from u_dw within wtc_mant_almacen_traspaso
boolean visible = false
integer x = 1728
integer y = 884
integer width = 2139
integer height = 1188
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = ""
string dataobject = "dwtc_almacen_traspaso_aux"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;String familia, tipo_unidad, orden, almacen_destino, zona_destino, observaciones_destino, observaciones_nuevas, calidad, tono, tipo_pallet, caja
String almacen_origen, zona_origen
Int fila_alm_origen, altura_origen
String articulos[1]
Int fila_destino, altura_destino, calibre
Long fila, fila_origen
Dec piezas
Datetime fecha_intr

str_ventana_alerta parametros
string botones[2]

dw_mover.triggerevent("itemchanged") //Así recogemos todos los valores cuando se hace click en el botón
dw_salidas.accepttext( )

if dwo.name = "b_cancelar" then	
	dw_mover.visible = false
	dw_1.selectrow(0, false)
else
	if dwo.name = "b_salida" then 
		if this.object.id_bulto_destino[1] = this.object.id_bulto_origen[1] then
			f_traspaso_bulto_completo()
		else
			f_traspaso_bulto_parcial()
		end if
	end if
end if
end event

event itemchanged;call super::itemchanged;string resultado, almacen, zona, familia = ""
Int fila, altura, res2

this.Accepttext()

if isnull(row) then 
	return
end if 

CHOOSE CASE dwo.name
	CASE "mostrar_todos_los_bultos"
		this.Post Event itemchanged(row,this.object.piezas,string(this.object.piezas[row]))
	CASE "traspasar_reservado"
		if this.object.piezas_reservado[row] = 0 then
			return 2
		else
			if data = 'S' then
				this.object.id_bulto_destino[row] = this.object.id_bulto_origen[row]
			else
				this.object.id_bulto_destino[row] = 0
			end if			
			
			parent.post f_calcular_pallets_caja( 0, 0, this.object.piezas_reservado[row], "RESERVADO")
		end if
	CASE "traspasar_no_reservado"
		if this.object.piezas_no_reservado[row] = 0 then
			return 2
		else
			parent.post f_calcular_pallets_caja( 0 , 0, this.object.piezas_no_reservado[row], "NO RESERVADO")
		end if
	CASE "tipomov"
		SELECT descripcion
		INTO :resultado
		FROM almtipomov
		WHERE empresa = :codigo_empresa AND codigo_real = 'S' AND interno = 'N'  
		and tipomov = :data
		USING SQLCA;

		if SQLCA.sqlcode <> 100 then
			this.object.almtipomov_descripcion[Row] = resultado
		else
			dwo.Primary[row] = ''
			this.object.almtipomov_descripcion[Row] = ''
			return 2			
		end if
		
	CASE "pallets"
		f_calcular_pallets_caja(integer(data), 0 , 0, "TODO")
		this.event itemchanged(row,this.object.traspasar_reservado,this.object.traspasar_reservado[row])
	CASE "cajas"
		f_calcular_pallets_caja(0, integer(data), 0, "TODO")		
		this.event itemchanged(row,this.object.traspasar_reservado,this.object.traspasar_reservado[row])
	CASE "piezas"
		f_calcular_pallets_caja(0, 0 , dec(data), "TODO")		
		this.event itemchanged(row,this.object.traspasar_reservado,this.object.traspasar_reservado[row])
	CASE "pallets_no_reservado"
		f_calcular_pallets_caja(integer(data), 0 , 0, "NO RESERVADO")
		this.event itemchanged(row,this.object.traspasar_reservado,this.object.traspasar_reservado[row])
	CASE "cajas_no_reservado"
		f_calcular_pallets_caja(0, integer(data), 0, "NO RESERVADO")		
		this.event itemchanged(row,this.object.traspasar_reservado,this.object.traspasar_reservado[row])
	CASE "piezas_no_reservado"
		f_calcular_pallets_caja(0, 0 , dec(data), "NO RESERVADO")		
		this.event itemchanged(row,this.object.traspasar_reservado,this.object.traspasar_reservado[row])
	CASE "pallets_reservado"
		f_calcular_pallets_caja(integer(data), 0 , 0, "RESERVADO")
		this.event itemchanged(row,this.object.traspasar_reservado,this.object.traspasar_reservado[row])
	CASE "cajas_reservado"
		f_calcular_pallets_caja(0, integer(data), 0, "RESERVADO")		
		this.event itemchanged(row,this.object.traspasar_reservado,this.object.traspasar_reservado[row])
	CASE "piezas_reservado"
		f_calcular_pallets_caja(0, 0 , dec(data), "RESERVADO")				
		this.event itemchanged(row,this.object.traspasar_reservado,this.object.traspasar_reservado[row])
	CASE "almacen"
			SELECT  almalmacen.descripcion
			into :resultado
			FROM almalmacen 
			WHERE empresa = :codigo_empresa
			and almalmacen.codigo = :data
			USING SQLCA;
										
			if SQLCA.sqlcode <> 100 then
				//OK
				
				//NO PERMITIR TRASPASOS DESDE Y HACIA EL MUELLE DE DISTRIBUCIÓN - 08/2015
				almacen = data
				fila = this.object.fila[Row]
				zona = this.object.zona[Row]
				if almacen = "1" and zona = "P" and fila >= 10 then
					MessageBox("Error", "No se permite traspasar material al muelle de distribución (fila >= 10). Desprepare el material desde el mantenimiento de órdenes de preparación.")
					this.object.almacen[Row] 	= ''
					this.object.zona[Row] 	= ''
					this.object.fila[Row] 	= 0
					this.object.altura[Row] 	= 0
					return 2			
				end if
				
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
			and almubizonas.zona = :data
			USING SQLCA;
			
			if SQLCA.sqlcode <> 100 then
				//OK
				//NO PERMITIR TRASPASOS DESDE Y HACIA EL MUELLE DE DISTRIBUCIÓN - 08/2015
				almacen = this.object.almacen[Row]
				fila = this.object.fila[Row]
				if almacen = "1" and zona = "P" and fila >= 10 then
					MessageBox("Error", "No se permite traspasar material al muelle de distribución (fila >= 10). Desprepare el material desde el mantenimiento de órdenes de preparación.")
					this.object.zona[Row] 		= ''
					this.object.fila[Row] 	= 0
					this.object.altura[Row] 	= 0
					return 2			
				end if
				
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
				and almubimapa.fila_desde <= :fila AND almubimapa.fila_hasta >= :fila
				USING SQLCA;
				
				if SQLCA.sqlcode <> 100 then
					//OK
					//NO PERMITIR TRASPASOS DESDE Y HACIA EL MUELLE DE DISTRIBUCIÓN - 08/2015
					almacen = this.object.almacen[Row]
					zona = this.object.zona[Row]
					if almacen = "1" and zona = "P" and fila >= 10 then
						MessageBox("Error", "No se permite traspasar material al muelle de distribución (fila >= 10). Desprepare el material desde el mantenimiento de órdenes de preparación.")
						this.object.fila[Row] 	= 0
						this.object.altura[Row] 	= 0
						return 2			
					end if
					
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
				and almubimapa.altura_desde <= :altura AND almubimapa.altura_hasta >= :altura
				USING SQLCA;
				
				if SQLCA.sqlcode <> 100 then
					//OK
					
					//NO PERMITIR TRASPASOS DESDE Y HACIA EL MUELLE DE DISTRIBUCIÓN - 08/2015
					almacen = this.object.almacen[Row]
					fila = this.object.fila[Row]
					zona = this.object.zona[Row]
					if almacen = "1" and zona = "P" and fila >= 10 then
						MessageBox("Error", "No se permite traspasar material al muelle de distribución (fila >= 10). Desprepare el material desde el mantenimiento de órdenes de preparación.")
						this.object.altura[Row] 	= 0
						return 2			
					else
						this.Post Event itemchanged(row,this.object.piezas,string(this.object.piezas[row]))
					end if
					
				else
					this.object.altura[Row] 	= 0
					return 2			
				end if
			end if
END CHOOSE

//this.Accepttext()
end event

event usr_dwnkey;call super::usr_dwnkey;string campo, almacen, familia = ""
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "tipomov"
			busqueda.titulo_ventana = "Búsqueda de Tipos de Movimiento"
			busqueda.consulta  = " SELECT tipomov, resumido, descripcion "+&
										" FROM almtipomov "+&
										" WHERE empresa = '"+codigo_empresa+"' AND codigo_real = 'S' AND interno = 'N' "+&
										" ORDER BY CONVERT(integer, tipomov) "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Abreviado"
			busqueda.titulos[3] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.tipomov[this.GetRow()] 					= resultado.valores[1]		
				this.object.almtipomov_descripcion[this.GetRow()] = resultado.valores[3]		
			end if
			
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

event losefocus;call super::losefocus;this.triggerevent("itemchanged")
end event

type pb_busqueda_codigo from picturebutton within wtc_mant_almacen_traspaso
integer x = 197
integer y = 116
integer width = 146
integer height = 128
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Preview_32x32.png"
alignment htextalign = right!
string powertiptext = "Busqueda por Codigo"
end type

event clicked;string campo

dw_mover.reset()
dw_mover.visible = false

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = true
padre_busqueda.consulta =  " SELECT articulos.codigo, articulos.codigo, CONVERT(char(60),articulos.descripcion), almusos.descripcion, formatos.abreviado "+&
									" FROM articulos "+&
									" LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
									" LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
									" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(char(60), articulos.descripcion) ASC"

padre_busqueda.titulos[1] = "Código"
padre_busqueda.titulos[2] = "Código"
padre_busqueda.titulos[3] = "Descripción"
padre_busqueda.titulos[4] = "Uso"
padre_busqueda.titulos[5] = "Formato"

long numero_valores, total
str_wt_busquedas_salida resultado_busqueda
integer columna
String articulos[1]

columna = dw_1.GetColumn()
OpenWithParm(wt_busquedas, padre_busqueda)
resultado_busqueda = Message.PowerObjectParm		// Devuelve el valor que encuentra ...
if resultado_busqueda.error = '' then
	numero_valores = UpperBound(resultado_busqueda.valores)
	if not isnull(numero_valores) and numero_valores >= 1 then
		total = dw_1.retrieve (codigo_empresa, resultado_busqueda.valores[1])
		if total > 0 then
			padre_codigo = resultado_busqueda.valores[1]
			estado = 1 // Modo edición
			articulos[1] = padre_codigo
			dw_pedidos.retrieve(codigo_empresa, articulos)
		else
			MessageBox("Atención", "No queda stock en ninguna ubicación del artículo "+resultado_busqueda.valores[3])
		end if
	end if
else
	messagebox("Error", resultado_busqueda.error )
end if

mostrar_controles_edicion()

dw_1.setfocus()
if dw_1.rowcount() > 0 then
	dw_1.SetColumn(columna)
end if

end event

type dw_pedidos from datawindow within wtc_mant_almacen_traspaso
integer x = 23
integer y = 2300
integer width = 5467
integer height = 676
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ver_pedidos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within wtc_mant_almacen_traspaso
integer x = 23
integer y = 2232
integer width = 5477
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

