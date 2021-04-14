$PBExportHeader$w_liquidacion_rem2.srw
$PBExportComments$€
forward
global type w_liquidacion_rem2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_liquidacion_rem2
end type
type em_banco from u_em_campo within w_liquidacion_rem2
end type
type st_nombre_banco from statictext within w_liquidacion_rem2
end type
type st_2 from statictext within w_liquidacion_rem2
end type
type em_remesa from u_em_campo within w_liquidacion_rem2
end type
type cb_1 from commandbutton within w_liquidacion_rem2
end type
type cb_2 from commandbutton within w_liquidacion_rem2
end type
type st_5 from statictext within w_liquidacion_rem2
end type
type st_fecha from statictext within w_liquidacion_rem2
end type
type st_6 from statictext within w_liquidacion_rem2
end type
type em_anyo from editmask within w_liquidacion_rem2
end type
type st_9 from statictext within w_liquidacion_rem2
end type
type em_fcontable from editmask within w_liquidacion_rem2
end type
type gb_2 from groupbox within w_liquidacion_rem2
end type
type gb_1 from groupbox within w_liquidacion_rem2
end type
type dw_2 from datawindow within w_liquidacion_rem2
end type
type cb_3 from commandbutton within w_liquidacion_rem2
end type
type cb_4 from commandbutton within w_liquidacion_rem2
end type
type dw_1 from datawindow within w_liquidacion_rem2
end type
type st_7 from statictext within w_liquidacion_rem2
end type
end forward

global type w_liquidacion_rem2 from w_int_con_empresa
integer x = 9
integer y = 168
integer width = 2958
integer height = 1636
pb_1 pb_1
em_banco em_banco
st_nombre_banco st_nombre_banco
st_2 st_2
em_remesa em_remesa
cb_1 cb_1
cb_2 cb_2
st_5 st_5
st_fecha st_fecha
st_6 st_6
em_anyo em_anyo
st_9 st_9
em_fcontable em_fcontable
gb_2 gb_2
gb_1 gb_1
dw_2 dw_2
cb_3 cb_3
cb_4 cb_4
dw_1 dw_1
st_7 st_7
end type
global w_liquidacion_rem2 w_liquidacion_rem2

type variables
string filtro

integer var_ejercicio
string es_nacional,is_naci_extra,is_nacional

string inst_tipodoc,inst_tiporem,inst_situacion

boolean inst_liquidado

end variables

forward prototypes
public subroutine f_fecha_remesa ()
public subroutine f_activa ()
public subroutine f_desactiva ()
end prototypes

public subroutine f_fecha_remesa ();// Obtenemos la fecha de la remesa
datetime fecha_remesa

dec{2} la_remesa,el_anyo

la_remesa = dec(em_remesa.text)

el_anyo =	dec(em_anyo.text)

select distinct fremesa into :fecha_remesa
from carefectos
where (empresa = :codigo_empresa) and 
		(nacional = :is_nacional) and 
		(banco = :em_banco.text) and
		(anyo_remesa = :el_anyo) and
		(remesa = :la_remesa ); 
		
if sqlca.sqlcode = 0 then
	st_fecha.text = string(date(fecha_remesa))
	st_5.visible = true
	
else
	st_fecha.text = ""	
	st_5.visible = false
end if

end subroutine

public subroutine f_activa ();cb_3.enabled = true
cb_4.enabled = true
end subroutine

public subroutine f_desactiva ();cb_3.enabled = false
cb_4.enabled = false
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Liquidación de Remesas"
This.title=istr_parametros.s_titulo_ventana

es_nacional = 'S'
is_naci_extra = 'N'
is_nacional = 'S'

st_5.visible = false

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_2.visible = false

em_anyo.text = string(year(today()))
em_fcontable.text = string(today())

// variable instancia que indica si una remesa se está volviendo 
// a liquidar
inst_liquidado = false



end event

on w_liquidacion_rem2.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.em_banco=create em_banco
this.st_nombre_banco=create st_nombre_banco
this.st_2=create st_2
this.em_remesa=create em_remesa
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_5=create st_5
this.st_fecha=create st_fecha
this.st_6=create st_6
this.em_anyo=create em_anyo
this.st_9=create st_9
this.em_fcontable=create em_fcontable
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_2=create dw_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_1=create dw_1
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.em_banco
this.Control[iCurrent+3]=this.st_nombre_banco
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_remesa
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_fecha
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.em_anyo
this.Control[iCurrent+12]=this.st_9
this.Control[iCurrent+13]=this.em_fcontable
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.dw_2
this.Control[iCurrent+17]=this.cb_3
this.Control[iCurrent+18]=this.cb_4
this.Control[iCurrent+19]=this.dw_1
this.Control[iCurrent+20]=this.st_7
end on

on w_liquidacion_rem2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.em_banco)
destroy(this.st_nombre_banco)
destroy(this.st_2)
destroy(this.em_remesa)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_5)
destroy(this.st_fecha)
destroy(this.st_6)
destroy(this.em_anyo)
destroy(this.st_9)
destroy(this.em_fcontable)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.st_7)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_liquidacion_rem2
integer x = 2112
integer y = 20
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_liquidacion_rem2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_liquidacion_rem2
integer x = 9
integer y = 4
integer width = 2427
integer height = 108
end type

