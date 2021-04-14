$PBExportHeader$wt_padre_vacio.srw
forward
global type wt_padre_vacio from window
end type
type pb_salir from picturebutton within wt_padre_vacio
end type
type st_titulo from statictext within wt_padre_vacio
end type
type p_logo from picture within wt_padre_vacio
end type
end forward

global type wt_padre_vacio from window
integer width = 4398
integer height = 2828
boolean titlebar = true
string title = "Consulta de Diseño"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_cerrar_sin_abrir ( )
pb_salir pb_salir
st_titulo st_titulo
p_logo p_logo
end type
global wt_padre_vacio wt_padre_vacio

type variables
int id_ventana_activa
long fila_inicial = 0

//Permisos
Boolean cerrar_sin_abrir
Int permiso_ventana
string is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas
boolean ib_control_acceso_pasado = false
end variables

forward prototypes
public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key)
end prototypes

event ue_cerrar_sin_abrir();if cerrar_sin_abrir = true then
	close(this)
end if
end event

public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key);If arg_KeyFlags = 2 then
	choose case arg_key
		case KeyEnter!
		case KeyN!
		case KeyS!
	end choose		
else
	choose case arg_Key
		case KeyEnter!
		case KeyF2!
		case KeyF3!
		case KeyF4!
		case KeyF8!
		case KeyEscape!
			pb_salir.triggerevent(clicked!)
	end choose		
end if


end subroutine

on wt_padre_vacio.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.pb_salir=create pb_salir
this.st_titulo=create st_titulo
this.p_logo=create p_logo
this.Control[]={this.pb_salir,&
this.st_titulo,&
this.p_logo}
end on

on wt_padre_vacio.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_salir)
destroy(this.st_titulo)
destroy(this.p_logo)
end on

event open;
//cerrar_sin_abrir = false
//
////PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana FROM uti_permisos_ventana P INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	
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
	
	//Codigo Ventana
	select nombre
	into :st_titulo.text
	from empresas
	where empresa = :codigo_empresa;
	
//end if


end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

if not(ib_control_acceso_pasado) then
	IF guo_menu_utigrupos.of_menu_leer_permiso (gs_usuarios_v_grupo, codigo_empresa, This.ClassName (), 'activo') = '0' THEN
		MessageBox ("Permisos", "NO tiene permisos para acceder a esta ventana¡", StopSign!)
		Close (this)
	ELSE
		//Compatibilidad permisos GNO con permisos Tencer
		guo_menu_utigrupos.of_menu_leer_permiso_total(gs_usuarios_v_grupo,codigo_empresa,This.ClassName(),is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas)
		
		if is_permiso_altas = 'S' or is_permiso_bajas = 'S' or is_permiso_cambios = 'S' then
			permiso_ventana = 2 //Permisos escritura
		else
			if is_permiso_consultas = 'S' then
				permiso_ventana = 1 //Permisos lectura
			else
				permiso_ventana = 0 //Sin permisos
			end if
		end if
		//Compatibilidad permisos GNO con permisos Tencer		
		ib_control_acceso_pasado = true
	END IF
end if


end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

event key;control_teclas (keyflags, key)

end event

type pb_salir from picturebutton within wt_padre_vacio
integer x = 4160
integer y = 116
integer width = 146
integer height = 128
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Log Out_24x24gris.png"
boolean map3dcolors = true
string powertiptext = "Salir (Esc)"
end type

event clicked;close(parent)


end event

type st_titulo from statictext within wt_padre_vacio
integer x = 41
integer y = 20
integer width = 3118
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

type p_logo from picture within wt_padre_vacio
integer x = 3803
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

