$PBExportHeader$w_labubicaciones_pantallas.srw
forward
global type w_labubicaciones_pantallas from window
end type
type pb_1 from picturebutton within w_labubicaciones_pantallas
end type
type cb_borrar from commandbutton within w_labubicaciones_pantallas
end type
type cb_insertar from commandbutton within w_labubicaciones_pantallas
end type
type cb_salir from commandbutton within w_labubicaciones_pantallas
end type
type cb_grabar from commandbutton within w_labubicaciones_pantallas
end type
type dw_1 from datawindow within w_labubicaciones_pantallas
end type
end forward

global type w_labubicaciones_pantallas from window
integer x = 407
integer y = 16
integer width = 3122
integer height = 2588
boolean titlebar = true
string title = "Selección"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
pb_1 pb_1
cb_borrar cb_borrar
cb_insertar cb_insertar
cb_salir cb_salir
cb_grabar cb_grabar
dw_1 dw_1
end type
global w_labubicaciones_pantallas w_labubicaciones_pantallas

on w_labubicaciones_pantallas.create
this.pb_1=create pb_1
this.cb_borrar=create cb_borrar
this.cb_insertar=create cb_insertar
this.cb_salir=create cb_salir
this.cb_grabar=create cb_grabar
this.dw_1=create dw_1
this.Control[]={this.pb_1,&
this.cb_borrar,&
this.cb_insertar,&
this.cb_salir,&
this.cb_grabar,&
this.dw_1}
end on

on w_labubicaciones_pantallas.destroy
destroy(this.pb_1)
destroy(this.cb_borrar)
destroy(this.cb_insertar)
destroy(this.cb_salir)
destroy(this.cb_grabar)
destroy(this.dw_1)
end on

event open;This.title = "Ubicaciones de Pantallas de laboratorio"

dw_1.SetTransObject(SQLCA)
dw_1.retrieve (codigo_empresa)
end event

type pb_1 from picturebutton within w_labubicaciones_pantallas
integer x = 2830
integer y = 524
integer width = 146
integer height = 128
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
alignment htextalign = left!
end type

event clicked;f_imprimir_datawindow(dw_1)
end event

type cb_borrar from commandbutton within w_labubicaciones_pantallas
integer x = 2702
integer y = 112
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;dw_1.DeleteRow(0)


end event

type cb_insertar from commandbutton within w_labubicaciones_pantallas
integer x = 2702
integer y = 12
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;long fila_nueva

fila_nueva = dw_1.InsertRow(0)
dw_1.ScrollToRow(fila_nueva)
dw_1.object.empresa[dw_1.GetRow()] = codigo_empresa

dw_1.setfocus()

end event

type cb_salir from commandbutton within w_labubicaciones_pantallas
integer x = 2706
integer y = 304
integer width = 370
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;close (w_labubicaciones_pantallas)

end event

type cb_grabar from commandbutton within w_labubicaciones_pantallas
integer x = 2706
integer y = 212
integer width = 370
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;integer rtn

CONNECT USING SQLCA;

dw_1.SetTransObject(SQLCA)
dw_1.accepttext()

rtn = dw_1.Update()

IF rtn = 1  THEN 
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	messagebox("Error","No se	guardarán ls cambios")
END IF
end event

type dw_1 from datawindow within w_labubicaciones_pantallas
integer x = 5
integer y = 4
integer width = 2661
integer height = 2496
integer taborder = 10
string dataobject = "dw_labubicaciones_pantallas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;dw_1.SetRedraw(false)

dw_1.SetSort("codigo D")

dw_1.Sort()

dw_1.SetRedraw(true)





end event

event clicked;choose case dwo.name
	case "t_ubicacion"
		dw_1.SetSort("codigo A")
		dw_1.Sort()
	case "t_tipo"
		dw_1.SetSort( "Tipo_pantallas A")
		dw_1.Sort()
	case "t_disponible"
		dw_1.SetSort( "disponible A")
		dw_1.Sort()
	case "t_existencias"
		dw_1.SetSort("total_nuevo A")
		dw_1.Sort()
	case "t_capacidad"
		dw_1.SetSort("capacidad A")
		dw_1.Sort()
		
end choose


end event

