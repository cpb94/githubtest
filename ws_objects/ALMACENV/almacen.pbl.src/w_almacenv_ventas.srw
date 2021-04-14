$PBExportHeader$w_almacenv_ventas.srw
forward
global type w_almacenv_ventas from w_ventana_padre_aplicaciones
end type
end forward

global type w_almacenv_ventas from w_ventana_padre_aplicaciones
int Width=2931
int Height=1917
boolean TitleBar=true
string Title="Modulo de Ventas"
string MenuName="mi_ventas_almacen"
end type
global w_almacenv_ventas w_almacenv_ventas

on w_almacenv_ventas.create
call w_ventana_padre_aplicaciones::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_ventas_almacen" then this.MenuID = create mi_ventas_almacen
end on

on w_almacenv_ventas.destroy
call w_ventana_padre_aplicaciones::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;OpenSheet(w_almacen_mapa,This, 3,original!)
end event

