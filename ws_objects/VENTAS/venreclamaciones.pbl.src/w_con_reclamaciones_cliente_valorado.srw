$PBExportHeader$w_con_reclamaciones_cliente_valorado.srw
forward
global type w_con_reclamaciones_cliente_valorado from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_reclamaciones_cliente_valorado
end type
type pb_2 from upb_imprimir within w_con_reclamaciones_cliente_valorado
end type
type dw_listado from datawindow within w_con_reclamaciones_cliente_valorado
end type
type em_fechadesde from u_em_campo within w_con_reclamaciones_cliente_valorado
end type
type em_fechahasta from u_em_campo within w_con_reclamaciones_cliente_valorado
end type
type gb_1 from groupbox within w_con_reclamaciones_cliente_valorado
end type
type cb_1 from commandbutton within w_con_reclamaciones_cliente_valorado
end type
type uo_cliente from u_em_campo_2 within w_con_reclamaciones_cliente_valorado
end type
type gb_2 from groupbox within w_con_reclamaciones_cliente_valorado
end type
type cbx_mostrar_texto from checkbox within w_con_reclamaciones_cliente_valorado
end type
type dw_detalle from datawindow within w_con_reclamaciones_cliente_valorado
end type
type uo_manejo from u_manejo_datawindow within w_con_reclamaciones_cliente_valorado
end type
end forward

global type w_con_reclamaciones_cliente_valorado from w_int_con_empresa
integer width = 3607
integer height = 1916
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
dw_detalle dw_detalle
uo_manejo uo_manejo
end type
global w_con_reclamaciones_cliente_valorado w_con_reclamaciones_cliente_valorado

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string    v_reclamacion,v_moneda,v_nombre_moneda,v_mascara_moneda_divisa
string    sel, v_cliente, v_nombre_cliente, v_descripcion, v_texto
datetime  v_fecha_desde,v_fecha_hasta, v_ffactura_abono
long      indice,v_total,v_anyo_abono,v_factura_abono,  donde
decimal   v_importe_fra_proveedor,v_total_fra_pts

DataStore datos
data.reset()
data.SetRedraw(FALSE)

v_moneda                = f_moneda_empresa(codigo_empresa)
v_nombre_moneda         = f_nombre_moneda_abr(v_moneda)
v_mascara_moneda_divisa = f_mascara_moneda(v_moneda)

v_fecha_desde    = DateTime(Date(em_fechadesde.text))
v_fecha_hasta    = DateTime(Date(em_fechahasta.text))
v_cliente        = uo_cliente.em_codigo.text

if trim(v_cliente) = "" then
	v_cliente = "%"
end if

if cbx_mostrar_texto.checked then
	sel = " select cliente,reclamacion,fecha,descripcion,texto"+&
			" from   ven_reclamaciones "+&
			" where  empresa =       '"+codigo_empresa+"' " +&
			" and    cliente like    '"+v_cliente+"' " +&
			" and    fecha   between '"+STring(Date(em_fechadesde.text),formato_fecha_cursores)+"'  and '"+STring(Date(em_fechahasta.text),formato_fecha_cursores)+"' "
else
	sel = " select cliente,reclamacion,fecha,descripcion,'' texto"+&
			" from   ven_reclamaciones "+&
			" where  empresa =       '"+codigo_empresa+"' " +&
			" and    cliente like    '"+v_cliente+"' " +&
			" and    fecha   between '"+STring(Date(em_fechadesde.text),formato_fecha_cursores)+"'  and '"+STring(Date(em_fechahasta.text),formato_fecha_cursores)+"' "	
end if

f_cargar_cursor_transaccion(sqlca,datos,sel)