type pb_1 from upb_salir within w_liquidacion_rem2
integer x = 2720
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type em_banco from u_em_campo within w_liquidacion_rem2
integer x = 114
integer y = 200
integer width = 270
integer taborder = 10
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE BANCO"
ue_datawindow ="dw_ayuda_carbancos"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;st_nombre_banco.text = f_nombre_banco(codigo_empresa,em_banco.text)
end event

type st_nombre_banco from statictext within w_liquidacion_rem2
integer x = 402
integer y = 200
integer width = 951
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_2 from statictext within w_liquidacion_rem2
integer x = 1582
integer y = 116
integer width = 265
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 12632256
string text = "Remesa "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;if em_anyo.text = "" or em_banco.text = "" then
	f_mensaje("Atención","Debe introducir los datos de Banco y Año")
	
	return
end if

int num_remesas 
num_remesas = 0


// mostramos las de nacional, confirmadas con o sin gastos (situ >= 2 y <= 4)
num_remesas =dw_2.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text),is_naci_extra,"2")


if num_remesas > 0 then 
	dw_2.visible = true
else
	f_mensaje("Atención","No hay remesas pendientes de liquidación para el Año : " + em_anyo.text + & 
				" y el Banco : " +st_nombre_banco.text)
				
	dw_1.reset()
	em_remesa.text = ""
	st_5.visible = false
	st_fecha.text = ""
end if
end event

type em_remesa from u_em_campo within w_liquidacion_rem2
integer x = 1582
integer y = 200
integer width = 265
integer taborder = 30
long backcolor = 16777215
alignment alignment = right!
end type

type cb_1 from commandbutton within w_liquidacion_rem2
integer x = 2217
integer y = 192
integer width = 334
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Consultar"
end type

event clicked;// Control de datos

if em_remesa.text = "" then
	messagebox("Error de datos","Debe introducir la remesa")
	return
end if

//if not isdate(em_anyo.text) then
//	messagebox("Error de datos","Debe introducir el año de la remesa")
//	return
//end if

if em_banco.text = "" then
	messagebox("Error de datos","Debe introducir el banco")	
	return
end if




int remesa_int,anyo_int

remesa_int = integer(em_remesa.text)  
anyo_int = integer(em_anyo.text)



// *********************************************************************
// Obtenemos datos generales de la remesa que se obtendrían al pinchar
// sobre la pantalla de ayuda
// *********************************************************************


// obtenemos la fecha de la remesa
f_fecha_remesa()

// En la variable instancia "inst_tipodoc" el tipodoc de la remesa
// En la variable instancia "inst_tiporem" el tipo de la remesa
// En la variable instancia "inst_situacion" el tipo de la remesa
select tipodoc, tiporem, situacion into :inst_tipodoc, :inst_tiporem, :inst_situacion
from carremesas
where (carremesas.empresa = :codigo_empresa)		and
		(carremesas.anyo = :anyo_int)					and
		(carremesas.banco = :em_banco.text)			and
		(carremesas.naci_extra = :is_naci_extra)					and
		(carremesas.remesa = :remesa_int);


// Si es al riesgo y confirmada con gastos avisamos de que ya ha habido una liquidación
if inst_situacion = "4" and inst_tiporem = "1" then
	int opcion
	opcion = messagebox("Atención", "La remesa ya ha sido liquidada anteriormente, ¿ Desea realizar una nueva liquidación ?",question!,yesno!,2)
	if opcion = 1 then 
		// Efectos de la remesa seleccionada
		dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_remesa.text),is_nacional,inst_tiporem)
	else 
		dw_1.reset()
		em_remesa.text = ""
		st_fecha.text = ""
		return
	end if	
else
	dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_remesa.text),is_nacional,inst_tiporem)
end if
	



// Si es remesa al riesgo no se puede puntear
if inst_tiporem = "1" then 
	f_desactiva()
else
	f_activa()
end if 












end event

type cb_2 from commandbutton within w_liquidacion_rem2
integer x = 2167
integer y = 1292
integer width = 352
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "&Procesar"
end type

event clicked;//******************************************************************
// CONTROLES DE DATOS 
//******************************************************************


// Control de los campos introducidos


IF em_anyo.text ="" or em_remesa.text = "" then
	
	messagebox("Atención","Debe introducir los datos de :  Banco, Remesa y Año ")
	return
end if



// Control de la dw : debe haberse consultado

if dw_1.rowcount() <= 0 then
	
	messagebox("Atención","No existe remesa o no se ha hecho la consulta")
	return
end if



//*********************************************************************
// Obtenemos el ejercicio de la fecha contable
//*********************************************************************

dec{2} ejer_act
datetime f_contable
f_contable =	datetime(date(em_fcontable.text))
ejer_act = year(date(em_fcontable.text))



