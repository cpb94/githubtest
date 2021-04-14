$PBExportHeader$w_liquidacion_rem_expor_original.srw
$PBExportComments$€
forward
global type w_liquidacion_rem_expor_original from w_int_con_empresa
end type
type pb_1 from upb_salir within w_liquidacion_rem_expor_original
end type
type em_banco from u_em_campo within w_liquidacion_rem_expor_original
end type
type st_nombre_banco from statictext within w_liquidacion_rem_expor_original
end type
type st_2 from statictext within w_liquidacion_rem_expor_original
end type
type em_remesa from u_em_campo within w_liquidacion_rem_expor_original
end type
type cb_1 from commandbutton within w_liquidacion_rem_expor_original
end type
type cb_2 from commandbutton within w_liquidacion_rem_expor_original
end type
type st_5 from statictext within w_liquidacion_rem_expor_original
end type
type st_fecha from statictext within w_liquidacion_rem_expor_original
end type
type st_6 from statictext within w_liquidacion_rem_expor_original
end type
type em_anyo from editmask within w_liquidacion_rem_expor_original
end type
type st_9 from statictext within w_liquidacion_rem_expor_original
end type
type em_fcontable from editmask within w_liquidacion_rem_expor_original
end type
type dw_2 from datawindow within w_liquidacion_rem_expor_original
end type
type cb_marca from commandbutton within w_liquidacion_rem_expor_original
end type
type cb_desmarca from commandbutton within w_liquidacion_rem_expor_original
end type
type dw_1 from datawindow within w_liquidacion_rem_expor_original
end type
type st_7 from statictext within w_liquidacion_rem_expor_original
end type
type st_10 from statictext within w_liquidacion_rem_expor_original
end type
type st_11 from statictext within w_liquidacion_rem_expor_original
end type
type st_12 from statictext within w_liquidacion_rem_expor_original
end type
type em_liquida from editmask within w_liquidacion_rem_expor_original
end type
type em_cambio from u_em_campo within w_liquidacion_rem_expor_original
end type
type em_apunbanco from u_em_campo within w_liquidacion_rem_expor_original
end type
type st_111 from statictext within w_liquidacion_rem_expor_original
end type
type em_difcambio from u_em_campo within w_liquidacion_rem_expor_original
end type
type st_122 from statictext within w_liquidacion_rem_expor_original
end type
type st_125 from statictext within w_liquidacion_rem_expor_original
end type
type em_liquida_pts from editmask within w_liquidacion_rem_expor_original
end type
type ln_1 from line within w_liquidacion_rem_expor_original
end type
type ln_2 from line within w_liquidacion_rem_expor_original
end type
type ln_3 from line within w_liquidacion_rem_expor_original
end type
type ln_4 from line within w_liquidacion_rem_expor_original
end type
type st_1 from statictext within w_liquidacion_rem_expor_original
end type
type st_2236 from statictext within w_liquidacion_rem_expor_original
end type
end forward

global type w_liquidacion_rem_expor_original from w_int_con_empresa
integer x = 9
integer y = 168
integer width = 2949
integer height = 1640
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
dw_2 dw_2
cb_marca cb_marca
cb_desmarca cb_desmarca
dw_1 dw_1
st_7 st_7
st_10 st_10
st_11 st_11
st_12 st_12
em_liquida em_liquida
em_cambio em_cambio
em_apunbanco em_apunbanco
st_111 st_111
em_difcambio em_difcambio
st_122 st_122
st_125 st_125
em_liquida_pts em_liquida_pts
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
st_1 st_1
st_2236 st_2236
end type
global w_liquidacion_rem_expor_original w_liquidacion_rem_expor_original

type variables
string filtro,mone

integer var_ejercicio
string es_nacional

string inst_tipodoc

boolean inst_liquidado
Decimal totliquida,totptas

str_paramemp em
end variables

forward prototypes
public subroutine f_fecha_remesa ()
end prototypes

public subroutine f_fecha_remesa ();datetime fecha_remesa
dec{2} la_remesa,el_anyo

// Obtenemos la fecha de la remesa
la_remesa = dec(em_remesa.text)
el_anyo =	dec(em_anyo.text)

SELECT carremesas.fremesa INTO :fecha_remesa FROM carremesas
WHERE carremesas.empresa 	 = :codigo_empresa
AND   carremesas.anyo		 = :el_anyo
AND	carremesas.banco		 = :em_banco.text
AND	carremesas.naci_extra = 'E'
AND   carremesas.remesa		 = :la_remesa USING SQLCA;

IF sqlca.sqlcode = 0 THEN
	st_fecha.text = string(date(fecha_remesa))
	st_5.visible = TRUE
