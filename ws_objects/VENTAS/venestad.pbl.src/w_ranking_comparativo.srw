$PBExportHeader$w_ranking_comparativo.srw
forward
global type w_ranking_comparativo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_ranking_comparativo
end type
type pb_2 from upb_imprimir within w_ranking_comparativo
end type
type dw_listado from datawindow within w_ranking_comparativo
end type
type em_fechadesde from u_em_campo within w_ranking_comparativo
end type
type em_fechahasta from u_em_campo within w_ranking_comparativo
end type
type cb_1 from commandbutton within w_ranking_comparativo
end type
type gb_1 from groupbox within w_ranking_comparativo
end type
type st_1 from statictext within w_ranking_comparativo
end type
type uo_series from u_marca_lista within w_ranking_comparativo
end type
type gb_6 from groupbox within w_ranking_comparativo
end type
type dw_listado_resumen from datawindow within w_ranking_comparativo
end type
type dw_listado_resumen_pm from datawindow within w_ranking_comparativo
end type
type dw_detalle from datawindow within w_ranking_comparativo
end type
type uo_agente from u_em_campo_2 within w_ranking_comparativo
end type
type st_2 from statictext within w_ranking_comparativo
end type
type st_3 from statictext within w_ranking_comparativo
end type
type st_4 from statictext within w_ranking_comparativo
end type
type dw_subclientes from datawindow within w_ranking_comparativo
end type
type cb_2 from commandbutton within w_ranking_comparativo
end type
type gb_2 from groupbox within w_ranking_comparativo
end type
end forward

global type w_ranking_comparativo from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 3502
integer height = 4032
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
uo_agente uo_agente
st_2 st_2
st_3 st_3
st_4 st_4
dw_subclientes dw_subclientes
cb_2 cb_2
gb_2 gb_2
end type
global w_ranking_comparativo w_ranking_comparativo

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_piezas_metros_importe (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente)
public subroutine f_importe_cliente (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente)
end prototypes

public subroutine f_control (datawindow data);datastore ds_clientes
long i, fila_Actual
string sel1, cliente, v_empresa, agente1, cod_cliente 
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

if uo_agente.em_codigo.text <> '' then
	agente1 = uo_agente.em_codigo.text
else
	agente1 = '%'
end if

sel1 = 	" SELECT venfac.empresa, genter.codigo, genter.razon, Sum((venfac.total_neto) / venfac.cambio) as total, "+&
										" (SELECT Sum((b.total_neto) / b.cambio) "+&
										" FROM venfac b "+&
										" WHERE  b.empresa = '"+codigo_empresa+"' "+&
										" AND b.cliente = genter.codigo "+&
										" AND b.ffactura >= '"+string(fecha1)+"' "+&
										" AND b.ffactura <= '"+string(fecha2)+"') as total2 "+&
			" FROM   venfac, genter, venclientes "+&
			" WHERE  venfac.empresa = '"+codigo_empresa+"' "+&
			" AND genter.tipoter = 'C' "+&
			" AND genter.empresa = '"+codigo_empresa+"' "+&
			" AND genter.codigo *= venfac.cliente "+&
			" AND genter.empresa = venclientes.empresa "+&
			" AND genter.codigo = venclientes.codigo "+&
			" AND venfac.ffactura >= '"+em_fechadesde.text+"' "+&
			" AND venfac.ffactura <= '"+em_fechahasta.text+"' "+&
			" AND venclientes.agente1 like '"+agente1+"' "+&
			" GROUP BY venfac.empresa, genter.codigo, genter.razon "+&
			" ORDER BY Sum((venfac.total_neto) / venfac.cambio) Desc "

f_cargar_cursor_nuevo (sel1, ds_clientes)

dw_detalle.Setredraw(false)
dw_Detalle.object.actual.text =  em_fechadesde.text+" a "+em_fechahasta.text
dw_Detalle.object.Anterior.text = string(fecha1,"dd-mm-yy")+" a "+string(fecha2,"dd-mm-yy")

for i = 1 to ds_clientes.rowcount()
	fila_actual = dw_detalle.insertrow(0)
	cod_cliente = ds_clientes.object.genter_codigo[i]
	cliente = ds_clientes.object.genter_razon[i]
	v_importe = ds_clientes.object.total[i]
	v_importe2 = ds_clientes.object.total2[i]
	
	dw_detalle.object.cod_cliente[fila_actual] = cod_cliente
	dw_detalle.object.cliente[fila_actual] = cliente
	dw_detalle.object.importe[fila_actual] = v_importe
	dw_detalle.object.importe2[fila_actual] = v_importe2
	f_mensaje_proceso ("Clientes:", i, ds_clientes.rowcount())
