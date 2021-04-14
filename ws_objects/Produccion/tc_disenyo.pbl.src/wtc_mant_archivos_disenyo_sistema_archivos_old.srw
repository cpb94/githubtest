$PBExportHeader$wtc_mant_archivos_disenyo_sistema_archivos_old.srw
forward
global type wtc_mant_archivos_disenyo_sistema_archivos_old from wt_ventana_padre_grid
end type
type pb_descargar_archivo from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos_old
end type
type st_guardar from statictext within wtc_mant_archivos_disenyo_sistema_archivos_old
end type
type p_seleccion from picture within wtc_mant_archivos_disenyo_sistema_archivos_old
end type
type cb_explorar from commandbutton within wtc_mant_archivos_disenyo_sistema_archivos_old
end type
type pb_cargar_archivo from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos_old
end type
type st_produccion from statictext within wtc_mant_archivos_disenyo_sistema_archivos_old
end type
type cb_borrado_masivo from commandbutton within wtc_mant_archivos_disenyo_sistema_archivos_old
end type
end forward

global type wtc_mant_archivos_disenyo_sistema_archivos_old from wt_ventana_padre_grid
integer width = 5609
integer height = 1904
string title = "Sistema de Archivos de la Pieza"
string menuname = ""
boolean minbox = false
windowtype windowtype = response!
pb_descargar_archivo pb_descargar_archivo
st_guardar st_guardar
p_seleccion p_seleccion
cb_explorar cb_explorar
pb_cargar_archivo pb_cargar_archivo
st_produccion st_produccion
cb_borrado_masivo cb_borrado_masivo
end type
global wtc_mant_archivos_disenyo_sistema_archivos_old wtc_mant_archivos_disenyo_sistema_archivos_old

type variables
String tipo_maquina
String nombre_fichero
end variables

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();Long i, j, total_aplicaciones, total_filas, max_codigo, n_archivos_borrados, n_archivos_subidos
String ruta_disenyo, ruta_disenyo_archivo, ruta_disenyo_temp_archivo, nombre, extension, ruta_modelo, ruta_antigua
String sel, tipomaquina_disenyo, codigo_archivo, prueba_archivo, modelo, cliente, propuesta, pieza, prueba, aplicacion
String lista_archivos_borrados[], lista_archivos_subidos[]
Boolean borrado, registrar = false
str_registro_sistema registro
String usuario_windows

Datastore aplicaciones

ContextKeyword lcxk_base
This.GetContextService("Keyword", lcxk_base)
usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))

dw_1.accepttext()
rtn = 1

st_guardar.visible = true

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "archivo_disenyo_sistema_archivos"
param_colisiones.campo = "codigo"
param_colisiones.filtro = "archivo_disenyo_sistema_archivos.tipomaquina_disenyo = '"+tipo_maquina+"' and archivo_disenyo_sistema_archivos.archivo = '"+padre_codigo+"'"
param_colisiones.buscar_huecos = false //No buscamos huecos para evitar problemas de colisiones con el DW propio

dw_1.SetTransObject(trans_ts)	


