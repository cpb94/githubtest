$PBExportHeader$w_con_incidencia_calidad.srw
forward
global type w_con_incidencia_calidad from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_incidencia_calidad
end type
type pb_2 from upb_imprimir within w_con_incidencia_calidad
end type
type dw_listado from datawindow within w_con_incidencia_calidad
end type
type em_fechadesde from u_em_campo within w_con_incidencia_calidad
end type
type em_fechahasta from u_em_campo within w_con_incidencia_calidad
end type
type cb_1 from commandbutton within w_con_incidencia_calidad
end type
type gb_1 from groupbox within w_con_incidencia_calidad
end type
type st_1 from statictext within w_con_incidencia_calidad
end type
type uo_series from u_marca_lista within w_con_incidencia_calidad
end type
type gb_6 from groupbox within w_con_incidencia_calidad
end type
type dw_listado_resumen from datawindow within w_con_incidencia_calidad
end type
type dw_listado_resumen_pm from datawindow within w_con_incidencia_calidad
end type
type dw_detalle from datawindow within w_con_incidencia_calidad
end type
end forward

global type w_con_incidencia_calidad from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 3534
integer height = 2212
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_1 gb_1
st_1 st_1
uo_series uo_series
gb_6 gb_6
dw_listado_resumen dw_listado_resumen
dw_listado_resumen_pm dw_listado_resumen_pm
dw_detalle dw_detalle
end type
global w_con_incidencia_calidad w_con_incidencia_calidad

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_piezas_metros_importe (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente)
public subroutine f_importe_cliente (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente)
end prototypes

public subroutine f_control (datawindow data);datastore ds_clientes
long i, fila_Actual
string sel1, cliente, v_empresa
date fecha1, fecha2, v_fpedido
integer dia1, mes1, anyo1, dia2, mes2, anyo2, v_anyo, v_pedido, v_linea
decimal v_importe, v_piezas, v_metros, v_importe2, v_piezas2, v_metros2

dw_detalle.reset()
fecha1 = date(em_fechadesde.text)
fecha2 = date(em_fechahasta.text)

dia1 = day(fecha1)
mes1 = month(fecha1)
anyo1 = year(fecha1) - 1
dia2 = day(fecha2)
mes2 = month(fecha2) 
anyo2 = year(fecha2) - 1


fecha1 = Date ( anyo1, mes1, dia1)
fecha2 = Date ( anyo2, mes2, dia2)

sel1 = 	" SELECT venlifac.empresa, genter.codigo, genter.razon, Sum((venlifac.importe) / venlifac.cambio) as total, "+&
										" (SELECT Sum((b.importe) / b.cambio) "+&
										" FROM venlifac b "+&
										" WHERE  b.empresa = '"+codigo_empresa+"' "+&
										" AND b.cantidad < 0 "+&
										" AND b.cliente = genter.codigo "+&
										" AND b.ffactura >= '"+em_fechadesde.text+"' "+&
										" AND b.ffactura <= '"+em_fechahasta.text+"') as total2 "+&
			" FROM   venlifac, genter "+&
			" WHERE  venlifac.empresa = '"+codigo_empresa+"' "+&
			" AND genter.tipoter = 'C' "+&
			" AND genter.empresa = '"+codigo_empresa+"' "+&
			" AND genter.codigo *= venlifac.cliente "+&
			" AND    venlifac.ffactura >= '"+em_fechadesde.text+"' "+&
			" AND    venlifac.ffactura <= '"+em_fechahasta.text+"' "+&
			" GROUP BY venlifac.empresa, genter.codigo, genter.razon "+&
			" ORDER BY Sum((venlifac.importe) / venlifac.cambio) Desc "

f_cargar_cursor_nuevo (sel1, ds_clientes)

