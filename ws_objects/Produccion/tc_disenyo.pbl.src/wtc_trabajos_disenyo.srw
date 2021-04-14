$PBExportHeader$wtc_trabajos_disenyo.srw
forward
global type wtc_trabajos_disenyo from wt_ventana_padre
end type
type pb_borrar_trabajo from picturebutton within wtc_trabajos_disenyo
end type
type pb_duplica_trabajo from picturebutton within wtc_trabajos_disenyo
end type
type pb_anyade_trabajo from picturebutton within wtc_trabajos_disenyo
end type
type pb_1 from picturebutton within wtc_trabajos_disenyo
end type
type pb_borrar_historico from picturebutton within wtc_trabajos_disenyo
end type
type pb_anyade_historico from picturebutton within wtc_trabajos_disenyo
end type
type p_imagen from picture within wtc_trabajos_disenyo
end type
type st_2 from statictext within wtc_trabajos_disenyo
end type
type r_1 from rectangle within wtc_trabajos_disenyo
end type
type dw_historicomodelo from u_dw_padre within wtc_trabajos_disenyo
end type
type dw_con_piezas_coleccion from u_dw_padre within wtc_trabajos_disenyo
end type
type cb_pasar_pieza from commandbutton within wtc_trabajos_disenyo
end type
type cb_generar_pieza from commandbutton within wtc_trabajos_disenyo
end type
type cb_generar_coleccion from commandbutton within wtc_trabajos_disenyo
end type
type dw_ficha_comercial from datawindow within wtc_trabajos_disenyo
end type
type cb_fecha_coleccion from commandbutton within wtc_trabajos_disenyo
end type
type dwtc_mant_trabajos_disenyo from u_dw within wtc_trabajos_disenyo
end type
type p_seleccion from picture within wtc_trabajos_disenyo
end type
type pb_anyade_archivo from picturebutton within wtc_trabajos_disenyo
end type
type pb_borrar_archivo from picturebutton within wtc_trabajos_disenyo
end type
type dw_archivos from u_dw within wtc_trabajos_disenyo
end type
type dw_fecha_necesidad from datawindow within wtc_trabajos_disenyo
end type
end forward

global type wtc_trabajos_disenyo from wt_ventana_padre
integer width = 5609
integer height = 3156
string title = "Trabajos diseño"
pb_borrar_trabajo pb_borrar_trabajo
pb_duplica_trabajo pb_duplica_trabajo
pb_anyade_trabajo pb_anyade_trabajo
pb_1 pb_1
pb_borrar_historico pb_borrar_historico
pb_anyade_historico pb_anyade_historico
p_imagen p_imagen
st_2 st_2
r_1 r_1
dw_historicomodelo dw_historicomodelo
dw_con_piezas_coleccion dw_con_piezas_coleccion
cb_pasar_pieza cb_pasar_pieza
cb_generar_pieza cb_generar_pieza
cb_generar_coleccion cb_generar_coleccion
dw_ficha_comercial dw_ficha_comercial
cb_fecha_coleccion cb_fecha_coleccion
dwtc_mant_trabajos_disenyo dwtc_mant_trabajos_disenyo
p_seleccion p_seleccion
pb_anyade_archivo pb_anyade_archivo
pb_borrar_archivo pb_borrar_archivo
dw_archivos dw_archivos
dw_fecha_necesidad dw_fecha_necesidad
end type
global wtc_trabajos_disenyo wtc_trabajos_disenyo

type variables

end variables

forward prototypes
public function boolean f_duplicar (integer tipo)
public function boolean hay_cambios ()
public function integer f_guardar ()
public function integer f_borrar ()
public subroutine mostrar_controles_insercion ()
public subroutine mostrar_controles_edicion ()
end prototypes

public function boolean f_duplicar (integer tipo);// Parametro
// Si recibe 1 ---> Generar una colección nueva con una pieza y un trabajo identicos al seleccionado.
// Si recibe 2 ---> Generar una pieza dentro de la misma coleccion con los datos del trabajo seleccionado.
// Si recibe 3 ---> 

boolean exito 
string ambiente, disenyador, estado2, observaciones_col, comercial, comercial_trabajo, codigo
string pieza, funcion, observaciones_pz, laboratorio, pavrev
string serie, relieve, formato, pasta, acabado_lab, contratipo, aceptado, base_cliente, base, observaciones_trab 
datetime fecha_solicitud, fecha_necesidad, fecha_lab
long max_coleccion, trabajo, modelo, fila
string v_coleccion, grafica

v_coleccion = 	dw_1.object.coleccion[dw_1.GetRow()]

exito = true
fila = dw_1.getrow()
codigo = f_codigo_principal()
if not isnull(codigo) and codigo <> '' then
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 										 Carga de los datos de la  colección										//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	select ambiente, disenyador, comercial, observaciones, grafica
	into :ambiente, :disenyador, :comercial, :observaciones_col, :grafica
	from descoleccionsol
	where empresa = :codigo_empresa
	and codigo = :v_coleccion;
	
	estado2 = "DISPONIBLE"
	
	if tipo = 1 then
		select max(convert(integer, codigo))
		into :max_coleccion
		from descoleccionsol
		where empresa = :codigo_empresa
		using SQLCA;
		
		max_coleccion = max_coleccion + 1
	
		insert into descoleccionsol (empresa, codigo, ambiente, disenyador, estado, observaciones, comercial, grafica)
		values (:codigo_empresa, :max_coleccion, :ambiente, :disenyador, :estado, :observaciones_col, :comercial, :grafica)
		using SQLCA;
		
		IF SQLCA.SQLCode = -1 THEN 
			exito = false
			messagebox("Error Inserción en la Tabla descoleccionsol", SQLCA.SQLErrText)
		END IF
	else
		max_coleccion = long(v_coleccion)
	end if
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	//										 Fin Carga de los datos de la  colección										//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 										 Carga de los datos del trabajo												//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	if tipo = 2 then
		setnull (formato)
		setnull (relieve)
		setnull (acabado_lab)
	else
		formato = dwtc_mant_trabajos_disenyo.object.destrabajo2_formato[dwtc_mant_trabajos_disenyo.Getrow()]
		relieve = dwtc_mant_trabajos_disenyo.object.destrabajo2_relieve[dwtc_mant_trabajos_disenyo.Getrow()]
		acabado_lab = dwtc_mant_trabajos_disenyo.object.destrabajo2_acabado_lab[dwtc_mant_trabajos_disenyo.Getrow()]
	end if
	trabajo = dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[dwtc_mant_trabajos_disenyo.Getrow()]
	serie = dwtc_mant_trabajos_disenyo.object.destrabajo2_serie[dwtc_mant_trabajos_disenyo.Getrow()]
	pasta = dwtc_mant_trabajos_disenyo.object.destrabajo2_pasta[dwtc_mant_trabajos_disenyo.Getrow()]
	comercial_trabajo = dwtc_mant_trabajos_disenyo.object.destrabajo2_comercial[dwtc_mant_trabajos_disenyo.Getrow()]
	fecha_solicitud = datetime(today())
	fecha_necesidad = datetime(relativedate(date(fecha_solicitud),7),time(0))
	setnull (fecha_lab)
	contratipo = dwtc_mant_trabajos_disenyo.object.destrabajo2_contratipo[dwtc_mant_trabajos_disenyo.Getrow()]
	aceptado = dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[dwtc_mant_trabajos_disenyo.Getrow()]
	base_cliente = dwtc_mant_trabajos_disenyo.object.destrabajo2_base_cliente[dwtc_mant_trabajos_disenyo.Getrow()]
//	observaciones_trab = dwtc_mant_trabajos_disenyo.object.destrabajo2_observaciones[dwtc_mant_trabajos_disenyo.Getrow()]
	laboratorio = dwtc_mant_trabajos_disenyo.object.destrabajo2_laboratorio[dwtc_mant_trabajos_disenyo.Getrow()]
	

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 										 Carga de los datos del modelo												//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	select funcion, observaciones, pavrev 
	into :funcion, :observaciones_pz, :pavrev
	from desmodelo
	where empresa = :codigo_empresa
	and modelo = :codigo;
	
	if tipo = 2 then setnull(funcion)

	modelo = f_colisiones2 (codigo_empresa,"desmodelo", "modelo","",true)
	
	IF modelo > 0 THEN
		insert into desmodelo ( empresa, coleccion, funcion, observaciones, modelo, pavrev, inkcid, comercial, tecnico_dis)
		values (:codigo_empresa, :max_coleccion, :funcion, :observaciones_pz, :modelo, :pavrev, 'N', :comercial_trabajo, :disenyador)
		using SQLCA;
		IF SQLCA.SQLCode = -1 THEN 
			exito = false
			messagebox("Error Inserción en la Tabla desmodelo", SQLCA.SQLErrText)
		END IF
	end if
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 									Fin Carga de los datos del modelo												//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	insert into destrabajo2 ( empresa, modelo, trabajo, serie, relieve, &
								formato, pasta, fecha_solicitud, fecha_necesidad, fecha_lab, acabado_lab, &
								contratipo, aceptado, base_cliente, base, observaciones, laboratorio, tecnico_dis, inkcid, comercial)
	values (:codigo_empresa, :modelo, 1, :serie, :relieve, &
		  :formato, :pasta, :fecha_solicitud, :fecha_necesidad, :fecha_lab, :acabado_lab, &
		  :contratipo, :aceptado, :base_cliente, :base, :observaciones_trab, :laboratorio, :disenyador, 'N', :comercial_trabajo)
	using SQLCA;
	IF SQLCA.SQLCode = -1 THEN 
		exito = false
		messagebox("Error Inserción en la Tabla destrabajo2", SQLCA.SQLErrText)
	END IF
	
/*  Dejamos el historico en blanco para forzar que pongan un cliente.	
	//HISTORICO
	insert into deshistorico (empresa, coleccion, orden, f_pres, cliente, estado)
		values (:codigo_empresa, :max_coleccion, '1', :fecha_solicitud, '87', 'Pendiente') using SQLCA;
	commit using SQLCA;
	IF SQLCA.SQLCode = -1 THEN 
		exito = false
		messagebox("Error Inserción en deshistorico", SQLCA.SQLErrText)
	END IF
*/

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 										 Fin Carga de los datos del trabajo											//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	if exito then
		padre_codigo = string(modelo)
		commit using SQLCA;
		dw_1.retrieve(codigo_empresa,padre_codigo)
		dwtc_mant_trabajos_disenyo.retrieve (codigo_empresa, padre_codigo)
		dw_historicomodelo.retrieve(codigo_empresa, String(max_coleccion))
		dw_con_piezas_coleccion.retrieve(codigo_empresa, String(max_coleccion))
		p_imagen.PictureName = f_cargar_imagen_nuevo(padre_codigo)
		
				
	else
		MessageBox("SQL error", SQLCA.SQLErrText)
		rollback using SQLCA;
	end if
	
end if

return exito




end function

public function boolean hay_cambios ();Boolean resultado
resultado = false

dw_1.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco

if dw_1.DeletedCount() + dw_1.ModifiedCount() > 0 or dw_archivos.DeletedCount() + dw_archivos.ModifiedCount() > 0 or dwtc_mant_trabajos_disenyo.DeletedCount() + dwtc_mant_trabajos_disenyo.ModifiedCount() > 0 or dw_historicomodelo.DeletedCount() + dw_historicomodelo.ModifiedCount() > 0 then
	resultado = true
end if

return resultado
end function

public function integer f_guardar ();//SOBRESCRIBIMOS LA FUNCION DEL PADRE. NO LA LLMAMOS CON super::funcion()

long i, modelos_antiguos
string campo, motivo
boolean falta_Campo, aceptado
string cod_inkcid, cod_inkcid2, inkcid, trabajo, dato
string v_coleccion
Int resultado

resultado = 1 //Todo ok si devolvemos 1


//COMPROBACIÓN COLECCIÓN NUEVA - Si es nueva hay que hacerlo con el programa NUEVO ************************************************************
v_coleccion = dw_1.object.coleccion[dw_1.getrow()]
if not isnull(v_coleccion) and v_coleccion <> "" then
	modelos_antiguos = 0
	SELECT COUNT(*) INTO :modelos_antiguos FROM desmodelo WHERE empresa = :codigo_empresa AND coleccion = :v_coleccion;
	if modelos_antiguos = 0 then
		MessageBox("Atención - NO SE CREARÁN NUEVOS MODELOS EN EL PROGRAMA ANTIGUO", "Para crear modelos NUEVOS debe utilizar el nuevo sistema. Solo se permitirá la creación de modelos nuevos en colecciones con trabajos en el sistema antiguo.")
		return -1
	end if
