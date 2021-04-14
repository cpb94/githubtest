$PBExportHeader$w_con_pedidos_fabricar_fam_form_ini.srw
forward
global type w_con_pedidos_fabricar_fam_form_ini from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_fabricar_fam_form_ini
end type
type pb_2 from upb_imprimir within w_con_pedidos_fabricar_fam_form_ini
end type
type dw_detalle from datawindow within w_con_pedidos_fabricar_fam_form_ini
end type
type dw_listado from datawindow within w_con_pedidos_fabricar_fam_form_ini
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_fabricar_fam_form_ini
end type
type cb_1 from commandbutton within w_con_pedidos_fabricar_fam_form_ini
end type
type uo_familia from u_em_campo_2 within w_con_pedidos_fabricar_fam_form_ini
end type
type gb_11 from groupbox within w_con_pedidos_fabricar_fam_form_ini
end type
type gb_10 from groupbox within w_con_pedidos_fabricar_fam_form_ini
end type
type gb_7 from groupbox within w_con_pedidos_fabricar_fam_form_ini
end type
type uo_formato from u_em_campo_2 within w_con_pedidos_fabricar_fam_form_ini
end type
type em_desde from u_em_campo within w_con_pedidos_fabricar_fam_form_ini
end type
type em_hasta from u_em_campo within w_con_pedidos_fabricar_fam_form_ini
end type
type gb_8 from groupbox within w_con_pedidos_fabricar_fam_form_ini
end type
type cb_2 from commandbutton within w_con_pedidos_fabricar_fam_form_ini
end type
end forward

global type w_con_pedidos_fabricar_fam_form_ini from w_int_con_empresa
integer width = 2907
integer height = 1632
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
cb_1 cb_1
uo_familia uo_familia
gb_11 gb_11
gb_10 gb_10
gb_7 gb_7
uo_formato uo_formato
em_desde em_desde
em_hasta em_hasta
gb_8 gb_8
cb_2 cb_2
end type
global w_con_pedidos_fabricar_fam_form_ini w_con_pedidos_fabricar_fam_form_ini

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string v_cliente,fam,form,ini1,ini2
dw_detalle.Reset()

if Trim(uo_familia.em_codigo.text) <> "" then 
	fam = uo_familia.em_codigo.text
else
	fam = "%"
end if

if Trim(uo_formato.em_codigo.text) <> "" then 
	form = uo_formato.em_codigo.text
else
	form = "%"
end if

if (Trim(em_desde.text)<>"") and (Trim(em_hasta.text)<>"") then
	ini1 = em_desde.text + "."
	ini2 = em_hasta.text + "Z"
else
	ini1 = "."
	ini2 = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
end if
dw_detalle.Retrieve(codigo_empresa,fam,form,ini1,ini2)
//dw_detalle.setsort("empresa Asc,familia Asc,formato Asc,articulo Asc")
//dw_detalle.sort()
dw_detalle.groupcalc()

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido a fabricar"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
uo_familia.em_campo.setfocus()
end event

event ue_listar;string v_cliente,fam,form,ini1,ini2

dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)

dw_report.Reset()

if Trim(uo_familia.em_codigo.text) <> "" then 
	fam = uo_familia.em_codigo.text
else
	fam = "%"
end if

if Trim(uo_formato.em_codigo.text) <> "" then 
	form = uo_formato.em_codigo.text
else
	form = "%"
end if

if (Trim(em_desde.text)<>"") and (Trim(em_hasta.text)<>"") then
	ini1 = em_desde.text + "."
	ini2 = em_hasta.text + "Z"
else
	ini1 = "."
	ini2 = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
end if
dw_report.Retrieve(codigo_empresa,fam,form,ini1,ini2)
//dw_report.setsort("empresa Asc,familia Asc,formato Asc,articulo Asc")
//dw_report.sort()
dw_report.groupcalc()
CALL Super::ue_listar
end event

on w_con_pedidos_fabricar_fam_form_ini.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
this.uo_familia=create uo_familia
this.gb_11=create gb_11
this.gb_10=create gb_10
this.gb_7=create gb_7
this.uo_formato=create uo_formato
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.gb_8=create gb_8
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_familia
this.Control[iCurrent+8]=this.gb_11
this.Control[iCurrent+9]=this.gb_10
this.Control[iCurrent+10]=this.gb_7
this.Control[iCurrent+11]=this.uo_formato
this.Control[iCurrent+12]=this.em_desde
this.Control[iCurrent+13]=this.em_hasta
this.Control[iCurrent+14]=this.gb_8
this.Control[iCurrent+15]=this.cb_2
end on

on w_con_pedidos_fabricar_fam_form_ini.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.cb_1)
destroy(this.uo_familia)
destroy(this.gb_11)
destroy(this.gb_10)
destroy(this.gb_7)
destroy(this.uo_formato)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.gb_8)
destroy(this.cb_2)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_fabricar_fam_form_ini
integer taborder = 110
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_fabricar_fam_form_ini
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_fabricar_fam_form_ini
integer x = 9
integer y = 8
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_con_pedidos_fabricar_fam_form_ini
integer x = 2734
integer y = 8
integer width = 110
integer height = 96
integer taborder = 90
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_fabricar_fam_form_ini
integer x = 2734
integer y = 164
integer taborder = 70
string picturename = "print!"
end type

