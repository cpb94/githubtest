$PBExportHeader$w_asiento_cierre_old.srw
$PBExportComments$€
forward
global type w_asiento_cierre_old from w_int_con_empresa
end type
type pb_2 from upb_salir within w_asiento_cierre_old
end type
type dw_1 from datawindow within w_asiento_cierre_old
end type
type cb_2 from commandbutton within w_asiento_cierre_old
end type
type uo_ejercicio_origen from u_ejercicio within w_asiento_cierre_old
end type
type st_1 from statictext within w_asiento_cierre_old
end type
type st_3 from statictext within w_asiento_cierre_old
end type
end forward

global type w_asiento_cierre_old from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2935
integer height = 1344
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
cb_2 cb_2
uo_ejercicio_origen uo_ejercicio_origen
st_1 st_1
st_3 st_3
end type
global w_asiento_cierre_old w_asiento_cierre_old

type variables
integer ejercicio_origen
end variables

forward prototypes
public subroutine f_control_cuenta (integer ejer, string emp, string cuen)
end prototypes

public subroutine f_control_cuenta (integer ejer, string emp, string cuen);String	descrip,anal,tipcta,direc,cos
Integer	niv,ejer_ant

SELECT contaplan.titulo INTO :descrip FROM contaplan
WHERE contaplan.ejercicio 	= :ejer
AND	contaplan.empresa		= :emp
AND	contaplan.cuenta		= :cuen USING SQLCA;

IF SQLCA.SQLCode = 100 THEN
	ejer_ant = ejer - 1
	SELECT contaplan.titulo,contaplan.analitica,
			 contaplan.tipocta,contaplan.directos,
			 contaplan.nivel,contaplan.coste
		INTO :descrip,:anal,:tipcta,:direc,:niv,:cos FROM contaplan
		WHERE contaplan.ejercicio 	= :ejer_ant
		AND	contaplan.empresa		= :emp
		AND	contaplan.cuenta		= :cuen USING SQLCA;
		
	INSERT INTO contaplan ( contaplan.ejercicio,contaplan.empresa,
									contaplan.cuenta,
									contaplan.titulo,contaplan.analitica,
			 						contaplan.tipocta,contaplan.directos,
			 						contaplan.nivel,contaplan.coste)
		VALUES (:ejer,:emp,:cuen,:descrip,:anal,:tipcta,:direc,:niv,:cos);
END IF
end subroutine

event open;call super::open;This.title = " ASIENTO DE CIERRE CONTABLE"
f_activar_campo(uo_ejercicio_origen.em_ejercicio)




end event

on w_asiento_cierre_old.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.uo_ejercicio_origen=create uo_ejercicio_origen
this.st_1=create st_1
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.uo_ejercicio_origen
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_3
end on

on w_asiento_cierre_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.uo_ejercicio_origen)
destroy(this.st_1)
destroy(this.st_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_asiento_cierre_old
integer x = 1495
integer y = 116
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_asiento_cierre_old
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_asiento_cierre_old
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_asiento_cierre_old
integer x = 2706
integer y = 64
integer width = 146
integer height = 136
integer taborder = 0
end type

type dw_1 from datawindow within w_asiento_cierre_old
boolean visible = false
integer x = 2446
integer y = 264
integer width = 421
integer height = 144
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_asiento_cierre"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_asiento_cierre_old
integer x = 1989
integer y = 580
integer width = 370
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Procesar"
end type

event clicked;int ejer_orig,ejer_sig,registros,i,op,numapu,cuantos
boolean correcto
String	cuentad,cuentah,origc,origa,orig

correcto = true
cuentad	= "000000000"
cuentah	= "599999999"

op = MessageBox("ATENCIÓN","Se va a proceder a realizar el asiento de Cierre",Question!,YesNo!,2)
IF op = 2 THEN
	RETURN
END IF

ejer_orig = integer(uo_ejercicio_origen.em_ejercicio.text)
ejer_sig		= ejer_orig + 1

orig = f_diario_contagene(codigo_empresa,"30")

cuantos=0

select count(*) 
into :cuantos
from contaapun 
WHERE contaapun.ejercicio 	= :ejer_orig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :orig ;

if cuantos>0 then
	f_mensaje("Atención","Hay asiento previo de cierre"+char(13)+"El asiento no se graba")
	return;
end if

orig = f_diario_contagene(codigo_empresa,"18")

cuantos=0

select count(*) 
into :cuantos
from contaapun 
WHERE contaapun.ejercicio 	= :ejer_sig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :orig ;

if cuantos>0 then
	f_mensaje("Atención","Hay asiento de apertura provisional"+char(13)+"El asiento no se graba")
	return;
end if

orig = f_diario_contagene(codigo_empresa,"31")

cuantos=0

select count(*) 
into :cuantos
from contaapun 
WHERE contaapun.ejercicio 	= :ejer_sig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :orig ;

if cuantos>0 then
	f_mensaje("Atención","Hay asiento de apertura real"+char(13)+"El asiento no se graba")
	return;
end if

/*// Primero borramos los asientos de Apertura Provisional y Apertura
// real del año siguiente

origc = f_diario_contagene(codigo_empresa,"18")

DELETE FROM contaapun
WHERE contaapun.ejercicio 	= :ejer_sig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :origc ;*/

origa = f_diario_contagene(codigo_empresa,"31")

/*DELETE FROM contaapun
WHERE contaapun.ejercicio 	= :ejer_sig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :origa ;


// Luego borramos los asientos anteriores de cierre*/

origc = f_diario_contagene(codigo_empresa,"30")
/*
DELETE FROM contaapun
WHERE contaapun.ejercicio 	= :ejer_orig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :origc ;*/


dw_1.settransobject(sqlca)

registros = dw_1.retrieve(codigo_empresa,ejer_orig,cuentad,cuentah)

// Si no hay registros acabamos
if registros <= 0 then
		f_mensaje("Atención"," No hay apuntes en ejercicio seleccionado")
		return
end if


// Estructura para el apunte de Cierre. Datos comunes a todos ellos
Str_contaapun apu  
dec{2} el_saldo
string la_cuenta

apu.origen		=	origc

apu.ejercicio 	=	ejer_orig
apu.empresa 	=	codigo_empresa
apu.fapunte		=	f_CIERRE_contaparam(codigo_empresa,ejer_orig)
apu.asiento		=	f_ultimo_asiento(ejer_orig,codigo_empresa,month(date(apu.fapunte)),apu.origen)

setnull(apu.diario)
setnull(apu.concepto)
apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"30")
setnull(apu.tipoapu)
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
apu.fvalor	= apu.fapunte
setnull(apu.docpunteo)
setnull(apu.coste)
setnull(apu.fregistro)
apu.cambio	=	1
apu.moneda	=	moneda_euro
apu.mes		=	month(date(apu.fapunte))
numapu 		= 0