//*********************************************************************
// EN LA VARIABLE INSTANCIA inst_tipodoc EL TIPO DE DOCUMENTO
// EN LA VARIABLE INSTANCIA inst_tiporem EL TIPO DE REMESA
// *********************************************************************
int anyo_int,rem_int
			
anyo_int = integer(em_anyo.text)
rem_int = integer (em_remesa.text )		

select tipodoc ,tiporem into :inst_tipodoc, :inst_tiporem
from carremesas 
where (carremesas.empresa = :codigo_empresa) and
		(carremesas.anyo = :anyo_int) and
		(carremesas.banco = :em_banco.text)and
		(carremesas.naci_extra = :is_naci_extra) and
		(carremesas.remesa = :rem_int);




//**********************************************************************
// ESTRUCTURA PARA EL ASIENTO
//**********************************************************************

// Apunte contable	
Str_contaapun apu  

// para la contabilidad analítica
str_costesapu	coste

dec{2} el_anyo,la_remesa,el_saldo,total_saldo
string la_cuenta,el_banco
int error_num, num_apunte,i
boolean res 		

el_anyo 		= dec(em_anyo.text)
la_remesa 	= dec(em_remesa.text)
el_banco 	= Trim(em_banco.text)


// Datos comunes a todos los apuntes

num_apunte		=	0	// inicialmente 0, se incrementa con cada apunte
apu.ejercicio 	=	integer(ejer_act)
apu.empresa 	=	codigo_empresa
apu.origen		=	f_diario_contagene(codigo_empresa,"13")	
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

apu.cambio = 1
apu.moneda = f_moneda_empresa(codigo_empresa)
apu.mes    = month(date(f_contable))

// ********************************************************************
// 		CASOS POSIBLES
// ********************************************************************

// CASO 1 LIQUIDACIÓN REMESAS EN GESTIÓN DE COBRO 
// CASO 2 LIQUIDACIÓN REMESAS EN RIESGO 


int caso

if inst_tiporem = "1" then
	caso = 2
else
	caso = 1
end if

choose case caso

case  1
	
