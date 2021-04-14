$PBExportHeader$wtc_colorgate_traspaso_archivos.srw
forward
global type wtc_colorgate_traspaso_archivos from window
end type
type dw_errores from datawindow within wtc_colorgate_traspaso_archivos
end type
type ficheros from listbox within wtc_colorgate_traspaso_archivos
end type
type carpetas from listbox within wtc_colorgate_traspaso_archivos
end type
type st_info from statictext within wtc_colorgate_traspaso_archivos
end type
type pb_1 from picturebutton within wtc_colorgate_traspaso_archivos
end type
type barra_1 from hprogressbar within wtc_colorgate_traspaso_archivos
end type
type cb_1 from commandbutton within wtc_colorgate_traspaso_archivos
end type
type p_logo from picture within wtc_colorgate_traspaso_archivos
end type
type st_titulo from statictext within wtc_colorgate_traspaso_archivos
end type
type gb_1 from groupbox within wtc_colorgate_traspaso_archivos
end type
type gb_2 from groupbox within wtc_colorgate_traspaso_archivos
end type
end forward

global type wtc_colorgate_traspaso_archivos from window
integer width = 2619
integer height = 1816
boolean titlebar = true
string title = "Traspaso de TIFFs"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_errores dw_errores
ficheros ficheros
carpetas carpetas
st_info st_info
pb_1 pb_1
barra_1 barra_1
cb_1 cb_1
p_logo p_logo
st_titulo st_titulo
gb_1 gb_1
gb_2 gb_2
end type
global wtc_colorgate_traspaso_archivos wtc_colorgate_traspaso_archivos

type variables
Long id_ventana_activa
Boolean parar
end variables

forward prototypes
public subroutine f_imprimir_errores ()
end prototypes

public subroutine f_imprimir_errores ();if dw_errores.rowcount() > 0 then
	dw_errores.sort()
	f_imprimir_datawindow(dw_errores)
end if
end subroutine

on wtc_colorgate_traspaso_archivos.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.dw_errores=create dw_errores
this.ficheros=create ficheros
this.carpetas=create carpetas
this.st_info=create st_info
this.pb_1=create pb_1
this.barra_1=create barra_1
this.cb_1=create cb_1
this.p_logo=create p_logo
this.st_titulo=create st_titulo
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_errores,&
this.ficheros,&
this.carpetas,&
this.st_info,&
this.pb_1,&
this.barra_1,&
this.cb_1,&
this.p_logo,&
this.st_titulo,&
this.gb_1,&
this.gb_2}
end on

on wtc_colorgate_traspaso_archivos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_errores)
destroy(this.ficheros)
destroy(this.carpetas)
destroy(this.st_info)
destroy(this.pb_1)
destroy(this.barra_1)
destroy(this.cb_1)
destroy(this.p_logo)
destroy(this.st_titulo)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;select nombre
into :st_titulo.text
from empresas
where empresa = :codigo_empresa;


parar = false
end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

barra_1.SetStep = 1
barra_1.Position = 1

end event

type dw_errores from datawindow within wtc_colorgate_traspaso_archivos
boolean visible = false
integer x = 1769
integer y = 612
integer width = 686
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "dwtc_aux_errores_traspaso"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ficheros from listbox within wtc_colorgate_traspaso_archivos
integer x = 1394
integer y = 380
integer width = 1129
integer height = 1120
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String tif, fichero, tipomaquina

if index > 0 then
	fichero = f_reemplazar(f_reemplazar(this.text(index), "]", ""), "[", "") //nombre del fichero
	tif = fichero //Codigo del tif
	if pos(tif, "T") <> 1 and pos(tif, "K") <> 1 then
		MessageBox("Info", "El tif no tiene T o K al principio. No se traspasará.")
	else
		if pos(tif, "T") = 1 then //Es un tif
			tipomaquina = "1"
		else //Es un archvio Kerajet
			tipomaquina = "2"
		end if
		tif = right(tif, len(tif) - 1) //ELIMINO LA T Ó LA K
		tif = left(tif, len(tif) - 4) //Elimino la extension
		MessageBox("Info", tif)
	end if
end if

end event

