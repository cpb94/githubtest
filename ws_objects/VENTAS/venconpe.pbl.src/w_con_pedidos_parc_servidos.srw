$PBExportHeader$w_con_pedidos_parc_servidos.srw
forward
global type w_con_pedidos_parc_servidos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_parc_servidos
end type
type pb_2 from upb_imprimir within w_con_pedidos_parc_servidos
end type
type dw_detalle from datawindow within w_con_pedidos_parc_servidos
end type
type dw_listado from datawindow within w_con_pedidos_parc_servidos
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_parc_servidos
end type
type st_9 from statictext within w_con_pedidos_parc_servidos
end type
type em_fechadesde from u_em_campo within w_con_pedidos_parc_servidos
end type
type st_8 from statictext within w_con_pedidos_parc_servidos
end type
type em_fechahasta from u_em_campo within w_con_pedidos_parc_servidos
end type
type gb_1 from groupbox within w_con_pedidos_parc_servidos
end type
type cb_1 from commandbutton within w_con_pedidos_parc_servidos
end type
type uo_serie from u_em_campo_2 within w_con_pedidos_parc_servidos
end type
type gb_4 from groupbox within w_con_pedidos_parc_servidos
end type
end forward

global type w_con_pedidos_parc_servidos from w_int_con_empresa
integer width = 2917
integer height = 1648
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
gb_1 gb_1
cb_1 cb_1
uo_serie uo_serie
gb_4 gb_4
end type
global w_con_pedidos_parc_servidos w_con_pedidos_parc_servidos

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Dec{0} cont,registros,v_anyo, v_pedido, cant_alb, cant_fac
Integer v_calibre
String  v_articulo, v_calidad, v_tono, v_pallet, v_caja
string s_fdesde,s_fhasta
Datetime fecha1,fecha2,falbaran_min,falbaran_max
datetime ffactura_min,ffactura_max
String serie1,serie2

data.Reset()
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

// Solamente mostramos las líneas que están parcialmente servidas
data.SetFilter("")
data.Filter()

data.Retrieve(codigo_empresa,fecha1,fecha2,serie1,serie2)

// Informamos la cantidad servida de esa línea de pedido
registros = data.RowCount()

for cont = 1 to registros
	
	v_anyo     = data.GetItemNumber(cont,"anyo")
	v_pedido   = data.GetItemNumber(cont,"pedido")
	v_articulo = data.GetItemString(cont,"articulo")
	v_calidad  = data.GetItemString(cont,"calidad")
	v_tono     = data.GetItemString(cont,"venliped_tonochar")
	v_calibre  = data.GetItemNumber(cont,"calibre")
	v_pallet   = data.GetItemString(cont,"tipo_pallet")
	v_caja	  = data.GetItemString(cont,"venliped_caja")
		
	SELECT sum(cantidad),min(falbaran),max(falbaran)
	  INTO :cant_alb,:falbaran_min,:falbaran_max
	  FROM venlialb
	 WHERE venlialb.empresa       = :codigo_empresa
	   AND venlialb.anyo_pedido_origen = :v_anyo
	   AND venlialb.pedido_origen = :v_pedido
		AND venlialb.articulo      = :v_articulo
		AND venlialb.calidad			= :v_calidad
		AND venlialb.tonochar		= :v_tono
		AND venlialb.calibre			= :v_calibre
		AND venlialb.tipo_pallet	= :v_pallet
		AND venlialb.caja				= :v_caja;
		
	if IsNull(cant_alb) then cant_alb = 0
	if sqlca.sqlcode <> 0 then 
		f_mensaje ("Error en selección de líneas de albarán","Error: "+sqlca.sqlerrtext)
	end if
	
	SELECT sum(cantidad),min(falbaran),max(falbaran) 
	  INTO :cant_fac,:ffactura_min,:ffactura_max
	  FROM venlifac
	 WHERE venlifac.empresa       = :codigo_empresa
	   AND venlifac.anyo_pedido_origen = :v_anyo
	   AND venlifac.pedido_origen = :v_pedido
		AND venlifac.articulo      = :v_articulo
		AND venlifac.calidad			= :v_calidad
		AND venlifac.tonochar		= :v_tono
		AND venlifac.calibre			= :v_calibre
		AND venlifac.tipo_pallet	= :v_pallet
		AND venlifac.caja				= :v_caja;

	if IsNull(cant_fac) then cant_fac = 0
	if sqlca.sqlcode <> 0 then 
		f_mensaje ("Error en selección de líneas de factura","Error: "+sqlca.sqlerrtext)
	end if
	
	if isnull(falbaran_min) then  
		if isnull(ffactura_min) then
			s_fdesde = ""
		else
			s_fdesde = string(date(ffactura_min),"dd/mm/yy")+"-"
		end if
	else
		if isnull(ffactura_min) then
			s_fdesde = string(date(falbaran_min),"dd/mm/yy")+"-"
		else
			if date(ffactura_min) < date(falbaran_min) then
				s_fdesde = string(date(ffactura_min),"dd/mm/yy")+"-"
			else
				s_fdesde = string(date(falbaran_min),"dd/mm/yy")+"-"
			end if
		end if
	end if
	
	if isnull(falbaran_max) then  
		if isnull(ffactura_max) then
			s_fhasta = ""
		else
			s_fhasta = string(date(ffactura_max),"dd/mm/yy")
		end if
	else
		if isnull(ffactura_max) then
			s_fhasta = string(date(falbaran_max),"dd/mm/yy")
		else
			if date(ffactura_max) > date(falbaran_max) then
				s_fhasta = string(date(ffactura_max),"dd/mm/yy")
			else
				s_fhasta = string(date(falbaran_max),"dd/mm/yy")
			end if
		end if
	end if
	
	data.SetItem(cont,"servido",cant_alb+cant_fac)
	data.SetItem(cont,"fecha_servido",s_fdesde+s_fhasta)
