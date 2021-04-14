$PBExportHeader$w_cancelacion_anticipos_old.srw
$PBExportComments$cancelación de anticipos
forward
global type w_cancelacion_anticipos_old from w_int_con_empresa
end type
type gb_52 from groupbox within w_cancelacion_anticipos_old
end type
type gb_55 from groupbox within w_cancelacion_anticipos_old
end type
type gb_2 from groupbox within w_cancelacion_anticipos_old
end type
type gb_1 from groupbox within w_cancelacion_anticipos_old
end type
type gb_5 from groupbox within w_cancelacion_anticipos_old
end type
type gb_3 from groupbox within w_cancelacion_anticipos_old
end type
type pb_1 from upb_salir within w_cancelacion_anticipos_old
end type
type cb_consultar from commandbutton within w_cancelacion_anticipos_old
end type
type em_anyo from editmask within w_cancelacion_anticipos_old
end type
type st_8 from statictext within w_cancelacion_anticipos_old
end type
type em_vencimiento from u_em_campo within w_cancelacion_anticipos_old
end type
type em_plazo_real from u_em_campo within w_cancelacion_anticipos_old
end type
type st_9 from statictext within w_cancelacion_anticipos_old
end type
type em_anticipo from u_em_campo within w_cancelacion_anticipos_old
end type
type st_nombre_banco from statictext within w_cancelacion_anticipos_old
end type
type dw_3 from datawindow within w_cancelacion_anticipos_old
end type
type cb_procesar from commandbutton within w_cancelacion_anticipos_old
end type
type em_fcontable from editmask within w_cancelacion_anticipos_old
end type
type gb_4 from groupbox within w_cancelacion_anticipos_old
end type
type rb_1 from radiobutton within w_cancelacion_anticipos_old
end type
type rb_2 from radiobutton within w_cancelacion_anticipos_old
end type
type cb_cancelar from commandbutton within w_cancelacion_anticipos_old
end type
type st_1 from statictext within w_cancelacion_anticipos_old
end type
type st_2 from statictext within w_cancelacion_anticipos_old
end type
type st_boton_anticipo from statictext within w_cancelacion_anticipos_old
end type
type em_banco from u_em_campo within w_cancelacion_anticipos_old
end type
type dw_1 from datawindow within w_cancelacion_anticipos_old
end type
type st_nombre_moneda from statictext within w_cancelacion_anticipos_old
end type
type em_cambio from editmask within w_cancelacion_anticipos_old
end type
type st_3 from statictext within w_cancelacion_anticipos_old
end type
type em_divisas_cancelar from editmask within w_cancelacion_anticipos_old
end type
type em_importe_cancelar from editmask within w_cancelacion_anticipos_old
end type
type st_4 from statictext within w_cancelacion_anticipos_old
end type
type st_5 from statictext within w_cancelacion_anticipos_old
end type
type em_asiento from editmask within w_cancelacion_anticipos_old
end type
type st_33 from statictext within w_cancelacion_anticipos_old
end type
type st_6 from statictext within w_cancelacion_anticipos_old
end type
type st_7 from statictext within w_cancelacion_anticipos_old
end type
type st_10 from statictext within w_cancelacion_anticipos_old
end type
type rb_3 from radiobutton within w_cancelacion_anticipos_old
end type
type rb_4 from radiobutton within w_cancelacion_anticipos_old
end type
type st_55 from statictext within w_cancelacion_anticipos_old
end type
type em_pdte from editmask within w_cancelacion_anticipos_old
end type
end forward

global type w_cancelacion_anticipos_old from w_int_con_empresa
integer width = 2871
integer height = 1604
gb_52 gb_52
gb_55 gb_55
gb_2 gb_2
gb_1 gb_1
gb_5 gb_5
gb_3 gb_3
pb_1 pb_1
cb_consultar cb_consultar
em_anyo em_anyo
st_8 st_8
em_vencimiento em_vencimiento
em_plazo_real em_plazo_real
st_9 st_9
em_anticipo em_anticipo
st_nombre_banco st_nombre_banco
dw_3 dw_3
cb_procesar cb_procesar
em_fcontable em_fcontable
gb_4 gb_4
rb_1 rb_1
rb_2 rb_2
cb_cancelar cb_cancelar
st_1 st_1
st_2 st_2
st_boton_anticipo st_boton_anticipo
em_banco em_banco
dw_1 dw_1
st_nombre_moneda st_nombre_moneda
em_cambio em_cambio
st_3 st_3
em_divisas_cancelar em_divisas_cancelar
em_importe_cancelar em_importe_cancelar
st_4 st_4
st_5 st_5
em_asiento em_asiento
st_33 st_33
st_6 st_6
st_7 st_7
st_10 st_10
rb_3 rb_3
rb_4 rb_4
st_55 st_55
em_pdte em_pdte
end type
global w_cancelacion_anticipos_old w_cancelacion_anticipos_old

type variables
string filtro

editmask isle_campo 
integer var_ejercicio
string istr_factura

int istr_prorroga
string inst_mascara_moneda
integer inst_situacion

string int_moneda_anticipo
end variables

forward prototypes
public subroutine f_desactiva ()
public subroutine f_activa ()
public subroutine f_nueva_divisa ()
public function string f_mascara ()
public subroutine f_nuevo_importe ()
public subroutine f_desactivar_importes ()
public subroutine f_activar_importes ()
public function integer f_maxima_liquidacion (string par_empresa, integer par_anyo, string par_banco, integer par_contador, integer par_prorroga)
public function boolean f_dividir_efecto (integer arg_anyo, long arg_orden, string arg_historico, integer arg_linea, decimal arg_nuevo_importe, string arg_nueva_situacion)
end prototypes

public subroutine f_desactiva ();em_banco.enabled = false
em_anyo.enabled = false
em_anticipo.enabled = false
st_boton_anticipo.enabled = false
end subroutine

public subroutine f_activa ();em_banco.enabled = true
em_anyo.enabled = true
em_anticipo.enabled = true
st_boton_anticipo.enabled = true
end subroutine

public subroutine f_nueva_divisa ();dec divisas

divisas = dw_1.getitemnumber(1,"pdte_liquidar")

em_importe_cancelar.text = string(dec(em_divisas_cancelar.text) / dec(em_cambio.text))

em_pdte.text = string(divisas - dec(em_divisas_cancelar.text))







end subroutine

public function string f_mascara ();str_paramemp par
string m 

par = f_paramemp(codigo_empresa)

m = par.moneda_emp

return m
end function

public subroutine f_nuevo_importe ();em_cambio.text = string(dec(em_importe_cancelar.text) * dec(em_divisas_cancelar.text))
end subroutine

public subroutine f_desactivar_importes ();em_divisas_cancelar.enabled = false
em_importe_cancelar.enabled = false
em_cambio.enabled = false
end subroutine

public subroutine f_activar_importes ();em_divisas_cancelar.enabled = true
em_importe_cancelar.enabled = true
em_cambio.enabled = true
end subroutine

public function integer f_maxima_liquidacion (string par_empresa, integer par_anyo, string par_banco, integer par_contador, integer par_prorroga);int maxim

select max(liquidacion) into :maxim
from carfinanliq
where (carfinanliq.empresa = :par_empresa)		and
		(carfinanliq.anyo = :par_anyo)				and
		(carfinanliq.bancofinan = :par_banco)		and
		(carfinanliq.contador = :par_contador)		and
		(carfinanliq.num_prorroga = :par_prorroga);
