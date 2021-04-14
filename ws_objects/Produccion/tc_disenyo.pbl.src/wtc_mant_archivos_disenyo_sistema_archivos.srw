$PBExportHeader$wtc_mant_archivos_disenyo_sistema_archivos.srw
forward
global type wtc_mant_archivos_disenyo_sistema_archivos from wt_ventana_padre_grid
end type
type pb_descargar_archivo from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos
end type
type st_guardar from statictext within wtc_mant_archivos_disenyo_sistema_archivos
end type
type p_seleccion from picture within wtc_mant_archivos_disenyo_sistema_archivos
end type
type cb_explorar from commandbutton within wtc_mant_archivos_disenyo_sistema_archivos
end type
type pb_cargar_archivo from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos
end type
type st_produccion from statictext within wtc_mant_archivos_disenyo_sistema_archivos
end type
type cb_borrado_masivo from commandbutton within wtc_mant_archivos_disenyo_sistema_archivos
end type
type st_info from statictext within wtc_mant_archivos_disenyo_sistema_archivos
end type
type dw_imagen from u_dw_imagen within wtc_mant_archivos_disenyo_sistema_archivos
end type
type pb_1 from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos
end type
end forward

global type wtc_mant_archivos_disenyo_sistema_archivos from wt_ventana_padre_grid
integer width = 5609
integer height = 1596
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
st_info st_info
dw_imagen dw_imagen
pb_1 pb_1
end type
global wtc_mant_archivos_disenyo_sistema_archivos wtc_mant_archivos_disenyo_sistema_archivos

type variables
String tipo_maquina
String nombre_fichero
end variables

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();Boolean falta_campo
String campo, motivo
Long i

// El primer campo del datawindow será el que reciba el código generado. 
// Por tanto, al crear el datawindow maestro debemos situar en primera posición dicho campo
dw_1.accepttext()
rtn = 1

//VALIDACIÓN DE DATOS

dw_1.accepttext()
falta_campo = false
IF dw_1.rowcount() > 0 THEN
	falta_campo = false
	i = 1
	DO WHILE ( i <= dw_1.rowcount() AND NOT falta_campo )
		/*
		if dw_1.object.tipomaquina_disenyo_gestion_color[i] = '1' then
			IF IsNull(dw_1.object.perfil_color[i]) or Trim(String(dw_1.object.perfil_color[i]))="" THEN
				  campo="perfil_color"
				  motivo  = "Campo Obligatorio: Introduzca el Perfil de Color"
				  falta_campo = True
			END IF
		end if
		*/
		i++
	LOOP
		
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dw_1.setrow(i)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	END IF
END IF

//GUARDADO


rtn = super::f_guardar()

return rtn
end function

on wtc_mant_archivos_disenyo_sistema_archivos.create
int iCurrent
call super::create
this.pb_descargar_archivo=create pb_descargar_archivo
this.st_guardar=create st_guardar
this.p_seleccion=create p_seleccion
this.cb_explorar=create cb_explorar
this.pb_cargar_archivo=create pb_cargar_archivo
this.st_produccion=create st_produccion
this.cb_borrado_masivo=create cb_borrado_masivo
this.st_info=create st_info
this.dw_imagen=create dw_imagen
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_descargar_archivo
this.Control[iCurrent+2]=this.st_guardar
this.Control[iCurrent+3]=this.p_seleccion
this.Control[iCurrent+4]=this.cb_explorar
this.Control[iCurrent+5]=this.pb_cargar_archivo
this.Control[iCurrent+6]=this.st_produccion
this.Control[iCurrent+7]=this.cb_borrado_masivo
this.Control[iCurrent+8]=this.st_info
this.Control[iCurrent+9]=this.dw_imagen
this.Control[iCurrent+10]=this.pb_1
end on

on wtc_mant_archivos_disenyo_sistema_archivos.destroy
call super::destroy
destroy(this.pb_descargar_archivo)
destroy(this.st_guardar)
destroy(this.p_seleccion)
destroy(this.cb_explorar)
destroy(this.pb_cargar_archivo)
destroy(this.st_produccion)
destroy(this.cb_borrado_masivo)
destroy(this.st_info)
destroy(this.dw_imagen)
destroy(this.pb_1)
end on

event open;str_parametros lstr_param
Long pantallas = 0, aplicaciones = 0

cerrar_sin_abrir = false

dw_1.SetTransObject(SQLCA)

////PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana 
//FROM uti_permisos_ventana P 
//INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa 
//WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;
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
	
	dw_1.SetFocus()
	
	dw_1.title = 'Pruebas del Fichero de Produccción ' + nombre_fichero
	
	dw_1.SetRowFocusIndicator(p_seleccion)
	
	SELECT COUNT(*) INTO :pantallas FROM juegospantallas 
	WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipo_maquina AND archivo = :padre_codigo;
			
	SELECT COUNT(*) INTO :aplicaciones FROM art_ver_op_aplicaciones 
	WHERE empresa = :codigo_empresa AND archivo_disenyo_tipomaquina_disenyo = :tipo_maquina AND archivo_disenyo_codigo = :padre_codigo;
	
	if pantallas + aplicaciones > 0 then
		st_produccion.visible = true
		//LIMITAR SOLO A LABOR
		//cb_borrado_masivo.visible = true
	end if
//end if
end event

event close;call super::close;//Comprobación de la existencia de archivos guardados por error por diseño
/*
String sel, ruta
Long i, total
Datastore archivos

f_crear_transaccion(transaccion ,"" ,"" ,false, "TS","")	
CONNECT USING transaccion;
rtn = 1

sel = "SELECT REPLACE(ruta + fichero, ' ','') AS ruta FROM archivo_disenyo_sistema_archivos WHERE empresa = '"+codigo_empresa+"' AND tipomaquina_disenyo = '"+tipo_maquina+"' AND archivo = '"+padre_codigo+"'"
f_cargar_cursor_trans (transaccion,  sel,  archivos)
total = archivos.RowCount()
i = 1
do while (i <= total) 
	ruta = archivos.object.ruta[i]
	
	i++
loop

IF rtn = 1 THEN	
	COMMIT USING transaccion;
	
ELSE
	ROLLBACK USING transaccion;
END IF

DISCONNECT USING transaccion;
Destroy archivos
*/
end event

event closequery;if f_guardar() <> 1 then
	return 1 //Fallo de validación en la grabación, no cerrar
end if
end event

event activate;call super::activate;if permiso_ventana = 1 then
	//Solo lectura
	pb_grabar.visible = false
	pb_anyadir1.visible = false
	pb_borrar1.visible = false
	pb_cargar_archivo.visible = false
end if
end event

type st_codigo from wt_ventana_padre_grid`st_codigo within wtc_mant_archivos_disenyo_sistema_archivos
boolean visible = false
integer x = 2117
integer y = 24
integer width = 503
integer height = 76
alignment alignment = left!
end type

type pb_duplicar1 from wt_ventana_padre_grid`pb_duplicar1 within wtc_mant_archivos_disenyo_sistema_archivos
boolean visible = false
integer x = 2427
integer y = 0
end type

