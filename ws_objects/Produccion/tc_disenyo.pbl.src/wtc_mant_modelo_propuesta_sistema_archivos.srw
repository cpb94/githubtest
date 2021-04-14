$PBExportHeader$wtc_mant_modelo_propuesta_sistema_archivos.srw
forward
global type wtc_mant_modelo_propuesta_sistema_archivos from wt_ventana_padre_grid
end type
type pb_descargar_archivo from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos
end type
type p_seleccion from picture within wtc_mant_modelo_propuesta_sistema_archivos
end type
type pb_cargar_archivo from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos
end type
type st_guardar from statictext within wtc_mant_modelo_propuesta_sistema_archivos
end type
type st_produccion from statictext within wtc_mant_modelo_propuesta_sistema_archivos
end type
type st_info from statictext within wtc_mant_modelo_propuesta_sistema_archivos
end type
type dw_imagen from u_dw_imagen within wtc_mant_modelo_propuesta_sistema_archivos
end type
type pb_1 from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos
end type
end forward

global type wtc_mant_modelo_propuesta_sistema_archivos from wt_ventana_padre_grid
integer width = 5865
integer height = 1592
string title = "Sistema de Archivos del Modelo"
string menuname = ""
boolean minbox = false
windowtype windowtype = response!
pb_descargar_archivo pb_descargar_archivo
p_seleccion p_seleccion
pb_cargar_archivo pb_cargar_archivo
st_guardar st_guardar
st_produccion st_produccion
st_info st_info
dw_imagen dw_imagen
pb_1 pb_1
end type
global wtc_mant_modelo_propuesta_sistema_archivos wtc_mant_modelo_propuesta_sistema_archivos

type variables
String modelo_cliente, modelo_propuesta
end variables

on wtc_mant_modelo_propuesta_sistema_archivos.create
int iCurrent
call super::create
this.pb_descargar_archivo=create pb_descargar_archivo
this.p_seleccion=create p_seleccion
this.pb_cargar_archivo=create pb_cargar_archivo
this.st_guardar=create st_guardar
this.st_produccion=create st_produccion
this.st_info=create st_info
this.dw_imagen=create dw_imagen
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_descargar_archivo
this.Control[iCurrent+2]=this.p_seleccion
this.Control[iCurrent+3]=this.pb_cargar_archivo
this.Control[iCurrent+4]=this.st_guardar
this.Control[iCurrent+5]=this.st_produccion
this.Control[iCurrent+6]=this.st_info
this.Control[iCurrent+7]=this.dw_imagen
this.Control[iCurrent+8]=this.pb_1
end on

on wtc_mant_modelo_propuesta_sistema_archivos.destroy
call super::destroy
destroy(this.pb_descargar_archivo)
destroy(this.p_seleccion)
destroy(this.pb_cargar_archivo)
destroy(this.st_guardar)
destroy(this.st_produccion)
destroy(this.st_info)
destroy(this.dw_imagen)
destroy(this.pb_1)
end on

event open;str_parametros lstr_param

cerrar_sin_abrir = false

////PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//SELECT P.permiso 
//INTO :permiso_ventana 
//FROM uti_permisos_ventana P 
//INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa 
//WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario USING SQLCA;
//
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	pb_grabar.visible = false
//	pb_anyadir1.visible = false
//	pb_borrar1.visible = false
//	pb_cargar_archivo.visible = false
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
	where empresa = :codigo_empresa
	USING SQLCA;
	
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
	
	SELECT genter.razon 
	INTO :cliente_descripcion 
	FROM modelo_cliente 
	INNER JOIN genter ON modelo_cliente.empresa = genter.empresa AND modelo_cliente.cliente = genter.codigo AND genter.tipoter = 'C' 
	WHERE modelo_cliente.empresa = :codigo_empresa AND modelo_cliente.cliente = :modelo_cliente
	USING SQLCA;
	
	SELECT formatos.descripcion 
	INTO :formato_descripcion 
	FROM modelo_propuesta 
	INNER JOIN formatos ON modelo_propuesta.empresa = formatos.empresa AND modelo_propuesta.formato = formatos.codigo 
	WHERE modelo_propuesta.empresa = :codigo_empresa AND modelo_propuesta.cliente = :modelo_cliente AND modelo_propuesta.codigo = :modelo_propuesta
	USING SQLCA;
	
	dw_1.title = 'Modelo ' + padre_codigo + ' para ' + cliente_descripcion + ' formato ' + formato_descripcion
	
	dw_1.SetRowFocusIndicator(p_seleccion)
	
	SELECT ISNULL(COUNT(*), 0) 
	INTO :modelos_pr 
	FROM articulos 
	WHERE empresa = :codigo_empresa AND modelo_origen = :padre_codigo
	USING SQLCA;
	
	if modelos_pr > 0 then
		st_produccion.visible = true
	end if