type carpetas from listbox within wtc_colorgate_traspaso_archivos
integer x = 87
integer y = 376
integer width = 1211
integer height = 1128
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ruta_tif, ruta_produccion = "\\amazonas\disenyo\produccion\"

if index > 0 then
	ficheros.reset()
	ruta_tif = ruta_produccion + f_reemplazar(f_reemplazar(carpetas.text(index), "]", ""), "[", "")
	if pos(ruta_tif, ".") = 0 then
		if not ficheros.DirList(ruta_tif + "\*.tif", 0) then
			st_info.text = "Error. No se encuentra el subirectorio: "+carpetas.text(index)+"."
			return
		end if
	end if
end if
end event

type st_info from statictext within wtc_colorgate_traspaso_archivos
integer x = 777
integer y = 104
integer width = 1627
integer height = 188
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

type pb_1 from picturebutton within wtc_colorgate_traspaso_archivos
integer x = 2432
integer y = 148
integer width = 146
integer height = 128
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Log Out_24x24Gris.png"
alignment htextalign = left!
end type

event clicked;Close(Parent)
end event

type barra_1 from hprogressbar within wtc_colorgate_traspaso_archivos
integer x = 37
integer y = 1544
integer width = 2519
integer height = 68
unsignedinteger minposition = 1
unsignedinteger maxposition = 100
unsignedinteger position = 1
integer setstep = 1
end type

type cb_1 from commandbutton within wtc_colorgate_traspaso_archivos
integer x = 37
integer y = 144
integer width = 709
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Iniciar Traspaso"
end type

event clicked;Long numero_subcarpetas, numero_ficheros, numero, i, j, n, fila, existe, en_produccion
LongLong tamanyo
String ruta_produccion = "\\amazonas\DISENYO\PRODUCCION\"
String ruta_archivos_disenyo, ruta_origen, ruta_destino, ruta_tif, ruta_carpeta, ruta_tif_bd, tif, fichero, nombre_fichero, nombre_fichero_destino, tipomaquina
String disenyador, modelo_teorico, modelo, articulo_aplicacion, version_aplicacion, operacion_aplicacion, codigo_aplicacion, maximo, sel
Datetime fecha_modificacion
str_colisiones param_colisiones
transaction trm
Datastore modelos, articulos

dw_errores.reset()

st_info.text = "Traspaso inciado."

if not carpetas.DirList(ruta_produccion, 32768 + 16) then
	st_info.text = "Error. No se encuentra el directorio de producción."
	return
end if

if MessageBox("Carpetas recuperadas", "Carpetas de producción recuperadas. ¿Desea comenzar el traspaso?", Question!, YesNo!, 2) = 2 then
	st_info.text = "Cancelado."
	return
end if

f_crear_transaccion(trm,"","",false,"TS","")
CONNECT USING trm;

