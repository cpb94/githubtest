$PBExportHeader$w_mant_produbicacionpantallas.srw
forward
global type w_mant_produbicacionpantallas from window
end type
type cb_2 from commandbutton within w_mant_produbicacionpantallas
end type
type cb_1 from commandbutton within w_mant_produbicacionpantallas
end type
type cb_borrar from commandbutton within w_mant_produbicacionpantallas
end type
type cb_insertar from commandbutton within w_mant_produbicacionpantallas
end type
type cb_salir from commandbutton within w_mant_produbicacionpantallas
end type
type cb_grabar from commandbutton within w_mant_produbicacionpantallas
end type
type dw_1 from datawindow within w_mant_produbicacionpantallas
end type
end forward

global type w_mant_produbicacionpantallas from window
integer x = 407
integer y = 16
integer width = 3721
integer height = 2840
boolean titlebar = true
string title = "Selección"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
cb_2 cb_2
cb_1 cb_1
cb_borrar cb_borrar
cb_insertar cb_insertar
cb_salir cb_salir
cb_grabar cb_grabar
dw_1 dw_1
end type
global w_mant_produbicacionpantallas w_mant_produbicacionpantallas

on w_mant_produbicacionpantallas.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_borrar=create cb_borrar
this.cb_insertar=create cb_insertar
this.cb_salir=create cb_salir
this.cb_grabar=create cb_grabar
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.cb_borrar,&
this.cb_insertar,&
this.cb_salir,&
this.cb_grabar,&
this.dw_1}
end on

on w_mant_produbicacionpantallas.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_borrar)
destroy(this.cb_insertar)
destroy(this.cb_salir)
destroy(this.cb_grabar)
destroy(this.dw_1)
end on

event open;This.title = "Ubicaciones de Pantallas de Producción"

dw_1.SetTransObject(SQLCA)
dw_1.retrieve (codigo_empresa)
end event

type cb_2 from commandbutton within w_mant_produbicacionpantallas
integer x = 3246
integer y = 1120
integer width = 430
integer height = 112
integer taborder = 50
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

type cb_1 from commandbutton within w_mant_produbicacionpantallas
integer x = 3241
integer y = 988
integer width = 430
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;dw_1.retrieve (codigo_empresa)
end event

type cb_borrar from commandbutton within w_mant_produbicacionpantallas
integer x = 3218
integer y = 136
integer width = 434
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

type cb_insertar from commandbutton within w_mant_produbicacionpantallas
integer x = 3218
integer y = 32
integer width = 434
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

type cb_salir from commandbutton within w_mant_produbicacionpantallas
integer x = 3223
integer y = 328
integer width = 434
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

event clicked;close(Parent)

end event

type cb_grabar from commandbutton within w_mant_produbicacionpantallas
integer x = 3223
integer y = 236
integer width = 434
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
long i

CONNECT USING SQLCA;

//for i = 1 to dw_1.rowcount()
//	if isnull(dw_1.object.total_ubicacion[i]) then
//		dw_1.object.total_ubicacion[i] = 0
//	end if
//next

dw_1.SetTransObject(SQLCA)
dw_1.accepttext()

rtn = dw_1.Update()

IF rtn = 1  THEN 
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	messagebox("Error","No se	guardarán los cambios")
END IF
end event

type dw_1 from datawindow within w_mant_produbicacionpantallas
integer x = 5
integer y = 4
integer width = 3173
integer height = 2736
integer taborder = 10
string dataobject = "dw_produbicacionpantallas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//dw_1.SetRedraw(false)
//
//dw_1.SetSort("disponible D")
//
//dw_1.Sort()
//
//dw_1.SetRedraw(true)
//




end event

