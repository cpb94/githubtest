$PBExportHeader$w_mant_art_tipomoldura.srw
forward
global type w_mant_art_tipomoldura from wt_ventana_padre
end type
end forward

global type w_mant_art_tipomoldura from wt_ventana_padre
integer width = 2258
integer height = 1520
string title = "Mantenimiento de Tipos de Relieve"
end type
global w_mant_art_tipomoldura w_mant_art_tipomoldura

type variables

end variables

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//LLAMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo, unico
boolean falta_Campo
Int resultado
Long repetidos = 0

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "art_tipomoldura"
param_colisiones.campo = "codigo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = true

//---------------------------------------------------------------------------------------------------------------------------------
//			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
//---------------------------------------------------------------------------------------------------------------------------------

// Campos obligatorios dw_1 

dw_1.accepttext()
falta_campo = false
if dw_1.rowcount() > 0 then
	if IsNull(dw_1.object.descripcion[dw_1.getrow()]) or Trim(String(dw_1.object.descripcion[dw_1.getrow()])) = "" then
		  campo = "descripcion"
		  motivo = "Campo Obligatorio: Descripcion. "
		  falta_campo = True
	end if
	
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

rtn = super::f_guardar()

IF rtn = 1 THEN
	COMMIT USING trans_ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_ts;
END IF

dw_1.SetTransObject(SQLCA)
estado = 1 // Modo edición

return rtn

end function

on w_mant_art_tipomoldura.create
call super::create
end on

on w_mant_art_tipomoldura.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_imprimir from wt_ventana_padre`pb_imprimir within w_mant_art_tipomoldura
end type

type p_logo from wt_ventana_padre`p_logo within w_mant_art_tipomoldura
integer x = 1705
end type

