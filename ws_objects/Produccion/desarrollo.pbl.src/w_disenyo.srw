$PBExportHeader$w_disenyo.srw
forward
global type w_disenyo from w_ventana_padre_aplicaciones
end type
end forward

global type w_disenyo from w_ventana_padre_aplicaciones
integer x = 599
integer y = 752
integer width = 2930
integer height = 1916
string title = "Módulo de Diseño"
string menuname = "mi_disenyo"
long backcolor = 79741120
string icon = "Application!"
boolean toolbarvisible = false
end type
global w_disenyo w_disenyo

on w_disenyo.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_disenyo" then this.MenuID = create mi_disenyo
end on

on w_disenyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_parametros lstr_param
OpenSheetWithParm(w_disenyo_arbol,lstr_param, w_disenyo, 3,Original!)
end event