if rtn <> -1 then
	
	n_archivos_borrados = 0
	For i = 1 To dw_1.deletedCount()
		//Borrado del archivo de las aplicaciones de las pruebas laboratorio
		//UPDATE modelo_aplicacion SET WHERE USING trans_ts;
		tipomaquina_disenyo = trim(dw_1.GetItemString(i,"tipomaquina_disenyo",Delete!,false))
		codigo_archivo = trim(dw_1.GetItemString(i,"archivo",Delete!,false))
		prueba_archivo = trim(dw_1.GetItemString(i,"codigo",Delete!,false))
		sel = "SELECT modelo_aplicacion.modelo, modelo_aplicacion.cliente, modelo_aplicacion.propuesta, modelo_aplicacion.pieza, modelo_aplicacion.prueba, modelo_aplicacion.codigo  "+&
  				"FROM modelo_aplicacion INNER JOIN modelo_archivo ON modelo_aplicacion.empresa = modelo_archivo.empresa AND modelo_aplicacion.modelo = modelo_archivo.modelo AND modelo_aplicacion.cliente = modelo_archivo.cliente AND modelo_aplicacion.propuesta = modelo_archivo.propuesta AND modelo_aplicacion.pieza = modelo_archivo.pieza AND modelo_aplicacion.modelo_archivo = modelo_archivo.codigo "+&
			   "WHERE modelo_archivo.empresa = '"+codigo_empresa+"' AND modelo_archivo.tipo_maquina_disenyo = '"+tipomaquina_disenyo+"' AND modelo_archivo.archivo_disenyo = '"+codigo_archivo+"' AND modelo_aplicacion.modelo_archivo_prueba = '"+prueba_archivo+"'"
		f_cargar_cursor_trans (trans_ts,  sel,  aplicaciones)
		
		j = 1
		total_aplicaciones = aplicaciones.RowCount()
		do while (j <= total_aplicaciones AND rtn = 1) 
			modelo = aplicaciones.object.modelo_aplicacion_modelo[j]
			cliente = aplicaciones.object.modelo_aplicacion_cliente[j]
			propuesta = aplicaciones.object.modelo_aplicacion_propuesta[j]
			pieza = aplicaciones.object.modelo_aplicacion_pieza[j]
			prueba = aplicaciones.object.modelo_aplicacion_prueba[j]
			aplicacion  = aplicaciones.object.modelo_aplicacion_codigo[j]
			
			UPDATE modelo_aplicacion set modelo_archivo = NULL, modelo_archivo_prueba = NULL 
			WHERE empresa = :codigo_empresa AND modelo = :modelo AND cliente = :cliente AND propuesta = :propuesta AND pieza = :pieza AND prueba = :prueba AND aplicacion = :aplicacion USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" Actualización de Aplicaciones de Laboratorio: "+String(trans_ts.SQLDBCode))
				rtn = -1
			END IF
			
			j++
		loop
		
		UPDATE modelo_pieza_ticket SET tipo_maquina = NULL, archivo_disenyo = NULL, archivo_disenyo_prueba = NULL 
		WHERE empresa = :codigo_empresa AND tipo_maquina = :tipomaquina_disenyo AND archivo_disenyo = :codigo_archivo AND archivo_disenyo_prueba = :prueba_archivo USING trans_ts;
		
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText +" Actualización de Tickets de Máquinas de Producción: "+String(trans_ts.SQLDBCode))
			rtn = -1
		END IF
		
		//Borrado de las imágenes eliminadas
		if dw_1.GetItemNumber(i,"ruta_local",Delete!,false) <> 1 then
			n_archivos_borrados++
			lista_archivos_borrados[n_archivos_borrados] = trim(dw_1.GetItemString(i,"ruta",Delete!,false)) + trim(dw_1.GetItemString(i,"fichero",Delete!,false))
			registrar = true
		else
			ruta_antigua = dw_1.GetItemString(i,"ruta_antigua",Delete!,false)
			if not isnull(ruta_antigua) and ruta_antigua <> "" then
				//Borramos el archivo antiguo si no concide con el nombre del nuevo
				n_archivos_borrados++
				lista_archivos_borrados[n_archivos_borrados] = ruta_antigua
				registrar = true
			end if
		end if
		//Borrado - Registro en tabla de cambios ******************************************************************************************************
		if registrar then
			registro.usuario_windows = usuario_windows
			registro.trans = trans_ts
			registro.accion = "BORRAR"
			registro.tabla = "modelo_sistema_archivos"
			registro.clave = trim(dw_1.GetItemString(i,"empresa",Delete!,false)) + "#" + trim(dw_1.GetItemString(i,"tipomaquina_disenyo",Delete!,false)) + "#" + trim(dw_1.GetItemString(i,"archivo",Delete!,false)) + "#" + trim(dw_1.GetItemString(i,"codigo",Delete!,false))
			registro.valor = (trim(dw_1.GetItemString(i,"ruta",Delete!,false)) + trim(dw_1.GetItemString(i,"fichero",Delete!,false)))
			ftc_registrar_cambios(registro)
			registrar = false
		end if
		//*********************************************************************************************************************************************
	Next
	
	Destroy aplicaciones
	
	//Inserción de las nuevas imágenes
	SELECT ruta_disenyo INTO :ruta_disenyo FROM empresas WHERE empresa = :codigo_empresa;
	total_filas = dw_1.rowcount()
	i = 1
	n_archivos_subidos = 0
	
	max_codigo = Long(f_colisiones (trans_ts, param_colisiones))
	if max_codigo = 0  then
		rtn = -1
	end if
	Do while (i <= total_filas and rtn = 1)
		if isnull(dw_1.object.codigo[i]) or dw_1.object.codigo[i] = "" then
			dw_1.object.codigo[i] = String(max_codigo)
			max_codigo++
			registro.accion = "NUEVO"
		else
			registro.accion = "MODIFICAR"
		end if
		if dw_1.object.ruta_local[i] = 1 then
			registrar = true
			extension = mid(dw_1.object.ruta[i], pos(dw_1.object.ruta[i],"."))
			nombre = nombre_fichero+"-"+dw_1.object.codigo[i]+extension
			
			//Comprobación de la existencia del directorio y creación			
			ruta_modelo = ruta_disenyo + nombre_fichero + "\"
			if not FileExists(ruta_modelo) then
				if CreateDirectory(ruta_modelo) <> 1 then
					MessageBox("Error", "No se ha podido crear el directorio en el servidor. Por favor, avise al administrador.")
					rtn = -1
				end if
			end if
			
			//Copia del archivo
			if rtn = 1 then
				ruta_disenyo_archivo = ruta_modelo + nombre
				ruta_disenyo_temp_archivo = ruta_modelo + "old_" + nombre				
				
				if not isnull(dw_1.object.ruta_antigua[i]) and dw_1.object.ruta_antigua[i] <> "" then
					rtn = FileMove(dw_1.object.ruta_antigua[i], ruta_disenyo_temp_archivo)
				end if				
				
				if rtn = 1 then
					rtn = FileCopy(dw_1.object.ruta[i], ruta_disenyo_archivo, true)
				else
					if rtn = -1 then
						MessageBox("Error", "No se ha podido reemplazar el archivo "+trim(String(dw_1.object.ruta[i]))+".")
					elseif rtn = -2 then
						MessageBox("Error", "No se ha podido reemplazar el archivo "+trim(String(dw_1.object.ruta[i]))+" en el sistema de archivos de la exposición")
					end if
				end if
				
				if rtn = 1 then
					dw_1.object.ruta[i] = ruta_modelo //Ruta sin el nombre del archivo
					dw_1.object.fichero[i] = nombre
					dw_1.object.archivo_nuevo[i] = ""
					n_archivos_subidos++
					lista_archivos_subidos[n_archivos_subidos] = ruta_disenyo_archivo
					if not isnull(dw_1.object.ruta_antigua[i]) and dw_1.object.ruta_antigua[i] <> "" then
						//Borramos el archivo antiguo si no concide con el nombre del nuevo
						n_archivos_borrados++
						lista_archivos_borrados[n_archivos_borrados] = ruta_disenyo_temp_archivo
					end if
				else
					if rtn = -1 then
						MessageBox("Error", "No se ha podido leer el archivo "+String(dw_1.object.ruta[i])+".")
						if not isnull(dw_1.object.ruta_antigua[i]) and dw_1.object.ruta_antigua[i] <> "" then
							FileMove(ruta_disenyo_temp_archivo, dw_1.object.ruta_antigua[i])
						end if
					elseif rtn = -2 then
						MessageBox("Error", "No se ha podido escribir el archivo "+String(dw_1.object.ruta[i])+" en el sistema de archivos.")
						if not isnull(dw_1.object.ruta_antigua[i]) and dw_1.object.ruta_antigua[i] <> "" then
							FileMove(ruta_disenyo_temp_archivo, dw_1.object.ruta_antigua[i])
						end if
					end if
					dw_1.deleterow(i)
				end if
				dw_1.object.ruta_local[i] = 0
				
			end if
		end if
		
		//Modificado/NUEVO - Registro en tabla de cambios ******************************************************************************************************
		if registrar then
			registro.usuario_windows = usuario_windows
			registro.trans = trans_ts
			registro.tabla = "modelo_sistema_archivos"
			registro.clave = trim(dw_1.GetItemString(i,"empresa")) + "#" + trim(dw_1.GetItemString(i,"tipomaquina_disenyo")) + "#" + trim(dw_1.GetItemString(i,"archivo")) + "#" + trim(dw_1.GetItemString(i,"codigo"))
			registro.valor = (trim(dw_1.GetItemString(i,"ruta")) + trim(dw_1.GetItemString(i,"fichero")))
			ftc_registrar_cambios(registro)
			registrar = false
		end if
		//*********************************************************************************************************************************************
		
		i++
	Loop
	
	if rtn = 1 then
		rtn = dw_1.Update()
	end if
	
	//Gestión  de archivos
	borrado = true
	if rtn = 1 then
		//Si OK guardado, borramos los archivos eliminados
		For i = 1 To n_archivos_borrados
			borrado = FileDelete(lista_archivos_borrados[i])
			if not borrado then
				MessageBox("Error borrando archivo","Avise al administrador para que borre a mano el archivo "+lista_archivos_borrados[i])
			end if
		Next
	else
		//SI FALLO guardado, eliminamos los archivos subidos a la expo
		For i = 1 To n_archivos_subidos
			borrado = FileDelete(lista_archivos_subidos[i])
			if not borrado then
				MessageBox("Error borrando archivo","Avise al administrador para que borre a mano el archivo "+lista_archivos_subidos[i])
			end if
		Next
	end if
