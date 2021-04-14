$PBExportHeader$wtc_mant_archivos_disenyo.srw
forward
global type wtc_mant_archivos_disenyo from wt_ventana_padre
end type
type pb_archivos_modelo from picturebutton within wtc_mant_archivos_disenyo
end type
end forward

global type wtc_mant_archivos_disenyo from wt_ventana_padre
integer width = 1929
integer height = 1196
string title = "Mantenimiento de Archivos"
pb_archivos_modelo pb_archivos_modelo
end type
global wtc_mant_archivos_disenyo wtc_mant_archivos_disenyo

forward prototypes
public function integer f_guardar ()
public function integer f_borrar ()
public function boolean f_post_asignar_codigo_padre ()
end prototypes

public function integer f_guardar ();//LLAMAMOS CON super::funcion() al padre para continuar la ejecución del guardado
String prefijo, nombre
string campo, motivo
boolean falta_Campo
Int resultado

Int n_pantallas, n_pantallas_actuales, capacidad_actual, ubicacion
String tipo_pantallas, tipo_pantallas_actual

//Boolean hay_transaccion = false

resultado = 1 //Todo ok si devolvemos 1

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_1 

dw_1.accepttext()
falta_campo = false
if dw_1.rowcount() > 0 then
	if IsNull(dw_1.object.archivo_disenyo_tipomaquina_disenyo[dw_1.getrow()]) or Trim(String(dw_1.object.archivo_disenyo_tipomaquina_disenyo[dw_1.getrow()])) = "" then
		  campo = "archivo_disenyo_tipomaquina_disenyo"
		  motivo = "Campo Obligatorio: Tipo Máquina. "
		  falta_campo = True
	end if
	
	if not IsNull(dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()]) and dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()] > 0 and dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()] <> 0 then
		if IsNull(dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()]) or dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()] <= 0 then
		  campo = "archivo_disenyo_n_pantallas"
		  motivo = "Campo Obligatorio: Número de Pantallas. "
		  falta_campo = True
		end if
		if IsNull(dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()]) or Trim(String(dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()])) = "" then
			  campo = "archivo_disenyo_tipo_pantallas"
			  motivo = "Campo Obligatorio: Tipo de Pantallas. "
			  falta_campo = True
		end if
	end if
	
	//ALAMACÉN DE PANTALLAS ********************************************************************************************************************************************************
	if not IsNull(dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()]) and dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()] > 0 then
		if IsNull(dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()]) or Trim(String(dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()])) = "" then
			  campo = "archivo_disenyo_tipo_pantallas"
			  motivo = "Campo Obligatorio: Tipo de Pantallas. "
			  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
			  dw_1.setfocus()
			  dw_1.SetColumn(campo)
			  return 0
		else
			n_pantallas = dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()]
			tipo_pantallas = dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()]
			ubicacion = dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()]
			
			if not IsNull(ubicacion) and ubicacion > 0 then
				//Comprobamos que haya espacio en la ubicación indicada
				SELECT capacidad, tipo_pantallas INTO :capacidad_actual, :tipo_pantallas_actual FROM almacen_laboratorio WHERE empresa = :codigo_empresa AND codigo = :ubicacion USING trans_ts;
				if tipo_pantallas <> tipo_pantallas_actual then
					MessageBox("Error Inserción en Almacén de Pantallas", "La ubicación seleccionada no corresponde con el Tipo de Ubicación indicado. Deje en blanco la ubicación si desee que se asigne automáticamente una ubicación óptima." ,Exclamation!, OK!,1)
					ROLLBACK USING trans_ts;
					return -1
				end if
				if f_codigo_principal() <> "" then
					SELECT SUM(n_pantallas) INTO :n_pantallas_actuales FROM archivo_disenyo WHERE empresa = :codigo_empresa AND tipo_pantallas = :tipo_pantallas AND ubicacion = :ubicacion AND codigo <> :padre_codigo USING trans_ts;
				else
					SELECT SUM(n_pantallas) INTO :n_pantallas_actuales FROM archivo_disenyo WHERE empresa = :codigo_empresa AND tipo_pantallas = :tipo_pantallas AND ubicacion = :ubicacion USING trans_ts;
				end if
				if isnull(n_pantallas_actuales) then 
					n_pantallas_actuales = 0
				end if
				if n_pantallas_actuales + n_pantallas > capacidad_actual then
					//MessageBox("Error Inserción en Almacén de Pantallas", "No existe espacio en la ubicación seleccionada del almacén. Deje en blanco la ubicación si desee que se asigne automáticamente una ubicación óptima." ,Exclamation!, OK!,1)
					ROLLBACK USING trans_ts;
					if MessageBox("Error Inserción en Almacén de Pantallas", "No existe espacio en el almacén para el número de pantallas y tipo indicados. ¿Desea buscar una nueva ubicación?" ,Question!, YesNo!, 2) = 1 then
						dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()] = 0
						f_guardar()
					end if					
					return -1
				end if
			else
				//Buscamos espacio en la ubicación optima
				SELECT TOP 1 almacen_laboratorio.codigo, almacen_laboratorio.capacidad - ISNULL(SUM(archivo_disenyo.n_pantallas),0) as disponibles 
				INTO :ubicacion, :capacidad_actual 
				FROM almacen_laboratorio 
				LEFT OUTER JOIN archivo_disenyo ON archivo_disenyo.empresa = almacen_laboratorio.empresa AND archivo_disenyo.tipo_pantallas = almacen_laboratorio.tipo_pantallas AND archivo_disenyo.ubicacion = almacen_laboratorio.codigo
				WHERE almacen_laboratorio.empresa = :codigo_empresa 
				AND almacen_laboratorio.tipo_pantallas = :tipo_pantallas 
				GROUP BY almacen_laboratorio.codigo, almacen_laboratorio.capacidad 
				HAVING almacen_laboratorio.capacidad - ISNULL(SUM(archivo_disenyo.n_pantallas),0) >= :n_pantallas  
				ORDER BY disponibles ASC 
				USING trans_ts;
				
				if not isnull(ubicacion) and ubicacion > 0 then
					dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()] = ubicacion
				else
					MessageBox("Error Inserción en Almacén de Pantallas", "No existe espacio en el almacén para el número de pantallas y tipo indicados." ,Exclamation!, OK!,1)
					ROLLBACK USING trans_ts;
					return -1
				end if
			end if
		end if
	else
		//Quitamos del almacén en caso de estar si n_pantallas es null o 0
		dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()] = 0
		dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()] = ""
		dw_1.object.almacen_laboratorio_tipo_descripcion[dw_1.getrow()] = ""
		dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()] = 0
	end if
	//FIN ALMACÉN PANTALLAS ********************************************************************************************************************************************************
	
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