//*********************************************************************
// CASO 1
// Liquidación remesas en gestión de cobro
//*********************************************************************


	// ********************************************************************
	// OBTENEMOS LA CANTIDAD QUE SE VA A LIQUIDAR AHORA DE LA REMESA
	// LA PASAMOS A LA PANTALLA DE INTRODUCCIÓN DE GASTOS
	// ********************************************************************

								
	// Estructura para el pase de parámetros a la pantalla de petición gastos
	str_imput_gastos datos,datos_salida
	
	datos.banco 		= em_banco.text
	datos.anyo 			= integer(em_anyo.text)
	datos.remesa 		= integer(em_remesa.text)
	datos.naci_extra 	= is_naci_extra
	// Variable instancia
	datos.tipodoc = inst_tipodoc
	// El valor del apunte al banco visible
	datos.visible_importe = true
	// Sí se hace cálculo de intereses
	datos.calcula_intereses = true
	
	
	string punteado1,punteado2
	int j,k
	dec{2} cantidad_liquidar,import

	// Una remesa en gestión de cobro se puede liquidar toda o sólo 
	// alguno de sus efectos. Vemos lo que se ha marcado ahora
	cantidad_liquidar = 0
	k = 0
	for j = 1 to dw_1.rowcount()
		
		punteado1 = dw_1.getitemstring(j,"punt")
				
		// si se ha punteado 
		if punteado1 = "S" then 
			import = dw_1.getitemnumber(j,"importe")
			
			// calculamos el total de lo que se va a liquidar 
			cantidad_liquidar = cantidad_liquidar + import
			
			// Pasamos los efectos punteados a la estructura
			k = k +1			
			datos.efectos_orden[k] 	 = dw_1.getitemnumber(j,"orden") 
			datos.efectos_fvto[k] 	 = dw_1.getitemdatetime(j,"fvto")
			datos.efectos_importe[k] = dw_1.getitemnumber(j,"importe")
						
		end if
		
	next
	
	// numero de efectos marcados
	datos.num_efectos = k
	// como importe el total de lo marcado
	datos.importe = cantidad_liquidar
	
	
	
	// Si hay algo que liquidar
	if datos.num_efectos > 0 then
				
		// abrimos ventana petición de datos
		openwithparm(w_input_gastos,datos)
		
		
		datos_salida = Message.powerobjectparm 
		
		if datos_salida.correcto = false then 
			messagebox("Atención","No se ha liquidado la remesa")
			rollback;
			return
		end if	
		
																				
		dec importe_banco,gastos_rem,suma_comprob
		boolean todo
		
		// el usuario puede introducir en importe remesa el total
		// de la remesa o el total descontando los gastos,
		// lo comprobamos aquí
		if cantidad_liquidar = datos_salida.importe_salida then
			// si ha puesto el total descontamos los gastos
			// siempre que los gastos no superen el importe
			if datos_salida.total_gastos > datos_salida.importe_salida then						
				error_num = 6
			else
				todo = true
				importe_banco = datos_salida.importe_salida - datos_salida.total_gastos
				gastos_rem = datos_salida.total_gastos
			end if
		else
			// ya descontados los gastos
			todo = false
			importe_banco = datos_salida.importe_salida 
			gastos_rem = datos_salida.total_gastos
		end if
		
		
		// La suma de importe remesa y gastos ha de ser el total a liquidar
		suma_comprob = importe_banco + gastos_rem
		
		if suma_comprob <> cantidad_liquidar then
			error_num = 5										
		end if
				
		//**************************************************************
		// CALCULO DE LOS GASTOS DE LA REMESA
		//**************************************************************
		
		// Una remesa en GESTIÓN DE COBRO se puede liquidar en varias veces.
		// (efecto a efecto)
		
		// El total de gastos en CARREMESAS se va actualizando
				
		dec gasto_acumulado
		
		// Obtenemos el gasto que ya pueda tener esta remesa
		select totgastos into :gasto_acumulado from carremesas
		where (carremesas.empresa 		= :codigo_empresa) and
				(carremesas.anyo 			= :anyo_int ) and
				(carremesas.banco			= :el_banco) AND
				(carremesas.naci_extra 	= :is_naci_extra) and
				(carremesas.remesa 		= :rem_int);
						
		if isnull(gasto_acumulado) then gasto_acumulado = 0				
		
		
		// Le añadimos el gasto actual
		gasto_acumulado = gasto_acumulado + gastos_rem		
		
		UPDATE carremesas SET totgastos = :gasto_acumulado  
		where	(carremesas.empresa 		= :codigo_empresa) and
				(carremesas.anyo 			= :anyo_int ) and
				(carremesas.banco			= :el_banco) AND
				(carremesas.naci_extra 	= :is_naci_extra) and
				(carremesas.remesa 		= :rem_int);
				
		//**********************************************************		
		//Apuntes contables
		//**********************************************************
			
		//*******************************************************
		// 1. Apuntes al banco
		// Hacemos un apunte por el importe y otro por los gastos
		//********************************************************
		
		// Apunte por importe de la remesa
		apu.cuenta 		= f_cuenta_carbancos(codigo_empresa,em_banco.text)
		apu.concepto	= f_concepto_contagene(codigo_empresa,"13")	
		apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"13")+ EM_REMESA.TEXT
		apu.origen		= f_diario_contagene(codigo_empresa,"13")	
		apu.documento 	= Trim(em_remesa.text)
		apu.ffactura	= DateTime(date(st_fecha.text))
		
		if f_dh_contagene(codigo_empresa,"13")= "D" then
			if todo then
				apu.debe		=	cantidad_liquidar 			
				apu.haber	=	0
			else
				apu.debe 	=	importe_banco
				apu.haber	=	0
			end if	
		else
			if todo then
				apu.debe		=	0
				apu.haber	=	cantidad_liquidar 
			else
				apu.debe		=	0
				apu.haber	=	importe_banco
			end if
		end if	
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
		res = f_insert_contaapun(apu) 
		if res = false then
			error_num = 7
		end if
		
		
		
		// Apunte al banco por los gastos. sólo si hay gastos y si se 
		// puso el importe sin descontar los gastos
		if gastos_rem > 0 then
			if todo then
				apu.cuenta 		=	f_cuenta_carbancos(codigo_empresa,em_banco.text)
				apu.concepto	=	f_concepto_contagene(codigo_empresa,"14")	
				apu.ampliacion	=	"Liquidación "+f_ampliacion_contagene(codigo_empresa,"14")+ " "+EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
				apu.origen		=	f_diario_contagene(codigo_empresa,"14")	
				
				if f_dh_contagene(codigo_empresa,"14")= "D" then
					apu.debe		=	gastos_rem
					apu.haber	=	0
				else
					apu.debe		=	0
					apu.haber	=	gastos_rem
				end if	
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				if res = false then
					error_num = 8
				end if
			
			end if
			
			//******************************************************************
			// 2. Apuntes a las cuentas de gastos obtenidas en ventana auxiliar
			//******************************************************************
		
		
			// apunte a la cuenta de intereses
			// Sólo si hay intereses 
			if datos_salida.intereses > 0 then
				apu.cuenta 		=	datos_salida.cta_intereses
				apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
				apu.ampliacion	=	"Liquidación " +f_ampliacion_contagene(codigo_empresa,"19")+" Nº "+ EM_REMESA.TEXT +"  " + f_nombre_banco_abr(codigo_empresa,el_banco)
				apu.origen		=	f_diario_contagene(codigo_empresa,"19")	
				
				if f_dh_contagene(codigo_empresa,"19")= "D" then
					apu.debe		=	datos_salida.intereses
					apu.haber	=	0
				else
					apu.debe		=	0
					apu.haber	=	datos_salida.intereses
				end if	
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				if res = false then
					error_num = 16
				end if
				// Apunte de analítica		
				// Comprobamos si tiene analitica
				IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
					IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
						coste.coste		  = f_coste_contagene(codigo_empresa,"19")
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
							error_num = 17
						END IF
					END IF
				END IF

			
			
			
			
			end if
		
			
			// Apunte para el resto de gastos
			for i= 1 to datos_salida.num_gastos
				// Sólo si hay gasto
				if datos_salida.gastos[i] >0 then
					apu.cuenta 		=	datos_salida.cuentas[i]
					apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
					apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"19")+ " Nº "+ EM_REMESA.TEXT +"  " + f_nombre_banco_abr(codigo_empresa,el_banco)
					apu.origen		=	f_diario_contagene(codigo_empresa,"19")	
					
					if f_dh_contagene(codigo_empresa,"19")= "D" then
						apu.debe		=	datos_salida.gastos[i]
						apu.haber	=	0
					else
						apu.debe		=	0
						apu.haber	=	datos_salida.gastos[i]
					end if	
					
					num_apunte		=	num_apunte +1
					apu.apunte		=	num_apunte	
					apu.orden_apunte	=	num_apunte
					res = f_insert_contaapun(apu) 
					if res = false then
						error_num = 16
					end if
					// Apunte de analítica
					// Comprobamos si tiene analitica
					IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
						IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
							coste.coste		  = f_coste_contagene(codigo_empresa,"19")
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
								error_num = 17
							END IF
						END IF
					END IF
	
		
				end if
				
			next
		
			
		end if
		
		
		
		//************************************************
		// 3. Apunte a los clientes. Sólo a los punteados
		//*************************************************
