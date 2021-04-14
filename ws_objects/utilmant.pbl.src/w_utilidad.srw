$PBExportHeader$w_utilidad.srw
forward
global type w_utilidad from w_ventana_padre_aplicaciones
end type
end forward

global type w_utilidad from w_ventana_padre_aplicaciones
integer width = 3195
integer height = 2976
string title = "Modulo de utilidades"
string menuname = "mi_utilidad"
end type
global w_utilidad w_utilidad

on w_utilidad.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_utilidad" then this.MenuID = create mi_utilidad
end on

on w_utilidad.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;//open(w_utilidad_arbol, w_utilidad)

// lstr_param.i_nargumentos = 2
// lstr_param.s_argumentos[2] = v_apli
// OpenSheetWithParm(w_utilidad_arbol,lstr_param,This,3,original!)

str_parametros lstr_param
OpenSheetWithParm(w_utilidad_arbol,lstr_param,w_utilidad, 3,Original!)
end event

