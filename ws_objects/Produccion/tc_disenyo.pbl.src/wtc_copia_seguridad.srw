$PBExportHeader$wtc_copia_seguridad.srw
forward
global type wtc_copia_seguridad from window
end type
type cb_borrar from commandbutton within wtc_copia_seguridad
end type
type directorio from listbox within wtc_copia_seguridad
end type
type cbx_calcular from checkbox within wtc_copia_seguridad
end type
type em_fecha from editmask within wtc_copia_seguridad
end type
type cb_2 from commandbutton within wtc_copia_seguridad
end type
type sle_ruta from singlelineedit within wtc_copia_seguridad
end type
type st_2 from statictext within wtc_copia_seguridad
end type
type st_1 from statictext within wtc_copia_seguridad
end type
type st_info from statictext within wtc_copia_seguridad
end type
type pb_1 from picturebutton within wtc_copia_seguridad
end type
type barra_1 from hprogressbar within wtc_copia_seguridad
end type
type cb_1 from commandbutton within wtc_copia_seguridad
end type
type p_logo from picture within wtc_copia_seguridad
end type
type st_titulo from statictext within wtc_copia_seguridad
end type
end forward

global type wtc_copia_seguridad from window
integer width = 2935
integer height = 984
boolean titlebar = true
string title = "Copia de seguridad"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_borrar cb_borrar
directorio directorio
cbx_calcular cbx_calcular
em_fecha em_fecha
cb_2 cb_2
sle_ruta sle_ruta
st_2 st_2
st_1 st_1
st_info st_info
pb_1 pb_1
barra_1 barra_1
cb_1 cb_1
p_logo p_logo
st_titulo st_titulo
end type
global wtc_copia_seguridad wtc_copia_seguridad

type variables
Long id_ventana_activa
Boolean parar
end variables

forward prototypes
public function integer f_crear_estructura_directorios (string ruta_inicio, string ruta_completa)
public function long f_copia_seguridad (string ruta_archivo_origen, string ruta_destino, string ruta, string fichero, ref string texto_error, ref double espacio_ocupado)
end prototypes

public function integer f_crear_estructura_directorios (string ruta_inicio, string ruta_completa);Long posicion, rtn = 1
String ruta_nueva 

ruta_nueva = ruta_inicio
ruta_completa =  f_reemplazar(ruta_completa, ruta_inicio, "")
do 
	posicion =  pos(ruta_completa, "\")
	if posicion <> 0 then
		ruta_nueva = ruta_nueva + left(ruta_completa, posicion)
		ruta_completa = mid(ruta_completa, posicion + 1)
		if not DirectoryExists (ruta_nueva) then
			if CreateDirectory (ruta_nueva) <> 1 then
				rtn = -1
			end if
		end if
	end if
loop while posicion <> 0 and rtn = 1 

return rtn
end function

public function long f_copia_seguridad (string ruta_archivo_origen, string ruta_destino, string ruta, string fichero, ref string texto_error, ref double espacio_ocupado);Datetime fecha_creacion_origen, fecha_acceso_origen, fecha_modificacion_origen, fecha_creacion_destino, fecha_acceso_destino, fecha_modificacion_destino
String h1, h2
Long rtn = 1

if not DirectoryExists (ruta_destino + ruta) then
	rtn = f_crear_estructura_directorios(ruta_destino, ruta_destino + ruta) 
	if rtn <> 1 then
		texto_error = "No se ha podido crear el directorio: "+ruta_destino + ruta
	end if
end if		

if rtn = 1 then
	ruta_destino = ruta_destino + ruta + fichero
	if fileexists(ruta_destino) then
		//Comprobamos fecha de modificación archivos
		f_hora_fichero(ruta_archivo_origen, fecha_creacion_origen, fecha_acceso_origen, fecha_modificacion_origen)
		h1 = string(fecha_modificacion_origen,"yyyymmddhhmmss")
		f_hora_fichero(ruta_destino, fecha_creacion_destino, fecha_acceso_destino, fecha_modificacion_destino)
		h2 = string(fecha_modificacion_destino,"yyyymmddhhmmss")
		if h1>h2 then
			if filecopy(ruta_archivo_origen, ruta_destino, true) <> 1 then
				rtn = -1
				texto_error = "No se ha podido copiar el archivo: "+ruta_destino
			else
				espacio_ocupado = espacio_ocupado + (FileLength64(ruta_destino) / 1000000)
			end if
		end if
	else
		if filecopy(ruta_archivo_origen, ruta_destino, false) <> 1 then
			rtn = -1
			texto_error = "No se ha podido copiar el archivo: "+ruta_destino
		else
			espacio_ocupado = espacio_ocupado + (FileLength64(ruta_destino) / 1000000)
		end if
	end if	
end if

return rtn
end function

on wtc_copia_seguridad.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.cb_borrar=create cb_borrar
this.directorio=create directorio
this.cbx_calcular=create cbx_calcular
this.em_fecha=create em_fecha
this.cb_2=create cb_2
this.sle_ruta=create sle_ruta
this.st_2=create st_2
this.st_1=create st_1
this.st_info=create st_info
this.pb_1=create pb_1
this.barra_1=create barra_1
this.cb_1=create cb_1
this.p_logo=create p_logo
this.st_titulo=create st_titulo
this.Control[]={this.cb_borrar,&
this.directorio,&
this.cbx_calcular,&
this.em_fecha,&
this.cb_2,&
this.sle_ruta,&
this.st_2,&
this.st_1,&
this.st_info,&
this.pb_1,&
this.barra_1,&
this.cb_1,&
this.p_logo,&
this.st_titulo}
end on

on wtc_copia_seguridad.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_borrar)
destroy(this.directorio)
destroy(this.cbx_calcular)
destroy(this.em_fecha)
destroy(this.cb_2)
destroy(this.sle_ruta)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_info)
destroy(this.pb_1)
destroy(this.barra_1)
destroy(this.cb_1)
destroy(this.p_logo)
destroy(this.st_titulo)
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
barra_1.Position = 0

