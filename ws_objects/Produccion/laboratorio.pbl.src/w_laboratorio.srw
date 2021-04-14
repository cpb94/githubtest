$PBExportHeader$w_laboratorio.srw
forward
global type w_laboratorio from w_ventana_padre_aplicaciones
end type
end forward

global type w_laboratorio from w_ventana_padre_aplicaciones
integer x = 599
integer y = 752
integer width = 2930
integer height = 1916
string title = "Módulo de laboratorio"
string menuname = "mi_laboratorio"
long backcolor = 79741120
string icon = "Application!"
boolean toolbarvisible = false
end type
global w_laboratorio w_laboratorio

on w_laboratorio.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_laboratorio" then this.MenuID = create mi_laboratorio
end on

on w_laboratorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_parametros lstr_param
OpenSheetWithParm(w_laboratorio_arbol,lstr_param, w_laboratorio, 3,Original!)
end event