dw_detalle.Setredraw(false)
//dw_Detalle.object.actual.text =  em_fechadesde.text+" a "+em_fechahasta.text
//dw_Detalle.object.Anterior.text = string(fecha1,"dd-mm-yy")+" a "+string(fecha2,"dd-mm-yy")
dw_Detalle.object.titulo.text = 'Incidencia de Calidad desde '+string(fecha1,"dd-mm-yy")+" a "+string(fecha2,"dd-mm-yy")

for i = 1 to ds_clientes.rowcount()
	fila_actual = dw_detalle.insertrow(0)
	cliente = ds_clientes.object.genter_razon[i]
	v_importe = ds_clientes.object.total[i]
	v_importe2 = -1 * (ds_clientes.object.total2[i]) 
	
	dw_detalle.object.cliente[fila_actual] = cliente
	dw_detalle.object.importe[fila_actual] = v_importe
	dw_detalle.object.importe2[fila_actual] = v_importe2
	f_mensaje_proceso ("Clientes:", i, ds_clientes.rowcount())
next



dw_detalle.setsort("")
dw_detalle.sort()
dw_detalle.Setredraw(True)

destroy ds_clientes
end subroutine

public subroutine f_piezas_metros_importe (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente);decimal importe_ped = 0, importe_alb = 0, importe_fac = 0
decimal piezas_ped = 0, piezas_alb = 0, piezas_fac = 0
decimal metros_ped = 0, metros_alb = 0, metros_fac = 0

select 	venliped.cliente,
			sum(venliped.importe / venped.cambio),
			sum(venliped.cantidad),
			sum(formatos.ancho * formatos.largo * venliped.cantidad / 10000)
into :cliente, :importe_ped, :piezas_ped, :metros_ped
from venliped, articulos, formatos, venped
where venliped.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and formatos.empresa = :codigo_empresa
and venped.empresa = :codigo_empresa
and venped.anyo = venliped.anyo
and venped.pedido = venliped.pedido
and venliped.articulo = articulos.codigo
and articulos.formato = formatos.codigo
and venliped.fpedido >= :fecha1
and venliped.fpedido <= :fecha2
and venliped.cliente like :cliente
group by venliped.cliente;

select 	venlialb.cliente,
			sum(venlialb.importe / venalb.cambio), 
			sum(venlialb.cantidad),
			sum(formatos.ancho * formatos.largo * venlialb.cantidad / 10000)
into :cliente, :importe_alb, :piezas_alb, :metros_alb
from venlialb, articulos, formatos, venalb
where venlialb.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and formatos.empresa = :codigo_empresa
and venalb.empresa = :codigo_empresa
and venalb.anyo = venlialb.anyo
and venalb.albaran = venlialb.albaran
and venlialb.articulo = articulos.codigo
and articulos.formato = formatos.codigo
and venlialb.fpedido_origen >= :fecha1
and venlialb.fpedido_origen <= :fecha2
and venlialb.cliente like :cliente
group by venlialb.cliente;

select 	venlifac.cliente, 
			sum(venlifac.importe / venlifac.cambio), 
			sum(venlifac.cantidad),
			sum(formatos.ancho * formatos.largo * venlifac.cantidad / 10000)
into :cliente, :importe_fac, :piezas_fac, :metros_fac
from venlifac, articulos, formatos, venfac
where venlifac.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and formatos.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.articulo = articulos.codigo
and articulos.formato = formatos.codigo
and venlifac.fpedido_origen >= :fecha1
and venlifac.fpedido_origen <= :fecha2
and venlifac.cliente like :cliente
group by venlifac.cliente;

arg_importe = importe_ped + importe_alb + importe_fac 
arg_piezas = piezas_ped + piezas_alb + piezas_fac 
arg_metros = metros_ped + metros_alb + metros_fac 



