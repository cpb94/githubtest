$PBExportHeader$w_errores_sistema.srw
$PBExportComments$Visualiza información sobre errores del sistema. Es llamado por el evento "systemerror" de la aplicacion.
forward
global type w_errores_sistema from window
end type
type cb_salir from u_boton within w_errores_sistema
end type
type cb_imprimir from u_boton within w_errores_sistema
end type
type cb_continuar from u_cancelar within w_errores_sistema
end type
type dw_error from datawindow within w_errores_sistema
end type
end forward

global type w_errores_sistema from window
integer x = 320
integer y = 420
integer width = 2171
integer height = 1088
boolean titlebar = true
string title = "System Error"
windowtype windowtype = response!
long backcolor = 12632256
cb_salir cb_salir
cb_imprimir cb_imprimir
cb_continuar cb_continuar
dw_error dw_error
end type
global w_errores_sistema w_errores_sistema

type variables

end variables

event open;/////////////////////////////////////////////////////////////////////////
// 
// 		Grabacion del error producido.
// 
/////////////////////////////////////////////////////////////////////////

string ls_fichero_errores
integer li_num_fichero

ls_fichero_errores = ProfileString ("pb.ini", "errores", "fichero", "")

li_num_fichero = FileOpen(ls_fichero_errores, &
									LineMode!,Write!,LockWrite!,Append!)

		// Datos a grabar

	FileWrite(li_num_fichero,"************************************************************************")
	FileWrite(li_num_fichero,"Fecha: " + String(today(),"dd/mm/yyyy") + &
									 "   Hora: " + String(now(),"hh:mm:ss") )
	FileWrite(li_num_fichero,"------------------------------------------------------------------------")
	FileWrite(li_num_fichero,"ERROR: " + string(error.number) + "   " + error.text)
	FileWrite(li_num_fichero," ")
	FileWrite(li_num_fichero,"Ventana/Menu: " + error.windowmenu )
	FileWrite(li_num_fichero,"Objeto      : " + error.object)
	FileWrite(li_num_fichero,"Evento      : " + error.objectevent)
	FileWrite(li_num_fichero,"Nº de Linea : " + String(error.line))
	FileWrite(li_num_fichero," ")
	FileWrite(li_num_fichero," ")

FileClose(li_num_fichero)


/////////////////////////////////////////////////////////////////////////
// 
// 			Visualiza los errores de sistema y permite al usuario 
//				continuar con la aplicacion, o imprimir el error.
//
///////////////////////////////////////////////////////////////////////////

dw_error.insertrow (1)

dw_error.setitem (1,"numero_error",string(error.number))
dw_error.setitem (1,"texto_mensaje" ,error.text)
dw_error.setitem (1,"donde"   ,error.windowmenu)
dw_error.setitem (1,"objecto"  ,error.object)
dw_error.setitem (1,"evento"   ,error.objectevent)
dw_error.setitem (1,"linea"    ,string(error.line))
f_grabar_incidencia(error.windowmenu,Trim(error.text)+&
                    " "+ Trim(error.object)+ " "+ Trim(error.objectevent)&
                    + " Ln"+ Trim(String(error.line)))
						  
	  
	  
						  
						  
end event

on w_errores_sistema.create
this.cb_salir=create cb_salir
this.cb_imprimir=create cb_imprimir
this.cb_continuar=create cb_continuar
this.dw_error=create dw_error
this.Control[]={this.cb_salir,&
this.cb_imprimir,&
this.cb_continuar,&
this.dw_error}
end on

on w_errores_sistema.destroy
destroy(this.cb_salir)
destroy(this.cb_imprimir)
destroy(this.cb_continuar)
destroy(this.dw_error)
end on

type cb_salir from u_boton within w_errores_sistema
integer x = 206
integer y = 840
integer width = 462
integer height = 92
integer taborder = 40
string text = "Salir Aplicación"
end type

on clicked;call u_boton::clicked;/////////////////////////////////////////////////////////////////////////
//
// 			Finaliza la aplicacion
//
/////////////////////////////////////////////////////////////////////////

HALT close
end on

type cb_imprimir from u_boton within w_errores_sistema
integer x = 1440
integer y = 840
integer width = 462
integer height = 92
integer taborder = 30
string text = "&Imprimir"
end type

on clicked;call u_boton::clicked;/////////////////////////////////////////////////////////////////////////
//
// 			Imprime el mensaje de error.
//
///////////////////////////////////////////////////////////////////////////

string ls_linea
int	li_prt

li_prt   = printopen("**** ERROR ****")

	// Imprime las Variables

print    (li_prt, "Mensaje de Error - "+string(today(),"dd/mm/yyyy") + &
						" - " + string(now(), "HH:MM:SS"))
print    (li_prt, " ")

ls_linea = "Numero de Error  : " + getitemstring(dw_error,1,1)
print    (li_prt, ls_linea)

ls_linea = "Mensaje de Error : " + getitemstring(dw_error,1,2)
print    (li_prt, ls_linea)

ls_linea = "Ventana/Menu     : " + getitemstring(dw_error,1,3)
print    (li_prt, ls_linea)

ls_linea = "Objecto          : " + getitemstring(dw_error,1,4)
print    (li_prt, ls_linea)

ls_linea = "Evento           : " + getitemstring(dw_error,1,5)
print    (li_prt, ls_linea)

ls_linea = "Numero de Linea  : " + getitemstring(dw_error,1,6)
print    (li_prt, ls_linea)

printclose(li_prt)
return
end on

type cb_continuar from u_cancelar within w_errores_sistema
integer x = 823
integer y = 840
integer width = 462
integer height = 92
integer taborder = 20
string text = "&Continuar"
end type

type dw_error from datawindow within w_errores_sistema
integer x = 23
integer y = 20
integer width = 2080
integer height = 740
integer taborder = 10
boolean enabled = false
string dataobject = "dw_errores_sistema"
borderstyle borderstyle = styleshadowbox!
end type

