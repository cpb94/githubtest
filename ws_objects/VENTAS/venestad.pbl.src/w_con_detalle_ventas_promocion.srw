$PBExportHeader$w_con_detalle_ventas_promocion.srw
forward
global type w_con_detalle_ventas_promocion from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_detalle_ventas_promocion
end type
type pb_2 from upb_imprimir within w_con_detalle_ventas_promocion
end type
type em_fechadesde from u_em_campo within w_con_detalle_ventas_promocion
end type
type em_fechahasta from u_em_campo within w_con_detalle_ventas_promocion
end type
type cb_1 from commandbutton within w_con_detalle_ventas_promocion
end type
type gb_1 from groupbox within w_con_detalle_ventas_promocion
end type
type st_1 from statictext within w_con_detalle_ventas_promocion
end type
type gb_6 from groupbox within w_con_detalle_ventas_promocion
end type
type dw_detalle from datawindow within w_con_detalle_ventas_promocion
end type
type uo_agente from u_em_campo_2 within w_con_detalle_ventas_promocion
end type
type uo_cliente from u_em_campo_2 within w_con_detalle_ventas_promocion
end type
type uo_familia from u_em_campo_2 within w_con_detalle_ventas_promocion
end type
type uo_articulo from u_em_campo_2 within w_con_detalle_ventas_promocion
end type
type uo_pais from u_em_campo_2 within w_con_detalle_ventas_promocion
end type
type cbx_promocion from checkbox within w_con_detalle_ventas_promocion
end type
type gb_4 from groupbox within w_con_detalle_ventas_promocion
end type
type gb_8 from groupbox within w_con_detalle_ventas_promocion
end type
type gb_2 from groupbox within w_con_detalle_ventas_promocion
end type
type gb_3 from groupbox within w_con_detalle_ventas_promocion
end type
type gb_5 from groupbox within w_con_detalle_ventas_promocion
end type
end forward

global type w_con_detalle_ventas_promocion from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 4878
integer height = 3912
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_1 gb_1
st_1 st_1
gb_6 gb_6
dw_detalle dw_detalle
uo_agente uo_agente
uo_cliente uo_cliente
uo_familia uo_familia
uo_articulo uo_articulo
uo_pais uo_pais
cbx_promocion cbx_promocion
gb_4 gb_4
gb_8 gb_8
gb_2 gb_2
gb_3 gb_3
gb_5 gb_5
end type
global w_con_detalle_ventas_promocion w_con_detalle_ventas_promocion

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_piezas_metros_importe (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente)
public subroutine f_importe_cliente (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente)
end prototypes

public subroutine f_control (datawindow data);datastore ds_clientes
long i, fila_Actual
string sel1, cliente, v_empresa, agente1, cod_cliente , familia, texto_cliente, texto_familia, pais, texto_pais, texto_agente
date fecha1, fecha2, v_fpedido
integer dia1, mes1, anyo1, dia2, mes2, anyo2, v_anyo, v_pedido, v_linea
string v_cod_agente, v_agente
string v_cod_articulo, v_articulo, articulo
dec{2} v_cantidad
string tipolinea

dw_detalle.reset()
fecha1 = date(em_fechadesde.text)
fecha2 = date(em_fechahasta.text)

//dia1 = day(fecha1)
//mes1 = month(fecha1)
//anyo1 = year(fecha1) - 1
//dia2 = day(fecha2)
//mes2 = month(fecha2) 
//anyo2 = year(fecha2) - 1

//fecha1 = Date ( anyo1, mes1, dia1)
//fecha2 = Date ( anyo2, mes2, dia2)

if uo_agente.em_codigo.text <> '' then
	agente1 = uo_agente.em_codigo.text
	texto_agente = "        Agente: "+uo_agente.em_campo.text
else
	agente1 = '%'
end if

if uo_cliente.em_codigo.text <> '' then
	cliente = uo_cliente.em_codigo.text
	texto_cliente = "        Cliente: "+uo_cliente.em_campo.text
else
	cliente = '%'
end if

if uo_familia.em_codigo.text <> '' then
	familia = uo_familia.em_codigo.text
	texto_familia =  "        Familia: "+uo_familia.em_campo.text
else
	familia = '%'
end if

if uo_articulo.em_codigo.text <> '' then
	articulo = uo_articulo.em_codigo.text
else
	articulo = '%'
end if

if uo_pais.em_codigo.text <> '' then
	pais = uo_pais.em_codigo.text
	texto_pais =  "        País: "+uo_pais.em_campo.text
else
	pais = '%'
end if