/************************************************/
//Parámetros de colisiones
//El codigo va por tipo de máquina!!!

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "archivo_disenyo"
param_colisiones.campo = "codigo"
param_colisiones.filtro = param_colisiones.tabla+".tipomaquina_disenyo = '"+dw_1.object.archivo_disenyo_tipomaquina_disenyo[dw_1.getrow()]+"'"				
param_colisiones.buscar_huecos = true

rtn = super::f_guardar()

IF rtn = 1 THEN
	COMMIT USING trans_ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_ts;
END IF

estado = 1 // Modo edición
dw_1.SetTransObject(SQLCA)

return rtn



/*
//LLAMAMOS CON super::funcion() al padre para continuar la ejecución del guardado
String prefijo, nombre
string campo, motivo
boolean falta_Campo
Int resultado

Int n_pantallas, n_pantallas_actuales, capacidad_actual, ubicacion
String tipo_pantallas, tipo_pantallas_actual

Boolean hay_transaccion = false

resultado = 1 //Todo ok si devolvemos 1

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_1 

dw_1.accepttext()
falta_campo = false
if dw_1.rowcount() > 0 then
	if IsNull(dw_1.object.archivo_disenyo_tipomaquina_disenyo[dw_1.getrow()]) or Trim(String(dw_1.object.archivo_disenyo_tipomaquina_disenyo[dw_1.getrow()])) = "" then
		  campo = "archivo_disenyo_tipomaquina_disenyo"
		  motivo = "Campo Obligatorio: Tipo Máquina. "
		  falta_campo = True
	end if
	
	if not IsNull(dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()]) and dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()] > 0 and dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()] <> 0 then
		if IsNull(dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()]) or dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()] <= 0 then
		  campo = "archivo_disenyo_n_pantallas"
		  motivo = "Campo Obligatorio: Número de Pantallas. "
		  falta_campo = True
		end if
		if IsNull(dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()]) or Trim(String(dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()])) = "" then
			  campo = "archivo_disenyo_tipo_pantallas"
			  motivo = "Campo Obligatorio: Tipo de Pantallas. "
			  falta_campo = True
		end if
	end if
	
	//ALAMACÉN DE PANTALLAS ********************************************************************************************************************************************************
	if not IsNull(dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()]) and dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()] > 0 then
		if IsNull(dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()]) or Trim(String(dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()])) = "" then
			  campo = "archivo_disenyo_tipo_pantallas"
			  motivo = "Campo Obligatorio: Tipo de Pantallas. "
			  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
			  dw_1.setfocus()
			  dw_1.SetColumn(campo)
			  return 0
		else
			n_pantallas = dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()]
			tipo_pantallas = dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()]
			ubicacion = dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()]
			
			//Crear transacción YA
			hay_transaccion = true
			f_crear_transaccion(transaccion ,"" ,"" ,false, "TS","")	
			CONNECT USING transaccion;
			
			if not IsNull(ubicacion) and ubicacion > 0 then
				//Comprobamos que haya espacio en la ubicación indicada
				SELECT capacidad, tipo_pantallas INTO :capacidad_actual, :tipo_pantallas_actual FROM almacen_laboratorio WHERE empresa = :codigo_empresa AND codigo = :ubicacion USING transaccion;
				if tipo_pantallas <> tipo_pantallas_actual then
					MessageBox("Error Inserción en Almacén de Pantallas", "La ubicación seleccionada no corresponde con el Tipo de Ubicación indicado. Deje en blanco la ubicación si desee que se asigne automáticamente una ubicación óptima." ,Exclamation!, OK!,1)
					ROLLBACK USING transaccion;
					DISCONNECT USING transaccion;
					return -1
				end if
				if f_codigo_principal() <> "" then
					SELECT SUM(n_pantallas) INTO :n_pantallas_actuales FROM archivo_disenyo WHERE empresa = :codigo_empresa AND tipo_pantallas = :tipo_pantallas AND ubicacion = :ubicacion AND codigo <> :padre_codigo USING transaccion;
				else
					SELECT SUM(n_pantallas) INTO :n_pantallas_actuales FROM archivo_disenyo WHERE empresa = :codigo_empresa AND tipo_pantallas = :tipo_pantallas AND ubicacion = :ubicacion USING transaccion;
				end if
				if isnull(n_pantallas_actuales) then 
					n_pantallas_actuales = 0
				end if
				if n_pantallas_actuales + n_pantallas > capacidad_actual then
					//MessageBox("Error Inserción en Almacén de Pantallas", "No existe espacio en la ubicación seleccionada del almacén. Deje en blanco la ubicación si desee que se asigne automáticamente una ubicación óptima." ,Exclamation!, OK!,1)
					ROLLBACK USING transaccion;
					DISCONNECT USING transaccion;
					if MessageBox("Error Inserción en Almacén de Pantallas", "No existe espacio en el almacén para el número de pantallas y tipo indicados. ¿Desea buscar una nueva ubicación?" ,Question!, YesNo!, 2) = 1 then
						dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()] = 0
						f_guardar()
					end if					
					return -1
				end if
			else
				//Buscamos espacio en la ubicación optima
				SELECT TOP 1 almacen_laboratorio.codigo, almacen_laboratorio.capacidad - ISNULL(SUM(archivo_disenyo.n_pantallas),0) as disponibles 
				INTO :ubicacion, :capacidad_actual 
				FROM almacen_laboratorio 
				LEFT OUTER JOIN archivo_disenyo ON archivo_disenyo.empresa = almacen_laboratorio.empresa AND archivo_disenyo.tipo_pantallas = almacen_laboratorio.tipo_pantallas AND archivo_disenyo.ubicacion = almacen_laboratorio.codigo
				WHERE almacen_laboratorio.empresa = :codigo_empresa 
				AND almacen_laboratorio.tipo_pantallas = :tipo_pantallas 
				GROUP BY almacen_laboratorio.codigo, almacen_laboratorio.capacidad 
				HAVING almacen_laboratorio.capacidad - ISNULL(SUM(archivo_disenyo.n_pantallas),0) >= :n_pantallas  
				ORDER BY disponibles ASC 
				USING transaccion;
				if not isnull(ubicacion) and ubicacion > 0 then
					dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()] = ubicacion
				else
					MessageBox("Error Inserción en Almacén de Pantallas", "No existe espacio en el almacén para el número de pantallas y tipo indicados." ,Exclamation!, OK!,1)
					ROLLBACK USING transaccion;
					DISCONNECT USING transaccion;
					return -1
				end if
			end if
		end if
	else
		//Quitamos del almacén en caso de estar si n_pantallas es null o 0
		dw_1.object.archivo_disenyo_n_pantallas[dw_1.getrow()] = 0
		dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()] = ""
		dw_1.object.almacen_laboratorio_tipo_descripcion[dw_1.getrow()] = ""
		dw_1.object.archivo_disenyo_ubicacion[dw_1.getrow()] = 0
	end if
	//FIN ALMACÉN PANTALLAS ********************************************************************************************************************************************************
	
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

/************************************************/
//Parámetros de colisiones
//El codigo va por tipo de máquina!!!

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "archivo_disenyo"
param_colisiones.campo = "codigo"
param_colisiones.filtro = param_colisiones.tabla+".tipomaquina_disenyo = '"+dw_1.object.archivo_disenyo_tipomaquina_disenyo[dw_1.getrow()]+"'"				
param_colisiones.buscar_huecos = true

