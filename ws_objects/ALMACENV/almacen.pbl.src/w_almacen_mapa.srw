$PBExportHeader$w_almacen_mapa.srw
forward
global type w_almacen_mapa from window
end type
type st_1 from statictext within w_almacen_mapa
end type
end forward

global type w_almacen_mapa from window
integer width = 2839
integer height = 1520
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 12632256
boolean center = true
st_1 st_1
end type
global w_almacen_mapa w_almacen_mapa

on w_almacen_mapa.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on w_almacen_mapa.destroy
destroy(this.st_1)
end on

type st_1 from statictext within w_almacen_mapa
integer x = 46
integer y = 4
integer width = 2674
integer height = 112
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Gestión Almacen"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

