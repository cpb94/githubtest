$PBExportHeader$w_con_stock_articulo.srw
forward
global type w_con_stock_articulo from window
end type
type cb_1 from commandbutton within w_con_stock_articulo
end type
type dw_1 from datawindow within w_con_stock_articulo
end type
end forward

global type w_con_stock_articulo from window
integer x = 5
integer y = 128
integer width = 3744
integer height = 1736
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 80269524
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_con_stock_articulo w_con_stock_articulo

on w_con_stock_articulo.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_con_stock_articulo.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;
string articulo

dw_1.SetTransObject(SQLCA)
articulo = Message.StringParm

dw_1.retrieve (codigo_empresa,articulo)



end event

type cb_1 from commandbutton within w_con_stock_articulo
integer x = 2912
integer y = 1508
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

type dw_1 from datawindow within w_con_stock_articulo
integer x = 18
integer y = 24
integer width = 3671
integer height = 1444
integer taborder = 10
string dataobject = "dw_con_stock_articulo"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