type pb_borrar1 from wt_ventana_padre_grid`pb_borrar1 within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 283
integer y = 1324
string powertiptext = "Eliminar Archivo"
end type

event pb_borrar1::clicked;string botones[2]
Int cambiar
str_ventana_alerta parametros

Long fila_actual, j, total_aplicaciones
String ruta, ruta_archivos_disenyo, ruta_papelera, sel, tipomaquina_disenyo, codigo_archivo, prueba_archivo, modelo, cliente, propuesta, pieza, prueba, aplicacion, extension
str_registro_sistema registro
String usuario_windows
Datastore aplicaciones

if dw_1.rowcount() <= 0 then
	Destroy aplicaciones
	return
end if

fila_actual = dw_1.getrow()

if dw_1.object.produccion[fila_actual] > 0 then
	MessageBox("Error","Atención, no puede borrar un archivo que está en producción.")
	return
end if

parametros.titulo = "Atención Borrar Archivo"
parametros.subtitulo = "Borrar Archivo de la Pieza"
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

tipomaquina_disenyo = dw_1.object.tipomaquina_disenyo[fila_actual]
codigo_archivo = dw_1.object.archivo[fila_actual]
prueba_archivo = dw_1.object.codigo[fila_actual]

//Borrado del archivo de las aplicaciones de las pruebas laboratorio y tickets de máquinas de producción

sel = "SELECT modelo_aplicacion.modelo, modelo_aplicacion.cliente, modelo_aplicacion.propuesta, modelo_aplicacion.pieza, modelo_aplicacion.prueba, modelo_aplicacion.codigo  "+&
		"FROM modelo_aplicacion INNER JOIN modelo_archivo ON modelo_aplicacion.empresa = modelo_archivo.empresa AND modelo_aplicacion.modelo = modelo_archivo.modelo AND modelo_aplicacion.cliente = modelo_archivo.cliente AND modelo_aplicacion.propuesta = modelo_archivo.propuesta AND modelo_aplicacion.pieza = modelo_archivo.pieza AND modelo_aplicacion.modelo_archivo = modelo_archivo.codigo "+&
		"WHERE modelo_archivo.empresa = '"+codigo_empresa+"' AND modelo_archivo.tipo_maquina_disenyo = '"+tipomaquina_disenyo+"' AND modelo_archivo.archivo_disenyo = '"+codigo_archivo+"' AND modelo_aplicacion.modelo_archivo_prueba = '"+prueba_archivo+"'"
f_cargar_cursor_transaccion (trans_ts,  aplicaciones,  sel)
		
j = 1
total_aplicaciones = aplicaciones.RowCount()

if st_produccion.visible = true then
	
	do while (j <= total_aplicaciones AND rtn = 1) 
		modelo = aplicaciones.object.modelo_aplicacion_modelo[j]
		cliente = aplicaciones.object.modelo_aplicacion_cliente[j]
		propuesta = aplicaciones.object.modelo_aplicacion_propuesta[j]
		pieza = aplicaciones.object.modelo_aplicacion_pieza[j]
		prueba = aplicaciones.object.modelo_aplicacion_prueba[j]
		aplicacion = aplicaciones.object.modelo_aplicacion_codigo[j]
		
		UPDATE modelo_aplicacion 
		set modelo_archivo = NULL, modelo_archivo_prueba = NULL 
		WHERE empresa = :codigo_empresa AND modelo = :modelo AND cliente = :cliente 
		AND propuesta = :propuesta AND pieza = :pieza AND prueba = :prueba AND codigo = :aplicacion USING trans_ts;
		
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText +" Actualización de Aplicaciones de Laboratorio: "+String(trans_ts.SQLDBCode))
			rtn = -1
		END IF
		
		j++
	loop
	
	Destroy aplicaciones
	
	if rtn = 1 then	
		UPDATE modelo_pieza_ticket 
		SET tipo_maquina = NULL, archivo_disenyo = NULL, archivo_disenyo_prueba = NULL 
		WHERE empresa = :codigo_empresa AND tipo_maquina = :tipomaquina_disenyo 
		AND archivo_disenyo = :codigo_archivo AND archivo_disenyo_prueba = :prueba_archivo USING trans_ts;
				
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText +" Actualización de Tickets de Máquinas de Producción: "+String(trans_ts.SQLDBCode))
			rtn = -1
		END IF
	end if
else
	if total_aplicaciones > 0 then
		MessageBox("Error", "No puede borrar archivos que están siendo usados en pruebas de laboratorio. Solo se permite su borrado cuando el artículo pasa a producción.")
		rtn = -1
	end if
end if

SELECT ruta_archivos_disenyo 
INTO :ruta_archivos_disenyo 
FROM empresas 
WHERE empresa = :codigo_empresa using trans_ts;

if isnull(ruta_archivos_disenyo) then ruta_archivos_disenyo = ""

//Borrado del archivo
if rtn = 1 then
	ruta = ruta_archivos_disenyo + f_reemplazar(trim(String(dw_1.object.ruta[fila_actual])), ruta_archivos_disenyo, "") + trim(String(dw_1.object.fichero[fila_actual]))
	ruta_papelera = ""
	SELECT ruta_papelera_disenyo INTO :ruta_papelera FROM empresas WHERE empresa = :codigo_empresa using trans_ts;
	IF trans_ts.SQLCode <> 0 THEN         
		MessageBox("SQL error", trans_ts.SQLErrText +" No se ha podido realizar encontrar la ruta de la papelera de reciclaje: "+String(trans_ts.SQLDBCode))
		rtn = -1
	END IF
	
	if not isnull(ruta_papelera) and ruta_papelera <> "" then
		ruta_papelera = ruta_papelera +  "old_" + String(Today(), "dd_mm_yy") + "_" + String(Now(), "hh_mm_ss") + "_" + trim(String(dw_1.object.fichero[fila_actual]))
		rtn = FileMove(ruta, ruta_papelera)
		if rtn = 1 then
			DELETE FROM archivo_disenyo_sistema_archivos 
			WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipomaquina_disenyo AND archivo = :codigo_archivo AND codigo = :prueba_archivo USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" No se ha podido realizar el borrado en la base de datos: "+String(trans_ts.SQLDBCode))
				rtn = -1
			END IF
		else
			MessageBox("Error", "No se ha podido mover el archivo a la papelera. Por favor, avise al administrador.")
			rtn = -1 
		end if
	else
		MessageBox("Error", "En la base de datos la ruta de la papelera de reciclaje no está definida. Por favor, avise al administrador.")
		rtn = -1
	end if
end if

if rtn = 1 then
	registro.usuario_windows = usuario_windows
	registro.trans = trans_ts
	registro.accion = "BORRAR"
	registro.tabla = "archivo_disenyo_sistema_archivos"
	registro.clave = codigo_empresa + "#" + tipomaquina_disenyo + "#" + codigo_archivo + "#" + prueba_archivo
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

dw_1.retrieve (codigo_empresa, tipo_maquina, padre_codigo) 
end event

type pb_anyadir1 from wt_ventana_padre_grid`pb_anyadir1 within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 128
integer y = 1324
integer weight = 700
string powertiptext = "Añadir Archivo Nuevo"
end type

