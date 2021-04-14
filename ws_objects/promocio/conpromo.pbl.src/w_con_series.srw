$PBExportHeader$w_con_series.srw
forward
global type w_con_series from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_series
end type
type pb_imprimir from upb_imprimir within w_con_series
end type
type dw_listado from datawindow within w_con_series
end type
type uo_manejo from u_manejo_datawindow within w_con_series
end type
type dw_conpromped1 from u_datawindow_consultas within w_con_series
end type
end forward

global type w_con_series from w_int_con_empresa
integer x = 59
integer y = 48
integer width = 3598
integer height = 2184
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
dw_conpromped1 dw_conpromped1
end type
global w_con_series w_con_series

type variables
String tipo = "P"


end variables

on w_con_series.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.dw_conpromped1=create dw_conpromped1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_manejo
this.Control[iCurrent+5]=this.dw_conpromped1
end on

on w_con_series.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.dw_conpromped1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Listado de Series expositores"
istr_parametros.s_listado        =   "report_series"
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromped1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

dw_conpromped1.retrieve(codigo_empresa)


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromped1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromped1)
end event

event ue_listar;dw_listado.retrieve(codigo_empresa)
dw_report = dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_series
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_series
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_series
integer width = 3177
end type

type pb_1 from upb_salir within w_con_series
integer x = 3223
integer y = 36
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_series
integer x = 3227
integer y = 184
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;

Parent.triggerEvent("ue_listar")
end event

type dw_listado from datawindow within w_con_series
boolean visible = false
integer x = 64
integer y = 8
integer width = 494
integer height = 264
boolean bringtotop = true
string dataobject = "report_series"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_series
integer x = 2747
integer y = 136
integer width = 608
integer height = 156
end type

event valores;call super::valores;dw_data=dw_conpromped1

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_conpromped1 from u_datawindow_consultas within w_con_series
integer x = 37
integer y = 308
integer width = 3410
integer height = 1604
integer taborder = 10
string dataobject = "dw_con_series"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;if row=0 then Return
str_parametros lstr_param 
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=dw_conpromped1.GetItemString(This.GetRow(),"codigo")
OpenWithParm(wi_mant_promseries,lstr_param)

end event

