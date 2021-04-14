$PBExportHeader$w_ventana_padre_aplicaciones.srw
$PBExportComments$Ventana Padre comun pantallas de modulos, controla la desconesión a los 15 minutos y errores del la base de datos de forma dinamica.
forward
global type w_ventana_padre_aplicaciones from window
end type
type mdi_1 from mdiclient within w_ventana_padre_aplicaciones
end type
end forward

global type w_ventana_padre_aplicaciones from window
integer width = 2953
integer height = 2480
boolean titlebar = true
string menuname = "mc_ayuda"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 12632256
string icon = "C:\bmp\tencer.ico"
mdi_1 mdi_1
end type
global w_ventana_padre_aplicaciones w_ventana_padre_aplicaciones

type variables
String texto_error
Integer pos_x,pos_y
end variables

event open;this.Icon = 'c:\bmp\tencer.ico'
n_aplicaciones = n_aplicaciones + 1
timer(60)
tiempo_limite = 0
//ventana_padre = This

end event

event timer;// Se controlan los errores de las bases de datos//
//===============================================//

IF sqlca.SqlCode<0 Then
	IF texto_error <> Sqlca.Sqlerrtext or len(texto_error) = 0 Then	
		setpointer(Cross!)
		texto_error    = Sqlca.Sqlerrtext
		f_grabar_incidencia(This.Title,texto_error)
		MessageBox(" (¡¡¡ERROR!!!)  Avise al administrador del sistema ","Error en base de datos ~n"+texto_error,StopSign!,OK!,1)
		setpointer(Arrow!)
	END IF
END IF

//Arrow!Cross! Beam!HourGlass!SizeNS!SizeNESW!SizeWE!SizeNWSE!UpArrow!
// Actualizo reloj
la_hora = DateTime(Today(),Now())
This.SetMicroHelp (f_la_hora() + "   " + Parent_mensaje)


// Control tiempo_limite
IF control_tiempo_limite = "S" Then
	IF pos_x = This.PointerX() and pos_y = This.PointerY() Then
    IF tiempo_limite >= 0 Then  tiempo_limite = tiempo_limite +1
	ELSE
	 f_inicializar_tiempo_limite()
	END IF
pos_x = This.PointerX()
pos_y = This.PointerY()
IF tiempo_limite = f_tiempo_limite_uti_parametros(codigo_empresa) - 60 Then Open(w_desconexion_limite)
IF tiempo_limite = f_tiempo_limite_uti_parametros(codigo_empresa) Then
  tiempo_limite = -1
  Close(This)
  DO WHILE  tiempo_limite = -1
	IF f_pedir_clave_usuario()  Then 
		tiempo_limite = 0
	END IF
 
  LOOP
  tiempo_limite = 0
END IF
END IF

IF control_mensajes = "S" Then
	Dec nu
	Select count(*) Into :nu From utimensajes
	Where empresa = :codigo_empresa
	And   destino = :nombre_usuario;
	IF IsNUll(nu) Then nu = 0
	IF nu <> 0 Then
		control_mensajes = "N"
		str_parametros lstr_param
		OpenSheetWithParm(w_con_mensajes_usuarios, lstr_param, this, 3,original!)
	END IF
END IF
end event

on w_ventana_padre_aplicaciones.create
if this.MenuName = "mc_ayuda" then this.MenuID = create mc_ayuda
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_ventana_padre_aplicaciones.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event key; f_inicializar_tiempo_limite()

end event

event close;n_aplicaciones = n_aplicaciones - 1
end event

type mdi_1 from mdiclient within w_ventana_padre_aplicaciones
long BackColor=12632256
end type

