$PBExportHeader$w_con_ubi_articulos_diferentes.srw
forward
global type w_con_ubi_articulos_diferentes from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_ubi_articulos_diferentes
end type
type uo_1 from u_manejo_datawindow within w_con_ubi_articulos_diferentes
end type
type cb_1 from commandbutton within w_con_ubi_articulos_diferentes
end type
type dw_2 from datawindow within w_con_ubi_articulos_diferentes
end type
type dw_1 from datawindow within w_con_ubi_articulos_diferentes
end type
type ddlb_1 from dropdownlistbox within w_con_ubi_articulos_diferentes
end type
type dw_listado from datawindow within w_con_ubi_articulos_diferentes
end type
type pb_imprimir_preli from picturebutton within w_con_ubi_articulos_diferentes
end type
end forward

global type w_con_ubi_articulos_diferentes from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2944
integer height = 1632
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_1 uo_1
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
ddlb_1 ddlb_1
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
end type
global w_con_ubi_articulos_diferentes w_con_ubi_articulos_diferentes

type variables
String ante_articulo,retrasos
end variables

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
This.title = " Consulta artículos en varias ubicaciones"

ddlb_1.text = "Metros"



end event

on w_con_ubi_articulos_diferentes.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.pb_imprimir_preli
end on

on w_con_ubi_articulos_diferentes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.ddlb_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_1.TriggerEvent("linea_arriba")
end event

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ubi_articulos_diferentes
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ubi_articulos_diferentes
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ubi_articulos_diferentes
integer x = 18
integer y = 20
integer width = 2377
end type

type pb_2 from upb_salir within w_con_ubi_articulos_diferentes
integer x = 2715
integer y = 20
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type uo_1 from u_manejo_datawindow within w_con_ubi_articulos_diferentes
integer x = 2245
integer y = 176
integer width = 617
integer height = 168
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from commandbutton within w_con_ubi_articulos_diferentes
integer x = 448
integer y = 220
integer width = 411
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 &Continuar"
end type

event clicked;string filtro,unidad
integer contador
filtro = " nveces > 1 "

unidad = "0"
if ddlb_1.text = "Metros" then 	unidad = "1"

dw_1.Setfilter(filtro)
dw_1.Filter()
dw_1.retrieve(codigo_empresa,unidad)
contador  = dw_1.retrieve(codigo_empresa,unidad)


IF contador <> 0 Then
	dw_1.SetFocus()
	dw_1.SetRow(1)
	dw_1.SelectRow(0,False)
	dw_1.SelectRow(1,True)
	
	string referencia,tipo_pallet,caja
   
	referencia  = dw_1.GetItemString(1,"almlinubica_referencia")
	tipo_pallet = dw_1.GetItemString(1,"almlinubica_tipo_pallet")
	caja        = dw_1.GetitemString(1,"almlinubica_caja")
	
	dw_2.retrieve(codigo_empresa,referencia,tipo_pallet,caja)
END IF




end event

type dw_2 from datawindow within w_con_ubi_articulos_diferentes
integer x = 1481
integer y = 336
integer width = 1381
integer height = 1072
boolean bringtotop = true
string dataobject = "dw_con_ubi_difer"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within w_con_ubi_articulos_diferentes
event clicked pbm_dwnlbuttonclk
event rowfocuschanged pbm_dwnrowchange
event scrollvertical pbm_dwnvscroll
integer x = 5
integer y = 336
integer width = 1477
integer height = 1072
integer taborder = 40
string dataobject = "dw_con_ubi_diferentes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;This.SelectRow(0,FALSE)
This.SelectRow(row,TRUE)

string referencia,tipo_pallet,caja

referencia  = dw_1.GetItemString(row,"almlinubica_referencia")
tipo_pallet = dw_1.GetItemString(row,"almlinubica_tipo_pallet")
caja        = dw_1.GetItemString(row,"almlinubica_caja")

dw_2.retrieve(codigo_empresa,referencia,tipo_pallet,caja)

end event

event rowfocuschanged;IF This.GetRow() = 0 Then Return

This.SelectRow(0,FALSE)
This.SelectRow(Getrow(),TRUE)

//string referencia,tipo_pallet
//
//
//referencia  = dw_1.GetItemString(GetRow(),"almlinubica_referencia")
//tipo_pallet = dw_1.GetItemString(GetRow(),"almlinubica_tipo_pallet")
//
//dw_2.retrieve(codigo_empresa,referencia,tipo_pallet)

end event

event scrollvertical;this.TriggerEvent(Clicked!)
end event

type ddlb_1 from dropdownlistbox within w_con_ubi_articulos_diferentes
integer x = 41
integer y = 216
integer width = 398
integer height = 284
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Metros","Unidades"}
borderstyle borderstyle = styleraised!
end type

type dw_listado from datawindow within w_con_ubi_articulos_diferentes
boolean visible = false
integer x = 160
integer y = 4
integer width = 494
integer height = 360
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_con_ubi_diferentes"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_ubi_articulos_diferentes
integer x = 2720
integer y = 220
integer width = 105
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;string filtro,unidad

dw_report= dw_listado
filtro = " nveces > 1 "
dw_report.Setfilter(filtro)
dw_report.Filter()

unidad = "0"
if ddlb_1.text = "Metros" then 	unidad = "1"


dw_report.SetTransObject(SQLCA)
dw_report.Retrieve(codigo_empresa,unidad)
f_imprimir_datawindow(dw_report)

end event

