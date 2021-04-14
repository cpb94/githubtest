$PBExportHeader$w_promocion.srw
forward
global type w_promocion from w_ventana_padre_aplicaciones
end type
end forward

global type w_promocion from w_ventana_padre_aplicaciones
integer width = 2926
integer height = 1908
string title = "Modulo de promocion"
string menuname = "mi_promocion"
end type
global w_promocion w_promocion

on w_promocion.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_promocion" then this.MenuID = create mi_promocion
end on

on w_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_parametros lstr_param
OpenSheetWithParm(w_promocion_arbol,lstr_param, w_promocion, 3,Original!)
end event