ELSE
	st_fecha.text = ""	
	st_5.visible = FALSE
END IF

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Liquidación de Remesas de Exportación"
This.title=istr_parametros.s_titulo_ventana

es_nacional = 'N'

st_5.visible = false

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_2.visible = false

em_anyo.text = string(year(today()))
em_fcontable.text = string(today())

// variable instancia que indica si una remesa se está volviendo 
// a liquidar
inst_liquidado = false
totliquida 		= 0
totptas			= 0
mone = ""



em = f_paramemp(codigo_empresa)
st_111.text = "Importe en " + f_nombre_moneda(em.moneda_emp)



end event

on w_liquidacion_rem_expor_original.create
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
this.dw_2=create dw_2
this.cb_marca=create cb_marca
this.cb_desmarca=create cb_desmarca
this.dw_1=create dw_1
this.st_7=create st_7
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.em_liquida=create em_liquida
this.em_cambio=create em_cambio
this.em_apunbanco=create em_apunbanco
this.st_111=create st_111
this.em_difcambio=create em_difcambio
this.st_122=create st_122
this.st_125=create st_125
this.em_liquida_pts=create em_liquida_pts
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.st_1=create st_1
this.st_2236=create st_2236
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
this.Control[iCurrent+14]=this.dw_2
this.Control[iCurrent+15]=this.cb_marca
this.Control[iCurrent+16]=this.cb_desmarca
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.st_7
this.Control[iCurrent+19]=this.st_10
this.Control[iCurrent+20]=this.st_11
this.Control[iCurrent+21]=this.st_12
this.Control[iCurrent+22]=this.em_liquida
this.Control[iCurrent+23]=this.em_cambio
this.Control[iCurrent+24]=this.em_apunbanco
this.Control[iCurrent+25]=this.st_111
this.Control[iCurrent+26]=this.em_difcambio
this.Control[iCurrent+27]=this.st_122
this.Control[iCurrent+28]=this.st_125
this.Control[iCurrent+29]=this.em_liquida_pts
this.Control[iCurrent+30]=this.ln_1
this.Control[iCurrent+31]=this.ln_2
this.Control[iCurrent+32]=this.ln_3
this.Control[iCurrent+33]=this.ln_4
this.Control[iCurrent+34]=this.st_1
this.Control[iCurrent+35]=this.st_2236
end on

on w_liquidacion_rem_expor_original.destroy
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
destroy(this.dw_2)
destroy(this.cb_marca)
destroy(this.cb_desmarca)
destroy(this.dw_1)
destroy(this.st_7)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.em_liquida)
destroy(this.em_cambio)
destroy(this.em_apunbanco)
destroy(this.st_111)
destroy(this.em_difcambio)
destroy(this.st_122)
destroy(this.st_125)
destroy(this.em_liquida_pts)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.st_1)
destroy(this.st_2236)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_liquidacion_rem_expor_original
integer x = 2112
integer y = 20
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_liquidacion_rem_expor_original
end type

