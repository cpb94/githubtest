$PBExportHeader$wtc_mant_articulos_imagen_encajado.srw
forward
global type wtc_mant_articulos_imagen_encajado from wt_ventana_padre_grid
end type
type dw_imagen from u_dw_imagen within wtc_mant_articulos_imagen_encajado
end type
type st_guardar from statictext within wtc_mant_articulos_imagen_encajado
end type
type pb_descarga from picturebutton within wtc_mant_articulos_imagen_encajado
end type
type st_info from statictext within wtc_mant_articulos_imagen_encajado
end type
type pb_cargar_archivo from picturebutton within wtc_mant_articulos_imagen_encajado
end type
type p_seleccion from picture within wtc_mant_articulos_imagen_encajado
end type
type dw_imagenes from datawindow within wtc_mant_articulos_imagen_encajado
end type
end forward

global type wtc_mant_articulos_imagen_encajado from wt_ventana_padre_grid
integer width = 5609
integer height = 2688
string title = " Mantenimiento de Imágenes de Artículos"
dw_imagen dw_imagen
st_guardar st_guardar
pb_descarga pb_descarga
st_info st_info
pb_cargar_archivo pb_cargar_archivo
p_seleccion p_seleccion
dw_imagenes dw_imagenes
end type
global wtc_mant_articulos_imagen_encajado wtc_mant_articulos_imagen_encajado

type variables
string tamanyo_visualizacion
Int modo_dw_imagenes
end variables

on wtc_mant_articulos_imagen_encajado.create
int iCurrent
call super::create
this.dw_imagen=create dw_imagen
this.st_guardar=create st_guardar
this.pb_descarga=create pb_descarga
this.st_info=create st_info
this.pb_cargar_archivo=create pb_cargar_archivo
this.p_seleccion=create p_seleccion
this.dw_imagenes=create dw_imagenes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagen
this.Control[iCurrent+2]=this.st_guardar
this.Control[iCurrent+3]=this.pb_descarga
this.Control[iCurrent+4]=this.st_info
this.Control[iCurrent+5]=this.pb_cargar_archivo
this.Control[iCurrent+6]=this.p_seleccion
this.Control[iCurrent+7]=this.dw_imagenes
end on

on wtc_mant_articulos_imagen_encajado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_imagen)
destroy(this.st_guardar)
destroy(this.pb_descarga)
destroy(this.st_info)
destroy(this.pb_cargar_archivo)
destroy(this.p_seleccion)
destroy(this.dw_imagenes)
end on

event open;str_parametros lstr_param

cerrar_sin_abrir = false

dw_1.SetTransObject(SQLCA)

////PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//
//SELECT P.permiso 
//INTO :permiso_ventana 
//FROM uti_permisos_ventana P 
//INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa 
//WHERE P.empresa = :codigo_empresa 
//	AND V.nombre = :nombre_ventana 
//	AND P.usuario = :nombre_usuario 
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
	
	select nombre
	into :st_titulo.text
	from empresas
	where empresa = :codigo_empresa 
	USING SQLCA;
	
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
	
	dw_1.title = 'Artículo ' + padre_codigo
	
	tamanyo_visualizacion = ""
	SELECT tamanyo 
	INTO :tamanyo_visualizacion 
	FROM archivo_resolucion 
	WHERE empresa = :codigo_empresa 
		AND codigo = '2' 
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

type st_codigo from wt_ventana_padre_grid`st_codigo within wtc_mant_articulos_imagen_encajado
boolean visible = false
integer x = 3429
integer y = 44
integer height = 76
alignment alignment = left!
end type

type pb_duplicar1 from wt_ventana_padre_grid`pb_duplicar1 within wtc_mant_articulos_imagen_encajado
boolean visible = false
integer x = 4407
integer y = 140
end type

