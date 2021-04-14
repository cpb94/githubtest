$PBExportHeader$w_mant_tipooperaciones_grid.srw
forward
global type w_mant_tipooperaciones_grid from window
end type
type pb_1 from picturebutton within w_mant_tipooperaciones_grid
end type
type cb_grabar from commandbutton within w_mant_tipooperaciones_grid
end type
type cb_salir from commandbutton within w_mant_tipooperaciones_grid
end type
type r_1 from rectangle within w_mant_tipooperaciones_grid
end type
type r_2 from rectangle within w_mant_tipooperaciones_grid
end type
type dw_1 from u_datawindow within w_mant_tipooperaciones_grid
end type
end forward

global type w_mant_tipooperaciones_grid from window
integer x = 59
integer y = 16
integer width = 3584
integer height = 3128
boolean titlebar = true
string title = "Aplicaciones"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 80269524
pb_1 pb_1
cb_grabar cb_grabar
cb_salir cb_salir
r_1 r_1
r_2 r_2
dw_1 dw_1
end type
global w_mant_tipooperaciones_grid w_mant_tipooperaciones_grid

type variables
Long id_ventana_activa

Public:

str_parametros  istr_parametros
end variables

on w_mant_tipooperaciones_grid.create
this.pb_1=create pb_1
this.cb_grabar=create cb_grabar
this.cb_salir=create cb_salir
this.r_1=create r_1
this.r_2=create r_2
this.dw_1=create dw_1
this.Control[]={this.pb_1,&
this.cb_grabar,&
this.cb_salir,&
this.r_1,&
this.r_2,&
this.dw_1}
end on

on w_mant_tipooperaciones_grid.destroy
destroy(this.pb_1)
destroy(this.cb_grabar)
destroy(this.cb_salir)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.dw_1)
end on

event open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_grabar.visible = false;
end choose

istr_parametros = Message.PowerObjectParm


dw_1.SetTransObject(SQLCA)
dw_1.retrieve(codigo_empresa)

end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

type pb_1 from picturebutton within w_mant_tipooperaciones_grid
integer x = 2551
integer y = 24
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;f_imprimir_datawindow(dw_1)
end event

type cb_grabar from commandbutton within w_mant_tipooperaciones_grid
integer x = 2720
integer y = 28
integer width = 352
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Grabar"
end type

event clicked;dw_1.update()

end event

type cb_salir from commandbutton within w_mant_tipooperaciones_grid
integer x = 3081
integer y = 28
integer width = 352
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Salir"
end type

event clicked;close(parent)
end event

type r_1 from rectangle within w_mant_tipooperaciones_grid
integer linethickness = 4
long fillcolor = 8421376
integer x = 2702
integer y = 16
integer width = 745
integer height = 108
end type

type r_2 from rectangle within w_mant_tipooperaciones_grid
integer linethickness = 4
long fillcolor = 8421376
integer x = 18
integer y = 132
integer width = 3520
integer height = 2892
end type

type dw_1 from u_datawindow within w_mant_tipooperaciones_grid
integer x = 32
integer y = 144
integer width = 3488
integer height = 2864
integer taborder = 10
string dataobject = "dw_art_tipooperaciones_grid"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row=0 Then Return

IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
END IF


end event

event retrieveend;if this.rowcount() >0 then
   This.event rowfocuschanged(1)
end if

end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

