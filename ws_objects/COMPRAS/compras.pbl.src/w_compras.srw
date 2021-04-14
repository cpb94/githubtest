$PBExportHeader$w_compras.srw
forward
global type w_compras from w_ventana_padre_aplicaciones
end type
end forward

global type w_compras from w_ventana_padre_aplicaciones
string title = "Módulo de compras"
string menuname = "mi_compras"
end type
global w_compras w_compras

on w_compras.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_compras" then this.MenuID = create mi_compras
end on

on w_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;f_agrupa_ubicaciones_compras()

str_parametros lstr_param
OpenSheetWithParm(w_compras_arbol,lstr_param, w_compras, 3,Original!)
end event