/*
	select 	venliped.empresa,
				venliped.anyo,   
				venliped.pedido,   
				venliped.linea,  
				venliped.fpedido,
				venliped.importe / venped.cambio as importe_moneda,
				venliped.cantidad,
				formatos.ancho * formatos.largo * venliped.cantidad / 10000
	into :v_empresa, :v_anyo, :v_pedido, :v_linea, :v_fpedido, :arg_importe, :arg_piezas, :arg_metros
	from venliped, articulos, formatos, venped
	where venliped.empresa = :codigo_empresa
	and articulos.empresa = :codigo_empresa
	and formatos.empresa = :codigo_empresa
	and venped.empresa = :codigo_empresa
	and venped.anyo = venliped.anyo
	and venped.pedido = venliped.pedido
	and venliped.articulo = articulos.codigo
	and articulos.formato = formatos.codigo
	and venliped.fpedido >= :fecha1
	and venliped.fpedido <= :fecha2
	and venliped.cliente like :cliente
	union
	select venlialb.empresa,
			venlialb.anyo_pedido_origen, 
			venlialb.pedido_origen, 
			venlialb.linea_pedido_origen, 
			venlialb.fpedido_origen,
			venlialb.importe / venalb.cambio as importe_moneda, 
			venlialb.cantidad,
			formatos.ancho * formatos.largo * venlialb.cantidad / 10000
	from venlialb, articulos, formatos, venalb
	where venlialb.empresa = :codigo_empresa
	and articulos.empresa = :codigo_empresa
	and formatos.empresa = :codigo_empresa
	and venalb.empresa = :codigo_empresa
	and venalb.anyo = venlialb.anyo
	and venalb.albaran = venlialb.albaran
	and venlialb.articulo = articulos.codigo
	and articulos.formato = formatos.codigo
	and venlialb.fpedido_origen >= :fecha1
	and venlialb.fpedido_origen <= :fecha2
	and venlialb.cliente like :cliente
	union
	select venlifac.empresa, 
			venlifac.anyo_pedido_origen, 
			venlifac.pedido_origen, 
			venlifac.linea_pedido_origen, 
			venlifac.fpedido_origen,
			venlifac.importe / venlifac.cambio as importe_moneda, 
			venlifac.cantidad,
			formatos.ancho * formatos.largo * venlifac.cantidad / 10000
	from venlifac, articulos, formatos, venfac
	where venlifac.empresa = :codigo_empresa
	and articulos.empresa = :codigo_empresa
	and formatos.empresa = :codigo_empresa
	and venfac.empresa = :codigo_empresa
	and venfac.anyo = venlifac.anyo
	and venfac.factura = venlifac.factura
	and venlifac.articulo = articulos.codigo
	and articulos.formato = formatos.codigo
	and venlifac.fpedido_origen >= :fecha1
	and venlifac.fpedido_origen <= :fecha2
	and venlifac.cliente like :cliente;
	*/
end subroutine

public subroutine f_importe_cliente (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente);decimal importe_ped = 0, importe_alb = 0, importe_fac = 0
decimal piezas_ped = 0, piezas_alb = 0, piezas_fac = 0
decimal metros_ped = 0, metros_alb = 0, metros_fac = 0

select 	venliped.cliente,
			sum(venliped.importe / venped.cambio),
			sum(venliped.cantidad),
			sum(formatos.ancho * formatos.largo * venliped.cantidad / 10000)
into :cliente, :importe_ped, :piezas_ped, :metros_ped
from venliped, articulos, formatos, venped
where venliped.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and formatos.empresa = :codigo_empresa
and venped.empresa = :codigo_empresa
and venped.anyo = venliped.anyo
and venped.pedido = venliped.pedido
and venliped.articulo = articulos.codigo
and articulos.formato = formatos.codigo
and venliped.fpedido >= :fecha1
and venliped.fpedido <= :fecha2
and venliped.cliente like :cliente
group by venliped.cliente;

select 	venlialb.cliente,
			sum(venlialb.importe / venalb.cambio), 
			sum(venlialb.cantidad),
			sum(formatos.ancho * formatos.largo * venlialb.cantidad / 10000)
