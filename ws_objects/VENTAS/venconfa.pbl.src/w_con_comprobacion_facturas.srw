$PBExportHeader$w_con_comprobacion_facturas.srw
$PBExportComments$€
forward
global type w_con_comprobacion_facturas from w_int_con_empresa
end type
type gb_fecha from groupbox within w_con_comprobacion_facturas
end type
type pb_1 from upb_salir within w_con_comprobacion_facturas
end type
type pb_2 from upb_imprimir within w_con_comprobacion_facturas
end type
type em_fechadesde from u_em_campo within w_con_comprobacion_facturas
end type
type em_fechahasta from u_em_campo within w_con_comprobacion_facturas
end type
type cb_1 from commandbutton within w_con_comprobacion_facturas
end type
type dw_listado from datawindow within w_con_comprobacion_facturas
end type
type dw_detalle from datawindow within w_con_comprobacion_facturas
end type
type st_1 from statictext within w_con_comprobacion_facturas
end type
type uo_serie from u_em_campo_2 within w_con_comprobacion_facturas
end type
type gb_4 from groupbox within w_con_comprobacion_facturas
end type
type uo_pais from u_em_campo_2 within w_con_comprobacion_facturas
end type
type gb_2 from groupbox within w_con_comprobacion_facturas
end type
type uo_cliente from u_em_campo_2 within w_con_comprobacion_facturas
end type
type gb_1 from groupbox within w_con_comprobacion_facturas
end type
type cbx_detalle from checkbox within w_con_comprobacion_facturas
end type
type uo_grupo from u_em_campo_2 within w_con_comprobacion_facturas
end type
type gb_3 from groupbox within w_con_comprobacion_facturas
end type
end forward

global type w_con_comprobacion_facturas from w_int_con_empresa
integer x = 14
integer y = 16
integer width = 4937
integer height = 3508
long backcolor = 32238571
gb_fecha gb_fecha
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
dw_listado dw_listado
dw_detalle dw_detalle
st_1 st_1
uo_serie uo_serie
gb_4 gb_4
uo_pais uo_pais
gb_2 gb_2
uo_cliente uo_cliente
gb_1 gb_1
cbx_detalle cbx_detalle
uo_grupo uo_grupo
gb_3 gb_3
end type
global w_con_comprobacion_facturas w_con_comprobacion_facturas

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();String serie, pais, cliente, grupo

if Trim(uo_serie.em_codigo.text) = "" then 
	serie = '%'
else
	serie = Trim(uo_serie.em_codigo.text)
end if
if Trim(uo_pais.em_codigo.text) = "" then 
	pais = '%'
else
	pais = Trim(uo_pais.em_codigo.text)
end if
if Trim(uo_cliente.em_codigo.text) = "" then 
	cliente = '%'
else
	cliente = Trim(uo_cliente.em_codigo.text)
end if

if Trim(uo_grupo.em_codigo.text) = "" then 
	grupo = '%'
else
	grupo = Trim(uo_grupo.em_codigo.text)
end if

dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,serie,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)), pais, cliente, grupo)

/*
if cbx_detalle.checked and  dw_detalle.rowcount() > 0 then
	dw_detalle.SetDetailHeight ( 1, dw_detalle.rowcount(), 65)
else
	dw_detalle.SetDetailHeight ( 1, dw_detalle.rowcount(), 0)
end if
*/
if cbx_detalle.checked and  dw_detalle.rowcount() > 0 then
	dw_detalle.Object.DataWindow.Detail.Height = 65
	
else
	dw_detalle.Object.DataWindow.Detail.Height = 0

end if

dw_detalle.Object.t_periodo.text = "Desde "+em_fechadesde.text+" Hasta "+em_fechahasta.text
end subroutine

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_manejo.TriggerEvent("linea_arriba")
f_cursor_arriba(dw_detalle)
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta Comprobacion Facturas"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
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

on w_con_comprobacion_facturas.create
int iCurrent
call super::create
this.gb_fecha=create gb_fecha
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.dw_listado=create dw_listado
this.dw_detalle=create dw_detalle
this.st_1=create st_1
this.uo_serie=create uo_serie
this.gb_4=create gb_4
this.uo_pais=create uo_pais
this.gb_2=create gb_2
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.cbx_detalle=create cbx_detalle
this.uo_grupo=create uo_grupo
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_fecha
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.dw_detalle
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.uo_serie
this.Control[iCurrent+11]=this.gb_4
this.Control[iCurrent+12]=this.uo_pais
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.uo_cliente
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.cbx_detalle
this.Control[iCurrent+17]=this.uo_grupo
this.Control[iCurrent+18]=this.gb_3
end on

on w_con_comprobacion_facturas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_fecha)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.dw_listado)
destroy(this.dw_detalle)
destroy(this.st_1)
destroy(this.uo_serie)
destroy(this.gb_4)
destroy(this.uo_pais)
destroy(this.gb_2)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.cbx_detalle)
destroy(this.uo_grupo)
destroy(this.gb_3)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
f_cursor_abajo(dw_detalle)
end event

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_comprobacion_facturas
integer x = 782
integer y = 776
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_comprobacion_facturas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_comprobacion_facturas
integer x = 9
integer y = 8
integer width = 4837
integer height = 88
end type

type gb_fecha from groupbox within w_con_comprobacion_facturas
integer x = 9
integer y = 132
integer width = 704
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Fecha"
end type

