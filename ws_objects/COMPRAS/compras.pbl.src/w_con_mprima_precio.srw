$PBExportHeader$w_con_mprima_precio.srw
forward
global type w_con_mprima_precio from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_mprima_precio
end type
type st_fpedido1 from statictext within w_con_mprima_precio
end type
type uo_manejo from u_manejo_datawindow within w_con_mprima_precio
end type
type dw_listado_mprima from datawindow within w_con_mprima_precio
end type
type pb_imprimir from upb_imprimir within w_con_mprima_precio
end type
type em_fpedido1 from u_em_campo within w_con_mprima_precio
end type
type st_fpedido2 from statictext within w_con_mprima_precio
end type
type em_fpedido2 from u_em_campo within w_con_mprima_precio
end type
type dw_mprima from datawindow within w_con_mprima_precio
end type
type gb_2 from groupbox within w_con_mprima_precio
end type
type gb_1 from groupbox within w_con_mprima_precio
end type
type cb_1 from commandbutton within w_con_mprima_precio
end type
type st_prodd from statictext within w_con_mprima_precio
end type
type st_prodh from statictext within w_con_mprima_precio
end type
end forward

global type w_con_mprima_precio from w_int_con_empresa
integer width = 2958
integer height = 1684
string icon = "Application!"
pb_1 pb_1
st_fpedido1 st_fpedido1
uo_manejo uo_manejo
dw_listado_mprima dw_listado_mprima
pb_imprimir pb_imprimir
em_fpedido1 em_fpedido1
st_fpedido2 st_fpedido2
em_fpedido2 em_fpedido2
dw_mprima dw_mprima
gb_2 gb_2
gb_1 gb_1
cb_1 cb_1
st_prodd st_prodd
st_prodh st_prodh
end type
global w_con_mprima_precio w_con_mprima_precio

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Precios de coste por Artículo"
This.title=istr_parametros.s_titulo_ventana

dw_mprima.SetTransObject(SQLCA)
dw_mprima.SetRowFocusIndicator(Hand!)
dw_listado_mprima.SetTransObject(SQLCA)
em_fpedido1.text=""
em_fpedido2.text=""
end event

event ue_listar;IF Trim(em_fpedido1.text) = "" or IsNull(em_fpedido1.text) then 
	em_fpedido1.text = "1"
END IF		
			
IF Trim(em_fpedido2.text) = "" or IsNull(em_fpedido2.text) then em_fpedido2.text = "99999"
dw_listado_mprima.Retrieve(codigo_empresa,em_fpedido1.text,em_fpedido2.text)
dw_report=dw_listado_mprima
CALL Super::ue_listar
end event

on w_con_mprima_precio.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_fpedido1=create st_fpedido1
this.uo_manejo=create uo_manejo
this.dw_listado_mprima=create dw_listado_mprima
this.pb_imprimir=create pb_imprimir
this.em_fpedido1=create em_fpedido1
this.st_fpedido2=create st_fpedido2
this.em_fpedido2=create em_fpedido2
this.dw_mprima=create dw_mprima
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_1=create cb_1
this.st_prodd=create st_prodd
this.st_prodh=create st_prodh
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_fpedido1
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.dw_listado_mprima
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.em_fpedido1
this.Control[iCurrent+7]=this.st_fpedido2
this.Control[iCurrent+8]=this.em_fpedido2
this.Control[iCurrent+9]=this.dw_mprima
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.st_prodd
this.Control[iCurrent+14]=this.st_prodh
end on

on w_con_mprima_precio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_fpedido1)
destroy(this.uo_manejo)
destroy(this.dw_listado_mprima)
destroy(this.pb_imprimir)
destroy(this.em_fpedido1)
destroy(this.st_fpedido2)
destroy(this.em_fpedido2)
destroy(this.dw_mprima)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.st_prodd)
destroy(this.st_prodh)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_mprima)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_mprima)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_mprima_precio
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_mprima_precio
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_mprima_precio
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_mprima_precio
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type st_fpedido1 from statictext within w_con_mprima_precio
integer x = 165
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

type uo_manejo from u_manejo_datawindow within w_con_mprima_precio
integer x = 2254
integer y = 148
integer width = 613
end type

event valores;call super::valores;dw_data=dw_mprima
f_activar_campo(em_fpedido1)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_mprima from datawindow within w_con_mprima_precio
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_venmprima_precio"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_mprima_precio
integer x = 2734
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

type em_fpedido1 from u_em_campo within w_con_mprima_precio
integer x = 462
integer y = 188
integer width = 165
integer taborder = 20
alignment alignment = center!
string mask = ""
string displaydata = "~b"
end type

event modified;call super::modified;st_prodd.text = f_nombre_tipo_materia(codigo_empresa, Trim(em_fpedido1.text))
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipos de Materias"
ue_datawindow = "dw_ayuda_venmateria"
end event

type st_fpedido2 from statictext within w_con_mprima_precio
integer x = 174
integer y = 348
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

type em_fpedido2 from u_em_campo within w_con_mprima_precio
integer x = 462
integer y = 340
integer width = 165
integer taborder = 30
alignment alignment = center!
string mask = ""
string displaydata = "Ä"
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipos de Materias"
ue_datawindow = "dw_ayuda_venmateria"
end event

type dw_mprima from datawindow within w_con_mprima_precio
integer x = 137
integer y = 480
integer width = 2683
integer height = 960
boolean bringtotop = true
string dataobject = "dw_con_mprima_precio"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//IF Row = 0 Then Return
//
//str_parametros lstr_param
//lstr_param.i_nargumentos=3
//lstr_param.s_argumentos[3]=f_valor_columna(dw_fechas,dw_fechas.GetRow(),"comlinalb_anyo")
//lstr_param.s_argumentos[2]= f_valor_columna(dw_fechas,dw_fechas.GetRow(),"comlinalb_albaran")
//OpenWithParm(w_mant_comlinalb,lstr_param) 
//
//
end event

type gb_2 from groupbox within w_con_mprima_precio
integer x = 1838
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

type gb_1 from groupbox within w_con_mprima_precio
integer x = 9
integer y = 120
integer width = 1806
integer height = 356
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Producto"
end type

type cb_1 from commandbutton within w_con_mprima_precio
integer x = 1856
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

event clicked;IF Trim(em_fpedido1.text) = "" or IsNull(em_fpedido1.text) then em_fpedido1.text = "1"
IF Trim(em_fpedido2.text) = "" or IsNull(em_fpedido2.text) then em_fpedido2.text = "99999"
dw_mprima.Retrieve(codigo_empresa,Trim(em_fpedido1.text),Trim(em_fpedido2.text))
end event

type st_prodd from statictext within w_con_mprima_precio
integer x = 645
integer y = 196
integer width = 1093
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
long bordercolor = 12632256
boolean focusrectangle = false
end type

type st_prodh from statictext within w_con_mprima_precio
integer x = 645
integer y = 344
integer width = 1093
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
long bordercolor = 12632256
boolean focusrectangle = false
end type