//end if
end event

event activate;call super::activate;if permiso_ventana = 1 then
	//Solo lectura
	pb_grabar.visible = false
	pb_anyadir1.visible = false
	pb_borrar1.visible = false
	pb_cargar_archivo.visible = false
end if
end event

type st_codigo from wt_ventana_padre_grid`st_codigo within wtc_mant_modelo_propuesta_sistema_archivos
boolean visible = false
integer x = 3342
integer y = 44
integer width = 503
integer height = 76
alignment alignment = left!
end type

type pb_duplicar1 from wt_ventana_padre_grid`pb_duplicar1 within wtc_mant_modelo_propuesta_sistema_archivos
boolean visible = false
integer x = 3653
integer y = 20
end type

type pb_borrar1 from wt_ventana_padre_grid`pb_borrar1 within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 270
integer y = 1316
end type

event pb_borrar1::clicked;string botones[2]
Int cambiar
str_ventana_alerta parametros

Long fila_actual, j, total_aplicaciones
String ruta, ruta_archivos_disenyo, ruta_papelera, codigo, modelo, cliente, propuesta
str_registro_sistema registro
String usuario_windows, extension

if dw_1.rowcount() <= 0 then
	return
end if

fila_actual = dw_1.getrow()

parametros.titulo = "Atención Borrar Archivo"
parametros.subtitulo = "Borrar Archivo del Modelo"
parametros.mensaje = "Va a eliminar definitivamente el archivo "+trim(String(dw_1.object.fichero[fila_actual]))+" y no se podrá recuperar, ¿esta seguro?"
parametros.tipo = 1
//parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
cambiar = Int(Message.DoubleParm)
if cambiar <> 1 then
	return	
end if

ContextKeyword lcxk_base
This.GetContextService("Keyword", lcxk_base)
usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))

dw_1.accepttext()
rtn = 1

st_guardar.visible = true

modelo = dw_1.object.modelo[fila_actual]
cliente = dw_1.object.cliente[fila_actual]
propuesta = dw_1.object.propuesta[fila_actual]
codigo = dw_1.object.codigo[fila_actual]

SELECT ruta_archivos_disenyo 
INTO :ruta_archivos_disenyo 
FROM empresas 
WHERE empresa = :codigo_empresa 
USING SQLCA;

if isnull(ruta_archivos_disenyo) then ruta_archivos_disenyo = ""

//Borrado del archivo
if rtn = 1 then
	ruta = ruta_archivos_disenyo + f_reemplazar(trim(String(dw_1.object.ruta[fila_actual])), ruta_archivos_disenyo, "") + trim(String(dw_1.object.fichero[fila_actual]))
	ruta_papelera = ""
	
	SELECT ruta_papelera_disenyo 
	INTO :ruta_papelera 
	FROM empresas 
	WHERE empresa = :codigo_empresa 
	using trans_ts;
	
	IF trans_ts.SQLCode <> 0 THEN         
		MessageBox("SQL error", trans_ts.SQLErrText +" No se ha podido realizar encontrar la ruta de la papelera de reciclaje: "+String(trans_ts.SQLDBCode))
		rtn = -1
	END IF
	
	if not isnull(ruta_papelera) and ruta_papelera <> "" then
		ruta_papelera = ruta_papelera +  "old_" + String(Today(), "dd_mm_yy") + "_" + String(Now(), "hh_mm_ss") + "_" + trim(String(dw_1.object.fichero[fila_actual]))
		rtn = FileMove(ruta, ruta_papelera)
		if rtn = 1 then
			DELETE FROM modelo_propuesta_sistema_archivos 
			WHERE empresa = :codigo_empresa AND modelo = :modelo AND cliente = :cliente AND propuesta = :propuesta AND codigo = :codigo 
			USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" No se ha podido realizar el borrado en la base de datos: "+String(trans_ts.SQLDBCode))
				rtn = -1
			END IF
		else
			MessageBox("Error", "No se ha podido mover el archivo a la papelera. Por favor, avise al administrador.")
			rtn = -1 
		end if
	end if
end if

if rtn = 1 then
	registro.usuario_windows = usuario_windows
	registro.trans = trans_ts
	registro.accion = "BORRAR"
	registro.tabla = "modelo_propuesta_sistema_archivos"
	registro.clave = codigo_empresa + "#" + modelo + "#" + cliente + "#" + propuesta + "#" + codigo
	registro.valor = ruta
	if not ftc_registrar_cambios(registro) then
		rtn = -1
	end if
end if

if rtn = 1 then
	COMMIT USING trans_ts;
//	dw_imagen.Object.datawindow.picture.File = ""
//	extension = mid(ruta, pos(ruta,"."))
//	filedelete(f_reemplazar(ruta,extension,".png"))
	st_info.text = "Archivo "+trim(String(dw_1.object.fichero[fila_actual]))+" borrado correctamente." 
else
	ROLLBACK USING trans_ts;
	rtn = -1
end if

st_guardar.visible = false

dw_1.retrieve (codigo_empresa, padre_codigo, modelo_cliente, modelo_propuesta) 

end event

type pb_anyadir1 from wt_ventana_padre_grid`pb_anyadir1 within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 114
integer y = 1316
integer weight = 700
end type

