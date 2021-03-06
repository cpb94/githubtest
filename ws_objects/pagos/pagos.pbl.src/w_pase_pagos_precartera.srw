$PBExportHeader$w_pase_pagos_precartera.srw
forward
global type w_pase_pagos_precartera from w_int_con_empresa
end type
type pb_2 from upb_salir within w_pase_pagos_precartera
end type
type dw_listado from datawindow within w_pase_pagos_precartera
end type
type cb_consulta from u_boton within w_pase_pagos_precartera
end type
type dw_listado1 from datawindow within w_pase_pagos_precartera
end type
type uo_proveedor from u_em_campo_2 within w_pase_pagos_precartera
end type
type st_2 from statictext within w_pase_pagos_precartera
end type
type gb_1 from groupbox within w_pase_pagos_precartera
end type
type dw_2 from u_datawindow_consultas within w_pase_pagos_precartera
end type
type dw_1 from u_datawindow_consultas within w_pase_pagos_precartera
end type
end forward

global type w_pase_pagos_precartera from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3017
integer height = 1648
pb_2 pb_2
dw_listado dw_listado
cb_consulta cb_consulta
dw_listado1 dw_listado1
uo_proveedor uo_proveedor
st_2 st_2
gb_1 gb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_pase_pagos_precartera w_pase_pagos_precartera

type variables
Date fpago
Dec num_talon
end variables

forward prototypes
public subroutine f_cargar ()
end prototypes

public subroutine f_cargar ();Integer registros
String pro1,pro2
dw_1.reset()
dw_2.reset()
dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
IF Trim(uo_proveedor.em_campo.text) = "" Then
	pro1 = "."
	pro2 = "Z"
ELSE
	pro1 = uo_proveedor.em_codigo.text
	pro2 = uo_proveedor.em_codigo.text
END IF
dw_1.Retrieve(codigo_empresa,pro1,pro2)
dw_2.Retrieve(codigo_empresa,pro1,pro2)


end subroutine

event open;call super::open;String mascara
dw_listado.SetTransObject(sqlca)
dw_listado1.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
This.title = " PASE PAGOS A PRECARTERA"
f_activar_campo(uo_proveedor.em_campo)


end event

on w_pase_pagos_precartera.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.cb_consulta=create cb_consulta
this.dw_listado1=create dw_listado1
this.uo_proveedor=create uo_proveedor
this.st_2=create st_2
this.gb_1=create gb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.dw_listado1
this.Control[iCurrent+5]=this.uo_proveedor
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.dw_1
end on

on w_pase_pagos_precartera.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.cb_consulta)
destroy(this.dw_listado1)
destroy(this.uo_proveedor)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_pase_pagos_precartera
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_pase_pagos_precartera
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_pase_pagos_precartera
integer x = 64
integer width = 2555
end type

type pb_2 from upb_salir within w_pase_pagos_precartera
integer x = 2821
integer y = 8
integer width = 110
integer height = 100
integer taborder = 0
end type

type dw_listado from datawindow within w_pase_pagos_precartera
boolean visible = false
integer x = 393
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_emision_pagos_cartas"
boolean livescroll = true
end type

type cb_consulta from u_boton within w_pase_pagos_precartera
integer x = 2016
integer y = 148
integer width = 347
integer height = 80
integer taborder = 0
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar()
f_activar_campo(uo_proveedor.em_campo)

end event

type dw_listado1 from datawindow within w_pase_pagos_precartera
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
integer taborder = 10
string dataobject = "report_emision_pagos_recibos"
boolean livescroll = true
end type

type uo_proveedor from u_em_campo_2 within w_pase_pagos_precartera
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 338
integer y = 148
integer width = 1573
integer taborder = 20
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

type st_2 from statictext within w_pase_pagos_precartera
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
long backcolor = 67108864
boolean enabled = false
string text = "Proveedor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pase_pagos_precartera
integer y = 108
integer width = 2400
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_2 from u_datawindow_consultas within w_pase_pagos_precartera
event rbuttondown pbm_dwnrbuttondown
event key pbm_dwnkey
integer y = 896
integer width = 2930
integer height = 516
integer taborder = 2
boolean titlebar = true
string title = "Pagos en precartera"
string dataobject = "dw_pase_pagos_precartera2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;Dec  anyo,orden
IF row = 0 Then Return
anyo  = dw_2.GetItemNumber(row,"anyo")
orden = dw_2.GetItemNumber(row,"orden")
Update carpagos
       Set   situacion = "0"
		 Where empresa = :codigo_empresa
		 And   anyo    = :anyo
		 And   orden   = :orden;
		 COMMIT;
 f_cargar()
end event

type dw_1 from u_datawindow_consultas within w_pase_pagos_precartera
integer y = 264
integer width = 2930
integer height = 632
integer taborder = 0
boolean titlebar = true
string title = "Pagos en cartera"
string dataobject = "dw_pase_pagos_precartera"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;Dec  anyo,orden
IF row = 0 Then Return
anyo  = dw_1.GetItemNumber(row,"anyo")
orden = dw_1.GetItemNumber(row,"orden")
Update carpagos
       Set   situacion = "9"
		 Where empresa = :codigo_empresa
		 And   anyo    = :anyo
		 And   orden   = :orden;
		 COMMIT;
 f_cargar()
end event

