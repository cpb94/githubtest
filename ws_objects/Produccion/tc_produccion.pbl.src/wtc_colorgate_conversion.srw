$PBExportHeader$wtc_colorgate_conversion.srw
forward
global type wtc_colorgate_conversion from window
end type
type dw_errores from datawindow within wtc_colorgate_conversion
end type
type st_info from statictext within wtc_colorgate_conversion
end type
type pb_1 from picturebutton within wtc_colorgate_conversion
end type
type barra_1 from hprogressbar within wtc_colorgate_conversion
end type
type cb_1 from commandbutton within wtc_colorgate_conversion
end type
type p_logo from picture within wtc_colorgate_conversion
end type
type st_titulo from statictext within wtc_colorgate_conversion
end type
end forward

global type wtc_colorgate_conversion from window
integer width = 5102
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
st_info st_info
pb_1 pb_1
barra_1 barra_1
cb_1 cb_1
p_logo p_logo
st_titulo st_titulo
end type
global wtc_colorgate_conversion wtc_colorgate_conversion

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

on wtc_colorgate_conversion.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.dw_errores=create dw_errores
this.st_info=create st_info
this.pb_1=create pb_1
this.barra_1=create barra_1
this.cb_1=create cb_1
this.p_logo=create p_logo
this.st_titulo=create st_titulo
this.Control[]={this.dw_errores,&
this.st_info,&
this.pb_1,&
this.barra_1,&
this.cb_1,&
this.p_logo,&
this.st_titulo}
end on

on wtc_colorgate_conversion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_errores)
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
barra_1.Position = 1

end event

type dw_errores from datawindow within wtc_colorgate_conversion
integer x = 78
integer y = 356
integer width = 4951
integer height = 1140
integer taborder = 10
string title = "none"
string dataobject = "dwtc_aux_errores_traspaso"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_info from statictext within wtc_colorgate_conversion
integer x = 942
integer y = 120
integer width = 3305
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

type pb_1 from picturebutton within wtc_colorgate_conversion
integer x = 4878
integer y = 168
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

type barra_1 from hprogressbar within wtc_colorgate_conversion
integer x = 37
integer y = 1544
integer width = 4983
integer height = 68
unsignedinteger minposition = 1
unsignedinteger maxposition = 100
unsignedinteger position = 1
integer setstep = 1
end type

type cb_1 from commandbutton within wtc_colorgate_conversion
integer x = 82
integer y = 164
integer width = 709
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Iniciar Conversión"
end type

event clicked;String ruta_temporal_conversion = "\\amazonas\HOTFOLDERS\CONVERSION\TEMP\"
String ruta_saco, archivo, codigo, ruta, fichero, ruta_absoluta, ruta_absoluta_txt, ruta_archivos_disenyo, perfil, codigo_perfil, perfil_actual, perfil_nuevo, ruta_conversor, bloqueo
Boolean fin = false
Long f, bytes, total_aproximado, contador,fila
Long n_beb = 0, n_mem = 0, n_msm_alta = 0, n_msm_baja = 0, n_bsb_alta = 0, n_bsb_baja = 0, erroneos = 0
str_colisiones param_colisiones

String ruta_copia_seguridad
String ruta_beb
String ruta_mem
String ruta_msm_alta
String ruta_msm_baja
String ruta_bsb_alta
String ruta_bsb_baja

dw_errores.reset()

st_info.text = "Inciado."

SELECT ruta_archivos_disenyo, ruta_archivos_cambio_perfil INTO :ruta_archivos_disenyo, :ruta_saco FROM empresas WHERE empresa = :codigo_empresa USING SQLCA;
SELECT COUNT(*) INTO :total_aproximado FROM archivo_disenyo_sistema_archivos WHERE empresa = :codigo_empresa AND perfil_origen IS NULL AND tipomaquina_disenyo = '1' USING SQLCA;
barra_1.setRange(1,total_aproximado)
barra_1.position = 1
contador = 0