if isnull(maxim) then maxim = 0

return maxim
end function

public function boolean f_dividir_efecto (integer arg_anyo, long arg_orden, string arg_historico, integer arg_linea, decimal arg_nuevo_importe, string arg_nueva_situacion);boolean bien = true

str_carefectos carefectos
str_carhistorico carhistorico

if arg_historico = "N" then
	SELECT carefectos.anyofra,	 			carefectos.factura, 				carefectos.recibo, 
			 carefectos.fvto, 				carefectos.ffra, 					carefectos.fcobro, 
			 carefectos.importe, 			carefectos.divisas, 				carefectos.monedas, 
			 carefectos.fpago, 				carefectos.tipodoc, 				carefectos.banco, 
			 carefectos.remesa, 				carefectos.fremesa, 				carefectos.situacion, 
			 carefectos.agente1, 			carefectos.pais, 					carefectos.cuenta, 
			 carefectos.domiciliacion, 	carefectos.Nacional, 			carefectos.observaciones,
			 carefectos.libre, 				carefectos.gasto, 				carefectos.fdevolucion, 
			 carefectos.agrupado, 			carefectos.efectoagrupa, 		carefectos.anyoagrupa, 
			 carefectos.cliente, 			carefectos.anyo_remesa, 		carefectos.comision11, 
			 carefectos.comision12, 		carefectos.agente2, 				carefectos.comision21, 
			 carefectos.comision22, 		carefectos.agente3, 				carefectos.comision31, 
			 carefectos.comision32, 		carefectos.cambio, 				carefectos.serie, 
			 carefectos.remesa_total, 		carefectos.tipo_remesa, 		carefectos.veces, 
			 carefectos.fechaimp, 			carefectos.recibir_dmto, 
			 carefectos.fecha_recibido, 	carefectos.punteado, 			carefectos.clase_efecto, 
			 carefectos.cambio_euros, 		carefectos.cambio_asegurado, 	carefectos.devuelto_notificado_agente,
			 carefectos.devuelto_notificado_agente2, 							carefectos.devuelto_notificado_agente3,
			 carefectos.banco_docu
	INTO   :carefectos.anyofra, 			:carefectos.factura, 			:carefectos.recibo,
			 :carefectos.fvto, 				:carefectos.ffra, 				:carefectos.fcobro, 
			 :carefectos.importe, 			:carefectos.divisas, 			:carefectos.monedas, 
			 :carefectos.fpago, 				:carefectos.tipodoc, 			:carefectos.banco, 
			 :carefectos.remesa, 			:carefectos.fremesa, 			:carefectos.situacion, 
			 :carefectos.agente1, 			:carefectos.pais, 				:carefectos.cuenta, 
			 :carefectos.domiciliacion, 	:carefectos.Nacional, 			:carefectos.observaciones, 
			 :carefectos.libre, 				:carefectos.gasto, 				:carefectos.fdevolucion, 
			 :carefectos.agrupado, 			:carefectos.efectoagrupa, 		:carefectos.anyoagrupa, 
			 :carefectos.cliente, 			:carefectos.anyo_remesa, 		:carefectos.comision11, 
			 :carefectos.comision12, 		:carefectos.agente2, 			:carefectos.comision21, 
			 :carefectos.comision22, 		:carefectos.agente3, 			:carefectos.comision31, 
			 :carefectos.comision32, 		:carefectos.cambio, 				:carefectos.serie, 
			 :carefectos.remesa_total, 	:carefectos.tipo_remesa, 		:carefectos.veces, 
			 :carefectos.fechaimp, 			:carefectos.recibir_dmto, 
			 :carefectos.fecha_recibido, 	:carefectos.punteado, 			:carefectos.clase_efecto, 
			 :carefectos.cambio_euros,	 	:carefectos.cambio_asegurado, :carefectos.devuelto_notificado_agente, 
			 :carefectos.devuelto_notificado_agente2, 						:carefectos.devuelto_notificado_agente3, 
			 :carefectos.banco_docu 
	FROM 	 carefectos
	WHERE  empresa = :codigo_empresa
	AND    anyo    = :arg_anyo
	AND    orden   = :arg_orden;
	
	if sqlca.sqlcode <> 0 then
		bien = false	
	end if
	
	UPDATE carefectos
	SET    importe = :arg_nuevo_importe,
			 divisas = :arg_nuevo_importe / cambio
	WHERE  empresa = :codigo_empresa
	AND    anyo    = :arg_anyo
	AND    orden   = :arg_orden;
	
	if sqlca.sqlcode <> 0 then
		bien = false	
	end if
	
	carefectos.empresa = codigo_empresa
	carefectos.anyo    = arg_anyo
	carefectos.orden   = f_orden_carparam(codigo_empresa,arg_anyo)
	carefectos.importe = carefectos.importe - arg_nuevo_importe
	carefectos.divisas = carefectos.importe / carefectos.cambio
	if trim(arg_nueva_situacion) <> "" then
		carefectos.situacion = arg_nueva_situacion
	end if
	if not(f_insert_carefectos(carefectos)) then
		bien = false
	end if
else
	//Efecto en el historico
	SELECT carhistorico.anyofra,	 			carhistorico.factura, 				carhistorico.recibo, 
			 carhistorico.fvto, 				carhistorico.ffra, 					carhistorico.fcobro, 
			 carhistorico.importe, 			carhistorico.divisas, 				carhistorico.monedas, 
			 carhistorico.fpago, 				carhistorico.tipodoc, 				carhistorico.banco, 
			 carhistorico.remesa, 				carhistorico.fremesa, 				carhistorico.situacion, 
			 carhistorico.agente1, 			carhistorico.pais, 					carhistorico.cuenta, 
			 carhistorico.domiciliacion, 	carhistorico.Nacional, 			carhistorico.observaciones,
			 carhistorico.libre, 				carhistorico.gasto, 				carhistorico.fdevolucion, 
			 carhistorico.agrupado, 			carhistorico.efectoagrupa, 		carhistorico.anyoagrupa, 
			 carhistorico.cliente, 			carhistorico.anyo_remesa, 		carhistorico.comision11, 
			 carhistorico.comision12, 		carhistorico.agente2, 				carhistorico.comision21, 
			 carhistorico.comision22, 		carhistorico.agente3, 				carhistorico.comision31, 
			 carhistorico.comision32, 		carhistorico.cambio, 				carhistorico.serie, 
			 carhistorico.desviacion, 		carhistorico.cambio_cobro, 		carhistorico.fecha_recibido, 
			 carhistorico.banco_docu
			 carhistorico.pago_a_cuenta
	INTO   :carhistorico.anyofra, 			:carhistorico.factura, 			:carhistorico.recibo,
			 :carhistorico.fvto, 				:carhistorico.ffra, 				:carhistorico.fcobro, 
			 :carhistorico.importe, 			:carhistorico.divisas, 			:carhistorico.monedas, 
			 :carhistorico.fpago, 				:carhistorico.tipodoc, 			:carhistorico.banco, 
			 :carhistorico.remesa, 			:carhistorico.fremesa, 			:carhistorico.situacion, 
			 :carhistorico.agente1, 			:carhistorico.pais, 				:carhistorico.cuenta, 
			 :carhistorico.domiciliacion, 	:carhistorico.Nacional, 			:carhistorico.observaciones, 
			 :carhistorico.libre, 				:carhistorico.gasto, 				:carhistorico.fdevolucion, 
			 :carhistorico.agrupado, 			:carhistorico.efectoagrupa, 		:carhistorico.anyoagrupa, 
			 :carhistorico.cliente, 			:carhistorico.anyo_remesa, 		:carhistorico.comision11, 
			 :carhistorico.comision12, 		:carhistorico.agente2, 			:carhistorico.comision21, 
			 :carhistorico.comision22, 		:carhistorico.agente3, 			:carhistorico.comision31, 
			 :carhistorico.comision32, 		:carhistorico.cambio, 				:carhistorico.serie, 
			 :carhistorico.desviacion, 	:carhistorico.cambio_cobro, 		:carhistorico.fecha_recibido, 
			 :carhistorico.banco_docu
	FROM 	 carhistorico
	WHERE  empresa = :codigo_empresa
	AND    anyo    = :arg_anyo
	AND    orden   = :arg_orden
	AND    linea   = :arg_linea;
	
	if sqlca.sqlcode <> 0 then
		bien = false	
	end if
	
	UPDATE carhistorico
	SET    importe = :arg_nuevo_importe,
			 divisas = :arg_nuevo_importe / cambio
	WHERE  empresa = :codigo_empresa
	AND    anyo    = :arg_anyo
	AND    orden   = :arg_orden
	AND    linea   = :arg_linea;
	
	if sqlca.sqlcode <> 0 then
		bien = false	
	end if
	
	carhistorico.empresa = codigo_empresa
	carhistorico.anyo    = arg_anyo
	carhistorico.orden   = f_orden_carparam(codigo_empresa,arg_anyo)
	carhistorico.linea   = 1
	carhistorico.importe = carhistorico.importe - arg_nuevo_importe
	carhistorico.divisas = carhistorico.importe / carhistorico.cambio
	
	if not(f_insert_carhistorico(carhistorico)) then
		bien = false
	end if
	
