$PBExportHeader$w_con_albaranes_proveedor.srw
$PBExportComments$€
forward
global type w_con_albaranes_proveedor from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_albaranes_proveedor
end type
type uo_manejo from u_manejo_datawindow within w_con_albaranes_proveedor
end type
type dw_listado from datawindow within w_con_albaranes_proveedor
end type
type dw_1 from datawindow within w_con_albaranes_proveedor
end type
type pb_imprimir from upb_imprimir within w_con_albaranes_proveedor
end type
type uo_proveedor from u_em_campo_2 within w_con_albaranes_proveedor
end type
type gb_1 from groupbox within w_con_albaranes_proveedor
end type
end forward

global type w_con_albaranes_proveedor from w_int_con_empresa
integer width = 3662
integer height = 2056
string icon = "Application!"
pb_1 pb_1
uo_manejo uo_manejo
dw_listado dw_listado
dw_1 dw_1
pb_imprimir pb_imprimir
uo_proveedor uo_proveedor
gb_1 gb_1
end type
global w_con_albaranes_proveedor w_con_albaranes_proveedor

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Albaranes por Proveedor"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

uo_proveedor.em_campo.SetFocus()
//uo_proveedor.em_campo.text= f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)

end event

event ue_listar;dw_listado.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text)
dw_report = dw_listado
CALL Super::ue_listar
end event

on w_con_albaranes_proveedor.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.pb_imprimir=create pb_imprimir
this.uo_proveedor=create uo_proveedor
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.uo_proveedor
this.Control[iCurrent+7]=this.gb_1
end on

on w_con_albaranes_proveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.pb_imprimir)
destroy(this.uo_proveedor)
destroy(this.gb_1)
end on

event ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_albaranes_proveedor
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_albaranes_proveedor
integer x = 5
integer taborder = 20
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_albaranes_proveedor
integer x = 18
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_albaranes_proveedor
integer x = 3465
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_albaranes_proveedor
integer x = 2990
integer y = 96
integer width = 613
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_proveedor.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_con_albaranes_proveedor
boolean visible = false
integer y = 12
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_albaranes_proveedor"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_albaranes_proveedor
integer y = 252
integer width = 3589
integer height = 1596
string dataobject = "dw_con_albaranes_proveedor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[1]="w_con_albaranes_proveedor"
lstr_param.s_argumentos[3]=This.GetItemString(Row,"comcabalb_anyo")
lstr_param.s_argumentos[2]=This.GetItemString(Row,"comcabalb_albaran")
OpenWithParm(w_mant_comlinalb,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_albaranes_proveedor
integer x = 3465
integer y = 144
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;Parent.triggerevent("ue_listar")
f_activar_campo(uo_proveedor.em_campo)
end event

type uo_proveedor from u_em_campo_2 within w_con_albaranes_proveedor
event destroy ( )
integer x = 18
integer y = 144
integer width = 1600
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)

IF Trim(uo_proveedor.em_campo.text) = "" THEN 
	IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
else
	dw_1.Retrieve(codigo_empresa,this.em_codigo.text)
END IF



end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE PROVEEDORES"
		ue_datawindow = "dw_ayuda_proveedores"
		ue_filtro     = ""

end event

type gb_1 from groupbox within w_con_albaranes_proveedor
integer y = 100
integer width = 1637
integer height = 144
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proveedor"
end type

