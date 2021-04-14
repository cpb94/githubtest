$PBExportHeader$w_observacion_ubicacion.srw
forward
global type w_observacion_ubicacion from window
end type
type cb_1 from commandbutton within w_observacion_ubicacion
end type
type dw_1 from datawindow within w_observacion_ubicacion
end type
end forward

global type w_observacion_ubicacion from window
integer x = 5
integer y = 128
integer width = 3483
integer height = 1560
boolean titlebar = true
string title = "Consulta de Stock"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 80269524
cb_1 cb_1
dw_1 dw_1
end type
global w_observacion_ubicacion w_observacion_ubicacion

on w_observacion_ubicacion.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_observacion_ubicacion.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;datawindow DW

DW = Message.PowerObjectParm

Dw_1.SetTransObject(SQLCA)
dw_1.retrieve (codigo_empresa,DW.object.cod_articulo[DW.GetRow()], DW.object.planificacion_version[DW.GetRow()])

//string articulo
//
//articulo = string(Message.PowerObjectParm)
//dw_1.retrieve (codigo_empresa,articulo)
//


end event

type cb_1 from commandbutton within w_observacion_ubicacion
integer x = 2907
integer y = 1340
integer width = 521
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;f_imprimir_datawindow(dw_1)
end event

type dw_1 from datawindow within w_observacion_ubicacion
integer x = 18
integer y = 24
integer width = 3433
integer height = 1276
integer taborder = 10
string dataobject = "dw_observacion_ubicacion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