into :cliente, :importe_alb, :piezas_alb, :metros_alb
from venlialb, articulos, formatos, venalb
where venlialb.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and formatos.empresa = :codigo_empresa
and venalb.empresa = :codigo_empresa
and venalb.anyo = venlialb.anyo
and venalb.albaran = venlialb.albaran
and venlialb.articulo = articulos.codigo
and articulos.formato = formatos.codigo
and venlialb.fpedido_origen >= :fecha1
and venlialb.fpedido_origen <= :fecha2
and venlialb.cliente like :cliente
group by venlialb.cliente;

select 	venlifac.cliente, 
			sum(venlifac.importe / venlifac.cambio), 
			sum(venlifac.cantidad),
			sum(formatos.ancho * formatos.largo * venlifac.cantidad / 10000)
into :cliente, :importe_fac, :piezas_fac, :metros_fac
from venlifac, articulos, formatos, venfac
where venlifac.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and formatos.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.articulo = articulos.codigo
and articulos.formato = formatos.codigo
and venlifac.fpedido_origen >= :fecha1
and venlifac.fpedido_origen <= :fecha2
and venlifac.cliente like :cliente
group by venlifac.cliente;

arg_importe = importe_ped + importe_alb + importe_fac 
arg_piezas = piezas_ped + piezas_alb + piezas_fac 
arg_metros = metros_ped + metros_alb + metros_fac 



/*
	select 	venliped.empresa,
				venliped.anyo,   
				venliped.pedido,   
				venliped.linea,  
				venliped.fpedido,
				venliped.importe / venped.cambio as importe_moneda,
				venliped.cantidad,
				formatos.ancho * formatos.largo * venliped.cantidad / 10000
	into :v_empresa, :v_anyo, :v_pedido, :v_linea, :v_fpedido, :arg_importe, :arg_piezas, :arg_metros
	from venliped, articulos, formatos, venped
	where venliped.empresa = :codigo_empresa
	and articulos.empresa = :codigo_empresa
	and formatos.empresa = :codigo_empresa
	and venped.empresa = :codigo_empresa
	and venped.anyo = venliped.anyo
	and venped.pedido = venliped.pedido
	and venliped.articulo = articulos.codigo
	and articulos.formato = formatos.codigo
	and venliped.fpedido >= :fecha1
	and venliped.fpedido <= :fecha2
	and venliped.cliente like :cliente
	union
	select venlialb.empresa,
			venlialb.anyo_pedido_origen, 
			venlialb.pedido_origen, 
			venlialb.linea_pedido_origen, 
			venlialb.fpedido_origen,
			venlialb.importe / venalb.cambio as importe_moneda, 
			venlialb.cantidad,
			formatos.ancho * formatos.largo * venlialb.cantidad / 10000
	from venlialb, articulos, formatos, venalb
	where venlialb.empresa = :codigo_empresa
	and articulos.empresa = :codigo_empresa
	and formatos.empresa = :codigo_empresa
	and venalb.empresa = :codigo_empresa
	and venalb.anyo = venlialb.anyo
	and venalb.albaran = venlialb.albaran
	and venlialb.articulo = articulos.codigo
	and articulos.formato = formatos.codigo
	and venlialb.fpedido_origen >= :fecha1
	and venlialb.fpedido_origen <= :fecha2
	and venlialb.cliente like :cliente
	union
	select venlifac.empresa, 
			venlifac.anyo_pedido_origen, 
			venlifac.pedido_origen, 
			venlifac.linea_pedido_origen, 
			venlifac.fpedido_origen,
			venlifac.importe / venlifac.cambio as importe_moneda, 
			venlifac.cantidad,
			formatos.ancho * formatos.largo * venlifac.cantidad / 10000
	from venlifac, articulos, formatos, venfac
	where venlifac.empresa = :codigo_empresa
	and articulos.empresa = :codigo_empresa
	and formatos.empresa = :codigo_empresa
	and venfac.empresa = :codigo_empresa
	and venfac.anyo = venlifac.anyo
	and venfac.factura = venlifac.factura
	and venlifac.articulo = articulos.codigo
	and articulos.formato = formatos.codigo
	and venlifac.fpedido_origen >= :fecha1
	and venlifac.fpedido_origen <= :fecha2
	and venlifac.cliente like :cliente;
	*/