end if
//*********************************************************************************************************************************************

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "desmodelo"
param_colisiones.campo = "modelo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = false

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_1 

dw_1.accepttext()
falta_campo = false
if dw_1.rowcount() > 0 then
	if IsNull(dw_1.object.coleccion[dw_1.getrow()]) or Trim(String(dw_1.object.coleccion[dw_1.getrow()])) = "" then
		  campo = "coleccion"
		  motivo = "Campo Obligatorio: Colección. "
		  falta_campo = True
	elseif IsNull(dw_1.object.funcion[dw_1.getrow()]) or Trim(String(dw_1.object.funcion[dw_1.getrow()])) = "" then
		  campo = "funcion"
		  motivo = "Campo Obligatorio: Función. "
		  falta_campo = True
	elseif IsNull(dw_1.object.pavrev[dw_1.getrow()]) or Trim(String(dw_1.object.pavrev[dw_1.getrow()])) = "" then
		  campo = "pavrev"
		  motivo = "Campo Obligatorio: Pav / Rev. "
		  falta_campo = True
	elseif IsNull(dw_1.object.tecnico_dis[dw_1.getrow()]) or Trim(String(dw_1.object.tecnico_dis[dw_1.getrow()])) = "" then
		  campo = "tecnico_dis"
		  motivo = "Campo Obligatorio: Diseñador "
		  falta_campo = True
	elseif IsNull(dw_1.object.comercial[dw_1.getrow()]) or Trim(String(dw_1.object.comercial[dw_1.getrow()])) = "" then
		  campo = "comercial"
		  motivo = "Campo Obligatorio: Comercial "
		  falta_campo = True
	end if	

	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

// Campos obligatorios dwtc_mant_trabajos_disenyo 
if dwtc_mant_trabajos_disenyo.RowCount() < 1 then
	messagebox("Aviso", 'Debe existir al menos un trabajo')
	return 0
end if


dwtc_mant_trabajos_disenyo.accepttext()
falta_campo = false
IF dwtc_mant_trabajos_disenyo.rowcount() > 0 THEN
	falta_campo = false
	i = 1
	DO WHILE ( i <= dwtc_mant_trabajos_disenyo.rowcount() AND NOT falta_campo )

		cod_inkcid	= dwtc_mant_trabajos_disenyo.object.destrabajo2_cod_inkcid[i]
		cod_inkcid2 = ''
		select codigo
		into :cod_inkcid2
		from desimagenestif
		where empresa = :codigo_empresa
		and codigo = :cod_inkcid;
		
		inkcid = dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid [i]
		trabajo = string(dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[i])
		if cod_inkcid2 = '' and  inkcid = 'S' then
			dwtc_mant_trabajos_disenyo.object.destrabajo2_cod_inkcid[i] = ''

			campo="destrabajo2_cod_inkcid"
			motivo  = "No existe el código inkcid introducido en el trabajo "+trabajo+".   "
			falta_campo = true
		end if
		
		IF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[i]))="" THEN
			  campo="destrabajo2_aceptado"
			  motivo  = "Campo Obligatorio: Introduzca si está OK"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_serie[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_serie[i]))="" THEN
			  campo="destrabajo2_serie"
			  motivo  = "Campo Obligatorio: Introduzca la Serie"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_formato[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_formato[i]))="" THEN
			  campo="destrabajo2_formato"
			  motivo  = "Campo Obligatorio: Introduzca el formato"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_pasta[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_pasta[i]))="" THEN
			  campo="destrabajo2_pasta"
			  motivo  = "Campo Obligatorio: Introduzca el la pasta"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_relieve[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_relieve[i]))="" THEN
			  campo="destrabajo2_relieve"
			  motivo  = "Campo Obligatorio: Introduzca el relieve"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_contratipo[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_contratipo[i]))="" THEN
			  campo="destrabajo2_contratipo"
			  motivo  = "Campo Obligatorio: Introduzca si es contratripo"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_base_cliente[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_base_cliente[i]))="" THEN
			  campo="destrabajo2_base_cliente"
			  motivo  = "Campo Obligatorio: Introduzca si es base de cliente"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_acabado_lab[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_acabado_lab[i]))="" THEN
			  campo="destrabajo2_acabado_lab"
			  motivo  = "Campo Obligatorio: Introduzca el acabado"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_solicitud[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_solicitud[i]))="" THEN
			  campo="destrabajo2_fecha_solicitud"
			  motivo  = "Campo Obligatorio: Introduzca la fecha de solicitud"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid[i]))="" THEN
			  campo="destrabajo2_inkcid"
			  motivo  = "Campo Obligatorio: Introduzca si es un modelo inkcid"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis[i]))="" THEN
			  campo="destrabajo2_tecnico_dis"
			  motivo  = "Campo Obligatorio: Introduzca el diseñador del trabajo"
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_comercial[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_comercial[i]))="" THEN
			  campo="destrabajo2_comercial"
			  motivo  = "Campo Obligatorio: Introduzca el comercial."
			  falta_campo = True
		ELSEIF IsNull(dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_necesidad[i]) or Trim(String(dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_necesidad[i]))="" THEN
			  campo="destrabajo2_fecha_necesidad"
			  motivo  = "Campo Obligatorio: Introduzca la fecha de necesidad"
			  falta_campo = True
		END IF
		i++
	LOOP
		
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dwtc_mant_trabajos_disenyo.setfocus()
	  dwtc_mant_trabajos_disenyo.SetColumn(campo)
	  return 0
	END IF
END IF


// HISTORICO
if dw_historicomodelo.RowCount() < 1 then
	messagebox("Aviso", 'Debe existir al menos un registro en el histórico')
	return 0
end if
		
if dw_1.rowcount() > 0 then
	v_coleccion = dw_1.object.coleccion[dw_1.getrow()]
	
	dw_historicomodelo.AcceptText()
	for i = 1 to dw_historicomodelo.Rowcount()
		if dw_historicomodelo.object.deshistorico_estado[i] = "Aceptado" &
			or dw_historicomodelo.object.deshistorico_estado[i] = "Rechazado" then
			if isnull(dw_historicomodelo.object.deshistorico_f_resp[i]) then
				messagebox("Aviso", 'No puede haber un registro del histórico ~n"Aceptado" o "Rechazado" sin fecha de respuesta')
				return 0
			end if
		end if
		if isnull(dw_historicomodelo.object.deshistorico_cliente[i])  &
			or dw_historicomodelo.object.deshistorico_cliente[i] = '' then
			messagebox("Aviso", 'Debe completar el campo cliente del histórico.')
			return 0
		end if
	next

end if
// FIN HISTORICO

// Campos obligatorios dw_archivos 
IF dw_archivos.rowcount() > 0  and falta_campo = false THEN
	i = 1
	DO WHILE (i <= dw_archivos.rowcount() AND NOT falta_campo )

		IF IsNull(dw_archivos.object.desmodelo_archivo_tipo_maquina_disenyo[i]) or Trim(String(dw_archivos.object.desmodelo_archivo_tipo_maquina_disenyo[i]))="" THEN
			  campo="desmodelo_archivo_tipo_maquina_disenyo"
			  motivo  = "Campo Obligatorio: Tipo Máquina"
			  falta_campo = True
		END IF
		
		IF IsNull(dw_archivos.object.desmodelo_archivo_archivo_disenyo[i]) or Trim(String(dw_archivos.object.desmodelo_archivo_archivo_disenyo[i]))="" THEN
			  campo="desmodelo_archivo_archivo_disenyo"
			  motivo  = "Campo Obligatorio: Archivo"
			  falta_campo = True
		END IF
		
		i++
	LOOP
	
	//ERRORES dw_archivos
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dw_archivos.setfocus()
	  dw_archivos.SetColumn(campo)
	  return 0
	END IF
END IF
// Fin archivos

/*---------------------------------------------------------------------------------------------------------------------------------
			   					FIN DE COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------------------------------------------------------------
			   					GRABACIÓN DW PRINCIPAL
---------------------------------------------------------------------------------------------------------------------------------*/

// El primer campo del datawindow será el que reciba el código generado. 
// Por tanto, al crear el datawindow maestro debemos situar en primera posición dicho campo
dw_1.accepttext()

//Codigo por si se desea mostrar aviso antes de guardar (Por defecto NO, si no utilizar Message.DoubleParm = 10001)

dw_1.SetTransObject(trans_ts)	
dwtc_mant_trabajos_disenyo.SetTransObject(trans_ts)
dw_historicomodelo.SetTransObject(trans_ts)
dw_archivos.SetTransObject(trans_ts)

if dw_1.rowcount() > 0 then
	dw_1.object.empresa[dw_1.getrow()] = codigo_empresa		
	if String(dw_1.object.#1[dw_1.getrow()]) = '' or isnull (dw_1.object.#1[dw_1.getrow()]) then
		padre_codigo = String(f_colisiones ( trans_ts, param_colisiones))
		if padre_codigo = '0'  then
			messagebox("ERROR", "No se puede asignar un código.")
			ROLLBACK USING trans_ts;
			dw_1.SetTransObject(SQLCA)	
			return 0
		else
			dw_1.object.#1[dw_1.getrow()] = padre_codigo
		end if
	end if
end if
dw_1.object.desmodelo_inkcid[dw_1.getrow()] = 'N'
rtn = dw_1.Update()

/*---------------------------------------------------------------------------------------------------------------------------------
			   					FIN GRABACIÓN DW PRINCIPAL
---------------------------------------------------------------------------------------------------------------------------------*/


IF rtn = 1 THEN
/*---------------------------------------------------------------------------------------------------------------------------------
				   				GRABACIÓN DATAWINDOWS AUXILIARES
---------------------------------------------------------------------------------------------------------------------------------*/
	for i = 1 to dwtc_mant_trabajos_disenyo.RowCount()
		dwtc_mant_trabajos_disenyo.object.destrabajo2_modelo[i] = dw_1.object.#1[dw_1.getrow()]
	next
	rtn = dwtc_mant_trabajos_disenyo.update() 
end if		

if rtn = 1 then
	rtn = dw_historicomodelo.update()
end if

if rtn = 1 then
	rtn = dw_archivos.update()
end if
/*---------------------------------------------------------------------------------------------------------------------------------
				   			FIN GRABACIÓN DATAWINDOWS AUXILIARES
---------------------------------------------------------------------------------------------------------------------------------*/
		
IF rtn = 1 THEN
	
	aceptado = false
	for i = 1 to dw_historicomodelo.Rowcount()
		if dw_historicomodelo.object.deshistorico_estado[i] = "Aceptado" then
			aceptado = true
		end if			
	next
	
	if aceptado then
		update descoleccionsol
		set estado = "NO DISPONIBLE"
		where empresa = :codigo_empresa
		and codigo = :v_coleccion USING trans_ts;
	else
		update descoleccionsol
		set estado = "DISPONIBLE"
		where empresa = :codigo_empresa
		and codigo = :v_coleccion USING trans_ts;
	end if			

	if SQLCA.sqlcode = -1 then rtn = -1
end if

if rtn = 1 then
	COMMIT USING trans_ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_ts;
END IF
dw_1.SetTransObject(SQLCA)	
dwtc_mant_trabajos_disenyo.SetTransObject(SQLCA)			
dw_historicomodelo.SetTransObject(SQLCA)		
dw_con_piezas_coleccion.SetTransObject(SQLCA)	
dw_archivos.SetTransObject(SQLCA)

estado = 1 // Modo edición


// Refrescar Datawindows después de guardar.
if rtn = 1 then
	dw_1.retrieve (codigo_empresa, padre_codigo)
	dwtc_mant_trabajos_disenyo.retrieve (codigo_empresa, padre_codigo)	
	p_imagen.PictureName = f_cargar_imagen_nuevo(padre_codigo)
	dw_archivos.retrieve (codigo_empresa, padre_codigo)
	if not isnull(dw_1.object.coleccion[dw_1.getrow()] ) and dw_1.object.coleccion[dw_1.getrow()] <> '' then
		dw_con_piezas_coleccion.retrieve (codigo_empresa, dw_1.object.coleccion[dw_1.getrow()])
		dw_historicomodelo.retrieve (codigo_empresa, dw_1.object.coleccion[dw_1.getrow()])
	end if
end if

return rtn
end function

public function integer f_borrar ();//SOBRESCRIBIMOS LA FUNCION DEL PADRE. NO LA LLMAMOS CON super::funcion()

string modelo, coleccion
long total_modelos_coleccion, total_modelos_coleccion_nueva, total_trabajos_lab
str_ventana_alerta parametros
string botones[2]

// Excepcion: Tengo que tomar el valor de la coleccion antes de borrar el datawindow dw_1. Al borrarlo da error por no contener ninguna fila. Hemos sobrescrito es script del padre.
coleccion = dw_1.object.coleccion[1]
modelo = padre_codigo

parametros.titulo = "Atención Borrado de Modelo"
parametros.subtitulo = "Borrar MODELO"
parametros.mensaje = "¿Desea borrar el MODELO?"
parametros.tipo = 1
//parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar = Int(Message.DoubleParm)

rtn = 0
if borrar = 1 then
	padre_codigo = dw_1.object.#1[dw_1.GetRow()]

	dw_1.SetTransObject(trans_ts)	
	
	rtn = dw_1.deleterow(0)
	if rtn = 1 then
		rtn = dw_1.update()
	end if
end if

if rtn = 1 then
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//   AQUÍ IRÁ EL CÓDIGO DE LOS DW AUXILIARES. CONTROLAR LOS BORRADOS CON rtn. 
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	select count (*) 
	into :total_trabajos_lab
	from destrabajo2
	where empresa = :codigo_empresa
	and modelo = :padre_codigo
	and laboratorio = 'S' using trans_ts;
	
	if total_trabajos_lab > 0 then
		messagebox("Atencion", "No se puede borrar el modelo porque tiene pruebas de laboratorio")
		rtn = -1
	end if
	
	IF rtn = 1 THEN
		modelo = padre_codigo
		delete from destrabajo2
		where empresa = :codigo_empresa
		and modelo = :modelo using trans_ts;
		
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText)
			rtn = -1
		END IF
	end if
	
	if rtn = 1 then
		total_modelos_coleccion = 0
		select count(*)
		into :total_modelos_coleccion
		from desmodelo
		where empresa = :codigo_empresa
		and coleccion = :coleccion using trans_ts;
		
		total_modelos_coleccion_nueva = 0
		select count(*)
		into :total_modelos_coleccion_nueva
		from modelo
		where empresa = :codigo_empresa
		and coleccion = :coleccion using trans_ts;
		
		total_modelos_coleccion = total_modelos_coleccion + total_modelos_coleccion_nueva
		
		if total_modelos_coleccion = 0 then
			
			delete from descoleccionsol
			where empresa = :codigo_empresa
			and codigo = :coleccion using trans_ts;
	
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText)
				rtn = -1
			END IF
			
			if rtn = 1 then
				delete from deshistorico
				where empresa = :codigo_empresa
				and coleccion = :coleccion using trans_ts;
		
				IF trans_ts.SQLCode <> 0 THEN         
					MessageBox("SQL error", trans_ts.SQLErrText)
					rtn = -1
				END IF
			end if
			
		end if
	end if
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if rtn = 1 then
		COMMIT USING trans_ts;
		dw_1.SetTransObject(SQLCA)			
		pb_nuevo.TriggerEvent(Clicked!)	
		mostrar_controles_insercion()
		dw_1.setfocus()
		dw_1.setcolumn(2)
		estado = 0 // Modo Insercion
		p_imagen.PictureName = ''
	ELSE
		ROLLBACK USING trans_ts;
		dw_1.SetTransObject(SQLCA)	
