$PBExportHeader$w_apertura_prov.srw
forward
global type w_apertura_prov from w_int_con_empresa
end type
type pb_2 from upb_salir within w_apertura_prov
end type
type st_1 from statictext within w_apertura_prov
end type
type st_2 from statictext within w_apertura_prov
end type
type dw_1 from datawindow within w_apertura_prov
end type
type cb_2 from commandbutton within w_apertura_prov
end type
type em_cuentadesde from u_em_campo within w_apertura_prov
end type
type em_cuentahasta from u_em_campo within w_apertura_prov
end type
type st_3 from statictext within w_apertura_prov
end type
type st_4 from statictext within w_apertura_prov
end type
type st_5 from statictext within w_apertura_prov
end type
type em_1 from u_em_campo within w_apertura_prov
end type
type st_6 from statictext within w_apertura_prov
end type
type st_7 from statictext within w_apertura_prov
end type
type uo_ejercicio_origen from u_ejercicio within w_apertura_prov
end type
type uo_ejercicio_destino from u_ejercicio within w_apertura_prov
end type
type st_8 from statictext within w_apertura_prov
end type
type st_9 from statictext within w_apertura_prov
end type
type cbx_equiv from checkbox within w_apertura_prov
end type
end forward

global type w_apertura_prov from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2917
integer height = 1432
string title = "Consulta de Movimientos"
pb_2 pb_2
st_1 st_1
st_2 st_2
dw_1 dw_1
cb_2 cb_2
em_cuentadesde em_cuentadesde
em_cuentahasta em_cuentahasta
st_3 st_3
st_4 st_4
st_5 st_5
em_1 em_1
st_6 st_6
st_7 st_7
uo_ejercicio_origen uo_ejercicio_origen
uo_ejercicio_destino uo_ejercicio_destino
st_8 st_8
st_9 st_9
cbx_equiv cbx_equiv
end type
global w_apertura_prov w_apertura_prov

type variables
integer ejercicio_origen,ejercicio_destino
end variables

forward prototypes
public function boolean f_cuenta_equivalencia (decimal arg_ejercicio, string arg_empresa, string arg_cuenta, integer arg_ejer_dest, decimal arg_saldo, ref integer ai_apunte)
end prototypes

public function boolean f_cuenta_equivalencia (decimal arg_ejercicio, string arg_empresa, string arg_cuenta, integer arg_ejer_dest, decimal arg_saldo, ref integer ai_apunte);string ls_cuenta,ls_cuenta_equiv
boolean correcto
dec el_saldo
correcto = true
Str_contaapun apu  

select contaplan_equivalencia.cuenta_equiv into :ls_cuenta_equiv
from contaplan_equivalencia
where contaplan_equivalencia.cuenta_vieja =:arg_cuenta
and   contaplan_equivalencia.ejercicio =:arg_ejercicio
and   contaplan_equivalencia.empresa =:arg_empresa
using sqlca;


if not f_nulo_blanco(ls_cuenta_equiv) and &
			trim(ls_cuenta_equiv) <> "D" then
	
		
	//1º generamos otro asiento con 
	// liquidamos la cuenta_vieja
	// Estructura para el apunte. Datos comunes a todos ellos
	
		
	// Origen especial para la apertura Provisional
	apu.origen		=	f_diario_contagene(arg_empresa,"18")

	apu.ejercicio 	=	arg_ejer_dest
	apu.empresa 	=	arg_empresa
	apu.fapunte		=	datetime(date("01/01/" + string(arg_ejer_dest))) // día 1/1/ejr_dest
	apu.asiento		=	f_ultimo_asiento(arg_ejer_dest,arg_empresa,month(date(apu.fapunte)),apu.origen)
	
	setnull(apu.diario)
	setnull(apu.concepto)
	apu.ampliacion	=	f_ampliacion_contagene(arg_empresa,"18")
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
	apu.moneda	=	f_moneda_empresa(arg_empresa)
	apu.mes		=	1
	
	//setpointer(hourglass!)
		
	el_saldo		=	arg_saldo
	apu.cuenta	=	arg_cuenta
		
	
	if el_saldo >= 0 then 
		apu.debe = 0
		apu.haber = abs(el_saldo)	
	else
		apu.debe =abs(el_saldo)	
		apu.haber = 0
	end if
	ai_apunte ++
	apu.apunte	=	ai_apunte 
	apu.orden_apunte	=	ai_apunte 

			
	// Insertamos el apunte
	correcto = f_insert_contaapun(apu)
	
	
	//2º apunte asobre la cuenta de equivalencia
	// Origen especial para la apertura Provisional
	apu.cuenta	=	ls_cuenta_equiv
			
	if el_saldo >= 0 then 
		apu.debe = abs(el_saldo)
		apu.haber = 0
	else
		apu.debe = 0
		apu.haber = abs(el_saldo)	
	end if
	ai_apunte ++	
	apu.apunte	=	ai_apunte 
	apu.orden_apunte	=	ai_apunte 

			
	// Insertamos el apunte
	correcto = f_insert_contaapun(apu)
	
		
	
	
