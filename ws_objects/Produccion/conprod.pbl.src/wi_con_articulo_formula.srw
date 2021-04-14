$PBExportHeader$wi_con_articulo_formula.srw
forward
global type wi_con_articulo_formula from w_int_con_empresa
end type
type dw_1 from datawindow within wi_con_articulo_formula
end type
type pb_imprimir from upb_imprimir within wi_con_articulo_formula
end type
type uo_manejo from u_manejo_datawindow within wi_con_articulo_formula
end type
type cb_1 from u_boton within wi_con_articulo_formula
end type
type pb_1 from upb_salir within wi_con_articulo_formula
end type
end forward

global type wi_con_articulo_formula from w_int_con_empresa
integer width = 2944
integer height = 1688
dw_1 dw_1
pb_imprimir pb_imprimir
uo_manejo uo_manejo
cb_1 cb_1
pb_1 pb_1
end type
global wi_con_articulo_formula wi_con_articulo_formula

on wi_con_articulo_formula.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.pb_imprimir=create pb_imprimir
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.pb_1
end on

on wi_con_articulo_formula.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.pb_imprimir)
destroy(this.uo_manejo)
destroy(this.cb_1)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Artículos por formato"
istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)



end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;string formato

//if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el formato")
////	f_activar_campo(uo_1.em_campo)
////	return
//	formato = "%"
//else
//	formato = uo_1.em_codigo.text
//end if
dw_1.Retrieve(codigo_empresa,"%")
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_articulo_formula
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_articulo_formula
integer x = 73
integer y = 160
integer width = 178
integer height = 96
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_con_articulo_formula
end type

type dw_1 from datawindow within wi_con_articulo_formula
integer x = 9
integer y = 300
integer width = 2885
integer height = 1136
boolean bringtotop = true
string dataobject = "dw_con_moldes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="wi_con_formatos_articulos"
  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
  OpenWithParm(wi_mant_prodmoldes,lstr_param)

end event

type pb_imprimir from upb_imprimir within wi_con_articulo_formula
event clicked pbm_bnclicked
integer x = 2706
integer y = 176
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF


wi_con_moldes.triggerEvent("ue_listar")
//f_activar_campo(uo_1.em_campo)
end event

type uo_manejo from u_manejo_datawindow within wi_con_articulo_formula
event valores pbm_custom01
integer x = 2231
integer y = 128
integer width = 635
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1
//f_activar_campo(uo_1.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from u_boton within wi_con_articulo_formula
integer x = 1911
integer y = 168
integer width = 315
integer height = 104
integer taborder = 20
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;string molde

//if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
	molde = "%"
//else
//	formato = uo_1.em_codigo.text
//end if

dw_1.Retrieve(codigo_empresa,molde)

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if
end event

type pb_1 from upb_salir within wi_con_articulo_formula
integer x = 2711
integer y = 28
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

