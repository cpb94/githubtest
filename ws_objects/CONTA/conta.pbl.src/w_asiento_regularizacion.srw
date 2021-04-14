$PBExportHeader$w_asiento_regularizacion.srw
$PBExportComments$€
forward
global type w_asiento_regularizacion from w_int_con_empresa
end type
type pb_2 from upb_salir within w_asiento_regularizacion
end type
type dw_1 from datawindow within w_asiento_regularizacion
end type
type cb_2 from commandbutton within w_asiento_regularizacion
end type
type em_1 from u_em_campo within w_asiento_regularizacion
end type
type st_6 from statictext within w_asiento_regularizacion
end type
type st_nomcuenta from statictext within w_asiento_regularizacion
end type
type uo_ejercicio_origen from u_ejercicio within w_asiento_regularizacion
end type
type st_9 from statictext within w_asiento_regularizacion
end type
type st_1 from statictext within w_asiento_regularizacion
end type
type st_3 from statictext within w_asiento_regularizacion
end type
type st_4 from statictext within w_asiento_regularizacion
end type
type r_1 from rectangle within w_asiento_regularizacion
end type
type cbx_resu from checkbox within w_asiento_regularizacion
end type
end forward

global type w_asiento_regularizacion from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2889
integer height = 1432
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
cb_2 cb_2
em_1 em_1
st_6 st_6
st_nomcuenta st_nomcuenta
uo_ejercicio_origen uo_ejercicio_origen
st_9 st_9
st_1 st_1
st_3 st_3
st_4 st_4
r_1 r_1
cbx_resu cbx_resu
end type
global w_asiento_regularizacion w_asiento_regularizacion

type variables
integer ejercicio_origen
end variables

event open;call super::open;This.title = " ASIENTO DE REGULARIZACIÓN"
f_activar_campo(uo_ejercicio_origen.em_ejercicio)




end event

on w_asiento_regularizacion.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.em_1=create em_1
this.st_6=create st_6
this.st_nomcuenta=create st_nomcuenta
this.uo_ejercicio_origen=create uo_ejercicio_origen
this.st_9=create st_9
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.r_1=create r_1
this.cbx_resu=create cbx_resu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.st_nomcuenta
this.Control[iCurrent+7]=this.uo_ejercicio_origen
this.Control[iCurrent+8]=this.st_9
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.r_1
this.Control[iCurrent+13]=this.cbx_resu
end on

on w_asiento_regularizacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.em_1)
destroy(this.st_6)
destroy(this.st_nomcuenta)
destroy(this.uo_ejercicio_origen)
destroy(this.st_9)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.r_1)
destroy(this.cbx_resu)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_asiento_regularizacion
integer x = 1495
integer y = 116
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_asiento_regularizacion
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_asiento_regularizacion
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_asiento_regularizacion
integer x = 2551
integer y = 168
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_1 from datawindow within w_asiento_regularizacion
boolean visible = false
integer x = 1993
integer y = 408
integer width = 695
integer height = 144
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_asiento_regularizacion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_asiento_regularizacion
integer x = 2263
integer y = 1052
integer width = 370
integer height = 108
integer taborder = 30
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
String	cuentad,cuentah,orig

correcto = true
cuentad	= "600000000"
cuentah	= "799999999"

if em_1.text	=	"" then 
	f_mensaje("Atención","Debe introducir la cuenta")
	return
end if

IF Trim(st_nomcuenta.text) = "" THEN
	f_mensaje("Atención","La cuenta no existe")
	RETURN
END IF

op = MessageBox("ATENCIÓN","Se va a proceder a realizar el asiento de regularización",Question!,YesNo!,2)
IF op = 2 THEN
	RETURN
END IF

ejer_orig = integer(uo_ejercicio_origen.em_ejercicio.text)
ejer_sig	 = ejer_orig + 1

//Miramos si hay asientos de cierre, de apertura provisional y real y 
//de regularizacion.

orig = f_diario_contagene(codigo_empresa,"30")

cuantos=0

select count(*) 
into :cuantos
from contaapun 
WHERE contaapun.ejercicio 	= :ejer_orig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :orig ;

if cuantos>0 then
	f_mensaje("Atención","Hay asiento provisional de pp y gg")
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
	f_mensaje("Atención","Hay asiento de apertura provisional")
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
	f_mensaje("Atención","Hay asiento de apertura real")
	return;
end if

orig = f_diario_contagene(codigo_empresa,"29")

cuantos=0

select count(*) 
into :cuantos
from contaapun 
WHERE contaapun.ejercicio 	= :ejer_orig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :orig ;

if cuantos>0 then
	f_mensaje("Atención","Hay asiento de pp y gg real")
	return;
end if

/*// Primero borramos los asientos anteriores de cierre

orig = f_diario_contagene(codigo_empresa,"30")

DELETE FROM contaapun
WHERE contaapun.ejercicio 	= :ejer_orig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :orig ;

// Luego borramos los asientos de Apertura Provisional y Apertura
// real del año siguiente

orig = f_diario_contagene(codigo_empresa,"18")

DELETE FROM contaapun
WHERE contaapun.ejercicio 	= :ejer_sig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :orig ;

orig = f_diario_contagene(codigo_empresa,"31")

DELETE FROM contaapun
WHERE contaapun.ejercicio 	= :ejer_sig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :orig ;

// Y por ultimo borramos los asientos anteriores de regularizacion

orig = f_diario_contagene(codigo_empresa,"29")

DELETE FROM contaapun
WHERE contaapun.ejercicio 	= :ejer_orig
AND	contaapun.empresa		= :codigo_empresa
AND	contaapun.origen		= :orig ;*/


