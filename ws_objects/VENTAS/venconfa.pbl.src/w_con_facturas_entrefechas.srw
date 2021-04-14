$PBExportHeader$w_con_facturas_entrefechas.srw
$PBExportComments$€
forward
global type w_con_facturas_entrefechas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_facturas_entrefechas
end type
type pb_2 from upb_imprimir within w_con_facturas_entrefechas
end type
type dw_detalle from datawindow within w_con_facturas_entrefechas
end type
type dw_listado from datawindow within w_con_facturas_entrefechas
end type
type uo_manejo from u_manejo_datawindow within w_con_facturas_entrefechas
end type
type gb_fecha from groupbox within w_con_facturas_entrefechas
end type
type em_fechadesde from u_em_campo within w_con_facturas_entrefechas
end type
type em_fechahasta from u_em_campo within w_con_facturas_entrefechas
end type
type dw_1 from datawindow within w_con_facturas_entrefechas
end type
type st_2 from statictext within w_con_facturas_entrefechas
end type
type st_3 from statictext within w_con_facturas_entrefechas
end type
type cb_1 from commandbutton within w_con_facturas_entrefechas
end type
type uo_serie from u_em_campo_2 within w_con_facturas_entrefechas
end type
type gb_4 from groupbox within w_con_facturas_entrefechas
end type
end forward

global type w_con_facturas_entrefechas from w_int_con_empresa
integer x = 78
integer y = 16
integer width = 3561
integer height = 3156
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
gb_fecha gb_fecha
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
dw_1 dw_1
st_2 st_2
st_3 st_3
cb_1 cb_1
uo_serie uo_serie
gb_4 gb_4
end type
global w_con_facturas_entrefechas w_con_facturas_entrefechas

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();String serie1,serie2

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),serie1,serie2)
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_manejo.TriggerEvent("linea_arriba")
f_cursor_arriba(dw_detalle)
end event

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de facturas entre fechas"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)
em_fechadesde.text=string(datetime(date(year(today()),01,01)))
em_fechahasta.text=string(datetime(today()))


end event

event ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//dw_report.retrieve(codigo_empresa,em_cliente.text)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end event

on w_con_facturas_entrefechas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.gb_fecha=create gb_fecha
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.dw_1=create dw_1
this.st_2=create st_2
this.st_3=create st_3
this.cb_1=create cb_1
this.uo_serie=create uo_serie
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.gb_fecha
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.uo_serie
this.Control[iCurrent+14]=this.gb_4
end on

on w_con_facturas_entrefechas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.gb_fecha)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.uo_serie)
destroy(this.gb_4)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
f_cursor_abajo(dw_detalle)
end event

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_facturas_entrefechas
integer x = 782
integer y = 776
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_facturas_entrefechas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_facturas_entrefechas
integer x = 9
integer y = 8
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_facturas_entrefechas
integer x = 3442
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_facturas_entrefechas
integer x = 3250
integer y = 192
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;PArent.triggerEvent("ue_listar")

end event

type dw_detalle from datawindow within w_con_facturas_entrefechas
integer x = 9
integer y = 304
integer width = 1093
integer height = 2668
string dataobject = "dw_con_facturas_entrefechas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"factura"))
  OpenWithParm(w_int_venfac,lstr_param) 
End If
end event

event rowfocuschanged;Integer linea
long altura=0,c
linea = currentrow

IF linea = 0 or isnull(linea) Then Return

if linea=1 then 
	if dw_detalle.RowCount()=0 then Return
End if

dw_detalle.selectrow(0,false)
dw_detalle.selectrow(linea,true)

dec v_factura,v_anyo

v_factura=dw_detalle.getItemNumber(linea,"factura")
v_anyo=dw_detalle.getItemNumber(linea,"anyo")

dw_1.reset()
dw_1.retrieve(codigo_empresa,v_anyo,v_factura)

end event

type dw_listado from datawindow within w_con_facturas_entrefechas
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_con_factura_entrefechas"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_facturas_entrefechas
integer x = 2775
integer y = 148
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_fecha from groupbox within w_con_facturas_entrefechas
integer x = 9
integer y = 120
integer width = 1143
integer height = 176
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type em_fechadesde from u_em_campo within w_con_facturas_entrefechas
integer x = 256
integer y = 196
integer width = 311
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fechahasta from u_em_campo within w_con_facturas_entrefechas
integer x = 809
integer y = 196
integer width = 311
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type dw_1 from datawindow within w_con_facturas_entrefechas
integer x = 1120
integer y = 308
integer width = 2423
integer height = 2668
boolean bringtotop = true
string dataobject = "dw_con_linfac_entrefechas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_con_facturas_entrefechas
integer x = 32
integer y = 204
integer width = 219
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_facturas_entrefechas
integer x = 585
integer y = 204
integer width = 210
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_con_facturas_entrefechas
event clicked pbm_bnclicked
integer x = 1714
integer y = 172
integer width = 361
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;f_control()
end event

type uo_serie from u_em_campo_2 within w_con_facturas_entrefechas
event destroy ( )
integer x = 1175
integer y = 176
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

type gb_4 from groupbox within w_con_facturas_entrefechas
integer x = 1157
integer y = 116
integer width = 489
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Serie"
end type

