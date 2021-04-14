$PBExportHeader$wtc_mant_modelo_propuesta_sistema_archivos_old.srw
forward
global type wtc_mant_modelo_propuesta_sistema_archivos_old from wt_ventana_padre_grid
end type
type pb_descargar_archivo from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos_old
end type
type p_seleccion from picture within wtc_mant_modelo_propuesta_sistema_archivos_old
end type
type pb_cargar_archivo from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos_old
end type
type st_guardar from statictext within wtc_mant_modelo_propuesta_sistema_archivos_old
end type
type st_produccion from statictext within wtc_mant_modelo_propuesta_sistema_archivos_old
end type
end forward

global type wtc_mant_modelo_propuesta_sistema_archivos_old from wt_ventana_padre_grid
integer width = 5609
integer height = 1884
string title = "Sistema de Archivos del Modelo"
string menuname = ""
boolean minbox = false
windowtype windowtype = response!
pb_descargar_archivo pb_descargar_archivo
p_seleccion p_seleccion
pb_cargar_archivo pb_cargar_archivo
st_guardar st_guardar
st_produccion st_produccion
end type
global wtc_mant_modelo_propuesta_sistema_archivos_old wtc_mant_modelo_propuesta_sistema_archivos_old

type variables
String modelo_cliente, modelo_propuesta
end variables

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();Long i, total_filas, max_codigo, n_archivos_borrados, n_archivos_subidos
String ruta_disenyo, ruta_disenyo_archivo, ruta_disenyo_temp_archivo, ruta_antigua, nombre, extension, ruta_modelo
String lista_archivos_borrados[], lista_archivos_subidos[]
Boolean borrado, falta_campo, registrar = false
String campo, motivo
str_registro_sistema registro
String usuario_windows

ContextKeyword lcxk_base
This.GetContextService("Keyword", lcxk_base)
usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))

dw_1.accepttext()
rtn = 1

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/



