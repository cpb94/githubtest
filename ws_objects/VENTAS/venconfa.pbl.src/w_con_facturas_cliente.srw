$PBExportHeader$w_con_facturas_cliente.srw
forward
global type w_con_facturas_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_facturas_cliente
end type
type pb_2 from upb_imprimir within w_con_facturas_cliente
end type
type dw_listado from datawindow within w_con_facturas_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_facturas_cliente
end type
type gb_fecha from groupbox within w_con_facturas_cliente
end type
type gb_1 from groupbox within w_con_facturas_cliente
end type
type em_fechadesde from u_em_campo within w_con_facturas_cliente
end type
type em_fechahasta from u_em_campo within w_con_facturas_cliente
end type
type st_1 from statictext within w_con_facturas_cliente
end type
type dw_1 from datawindow within w_con_facturas_cliente
end type
type dw_detalle from u_datawindow_consultas within w_con_facturas_cliente
end type
type uo_agente from u_em_campo_2 within w_con_facturas_cliente
end type
type cb_consulta from commandbutton within w_con_facturas_cliente
end type
type gb_2 from groupbox within w_con_facturas_cliente
end type
end forward

global type w_con_facturas_cliente from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 4050
integer height = 3104
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
uo_cliente uo_cliente
gb_fecha gb_fecha
gb_1 gb_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_1 st_1
dw_1 dw_1
dw_detalle dw_detalle
uo_agente uo_agente
cb_consulta cb_consulta
gb_2 gb_2
end type
global w_con_facturas_cliente w_con_facturas_cliente

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,datetime(em_fechadesde.text),datetime(em_fechahasta.text))
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_manejo.TriggerEvent("linea_arriba")
f_cursor_arriba(dw_detalle)
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de facturas por cliente"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)
em_fechadesde.text=string(datetime(date(year(today()),01,01)))
em_fechahasta.text=string(datetime(today()))


end event

event ue_listar;string cliente, agente

if uo_cliente.em_codigo.text = '' then
	cliente = '%'
else
	cliente = uo_cliente.em_codigo.text 
end if 

if uo_agente.em_codigo.text = '' then
	agente = '%'
else
	agente = uo_agente.em_codigo.text 
end if 




dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)

dw_report.object.titulo_agente.text = uo_agente.em_campo.text
dw_report.object.titulo_cliente.text = uo_cliente.em_campo.text

dw_report.Retrieve(codigo_empresa, cliente, agente, datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)))

CALL Super::ue_listar
end event

on w_con_facturas_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.uo_cliente=create uo_cliente
this.gb_fecha=create gb_fecha
this.gb_1=create gb_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_detalle=create dw_detalle
this.uo_agente=create uo_agente
this.cb_consulta=create cb_consulta
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.gb_fecha
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.dw_detalle
this.Control[iCurrent+12]=this.uo_agente
this.Control[iCurrent+13]=this.cb_consulta
this.Control[iCurrent+14]=this.gb_2
end on

on w_con_facturas_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.uo_cliente)
destroy(this.gb_fecha)
destroy(this.gb_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_detalle)
destroy(this.uo_agente)
destroy(this.cb_consulta)
destroy(this.gb_2)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
f_cursor_abajo(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_facturas_cliente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_facturas_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_facturas_cliente
integer x = 9
integer width = 3785
integer height = 88
integer textsize = -12
boolean italic = true
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_con_facturas_cliente
integer x = 3913
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "EXIT!"
end type

type pb_2 from upb_imprimir within w_con_facturas_cliente
integer x = 3913
integer y = 188
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type dw_listado from datawindow within w_con_facturas_cliente
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_factura_cliente"
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_con_facturas_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 754
integer y = 184
integer width = 1248
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;dw_1.Reset()
dw_detalle.Reset()
uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

//dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_fecha from groupbox within w_con_facturas_cliente
integer x = 23
integer y = 100
integer width = 672
integer height = 196
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type gb_1 from groupbox within w_con_facturas_cliente
integer x = 704
integer y = 100
integer width = 1344
integer height = 196
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type em_fechadesde from u_em_campo within w_con_facturas_cliente
integer x = 41
integer y = 184
integer width = 279
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

type em_fechahasta from u_em_campo within w_con_facturas_cliente
integer x = 379
integer y = 184
integer width = 279
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

type st_1 from statictext within w_con_facturas_cliente
integer x = 311
integer y = 180
integer width = 64
integer height = 68
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_facturas_cliente
integer x = 1303
integer y = 328
integer width = 2715
integer height = 2596
boolean bringtotop = true
string dataobject = "dw_con_linfac_cliente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_detalle from u_datawindow_consultas within w_con_facturas_cliente
integer x = 14
integer y = 328
integer width = 1280
integer height = 2600
integer taborder = 0
string dataobject = "dw_con_facturas_cliente"
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;Integer linea
long altura=0,c

IF dw_detalle.RowCount()=0 then return
linea = currentrow

dec v_factura,v_anyo
v_factura = dw_detalle.getItemNumber(linea,"factura")
v_anyo    = dw_detalle.getItemNumber(linea,"anyo")

dw_1.reset()
dw_1.retrieve(codigo_empresa,v_anyo,v_factura)

end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF rowCount() = 0 Then Return
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"factura"))
  OpenWithParm(w_int_venfac,lstr_param) 
End If
end event

event retrieveend;call super::retrieveend;//
//IF rowcount = 0 Then Return
//SetRow(1)
//dec v_factura,v_anyo
//v_factura=dw_detalle.getItemNumber(1,"factura")
//v_anyo=dw_detalle.getItemNumber(1,"anyo")
//dw_1.reset()
//dw_1.retrieve(codigo_empresa,v_anyo,v_factura)
//
end event

type uo_agente from u_em_campo_2 within w_con_facturas_cliente
event destroy ( )
integer x = 2107
integer y = 188
integer width = 1225
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;dw_1.Reset()
dw_detalle.Reset()
uo_agente.em_campo.text = f_nombre_agente(codigo_empresa, uo_agente.em_codigo.text)

If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 

//dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Agentes"
	ue_datawindow ="dw_ayuda_venagentes"
	ue_filtro = ""

end event

type cb_consulta from commandbutton within w_con_facturas_cliente
integer x = 3442
integer y = 180
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;string cliente, agente

if uo_cliente.em_codigo.text = '' then
	cliente = '%'
else
	cliente = uo_cliente.em_codigo.text 
end if 

if uo_agente.em_codigo.text = '' then
	agente = '%'
else
	agente = uo_agente.em_codigo.text 
end if 


dw_detalle.Retrieve(codigo_empresa, cliente, agente, datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)))
end event

type gb_2 from groupbox within w_con_facturas_cliente
integer x = 2057
integer y = 104
integer width = 1303
integer height = 196
integer taborder = 50
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

