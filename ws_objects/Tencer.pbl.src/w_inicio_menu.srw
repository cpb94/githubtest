$PBExportHeader$w_inicio_menu.srw
forward
global type w_inicio_menu from w_ventana_padre_inicio
end type
end forward

global type w_inicio_menu from w_ventana_padre_inicio
string tag = "INICIO"
integer width = 1504
integer height = 4000
string title = "Menu Principal"
string menuname = "mtc_menu_principal"
boolean resizable = true
windowstate windowstate = normal!
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = topslide!
end type
global w_inicio_menu w_inicio_menu

forward prototypes
public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso)
end prototypes

public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso);
end subroutine

on w_inicio_menu.create
call super::create
if this.MenuName = "mtc_menu_principal" then this.MenuID = create mtc_menu_principal
end on

on w_inicio_menu.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event closequery;call super::closequery;f_menu_cerrar_aplicacion(false)
end event

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_menu
integer x = 1294
integer y = 0
integer width = 174
integer height = 152
integer taborder = 10
boolean originalsize = false
end type

