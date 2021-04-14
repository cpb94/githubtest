$PBExportHeader$w_almacenv.srw
forward
global type w_almacenv from w_ventana_padre_aplicaciones
end type
end forward

global type w_almacenv from w_ventana_padre_aplicaciones
integer width = 2930
integer height = 1916
string title = "Modulo de almacen"
string menuname = "mi_almacenv"
end type
global w_almacenv w_almacenv

on w_almacenv.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_almacenv" then this.MenuID = create mi_almacenv
end on

on w_almacenv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;//str_parametros lstr_param
//OpenSheetWithParm(w_almacen_mapa,lstr_param,w_almacenv,3,original!)

str_parametros lstr_param
OpenSheetWithParm(w_almacenv_arbol,lstr_param, w_almacenv, 3,Original!)
end event

