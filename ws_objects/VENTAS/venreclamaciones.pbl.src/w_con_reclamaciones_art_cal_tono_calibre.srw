$PBExportHeader$w_con_reclamaciones_art_cal_tono_calibre.srw
forward
global type w_con_reclamaciones_art_cal_tono_calibre from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_reclamaciones_art_cal_tono_calibre
end type
type pb_2 from upb_imprimir within w_con_reclamaciones_art_cal_tono_calibre
end type
type dw_listado from datawindow within w_con_reclamaciones_art_cal_tono_calibre
end type
type em_fechadesde from u_em_campo within w_con_reclamaciones_art_cal_tono_calibre
end type
type em_fechahasta from u_em_campo within w_con_reclamaciones_art_cal_tono_calibre
end type
type gb_1 from groupbox within w_con_reclamaciones_art_cal_tono_calibre
end type
type cb_1 from commandbutton within w_con_reclamaciones_art_cal_tono_calibre
end type
type uo_cliente from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
end type
type gb_2 from groupbox within w_con_reclamaciones_art_cal_tono_calibre
end type
type cbx_mostrar_texto from checkbox within w_con_reclamaciones_art_cal_tono_calibre
end type
type uo_manejo from u_manejo_datawindow within w_con_reclamaciones_art_cal_tono_calibre
end type
type uo_articulo from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
end type
type uo_calidad from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
end type
type st_3 from statictext within w_con_reclamaciones_art_cal_tono_calibre
end type
type st_6 from statictext within w_con_reclamaciones_art_cal_tono_calibre
end type
type st_5 from statictext within w_con_reclamaciones_art_cal_tono_calibre
end type
type st_4 from statictext within w_con_reclamaciones_art_cal_tono_calibre
end type
type uo_tipopallet from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
end type
type st_9 from statictext within w_con_reclamaciones_art_cal_tono_calibre
end type
type uo_tono from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
end type
type uo_calibre from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
end type
type dw_detalle from datawindow within w_con_reclamaciones_art_cal_tono_calibre
end type
end forward

global type w_con_reclamaciones_art_cal_tono_calibre from w_int_con_empresa
integer width = 2999
integer height = 1992
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
gb_1 gb_1
cb_1 cb_1
uo_cliente uo_cliente
gb_2 gb_2
cbx_mostrar_texto cbx_mostrar_texto
uo_manejo uo_manejo
uo_articulo uo_articulo
uo_calidad uo_calidad
st_3 st_3
st_6 st_6
st_5 st_5
st_4 st_4
uo_tipopallet uo_tipopallet
st_9 st_9
uo_tono uo_tono
uo_calibre uo_calibre
dw_detalle dw_detalle
end type
global w_con_reclamaciones_art_cal_tono_calibre w_con_reclamaciones_art_cal_tono_calibre

type variables
//string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string    v_reclamacion,v_moneda,v_nombre_moneda,v_mascara_moneda_divisa
string    sel, v_cliente, v_nombre_cliente, v_descripcion, v_texto
datetime  v_fecha_desde,v_fecha_hasta, v_ffactura_abono
long      indice,v_total,v_anyo_abono,v_factura_abono,  donde
decimal   v_importe_fra_proveedor,v_total_fra_pts
String		ls_articulo, ls_calidad, ls_tono, ls_calibre, filtro

DataStore datos
data.reset()
data.SetRedraw(FALSE)

v_moneda                = f_moneda_empresa(codigo_empresa)
v_nombre_moneda         = f_nombre_moneda_abr(v_moneda)
v_mascara_moneda_divisa = f_mascara_moneda(v_moneda)

v_fecha_desde    = DateTime(Date(em_fechadesde.text))
v_fecha_hasta    = DateTime(Date(em_fechahasta.text))
v_cliente        = uo_cliente.em_codigo.text


IF uo_articulo.em_codigo.text <> '' THEN
	ls_articulo = uo_articulo.em_codigo.text
ELSE
	MessageBox("Reclamciones", "Debe indicar un artículo¡", Exclamation!)
	uo_articulo.em_campo.setfocus( )
	Return
END IF

filtro = ''

IF uo_calidad.em_codigo.text <> '' THEN	ls_calidad =  " vista_venlialb_reclamaciones_calidad = '" + uo_calidad.em_codigo.text + "' "	

IF uo_tono.em_codigo.text <> '' THEN	ls_tono = " vista_venlialb_reclamaciones_tono = " + uo_tono.em_codigo.text + " "	

