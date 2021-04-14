$PBExportHeader$w_mailing.srw
$PBExportComments$Pantalla principal.
forward
global type w_mailing from w_ventana_padre_aplicaciones
end type
end forward

global type w_mailing from w_ventana_padre_aplicaciones
integer width = 2930
integer height = 1916
string title = "Modulo de mailing"
string menuname = "mi_mailing"
end type
global w_mailing w_mailing

event open;call super::open;OpenSheet(w_mailing_mapa,This, 3,original!)

end event

on w_mailing.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_mailing" then this.MenuID = create mi_mailing
end on

on w_mailing.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