type st_empresa from w_int_con_empresa`st_empresa within w_liquidacion_rem_expor_original
integer x = 9
integer y = 4
integer width = 2427
integer height = 108
end type

type pb_1 from upb_salir within w_liquidacion_rem_expor_original
integer x = 2688
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type em_banco from u_em_campo within w_liquidacion_rem_expor_original
integer x = 23
integer y = 200
integer width = 270
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE BANCO"
ue_datawindow ="dw_ayuda_carbancos"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;st_nombre_banco.text = f_nombre_banco(codigo_empresa,em_banco.text)
end event

type st_nombre_banco from statictext within w_liquidacion_rem_expor_original
integer x = 311
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

type st_2 from statictext within w_liquidacion_rem_expor_original
integer x = 1490
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


// mostramos las de exportacion, confirmadas con o sin gastos (situ >= 2)
num_remesas =dw_2.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text),"E","2")


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

type em_remesa from u_em_campo within w_liquidacion_rem_expor_original
integer x = 1490
integer y = 200
integer width = 265
integer taborder = 30
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = right!
end type

event modified;call super::modified;f_fecha_remesa()
	// Remesas de Exportación con la situación 6 (gestión de cobro)
dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_remesa.text),es_nacional,"6")
end event

type cb_1 from commandbutton within w_liquidacion_rem_expor_original
integer x = 2121
integer y = 164
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

event clicked;
f_fecha_remesa()
	// Remesas de Exportación con la situación 6 (gestión de cobro)
dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_remesa.text),es_nacional,"6")



end event

type cb_2 from commandbutton within w_liquidacion_rem_expor_original
integer x = 2126
integer y = 1164
integer width = 517
integer height = 216
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Liquidar"
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

// Control de que se ha marcado algo
IF em_liquida.text = "" OR em_liquida.text = "0" THEN
	f_mensaje("ERROR","No se ha marcado NADA")
	RETURN
END IF

// Control de que hay cambio
IF em_cambio.text = "" OR em_cambio.text = '0' THEN
	f_mensaje("ERROR","El cambio no puede ser 0")
	f_activar_campo(em_cambio)
	RETURN
END IF

// Control de que el cambio sea = 1 si la moneda es la de la empresa
IF dec(em_cambio.text) <> f_cambio_moneda(em.moneda_emp) AND mone = em.moneda_emp THEN
	f_mensaje("ERROR","El cambio debe ser 1")
	f_activar_campo(em_cambio)
	RETURN
END IF

// Control de que no haya diferencias de cambio cuando la moneda
// es la de la empresa
IF Dec(em_difcambio.text) <> 0 AND mone = em.moneda_emp THEN
	f_mensaje("ERROR","No puede haber diferencias de cambio")
	f_activar_campo(em_apunbanco)
	RETURN
END IF

// Control de que el apunte al banco no es cero
IF Dec(em_apunbanco.text) = 0 THEN
	f_mensaje("ERROR","El importe a liquidar no puede ser cero")
	f_activar_campo(em_apunbanco)
	RETURN
END IF

//*********************************************************************
// Obtenemos el ejercicio de la fecha contable
//*********************************************************************

dec{2} ejer_act
datetime f_contable
f_contable =	datetime(date(em_fcontable.text))
ejer_act = year(date(em_fcontable.text))

// Control de que el ejercicio no este cerrado

//IF Not f_control_fecha_apunte_empresa(ejer_act,codigo_empresa,f_contable) THEN
//	f_mensaje("ERROR","La Fecha Contable es Incorrecta")
//	f_activar_campo(em_fcontable)
//	RETURN
//END IF

// EN LA VARIABLE INSTANCIA inst_tipodoc EL TIPO DE DOCUMENTO
int anyo_int,rem_int
			
anyo_int = integer(em_anyo.text)
rem_int = integer (em_remesa.text )		

select tipodoc into :inst_tipodoc from carremesas 
where (carremesas.empresa 		= :codigo_empresa) and
		(carremesas.anyo 			= :anyo_int) and
		(carremesas.banco 		= :em_banco.text)and
		(carremesas.naci_extra 	= "E") and
		(carremesas.remesa 		= :rem_int);

//**********************************************************************
// ESTRUCTURA PARA EL ASIENTO
//**********************************************************************
	
Str_contaapun apu  

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
apu.fvalor		= apu.fapunte

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
setnull(apu.docpunteo)
setnull(apu.coste)
setnull(apu.fregistro)

apu.cambio	= 1
apu.moneda	= em.moneda_emp
apu.mes		= month(date(f_contable))

//*********************************************************************
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
datos.naci_extra 	= "E"
// Variable instancia
datos.tipodoc = inst_tipodoc

datos.visible_importe = true


string punteado1,punteado2
int    j,k
dec    cantidad_liquidar,import

// Una remesa en gestión de cobro se puede liquidar toda o sólo 
// alguno de sus efectos. Vemos lo que se ha marcado ahora
cantidad_liquidar = Dec(String(Dec(em_apunbanco.text),f_mascara_moneda(mone)))
k = 0
for j = 1 to dw_1.rowcount()
	punteado1 = dw_1.getitemstring(j,"carefectos_libre")
			
	// si se ha punteado 
	if punteado1 = "S" then 
		// Pasamos los efectos punteados a la estructural
		k = k +1			
		datos.efectos_anyo[k] 	 = dw_1.getitemnumber(j,"anyo") 
		datos.efectos_orden[k] 	 = dw_1.getitemnumber(j,"orden") 
		datos.efectos_fvto[k] 	 = dw_1.getitemdatetime(j,"fvto")
		datos.efectos_importe[k] = dw_1.getitemnumber(j,"importe")
					
	end if
	
next

// numero de efectos marcados
datos.num_efectos = k
// como importe el total de lo marcado con la diferencia de cambio
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
			
	//**************************************************************
	// SITUACIÓN EN CARREMESAS
	//**************************************************************
	
	// Una remesa en GESTIÓN DE COBRO se puede liquidar en varias veces.
	// Cambiamos la situación de la remesa en CarRemesas cuando ya se
	// han liquidado cada uno de los efectos.
	
	// El total de gastos en CARREMESAS se va actualizando
			
	dec gasto_acumulado
	
	// Obtenemos el gasto que ya pueda tener esta remesa
	select totgastos into :gasto_acumulado from carremesas
	where (carremesas.empresa 		= :codigo_empresa) and
			(carremesas.anyo 			= :anyo_int ) and
			(carremesas.banco			= :el_banco) AND
			(carremesas.naci_extra 	= "E") and
			(carremesas.remesa 		= :rem_int);
					
	if isnull(gasto_acumulado) then gasto_acumulado = 0				
	
	
	// Le añadimos el gasto actual
	gasto_acumulado = gasto_acumulado + datos_salida.total_gastos		
	
	UPDATE carremesas SET totgastos = :gasto_acumulado  
	where	(carremesas.empresa 		= :codigo_empresa) and
			(carremesas.anyo 			= :anyo_int ) and
			(carremesas.banco			= :el_banco) AND
			(carremesas.naci_extra 	= "E") and
			(carremesas.remesa 		= :rem_int);
			
	//**********************************************************		
	//Apuntes contables
	//**********************************************************
		
	//*******************************************************
	// 1. Apuntes al banco
	// Hacemos un apunte por el importe y otro por los gastos
	//********************************************************
	
	// Apunte por importe de lo marcado
	apu.cuenta 		= f_cuenta_carbancos(codigo_empresa,em_banco.text)
	apu.concepto	= f_concepto_contagene(codigo_empresa,"13")	
	apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"13")+ EM_REMESA.TEXT
	apu.origen		= f_diario_contagene(codigo_empresa,"13")	
	apu.documento 	= Trim(em_remesa.text)
	apu.ffactura	= DateTime(date(st_fecha.text))
	
	if f_dh_contagene(codigo_empresa,"13")= "D" then
		apu.debe		= datos_salida.importe_salida +  Dec(em_difcambio.text)
		apu.haber	= 0
	else
		apu.debe		= 0
		apu.haber	= datos_salida.importe_salida  +  Dec(em_difcambio.text)
	end if	
	
	num_apunte			=	num_apunte +1
	apu.apunte			=	num_apunte	
	apu.orden_apunte	=	num_apunte
	res 					= f_insert_contaapun(apu) 
	if res = false then
		error_num = 7
	end if
	
	// Apunte al banco por los gastos. sólo si hay gastos y si se 
	// puso el importe sin descontar los gastos
	IF datos_salida.importe_salida = datos_salida.importe THEN
		apu.cuenta 		=	f_cuenta_carbancos(codigo_empresa,em_banco.text)
		apu.concepto	=	f_concepto_contagene(codigo_empresa,"14")	
		apu.ampliacion	=	"Liquidación "+f_ampliacion_contagene(codigo_empresa,"14")+ " "+EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
		apu.origen		=	f_diario_contagene(codigo_empresa,"14")	
			
		if f_dh_contagene(codigo_empresa,"14")= "D" then
			apu.debe		= datos_salida.total_gastos
			apu.haber	= 0
		else
			apu.debe		= 0
			apu.haber	= datos_salida.total_gastos
		end if	
			
		num_apunte			=	num_apunte +1
		apu.apunte			=	num_apunte	
		apu.orden_apunte	=	num_apunte
		
		IF datos_salida.total_gastos <> 0 THEN
			res 					= f_insert_contaapun(apu) 
			if res = false then
				error_num = 8
			end if
		END IF	
	END IF		
		//******************************************************************
		// 2. Apuntes a las cuentas de gastos obtenidas en ventana auxiliar
		//******************************************************************
	
		str_costesapu coste
		// apunte a la cuenta de intereses
		// Sólo si hay intereses 
		if datos_salida.intereses > 0 then
			apu.cuenta 		=	datos_salida.cta_intereses
			apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
			apu.ampliacion	=	"Liquidación " +f_ampliacion_contagene(codigo_empresa,"19")+EM_REMESA.TEXT +"  " + f_nombre_banco_abr(codigo_empresa,el_banco)
			apu.origen		=	f_diario_contagene(codigo_empresa,"19")	
			
			if f_dh_contagene(codigo_empresa,"19")= "D" then
				apu.debe		=	datos_salida.intereses
				apu.haber	=	0
			else
				apu.debe		=	0
				apu.haber	=	datos_salida.intereses
			end if	
			
			num_apunte			=	num_apunte +1
			apu.apunte			=	num_apunte	
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
		END IF
	
		
		// Apunte para el resto de gastos
		for i= 1 to datos_salida.num_gastos
			// Sólo si hay gasto
			if datos_salida.gastos[i] >0 then
				apu.cuenta 		=	datos_salida.cuentas[i]
				apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"19")+ EM_REMESA.TEXT +"  " + f_nombre_banco_abr(codigo_empresa,el_banco)
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
					EXIT
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
	
	// Apunte por Diferencias de Cambio
	
	IF Dec(em_difcambio.text) <> 0 THEN
		IF Dec(em_difcambio.text) > 0 THEN
			apu.cuenta 		=	f_cuenta_contagene(codigo_empresa,'26')
			apu.concepto	=	f_concepto_contagene(codigo_empresa,"26")	
			apu.ampliacion	=	"Liquidación Remesa Nº "+EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
			apu.origen		=	f_diario_contagene(codigo_empresa,"26")	
				
			if f_dh_contagene(codigo_empresa,"26")= "D" then
				apu.debe		= Dec(em_difcambio.text)
				apu.haber	= 0
			else
				apu.debe		= 0
				apu.haber	= Dec(em_difcambio.text)
			end if	
				
			num_apunte			=	num_apunte +1
			apu.apunte			=	num_apunte	
			apu.orden_apunte	=	num_apunte
			res 					= f_insert_contaapun(apu) 
			if res = false then
				error_num = 8
			end if
		ELSE
			apu.cuenta 		=	f_cuenta_contagene(codigo_empresa,'27')
			apu.concepto	=	f_concepto_contagene(codigo_empresa,"27")	
			apu.ampliacion	=	"Liquidación Remesa Nº "+EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
			apu.origen		=	f_diario_contagene(codigo_empresa,"27")	
				
			if f_dh_contagene(codigo_empresa,"27")= "D" then
				apu.debe		= Dec(em_difcambio.text) * -1
				apu.haber	= 0
			else
				apu.debe		= 0
				apu.haber	= Dec(em_difcambio.text) * -1
			end if	
				
			num_apunte			=	num_apunte +1
			apu.apunte			=	num_apunte	
			apu.orden_apunte	=	num_apunte
			res 					= f_insert_contaapun(apu) 
			if res = false then
				error_num = 8
			end if
		END IF
	END IF		

	//************************************************
	// 3. Apunte a los clientes. Sólo a los punteados
	//*************************************************
					
	// para cada cliente
	Dec	impefec
	
	for i = 1 to datos.num_efectos
		SELECT carefectos.cuenta,carefectos.factura,carefectos.fvto,
				 carefectos.importe INTO 
				 :apu.cuenta,:apu.documento,:apu.ffactura,:impefec FROM carefectos
		WHERE carefectos.empresa 	= :codigo_empresa
		AND	carefectos.anyo 		= :datos.efectos_anyo[i]
		AND	carefectos.orden 		= :datos.efectos_orden[i];
									
		apu.concepto	= f_concepto_contagene(codigo_empresa,"15")	

		apu.ampliacion	=	f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemString(i,"tipodoc")) + " Vto. " + String(Date(dw_1.GetItemDateTime(i,"fvto")),"dd/mm/yy")
		apu.origen		=	f_diario_contagene(codigo_empresa,"15")	
				
		if f_dh_contagene(codigo_empresa,"15")= "D" then
			apu.debe		=	impefec
			apu.haber	=	0
		else
			apu.debe		=	0
			apu.haber	=	impefec
		end if	
			
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
		res = f_insert_contaapun(apu) 
		if res = false then
			error_num = 9
			exit
		end if
		//****************************************************************
		// Los efectos que se han liquidado pasan al histórico
		
		int linea_efecto
		str_carhistorico historico
		
		// Borramos de carefectos los liquidados y los copiamos al histórico.
		SELECT carefectos.anyofra,carefectos.factura,carefectos.recibo,
				carefectos.fvto, carefectos.ffra, carefectos.fvto_original,  
				carefectos.importe,carefectos.divisas,carefectos.monedas,
				carefectos.fpago,carefectos.tipodoc,carefectos.banco,   
				carefectos.remesa,carefectos.fremesa,
				carefectos.agente1,carefectos.pais,carefectos.cuenta,   
				carefectos.domiciliacion,carefectos.Nacional,
				carefectos.observaciones,carefectos.libre,carefectos.gasto,   
				carefectos.fdevolucion,carefectos.agrupado,   
				carefectos.efectoagrupa,carefectos.anyoagrupa,
				carefectos.cliente,carefectos.anyo_remesa  
				INTO :historico.anyofra,:historico.factura,:historico.recibo,   
					:historico.fvto,:historico.ffra, :historico.fvto_original,  
					:historico.importe,:historico.divisas,:historico.monedas,   
					:historico.fpago,:historico.tipodoc,:historico.banco,   
					:historico.remesa,:historico.fremesa,  
					:historico.agente1,:historico.pais,:historico.cuenta,   
					:historico.domiciliacion,:historico.nacional,   
					:historico.observaciones,:historico.libre,:historico.gasto,   
					:historico.fdevolucion,:historico.agrupado,
					:historico.efectoagrupa,:historico.anyoagrupa,   
					:historico.cliente,:historico.anyo_remesa  FROM carefectos  
				WHERE carefectos.empresa = :codigo_empresa
				AND  	carefectos.anyo 	= :datos.efectos_anyo[i]
				AND   carefectos.orden 	= :datos.efectos_orden[i];
				IF SQLCA.SQLCODE <> 0 Then error_num = 18 
				historico.empresa	= codigo_empresa
				historico.anyo		= datos.efectos_anyo[i] 
				historico.orden	= datos.efectos_orden[i]
				historico.fcobro	= historico.fvto
				historico.situacion="9"
				SELECT max(carhistorico.linea ) INTO :linea_efecto FROM carhistorico  
				WHERE ( carhistorico.empresa 	= :codigo_empresa ) AND  
						( carhistorico.anyo 		= :datos.efectos_anyo[i] ) AND  
						( carhistorico.orden 	= :datos.efectos_orden[i] ) USING SQLCA;
				if sqlca.sqlcode=100 then linea_efecto=0
				if isnull(linea_efecto) then linea_efecto=0
				historico.linea=linea_efecto + 1
				
				if not f_insert_carhistorico(historico) then error_num = 18
			
				// Borro el efecto de carefectos
				DELETE FROM carefectos  
				WHERE ( carefectos.empresa = :codigo_empresa ) AND  
						( carefectos.anyo 	= :datos.efectos_anyo[i] ) AND  
						( carefectos.orden 	= :datos.efectos_orden[i] ) USING SQLCA;
			IF SQLCA.SQLCODE <> 0 Then error_num = 19
	next
	
	
	//****************************************************************
	// Sólo se cambia a situación 3 si ya están todos marcados
	//*****************************************************************
	Long	cuantas
	SELECT Count(*) INTO :cuantas FROM carefectos
	WHERE	carefectos.empresa 		= :codigo_empresa
	AND	carefectos.banco 			= :el_banco
	AND	carefectos.anyo_remesa 	= :anyo_int
	AND	carefectos.remesa 		= :rem_int
	AND	carefectos.Nacional		= 'N';
	if cuantas = 0 then
		// Si no queda nada por liquidar situación 5 (cancelada)	
		UPDATE carremesas  SET situacion = "5"  
		where	(carremesas.empresa 		= :codigo_empresa) and
				(carremesas.anyo 			= :anyo_int ) and
				(carremesas.banco 		= :el_banco) AND
				(carremesas.naci_extra 	= "E") and
				(carremesas.remesa 		= :rem_int);
	ELSE
		// Si queda algo por liquidar situación 4 (liquidada)
		UPDATE carremesas  SET situacion = "4"  
		where	(carremesas.empresa 		= :codigo_empresa) and
				(carremesas.anyo 			= :anyo_int ) and
				(carremesas.banco 		= :el_banco) AND
				(carremesas.naci_extra 	= "E") and
				(carremesas.remesa 		= :rem_int);
	end if
end if	

//******************************************************************
// Comprobación de los errores
//*******************************************************************

if error_num = 0 then
	f_mensaje("BIEN","La remesa ha sido Liquidada")
	
	//limpiamos pantalla
	dw_1.reset()
	em_remesa.text = ""
	st_5.visible 	= false
	st_fecha.text 	= ""
	totliquida 		= 0
	totptas			= 0
	mone				= ""
	em_liquida.text	= ""
	em_apunbanco.text = ""
	em_difcambio.text = ""
	em_cambio.text		= ""
	
	commit;
	f_activar_campo(em_banco)
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
		case 18
			f_mensaje("ATENCIÓN","No encuentro el efecto en cartera")
	end choose
end if
end event

type st_5 from statictext within w_liquidacion_rem_expor_original
integer x = 1755
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

type st_fecha from statictext within w_liquidacion_rem_expor_original
integer x = 1760
integer y = 200
integer width = 265
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_liquidacion_rem_expor_original
integer x = 1280
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

type em_anyo from editmask within w_liquidacion_rem_expor_original
integer x = 1285
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

type st_9 from statictext within w_liquidacion_rem_expor_original
integer x = 1093
integer y = 840
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

type em_fcontable from editmask within w_liquidacion_rem_expor_original
integer x = 1605
integer y = 832
integer width = 320
integer height = 88
integer taborder = 50
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
string displaydata = "Ä"
end type

type dw_2 from datawindow within w_liquidacion_rem_expor_original
boolean visible = false
integer x = 786
integer y = 288
integer width = 1797
integer height = 492
boolean bringtotop = true
string dataobject = "dw_ayuda_remesas_liq_expor"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)
	CASE "remesa","fremesa","importe","nom_tipodoc","nom_tipo_rem"
		em_remesa.text = string(getitemnumber(row,"remesa"))
		st_fecha.text 	= string(date(getitemdatetime(row,"fremesa")))
		dw_2.visible 	= false	
		if st_fecha.text <> "" then		
			st_5.visible = true		
		end if
		
		// En la variable instancia "inst_tipodoc" el tipodoc de la remesa
		inst_tipodoc = dw_2.getitemstring(row,"tipodoc")
		
//		// En la variable instancia "inst_tiporem" el tipo de la remesa
//		inst_tiporem = dw_2.getitemstring(row,"tiporem")
		
		// Efectos de la remesa seleccionada
		dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_remesa.text),es_nacional,"6")
	end choose
end event

type cb_marca from commandbutton within w_liquidacion_rem_expor_original
integer x = 23
integer y = 824
integer width = 517
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Marcar"
end type

event clicked;int 		i
decimal 	var_importe,var_ptas
string mone_ant
boolean primero
totliquida = 0

totptas = 0

primero = true
FOR i = 1 TO dw_1.rowcount()
		
	mone	 		= dw_1.GetItemString(i,"monedas")
	if primero then
		mone_ant = mone
		primero = false
	end if
	if mone_ant <> mone then
		messagebox("No se puede continuar","Se han seleccionado efectos en varias monedas")
		return
	end if
	dw_1.setitem(i,"CAREFECTOS_LIBRE","S")
	var_importe = dw_1.GetitemNumber(i,"divisas")
	var_ptas	  	= dw_1.getitemnumber(i,"importe")
	totliquida 	= totliquida + var_importe
	totptas	  	= totptas + var_ptas
NEXT

em_liquida.text= String(totliquida,f_redondeo_moneda(mone))
em_liquida_pts.text= String(totptas,f_redondeo_moneda(em.moneda_emp))




end event

type cb_desmarca from commandbutton within w_liquidacion_rem_expor_original
integer x = 539
integer y = 824
integer width = 517
integer height = 80
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
	dw_1.setitem(i,"CAREFECTOS_LIBRE","N")
next

em_liquida.text 	= ""
em_liquida_pts.text 	= ""
totliquida 			= 0
totptas 				= 0
em_cambio.text = ""
em_difcambio.text = ""
em_apunbanco.text = ""
end event

type dw_1 from datawindow within w_liquidacion_rem_expor_original
integer x = 23
integer y = 288
integer width = 2683
integer height = 536
string dataobject = "dw_liquida_rem_expor"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF dwo.Name = "e_factura" Then
	SetSort("")
	SetSort("factura")
	Sort()
	Return
END IF
IF dwo.Name = "e_vto" Then
	SetSort("")
	SetSort("fvto")
	Sort()
	Return
END IF
IF dwo.Name = "e_divisas" Then
	SetSort("")
	SetSort("divisas")
	Sort()
	Return
END IF

IF dwo.Name = "e_cliente" Then
	SetSort("")
	SetSort("genter_razon")
	Sort()
	Return
END IF

if row=0 then return

Decimal var_importe,var_ptas
String controles,moneda

IF dwo.Name = "carefectos_libre" THEN
	controles =  This.GetItemString(row,"carefectos_libre")
	IF mone = "" THEN
		mone =  This.GetItemString(row,"monedas")
		st_122.text = f_nombre_moneda_abr(mone)
		IF mone = em.moneda_emp THEN
			em_cambio.text = '1'
		else
			em_cambio.text = ''
		END IF
	END IF
	IF controles = "S" THEN
	  This.SetItem(row,"carefectos_libre","N")
	  var_importe = this.getitemnumber(row,"divisas")
	  var_ptas	  = this.getitemnumber(row,"importe")
	  totliquida = totliquida - var_importe
	  totptas	 = totptas - var_ptas
  	  em_liquida_pts.text=string(totptas,f_redondeo_moneda(em.moneda_emp))
	  em_liquida.text=string(totliquida,f_redondeo_moneda(mone))
	  em_cambio.text = ""
	  em_difcambio.text = ""
	  em_apunbanco.text = ""
	  This.AcceptText()
	  string marca
	  boolean alguno
	  long i
	  
	  for i = 1 to dw_1.rowcount() 
			marca  = GetItemString(row,"carefectos_libre") 
			if marca = "S" then alguno = true					
	  next
	  if not alguno then mone = ""
	  
	ELSE
		moneda =  This.GetItemString(row,"monedas")
		IF mone <> moneda THEN
			f_mensaje("ERROR","La moneda es distinta")
			RETURN
		END IF
	  This.SetItem(row,"carefectos_libre","S")
	  var_importe=this.getitemnumber(row,"divisas")
	  var_ptas	  = this.getitemnumber(row,"importe")
	  totliquida = totliquida + var_importe
	  totptas	 = totptas + var_ptas
	  em_liquida.text=string(totliquida,f_redondeo_moneda(mone))
	  em_liquida_pts.text=string(totptas,f_redondeo_moneda(em.moneda_emp))
	  em_cambio.text = ""
	  em_difcambio.text = ""
	  em_apunbanco.text = ""
	  
	  This.AcceptText()
	End If
END IF



end event

type st_7 from statictext within w_liquidacion_rem_expor_original
integer x = 23
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

type st_10 from statictext within w_liquidacion_rem_expor_original
integer x = 992
integer y = 1032
integer width = 585
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Divisas. a Liquidar :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within w_liquidacion_rem_expor_original
integer x = 1303
integer y = 1136
integer width = 283
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Cambio :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_12 from statictext within w_liquidacion_rem_expor_original
integer x = 946
integer y = 1348
integer width = 658
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Diferencia de Cambio :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_liquida from editmask within w_liquidacion_rem_expor_original
integer x = 1605
integer y = 1020
integer width = 434
integer height = 92
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
boolean border = false
alignment alignment = right!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxxxxxxxxxx"
string displaydata = "~b"
end type

type em_cambio from u_em_campo within w_liquidacion_rem_expor_original
integer x = 1609
integer y = 1132
integer width = 416
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "#,##0.00####"
end type

event modified;dec	   cambio
Dec		impptas,impdiv,difcambio

IF em_cambio.text <> "" THEN
	impdiv = Dec(em_liquida.text)
	cambio = dec(em_cambio.text)
	impptas = impdiv * cambio
	
	em_apunbanco.text = String(impptas,f_mascara_moneda(em.moneda_emp))
	difcambio = impptas - totptas 
	em_difcambio.text = String(difcambio,f_mascara_moneda(em.moneda_emp))
END IF
end event

type em_apunbanco from u_em_campo within w_liquidacion_rem_expor_original
integer x = 1609
integer y = 1232
integer width = 416
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;Dec	difcambio

difcambio = Dec(em_apunbanco.text) - totptas
em_difcambio.text = String(difcambio,f_mascara_moneda(em.moneda_emp))
end event

type st_111 from statictext within w_liquidacion_rem_expor_original
integer x = 937
integer y = 1240
integer width = 667
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean focusrectangle = false
end type

type em_difcambio from u_em_campo within w_liquidacion_rem_expor_original
event modificado pbm_custom02
integer x = 1609
integer y = 1332
integer width = 416
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;Dec	difcambio

difcambio = totptas - Dec(em_apunbanco.text) 
em_difcambio.text = String(difcambio,f_mascara_moneda(em.moneda_emp))
end event

type st_122 from statictext within w_liquidacion_rem_expor_original
integer x = 2048
integer y = 1020
integer width = 283
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_125 from statictext within w_liquidacion_rem_expor_original
integer x = 992
integer y = 936
integer width = 585
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Importe a Liquidar :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_liquida_pts from editmask within w_liquidacion_rem_expor_original
integer x = 1605
integer y = 920
integer width = 434
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
boolean border = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

type ln_1 from line within w_liquidacion_rem_expor_original
long linecolor = 16711680
integer linethickness = 8
integer beginx = 905
integer beginy = 920
integer endx = 905
integer endy = 1424
end type

type ln_2 from line within w_liquidacion_rem_expor_original
long linecolor = 16711680
integer linethickness = 8
integer beginx = 901
integer beginy = 920
integer endx = 1001
integer endy = 920
end type

type ln_3 from line within w_liquidacion_rem_expor_original
long linecolor = 16711680
integer linethickness = 8
integer beginx = 905
integer beginy = 1120
integer endx = 1001
integer endy = 1120
end type

type ln_4 from line within w_liquidacion_rem_expor_original
long linecolor = 16711680
integer linethickness = 8
integer beginx = 905
integer beginy = 1424
integer endx = 1001
integer endy = 1424
end type

type st_1 from statictext within w_liquidacion_rem_expor_original
integer x = 480
integer y = 980
integer width = 352
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "A Liquidar :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2236 from statictext within w_liquidacion_rem_expor_original
integer x = 443
integer y = 1216
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Liquidación :"
alignment alignment = right!
boolean focusrectangle = false
end type