type dw_1 from wt_ventana_padre`dw_1 within w_mant_art_tipomoldura
integer width = 2185
integer height = 1052
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_relieve"
boolean border = false
end type

event dw_1::clicked;call super::clicked;if dwo.name <> "p_subir" then
	return
end if

if f_guardar() <> 1 then
	return
end if

Long fila, filas, j, numero_tipos
String sel
string ruta_mostrada, pathname, filename, usuario_windows, ejecutable
str_registro_sistema registro
Datetime fecha_modificacion
String max_codigo, ruta_archivos_relieve, ruta_fichero, nombre, extension, ruta_carpeta, ruta_carpeta_bd, ruta_temporal, ruta_papelera_disenyo, nombre_temporal
Boolean copiado = false

//Tamaño archivo 
LongLong tamanyo_inicio, tamanyo_fin, tamanyo_miniatura = 5000000, tamanyo_archivo = 5000000 //5 MB Aprox

String tipomaquina_disenyo, codigo_archivo, prueba_archivo, ruta_antigua, fichero_antiguo, descripcion
string botones[2]
Int cambiar
str_ventana_alerta parametros
Datastore tipos

rtn = 1
fila = dw_1.getrow()

codigo_archivo = dw_1.object.codigo[fila]
descripcion = dw_1.object.descripcion[fila]

fichero_antiguo = "1.jpg"

SELECT ruta_archivos_relieve, ruta_papelera_disenyo INTO :ruta_archivos_relieve, :ruta_papelera_disenyo FROM empresas WHERE empresa = :codigo_empresa;

ruta_carpeta = ruta_archivos_relieve + codigo_archivo + "\"
ruta_antigua = ruta_carpeta
ruta_carpeta_bd = codigo_archivo + "\"

ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)
SELECT ruta_area_trabajo INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa; 
IF SQLCA.SQLCode <> 0 THEN         
	rtn = -1
ELSE
	usuario_windows = upper(ftc_variable_entorno("USERNAME", lcxk_base))
	ruta_mostrada = ruta_mostrada + usuario_windows
	rtn = GetFileOpenName ("Imágen del relieve "+descripcion, pathname, filename, "jpg", "Imagen JPG,*.jpg", ruta_mostrada, 2)
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

if rtn = 1 then
	//GUARDAR EN BD
	
	//Creación del archivo temporal
	fecha_modificacion = datetime(today(), now())
	
	if fileexists(ruta_antigua + fichero_antiguo) then
		nombre_temporal = "old_REL"+codigo_archivo+"_" + String(Today(), "dd_mm_yy") + "_" + String(Now(), "hh_mm_ss") + "_" + fichero_antiguo
		ruta_temporal = ruta_antigua + nombre_temporal
		rtn = FileMove(ruta_antigua + fichero_antiguo, ruta_temporal)
	end if
	
	if not DirectoryExists(ruta_carpeta) then
		CreateDirectory(ruta_carpeta)
	end if
	
	if rtn = 1 then
		extension = ".jpg" //Siempre jpg //mid(filename, pos(filename,"."))
		nombre = "1"+extension //Solo puede existir una imagen y siempre será la 1.jpg (el numero de relieve lo tiene la carpeta)
		
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
				FileMove(ruta_temporal, ruta_antigua + fichero_antiguo)
			end if
		end if
		
		if rtn = 1 then			
			UPDATE art_tipomoldura 
			SET ruta = :ruta_carpeta_bd, fichero = :nombre 
			WHERE empresa = :codigo_empresa AND codigo = :codigo_archivo USING trans_ts;
			
			IF trans_ts.SQLCode <> 0 THEN         
				MessageBox("SQL error", trans_ts.SQLErrText +" Error actualización en base de datos de la imagen: "+String(trans_ts.SQLDBCode))
			end if
		end if
		
		if rtn = 1 then		
			//El archivo reemplazado lo dejamos en la papelera
			if fileexists(ruta_temporal) then
				fileMove(ruta_temporal, ruta_papelera_disenyo + nombre_temporal)
			end if
			
			COMMIT USING trans_ts;
			//-----------------------------------------------------------------------------
			//BORRAMOS LA COPIA LOCAL DEL ARCHIVO SUBIDO
			if copiado then
				if not Filedelete(pathname) then
					MessageBox("Atención", "No ha sido posible borrar su copia en espacio de trabajo del archivo. Por favor, borrela a mano.")
				end if
			end if
			
			//-----------------------------------------------------------------------------
			//Borrado de Miniaturas y PROCESO DE CREACIÓN DE LAS NUEVAS IMÁGENES PARA CADA TAMAÑO NECESARIO
			sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
			f_cargar_cursor_transaccion (trans_ts,  tipos,  sel)
			numero_tipos = tipos.RowCount()
			For j = 1 To numero_tipos
				fileDelete(ruta_antigua + tipos.object.tamanyo[j] + "\" + fichero_antiguo)
				if not DirectoryExists(ruta_carpeta + tipos.object.tamanyo[j]) then
					CreateDirectory(ruta_carpeta + tipos.object.tamanyo[j])
				end if
				ftc_tranformar_imagen_IM (ruta_carpeta, ruta_carpeta + tipos.object.tamanyo[j] + "\" , nombre, tipos.object.resolucion[j], tipos.object.tamanyo[j], tipos.object.color[j])			
			Next
			Destroy tipos
			//-----------------------------------------------------------------------------
			
			
			MessageBox("Exito", "La imagen ha sido correctamente subida.")
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

	pb_cancelar.triggerEvent("clicked")

end if

end event

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "art_tipomoldura_cliente"
			busqueda.titulo_ventana = "Búsqueda de Clientes"
			busqueda.consulta  = " SELECT codigo, razon "+&
										" FROM genter "+&
										" WHERE empresa = '"+codigo_empresa+"' AND tipoter = 'C'"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Razón"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.art_tipomoldura_cliente[dw_1.GetRow()] 	= resultado.valores[1]		
				dw_1.object.genter_razon[dw_1.GetRow()] 				= resultado.valores[2]
			end if
	END CHOOSE
end if	
	

end event

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "art_tipomoldura_cliente"
		if data <> '' then
			SELECT razon
			INTO :resultado
			FROM genter
			WHERE empresa = :codigo_empresa AND tipoter = 'C' 
			and codigo = :data;
	
			if SQLCA.sqlcode <> 100 then
				this.object.genter_razon[Row] 		= resultado
			else
				dwo.Primary[row] = ''
				this.object.genter_razon[Row] 		= ''
				return 2			
			end if
		else
			this.object.genter_razon[Row] 		= ''
		end if
END CHOOSE


this.Accepttext()
end event

type pb_borrar from wt_ventana_padre`pb_borrar within w_mant_art_tipomoldura
integer x = 1751
end type

type pb_salir from wt_ventana_padre`pb_salir within w_mant_art_tipomoldura
integer x = 2062
end type

type pb_grabar from wt_ventana_padre`pb_grabar within w_mant_art_tipomoldura
end type

type st_titulo from wt_ventana_padre`st_titulo within w_mant_art_tipomoldura
integer width = 1298
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within w_mant_art_tipomoldura
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within w_mant_art_tipomoldura
integer x = 1906
end type

type pb_buscar from wt_ventana_padre`pb_buscar within w_mant_art_tipomoldura
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT codigo, codigo, descripcion "+&
											" FROM art_tipomoldura "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
	
	case "descripcion"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT codigo, descripcion "+&
											" FROM art_tipomoldura "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"			
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT codigo, codigo, descripcion "+&
											" FROM art_tipomoldura "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"		
end choose


call super :: clicked
end event

