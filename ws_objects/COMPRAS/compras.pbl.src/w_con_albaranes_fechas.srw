$PBExportHeader$w_con_albaranes_fechas.srw
forward
global type w_con_albaranes_fechas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_albaranes_fechas
end type
type st_fpedido1 from statictext within w_con_albaranes_fechas
end type
type uo_manejo from u_manejo_datawindow within w_con_albaranes_fechas
end type
type dw_listado_fechas from datawindow within w_con_albaranes_fechas
end type
type pb_imprimir from upb_imprimir within w_con_albaranes_fechas
end type
type em_fpedido1 from u_em_campo within w_con_albaranes_fechas
end type
type st_fpedido2 from statictext within w_con_albaranes_fechas
end type
type em_fpedido2 from u_em_campo within w_con_albaranes_fechas
end type
type dw_fechas from datawindow within w_con_albaranes_fechas
end type
type gb_2 from groupbox within w_con_albaranes_fechas
end type
type gb_1 from groupbox within w_con_albaranes_fechas
end type
type cb_1 from commandbutton within w_con_albaranes_fechas
end type
end forward

global type w_con_albaranes_fechas from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 3360
integer height = 2108
string icon = "Application!"
pb_1 pb_1
st_fpedido1 st_fpedido1
uo_manejo uo_manejo
dw_listado_fechas dw_listado_fechas
pb_imprimir pb_imprimir
em_fpedido1 em_fpedido1
st_fpedido2 st_fpedido2
em_fpedido2 em_fpedido2
dw_fechas dw_fechas
gb_2 gb_2
gb_1 gb_1
cb_1 cb_1
end type
global w_con_albaranes_fechas w_con_albaranes_fechas

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Albaranes por Fechas"
This.title=istr_parametros.s_titulo_ventana

dw_fechas.SetTransObject(SQLCA)
//dw_fechas.SetRowFocusIndicator(Hand!)
dw_listado_fechas.SetTransObject(SQLCA)
em_fpedido1.text=string(date(year(today()),month(today()),1))
em_fpedido2.text=string(today())
end event

event ue_listar;dw_listado_fechas.Retrieve(codigo_empresa,datetime(date(em_fpedido1.text)),datetime(date(em_fpedido2.text)))
dw_report=dw_listado_fechas
CALL Super::ue_listar
end event

on w_con_albaranes_fechas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_fpedido1=create st_fpedido1
this.uo_manejo=create uo_manejo
this.dw_listado_fechas=create dw_listado_fechas
this.pb_imprimir=create pb_imprimir
this.em_fpedido1=create em_fpedido1
this.st_fpedido2=create st_fpedido2
this.em_fpedido2=create em_fpedido2
this.dw_fechas=create dw_fechas
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_fpedido1
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.dw_listado_fechas
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.em_fpedido1
this.Control[iCurrent+7]=this.st_fpedido2
this.Control[iCurrent+8]=this.em_fpedido2
this.Control[iCurrent+9]=this.dw_fechas
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.cb_1
end on

on w_con_albaranes_fechas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_fpedido1)
destroy(this.uo_manejo)
destroy(this.dw_listado_fechas)
destroy(this.pb_imprimir)
destroy(this.em_fpedido1)
destroy(this.st_fpedido2)
destroy(this.em_fpedido2)
destroy(this.dw_fechas)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_fechas)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_fechas)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_albaranes_fechas
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_albaranes_fechas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_albaranes_fechas
integer y = 8
integer width = 3118
integer textsize = -12
boolean italic = true
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_con_albaranes_fechas
integer x = 3168
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type st_fpedido1 from statictext within w_con_albaranes_fechas
integer x = 416
integer y = 196
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_manejo from u_manejo_datawindow within w_con_albaranes_fechas
integer x = 2693
integer y = 148
integer width = 613
end type

event valores;call super::valores;dw_data=dw_fechas
f_activar_campo(em_fpedido1)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_fechas from datawindow within w_con_albaranes_fechas
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_albaranes_fechas"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_albaranes_fechas
integer x = 3173
integer y = 196
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(em_fpedido1)
end event

type em_fpedido1 from u_em_campo within w_con_albaranes_fechas
integer x = 704
integer y = 188
integer width = 375
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "$Œç<pïMˆïM"
end type

type st_fpedido2 from statictext within w_con_albaranes_fechas
integer x = 1106
integer y = 196
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fpedido2 from u_em_campo within w_con_albaranes_fechas
integer x = 1390
integer y = 188
integer width = 375
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "˜"
end type

type dw_fechas from datawindow within w_con_albaranes_fechas
integer x = 18
integer y = 300
integer width = 3273
integer height = 1596
boolean bringtotop = true
string dataobject = "dw_con_albaranes_fechas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[3]=f_valor_columna(dw_fechas,dw_fechas.GetRow(),"comlinalb_anyo")
lstr_param.s_argumentos[2]= f_valor_columna(dw_fechas,dw_fechas.GetRow(),"comlinalb_albaran")
OpenWithParm(w_mant_comlinalb,lstr_param) 


end event

type gb_2 from groupbox within w_con_albaranes_fechas
integer x = 2277
integer y = 144
integer width = 416
integer height = 152
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_con_albaranes_fechas
integer x = 18
integer y = 112
integer width = 1806
integer height = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha Albaran"
end type

type cb_1 from commandbutton within w_con_albaranes_fechas
integer x = 2295
integer y = 196
integer width = 379
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Continuar"
end type

event clicked;dw_fechas.Retrieve(codigo_empresa,datetime(date(string(em_fpedido1.text))),datetime(date(string(em_fpedido2.text))))
end event

