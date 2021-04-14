$PBExportHeader$w_con_datos_proveedores.srw
forward
global type w_con_datos_proveedores from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_datos_proveedores
end type
type pb_imprimir_preli from picturebutton within w_con_datos_proveedores
end type
type uo_proveedor_desde from u_em_campo_2 within w_con_datos_proveedores
end type
type uo_proveedor_hasta from u_em_campo_2 within w_con_datos_proveedores
end type
type st_1 from statictext within w_con_datos_proveedores
end type
type st_2 from statictext within w_con_datos_proveedores
end type
type cb_1 from commandbutton within w_con_datos_proveedores
end type
type dw_1 from datawindow within w_con_datos_proveedores
end type
type dw_listado from datawindow within w_con_datos_proveedores
end type
end forward

global type w_con_datos_proveedores from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2967
integer height = 1656
pb_2 pb_2
pb_imprimir_preli pb_imprimir_preli
uo_proveedor_desde uo_proveedor_desde
uo_proveedor_hasta uo_proveedor_hasta
st_1 st_1
st_2 st_2
cb_1 cb_1
dw_1 dw_1
dw_listado dw_listado
end type
global w_con_datos_proveedores w_con_datos_proveedores

type variables
String situacion= "0"


end variables

forward prototypes
public subroutine f_cargar (datawindow arg_data)
end prototypes

public subroutine f_cargar (datawindow arg_data);string pro1,pro2

if uo_proveedor_desde.em_codigo.text = "" then
	pro1 = "."	
else
	pro1 = uo_proveedor_desde.em_codigo.text 
end if


if uo_proveedor_hasta.em_codigo.text = "" then
	pro2 = "Z"
else	
	pro2 = uo_proveedor_hasta.em_codigo.text
end if




arg_data.retrieve(codigo_empresa,pro1,pro2)
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
This.title = " Datos de los proveedores"













end event

on w_con_datos_proveedores.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_proveedor_desde=create uo_proveedor_desde
this.uo_proveedor_hasta=create uo_proveedor_hasta
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_imprimir_preli
this.Control[iCurrent+3]=this.uo_proveedor_desde
this.Control[iCurrent+4]=this.uo_proveedor_hasta
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.dw_listado
end on

on w_con_datos_proveedores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.pb_imprimir_preli)
destroy(this.uo_proveedor_desde)
destroy(this.uo_proveedor_hasta)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_listado)
end on

event ue_pagina_arriba;//uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;//uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;//f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;//f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_datos_proveedores
integer x = 823
integer y = 72
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_datos_proveedores
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_datos_proveedores
integer x = 59
integer y = 12
integer width = 2642
end type

type pb_2 from upb_salir within w_con_datos_proveedores
integer x = 2734
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type pb_imprimir_preli from picturebutton within w_con_datos_proveedores
integer x = 2734
integer y = 136
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)

end event

type uo_proveedor_desde from u_em_campo_2 within w_con_datos_proveedores
event destroy ( )
integer x = 416
integer y = 152
integer width = 1477
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor_desde.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_proveedor_desde.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor_desde.em_codigo.text)
If Trim(uo_proveedor_desde.em_campo.text)="" then
	uo_proveedor_desde.em_campo.text=""
	uo_proveedor_desde.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

type uo_proveedor_hasta from u_em_campo_2 within w_con_datos_proveedores
event destroy ( )
integer x = 416
integer y = 244
integer width = 1477
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor_hasta.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_proveedor_hasta.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor_hasta.em_codigo.text)
If Trim(uo_proveedor_hasta.em_campo.text)="" then
	uo_proveedor_hasta.em_campo.text=""
	uo_proveedor_hasta.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

type st_1 from statictext within w_con_datos_proveedores
integer x = 133
integer y = 164
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_datos_proveedores
integer x = 155
integer y = 248
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta : "
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_con_datos_proveedores
integer x = 1947
integer y = 184
integer width = 293
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;f_cargar(dw_1)
end event

type dw_1 from datawindow within w_con_datos_proveedores
integer x = 82
integer y = 336
integer width = 2761
integer height = 1080
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_datos_proveedores"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado from datawindow within w_con_datos_proveedores
boolean visible = false
integer x = 2094
integer y = 164
integer width = 494
integer height = 360
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_datos_proveedores"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