end if

return bien
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Cancelación de Anticipos"
This.title=istr_parametros.s_titulo_ventana



dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)

em_anyo.text = string(year(today()))

dw_3.visible = false

dw_1.enabled = false
// En istr_prorroga tenemos la prorroga del anticipo seleccionado
// Inicialmente -1

istr_prorroga = -1

em_fcontable.text = string(today())

rb_1.checked = true
rb_2.checked = false

rb_3.checked = true
rb_4.checked = false

f_desactivar_importes()
end event

on w_cancelacion_anticipos_old.create
int iCurrent
call super::create
this.gb_52=create gb_52
this.gb_55=create gb_55
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_5=create gb_5
this.gb_3=create gb_3
this.pb_1=create pb_1
this.cb_consultar=create cb_consultar
this.em_anyo=create em_anyo
this.st_8=create st_8
this.em_vencimiento=create em_vencimiento
this.em_plazo_real=create em_plazo_real
this.st_9=create st_9
this.em_anticipo=create em_anticipo
this.st_nombre_banco=create st_nombre_banco
this.dw_3=create dw_3
this.cb_procesar=create cb_procesar
this.em_fcontable=create em_fcontable
this.gb_4=create gb_4
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_cancelar=create cb_cancelar
this.st_1=create st_1
this.st_2=create st_2
this.st_boton_anticipo=create st_boton_anticipo
this.em_banco=create em_banco
this.dw_1=create dw_1
this.st_nombre_moneda=create st_nombre_moneda
this.em_cambio=create em_cambio
this.st_3=create st_3
this.em_divisas_cancelar=create em_divisas_cancelar
this.em_importe_cancelar=create em_importe_cancelar
this.st_4=create st_4
this.st_5=create st_5
this.em_asiento=create em_asiento
this.st_33=create st_33
this.st_6=create st_6
this.st_7=create st_7
this.st_10=create st_10
this.rb_3=create rb_3
this.rb_4=create rb_4
this.st_55=create st_55
this.em_pdte=create em_pdte
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_52
this.Control[iCurrent+2]=this.gb_55
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.cb_consultar
this.Control[iCurrent+9]=this.em_anyo
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.em_vencimiento
this.Control[iCurrent+12]=this.em_plazo_real
this.Control[iCurrent+13]=this.st_9
this.Control[iCurrent+14]=this.em_anticipo
this.Control[iCurrent+15]=this.st_nombre_banco
this.Control[iCurrent+16]=this.dw_3
this.Control[iCurrent+17]=this.cb_procesar
this.Control[iCurrent+18]=this.em_fcontable
this.Control[iCurrent+19]=this.gb_4
this.Control[iCurrent+20]=this.rb_1
this.Control[iCurrent+21]=this.rb_2
this.Control[iCurrent+22]=this.cb_cancelar
this.Control[iCurrent+23]=this.st_1
this.Control[iCurrent+24]=this.st_2
this.Control[iCurrent+25]=this.st_boton_anticipo
this.Control[iCurrent+26]=this.em_banco
this.Control[iCurrent+27]=this.dw_1
this.Control[iCurrent+28]=this.st_nombre_moneda
this.Control[iCurrent+29]=this.em_cambio
this.Control[iCurrent+30]=this.st_3
this.Control[iCurrent+31]=this.em_divisas_cancelar
this.Control[iCurrent+32]=this.em_importe_cancelar
this.Control[iCurrent+33]=this.st_4
this.Control[iCurrent+34]=this.st_5
this.Control[iCurrent+35]=this.em_asiento
this.Control[iCurrent+36]=this.st_33
this.Control[iCurrent+37]=this.st_6
this.Control[iCurrent+38]=this.st_7
this.Control[iCurrent+39]=this.st_10
this.Control[iCurrent+40]=this.rb_3
this.Control[iCurrent+41]=this.rb_4
this.Control[iCurrent+42]=this.st_55
this.Control[iCurrent+43]=this.em_pdte
end on

on w_cancelacion_anticipos_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_52)
destroy(this.gb_55)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.pb_1)
destroy(this.cb_consultar)
destroy(this.em_anyo)
destroy(this.st_8)
destroy(this.em_vencimiento)
destroy(this.em_plazo_real)
destroy(this.st_9)
destroy(this.em_anticipo)
destroy(this.st_nombre_banco)
destroy(this.dw_3)
destroy(this.cb_procesar)
destroy(this.em_fcontable)
destroy(this.gb_4)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_cancelar)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_boton_anticipo)
destroy(this.em_banco)
destroy(this.dw_1)
destroy(this.st_nombre_moneda)
destroy(this.em_cambio)
destroy(this.st_3)
destroy(this.em_divisas_cancelar)
destroy(this.em_importe_cancelar)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.em_asiento)
destroy(this.st_33)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_10)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.st_55)
destroy(this.em_pdte)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cancelacion_anticipos_old
integer x = 2112
integer y = 20
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cancelacion_anticipos_old
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cancelacion_anticipos_old
integer width = 2427
integer height = 96
end type

type gb_52 from groupbox within w_cancelacion_anticipos_old
integer x = 910
integer y = 1044
integer width = 302
integer height = 332
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_55 from groupbox within w_cancelacion_anticipos_old
integer x = 2304
integer y = 1044
integer width = 347
integer height = 332
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_cancelacion_anticipos_old
integer x = 1920
integer y = 1044
integer width = 379
integer height = 332
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_cancelacion_anticipos_old
integer x = 1527
integer y = 1044
integer width = 389
integer height = 332
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_5 from groupbox within w_cancelacion_anticipos_old
integer x = 1216
integer y = 1044
integer width = 311
integer height = 332
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_cancelacion_anticipos_old
integer x = 896
integer y = 984
integer width = 1774
integer height = 448
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_1 from upb_salir within w_cancelacion_anticipos_old
integer x = 2688
integer y = 16
integer width = 142
integer height = 116
integer taborder = 0
end type