end if

if rtn = 1 then
	COMMIT USING trans_ts;
else
	ROLLBACK USING trans_ts;
	rtn = -1
end if

st_guardar.visible = false

return rtn

end function

on wtc_mant_archivos_disenyo_sistema_archivos_old.create
int iCurrent
call super::create
this.pb_descargar_archivo=create pb_descargar_archivo
this.st_guardar=create st_guardar
this.p_seleccion=create p_seleccion
this.cb_explorar=create cb_explorar
this.pb_cargar_archivo=create pb_cargar_archivo
this.st_produccion=create st_produccion
this.cb_borrado_masivo=create cb_borrado_masivo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_descargar_archivo
this.Control[iCurrent+2]=this.st_guardar
this.Control[iCurrent+3]=this.p_seleccion
this.Control[iCurrent+4]=this.cb_explorar
this.Control[iCurrent+5]=this.pb_cargar_archivo
this.Control[iCurrent+6]=this.st_produccion
this.Control[iCurrent+7]=this.cb_borrado_masivo
end on

on wtc_mant_archivos_disenyo_sistema_archivos_old.destroy
call super::destroy
destroy(this.pb_descargar_archivo)
destroy(this.st_guardar)
destroy(this.p_seleccion)
destroy(this.cb_explorar)
destroy(this.pb_cargar_archivo)
destroy(this.st_produccion)
destroy(this.cb_borrado_masivo)
end on