event pb_anyadir1::clicked;call super::clicked;string ruta_mostrada, pathname, filename, usuario_windows
str_registro_sistema registro
Datetime fecha_modificacion
String max_codigo, ruta_antigua_disenyo, ruta_archivos_disenyo, ruta_fichero, nombre, extension, ruta_carpeta, ruta_carpeta_bd, ejecutable
Long filas, f, bytes
String gestion_color = "0", perfil, codigo_perfil, ruta_fichero_txt

Boolean copiado = false

//Tamaño archivo 
LongLong tamanyo_inicio, tamanyo_fin, tamanyo_miniatura = 1000000000, tamanyo_archivo = 40000000000 //40GB Aprox, 1GB Miniatura

rtn = 1

ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)
SELECT ruta_area_trabajo INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa using sqlca;
IF SQLCA.SQLCode <> 0 THEN         
	rtn = -1
ELSE
	usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
	ruta_mostrada = ruta_mostrada + usuario_windows
	rtn = GetFileOpenName ("Añadir Prueba al Fichero "+nombre_fichero, pathname, filename, "", "Fichero Producción, *.*", ruta_mostrada, 2)
	tamanyo_inicio = FileLength64 (pathname)
	if tamanyo_inicio > tamanyo_archivo then
		MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
		return
	end if
	if pos(mid(pathname, pos(pathname, ".") + 1), ".") > 0 then
		MessageBox("Error","El nombre del fichero no puede contener puntos.")
		return
	end if
END IF