//		dw_1.object.coleccion[1] = coleccion
		dw_1.object.#1[1] = modelo
		pb_cancelar.triggerevent(Clicked!)
	
	END IF

	
end if

return rtn
end function

public subroutine mostrar_controles_insercion ();cb_pasar_pieza.visible = false
cb_generar_pieza.visible = false
cb_generar_coleccion.visible = false

super::mostrar_controles_insercion()
end subroutine

public subroutine mostrar_controles_edicion ();cb_pasar_pieza.visible = true
cb_generar_pieza.visible = true
cb_generar_coleccion.visible = true

super::mostrar_controles_edicion()
end subroutine

on wtc_trabajos_disenyo.create
int iCurrent
call super::create
this.pb_borrar_trabajo=create pb_borrar_trabajo
this.pb_duplica_trabajo=create pb_duplica_trabajo
this.pb_anyade_trabajo=create pb_anyade_trabajo
this.pb_1=create pb_1
this.pb_borrar_historico=create pb_borrar_historico
this.pb_anyade_historico=create pb_anyade_historico
this.p_imagen=create p_imagen
this.st_2=create st_2
this.r_1=create r_1
this.dw_historicomodelo=create dw_historicomodelo
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.cb_pasar_pieza=create cb_pasar_pieza
this.cb_generar_pieza=create cb_generar_pieza
this.cb_generar_coleccion=create cb_generar_coleccion
this.dw_ficha_comercial=create dw_ficha_comercial
this.cb_fecha_coleccion=create cb_fecha_coleccion
this.dwtc_mant_trabajos_disenyo=create dwtc_mant_trabajos_disenyo
this.p_seleccion=create p_seleccion
this.pb_anyade_archivo=create pb_anyade_archivo
this.pb_borrar_archivo=create pb_borrar_archivo
this.dw_archivos=create dw_archivos
this.dw_fecha_necesidad=create dw_fecha_necesidad
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_borrar_trabajo
this.Control[iCurrent+2]=this.pb_duplica_trabajo
this.Control[iCurrent+3]=this.pb_anyade_trabajo
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.pb_borrar_historico
this.Control[iCurrent+6]=this.pb_anyade_historico
this.Control[iCurrent+7]=this.p_imagen
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.r_1
this.Control[iCurrent+10]=this.dw_historicomodelo
this.Control[iCurrent+11]=this.dw_con_piezas_coleccion
this.Control[iCurrent+12]=this.cb_pasar_pieza
this.Control[iCurrent+13]=this.cb_generar_pieza
this.Control[iCurrent+14]=this.cb_generar_coleccion
this.Control[iCurrent+15]=this.dw_ficha_comercial
this.Control[iCurrent+16]=this.cb_fecha_coleccion
this.Control[iCurrent+17]=this.dwtc_mant_trabajos_disenyo
this.Control[iCurrent+18]=this.p_seleccion
this.Control[iCurrent+19]=this.pb_anyade_archivo
this.Control[iCurrent+20]=this.pb_borrar_archivo
this.Control[iCurrent+21]=this.dw_archivos
this.Control[iCurrent+22]=this.dw_fecha_necesidad
end on

on wtc_trabajos_disenyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_borrar_trabajo)
destroy(this.pb_duplica_trabajo)
destroy(this.pb_anyade_trabajo)
destroy(this.pb_1)
destroy(this.pb_borrar_historico)
destroy(this.pb_anyade_historico)
destroy(this.p_imagen)
destroy(this.st_2)
destroy(this.r_1)
destroy(this.dw_historicomodelo)
destroy(this.dw_con_piezas_coleccion)
destroy(this.cb_pasar_pieza)
destroy(this.cb_generar_pieza)
destroy(this.cb_generar_coleccion)
destroy(this.dw_ficha_comercial)
destroy(this.cb_fecha_coleccion)
destroy(this.dwtc_mant_trabajos_disenyo)
destroy(this.p_seleccion)
destroy(this.pb_anyade_archivo)
destroy(this.pb_borrar_archivo)
destroy(this.dw_archivos)
destroy(this.dw_fecha_necesidad)
end on

event open;call super::open;Long fila

This.Title = "Trabajos Diseño"
dwtc_mant_trabajos_disenyo.SetTransObject(SQLCA)
dwtc_mant_trabajos_disenyo.SetRowFocusIndicator(p_seleccion)
dw_con_piezas_coleccion.SetTransObject(SQLCA)

//dwtc_mant_trabajos_disenyo.marcar_filas = true
dw_historicomodelo.SetTransObject(SQLCA)

dw_ficha_comercial.SetTransObject(SQLCA)

dw_archivos.SetTransObject(SQLCA)
dw_fecha_necesidad.visible = false

if padre_codigo <> "" then
	dwtc_mant_trabajos_disenyo.retrieve (codigo_empresa, dw_1.object.modelo[dw_1.getrow()])
	dw_historicomodelo.retrieve(codigo_empresa, dw_1.object.coleccion[dw_1.getrow()])
	dw_con_piezas_coleccion.retrieve(codigo_empresa, dw_1.object.coleccion[dw_1.getrow()])	
	dw_archivos.retrieve (codigo_empresa, dw_1.object.modelo[dw_1.getrow()])
	
	if dw_con_piezas_coleccion.rowcount() > 0 then
		fila = dw_con_piezas_coleccion.Find("desmodelo_modelo = '"+padre_codigo+"'", 1, dw_con_piezas_coleccion.rowcount())
		if fila > 0 then
			dw_con_piezas_coleccion.scrolltorow(fila)
			dw_con_piezas_coleccion.setrow(fila)
		end if
	end if
	p_imagen.PictureName = f_cargar_imagen_nuevo(dw_1.object.modelo[dw_1.getrow()])
	estado = 1
end if
end event

event activate;call super::activate;wtc_trabajos_disenyo = ventanas_activas[id_ventana_activa].ventana





end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_trabajos_disenyo
integer x = 526
integer y = 128
end type

event pb_imprimir::clicked;long trabajo
Boolean imprimir

//Solo se puede imprimir en modo edicion
if estado = 1 then
	imprimir = true
	if hay_cambios() then
		if MessageBox("Atención","¿Desea guardar los cambios antes de imprimir?",Question!,YesNo!,1) = 1 then
			if f_guardar() <> 1 then 
				imprimir = false
			end if
		end if	
	end if
	
	if imprimir = true then
		trabajo = dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[dwtc_mant_trabajos_disenyo.Getrow()]
		
		dw_ficha_comercial.retrieve(codigo_empresa, padre_codigo, trabajo)
		dw_ficha_comercial.object.p_1.filename = f_cargar_imagen_nuevo(padre_codigo)
		
		f_imprimir_datawindow(dw_ficha_comercial)
	end if
end if
end event