/*---------------------------------------------------------------------------------------------------------------------------------
			   FIN CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

st_guardar.visible = true

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "modelo_propuesta_sistema_archivos"
param_colisiones.campo = "codigo"
param_colisiones.filtro = "modelo_propuesta_sistema_archivos.modelo = '"+padre_codigo+"' AND modelo_propuesta_sistema_archivos.cliente = '"+modelo_cliente+"' AND modelo_propuesta_sistema_archivos.propuesta = '"+modelo_propuesta+"'"
param_colisiones.buscar_huecos = false //No buscamos huecos para evitar problemas de colisiones con el DW propio


dw_1.SetTransObject(trans_ts)	


if rtn <> -1 then
	//Borrado de las imágenes eliminadas
	n_archivos_borrados = 0
	For i = 1 To dw_1.deletedCount()
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
			registro.clave = trim(dw_1.GetItemString(i,"empresa",Delete!,false)) + "#" + trim(dw_1.GetItemString(i,"modelo",Delete!,false)) + "#" + trim(dw_1.GetItemString(i,"cliente",Delete!,false)) + "#" + trim(dw_1.GetItemString(i,"propuesta",Delete!,false)) + "#" + trim(dw_1.GetItemString(i,"codigo",Delete!,false))
			registro.valor = (trim(dw_1.GetItemString(i,"ruta",Delete!,false)) + trim(dw_1.GetItemString(i,"fichero",Delete!,false)))
			ftc_registrar_cambios(registro)
			registrar = false
		end if
	Next
	
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
			nombre = padre_codigo+"-"+modelo_cliente+"-"+modelo_propuesta+"-"+dw_1.object.codigo[i]+extension
			
			//Comprobación de la existencia del directorio y creación			
			ruta_modelo = ruta_disenyo + padre_codigo + "\"
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
						MessageBox("Error", "No se ha podido reemplazar el archivo "+String(dw_1.object.ruta[i])+".")
					elseif rtn = -2 then
						MessageBox("Error", "No se ha podido reemplazar el archivo "+String(dw_1.object.ruta[i])+" en el sistema de archivos.")
					end if
				end if
				
				if rtn = 1 then
					dw_1.object.ruta[i] = ruta_modelo //Sin el fichero
					dw_1.object.fichero[i] = nombre
					dw_1.object.archivo_local[i] = ""
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
			registro.clave = trim(dw_1.GetItemString(i,"empresa")) + "#" + trim(dw_1.GetItemString(i,"modelo")) + "#" + trim(dw_1.GetItemString(i,"cliente")) + "#" + trim(dw_1.GetItemString(i,"propuesta")) + "#" + trim(dw_1.GetItemString(i,"codigo"))
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

on wtc_mant_modelo_propuesta_sistema_archivos_old.create
int iCurrent
call super::create
this.pb_descargar_archivo=create pb_descargar_archivo
this.p_seleccion=create p_seleccion
this.pb_cargar_archivo=create pb_cargar_archivo
this.st_guardar=create st_guardar
this.st_produccion=create st_produccion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_descargar_archivo
this.Control[iCurrent+2]=this.p_seleccion
this.Control[iCurrent+3]=this.pb_cargar_archivo
this.Control[iCurrent+4]=this.st_guardar
this.Control[iCurrent+5]=this.st_produccion
end on

on wtc_mant_modelo_propuesta_sistema_archivos_old.destroy
call super::destroy
destroy(this.pb_descargar_archivo)
destroy(this.p_seleccion)
destroy(this.pb_cargar_archivo)
destroy(this.st_guardar)
destroy(this.st_produccion)
end on

event open;str_parametros lstr_param

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
		if not isnull(lstr_param.s_argumentos[1]) and lstr_param.s_argumentos[1] <> "" and not isnull(lstr_param.s_argumentos[2]) and lstr_param.s_argumentos[2] <> "" and not isnull(lstr_param.s_argumentos[3]) and lstr_param.s_argumentos[3] <> "" then
			padre_codigo = lstr_param.s_argumentos[1]
			modelo_cliente = lstr_param.s_argumentos[2]
			modelo_propuesta = lstr_param.s_argumentos[3]
			st_codigo.text = padre_codigo
			dw_1.retrieve (codigo_empresa, padre_codigo, modelo_cliente, modelo_propuesta) 
		end if
	END IF
	
	dw_1.SetFocus()
	
	
	Long modelos_pr
	String cliente_descripcion, formato_descripcion
	
	SELECT genter.razon INTO :cliente_descripcion 
	FROM modelo_cliente INNER JOIN genter ON modelo_cliente.empresa = genter.empresa AND modelo_cliente.cliente = genter.codigo AND genter.tipoter = 'C' 
	WHERE modelo_cliente.empresa = :codigo_empresa AND modelo_cliente.cliente = :modelo_cliente;
	
	SELECT formatos.descripcion INTO :formato_descripcion 
	FROM modelo_propuesta INNER JOIN formatos ON modelo_propuesta.empresa = formatos.empresa AND modelo_propuesta.formato = formatos.codigo 
	WHERE modelo_propuesta.empresa = :codigo_empresa AND modelo_propuesta.cliente = :modelo_cliente AND modelo_propuesta.codigo = :modelo_propuesta;
	
	dw_1.title = 'Modelo ' + padre_codigo + ' para ' + cliente_descripcion + ' formato ' + formato_descripcion
	
	dw_1.SetRowFocusIndicator(p_seleccion)
	
	SELECT COUNT(*) INTO :modelos_pr FROM articulos WHERE empresa = :codigo_empresa AND modelo_origen = :padre_codigo;
	
	if modelos_pr > 0 then
		st_produccion.visible = true
	end if
//end if
end event

event activate;call super::activate;if permiso_ventana = 1 then
	//Solo lectura
	pb_grabar.visible = false
end if
end event

type st_codigo from wt_ventana_padre_grid`st_codigo within wtc_mant_modelo_propuesta_sistema_archivos_old
boolean visible = false
integer x = 3941
integer y = 52
integer width = 503
integer height = 76
alignment alignment = left!
end type

type pb_duplicar1 from wt_ventana_padre_grid`pb_duplicar1 within wtc_mant_modelo_propuesta_sistema_archivos_old
boolean visible = false
integer x = 4251
integer y = 28
end type

type pb_borrar1 from wt_ventana_padre_grid`pb_borrar1 within wtc_mant_modelo_propuesta_sistema_archivos_old
integer x = 265
integer y = 1620
end type

event pb_borrar1::clicked;long fila
boolean error_borrando
long fila_actual
string botones[2]
Int cambiar
str_ventana_alerta parametros

fila_actual = dw_1.getrow()

if dw_1.object.ruta_local[fila_actual] <> 1 then
	parametros.titulo = "Atención Borrar Archivo"
	parametros.subtitulo = "Borrar Archivo del Modelo"
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

type pb_anyadir1 from wt_ventana_padre_grid`pb_anyadir1 within wtc_mant_modelo_propuesta_sistema_archivos_old
integer x = 110
integer y = 1620
integer weight = 700
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
dw_1.object.modelo[fila] = padre_codigo
dw_1.object.cliente[fila] = modelo_cliente
dw_1.object.propuesta[fila] = modelo_propuesta
dw_1.object.fichero[fila] = "Pdt. Guardar"

ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)
SELECT ruta_area_trabajo INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa; 
ruta_mostrada = ruta_mostrada + upper(ftc_variable_entorno("USERNAME", lcxk_base))
res = GetFileOpenName ("Añadir Fichero al Modelo", pathname, filename, "", "Fichero de Diseño, *.*", ruta_mostrada)
if FileLength64 (pathname) > tamanyo_archivo then
	MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
	dw_1.deleterow(fila)
	return
end if

if res = 1 then
	dw_1.object.archivo_local[fila] = filename
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

type pb_imprimir from wt_ventana_padre_grid`pb_imprimir within wtc_mant_modelo_propuesta_sistema_archivos_old
boolean visible = false
integer x = 4023
integer y = 28
end type

type p_logo from wt_ventana_padre_grid`p_logo within wtc_mant_modelo_propuesta_sistema_archivos_old
integer x = 5047
integer y = 20
end type

type dw_1 from wt_ventana_padre_grid`dw_1 within wtc_mant_modelo_propuesta_sistema_archivos_old
integer x = 37
integer y = 268
integer width = 5536
integer height = 1512
boolean titlebar = true
string title = "Archivos del Modelo"
string dataobject = "dwtc_modelo_propuesta_sistema_archivos"
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

event dw_1::itemchanged;call super::itemchanged;string resultado, resultado2, modelo, cliente, coleccion

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "modelo_sistema_archivos_cliente"
		modelo = padre_codigo
		cliente = this.object.cliente_actual[row]
		
		if data = "" then
			dwo.Primary[row] = cliente
			return 2	
		end if
		
		coleccion = ""
		SELECT coleccion INTO :coleccion FROM modelo WHERE empresa = :codigo_empresa AND modelo = :modelo;
		
		SELECT genter.razon 
		INTO :resultado
		FROM genter 
		WHERE genter.empresa = :codigo_empresa AND genter.tipoter = 'C' AND genter.codigo = :data;
		if SQLCA.sqlcode <> 100 then
			//Comprobamos que esté en el historico (salvo Tencer)
			if data <> '87' then
				SELECT cliente 
				INTO :resultado2
				FROM deshistorico 
				WHERE empresa = :codigo_empresa AND coleccion = :coleccion AND cliente = :data;
				if SQLCA.sqlcode = 100 then
					MessageBox("Error","El cliente seleccionado debe estar en el histórico de la colección o ser TENCER.")
					dwo.Primary[row] = cliente
					return 2	
				end if
			end if
			
			this.object.genter_razon[Row] 	= resultado
			this.object.cliente_actual[Row]	= data
		else
			dwo.Primary[row] = cliente
			return 2	
		end if
END CHOOSE

end event

event dw_1::usr_keydown;call super::usr_keydown;string campo, modelo, cliente, coleccion
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "modelo_sistema_archivos_cliente"
			modelo = padre_codigo
			
			coleccion = ""
			SELECT coleccion INTO :coleccion FROM modelo WHERE empresa = :codigo_empresa AND modelo = :modelo;
			
			busqueda.titulo_ventana = "Búsqueda de Clientes"
		
			busqueda.consulta  = "SELECT genter.codigo, genter.razon "+&
										"FROM deshistorico INNER JOIN genter ON deshistorico.empresa = genter.empresa AND deshistorico.cliente = genter.codigo AND genter.tipoter = 'C' "+&
										"WHERE deshistorico.empresa = '"+codigo_empresa+"' AND deshistorico.coleccion = '"+coleccion+"' "+&
										"UNION SELECT genter.codigo, genter.razon FROM genter WHERE genter.codigo = '87' AND genter.tipoter = 'C' ORDER BY genter.razon"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				
				this.object.modelo_sistema_archivos_cliente[this.GetRow()] 			= resultado.valores[1]		
				this.object.genter_razon[this.GetRow()] 	= resultado.valores[2]	
				this.object.cliente_actual[this.GetRow()] = resultado.valores[1]		
						
			end if
	END CHOOSE
end if	
	
end event

type pb_salir from wt_ventana_padre_grid`pb_salir within wtc_mant_modelo_propuesta_sistema_archivos_old
integer x = 5413
integer y = 124
end type

type pb_grabar from wt_ventana_padre_grid`pb_grabar within wtc_mant_modelo_propuesta_sistema_archivos_old
end type

type st_titulo from wt_ventana_padre_grid`st_titulo within wtc_mant_modelo_propuesta_sistema_archivos_old
integer width = 2482
end type

type pb_cancelar from wt_ventana_padre_grid`pb_cancelar within wtc_mant_modelo_propuesta_sistema_archivos_old
boolean visible = false
integer x = 4613
integer y = 24
end type

type pb_descargar_archivo from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos_old
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
	ruta = trim(dw_1.object.ruta[fila])
	fichero = trim(dw_1.object.fichero[fila])
	local = dw_1.object.ruta_local[fila]
	
	if not isnull(ruta) and ruta <> "" and local = 0 then
		ContextKeyword lcxk_base
		this.GetContextService("Keyword", lcxk_base)
		SELECT ruta_area_trabajo INTO :ruta_destino FROM empresas WHERE empresa = :codigo_empresa; 
		ruta_destino = ruta_destino + upper(ftc_variable_entorno("USERNAME", lcxk_base)) + "\"
		if not fileexists(ruta_destino) then
			ruta_destino = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop\"
		end if
		res = GetFileSaveName ("Descargar Archivo", pathname, filename, "", "Fichero de Diseño,*.*", ruta_destino)
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

type p_seleccion from picture within wtc_mant_modelo_propuesta_sistema_archivos_old
boolean visible = false
integer x = 3771
integer y = 56
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Tencer_PB12\fila_seleccionada.png"
boolean focusrectangle = false
end type

type pb_cargar_archivo from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos_old
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
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Upload_24x24.png"
alignment htextalign = left!
string powertiptext = "Reemplazar Archivo Seleccionado"
end type

event clicked;string codigo_archivo, ruta_anterior, ruta_mostrada
long fila
string pathname
string filename
int res, ruta_local_anterior

//Tamaño archivo 
LongLong tamanyo_archivo = 20000000000 //20GB Aprox

fila = dw_1.getrow()
ruta_anterior = dw_1.object.ruta[fila] +  dw_1.object.fichero[fila]
ruta_local_anterior = dw_1.object.ruta_local[fila]

ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)
SELECT ruta_area_trabajo INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa; 
ruta_mostrada = ruta_mostrada + upper(ftc_variable_entorno("USERNAME", lcxk_base)) + "\"
res = GetFileOpenName ("Reemplazar el Archivo por el siguiente:", pathname, filename, "", "Fichero de Diseño, *.*", ruta_mostrada)
if FileLength64 (pathname) > tamanyo_archivo then
	MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
	return
end if

if res = 1 then
	dw_1.object.archivo_local[fila] = filename
	dw_1.object.ruta[fila] = pathname
	dw_1.object.ruta_local[fila] = 1
	dw_1.object.fecha_modificacion[fila] = datetime(today(),now())
	if isnull(dw_1.object.ruta_antigua[fila]) or dw_1.object.ruta_antigua[fila] = "" then
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

type st_guardar from statictext within wtc_mant_modelo_propuesta_sistema_archivos_old
boolean visible = false
integer x = 238
integer y = 112
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

type st_produccion from statictext within wtc_mant_modelo_propuesta_sistema_archivos_old
boolean visible = false
integer x = 2464
integer y = 148
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
string text = "Modelo en Producción"
boolean focusrectangle = false
end type