end event

type cb_borrar from commandbutton within wtc_copia_seguridad
integer x = 27
integer y = 584
integer width = 494
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar Papelera"
end type

event clicked;String h1, h2, fecha_inicio, dia, mes, anyo
String ruta_papelera_disenyo, ruta_archivo, fichero
//Datetime fecha_creacion, fecha_acceso, fecha_modificacion
Long i, n_ficheros, rtn, posicion, posicion_anterior, borrados, f
Double espacio_liberado, tamanyo_mb

fecha_inicio = em_fecha.text 
if fecha_inicio = "none" or fecha_inicio = "00-00-0000" or isnull(fecha_inicio) then
	MessageBox("Error", "Debe indicar una fecha")
	return
end if

if MessageBox("Borrar Papelera de Diseño", "Va a borrar los archivos de la papelera de diseño con fecha anterior o igual a "+fecha_inicio, Question!, YesNo!, 2) = 2 then
	return
end if

SELECT ruta_papelera_disenyo INTO :ruta_papelera_disenyo FROM empresas WHERE empresa = :codigo_empresa;

f = FileOpen(ruta_papelera_disenyo + "log.txt", LineMode!, Write!, LockWrite!, Replace!, EncodingANSI!)
if f = -1 then
	st_info.text = "No se ha podido crear el archivo de log: "+ruta_papelera_disenyo + "log.txt"
	return
end if

if not directorio.DirList(ruta_papelera_disenyo+"*.*", 0) then
	st_info.text = "No se puede borrar la papelera de diseño"
	return