// Para cada una de las cuentas
for i = 1 to registros 
	
	f_mensaje_proceso("Realizando cierre",i,registros)
	
	
	el_saldo		=	dw_1.getitemnumber(i,"saldo")
	apu.cuenta	=	dw_1.getitemstring(i,"cuenta")
	// si saldo cero no hace apunte
	IF IsNull(el_saldo) THEN el_saldo = 0
	IF el_saldo = 0 THEN
		CONTINUE
	END IF
	
	if el_saldo > 0 then 
		apu.haber = abs(el_saldo)
		apu.debe  = 0
	else
		apu.haber = 0
		apu.debe  = abs(el_saldo)	
	end if
	
	numapu = numapu + 1
	apu.apunte			=	numapu
	apu.orden_apunte	=	apu.apunte
	
	// Insertamos el apunte
	correcto = f_insert_contaapun(apu)
	if not correcto then exit
next

// Apunte de apertura en el ejercicio siguiente
apu.origen		=	origa

apu.ejercicio 	=	ejer_sig
apu.empresa 	=	codigo_empresa
apu.fapunte		=	f_inicio_contaparam(codigo_empresa,ejer_sig)
apu.asiento		=	f_ultimo_asiento(ejer_sig,codigo_empresa,month(date(apu.fapunte)),apu.origen)

setnull(apu.diario)
setnull(apu.concepto)
apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"31")
setnull(apu.tipoapu)
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
apu.fvalor	= apu.fapunte
setnull(apu.docpunteo)
setnull(apu.coste)
setnull(apu.fregistro)
apu.cambio	=	1
apu.moneda	=	moneda_euro
apu.mes		=	month(date(apu.fapunte))

numapu 		= 0

// Para cada una de las cuentas
for i = 1 to registros 
	
	
	f_mensaje_proceso("Realizando apertura",i,registros)
	
	el_saldo		=	dw_1.getitemnumber(i,"saldo")
	apu.cuenta	=	dw_1.getitemstring(i,"cuenta")
	// Controlamos si la cuenta existe en el ejercicio siguiente
	// si no existe la crea
	f_control_cuenta(ejer_sig,codigo_empresa,apu.cuenta)
	// si saldo cero no hace apunte
	IF IsNull(el_saldo) THEN el_saldo = 0
	IF el_saldo = 0 THEN
		CONTINUE
	END IF
	
	if el_saldo > 0 then 
		apu.haber = 0
		apu.debe  = abs(el_saldo)
	else
		apu.haber = abs(el_saldo)
		apu.debe  = 0	
	end if
	
	numapu = numapu + 1
	apu.apunte			=	numapu
	apu.orden_apunte	=	apu.apunte
	
	// Insertamos el apunte
	correcto = f_insert_contaapun(apu)
	if not correcto then exit
next

if correcto = true then
	f_mensaje("Correcto","El apunte se hizo correctamente")
	commit;
else
	f_mensaje("Atención","El apunte no se ha grabado")
	rollback;
END IF



end event

type uo_ejercicio_origen from u_ejercicio within w_asiento_cierre_old
event destroy ( )
integer x = 850
integer y = 520
integer width = 645
integer height = 304
integer taborder = 10
boolean bringtotop = true
end type

on uo_ejercicio_origen.destroy
call u_ejercicio::destroy
end on

type st_1 from statictext within w_asiento_cierre_old
integer x = 87
integer y = 172
integer width = 2386
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 65535
long backcolor = 12632256
boolean enabled = false
string text = "Asiento de Cierre Contable (Grupos 1 a 5) y Apertura en el año siguiente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_asiento_cierre_old
integer x = 347
integer y = 364
integer width = 2103
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "_ Lectura de los saldos, cuenta a cuenta del ejercicio a cerrar y traspaso al año siguiente."
boolean focusrectangle = false
end type

