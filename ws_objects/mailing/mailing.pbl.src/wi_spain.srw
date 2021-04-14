$PBExportHeader$wi_spain.srw
forward
global type wi_spain from window
end type
type pb_1 from picturebutton within wi_spain
end type
end forward

global type wi_spain from window
integer x = 5
integer y = 4
integer width = 2697
integer height = 1764
boolean titlebar = true
string title = "España"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 79741120
boolean center = true
pb_1 pb_1
end type
global wi_spain wi_spain

on wi_spain.create
this.pb_1=create pb_1
this.Control[]={this.pb_1}
end on

on wi_spain.destroy
destroy(this.pb_1)
end on

type pb_1 from picturebutton within wi_spain
integer width = 2697
integer height = 1688
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\spain.bmp"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