type cb_consultar from commandbutton within w_cancelacion_anticipos_old
integer x = 2331
integer y = 200
integer width = 325
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Consultar"
end type

event clicked;// ***********************************************************************
// CONTROL DE DATOS
// ************************************************************************



// Anticipo y banco
IF em_anticipo.text = "" or em_banco.text = "" then
	messagebox("Atención","Debe introducir los datos de BANCO y ANTICIPO")
	RETURN	
end if



// Comprobamos la situación del anticipo por si se ha introducido
// directamente sobre el campo "em_anticipo".
// La situación ha de ser 2, 3 ó 4
int la_situacion,el_anyo,el_anticipo
el_anyo = integer(em_anyo.text)
el_anticipo = integer(em_anticipo.text)

select situacion into :la_situacion
from carfinan
where (carfinan.empresa = :codigo_empresa)	and
		(carfinan.anyo = :el_anyo)					and
		(carfinan.bancofinan = :em_banco.text)	and
		(carfinan.contador = :el_anticipo)		and
		(carfinan.num_prorroga = :istr_prorroga);


f_activar_importes()


int opcion  
choose case la_situacion

	// Anticipos ya liqidados. Se puede hacer una nueva liquidación
	case 4
		opcion = messagebox("Atención","El anticipo ha sido liquidado, ¿ Desea hacer una nueva liquidación ?",question!,yesno!,2)
		if opcion = 2 then
			em_anticipo.text = ""
			em_anticipo.setfocus()
			dw_1.reset()
			em_cambio.text = ""
			st_nombre_moneda.text = ""
			f_activa()
			em_anticipo.setfocus()
			return
		
		else
			//f_desactivar_importes()
			rb_1.checked = true
			rb_2.checked = false
			rb_1.enabled = TRUE
			rb_2.enabled = TRUE
			
		end if


	// Anticipo abonado con o sin gastos
	case 2,3
	
	// Resto de situacones. No válidas
	case else
		em_anticipo.text = ""
		em_anticipo.setfocus()
		return

end choose

// Variable instancia para la situación

inst_situacion = la_situacion





//  MOSTRAMOS DATOS DEL ANTICIPO (ULTIMA PRORROGA)
dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_anticipo.text),istr_prorroga)

// Por defecto el cambio es el del abono
string la_moneda
dec el_cambio,div,imp,pdte

select cambio_abono,moneda_abono,divisa_abono,importe_abono,pdte_liquidar
into :el_cambio, :la_moneda,:div, :imp, :pdte
from carfinan
where (carfinan.empresa = :codigo_empresa)	and
		(carfinan.anyo = :el_anyo)					and
		(carfinan.bancofinan = :em_banco.text)	and
		(carfinan.contador = :el_anticipo)		and
		(carfinan.num_prorroga = :istr_prorroga);

em_cambio.text = string(el_cambio)
st_nombre_moneda.text = f_nombre_moneda_abr(la_moneda)
em_divisas_cancelar.text = string(pdte)
em_importe_cancelar.text = string(pdte * el_cambio)
em_pdte.text = "0"


int_moneda_anticipo = la_moneda


em_asiento.text = ""



end event

type em_anyo from editmask within w_cancelacion_anticipos_old
integer x = 1330
integer y = 188
integer width = 219
integer height = 88
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
string displaydata = "x"
end type

type st_8 from statictext within w_cancelacion_anticipos_old
integer x = 2958
integer y = 324
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Vencimiento :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_vencimiento from u_em_campo within w_cancelacion_anticipos_old
integer x = 3378
integer y = 332
integer width = 270
integer taborder = 0
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = ""
end type

type em_plazo_real from u_em_campo within w_cancelacion_anticipos_old
integer x = 3442
integer y = 424
integer width = 206
integer taborder = 0
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "##0"
string displaydata = "0"
end type

type st_9 from statictext within w_cancelacion_anticipos_old
integer x = 2935
integer y = 424
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Plazo Real :"
boolean focusrectangle = false
end type

type em_anticipo from u_em_campo within w_cancelacion_anticipos_old
integer x = 1687
integer y = 192
integer width = 261
integer taborder = 20
long backcolor = 16777215
alignment alignment = right!
boolean displayonly = true
end type

event modified;call super::modified;dw_1.reset()



end event

type st_nombre_banco from statictext within w_cancelacion_anticipos_old
integer x = 366
integer y = 196
integer width = 914
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_cancelacion_anticipos_old
boolean visible = false
integer x = 101
integer y = 300
integer width = 2638
integer height = 584
integer taborder = 130
boolean bringtotop = true
string dataobject = "dw_ayuda_carfinan_cancelacion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)
		
	case "contador","num_prorroga","nom_serie","factura","divisasfinan","nom_cliente","nom_moneda"
		em_anticipo.text = string(dw_3.getitemnumber(row,"contador"))
		istr_prorroga = dw_3.getitemnumber(row,"prorroga_activa")		
		
		dw_3.visible = false
		dw_1.reset()		
		f_desactiva()
		
		setfocus(cb_consultar)
		cb_consultar.triggerevent("clicked")	

end choose


end event

type cb_procesar from commandbutton within w_cancelacion_anticipos_old
integer x = 1957
integer y = 1140
integer width = 302
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;//***********************************************************************
// Control de datos
//***********************************************************************
string ls_sel
long   ll_total,ll_indice,ll_anyo_efecto,ll_orden_efecto
int dec_moneda
INT la_liquidacion,bien	
	
datastore ds_efectos

dec_moneda = f_decimales_moneda(int_moneda_anticipo)

// Banco y anticipo
if em_anticipo.text = "" or em_banco.text = "" then
	f_mensaje("Atención","Debe introducir el Banco y el Nº de Anticipo")
	return
end if

// datos del anticipo
if dw_1.rowcount()= 0 then
	
	f_mensaje("Atención","No hay datos sobre el anticipo")
	return
end if

// fecha contable
if not isdate(em_fcontable.text) then 	
	f_mensaje("Atención","Introduzca la fecha para el asiento contable")
	return
end if

// Control de la cantidad introducida
int op
if em_importe_cancelar.text = "" or dec(em_importe_cancelar.text) = 0 then
	op = messagebox("Atención","La cantidad a liquidar es 0. ¿ Desea Continuar ?", &
					question!,yesno!,2)
	if op = 2 then return
end if

// Control de la cantidad pdte de liquidar
dec pdte
pdte = round(dw_1.getitemnumber(1,"pdte_liquidar"),dec_moneda)
if isnull(pdte) then
	messagebox("No se puede continuar","No se pudo leer la cantidad pendiente de liquidar ")
	return
end if

// Control de la cantidad introducida > que la cantidad pdte de liquidar  
if dec(em_divisas_cancelar.text) > pdte then
	messagebox("No se puede continuar","La cantidad a liquidar (" +string(dec(em_divisas_cancelar.text)) +&
	" ) "+"mayor que la cantidad pendiente ( "+string(pdte) +" )")
	return
end if