end if
FileWrite(f, "Inicio borrado: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))

n_ficheros = directorio.TotalItems()
borrados = 0
espacio_liberado = 0
for i = 1 to n_ficheros
	ruta_archivo = directorio.Text(i)
	
	h1 = string(Datetime(date(fecha_inicio)),"yyyymmddhhmmss")
	
	//Cálculo de la fecha a partir del nombre de fichero
	posicion = pos(ruta_archivo, "\")
	do while posicion <> 0
		posicion_anterior = posicion
		posicion = pos(ruta_archivo, "\")
	loop 
	fichero = mid(ruta_archivo, posicion_anterior+1)
	fichero = f_reemplazar(fichero, "old_", "")
	dia = mid(fichero, 0, 2)
	fichero = mid(fichero, pos(fichero, "_") + 1)
	mes = mid(fichero, 0, 2)
	fichero = mid(fichero, pos(fichero, "_") + 1)
	anyo = mid(fichero, 0, 2)
	h2 = "20"+anyo+mes+dia+"000001"	
	if h1>h2 then
		tamanyo_mb =  (FileLength64(ruta_archivo) / 1000000)
		if not FileDelete(ruta_archivo) then
			FileWrite(f, "No se pudo borrar el archivo: "+ruta_archivo)
		else
			borrados ++
			espacio_liberado = espacio_liberado + tamanyo_mb
		end if
	end if
next



st_info.text = "Fin Borrado Papelera de disenyo. "+String(borrados)+" archivos eliminados. Espacio liberado: "+String(espacio_liberado, "###,##0.00")+ " MB"
FileWrite(f, "Fin Borrado Papelera de disenyo.")
FileWrite(f, String(borrados)+" archivos eliminados.")
FileWrite(f, "Espacio liberado: "+String(espacio_liberado, "###,##0.00")+ " MB")
FileWrite(f, "Fecha: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
FileClose(f)



end event

type directorio from listbox within wtc_copia_seguridad
boolean visible = false
integer x = 2478
integer y = 152
integer width = 411
integer height = 144
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_calcular from checkbox within wtc_copia_seguridad
integer x = 37
integer y = 128
integer width = 608
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sólo calcular espacio"
boolean checked = true
end type

type em_fecha from editmask within wtc_copia_seguridad
integer x = 1842
integer y = 224
integer width = 549
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
boolean dropdowncalendar = true
end type

type cb_2 from commandbutton within wtc_copia_seguridad
integer x = 2491
integer y = 340
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Examinar"
end type

event clicked;String ruta_seleccionada

if GetFolder ("Ruta copia", ruta_seleccionada) = 1 then
	sle_ruta.text = ruta_seleccionada
end if
end event

type sle_ruta from singlelineedit within wtc_copia_seguridad
integer x = 366
integer y = 352
integer width = 2030
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "\\sauron\copia"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within wtc_copia_seguridad
integer x = 41
integer y = 240
integer width = 1559
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha máxima (antes de esta fecha no se guardará nada):"
boolean focusrectangle = false
end type

type st_1 from statictext within wtc_copia_seguridad
integer x = 41
integer y = 372
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Destino:"
boolean focusrectangle = false
end type

type st_info from statictext within wtc_copia_seguridad
integer x = 549
integer y = 484
integer width = 2336
integer height = 180
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

type pb_1 from picturebutton within wtc_copia_seguridad
integer x = 2747
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

type barra_1 from hprogressbar within wtc_copia_seguridad
integer x = 27
integer y = 708
integer width = 2857
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type cb_1 from commandbutton within wtc_copia_seguridad
integer x = 27
integer y = 468
integer width = 494
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Iniciar Copia"
end type

event clicked;//Sustitución Unidades Materias Primas Fórmulas TIFF - De gramos a litros para aplicar la densidad al coste (como funciona por proporciona litros funciona, sin ser necesario ml que no existe)
String sel, fecha_inicio, ruta_archivos_disenyo, ruta_archivos_exposicion, ruta, fichero, ruta_archivo, ruta_nueva, ruta_completa
Long i, j, rtn, f, res
Long numero, numero_tipos, posicion, n_ficheros
Datastore archivos, tipos
Boolean solo_espacio
Double espacio_ocupado
String ruta_copia, ruta_copia_disenyo, ruta_copia_expo
String texto_error

//CONSTANTES CONFIGURACIÓN
String ruta_bd = "\\Pascal\temp\"
String ruta_servidor_origen = "\\AMAZONAS\" 
Int meses_papelera = 6

rtn = 1
espacio_ocupado = 0

fecha_inicio = em_fecha.text 
if fecha_inicio = "none" or fecha_inicio = "00-00-0000" or isnull(fecha_inicio) then
	MessageBox("Error", "Debe indicar una fecha")
	return
end if

solo_espacio = cbx_calcular.checked

if not solo_espacio then
	ruta_copia = sle_ruta.text
	if ruta_copia = "" or isnull(ruta_copia) or not DirectoryExists (ruta_copia) then
		MessageBox("Error", "Debe indicar una ruta válida de copia")
		return
	end if
	if pos(right(ruta_copia, 1), "\") = 0 then
		ruta_copia = ruta_copia + "\"
	end if
end if

if not solo_espacio then
	if MessageBox("Copia de seguridad", "Se procederá a la copia de seguidad de todos los archivos de producción y con fecha de modificación mayor que "+fecha_inicio+". ¿Desea continuar?", Question!, YesNo!, 2) = 2 then
		return
	end if
else
	if MessageBox("Cálculo del espacio", "Se va a calcular el espacio que ocupará una hipotética copia de seguridad de todos los archivos de producción y con fecha de modificación mayor que "+fecha_inicio+". El proceso tardará varios minutos. ¿Desea continuar?", Question!, YesNo!, 2) = 2 then
		return
	end if
end if

SELECT ruta_archivos_disenyo, ruta_archivos_exposicion INTO :ruta_archivos_disenyo, :ruta_archivos_exposicion FROM empresas WHERE empresa = :codigo_empresa;
 ruta_copia_disenyo = ruta_copia + f_reemplazar(ruta_archivos_disenyo, ruta_servidor_origen, "")
 ruta_copia_expo = ruta_copia + f_reemplazar(ruta_archivos_exposicion, ruta_servidor_origen, "")

if not solo_espacio then
	f = FileOpen(ruta_copia + "log.txt", LineMode!, Write!, LockWrite!, Replace!, EncodingANSI!)
	if f = -1 then
		st_info.text = "No se ha podido crear el archivo de log: "+ruta_copia + "log.txt"
		return
	end if
	
	FileWrite(f, "Copia iniciada. Fecha inicio: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
end if

if rtn = 1 then
	if solo_espacio then
		st_info.text = "Calculando espacio ocupado Archivos de Máquina"
	else
		st_info.text = "Realizando copia de Archivos de Máquina"
		
		if not DirectoryExists (ruta_copia_disenyo) then
			rtn = f_crear_estructura_directorios(ruta_copia, ruta_copia_disenyo)
			if rtn <> 1 then
				st_info.text = "No se ha podido crear el directorio: "+ruta_copia_disenyo
			end if
		end if
		
		if not DirectoryExists (ruta_copia_expo) then
			rtn = f_crear_estructura_directorios(ruta_copia, ruta_copia_expo)
			if rtn <> 1 then
				st_info.text = "No se ha podido crear el directorio: "+ruta_copia_disenyo
			end if
		end if
	end if
end if
/*
if not solo_espacio then
	FileWrite(f, "Archivos de máquina. Fecha inicio: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
end if

sel = "SELECT ruta, fichero FROM archivo_disenyo_sistema_archivos WHERE fecha_modificacion >= '"+fecha_inicio+"' OR ((SELECT COUNT(*) FROM juegospantallas J WHERE J.empresa = archivo_disenyo_sistema_archivos.empresa AND J.tipomaquina_disenyo = archivo_disenyo_sistema_archivos.tipomaquina_disenyo AND J.archivo = archivo_disenyo_sistema_archivos.archivo AND J.prueba = archivo_disenyo_sistema_archivos.codigo) + (SELECT COUNT(*) FROM art_ver_op_aplicaciones A WHERE A.empresa = archivo_disenyo_sistema_archivos.empresa AND A.archivo_disenyo_tipomaquina_disenyo = archivo_disenyo_sistema_archivos.tipomaquina_disenyo AND A.archivo_disenyo_codigo = archivo_disenyo_sistema_archivos.archivo AND A.archivo_disenyo_prueba = archivo_disenyo_sistema_archivos.codigo)) > 0 "
f_cargar_cursor_trans (SQLCA,  sel,  archivos)
numero = archivos.RowCount()
barra_1.setRange(0,numero)
i = 1
do while (i <= numero AND rtn = 1) 
	ruta = archivos.object.ruta[i]
	fichero = archivos.object.fichero[i]
	
	ruta_archivo = ruta_archivos_disenyo + ruta + fichero
	if not solo_espacio then
		//Proceso de copia de seguridad
		texto_error = ""
		if f_copia_seguridad(ruta_archivo, ruta_copia_disenyo, ruta, fichero, texto_error, espacio_ocupado) <> 1 then
			if texto_error <> "" then
				FileWrite(f, texto_error)
				//st_info.text = texto_error
			end if
		end if
	else
		espacio_ocupado = espacio_ocupado + (FileLength64(ruta_archivo) / 1000000)
	end if
	
	barra_1.StepIt()
	i++
loop

if rtn = 1 then
	if solo_espacio then
		st_info.text = "Calculando espacio ocupado Modelos de Diseño"
	else
		st_info.text = "Realizando copia de Modelos de Diseño"
	end if
end if

if not solo_espacio then
	FileWrite(f, "Fin Archivos de máquina.")
	FileWrite(f, "Modelos Diseño. Fecha inicio: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
end if

sel = "SELECT ruta, fichero FROM modelo_propuesta_sistema_archivos WHERE fecha_modificacion >= '"+fecha_inicio+"' OR (SELECT COUNT(*) FROM articulos WHERE articulos.empresa = modelo_propuesta_sistema_archivos.empresa AND articulos.modelo_origen = modelo_propuesta_sistema_archivos.modelo) > 0 "
f_cargar_cursor_trans (SQLCA,  sel,  archivos)
numero = archivos.RowCount()
barra_1.setRange(0,numero)
i = 1
do while (i <= numero AND rtn = 1) 
	ruta = archivos.object.ruta[i]
	fichero = archivos.object.fichero[i]
	
	ruta_archivo = ruta_archivos_disenyo + ruta + fichero
	if not solo_espacio then
		//Proceso de copia de seguridad
		texto_error = ""
		if f_copia_seguridad(ruta_archivo, ruta_copia_disenyo, ruta, fichero, texto_error, espacio_ocupado) <> 1 then
			if texto_error <> "" then
				FileWrite(f, texto_error)
				//st_info.text = texto_error
			end if
		end if
	else
		espacio_ocupado = espacio_ocupado + (FileLength64(ruta_archivo) / 1000000)
	end if
	
	barra_1.StepIt()
	i++
loop

if rtn = 1 then
	if solo_espacio then
		st_info.text = "Calculando espacio ocupado Colecciones"
	else
		st_info.text = "Realizando copia de Colecciones"
	end if
end if

if not solo_espacio then
	FileWrite(f, "Fin Modelos Diseño.")
	FileWrite(f, "Colecciones. Fecha inicio: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
end if

sel = "SELECT ruta, fichero FROM coleccion_sistema_archivos WHERE fecha_modificacion >= '"+fecha_inicio+"' OR (SELECT COUNT(*) FROM articulos WHERE articulos.empresa = coleccion_sistema_archivos.empresa AND articulos.modelo_origen IN (SELECT modelo.modelo FROM modelo WHERE modelo.coleccion =  coleccion_sistema_archivos.coleccion)) > 0 "
f_cargar_cursor_trans (SQLCA,  sel,  archivos)
numero = archivos.RowCount()
barra_1.setRange(0,numero)
i = 1
do while (i <= numero AND rtn = 1) 
	ruta = archivos.object.ruta[i]
	fichero = archivos.object.fichero[i]
	
	ruta_archivo = ruta_archivos_disenyo + ruta + fichero
	if not solo_espacio then
		//Proceso de copia de seguridad
		texto_error = ""
		if f_copia_seguridad(ruta_archivo, ruta_copia_disenyo, ruta, fichero, texto_error, espacio_ocupado) <> 1 then
			if texto_error <> "" then
				FileWrite(f, texto_error)
				//st_info.text = texto_error
			end if
		end if
	else
		espacio_ocupado = espacio_ocupado + (FileLength64(ruta_archivo) / 1000000)
	end if
	
	barra_1.StepIt()
	i++
loop

if rtn = 1 then
	if solo_espacio then
		st_info.text = "Calculando espacio ocupado Ambientes"
	else
		st_info.text = "Realizando copia de Ambientes"
	end if
end if

if not solo_espacio then
	FileWrite(f, "Fin Colecciones.")
	FileWrite(f, "Ambientes. Fecha inicio: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
end if

sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
f_cargar_cursor_trans (SQLCA,  sel,  tipos)

sel = "SELECT ruta, fichero FROM coleccion_archivo WHERE fecha_modificacion >= '"+fecha_inicio+"' OR (SELECT COUNT(*) FROM articulos WHERE articulos.empresa = coleccion_archivo.empresa AND articulos.modelo_origen IN (SELECT modelo.modelo FROM modelo WHERE modelo.coleccion =  coleccion_archivo.coleccion)) > 0 "
f_cargar_cursor_trans (SQLCA,  sel,  archivos)
numero = archivos.RowCount()
barra_1.setRange(0,numero)
i = 1
do while (i <= numero AND rtn = 1) 
	ruta = archivos.object.ruta[i]
	fichero = archivos.object.fichero[i]
	
	ruta_archivo = ruta_archivos_exposicion + ruta + fichero
	if not solo_espacio then
		//Proceso de copia de seguridad
		texto_error = ""
		if f_copia_seguridad(ruta_archivo, ruta_copia_expo, ruta, fichero, texto_error, espacio_ocupado) <> 1 then
			if texto_error <> "" then
				FileWrite(f, texto_error)
				//st_info.text = texto_error
			end if
		end if
		//IMÁGENES PARA CADA TAMAÑO
		numero_tipos = tipos.RowCount()
		j = 1
		Do while j <= numero_tipos and rtn = 1
			ruta_archivo = ruta_archivos_exposicion + ruta + tipos.object.tamanyo[j] + "\" + fichero
			res = f_copia_seguridad(ruta_archivo, ruta_copia_expo, ruta + tipos.object.tamanyo[j] + "\", fichero, texto_error, espacio_ocupado)
			if res <> 1 then
				if texto_error <> "" then
					FileWrite(f, texto_error)
				end if
			end if
			j++
		Loop
	else
		espacio_ocupado = espacio_ocupado + (FileLength64(ruta_archivo) / 1000000)
		//IMÁGENES PARA CADA TAMAÑO
		numero_tipos = tipos.RowCount()
		j = 1
		Do while j <= numero_tipos and rtn = 1
			ruta_archivo = ruta_archivos_exposicion + ruta + tipos.object.tamanyo[j] + "\" + fichero
			espacio_ocupado = espacio_ocupado + (FileLength64(ruta_archivo) / 1000000)
			j++
		Loop
	end if
	
	barra_1.StepIt()
	i++
loop

if rtn = 1 then
	if solo_espacio then
		st_info.text = "Calculando espacio ocupado JPGs Modelos"
	else
		st_info.text = "Realizando copia JPGs Modelos"
	end if
end if

if not solo_espacio then
	FileWrite(f, "Fin Ambientes.")
	FileWrite(f, "JPGs Modelos. Fecha inicio: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
end if

sel = "SELECT ruta, fichero FROM modelo_archivo_expo WHERE fecha_modificacion >= '"+fecha_inicio+"' OR (SELECT COUNT(*) FROM articulos WHERE articulos.empresa = modelo_archivo_expo.empresa AND articulos.modelo_origen = modelo_archivo_expo.modelo) > 0 "
f_cargar_cursor_trans (SQLCA,  sel,  archivos)
numero = archivos.RowCount()
barra_1.setRange(0,numero)
i = 1
do while (i <= numero AND rtn = 1) 
	ruta = archivos.object.ruta[i]
	fichero = archivos.object.fichero[i]
	
	ruta_archivo = ruta_archivos_exposicion + ruta + fichero
	if not solo_espacio then
		//Proceso de copia de seguridad
		texto_error = ""
		if f_copia_seguridad(ruta_archivo, ruta_copia_expo, ruta, fichero, texto_error, espacio_ocupado) <> 1 then
			if texto_error <> "" then
				FileWrite(f, texto_error)
				//st_info.text = texto_error
			end if
		end if
		//IMÁGENES PARA CADA TAMAÑO
		numero_tipos = tipos.RowCount()
		j = 1
		Do while j <= numero_tipos and rtn = 1
			ruta_archivo = ruta_archivos_exposicion + ruta + tipos.object.tamanyo[j] + "\" + fichero
			res = f_copia_seguridad(ruta_archivo, ruta_copia_expo, ruta + tipos.object.tamanyo[j] + "\", fichero, texto_error, espacio_ocupado)
			if res <> 1 then
				if texto_error <> "" then
					FileWrite(f, texto_error)
				end if
			end if
			j++
		Loop
	else
		espacio_ocupado = espacio_ocupado + (FileLength64(ruta_archivo) / 1000000)
		//IMÁGENES PARA CADA TAMAÑO
		numero_tipos = tipos.RowCount()
		j = 1
		Do while j <= numero_tipos and rtn = 1
			ruta_archivo = ruta_archivos_exposicion + ruta + tipos.object.tamanyo[j] + "\" + fichero
			espacio_ocupado = espacio_ocupado + (FileLength64(ruta_archivo) / 1000000)
			j++
		Loop
	end if
	
	barra_1.StepIt()
	i++
loop

if rtn = 1 then
	if solo_espacio then
		st_info.text = "Calculando espacio ocupado JPGs Piezas"
	else
		st_info.text = "Realizando copia JPGs Piezas"
	end if
end if

if not solo_espacio then
	FileWrite(f, "Fin JPGs Modelos.")
	FileWrite(f, "JPGs Piezas. Fecha inicio: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
end if

sel = "SELECT ruta, fichero FROM modelo_pieza_archivo WHERE fecha_modificacion >= '"+fecha_inicio+"' OR (SELECT COUNT(*) FROM articulos WHERE articulos.empresa = modelo_pieza_archivo.empresa AND articulos.modelo_origen IN (SELECT modelo_pieza.modelo FROM modelo_pieza WHERE modelo_pieza.empresa = modelo_pieza_archivo.empresa AND modelo_pieza.codigo_lab = modelo_pieza_archivo.pieza )) > 0 "
f_cargar_cursor_trans (SQLCA,  sel,  archivos)
numero = archivos.RowCount()
barra_1.setRange(0,numero)
i = 1
do while (i <= numero AND rtn = 1) 
	ruta = archivos.object.ruta[i]
	fichero = archivos.object.fichero[i]
	
	ruta_archivo = ruta_archivos_exposicion + ruta + fichero
	if not solo_espacio then
		//Proceso de copia de seguridad
		texto_error = ""
		if f_copia_seguridad(ruta_archivo, ruta_copia_expo, ruta, fichero, texto_error, espacio_ocupado) <> 1 then
			if texto_error <> "" then
				FileWrite(f, texto_error)
				//st_info.text = texto_error
			end if
		end if
		//IMÁGENES PARA CADA TAMAÑO
		numero_tipos = tipos.RowCount()
		j = 1
		Do while j <= numero_tipos and rtn = 1
			ruta_archivo = ruta_archivos_exposicion + ruta + tipos.object.tamanyo[j] + "\" + fichero
			res = f_copia_seguridad(ruta_archivo, ruta_copia_expo, ruta + tipos.object.tamanyo[j] + "\", fichero, texto_error, espacio_ocupado)
			if res <> 1 then
				if texto_error <> "" then
					FileWrite(f, texto_error)
				end if
			end if
			j++
		Loop
	else
		espacio_ocupado = espacio_ocupado + (FileLength64(ruta_archivo) / 1000000)
		//IMÁGENES PARA CADA TAMAÑO
		numero_tipos = tipos.RowCount()
		j = 1
		Do while j <= numero_tipos and rtn = 1
			ruta_archivo = ruta_archivos_exposicion + ruta + tipos.object.tamanyo[j] + "\" + fichero
			espacio_ocupado = espacio_ocupado + (FileLength64(ruta_archivo) / 1000000)
			j++
		Loop
	end if
	
	barra_1.StepIt()
	i++
loop
*/
if not solo_espacio then
	//FileWrite(f, "Fin JPGs Piezas.")
	FileWrite(f, "Inicio copia BD: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
	//MessageBox("", "robocopy "+ruta_copia+"BASE_DATOS\ "+ruta_bd+" /e /copyall /mir /R:2 /W:5 /log:"+ruta_copia+"log.txt /x /fp /XA:H ")
	ftc_ejecutar_concurrente("robocopy "+ruta_copia+"BASE_DATOS\ "+ruta_bd+" /e /copyall /mir /R:2 /W:5 /x /fp /XA:H ", 1, true)
	FileWrite(f, "Fin Copia BD.")
end if



/*
if not directorio.DirList(ruta_bd+"*.*", 0) then
	FileWrite(f, "ERROR: No se ha podido realizar copia de seguridad de la base de datos")
else
	FileWrite(f, "Inicio copia BD: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss"))
	
	
	
	FileWrite(f, "Fin Copia BD.")
end if
*/

if rtn = 1 then
	st_info.text = "Fin copia. Espacio total ocupado (diseño): "+String(espacio_ocupado, "###,##0.00")+" MB. Fecha Fin: "+String(Datetime(Today(), Now()), "dd-mm-yyyy hh:mm:ss")
end if

if not solo_espacio then
	FileWrite(f, st_info.text)
	FileClose(f)
end if

Destroy archivos
Destroy tipos


end event

type p_logo from picture within wtc_copia_seguridad
integer x = 2158
integer y = 16
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type st_titulo from statictext within wtc_copia_seguridad
integer x = 37
integer y = 32
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