// El primer campo del datawindow será el que reciba el código generado. 
// Por tanto, al crear el datawindow maestro debemos situar en primera posición dicho campo
dw_1.accepttext()

//Codigo por si se desea mostrar aviso antes de guardar (Por defecto NO, si no utilizar Message.DoubleParm = 10001)

//Transacción creada en el almacen de pantallas
if not hay_transaccion then
	f_crear_transaccion(transaccion ,"" ,"" ,false, "TS","")	
	//ftc_crear_transaccion(transaccion ,param_transaccion)	
	CONNECT USING transaccion;
end if
dw_1.SetTransObject(transaccion)	

if dw_1.rowcount() > 0 then
	dw_1.object.archivo_disenyo_empresa[dw_1.getrow()] = codigo_empresa		
	if String(dw_1.object.#1[dw_1.getrow()]) = '' or isnull (dw_1.object.#1[dw_1.getrow()]) then
		padre_codigo = String(f_colisiones ( transaccion, param_colisiones))
		if padre_codigo = '0'  then
			messagebox("ERROR", "No se puede asignar un código.")
			rtn = -1
			ROLLBACK USING transaccion;
			DISCONNECT USING transaccion;
			dw_1.SetTransObject(SQLCA)	
		else
			dw_1.object.#1[dw_1.getrow()] = padre_codigo
			
			
			/*********************************************************************************/
			// Creación del nombre para el fichero
			prefijo = dw_1.object.tipomaquina_disenyo_prefijo[dw_1.getrow()]
			nombre = prefijo + padre_codigo
			dw_1.object.archivo_disenyo_nombre[dw_1.getrow()] = nombre
			/*********************************************************************************/
			
			rtn = 1
		end if
	end if
end if

if rtn <> -1 then
	rtn = dw_1.Update()
end if
/******************************************************/


IF rtn = 1 THEN
	COMMIT USING transaccion;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING transaccion;
END IF
DISCONNECT USING transaccion;
dw_1.SetTransObject(SQLCA)	

destroy transaccion

estado = 1 // Modo edición

return rtn

*/
end function

public function integer f_borrar ();Long total, total2
String tipo

//Comprobaciones previas

padre_codigo = dw_1.object.#1[dw_1.GetRow()]
tipo = dw_1.object.archivo_disenyo_tipomaquina_disenyo[dw_1.GetRow()]

total = 0
total2 = 0

select count(*) 
into :total
from modelo_archivo
where empresa = :codigo_empresa 
and tipo_maquina_disenyo = :tipo 
and archivo_disenyo = :padre_codigo using trans_ts;

select count(*) 
into :total2
from archivo_disenyo_sistema_archivos
where empresa = :codigo_empresa 
and tipomaquina_disenyo = :tipo 
and archivo = :padre_codigo using trans_ts;

if (total + total2) > 0 then
	messagebox("Aviso", "No se puede borrar el archivo porque hay piezas que lo usan y/o ficheros de diseño asociados")
	rtn = -1
	
else
	rtn = super::f_borrar()	
end if

return rtn
end function

public function boolean f_post_asignar_codigo_padre ();string prefijo, nombre

// Creación del nombre para el fichero
prefijo = dw_1.object.tipomaquina_disenyo_prefijo[dw_1.getrow()]
nombre = prefijo + padre_codigo
dw_1.object.archivo_disenyo_nombre[dw_1.getrow()] = nombre

return true

end function

on wtc_mant_archivos_disenyo.create
int iCurrent
call super::create
this.pb_archivos_modelo=create pb_archivos_modelo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_archivos_modelo
end on

on wtc_mant_archivos_disenyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_archivos_modelo)
end on

