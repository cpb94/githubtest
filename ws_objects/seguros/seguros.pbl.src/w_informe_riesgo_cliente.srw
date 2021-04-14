$PBExportHeader$w_informe_riesgo_cliente.srw
forward
global type w_informe_riesgo_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_informe_riesgo_cliente
end type
type pb_2 from upb_imprimir within w_informe_riesgo_cliente
end type
type dw_detalle from u_datawindow_consultas within w_informe_riesgo_cliente
end type
type cb_1 from u_boton within w_informe_riesgo_cliente
end type
type uo_cliente from u_em_campo_2 within w_informe_riesgo_cliente
end type
type st_6 from statictext within w_informe_riesgo_cliente
end type
end forward

global type w_informe_riesgo_cliente from w_int_con_empresa
integer width = 4777
integer height = 3320
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
cb_1 cb_1
uo_cliente uo_cliente
st_6 st_6
end type
global w_informe_riesgo_cliente w_informe_riesgo_cliente

type variables
string filtro
end variables

forward prototypes
public function decimal f_facturado_no_vencido (string empresa, string cliente)
public function decimal f_vencido_pendiente_cancelar_riesgo (string empresa, string cliente)
public function decimal f_impagado (string empresa, string cliente)
public function decimal f_apl_o_dev_pdte_cobro (string empresa, string cliente)
end prototypes

public function decimal f_facturado_no_vencido (string empresa, string cliente);dec facturado_no_vencido
datetime hoy

hoy = datetime(today())
facturado_no_vencido = 0

select sum(importe)
into :facturado_no_vencido
from carefectos
where empresa = :empresa
and cliente = :cliente
and fvto = fvto_original
and ( situacion = '0' or situacion = '1' or situacion = '4' or situacion = '5' or situacion = '6' or situacion = '10')
and fvto > :hoy;


return facturado_no_vencido
end function

public function decimal f_vencido_pendiente_cancelar_riesgo (string empresa, string cliente);dec total

datetime hoy

hoy = datetime(today())
total = 0

select sum(importe)
into :total
from carefectos
where empresa = :empresa
and cliente = :cliente
and fvto = fvto_original
and ( situacion = '0' or situacion = '1' or situacion = '4' or situacion = '5' or situacion = '6' or situacion = '10')
and fvto <= :hoy;

return total
end function

public function decimal f_impagado (string empresa, string cliente);dec total
datetime hoy

//hoy = datetime(today())
total = 0

select sum(importe)
into :total
from carefectos
where empresa = :empresa
and cliente = :cliente
and situacion = '2' ;
//and fvto > :hoy
//and fvto = fvto_original


return total
end function

public function decimal f_apl_o_dev_pdte_cobro (string empresa, string cliente);dec total
datetime hoy

hoy = datetime(today())
total = 0

select sum(importe)
into :total
from carefectos
where empresa = :empresa
and cliente = :cliente
and fvto <> fvto_original
and ( situacion = '0' or situacion = '1' or situacion = '4' or situacion = '5' or situacion = '6' or situacion = '10');


return total
end function

event close;call super::close;dw_detalle.reset()

end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.TriggerEvent("pagina_arriba")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.TriggerEvent("pagina_abajo")
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe riesgo por clientes"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
//dw_detalle.visible = FALSE

f_activar_campo(uo_cliente.em_campo)

end event

event ue_listar;dw_report  = dw_detalle
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

on w_informe_riesgo_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.uo_cliente
this.Control[iCurrent+6]=this.st_6
end on

on w_informe_riesgo_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.st_6)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_informe_riesgo_cliente
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_informe_riesgo_cliente
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_informe_riesgo_cliente
integer x = 32
integer y = 12
integer width = 4439
integer height = 88
end type

type pb_1 from upb_salir within w_informe_riesgo_cliente
integer x = 4498
integer y = 12
integer width = 114
integer height = 96
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_informe_riesgo_cliente
integer x = 4498
integer y = 120
integer taborder = 0
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
f_activar_campo(uo_cliente.em_campo)
end event