if rtn = 1 then
	//GUARDAR EN BD
		
	st_guardar.visible = true
	
	SELECT ruta_archivos_disenyo, ruta_disenyo 
	INTO :ruta_archivos_disenyo, :ruta_antigua_disenyo 
	FROM empresas 
	WHERE empresa = :codigo_empresa 
	using sqlca;
	
	SELECT gestion_color 
	INTO :gestion_color 
	FROM tipomaquina_disenyo 
	WHERE empresa = :codigo_empresa 
	AND codigo = :tipo_maquina 
	using sqlca;
	
	ruta_carpeta = ruta_archivos_disenyo + nombre_fichero + "\"
	
	//Detección sistema nuevo o viejo
	if ruta_antigua_disenyo = "" then
		ruta_carpeta_bd = nombre_fichero + "\" //********* Nueva ruta BD
	else
		ruta_carpeta_bd = ruta_carpeta
	end if
	
	//OBTENCIÓN CÓDIGO NUEVO
	param_colisiones.empresa = codigo_empresa
	param_colisiones.tabla = "archivo_disenyo_sistema_archivos"
	param_colisiones.campo = "codigo"
	param_colisiones.filtro = "archivo_disenyo_sistema_archivos.tipomaquina_disenyo = '"+tipo_maquina+"' and archivo_disenyo_sistema_archivos.archivo = '"+padre_codigo+"'"
	param_colisiones.buscar_huecos = false //No buscamos huecos para evitar problemas de colisiones con el DW propio
	
	
	//NOMBRE DEL ARCHIVO
	max_codigo = f_colisiones (trans_ts, param_colisiones)
	extension = mid(pathname, pos(pathname,"."))
	nombre = nombre_fichero+"-"+max_codigo+extension
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
		if gestion_color = "1" then
			ftc_ejecutar_concurrente ('C:\Tencer_pb12\exiftool -w! txt -ICCProfileName "'+ pathname + '"', 2, true)
			
			//Lectura del perfil
			ruta_fichero_txt = mid(pathname, 1,pos(pathname,".")) + "txt"
			f = FileOpen(ruta_fichero_txt) 				
			if f < 0 then
				//Error apertura
				MessageBox("Error", "No se puede abrir el perfil del archivo.")
				rtn = -4
			else
				bytes = FileRead(f, perfil)
				if bytes < 0 then
					//Error lectura - Saltamos el archivo
					MessageBox("Error", "No se puede leer el perfil del archivo.")
					rtn = -4
				else
					perfil = f_reemplazar(f_reemplazar(f_reemplazar(perfil,":",""),"ICC Profile Name","")," ","")
					codigo_perfil = ""
					SELECT codigo INTO :codigo_perfil FROM perfil_color WHERE empresa = :codigo_empresa AND nombre_fisico = :perfil USING trans_ts;
					if isnull(codigo_perfil) or codigo_perfil = "" then
						//Error - Perfil Erróneo
						MessageBox("Error", "El archivo tiene un perfil de color NO VÁLIDO: "+perfil+". Por favor, reemplácelo.")
						rtn = -4
					end if
				end if
			end if
			FileClose(f)
			FileDelete(ruta_fichero_txt)
		end if
	end if
	
	if rtn = 1 then		
		INSERT INTO archivo_disenyo_sistema_archivos (empresa, tipomaquina_disenyo, archivo, codigo, ruta, fichero, fecha_modificacion, tamanyo, perfil_color) 
		VALUES (:codigo_empresa, :tipo_maquina, :padre_codigo, :max_codigo, :ruta_carpeta_bd, :nombre, :fecha_modificacion, :tamanyo_fin, :codigo_perfil) USING trans_ts;
		
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText +" Error inserción en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
			rtn = -1
		else
			registro.accion = "NUEVO"
			registro.usuario_windows = usuario_windows
			registro.trans = trans_ts
			registro.tabla = "archivo_disenyo_sistema_archivos"
			registro.clave = codigo_empresa + "#" + tipo_maquina + "#" + padre_codigo + "#" + max_codigo
			registro.valor = "origen: " + pathname + " destino "+ruta_fichero
			if not ftc_registrar_cambios(registro) then
				rtn = -1
			end if
		END IF
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
		//*****************************************************************************
		//MINIATURAS
		/*
		if extension = ".psd" then
			ejecutable = "C:\Tencer_PB12\IM\psd2pngcmd.exe -c "+ruta_disenyo_archivo+" "+ruta_modelo
			run(ejecutable,Minimized!)
		elseif extension = ".png" then
			//OJO No se crea miniatura. Se muestra el propio archivo
		elseif extension = ".tif" or extension = ".jpg" then
			ejecutable = 'c:\tencer_pb12\IM\convert.exe '+ruta_disenyo_archivo+' -units PixelsPerInch -resample 96 -channel RGB -resize "1200x369>" '+f_reemplazar(ruta_disenyo_archivo,extension,".png")
			run (ejecutable,Minimized!)
		end if
		*/
		//*****************************************************************************
	else
		ROLLBACK USING trans_ts;
		rtn = -1
	end if

	st_guardar.visible = false
	
	filas = dw_1.retrieve (codigo_empresa, tipo_maquina, padre_codigo) 
	if filas > 0 then
		dw_1.setrow(filas)
	end if
else
	MessageBox("Cancelado","No ha sido posible obtener la ruta del archivo indicado")
end if








end event

type pb_imprimir from wt_ventana_padre_grid`pb_imprimir within wtc_mant_archivos_disenyo_sistema_archivos
boolean visible = false
integer x = 2770
integer y = 12
end type

type p_logo from wt_ventana_padre_grid`p_logo within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 5065
integer y = 24
end type