// Control si es la última liquidación
if rb_3.checked  then
	if dec(em_pdte.text) <> 0 then
		op = messagebox("Atención","Es la última liquidación y hay pendiente de liquidar. ¿ Desea Continuar ?",question!,yesno!,2)
		if op = 2 then return
	end if
end if


// Control de la cantidad introducida y es la última liquidación

if (em_pdte.text = "" or dec(em_pdte.text) = 0)  and ( not rb_3.checked ) then
	op = messagebox("Atención","La cantidad Pendiente de liquidar es 0 y no se ha marcado última liquidación.¿ Desea Continuar ?", &
					question!,yesno!,2)
	if op = 2 then return
end if


// **********************************************************************
// EJERCICIO A PARTIR DE LA FECHA DEL APUNTE
// **********************************************************************

integer ejer_act

ejer_act = year(date(em_fcontable.text))


//*************************************************************************
// cancelar el anticipo
//*************************************************************************

BOOLEAN correcto,con_gastos
int opci

opci = messagebox("Atención", "¿Desea cancelar el anticipo?",question!,yesno!,1)

if opci = 1 then
		
	// *********************************************************************
	// 	VARIABLE con_gastos. GASTOS AL ABONAR O NO 
	// *********************************************************************
	
	IF rb_1.checked then 
		con_gastos = true
	else
		con_gastos = false
	end if
	
	
	
	
	// ******************************************************************
	// CAMBIAR LA SITUACIÓN DEL ANTICIPO
	// ********************************************************************
	
	
	// Si es la última liquidación situación 5 si no 4 
		
	int situ,anticipo_int,anyo_int,nueva_situacion
	dec pdte_liquidar
	
	
	anticipo_int = integer(em_anticipo.text)
	anyo_int = integer(em_anyo.text)
	
	if rb_3.checked = true then
		nueva_situacion = 5
	else
		nueva_situacion = 4
	end if
	
	pdte_liquidar = dec(em_pdte.text)
	
	// Actualizamos la situación y lo que queda por liquidar
	UPDATE carfinan
	set situacion 		= :nueva_situacion,
		 pdte_liquidar = :pdte_liquidar	
	where (empresa = :codigo_empresa)		and
			(bancofinan = :em_banco.text)		and
			(contador = :anticipo_int)			and
			(num_prorroga = :istr_prorroga)	and
			(anyo = :anyo_int);
	
	if rb_3.checked or pdte_liquidar > 0 then			
		//ULTIMA LIQUIDACION CAMBIAMOS LA SITUACION DE LOS EFECTOS DE LA 8 A LA 0	
		//CURSOR PARA CARGAR LOS EFECTOS DE CARFINANEFE
		ls_sel = "select carfinanefe.ejercicio, "+&
					"       carfinanefe.orden "+&
					"from   carfinanefe "+&
					"where  carfinanefe.empresa    = '"+codigo_empresa+"' "+&
					"and    carfinanefe.bancofinan = '"+em_banco.text+"' "+&
					"and    carfinanefe.anyo       = "+string(anyo_int,"###0")+" "+&
					"and    carfinanefe.contador   = "+string(anticipo_int,"###0")+" "
					
		ll_total = f_cargar_cursor_transaccion(sqlca,ds_efectos,ls_sel)
		dec ld_divisas_efecto,ld_pdte_liquidar
		ld_pdte_liquidar = pdte_liquidar
		for ll_indice = 1 to ll_total
			ll_anyo_efecto  = ds_efectos.object.ejercicio[ll_indice]
			ll_orden_efecto = ds_efectos.object.orden[ll_indice]
			//Vamos poniendo los efectos en cartera, excepto los que sumen en importe pendiente de liquidar
			if ld_pdte_liquidar > 0 then	
				select isnull(divisas,0)
				into   :ld_divisas_efecto
				from  carefectos
				where carefectos.empresa 	=  :codigo_empresa
				and	carefectos.anyo		=	:ll_anyo_efecto
				and	carefectos.orden		=	:ll_orden_efecto
				and   carefectos.situacion = "8";			
				
				if ld_divisas_efecto > ld_pdte_liquidar then
					if not f_dividir_efecto(ll_anyo_efecto,ll_orden_efecto,"N",0,ld_pdte_liquidar,"0") then
						bien = 1
					end if					
					ld_pdte_liquidar = 0
				else
					ld_pdte_liquidar = ld_pdte_liquidar - ld_divisas_efecto
				end if
			else
				UPDATE carefectos
				set   situacion = "0", 
						banco     =  ""
				where carefectos.empresa 	=  :codigo_empresa
				and	carefectos.anyo		=	:ll_anyo_efecto
				and	carefectos.orden		=	:ll_orden_efecto
				and   carefectos.situacion = "8";		
			end if
		next
		
		destroy ds_efectos		
	end if
	// DATOS DEL ANTICIPO
	
	dec divisas,abonado,el_cambio_abono
	datetime el_vencimiento,la_fecha_abono
	
	select importe_abono,vencimiento, fecha_abono,divisasfinan,cambio_abono 
	into :abonado, :el_vencimiento, :la_fecha_abono, :divisas,:el_cambio_abono 
	from carfinan
	where (carfinan.empresa = :codigo_empresa)	and
			(carfinan.anyo = :anyo_int)				and
			(carfinan.bancofinan = :em_banco.text)	and
			(carfinan.contador = :anticipo_int)		and
			(carfinan.num_prorroga = :istr_prorroga);
	
	// *******************************************************************
	// 	CAMBIO
	// *******************************************************************+
	
	


	// ********************************************************************
	// INSERTAR LIQUIDACIÓN
	// *******************************************************************

	// estructura para insertar la liquidación 
	STR_CARFINANLIQ liquidacion
	
	la_liquidacion = f_maxima_liquidacion( & 
					codigo_empresa,anyo_int,em_banco.text,anticipo_int,istr_prorroga) + 1
	
	bien = 0
	
	
	
	liquidacion.empresa = codigo_empresa
	liquidacion.anyo = anyo_int
	liquidacion.bancofinan = em_banco.text
	liquidacion.contador = anticipo_int
	liquidacion.num_prorroga = istr_prorroga
	
	
	liquidacion.liquidacion = la_liquidacion 
	liquidacion.banco = em_banco.text
	liquidacion.fecha = datetime(date(em_fcontable.text))
	
	
	liquidacion.cambio = dec(em_cambio.text)  
	liquidacion.divisas = dec(em_divisas_cancelar.text)
	liquidacion.importe = dec(em_importe_cancelar.text)
	
	
	liquidacion.moneda = dw_1.getitemstring(1,"moneda")
		
	if not f_insert_carfinanliq(liquidacion) then bien = 1

		
	
	
	
	// *********************************************************************
	//		OBTENEMOS LOS DATOS DE GASTOS EN OTRA PANTALLA	
	// *********************************************************************

	IF con_gastos 	then
	
		// Estructura para el pase de parámetros
		str_input_gastos_anticipos datos,datos_salida
		
		datos.banco 		= em_banco.text
		datos.anyo 			= integer(em_anyo.text)
		datos.contador 	= integer(em_anticipo.text)
		datos.prorroga 	= istr_prorroga
		// Pasamos la cantidad a cancelar del anticipo 
		datos.importe		= dec(em_importe_cancelar.text)
		// El tipo de documento es el anticipo (CÓDIGO 13)
		datos.tipodoc = "13"
		// Sólo anticipos de extranjero
		datos.naci_extra = "E"
		// Es una liquidación
		datos.abono_liq_teo = "L"
		// La fecha de liquidación la fecha contable
		datos.fecha_liquidacion = datetime(date(em_fcontable.text))
		// el nº de liquidación
		datos.num_liquidacion = la_liquidacion 
		// la situación
		datos.situacion = inst_situacion
		
		
		datos.vencimiento = el_vencimiento
		datos.fecha_abono = la_fecha_abono
		
		// Pantalla para obtener los gastos			
		openwithparm(w_input_gastos_anticipos,datos)
		
		datos_salida = Message.powerobjectparm 
		
		IF datos_salida.correcto = false THEN 
			messagebox("¡ Atención !","No se ha cancelado el anticipo")
			rollback;
			RETURN
		END IF	
		
	end if	

	setpointer(hourglass!)


	// *********************************************************************
	// ASIENTO CONTABLE
	// *********************************************************************

	str_contaapun apu  
	
	dec{2} el_saldo,total_saldo
	string la_cuenta,el_banco
	int error_num, num_apunte,i
	boolean res 		
	datetime f_contable 
	
	f_contable = datetime(date(em_fcontable.text))
	el_banco 	= Trim(em_banco.text)
	
	
	// Datos comunes a todos los apuntes
	
	num_apunte		=	0	// inicialmente 0, se incrementa con cada apunte
	apu.ejercicio 	=	ejer_act
	apu.empresa 	=	codigo_empresa
	apu.origen		=	f_diario_contagene(codigo_empresa,"28")	
	apu.asiento		=	f_ultimo_asiento(ejer_act,codigo_empresa,month(date(f_contable)),apu.origen)
	apu.fapunte		=	f_contable
		
	setnull(apu.diario)
	Setnull(apu.tipoapu)
	setnull(apu.documento)
	setnull(apu.factura)
	setnull(apu.ffactura)
	setnull(apu.imponible)
	setnull(apu.tipoiva)
	setnull(apu.iva)
	setnull(apu.divisas)
	setnull(apu.deducible)
	setnull(apu.actualizado)
	setnull(apu.listado)
	setnull(apu.registro)
	
	setnull(apu.tipoter)
	setnull(apu.clipro)
	setnull(apu.conciliado)
	setnull(apu.nif)
	setnull(apu.punteado)
	// la fvalor es la fapunte
	apu.fvalor	= apu.fapunte
	setnull(apu.docpunteo)
	setnull(apu.coste)
	setnull(apu.fregistro)
	
	apu.cambio	=	1
	apu.moneda	=	f_moneda_empresa(codigo_empresa)
	apu.mes		=	month(date(f_contable))


	
	// ******************************************************************
	// APUNTE AL BANCO
	// ******************************************************************
	
	
	//*******************************************************
	// 1. Apunte al banco
	// Hacemos un apunte por el importe y otro por los gastos
	//********************************************************
	
	// Apunte por importe del anticipo
	// Sólo si no ha sido liquidado y se están añadiendo nuevos gastos
	
	
	apu.cuenta 		= f_cuenta_carbancos(codigo_empresa,em_banco.text)
	
	apu.concepto	= f_concepto_contagene(codigo_empresa,"28")	
	apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"28")+ " " + em_anticipo.text +" " + & 
						string(date(dw_1.getitemdatetime(1,"fecha_abono")))+ " " + &
						f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))
	apu.documento 	= dw_1.getitemstring(1,"factura")
	apu.origen		= f_diario_contagene(codigo_empresa,"28")
	apu.ffactura	= la_fecha_abono
	
	IF f_dh_contagene(codigo_empresa,"28")= "D" THEN
		// Si se ha seleccionado abono con gastos
		IF con_gastos THEN
			apu.debe		=	round(datos_salida.importe_salida, 2)
			apu.haber	=	0
		ELSE
			apu.debe		=	round(dec(em_importe_cancelar.text), 2)
			apu.haber	=	0
		END IF 
	ELSE
		IF con_gastos THEN
			apu.debe		=	0
			apu.haber	=	round(datos_salida.importe_salida, 2)
		ELSE
			apu.debe 	=	0
			apu.haber	=	round(dec(em_importe_cancelar.text), 2)
		END IF
	END IF	
	
	num_apunte		=	num_apunte +1
	apu.apunte		=	num_apunte	
	apu.orden_apunte	=	num_apunte
	
	// Sólo si el importe a liquidar > 0
	if apu.debe <> 0 or apu.haber <> 0 then
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			error_num = 1
		END IF
	end if
	
	
	
	// Apunte al banco por los gastos
	
	// Si se ha hecho el apunte al banco ya descontando los gastos
	// no se hace aquí
	boolean ya_descontado
	ya_descontado = false
	
	if datos_salida.importe_salida <> dec(em_importe_cancelar.text) then
		ya_descontado = true	
	end if
	
	
	IF con_gastos and datos_salida.total_gastos <> 0 and not ya_descontado THEN
		
		apu.cuenta 		=	f_cuenta_carbancos(codigo_empresa,em_banco.text)
		apu.concepto	=	f_concepto_contagene(codigo_empresa,"23")	
		apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"28")+ " " + em_anticipo.text + " " +& 
							string(date(dw_1.getitemdatetime(1,"fecha_abono")))+ " " + &
							f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))
		apu.documento 	= dw_1.getitemstring(1,"factura")
		apu.origen		=	f_diario_contagene(codigo_empresa,"23")	
		apu.ffactura	= la_fecha_abono
		
		IF f_dh_contagene(codigo_empresa,"23")= "D" THEN
			// Pueden ser gastos positivos o negativos
			if datos_salida.total_gastos > 0 then
				apu.debe		=	round(datos_salida.total_gastos, 2)
				apu.haber	=	0
			else
				apu.debe		=	0
				apu.haber	=	round(ABS(datos_salida.total_gastos), 2)
			end if
		ELSE
			
			if datos_salida.total_gastos > 0 then
				apu.debe		=	0
				apu.haber	=	round(datos_salida.total_gastos, 2)
			else
				apu.debe		=	round(abs(datos_salida.total_gastos), 2)
				apu.haber	=	0
			end if
			
		END IF	
		
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte=	num_apunte
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			error_num = 2
		END IF
	
	
	END IF
	

	
	// *******************************************************************+
	// 2. APUNTE AL RIESGO DEL BANCO
	//	*******************************************************************+
					
	// obtenemos la cuenta de riesgo componiendola
	// con la que se obtiene de la tabla contagene
	// y el código del banco
	//if inst_situacion <> 4 then
	
		string cta_gene
		cta_gene			=	f_cuenta_contagene(codigo_empresa,"24")
		apu.cuenta		=  f_cuenta_riesgo_exportacion_banco(codigo_empresa,em_banco.text)//f_comp_cta_riesgo(cta_gene,em_banco.text)
			
		apu.concepto	=	f_concepto_contagene(codigo_empresa,"24")	
		apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"28")+ " " + em_anticipo.text + " " +& 
							string(date(dw_1.getitemdatetime(1,"fecha_abono")))+ " " + &
							f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))
		apu.documento 	= dw_1.getitemstring(1,"factura")
		
		
						
		apu.ffactura	=  la_fecha_abono
		apu.origen		=	f_diario_contagene(codigo_empresa,"24")	
				
		
		
		IF f_dh_contagene(codigo_empresa,"24")= "D" THEN
			apu.haber =	round(dec(em_importe_cancelar.text), 2)
			apu.debe  =	0
		ELSE
			apu.haber =	0
			apu.debe  =	round(dec(em_importe_cancelar.text), 2)
		END IF	
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
		
		
		// Sólo si hay cantidad a liquidar
		if apu.debe <> 0 or apu.haber <> 0 then			
			res = f_insert_contaapun(apu) 
			IF res = false THEN
				error_num = 3
			END IF						
		end if	
		

	
	
	// ******************************************************************
	// 3.APUNTE POR LOS GASTOS
	// ******************************************************************
	
	
	// APUNTE POR LOS INTERESES
	
	// Si los intereses son positivos
	if con_gastos and datos_salida.intereses > 0 then
				
		
		apu.cuenta 		=	datos_salida.cta_intereses
		apu.concepto	=	f_concepto_contagene(codigo_empresa,"25")	
		apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"28")+ " " + em_anticipo.text + " " +& 
							string(date(dw_1.getitemdatetime(1,"fecha_abono")))+ " " + &
							f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))
		apu.documento 	= dw_1.getitemstring(1,"factura")
		
		apu.origen		=	f_diario_contagene(codigo_empresa,"25")	
		apu.ffactura	= la_fecha_abono		
		IF f_dh_contagene(codigo_empresa,"25")= "D" THEN
			apu.debe		=	round(datos_salida.intereses, 2)
			apu.haber	=	0
		ELSE
			apu.debe		=	0
			apu.haber	=	round(datos_salida.intereses, 2)
		END IF	
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			error_num = 4
		END IF
		// Comprobamos si tiene analitica
		IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
			str_costesapu	coste
			IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
				coste.coste		  = f_coste_contagene(codigo_empresa,"25")
				coste.empresa    = codigo_empresa
				coste.ejercicio  = int(ejer_act)
				coste.origen     = apu.origen
				coste.fapunte    = apu.fapunte
				coste.mes        = apu.mes
				coste.asiento    = apu.asiento
				coste.apunte     = apu.apunte
				coste.debe		  = apu.debe
				coste.haber		  = apu.haber
				coste.concepto   = apu.concepto
				coste.ampliacion = apu.ampliacion
				coste.cuenta     = apu.cuenta
				res = f_insert_costesapu(coste)
				IF res = false THEN
					error_num = 5
				END IF
			END IF
		END IF
	
		
		
	end if


	// Si los intereses son negativos
	if con_gastos and datos_salida.intereses < 0 then


		cta_gene			=	f_cuenta_contagene(codigo_empresa,"25")
		apu.cuenta		=  f_cuenta_riesgo_exportacion_banco(codigo_empresa,em_banco.text)//f_comp_cta_riesgo(cta_gene,em_banco.text)
				
		apu.concepto	= f_concepto_contagene(codigo_empresa,"25")
		apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"28")+ " " + em_anticipo.text + " " +& 
							string(date(dw_1.getitemdatetime(1,"fecha_abono")))+ " " + &
							f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))
		apu.documento 	= dw_1.getitemstring(1,"factura")
		
		apu.origen		=	f_diario_contagene(codigo_empresa,"25")	
		apu.ffactura	= la_fecha_abono		
		IF f_dh_contagene(codigo_empresa,"25")= "D" THEN
			apu.debe		=	round(ABS(datos_salida.intereses), 2)
			apu.haber	=	0
		ELSE
			apu.debe		=	0
			apu.haber	=	round(ABS(datos_salida.intereses), 2)
		END IF	
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			error_num = 4
		END IF
		// Comprobamos si tiene analitica
		IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
			
			IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
				coste.coste		  = f_coste_contagene(codigo_empresa,"25")
				coste.empresa    = codigo_empresa
				coste.ejercicio  = int(ejer_act)
				coste.origen     = apu.origen
				coste.fapunte    = apu.fapunte
				coste.mes        = apu.mes
				coste.asiento    = apu.asiento
				coste.apunte     = apu.apunte
				coste.debe		  = apu.debe
				coste.haber		  = apu.haber
				coste.concepto   = apu.concepto
				coste.ampliacion = apu.ampliacion
				coste.cuenta     = apu.cuenta
				res = f_insert_costesapu(coste)
				IF res = false THEN
					error_num = 5
				END IF
			END IF
		END IF
	
		
		
	end if

	
	
	
	
	
	
	// APUNTES POR LOS GASTOS
	
	if con_gastos and datos_salida.num_gastos > 0 THEN
	
		// para cada uno de los gastos devueltos en pantalla auxiliar		
		fOR i= 1 to datos_salida.num_gastos
			
			// Sólo si hay gasto
			IF datos_salida.gastos[i] > 0 THEN
				apu.cuenta 		=	datos_salida.cuentas[i]
				apu.concepto	=	f_concepto_contagene(codigo_empresa,"25")	
				apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"28")+ " " + em_anticipo.text + " "+& 
							string(date(dw_1.getitemdatetime(1,"fecha_abono")))+ " " + &
							f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))
				apu.documento 	= dw_1.getitemstring(1,"factura")
				apu.origen		=	f_diario_contagene(codigo_empresa,"25")	
			
				apu.ffactura	= la_fecha_abono
				IF f_dh_contagene(codigo_empresa,"25")= "D" THEN
					apu.debe		=	round(datos_salida.gastos[i], 2)
					apu.haber	=	0
				ELSE
					apu.debe		=	0
					apu.haber	=	round(datos_salida.gastos[i], 2)
				END IF	
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				IF res = false THEN
					error_num = 6
				END IF
				// Comprobamos si tiene analitica
				IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
					IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
						coste.coste		  = f_coste_contagene(codigo_empresa,"25")
						coste.empresa    = codigo_empresa
						coste.ejercicio  = int(ejer_act)
						coste.origen     = apu.origen
						coste.fapunte    = apu.fapunte
						coste.mes        = apu.mes
						coste.asiento    = apu.asiento
						coste.apunte     = apu.apunte
						coste.debe		  = apu.debe
						coste.haber		  = apu.haber
						coste.concepto   = apu.concepto
						coste.ampliacion = apu.ampliacion
						coste.cuenta     = apu.cuenta
						res = f_insert_costesapu(coste)
						IF res = false THEN
							error_num = 7
						END IF
					END IF
				END IF
				
				
			END IF
		
		next

		
		
	end if 
	
	
	// ********************************************************************
	// CARTERA DE PAGOS
	// **********************************************************************
	 
	// En el programa "abono de anticipos" se insertaron tantos efectos en
	// cartera de pagos como efectos se anticiparon, ahora en la 
	// cancelación se ponen a situación de pagado 
	
	// Sólo la primera cancelación
	

	datastore d
	string sel
	long r,t
	dec orden_carpagos,anyo_dec
		

	if inst_situacion <> 4 then 	

		anyo_dec = dec(em_anyo.text)
		
		// Buscamos los nº de efecto de la cartera de pagos  