event clicked;PArent.triggerEvent("ue_listar")

end event

type dw_detalle from datawindow within w_con_pedidos_fabricar_fam_form_ini
integer y = 288
integer width = 2848
integer height = 1128
string dataobject = "dw_con_pedidos_fabricar_fam_form_ini"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;//Integer linea
//linea = row
//IF linea = 0 Then Return
//String controles
//
//controles =  This.GetItemString(linea,"usuario")
//IF controles = "MARCADO" Then
//  This.SetItem(linea,"usuario","NOMARCADO")
//  This.SelectRow(linea,FALSE)
//  f_calculo(2,linea)
//  f_calcula_bruto_linea(2,linea)
//Else
//  This.SetItem(linea,"usuario","MARCADO")
//  This.SelectRow(linea,TRUE)
//  f_calculo(1,linea)
//  f_calcula_bruto_linea(1,linea)
//End If
//
end event

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
	if This.GetItemstring(Row,"empresa") <> codigo_empresa then
		MESSAGEBOX("ATENCION","El pedido que ha seleccionado no pertenece a esta empresa")
	else
	  lstr_param.i_nargumentos=3
	  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
	  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
	  OpenWithParm(w_int_venped,lstr_param) 
	end if
End If
end event

type dw_listado from datawindow within w_con_pedidos_fabricar_fam_form_ini
boolean visible = false
integer y = 4
integer width = 160
integer height = 252
boolean bringtotop = true
string dataobject = "report_con_pedidos_fabricar_fam_form_ini"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_fabricar_fam_form_ini
integer x = 2258
integer y = 120
integer width = 649
integer height = 144
integer taborder = 80
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(uo_familia.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from commandbutton within w_con_pedidos_fabricar_fam_form_ini
integer x = 1673
integer y = 152
integer width = 283
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked; 
 f_control()

end event

type uo_familia from u_em_campo_2 within w_con_pedidos_fabricar_fam_form_ini
event destroy ( )
integer x = 32
integer y = 156
integer width = 526
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_familia.em_campo.text=f_nombre_familia(codigo_empresa,uo_familia.em_codigo.text)

If Trim(uo_familia.em_campo.text)="" then
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Familias"
	ue_datawindow ="dw_ayuda_familias"
	ue_filtro = ""

end event

type gb_11 from groupbox within w_con_pedidos_fabricar_fam_form_ini
integer x = 1659
integer y = 112
integer width = 599
integer height = 152
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
end type

type gb_10 from groupbox within w_con_pedidos_fabricar_fam_form_ini
integer x = 1074
integer y = 92
integer width = 585
integer height = 172
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
string text = "Iniciales"
end type

type gb_7 from groupbox within w_con_pedidos_fabricar_fam_form_ini
integer y = 88
integer width = 590
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Familia"
end type

type uo_formato from u_em_campo_2 within w_con_pedidos_fabricar_fam_form_ini
event destroy ( )
integer x = 626
integer y = 156
integer width = 411
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text)

If Trim(uo_formato.em_campo.text)="" then
	uo_formato.em_campo.text=""
	uo_formato.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Formatos"
	ue_datawindow ="dw_ayuda_formatos"
	ue_filtro = ""

end event

type em_desde from u_em_campo within w_con_pedidos_fabricar_fam_form_ini
integer x = 1157
integer y = 156
integer width = 187
integer taborder = 30
boolean bringtotop = true
end type

event modificado;call super::modificado;em_hasta.text = em_desde.text
end event

type em_hasta from u_em_campo within w_con_pedidos_fabricar_fam_form_ini
integer x = 1435
integer y = 156
integer width = 187
integer taborder = 40
boolean bringtotop = true
end type

type gb_8 from groupbox within w_con_pedidos_fabricar_fam_form_ini
integer x = 594
integer y = 88
integer width = 475
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Formato"
end type

type cb_2 from commandbutton within w_con_pedidos_fabricar_fam_form_ini
integer x = 1961
integer y = 152
integer width = 283
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resumen"
end type

event clicked;if this.text = "Detalle" then
	dw_detalle.modify("datawindow.detail.height = 80")
	dw_detalle.modify("cab_articulo.visible = 1")
	dw_listado.modify("datawindow.detail.height = 80")
	dw_listado.modify("cab_articulo.visible = 1")
	this.text = "Resumen"
else
	dw_detalle.modify("datawindow.detail.height = 0")
	dw_detalle.modify("cab_articulo.visible = 0")
	dw_listado.modify("datawindow.detail.height = 0")
	dw_listado.modify("cab_articulo.visible = 0")
	this.text = "Detalle"
end if
end event

