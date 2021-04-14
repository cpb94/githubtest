$PBExportHeader$wtc_mant_pieza_archivo.srw
forward
global type wtc_mant_pieza_archivo from wt_ventana_padre_grid
end type
type dw_imagen from u_dw_imagen within wtc_mant_pieza_archivo
end type
type st_guardar from statictext within wtc_mant_pieza_archivo
end type
type pb_descarga from picturebutton within wtc_mant_pieza_archivo
end type
type st_info from statictext within wtc_mant_pieza_archivo
end type
type pb_cargar_archivo from picturebutton within wtc_mant_pieza_archivo
end type
type p_seleccion from picture within wtc_mant_pieza_archivo
end type
type pb_1 from picturebutton within wtc_mant_pieza_archivo
end type
end forward

global type wtc_mant_pieza_archivo from wt_ventana_padre_grid
integer width = 5810
integer height = 2688
string title = " Mantenimiento de Archivos de la Pieza"
dw_imagen dw_imagen
st_guardar st_guardar
pb_descarga pb_descarga
st_info st_info
pb_cargar_archivo pb_cargar_archivo
p_seleccion p_seleccion
pb_1 pb_1
end type
global wtc_mant_pieza_archivo wtc_mant_pieza_archivo

type variables
string tamanyo_visualizacion
end variables

on wtc_mant_pieza_archivo.create
int iCurrent
call super::create
this.dw_imagen=create dw_imagen
this.st_guardar=create st_guardar
this.pb_descarga=create pb_descarga
this.st_info=create st_info
this.pb_cargar_archivo=create pb_cargar_archivo
this.p_seleccion=create p_seleccion
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagen
this.Control[iCurrent+2]=this.st_guardar
this.Control[iCurrent+3]=this.pb_descarga
this.Control[iCurrent+4]=this.st_info
this.Control[iCurrent+5]=this.pb_cargar_archivo
this.Control[iCurrent+6]=this.p_seleccion
this.Control[iCurrent+7]=this.pb_1
end on

on wtc_mant_pieza_archivo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_imagen)
destroy(this.st_guardar)
destroy(this.pb_descarga)
destroy(this.st_info)
destroy(this.pb_cargar_archivo)
destroy(this.p_seleccion)
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
//WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario 
//USING SQLCA;
//
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	pb_grabar.visible = false
//	pb_anyadir1.visible = false
//	pb_borrar1.visible = false
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
	where empresa = :codigo_empresa USING SQLCA;
	
	// Si recibo el codigo lo visualizo
	lstr_param = Message.PowerObjectParm
	
	nombre_ventana_invoca = lstr_param.s_titulo_ventana
	IF lstr_param.i_nargumentos >= 1 THEN
		if not isnull(lstr_param.s_argumentos[1]) and lstr_param.s_argumentos[1] <> "" then
			padre_codigo = lstr_param.s_argumentos[1]
			st_codigo.text = padre_codigo
			dw_1.retrieve (codigo_empresa, padre_codigo) 
		end if
	END IF
	
	dw_1.SetFocus()
	dw_1.SetRowFocusIndicator(p_seleccion)
	
	dw_1.title = 'Pieza ' + padre_codigo
	
	tamanyo_visualizacion = ""
	SELECT tamanyo 
	INTO :tamanyo_visualizacion 
	FROM archivo_resolucion 
	WHERE empresa = :codigo_empresa AND codigo = '2'
	USING SQLCA;
//end if
end event

event activate;call super::activate;if permiso_ventana = 1 then
	//Solo lectura
	pb_grabar.visible = false
	pb_anyadir1.visible = false
	pb_borrar1.visible = false
end if
end event

type st_codigo from wt_ventana_padre_grid`st_codigo within wtc_mant_pieza_archivo
boolean visible = false
integer x = 3429
integer y = 44
integer height = 76
alignment alignment = left!
end type

type pb_duplicar1 from wt_ventana_padre_grid`pb_duplicar1 within wtc_mant_pieza_archivo
boolean visible = false
integer x = 4407
integer y = 140
end type

