$PBExportHeader$w_conta.srw
forward
global type w_conta from w_ventana_padre_aplicaciones
end type
end forward

global type w_conta from w_ventana_padre_aplicaciones
integer width = 2935
integer height = 1920
string title = "Modulo de contabilidad"
string menuname = "mi_conta"
end type
global w_conta w_conta

on w_conta.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_conta" then this.MenuID = create mi_conta
end on

on w_conta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_parametros lstr_param
OpenSheetWithParm(w_conta_arbol,lstr_param, w_conta, 3,Original!)
end event

