$PBExportHeader$w_con_albaranes_agencia.srw
forward
global type w_con_albaranes_agencia from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_albaranes_agencia
end type
type pb_2 from upb_imprimir within w_con_albaranes_agencia
end type
type st_2 from statictext within w_con_albaranes_agencia
end type
type dw_detalle from datawindow within w_con_albaranes_agencia
end type
type dw_listado from datawindow within w_con_albaranes_agencia
end type
type uo_manejo from u_manejo_datawindow within w_con_albaranes_agencia
end type
type uo_transpor from u_em_campo_2 within w_con_albaranes_agencia
end type
type em_desde from u_em_campo within w_con_albaranes_agencia
end type
type em_hasta from u_em_campo within w_con_albaranes_agencia
end type
type st_3 from statictext within w_con_albaranes_agencia
end type
type st_4 from statictext within w_con_albaranes_agencia
end type
type gb_1 from groupbox within w_con_albaranes_agencia
end type
type cb_1 from commandbutton within w_con_albaranes_agencia
end type
end forward

global type w_con_albaranes_agencia from w_int_con_empresa
integer width = 3470
integer height = 1672
pb_1 pb_1
pb_2 pb_2
st_2 st_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
uo_transpor uo_transpor
em_desde em_desde
em_hasta em_hasta
st_3 st_3
st_4 st_4
gb_1 gb_1
cb_1 cb_1
end type
global w_con_albaranes_agencia w_con_albaranes_agencia

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string transp

dw_detalle.Reset()

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_desde.Text)))
fecha2=Datetime(Date(String(em_hasta.Text)))

if trim(uo_transpor.em_codigo.text) <> "" then
	transp = uo_transpor.em_codigo.text
else
	transp = "%"
end if

dw_detalle.Retrieve(codigo_empresa,transp,fecha1,fecha2)

f_activar_campo(uo_transpor.em_campo)

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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de albarán por agencia"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

em_desde.text = String(MDY(01,01,Year(Today())))
em_hasta.text = String(Today())

f_activar_campo(uo_transpor.em_campo)
end event

event ue_listar;String transp

dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_desde.Text)))
fecha2=Datetime(Date(String(em_hasta.Text)))

if trim(uo_transpor.em_codigo.text) <> "" then
	transp = uo_transpor.em_codigo.text
else
	transp = "%"
end if

dw_report.retrieve(codigo_empresa,transp,fecha1,fecha2)

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar

f_activar_campo(uo_transpor.em_campo)
end event

on w_con_albaranes_agencia.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.uo_transpor=create uo_transpor
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_3=create st_3
this.st_4=create st_4
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.uo_transpor
this.Control[iCurrent+8]=this.em_desde
this.Control[iCurrent+9]=this.em_hasta
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.cb_1
end on

on w_con_albaranes_agencia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.uo_transpor)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_1)
destroy(this.cb_1)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_albaranes_agencia
integer x = 521
integer y = 720
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_albaranes_agencia
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_albaranes_agencia
integer x = 9
integer width = 2427
end type

type pb_1 from upb_salir within w_con_albaranes_agencia
integer x = 3237
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_albaranes_agencia
integer x = 2706
integer y = 212
integer taborder = 0
string picturename = "print!"
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_albaranes_agencia
integer x = 18
integer y = 120
integer width = 389
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Transportista"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_detalle from datawindow within w_con_albaranes_agencia
integer x = 5
integer y = 320
integer width = 3355
integer height = 1104
string dataobject = "dw_con_albaranes_agencia"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;Integer linea
linea = row
IF linea = 0 Then Return
String controles

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

type dw_listado from datawindow within w_con_albaranes_agencia
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_con_albaranes_agencia"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_albaranes_agencia
integer x = 2231
integer y = 168
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(uo_transpor.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type uo_transpor from u_em_campo_2 within w_con_albaranes_agencia
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 425
integer y = 120
integer width = 1289
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_transpor.em_campo.text=f_nombre_ventransportista(codigo_empresa,uo_transpor.em_codigo.text)
If Trim(uo_transpor.em_campo.text)="" then
	uo_transpor.em_campo.text=""
	uo_transpor.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Transportistaa"
ue_datawindow ="dw_ayuda_ventransportistas"
ue_filtro = ""
end event

on uo_transpor.destroy
call u_em_campo_2::destroy
end on

type em_desde from u_em_campo within w_con_albaranes_agencia
integer x = 425
integer y = 212
integer width = 297
integer height = 80
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_hasta from u_em_campo within w_con_albaranes_agencia
integer x = 987
integer y = 212
integer width = 297
integer height = 80
integer taborder = 40
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_3 from statictext within w_con_albaranes_agencia
integer x = 23
integer y = 212
integer width = 370
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_albaranes_agencia
integer x = 745
integer y = 212
integer width = 183
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_albaranes_agencia
integer x = 9
integer y = 76
integer width = 1723
integer height = 236
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_1 from commandbutton within w_con_albaranes_agencia
integer x = 1335
integer y = 212
integer width = 379
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;f_control()
end event