end if

return correcto


end function

event open;call super::open;This.title = " APERTURA PROVISIONAL"
f_activar_campo(uo_ejercicio_origen.em_ejercicio)




end event

on w_apertura_prov.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.em_cuentadesde=create em_cuentadesde
this.em_cuentahasta=create em_cuentahasta
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.em_1=create em_1
this.st_6=create st_6
this.st_7=create st_7
this.uo_ejercicio_origen=create uo_ejercicio_origen
this.uo_ejercicio_destino=create uo_ejercicio_destino
this.st_8=create st_8
this.st_9=create st_9
this.cbx_equiv=create cbx_equiv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.em_cuentadesde
this.Control[iCurrent+7]=this.em_cuentahasta
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.em_1
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.uo_ejercicio_origen
this.Control[iCurrent+15]=this.uo_ejercicio_destino
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.st_9
this.Control[iCurrent+18]=this.cbx_equiv
end on

on w_apertura_prov.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.em_cuentadesde)
destroy(this.em_cuentahasta)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.em_1)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.uo_ejercicio_origen)
destroy(this.uo_ejercicio_destino)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.cbx_equiv)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_apertura_prov
integer x = 1495
integer y = 116
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_apertura_prov
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_apertura_prov
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_apertura_prov
integer x = 2624
integer y = 208
integer width = 146
integer height = 136
integer taborder = 0
end type

type st_1 from statictext within w_apertura_prov
integer x = 727
integer y = 176
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Origen :"
boolean focusrectangle = false
end type

type st_2 from statictext within w_apertura_prov
integer x = 1449
integer y = 184
integer width = 320
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Destino :"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_apertura_prov
boolean visible = false
integer x = 1993
integer y = 408
integer width = 695
integer height = 144
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_apertura_prov"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_apertura_prov
integer x = 2263
integer y = 1052
integer width = 370
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Procesar"
end type

event clicked;int ejer_orig,ejer_dest,registros,i,opci,li_apunte
boolean correcto
correcto = true



opci = messagebox("Atención","Este programa realiza la apertura provisional " + &
					"borrando las anteriores. ¿ Desea continuar ? ",question!,yesno!,2)

if opci = 2 then return

if em_1.text	=	"" then 
	f_mensaje("Atención","Debe introducir la cuenta")
	return
end if


// Si pone las cuentas ponemos las máximas
if em_cuentadesde.text = "" then em_cuentadesde.text = "1"
if em_cuentahasta.text = "" then em_cuentahasta.text = "9"


ejer_orig = integer(uo_ejercicio_origen.em_ejercicio.text)
ejer_dest = integer(uo_ejercicio_destino.em_ejercicio.text)

dw_1.settransobject(sqlca)

registros = dw_1.retrieve(codigo_empresa,ejer_orig,em_cuentadesde.text,em_cuentahasta.text)




// Si no hay registros acabamos
if registros <= 0 then
		f_mensaje("Atención","El apunte no se ha grabado. No hay apuntes en ejercicio origen")
		return
end if





// Miramos si existe el apunte provisional anterior

string orig
int cuants

orig = f_diario_contagene(codigo_empresa,"18")

select count(*) into :cuants
from contaapun
where (contaapun.empresa	= :codigo_empresa) 	and
		(contaapun.ejercicio = :ejer_dest) 			and
		(contaapun.origen 	= :orig);

if isnull(cuants) then cuants = 0

if cuants > 0 then
	f_mensaje("Atención","Ya existe un asiento provisional del ejercicio."+char(13)+"El asiento no se graba")
	return
end if




// El asiento de apertura provisional recoge los saldos de todas
// las cuentas de ejercicio anterior y los traslada al nuevo ejercicio
// utilizando como contrapartida la cuenta de pérdidas y ganancias



// Estructura para el apunte. Datos comunes a todos ellos
Str_contaapun apu  
dec{2} el_saldo,total_saldo
string la_cuenta

// Origen especial para la apertura Provisional
apu.origen		=	f_diario_contagene(codigo_empresa,"18")

apu.ejercicio 	=	ejer_dest
apu.empresa 	=	codigo_empresa
apu.fapunte		=	datetime(date("01/01/" + string(ejer_dest))) // día 1/1/ejr_dest
apu.asiento		=	f_ultimo_asiento(ejer_dest,codigo_empresa,month(date(apu.fapunte)),apu.origen)

setnull(apu.diario)
setnull(apu.concepto)
apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"18")
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
apu.mes		=	1

setpointer(hourglass!)

total_saldo = 0
li_apunte = 0