numero_subcarpetas = carpetas.TotalItems()
barra_1.setRange(1,numero_subcarpetas)
barra_1.position = 1
For i = 1 To numero_subcarpetas
	carpetas.SelectItem (i)
	modelo_teorico = f_reemplazar(f_reemplazar(carpetas.text(i), "]", ""), "[", "")
	
	SELECT tecnico_dis.descripcion INTO :disenyador 
	FROM desmodelo INNER JOIN tecnico_dis ON desmodelo.empresa = tecnico_dis.empresa AND desmodelo.tecnico_dis = tecnico_dis.codigo 
	WHERE modelo = :modelo_teorico 
	USING SQLCA;
	
	ruta_tif = ruta_produccion + modelo_teorico
	if pos(ruta_tif, ".") = 0 and pos(ruta_tif, "V_") = 0 and pos(ruta_tif, "JUEGOS") = 0 and pos(ruta_tif, "PROVISIONAL_INKCID_2") = 0 then
		if not ficheros.DirList(ruta_tif + "\*.tif", 0) then
			st_info.text = "Error. No se encuentra el subirectorio: "+carpetas.text(i)+"."
			fila = dw_errores.insertrow(0)
			dw_errores.object.tipo[fila] = 1
			dw_errores.object.error[fila] = st_info.text
			ficheros.reset()
		end if
	end if
	numero_ficheros = ficheros.TotalItems()
	for j = 1 To numero_ficheros
		//Traspaso
		fichero = f_reemplazar(f_reemplazar(ficheros.text(j), "]", ""), "[", "") //nombre del fichero
		ruta_origen = ruta_tif + "\" + fichero
		tif = upper(fichero) //Codigo del tif
		if pos(tif, "T") <> 1 and pos(tif, "K") <> 1 then
			fila = dw_errores.insertrow(0)
			dw_errores.object.tipo[fila] = 1
			dw_errores.object.disenyador[fila] = disenyador
			dw_errores.object.error[fila] = "TIF: "+fichero+ " RUTA: "+ruta_tif+ " D: "+disenyador		
			dw_errores.object.tif[fila] = tif
		else
			tif = left(tif, len(tif) - 4) //Elimino la extension
			nombre_fichero = tif
			if pos(tif, "T") = 1 then //Es un tif				
				tipomaquina = "1"
			else //Es un archvio Kerajet
				tipomaquina = "2"
			end if
			tif = right(tif, len(tif) - 1) //ELIMINO LA T Ó LA K			
			
			//Busco el tif en la base de datos y compruebo que no tiene archivos ya subidos
			existe = 0
			SELECT COUNT(*) INTO :existe FROM archivo_disenyo_sistema_archivos 
			WHERE empresa = :codigo_empresa 
			AND tipomaquina_disenyo = :tipomaquina 
			AND archivo = :tif
			USING trm;
			
			en_produccion = 0
			SELECT COUNT(*) INTO :en_produccion FROM prodformula 
			WHERE empresa = :codigo_empresa 
			AND prodformula.descripcion_produccion = :nombre_fichero
			USING trm;
			
			if existe > 0 then
				fila = dw_errores.insertrow(0)
				dw_errores.object.tif[fila] = tif
				dw_errores.object.tipo[fila] = 2
				dw_errores.object.disenyador[fila] = disenyador
				dw_errores.object.error[fila] = "YA HAY ARCHIVOS PARA EL TIF: "+fichero+ " RUTA: "+ruta_tif+ " D: "+disenyador		
			elseif en_produccion <= 0 then
				fila = dw_errores.insertrow(0)
				dw_errores.object.tif[fila] = tif
				dw_errores.object.tipo[fila] = 0
				dw_errores.object.disenyador[fila] = disenyador
				dw_errores.object.error[fila] = "No se subirá el TIF: "+fichero+ " Por no estar en producción. RUTA: "+ruta_tif+ " D: "+disenyador		
			else
				//ALTA DEL ARCHIVO
				existe = 0
				SELECT COUNT(*) INTO :existe FROM archivo_disenyo
				WHERE empresa = :codigo_empresa 
				AND tipomaquina_disenyo = :tipomaquina 
				AND codigo = :tif
				USING trm; 
				
				//Insercion de Archivo Diseño
				if existe = 0 then
					INSERT INTO archivo_disenyo (empresa, tipomaquina_disenyo, codigo, nombre) 
					VALUES (:codigo_empresa, :tipomaquina, :tif,  :nombre_fichero ) 
					USING trm;
					
					if trm.sqlcode <> 0 then 
						st_info.text = "Error Insercion Archivo Disenyo. Se detiene el traspaso en TIF: "+fichero
						ROLLBACK USING trm;
						DISCONNECT USING trm;
						Destroy trm
						Destroy modelos
						Destroy articulos
						f_imprimir_errores()
						return
					end if
					fila = dw_errores.insertrow(0)
					dw_errores.object.tipo[fila] = 0
					//dw_errores.object.disenyador[fila] = disenyador
					dw_errores.object.error[fila] = "Se ha creado nuevo TIF: "+fichero
					dw_errores.object.tif[fila] = tif
				end if
				
				//NOMBRE FINAL DEL ARCHIVO Y RUTAS DE DESTINO
				SELECT ruta_archivos_disenyo INTO :ruta_archivos_disenyo FROM empresas 
				WHERE empresa = :codigo_empresa 
				USING trm;
				
				ruta_tif_bd = nombre_fichero+"\"
				nombre_fichero_destino = nombre_fichero+"-1.tif" //El codigo siempre será 1 y la extensión tif 
				ruta_carpeta = ruta_archivos_disenyo + ruta_tif_bd
				ruta_destino = ruta_archivos_disenyo + ruta_tif_bd + nombre_fichero_destino
				tamanyo = FileLength64 (ruta_origen)
				fecha_modificacion = datetime(today(), now())
				
				//Comprobación de la existencia del directorio y creación					
				if not FileExists(ruta_carpeta) then
					if CreateDirectory(ruta_carpeta) <> 1 then
						st_info.text = "Error creando carpeta "+ruta_carpeta+" en el sistema. Se detiene el traspaso en TIF: "+fichero
						ROLLBACK USING trm;
						DISCONNECT USING trm;
						Destroy trm
						Destroy modelos
						Destroy articulos
						f_imprimir_errores()
						return
					end if
				end if
				
				//Inserción en Sistema Archivos
				INSERT INTO archivo_disenyo_sistema_archivos (empresa, tipomaquina_disenyo, archivo, codigo, ruta, fichero, fecha_modificacion, tamanyo) 
				VALUES (:codigo_empresa, :tipomaquina, :tif,  '1', :ruta_tif_bd, :nombre_fichero_destino, :fecha_modificacion, :tamanyo) 
				USING trm;
				if trm.sqlcode <> 0 then 
					st_info.text = "Error Insercion Archivo Disenyo Sistema Archivos. Se detiene el traspaso en TIF: "+fichero
					ROLLBACK USING trm;
					DISCONNECT USING trm;
					Destroy trm
					Destroy modelos
					Destroy articulos
					f_imprimir_errores()
					return
				end if
				
				//Asociación a los modelos que llevan el TIF añadido al sistema
				sel = "SELECT DISTINCT modelo FROM destrabajo2 WHERE cod_inkcid = '"+tif+"'"
				f_cargar_cursor_trans (trm,  sel,  modelos)
				numero = modelos.RowCount()
				n = 1
				do while (n <= numero) 
					modelo = modelos.object.modelo[n]
					//Codigo máximo de archivo asociado
					param_colisiones.empresa = codigo_empresa
					param_colisiones.tabla = "desmodelo_archivo"
					param_colisiones.campo = "codigo"
					param_colisiones.filtro = "desmodelo_archivo.modelo = '"+modelo+"'"
					param_colisiones.buscar_huecos = false
					maximo = f_colisiones (trm, param_colisiones)
					
					INSERT INTO desmodelo_archivo (empresa, modelo, codigo, tipo_maquina_disenyo, archivo_disenyo) 
					VALUES (:codigo_empresa, :modelo, :maximo, :tipomaquina, :tif) 
					USING trm;
					
					if trm.sqlcode <> 0 then 
						st_info.text = "Error Asociación al modelo "+modelo+",  tif: "+fichero
						ROLLBACK USING trm;
						DISCONNECT USING trm;
						Destroy trm
						Destroy modelos
						Destroy articulos
						f_imprimir_errores()
						return
					end if
					
					n++
				loop
				if numero = 0 then
					fila = dw_errores.insertrow(0)
					dw_errores.object.tif[fila] = tif
					//dw_errores.object.disenyador[fila] = disenyador
					
					existe = 0
					SELECT COUNT(*) INTO :existe FROM desmodelo WHERE empresa = :codigo_empresa AND modelo = :modelo_teorico USING trm;
					if existe > 0 then
						dw_errores.object.tipo[fila] = 0
						dw_errores.object.error[fila] = "El TIF "+fichero+" no está asociado a ningún modelo. Se asociará al modelo con el nombre de la carpeta: "+modelo_teorico
						
						//Codigo máximo de archivo asociado
						param_colisiones.empresa = codigo_empresa
						param_colisiones.tabla = "desmodelo_archivo"
						param_colisiones.campo = "codigo"
						param_colisiones.filtro = "desmodelo_archivo.modelo = '"+modelo_teorico+"'"
						param_colisiones.buscar_huecos = false
						maximo = f_colisiones (trm, param_colisiones)
						
						INSERT INTO desmodelo_archivo (empresa, modelo, codigo, tipo_maquina_disenyo, archivo_disenyo) 
						VALUES (:codigo_empresa, :modelo_teorico, :maximo, :tipomaquina, :tif) 
						USING trm;
						
						if trm.sqlcode <> 0 then 
							st_info.text = "Error Asociación al modelo "+modelo_teorico+",  tif: "+fichero
							ROLLBACK USING trm;
							DISCONNECT USING trm;
							Destroy trm
							Destroy modelos
							Destroy articulos
							f_imprimir_errores()
							return
						end if
						
					else
						dw_errores.object.error[fila] = "El TIF "+fichero+" no está asociado a ningún modelo"
						dw_errores.object.tipo[fila] = 4
					end if
				end if
				
				//Asociación a los artículos de producción que llevan el TIF añadido al sistema
				sel =  "SELECT art_ver_op_aplicaciones.articulo, art_ver_op_aplicaciones.version, art_ver_op_aplicaciones.operacion, art_ver_op_aplicaciones.contadoraplicacion "+&
						"FROM art_ver_op_aplicaciones INNER JOIN prodformula ON art_ver_op_aplicaciones.empresa = prodformula.empresa AND art_ver_op_aplicaciones.formula = prodformula.formula "+&
						"WHERE prodformula.descripcion_produccion = '"+nombre_fichero+"'"
				f_cargar_cursor_trans (trm,  sel,  articulos)
				numero = articulos.RowCount()
				n = 1
				do while (n <= numero) 
					articulo_aplicacion = articulos.object.art_ver_op_aplicaciones_articulo[n]
					version_aplicacion = articulos.object.art_ver_op_aplicaciones_version[n]
					operacion_aplicacion = articulos.object.art_ver_op_aplicaciones_operacion[n]
					codigo_aplicacion = articulos.object.art_ver_op_aplicaciones_contadoraplicacion[n]
					
					UPDATE art_ver_op_aplicaciones SET 
					archivo_disenyo_tipomaquina_disenyo = :tipomaquina,
					archivo_disenyo_codigo = :tif, 
					archivo_disenyo_prueba = '1'
					WHERE empresa = :codigo_empresa 
					AND articulo = :articulo_aplicacion 
					AND version = :version_aplicacion 
					AND operacion = :operacion_aplicacion 
					AND contadoraplicacion = :codigo_aplicacion 
					USING trm;
					
					if trm.sqlcode <> 0 then 
						st_info.text = "Error Asociación al articulo "+articulo_aplicacion+",  tif: "+fichero
						ROLLBACK USING trm;
						DISCONNECT USING trm;
						Destroy trm
						Destroy modelos
						Destroy articulos
						f_imprimir_errores()
						return
					end if
					
					n++
				loop
				if numero = 0 then
					fila = dw_errores.insertrow(0)
					dw_errores.object.tipo[fila] = 5
					dw_errores.object.tif[fila] = tif
					dw_errores.object.disenyador[fila] = disenyador
					dw_errores.object.error[fila] = "El TIF "+fichero+" no está asociado a ningún Artículo de Producción. Revisar. "
				end if
				
				//MOVIMIENTO IMAGEN AL SISTEMA ARCHIVOS
				if FileMove(ruta_origen, ruta_destino) <> 1 then
					st_info.text = "Error Moviendo Tif: "+fichero+ " a "+ruta_destino
					ROLLBACK USING trm;
					DISCONNECT USING trm;
					Destroy trm
					Destroy modelos
					Destroy articulos
					f_imprimir_errores()
					return
				end if	
				
				//Confirmar grabación
				COMMIT USING trm;
			end if
		end if
	Next
	st_info.text = "Carpeta "+String(i)+" de "+String(numero_subcarpetas)+" completada."
	barra_1.StepIt()
Next 

st_info.text = "Fin Traspaso."
DISCONNECT USING trm;
Destroy trm

f_imprimir_errores()
end event

type p_logo from picture within wtc_colorgate_traspaso_archivos
integer x = 2053
integer y = 8
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type st_titulo from statictext within wtc_colorgate_traspaso_archivos
integer x = 37
integer y = 24
integer width = 1710
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Nombre Empresa"
boolean focusrectangle = false
end type

type gb_1 from groupbox within wtc_colorgate_traspaso_archivos
integer x = 41
integer y = 292
integer width = 1298
integer height = 1232
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carpetas Producción"
end type

type gb_2 from groupbox within wtc_colorgate_traspaso_archivos
integer x = 1367
integer y = 292
integer width = 1193
integer height = 1232
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ficheros"
end type