//		sel = " select empresa,anyo,orden_carpagos from carfinanefe " + &
//				" where carfinanefe.empresa = '"+codigo_empresa +"'" + &
//				" and carfinanefe.anyo = " + string(anyo_dec) + &
//				" and carfinanefe.bancofinan = '"+em_banco.text +"'" +&
//				" and carfinanefe.contador = "+ string(em_anticipo.text)
//
//				
//		d = f_cargar_cursor(sel)
//		r = d.rowcount()
		
// Esto sólo se hace en IKON		
		
//		// Actualizamos la situación y la forma de pago  
//		for t = 1 to r 
//			orden_carpagos = d.getitemnumber(t,"orden_carpagos")
//			
//			update carpagos
//			set situacion = "2", fpago = :f_contable
//			where (carpagos.empresa = :codigo_empresa) 	and
//					(carpagos.anyo = :anyo_dec) 				and
//					(carpagos.orden = :orden_carpagos);
//
//		next
	
	end if
	
	
	
	
	//********************************************************************
	//  CONTROL DE ERRORES
	// *******************************************************************
	
	if error_num = 0 then
		f_mensaje("BIEN","Se ha cancelado el anticipo")	
		
		f_activa()
		dw_1.reset()
		if apu.apunte > 0 then
			em_asiento.text = string(apu.asiento)
		end if
		
		em_anticipo.text = ""
		em_anticipo.setfocus()
		em_cambio.text = ""
		st_nombre_moneda.text = ""
		em_importe_cancelar.text = ""
		em_cambio.text = ""
		em_divisas_cancelar.text = ""
		f_desactivar_importes()
		
		commit;
		//return
		IF messagebox("Conexion con el asiento","¿Desea ver el asiento?",Question!,YesNo!,1) = 1 Then
			str_parametros zstr_param
			zstr_param.i_nargumentos=5
			zstr_param.s_argumentos[2] = String(Year(Date(apu.fapunte)),"####")			
			zstr_param.s_argumentos[3] = apu.origen			
			zstr_param.s_argumentos[4] = string(date(apu.fapunte))
			zstr_param.s_argumentos[5] = string(apu.asiento)
			OpenSheetWithParm(w_int_contaapun,zstr_param,GetParent(This),3,Original!) 
		end if
	else
		
		string texto_error
		em_asiento.text = ""
		choose case error_num
				
			case 1	
				texto_error = "apunte al banco"
			case 2
				texto_error = "apunte al banco por gastos"
			case 3	
				texto_error = "apunte riesgo banco"
			case 4	
				texto_error = "apunte intereses"
			case 5	
				texto_error = "apunte contabilidad analítica, intereses"
			case 6	
				texto_error = "apunte por los gastos"
			case 7	
				texto_error = "apunte contabilidad analítica, gastos"
			case 8	
				texto_error = "apunte por la diferencia de cambio"
				
		end choose 
		
		f_mensaje("ATENCIÓN","No se ha grabado el anticipo, error nº "+ string(error_num) + ", "+ texto_error )
		rollback;
		RETURN
	END IF
	