event pb_anyadir1::clicked;call super::clicked;string ruta_mostrada, pathname, filename, usuario_windows
str_registro_sistema registro
Datetime fecha_modificacion
String max_codigo, ruta_antigua_disenyo, ruta_archivos_disenyo, nombre, extension, ruta_fichero, ruta_carpeta, ruta_carpeta_bd, ejecutable
Long filas
Long f, bytes
String ruta_fichero_txt, perfil, codigo_perfil

Boolean copiado = false

//Tamaño archivo 
LongLong tamanyo_inicio, tamanyo_fin, tamanyo_miniatura = 1000000000, tamanyo_archivo = 40000000000  //40GB Aprox max. 1000Mb Max para que se cree miniatura

rtn = 1

ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)

SELECT ruta_area_trabajo 
INTO :ruta_mostrada 
FROM empresas 
WHERE empresa = :codigo_empresa
USING SQLCA; 

IF SQLCA.SQLCode <> 0 THEN         
	rtn = -1
ELSE
	usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
	ruta_mostrada = ruta_mostrada + usuario_windows
	rtn = GetFileOpenName ("Añadir Fichero al Modelo "+padre_codigo, pathname, filename, "", "Fichero de Diseño, *.*", ruta_mostrada, 2)
	tamanyo_inicio = FileLength64 (pathname)

	if tamanyo_inicio > tamanyo_archivo then
		MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
		return
	end if
	
END IF