type dw_detalle from u_datawindow_consultas within w_informe_riesgo_cliente
integer y = 240
integer width = 4663
integer height = 2732
integer taborder = 0
string dataobject = "dw_informe_riesgo_cliente"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;/*
//if row=0 then Return
//str_parametros lstr_param 
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=uo_cliente.em_codigo.text
//  lstr_param.s_argumentos[3]=String(dw_detalle.GetItemString(This.GetRow(),"cuenta"))
//  OpenWithParm(wi_mant_venriesgosclientes,lstr_param)


long donde
int altura_dw_res = 50, i = 1
dec alb,fac,cobro,nego,devo,gasto,concedido
dec pedidos_pdtes, stock_deposito, total
tipo_array vencido
string cliente

dw_desglose_riesgo.reset()
cliente = this.object.codcli[row]
dw_desglose_riesgo.title = "Detalle Riesgo de "+dw_detalle.object.cliente[row]

dw_desglose_riesgo.visible = true


// David 18-01-05: Controlamos los pedidos pendientes.
pedidos_pdtes = f_pedidos_pdtes(codigo_empresa,cliente)
if pedidos_pdtes <> 0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Pedidos Pendientes")
	dw_desglose_riesgo.setitem(donde,"cantidad",pedidos_pdtes)
	i++
end if

stock_deposito = f_importe_stock_deposito_cliente (codigo_empresa,cliente)
if stock_deposito <> 0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Importe Stock Depósito")
	dw_desglose_riesgo.setitem(donde,"cantidad",stock_deposito )
	i ++
end if

// fin david

alb=f_alb_pdtes_facturar(codigo_empresa,cliente)
if alb<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Albaranes Pendientes de Facturar")
	dw_desglose_riesgo.setitem(donde,"cantidad",alb)
	i++
end if

fac=f_fac_pdtes_actualizar(codigo_empresa,cliente)
if fac<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Facturas Pendientes de Actualizar")
	dw_desglose_riesgo.setitem(donde,"cantidad",fac)
	i++
end if

cobro=f_fac_pdtes_cobro(codigo_empresa,cliente)
if cobro<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Recibos Pendientes de Cobro")
	dw_desglose_riesgo.setitem(donde,"cantidad",cobro)
	i++
end if

nego=f_negociado_pdtes_cobro(codigo_empresa,cliente)
if nego<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Negociado Pendiente de Cobro")
	dw_desglose_riesgo.setitem(donde,"cantidad",nego)
	i++
end if

vencido=f_fac_vencidas(codigo_empresa,cliente)

if dec(vencido.valor[1])<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Recibos Vencidos entre 1 y 30 días")
	dw_desglose_riesgo.setitem(donde,"cantidad",dec(vencido.valor[1]))
	i++
end if
if dec(vencido.valor[2])<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Recibos Vencidos entre 30 y 60 días")
	dw_desglose_riesgo.setitem(donde,"cantidad",dec(vencido.valor[2]))
	i++
end if
if dec(vencido.valor[3])<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Recibos Vencidos entre 60 y 90 días")
	dw_desglose_riesgo.setitem(donde,"cantidad",dec(vencido.valor[3]))
	i++
end if

if dec(vencido.valor[4])<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Recibos Vencidos mas de 90 días")
	dw_desglose_riesgo.setitem(donde,"cantidad",dec(vencido.valor[4]))
	i++
end if

devo=f_fac_devuelto(codigo_empresa,cliente)
if devo<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Devoluciones")
	dw_desglose_riesgo.setitem(donde,"cantidad",devo)
	i++
end if

gasto=f_fac_gasto(codigo_empresa,cliente)

if gasto<>0 then
	donde=dw_desglose_riesgo.insertrow(0)
	dw_desglose_riesgo.setitem(donde,"concepto","Gastos")
	dw_desglose_riesgo.setitem(donde,"cantidad",gasto)
	i++
end if

donde=dw_desglose_riesgo.insertrow(0)
dw_desglose_riesgo.setitem(donde,"concepto","-----------------------------------------")



total = pedidos_pdtes + stock_deposito + alb + fac + cobro + nego + &
dec(vencido.valor[1]) + dec(vencido.valor[2]) +dec(vencido.valor[3]) +dec(vencido.valor[4]) +devo + gasto

concedido = f_riesgo_concedio(codigo_empresa,cliente)
if isnull(concedido) then concedido = 0
donde=dw_desglose_riesgo.insertrow(0)
dw_desglose_riesgo.setitem(donde,"concepto","Riesgo Concedido")
dw_desglose_riesgo.setitem(donde,"cantidad",concedido)
i++

donde=dw_desglose_riesgo.insertrow(0)
dw_desglose_riesgo.setitem(donde,"concepto","Total Riesgo")
dw_desglose_riesgo.setitem(donde,"cantidad",Total)
i++

donde=dw_desglose_riesgo.insertrow(0)
dw_desglose_riesgo.setitem(donde,"concepto","-----------------------------------------")

donde=dw_desglose_riesgo.insertrow(0)
dw_desglose_riesgo.setitem(donde,"concepto","Diferencia")
dw_desglose_riesgo.setitem(donde,"cantidad",concedido - total)
i++

if (i * altura_dw_res) + 450	> 1300 then
	dw_desglose_riesgo.Height = 1300
else
	dw_desglose_riesgo.Height = (i * altura_dw_res) + 450
end if



*/
end event