//Santiago 09/08/2000
//La liquidación de una remesa al cobro NO implica su cancelación
//		// para cada cliente
//		for i = 1 to dw_1.rowcount()
//			
//			string punte,punte2
//			punte = dw_1.getitemstring(i,"punt")
//					
//			// si está marcado hacemos el apunte
//			if punte = "S" then
//															
//							
//				apu.cuenta = dw_1.getitemstring(i,"cuenta")	
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"15")	
//	
//				apu.ampliacion	=	f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemString(i,"tipodoc")) + " Vto. " + String(Date(dw_1.GetItemDateTime(i,"fvto")),"dd/mm/yy")
//				apu.origen		=	f_diario_contagene(codigo_empresa,"15")	
//				
//				apu.documento	=	dw_1.getitemstring(i,"factura")
//				apu.ffactura	=	dw_1.getitemdatetime(i,"fvto")
//				
//				
//				if f_dh_contagene(codigo_empresa,"15")= "D" then
//					apu.debe		=	dw_1.getitemnumber(i,"importe")
//					apu.haber	=	0
//				else
//					apu.debe		=	0
//					apu.haber	=	dw_1.getitemnumber(i,"importe")
//				end if	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				if res = false then
//					exit
//	
//					error_num = 9
//				end if
//			end if
//		next
//		
//		
//		//****************************************************************
//		// Los efectos que se han liquidado pasan al histórico
//		// Se cambia a situación 5 (cancelada) si ya están todos	liquidados.	
//		// Si hay alguno pendiente situación 4 (liquidada) 
//		//*****************************************************************
//		int linea_efecto
//		dec orden,anyo_efecto
//		boolean pendiente
//		str_carhistorico historico
//		
//		pendiente = false
//
//		// Borramos de carefectos los liquidados y los copiams al histórico.
//		for i = 1 to dw_1.rowcount()
//			
//			punte2 = dw_1.getitemstring(i,"punt")
//			orden	 = dw_1.getitemnumber(i,"orden") 
//			anyo_efecto = dw_1.getitemnumber(i,"anyo") 
//			
//			if (punte2 = "S") then
//								
//					// Selecciono datos del efecto y los inserto en carhistorico							  
//				  SELECT 
//						carefectos.anyofra,carefectos.factura,carefectos.recibo,
//						carefectos.fvto, carefectos.ffra, carefectos.fvto_original,  
//						carefectos.importe,carefectos.divisas,carefectos.monedas,
//						carefectos.fpago,carefectos.tipodoc,carefectos.banco,   
//						carefectos.remesa,carefectos.fremesa,
//						carefectos.agente1,carefectos.pais,carefectos.cuenta,   
//						carefectos.domiciliacion,carefectos.Nacional,
//						carefectos.observaciones,carefectos.libre,carefectos.gasto,   
//						carefectos.fdevolucion,carefectos.agrupado,   
//						carefectos.efectoagrupa,carefectos.anyoagrupa,
//						carefectos.cliente,carefectos.anyo_remesa  
//				 INTO :historico.anyofra,:historico.factura,:historico.recibo,   
//						:historico.fvto,:historico.ffra, :historico.fvto_original,  
//						:historico.importe,:historico.divisas,:historico.monedas,   
//						:historico.fpago,:historico.tipodoc,:historico.banco,   
//						:historico.remesa,:historico.fremesa,  
//						:historico.agente1,:historico.pais,:historico.cuenta,   
//						:historico.domiciliacion,:historico.nacional,   
//						:historico.observaciones,:historico.libre,:historico.gasto,   
//						:historico.fdevolucion,:historico.agrupado,
//						:historico.efectoagrupa,:historico.anyoagrupa,   
//						:historico.cliente,:historico.anyo_remesa  
//				FROM carefectos  
//				WHERE ( carefectos.empresa = :codigo_empresa ) AND  
//						( carefectos.anyo 	= :anyo_efecto ) AND  
//						( carefectos.orden 	= :orden )   ;
//				IF SQLCA.SQLCODE <> 0 Then error_num = 18 
//				historico.empresa=codigo_empresa
//				historico.anyo=anyo_efecto 
//				historico.orden=orden
//				historico.fcobro=historico.fvto
//				historico.situacion="9"
//				SELECT max(carhistorico.linea ) INTO :linea_efecto FROM carhistorico  
//				WHERE ( carhistorico.empresa 	= :codigo_empresa ) AND  
//						( carhistorico.anyo 		= :anyo_efecto ) AND  
//						( carhistorico.orden 	= :orden ) USING SQLCA;
//				if sqlca.sqlcode=100 then linea_efecto=0
//				if isnull(linea_efecto) then linea_efecto=0
//				historico.linea=linea_efecto + 1
//				
//				if not f_insert_carhistorico(historico) then error_num = 18
//			
//				// Borro el efecto de carefectos
//				DELETE FROM carefectos  
//				WHERE ( carefectos.empresa = :codigo_empresa ) AND  
//						( carefectos.anyo 	= :anyo_efecto ) AND  
//						( carefectos.orden 	= :orden ) USING SQLCA;
//				IF SQLCA.SQLCODE <> 0 Then error_num = 19
//							
//			else
//				// Si queda alguno pendiente
//				pendiente = true
//			end if
//		
//		// final paso al histórico
//		next
//				
//		
//		
//		if not pendiente  then
//			// Si no queda nada por liquidar situación 5 (cancalada)	
//			UPDATE carremesas  SET situacion = "5"  
//			where	(carremesas.empresa 		= :codigo_empresa) and
//					(carremesas.anyo 			= :anyo_int ) and
//					(carremesas.banco 		= :el_banco) AND
//					(carremesas.naci_extra 	= "N") and
//					(carremesas.remesa 		= :rem_int);
//		
//		else
//			// Si queda algo por liquidar situación 4 (liquidada)
//			UPDATE carremesas  SET situacion = "4"  
//			where	(carremesas.empresa 		= :codigo_empresa) and
//					(carremesas.anyo 			= :anyo_int ) and
//					(carremesas.banco 		= :el_banco) AND
//					(carremesas.naci_extra 	= "N") and
//					(carremesas.remesa 		= :rem_int);
//	
//		end if
//Santiago 09/08/2000
//La liquidación de una remesa al cobro NO implica su cancelación
		
	else
		error_num = 17
	end if 








