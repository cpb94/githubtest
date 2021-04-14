$PBExportHeader$w_con_albaranes_articulo.srw
forward
global type w_con_albaranes_articulo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_albaranes_articulo
end type
type uo_manejo from u_manejo_datawindow within w_con_albaranes_articulo
end type
type dw_albaranes from datawindow within w_con_albaranes_articulo
end type
type pb_imprimir from upb_imprimir within w_con_albaranes_articulo
end type
type st_articulo2 from statictext within w_con_albaranes_articulo
end type
type dw_listado from datawindow within w_con_albaranes_articulo
end type
type em_prima1 from u_em_campo within w_con_albaranes_articulo
end type
type st_prima1 from statictext within w_con_albaranes_articulo
end type
end forward

global type w_con_albaranes_articulo from w_int_con_empresa
integer width = 2939
integer height = 1656
string icon = "Application!"
pb_1 pb_1
uo_manejo uo_manejo
dw_albaranes dw_albaranes
pb_imprimir pb_imprimir
st_articulo2 st_articulo2
dw_listado dw_listado
em_prima1 em_prima1
st_prima1 st_prima1
end type
global w_con_albaranes_articulo w_con_albaranes_articulo

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Albaranes por M.Prima"
This.title=istr_parametros.s_titulo_ventana
em_prima1.SetFocus()
dw_albaranes.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_albaranes.SetRowFocusIndicator(Hand!)
//uo_articulo.em_campo.text= f_nombre_mprima(codigo_empresa,uo_articulo.em_codigo.text)

end event

event ue_listar;dw_listado.Retrieve(codigo_empresa,em_prima1.text)
dw_report=dw_listado
CALL Super::ue_listar
end event

on w_con_albaranes_articulo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.dw_albaranes=create dw_albaranes
this.pb_imprimir=create pb_imprimir
this.st_articulo2=create st_articulo2
this.dw_listado=create dw_listado
this.em_prima1=create em_prima1
this.st_prima1=create st_prima1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.dw_albaranes
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.st_articulo2
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.em_prima1
this.Control[iCurrent+8]=this.st_prima1
end on

on w_con_albaranes_articulo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.dw_albaranes)
destroy(this.pb_imprimir)
destroy(this.st_articulo2)
destroy(this.dw_listado)
destroy(this.em_prima1)
destroy(this.st_prima1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_albaranes)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_albaranes)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_albaranes_articulo
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_albaranes_articulo
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_prima1)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_albaranes_articulo
integer x = 18
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_albaranes_articulo
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_albaranes_articulo
integer x = 2254
integer y = 120
integer width = 613
end type

event valores;call super::valores;dw_data=dw_albaranes
f_activar_campo(em_prima1)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_albaranes from datawindow within w_con_albaranes_articulo
integer x = 32
integer y = 268
integer width = 2839
integer height = 1164
string dataobject = "dw_con_albaranes_articulo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[1]="w_con_albaranes_artfec"
lstr_param.s_argumentos[3]=This.GetItemString(Row,"comlinalb_anyo")
lstr_param.s_argumentos[2]=This.GetItemString(Row,"comlinalb_albaran")
OpenWithParm(w_mant_comlinalb,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_albaranes_articulo
integer x = 2729
integer y = 168
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(em_prima1)
end event

type st_articulo2 from statictext within w_con_albaranes_articulo
integer x = 23
integer y = 144
integer width = 366
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = " M.Prima:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_albaranes_articulo
boolean visible = false
integer x = 18
integer y = 4
integer width = 494
integer height = 108
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_albaranes_articulo"
boolean livescroll = true
end type

type em_prima1 from u_em_campo within w_con_albaranes_articulo
integer x = 439
integer y = 144
integer width = 448
integer taborder = 2
end type

event modificado;call super::modificado;st_prima1.text = f_nombre_mprima(codigo_empresa,This.text)
iF Trim(st_prima1.text) = "" Then
	IF Trim(em_prima1.text)<>"" Then
	f_activar_campo(em_prima1)
END IF
em_prima1.text = ""
END iF

dw_albaranes.Retrieve(codigo_empresa,em_prima1.text)
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Articulos"
ue_datawindow = "dw_ayuda_venmprima_compras"
ue_filtro     = "tipo_materia = '1'"
end event

type st_prima1 from statictext within w_con_albaranes_articulo
integer x = 910
integer y = 144
integer width = 1143
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