IF uo_calibre.em_codigo.text <> '' THEN	ls_calibre = " vista_venlialb_reclamaciones_calibre = " + uo_calibre.em_codigo.text + " "	

IF ls_calidad <> '' THEN filtro += ls_calidad

IF ls_tono <> '' THEN 
	IF filtro <> '' THEN	
		filtro += " and " + ls_tono
	ELSE
		filtro += ls_tono
	END IF
END IF

IF ls_calibre <> '' THEN 
	IF filtro <> '' THEN	
		filtro += " and " + ls_calibre
	ELSE
		filtro += ls_calibre
	END IF
END IF

IF filtro <> '' THEN filtro = " ( " + filtro + " ) "

data.SetFilter(filtro)
data.Filter()

data.Retrieve(codigo_empresa, ls_articulo)


//if trim(v_cliente) = "" then
//	v_cliente = "%"
//end if
//
//if cbx_mostrar_texto.checked then
//	sel = " select cliente,reclamacion,fecha,descripcion,texto"+&
//			" from   ven_reclamaciones "+&
//			" where  empresa =       '"+codigo_empresa+"' " +&
//			" and    cliente like    '"+v_cliente+"' " +&
//			" and    fecha   between '"+STring(Date(em_fechadesde.text),'mm-dd-yyyy')+"'  and '"+STring(Date(em_fechahasta.text),'mm-dd-yyyy')+"' "
//else
//	sel = " select cliente,reclamacion,fecha,descripcion,'' texto"+&
//			" from   ven_reclamaciones "+&
//			" where  empresa =       '"+codigo_empresa+"' " +&
//			" and    cliente like    '"+v_cliente+"' " +&
//			" and    fecha   between '"+STring(Date(em_fechadesde.text),'mm-dd-yyyy')+"'  and '"+STring(Date(em_fechahasta.text),'mm-dd-yyyy')+"' "	
//end if
//
//f_cargar_cursor_transaccion(sqlca,datos,sel)
//
//v_total = datos.rowcount()				
//For indice = 1 To v_total
//	v_cliente        = datos.object.cliente[indice]
//	v_nombre_cliente = f_nombre_cliente(codigo_empresa,"C",v_cliente)	
//	v_reclamacion    = datos.object.reclamacion[indice]
//	v_ffactura_abono = datos.object.fecha[indice]
//	v_descripcion    = datos.object.descripcion[indice]
//	v_texto          = datos.object.texto[indice]
//	
//	select sum(venfac.total_fac_pts)
//	into   :v_total_fra_pts
//	from	 ven_reclamaciones_abonos,venfac
//	where  ven_reclamaciones_abonos.empresa = venfac.empresa 
//	and    ven_reclamaciones_abonos.anyo    = venfac.anyo 
//	and    ven_reclamaciones_abonos.factura = venfac.factura 	
//	and    ven_reclamaciones_abonos.empresa = :codigo_empresa
//	and    ven_reclamaciones_abonos.cliente = :v_cliente
//   and    ven_reclamaciones_abonos.reclamacion = :v_reclamacion;
//	
//	if isnull(v_total_fra_pts) then v_total_fra_pts = 0
//	
//	select	sum(importe_fra_proveedor)
//	into     :v_importe_fra_proveedor
//	from     ven_reclamaciones_gastos
//	where    (empresa      = :codigo_empresa ) 
//	and      (cliente      = :v_cliente)
//	and      (reclamacion  = :v_reclamacion );
//	
//	if isnull(v_importe_fra_proveedor) then v_importe_fra_proveedor = 0
//	
//	donde = data.InsertRow(0)
//	data.object.empresa[donde]         = codigo_empresa	
//	data.object.codigo_cliente[donde]  = v_cliente
//	data.object.nombre_cliente[donde]  = v_nombre_cliente
//	data.object.reclamacion[donde]     = v_reclamacion
//	data.object.ffactura_abono[donde]  = v_ffactura_abono
//	data.object.descripcion[donde]     = v_descripcion
//	data.object.total_fra_pts[donde]   = v_total_fra_pts
//	data.object.nombre_divisa[donde]   = v_nombre_moneda
//	data.object.mascara_moneda_divisa[donde]  = v_mascara_moneda_divisa
//	data.object.importe_fra_proveedor[donde]  = v_importe_fra_proveedor
//	data.object.texto[donde]           = v_texto
//	
//	f_mensaje_proceso("Leyendo clientes",indice,datos.RowCount())	
//Next
//
//destroy datos
//data.Sort()
//data.GroupCalc()

data.SetRedraw(TRUE)