//*********************************************************************
// CASO 2
// Liquidación de remesas en riesgo
// ********************************************************************+
case  2
	
	
	
	// ********************************************************************
	// OBTENEMOS TOTAL REMESA
	// ********************************************************************
	
	long total_remesa
	
	total_remesa = dw_1.getitemnumber(1,"total")
	
	
	
	
	//*********************************************************************+
	//		Liquidación REMESA
	//**********************************************************************
	
	// 0 errores
	error_num = 0
	int continuar
	
	
	continuar = messagebox("Atención","¿ Desea liquidar la remesa ?"  , question!,yesno!,1)	
	if continuar = 2 then
		//No continuar
		return
	else
		
		
		//Pedimos los datos de gastos en otra pantalla
								
		// Estructura para el pase de parámetros
			
		datos.banco = em_banco.text
		datos.anyo = integer(em_anyo.text)
		datos.remesa = integer(em_remesa.text)
		datos.naci_extra = is_naci_extra
		datos.tipodoc = inst_tipodoc
		
		// El importe del apunte al banco no visible
		datos.visible_importe = false
		// No se hace el cálculo de los intereses si ya ha habido una 
		// liquidación previa
		if inst_situacion = "3" then
			datos.calcula_intereses = false
		end if
		if inst_situacion = "2" then
			datos.calcula_intereses = true
		end if
		
		
		// Pasamos los efectos de la remesa a la estructura datos		
		datos.num_efectos = dw_1.rowcount() 
		for k = 1 to datos.num_efectos
			datos.efectos_orden[k] = dw_1.getitemnumber(k,"orden") 
			datos.efectos_fvto[k] = dw_1.getitemdatetime(k,"fvto")
			datos.efectos_importe[k] = dw_1.getitemnumber(k,"importe")
		next

		// Pantalla para obtener los gastos			
		openwithparm(w_input_gastos,datos)

		datos_salida = Message.powerobjectparm 
		
		if datos_salida.correcto = false then 
			messagebox("Atención","No se ha liquidado la remesa")
			rollback;
			return
		end if
									
		
		// El usuario no introduce el importe de la remesa 
		// Ya se hizo el apunte por el total en el programa
		// de confirmación.
		
	
		gastos_rem = datos_salida.total_gastos
		
		
		// *********************************************************************
		// cambiamos la situación de la remesa en CarRemesas y
		// añadimos el total de los gastos
		// *********************************************************************
		
		
		
		
		// actualización de los gastos de la remesa
		
		anyo_int = integer(em_anyo.text)
		rem_int = integer (em_remesa.text )		
				
		gasto_acumulado = 0
		
		// Obtenemos el gasto que ya pueda tener esta remesa
		select totgastos into :gasto_acumulado from carremesas
		where (carremesas.empresa 		= :codigo_empresa) and
				(carremesas.anyo 			= :anyo_int ) and
				(carremesas.banco			= :el_banco) AND
				(carremesas.naci_extra 	= :is_naci_extra) and
				(carremesas.remesa 		= :rem_int);
						
		if isnull(gasto_acumulado) then gasto_acumulado = 0				
		
		// Le añadimos el gasto actual
		gasto_acumulado = gasto_acumulado + gastos_rem				
		
		UPDATE carremesas 
		SET situacion = "4",
			 totgastos = :gasto_acumulado  
		where	(carremesas.empresa 		= :codigo_empresa) and
				(carremesas.anyo 			= :anyo_int ) and
				(carremesas.banco 		= :el_banco) AND
				(carremesas.naci_extra 	= :is_naci_extra) and
				(carremesas.remesa 		= :rem_int);
		
		
		
		
					
		//**********************************************************		
		//Asiento contables
		//**********************************************************
		
		
		//*******************************************************
		// 1. Apunte al banco			
		//********************************************************
		
		// si no hay gastos no hay asiento
	if gastos_rem > 0 then
		
		// Apunte a la cuenta del banco por los gastos. 
			 
			apu.cuenta 		=	f_cuenta_carbancos(codigo_empresa,em_banco.text)
			apu.concepto	=	f_concepto_contagene(codigo_empresa,"14")	
			apu.ampliacion	=	"Liquidación "+f_ampliacion_contagene(codigo_empresa,"14")+" Nº "+EM_REMESA.TEXT
			apu.origen		=	f_diario_contagene(codigo_empresa,"14")	
			
			apu.documento	= 	Trim(em_remesa.text)
			apu.ffactura	= 	DateTime(date(st_fecha.text))
			
			if f_dh_contagene(codigo_empresa,"14")= "D" then
				apu.debe		=	gastos_rem
				apu.haber	=	0
			else
				apu.debe		=	0
				apu.haber	=	gastos_rem
			end if	
			
			num_apunte		=	num_apunte +1
			apu.apunte		=	num_apunte	
			apu.orden_apunte	=	num_apunte
			res = f_insert_contaapun(apu) 
			if res = false then
				error_num = 8
			end if
			
		
		//**************************************+
		// 2. Apuntes por los gastos 
		//***************************************
	
	
		// Apunte por los intereses
		
		// Si hay intereses
		if datos_salida.intereses > 0 then
			apu.cuenta 		=	datos_salida.cta_intereses
			apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
			apu.ampliacion	=	"Liquidación "+ f_ampliacion_contagene(codigo_empresa,"19")+ " "+ EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco) +"  " + f_nombre_banco_abr(codigo_empresa,el_banco)
			apu.origen		=	f_diario_contagene(codigo_empresa,"19")	
			apu.documento	= 	Trim(em_remesa.text)
			apu.ffactura	= 	DateTime(date(st_fecha.text))
			
			if f_dh_contagene(codigo_empresa,"19")= "D" then
				apu.debe		=	datos_salida.intereses
				apu.haber	=	0
			else
				apu.debe		=	0
				apu.haber	=	datos_salida.intereses
			end if	
			
			num_apunte		=	num_apunte +1
			apu.apunte		=	num_apunte	
			apu.orden_apunte	=	num_apunte
			res = f_insert_contaapun(apu) 
			if res = false then
				error_num = 16
			end if
		
			
			// Apunte de analítica
			// Comprobamos si tiene analitica
			IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
				IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
					coste.coste		  = f_coste_contagene(codigo_empresa,"19")
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
						error_num = 17
					END IF
				END IF
			END IF
	
		
		end if	
	
		// Apunte por los demás gastos
		
		for i = 1 to datos_salida.num_gastos
			
			// Si hay gasto
			if datos_salida.gastos[i] >0 then
				apu.cuenta 		=	datos_salida.cuentas[i]
				apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
				apu.ampliacion	=	"Liquidación "+ f_ampliacion_contagene(codigo_empresa,"19")+ " "+ EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
				apu.origen		=	f_diario_contagene(codigo_empresa,"19")	
				
				if f_dh_contagene(codigo_empresa,"19")= "D" then
					apu.debe		=	datos_salida.gastos[i]
					apu.haber	=	0
				else
					apu.debe		=	0
					apu.haber	=	datos_salida.gastos[i]
				end if	
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				if res = false then
					error_num = 16
				end if
			
				// Apunte de analítica
				// Comprobamos si tiene analitica
				IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
					IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
						coste.coste		  = f_coste_contagene(codigo_empresa,"19")
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
							error_num = 17
						END IF
					END IF
				END IF
						
			end if	
			
		next
	
	
	end if // no hay gastos
			
				
	end if // Condición de continuar




	