event open;
String tipo
str_parametros lstr_param

cerrar_sin_abrir = false
dw_1.SetTransObject(SQLCA)
//PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana FROM uti_permisos_ventana P INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	pb_grabar.visible = false
//	pb_borrar.visible = false
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
//else
	
	pb_nuevo.triggerevent(clicked!)
	
	mostrar_controles_insercion()
	
	select nombre
	into :st_titulo.text
	from empresas
	where empresa = :codigo_empresa;
	
	// Si recibo el codigo lo visualizo
	lstr_param = Message.PowerObjectParm
	
	nombre_ventana_invoca = lstr_param.s_titulo_ventana
	IF lstr_param.i_nargumentos >= 2 THEN
		ventana_invoca = lstr_param.nombre_ventana
		if not isnull(lstr_param.s_argumentos[1]) and lstr_param.s_argumentos[1] <> "" and not isnull(lstr_param.s_argumentos[2]) and lstr_param.s_argumentos[2] <> "" then
			padre_codigo = lstr_param.s_argumentos[1]
			tipo = lstr_param.s_argumentos[2]
			if dw_1.retrieve (codigo_empresa, padre_codigo, tipo) <> 1 then
				padre_codigo = ""
				pb_nuevo.triggerevent(clicked!)
				mostrar_controles_insercion()
			else
				estado = 1 // Modo edición
				mostrar_controles_edicion()
			end if
		end if
	END IF
	
	dw_1.SetFocus()