IF data.RowCount() = 0 THEN MessageBox("Reclamciones", "No hay registros con los datos seleccionados¡", Exclamation!)



end subroutine

event close;dw_detalle.reset()
dw_listado.reset()
end event

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Consulta Reclamaciones de cliente por Articulo/Calidad/Tono/Calibre"
This.title         = istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_listado.SetTransObject(SQLCA)


dw_detalle.SetTransObject(SQLCA)

end event

on w_con_reclamaciones_art_cal_tono_calibre.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.gb_2=create gb_2
this.cbx_mostrar_texto=create cbx_mostrar_texto
this.uo_manejo=create uo_manejo
this.uo_articulo=create uo_articulo
this.uo_calidad=create uo_calidad
this.st_3=create st_3
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.uo_tipopallet=create uo_tipopallet
this.st_9=create st_9
this.uo_tono=create uo_tono
this.uo_calibre=create uo_calibre
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.uo_cliente
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.cbx_mostrar_texto
this.Control[iCurrent+11]=this.uo_manejo
this.Control[iCurrent+12]=this.uo_articulo
this.Control[iCurrent+13]=this.uo_calidad
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.uo_tipopallet
this.Control[iCurrent+19]=this.st_9
this.Control[iCurrent+20]=this.uo_tono
this.Control[iCurrent+21]=this.uo_calibre
this.Control[iCurrent+22]=this.dw_detalle
end on

on w_con_reclamaciones_art_cal_tono_calibre.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.gb_2)
destroy(this.cbx_mostrar_texto)
destroy(this.uo_manejo)
destroy(this.uo_articulo)
destroy(this.uo_calidad)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.uo_tipopallet)
destroy(this.st_9)
destroy(this.uo_tono)
destroy(this.uo_calibre)
destroy(this.dw_detalle)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;//f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_reclamaciones_art_cal_tono_calibre
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_reclamaciones_art_cal_tono_calibre
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_reclamaciones_art_cal_tono_calibre
integer y = 4
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_reclamaciones_art_cal_tono_calibre
integer x = 2821
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_reclamaciones_art_cal_tono_calibre
integer x = 2752
integer y = 208
integer taborder = 0
end type

event clicked;//f_control(dw_listado)
//f_imprimir_datawindow(dw_listado)


IF dw_detalle.RowCount() > 0 THEN	
	u_imprimir u_imp
	u_imp = create u_imprimir
	u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
	u_imp.isTitulo    = "Consulta Reclamaciones de cliente por Articulo/Calidad/Tono/Calibre"
	u_imp.isSubTitulo = "Para el Artículo: " + uo_articulo.em_campo.Text +  " Desde: " + em_fechadesde.text + " Hasta: " + em_fechahasta.Text
	u_imp.ibLandscape = false
	parent.OpenUserObject(u_imp.report)
	u_imp.event ue_imprimir(dw_detalle)
	Destroy(u_imp)
END IF
	



end event

type dw_listado from datawindow within w_con_reclamaciones_art_cal_tono_calibre
boolean visible = false
integer x = 2258
integer y = 588
integer width = 297
integer height = 104
integer taborder = 70
boolean bringtotop = true
boolean livescroll = true
end type

type em_fechadesde from u_em_campo within w_con_reclamaciones_art_cal_tono_calibre
boolean visible = false
integer x = 160
integer y = 648
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_reclamaciones_art_cal_tono_calibre
boolean visible = false
integer x = 503
integer y = 648
integer width = 320
integer taborder = 30
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_reclamaciones_art_cal_tono_calibre
boolean visible = false
integer x = 142
integer y = 596
integer width = 699
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Periodo"
end type

type cb_1 from commandbutton within w_con_reclamaciones_art_cal_tono_calibre
integer x = 1970
integer y = 196
integer width = 315
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;f_control(dw_detalle)

end event

type uo_cliente from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
event destroy ( )
integer x = 215
integer y = 788
integer width = 1275
integer taborder = 40
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
ue_titulo     = "Selección de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type gb_2 from groupbox within w_con_reclamaciones_art_cal_tono_calibre
integer x = 197
integer y = 736
integer width = 1312
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type cbx_mostrar_texto from checkbox within w_con_reclamaciones_art_cal_tono_calibre
boolean visible = false
integer x = 2190
integer y = 964
integer width = 622
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
string text = "Mostrar texto detalle"
end type