event open;str_parametros lstr_param
Long pantallas = 0, aplicaciones = 0

cerrar_sin_abrir = false

////PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana FROM uti_permisos_ventana P INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	pb_grabar.visible = false
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

	dw_1.SetTransObject(SQLCA)
	
	select nombre
	into :st_titulo.text
	from empresas
	where empresa = :codigo_empresa;
	
	// Si recibo el codigo lo visualizo
	lstr_param = Message.PowerObjectParm
	
	nombre_ventana_invoca = lstr_param.s_titulo_ventana
	IF lstr_param.i_nargumentos >= 3 THEN
		if not isnull(lstr_param.s_argumentos[1]) and lstr_param.s_argumentos[1] <> "" and not isnull(lstr_param.s_argumentos[2]) and lstr_param.s_argumentos[2] <> "" and &
			not isnull(lstr_param.s_argumentos[3]) and lstr_param.s_argumentos[3] <> "" then
			tipo_maquina = lstr_param.s_argumentos[1]
			padre_codigo = lstr_param.s_argumentos[2]
			nombre_fichero = lstr_param.s_argumentos[3]
			st_codigo.text = padre_codigo
			dw_1.retrieve (codigo_empresa, tipo_maquina, padre_codigo) 
		end if
	END IF
	
	/*
	if not FileExists ("C:\Program Files (x86)\Adobe\Adobe Bridge CS5\Bridge.exe") then
		cb_explorar.visible = false
	end if
	*/
	
	dw_1.SetFocus()
	
	dw_1.title = 'Pruebas del Fichero de Produccción ' + nombre_fichero
	
	dw_1.SetRowFocusIndicator(p_seleccion)
	
	SELECT COUNT(*) INTO :pantallas FROM juegospantallas 
	WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipo_maquina AND archivo = :padre_codigo;
			
	SELECT COUNT(*) INTO :aplicaciones FROM art_ver_op_aplicaciones 
	WHERE empresa = :codigo_empresa AND archivo_disenyo_tipomaquina_disenyo = :tipo_maquina AND archivo_disenyo_codigo = :padre_codigo;
	
	if pantallas + aplicaciones > 0 then
		st_produccion.visible = true
		cb_borrado_masivo.visible = true
	end if
