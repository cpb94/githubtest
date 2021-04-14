$PBExportHeader$w_con_resumen_vtas_facturas_cliente.srw
forward
global type w_con_resumen_vtas_facturas_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_resumen_vtas_facturas_cliente
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_facturas_cliente
end type
type em_fechadesde from u_em_campo within w_con_resumen_vtas_facturas_cliente
end type
type em_fechahasta from u_em_campo within w_con_resumen_vtas_facturas_cliente
end type
type dw_listado from datawindow within w_con_resumen_vtas_facturas_cliente
end type
type cb_1 from commandbutton within w_con_resumen_vtas_facturas_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_resumen_vtas_facturas_cliente
end type
type gb_2 from groupbox within w_con_resumen_vtas_facturas_cliente
end type
type cb_2 from commandbutton within w_con_resumen_vtas_facturas_cliente
end type
type gb_1 from groupbox within w_con_resumen_vtas_facturas_cliente
end type
type uo_serie from u_em_campo_2 within w_con_resumen_vtas_facturas_cliente
end type
type uo_agente from u_em_campo_2 within w_con_resumen_vtas_facturas_cliente
end type
type gb_4 from groupbox within w_con_resumen_vtas_facturas_cliente
end type
type dw_detalle from datawindow within w_con_resumen_vtas_facturas_cliente
end type
type uo_fpago from u_em_campo_2 within w_con_resumen_vtas_facturas_cliente
end type
type cb_exportar from u_boton within w_con_resumen_vtas_facturas_cliente
end type
type dw_export_excel from datawindow within w_con_resumen_vtas_facturas_cliente
end type
type gb_5 from groupbox within w_con_resumen_vtas_facturas_cliente
end type
type gb_6 from groupbox within w_con_resumen_vtas_facturas_cliente
end type
end forward

shared variables
boolean detalle=true
end variables

global type w_con_resumen_vtas_facturas_cliente from w_int_con_empresa
integer width = 3822
integer height = 3264
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_1 cb_1
uo_cliente uo_cliente
gb_2 gb_2
cb_2 cb_2
gb_1 gb_1
uo_serie uo_serie
uo_agente uo_agente
gb_4 gb_4
dw_detalle dw_detalle
uo_fpago uo_fpago
cb_exportar cb_exportar
dw_export_excel dw_export_excel
gb_5 gb_5
gb_6 gb_6
end type
global w_con_resumen_vtas_facturas_cliente w_con_resumen_vtas_facturas_cliente

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
string agente
string fpago
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

if uo_agente.em_codigo.text <> "" then
	agente = uo_agente.em_codigo.text
else
	agente = '%'
end if

if uo_fpago.em_codigo.text <> "" then
	fpago = uo_fpago.em_codigo.text
else
	fpago = '%'
	
end if

data.retrieve(codigo_empresa,f1,f2,cli1,cli2,serie1,serie2, agente, fpago)

data.sort()
data.groupcalc()
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.TriggerEvent("pagina_arriba")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.TriggerEvent("pagina_abajo")
end event

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

on w_con_resumen_vtas_facturas_cliente.create
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
this.cb_2=create cb_2
this.gb_1=create gb_1
this.uo_serie=create uo_serie
this.uo_agente=create uo_agente
this.gb_4=create gb_4
this.dw_detalle=create dw_detalle
this.uo_fpago=create uo_fpago
this.cb_exportar=create cb_exportar
this.dw_export_excel=create dw_export_excel
this.gb_5=create gb_5
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.uo_serie
this.Control[iCurrent+12]=this.uo_agente
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.dw_detalle
this.Control[iCurrent+15]=this.uo_fpago
this.Control[iCurrent+16]=this.cb_exportar
this.Control[iCurrent+17]=this.dw_export_excel
this.Control[iCurrent+18]=this.gb_5
this.Control[iCurrent+19]=this.gb_6
end on

on w_con_resumen_vtas_facturas_cliente.destroy
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
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.uo_serie)
destroy(this.uo_agente)
destroy(this.gb_4)
destroy(this.dw_detalle)
destroy(this.uo_fpago)
destroy(this.cb_exportar)
destroy(this.dw_export_excel)
destroy(this.gb_5)
destroy(this.gb_6)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_facturas_cliente
integer x = 110
integer y = 1276
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_facturas_cliente
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_facturas_cliente
integer x = 9
integer y = 8
integer width = 3735
integer height = 80
end type