event clicked;call super::clicked;string orden
orden = ''
choose case dwo.name
	case "t_tot_riesgo_op_normal"
		orden = "tot_riesgo_op_normal D"
		this.SetSort(orden)
		this.Sort()
	case "t_total_riesgo_actual"
		orden = "total_riesgo_actual D"
		this.SetSort(orden)
		this.Sort()
	case "t_dif_con_riesgo_aseg1"
		orden = "dif_con_riesgo_aseg1 D"
		this.SetSort(orden)
		this.Sort()
	case "t_dif_con_riesgo_aseg2"
		orden = "dif_con_riesgo_aseg2 D"
		this.SetSort(orden)
		this.Sort()
		
end choose
		
		




end event

type cb_1 from u_boton within w_informe_riesgo_cliente
integer x = 4078
integer y = 120
integer height = 100
integer taborder = 30
string text = "&Consultar"
end type

event clicked;call super::clicked;string v_cliente, sel, cliente
datastore regs
long i, fila 
dec riesgo_concedido , riesgo_actual 
dec alb_pdtes_fact , fac_pdtes_contab , facturado_no_vencido , vencido_pdte_can_riesgo , tot_riesgo_op_normal , impagado 
dec  apl_o_dev_pdte_cobro , total_riesgo_Actual , pedidos_pdtes , stock_almacen 

if uo_cliente.em_codigo.text = '' then
	v_cliente = 	'%'
else
	v_cliente = 	uo_cliente.em_codigo.text
end if

sel = ' select codigo, razon '+&
		' from genter  '+&
		' where empresa = "'+codigo_empresa +'"'+&
		' and tipoter = "C" '+&
		' and codigo like "'+v_cliente+'"'
		