if rtn = 1 then
	//GUARDAR EN BD
		
	st_guardar.visible = true
	
	SELECT ruta_archivos_disenyo, ruta_disenyo 
	INTO :ruta_archivos_disenyo, :ruta_antigua_disenyo 
	FROM empresas 
	WHERE empresa = :codigo_empresa;
	
	ruta_carpeta = ruta_archivos_disenyo + padre_codigo + "\"
	
	//Detección sistema nuevo o viejo
	if ruta_antigua_disenyo = "" then
		ruta_carpeta_bd = padre_codigo + "\" //*********** NUEVA CARPETA BD
	else
		ruta_carpeta_bd = ruta_carpeta
	end if
	
	//OBTENCIÓN CÓDIGO NUEVO
	param_colisiones.empresa = codigo_empresa
	param_colisiones.tabla = "modelo_propuesta_sistema_archivos"
	param_colisiones.campo = "codigo"
	param_colisiones.filtro = "modelo_propuesta_sistema_archivos.modelo = '"+padre_codigo+"' AND modelo_propuesta_sistema_archivos.cliente = '"+modelo_cliente+"' AND modelo_propuesta_sistema_archivos.propuesta = '"+modelo_propuesta+"'"
	param_colisiones.buscar_huecos = false //No buscamos huecos para evitar problemas de colisiones con el DW propio
	

	//NOMBRE DEL ARCHIVO
	max_codigo = f_colisiones (trans_ts, param_colisiones)
	extension = mid(pathname, pos(pathname,"."))
	nombre = padre_codigo+"-"+modelo_cliente+"-"+modelo_propuesta+"-"+max_codigo+extension
	ruta_fichero = ruta_carpeta + nombre
	fecha_modificacion = datetime(today(), now())
	
	//Comprobación de la existencia del directorio y creación		
	
	if not FileExists(ruta_carpeta) then
		if CreateDirectory(ruta_carpeta) <> 1 then
			MessageBox("Error", "No se ha podido crear el directorio en el servidor. Por favor, avise al administrador.")
			rtn = -1
		end if
	end if
	
	if rtn = 1 then
		codigo_perfil = ""
		perfil = ""
		ftc_ejecutar_concurrente ('C:\Tencer_pb12\exiftool -w! txt -ICCProfileName "'+ pathname + '"', 2, true)
		
		//Lectura del perfil
		ruta_fichero_txt = mid(pathname, 1,pos(pathname,".")) + "txt"
		f = FileOpen(ruta_fichero_txt) 				
		if f < 0 then
			//Error apertura
			//No hacemos nada - No es crítico como en el resto de ficheros de producción
		else
			bytes = FileRead(f, perfil)
			if bytes < 0 then
				//Error lectura - Saltamos el archivo
				//No hacemos nada - No es crítico como en el resto de ficheros de producción
			else
				perfil = f_reemplazar(f_reemplazar(f_reemplazar(perfil,":",""),"ICC Profile Name","")," ","")
				//SOLO NOS INTERESA EL NOMBRE EN ESTE CASO
				/*
				codigo_perfil = ""
				SELECT codigo INTO :codigo_perfil FROM perfil_color WHERE empresa = :codigo_empresa AND nombre_fisico = :perfil USING SQLCA;
				if isnull(codigo_perfil) or codigo_perfil = "" then
					//Error - Perfil Erróneo
					//No hacemos nada - No es crítico como en el resto de ficheros de producción
				end if
				*/
			end if
		end if
		FileClose(f)
		FileDelete(ruta_fichero_txt)
	end if
	
	if rtn = 1 then
		//Si estamos en el espacio de trabajo del usuario movemos. De lo contrario copiamos
		if pos(lower(pathname), lower(ruta_mostrada)) <> 0 then
			rtn = FileMove(pathname, ruta_fichero)
			copiado = false
		else
			rtn = FileCopy(pathname, ruta_fichero, true)
			copiado = true
		end if
		if rtn = -1 then
			MessageBox("Error", "No se ha podido leer el archivo "+trim(String(pathname))+".")
		elseif rtn = -2 then
			MessageBox("Error", "No se ha podido crear el archivo "+trim(String(ruta_fichero))+".")
		else
			tamanyo_fin = FileLength64 (ruta_fichero)
			if tamanyo_inicio <> tamanyo_fin then
				MessageBox("Error", "No se ha realizado la subida del archivo correctamente. Compruebe que no hay otro programa modificando el archivo mientras lo sube.")
				rtn = -3
			end if
		end if
	end if
	
	if rtn = 1 then
		
		INSERT INTO modelo_propuesta_sistema_archivos (empresa, modelo, cliente, propuesta, codigo, ruta, fichero, fecha_modificacion, tamanyo, perfil_color) 
		VALUES (:codigo_empresa, :padre_codigo, :modelo_cliente, :modelo_propuesta, :max_codigo, :ruta_carpeta_bd, :nombre, :fecha_modificacion, :tamanyo_fin, :perfil) 
		USING trans_ts;
		
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText +" Error inserción en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
			rtn = -1
		else
			registro.accion = "NUEVO"
			registro.usuario_windows = usuario_windows
			registro.trans = trans_ts
			registro.tabla = "modelo_propuesta_sistema_archivos"
			registro.clave = codigo_empresa + "#" + padre_codigo + "#" + modelo_cliente + "#" + modelo_propuesta + "#" + max_codigo
			registro.valor = "origen: "+pathname + " destino: "+ruta_fichero
			if not ftc_registrar_cambios(registro) then
				rtn = -1
			end if
		END IF
	end if

	if rtn = 1 then
		COMMIT USING trans_ts;
		st_info.text = "Archivo "+filename+" subido correctamente." 
		
		//*****************************************************************************
		//BORRAMOS LA COPIA LOCAL DEL ARCHIVO SUBIDO
		if copiado then
			if not Filedelete(pathname) then
				MessageBox("Atención", "No ha sido posible borrar su copia en espacio de trabajo del archivo. Por favor, borrela a mano.")
			end if
		end if
		//*****************************************************************************
		//MINIATURAS
		/*
		if tamanyo_fin < tamanyo_miniatura then
			if extension = ".psd" then
				ejecutable = "C:\Tencer_PB12\IM\psd2pngcmd.exe -c "+ruta_disenyo_archivo+" "+ruta_modelo
				run(ejecutable,Minimized!)
			elseif extension = ".png" then
				//OJO No se crea miniatura. Se muestra el propio archivo
			elseif extension = ".tif" or extension = ".jpg" then
				ejecutable = 'c:\tencer_pb12\IM\convert.exe '+ruta_disenyo_archivo+' -units PixelsPerInch -resample 96 -channel RGB -resize "1200x369>" '+f_reemplazar(ruta_disenyo_archivo,extension,".png")
				run (ejecutable,Minimized!)
			end if
		end if
		*/
		//*****************************************************************************
	else
		ROLLBACK USING trans_ts;
		rtn = -1
	end if

	st_guardar.visible = false
	
	filas = dw_1.retrieve (codigo_empresa, padre_codigo, modelo_cliente, modelo_propuesta) 
	if filas > 0 then
		dw_1.setrow(filas)
	end if
	