type pb_borrar1 from wt_ventana_padre_grid`pb_borrar1 within wtc_mant_articulos_imagen_encajado
integer x = 192
integer y = 2376
integer weight = 700
end type

event pb_borrar1::clicked;string botones[2]
Int cambiar
str_ventana_alerta parametros

Long fila_actual, produccion
String ruta, ruta_aux, ruta_archivos_exposicion, articulo, codigo, modelo_imagen, pieza_imagen, uso
str_registro_sistema registro
String usuario_windows
String modelo_viejo, modelo_nuevo

String sel
Datastore tipos
Long j, numero_tipos

if dw_1.rowcount() <= 0 then
	Destroy tipos
	return
end if

fila_actual = dw_1.getrow()

articulo = dw_1.object.articulo[fila_actual]
codigo = dw_1.object.codigo[fila_actual]
modelo_imagen = dw_1.object.modelo[fila_actual]
pieza_imagen = dw_1.object.pieza[fila_actual]
produccion = dw_1.object.produccion[fila_actual]

if produccion = 1 then 
	SELECT referencia_laboratorio, modelo_origen, uso INTO :modelo_viejo, :modelo_nuevo, :uso FROM articulos WHERE empresa = :codigo_empresa AND codigo = :articulo using sqlca;
	if not isnull(modelo_nuevo) and modelo_nuevo <>"" and uso = "3" then
		MessageBox("Atención", "No puede borrar la imagen que se muestra por defecto en la ficha de producción.")
		return
	end if
end if

ContextKeyword lcxk_base
This.GetContextService("Keyword", lcxk_base)
usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))

dw_1.accepttext()
rtn = 1
st_info.text = "" 

st_guardar.visible = true
pb_grabar.triggerevent(clicked!)



SELECT ruta_archivos_exposicion INTO :ruta_archivos_exposicion FROM empresas WHERE empresa = :codigo_empresa using sqlca;
if isnull(ruta_archivos_exposicion) then ruta_archivos_exposicion = ""

//Si el archivo es asociado (solo hay que borrar asociación, no las imágenes)
DELETE FROM articulos_imagen_encajado 
WHERE empresa = :codigo_empresa AND articulo = :articulo AND codigo = :codigo USING trans_ts;

IF trans_ts.SQLCode <> 0 THEN         
	MessageBox("SQL error", trans_ts.SQLErrText +" No se ha podido realizar el borrado en la base de datos: "+String(trans_ts.SQLDBCode))
	rtn = -1
END IF

if isnull(modelo_imagen) or modelo_imagen = "" then
	if rtn = 1 then
		//Archivo subido de encajado
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
			ROLLBACK USING trans_ts;
			return	
		end if
	end if
	
	if rtn = 1 then
		ruta = ruta_archivos_exposicion + f_reemplazar(trim(String(dw_1.object.ruta[fila_actual])), ruta_archivos_exposicion,"") + trim(String(dw_1.object.fichero[fila_actual]))
		if not FileDelete(ruta) then
			MessageBox("Error", "No se ha podido borrar el archivo del disco. Por favor, avise al administrador.")
			rtn = -1 
		end if
	end if
	
	if rtn = 1 then
		//------------------------------------------------------------------------------
		//PROCESO DE BORRADO DE IMÁGENES DE CADA TAMAÑO EXISTENTE
		sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
		f_cargar_cursor_transaccion (SQLCA, tipos,  sel)
		numero_tipos = tipos.RowCount()
		For j = 1 To numero_tipos
			ruta_aux = ruta_archivos_exposicion + f_reemplazar(trim(String(dw_1.object.ruta[fila_actual])), ruta_archivos_exposicion, "") + tipos.object.tamanyo[j] + "\" + trim(String(dw_1.object.fichero[fila_actual]))
			FileDelete(ruta_aux)
		Next
		Destroy tipos
		//------------------------------------------------------------------------------
	end if
	
else
	//Si el archivo es asociado (solo hay que borrar asociación, no las imágenes)
	//Ponemos en la ruta la imagen y pieza de referencia para el registro de sistema
	ruta = "modelo: " + modelo_imagen + " pieza: " + pieza_imagen
end if

if rtn = 1 then
	registro.usuario_windows = usuario_windows
	registro.trans = trans_ts
	registro.accion = "BORRAR"
	registro.tabla = "articulos_imagen_encajado"
	registro.clave = codigo_empresa + "#" + articulo + "#" + codigo
	registro.valor = ruta
	if not ftc_registrar_cambios(registro) then
		rtn = -1
	end if
end if

if rtn = 1 then
	COMMIT USING trans_ts;
	st_info.text = "Archivo "+codigo+" borrado correctamente." 
else
	ROLLBACK USING trans_ts;
	rtn = -1
end if

st_guardar.visible = false

if dw_1.retrieve (codigo_empresa, padre_codigo) > 0 then
	dw_1.EVENT rowfocuschanged(dw_1.getrow())
end if



end event

type pb_anyadir1 from wt_ventana_padre_grid`pb_anyadir1 within wtc_mant_articulos_imagen_encajado
integer x = 41
integer y = 2376
integer weight = 700
end type

