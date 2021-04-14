$PBExportHeader$upb_imprimir.sru
$PBExportComments$PictureButton para Imprimir.
forward
global type upb_imprimir from picturebutton
end type
end forward

shared variables

end variables

global type upb_imprimir from picturebutton
integer width = 110
integer height = 96
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Print!"
vtextalign vtextalign = vcenter!
end type
global upb_imprimir upb_imprimir

type variables

end variables

on upb_imprimir.create
end on

on upb_imprimir.destroy
end on