end choose





//*******************************************************************
// Comprobación de los errores
//*******************************************************************

if error_num = 0 then
	f_mensaje("BIEN","La remesa ha sido Liquidada")
	
	//limpiamos pantalla
	dw_1.reset()
	em_remesa.text = ""
	st_5.visible = false
	st_fecha.text = ""
	
	commit;
	return

else
	rollback;
	choose case error_num
			
		
		case 5
			f_mensaje("ATENCIÓN","Las cantidades introducidas de importe y gastos " +&
						" no coinciden con el total de la remesa")
		case 6
			f_mensaje("ATENCIÓN","Los gastos introducidas superan el importe de la remesa ")
		
		case 7
			f_mensaje("ATENCIÓN","Error al hacer el apunte contable a BANCOS ")
				
		case 8
			f_mensaje("ATENCIÓN","Error al hacer el apunte contable a BANCOS (GASTOS) ")
		
		case 9
			f_mensaje("ATENCIÓN","Error al hacer el apunte contable a CLIENTES ")
		case 16
			f_mensaje("ATENCIÓN","Error al hacer el apunte contable a la cuenta GASTOS BANCARIOS ")
		
		case 17
			f_mensaje("ATENCIÓN","No se han seleccionado efectos a liquidar ")
	

	end choose
	
