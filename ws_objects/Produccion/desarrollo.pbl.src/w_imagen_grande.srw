$PBExportHeader$w_imagen_grande.srw
forward
global type w_imagen_grande from window
end type
type p_imagen from picture within w_imagen_grande
end type
end forward

global type w_imagen_grande from window
integer width = 2482
integer height = 832
boolean titlebar = true
string title = "Imagen"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 134217729
string icon = "C:\bmp\tencer.ico"
boolean center = true
p_imagen p_imagen
end type
global w_imagen_grande w_imagen_grande

on w_imagen_grande.create
this.p_imagen=create p_imagen
this.Control[]={this.p_imagen}
end on

on w_imagen_grande.destroy
destroy(this.p_imagen)
end on

event key;


//w_con_colecciones_trabajos2.visible = true
end event

type p_imagen from picture within w_imagen_grande
integer x = 37
integer y = 36
integer width = 2341
integer height = 124
boolean originalsize = true
string picturename = "\\Amazonas\IMAGENES2\aaaaaaaaaaaaaaeeeeeeeeeeee3.jpg"
boolean focusrectangle = false
end type