next



dw_detalle.setsort("")
dw_detalle.sort()
dw_detalle.Setredraw(True)

//dw_detalle.setfilter("importe > 0 or importe2 > 0")
//dw_detalle.filter()

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

dw_subclientes.SetTransobject( SQLCA)
end event

on w_ranking_comparativo.create
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
this.uo_agente=create uo_agente
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.dw_subclientes=create dw_subclientes
this.cb_2=create cb_2
this.gb_2=create gb_2
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
this.Control[iCurrent+14]=this.uo_agente
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.dw_subclientes
this.Control[iCurrent+19]=this.cb_2
this.Control[iCurrent+20]=this.gb_2
end on

on w_ranking_comparativo.destroy
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
destroy(this.uo_agente)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_subclientes)
destroy(this.cb_2)
destroy(this.gb_2)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_ranking_comparativo
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_ranking_comparativo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_ranking_comparativo
integer y = 8
integer width = 3209
integer height = 84
end type

type pb_1 from upb_salir within w_ranking_comparativo
integer x = 3314
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_ranking_comparativo
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

type dw_listado from datawindow within w_ranking_comparativo
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

type em_fechadesde from u_em_campo within w_ranking_comparativo
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

type em_fechahasta from u_em_campo within w_ranking_comparativo
integer x = 398
integer y = 148
integer width = 279
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_ranking_comparativo
integer x = 2734
integer y = 140
integer width = 549
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;	f_control(dw_detalle)


end event

type gb_1 from groupbox within w_ranking_comparativo
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
string text = "Fecha de Factura"
end type

type st_1 from statictext within w_ranking_comparativo
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

type uo_series from u_marca_lista within w_ranking_comparativo
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type gb_6 from groupbox within w_ranking_comparativo
integer x = 2715
integer y = 100
integer width = 722
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_listado_resumen from datawindow within w_ranking_comparativo
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

type dw_listado_resumen_pm from datawindow within w_ranking_comparativo
boolean visible = false
integer x = 2898
integer y = 12
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3pm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle from datawindow within w_ranking_comparativo
integer x = 18
integer y = 408
integer width = 3424
integer height = 2608
string dataobject = "dw_ranking_comparativo"
boolean vscrollbar = true
boolean border = false
end type

event doubleclicked;string cod_cliente 

cod_cliente = dw_detalle.object.cod_cliente[row]

dw_subclientes.visible = true
dw_subclientes.retrieve (codigo_empresa, cod_cliente, datetime(em_fechadesde.text), datetime(em_fechahasta.text ))
end event

event rowfocuschanged;string cod_cliente 
datetime fechad, fechah

if dw_detalle.rowcount( ) > 0 then
	cod_cliente = dw_detalle.object.cod_cliente[currentrow]
	fechad = datetime (em_fechadesde.text)
	fechah = datetime (em_fechahasta.text )
	if isnull(cod_cliente ) then 
		cod_cliente = ''
	end if
	dw_subclientes.retrieve (codigo_empresa, cod_cliente, fechad, fechah)
end if

end event

type uo_agente from u_em_campo_2 within w_ranking_comparativo
event destroy ( )
integer x = 1102
integer y = 152
integer width = 1403
integer taborder = 30
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

event getfocus;call super::getfocus;	ue_titulo = "Selección de Agente"
	ue_datawindow ="dw_ayuda_venagentes"
	ue_filtro = ""

end event

type st_2 from statictext within w_ranking_comparativo
integer x = 736
integer y = 160
integer width = 343
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Agente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_ranking_comparativo
integer x = 18
integer y = 272
integer width = 1472
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 16777215
string text = "Tiene en cuenta Rappels (en dic.) y todos los dtos. excepto dtopp."
boolean focusrectangle = false
end type

type st_4 from statictext within w_ranking_comparativo
integer x = 23
integer y = 320
integer width = 1275
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 16777215
string text = "Incluye la facturación ajena a la actividad."
boolean focusrectangle = false
end type

type dw_subclientes from datawindow within w_ranking_comparativo
integer x = 18
integer y = 3028
integer width = 3429
integer height = 820
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_subclientes"
boolean controlmenu = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within w_ranking_comparativo
integer x = 2734
integer y = 276
integer width = 695
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar a Excel"
end type

event clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_detalle.rowcount()

if ll_registros > 0 then
	
	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then

		uf_save_dw_as_excel(dw_detalle,ls_ruta_fichero)
		
	end if

end if

end event

type gb_2 from groupbox within w_ranking_comparativo
integer x = 2715
integer y = 268
integer width = 722
integer height = 120
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

