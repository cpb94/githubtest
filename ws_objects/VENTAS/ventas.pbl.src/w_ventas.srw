$PBExportHeader$w_ventas.srw
forward
global type w_ventas from w_ventana_padre_aplicaciones
end type
end forward

global type w_ventas from w_ventana_padre_aplicaciones
integer width = 2935
integer height = 1928
string title = "Modulo de ventas"
string menuname = "wi_ventas"
end type
global w_ventas w_ventas

on w_ventas.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "wi_ventas" then this.MenuID = create wi_ventas
end on

on w_ventas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_parametros lstr_param
OpenSheetWithParm(w_ventas_arbol,lstr_param, w_ventas, 3,Original!)
end event