else
	MessageBox("Cancelado","No ha sido posible obtener la ruta del archivo indicado")
end if
end event

type pb_imprimir from wt_ventana_padre_grid`pb_imprimir within wtc_mant_modelo_propuesta_sistema_archivos
boolean visible = false
integer x = 3424
integer y = 20
end type

type p_logo from wt_ventana_padre_grid`p_logo within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 4325
integer y = 12
end type

type dw_1 from wt_ventana_padre_grid`dw_1 within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 37
integer y = 268
integer width = 5801
integer height = 872
boolean titlebar = true
string title = "Archivos del Modelo"
string dataobject = "dwtc_modelo_propuesta_sistema_archivos"
boolean vscrollbar = true
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;/*
//Miniaturas
String ruta, extension

if currentrow > 0 then
	ruta = trim(dw_1.object.ruta[currentrow]) + trim(dw_1.object.fichero[currentrow])
	if not isnull(ruta) and ruta <> "" then
		extension = mid(ruta, pos(ruta,"."))
		if extension = ".png" then
			dw_imagen.Object.datawindow.picture.File = ruta
		elseif extension = ".jpg" or extension = ".tif" or extension = ".psd" then
			dw_imagen.Object.datawindow.picture.File = f_reemplazar(ruta,extension,".png")
		else
			dw_imagen.visible = false
		end if
	else
		dw_imagen.visible = false
	end if
else
	dw_imagen.visible = false
end if
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

type pb_salir from wt_ventana_padre_grid`pb_salir within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 4690
end type

type pb_grabar from wt_ventana_padre_grid`pb_grabar within wtc_mant_modelo_propuesta_sistema_archivos
end type

type st_titulo from wt_ventana_padre_grid`st_titulo within wtc_mant_modelo_propuesta_sistema_archivos
integer width = 2482
end type