//end if


end event

event activate;call super::activate;if permiso_ventana = 1 then
	//Solo lectura
	pb_grabar.visible = false
	pb_borrar.visible = false
end if
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_archivos_disenyo
boolean visible = false
integer x = 649
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_archivos_disenyo
integer x = 1381
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_archivos_disenyo
integer width = 1856
integer height = 736
string title = "Mantenimiento de Archivos de Diseño"
string dataobject = "dwtc_archivos_disenyo"
boolean border = false
end type

event dw_1::usr_keydown;call super::usr_keydown;string campo, codigo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "archivo_disenyo_tipomaquina_disenyo"
			codigo = dw_1.object.#1[dw_1.getrow()]
			if not isnull(codigo) and codigo <> "" then
				MessageBox("Error", "No se permite modificar el tipo de máquina de un archivo dado de alta.")
				return
			end if
			
			busqueda.titulo_ventana = "Búsqueda de Serie"
			busqueda.consulta  =  "  SELECT tipomaquina_disenyo.codigo, tipomaquina_disenyo.descripcion, tipomaquina_disenyo.prefijo "+&
										 "  FROM   tipomaquina_disenyo   "+&
										 "  WHERE  tipomaquina_disenyo.empresa = '"+codigo_empresa+"'"+&
	 									 "  ORDER BY tipomaquina_disenyo.descripcion ASC  "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Tipo de Máquina"
			busqueda.titulos[3] = "Prefijo"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.archivo_disenyo_tipomaquina_disenyo[this.GetRow()] 			= resultado.valores[1]		
				this.object.tipomaquina_disenyo_descripcion[this.GetRow()] 					= resultado.valores[2]	
				this.object.tipomaquina_disenyo_prefijo[this.GetRow()] 						= resultado.valores[3]
				this.object.archivo_disenyo_tipomaquina_disenyo_actual[this.GetRow()]	= resultado.valores[1]
			end if
			
		CASE "archivo_disenyo_tipo_pantallas"
			
			busqueda.titulo_ventana = "Búsqueda de Tipo de Ubicaciones"
			busqueda.consulta  = " SELECT codigo, abreviado, descripcion "+&
										" FROM almacen_laboratorio_tipo "+&
										" WHERE empresa = '"+codigo_empresa+"' "+&
										" ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Abreviado"
			busqueda.titulos[3] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.archivo_disenyo_tipo_pantallas[dw_1.getrow()] 			= resultado.valores[1]		
				dw_1.object.almacen_laboratorio_tipo_descripcion[dw_1.getrow()]	= resultado.valores[3]		
			end if
			
	END CHOOSE
