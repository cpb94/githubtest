$PBExportHeader$w_ventana_padre_inicio.srw
$PBExportComments$Ventana Padre comun pantallas de modulos, controla la desconesión a los 15 minutos y errores del la base de datos de forma dinamica.
forward
global type w_ventana_padre_inicio from window
end type
type pb_salir from upb_salir within w_ventana_padre_inicio
end type
end forward

global type w_ventana_padre_inicio from window
integer width = 2770
integer height = 1784
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowstate windowstate = maximized!
long backcolor = 12632256
string icon = "C:\bmp\tencer.ico"
pb_salir pb_salir
end type
global w_ventana_padre_inicio w_ventana_padre_inicio

type variables

end variables

forward prototypes
public subroutine wf_abrir_ventana (ref window aw_nomventana, string as_titulo)
end prototypes

public subroutine wf_abrir_ventana (ref window aw_nomventana, string as_titulo);OpenWithParm(aw_nomventana,as_titulo)
end subroutine

event close;Delete from uticonexiones
Where  usuario = :nombre_usuario
And    fecha   = :fecha_conexion;

COMMIT;

disconnect using sqlca;
disconnect using trans_cursor;

disconnect using trans_ts; 
end event

event open;this.Icon = 'c:\bmp\tencer.ico'
This.x=1
This.y=1
This.Title = "Menu Principal"

f_cargar_menu_new (This)
end event

on w_ventana_padre_inicio.create
this.pb_salir=create pb_salir
this.Control[]={this.pb_salir}
end on

on w_ventana_padre_inicio.destroy
destroy(this.pb_salir)
end on

event closequery;IF n_aplicaciones <> 0 Then
	f_mensaje("No se puede cerrar la pantalla principal","Existen aplicaciones en curso")
	return 1
END IF

connect using SQLCA;
delete from uti_colisiones
where usuario = :nombre_usuario 
using sqlca;

if SQLCA.SqlCode = -1 then
	rollback using SQLCA;
	f_mensaje("Avise al administrador del Sistema","No se pueden borrar los registros de colisión.")
else
	commit using SQLCA;
end if
end event

event activate;//if not(ib_control_acceso_pasado) then
//	IF guo_menu_utigrupos.of_menu_leer_permiso (gs_usuarios_v_grupo, String (codigo_empresa), This.ClassName (), 'activo') = '0' THEN
//		MessageBox ("Permisos", "¡No tiene permisos para acceder a este modulo!",StopSign!)
//		Close(this)
//	ELSE
//		ib_control_acceso_pasado = true
//		ventana_padre = This
//	END IF
//else
//	ventana_padre = This
//end if
end event

type pb_salir from upb_salir within w_ventana_padre_inicio
integer x = 2528
integer y = 72
integer width = 110
integer height = 96
integer taborder = 40
boolean originalsize = true
end type

event clicked;IF n_aplicaciones = 0 Then
	Call Super::Clicked
ELse
	f_mensaje("No se puede cerrar la pantalla principal","Existen aplicaciones en curso")
END IF
	
end event