type uo_manejo from u_manejo_datawindow within w_con_reclamaciones_art_cal_tono_calibre
integer x = 2277
integer y = 160
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type uo_articulo from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
event destroy ( )
integer x = 50
integer y = 208
integer width = 1015
integer height = 88
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF
String mascara
mascara = f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text))

//f_control_tono_calibre()

//f_mascara_columna(dw_1,"cantidads",mascara)
//f_mascara_columna(dw_1,"cantidade",mascara)
//f_mascara_columna(dw_1,"stock",mascara)
//f_mascara_columna(dw_listado,"cantidads",mascara)
//f_mascara_columna(dw_listado,"cantidade",mascara)
//f_mascara_columna(dw_listado,"stock",mascara)
end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

type uo_calidad from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
event destroy ( )
integer x = 1070
integer y = 208
integer width = 151
integer height = 88
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;
uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text) <> "" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text  = ""
 uo_calidad.em_codigo.text = ""
END IF

//f_control_tono_calibre()
//f_activar_campo(uo_calidad.em_campo)


end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

type st_3 from statictext within w_con_reclamaciones_art_cal_tono_calibre
integer x = 50
integer y = 128
integer width = 1019
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_con_reclamaciones_art_cal_tono_calibre
integer x = 1070
integer y = 128
integer width = 155
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_reclamaciones_art_cal_tono_calibre
integer x = 1230
integer y = 128
integer width = 155
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_reclamaciones_art_cal_tono_calibre
boolean visible = false
integer x = 1545
integer y = 128
integer width = 155
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Tp"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_tipopallet from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
event destroy ( )
boolean visible = false
integer x = 1545
integer y = 208
integer width = 155
integer height = 88
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tipopallet.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;
uo_tipopallet.em_campo.text = f_nombre_almartpallet_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_tipopallet.em_codigo.text)
IF Trim(uo_tipopallet.em_campo.text)="" THEN 
 IF Trim(uo_tipopallet.em_codigo.text) <> "" Then uo_tipopallet.em_campo.SetFocus()
 uo_tipopallet.em_campo.text  = ""
 uo_tipopallet.em_codigo.text = ""
END IF

f_activar_campo(uo_tipopallet.em_campo)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_almartpallets_abr"
ue_filtro     = "almartpallet_articulo = '" + uo_articulo.em_codigo.text+ "'"

end event

type st_9 from statictext within w_con_reclamaciones_art_cal_tono_calibre
integer x = 1390
integer y = 128
integer width = 155
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_tono from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
event destroy ( )
integer x = 1225
integer y = 208
integer width = 155
integer height = 88
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tono.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = Trim(f_nombre_tono(codigo_empresa,integer(this.em_codigo.text)))

IF Trim(this.em_campo.text) = "" THEN 
   IF Trim(this.em_codigo.text) <> "" Then 
	   this.em_campo.SetFocus()
   END IF
   this.em_campo.text  = ""
   this.em_codigo.text = ""
   Return
END IF

//f_control_tono_calibre()

end event

event getfocus;call super::getfocus;//f_control_tono_calibre()
ue_titulo     = "Ayuda seleccion de Tonos"
ue_datawindow = "dw_ayuda_tono"
ue_filtro     = ""
valor_empresa = true

end event

event tecla_tabulador;//if control_tono then call super::tecla_tabulador
end event

type uo_calibre from u_em_campo_2 within w_con_reclamaciones_art_cal_tono_calibre
event destroy ( )
integer x = 1385
integer y = 208
integer width = 155
integer height = 88
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_calibre.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = Trim(f_nombre_calibre(codigo_empresa,integer(this.em_codigo.text)))

IF Trim(this.em_campo.text) = "" THEN 
   IF Trim(this.em_codigo.text) <> "" Then 
	   this.em_campo.SetFocus()
   END IF
   this.em_campo.text  = ""
   this.em_codigo.text = ""
   Return
END IF

//f_control_tono_calibre()

end event

event getfocus;call super::getfocus;//f_control_tono_calibre()
ue_titulo     = "Ayuda seleccion de Calibres"
ue_datawindow = "dw_ayuda_calibre"
ue_filtro     = ""
valor_empresa = true

end event

event tecla_tabulador;//if control_calibre then call super::tecla_tabulador
end event

type dw_detalle from datawindow within w_con_reclamaciones_art_cal_tono_calibre
integer x = 27
integer y = 328
integer width = 2903
integer height = 1536
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_con_reclama_art_cal_tono_calibre"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.ven_reclamaciones_detalle_cliente[row]
  lstr_param.s_argumentos[3] = This.object.ven_reclamaciones_detalle_reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

