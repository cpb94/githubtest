$PBExportHeader$wtc_ficheros_sin_archivo.srw
forward
global type wtc_ficheros_sin_archivo from window
end type
type dw_errores from datawindow within wtc_ficheros_sin_archivo
end type
type st_info from statictext within wtc_ficheros_sin_archivo
end type
type pb_1 from picturebutton within wtc_ficheros_sin_archivo
end type
type barra_1 from hprogressbar within wtc_ficheros_sin_archivo
end type
type cb_1 from commandbutton within wtc_ficheros_sin_archivo
end type
type p_logo from picture within wtc_ficheros_sin_archivo
end type
type st_titulo from statictext within wtc_ficheros_sin_archivo
end type
end forward

global type wtc_ficheros_sin_archivo from window
integer width = 5102
integer height = 1816
boolean titlebar = true
string title = "Ficheros sin archivo"
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
global wtc_ficheros_sin_archivo wtc_ficheros_sin_archivo

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

on wtc_ficheros_sin_archivo.create
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

on wtc_ficheros_sin_archivo.destroy
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

type dw_errores from datawindow within wtc_ficheros_sin_archivo
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

type st_info from statictext within wtc_ficheros_sin_archivo
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

type pb_1 from picturebutton within wtc_ficheros_sin_archivo
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

type barra_1 from hprogressbar within wtc_ficheros_sin_archivo
integer x = 37
integer y = 1544
integer width = 4983
integer height = 68
unsignedinteger minposition = 1
unsignedinteger maxposition = 100
unsignedinteger position = 1
integer setstep = 1
end type

type cb_1 from commandbutton within wtc_ficheros_sin_archivo
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
string text = "Obtener Listado"
end type

event clicked;String sel, ruta, fichero, ruta_absoluta, ruta_archivos_disenyo
Long i, numero, fila, contador
Datastore ficheros

dw_errores.reset()

st_info.text = "Inciado."

SELECT ruta_archivos_disenyo INTO :ruta_archivos_disenyo FROM empresas WHERE empresa = :codigo_empresa USING SQLCA;

sel = "SELECT ruta, fichero "+&
"FROM archivo_disenyo_sistema_archivos "+&
"WHERE empresa = '"+codigo_empresa+"' "+&
"ORDER BY CONVERT(integer, archivo) ASC"

f_cargar_cursor_trans (SQLCA,  sel,  ficheros)
numero = ficheros.RowCount()
barra_1.setRange(1,numero)
i = 1
contador = 0
do while (i <= numero) 	
	st_info.text = "Fichero "+String(i)+" de "+String(numero)
	
	ruta = ficheros.object.ruta[i]
	fichero = ficheros.object.fichero[i]
	ruta_absoluta = ruta_archivos_disenyo + ruta + fichero
	
	if not fileExists(ruta_absoluta) then
		//Error archivo - No está en su ruta
		fila = dw_errores.insertrow(0)
		dw_errores.object.tipo[fila] = 1
		dw_errores.object.error[fila] = "NO EXISTE TIF: "+fichero+ " RUTA: "+ruta_absoluta+ " Se borrará de BD"
		dw_errores.object.tif[fila] = fichero
		contador++
	end if
	
	barra_1.StepIt()
	i++
loop

st_info.text = "Fin. Errores = "+String(contador)

Destroy ficheros
f_imprimir_errores()
end event

type p_logo from picture within wtc_ficheros_sin_archivo
integer x = 4498
integer y = 36
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type st_titulo from statictext within wtc_ficheros_sin_archivo
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