dw_1.settransobject(sqlca)

registros = dw_1.retrieve(codigo_empresa,ejer_orig,cuentad,cuentah)

// Si no hay registros acabamos
if registros <= 0 then
		f_mensaje("Atención"," No hay apuntes en ejercicio seleccionado")
		return
end if


// Estructura para el apunte. Datos comunes a todos ellos
Str_contaapun apu  
dec{2} el_saldo,total_saldo
string la_cuenta

apu.origen		=	orig

apu.ejercicio 	=	ejer_orig
apu.empresa 	=	codigo_empresa
apu.fapunte		=	f_cierre_contaparam(codigo_empresa,ejer_orig)
apu.asiento		=	f_ultimo_asiento(ejer_orig,codigo_empresa,month(date(apu.fapunte)),apu.origen)

setnull(apu.diario)
setnull(apu.concepto)
apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"29")
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
apu.moneda	=	"1"
apu.mes		=	month(date(apu.fapunte))

total_saldo = 0
numapu 		= 0

// Para cada una de las cuentas
for i = 1 to registros 
	
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
	
	total_saldo = total_saldo + el_saldo
	
	// Insertamos el apunte
	correcto = f_insert_contaapun(apu)
	if not correcto then exit
	
	// Si no lo quieren resumido se hace un apunte por cada cuenta a la
	// cuenta de perdidas y ganancias
	IF NOT(cbx_resu.checked) THEN
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
		apu.cuenta	=	em_1.text	
		f_insert_contaapun(apu)
	END IF
next

// apunte a la cuenta de pérdidas y ganancias introducidas

if correcto = true then
	IF cbx_resu.checked THEN
		apu.cuenta	=	em_1.text	
		apu.apunte	=	numapu+1
		apu.orden_apunte	=	numapu+1
		
		if total_saldo > 0 then
			apu.debe		=	abs(total_saldo)
			apu.haber	=	0
		else
			apu.debe		=	0
			apu.haber	=	abs(total_saldo)
		end if
		
		//apunte a pérdidas y ganancias
		boolean correcto2
		
		correcto2	=	f_insert_contaapun(apu)
		
		if correcto2 then
			f_mensaje("Correcto","El apunte se hizo correctamente")
			
			commit;
		else
			f_mensaje("Atención","El apunte no se ha grabado")
			rollback;
		end if
	END IF
else
	f_mensaje("Atención","El apunte no se ha grabado")
	rollback;
end if


end event

type em_1 from u_em_campo within w_asiento_regularizacion
integer x = 1051
integer y = 712
integer width = 421
integer height = 80
integer taborder = 20
end type

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_contaplan"
ue_titulo      = "AYUDA SELECCION DE CUENTAS"
ue_filtro      = "ejercicio = " + uo_ejercicio_origen.em_ejercicio.text 
end event

event modificado;call super::modificado;int max,niv,ejer

niv = 0
ejer = integer(uo_ejercicio_origen.em_ejercicio.text)

select nivel into :niv from contaplan
where cuenta = :em_1.text
AND   ejercicio = :ejer
and 	empresa = :codigo_empresa;

select niveles into :max from contaparam
where (empresa = :codigo_empresa) 
and (ejercicio = :ejer );

if niv <> max then
	
	f_mensaje("Atención","La cuenta no es del máximo nivel")
   This.Text = ""   
   f_activar_campo(em_1)
	
else
	
	st_nomcuenta.text=f_nombre_contaplan(ejer,codigo_empresa,em_1.text)
	
end if

end event

type st_6 from statictext within w_asiento_regularizacion
integer x = 846
integer y = 604
integer width = 1623
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
string text = "Pérdidas y Ganancias "
boolean focusrectangle = false
end type

type st_nomcuenta from statictext within w_asiento_regularizacion
integer x = 1490
integer y = 712
integer width = 1042
integer height = 76
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

type uo_ejercicio_origen from u_ejercicio within w_asiento_regularizacion
event destroy ( )
integer x = 78
integer y = 604
integer width = 645
integer height = 304
integer taborder = 10
boolean bringtotop = true
end type

on uo_ejercicio_origen.destroy
call u_ejercicio::destroy
end on

type st_9 from statictext within w_asiento_regularizacion
integer x = 791
integer y = 712
integer width = 247
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
string text = "Cuenta"
boolean focusrectangle = false
end type

type st_1 from statictext within w_asiento_regularizacion
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
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Asiento de PP y GG"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_asiento_regularizacion
integer x = 347
integer y = 364
integer width = 1865
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
string text = "_ Lectura de los saldos, cuenta a cuenta del ejercicio a regularizar."
boolean focusrectangle = false
end type

type st_4 from statictext within w_asiento_regularizacion
integer x = 347
integer y = 452
integer width = 2121
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
string text = "_ Grabación de los apuntes necesarios a la cuenta de Pérdidas y Ganancias."
boolean focusrectangle = false
end type

type r_1 from rectangle within w_asiento_regularizacion
long linecolor = 15793151
integer linethickness = 4
long fillcolor = 12632256
integer x = 773
integer y = 576
integer width = 1801
integer height = 436
end type

type cbx_resu from checkbox within w_asiento_regularizacion
integer x = 864
integer y = 896
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
string text = "Resumido"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