do while fin = false
	contador++
	
	transaction trm
	f_crear_transaccion(trm,"","",false,"TS","")
	CONNECT USING trm;
	archivo = ""
	
	SELECT TOP 1 archivo_disenyo_sistema_archivos.archivo, archivo_disenyo_sistema_archivos.codigo, archivo_disenyo_sistema_archivos.ruta, archivo_disenyo_sistema_archivos.fichero, archivo_disenyo_sistema_archivos.perfil_color, perfil_color.nuevo_perfil, perfil_color.ruta_conversion
	INTO :archivo, :codigo, :ruta, :fichero, :perfil_actual, :perfil_nuevo, :ruta_conversor
 	FROM archivo_disenyo_sistema_archivos 
	INNER JOIN perfil_color ON archivo_disenyo_sistema_archivos.empresa = perfil_color.empresa AND archivo_disenyo_sistema_archivos.perfil_color = perfil_color.codigo AND perfil_color.nuevo_perfil IS NOT NULL
	WHERE archivo_disenyo_sistema_archivos.empresa = :codigo_empresa 
	AND archivo_disenyo_sistema_archivos.perfil_origen IS NULL 
	AND archivo_disenyo_sistema_archivos.tipomaquina_disenyo = '1'
	ORDER BY CONVERT(integer, archivo) ASC USING sqlca;
	
	if isnull(archivo) or archivo = "" then
		fin = true
	else
		//Bloqueo BD
		bloqueo = ""
		SELECT perfil_origen INTO :bloqueo FROM archivo_disenyo_sistema_archivos  
		WHERE empresa = :codigo_empresa AND archivo = :archivo AND codigo = :codigo AND tipomaquina_disenyo = '1' USING trm;
		
		if isnull(bloqueo) or bloqueo = "" then
			//Obtención Ruta Fichero
			ruta_absoluta = ruta_archivos_disenyo + ruta + fichero
			
			//Comprobamos que el fichero está en su ruta, si no lo borramos de BD
			if not fileExists(ruta_absoluta) then
				//Error archivo - No está en su ruta - Saltamos el archivo
				fila = dw_errores.insertrow(0)
				dw_errores.object.tipo[fila] = 1
				dw_errores.object.error[fila] = "NO EXISTE TIF: "+fichero+ " RUTA: "+ruta_absoluta+ " Se borrará de BD"
				dw_errores.object.tif[fila] = codigo
				
				DELETE FROM archivo_disenyo_sistema_archivos WHERE empresa = :codigo_empresa AND archivo = :archivo AND codigo = :codigo AND tipomaquina_disenyo = '1' USING trm;
				if trm.sqlcode <> 0 then 
					//Error Crítico - Puede provocar bucle infinito
					st_info.text = "Error borrar BD.TIF: "+fichero+ " RUTA: "+ruta_absoluta
					fin = true
					ROLLBACK USING trm;
				else
					COMMIT USING trm;
				end if
			else				
				//Conversión del fichero
				ftc_ejecutar_concurrente (ruta_conversor + ' "'+ ruta_absoluta + '"', 1, true) //Esta orden ejecuta el conversor, dejando el fichero generado en la ruta_temporal_conversion especificada arriba del todo
				st_info.text = "Fichero " + String(contador) + " de "+ String(total_aproximado) +" (Apróx): "+ fichero
				
				//Comprobamos que efectivamente se ha generado el archivo convertido
				if not fileExists(ruta_temporal_conversion + fichero) then
					//Error Crítico - Puede provocar bucle infinito
					st_info.text = "Error conversión TIFF: "+fichero+ " RUTA: "+ruta_absoluta
					fin = true
				end if
				
				/*
				//SOLO EN VERSIÓN DEFINITIVA
				//Movemos el archivo original al saco
				if fin = false then
					if fileMove(ruta_absoluta, ruta_saco + fichero) <> 1 then
						//Error Crítico - Puede provocar bucle infinito
						st_info.text = "No se ha podido mover el TIFF original "+fichero+ " al 'saco': "+ruta_absoluta
						fin = true
					end if
				end if
				
				//Movemos el archivo convertido a la ubicación original		
				if fin = false then
					if fileMove(ruta_temporal_conversion + fichero, ruta_absoluta) <> 1 then
						//Error Crítico - Puede provocar bucle infinito
						st_info.text = "No se ha podido mover el TIFF convertido "+fichero+ " a su ruta original: "+ruta_absoluta
						fin = true
					end if
				end if
				*/
				
				//Actualización BD si todo ok
				if fin = false then
					/* 
					//VERSION DEFINITIVA
					UPDATE archivo_disenyo_sistema_archivos 
					SET perfil_color = :perfil_nuevo, perfil_origen = :perfil_actual
					WHERE empresa = :codigo_empresa AND archivo = :archivo AND codigo = :codigo 
					USING trm;
					*/
					//TEMPORAL
					UPDATE archivo_disenyo_sistema_archivos 
					SET perfil_origen = :perfil_actual
					WHERE empresa = :codigo_empresa AND archivo = :archivo AND codigo = :codigo and tipomaquina_disenyo = '1'
					USING trm;
					//FIN TEMPORAL
					if trm.sqlcode <> 0 then 
						//Error Crítico - Puede provocar bucle infinito
						st_info.text = "Error actualización BD.TIF: "+fichero+ " RUTA: "+ruta_absoluta
						fin = true
						ROLLBACK USING trm;
					else
						COMMIT USING trm;
					end if
				end if //Fin if UPDATE BD
			end if //Fin if No EXISTE FICHERO
		end if //Fin if bloqueo
		
		DISCONNECT USING trm;
		Destroy trm
		
	end if
	barra_1.StepIt()
loop

f_imprimir_errores()
end event

type p_logo from picture within wtc_colorgate_conversion
integer x = 4498
integer y = 36
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type st_titulo from statictext within wtc_colorgate_conversion
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