if cbx_promocion.checked then
	sel1 = " select venlifac.cliente, genter.razon, venlifac.articulo, articulos.descripcion, sum(cantidad) as CANTIDAD "  +&
			" from venlifac "+&
			" inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo " +&
			" inner join genter on venlifac.empresa = genter.empresa and venlifac.cliente = genter.codigo and genter.tipoter = 'C'" +&
			" inner join venclientes on genter.empresa = venclientes.empresa and genter.codigo = venclientes.codigo "+&
			" where articulos.familia like '"+familia+"' "+&
			" AND venlifac.ffactura >= '"+em_fechadesde.text+"' "+&
			" AND venlifac.ffactura <= '"+em_fechahasta.text+"' "+&
			" AND venclientes.agente1 like '"+agente1+"' "+&
			" AND venlifac.cliente like '"+cliente+"' "+&
			" AND venlifac.empresa like '"+codigo_empresa+"' "+&
			" AND venlifac.articulo like '"+articulo+"' "+&
			" AND genter.pais like '"+pais+"' "+&
			" and venlifac.tipolinea = '4' " +&
			" group by venlifac.cliente, genter.razon, venlifac.articulo, articulos.descripcion "	/*+&
			" order by genter.razon ASC"*/
else
		sel1 = " select venlifac.cliente, genter.razon, venlifac.articulo, articulos.descripcion, sum(cantidad) as CANTIDAD "  +&
			" from venlifac "+&
			" inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo " +&
			" inner join genter on venlifac.empresa = genter.empresa and venlifac.cliente = genter.codigo and genter.tipoter = 'C'" +&
			" inner join venclientes on genter.empresa = venclientes.empresa and genter.codigo = venclientes.codigo "+&
			" where articulos.familia like '"+familia+"' "+&
			" AND venlifac.ffactura >= '"+em_fechadesde.text+"' "+&
			" AND venlifac.ffactura <= '"+em_fechahasta.text+"' "+&
			" AND venclientes.agente1 like '"+agente1+"' "+&
			" AND venlifac.cliente like '"+cliente+"' "+&
			" AND venlifac.empresa like '"+codigo_empresa+"' "+&
			" AND venlifac.articulo like '"+articulo+"' "+&
			" AND genter.pais like '"+pais+"' "+&
			" group by venlifac.cliente, genter.razon, venlifac.articulo, articulos.descripcion "	/*+&
			" order by genter.razon ASC"*/
end if
f_cargar_cursor_nuevo (sel1, ds_clientes)

dw_detalle.Setredraw(false)

dw_Detalle.object.texto.text =  em_fechadesde.text+" a "+em_fechahasta.text  + texto_cliente+ texto_familia+ texto_pais + texto_agente

for i = 1 to ds_clientes.rowcount()
	fila_actual = dw_detalle.insertrow(0)
	cod_cliente = ds_clientes.object.venlifac_cliente[i]
	cliente = ds_clientes.object.genter_razon[i]

//	v_cod_agente = ds_clientes.object.venagentes_agente[i]
//	v_agente = ds_clientes.object.venagentes_nombre[i]

	v_cod_articulo = ds_clientes.object.venlifac_articulo[i]
	v_articulo = ds_clientes.object.articulos_descripcion[i]

	v_cantidad = ds_clientes.object.cantidad[i]
	
	
	dw_detalle.object.cod_cliente[fila_actual] = cod_cliente
	dw_detalle.object.cliente[fila_actual] = cliente
	dw_detalle.object.cod_agente[fila_actual] = v_cod_agente
	dw_detalle.object.agente[fila_actual] = v_agente
	dw_detalle.object.cod_articulo[fila_actual] = v_cod_articulo
	dw_detalle.object.articulo[fila_actual] = v_articulo
	dw_detalle.object.cantidad[fila_actual] = v_cantidad
	
	f_mensaje_proceso ("Clientes:", i, ds_clientes.rowcount())
next



dw_detalle.setsort("cliente ASC" )
dw_detalle.sort()

dw_detalle.GroupCalc()
dw_detalle.Setredraw(True)

//dw_detalle.setfilter("importe > 0 ")
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

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Ventas y Promoción por Agentes y Clientes"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())


end event

on w_con_detalle_ventas_promocion.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_1=create gb_1
this.st_1=create st_1
this.gb_6=create gb_6
this.dw_detalle=create dw_detalle
this.uo_agente=create uo_agente
this.uo_cliente=create uo_cliente
this.uo_familia=create uo_familia
this.uo_articulo=create uo_articulo
this.uo_pais=create uo_pais
this.cbx_promocion=create cbx_promocion
this.gb_4=create gb_4
this.gb_8=create gb_8
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.gb_6
this.Control[iCurrent+9]=this.dw_detalle
this.Control[iCurrent+10]=this.uo_agente
this.Control[iCurrent+11]=this.uo_cliente
this.Control[iCurrent+12]=this.uo_familia
this.Control[iCurrent+13]=this.uo_articulo
this.Control[iCurrent+14]=this.uo_pais
this.Control[iCurrent+15]=this.cbx_promocion
this.Control[iCurrent+16]=this.gb_4
this.Control[iCurrent+17]=this.gb_8
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.gb_5
end on