type p_logo from wt_ventana_padre`p_logo within wtc_trabajos_disenyo
integer x = 5065
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_trabajos_disenyo
integer x = 37
integer y = 296
integer width = 3479
integer height = 696
integer taborder = 10
string dataobject = "dwtc_trabajos_disenyo"
boolean border = false
end type

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "funcion"
			busqueda.titulo_ventana = "Búsqueda de Función"
			busqueda.consulta  = " SELECT art_grupo2.codigo, art_grupo2.descripcion "+&
										" FROM art_grupo2 "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Función de la Pieza "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.funcion[dw_1.GetRow()] 							= resultado.valores[1]		// Devuelve el valor que encuentra ...
				dw_1.object.art_grupo2_descripcion[dw_1.GetRow()] 		= resultado.valores[2]		// Devuelve el valor que encuentra ...
				dw_1.Modify("art_grupo2_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
			end if
			
		CASE "tecnico_dis"
			busqueda.titulo_ventana = "Búsqueda de Diseñador"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM TECNICO_DIS WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Diseñador"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.tecnico_dis[dw_1.GetRow()] 							= resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.tecnico_dis_descripcion[dw_1.GetRow()] 	= resultado.valores[2]			// Devuelve el valor que encuentra ...
				dw_1.Modify("tecnico_dis_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
			end if		
			
		CASE "comercial"
			busqueda.titulo_ventana = "Búsqueda de Comercial"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM comercial WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Comercial"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.comercial[dw_1.GetRow()] 					= resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.comercial_descripcion[dw_1.GetRow()] 	= resultado.valores[2]			// Devuelve el valor que encuentra ...
				dw_1.Modify("comercial_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
			end if		
			
	END CHOOSE
end if	
	

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param
long esta_abierta

this.accepttext()

CHOOSE CASE dwo.name
	CASE "p_coleccion"
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_coleccion")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = this.object.coleccion[row]
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "wtc_trabajos_disenyo"
			lstr_param.resultado = ''
			Openwithparm(wtc_mant_coleccion, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if

		CASE "p_disenyador"
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_disenyador")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = this.object.tecnico_dis[row]
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "wtc_trabajos_disenyo"
			lstr_param.resultado = ''
			Openwithparm(wtc_mant_disenyador, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if

		CASE "p_comercial"
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_comercial")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = this.object.comercial[row]
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "wtc_trabajos_disenyo"
			lstr_param.resultado = ''
			Openwithparm(wtc_mant_comercial, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
		
END CHOOSE

end event

event dw_1::itemchanged;call super::itemchanged;string resultado, resultado1, resultado3
datetime resultado2

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "coleccion"
			
		SELECT descoleccionsol.ambiente, descoleccionsol.fecha_coleccion, tecnico_dis.descripcion
		INTO :resultado1, :resultado2, :resultado3
		FROM descoleccionsol, tecnico_dis
		WHERE descoleccionsol.empresa = :codigo_empresa
		and descoleccionsol.codigo = :data
		and descoleccionsol.disenyador = tecnico_dis.codigo
		and descoleccionsol.empresa = tecnico_dis.empresa;

		if SQLCA.sqlcode <> 100 then
			this.object.descoleccionsol_ambiente[Row] 		= resultado1
			this.object.descoleccionsol_fecha_coleccion[Row] 		= resultado2
			this.object.tecnico_dis_descripcion_1[Row] 		= resultado3
			dw_historicomodelo.retrieve(codigo_empresa, this.object.coleccion[1])
			dw_con_piezas_coleccion.retrieve (codigo_empresa, this.object.coleccion[1])
		else
			dwo.Primary[row] = ''
			this.object.descoleccionsol_ambiente[Row] 		= ''
			setnull(resultado2)
			this.object.descoleccionsol_fecha_coleccion[Row] 	= resultado2
			dw_historicomodelo.reset()
			dw_con_piezas_coleccion.reset()
			return 2			
		end if

	CASE "funcion"
		SELECT art_grupo2.descripcion 
		INTO :resultado
		FROM art_grupo2
		WHERE empresa = :codigo_empresa
		and art_grupo2.codigo = :data
		ORDER BY art_grupo2.descripcion ;

		if SQLCA.sqlcode <> 100 then
			this.object.art_grupo2_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.art_grupo2_descripcion[Row] 		= ''
			return 2
		end if

	CASE "tecnico_dis"
		SELECT tecnico_dis.descripcion 
		INTO :resultado
		FROM tecnico_dis
		WHERE empresa = :codigo_empresa
		and tecnico_dis.codigo = :data
		ORDER BY tecnico_dis.descripcion ;

		if SQLCA.sqlcode <> 100 then
			this.object.tecnico_dis_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tecnico_dis_descripcion[Row] 		= ''
			return 2
		end if
		
	CASE "comercial"
		SELECT comercial.descripcion 
		INTO :resultado
		FROM comercial
		WHERE empresa = :codigo_empresa
		and comercial.codigo = :data
		ORDER BY comercial.descripcion ;

		if SQLCA.sqlcode <> 100 then
			this.object.comercial_descripcion[Row] 		= resultado
//			this.Modify("comercial_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
		else
			dwo.Primary[row] = ''
			this.object.comercial_descripcion[Row] 		= ''
			return 2
		end if
END CHOOSE


this.Accepttext()
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_trabajos_disenyo
integer x = 5111
integer y = 132
string disabledname = "C:\Tencer_PB12\Delete_24x24_D.png"
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_trabajos_disenyo
integer x = 5431
integer y = 132
string picturename = "C:\Tencer_PB12\Log Out_24x24Gris.png"
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_trabajos_disenyo
integer x = 361
integer y = 128
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_trabajos_disenyo
integer x = 46
integer y = 24
integer width = 5001
integer height = 72
string facename = "Verdana"
long bordercolor = 33554432
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_trabajos_disenyo
integer x = 41
integer y = 128
string disabledname = "C:\Tencer_PB12\New_24x24_D.png"
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
end if
dwtc_mant_trabajos_disenyo.reset()
dw_historicomodelo.reset()
dw_con_piezas_coleccion.reset()
dw_archivos.reset ()
p_imagen.PictureName = ''
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_trabajos_disenyo
integer x = 5271
integer y = 132
string picturename = "C:\Tencer_PB12\Undo_24x24Gris.png"
end type

event pb_cancelar::clicked;call super::clicked;if estado = 1 then
	dw_1.retrieve(codigo_empresa, padre_codigo)
	dwtc_mant_trabajos_disenyo.retrieve(codigo_empresa, padre_codigo)
	dw_historicomodelo.retrieve (codigo_empresa, dw_1.object.coleccion[1])
	dw_con_piezas_coleccion.retrieve (codigo_empresa, dw_1.object.coleccion[1])
	dw_archivos.retrieve (codigo_empresa, dw_1.object.modelo[1])
	
	p_imagen.PictureName = f_cargar_imagen_nuevo(padre_codigo)
else
	Parent.setfocus()
	pb_nuevo.triggerevent(clicked!)
end if

end event

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_trabajos_disenyo
integer x = 201
integer y = 128
end type

event pb_buscar::clicked;string campo
//, consulta_padre_busqueda
//Int numero_valores

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "modelo"
		padre_busqueda.filtro_es_codigo = true
//		padre_busqueda.consulta =  " SELECT desmodelo.modelo, desmodelo.modelo, art_grupo2.descripcion, tecnico_dis.descripcion, comercial.descripcion "+&	
//									" FROM desmodelo LEFT OUTER JOIN tecnico_dis ON desmodelo.empresa = tecnico_dis.empresa AND desmodelo.tecnico_dis = tecnico_dis.codigo "+&
//									" LEFT OUTER JOIN comercial ON desmodelo.comercial = comercial.codigo AND desmodelo.empresa = comercial.empresa "+&
//									" LEFT OUTER JOIN descoleccionsol ON desmodelo.empresa = descoleccionsol.empresa AND desmodelo.coleccion = descoleccionsol.codigo "+&
//									" LEFT OUTER JOIN art_grupo2 ON desmodelo.funcion = art_grupo2.codigo  "+&
//									" WHERE desmodelo.empresa = '"+codigo_empresa+"' "+&
//									" ORDER BY CONVERT(INTEGER, desmodelo.modelo) desc"
									
									
		padre_busqueda.consulta =  " SELECT desmodelo.modelo, desmodelo.modelo, art_grupo2.descripcion, tecnico_dis.descripcion, comercial.descripcion, genter.razon "+&	
									" FROM desmodelo LEFT OUTER JOIN tecnico_dis ON desmodelo.empresa = tecnico_dis.empresa AND desmodelo.tecnico_dis = tecnico_dis.codigo "+&
									" LEFT OUTER JOIN comercial ON desmodelo.comercial = comercial.codigo AND desmodelo.empresa = comercial.empresa "+&
									" LEFT OUTER JOIN descoleccionsol ON desmodelo.empresa = descoleccionsol.empresa AND desmodelo.coleccion = descoleccionsol.codigo "+&
									" LEFT OUTER JOIN art_grupo2 ON desmodelo.funcion = art_grupo2.codigo, deshistorico D1, genter  "+&
									" WHERE desmodelo.empresa = '"+codigo_empresa+"' AND "+&
									" desmodelo.empresa = D1.empresa AND "+&
									" desmodelo.coleccion = D1.coleccion AND "+&
									" D1.f_pres = (SELECT MAX(D2.f_pres) FROM deshistorico D2 WHERE D2.empresa = desmodelo.empresa AND D2.coleccion = desmodelo.coleccion) AND "+&
									" genter.empresa = D1.empresa AND genter.codigo = D1.cliente AND genter.tipoter = 'C' "+&
									" ORDER BY CONVERT(INTEGER, desmodelo.modelo) desc"							
		
		padre_busqueda.titulos[1] = "Modelo"
		padre_busqueda.titulos[2] = "Modelo"
		padre_busqueda.titulos[3] = "Función"
		padre_busqueda.titulos[4] = "Diseñador"
		padre_busqueda.titulos[5] = "Comercial"
		padre_busqueda.titulos[6] = "Cliente"

	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT desmodelo.modelo, desmodelo.modelo, art_grupo2.descripcion, tecnico_dis.descripcion, comercial.descripcion "+&	
									" FROM desmodelo LEFT OUTER JOIN tecnico_dis ON desmodelo.empresa = tecnico_dis.empresa AND desmodelo.tecnico_dis = tecnico_dis.codigo "+&
									" LEFT OUTER JOIN comercial ON desmodelo.comercial = comercial.codigo AND desmodelo.empresa = comercial.empresa "+&
									" LEFT OUTER JOIN descoleccionsol ON desmodelo.empresa = descoleccionsol.empresa AND desmodelo.coleccion = descoleccionsol.codigo "+&
									" LEFT OUTER JOIN art_grupo2 ON desmodelo.funcion = art_grupo2.codigo  "+&
									" WHERE desmodelo.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, desmodelo.modelo) desc"
		padre_busqueda.titulos[1] = "Modelo"
		padre_busqueda.titulos[2] = "Modelo"
		padre_busqueda.titulos[3] = "Función"
		padre_busqueda.titulos[4] = "Diseñador"
		padre_busqueda.titulos[5] = "Comercial"		
end choose


call super :: clicked

if padre_codigo <> "" then
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AQUÍ PONDREMOS TODOS LOS DATAWINDOWS AUXILIARES
	dwtc_mant_trabajos_disenyo.retrieve (codigo_empresa, dw_1.object.modelo[1])
	dw_historicomodelo.retrieve(codigo_empresa, dw_1.object.coleccion[1])
	dw_con_piezas_coleccion.retrieve(codigo_empresa, dw_1.object.coleccion[1])
	dw_archivos.retrieve (codigo_empresa, dw_1.object.modelo[1])
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	p_imagen.PictureName = f_cargar_imagen_nuevo(padre_codigo)
end if
end event

type pb_borrar_trabajo from picturebutton within wtc_trabajos_disenyo
integer x = 229
integer y = 2184
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
string powertiptext = "EliminarRegistro"
end type

event clicked;
boolean error_borrando
long fila_actual, v_prueba

error_borrando = false
fila_actual = dwtc_mant_trabajos_disenyo.getrow()
if fila_actual > 0 then
	if dwtc_mant_trabajos_disenyo.DeleteRow(fila_actual) <> 1 then
		error_borrando = True
	else
		error_borrando = False
	end if
end if
end event

type pb_duplica_trabajo from picturebutton within wtc_trabajos_disenyo
integer x = 379
integer y = 2184
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\duplicar.png"
alignment htextalign = left!
string powertiptext = "Duplicar Registro"
end type

event clicked;long total_filas, fila_actual, nuevaprueba, indice, i, maximo_valor_dw
integer  v_orden, v_prueba
string v_descripcion, sel, v_aplicacion, v_pantalla, v_formula, v_hilos, v_observaciones, v_operacion, modelo_actual
boolean bien = true
datastore aplicaciones
string v_serie, v_descripcion_serie, v_aceptado, v_formato, v_formato_abreviado, v_pasta
string v_relieve, v_descripcion_relieve, v_contratipo, v_base_cli, v_acabado_lab, v_descripcion_acabado_lab
string v_base, v_descripcion_base, v_coste, inkcid, tecnico_dis, des_tecnico_dis
datetime f_solicitud, f_necesidad, f_fin, f_laboratorio
decimal  v_ancho, v_largo

modelo_actual = f_codigo_principal()
IF modelo_actual <> '' and dw_1.RowCount() > 0 THEN
	v_prueba = dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_serie = dwtc_mant_trabajos_disenyo.object.destrabajo2_serie[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_descripcion_serie = dwtc_mant_trabajos_disenyo.object.desserie_descripcion[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_aceptado = 'N'
	v_formato = dwtc_mant_trabajos_disenyo.object.destrabajo2_formato[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_formato_abreviado = dwtc_mant_trabajos_disenyo.object.formatos_abreviado[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_ancho = dwtc_mant_trabajos_disenyo.object.formatos_ancho[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_largo = dwtc_mant_trabajos_disenyo.object.formatos_largo[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_pasta = dwtc_mant_trabajos_disenyo.object.destrabajo2_pasta[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_relieve = dwtc_mant_trabajos_disenyo.object.destrabajo2_relieve[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_descripcion_relieve = dwtc_mant_trabajos_disenyo.object.art_tipomoldura_descripcion[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_contratipo = dwtc_mant_trabajos_disenyo.object.destrabajo2_contratipo[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_base_cli = dwtc_mant_trabajos_disenyo.object.destrabajo2_base_cliente[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_acabado_lab = dwtc_mant_trabajos_disenyo.object.destrabajo2_acabado_lab[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_descripcion_acabado_lab = dwtc_mant_trabajos_disenyo.object.tipoacabado_lab_descripcion[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_base = dwtc_mant_trabajos_disenyo.object.destrabajo2_base[dwtc_mant_trabajos_disenyo.GetRow()] 
	v_descripcion_base = dwtc_mant_trabajos_disenyo.object.articulos_descripcion[dwtc_mant_trabajos_disenyo.GetRow()] 
	f_solicitud = dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_solicitud[dwtc_mant_trabajos_disenyo.GetRow()] 
	inkcid = dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid[dwtc_mant_trabajos_disenyo.GetRow()] 
	tecnico_dis = dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis[dwtc_mant_trabajos_disenyo.GetRow()] 
	des_tecnico_dis = dwtc_mant_trabajos_disenyo.object.tecnico_dis_descripcion[dwtc_mant_trabajos_disenyo.GetRow()] 
//	f_necesidad = dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_necesidad[dwtc_mant_trabajos_disenyo.GetRow()] 
	
	dwtc_mant_trabajos_disenyo.scrolltorow(dwtc_mant_trabajos_disenyo.InsertRow(0))
	dwtc_mant_trabajos_disenyo.SetColumn(3)
	dwtc_mant_trabajos_disenyo.Setfocus()
	
	fila_actual = dwtc_mant_trabajos_disenyo.Getrow()
	total_filas = dwtc_mant_trabajos_disenyo.RowCount()
	
	select max (trabajo) 
	into :nuevaprueba
	from destrabajo2
	where empresa = :codigo_empresa
	and modelo = :modelo_actual;
	
	maximo_valor_dw = long(dwtc_mant_trabajos_disenyo.Describe("Evaluate('Max(destrabajo2_trabajo)', 0)"))
	if isnull(nuevaprueba) then nuevaprueba = 0
	if isnull(maximo_valor_dw) then maximo_valor_dw = 0
	
	if nuevaprueba > maximo_valor_dw then
		nuevaprueba ++
	else
		nuevaprueba = maximo_valor_dw +1
	end if	

	dwtc_mant_trabajos_disenyo.object.destrabajo2_empresa[fila_actual] = codigo_empresa
	dwtc_mant_trabajos_disenyo.object.destrabajo2_modelo[fila_actual] = modelo_actual
	dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
	
	dwtc_mant_trabajos_disenyo.object.destrabajo2_serie[fila_actual] = v_serie
	dwtc_mant_trabajos_disenyo.object.desserie_descripcion[fila_actual] = v_descripcion_serie 
	dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[fila_actual] = v_aceptado
	dwtc_mant_trabajos_disenyo.object.destrabajo2_formato[fila_actual] = v_formato 
	dwtc_mant_trabajos_disenyo.object.formatos_ancho[fila_actual] = v_ancho 
	dwtc_mant_trabajos_disenyo.object.formatos_largo[fila_actual] = v_largo 
	dwtc_mant_trabajos_disenyo.object.formatos_abreviado[fila_actual] = v_formato_abreviado 
	dwtc_mant_trabajos_disenyo.object.destrabajo2_pasta[fila_actual] = v_pasta 
	dwtc_mant_trabajos_disenyo.object.destrabajo2_relieve[fila_actual] = v_relieve 
	dwtc_mant_trabajos_disenyo.object.art_tipomoldura_descripcion[fila_actual] = v_descripcion_relieve
	dwtc_mant_trabajos_disenyo.object.destrabajo2_contratipo[fila_actual] = v_contratipo
	dwtc_mant_trabajos_disenyo.object.destrabajo2_base_cliente[fila_actual] = v_base_cli
	dwtc_mant_trabajos_disenyo.object.destrabajo2_acabado_lab[fila_actual] = v_acabado_lab
	dwtc_mant_trabajos_disenyo.object.tipoacabado_lab_descripcion[fila_actual] = v_descripcion_acabado_lab
	dwtc_mant_trabajos_disenyo.object.destrabajo2_base[fila_actual] = v_base
	dwtc_mant_trabajos_disenyo.object.articulos_descripcion[fila_actual] = v_descripcion_base
	dwtc_mant_trabajos_disenyo.object.destrabajo2_laboratorio[fila_actual] = 'N'
	dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_solicitud[fila_actual] = datetime(today())
	dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid[fila_actual] = inkcid
	dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis[fila_actual] = tecnico_dis
	dwtc_mant_trabajos_disenyo.object.tecnico_dis_descripcion[dwtc_mant_trabajos_disenyo.GetRow()] = des_tecnico_dis
end if

end event

type pb_anyade_trabajo from picturebutton within wtc_trabajos_disenyo
integer x = 78
integer y = 2184
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;long fila_actual, nuevaprueba, indice, maximo_valor_dw
string modelo_actual

nuevaprueba = 0
modelo_actual =  padre_codigo

select max(trabajo)
into :nuevaprueba
from destrabajo2
where empresa = :codigo_empresa
and modelo = :modelo_actual;

maximo_valor_dw = long(dwtc_mant_trabajos_disenyo.Describe("Evaluate('Max(destrabajo2_trabajo)', 0)"))

if isnull(nuevaprueba) then nuevaprueba = 0
if isnull(maximo_valor_dw) then maximo_valor_dw = 0

if nuevaprueba > maximo_valor_dw then
	nuevaprueba ++
else
	nuevaprueba = maximo_valor_dw +1
end if

fila_actual = dwtc_mant_trabajos_disenyo.InsertRow(0)

dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[fila_actual] = nuevaprueba

dwtc_mant_trabajos_disenyo.scrolltorow(fila_actual)
dwtc_mant_trabajos_disenyo.SetColumn(3)
dwtc_mant_trabajos_disenyo.Setfocus()
dwtc_mant_trabajos_disenyo.object.destrabajo2_empresa[fila_actual] = codigo_empresa
//	dwtc_mant_trabajos_disenyo.object.destrabajo2_modelo[fila_actual] = modelo_actual
dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[fila_actual] = 'N'
dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_solicitud[fila_actual] = datetime(today())
dwtc_mant_trabajos_disenyo.object.destrabajo2_laboratorio[fila_actual] = 'N'
dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid[fila_actual] = 'N'
dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis[fila_actual] = ''

end event

type pb_1 from picturebutton within wtc_trabajos_disenyo
boolean visible = false
integer x = 846
integer y = 120
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
end type

event clicked;long trabajo
Boolean imprimir

//Solo se puede imprimir en modo edicion
if estado = 1 then
	imprimir = false
	if hay_cambios() then
		if MessageBox("Atención","¿Desea guardar los cambios antes de imprimir?",Question!,YesNo!,1) = 1 then
			if f_guardar() <> 1 then 
				imprimir = false
			else
				imprimir = true
			end if
		else
			imprimir = true
		end if	
	else
		imprimir = true
	end if
	
	if imprimir = true then
		trabajo = dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[dwtc_mant_trabajos_disenyo.Getrow()]
		
		dw_ficha_comercial.retrieve(codigo_empresa, padre_codigo, trabajo)
		dw_ficha_comercial.object.p_1.filename = f_cargar_imagen_nuevo(padre_codigo)
		
		f_imprimir_datawindow(dw_ficha_comercial)
	end if
end if
end event

type pb_borrar_historico from picturebutton within wtc_trabajos_disenyo
integer x = 229
integer y = 2808
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
string powertiptext = "EliminarRegistro"
end type

event clicked;
boolean error_borrando
long fila_actual, v_registro

if dw_historicomodelo.Rowcount() > 0 then
	fila_actual = dw_historicomodelo.getrow()
	v_registro = dw_historicomodelo.object.deshistorico_orden[fila_actual]
	dw_historicomodelo.DeleteRow(fila_actual)

	error_borrando = False

	if dw_historicomodelo.Rowcount() > 0 then
		dw_historicomodelo.scrolltoRow(fila_actual)
	end if
end if


end event

type pb_anyade_historico from picturebutton within wtc_trabajos_disenyo
integer x = 78
integer y = 2808
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;
long total_filas, fila_actual, nuevoregistro, indice
string v_solicitud, v_coleccion

dw_historicomodelo.scrolltorow(dw_historicomodelo.InsertRow(0))
dw_historicomodelo.SetColumn(1)
dw_historicomodelo.Setfocus()

fila_actual = dw_historicomodelo.Getrow()
total_filas = dw_historicomodelo.RowCount()

v_coleccion = dw_1.object.coleccion[dw_1.getrow()]

nuevoregistro = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_historicomodelo.object.deshistorico_orden[indice]) >= nuevoregistro then
			nuevoregistro = long(dw_historicomodelo.object.deshistorico_orden[indice]) + 1
		end if
	next
end if

dw_historicomodelo.object.deshistorico_empresa[fila_actual] = codigo_empresa
dw_historicomodelo.object.deshistorico_coleccion[fila_actual] = v_coleccion
dw_historicomodelo.object.deshistorico_orden[fila_actual] = nuevoregistro
dw_historicomodelo.object.deshistorico_f_pres[fila_actual] = datetime(today())
dw_historicomodelo.object.deshistorico_estado[fila_actual] = 'Pendiente'


end event

type p_imagen from picture within wtc_trabajos_disenyo
integer x = 3465
integer y = 2496
integer width = 823
integer height = 456
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type st_2 from statictext within wtc_trabajos_disenyo
integer x = 3685
integer y = 2376
integer width = 402
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 24076881
string text = "Imagen"
alignment alignment = center!
boolean focusrectangle = false
end type

type r_1 from rectangle within wtc_trabajos_disenyo
linestyle linestyle = transparent!
long fillcolor = 67108864
integer x = 3470
integer y = 2364
integer width = 818
integer height = 600
end type

type dw_historicomodelo from u_dw_padre within wtc_trabajos_disenyo
integer x = 37
integer y = 2360
integer width = 3410
integer height = 596
integer taborder = 30
string dataobject = "dwtc_historicomodelo"
end type

event usr_dwnkey;call super::usr_dwnkey;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

//if key = KeyF8! then
//	dw_1.EVENT usr_keydown(key, keyflags)
//end if

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "deshistorico_cliente"
			busqueda.titulo_ventana = "Búsqueda de Cliente"
			busqueda.consulta  = " SELECT CODIGO, RAZON "+&
										" FROM genter "+&
										" WHERE empresa = '"+codigo_empresa+"' and tipoter = 'C' ORDER BY RAZON"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Razón "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.deshistorico_cliente[this.GetRow()] 			= resultado.valores[1]		
				this.object.genter_razon[this.GetRow()] 					= resultado.valores[2]		
			end if

	END CHOOSE
end if	
	
end event

event itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "deshistorico_cliente"
		SELECT genter.razon
		INTO :resultado
		FROM genter
		WHERE empresa = :codigo_empresa
		and genter.codigo = :data
		and genter.tipoter = 'C';

		if SQLCA.sqlcode <> 100 then
			this.object.genter_razon[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.genter_razon[Row] 		= ''
			return 1			
		end if
END CHOOSE


end event

event doubleclicked;call super::doubleclicked;this.EVENT usr_dwnkey(KeyEnter!, 0)

end event

type dw_con_piezas_coleccion from u_dw_padre within wtc_trabajos_disenyo
integer x = 4311
integer y = 2360
integer width = 1266
integer height = 596
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

event clicked;call super::clicked;str_parametros lstr_param 

if row > 0 then
	if dwo.name = "desmodelo_modelo" then
//		if hay_cambios() then
//			if MessageBox("Atención","Los cambios no guardados se perderán, ¿Desea continuar?",Question!,YesNo!,2) = 2 then
//				return
//			end if
//		end if
		padre_codigo = this.object.desmodelo_modelo[row]	
		
		lstr_param.s_argumentos[1] = padre_codigo
		lstr_param.i_nargumentos = 1
		lstr_param.nombre_ventana = "w_con_trabajos_disenyador2"
		lstr_param.resultado = ''
		
		Message.PowerObjectParm = lstr_param
		Parent.triggerevent(open!)
	end if
end if
end event

type cb_pasar_pieza from commandbutton within wtc_trabajos_disenyo
boolean visible = false
integer x = 2939
integer y = 132
integer width = 562
integer height = 128
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Pasar a Pieza"
end type

event clicked;dw_fecha_necesidad.reset()
dw_fecha_necesidad.insertrow(0)
dw_fecha_necesidad.visible = not(dw_fecha_necesidad.visible)
end event

type cb_generar_pieza from commandbutton within wtc_trabajos_disenyo
boolean visible = false
integer x = 2363
integer y = 132
integer width = 562
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Generar Pieza"
end type

event clicked;string ambiente, disenyador, estado2, observaciones_col, comercial, comercial_trabajo
string pieza, funcion, observaciones_pz, laboratorio, pavrev
string serie, relieve, formato, pasta, acabado_lab, contratipo, aceptado, base_cliente, base, observaciones_trab 
datetime fecha_solicitud, fecha_necesidad, fecha_lab
long max_coleccion, trabajo, modelo
string v_coleccion, grafica, INKCID
Dwobject temp

if hay_cambios() then
	MessageBox("Atención","Debe guardar los cambios o cancelar antes de Generar una pieza nueva")
	return
end if

if dwtc_mant_trabajos_disenyo.getrow() > 0 and dw_1.rowcount() > 0 then
	v_coleccion = 	dw_1.object.coleccion[dw_1.GetRow()]
	if padre_codigo <> '' then				
			
		max_coleccion = long(v_coleccion)
	
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		// 										 Carga de los datos del modelo												//
		/////////////////////////////////////////////////////////////////////////////////////////////////////

		disenyador = dw_1.object.tecnico_dis[dw_1.getrow()]
		funcion = dw_1.object.funcion[dw_1.getrow()]
		observaciones_pz = dw_1.object.observaciones[dw_1.getrow()]
		pavrev = dw_1.object.pavrev[dw_1.getrow()]
		INKCID = dw_1.object.desmodelo_inkcid[dw_1.getrow()]

		/////////////////////////////////////////////////////////////////////////////////////////////////////
		// 										 Carga de los datos del trabajo												//
		/////////////////////////////////////////////////////////////////////////////////////////////////////

		//formato = dwtc_mant_trabajos_disenyo.object.destrabajo2_formato[dwtc_mant_trabajos_disenyo.Getrow()]
		//relieve = dwtc_mant_trabajos_disenyo.object.destrabajo2_relieve[dwtc_mant_trabajos_disenyo.Getrow()]
		//acabado_lab = dwtc_mant_trabajos_disenyo.object.destrabajo2_acabado_lab[dwtc_mant_trabajos_disenyo.Getrow()]
		trabajo = dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[dwtc_mant_trabajos_disenyo.Getrow()]
		serie = dwtc_mant_trabajos_disenyo.object.destrabajo2_serie[dwtc_mant_trabajos_disenyo.Getrow()]
		pasta = dwtc_mant_trabajos_disenyo.object.destrabajo2_pasta[dwtc_mant_trabajos_disenyo.Getrow()]
		comercial_trabajo = dwtc_mant_trabajos_disenyo.object.destrabajo2_comercial[dwtc_mant_trabajos_disenyo.Getrow()]
		fecha_solicitud = datetime(today())
		setnull (fecha_necesidad)
		setnull (fecha_lab)
		contratipo = dwtc_mant_trabajos_disenyo.object.destrabajo2_contratipo[dwtc_mant_trabajos_disenyo.Getrow()]
		aceptado = dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[dwtc_mant_trabajos_disenyo.Getrow()]
		base_cliente = dwtc_mant_trabajos_disenyo.object.destrabajo2_base_cliente[dwtc_mant_trabajos_disenyo.Getrow()]
	//	observaciones_trab = dwtc_mant_trabajos_disenyo.object.destrabajo2_observaciones[dwtc_mant_trabajos_disenyo.Getrow()]
		laboratorio = dwtc_mant_trabajos_disenyo.object.destrabajo2_laboratorio[dwtc_mant_trabajos_disenyo.Getrow()]


		/////////////////////////////////////////////////////////////////////////////////////////////////////
		// 										 Nuevo modelo y nuevo trabajo													//
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		 pb_nuevo.triggerevent(clicked!)
		 
		 //CARGA DEL MODELO
		 dw_1.accepttext()
		 dw_1.object.coleccion[dw_1.Getrow()] = v_coleccion
		 dw_1.EVENT itemchanged(dw_1.Getrow(), dw_1.object.coleccion, v_coleccion)
		 dw_1.object.tecnico_dis[dw_1.getrow()] = disenyador
		 dw_1.EVENT itemchanged(dw_1.Getrow(), dw_1.object.tecnico_dis, disenyador)
		 dw_1.object.comercial[dw_1.getrow()] = comercial_trabajo
		 dw_1.EVENT itemchanged(dw_1.Getrow(), dw_1.object.comercial, comercial_trabajo)
		 //dw_1.object.funcion[dw_1.Getrow()] = funcion
		 dw_1.object.observaciones[dw_1.Getrow()] = observaciones_pz
		 dw_1.object.pavrev[dw_1.Getrow()] = pavrev
		 dw_1.object.desmodelo_inkcid[dw_1.Getrow()] = INKCID
		 
		 //'N'
		
		 //CARGA DEL TRABAJO
		 pb_anyade_trabajo.triggerevent(clicked!)
		 
		 dwtc_mant_trabajos_disenyo.accepttext()
		 dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[dwtc_mant_trabajos_disenyo.Getrow()] = trabajo
		 dwtc_mant_trabajos_disenyo.object.destrabajo2_serie[dwtc_mant_trabajos_disenyo.Getrow()] = serie
		 temp = dwtc_mant_trabajos_disenyo.object.destrabajo2_serie
		 dwtc_mant_trabajos_disenyo.EVENT itemchanged(dwtc_mant_trabajos_disenyo.Getrow(), temp, serie)
		 dwtc_mant_trabajos_disenyo.object.destrabajo2_pasta[dwtc_mant_trabajos_disenyo.Getrow()] = pasta
		 dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis[dwtc_mant_trabajos_disenyo.Getrow()] = disenyador
		 temp = dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis
		 dwtc_mant_trabajos_disenyo.EVENT itemchanged(dwtc_mant_trabajos_disenyo.Getrow(), temp, disenyador) 
		 dwtc_mant_trabajos_disenyo.object.destrabajo2_comercial[dwtc_mant_trabajos_disenyo.Getrow()] = comercial_trabajo
		 temp = dwtc_mant_trabajos_disenyo.object.destrabajo2_comercial
		 dwtc_mant_trabajos_disenyo.EVENT itemchanged(dwtc_mant_trabajos_disenyo.Getrow(), temp, comercial_trabajo)
		 dwtc_mant_trabajos_disenyo.object.destrabajo2_contratipo[dwtc_mant_trabajos_disenyo.Getrow()] = contratipo
		 dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[dwtc_mant_trabajos_disenyo.Getrow()] = aceptado
		 dwtc_mant_trabajos_disenyo.object.destrabajo2_base_cliente[dwtc_mant_trabajos_disenyo.Getrow()] = base_cliente
		 //dwtc_mant_trabajos_disenyo.object.destrabajo2_observaciones[dwtc_mant_trabajos_disenyo.Getrow()] = observaciones_trab
		 dwtc_mant_trabajos_disenyo.object.destrabajo2_laboratorio[dwtc_mant_trabajos_disenyo.Getrow()] = laboratorio
		 
		 
		 
	
	end if
else
	messagebox("Atención", "Debe seleccionar el trabajo que se desee duplicar.")
end if


end event

type cb_generar_coleccion from commandbutton within wtc_trabajos_disenyo
boolean visible = false
integer x = 1792
integer y = 132
integer width = 562
integer height = 128
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Generar Colección"
end type

event clicked;str_ventana_alerta parametros
string botones[2]
Int aviso, resultado 

if hay_cambios() then
	MessageBox("Atención","Debe guardar antes de generar una colección nueva")
	return 1
end if

parametros.titulo = "Atención"
parametros.subtitulo = "Generar Colección"
parametros.mensaje = "¿Desea generar una colección nueva?~nEstos cambios se guardarán inmediatamente una vez realizados."
botones[1] = "Sí"
botones[2] = "No"
parametros.tipo = 2
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
aviso = Int(Message.DoubleParm)

if aviso = 1 then
	//GRABADO PREVIO
	//resultado = f_guardar()
	//if resultado <> 1 then
	//	return 1
	//end if 
	
	if dwtc_mant_trabajos_disenyo.getrow() > 0 then
		if f_duplicar(1)  then
			
		end if
	else
		messagebox("Atención", "Debe seleccionar el trabajo que se desee duplicar.")
	end if
end if
end event

type dw_ficha_comercial from datawindow within wtc_trabajos_disenyo
boolean visible = false
integer x = 242
integer y = 1476
integer width = 1371
integer height = 624
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_report_solicitud2"
boolean livescroll = true
end type

type cb_fecha_coleccion from commandbutton within wtc_trabajos_disenyo
integer x = 1303
integer y = 360
integer width = 306
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fecha"
end type

event clicked;Int grabar_fecha
datetime fecha, hoy
string coleccion
str_ventana_alerta parametros
string botones[2]

if dw_1.rowcount() > 0 then
	coleccion = dw_1.object.coleccion[dw_1.getrow()]
	
	select fecha_coleccion
	into :fecha
	from descoleccionsol
	where empresa = :codigo_empresa
	and codigo = :coleccion;	
	
	parametros.titulo = "Atención"
	parametros.subtitulo = "Asignar Fecha a la Colección"
	parametros.mensaje = "¿Desea asignar la fecha de hoy a la colección?~nEstos cambios se guardarán inmediatamente una vez realizados."
	botones[1] = "Sí"
	botones[2] = "No"
	parametros.tipo = 2
	parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	grabar_fecha = Int(Message.DoubleParm)
	
	if not isnull (fecha) and grabar_fecha = 1 then
		if messagebox ("Aviso", "Esta colección ya tiene fecha, desea modificarla", Exclamation!, YesNo!, 2 ) = 2 then
			grabar_fecha = 2
		end if
	end if
	
	if grabar_fecha = 1 then
		hoy = datetime(today())
		update descoleccionsol set fecha_coleccion = :hoy
		where empresa = :codigo_empresa
		and codigo = :coleccion using sqlca;
		
		if SQLCA.SQLCode = -1 then
			MessageBox("SQL error", SQLCA.SQLErrText)
			Rollback using sqlca;
		else
			dw_1.object.descoleccionsol_fecha_coleccion[dw_1.getrow()] = hoy
			commit using sqlca;
		end if
	end if		
end if



end event

type dwtc_mant_trabajos_disenyo from u_dw within wtc_trabajos_disenyo
event rbuttondwn pbm_dwnrbuttondown
integer x = 37
integer y = 1000
integer width = 5541
integer height = 1344
integer taborder = 30
string dataobject = "dwtc_mant_trabajos_disenyo"
boolean vscrollbar = true
end type

event rbuttondwn;Integer registros
string codigo_inkcid


CHOOSE CASE dwo.name
	CASE "destrabajo2_cod_inkcid"
		MessageBox("Atención", "Los códigos TIF y Kerajet los genera el diseñador en la ventana de archivos pieza.")
		/*
		if messagebox("Pregunta", "Desea generar un código INKCID",     Question!, YesNo!, 2) = 1 then
			connect using SQLCA;
			Select count(*) 
			Into   :registros
			From   desimagenestif	
			Where  empresa = :codigo_empresa;
			IF registros=0 THEN
				codigo_inkcid = "1"
			ELSE
				Select max(convert(int,codigo)+1)
				Into   :codigo_inkcid
				From   desimagenestif
				Where  empresa = :codigo_empresa;
			END IF
			
			insert into desimagenestif (empresa, codigo, modelo)
			values (:codigo_empresa, :codigo_inkcid, :padre_codigo);
			
			this.object.destrabajo2_cod_inkcid[row] = codigo_inkcid
			if SQLCA.SQLCode = 0 then
				commit using SQLCA;
			else
				rollback using SQLCA;
			end if
		end if
		*/
END CHOOSE





end event

event clicked;call super::clicked;str_parametros lstr_param
long esta_abierta


CHOOSE CASE dwo.name

CASE "p_serie"
esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_serie")
//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
if esta_abierta = -1 then
	lstr_param.s_argumentos[1] = this.object.destrabajo2_serie[row]
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_trabajos_disenyo"
	lstr_param.resultado = ''
	Openwithparm(wtc_mant_serie, lstr_param)
else
	ventanas_activas[esta_abierta].ventana.BringToTop = true
end if
END CHOOSE


end event

event itemchanged;call super::itemchanged;string resultado, resultado1
dec  resultado2, resultado3
datetime resultado_fecha

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "destrabajo2_serie"
		SELECT desserie.descripcion
		INTO :resultado
		FROM desserie
		WHERE empresa = :codigo_empresa
		and desserie.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.desserie_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.desserie_descripcion[Row] 		= ''
			return 2			
		end if

	CASE "destrabajo2_formato"
		SELECT formatos.abreviado, formatos.ancho, formatos.largo 
		INTO :resultado, :resultado2, :resultado3
		FROM formatos
		WHERE empresa = :codigo_empresa
		and formatos.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.formatos_abreviado[Row] 		= resultado
			this.object.formatos_ancho[Row] 		= resultado2
			this.object.formatos_largo[Row] 		= resultado3
		else
			dwo.Primary[row] = ''
			this.object.formatos_abreviado[Row] 		= ''
			this.object.formatos_ancho[Row] = 0
			this.object.formatos_largo[Row]  = 0
			return 2
		end if

	CASE "destrabajo2_relieve"
		SELECT art_tipomoldura.descripcion
		INTO :resultado
		FROM art_tipomoldura
		WHERE empresa = :codigo_empresa
		and art_tipomoldura.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.art_tipomoldura_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.art_tipomoldura_descripcion[Row] 		= ''
			return 2			
		end if

	CASE "destrabajo2_acabado_lab"
		SELECT tipoacabado_lab.descripcion
		INTO :resultado
		FROM tipoacabado_lab
		WHERE empresa = :codigo_empresa
		and tipoacabado_lab.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tipoacabado_lab_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tipoacabado_lab_descripcion[Row] 		= ''
			return 2			
		end if

	CASE "destrabajo2_tecnico_dis"
		SELECT tecnico_dis.descripcion 
		INTO :resultado
		FROM tecnico_dis
		WHERE empresa = :codigo_empresa
		and tecnico_dis.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tecnico_dis_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tecnico_dis_descripcion[Row] 		= ''
			return 2
		end if
		
	CASE "destrabajo2_comercial"
		SELECT comercial.descripcion 
		INTO :resultado
		FROM comercial
		WHERE empresa = :codigo_empresa
		and comercial.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.comercial_descripcion[Row] 		= resultado
//			this.Modify("comercial_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
		else
			dwo.Primary[row] = ''
			this.object.comercial_descripcion[Row] 		= ''
			return 2
		end if
END CHOOSE


this.Accepttext()
end event

event usr_dwnkey;call super::usr_dwnkey;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

//if key = KeyF8! then
	//dw_1.EVENT usr_keydown(key, keyflags)
//end if

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "destrabajo2_serie"
			busqueda.titulo_ventana = "Búsqueda de Serie"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION "+&
										" FROM desserie "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Serie "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.destrabajo2_serie[this.GetRow()] 			= resultado.valores[1]		
				this.object.desserie_descripcion[this.GetRow()] 		= resultado.valores[2]		
			end if

		CASE "destrabajo2_formato"
			busqueda.titulo_ventana = "Búsqueda de Formato"
			busqueda.consulta  = " SELECT CODIGO, ABREVIADO, convert (decimal (10, 2), ancho) , convert (decimal (10, 2), largo) "+&
										" FROM FORMATOS "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Formato"
			busqueda.titulos[3] = "Ancho "
			busqueda.titulos[4] = "Largo"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.destrabajo2_formato[this.GetRow()] 		= resultado.valores[1]	
				this.object.formatos_abreviado[this.GetRow()] 		= resultado.valores[2]		
				this.object.formatos_ancho[this.GetRow()] 		= dec ( truncate ( dec ( resultado.valores[3] ), 2 ) )
				this.object.formatos_largo[this.GetRow()] 		= dec ( truncate ( dec ( resultado.valores[4] ), 2 ) )
			end if

		CASE "destrabajo2_relieve"
			busqueda.titulo_ventana = "Búsqueda de Relieve"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION "+&
										" FROM art_tipomoldura "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Relieve "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.destrabajo2_relieve[this.GetRow()] 			= resultado.valores[1]		
				this.object.art_tipomoldura_descripcion[this.GetRow()] 		= resultado.valores[2]		
			end if
			
		CASE "destrabajo2_acabado_lab"
			busqueda.titulo_ventana = "Búsqueda de Acabado"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION "+&
										" FROM tipoacabado_lab "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Acabado "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.destrabajo2_acabado_lab[this.GetRow()] 			= resultado.valores[1]		
				this.object.tipoacabado_lab_descripcion[this.GetRow()] 		= resultado.valores[2]		
			end if
			
		CASE "destrabajo2_tecnico_dis"
			busqueda.titulo_ventana = "Búsqueda de Diseñador"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM TECNICO_DIS WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Diseñador"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.destrabajo2_tecnico_dis[this.GetRow()] 					= resultado.valores[1]			
				this.object.tecnico_dis_descripcion[this.GetRow()] 	= resultado.valores[2]			
			end if		
			
		CASE "destrabajo2_comercial"
			busqueda.titulo_ventana = "Búsqueda de Comercial"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM comercial WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Comercial"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.destrabajo2_comercial[this.GetRow()] 					= resultado.valores[1]			
				this.object.comercial_descripcion[this.GetRow()] 	= resultado.valores[2]			
//				this.Modify("comercial_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
			end if		
			
	END CHOOSE
end if	
	
end event

type p_seleccion from picture within wtc_trabajos_disenyo
boolean visible = false
integer x = 1065
integer y = 108
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Tencer_PB12\fila_seleccionada.png"
boolean focusrectangle = false
end type

type pb_anyade_archivo from picturebutton within wtc_trabajos_disenyo
integer x = 3557
integer y = 836
integer width = 146
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;long fila_actual, nuevo_codigo, indice, maximo_valor_dw
string modelo_actual, cliente, propuesta, pieza, version_color

nuevo_codigo = 0

modelo_actual = dw_1.object.#1[dw_1.getrow()]

if not isnull(modelo_actual) and modelo_actual <> "" then
	maximo_valor_dw = long(dw_archivos.Describe("Evaluate('Max(integer(desmodelo_archivo_codigo))', 0)"))
	if isnull(maximo_valor_dw) then maximo_valor_dw = 0
	nuevo_codigo = maximo_valor_dw +1
else
	MessageBox("Error","Debe guardar el Modelo Nuevo antes de añadir archivos")
	return
end if

fila_actual = dw_archivos.InsertRow(0)

dw_archivos.object.desmodelo_archivo_codigo[fila_actual] = String(nuevo_codigo)

dw_archivos.scrolltorow(fila_actual)
dw_archivos.SetColumn(2)
dw_archivos.Setfocus()
dw_archivos.object.desmodelo_archivo_empresa[fila_actual] = codigo_empresa
dw_archivos.object.desmodelo_archivo_modelo[fila_actual] = modelo_actual

end event

type pb_borrar_archivo from picturebutton within wtc_trabajos_disenyo
integer x = 3707
integer y = 836
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
string picturename = "C:\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
string powertiptext = "EliminarRegistro"
end type

event clicked;boolean error_borrando
long fila_actual, total, total2, archivos, pruebas, aviso
String modelo, cliente, propuesta, pieza, archivo, archivo_dis, tipo_maquina
str_ventana_alerta parametros
string botones[2]

error_borrando = false
fila_actual = dw_archivos.getrow()
if isnull(fila_actual) or fila_actual = 0 then
	MessageBox("Error","Debe seleccionar una fila para borrar")
	return
end if

tipo_maquina = dw_archivos.object.desmodelo_archivo_tipo_maquina_disenyo[fila_actual]
archivo_dis = dw_archivos.object.desmodelo_archivo_archivo_disenyo[fila_actual]

//No podemos borrar un archivo si hay aplicaciones de laboratorio que lo usan
total2 = 0
SELECT COUNT(*) INTO :total2 FROM archivo_disenyo_sistema_archivos WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipo_maquina AND archivo = :archivo_dis;

if total2 > 0 then
	parametros.titulo = "Atención"
	parametros.subtitulo = "Desvincular Archivo"
	parametros.mensaje = "Si el archivo no se usa en ningún modelo más, contine ficheros que antes debería borrar. ¿Seguro que quiere desvincular el archivo?"
	botones[1] = "Sí"
	botones[2] = "No"
	parametros.tipo = 2
	parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	aviso = Int(Message.DoubleParm)
	if aviso = 1 then
		if dw_archivos.DeleteRow(fila_actual) <> 1 then
			error_borrando = True
		else
			error_borrando = False
		end if
	end if
else
	if dw_archivos.DeleteRow(fila_actual) <> 1 then
		error_borrando = True
	else
		error_borrando = False
	end if
end if

if error_borrando then
	MessageBox("Error","No ha sido posible borrar el archivo")
end if


end event

type dw_archivos from u_dw within wtc_trabajos_disenyo
integer x = 3525
integer y = 296
integer width = 2053
integer height = 692
integer taborder = 80
string dataobject = "dwtc_modelo_archivo_antiguo"
boolean vscrollbar = true
end type

event clicked;call super::clicked;String codigo_nuevo, prefijo, nombre, tipo
str_colisiones pcolisiones

str_parametros lstr_param
long esta_abierta, aviso

Datastore dependencias 
String modelo, sel, articulos, articulos1, articulos2, archivo
Int i, numero, numero1, numero2

str_ventana_alerta parametros
string botones[2]

CHOOSE CASE dwo.name
	CASE "p_archivos"
		if hay_cambios() then
			//MessageBox("Atención", "Debe guardar los cambios antes de gestionar los archivos de la pieza")
			if f_guardar() <> 1 then
				return //Fallo de validación en la grabación
			end if
		end if
		
		if f_codigo_principal() = "" then
			return
		end if
		
		//La ventana será response
		lstr_param.s_argumentos[1] = this.object.desmodelo_archivo_tipo_maquina_disenyo[row]
		lstr_param.s_argumentos[2] = this.object.desmodelo_archivo_archivo_disenyo[row]
		lstr_param.s_argumentos[3] = this.object.archivo_disenyo_nombre[row]
		lstr_param.i_nargumentos = 3
		lstr_param.nombre_ventana = "wtc_trabajos_disenyo_nuevo"
		lstr_param.resultado = ''
		Openwithparm(wtc_mant_archivos_disenyo_sistema_archivos, lstr_param)
		
	CASE "p_nuevo"
		tipo = this.object.desmodelo_archivo_tipo_maquina_disenyo[row]
		if isnull(tipo) or tipo = "" then
			MessageBox("Error","Debe indicar el tipo de máquina para generar un archivo nuevo.")
			destroy dependencias
			return
		end if
		if not isnull(this.object.desmodelo_archivo_archivo_disenyo[row]) and this.object.desmodelo_archivo_archivo_disenyo[row] <> "" then
			parametros.titulo = "Atención"
			parametros.subtitulo = "Nuevo Archivo"
			parametros.mensaje = "Va a generar un archivo nuevo, ¿desea reemplazar el archivo actual "+String(this.object.archivo_disenyo_nombre[row])+" por uno nuevo?"
			botones[1] = "Sí"
			botones[2] = "No"
			parametros.tipo = 2
			parametros.botones = botones
			parametros.mostrar_imagen = true
			openwithparm(wtc_ventana_alerta, parametros)
			aviso = Int(Message.DoubleParm)
			if aviso = 2 then
				destroy dependencias
				return
			end if
		end if

		//-------------------------------------------------------------------------------------
		// Incio de trans_ts
		//-------------------------------------------------------------------------------------
		pcolisiones.empresa = codigo_empresa
		pcolisiones.tabla = "archivo_disenyo"
		pcolisiones.campo = "codigo"
		pcolisiones.filtro = pcolisiones.tabla+".tipomaquina_disenyo = '"+this.object.desmodelo_archivo_tipo_maquina_disenyo[row]+"'"				
		pcolisiones.buscar_huecos = true
		codigo_nuevo = String(f_colisiones(trans_ts, pcolisiones))
		
		if codigo_nuevo = '0'  then
			messagebox("ERROR", "No se ha podido generar un archivo nuevo. Intentelo mas tarde y si ocurre el error de nuevo contacte con el administrador.")
			ROLLBACK USING trans_ts;
		else
			/*********************************************************************************/
			// Creación del nombre para el fichero
			SELECT prefijo INTO :prefijo FROM tipomaquina_disenyo WHERE empresa = :codigo_empresa AND codigo = :tipo using trans_ts;
			nombre = prefijo + codigo_nuevo
			
			INSERT INTO archivo_disenyo (empresa, tipomaquina_disenyo, codigo, nombre) VALUES (:codigo_empresa,:tipo,:codigo_nuevo,:nombre) USING trans_ts;
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error en la inserción de archivo ", trans_ts.SQLErrText)
				ROLLBACK USING trans_ts;
			END IF
				
			this.object.desmodelo_archivo_archivo_disenyo[row] = codigo_nuevo
			this.object.archivo_disenyo_nombre[row] = nombre
			/*********************************************************************************/
			
			COMMIT USING trans_ts;
		end if
		//-------------------------------------------------------------------------------------
		// Fin de trans_ts
		//-------------------------------------------------------------------------------------
		
END CHOOSE

destroy dependencias


end event

event itemchanged;call super::itemchanged;string resultado, resultado1, tipo, modelo, cliente, propuesta, codigo, descripcion, pieza, version_color, codigo_actual, tipo_maquina_disenyo_actual
dec  resultado2, resultado3
datetime resultado_fecha
int alerta, info, fila, ficheros, i

String serigrafia_codigo, serigrafia_nombre
Boolean serigrafia_automatica = true

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "desmodelo_archivo_tipo_maquina_disenyo"
		SELECT descripcion
		INTO :resultado
		FROM tipomaquina_disenyo
		WHERE empresa = :codigo_empresa
		and codigo = :data;
		
		//Si cambia el tipo, eliminar los archivos porque son dependientes
		if this.object.desmodelo_archivo_archivo_nombre_actual[Row] <> "" then
			if MessageBox("Atención", "Cambiar el tipo de máquina, pondrá en blanco la casilla de archivo, ¿desea continuar?", Question!, YesNo!, 2) = 2 then
				tipo_maquina_disenyo_actual  = this.object.desmodelo_archivo_tipo_maquina_disenyo_actual[Row]
				SELECT descripcion
				INTO :resultado
				FROM tipomaquina_disenyo
				WHERE empresa = :codigo_empresa
				and codigo = :tipo_maquina_disenyo_actual;
				dwo.Primary[row] = tipo_maquina_disenyo_actual
				this.object.tipomaquina_disenyo_descripcion[Row] = resultado
				return 2		
			end if
		end if
		this.object.desmodelo_archivo_archivo_nombre_actual[Row]	= ""
		this.object.desmodelo_archivo_archivo_disenyo[Row] 			= ""	
		this.object.archivo_disenyo_nombre[Row] 	= ""

		if SQLCA.sqlcode <> 100 then
			this.object.tipomaquina_disenyo_descripcion[Row] 		= resultado
			this.object.desmodelo_archivo_tipo_maquina_disenyo_actual[Row] = resultado			
		else			
			dwo.Primary[row] = ''
			this.object.tipomaquina_disenyo_descripcion[Row] 		= ''
			return 2			
		end if
	CASE "desmodelo_archivo_archivo_disenyo"
		tipo = this.object.desmodelo_archivo_tipo_maquina_disenyo[Row]
		if isnull(tipo) or tipo = "" then
			MessageBox("Error","Debe seleccionar un tipo de maquina antes de indicar el archivo")
			dwo.Primary[row] = this.object.desmodelo_archivo_archivo_nombre_actual[row]
			return 2
		end if
		SELECT nombre
		INTO :resultado
		FROM archivo_disenyo
		WHERE empresa = :codigo_empresa 
		AND tipomaquina_disenyo = :tipo 
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.archivo_disenyo_nombre[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.archivo_disenyo_nombre[Row] 		= ''
			return 2			
		end if	
END CHOOSE


this.Accepttext()
end event

event usr_dwnkey;call super::usr_dwnkey;string campo, modelo, cliente, propuesta, tipo, codigo, tipo_maquina_disenyo_actual, descripcion
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda
Int alerta, info, num_versiones, ficheros

//if key = KeyF8! then
	//dw_1.EVENT usr_keydown(key, keyflags)
//end if

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "desmodelo_archivo_tipo_maquina_disenyo"
			busqueda.titulo_ventana = "Búsqueda de Tipo de Máquina"
			busqueda.consulta  =  "  SELECT tipomaquina_disenyo.codigo, tipomaquina_disenyo.descripcion "+&
										 "  FROM   tipomaquina_disenyo   "+&
										 "  WHERE  tipomaquina_disenyo.empresa = '"+codigo_empresa+"'"+&
	 									 "  ORDER BY tipomaquina_disenyo.descripcion ASC  "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Tipo de Máquina"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				if this.object.archivo_disenyo_nombre[this.GetRow()] <> "" then
					if MessageBox("Atención", "Cambiar el tipo de máquina, pondrá en blanco la casilla del archivo, ¿desea continuar?", Question!, YesNo!, 2) = 2 then
						tipo_maquina_disenyo_actual  = this.object.tipo_maquina_disenyo_actual[this.GetRow()]
						SELECT descripcion
						INTO :descripcion
						FROM tipomaquina_disenyo
						WHERE empresa = :codigo_empresa
						and codigo = :tipo_maquina_disenyo_actual;
						this.object.desmodelo_archivo_tipo_maquina_disenyo[this.GetRow()] 						= tipo_maquina_disenyo_actual		
						this.object.tipomaquina_disenyo_descripcion[this.GetRow()] 			= descripcion
						return 
					end if
				end if
				this.object.desmodelo_archivo_tipo_maquina_disenyo[this.GetRow()] 						= resultado.valores[1]		
				this.object.desmodelo_archivo_tipo_maquina_disenyo_actual[this.GetRow()]				= resultado.valores[1]		
				this.object.tipomaquina_disenyo_descripcion[this.GetRow()] 			= resultado.valores[2]	
				this.object.desmodelo_archivo_archivo_nombre_actual[this.GetRow()]	= ""
				
				//Si cambia el tipo, eliminar los archivos porque son dependientes
				this.object.desmodelo_archivo_archivo_disenyo[this.GetRow()] 			= ""	
				this.object.archivo_disenyo_nombre[this.GetRow()] 	= ""
			end if

		CASE "desmodelo_archivo_archivo_disenyo"
			tipo = this.object.desmodelo_archivo_tipo_maquina_disenyo[this.getrow()]
			if isnull(tipo) or tipo = "" then
				MessageBox("Error","Debe seleccionar un tipo de maquina antes de indicar el archivo")
				return
			end if
			busqueda.titulo_ventana = "Búsqueda de Archivos de Diseño"
			busqueda.consulta  = " SELECT codigo, nombre "+&
										" FROM archivo_disenyo "+&
										" WHERE empresa = '"+codigo_empresa+"' AND tipomaquina_disenyo = '"+tipo+"' ORDER BY codigo ASC"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Formato"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				codigo = resultado.valores[1]
				this.object.desmodelo_archivo_archivo_disenyo[this.GetRow()] 		= codigo
				this.object.archivo_disenyo_nombre[this.GetRow()] 		= resultado.valores[2]		
			end if

	END CHOOSE
end if	
	
end event

type dw_fecha_necesidad from datawindow within wtc_trabajos_disenyo
boolean visible = false
integer x = 3511
integer y = 132
integer width = 2043
integer height = 452
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_fecha_necesidad"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicking;string tecnico, descripcion, coleccion, comercial, tiff, codigo
Datetime fecha_necesidad
long v_control, v_maximo
int retardo = 6, k, fila_trabajo_seleccionado
string v_control_inkcid, es_inkcid, trabajo_inkcid
dec prioridad
boolean correcto = true
Dwobject temp
str_ventana_alerta parametros
string botones[2]
Int aviso, fila, resultado

if dwo.name = "b_continuar" then
	/*
	parametros.titulo = "Atención"
	parametros.subtitulo = "Pasar a Pieza"
	parametros.mensaje = "¿Seguro que desea pasar a pieza?~nEstos cambios se guardarán inmediatamente una vez realizados."
	botones[1] = "Sí"
	botones[2] = "No"
	parametros.tipo = 2
	parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	aviso = Int(Message.DoubleParm)
	*/
	aviso = 1
	
	fila = dw_1.getrow()
	fila_trabajo_seleccionado = dwtc_mant_trabajos_disenyo.getrow()
	codigo = f_codigo_principal()
	if not isnull(codigo) and codigo <> '' and aviso = 1 then
		dw_fecha_necesidad.accepttext()
		//GRABADO PREVIO
		resultado = f_guardar()
		fecha_necesidad = dw_fecha_necesidad.object.fecha_necesidad[1]
		if resultado <> 1 or isnull(fecha_necesidad) or String(fecha_necesidad) = "00/00/00" then
			//Error guardando...
			return -1
		end if
		
		if dwtc_mant_trabajos_disenyo.rowcount() > 0 then
			comercial = dwtc_mant_trabajos_disenyo.object.destrabajo2_comercial[fila_trabajo_seleccionado]
			tiff = dwtc_mant_trabajos_disenyo.object.destrabajo2_cod_inkcid[fila_trabajo_seleccionado]
			if dwtc_mant_trabajos_disenyo.getrow() <> fila_trabajo_seleccionado then
				dwtc_mant_trabajos_disenyo.setrow(fila_trabajo_seleccionado)
				dwtc_mant_trabajos_disenyo.Event rowfocuschanged(fila_trabajo_seleccionado)
			end if
			//fecha_necesidad = Date(dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_solicitud[dwtc_mant_trabajos_disenyo.getrow()])
			pb_duplica_trabajo.triggerevent(clicked!)
			dwtc_mant_trabajos_disenyo.object.destrabajo2_comercial[dwtc_mant_trabajos_disenyo.getrow()] = comercial
			temp = dwtc_mant_trabajos_disenyo.object.destrabajo2_comercial
			dwtc_mant_trabajos_disenyo.EVENT itemchanged(dwtc_mant_trabajos_disenyo.Getrow(), temp, comercial)
			dwtc_mant_trabajos_disenyo.object.destrabajo2_cod_inkcid[dwtc_mant_trabajos_disenyo.getrow()] = tiff
			//dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_necesidad[dwtc_mant_trabajos_disenyo.getrow()] = RelativeDate(fecha_necesidad,7)
			dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_necesidad[dwtc_mant_trabajos_disenyo.getrow()] = fecha_necesidad
		else
			pb_anyade_trabajo.triggerevent(clicked!)
		end if		
		
		coleccion = dw_1.object.coleccion[1] 
		trabajo_inkcid = 'N'
		for k = 1 to dwtc_mant_trabajos_disenyo.rowcount()
			if dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid[k] = 'S' then
				trabajo_inkcid = 'S'
			end if
		next
		
		tecnico = ""
		
		select tecnico_lab
		into :tecnico
		from descoleccionsol 
		where empresa = :codigo_empresa
		and codigo = :coleccion 
		and tecnico_lab is not null;		
		
		if isnull(tecnico)  or tecnico = '' then
			select tecnico_lab
			into :tecnico
			from desmodelo 
			where empresa = :codigo_empresa
			and coleccion = :coleccion
			and tecnico_lab is not null;
		end if
		
		if isnull(tecnico) or tecnico = '' then  // Si el trabajo no tiene tecnico asociado,
			select codigo, descripcion, control, control_inkcid, es_inkcid, prioridad
			into :tecnico, :descripcion, :v_control, :v_control_inkcid, :es_inkcid, :prioridad
			from tecnico_lab
			where ( control + control_inkcid ) * prioridad = ( select min ((control + control_inkcid) * prioridad ) &
																				from tecnico_lab &
																				where empresa = :codigo_empresa and activo = 'S')
			and empresa = :codigo_empresa
			and activo = 'S';
			
			update tecnico_lab 
			set control = :v_control + 1
			where empresa = :codigo_empresa
			and codigo = :tecnico using SQLCA;
	
			if SQLCA.SqlCode = -1 then correcto = false;
		
		end if
		
		update desmodelo 
		set tecnico_lab = :tecnico
		where empresa = :codigo_empresa
		and modelo = :codigo using SQLCA;
	
		if SQLCA.SqlCode = -1 then correcto = false;
		
	
		// Ponemos el técnico en la colección
		update descoleccionsol
		set tecnico_lab = :tecnico
		where empresa = :codigo_empresa
		and codigo = :coleccion using SQLCA;
		
		if SQLCA.SqlCode = -1 then correcto = false;
	
		if correcto then 
			commit using SQLCA;
		else 
			messagebox("Atención", "No se pudo asignar técnico de laboratorio")
			rollback using SQLCA;
		end if
		
		dwtc_mant_trabajos_disenyo.object.destrabajo2_observaciones[dwtc_mant_trabajos_disenyo.getrow()] = "PASAR A PIEZA."
		dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_lab[dwtc_mant_trabajos_disenyo.getrow()] = tecnico
		
		if dwtc_mant_trabajos_disenyo.rowcount() > 0 then
			//FORZAMOS EL GUARDADO PARA EVITAR INCONSISTENCIAS EN EL DUPLICADO
			resultado = f_guardar()
			if resultado <> 1 then
				Messagebox("Error", "Se ha producido un error en el guardado de pasar a pieza.")
			else
				fila_trabajo_seleccionado = dwtc_mant_trabajos_disenyo.retrieve (codigo_empresa, dw_1.object.modelo[1])
				if fila_trabajo_seleccionado > 0 and dwtc_mant_trabajos_disenyo.getrow() <> fila_trabajo_seleccionado then
					dwtc_mant_trabajos_disenyo.setrow(fila_trabajo_seleccionado)
					dwtc_mant_trabajos_disenyo.Event rowfocuschanged(fila_trabajo_seleccionado)
				end if
			end if
		end if
	END IF	
	dw_fecha_necesidad.visible = false
else
	dw_fecha_necesidad.visible = false
end if
end event