type pb_1 from upb_salir within w_con_resumen_vtas_facturas_cliente
integer x = 3602
integer y = 92
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_facturas_cliente
integer x = 3493
integer y = 92
integer taborder = 0
end type

event clicked;call super::clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type em_fechadesde from u_em_campo within w_con_resumen_vtas_facturas_cliente
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

type em_fechahasta from u_em_campo within w_con_resumen_vtas_facturas_cliente
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

type dw_listado from datawindow within w_con_resumen_vtas_facturas_cliente
boolean visible = false
integer x = 3159
integer y = 1156
integer width = 498
integer height = 500
string dataobject = "report_con_resumen_vtas_facturas_cliente"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_resumen_vtas_facturas_cliente
integer x = 2898
integer y = 140
integer width = 393
integer height = 108
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

type uo_cliente from u_em_campo_2 within w_con_resumen_vtas_facturas_cliente
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

type gb_2 from groupbox within w_con_resumen_vtas_facturas_cliente
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

type cb_2 from commandbutton within w_con_resumen_vtas_facturas_cliente
integer x = 2898
integer y = 292
integer width = 393
integer height = 108
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

type gb_1 from groupbox within w_con_resumen_vtas_facturas_cliente
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

type uo_serie from u_em_campo_2 within w_con_resumen_vtas_facturas_cliente
event destroy ( )
integer x = 1742
integer y = 344
integer width = 873
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

type uo_agente from u_em_campo_2 within w_con_resumen_vtas_facturas_cliente
event destroy ( )
integer x = 1746
integer y = 160
integer width = 823
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)

If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Agentes"
	ue_datawindow ="dw_ayuda_venagentes"
	ue_filtro = ""

end event

type gb_4 from groupbox within w_con_resumen_vtas_facturas_cliente
integer x = 1723
integer y = 272
integer width = 910
integer height = 184
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

type dw_detalle from datawindow within w_con_resumen_vtas_facturas_cliente
integer y = 456
integer width = 3735
integer height = 2612
string dataobject = "dw_con_resumen_vtas_facturas_clientes"
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

type uo_fpago from u_em_campo_2 within w_con_resumen_vtas_facturas_cliente
event destroy ( )
integer x = 631
integer y = 344
integer width = 1074
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_fpago.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_fpago.em_campo.text=f_nombre_carforpag(codigo_empresa,uo_fpago.em_codigo.text)

If Trim(uo_fpago.em_campo.text)="" then
	uo_fpago.em_campo.text=""
	uo_fpago.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de formas de pago"
	ue_datawindow ="dw_ayuda_carforpag"
	ue_filtro = ""

end event

type cb_exportar from u_boton within w_con_resumen_vtas_facturas_cliente
integer x = 3351
integer y = 292
integer width = 393
integer height = 108
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;call super::clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_detalle.rowcount()

if ll_registros > 0 then
	dw_export_excel.reset()
	dw_export_excel.object.data = dw_detalle.object.data
	
	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
		//dw_detalle.SaveAs(ls_ruta_fichero, Excel!, true)
		uf_save_dw_as_excel(dw_export_excel, ls_ruta_fichero)
		
	end if

//	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
//		//dw_detalle.SaveAs(ls_ruta_fichero, Excel!, true)
//		
//		guardaraexcel2(dw_export_excel,ls_ruta_fichero)
//	end if

end if

end event

type dw_export_excel from datawindow within w_con_resumen_vtas_facturas_cliente
boolean visible = false
integer x = 1472
integer y = 156
integer width = 1202
integer height = 196
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_con_resumen_vtas_facturas_clientes_ex"
boolean vscrollbar = true
boolean border = false
end type

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

event doubleclicked;//this.Object.elgrafico.visible = 0
//grafico = "N"
end event

type gb_5 from groupbox within w_con_resumen_vtas_facturas_cliente
integer x = 1714
integer y = 96
integer width = 923
integer height = 172
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

type gb_6 from groupbox within w_con_resumen_vtas_facturas_cliente
integer x = 613
integer y = 276
integer width = 1111
integer height = 184
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Forma de pago"
end type