type pb_borrar1 from wt_ventana_padre_grid`pb_borrar1 within wtc_mant_pieza_archivo
integer x = 192
integer y = 2376
end type

event pb_borrar1::clicked;string botones[2]
Int cambiar
str_ventana_alerta parametros

Long fila_actual
String ruta, ruta_archivos_exposicion, pieza, codigo
str_registro_sistema registro
String usuario_windows

String sel
Datastore tipos
Long j, numero_tipos

if dw_1.rowcount() <= 0 then
	Destroy tipos
	return
end if

fila_actual = dw_1.getrow()

pieza = dw_1.object.pieza[fila_actual]
codigo = dw_1.object.codigo[fila_actual]

parametros.titulo = "Atención Borrar Archivo"
parametros.subtitulo = "Borrar Archivo Pieza"
//parametros.mensaje = "Va a eliminar definitivamente el archivo "+trim(String(dw_1.object.fichero[fila_actual]))+" y no se podrá recuperar, ¿esta seguro?"
parametros.mensaje = "Va a eliminar definitivamente el archivo "+codigo+" y no se podrá recuperar, ¿esta seguro?"
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

dw_1.settransobject(trans_ts)
rtn = dw_1.update()

st_guardar.visible = true

SELECT ruta_archivos_exposicion INTO :ruta_archivos_exposicion FROM empresas WHERE empresa = :codigo_empresa using trans_ts;
if isnull(ruta_archivos_exposicion) then ruta_archivos_exposicion = ""

//Borrado del archivo
if rtn = 1 then
	ruta = ruta_archivos_exposicion + f_reemplazar(trim(String(dw_1.object.ruta[fila_actual])), ruta_archivos_exposicion,"") + trim(String(dw_1.object.fichero[fila_actual]))
	if FileDelete(ruta) then
		DELETE FROM modelo_pieza_archivo 
		WHERE empresa = :codigo_empresa AND pieza = :pieza AND codigo = :codigo USING trans_ts;
		
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText +" No se ha podido realizar el borrado en la base de datos: "+String(trans_ts.SQLDBCode))
			rtn = -1
		END IF
	else
		MessageBox("Error", "No se ha podido borrar el archivo del disco. Por favor, avise al administrador.")
		rtn = -1 
	end if
end if

if rtn = 1 then
	registro.usuario_windows = usuario_windows
	registro.trans = trans_ts
	registro.accion = "BORRAR"
	registro.tabla = "modelo_pieza_archivo"
	registro.clave = codigo_empresa + "#" + pieza + "#" + codigo
	registro.valor = ruta
	if not ftc_registrar_cambios(registro) then
		rtn = -1
	end if
end if

if rtn = 1 then
	COMMIT USING trans_ts;
	//**********************************************************************
	//PROCESO DE BORRADO DE IMÁGENES DE CADA TAMAÑO EXISTENTE
	sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
	f_cargar_cursor_transaccion (SQLCA,  tipos, sel)
	numero_tipos = tipos.RowCount()
	For j = 1 To numero_tipos
		ruta = ruta_archivos_exposicion + f_reemplazar(trim(String(dw_1.object.ruta[fila_actual])), ruta_archivos_exposicion, "") + tipos.object.tamanyo[j] + "\" + trim(String(dw_1.object.fichero[fila_actual]))
		FileDelete(ruta)
	Next
	Destroy tipos
	//**********************************************************************
	st_info.text = "Archivo "+codigo+" borrado correctamente." 
else
	ROLLBACK USING trans_ts;
	rtn = -1
end if

st_guardar.visible = false

dw_1.settransobject(sqlca)
if dw_1.retrieve (codigo_empresa, padre_codigo) > 0 then
	dw_1.EVENT rowfocuschanged(dw_1.getrow())
end if



end event

type pb_anyadir1 from wt_ventana_padre_grid`pb_anyadir1 within wtc_mant_pieza_archivo
integer x = 41
integer y = 2376
integer weight = 700
end type

event pb_anyadir1::clicked;call super::clicked;string ruta_mostrada, pathname, filename, usuario_windows
str_registro_sistema registro
Datetime fecha_modificacion
String max_codigo, nombre, extension, ruta_antigua_exposicion, ruta_archivos_exposicion, ruta_fichero, ruta_carpeta, ruta_carpeta_bd
Long filas