end if

setpointer(arrow!)
end event

type em_fcontable from editmask within w_cancelacion_anticipos_old
integer x = 1563
integer y = 1236
integer width = 320
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_4 from groupbox within w_cancelacion_anticipos_old
integer x = 73
integer y = 984
integer width = 823
integer height = 448
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cancelación"
end type

type rb_1 from radiobutton within w_cancelacion_anticipos_old
integer x = 946
integer y = 1196
integer width = 215
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sí"
end type

type rb_2 from radiobutton within w_cancelacion_anticipos_old
integer x = 946
integer y = 1264
integer width = 215
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "No"
boolean checked = true
end type

type cb_cancelar from commandbutton within w_cancelacion_anticipos_old
integer x = 1957
integer y = 1256
integer width = 302
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;f_activa()
dw_1.reset()
dw_3.visible = false

em_anticipo.text = ""
em_anticipo.setfocus()
em_importe_cancelar.text = ""
em_cambio.text = ""
em_divisas_cancelar.text = ""
st_nombre_moneda.text = ""
f_desactivar_importes()

rb_1.enabled = true
rb_2.enabled = true


em_asiento.text = ""
end event

type st_1 from statictext within w_cancelacion_anticipos_old
integer x = 110
integer y = 116
integer width = 1175
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
boolean enabled = false
string text = "Banco"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_cancelacion_anticipos_old
integer x = 1289
integer y = 116
integer width = 338
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
boolean enabled = false
string text = "Año Ant."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_boton_anticipo from statictext within w_cancelacion_anticipos_old
integer x = 1632
integer y = 116
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Anticipo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
int reg
// anticipos en situación 2 a 4 
reg = dw_3.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text),2,4)
if reg > 0 then
	dw_3.visible = true
	dw_3.setfocus()
