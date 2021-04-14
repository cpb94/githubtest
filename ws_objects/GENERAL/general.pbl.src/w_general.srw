$PBExportHeader$w_general.srw
$PBExportComments$Ventana para los Mantenimientos Generales. ~r~nMenu: "m_generales"
forward
global type w_general from w_ventana_padre_aplicaciones
end type
end forward

global type w_general from w_ventana_padre_aplicaciones
integer width = 2930
integer height = 1928
string title = "Modulo general"
string menuname = "mi_generales"
end type
global w_general w_general

on w_general.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_generales" then this.MenuID = create mi_generales
end on

on w_general.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_parametros lstr_param
OpenSheetWithParm(w_general_arbol,lstr_param,w_general, 3,Original!)
end event

