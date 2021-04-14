$PBExportHeader$w_con_situacion_riesgo.srw
forward
global type w_con_situacion_riesgo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_situacion_riesgo
end type
type pb_2 from upb_imprimir within w_con_situacion_riesgo
end type
type dw_detalle from u_datawindow_consultas within w_con_situacion_riesgo
end type
type cb_1 from u_boton within w_con_situacion_riesgo
end type
type uo_cliente from u_em_campo_2 within w_con_situacion_riesgo
end type
type st_6 from statictext within w_con_situacion_riesgo
end type
type dw_desglose_riesgo from datawindow within w_con_situacion_riesgo
end type
end forward

global type w_con_situacion_riesgo from w_int_con_empresa
integer width = 3392
integer height = 2708
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
cb_1 cb_1
uo_cliente uo_cliente
st_6 st_6
dw_desglose_riesgo dw_desglose_riesgo
end type
global w_con_situacion_riesgo w_con_situacion_riesgo

type variables
string filtro
end variables

event close;call super::close;dw_detalle.reset()

end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.TriggerEvent("pagina_arriba")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.TriggerEvent("pagina_abajo")
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta estado del riesgo por clientes"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
//dw_detalle.visible = FALSE

f_activar_campo(uo_cliente.em_campo)

end event

event ue_listar;dw_report  = dw_detalle
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

on w_con_situacion_riesgo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.st_6=create st_6
this.dw_desglose_riesgo=create dw_desglose_riesgo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.uo_cliente
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.dw_desglose_riesgo
end on

on w_con_situacion_riesgo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.st_6)
destroy(this.dw_desglose_riesgo)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_situacion_riesgo
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_situacion_riesgo
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_situacion_riesgo
integer x = 32
integer width = 3095
integer height = 92
end type

type pb_1 from upb_salir within w_con_situacion_riesgo
integer x = 3145
integer y = 4
integer width = 114
integer height = 96
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_situacion_riesgo
integer x = 3145
integer y = 112
integer taborder = 0
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
f_activar_campo(uo_cliente.em_campo)
end event

type dw_detalle from u_datawindow_consultas within w_con_situacion_riesgo
integer y = 240
integer width = 3310
integer height = 2188
integer taborder = 0
string dataobject = "dw_con_situacion_riesgo"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;//if row=0 then Return
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




end event

type cb_1 from u_boton within w_con_situacion_riesgo
integer x = 2725
integer y = 112
integer height = 100
integer taborder = 30
string text = "&Consultar"
end type

event clicked;call super::clicked;string v_cliente, sel
datastore regs
long i, fila
dec riesgo_concedido, riesgo_actual

//dw_detalle.reset()

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
	riesgo_actual = f_riesgo_cliente(codigo_empresa, regs.object.codigo[i])
	riesgo_concedido = f_riesgo_concedio(codigo_empresa, regs.object.codigo[i])
	dw_detalle.object.codcli[fila] = regs.object.codigo[i]
	dw_detalle.object.cliente[fila] = regs.object.razon[i]
	dw_detalle.object.riesgo_concedido[fila] = riesgo_concedido 
	dw_detalle.object.riesgo_actual[fila] = riesgo_actual
	if riesgo_concedido <> 0 then
		dw_detalle.object.diferencia_riesgo[fila] = riesgo_concedido - riesgo_actual
	end if
	f_mensaje_proceso ('Registro:', i, regs.rowcount())
next


dw_detalle.sort()
dw_detalle.groupcalc()


destroy regs

end event

type uo_cliente from u_em_campo_2 within w_con_situacion_riesgo
event destroy ( )
integer x = 270
integer y = 112
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

type st_6 from statictext within w_con_situacion_riesgo
integer x = 5
integer y = 116
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

type dw_desglose_riesgo from datawindow within w_con_situacion_riesgo
boolean visible = false
integer x = 1175
integer y = 596
integer width = 2066
integer height = 848
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle Riesgo"
string dataobject = "dw_desglose_riesgo"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long Job

if dwo.name = "p_salir" then
	this.visible = false
end if

if dwo.name = "p_imprimir" then
	if MessageBox("Pregunta", "¿Desea Imprimir el Riesgo de este cliente?",   Question!, YesNO!, 2) = 1 then
		Job = PrintOpen( )
		this.Print(Job, 500,1000)
		PrintClose(Job)
	end if
end if
end event