f_cargar_cursor_nuevo ( sel, regs)
dw_detalle.Retrieve()
for i = 1 to regs.Rowcount()
	fila = dw_detalle.insertrow(0)
	cliente = regs.object.codigo[i]

	dw_detalle.object.codcli[fila] = regs.object.codigo[i]
	dw_detalle.object.cliente[fila] = regs.object.razon[i]
	dw_detalle.object.riesgo_concedido[fila] = f_riesgo_concedio (codigo_empresa, cliente)
	dw_detalle.object.riesgo_actual[fila] = f_riesgo_cliente (codigo_empresa, cliente)
	dw_detalle.object.alb_pdtes_fact[fila] = f_alb_pdtes_facturar (codigo_empresa,cliente)
	dw_detalle.object.fac_pdtes_contab[fila] = f_fac_pdtes_actualizar (codigo_empresa,cliente)
	dw_detalle.object.facturado_no_vencido[fila] = f_facturado_no_vencido (codigo_empresa,cliente)
	dw_detalle.object.vencido_pdte_can_riesgo[fila] = f_vencido_pendiente_cancelar_riesgo (codigo_empresa,cliente)
	dw_detalle.object.impagado[fila] = f_impagado (codigo_empresa,cliente)
	dw_detalle.object.apl_o_dev_pdte_cobro[fila] = f_apl_o_dev_pdte_cobro(codigo_empresa, cliente)

	
	if isnull(dw_detalle.object.riesgo_concedido[fila]) then riesgo_concedido = 0 else riesgo_concedido = dw_detalle.object.riesgo_concedido[fila]
	if isnull(dw_detalle.object.alb_pdtes_fact[fila]) then alb_pdtes_fact = 0 else alb_pdtes_fact = dw_detalle.object.alb_pdtes_fact[fila] 
	if isnull(dw_detalle.object.fac_pdtes_contab[fila]) then fac_pdtes_contab = 0 else fac_pdtes_contab = dw_detalle.object.fac_pdtes_contab[fila] 
	if isnull(dw_detalle.object.facturado_no_vencido[fila]) then facturado_no_vencido = 0 else facturado_no_vencido = dw_detalle.object.facturado_no_vencido[fila] 
	if isnull(dw_detalle.object.vencido_pdte_can_riesgo[fila]) then vencido_pdte_can_riesgo = 0 else vencido_pdte_can_riesgo = dw_detalle.object.vencido_pdte_can_riesgo[fila] 
	
	dw_detalle.object.tot_riesgo_op_normal[fila] =  alb_pdtes_fact + fac_pdtes_contab + facturado_no_vencido + vencido_pdte_can_riesgo
	
	if isnull(dw_detalle.object.tot_riesgo_op_normal[fila]) then tot_riesgo_op_normal = 0 else tot_riesgo_op_normal = dw_detalle.object.tot_riesgo_op_normal[fila] 
	
	dw_detalle.object.dif_con_riesgo_aseg1[fila] = riesgo_concedido - tot_riesgo_op_normal

	if isnull(dw_detalle.object.impagado[fila]) then impagado = 0 else impagado = dw_detalle.object.impagado[fila] 
	if isnull(dw_detalle.object.apl_o_dev_pdte_cobro[fila]) then apl_o_dev_pdte_cobro = 0 else apl_o_dev_pdte_cobro = dw_detalle.object.apl_o_dev_pdte_cobro[fila] 

	dw_detalle.object.total_riesgo_Actual[fila] = tot_riesgo_op_normal + impagado + apl_o_dev_pdte_cobro
	if isnull (dw_detalle.object.total_riesgo_Actual[fila] ) then total_riesgo_actual = 0 else total_riesgo_actual = dw_detalle.object.total_riesgo_Actual[fila] 
	dw_detalle.object.dif_con_riesgo_aseg2[fila] = riesgo_concedido - total_riesgo_actual

	dw_detalle.object.pedidos_pdtes[fila] = f_pedidos_pdtes(codigo_empresa,cliente)
	dw_detalle.object.stock_deposito[fila] = f_importe_stock_deposito_cliente (codigo_empresa,cliente)
	dw_detalle.object.stock_almacen[fila] = f_valor_stock_cliente_almlinubica (codigo_empresa,cliente)
	
	if isnull(dw_detalle.object.pedidos_pdtes[fila]) then pedidos_pdtes = 0 else pedidos_pdtes = dw_detalle.object.pedidos_pdtes[fila] 
	if isnull(dw_detalle.object.stock_almacen[fila]) then stock_almacen = 0 else stock_almacen = dw_detalle.object.stock_almacen[fila] 
	dw_detalle.object.tot_riesgo_no_cubierto[fila] = pedidos_pdtes + stock_almacen
		
	f_mensaje_proceso ('Registro:', i, regs.rowcount())
next


dw_detalle.sort()
dw_detalle.groupcalc()


destroy regs

end event

type uo_cliente from u_em_campo_2 within w_informe_riesgo_cliente
event destroy ( )
integer x = 270
integer y = 120
integer width = 1399
integer taborder = 70
boolean bringtotop = true
boolean border = true
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

event getfocus;call super::getfocus;ue_titulo = "Selección de clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""

end event

type st_6 from statictext within w_informe_riesgo_cliente
integer x = 5
integer y = 124
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