//end if
end event

event activate;call super::activate;if permiso_ventana = 1 then
	//Solo lectura
	pb_grabar.visible = false
end if
end event

type st_codigo from wt_ventana_padre_grid`st_codigo within wtc_mant_archivos_disenyo_sistema_archivos_old
boolean visible = false
integer x = 3415
integer y = 36
integer width = 503
integer height = 76
alignment alignment = left!
end type

type pb_duplicar1 from wt_ventana_padre_grid`pb_duplicar1 within wtc_mant_archivos_disenyo_sistema_archivos_old
boolean visible = false
integer x = 3726
integer y = 12
end type

type pb_borrar1 from wt_ventana_padre_grid`pb_borrar1 within wtc_mant_archivos_disenyo_sistema_archivos_old
integer x = 265
integer y = 1620
string powertiptext = "Eliminar Archivo"
end type

event pb_borrar1::clicked;long fila
boolean error_borrando
long fila_actual

string botones[2]
Int cambiar
str_ventana_alerta parametros

fila_actual = dw_1.getrow()

if dw_1.object.produccion[fila_actual] > 0 then
	MessageBox("Error","Atención, no puede borrar un archivo que está en producción.")
	return
end if

if dw_1.object.ruta_local[fila_actual] <> 1 then
	parametros.titulo = "Atención Borrar Archivo"
	parametros.subtitulo = "Borrar Archivo de la Pieza"
	parametros.mensaje = "Va a eliminar definitivamente el archivo, ¿esta seguro?"
	parametros.tipo = 2
	//parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	cambiar = Int(Message.DoubleParm)
	if cambiar <> 1 then
		return	
	end if
end if

error_borrando = false

if fila_actual > 0 then
	if dw_1.DeleteRow(fila_actual) <> 1 then
		error_borrando = True
	else
		error_borrando = False
	end if
end if
	
if error_borrando then
	MessageBox("Error","No ha sido posible borrar el registro")
else
	fila = dw_1.getrow()
		
	if fila > 0 then
		if fila = dw_1.rowcount() then
			dw_1.setrow(dw_1.rowcount())
		else
			dw_1.setrow(fila)
		end if	
	end if		
	dw_1.event rowfocuschanged(dw_1.getrow())
end if


end event

type pb_anyadir1 from wt_ventana_padre_grid`pb_anyadir1 within wtc_mant_archivos_disenyo_sistema_archivos_old
integer x = 110
integer y = 1620
integer weight = 700
string powertiptext = "Añadir Archivo Nuevo"
end type