type dw_1 from wt_ventana_padre_grid`dw_1 within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 41
integer y = 268
integer width = 5545
integer height = 1224
boolean titlebar = true
string title = "Archivos de la Pieza"
string dataobject = "dwtc_archivo_disenyo_sistema_archivos"
boolean vscrollbar = true
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;/*
//MINIATURAS
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

event dw_1::clicked;call super::clicked;String ruta_fichero, usuario_windows
str_ventana_alerta parametros
str_registro_sistema registro
string botones[2]
Int respuesta
Long fila
Datetime ahora 
ahora = Datetime (Today(), Now())

if row > 0 then
	CHOOSE CASE dwo.name
		CASE "p_ps", "p_tiff", "p_jpg", "p_ai"
			if permiso_ventana > 1 and (integer(dw_1.object.tipomaquina_disenyo[row]) =  3 or integer(dw_1.object.tipomaquina_disenyo[row]) =  2) then
				SELECT ruta_archivos_disenyo INTO :ruta_fichero FROM empresas WHERE empresa = :codigo_empresa;
				ruta_fichero = Trim(ruta_fichero) + Trim(dw_1.object.ruta[row]) + Trim(dw_1.object.fichero[row])
				
				parametros.titulo = "MODIFICAR SERIGRAFIA/KERAJET DIRECTAMENTE"
				parametros.subtitulo = "MODIFCAR DIRECTAMENTE"
				parametros.mensaje = "NO 'GUARDAR COMO' en Photoshop o perderá los cambios y no se recuperarán. ¿Desea modificar bajo su responsabilidad?"
				parametros.tipo = 2
				botones[1] = "SI"
				botones[2] = "NO, descargaré"
				parametros.botones = botones
				parametros.mostrar_imagen = true
				openwithparm(wtc_ventana_alerta, parametros)
				respuesta = Int(Message.DoubleParm)
				
				if not isnull(ruta_fichero) and ruta_fichero <> "" and respuesta = 1 then
					ContextKeyword lcxk_base
					this.GetContextService("Keyword", lcxk_base)
					usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
					
					registro.accion = "MODIFICAR DIRECTO"
					registro.usuario_windows = usuario_windows
					registro.trans = SQLCA
					registro.tabla = "archivo_disenyo_sistema_archivos"
					registro.clave = codigo_empresa + "#" + String(dw_1.object.tipomaquina_disenyo[row]) + "#" + padre_codigo + "#" + String(dw_1.object.codigo[row])
					registro.valor = ruta_fichero
					if ftc_registrar_cambios(registro) then
						//Lanzamos photoshop
						run("explorer "+ruta_fichero) 
						fila = this.getrow()
						this.object.fecha_modificacion[fila] = ahora
						f_guardar()
					end if					
				end if
			end if
	END CHOOSE
end if
end event

type pb_salir from wt_ventana_padre_grid`pb_salir within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 5435
integer y = 124
end type

type pb_grabar from wt_ventana_padre_grid`pb_grabar within wtc_mant_archivos_disenyo_sistema_archivos
integer y = 124
end type

type st_titulo from wt_ventana_padre_grid`st_titulo within wtc_mant_archivos_disenyo_sistema_archivos
integer y = 32
integer width = 1554
end type