end if
end event

event dw_1::itemchanged;call super::itemchanged;string codigo, resultado, resultado2

this.Accepttext()

CHOOSE CASE dwo.name

	CASE "archivo_disenyo_tipomaquina_disenyo"
		codigo = dw_1.object.#1[dw_1.getrow()]
		if not isnull(codigo) and codigo <> "" then
			MessageBox("Error", "No se permite modificar el tipo de máquina de un archivo dado de alta.")
			dwo.Primary[row] = this.object.archivo_disenyo_tipomaquina_disenyo_actual[Row]
			return 2
		end if
		
		SELECT descripcion, prefijo
		INTO :resultado, :resultado2 
		FROM tipomaquina_disenyo
		WHERE empresa = :codigo_empresa
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tipomaquina_disenyo_descripcion[Row]	= resultado
			this.object.tipomaquina_disenyo_prefijo[Row] 		= resultado2
			this.object.archivo_disenyo_tipomaquina_disenyo_actual[Row]  = resultado
		else
			dwo.Primary[row] = ''
			this.object.tipomaquina_disenyo_descripcion[Row]	= ''
			this.object.tipomaquina_disenyo_prefijo[Row] 		= ''
			return 2			
		end if
	
	CASE "archivo_disenyo_tipo_pantallas"
			SELECT almacen_laboratorio_tipo.descripcion
			INTO :resultado
			FROM almacen_laboratorio_tipo
			WHERE empresa = :codigo_empresa
			and almacen_laboratorio_tipo.codigo = :data;
	
			if SQLCA.sqlcode <> 100 then
				this.object.almacen_laboratorio_tipo_descripcion[Row] = resultado
			else
				dwo.Primary[row] = ''
				this.object.almacen_laboratorio_tipo_descripcion[Row] = ''
				return 2			
			end if
			
END CHOOSE


this.Accepttext()
end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param
long esta_abierta