next

// Solamente mostramos las líneas que están parcialmente servidas
data.SetFilter("servido > 0")
data.Filter()

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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido parcialmente servidas"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
end event

event ue_listar;dw_report  = dw_listado
//
//Datetime fecha1,fecha2
//String serie1,serie2
//fecha1=Datetime(Date(String(em_fechadesde.Text)))
//fecha2=Datetime(Date(String(em_fechahasta.Text)))
//
//if Trim(uo_serie.em_codigo.text) <> "" then 
//	serie1 = uo_serie.em_codigo.text
//	serie2 = uo_serie.em_codigo.text
//else
//	serie1 = "."
//	serie2 = "Z"
//end if
//
//dw_report.Retrieve(codigo_empresa,fecha1,fecha2,serie1,serie2)
//
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end event

on w_con_pedidos_parc_servidos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.st_9=create st_9
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_serie=create uo_serie
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.em_fechahasta
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.uo_serie
this.Control[iCurrent+13]=this.gb_4
end on

on w_con_pedidos_parc_servidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.st_9)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_serie)
destroy(this.gb_4)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_parc_servidos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_parc_servidos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_parc_servidos
integer x = 9
integer y = 8
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_pedidos_parc_servidos
integer x = 2711
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_parc_servidos
integer x = 2711
integer y = 176
integer taborder = 0
string picturename = "print!"
end type

event clicked;//w_con_pedidos_entrefechas.triggerEvent("ue_listar")

f_control (dw_listado)

f_imprimir_datawindow (dw_listado)

end event

type dw_detalle from datawindow within w_con_pedidos_parc_servidos
integer x = 9
integer y = 304
integer width = 2834
integer height = 1112
string dataobject = "dw_con_pedidos_parc_servidos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

type dw_listado from datawindow within w_con_pedidos_parc_servidos
boolean visible = false
integer x = 507
integer width = 274
integer height = 232
boolean bringtotop = true
string dataobject = "report_con_pedidos_parc_servidos"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_parc_servidos
integer x = 2235
integer y = 132
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type st_9 from statictext within w_con_pedidos_parc_servidos
integer x = 78
integer y = 168
integer width = 233
integer height = 84
boolean bringtotop = true
integer textsize = -10
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

type em_fechadesde from u_em_campo within w_con_pedidos_parc_servidos
integer x = 315
integer y = 168
integer width = 320
integer taborder = 10
boolean bringtotop = true
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_pedidos_parc_servidos
integer x = 645
integer y = 168
integer width = 233
integer height = 84
boolean bringtotop = true
integer textsize = -10
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

type em_fechahasta from u_em_campo within w_con_pedidos_parc_servidos
integer x = 869
integer y = 168
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_pedidos_parc_servidos
integer x = 50
integer y = 108
integer width = 1184
integer height = 168
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_1 from commandbutton within w_con_pedidos_parc_servidos
integer x = 1271
integer y = 180
integer width = 361
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked; f_control(dw_detalle)

end event

type uo_serie from u_em_campo_2 within w_con_pedidos_parc_servidos
event destroy ( )
integer x = 1678
integer y = 176
integer width = 462
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

type gb_4 from groupbox within w_con_pedidos_parc_servidos
integer x = 1659
integer y = 116
integer width = 498
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

