$PBExportHeader$w_con_resumen_vtas_facturas_direnv.srw
forward
global type w_con_resumen_vtas_facturas_direnv from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_resumen_vtas_facturas_direnv
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_facturas_direnv
end type
type em_fechadesde from u_em_campo within w_con_resumen_vtas_facturas_direnv
end type
type em_fechahasta from u_em_campo within w_con_resumen_vtas_facturas_direnv
end type
type dw_listado from datawindow within w_con_resumen_vtas_facturas_direnv
end type
type cb_1 from commandbutton within w_con_resumen_vtas_facturas_direnv
end type
type uo_cliente from u_em_campo_2 within w_con_resumen_vtas_facturas_direnv
end type
type gb_2 from groupbox within w_con_resumen_vtas_facturas_direnv
end type
type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_facturas_direnv
end type
type dw_detalle from datawindow within w_con_resumen_vtas_facturas_direnv
end type
type cb_2 from commandbutton within w_con_resumen_vtas_facturas_direnv
end type
type gb_1 from groupbox within w_con_resumen_vtas_facturas_direnv
end type
type uo_serie from u_em_campo_2 within w_con_resumen_vtas_facturas_direnv
end type
type gb_4 from groupbox within w_con_resumen_vtas_facturas_direnv
end type
end forward

shared variables
boolean detalle=true
end variables

global type w_con_resumen_vtas_facturas_direnv from w_int_con_empresa
integer width = 3470
integer height = 3352
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_1 cb_1
uo_cliente uo_cliente
gb_2 gb_2
uo_manejo uo_manejo
dw_detalle dw_detalle
cb_2 cb_2
gb_1 gb_1
uo_serie uo_serie
gb_4 gb_4
end type
global w_con_resumen_vtas_facturas_direnv w_con_resumen_vtas_facturas_direnv

type variables
string filtro,grafico = "N"
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);DateTime f1,f2
f1 = DateTime(Date(em_fechadesde.text))
f2 = DateTime(Date(em_fechahasta.text))
string cli1,cli2,serie1,serie2
cli1 = char(1)
cli2 = char(255)

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

IF Trim(uo_cliente.em_codigo.text) <> "" Then
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
END IF
data.retrieve(codigo_empresa,f1,f2,cli1,cli2,serie1,serie2)
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

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen Ventas: facturas por cliente"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"total",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"porcentaje",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"total_pts",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts1",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts2",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts3",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts4",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"total",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"porcentaje",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"total_pts",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts1",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts2",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts3",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts4",f_mascara_decimales(0))
f_activar_campo(em_fechadesde)



end event

on w_con_resumen_vtas_facturas_direnv.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.gb_2=create gb_2
this.uo_manejo=create uo_manejo
this.dw_detalle=create dw_detalle
this.cb_2=create cb_2
this.gb_1=create gb_1
this.uo_serie=create uo_serie
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.uo_manejo
this.Control[iCurrent+10]=this.dw_detalle
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.uo_serie
this.Control[iCurrent+14]=this.gb_4
end on

on w_con_resumen_vtas_facturas_direnv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.gb_2)
destroy(this.uo_manejo)
destroy(this.dw_detalle)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.uo_serie)
destroy(this.gb_4)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_facturas_direnv
integer x = 114
integer y = 1292
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_facturas_direnv
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_facturas_direnv
integer x = 9
integer y = 8
integer width = 3346
integer height = 80
end type

type pb_1 from upb_salir within w_con_resumen_vtas_facturas_direnv
integer x = 3223
integer y = 108
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_facturas_direnv
integer x = 3086
integer y = 116
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = "Desde '"+em_fechadesde.text +"' Hasta '"+em_fechahasta.text+"' "
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)
u_imp.event ue_imprimir(dw_detalle)
end event

type em_fechadesde from u_em_campo within w_con_resumen_vtas_facturas_direnv
integer x = 9
integer y = 156
integer width = 302
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_resumen_vtas_facturas_direnv
integer x = 311
integer y = 156
integer width = 283
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_resumen_vtas_facturas_direnv
boolean visible = false
integer x = 2405
integer y = 12
integer width = 119
integer height = 80
string dataobject = "report_con_resumen_vtas_facturas_cliente"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_resumen_vtas_facturas_direnv
integer x = 2318
integer y = 112
integer width = 270
integer height = 72
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Ok"
end type

event clicked;f_control(dw_detalle)

end event

type uo_cliente from u_em_campo_2 within w_con_resumen_vtas_facturas_direnv
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 622
integer y = 156
integer width = 1083
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,'C',uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_2 from groupbox within w_con_resumen_vtas_facturas_direnv
integer x = 613
integer y = 92
integer width = 1106
integer height = 180
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_facturas_direnv
integer x = 2615
integer y = 68
integer width = 759
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_detalle from datawindow within w_con_resumen_vtas_facturas_direnv
integer x = 9
integer y = 284
integer width = 3365
integer height = 2824
string dataobject = "dw_con_resumen_vtas_facturas_direnv"
boolean vscrollbar = true
boolean border = false
end type

event doubleclicked;//this.Object.elgrafico.visible = 0
//grafico = "N"
end event

event clicked;//IF f_objeto_datawindow(This)= "grafico" Then
//	IF grafico = "N" Then
//		grafico = "S"
//		this.Object.elgrafico.x = 0
//		this.Object.elgrafico.y = 0
//		this.Object.elgrafico.height = 1100
//		this.Object.elgrafico.width = 3031
//		this.Object.elgrafico.visible = 1
//	ELSE
//		grafico = "N"
//		this.Object.elgrafico.visible = 0
//	END IF
//
//END IF
end event

type cb_2 from commandbutton within w_con_resumen_vtas_facturas_direnv
integer x = 2327
integer y = 196
integer width = 270
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Resumen"
end type

event clicked;if detalle then
	dw_detalle.modify("datawindow.detail.height=0")
	dw_detalle.modify("datawindow.trailer.2.height=0")
	dw_listado.modify("datawindow.detail.height=0")
	dw_listado.modify("datawindow.trailer.2.height=0")
	cb_2.text="Detalle"
else
	dw_detalle.modify("datawindow.detail.height=77")
	dw_detalle.modify("datawindow.trailer.2.height=77")
	dw_listado.modify("datawindow.detail.height=77")
	dw_listado.modify("datawindow.trailer.2.height=77")
	cb_2.text="Resumen"
end if

detalle=not detalle
end event

type gb_1 from groupbox within w_con_resumen_vtas_facturas_direnv
integer y = 92
integer width = 613
integer height = 180
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type uo_serie from u_em_campo_2 within w_con_resumen_vtas_facturas_direnv
event destroy ( )
integer x = 1765
integer y = 156
integer width = 453
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_serie.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_serie.em_campo.text=f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)

If Trim(uo_serie.em_campo.text)="" then
	uo_serie.em_campo.text=""
	uo_serie.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Series"
	ue_datawindow ="dw_ayuda_venseries"
	ue_filtro = ""

end event

type gb_4 from groupbox within w_con_resumen_vtas_facturas_direnv
integer x = 1746
integer y = 96
integer width = 489
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