event pb_anyadir1::clicked;call super::clicked;string codigo_archivo, ruta_mostrada
long fila
string pathname
string filename
int res

//Tamaño archivo 
LongLong tamanyo_archivo = 20000000000 //20GB Aprox

fila = dw_1.insertrow(0)

dw_1.object.empresa[fila] = codigo_empresa
dw_1.object.tipomaquina_disenyo[fila] = tipo_maquina
dw_1.object.archivo[fila] = padre_codigo
dw_1.object.fichero[fila] = "Pdt. Guardar"
dw_1.object.produccion[fila] = 0

ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)
SELECT ruta_area_trabajo INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa; 
ruta_mostrada = ruta_mostrada + upper(ftc_variable_entorno("USERNAME", lcxk_base))
res = GetFileOpenName ("Añadir Prueba al Fichero "+nombre_fichero, pathname, filename, "", "Fichero Producción, *.*", ruta_mostrada)
if FileLength64 (pathname) > tamanyo_archivo then
	MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
	dw_1.deleterow(fila)
	return
end if

if res = 1 then
	dw_1.object.archivo_nuevo[fila] = filename
	dw_1.object.ruta[fila] = pathname
	dw_1.object.ruta_local[fila] = 1
	dw_1.object.fecha_modificacion[fila] = datetime(today(),now())
	dw_1.setrow(fila)
	dw_1.event rowfocuschanged(dw_1.getrow())
else
	MessageBox("Error","No ha sido posible obtener la ruta del archivo indicado")
	dw_1.deleterow(fila)
end if








end event

type pb_imprimir from wt_ventana_padre_grid`pb_imprimir within wtc_mant_archivos_disenyo_sistema_archivos_old
boolean visible = false
integer x = 4069
integer y = 24
end type

type p_logo from wt_ventana_padre_grid`p_logo within wtc_mant_archivos_disenyo_sistema_archivos_old
integer x = 5042
integer y = 28
end type

type dw_1 from wt_ventana_padre_grid`dw_1 within wtc_mant_archivos_disenyo_sistema_archivos_old
integer x = 41
integer y = 268
integer width = 5522
integer height = 1512
boolean titlebar = true
string title = "Archivos de la Pieza"
string dataobject = "dwtc_archivo_disenyo_sistema_archivos"
boolean vscrollbar = true
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;/*
if currentrow <= 0 then
	return
end if


dw_1.selectrow(0, false)
dw_1.selectrow(currentrow, true)
dw_1.scrolltorow(dw_1.getrow())
*/
end event

type pb_salir from wt_ventana_padre_grid`pb_salir within wtc_mant_archivos_disenyo_sistema_archivos_old
integer x = 5413
integer y = 128
end type

type pb_grabar from wt_ventana_padre_grid`pb_grabar within wtc_mant_archivos_disenyo_sistema_archivos_old
integer y = 124
end type

type st_titulo from wt_ventana_padre_grid`st_titulo within wtc_mant_archivos_disenyo_sistema_archivos_old
integer y = 32
integer width = 1554
end type

