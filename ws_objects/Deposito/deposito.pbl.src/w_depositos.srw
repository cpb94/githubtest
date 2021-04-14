$PBExportHeader$w_depositos.srw
forward
global type w_depositos from w_ventana_padre_aplicaciones
end type
end forward

global type w_depositos from w_ventana_padre_aplicaciones
integer width = 2935
integer height = 1928
string title = "Modulo de depositos"
string menuname = "wi_deposito"
end type
global w_depositos w_depositos

on w_depositos.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "wi_deposito" then this.MenuID = create wi_deposito
end on

on w_depositos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_parametros lstr_param
OpenSheetWithParm(w_depositos_arbol,lstr_param, w_depositos, 3,Original!)
end event