end if


end event

type em_banco from u_em_campo within w_cancelacion_anticipos_old
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 114
integer y = 192
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION BANCOS"
ue_datawindow = "dw_ayuda_carbancos"
ue_filtro     = ""		
isle_campo    = this

end event

event modificado;call super::modificado;st_nombre_banco.text=f_nombre_banco(codigo_empresa,em_banco.text)	
IF Trim(st_nombre_banco.text)="" THEN 
 IF Trim(st_nombre_banco.text)<>"" Then f_activar_campo(em_banco)
 em_banco.text=""
END IF
end event

type dw_1 from datawindow within w_cancelacion_anticipos_old
integer x = 82
integer y = 304
integer width = 2770
integer height = 640
string dataobject = "dw_cancelacion_anticipos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_nombre_moneda from statictext within w_cancelacion_anticipos_old
integer x = 635
integer y = 1176
integer width = 224
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_cambio from editmask within w_cancelacion_anticipos_old
integer x = 379
integer y = 1140
integer width = 247
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###.00##"
string displaydata = ""
end type

event modified;f_nueva_divisa()
end event

type st_3 from statictext within w_cancelacion_anticipos_old
integer x = 91
integer y = 1156
integer width = 274
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cambio :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_divisas_cancelar from editmask within w_cancelacion_anticipos_old
integer x = 379
integer y = 1052
integer width = 480
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###.00##"
string displaydata = ""
end type

event modified;f_nueva_divisa()
end event

type em_importe_cancelar from editmask within w_cancelacion_anticipos_old
integer x = 379
integer y = 1228
integer width = 485
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###,###.00"
end type

event modified;//f_nuevo_importe()
end event

type st_4 from statictext within w_cancelacion_anticipos_old
integer x = 114
integer y = 1072
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Divisas :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_cancelacion_anticipos_old
integer x = 96
integer y = 1240
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Importe :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_asiento from editmask within w_cancelacion_anticipos_old
integer x = 2327
integer y = 1232
integer width = 293
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "###,###,###"
string displaydata = ""
end type

type st_33 from statictext within w_cancelacion_anticipos_old
integer x = 2341
integer y = 1128
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Asiento "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_cancelacion_anticipos_old
integer x = 937
integer y = 1108
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Gastos"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_cancelacion_anticipos_old
integer x = 1554
integer y = 1128
integer width = 334
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "F. Contable "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_10 from statictext within w_cancelacion_anticipos_old
integer x = 1248
integer y = 1092
integer width = 242
integer height = 116
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Última liquid."
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_cancelacion_anticipos_old
integer x = 1257
integer y = 1208
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sí"
boolean checked = true
end type

type rb_4 from radiobutton within w_cancelacion_anticipos_old
integer x = 1257
integer y = 1276
integer width = 197
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "No"
end type

type st_55 from statictext within w_cancelacion_anticipos_old
integer x = 197
integer y = 1316
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pdte :"
boolean focusrectangle = false
end type

type em_pdte from editmask within w_cancelacion_anticipos_old
integer x = 379
integer y = 1312
integer width = 485
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###,###.00"
end type

event modified;//f_nuevo_importe()
end event

