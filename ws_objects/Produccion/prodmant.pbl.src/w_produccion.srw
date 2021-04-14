$PBExportHeader$w_produccion.srw
forward
global type w_produccion from w_ventana_padre_aplicaciones
end type
end forward

global type w_produccion from w_ventana_padre_aplicaciones
integer x = 599
integer y = 752
integer width = 2930
integer height = 1916
string title = "Módulo de producción"
string menuname = "mi_produccion"
long backcolor = 79741120
string icon = "Application!"
boolean toolbarvisible = false
end type
global w_produccion w_produccion

on w_produccion.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_produccion" then this.MenuID = create mi_produccion
end on

on w_produccion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_parametros lstr_param
OpenSheetWithParm(w_produccion_arbol,lstr_param, w_produccion, 3,Original!)
end event