type pb_cancelar from wt_ventana_padre_grid`pb_cancelar within wtc_mant_modelo_propuesta_sistema_archivos
boolean visible = false
integer x = 4014
integer y = 16
end type

type pb_descargar_archivo from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 526
integer y = 1320
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

event clicked;string ruta, pathname, ruta_destino, fichero, ruta_archivos_disenyo, origen_fichero
string filename = ""
int res, fh, fila, numero_seleccionados, i, seleccionado
Int local, remp
Boolean reemplazar = false
str_ventana_alerta parametros
string botones[2]

SELECT ruta_archivos_disenyo INTO :ruta_archivos_disenyo FROM empresas WHERE empresa = :codigo_empresa;
ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)
SELECT ruta_area_trabajo INTO :ruta_destino FROM empresas WHERE empresa = :codigo_empresa; 
ruta_destino = ruta_destino + upper(ftc_variable_entorno("USERNAME", lcxk_base)) + "\"
if not fileexists(ruta_destino) then
	ruta_destino = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop\"
end if
//res = GetFileSaveName ("Descargar Archivo", pathname, filename, "", "Fichero de Producción,*.*", ruta_destino, 2)
pathname = ruta_destino
res = GetFolder("Descargar Archivo", pathname)

remp = 0
numero_seleccionados = Long(dw_1.Describe ("Evaluate ( 'sum(if(marcado = 1,1,0))' , 0)"))

if res = 1 then
	st_guardar.visible = true
	For i = 1 To dw_1.rowcount()
		//Descargamos los archivos seleccionados y en caso de no seleccionar ninguno la fila actual
		seleccionado = dw_1.object.marcado[i]
		if seleccionado = 1 or (numero_seleccionados = 0 and dw_1.getrow() = i) then
			ruta = dw_1.object.ruta[i]
			fichero = dw_1.object.fichero[i]
			local = dw_1.object.ruta_local[i]
			if not isnull(ruta) and ruta <> "" and local = 0 then
				ruta_destino = pathname + "\" + String(dw_1.object.fichero[i])
				// Comprobar la existencia de los ficheros y preguntar una vez que se hará en caso de existencia ---------------------
				if FileExists(ruta_destino) and remp = 0 then
					parametros.titulo = "Atención Sobreescribir Ficheros"
					parametros.subtitulo = "¿Sobreescribir ficheros?"
					parametros.mensaje = "Hay ficheros que ya existen en esta carpeta, ¿Desea reemplazarlos?"
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
						reemplazar = false
					end if
				end if
				//Fin comprobación -----------------------------------------------------------------------------------------------------------------------
				
				origen_fichero = ruta_archivos_disenyo + ruta + fichero
				res = FileCopy(origen_fichero, ruta_destino, reemplazar)
				
				if res = -1 then
					MessageBox("Error", "Error de lectura de la imagen.")
				elseif res = -2 then
					MessageBox("Error", "Error de escritura de la imagen.")
				else
					st_info.text = fichero + " descargado."
				end if
				
			end if
		end if
	Next
	st_info.text = "Descargas finalizadas."
	st_guardar.visible = false
end if
	
/*
string ruta, pathname, ruta_destino, fichero, ruta_archivos_disenyo, origen_fichero
string filename = ""
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
		//res = GetFileSaveName ("Descargar Archivo", pathname, filename, "", "Fichero de Diseño,*.*", ruta_destino, 2)
		pathname = ruta_destino
		res = GetFolder("Descargar Archivo", pathname )
		if res = 1 then
			//pathname = f_reemplazar(pathname, filename, String(dw_1.object.fichero[fila]))
			pathname = pathname + "\" + String(dw_1.object.fichero[fila])
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
			SELECT ruta_archivos_disenyo INTO :ruta_archivos_disenyo FROM empresas WHERE empresa = :codigo_empresa;
			origen_fichero = ruta_archivos_disenyo + f_reemplazar(ruta, ruta_archivos_disenyo, "") + fichero
			res = FileCopy(origen_fichero, pathname, reemplazar)
			st_guardar.visible = false
			if res = -1 then
				MessageBox("Error", "Error de lectura de la imagen.")
			elseif res = -2 then
				MessageBox("Error", "Error de escritura de la imagen.")
			else
				//Exito
				//Lanzamos photoshop o el explorador de windows
				/*
				if ftc_lanzar_photoshop(pathname) < 1 then
					run("explorer "+pathname) //Muestra la carpeta
				end if
				*/
				
				//run("explorer "+pathname) //Realiza la accion de apertura por defecto del sistema
			end if				
		else
			MessageBox("Error", "No ha sido posible guardar en la ruta indicada.")
		end if
	else
		MessageBox("Error", "No existe imagen para descargar o la imagen seleccionada todabía no ha sido guardada.")
	end if
end if
*/

end event

type p_seleccion from picture within wtc_mant_modelo_propuesta_sistema_archivos
boolean visible = false
integer x = 3173
integer y = 48
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Tencer_PB12\fila_seleccionada.png"
boolean focusrectangle = false
end type

type pb_cargar_archivo from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 837
integer y = 1320
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

event clicked;long fila, filas
string ruta_mostrada, pathname, filename, usuario_windows, ejecutable
str_registro_sistema registro
Datetime fecha_modificacion
String max_codigo, ruta_antigua_disenyo, ruta_archivos_disenyo, ruta_fichero, nombre, extension, extension_antigua, ruta_carpeta, ruta_carpeta_bd, ruta_temporal
Boolean copiado = false
Long f, bytes
String ruta_fichero_txt, perfil, codigo_perfil

//Tamaño archivo 
LongLong tamanyo_inicio, tamanyo_fin, tamanyo_miniatura = 1000000000, tamanyo_archivo = 40000000000  //40GB Aprox max. 1GB Max para que se cree miniatura

String modelo, cliente, propuesta, codigo, ruta_antigua, fichero_antiguo
string botones[2]
Int cambiar
str_ventana_alerta parametros

rtn = 1
fila = dw_1.getrow()

modelo = dw_1.object.modelo[fila]
cliente = dw_1.object.cliente[fila]
propuesta = dw_1.object.propuesta[fila]
codigo = dw_1.object.codigo[fila]

SELECT ruta_archivos_disenyo, ruta_disenyo 
INTO :ruta_archivos_disenyo, :ruta_antigua_disenyo 
FROM empresas 
WHERE empresa = :codigo_empresa
USING SQLCA;

ruta_carpeta = ruta_archivos_disenyo + modelo + "\"

//Detección sistema nuevo o viejo
if ruta_antigua_disenyo = "" then
	ruta_carpeta_bd = modelo + "\" //*** NUEVO SISTEMA ARCHIVOS
else
	ruta_carpeta_bd = ruta_carpeta
end if


ruta_antigua = ruta_archivos_disenyo + f_reemplazar(String(dw_1.object.ruta[fila]), ruta_archivos_disenyo, "")
fichero_antiguo = dw_1.object.fichero[fila]

if st_produccion.visible then
	parametros.titulo = "Atención Modelo en Producción"
	parametros.subtitulo = "Modelo en Producción"
	parametros.mensaje = "¿Esta seguro de sustituir el archivo "+fichero_antiguo+"?"
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
SELECT ruta_area_trabajo 
INTO :ruta_mostrada 
FROM empresas 
WHERE empresa = :codigo_empresa
USING SQLCA;

IF SQLCA.SQLCode <> 0 THEN         
	rtn = -1
ELSE
	usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
	ruta_mostrada = ruta_mostrada + usuario_windows
	rtn = GetFileOpenName ("Modificar el fichero "+fichero_antiguo, pathname, filename, "", " Archivo Diseño, *.*", ruta_mostrada, 2)
	tamanyo_inicio = FileLength64 (pathname)
	if tamanyo_inicio > tamanyo_archivo then
		MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
		return
	end if
END IF

if rtn = 1 then
	codigo_perfil = ""
	perfil = ""
	ftc_ejecutar_concurrente ('C:\Tencer_pb12\exiftool -w! txt -ICCProfileName "'+ pathname + '"', 2, true)
	
	//Lectura del perfil
	ruta_fichero_txt = mid(pathname, 1,pos(pathname,".")) + "txt"
	f = FileOpen(ruta_fichero_txt) 				
	if f < 0 then
		//Error apertura
		//No hacemos nada - No es crítico como en el resto de ficheros de producción
	else
		bytes = FileRead(f, perfil)
		if bytes < 0 then
			//Error lectura - Saltamos el archivo
			//No hacemos nada - No es crítico como en el resto de ficheros de producción
		else
			perfil = f_reemplazar(f_reemplazar(f_reemplazar(perfil,":",""),"ICC Profile Name","")," ","")
			//SOLO NOS INTERESA EL NOMBRE EN ESTE CASO
			/*
			codigo_perfil = ""
			SELECT codigo INTO :codigo_perfil FROM perfil_color WHERE empresa = :codigo_empresa AND nombre_fisico = :perfil USING SQLCA;
			if isnull(codigo_perfil) or codigo_perfil = "" then
				//Error - Perfil Erróneo
				//No hacemos nada - No es crítico como en el resto de ficheros de producción
			end if
			*/
		end if
	end if
	FileClose(f)
	FileDelete(ruta_fichero_txt)
end if

if rtn = 1 then
	//GUARDAR EN BD
		
	st_guardar.visible = true	
	
	fecha_modificacion = datetime(today(), now())
	ruta_temporal = ruta_antigua + "old_" + String(Today(), "dd_mm_yy") + "_" + String(Now(), "hh_mm_ss") + "_" + fichero_antiguo
	rtn = FileMove(ruta_antigua + fichero_antiguo, ruta_temporal)
	
	if rtn = 1 then
		extension = mid(filename, pos(filename,"."))
		nombre = mid(fichero_antiguo, 1 , pos(fichero_antiguo,".") - 1) + extension
		//Si estamos en el espacio de trabajo del usuario movemos. De lo contrario copiamos
		if pos(lower(pathname), lower(ruta_mostrada)) <> 0 then
			rtn = FileMove(pathname, ruta_carpeta + nombre)
			copiado = false
		else
			rtn = FileCopy(pathname, ruta_carpeta + nombre, true)
			copiado = true
		end if
		if rtn = -1 then
			MessageBox("Error", "No se ha podido leer el archivo "+trim(String(pathname))+".")
		elseif rtn = -2 then
			MessageBox("Error", "No se ha podido reemplazar el archivo "+trim(String(ruta_antigua + fichero_antiguo))+".")
		else
			tamanyo_fin = FileLength64 (ruta_carpeta + nombre)
			if tamanyo_inicio <> tamanyo_fin then
				MessageBox("Error", "No se ha realizado la subida del archivo correctamente. Compruebe que no hay otro programa modificando el archivo mientras lo sube.")
				rtn = -3
			end if
		end if
		
		if rtn = 1 then
			
			UPDATE modelo_propuesta_sistema_archivos 
			SET ruta = :ruta_carpeta_bd, fichero = :nombre, fecha_modificacion = :fecha_modificacion, tamanyo = :tamanyo_fin, perfil_color = :perfil  
			WHERE empresa = :codigo_empresa AND modelo = :modelo AND cliente = :cliente 
			AND propuesta = :propuesta AND codigo = :codigo
			USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" Error actualización en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
				rtn = -1
			else
				registro.accion = "MODIFICAR"
				registro.usuario_windows = usuario_windows
				registro.trans = trans_ts
				registro.tabla = "modelo_propuesta_sistema_archivos"
				registro.clave = codigo_empresa + "#" + modelo + "#" + cliente + "#" + propuesta + "#" + codigo
				registro.valor = "origen: "+ pathname + " destino: " + ruta_carpeta + nombre
				if not ftc_registrar_cambios(registro) then
					rtn = -1
				end if
			END IF
		end if
		if rtn = 1 then
		
			fileDelete(ruta_temporal)
			
			COMMIT USING trans_ts;
			
			//*****************************************************************************
			//BORRAMOS LA COPIA LOCAL DEL ARCHIVO SUBIDO
			if copiado then
				if not Filedelete(pathname) then
					MessageBox("Atención", "No ha sido posible borrar su copia en espacio de trabajo del archivo. Por favor, borrela a mano.")
				end if
			end if
			//*****************************************************************************
			//*****************************************************************************
			//MINIATURAS
			/*
			dw_imagen.Object.datawindow.picture.File = ""
			extension_antigua = mid(fichero_antiguo, pos(fichero_antiguo,"."))
			if extension_antigua <> ".png" then
				//Borrar miniatura antigua
				filedelete(f_reemplazar(ruta_antigua+fichero_antiguo,extension_antigua,".png"))
			end if
			if tamanyo_fin < tamanyo_miniatura then
				if extension = ".psd" then
					ejecutable = "C:\Tencer_PB12\IM\psd2pngcmd.exe -c "+ruta_antigua+nombre+" "+ruta_antigua
					run(ejecutable,Minimized!)
				elseif extension = ".png" then
					//OJO No se crea miniatura. Se muestra el propio archivo
				elseif extension = ".tif" or extension = ".jpg" then
					ejecutable = 'c:\tencer_pb12\IM\convert.exe '+ruta_antigua+nombre+' -units PixelsPerInch -resize "1200x369>" '+f_reemplazar(ruta_antigua+nombre,extension,".png")
					run (ejecutable,Minimized!)
				end if
			end if
			*/
			//*****************************************************************************
			st_info.text = "Reemplazo de "+fichero_antiguo+" por "+filename+" correcto." 
		else
			ROLLBACK USING trans_ts;
			FileMove(ruta_temporal, ruta_antigua + fichero_antiguo)
			rtn = -1
		end if
	else
		ROLLBACK USING trans_ts;
		rtn = -1
	end if

	st_guardar.visible = false
	
	filas = dw_1.retrieve (codigo_empresa, padre_codigo, modelo_cliente, modelo_propuesta) 
	if filas > 0 then
		dw_1.setrow(fila)
	end if
else
	MessageBox("Cancelado","No ha sido posible obtener la ruta del archivo indicado")
end if
end event

type st_guardar from statictext within wtc_mant_modelo_propuesta_sistema_archivos
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

type st_produccion from statictext within wtc_mant_modelo_propuesta_sistema_archivos
boolean visible = false
integer x = 882
integer y = 160
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

type st_info from statictext within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 1774
integer y = 160
integer width = 2862
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
boolean focusrectangle = false
end type

type dw_imagen from u_dw_imagen within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 37
integer y = 1520
integer width = 4800
integer height = 1476
integer taborder = 100
boolean bringtotop = true
boolean border = true
end type

type pb_1 from picturebutton within wtc_mant_modelo_propuesta_sistema_archivos
integer x = 681
integer y = 1320
integer width = 146
integer height = 128
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\ps_big.png"
alignment htextalign = left!
string powertiptext = "Descargar y Abrir Archivo"
end type

event clicked;string ruta, pathname, ruta_destino, fichero, ruta_archivos_disenyo, origen_fichero
string filename = ""
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
		//res = GetFileSaveName ("Descargar Archivo", pathname, filename, "", "Fichero de Diseño,*.*", ruta_destino, 2)
		pathname = ruta_destino
		res = GetFolder("Descargar Archivo", pathname )
		if res = 1 then
			//pathname = f_reemplazar(pathname, filename, String(dw_1.object.fichero[fila]))
			pathname = pathname + "\" + String(dw_1.object.fichero[fila])
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
			SELECT ruta_archivos_disenyo INTO :ruta_archivos_disenyo FROM empresas WHERE empresa = :codigo_empresa;
			origen_fichero = ruta_archivos_disenyo + f_reemplazar(ruta, ruta_archivos_disenyo, "") + fichero
			res = FileCopy(origen_fichero, pathname, reemplazar)
			st_guardar.visible = false
			if res = -1 then
				MessageBox("Error", "Error de lectura de la imagen.")
			elseif res = -2 then
				MessageBox("Error", "Error de escritura de la imagen.")
			else
				//Exito
				//Lanzamos photoshop o el explorador de windows
				/*
				if ftc_lanzar_photoshop(pathname) < 1 then
					run("explorer "+pathname) //Muestra la carpeta
				end if
				*/
				
				run("explorer "+pathname) //Realiza la accion de apertura por defecto del sistema
			end if				
		else
			MessageBox("Error", "No ha sido posible guardar en la ruta indicada.")
		end if
	else
		MessageBox("Error", "No existe imagen para descargar o la imagen seleccionada todabía no ha sido guardada.")
	end if
end if

	

end event