on w_con_detalle_ventas_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.gb_6)
destroy(this.dw_detalle)
destroy(this.uo_agente)
destroy(this.uo_cliente)
destroy(this.uo_familia)
destroy(this.uo_articulo)
destroy(this.uo_pais)
destroy(this.cbx_promocion)
destroy(this.gb_4)
destroy(this.gb_8)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_5)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_detalle_ventas_promocion
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_detalle_ventas_promocion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_detalle_ventas_promocion
integer y = 8
integer width = 4713
integer height = 84
end type

type pb_1 from upb_salir within w_con_detalle_ventas_promocion
integer x = 4731
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_detalle_ventas_promocion
integer x = 4681
integer y = 136
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

type em_fechadesde from u_em_campo within w_con_detalle_ventas_promocion
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

type em_fechahasta from u_em_campo within w_con_detalle_ventas_promocion
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

type cb_1 from commandbutton within w_con_detalle_ventas_promocion
integer x = 4151
integer y = 136
integer width = 517
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

type gb_1 from groupbox within w_con_detalle_ventas_promocion
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

type st_1 from statictext within w_con_detalle_ventas_promocion
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

type gb_6 from groupbox within w_con_detalle_ventas_promocion
integer x = 4133
integer y = 96
integer width = 695
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

type dw_detalle from datawindow within w_con_detalle_ventas_promocion
integer x = 18
integer y = 424
integer width = 4805
integer height = 3284
string dataobject = "dw_con_detalle_ventas_promocion"
boolean vscrollbar = true
boolean border = false
end type

event rowfocuschanged;//string cod_cliente 
//datetime fechad, fechah
//
//if dw_detalle.rowcount( ) > 0 then
//	cod_cliente = dw_detalle.object.cod_cliente[currentrow]
//	fechad = datetime (em_fechadesde.text)
//	fechah = datetime (em_fechahasta.text )
//	if isnull(cod_cliente ) then 
//		cod_cliente = ''
//	end if
//	dw_subclientes.retrieve (codigo_empresa, cod_cliente, fechad, fechah)
//end if

end event

event clicked;
choose case dwo.name
	case 't_cliente'
		dw_detalle.setsort("cliente Desc")
	case 't_ventas'
		dw_detalle.setsort("importe Desc")
	case 't_coste_promo'
		dw_detalle.setsort("coste_promo Desc")
	case 't_promo'
		dw_detalle.setsort("promo Desc")
	case 't_porcentaje'
		dw_detalle.setsort("porcentaje Desc")
		
end choose

dw_detalle.Sort()

end event

type uo_agente from u_em_campo_2 within w_con_detalle_ventas_promocion
event destroy ( )
integer x = 786
integer y = 148
integer width = 1216
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

type uo_cliente from u_em_campo_2 within w_con_detalle_ventas_promocion
event destroy ( )
integer x = 2080
integer y = 152
integer width = 1253
integer height = 80
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_cliente

select razon
into :des_cliente
from genter
where empresa = :codigo_empresa
and codigo = :uo_cliente.em_codigo.text
and tipoter = 'C';

uo_cliente.em_campo.text = des_cliente

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow  = "dw_ayuda_clientes"
ue_filtro = ""
end event

type uo_familia from u_em_campo_2 within w_con_detalle_ventas_promocion
event destroy ( )
integer x = 3387
integer y = 148
integer width = 672
integer taborder = 100
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= descripcion
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type uo_articulo from u_em_campo_2 within w_con_detalle_ventas_promocion
event destroy ( )
integer x = 786
integer y = 308
integer width = 1216
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)

If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;	ue_titulo = "Selección de Artículos"
	ue_datawindow ="dw_ayuda_articulos"
	ue_filtro = ""

end event

type uo_pais from u_em_campo_2 within w_con_detalle_ventas_promocion
event destroy ( )
integer x = 2103
integer y = 308
integer width = 1216
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_pais.em_campo.text =  f_nombre_pais (uo_pais.em_codigo.text)

If Trim(uo_pais.em_campo.text) = "" then
	uo_pais.em_campo.text =""
	uo_pais.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;	ue_titulo = "Selección de Países"
	ue_datawindow ="dw_ayuda_paises"
	ue_filtro = ""
	valor_empresa = FALSE
end event

type cbx_promocion from checkbox within w_con_detalle_ventas_promocion
integer x = 142
integer y = 304
integer width = 466
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Promoción"
boolean checked = true
end type

type gb_4 from groupbox within w_con_detalle_ventas_promocion
integer x = 750
integer y = 100
integer width = 1289
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

type gb_8 from groupbox within w_con_detalle_ventas_promocion
integer x = 3365
integer y = 96
integer width = 736
integer height = 160
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "Familia"
end type

type gb_2 from groupbox within w_con_detalle_ventas_promocion
integer x = 2062
integer y = 100
integer width = 1289
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
string text = "Cliente"
end type

type gb_3 from groupbox within w_con_detalle_ventas_promocion
integer x = 750
integer y = 260
integer width = 1289
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
string text = "Artículo"
end type

type gb_5 from groupbox within w_con_detalle_ventas_promocion
integer x = 2066
integer y = 260
integer width = 1289
integer height = 160
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "País"
end type

