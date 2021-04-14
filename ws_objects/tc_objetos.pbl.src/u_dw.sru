$PBExportHeader$u_dw.sru
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
integer width = 2953
integer height = 1492
string title = "none"
boolean border = false
boolean livescroll = true
event usr_dwnkey pbm_dwnkey
end type
global u_dw u_dw

type variables
Boolean marcar_filas = false
end variables

on u_dw.create
end on

on u_dw.destroy
end on

event doubleclicked;this.EVENT usr_dwnkey(KeyEnter!, 0)
end event

event rowfocuschanged;if marcar_filas then
	if This.GetRow() > 0 then
		This.SelectRow(0, false)
  		This.SelectRow(This.GetRow(), true)	
	end if
end if
end event

event retrieveend;/*
if marcar_filas and rowcount > 0 then
	This.setrow(1)
	This.scrolltorow(1)
	This.SelectRow(0, false)
	This.SelectRow(1, true)
end if
*/
end event

event losefocus;//Evitamos que se queden valores sin introducir en un DW al cambiar de objeto (por ejemplo un clic en un botón)
//this.event usr_dwnkey(KeyTab!, 0) //No funciona
//this.triggerevent("itemchanged") //Hay que comprobar que no hay fallos por los valores null que recibe el evento
end event