// Para cada una de las cuentas
for i = 1 to registros 
	
	
	
	el_saldo		=	dw_1.getitemnumber(i,"saldo")
	apu.cuenta	=	dw_1.getitemstring(i,"cuenta")
	if el_saldo >= 0 then 
		apu.debe = abs(el_saldo)
		apu.haber = 0
	else
		apu.debe = 0
		apu.haber = abs(el_saldo)	
	end if
	
	li_apunte ++
	apu.apunte	=	li_apunte 
	apu.orden_apunte	=	li_apunte 
	
	total_saldo = total_saldo + el_saldo
	
	// Insertamos el apunte
	correcto = f_insert_contaapun(apu)
	if not correcto then exit
	
	// Equivalencias PGCN
	if cbx_equiv.checked then
		
		 correcto = f_cuenta_equivalencia(ejer_orig,codigo_empresa,apu.cuenta,ejer_dest,el_saldo,	li_apunte)
	end if
		
next

setpointer(arrow!)

// apunte a la cuenta de pérdidas y ganancias introducidas

if correcto = true then
	
	apu.cuenta	=	em_1.text	
	li_apunte ++
	apu.apunte	=	li_apunte+1
	apu.orden_apunte	=	li_apunte +1
		
	if total_saldo >= 0 then
		apu.debe		=	0
		apu.haber	=	abs(total_saldo)
				
	else
		apu.debe		=	abs(total_saldo)
		apu.haber	=	0
		
	end if
	
	//apunte a pérdidas y ganancias
	boolean correcto2
	
	correcto2	=	f_insert_contaapun(apu)
	
	if correcto2 then
		f_mensaje("Correcto","El apunte se hizo correctamente. Origen " + apu.origen +" asiento "+ string(long(apu.asiento)))
		
		commit;
	else
		f_mensaje("Atención","El apunte no se ha grabado")
		rollback;
	end if
	
else
	f_mensaje("Atención","El apunte no se ha grabado")
	rollback;
	
end if





end event

type em_cuentadesde from u_em_campo within w_apertura_prov
integer x = 713
integer y = 748
integer width = 334
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = ""
end type

type em_cuentahasta from u_em_campo within w_apertura_prov
integer x = 1202
integer y = 748
integer width = 343
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = ""
end type

type st_3 from statictext within w_apertura_prov
integer x = 709
integer y = 664
integer width = 224
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_apertura_prov
integer x = 1202
integer y = 664
integer width = 210
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_apertura_prov
integer x = 1097
integer y = 740
integer width = 55
integer height = 96
boolean bringtotop = true
integer textsize = -15
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_1 from u_em_campo within w_apertura_prov
integer x = 713
integer y = 1060
integer width = 421
integer height = 80
integer taborder = 50
end type

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_contaplan"
ue_titulo      = "AYUDA SELECCION DE CUENTAS"
ue_filtro      = "ejercicio = " + uo_ejercicio_destino.em_ejercicio.text 
end event

event modificado;call super::modificado;int max,niv,ejer

niv = 0
ejer = integer(uo_ejercicio_destino.em_ejercicio.text)

select nivel into :niv
from contaplan
where cuenta = :em_1.text;

select niveles into :max
from contaparam
where (empresa = :codigo_empresa) and (ejercicio = :ejer );

if niv <> max then
	
	f_mensaje("Atención","La cuenta no es del máximo nivel")
   This.Text = ""   
   f_activar_campo(em_1)
	
else
	
	st_7.text=f_nombre_contaplan(ejer,codigo_empresa,em_1.text)
	
end if

end event

type st_6 from statictext within w_apertura_prov
integer x = 722
integer y = 960
integer width = 1623
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pérdidas y Ganancias del ejercicio destino  :"
boolean focusrectangle = false
end type

type st_7 from statictext within w_apertura_prov
integer x = 1152
integer y = 1060
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

type uo_ejercicio_origen from u_ejercicio within w_apertura_prov
event destroy ( )
integer x = 453
integer y = 268
integer width = 645
integer height = 304
integer taborder = 10
boolean bringtotop = true
end type

on uo_ejercicio_origen.destroy
call u_ejercicio::destroy
end on

type uo_ejercicio_destino from u_ejercicio within w_apertura_prov
event destroy ( )
integer x = 1175
integer y = 268
integer height = 304
integer taborder = 20
boolean bringtotop = true
end type

on uo_ejercicio_destino.destroy
call u_ejercicio::destroy
end on

event constructor; 
 
 uo_ejercicio_destino.em_ejercicio.text = string(integer(uo_ejercicio_origen.em_ejercicio.text) + 1)
end event

type st_8 from statictext within w_apertura_prov
integer x = 453
integer y = 748
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cuenta"
boolean focusrectangle = false
end type

type st_9 from statictext within w_apertura_prov
integer x = 453
integer y = 1060
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cuenta"
boolean focusrectangle = false
end type

type cbx_equiv from checkbox within w_apertura_prov
integer x = 1792
integer y = 736
integer width = 622
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cuentas Equivalentes"
end type