v_total = datos.rowcount()				
For indice = 1 To v_total
	v_cliente        = datos.object.cliente[indice]
	v_nombre_cliente = f_nombre_cliente(codigo_empresa,"C",v_cliente)	
	v_reclamacion    = datos.object.reclamacion[indice]
	v_ffactura_abono = datos.object.fecha[indice]
	v_descripcion    = datos.object.descripcion[indice]
	v_texto          = datos.object.texto[indice]
	
	select sum(venfac.total_fac_pts)
	into   :v_total_fra_pts
	from	 ven_reclamaciones_abonos,venfac
	where  ven_reclamaciones_abonos.empresa = venfac.empresa 
	and    ven_reclamaciones_abonos.anyo    = venfac.anyo 
	and    ven_reclamaciones_abonos.factura = venfac.factura 	
	and    ven_reclamaciones_abonos.empresa = :codigo_empresa
	and    ven_reclamaciones_abonos.cliente = :v_cliente
   and    ven_reclamaciones_abonos.reclamacion = :v_reclamacion;
	
	if isnull(v_total_fra_pts) then v_total_fra_pts = 0
	
	select	sum(importe_fra_proveedor)
	into     :v_importe_fra_proveedor
	from     ven_reclamaciones_gastos
	where    (empresa      = :codigo_empresa ) 
	and      (cliente      = :v_cliente)
	and      (reclamacion  = :v_reclamacion );
	
	if isnull(v_importe_fra_proveedor) then v_importe_fra_proveedor = 0
	
	donde = data.InsertRow(0)
	data.object.empresa[donde]         = codigo_empresa	
	data.object.codigo_cliente[donde]  = v_cliente
	data.object.nombre_cliente[donde]  = v_nombre_cliente
	data.object.reclamacion[donde]     = v_reclamacion
	data.object.ffactura_abono[donde]  = v_ffactura_abono
	data.object.descripcion[donde]     = v_descripcion
	data.object.total_fra_pts[donde]   = v_total_fra_pts
	data.object.nombre_divisa[donde]   = v_nombre_moneda
	data.object.mascara_moneda_divisa[donde]  = v_mascara_moneda_divisa
	data.object.importe_fra_proveedor[donde]  = v_importe_fra_proveedor
	data.object.texto[donde]           = v_texto
	
	f_mensaje_proceso("Leyendo clientes",indice,datos.RowCount())	
Next

destroy datos
data.Sort()
data.GroupCalc()
data.SetRedraw(TRUE)
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

event open;call super::open;istr_parametros.s_titulo_ventana = "Consulta Reclamaciones de cliente valorado"
This.title         = istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_listado.SetTransObject(SQLCA)

end event

on w_con_reclamaciones_cliente_valorado.create
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
this.dw_detalle=create dw_detalle
this.uo_manejo=create uo_manejo
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
this.Control[iCurrent+11]=this.dw_detalle
this.Control[iCurrent+12]=this.uo_manejo
end on

on w_con_reclamaciones_cliente_valorado.destroy
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
destroy(this.dw_detalle)
destroy(this.uo_manejo)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;//f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_reclamaciones_cliente_valorado
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_reclamaciones_cliente_valorado
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_reclamaciones_cliente_valorado
integer y = 4
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_reclamaciones_cliente_valorado
integer x = 3456
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_reclamaciones_cliente_valorado
integer x = 3461
integer y = 180
integer taborder = 0
end type

event clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)



end event

type dw_listado from datawindow within w_con_reclamaciones_cliente_valorado
boolean visible = false
integer x = 3067
integer y = 4
integer width = 297
integer height = 104
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_con_reclamaciones_cliente_valorad"
boolean livescroll = true
end type

type em_fechadesde from u_em_campo within w_con_reclamaciones_cliente_valorado
integer x = 50
integer y = 168
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_reclamaciones_cliente_valorado
integer x = 393
integer y = 168
integer width = 320
integer taborder = 30
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_reclamaciones_cliente_valorado
integer x = 32
integer y = 116
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

type cb_1 from commandbutton within w_con_reclamaciones_cliente_valorado
integer x = 2679
integer y = 168
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

type uo_cliente from u_em_campo_2 within w_con_reclamaciones_cliente_valorado
event destroy ( )
integer x = 750
integer y = 168
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

type gb_2 from groupbox within w_con_reclamaciones_cliente_valorado
integer x = 731
integer y = 116
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

type cbx_mostrar_texto from checkbox within w_con_reclamaciones_cliente_valorado
integer x = 2053
integer y = 188
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

type dw_detalle from datawindow within w_con_reclamaciones_cliente_valorado
integer x = 27
integer y = 284
integer width = 3557
integer height = 1532
integer taborder = 60
string dataobject = "dw_con_reclamaciones_cliente_valorado"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.codigo_cliente[row]
  lstr_param.s_argumentos[3] = This.object.reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

type uo_manejo from u_manejo_datawindow within w_con_reclamaciones_cliente_valorado
integer x = 2985
integer y = 132
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

