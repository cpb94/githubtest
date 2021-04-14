$PBExportHeader$w_con_ubicaciones_reservas.srw
forward
global type w_con_ubicaciones_reservas from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_ubicaciones_reservas
end type
type dw_proceso from datawindow within w_con_ubicaciones_reservas
end type
type dw_listado from datawindow within w_con_ubicaciones_reservas
end type
type dw_1 from datawindow within w_con_ubicaciones_reservas
end type
type cb_1 from commandbutton within w_con_ubicaciones_reservas
end type
type rb_1 from radiobutton within w_con_ubicaciones_reservas
end type
type rb_2 from radiobutton within w_con_ubicaciones_reservas
end type
type rb_3 from radiobutton within w_con_ubicaciones_reservas
end type
type gb_4 from groupbox within w_con_ubicaciones_reservas
end type
type uo_1 from u_manejo_datawindow within w_con_ubicaciones_reservas
end type
end forward

global type w_con_ubicaciones_reservas from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2939
integer height = 1632
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_proceso dw_proceso
dw_listado dw_listado
dw_1 dw_1
cb_1 cb_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
gb_4 gb_4
uo_1 uo_1
end type
global w_con_ubicaciones_reservas w_con_ubicaciones_reservas

type variables
String ante_articulo,retrasos
end variables

event ue_listar;//String almacen
//IF dw_almacenes.GetRow()= 0 Then Return
//almacen= dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")
//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//dw_report.Retrieve(codigo_empresa,almacen)
//CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " Consulta material reservado"


end event

on w_con_ubicaciones_reservas.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.cb_1=create cb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.gb_4=create gb_4
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.rb_3
this.Control[iCurrent+9]=this.gb_4
this.Control[iCurrent+10]=this.uo_1
end on

on w_con_ubicaciones_reservas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_proceso)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.gb_4)
destroy(this.uo_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ubicaciones_reservas
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ubicaciones_reservas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ubicaciones_reservas
integer x = 27
integer y = 20
integer width = 2574
end type

type pb_2 from upb_salir within w_con_ubicaciones_reservas
integer x = 2693
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type dw_proceso from datawindow within w_con_ubicaciones_reservas
boolean visible = false
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_almtipomov"
boolean livescroll = true
end type

type dw_listado from datawindow within w_con_ubicaciones_reservas
boolean visible = false
integer x = 2103
integer y = 160
integer width = 137
integer height = 96
boolean bringtotop = true
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_ubicaciones_reservas
integer x = 14
integer y = 288
integer width = 2848
integer height = 1120
integer taborder = 30
string dataobject = "dw_con_ubicaciones_reservas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within w_con_ubicaciones_reservas
integer x = 1033
integer y = 184
integer width = 407
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;string seried,serieh
if rb_1.checked=true then 
	seried='1'
	serieh='1'
else
	if rb_2.checked=true then
		seried='2'
		serieh='2'
	else
		seried='1'
		serieh='2'
	end if
end if

dw_1.Retrieve(codigo_empresa,seried,serieh)
dw_1.Setfocus()

end event

type rb_1 from radiobutton within w_con_ubicaciones_reservas
integer x = 55
integer y = 196
integer width = 306
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nacional"
end type

type rb_2 from radiobutton within w_con_ubicaciones_reservas
integer x = 603
integer y = 196
integer width = 393
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Exportación"
end type

type rb_3 from radiobutton within w_con_ubicaciones_reservas
integer x = 352
integer y = 196
integer width = 238
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todo"
boolean checked = true
end type

type gb_4 from groupbox within w_con_ubicaciones_reservas
integer x = 18
integer y = 136
integer width = 992
integer height = 136
integer taborder = 1
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_1 from u_manejo_datawindow within w_con_ubicaciones_reservas
integer x = 1467
integer y = 124
integer width = 599
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

