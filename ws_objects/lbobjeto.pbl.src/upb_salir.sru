$PBExportHeader$upb_salir.sru
$PBExportComments$PictureButton de Cerrar Ventana.
forward
global type upb_salir from picturebutton
end type
end forward

global type upb_salir from picturebutton
integer width = 160
integer height = 156
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean cancel = true
string picturename = "Exit!"
vtextalign vtextalign = vcenter!
event mover_raton pbm_mousemove
event timer pbm_timer
end type
global upb_salir upb_salir

event mover_raton;//This.picturename="\bmp\salir2.bmp"


end event

event clicked;Close (Parent)
end event

on upb_salir.create
end on

on upb_salir.destroy
end on