type pb_1 from upb_salir within w_con_comprobacion_facturas
integer x = 4681
integer y = 160
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\Fuentes_tencer_PB12\Log Out_24x24.png"
end type

type pb_2 from upb_imprimir within w_con_comprobacion_facturas
integer x = 4535
integer y = 160
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = false
string picturename = "C:\Fuentes_tencer_PB12\printer-icon2_24x24.png"
end type

event clicked;/*
String serie,pais,cliente

if Trim(uo_serie.em_codigo.text) = "" then 
	serie = "%"
else
	serie = Trim(uo_serie.em_codigo.text)
end if
if Trim(uo_pais.em_codigo.text) = "" then 
	pais = '%'
else
	pais = Trim(uo_pais.em_codigo.text)
end if
if Trim(uo_cliente.em_codigo.text) = "" then 
	cliente = '%'
else
	cliente = Trim(uo_cliente.em_codigo.text)
end if

dw_listado.Reset()
dw_listado.Retrieve(codigo_empresa,serie,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),pais,cliente)

f_imprimir_datawindow(dw_listado)

*/

f_imprimir_datawindow(dw_Detalle)

end event

type em_fechadesde from u_em_campo within w_con_comprobacion_facturas
integer x = 27
integer y = 188
integer width = 302
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

type em_fechahasta from u_em_campo within w_con_comprobacion_facturas
integer x = 384
integer y = 188
integer width = 302
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

type cb_1 from commandbutton within w_con_comprobacion_facturas
event clicked pbm_bnclicked
integer x = 4101
integer y = 164
integer width = 416
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;f_control()
end event

type dw_listado from datawindow within w_con_comprobacion_facturas
boolean visible = false
integer x = 590
integer width = 494
integer height = 360
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_comprobacion_facturas"
boolean livescroll = true
end type

type dw_detalle from datawindow within w_con_comprobacion_facturas
event doubleclicked pbm_dwnlbuttondblclk
event rowfocuschanged pbm_dwnrowchange
integer x = 5
integer y = 332
integer width = 4869
integer height = 2996
string dataobject = "dw_comprobacion_facturas"
boolean hscrollbar = true
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

event rowfocuschanged;//Integer linea
//long altura=0,c
//linea = currentrow
//
//IF linea = 0 or isnull(linea) Then Return
//
//if linea=1 then 
//	if dw_detalle.RowCount()=0 then Return
//End if
//
//dw_detalle.selectrow(0,false)
//dw_detalle.selectrow(linea,true)
//
//dec v_factura,v_anyo
//
//v_factura=dw_detalle.getItemNumber(linea,"factura")
//v_anyo=dw_detalle.getItemNumber(linea,"anyo")
//
//dw_1.reset()
//dw_1.retrieve(codigo_empresa,v_anyo,v_factura)
//
end event

type st_1 from statictext within w_con_comprobacion_facturas
integer x = 334
integer y = 196
integer width = 46
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
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

type uo_serie from u_em_campo_2 within w_con_comprobacion_facturas
event destroy ( )
integer x = 741
integer y = 188
integer width = 512
integer taborder = 30
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

type gb_4 from groupbox within w_con_comprobacion_facturas
integer x = 718
integer y = 128
integer width = 558
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Serie"
end type

type uo_pais from u_em_campo_2 within w_con_comprobacion_facturas
event destroy ( )
integer x = 1298
integer y = 188
integer width = 626
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)

If Trim(uo_pais.em_campo.text)="" then
	uo_pais.em_campo.text=""
	uo_pais.em_codigo.text=""
	Return
end if 

end event

event losefocus;call super::losefocus;valor_empresa = TRUE
end event

event getfocus;call super::getfocus;valor_empresa = FALSE
	ue_titulo = "Selección de Paises"
	ue_datawindow ="dw_ayuda_paises"
	ue_filtro = ""

end event

type gb_2 from groupbox within w_con_comprobacion_facturas
integer x = 1275
integer y = 132
integer width = 672
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Pais"
end type

type uo_cliente from u_em_campo_2 within w_con_comprobacion_facturas
event destroy ( )
integer x = 1966
integer y = 192
integer width = 1129
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

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

type gb_1 from groupbox within w_con_comprobacion_facturas
integer x = 1947
integer y = 132
integer width = 1175
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Cliente"
end type

type cbx_detalle from checkbox within w_con_comprobacion_facturas
integer x = 3726
integer y = 188
integer width = 334
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Detalle"
borderstyle borderstyle = styleraised!
end type

event clicked;//	dwcontrol.SetDetailHeight ( long startrow, long endrow, long height )

if cbx_detalle.checked and  dw_detalle.rowcount() > 0 then
	dw_detalle.Object.DataWindow.Detail.Height = 65
	
else
	dw_detalle.Object.DataWindow.Detail.Height = 0

end if
end event

type uo_grupo from u_em_campo_2 within w_con_comprobacion_facturas
event destroy ( )
integer x = 3154
integer y = 192
integer width = 489
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_grupo.em_campo.text = f_nombre_vengrupos(codigo_empresa, uo_grupo.em_codigo.text)

If Trim(uo_grupo.em_campo.text)="" then
	uo_grupo.em_campo.text=""
	uo_grupo.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Grupos"
	ue_datawindow ="dw_ayuda_vengrupos"
	ue_filtro = ""

end event

type gb_3 from groupbox within w_con_comprobacion_facturas
integer x = 3136
integer y = 132
integer width = 535
integer height = 164
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Grupo"
end type