type pb_cancelar from wt_ventana_padre_grid`pb_cancelar within wtc_mant_archivos_disenyo_sistema_archivos
boolean visible = false
integer x = 3355
integer y = 8
end type

type pb_descargar_archivo from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 539
integer y = 1328
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
	

end event

type st_guardar from statictext within wtc_mant_archivos_disenyo_sistema_archivos
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

type p_seleccion from picture within wtc_mant_archivos_disenyo_sistema_archivos
boolean visible = false
integer x = 2638
integer y = 24
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Tencer_PB12\fila_seleccionada.png"
boolean focusrectangle = false
end type

type cb_explorar from commandbutton within wtc_mant_archivos_disenyo_sistema_archivos
boolean visible = false
integer x = 2981
integer y = 16
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

type pb_cargar_archivo from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 859
integer y = 1328
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

event clicked;Long fila, filas
String gestion_color = "0", codigo_perfil
string ruta_mostrada, pathname, filename, usuario_windows, ejecutable
str_registro_sistema registro
Datetime fecha_modificacion
String max_codigo, ruta_antigua_disenyo, ruta_archivos_disenyo, ruta_fichero, nombre, extension, ruta_carpeta, ruta_carpeta_bd, ruta_temporal, ruta_papelera_disenyo, nombre_temporal
Boolean copiado = false

//Tamaño archivo 
LongLong tamanyo_inicio, tamanyo_fin, tamanyo_miniatura = 1000000000, tamanyo_archivo = 40000000000 //40GB Aprox

String tipomaquina_disenyo, codigo_archivo, prueba_archivo, ruta_antigua, fichero_antiguo
string botones[2]
Int cambiar
str_ventana_alerta parametros

rtn = 1
fila = dw_1.getrow()

tipomaquina_disenyo = dw_1.object.tipomaquina_disenyo[fila]
codigo_archivo = dw_1.object.archivo[fila]
prueba_archivo = dw_1.object.codigo[fila]

SELECT ruta_archivos_disenyo, ruta_disenyo, ruta_papelera_disenyo 
INTO :ruta_archivos_disenyo, :ruta_antigua_disenyo, :ruta_papelera_disenyo 
FROM empresas 
WHERE empresa = :codigo_empresa using sqlca;

ruta_carpeta = ruta_archivos_disenyo + nombre_fichero + "\"
ruta_carpeta_bd = nombre_fichero + "\"

st_info.text = ""

ruta_antigua = ruta_archivos_disenyo + dw_1.object.ruta[fila]
fichero_antiguo = dw_1.object.fichero[fila]

if dw_1.object.produccion[fila] > 0 then
	parametros.titulo = "Atención Archivo de Producción"
	parametros.subtitulo = "Cambiar Archivo Producción"
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
SELECT ruta_area_trabajo INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa using sqlca; 
IF SQLCA.SQLCode <> 0 THEN         
	rtn = -1
ELSE
	usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
	ruta_mostrada = ruta_mostrada + usuario_windows
	rtn = GetFileOpenName ("Sustituir el Fichero "+fichero_antiguo, pathname, filename, "", "Fichero Producción, *.*", ruta_mostrada, 2)
	if rtn = 1 then
		tamanyo_inicio = FileLength64 (pathname)
		if tamanyo_inicio > tamanyo_archivo then
			MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
			return
		end if
	else
		MessageBox("Cancelado","No ha indicado el archivo a subir.")
	end if
END IF

//Comprobacion perfil
SELECT gestion_color 
INTO :gestion_color 
FROM tipomaquina_disenyo 
WHERE empresa = :codigo_empresa AND codigo = :tipo_maquina 
using sqlca;

if gestion_color = "1" and rtn = 1 then
	codigo_perfil = ftc_perfil_color_fichero(pathname)
	if codigo_perfil = "" or codigo_perfil = "-1" then
		//Perfil de color no válido, no se sigue con el reemplazo
		rtn=-4
	end if
end if

if rtn = 1 then
	//GUARDAR EN BD
		
	st_guardar.visible = true
	
	//Creación del archivo temporal
	fecha_modificacion = datetime(today(), now())
	nombre_temporal = "old_" + String(Today(), "dd_mm_yy") + "_" + String(Now(), "hh_mm_ss") + "_" + fichero_antiguo
	ruta_temporal = ruta_antigua + nombre_temporal
	rtn = FileMove(ruta_antigua + fichero_antiguo, ruta_temporal)
	
	if rtn = 1 then
		extension = mid(filename, pos(filename,"."))
		nombre = mid(fichero_antiguo, 1 , pos(fichero_antiguo,".") - 1) + extension
		
		//Si estamos en el espacio de trabajo del usuario movemos. De lo contrario copiamos
		if rtn = 1 then
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
			if rtn <> 1 then //Si ha habido error, hay que volver a colocar el archivo temporal en su sitio
				FileDelete(ruta_carpeta + nombre)
				if FileMove(ruta_temporal, ruta_antigua + fichero_antiguo) <> 1 then
					MessageBox("Error", "Avise a Informática. El archivo se ha quedado con el nombre temporal.")
					registro.accion = "FALLO RESTAURAR OLD" 
					registro.usuario_windows = usuario_windows
					registro.trans = trans_ts
					registro.tabla = "archivo_disenyo_sistema_archivos"
					registro.clave = codigo_empresa + "#" + tipomaquina_disenyo + "#" + codigo_archivo + "#" + prueba_archivo
					registro.valor = "Temporal: "+ruta_temporal 
					if not ftc_registrar_cambios(registro) then
						rtn = -1
					end if
				end if
			end if
		end if
		
		if rtn = 1 then			
			UPDATE archivo_disenyo_sistema_archivos 
			SET ruta = :ruta_carpeta_bd, fichero = :nombre, fecha_modificacion = :fecha_modificacion, tamanyo = :tamanyo_fin, perfil_color = :codigo_perfil 
			WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipomaquina_disenyo 
			AND archivo = :codigo_archivo AND codigo = :prueba_archivo USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" Error actualización en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
				rtn = -1
				//Eror dejamos el archivo original en su sitio
				FileDelete(ruta_carpeta + nombre)
				if FileMove(ruta_temporal, ruta_antigua + fichero_antiguo) <> 1 then
					MessageBox("Error", "Avise a Informática. El archivo se ha quedado con el nombre temporal.")
					registro.accion = "FALLO RESTAURAR OLD" 
					registro.usuario_windows = usuario_windows
					registro.trans = trans_ts
					registro.tabla = "archivo_disenyo_sistema_archivos"
					registro.clave = codigo_empresa + "#" + tipomaquina_disenyo + "#" + codigo_archivo + "#" + prueba_archivo
					registro.valor = "Temporal: "+ruta_temporal 
					if not ftc_registrar_cambios(registro)  then
						rtn = -1
					end if
				end if
			else
				registro.accion = "MODIFICAR"
				registro.usuario_windows = usuario_windows
				registro.trans = trans_ts
				registro.tabla = "archivo_disenyo_sistema_archivos"
				registro.clave = codigo_empresa + "#" + tipomaquina_disenyo + "#" + codigo_archivo + "#" + prueba_archivo
				registro.valor = "origen: "+ pathname + " destino: " + ruta_carpeta + nombre
				if not ftc_registrar_cambios(registro) then
					rtn = -1
				end if
			END IF
		end if
		
		if rtn = 1 then		
			//El archivo reemplazado lo dejamos en la papelera
			fileMove(ruta_temporal, ruta_papelera_disenyo + nombre_temporal)
			
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
			/*
			//MINIATURAS
			dw_imagen.Object.datawindow.picture.File = ""
			if extension = ".psd" then
				filedelete(f_reemplazar(ruta_antigua+nombre,extension,".png"))
				ejecutable = "C:\Tencer_PB12\IM\psd2pngcmd.exe -c "+ruta_antigua+nombre+" "+ruta_antigua
				run(ejecutable,Minimized!)
			elseif extension = ".png" then
				//OJO No se crea miniatura. Se muestra el propio archivo
			elseif extension = ".tif" or extension = ".jpg" then
				filedelete(f_reemplazar(ruta_antigua+nombre,extension,".png"))
				ejecutable = 'c:\tencer_pb12\IM\convert.exe '+ruta_antigua+nombre+' -units PixelsPerInch -resize "1200x369>" '+f_reemplazar(ruta_antigua+nombre,extension,".png")
				run (ejecutable,Minimized!)
			end if
			*/
			//*****************************************************************************
			st_info.text = "Reemplazo de "+fichero_antiguo+" por "+filename+" correcto." 
		else
			ROLLBACK USING trans_ts;
			rtn = -1
		end if
	else
		//Error moviendo archivo
		MessageBox("Error", "No se ha podido crear una copia temporal del archivo a reemplazar. Por favor, avise al administrador.")
		ROLLBACK USING trans_ts;
		rtn = -1
	end if

	st_guardar.visible = false
	
	filas = dw_1.retrieve (codigo_empresa, tipo_maquina, padre_codigo) 
	if filas > 0 then
		dw_1.setrow(fila)
	end if	
end if
end event

type st_produccion from statictext within wtc_mant_archivos_disenyo_sistema_archivos
boolean visible = false
integer x = 859
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
string text = "Fichero en Producción"
boolean focusrectangle = false
end type

type cb_borrado_masivo from commandbutton within wtc_mant_archivos_disenyo_sistema_archivos
boolean visible = false
integer x = 3287
integer y = 1344
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
		dw_1.setrow(i)
		pb_borrar1.triggerevent(clicked!)
		dw_1.deleterow(i)
	end if
	i --
Loop

//f_guardar()
end event

type st_info from statictext within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 1746
integer y = 160
integer width = 3273
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

type dw_imagen from u_dw_imagen within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 41
integer y = 1520
integer width = 4800
integer height = 1476
integer taborder = 100
boolean border = true
end type

type pb_1 from picturebutton within wtc_mant_archivos_disenyo_sistema_archivos
integer x = 699
integer y = 1328
integer width = 146
integer height = 128
integer taborder = 100
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
		//res = GetFileSaveName ("Descargar Archivo", pathname, filename, "", "Fichero de Producción,*.*", ruta_destino, 2)
		pathname = ruta_destino
		res = GetFolder("Descargar Archivo", pathname)
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