end subroutine

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
dw_listado_resumen.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Ranking Comparativo de clientes"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
//dw_detalle.DataObject = "dw_con_ped_alb_fac_cliente_fechas_tencer"
end event

on w_con_incidencia_calidad.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_1=create gb_1
this.st_1=create st_1
this.uo_series=create uo_series
this.gb_6=create gb_6
this.dw_listado_resumen=create dw_listado_resumen
this.dw_listado_resumen_pm=create dw_listado_resumen_pm
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.uo_series
this.Control[iCurrent+10]=this.gb_6
this.Control[iCurrent+11]=this.dw_listado_resumen
this.Control[iCurrent+12]=this.dw_listado_resumen_pm
this.Control[iCurrent+13]=this.dw_detalle
end on

on w_con_incidencia_calidad.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.uo_series)
destroy(this.gb_6)
destroy(this.dw_listado_resumen)
destroy(this.dw_listado_resumen_pm)
destroy(this.dw_detalle)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_incidencia_calidad
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_incidencia_calidad
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_incidencia_calidad
integer x = 9
integer y = 8
integer width = 3209
integer height = 84
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_con_incidencia_calidad
integer x = 3310
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_incidencia_calidad
integer x = 3296
integer y = 140
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;//if rb_pm.checked then
//	f_control_pm(dw_detalle)
//else
//	f_control(dw_detalle)
//end if
	f_imprimir_datawindow(dw_detalle)

end event

type dw_listado from datawindow within w_con_incidencia_calidad
boolean visible = false
integer x = 2523
integer y = 12
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_fechadesde from u_em_campo within w_con_incidencia_calidad
integer x = 27
integer y = 148
integer width = 302
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_incidencia_calidad
integer x = 398
integer y = 148
integer width = 279
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_incidencia_calidad
integer x = 2734
integer y = 140
integer width = 549
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;	f_control(dw_detalle)

/*
if rb_pm.checked then
	f_control_pm(dw_detalle)
else
	f_control(dw_detalle)
end if
*/
end event

type gb_1 from groupbox within w_con_incidencia_calidad
integer x = 9
integer y = 96
integer width = 690
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha de Pedido"
end type

type st_1 from statictext within w_con_incidencia_calidad
integer x = 343
integer y = 148
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -15
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

type uo_series from u_marca_lista within w_con_incidencia_calidad
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type gb_6 from groupbox within w_con_incidencia_calidad
integer x = 2715
integer y = 100
integer width = 722
integer height = 160
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_listado_resumen from datawindow within w_con_incidencia_calidad
boolean visible = false
integer x = 2711
integer y = 12
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3_r"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado_resumen_pm from datawindow within w_con_incidencia_calidad
boolean visible = false
integer x = 2898
integer y = 12
integer width = 160
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3pm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle from datawindow within w_con_incidencia_calidad
integer x = 18
integer y = 272
integer width = 3424
integer height = 1716
integer taborder = 30
string dataobject = "dw_con_incidencia_calidad"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF dwo.name= "facturacion" Then
	this.SetRedraw(False)
	this.SetSort("importe1 D")
	this.Sort()
	this.SetRedraw(True)
END IF

IF dwo.name= "abonos" Then
	this.SetRedraw(False)
	this.SetSort("importe22 D")
	this.Sort()
	this.SetRedraw(True)
END IF

IF dwo.name= "porcent" Then
	this.SetRedraw(False)
	this.SetSort("porcentaje D")
	this.Sort()
	this.SetRedraw(True)
END IF

end event

