$PBExportHeader$w_con_situacion_riesgo_con_historico.srw
forward
global type w_con_situacion_riesgo_con_historico from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_situacion_riesgo_con_historico
end type
type pb_2 from upb_imprimir within w_con_situacion_riesgo_con_historico
end type
type dw_detalle from u_datawindow_consultas within w_con_situacion_riesgo_con_historico
end type
type cb_1 from u_boton within w_con_situacion_riesgo_con_historico
end type
type uo_cliente from u_em_campo_2 within w_con_situacion_riesgo_con_historico
end type
type st_6 from statictext within w_con_situacion_riesgo_con_historico
end type
type dw_desglose_riesgo from datawindow within w_con_situacion_riesgo_con_historico
end type
type cbx_resumen from checkbox within w_con_situacion_riesgo_con_historico
end type
type cbx_historico from checkbox within w_con_situacion_riesgo_con_historico
end type
end forward

global type w_con_situacion_riesgo_con_historico from w_int_con_empresa
integer width = 4763
integer height = 3772
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
cb_1 cb_1
uo_cliente uo_cliente
st_6 st_6
dw_desglose_riesgo dw_desglose_riesgo
cbx_resumen cbx_resumen
cbx_historico cbx_historico
end type
global w_con_situacion_riesgo_con_historico w_con_situacion_riesgo_con_historico

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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta estado del riesgo por clientes contemplando el histórico"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
//dw_detalle.visible = FALSE

f_activar_campo(uo_cliente.em_campo)

end event

event ue_listar;dw_report  = dw_detalle
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

on w_con_situacion_riesgo_con_historico.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.st_6=create st_6
this.dw_desglose_riesgo=create dw_desglose_riesgo
this.cbx_resumen=create cbx_resumen
this.cbx_historico=create cbx_historico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.uo_cliente
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.dw_desglose_riesgo
this.Control[iCurrent+8]=this.cbx_resumen
this.Control[iCurrent+9]=this.cbx_historico
end on

on w_con_situacion_riesgo_con_historico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.st_6)
destroy(this.dw_desglose_riesgo)
destroy(this.cbx_resumen)
destroy(this.cbx_historico)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_situacion_riesgo_con_historico
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_situacion_riesgo_con_historico
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_situacion_riesgo_con_historico
integer x = 32
integer width = 4658
integer height = 80
end type

type pb_1 from upb_salir within w_con_situacion_riesgo_con_historico
integer x = 4571
integer y = 108
integer width = 114
integer height = 96
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_situacion_riesgo_con_historico
integer x = 4448
integer y = 108
integer taborder = 0
end type

event clicked;call super::clicked;parent.triggerEvent("ue_listar")
f_activar_campo(uo_cliente.em_campo)
end event

type dw_detalle from u_datawindow_consultas within w_con_situacion_riesgo_con_historico
integer x = 9
integer y = 240
integer width = 4686
integer height = 3272
integer taborder = 0
string dataobject = "dw_con_situacion_riesgo_con_historico"
boolean vscrollbar = true
boolean border = false
end type

event doubleclicked;call super::doubleclicked;//if row=0 then Return
//str_parametros lstr_param 
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=uo_cliente.em_codigo.text
//  lstr_param.s_argumentos[3]=String(dw_detalle.GetItemString(This.GetRow(),"cuenta"))
//  OpenWithParm(wi_mant_venriesgosclientes,lstr_param)

