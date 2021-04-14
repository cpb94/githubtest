$PBExportHeader$w_ventana_general.srw
forward
global type w_ventana_general from w_ventana_padre_aplicaciones
end type
end forward

global type w_ventana_general from w_ventana_padre_aplicaciones
integer width = 2935
integer height = 1928
string title = "Ventana General"
string menuname = "mi_ventana_general"
windowtype windowtype = mdi!
end type
global w_ventana_general w_ventana_general

on w_ventana_general.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_ventana_general" then this.MenuID = create mi_ventana_general
end on

on w_ventana_general.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;This.ToolbarVisible = false
end event