end if
end event

type st_5 from statictext within w_liquidacion_rem2
integer x = 1847
integer y = 116
integer width = 279
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_fecha from statictext within w_liquidacion_rem2
integer x = 1851
integer y = 200
integer width = 265
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_liquidacion_rem2
integer x = 1371
integer y = 116
integer width = 210
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_anyo from editmask within w_liquidacion_rem2
integer x = 1376
integer y = 200
integer width = 206
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
string displaydata = "x"
end type

type st_9 from statictext within w_liquidacion_rem2
integer x = 1221
integer y = 1308
integer width = 494
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Contable :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fcontable from editmask within w_liquidacion_rem2
integer x = 1719
integer y = 1296
integer width = 343
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_2 from groupbox within w_liquidacion_rem2
integer x = 2130
integer y = 1244
integer width = 416
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 12632256
end type

type gb_1 from groupbox within w_liquidacion_rem2
integer x = 1207
integer y = 1244
integer width = 896
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 12632256
end type

type dw_2 from datawindow within w_liquidacion_rem2
boolean visible = false
integer x = 549
integer y = 288
integer width = 2135
integer height = 608
boolean bringtotop = true
string dataobject = "dw_ayuda_remesas_liq2"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;


CHOOSE CASE f_objeto_datawindow(This)

CASE "remesa","fremesa","importe","nom_tipodoc","nom_tipo_rem"
	em_remesa.text =string(getitemnumber(row,"remesa"))
	st_fecha.text = 	 string(date(getitemdatetime(row,"fremesa")))
	dw_2.visible = false	
	if st_fecha.text <> "" then		
		st_5.visible = true		
	end if
	
	// En la variable instancia "inst_tipodoc" el tipodoc de la remesa
	inst_tipodoc = dw_2.getitemstring(row,"tipodoc")
	
	// En la variable instancia "inst_tiporem" el tipo de la remesa
	inst_tiporem = dw_2.getitemstring(row,"tiporem")
		
	// En la variable instancia "inst_situacion" la situación de la remesa 
	inst_situacion = dw_2.getitemstring(row,"situacion")

	// Si es confirmada con gastos avisamos de que ya ha habido una liquidación
	if inst_situacion = "4" and inst_tiporem = "1" then
		int opcion
		opcion = messagebox("Atención", "La remesa ya ha sido liquidada anteriormente, ¿ Desea realizar una nueva liquidación ?",question!,yesno!,2)
		if opcion = 1 then 
			// Efectos de la remesa seleccionada
			dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_remesa.text),is_nacional,inst_tiporem)
		else 
			dw_1.reset()
			em_remesa.text = ""
			st_fecha.text = ""
			return
		end if	
	else
		dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_remesa.text),is_nacional,inst_tiporem)
	end if
		
		
		
	// Si es remesa al riesgo no se puede puntear
	if inst_tiporem = "1" then 
		f_desactiva()
	else
		f_activa()
	end if 
	
	
	
end choose
end event

type cb_3 from commandbutton within w_liquidacion_rem2
integer x = 114
integer y = 1240
integer width = 517
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Marcar"
end type

event clicked;int i

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i,"punt","S")
	
	
next
end event

type cb_4 from commandbutton within w_liquidacion_rem2
integer x = 631
integer y = 1240
integer width = 517
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Desmarcar"
end type

event clicked;int i

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i,"punt","N")
	
	
next
end event

type dw_1 from datawindow within w_liquidacion_rem2
integer x = 114
integer y = 288
integer width = 2437
integer height = 952
string dataobject = "dw_liquida_remesas2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_7 from statictext within w_liquidacion_rem2
integer x = 114
integer y = 116
integer width = 1257
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Banco"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