String sel
Datastore tipos
Long j, numero_tipos

//Tamaño archivo 
LongLong tamanyo, tamanyo_archivo = 30000000 //30 MB Aprox

rtn = 1

/*
ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)
SELECT ruta_area_trabajo INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa; 
usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
ruta_mostrada = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
*/
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
	rtn = GetFileOpenName ("Añadir Imagen a la pieza "+padre_codigo, pathname, filename, "jpg", "Imagen JPG,*.jpg", ruta_mostrada, 2)
	tamanyo = FileLength64 (pathname)
	if tamanyo > tamanyo_archivo then
		MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
		return
	end if
END IF

if rtn = 1 then
	dw_1.settransobject(trans_ts)
	rtn =	dw_1.update()
end if

if rtn = 1 then
	//GUARDAR EN BD
		
	st_guardar.visible = true
	
	SELECT ruta_archivos_exposicion, ruta_exposicion 
	INTO :ruta_archivos_exposicion, :ruta_antigua_exposicion 
	FROM empresas 
	WHERE empresa = :codigo_empresa
	USING SQLCA;
	
	ruta_carpeta = ruta_archivos_exposicion
	
	if ruta_antigua_exposicion = "" then
		ruta_carpeta_bd = ""
	else
		ruta_carpeta_bd = ruta_carpeta
	end if
	
	//OBTENCIÓN CÓDIGO NUEVO
	param_colisiones.empresa = codigo_empresa
	param_colisiones.tabla = "modelo_pieza_archivo"
	param_colisiones.campo = "codigo"
	param_colisiones.filtro = "modelo_pieza_archivo.pieza = '"+padre_codigo+"'"
	param_colisiones.buscar_huecos = false //No buscamos huecos para evitar problemas de colisiones con el DW propio
	
	
	//NOMBRE DEL ARCHIVO
	max_codigo = f_colisiones (trans_ts, param_colisiones)
	extension = mid(pathname, pos(pathname,"."))
	nombre = "P"+padre_codigo+"-"+max_codigo+extension
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
		rtn = FileCopy(pathname, ruta_fichero, true)
		if rtn = -1 then
			MessageBox("Error", "No se ha podido leer el archivo "+trim(String(pathname))+".")
		elseif rtn = -2 then
			MessageBox("Error", "No se ha podido crear el archivo "+trim(String(ruta_fichero))+".")
		end if
	end if
	
	if rtn = 1 then
		
		INSERT INTO modelo_pieza_archivo (empresa, pieza, codigo, ruta, fichero, activo, fecha_modificacion, tamanyo) 
		VALUES (:codigo_empresa, :padre_codigo, :max_codigo, :ruta_carpeta_bd, :nombre, 0, :fecha_modificacion, :tamanyo) 
		USING trans_ts;
		
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText +" Error inserción en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
			rtn = -1
		else
			registro.accion = "NUEVO"
			registro.usuario_windows = usuario_windows
			registro.trans = trans_ts
			registro.tabla = "modelo_pieza_archivo"
			registro.clave = codigo_empresa + "#" + padre_codigo + "#" + max_codigo
			registro.valor = "origen: " + pathname + " destino: " + ruta_fichero
			if not ftc_registrar_cambios(registro) then
				rtn = -1
			end if
		END IF
	end if

	if rtn = 1 then
		COMMIT USING trans_ts;
		st_info.text = "Archivo "+filename+" subido correctamente." 
		
		//**********************************************************************
		//PROCESO DE CREACIÓN DE IMÁGENES PARA CADA TAMAÑO NECESARIO
		sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
		f_cargar_cursor_trans (SQLCA,  sel,  tipos)
		numero_tipos = tipos.RowCount()
		For j = 1 To numero_tipos
			ftc_tranformar_imagen_IM (ruta_carpeta, ruta_carpeta + tipos.object.tamanyo[j] + "\" , nombre, tipos.object.resolucion[j], tipos.object.tamanyo[j], tipos.object.color[j])
			//resultado = ftc_tranformar_imagen_IM (ruta_exposicion, ruta_exposicion, ruta_archivo, "200x200", "4096x2160", "")				
		Next
		
		Destroy tipos
		//**********************************************************************
		
		//*****************************************************************************
		//BORRAMOS LA COPIA LOCAL DEL ARCHIVO SUBIDO
		if not Filedelete(pathname) then
			MessageBox("Atención", "No ha sido posible borrar su copia en espacio de trabajo del archivo. Por favor, borrela a mano.")
		end if
		//*****************************************************************************		
		
	else
		ROLLBACK USING trans_ts;
		rtn = -1
	end if

	st_guardar.visible = false
	
	dw_1.settransobject(sqlca)
	filas = dw_1.retrieve (codigo_empresa, padre_codigo) 
	if filas > 0 then
		dw_1.setrow(filas)
	end if
	
	st_guardar.visible = false
	dw_1.setfocus()	
else
	dw_1.settransobject(sqlca)
	MessageBox("Cancelado","No ha sido posible obtener la ruta del archivo indicado")
end if



end event

type pb_imprimir from wt_ventana_padre_grid`pb_imprimir within wtc_mant_pieza_archivo
boolean visible = false
integer x = 4571
integer y = 136
end type

type p_logo from wt_ventana_padre_grid`p_logo within wtc_mant_pieza_archivo
integer x = 5266
integer y = 20
end type

type dw_1 from wt_ventana_padre_grid`dw_1 within wtc_mant_pieza_archivo
integer y = 276
integer width = 859
integer height = 2244
boolean titlebar = true
string title = "Imágenes Piezas"
string dataobject = "dwtc_pieza_archivo"
boolean vscrollbar = true
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;string codigo_archivo, ruta, ruta_archivos_exposicion, fichero
int ruta_local

dw_imagen.visible = false

if currentrow <= 0 then
	return
end if

ruta_local = dw_1.object.ruta_local[currentrow]
if ruta_local = 1 then
	ruta = dw_1.object.ruta[currentrow]
	fichero = dw_1.object.fichero[currentrow]
	dw_imagen.Object.datawindow.picture.File = ruta + fichero
	dw_imagen.visible = true
else
	SELECT ruta_archivos_exposicion INTO :ruta_archivos_exposicion FROM empresas WHERE empresa = :codigo_empresa;
	if isnull(ruta_archivos_exposicion) then ruta_archivos_exposicion = ""
	ruta = ruta_archivos_exposicion + f_reemplazar(String(dw_1.object.ruta[currentrow]), ruta_archivos_exposicion, "")
	fichero = dw_1.object.fichero[currentrow]
	if not isnull(ruta) and ruta <> "" and not isnull(fichero) and fichero <> "" then
		
		if tamanyo_visualizacion = "" then
			SELECT tamanyo INTO :tamanyo_visualizacion FROM archivo_resolucion WHERE empresa = :codigo_empresa AND codigo = '2';
		end if
		
		ruta = ruta + tamanyo_visualizacion + "\"+fichero
		dw_imagen.Object.datawindow.picture.File = ruta
		dw_imagen.visible = true
	end if
end if
end event

event dw_1::retrieveend;call super::retrieveend;if rowcount > 0 then
	this.object.marcado[1] = 1 //marcamos siempre la primera imagen pues es la del modelo
end if
end event

type pb_salir from wt_ventana_padre_grid`pb_salir within wtc_mant_pieza_archivo
integer x = 5641
integer y = 124
end type

type pb_grabar from wt_ventana_padre_grid`pb_grabar within wtc_mant_pieza_archivo
end type

type st_titulo from wt_ventana_padre_grid`st_titulo within wtc_mant_pieza_archivo
end type

type pb_cancelar from wt_ventana_padre_grid`pb_cancelar within wtc_mant_pieza_archivo
boolean visible = false
integer x = 4736
integer y = 136
end type

type dw_imagen from u_dw_imagen within wtc_mant_pieza_archivo
integer x = 887
integer y = 280
integer width = 4896
integer height = 2240
integer taborder = 80
boolean border = true
end type

type st_guardar from statictext within wtc_mant_pieza_archivo
boolean visible = false
integer x = 206
integer y = 112
integer width = 571
integer height = 128
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

type pb_descarga from picturebutton within wtc_mant_pieza_archivo
integer x = 576
integer y = 2376
integer width = 146
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Download_24x24.png"
alignment htextalign = left!
string powertiptext = "Descargar Archivo"
end type

event clicked;Long i, res, fila
String ruta, ruta_por_defecto, ruta_destino, ruta_archivos_exposicion, pathname, filename, extension, fichero
ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)

fila = dw_1.getrow()
if fila > 0 then
	ruta_por_defecto = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
	//res = GetFileSaveName ("Indique un nombre para la descarga", pathname, filename, "jpg", "Imagenes jpg,*.jpg", ruta_por_defecto, 2)
	pathname = ruta_por_defecto
	res = GetFolder("Descargar Archivo", pathname)
	if res <> 1 then
		MessageBox("Error", "No ha sido posible guardar en la ruta indicada.")
		return
	end if
	
	SELECT ruta_archivos_exposicion INTO :ruta_archivos_exposicion FROM empresas WHERE empresa = :codigo_empresa USING SQLCA;
	if isnull(ruta_archivos_exposicion) then ruta_archivos_exposicion = ""
	ruta = ruta_archivos_exposicion + f_reemplazar(String(dw_1.object.ruta[fila]), ruta_archivos_exposicion, "")
	fichero = dw_1.object.fichero[fila]
	//res = FileCopy(ruta + fichero, pathname, true)
	res = FileCopy(ruta + fichero, pathname + "\" + fichero, true)
	
	//run("explorer "+pathname) //Muestra el archivo
end if
end event

type st_info from statictext within wtc_mant_pieza_archivo
integer x = 809
integer y = 168
integer width = 2619
integer height = 84
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

type pb_cargar_archivo from picturebutton within wtc_mant_pieza_archivo
integer x = 421
integer y = 2376
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
string picturename = "C:\Tencer_PB12\Upload_24x24.png"
alignment htextalign = left!
string powertiptext = "Reemplazar Archivo Seleccionado"
end type

event clicked;long fila, filas
string ruta_mostrada, pathname, filename, usuario_windows, ejecutable
str_registro_sistema registro
Datetime fecha_modificacion
String max_codigo, nombre, extension, extension_antigua, ruta_temporal, ruta_antigua_exposicion, ruta_archivos_exposicion, ruta_fichero, ruta_carpeta, ruta_carpeta_bd
Boolean copiado = false

//Tamaño archivo 
LongLong tamanyo_inicio, tamanyo_fin, tamanyo_archivo = 30000000 //30 MB Aprox

String codigo, ruta_antigua, fichero_antiguo
string botones[2]
Int cambiar
str_ventana_alerta parametros

String sel
Long j, numero_tipos
Datastore tipos

rtn = 1
fila = dw_1.getrow()

codigo = dw_1.object.codigo[fila]

SELECT ruta_archivos_exposicion, ruta_exposicion 
INTO :ruta_archivos_exposicion, :ruta_antigua_exposicion 
FROM empresas 
WHERE empresa = :codigo_empresa
USING SQLCA;

IF SQLCA.SQLCode <> 0 THEN         
	rtn = -1
ELSE
	ruta_carpeta = ruta_archivos_exposicion
	
	//Detección sistema nuevo o viejo
	if ruta_antigua_exposicion = "" then
		ruta_carpeta_bd = ""
	else
		ruta_carpeta_bd = ruta_carpeta
	end if
	
	ruta_antigua = ruta_archivos_exposicion + f_reemplazar(dw_1.object.ruta[fila], ruta_archivos_exposicion, "")
	fichero_antiguo = dw_1.object.fichero[fila]
	
	ContextKeyword lcxk_base
	this.GetContextService("Keyword", lcxk_base)
	
	SELECT ruta_area_trabajo 
	INTO :ruta_mostrada 
	FROM empresas 
	WHERE empresa = :codigo_empresa 
	USING SQLCA; 
	
	usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
	ruta_mostrada = ruta_mostrada + usuario_windows
	rtn = GetFileOpenName ("Modificar el fichero "+fichero_antiguo, pathname, filename, "jpg", "Imagen JPG,*.jpg", ruta_mostrada, 2)
	tamanyo_inicio = FileLength64 (pathname)
	if tamanyo_inicio > tamanyo_archivo then
		MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
		return
	end if
END IF

if rtn = 1 then
	dw_1.settransobject(trans_ts)
	dw_1.update()
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
			
			UPDATE modelo_pieza_archivo 
			SET ruta = :ruta_carpeta_bd, fichero = :nombre, fecha_modificacion = :fecha_modificacion, tamanyo = :tamanyo_fin 
			WHERE empresa = :codigo_empresa AND pieza = :padre_codigo AND codigo = :codigo 
			USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" Error actualización en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
				rtn = -1
			else
				registro.accion = "MODIFICAR"
				registro.usuario_windows = usuario_windows
				registro.trans = trans_ts
				registro.tabla = "modelo_pieza_archivo"
				registro.clave = codigo_empresa + "#" + padre_codigo + "#" + codigo
				registro.valor = "origen: "+ pathname + " destino: " + ruta_carpeta + nombre
				if not ftc_registrar_cambios(registro) then
					rtn = -1
				end if
			END IF
		end if
		if rtn = 1 then
		
			fileDelete(ruta_temporal)		
			
			COMMIT USING trans_ts;
			
			//-----------------------------------------------------------------------------
			//Borrado de Miniaturas y PROCESO DE CREACIÓN DE LAS NUEVAS IMÁGENES PARA CADA TAMAÑO NECESARIO
			sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
			f_cargar_cursor_transaccion (SQLCA, tipos,  sel)
			numero_tipos = tipos.RowCount()
			For j = 1 To numero_tipos
				fileDelete(ruta_antigua + tipos.object.tamanyo[j] + "\" + fichero_antiguo)
				ftc_tranformar_imagen_IM (ruta_carpeta, ruta_carpeta + tipos.object.tamanyo[j] + "\" , nombre, tipos.object.resolucion[j], tipos.object.tamanyo[j], tipos.object.color[j])			
			Next
			Destroy tipos
			//-----------------------------------------------------------------------------
			
			
			//-----------------------------------------------------------------------------
			//BORRAMOS LA COPIA LOCAL DEL ARCHIVO SUBIDO
			if copiado then
				if not Filedelete(pathname) then
					MessageBox("Atención", "No ha sido posible borrar su copia en espacio de trabajo del archivo. Por favor, borrela a mano.")
				end if
			end if
			//-----------------------------------------------------------------------------
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
	dw_1.settransobject(sqlca)	
	filas = dw_1.retrieve (codigo_empresa, padre_codigo) 
	if filas > 0 then
		dw_1.setrow(fila)
		dw_1.EVENT rowfocuschanged(fila)
	end if
else
	dw_1.settransobject(sqlca)	
	MessageBox("Cancelado","No ha sido posible obtener la ruta del archivo indicado")
end if



end event

type p_seleccion from picture within wtc_mant_pieza_archivo
boolean visible = false
integer x = 4274
integer y = 196
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Tencer_PB12\fila_seleccionada.png"
boolean focusrectangle = false
end type

type pb_1 from picturebutton within wtc_mant_pieza_archivo
integer x = 727
integer y = 2376
integer width = 146
integer height = 128
integer taborder = 80
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

event clicked;Long i, res, fila
String ruta, ruta_por_defecto, ruta_destino, ruta_archivos_exposicion, pathname, filename, extension
ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)

fila = dw_1.getrow()
if fila > 0 then
	ruta_por_defecto = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
	res = GetFileSaveName ("Indique un nombre para la descarga", pathname, filename, "jpg", "Imagenes jpg,*.jpg", ruta_por_defecto, 2)
	if res <> 1 then
		MessageBox("Error", "No ha sido posible guardar en la ruta indicada.")
		return
	end if
	
	SELECT ruta_archivos_exposicion INTO :ruta_archivos_exposicion FROM empresas WHERE empresa = :codigo_empresa;
	if isnull(ruta_archivos_exposicion) then ruta_archivos_exposicion = ""
	ruta = ruta_archivos_exposicion + f_reemplazar(String(dw_1.object.ruta[fila]), ruta_archivos_exposicion, "")
	ruta = ruta + dw_1.object.fichero[fila]
	res = FileCopy(ruta, pathname, true)
	
	run("explorer "+pathname) //Muestra el archivo
end if
end event