event pb_anyadir1::clicked;call super::clicked;string ruta_mostrada, pathname, filename, usuario_windows
str_registro_sistema registro
Datetime fecha_modificacion
String max_codigo, nombre, extension, ruta_archivos_exposicion, ruta_fichero, ruta_carpeta, ruta_carpeta_bd
Long imagen_produccion, filas

String sel
Datastore tipos
Long j, numero_tipos

string botones[3]
Int tipo_imagen
str_ventana_alerta parametros

//Tamaño archivo 
LongLong tamanyo_archivo = 5000000 //5 MB Aprox

rtn = 1
st_info.text = "" 

parametros.titulo = "Tipo de Imagen"
parametros.subtitulo = "Seleccione Tipo Imagen"
parametros.mensaje = "¿Qué tipo de imagen desea subir?"
parametros.tipo = 3
botones[1] = "Modelo o Pieza"
botones[2] = "Nueva"
botones[3] = "Cancelar"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
tipo_imagen = Int(Message.DoubleParm)

if tipo_imagen = 2 then 

	ContextKeyword lcxk_base
	this.GetContextService("Keyword", lcxk_base)
	
	SELECT ruta_area_trabajo 
	INTO :ruta_mostrada 
	FROM empresas 
	WHERE empresa = :codigo_empresa 
	USING SQLCA; 
	
	usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
	ruta_mostrada = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
	
	rtn = GetFileOpenName ("Añadir Imagen de Encajado "+padre_codigo, pathname, filename, "jpg", "Imagen JPG,*.jpg", ruta_mostrada, 2)
	if FileLength64 (pathname) > tamanyo_archivo then
		MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
		return
	end if
	
	if rtn = 1 then
		dw_1.settransobject (trans_ts)
		rtn = dw_1.update()
	end if
	
	if rtn = 1 then
		//GUARDAR EN BD
		st_guardar.visible = true
		
		SELECT ruta_archivos_exposicion 
		INTO :ruta_archivos_exposicion 
		FROM empresas 
		WHERE empresa = :codigo_empresa 
		using trans_ts;
		
		ruta_carpeta_bd = "ARTICULOS\A" + padre_codigo + "\" 
		ruta_carpeta = ruta_archivos_exposicion + ruta_carpeta_bd
		
		//OBTENCIÓN CÓDIGO NUEVO
		param_colisiones.empresa = codigo_empresa
		param_colisiones.tabla = "articulos_imagen_encajado"
		param_colisiones.campo = "codigo"
		param_colisiones.filtro = "articulos_imagen_encajado.articulo = '"+padre_codigo+"'"
		param_colisiones.buscar_huecos = false //No buscamos huecos para evitar problemas de colisiones con el DW propio
		
	
		//NOMBRE DEL ARCHIVO
		max_codigo = f_colisiones (trans_ts, param_colisiones)
		extension = mid(pathname, pos(pathname,"."))
		nombre = "A" + padre_codigo + "-" + max_codigo + extension
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
			if max_codigo = "1" then
				imagen_produccion = 1
			else
				imagen_produccion = 0
			end if
			INSERT INTO articulos_imagen_encajado (empresa, articulo, codigo, modelo, pieza, ruta, fichero, produccion, fecha_modificacion) 
			VALUES (:codigo_empresa, :padre_codigo, :max_codigo, NULL, NULL, :ruta_carpeta_bd, :nombre, :imagen_produccion, :fecha_modificacion) 
			USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" Error inserción en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
				rtn = -1
			else
				registro.accion = "NUEVO"
				registro.usuario_windows = usuario_windows
				registro.trans = trans_ts
				registro.tabla = "articulos_imagen_encajado"
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
			f_cargar_cursor_transaccion (SQLCA,  tipos,  sel)
			numero_tipos = tipos.RowCount()
			For j = 1 To numero_tipos
				if not FileExists(ruta_carpeta + tipos.object.tamanyo[j] + "\" ) then
					if CreateDirectory(ruta_carpeta + tipos.object.tamanyo[j] + "\" ) <> 1 then
						
					end if
				end if
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
		dw_1.settransobject (SQLCA)		
		filas = dw_1.retrieve (codigo_empresa, padre_codigo) 
		if filas > 0 then
			dw_1.setrow(filas)
		end if
		
		st_guardar.visible = false
		dw_1.setfocus()	
	else
		dw_1.settransobject (SQLCA)		
		MessageBox("Cancelado","No ha sido posible obtener la ruta del archivo indicado")
	end if
elseif tipo_imagen = 1 then 
	modo_dw_imagenes = 1 //Insercion
	dw_imagenes.visible = true
	pb_anyadir1.enabled = false
	pb_borrar1.enabled = false
	pb_cargar_archivo.enabled = false
	pb_descarga.enabled = false
	dw_imagenes.settransobject(SQLCA)
	dw_imagenes.retrieve(codigo_empresa, padre_codigo)
	dw_1.settransobject (SQLCA)
else
	//Cancelado	
end if



end event

type pb_imprimir from wt_ventana_padre_grid`pb_imprimir within wtc_mant_articulos_imagen_encajado
boolean visible = false
integer x = 4571
integer y = 136
end type

type p_logo from wt_ventana_padre_grid`p_logo within wtc_mant_articulos_imagen_encajado
integer x = 5070
integer y = 28
end type

type dw_1 from wt_ventana_padre_grid`dw_1 within wtc_mant_articulos_imagen_encajado
integer y = 276
integer width = 713
integer height = 2244
boolean titlebar = true
string title = "Imágenes Artículos"
string dataobject = "dwtc_articulos_imagen_encajado"
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
	SELECT ruta_archivos_exposicion 
	INTO :ruta_archivos_exposicion 
	FROM empresas WHERE empresa = :codigo_empresa USING SQLCA;
	
	if isnull(ruta_archivos_exposicion) then ruta_archivos_exposicion = ""
	ruta = ruta_archivos_exposicion + f_reemplazar(String(dw_1.object.ruta[currentrow]), ruta_archivos_exposicion, "")
	fichero = dw_1.object.fichero[currentrow]
	if not isnull(ruta) and ruta <> "" and not isnull(fichero) and fichero <> "" then
		
		if tamanyo_visualizacion = "" then
			SELECT tamanyo INTO :tamanyo_visualizacion FROM archivo_resolucion WHERE empresa = :codigo_empresa AND codigo = '2' USING SQLCA;
		end if
		
		ruta = ruta + tamanyo_visualizacion + "\"+fichero
		dw_imagen.Object.datawindow.picture.File = ruta
		dw_imagen.visible = true
	end if
end if
end event

event dw_1::itemchanged;call super::itemchanged;Long i, cambio, contador
if row > 0 then
	if dwo.name = "produccion" then
		//Solo puede haber una marcada como produccion y debe haber al menos una marcada como producción
		this.accepttext()
		if data = "1" then
			cambio = 0
		else
			cambio = 1
		end if
		
		For i = 1 To this.rowcount()
			if row <> i then
				if cambio = 0 then
					this.object.produccion[i] = cambio
				else
					if this.object.produccion[i] = cambio then
						contador ++
					else
						//Si solo hay dos elementos el cambio es automático
						if this.rowcount() = 2 then
							this.object.produccion[i] = cambio
							contador ++
						end if
					end if
				end if
			end if
		Next
		
		if cambio = 1 and contador = 0 then
			MessageBox("Atención", "Debe existir al menos 1 como principal")
			dwo.Primary[row] = 1
			return 2
		end if	
	end if	
end if
end event

type pb_salir from wt_ventana_padre_grid`pb_salir within wtc_mant_articulos_imagen_encajado
integer x = 5435
integer y = 136
end type

type pb_grabar from wt_ventana_padre_grid`pb_grabar within wtc_mant_articulos_imagen_encajado
end type

event pb_grabar::clicked;call super::clicked;st_info.text = "" 
dw_imagenes.visible = false
pb_anyadir1.enabled = true
pb_borrar1.enabled = true
pb_cargar_archivo.enabled = true
pb_descarga.enabled = true
end event

type st_titulo from wt_ventana_padre_grid`st_titulo within wtc_mant_articulos_imagen_encajado
end type

type pb_cancelar from wt_ventana_padre_grid`pb_cancelar within wtc_mant_articulos_imagen_encajado
boolean visible = false
integer x = 4736
integer y = 136
end type

type dw_imagen from u_dw_imagen within wtc_mant_articulos_imagen_encajado
integer x = 745
integer y = 280
integer width = 4832
integer height = 2240
integer taborder = 80
boolean border = true
end type

type st_guardar from statictext within wtc_mant_articulos_imagen_encajado
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

type pb_descarga from picturebutton within wtc_mant_articulos_imagen_encajado
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
string powertiptext = "Descargar Alta Resolución"
end type

event clicked;Long i, res, fila
String ruta, ruta_por_defecto, ruta_destino, ruta_archivos_exposicion, pathname, filename, extension
ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)

st_info.text = "" 
fila = dw_1.getrow()
if fila > 0 then
	ruta_por_defecto = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
	res = GetFileSaveName ("Indique un nombre para la descarga", pathname, filename, "jpg", "Imagenes jpg,*.jpg", ruta_por_defecto, 2)
	if res <> 1 then
		MessageBox("Error", "No ha sido posible guardar en la ruta indicada.")
		return
	end if
	
	SELECT ruta_archivos_exposicion 
	INTO :ruta_archivos_exposicion 
	FROM empresas 
	WHERE empresa = :codigo_empresa
	USING SQLCA;
	
	if isnull(ruta_archivos_exposicion) then ruta_archivos_exposicion = ""
	ruta = ruta_archivos_exposicion + f_reemplazar(String(dw_1.object.ruta[fila]), ruta_archivos_exposicion, "")
	ruta = ruta + dw_1.object.fichero[fila]
	res = FileCopy(ruta, pathname, true)
	
	run("explorer "+pathname) //Muestra el archivo
end if
end event

type st_info from statictext within wtc_mant_articulos_imagen_encajado
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

type pb_cargar_archivo from picturebutton within wtc_mant_articulos_imagen_encajado
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
String max_codigo, nombre, extension, extension_antigua, ruta_temporal, ruta_archivos_exposicion, ruta_fichero, ruta_carpeta, ruta_carpeta_bd

//Tamaño archivo 
LongLong tamanyo_inicio, tamanyo_fin, tamanyo_archivo = 5000000 //5 MB Aprox

String codigo, modelo_imagen, pieza_imagen, ruta_antigua, fichero_antiguo
string botones[3]
Int tipo_imagen
str_ventana_alerta parametros

String sel
Long j, numero_tipos
Datastore tipos

rtn = 1
st_info.text = "" 
fila = dw_1.getrow()

codigo = dw_1.object.codigo[fila]

SELECT ruta_archivos_exposicion 
INTO :ruta_archivos_exposicion 
FROM empresas 
WHERE empresa = :codigo_empresa
USING SQLCA;

ruta_carpeta_bd = "ARTICULOS\A" + padre_codigo + "\"
ruta_carpeta = ruta_archivos_exposicion + ruta_carpeta_bd

ruta_antigua = ruta_archivos_exposicion + dw_1.object.ruta[fila]
fichero_antiguo = dw_1.object.fichero[fila]
modelo_imagen = dw_1.object.modelo[fila]
pieza_imagen = dw_1.object.pieza[fila]

parametros.titulo = "Tipo de Imagen"
parametros.subtitulo = "Seleccione Tipo Imagen"
parametros.mensaje = "¿Qué tipo de imagen desea subir?"
parametros.tipo = 3
botones[1] = "Modelo o Pieza"
botones[2] = "Nueva"
botones[3] = "Cancelar"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
tipo_imagen = Int(Message.DoubleParm)

if tipo_imagen = 2 then 

	ContextKeyword lcxk_base
	this.GetContextService("Keyword", lcxk_base)
	
	SELECT ruta_area_trabajo 
	INTO :ruta_mostrada 
	FROM empresas 
	WHERE empresa = :codigo_empresa
	USING SQLCA; 
	
	usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
	ruta_mostrada = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
	
	rtn = GetFileOpenName ("Añadir Imagen de Artículo "+padre_codigo, pathname, filename, "jpg", "Imagen JPG,*.jpg", ruta_mostrada, 2)
	tamanyo_inicio = FileLength64 (pathname)
	if tamanyo_inicio > tamanyo_archivo then
		MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
		return
	end if
	
	if rtn = 1 then
		//GUARDAR EN BD
		
		pb_grabar.triggerevent(clicked!)
		
		st_guardar.visible = true
		
		extension = mid(filename, pos(filename,"."))
		fecha_modificacion = datetime(today(), now())
		
		if isnull(modelo_imagen) or modelo_imagen = "" then
			//Solo movemos el archivo si el aterior era de tipo  "Nuevo"
			ruta_temporal = ruta_antigua + "old_" + String(Today(), "dd_mm_yy") + "_" + String(Now(), "hh_mm_ss") + "_" + fichero_antiguo
			//rtn = FileMove(ruta_antigua + fichero_antiguo, ruta_temporal)
			FileMove(ruta_antigua + fichero_antiguo, ruta_temporal)
			//El nombre del archivo será el mismo que antes
			nombre = mid(fichero_antiguo, 1 , pos(fichero_antiguo,".") - 1) + extension
		else
			//Hay que asignar un nuevo nombre de archivo, porque anteriormente había una imagen de modelo o pieza
			nombre = "A" + padre_codigo + "-" + codigo + extension
		end if
		
		if rtn = 1 then
			
			if not FileExists(ruta_carpeta) then
				if CreateDirectory(ruta_carpeta) <> 1 then
					MessageBox("Error", "No se ha podido crear el directorio en el servidor. Por favor, avise al administrador.")
					rtn = -1
				end if
			end if
			
			rtn = FileCopy(pathname, ruta_carpeta + nombre, true)
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
				
				UPDATE articulos_imagen_encajado 
				SET modelo = NULL, pieza = NULL, ruta = :ruta_carpeta_bd, fichero = :nombre, fecha_modificacion = :fecha_modificacion 
				WHERE empresa = :codigo_empresa AND articulo = :padre_codigo AND codigo = :codigo 
				USING trans_ts;
				
				IF trans_ts.SQLCode <> 0 THEN         
					MessageBox("SQL error", trans_ts.SQLErrText +" Error actualización en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
					rtn = -1
				else
					registro.accion = "MODIFICAR"
					registro.usuario_windows = usuario_windows
					registro.trans = trans_ts
					registro.tabla = "articulos_imagen_encajado"
					registro.clave = codigo_empresa + "#" + padre_codigo + "#" + codigo
					registro.valor = "antigua: " + ruta_antigua + fichero_antiguo + " nueva: " + ruta_carpeta + nombre
					if not ftc_registrar_cambios(registro) then
						rtn = -1
					end if
				END IF
			end if
			if rtn = 1 then
				if isnull(modelo_imagen) or modelo_imagen = "" then
					//Borramos el archivo anterior si era de tipo nuevo, así como sus miniaturas
					fileDelete(ruta_temporal)	
					//-----------------------------------------------------------------------------
					//Borrado de Miniaturas y PROCESO DE CREACIÓN DE LAS NUEVAS IMÁGENES PARA CADA TAMAÑO NECESARIO
					sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
					f_cargar_cursor_transaccion (trans_ts, tipos,  sel)
					numero_tipos = tipos.RowCount()
					For j = 1 To numero_tipos
						fileDelete(ruta_antigua + tipos.object.tamanyo[j] + "\" + fichero_antiguo)
						CreateDirectory(ruta_carpeta + tipos.object.tamanyo[j] + "\")
						ftc_tranformar_imagen_IM (ruta_carpeta, ruta_carpeta + tipos.object.tamanyo[j] + "\" , nombre, tipos.object.resolucion[j], tipos.object.tamanyo[j], tipos.object.color[j])			
					Next
					Destroy tipos
					//-----------------------------------------------------------------------------
				else
					//-----------------------------------------------------------------------------
					//PROCESO DE CREACIÓN DE LAS NUEVAS IMÁGENES PARA CADA TAMAÑO NECESARIO
					sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
					f_cargar_cursor_trans (trans_ts,  sel,  tipos)
					numero_tipos = tipos.RowCount()
					For j = 1 To numero_tipos
						CreateDirectory(ruta_carpeta + tipos.object.tamanyo[j] + "\")
						ftc_tranformar_imagen_IM (ruta_carpeta, ruta_carpeta + tipos.object.tamanyo[j] + "\" , nombre, tipos.object.resolucion[j], tipos.object.tamanyo[j], tipos.object.color[j])			
					Next
					Destroy tipos
					//-----------------------------------------------------------------------------
				end if
				
				COMMIT USING trans_ts;
				
				//-----------------------------------------------------------------------------
				//BORRAMOS LA COPIA LOCAL DEL ARCHIVO SUBIDO
				if not Filedelete(pathname) then
					MessageBox("Atención", "No ha sido posible borrar su copia del archivo. Por favor, borrela a mano.")
				end if
				//-----------------------------------------------------------------------------
				st_info.text = "Reemplazo de "+fichero_antiguo+" por "+filename+" correcto." 
			else
				ROLLBACK USING trans_ts;
				if not isnull(modelo_imagen) and modelo_imagen = "" then
					//en caso de error de reemplazo en archivos de tipo nuevo, reemplazamos la copia temporal
					FileMove(ruta_temporal, ruta_antigua + fichero_antiguo)
				end if
				rtn = -1
			end if
		else
			ROLLBACK USING trans_ts;
			rtn = -1
		end if
	
		
		st_guardar.visible = false
		
		filas = dw_1.retrieve (codigo_empresa, padre_codigo) 
		if filas > 0 then
			dw_1.setrow(fila)
			dw_1.EVENT rowfocuschanged(fila)
		end if
	else
		MessageBox("Cancelado","No ha sido posible obtener la ruta del archivo indicado")
	end if

elseif tipo_imagen = 1 then
	
	dw_imagenes.visible = true
	pb_anyadir1.enabled = false
	pb_borrar1.enabled = false
	pb_cargar_archivo.enabled = false
	pb_descarga.enabled = false
	dw_imagenes.settransobject(SQLCA)
	dw_imagenes.retrieve(codigo_empresa, padre_codigo)
	modo_dw_imagenes = 2 //Reemplazo
else
	//Cancelado	
	
end if
end event

type p_seleccion from picture within wtc_mant_articulos_imagen_encajado
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

type dw_imagenes from datawindow within wtc_mant_articulos_imagen_encajado
boolean visible = false
integer x = 745
integer y = 272
integer width = 1545
integer height = 2248
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_articulos_imagen_encajado"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;if dwo.name = "cancelar" then
	dw_imagenes.visible = false
	pb_anyadir1.enabled = true
	pb_borrar1.enabled = true
	pb_cargar_archivo.enabled = true
	pb_descarga.enabled = true
end if
end event

event clicked;Datetime fecha_modificacion
String codigo, modelo_imagen, modelo_imagen_antiguo, pieza_imagen, pieza_imagen_antiguo, max_codigo 
String ruta_archivos_exposicion, ruta_fichero, ruta_antigua, ruta_carpeta, ruta_carpeta_bd, nombre, fichero_antiguo, usuario_windows
Long imagen_produccion, filas, fila
String sel
Long numero_tipos, j
Datastore tipos
str_registro_sistema registro
ContextKeyword lcxk_base

rtn = 1

if row > 0 then
	if dwo.name <> "cancelar" then
		fecha_modificacion = datetime(today(), now())
		modelo_imagen = this.object.modelo[row]
		pieza_imagen = this.object.pieza[row]
		ruta_fichero = this.object.ruta_imagen[row]
		ruta_carpeta_bd = this.object.ruta[row]
		nombre = this.object.fichero[row]
		
		if modo_dw_imagenes = 1 then //Insercion
			
			//OBTENCIÓN CÓDIGO NUEVO
			param_colisiones.empresa = codigo_empresa
			param_colisiones.tabla = "articulos_imagen_encajado"
			param_colisiones.campo = "codigo"
			param_colisiones.filtro = "articulos_imagen_encajado.articulo = '"+padre_codigo+"'"
			param_colisiones.buscar_huecos = false //No buscamos huecos para evitar problemas de colisiones con el DW propio
			
			ftc_crear_transaccion(trans_ts ,param_transaccion)	
			CONNECT USING trans_ts;
			
			max_codigo = f_colisiones (trans_ts, param_colisiones)
			
			if max_codigo = "1" then
				imagen_produccion = 1
			else
				imagen_produccion = 0
			end if
			
			INSERT INTO articulos_imagen_encajado (empresa, articulo, codigo, modelo, pieza, ruta, fichero, produccion, fecha_modificacion) 
			VALUES (:codigo_empresa, :padre_codigo, :max_codigo, :modelo_imagen, :pieza_imagen, :ruta_carpeta_bd, :nombre, :imagen_produccion, :fecha_modificacion) USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" Error inserción en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
				rtn = -1
			else
				
				this.GetContextService("Keyword", lcxk_base)
				usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
				
				registro.accion = "NUEVO"
				registro.usuario_windows = usuario_windows
				registro.trans = trans_ts
				registro.tabla = "articulos_imagen_encajado"
				registro.clave = codigo_empresa + "#" + padre_codigo + "#" + max_codigo
				registro.valor = "Modelo / Pieza origen: " + modelo_imagen + "-" + pieza_imagen + " ruta: " + ruta_fichero
				if not ftc_registrar_cambios(registro) then
					rtn = -1
				end if
			END IF
			
			if rtn = 1 then
				COMMIT USING trans_ts;
				st_info.text = "Imagen asociada correctamente." 
				
			else
				ROLLBACK USING trans_ts;
				rtn = -1
			end if
			
			filas = dw_1.retrieve (codigo_empresa, padre_codigo) 
			if filas > 0 then
				dw_1.setrow(filas)
			end if
			dw_1.setfocus()	
			
		elseif modo_dw_imagenes = 2 then //Reemplazar
			//Valores antiguos
			fila = dw_1.getrow()
			codigo = dw_1.object.codigo[fila]

			SELECT ruta_archivos_exposicion INTO :ruta_archivos_exposicion FROM empresas WHERE empresa = :codigo_empresa;
			//ruta_carpeta_bd = "ARTICULOS\A" + padre_codigo + "\"
			ruta_carpeta = ruta_archivos_exposicion + ruta_carpeta_bd
			
			ruta_antigua = ruta_archivos_exposicion + dw_1.object.ruta[fila]
			fichero_antiguo = dw_1.object.fichero[fila]
			modelo_imagen_antiguo = dw_1.object.modelo[fila]
			pieza_imagen_antiguo = dw_1.object.pieza[fila]
			
			UPDATE articulos_imagen_encajado 
			SET modelo = :modelo_imagen, pieza = :pieza_imagen, ruta = :ruta_carpeta_bd, fichero = :nombre, fecha_modificacion = :fecha_modificacion
			WHERE empresa = :codigo_empresa AND articulo = :padre_codigo AND codigo = :codigo
			USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" Error actualización en base de datos: "+String(trans_ts.SQLDBCode))
				rtn = -1
			else
				this.GetContextService("Keyword", lcxk_base)
				usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
				
				registro.accion = "MODIFICAR"
				registro.usuario_windows = usuario_windows
				registro.trans = trans_ts
				registro.tabla = "articulos_imagen_encajado"
				registro.clave = codigo_empresa + "#" + padre_codigo + "#" + codigo
				registro.valor = "antigua: " + ruta_antigua + fichero_antiguo + " nueva: " + ruta_carpeta + nombre
				if not ftc_registrar_cambios(registro) then
					rtn = -1
				end if
			END IF
			
			if rtn = 1 then
				COMMIT USING trans_ts;
				//Hay que borrar la imagen anterior si era del tipo nueva
				if isnull(modelo_imagen_antiguo) or modelo_imagen_antiguo = "" then 
					fileDelete(ruta_antigua + fichero_antiguo)	
					//-----------------------------------------------------------------------------
					//Borrado de Miniaturas y PROCESO DE CREACIÓN DE LAS NUEVAS IMÁGENES PARA CADA TAMAÑO NECESARIO
					sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
					f_cargar_cursor_trans (SQLCA,  sel,  tipos)
					numero_tipos = tipos.RowCount()
					For j = 1 To numero_tipos
						fileDelete(ruta_antigua + tipos.object.tamanyo[j] + "\" + fichero_antiguo)
						ftc_tranformar_imagen_IM (ruta_carpeta, ruta_carpeta + tipos.object.tamanyo[j] + "\" , nombre, tipos.object.resolucion[j], tipos.object.tamanyo[j], tipos.object.color[j])			
					Next
					Destroy tipos
					//-----------------------------------------------------------------------------		
				end if
				st_info.text = "Imagen asociada correctamente." 
				
			else
				ROLLBACK USING trans_ts;
				rtn = -1
			end if
					
			filas = dw_1.retrieve (codigo_empresa, padre_codigo) 
			if filas > 0 then
				dw_1.setrow(fila)
				dw_1.EVENT rowfocuschanged(fila)
			end if
			dw_1.setfocus()	
		end if
		//Habilitamos controles y ocultamos DW auxiliar
		dw_imagenes.visible = false
		pb_anyadir1.enabled = true
		pb_borrar1.enabled = true
		pb_cargar_archivo.enabled = true
		pb_descarga.enabled = true
	end if
end if
end event