type pb_cancelar from wt_ventana_padre_grid`pb_cancelar within wtc_mant_archivos_disenyo_sistema_archivos_old
boolean visible = false
integer x = 4654
integer y = 20
end type

type pb_descargar_archivo from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos_old
integer x = 521
integer y = 1624
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
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Download_24x24.png"
alignment htextalign = left!
string powertiptext = "Descargar Archivo"
end type

event clicked;string ruta, pathname, ruta_destino, fichero
string filename
int res, fh, fila
Int local, remp
Boolean reemplazar = false
str_ventana_alerta parametros
string botones[2]


fila = dw_1.getrow()
if fila > 0 then  
	ruta = dw_1.object.ruta[fila]
	fichero = dw_1.object.fichero[fila]
	local = dw_1.object.ruta_local[fila]
	
	if not isnull(ruta) and ruta <> "" and local = 0 then
		ContextKeyword lcxk_base
		this.GetContextService("Keyword", lcxk_base)
		SELECT ruta_area_trabajo INTO :ruta_destino FROM empresas WHERE empresa = :codigo_empresa; 
		ruta_destino = ruta_destino + upper(ftc_variable_entorno("USERNAME", lcxk_base)) + "\"
		if not fileexists(ruta_destino) then
			ruta_destino = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop\"
		end if
		res = GetFileSaveName ("Descargar Archivo", pathname, filename, "", "Fichero de Producción,*.*", ruta_destino)
		if res = 1 then
			pathname = f_reemplazar(pathname, filename, String(dw_1.object.fichero[fila]))
			if FileExists(pathname) then
				parametros.titulo = "Atención Reemplazar Fichero"
				parametros.subtitulo = "El fichero ya existe"
				parametros.mensaje = "¿Desea reemplazarlo?"
				parametros.tipo = 2
				botones[1] = "Sí"
				botones[2] = "No"
				parametros.botones = botones
				parametros.mostrar_imagen = true
				openwithparm(wtc_ventana_alerta, parametros)
				remp = Int(Message.DoubleParm)
				if remp = 1 then
					reemplazar = true
				else 
					return
				end if
			end if
			st_guardar.visible = true
			res = FileCopy(ruta + fichero, pathname, reemplazar)
			st_guardar.visible = false
			if res = -1 then
				MessageBox("Error", "Error de lectura de la imagen.")
			elseif res = -2 then
				MessageBox("Error", "Error de escritura de la imagen.")
			else
				//Exito
				//Lanzamos photoshop o el explorador de windows
				if ftc_lanzar_photoshop(pathname) < 1 then
					run("explorer "+pathname) //Muestra la carpeta
				end if
			end if				
		else
			MessageBox("Error", "No ha sido posible guardar en la ruta indicada.")
		end if
	else
		MessageBox("Error", "No existe imagen para descargar o la imagen seleccionada todabía no ha sido guardada.")
	end if
end if

	

end event

type st_guardar from statictext within wtc_mant_archivos_disenyo_sistema_archivos_old
boolean visible = false
integer x = 238
integer y = 120
integer width = 571
integer height = 124
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19474154
long backcolor = 67108864
string text = "Guardando. Espere, por favor. "
boolean focusrectangle = false
end type

type p_seleccion from picture within wtc_mant_archivos_disenyo_sistema_archivos_old
boolean visible = false
integer x = 3936
integer y = 36
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Tencer_PB12\fila_seleccionada.png"
boolean focusrectangle = false
end type

type cb_explorar from commandbutton within wtc_mant_archivos_disenyo_sistema_archivos_old
boolean visible = false
integer x = 4279
integer y = 28
integer width = 338
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Explorar"
end type

event clicked;if dw_1.rowcount() > 0 then
	if FileExists ("C:\Program Files (x86)\Adobe\Adobe Bridge CS5\Bridge.exe") then
		run("C:\tencer_pb12\bocetos.bat "+nombre_fichero)
	end if
end if

end event

type pb_cargar_archivo from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos_old
integer x = 677
integer y = 1624
integer width = 146
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Upload_24x24.png"
alignment htextalign = left!
string powertiptext = "Reemplazar Archivo Seleccionado"
end type

event clicked;string codigo_archivo, ruta_mostrada
long fila
string pathname, ruta_anterior
string filename
int res, ruta_local_anterior

//Tamaño archivo 
LongLong tamanyo_archivo = 20000000000 //20GB Aprox
string botones[2]
Int cambiar
str_ventana_alerta parametros

fila = dw_1.getrow()
ruta_anterior = dw_1.object.ruta[fila] + dw_1.object.fichero[fila]
ruta_local_anterior = dw_1.object.ruta_local[fila]

if dw_1.object.produccion[fila] > 0 then
	parametros.titulo = "Atención Archivo de Producción"
	parametros.subtitulo = "Cambiar Archivo Producción"
	parametros.mensaje = "¿Esta seguro de sustituir el archivo?"
	parametros.tipo = 1
	//parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	cambiar = Int(Message.DoubleParm)
	if cambiar <> 1 then
		return	
	end if
end if

ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)
SELECT ruta_area_trabajo INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa; 
ruta_mostrada = ruta_mostrada + upper(ftc_variable_entorno("USERNAME", lcxk_base)) + "\"
res = GetFileOpenName ("Reemplazar el Archivo por el siguiente: ", pathname, filename, "", "Fichero de Producción, *.*", ruta_mostrada)
if FileLength64 (pathname) > tamanyo_archivo then
	MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
	return
end if

if res = 1 then
	dw_1.object.archivo_nuevo[fila] = filename
	dw_1.object.ruta[fila] = pathname
	dw_1.object.ruta_local[fila] = 1
	dw_1.object.fecha_modificacion[fila] = datetime(today(),now())
	if isnull(dw_1.object.ruta_antigua[fila]) or dw_1.object.ruta_antigua[fila] = "" then
		//Sirve para borrar el archivo antiguo del disco una vez guardados los cambios
		dw_1.object.ruta_antigua[fila] = ruta_anterior
	end if
	dw_1.setrow(fila)
	dw_1.event rowfocuschanged(dw_1.getrow())
else
	MessageBox("Error","No ha sido posible obtener la ruta del archivo indicado")
	dw_1.object.ruta[fila] = ruta_anterior
	dw_1.object.ruta_local[fila] = ruta_local_anterior
end if

end event

type st_produccion from statictext within wtc_mant_archivos_disenyo_sistema_archivos_old
boolean visible = false
integer x = 2464
integer y = 140
integer width = 850
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 18948574
long backcolor = 67108864
string text = "Fichero en Producción"
boolean focusrectangle = false
end type

type cb_borrado_masivo from commandbutton within wtc_mant_archivos_disenyo_sistema_archivos_old
boolean visible = false
integer x = 955
integer y = 1632
integer width = 1490
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar pruebas del archivo que no están en producción"
end type

event clicked;string botones[2]
Int cambiar
str_ventana_alerta parametros

Long archivos_produccion, i, numero_pruebas

parametros.titulo = "Atención - Borrar Archivos"
parametros.subtitulo = "Borrado de Pruebas"
parametros.mensaje = "Compruebe que el archivo de producción es el correcto, puesto que las pruebas borradas no se podrán recuperar. ¿Desea continuar?"
parametros.tipo = 1
//parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
cambiar = Int(Message.DoubleParm)
if cambiar <> 1 then
	return	
end if

archivos_produccion = long(dw_1.Describe("Evaluate('Sum(produccion)', 0)"))
if archivos_produccion <= 0 then
	parametros.titulo = "Atención - Borrar Todos los Archivos"
	parametros.subtitulo = "Borrar TODAS las Pruebas"
	parametros.mensaje = "No hay ninguna prueba en producción. ¿Desea borrar todas las pruebas?"
	parametros.tipo = 2
	//parametros.botones = botones
	parametros.mostrar_imagen = true
	openwithparm(wtc_ventana_alerta, parametros)
	cambiar = Int(Message.DoubleParm)
	if cambiar <> 1 then
		return	
	end if
end if

numero_pruebas = dw_1.rowcount()
i = numero_pruebas
Do While i >= 1
	if dw_1.object.produccion[i] < 1 then
		dw_1.deleterow(i)
	end if
	i --
Loop
end event