/*
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

type cb_1 from u_boton within w_con_situacion_riesgo_con_historico
integer x = 4133
integer y = 108
integer width = 306
integer height = 96
integer taborder = 30
string text = "&Consultar"
end type

event clicked;call super::clicked;string v_cliente, sel, cliente_act, razon, cliente_ant, f_pago
datastore regs
long i, fila, total_registros
dec riesgo, riesgo_concedido, riesgo_cubierto, riesgo_no_cubierto, devuelto, total_riesgo, fac_vencidas, importe_cubierto
datetime fecha1, fecha2
dec maximo_riesgo_concedido, cubierto_acumulado_anterior, cubierto_acumulado_actual, riesgo_cubierto_real

if uo_cliente.em_codigo.text = '' then
	v_cliente = 	'%'
else
	v_cliente = 	uo_cliente.em_codigo.text
end if

sel = " select venriesgoclienteshis.cliente, venriesgoclienteshis.fecha, venriesgoclienteshis.riesgo,"+& 
		" venriesgoclienteshis.situacion, genter.razon, carforpag.texto1 "+&
		" from venriesgoclienteshis, genter, venclientes, carforpag "+&
		" where situacion = 'concedido' "+&
		" and venriesgoclienteshis.empresa = genter.empresa "+&
		" and venriesgoclienteshis.cliente = genter.codigo "+&
		" and genter.activo <> 'N' "+&
		" and genter.tipoter = 'C' "+&
		" and cliente like '"+v_cliente+"' "+&
		" and genter.empresa = venclientes.empresa "+&
		" and genter.codigo = venclientes.codigo "+&
		" and venclientes.empresa = carforpag.empresa "+&
		" and venclientes.cod_pago = carforpag.forma "+&
		" order by cliente, fecha "

	
f_cargar_cursor_nuevo ( sel, regs)

total_registros = regs.Rowcount()
dw_detalle.reset()

cubierto_acumulado_anterior = 0 //nuevo
cubierto_acumulado_actual = 0 //nuevo
cliente_ant = regs.object.venriesgoclienteshis_cliente[1]//nuevo

for i = 1 to total_registros
	
	cliente_act = regs.object.venriesgoclienteshis_cliente[i]
	f_pago = regs.object.carforpag_texto1[i]
	fecha1 = regs.object.venriesgoclienteshis_fecha[i]
		
	if i = total_registros then 
		setnull(fecha2) 
	elseif cliente_act <> regs.object.venriesgoclienteshis_cliente[i+1]	then
		setnull(fecha2)
	else
		fecha2 = regs.object.venriesgoclienteshis_fecha[i+1]
	end if
	
	
	riesgo_concedido = regs.object.venriesgoclienteshis_riesgo[i]
	riesgo = f_riesgo_cliente_entre_fechas(codigo_empresa, cliente_act, fecha1, fecha2)
	razon = regs.object.genter_razon[i]
	devuelto = f_fac_devuelto_entre_fechas (codigo_empresa, cliente_Act, fecha1, fecha2)
	total_riesgo = riesgo + devuelto
	fac_vencidas = f_fac_vencidas_entre_fechas (codigo_empresa, cliente_Act, fecha1, fecha2)

	if riesgo <> 0 or devuelto <> 0 or total_riesgo <> 0 or fac_vencidas <> 0 or cbx_historico.checked then	
		fila = dw_detalle.insertrow(0)

		dw_detalle.object.cliente[fila] = razon
		dw_detalle.object.f_pago[fila] = f_pago
		dw_detalle.object.fecha[fila] = fecha1
		dw_detalle.object.riesgo_concedido [fila] = riesgo_concedido
		dw_detalle.object.riesgo[fila] = riesgo 
		dw_detalle.object.devuelto[fila] = devuelto
		dw_detalle.object.total_riesgo[fila] = total_riesgo
		dw_detalle.object.pdte_cancelar[fila] = fac_vencidas
				
		if riesgo_concedido - total_riesgo >= 0 then
			riesgo_cubierto = total_riesgo
		else
			riesgo_cubierto = riesgo_concedido
		end if
		dw_detalle.object.riesgo_cubierto[fila] = riesgo_cubierto
		
//		select max(
		
		if cliente_ant = cliente_act then //nuevo
			cubierto_acumulado_actual = cubierto_acumulado_actual + riesgo_cubierto //nuevo
			dw_detalle.object.acumulado[fila] = cubierto_acumulado_Actual // nuevo			
			if fila = 1 then
				dw_detalle.object.acumulado_ant[fila] = 0
			else
				dw_detalle.object.acumulado_ant[fila] = dw_detalle.object.acumulado[fila - 1] // nuevo			
			end if
		else //nuevo
		 	cubierto_acumulado_actual =  riesgo_cubierto//nuevo
			dw_detalle.object.acumulado[fila] = cubierto_acumulado_Actual // nuevo			 
			dw_detalle.object.acumulado_ant[fila] = 0 // nuevo
			 
		end if //nuevo


	 	cliente_ant = cliente_Act //nuevo

	end if

	f_mensaje_proceso ('Registro:', i, total_registros)
next


dw_detalle.groupcalc()
dw_detalle.sort()



destroy regs

end event

type uo_cliente from u_em_campo_2 within w_con_situacion_riesgo_con_historico
event destroy ( )
integer x = 270
integer y = 112
integer width = 1934
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

type st_6 from statictext within w_con_situacion_riesgo_con_historico
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

type dw_desglose_riesgo from datawindow within w_con_situacion_riesgo_con_historico
boolean visible = false
integer x = 1001
integer y = 1184
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

type cbx_resumen from checkbox within w_con_situacion_riesgo_con_historico
integer x = 2478
integer y = 124
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumen"
borderstyle borderstyle = styleraised!
end type

event clicked;if cbx_resumen.checked then
	dw_detalle.Object.DataWindow.Detail.Height = '0'
else
	dw_detalle.Object.DataWindow.Detail.Height = '68'
end if


end event

type cbx_historico from checkbox within w_con_situacion_riesgo_con_historico
integer x = 2962
integer y = 124
integer width = 873
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Histórico de riesgo concedido"
borderstyle borderstyle = styleraised!
end type

event clicked;if cbx_resumen.checked then
	dw_detalle.Object.DataWindow.Detail.Height = '0'
else
	dw_detalle.Object.DataWindow.Detail.Height = '68'
end if


end event

