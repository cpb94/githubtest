$PBExportHeader$w_int_asignacion_stock_promocion.srw
forward
global type w_int_asignacion_stock_promocion from w_int_con_empresa
end type
type pb_2 from upb_salir within w_int_asignacion_stock_promocion
end type
type st_1 from statictext within w_int_asignacion_stock_promocion
end type
type cb_continuar from u_boton within w_int_asignacion_stock_promocion
end type
type em_articulo from u_em_campo within w_int_asignacion_stock_promocion
end type
type dw_pedidos from u_datawindow_consultas within w_int_asignacion_stock_promocion
end type
type dw_listado from datawindow within w_int_asignacion_stock_promocion
end type
type rb_todos from radiobutton within w_int_asignacion_stock_promocion
end type
type rb_disponible from radiobutton within w_int_asignacion_stock_promocion
end type
end forward

global type w_int_asignacion_stock_promocion from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2962
integer height = 1884
string title = "Consulta de Movimientos"
pb_2 pb_2
st_1 st_1
cb_continuar cb_continuar
em_articulo em_articulo
dw_pedidos dw_pedidos
dw_listado dw_listado
rb_todos rb_todos
rb_disponible rb_disponible
end type
global w_int_asignacion_stock_promocion w_int_asignacion_stock_promocion

type variables
String ante_articulo,retrasos
datawindow dw_data
String donde,modo
end variables

event open;call super::open;String mascara
This.title = "ASIGNANCION DE SOCKS PROMOCION"
f_activar_campo(em_articulo)
dw_pedidos.SetTransObject(SQLCA)

end event

on w_int_asignacion_stock_promocion.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.st_1=create st_1
this.cb_continuar=create cb_continuar
this.em_articulo=create em_articulo
this.dw_pedidos=create dw_pedidos
this.dw_listado=create dw_listado
this.rb_todos=create rb_todos
this.rb_disponible=create rb_disponible
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_continuar
this.Control[iCurrent+4]=this.em_articulo
this.Control[iCurrent+5]=this.dw_pedidos
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.rb_todos
this.Control[iCurrent+8]=this.rb_disponible
end on

on w_int_asignacion_stock_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.st_1)
destroy(this.cb_continuar)
destroy(this.em_articulo)
destroy(this.dw_pedidos)
destroy(this.dw_listado)
destroy(this.rb_todos)
destroy(this.rb_disponible)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_pedidos)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_pedidos)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_pedidos)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_pedidos)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_asignacion_stock_promocion
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_asignacion_stock_promocion
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_articulo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_asignacion_stock_promocion
integer x = 27
integer y = 20
integer width = 2574
end type

type pb_2 from upb_salir within w_int_asignacion_stock_promocion
integer x = 2715
integer y = 12
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

event clicked;IF dw_listado.RowCOunt() <> 0 Then
	f_mensaje("No se puede salir","Listar Incidencias")
	Return
END IF
Call Super::Clicked
end event

type st_1 from statictext within w_int_asignacion_stock_promocion
integer x = 37
integer y = 152
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Descripción:"
boolean focusrectangle = false
end type

type cb_continuar from u_boton within w_int_asignacion_stock_promocion
integer x = 1723
integer y = 152
integer height = 84
integer taborder = 20
string text = "F5 Continuar"
end type

event clicked;call super::clicked;Integer g
Dec   disp
String articulo,calidad
dw_pedidos.SetRedraw(FALSE)
dw_pedidos.Retrieve(codigo_empresa,"%"+Trim(em_articulo.text)+"%")
dw_pedidos.SetFilter("")
dw_pedidos.Filter()
For g = 1 To dw_pedidos.RowCount()
	articulo = dw_pedidos.GetItemString(g,"articulo")
	calidad  = dw_pedidos.GetItemString(g,"calidad")
	disp     = f_disponible_articulo_calidad(codigo_empresa,articulo,calidad)
	dw_pedidos.SetItem(g,"disp",disp)
Next
IF rb_disponible.checked = TRUE Then
	dw_pedidos.SetFilter("disp <>0")
	dw_pedidos.Filter()
END IF

dw_pedidos.SetRedraw(TRUE)
end event

type em_articulo from u_em_campo within w_int_asignacion_stock_promocion
integer x = 411
integer y = 148
integer width = 1294
integer taborder = 10
end type

type dw_pedidos from u_datawindow_consultas within w_int_asignacion_stock_promocion
integer x = 27
integer y = 268
integer width = 2843
integer height = 1404
integer taborder = 0
string dataobject = "dw_int_asignacion_stock_promocion"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="w_int_asignacion_stock_promocion"
  lstr_param.s_argumentos[2]=String(dw_pedidos.GetItemNumber(This.GetRow(),"anyo"))
  lstr_param.s_argumentos[3]=String(dw_pedidos.GetItemNumber(This.GetRow(),"pedido"))
  OpenWithParm(w_preparacion_pedidos_promocion,lstr_param)

end event

type dw_listado from datawindow within w_int_asignacion_stock_promocion
boolean visible = false
integer width = 219
integer height = 100
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_int_movtraspasos5"
boolean livescroll = true
end type

type rb_todos from radiobutton within w_int_asignacion_stock_promocion
integer x = 2149
integer y = 152
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Todos"
boolean checked = true
boolean lefttext = true
end type

event clicked;This.Checked = TRUE
cb_continuar.TriggerEvent(Clicked!)
end event

type rb_disponible from radiobutton within w_int_asignacion_stock_promocion
integer x = 2441
integer y = 152
integer width = 357
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Disponible"
boolean lefttext = true
end type

event clicked;This.Checked = TRUE
cb_continuar.TriggerEvent(Clicked!)
end event

