$PBExportHeader$w_con_precartera_pagos.srw
forward
global type w_con_precartera_pagos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_precartera_pagos
end type
type cb_consulta from u_boton within w_con_precartera_pagos
end type
type dw_listado from datawindow within w_con_precartera_pagos
end type
type uo_proveedor from u_em_campo_2 within w_con_precartera_pagos
end type
type st_2 from statictext within w_con_precartera_pagos
end type
type dw_2 from u_datawindow_consultas within w_con_precartera_pagos
end type
type pb_1 from upb_imprimir within w_con_precartera_pagos
end type
end forward

global type w_con_precartera_pagos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2949
integer height = 2160
pb_2 pb_2
cb_consulta cb_consulta
dw_listado dw_listado
uo_proveedor uo_proveedor
st_2 st_2
dw_2 dw_2
pb_1 pb_1
end type
global w_con_precartera_pagos w_con_precartera_pagos

type variables
Date fpago
Dec num_talon
end variables

forward prototypes
public subroutine f_cargar ()
end prototypes

public subroutine f_cargar ();Integer registros
String pro1,pro2
dw_2.reset()
dw_2.SetTransObject(sqlca)
IF Trim(uo_proveedor.em_campo.text) = "" Then
	pro1 = "."
	pro2 = "Z"
ELSE
	pro1 = uo_proveedor.em_codigo.text
	pro2 = uo_proveedor.em_codigo.text
END IF
dw_2.Retrieve(codigo_empresa,pro1,pro2)


end subroutine

event open;call super::open;String mascara
dw_listado.SetTransObject(sqlca)
This.title = " CONSULTA PAGOS PRECARTERA"
f_activar_campo(uo_proveedor.em_campo)


end event

on w_con_precartera_pagos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.dw_listado=create dw_listado
this.uo_proveedor=create uo_proveedor
this.st_2=create st_2
this.dw_2=create dw_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_proveedor
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.pb_1
end on

on w_con_precartera_pagos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.dw_listado)
destroy(this.uo_proveedor)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.pb_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_2)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_2)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_2)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_2)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_precartera_pagos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_precartera_pagos
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_precartera_pagos
integer x = 64
integer width = 2555
end type

type pb_2 from upb_salir within w_con_precartera_pagos
integer x = 2734
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_precartera_pagos
integer x = 2011
integer y = 140
integer width = 357
integer height = 88
integer taborder = 0
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar()
f_activar_campo(uo_proveedor.em_campo)

end event

type dw_listado from datawindow within w_con_precartera_pagos
boolean visible = false
integer y = 28
integer width = 379
integer height = 112
integer taborder = 20
string dataobject = "report_con_precartera_pagos"
boolean livescroll = true
end type

type uo_proveedor from u_em_campo_2 within w_con_precartera_pagos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 338
integer y = 148
integer width = 1573
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
If Trim(uo_proveedor.em_campo.text)="" then
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_con_precartera_pagos
integer x = 27
integer y = 164
integer width = 302
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_2 from u_datawindow_consultas within w_con_precartera_pagos
event rbuttondown pbm_dwnrbuttondown
event key pbm_dwnkey
integer y = 252
integer width = 2880
integer height = 1680
integer taborder = 10
string dataobject = "dw_con_precartera_pagos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;call super::rbuttondown;long anyo,orden

if row > 0 then
	anyo  = this.object.anyo[row]
	orden = this.object.orden[row]
	f_muestra_detalle_pago_agrupado(anyo,orden,ypos + this.y + parent.y)
end if
end event

type pb_1 from upb_imprimir within w_con_precartera_pagos
integer x = 2373
integer y = 140
end type

event clicked;call super::clicked;Integer registros
String pro1,pro2
dw_listado.reset()
dw_listado.SetTransObject(sqlca)
IF Trim(uo_proveedor.em_campo.text) = "" Then
	pro1 = "."
	pro2 = "Z"
ELSE
	pro1 = uo_proveedor.em_codigo.text
	pro2 = uo_proveedor.em_codigo.text
END IF
dw_listado.Retrieve(codigo_empresa,pro1,pro2)
f_imprimir_datawindow(dw_listado)


end event

