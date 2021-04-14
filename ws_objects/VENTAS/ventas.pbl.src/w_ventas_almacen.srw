$PBExportHeader$w_ventas_almacen.srw
forward
global type w_ventas_almacen from w_ventana_padre_aplicaciones
end type
end forward

global type w_ventas_almacen from w_ventana_padre_aplicaciones
int Width=2935
int Height=1929
boolean TitleBar=true
string Title="Modulo de ventas"
string MenuName="wi_almacenv_ventas"
end type
global w_ventas_almacen w_ventas_almacen

on w_ventas_almacen.create
call w_ventana_padre_aplicaciones::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "wi_almacenv_ventas" then this.MenuID = create wi_almacenv_ventas
end on

on w_ventas_almacen.destroy
call w_ventana_padre_aplicaciones::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