CHOOSE CASE dwo.name

	CASE "p_tipo"
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_tipomaquina_disenyo")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = this.object.archivo_disenyo_tipomaquina_disenyo[row]
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "wtc_mant_archivos_disenyo"
			lstr_param.resultado = ''
			Openwithparm(wtc_mant_tipomaquina_disenyo, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
	CASE "p_tipo_pant"
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_almacen_laboratorio_tipo")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = this.object.archivo_disenyo_tipo_pantallas[row]
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "wtc_mant_archivos_disenyo"
			lstr_param.resultado = ''
			Openwithparm(wtc_mant_almacen_laboratorio_tipo, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
END CHOOSE
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_archivos_disenyo
integer x = 1426
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_archivos_disenyo
integer x = 1737
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_archivos_disenyo
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_archivos_disenyo
integer width = 1257
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_archivos_disenyo
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_archivos_disenyo
integer x = 1582
end type

event pb_cancelar::clicked;String tipo
if estado = 1 then
	padre_codigo = dw_1.object.#1[dw_1.getrow()]
	tipo = dw_1.object.archivo_disenyo_tipomaquina_disenyo[dw_1.getrow()]
	dw_1.retrieve (codigo_empresa, padre_codigo, tipo)
	mostrar_controles_edicion()
elseif estado = 0 then
	pb_nuevo.triggerevent (clicked!)
	mostrar_controles_insercion()
end if

dw_1.setfocus()
dw_1.setcolumn(2)
end event

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_archivos_disenyo
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT archivo_disenyo.codigo, archivo_disenyo.codigo, archivo_disenyo.tipomaquina_disenyo, archivo_disenyo.nombre "+&
											" FROM archivo_disenyo "+&
											" WHERE archivo_disenyo.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, archivo_disenyo.tipomaquina_disenyo) ASC, CONVERT(INTEGER, archivo_disenyo.codigo) ASC"
		//Ojo clave primaria
		padre_busqueda.titulos[1] = "Código"	
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Tipo Máquina"
		padre_busqueda.titulos[4] = "Nombre"	
	
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT archivo_disenyo.codigo, archivo_disenyo.codigo, archivo_disenyo.tipomaquina_disenyo, archivo_disenyo.nombre "+&
											" FROM archivo_disenyo "+&
											" WHERE archivo_disenyo.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, archivo_disenyo.tipomaquina_disenyo) ASC, CONVERT(INTEGER, archivo_disenyo.codigo) ASC"
		//Ojo clave primaria
		padre_busqueda.titulos[1] = "Código"	
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Tipo Máquina"
		padre_busqueda.titulos[4] = "Nombre"	
end choose

//No podemos llamar al padre (Clave primaria compuesta)
//call super :: clicked

long numero_valores
str_wt_busquedas_salida resultado_busqueda
integer columna

columna = dw_1.GetColumn()
OpenWithParm(wt_busquedas, padre_busqueda)
resultado_busqueda = Message.PowerObjectParm		// Devuelve el valor que encuentra ...
if resultado_busqueda.error = '' then
	numero_valores = UpperBound(resultado_busqueda.valores)
	if not isnull(numero_valores) and numero_valores >= 1 then
		dw_1.retrieve (codigo_empresa, resultado_busqueda.valores[1], resultado_busqueda.valores[3])
		padre_codigo = dw_1.object.#1[1]
		estado = 1 // Modo edición
	else
		padre_codigo = ""
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

type pb_archivos_modelo from picturebutton within wtc_mant_archivos_disenyo
integer x = 494
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
string picturename = "C:\Tencer_PB12\index.png"
alignment htextalign = left!
string powertiptext = "Archivos del Modelo"
end type

event clicked;str_parametros lstr_param
long esta_abierta

if hay_cambios() then
	MessageBox("Atención", "Debe guardar los cambios antes de gestionar los archivos de disenyo")
	return
end if

if f_codigo_principal() = "" then
	return
end if

//La ventana será response
lstr_param.s_argumentos[1] = dw_1.object.archivo_disenyo_tipomaquina_disenyo[1]
lstr_param.s_argumentos[2] = dw_1.object.archivo_disenyo_codigo[1]
lstr_param.s_argumentos[3] = dw_1.object.archivo_disenyo_nombre[1]
lstr_param.i_nargumentos = 3
lstr_param.nombre_ventana = "wtc_mant_archivos_disenyo"
lstr_param.resultado = ''
Openwithparm(wtc_mant_archivos_disenyo_sistema_archivos, lstr_param)

end event

