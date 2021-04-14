$PBExportHeader$w_int_carpagos.srw
$PBExportComments$€ Introduccion Facturas Compras Directas
forward
global type w_int_carpagos from w_int_con_empresa
end type
type gb_3 from groupbox within w_int_carpagos
end type
type gb_10 from groupbox within w_int_carpagos
end type
type gb_2 from groupbox within w_int_carpagos
end type
type gb_1 from groupbox within w_int_carpagos
end type
type pb_salir from upb_salir within w_int_carpagos
end type
type em_ffra from u_em_campo within w_int_carpagos
end type
type st_3 from statictext within w_int_carpagos
end type
type st_4 from statictext within w_int_carpagos
end type
type st_5 from statictext within w_int_carpagos
end type
type st_6 from statictext within w_int_carpagos
end type
type st_7 from statictext within w_int_carpagos
end type
type em_importe from u_em_campo within w_int_carpagos
end type
type cb_confirmar from u_boton within w_int_carpagos
end type
type cb_salir from u_boton within w_int_carpagos
end type
type st_22 from statictext within w_int_carpagos
end type
type em_asiento from u_em_campo within w_int_carpagos
end type
type st_33 from statictext within w_int_carpagos
end type
type em_registro from u_em_campo within w_int_carpagos
end type
type st_88 from statictext within w_int_carpagos
end type
type em_importe_irpf from u_em_campo within w_int_carpagos
end type
type st_89 from statictext within w_int_carpagos
end type
type em_importe_pp from u_em_campo within w_int_carpagos
end type
type st_90 from statictext within w_int_carpagos
end type
type em_importe_esp from u_em_campo within w_int_carpagos
end type
type st_91 from statictext within w_int_carpagos
end type
type st_92 from statictext within w_int_carpagos
end type
type em_por_pp from u_em_campo within w_int_carpagos
end type
type em_por_esp from u_em_campo within w_int_carpagos
end type
type em_banco from u_em_campo within w_int_carpagos
end type
type st_nombre_banco from statictext within w_int_carpagos
end type
type st_1 from statictext within w_int_carpagos
end type
type pago from radiobutton within w_int_carpagos
end type
type em_por_irpf from u_em_campo within w_int_carpagos
end type
type cbx_generar_pago from checkbox within w_int_carpagos
end type
type cbx_fobs from checkbox within w_int_carpagos
end type
type gb_4 from groupbox within w_int_carpagos
end type
type dw_detalle from u_datawindow within w_int_carpagos
end type
type dw_ivas from u_datawindow within w_int_carpagos
end type
type st_333 from statictext within w_int_carpagos
end type
type uo_proveedor from u_em_campo_2 within w_int_carpagos
end type
type em_fra from u_em_campo within w_int_carpagos
end type
type em_codpago from u_em_campo within w_int_carpagos
end type
type st_nombre_codpago from statictext within w_int_carpagos
end type
type cb_continuar from u_boton within w_int_carpagos
end type
type uo_serie from u_em_campo_2 within w_int_carpagos
end type
type em_fapunte from u_em_campo within w_int_carpagos
end type
type st_15 from statictext within w_int_carpagos
end type
type em_fregistro from u_em_campo within w_int_carpagos
end type
type st_16 from statictext within w_int_carpagos
end type
type uo_moneda from u_em_campo_2 within w_int_carpagos
end type
type uo_ejercicio from u_ejercicio within w_int_carpagos
end type
type gb_5 from groupbox within w_int_carpagos
end type
type dw_recibos from datawindow within w_int_carpagos
end type
end forward

global type w_int_carpagos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3456
integer height = 1852
string title = "Consulta de Movimientos"
gb_3 gb_3
gb_10 gb_10
gb_2 gb_2
gb_1 gb_1
pb_salir pb_salir
em_ffra em_ffra
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
em_importe em_importe
cb_confirmar cb_confirmar
cb_salir cb_salir
st_22 st_22
em_asiento em_asiento
st_33 st_33
em_registro em_registro
st_88 st_88
em_importe_irpf em_importe_irpf
st_89 st_89
em_importe_pp em_importe_pp
st_90 st_90
em_importe_esp em_importe_esp
st_91 st_91
st_92 st_92
em_por_pp em_por_pp
em_por_esp em_por_esp
em_banco em_banco
st_nombre_banco st_nombre_banco
st_1 st_1
pago pago
em_por_irpf em_por_irpf
cbx_generar_pago cbx_generar_pago
cbx_fobs cbx_fobs
gb_4 gb_4
dw_detalle dw_detalle
dw_ivas dw_ivas
st_333 st_333
uo_proveedor uo_proveedor
em_fra em_fra
em_codpago em_codpago
st_nombre_codpago st_nombre_codpago
cb_continuar cb_continuar
uo_serie uo_serie
em_fapunte em_fapunte
st_15 st_15
em_fregistro em_fregistro
st_16 st_16
uo_moneda uo_moneda
uo_ejercicio uo_ejercicio
gb_5 gb_5
dw_recibos dw_recibos
end type
global w_int_carpagos w_int_carpagos

type variables
String conexion,libro
String pagos = "S"
Dec irpf,dtopp,dto1
Dec dpptot,desptot,irpftot
Long asiento
Datetime hoy
Boolean  retrasada
Dec{2} importe_prove
Dec{2} importe_inmov
Dec{2} importe_acree
String varias
end variables

forward prototypes
public subroutine f_activar (boolean bol)
public subroutine f_insertar_linea (integer reg)
public subroutine f_ivas ()
public function boolean f_control ()
public subroutine f_confirmar ()
public subroutine f_salir ()
public function boolean f_grabar_pagos ()
public function boolean f_grabar_apuntes ()
public subroutine f_pagos ()
public subroutine f_borrar_linea (integer reg)
public subroutine f_procesar ()
public function boolean f_datos_costes ()
public subroutine f_fobs ()
public function boolean f_grabar_apuntes_nuevo ()
public function boolean f_grabar_pagos_nuevo ()
public function boolean f_insertar_carpagos_cuentas (long anyo, long orden, string cuenta, decimal importe, decimal divisas, decimal cambio, string tipo)
public function boolean f_comprueba_si_existe_factura ()
end prototypes

public subroutine f_activar (boolean bol);em_codpago.enabled             = bol
em_banco.enabled= bol

em_fapunte.enabled             = bol
em_fregistro.enabled           = bol
em_ffra.enabled                = bol
em_fra.enabled                 = bol
em_importe.enabled             = bol
em_importe_irpf.enabled      	 = bol
em_importe_pp.enabled      	 = bol
em_por_pp.enabled      	 		 = bol
em_por_irpf.enabled   	 		 = bol
em_importe_esp.enabled      	 = bol
em_por_esp.enabled     	 		 = bol
pb_salir.enabled               = bol
uo_moneda.enabled              = bol
uo_proveedor.em_campo.enabled  = bol
uo_proveedor.em_codigo.enabled = bol
uo_proveedor.enabled           = bol
pago.enabled           = bol
cb_continuar.visible           = bol
dw_recibos.visible   = bol
IF bol Then
	em_codpago.text = ""
	pago.checked =FALSE
	em_por_irpf.text = "0"
	em_importe_irpf.text = "0"
END IF
IF  bol Then 
	bol = FALSE
ELSE
	bol = TRUE
END IF

gb_2.visible         	= bol
gb_10.visible           = bol
st_33.visible 				= bol
st_22.visible 				= bol
em_registro.visible 		= bol
em_asiento.visible      = bol
cb_confirmar.visible 	= bol
cb_salir.visible     	= bol
gb_1.visible         	= bol
cb_confirmar.BringToTop = TRUE
cb_salir.BringToTop     = true
dw_ivas.visible      	= bol
DW_IVAS.BringToTop     	= false
dw_detalle.visible   	= bol


end subroutine

public subroutine f_insertar_linea (integer reg);String cuenta,concepto,iva
IF reg <> 0 Then
	// Controles
	IF Not f_control() Then Return
END IF
reg = reg + 1

dw_detalle.InsertRow(reg)
dw_detalle.Setfocus()
dw_detalle.SetRow(reg)
dw_detalle.ScrollToRow(reg)
dw_detalle.SetItem(reg,"ejercicio",Dec(uo_ejercicio.em_ejercicio.text))
dw_detalle.SetItem(reg,"empresa",codigo_empresa)
dw_detalle.SetItem(reg,"tipo_iva",f_tipoiva_comprov(codigo_empresa,Trim(uo_proveedor.em_codigo.text)))
dw_detalle.SetItem(reg,"moneda",uo_moneda.em_codigo.text)
//dw_detalle.SetItem(reg,"cuenta",f_cta_gastos_comprov(codigo_empresa,Trim(uo_proveedor.em_codigo.text)))

dw_detalle.SetColumn("cuenta")
//  modificacion hecha por Jose Miguel y Paco Marin el 18/11/98
//  inserta por defecto las columnas de ampliacion, concepto, dpp,irpf,desp

String ampli, concept

ampli = dw_detalle.GetitemString(reg,"ampliacion")
IF Trim(ampli) = "" OR IsNull(ampli) THEN
	ampli = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text
	dw_detalle.SetItem(reg,"ampliacion",ampli)
END IF
concept= dw_detalle.GetitemString(reg,"concepto")
IF trim(concept) =""  OR IsNull(concept) THEN
	concept="58"
	dw_detalle.SetItem(reg,"concepto",concept)
END IF

IF dec(em_importe_pp.text) = 0 OR IsNull(em_importe_pp.text) THEN
	dw_detalle.SetItem(reg,"dpp","N")
else
	dw_detalle.SetItem(reg,"dpp","S")
END IF

IF dec(em_importe_irpf.text) = 0 OR IsNull(em_importe_irpf.text) THEN
	dw_detalle.SetItem(reg,"irpf","N")
else
	dw_detalle.SetItem(reg,"irpf","S")
END IF
IF dec(em_por_esp.text) = 0 OR IsNull(em_por_esp.text) THEN
	dw_detalle.SetItem(reg,"desp","N")
	dw_detalle.SetItem(reg,"dto",0)
else
	dw_detalle.SetItem(reg,"desp","S")
	dw_detalle.SetItem(reg,"dto",dec(em_por_esp.text))
END IF
choose case uo_serie.em_codigo.text
	case "1"
		dw_detalle.SetItem(reg,"tipo_iva","3")
	case "2"
		dw_detalle.SetItem(reg,"tipo_iva","13")
	case "3"
		dw_detalle.SetItem(reg,"tipo_iva","10")
end choose
if varias <> "" then
	dw_detalle.Setitem(reg,"tipo",varias)
end if
end subroutine

public subroutine f_ivas ();String 	tipo_iva,gra,tipo_iva2
Dec 		base,impiva,base2,iva,impirpf
Dec   	impdto,impdtoesp
Integer 	r,q,a

dw_ivas.SetRedraw(FALSE)
dw_ivas.Reset()
dw_detalle.AcceptText()

impdto 	 = 0
impdtoesp = 0
// variables globales de descuento
dpptot=0
desptot=0
irpftot=0

For r =1 To dw_detalle.RowCount()
	base = dw_detalle.GetItemNumber(r,"neto")
	// Si tiene dtos  y esta activado para descontar de la linea
	// restar de la base imponible
	IF Dec(em_por_pp.text) <> 0 and dw_detalle.GetItemstring(r,"dpp") ="S" THEN
		impdto = base*Dec(em_por_pp.text)/100
		dpptot=dpptot+impdto	
	ELSE
		impdto = 0
	END IF
	base = base - impdto
	// Si tiene  activado para descontar de la linea el IRPF  lo guarda en el total
	IF Dec(em_por_irpf.text) <> 0 and dw_detalle.GetItemstring(r,"irpf") ="S" THEN
		impirpf = base*Dec(em_por_irpf.text)/100
		irpftot=irpftot+impirpf
	END IF
	tipo_iva = dw_detalle.GetItemString(r,"tipo_iva")
	iva      = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,tipo_iva)
	IF IsNUll(tipo_iva) Then tipo_iva = ""
	If tipo_iva <> "" Then  
		gra = "S"
		IF dw_ivas.RowCount() <> 0 Then
			For q = 1 To dw_ivas.RowCount()
				tipo_iva2 = dw_ivas.GetItemString(q,"tipo_iva")
				IF tipo_iva = tipo_iva2  Then
					base2  =  dw_ivas.GetItemNumber(q,"base") + base
					dw_ivas.SetItem(q,"base",base2)
					impiva = Dec(String(base2 * iva /100,f_mascara_decimales(2)))
					dw_ivas.SetItem(q,"impiva",impiva)
					dw_ivas.SetItem(q,"iva",iva)
					gra = "N"	
				END IF
			Next
		END IF
		IF gra = "S" Then
			a = dw_ivas.RowCount() +1
			dw_ivas.InsertRow(a)
			dw_ivas.SetItem(a,"ejercicio",Dec(uo_ejercicio.em_ejercicio.text))
			dw_ivas.SetItem(a,"empresa",codigo_empresa)
			dw_ivas.SetItem(a,"moneda",uo_moneda.em_codigo.text)
			dw_ivas.SetItem(a,"base",base)
			dw_ivas.SetItem(a,"tipo_iva",tipo_iva)
			dw_ivas.SetItem(a,"iva",iva)
			impiva = Dec(String(base * iva /100,f_mascara_decimales(2)))
			dw_ivas.SetItem(a,"impiva",impiva)
			dw_ivas.SetItem(a,"irpf",Dec(em_importe_irpf.text))
		END IF
	END IF
Next
// muestra en la datawindow de ivas el IRPF calculado
dw_ivas.SetItem(a,"irpf",irpftot)
dw_ivas.SetRedraw(TRUE)
end subroutine

public function boolean f_control ();Integer r ,r1 
r1 = dw_detalle.RowCount()
String cuenta,concepto,tipoiva

For r = 1 To r1
	cuenta   = dw_detalle.GetItemSTring(r,"cuenta")
	concepto = dw_detalle.GetItemSTring(r,"concepto")
	tipoiva  = dw_detalle.GetItemSTring(r,"tipo_iva")
	IF f_nombre_contaplan(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) = "" Then
		f_mensaje("Error en Introduccion de datos","La cuenta no existe")
		dw_detalle.SetFocus()
		dw_detalle.SetRow(r)
		dw_detalle.SetColumn("cuenta")
		Return FALSE
	END IF		


	IF f_nombre_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,tipoiva) = "" Then
		f_mensaje("Error en Introduccion de datos","EL Tipo de Iva no existe")
		dw_detalle.SetFocus()
		dw_detalle.SetRow(r)
		dw_detalle.SetColumn("tipo_iva")
		Return FALSE
	END IF		
	
	IF dw_detalle.GetItemNumber(r,"importe") = 0 Then
		f_mensaje("Error en Introduccion de datos","El importe no puede ser 0")
		dw_detalle.SetFocus()
		dw_detalle.SetRow(r)
		dw_detalle.SetColumn("importe")
		Return FALSE
	END IF		
Next

return True

end function

public subroutine f_confirmar ();Integer bien = 0
Long    total_registros,i,lugar
Boolean encontrado

total_registros = dw_detalle.Rowcount()
encontrado = false
lugar = 0
for i = 1 to total_registros
	if dw_detalle.object.tipo[i] = "" or isnull(dw_detalle.object.tipo[i]) then
		messagebox("Atención","Se han encontrado líneas sin Tipo")
		encontrado = true
		lugar = i
		exit
	end if
next
if encontrado then
	dw_detalle.Setfocus()
	dw_detalle.Setrow(lugar)
	dw_detalle.ScrollToRow(lugar)
	return
end if

IF bien <> 1 THEN
	//	IF Not f_grabar_apuntes() Then bien = 1
	IF Not f_grabar_apuntes_nuevo() Then bien = 1
END IF
if cbx_generar_pago.checked then
	IF pago.checked = FALSE THEN
//		IF Not f_grabar_pagos() Then bien = 1
		IF Not f_grabar_pagos_nuevo() Then bien = 1
	END IF
end if

IF bien = 0 Then
	if cbx_fobs.checked then 
		f_fobs()
	end if
	IF not(pago.checked) and cbx_generar_pago.checked and pagos = "S" and bien<>1 Then 
		f_pagos()	
	end if
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso de datos","La operacion no se actualiza")
END IF


end subroutine

public subroutine f_salir ();f_activar(TRUE)
dw_detalle.Reset()
dw_ivas.Reset()
dw_recibos.Reset()
dw_recibos.visible = FALSE
f_activar_campo(uo_serie.em_campo)
em_banco.text = ""
st_nombre_banco.text = ""
varias = ""
end subroutine

public function boolean f_grabar_pagos ();IF pagos = "N" Then  Return True
Integer r
Int bien
Dec cambio
bien = 0

str_carpagos       car
str_vencimientos vto
vto = f_vencimientos_pagos(codigo_empresa,Dec(em_importe.text),em_codpago.text,DateTime(Date(em_ffra.text)),uo_proveedor.em_codigo.text, uo_moneda.em_codigo.text)
car.moneda    = uo_moneda.em_codigo.text
car.proveedor = uo_proveedor.em_codigo.text
//car.codpago   = em_codpago.text
//car.tipodoc   = f_tipodoc_carforpag(codigo_empresa,car.codpago)
cambio        = dec(string(f_cambio_moneda(car.moneda),"###,###.###"))
car.empresa   = codigo_empresa
car.cuenta    = f_cuenta_genter(car.empresa,"P",car.proveedor)
car.anyo 	  = Dec(uo_ejercicio.em_ejercicio.text)
car.ffra 	  = DateTime(Date(em_ffra.text))
car.fra  	  = em_fra.text
car.anyofra   = Year(Date(car.ffra))
car.cambio    = cambio

Select  Max(carpagos.orden)
Into 	  :car.orden
From	  carpagos
Where   carpagos.empresa = :codigo_empresa
And     carpagos.anyo    = :car.anyo ;

IF IsNull(car.orden) Then car.orden = 0

// Si hay banco puesto se asigna en este momento
if em_banco.text <> "" then
	car.banco = em_banco.text
else
	car.banco = ""
end if


For r = 1  To vto.efectos
	choose case r
		case 1
			car.codpago   = f_codpago1_carforpag(codigo_empresa,em_codpago.text)
		case 2
			car.codpago   = f_codpago2_carforpag(codigo_empresa,em_codpago.text)			
		case 3
			car.codpago   = f_codpago3_carforpag(codigo_empresa,em_codpago.text)			
		case 4
			car.codpago   = f_codpago4_carforpag(codigo_empresa,em_codpago.text)			
		case 5
			car.codpago   = f_codpago5_carforpag(codigo_empresa,em_codpago.text)			
		case 6
			car.codpago   = f_codpago6_carforpag(codigo_empresa,em_codpago.text)			
		case 7
			car.codpago   = f_codpago7_carforpag(codigo_empresa,em_codpago.text)			
		case 8
			car.codpago   = f_codpago8_carforpag(codigo_empresa,em_codpago.text)			
		case 9
			car.codpago   = f_codpago9_carforpag(codigo_empresa,em_codpago.text)						
	end choose
	car.tipodoc   = f_tipodoc_carforpag(codigo_empresa,car.codpago)				
	car.orden = car.orden + 1
	car.recibo = r
	car.fvto    = DateTime(vto.vencimiento[r])
	car.divisas = vto.importe[r]
	car.importe = Dec(String(car.divisas * cambio,f_mascara_decimales(0)))
	car.situacion = '0'
	IF Not f_insert_carpagos(car) Then bien  = 1
Next
IF bien = 1 Then Return False
Return TRue
end function

public function boolean f_grabar_apuntes ();Integer v_bien,r,r1
String  moneda,dh
v_bien = 0
Dec cambio,registro,oldreg

moneda = uo_moneda.em_codigo.text
cambio = f_cambio_moneda(moneda)
str_contaapun    conta

oldreg = 0

// Valores comunes a todos los apuntes de todos los asientos
conta.empresa    = codigo_empresa
conta.ejercicio  = Dec(uo_ejercicio.em_ejercicio.text)
conta.origen     = "3"
conta.fapunte    = DateTime(Date(em_fapunte.text))
conta.mes        = Month(Date(conta.fapunte))
conta.asiento    = f_ultimo_asiento(conta.ejercicio,conta.empresa,conta.mes,conta.origen)
asiento=conta.asiento
conta.apunte     = 0
em_asiento.text  = String(conta.asiento,f_mascara_decimales(0))

//--------------------------------------------------------------
// APUNTE A LA CUENTA DEL PROVEEDOR  //
//--------------------------------------------------------------

conta.divisas    = Dec(em_importe.text)
conta.concepto   = f_concepto_contagene(codigo_empresa,"1")
conta.ampliacion = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text

str_vencimientos   vto

vto = f_vencimientos_pagos(codigo_empresa,Dec(em_importe.text),em_codpago.text,DateTime(Date(em_ffra.text)),uo_proveedor.em_codigo.text, moneda)
//For r = 1  To vto.efectos
//	conta.ampliacion = conta.ampliacion + string(vto.vencimiento[r],"dd-mm-yy")
//Next

dh = f_dh_contagene(codigo_empresa,"1")
if dh = "H" then
	conta.debe  = 0
	conta.haber = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
else
	conta.haber = 0
	conta.debe  = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
end if
conta.deducible   = "S"
conta.actualizado = "N"
conta.listado     = "N"
conta.tipoter     = "P"
conta.cuenta      = f_cuenta_genter(conta.empresa,conta.tipoter,Trim(uo_proveedor.em_codigo.text))
conta.moneda      = moneda
conta.cambio      = cambio
conta.documento   = em_fra.text
conta.factura     = em_fra.text
conta.ffactura    = DateTime(date(em_ffra.text))
conta.imponible   = 0
conta.tipoiva     = ""
SetNUll(conta.iva)
SetNull(conta.punteado)
SetNull(conta.fvalor)
SetNull(conta.docpunteo)
SetNull(conta.coste)
SetNull(conta.fregistro)
SetNull(conta.registro)
SetNull(conta.conciliado)
SetNull(conta.clipro)

conta.apunte   = conta.apunte + 1

IF Not f_insert_contaapun(conta) Then 	v_bien = 1

//--------------------------------------------------------------
// APUNTE A LA CUENTA DE I.R.P.F. si hay  //
//--------------------------------------------------------------

IF Dec(em_importe_irpf.text) <> 0 THEN
	conta.divisas    = Dec(em_importe_irpf.text)
	conta.concepto   = f_concepto_contagene(codigo_empresa,"5")
	conta.ampliacion = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text
	dh = f_dh_contagene(codigo_empresa,"5")
	IF dh = "H" THEN
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
	ELSE
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
	END IF
	conta.deducible   = "N"
	conta.actualizado = "N"
	conta.listado     = "N"
	conta.tipoter     = "P"
	conta.cuenta      =  f_cta_irpf_comprov(codigo_empresa,uo_proveedor.em_codigo.text)
	if conta.cuenta = "" then
		messagebox("INCIDENCIA","No hay cuenta de IRPF")		
	end if
	
	conta.moneda      = moneda
	conta.cambio      = cambio
	conta.documento   = em_fra.text
	conta.factura     = em_fra.text
	conta.ffactura    = DateTime(date(em_ffra.text))
	conta.imponible   = 0
	conta.tipoiva     = ""
	SetNUll(conta.iva)
	SetNull(conta.punteado)
	SetNull(conta.fvalor)
	SetNull(conta.docpunteo)
	SetNull(conta.coste)
	SetNull(conta.fregistro)
	SetNull(conta.registro)
	SetNull(conta.conciliado)
	SetNull(conta.clipro)

	
	conta.apunte   = conta.apunte + 1
	
	IF Not f_insert_contaapun(conta) Then 	v_bien = 1
END IF

// APUNTE A LA CUENTA DE DESCUENTOS P.P. Y COMERCIAL //

IF Dec(em_importe_pp.text) <> 0 or Dec(em_importe_esp.text) <> 0 THEN
	conta.cuenta	  = f_cuenta_contagene(codigo_empresa,"4")
	conta.divisas    = Dec(em_importe_pp.text) + Dec(em_importe_esp.text)
	conta.concepto   = f_concepto_contagene(codigo_empresa,"4")
	conta.ampliacion = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text
	dh = f_dh_contagene(codigo_empresa,"4")
	if dh = "H" then
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
	else
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
	end if
	conta.deducible   = "N"
	conta.actualizado = "N"
	conta.listado     = "N"
	conta.tipoter     = "P"
	conta.moneda      = moneda
	conta.cambio      = cambio
	conta.documento   = em_fra.text
	conta.factura     = em_fra.text
	conta.ffactura    = DateTime(date(em_ffra.text))
	conta.imponible   = 0
	conta.tipoiva     = ""
	SetNUll(conta.iva)
	SetNull(conta.punteado)
	SetNull(conta.fvalor)
	SetNull(conta.docpunteo)
	SetNull(conta.coste)
	SetNull(conta.fregistro)
	SetNull(conta.registro)
	SetNull(conta.conciliado)
	SetNull(conta.clipro)
	conta.apunte     = conta.apunte + 1
	IF Not f_insert_contaapun(conta) Then 	v_bien = 1
END IF


//--------------------------------------------------------------
				/// APUNTE A LOS IVAS //
//--------------------------------------------------------------

r1 = dw_ivas.RowCount()
For r = 1 To r1

	conta.apunte     = conta.apunte + 1
	conta.concepto   = f_concepto_contagene(codigo_empresa,"2")
	conta.ampliacion = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text
	dh = f_dh_contagene(codigo_empresa,"2")
	conta.divisas  = dw_ivas.GetItemNumber(r,"impiva")
	if dh = "H" then
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
	else
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
	end if
	conta.clipro    = Trim(uo_proveedor.em_codigo.text)
	conta.tipoiva   = dw_ivas.GetItemString(r,"tipo_iva")
	libro				 = f_libro_contaiva(conta.ejercicio,codigo_empresa,conta.tipoiva)
	
	// Santiago 04/12/00. Cada tipo de iva tiene su contador
	//	// Esto se hace porque si hay más de un iva en la factura, todos deben
	//	// llevar el mismo nº de iva
	//	IF oldreg > 0 THEN
	//		registro 	 = oldreg
	//	ELSE
	registro        = f_contador_contalibros(conta.ejercicio,conta.empresa,libro)
	//	END IF
	oldreg 			 = registro
	conta.cuenta    = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
	conta.iva       = f_iva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
	conta.nif       = f_cif_genter(conta.empresa,conta.tipoter,conta.clipro)
	conta.tipoapu   = libro
	conta.imponible = dw_ivas.GetItemNumber(r,"base")
	conta.registro  = registro
	conta.fregistro = DateTime(Date(em_fregistro.text))
	
	IF Not f_actualizar_contalibros(conta.ejercicio,conta.empresa,libro,registro) Then Return FALSE
	IF Not f_insert_contaapun(conta) Then 	v_bien = 1



	// El tipo 13 (iva de compras autorrepercutido) es un caso especial
	//  - No se suma al total de la factura
	//  - Se hace otro apunte al tipo 14 (iva de ventas autorrepercutido)
	//		por la misma cantidad
	
	if conta.tipoiva = "13" then
		
					
		// El apunte a tipo de compras al 0%
		
		conta.tipoiva   = "6"
		libro				 = f_libro_contaiva(conta.ejercicio,codigo_empresa,conta.tipoiva)	
		
		
		conta.tipoter   = "P"		
		conta.clipro 	 = uo_proveedor.em_codigo.text//f_codigo_cliente_comproveedores(codigo_empresa,uo_proveedor.em_codigo.text)
		if conta.clipro = "" then
			messagebox("No se puede continuar","Falta el código de proveedor como cliente")
			v_bien = 1
		end if
		
		conta.debe 	= 	0
		conta.haber = 	0
		conta.cuenta    = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
		conta.iva       = f_iva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
		conta.nif       = f_cif_genter(conta.empresa,conta.tipoter,conta.clipro)
		conta.tipoapu   = libro
		conta.imponible = dw_ivas.GetItemNumber(r,"base")
		
		conta.fregistro = DateTime(Date(em_fregistro.text))
		conta.apunte = conta.apunte + 1
		
		IF Not f_insert_contaapun(conta) Then 	v_bien = 1
		
		// Hacemos el apunte por el iva tipo 14
		
		conta.apunte     = conta.apunte + 1
		
		if dh = "H" then
			conta.haber  = 0
			conta.debe = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
		else
			conta.debe = 0
			conta.haber  = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
		end if
				
		conta.tipoiva   = "14"
		libro				 = f_libro_contaiva(conta.ejercicio,codigo_empresa,conta.tipoiva)	
		if f_tipo_libro(conta.ejercicio,codigo_empresa,libro) = "C" then
			registro     = f_contador_contalibros(conta.ejercicio,conta.empresa,libro)
		else
			registro = dec(conta.factura)
		end if	
		
		
		conta.clipro 	 = f_codigo_cliente_empresa(codigo_empresa)
		if conta.clipro = "" then
			messagebox("No se puede continuar","Falta el código de la empresa como cliente")
			v_bien = 1
		end if
		
		conta.tipoter   = "C"		
		
		conta.cuenta    = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
		conta.iva       = f_iva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
		conta.nif       = f_cif_genter(conta.empresa,conta.tipoter,conta.clipro)
		conta.tipoapu   = libro
		conta.imponible = dw_ivas.GetItemNumber(r,"base")
		conta.registro  = registro
		conta.fregistro = DateTime(Date(em_fregistro.text))
		
		IF Not f_insert_contaapun(conta) Then 	v_bien = 1
		
		
	
		
		setnull(conta.factura)
		setnull(conta.documento)
	end if
	
Next

//--------------------------------------------------------------
/// APUNTES A LAS CUENTAS DE GASTOS //
//--------------------------------------------------------------
r1 = dw_detalle.RowCount()
For r = 1 To r1
	conta.cuenta     = dw_detalle.GetItemString(r,"cuenta")
	IF not(isnull(conta.cuenta)) then
		conta.apunte     = conta.apunte + 1
		conta.divisas    = dw_detalle.GetItemNumber(r,"importe")
		conta.concepto   = dw_detalle.GetItemString(r,"concepto")
		conta.ampliacion = dw_detalle.GetItemString(r,"ampliacion")
		IF Trim(conta.ampliacion) = "" THEN
			conta.ampliacion  = Trim(uo_proveedor.em_campo.text)
		END IF
		dh = f_dh_contagene(codigo_empresa,"3")
		if dh = "H" then
			conta.debe  = 0
			conta.haber = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
		else
			conta.haber = 0
			conta.debe  = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
		end if
		conta.imponible = 0
		SetNull(conta.tipoiva)
		SetNull(conta.iva)
		SetNull(conta.tipoapu)
		SetNull(conta.clipro)
		SetNull(conta.registro)
		IF Not f_insert_contaapun(conta) Then 	v_bien = 1
		dw_detalle.SetItem(r,"apunte",conta.apunte)
	END IF
Next
// CANCELO EL PAGO AUTOMATICAMANTE
//----------------------------------
IF pago.checked = TRUE THEN
				conta.imponible   = 0
				conta.tipoiva     = ""
				SetNUll(conta.iva)
				SetNull(conta.punteado)
				SetNull(conta.fvalor)
				SetNull(conta.docpunteo)
				SetNull(conta.coste)
				SetNull(conta.fregistro)
				SetNull(conta.registro)
				SetNull(conta.conciliado)
				SetNull(conta.clipro)
				conta.deducible   = "S"
				conta.actualizado = "N"
				conta.listado     = "N"
				conta.tipoter     = "P"
				conta.moneda      = moneda
				conta.cambio      = cambio
				
				conta.divisas    = Dec(em_importe.text)
				conta.concepto   = f_concepto_contagene(codigo_empresa,"10")
				conta.ampliacion = "Pago Fra "+em_fra.text+" "+uo_proveedor.em_campo.text+" "+st_nombre_banco.text
				dh = f_dh_contagene(codigo_empresa,"10")
				if dh = "H" then
					conta.debe  = 0
					conta.haber = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
				else
					conta.haber = 0
					conta.debe  = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
				end if
				
				conta.cuenta      = f_cuenta_genter(conta.empresa,conta.tipoter,Trim(uo_proveedor.em_codigo.text))
				conta.documento   = em_fra.text
				conta.factura     = em_fra.text
				conta.ffactura    = DateTime(date(em_ffra.text))
			
				conta.apunte   = conta.apunte + 1
				IF Not f_insert_contaapun(conta) Then 	v_bien = 1
				//--------------------------------------------------------
				// AL BANCO
				//--------------------------------------------------------
				conta.concepto   = f_concepto_contagene(codigo_empresa,"11")
				conta.ampliacion = "Pago Fra "+em_fra.text+" "+uo_proveedor.em_campo.text+" "+st_nombre_banco.text
				dh = f_dh_contagene(codigo_empresa,"11")
				if dh = "H" then
					conta.debe  = 0
					conta.haber = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
				else
					conta.haber = 0
					conta.debe  = Dec(String(conta.divisas * cambio,f_mascara_decimales(0)))
				end if
				
				conta.cuenta      = f_cuenta_carbancos(conta.empresa,em_banco.text)
				conta.documento   = em_fra.text
				conta.factura     = em_fra.text
				conta.ffactura    = DateTime(date(em_ffra.text))
			
				conta.apunte   = conta.apunte + 1
				IF Not f_insert_contaapun(conta) Then 	v_bien = 1
END IF
//-----------------------------------------

if v_bien = 1 Then
	Return False
Else
	IF Not f_actualizar_contalibros(conta.ejercicio,conta.empresa,libro,registro) Then Return FALSE
	// Miramos si alguna cuenta tiene analitica
	IF f_datos_costes()	THEN
		Return True
	ELSE
		RETURN FALSE
	END IF
End If



end function

public subroutine f_pagos ();str_parametros zstr_param
  	zstr_param.i_nargumentos=5
 	zstr_param.s_argumentos[2]=(uo_ejercicio.em_ejercicio.text)
 	zstr_param.s_argumentos[3]= "3"
 	zstr_param.s_argumentos[4]=(em_fapunte.text)
	zstr_param.s_argumentos[5]=string(asiento)
  
  OpenWithParm(w_int_contaapun,zstr_param) 

// em_asiento.text = Message.StringParm
str_parametros lstr_param
lstr_param.i_nargumentos    = 4
lstr_param.s_argumentos[1]  = "w_int_contaapun"
lstr_param.s_argumentos[2] = uo_proveedor.em_codigo.text
lstr_param.s_argumentos[3] = em_fra.text
lstr_param.s_argumentos[4] = string(year(date(em_ffra.text)))

OpenWithParm(w_con_pagos_proveedor_fra,lstr_param)


end subroutine

public subroutine f_borrar_linea (integer reg);dw_detalle.DeleteRow(reg)
end subroutine

public subroutine f_procesar ();//IF Dec(em_importe.text) <> Dec(dw_ivas.GetItemString(1,"total_fra")) Then
//	f_mensaje("Error en Introduccion de Dtos","El total de factura no cuadra")
//	em_importe.enabled= TRUE
//	f_activar_campo(em_importe)
//	Return 
//END IF

IF Not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),DateTime(date(em_fapunte.text))) Then 
	f_activar_campo(em_fapunte)
	Return
END IF

f_confirmar()
IF conexion = "S" Then 
	pb_salir.TriggerEvent(Clicked!)
	Return
END IF
dw_detalle.Reset()
dw_ivas.Reset()
dw_detalle.visible 			= FALSE
dw_ivas.visible    			= FALSE
em_codpago.text 				= ""
em_ffra.text 					= ""
em_fra.text 					= ""
em_importe.text 				= ""
em_importe_pp.text 			= ""
em_importe_esp.text 			= ""
em_importe_irpf.text 		= ""
uo_moneda.em_campo.text 	= ""
st_nombre_codpago.text 		= ""
uo_proveedor.em_campo.text = ""
uo_moneda.em_codigo.text 	= ""
uo_proveedor.em_campo.text = ""
uo_serie.em_campo.text     = ""
uo_serie.em_codigo.text    = ""
f_salir()

end subroutine

public function boolean f_datos_costes ();Int 		r,xx,mes,rr,xy
String	ana,origen,coste,concepto,ampliacion,conta_i
Dec{0}	importe_d,importe_h,parcial,pasado,sumado,difer,suma,asiento_i,apunte_i
Dec{2}	porcent
Datetime	fapunte
Boolean  vale

r = dw_detalle.RowCount()
IF r = 0 Then Return TRUE
For xx = 1 To r
	conta_i = f_valor_columna(dw_detalle,xx,"cuenta")
	SELECT contaplan.analitica INTO :ana FROM contaplan  
   WHERE contaplan.ejercicio = :ejercicio_activo 
	AND   contaplan.empresa   = :codigo_empresa
	AND   contaplan.cuenta    = :conta_i ;
	IF ana <> 'S'  OR  IsNull(ana) = TRUE Then	Continue 

	mes        = Month(Date(em_fapunte.text))
	origen     = "3"
	asiento_i  = Dec(em_asiento.text)
	
	importe_d  = dw_detalle.GetItemNumber(xx,"importe")
	importe_h  = 0
	apunte_i   = dw_detalle.GetItemNumber(xx,"apunte")
	concepto   = f_valor_columna(dw_detalle,xx,"concepto")
	ampliacion = dw_detalle.GetItemString(xx,"ampliacion")
	IF Trim(ampliacion) = "" THEN
		ampliacion  = "Fra.: " + em_fra.text + " " + Trim(uo_proveedor.em_campo.text)
	END IF
	fapunte    = DateTime(Date(em_fapunte.text))
	
	str_parametros lstr_param
	
	lstr_param.s_argumentos[1] = String(mes)
	lstr_param.s_argumentos[2] = origen
	lstr_param.s_argumentos[3] = String(asiento_i)
	lstr_param.s_argumentos[4] = conta_i
	lstr_param.s_argumentos[5] = String(importe_d)
	lstr_param.s_argumentos[6] = String(apunte_i)
	lstr_param.s_argumentos[7] = concepto
	lstr_param.s_argumentos[8] = ampliacion
	lstr_param.s_argumentos[9] = String(fapunte,"dd-mm-yyyy")
	lstr_param.s_argumentos[10] = String(importe_h)
	lstr_param.s_argumentos[11] = uo_ejercicio.em_ejercicio.text
	
	String vale_st
	
	OpenWithParm(w_costes,lstr_param)
	
	vale_st = Message.StringParm
	IF vale_st = "0" THEN
		Return FALSE
	END IF
Next
Return TRUE
end function

public subroutine f_fobs ();str_parametros zstr_param
zstr_param.i_nargumentos=3
zstr_param.s_argumentos[2]=em_importe.text
zstr_param.s_argumentos[3]=string(x)
zstr_param.s_argumentos[4]=string(workspacey())
OpenWithParm(w_facturas_ventas_fobs,zstr_param) 

end subroutine

public function boolean f_grabar_apuntes_nuevo ();Integer v_bien,r,r1
Long    total_detalle,i,var_iva
String  moneda,dh,var_tipo,var_tipo_iva,var_dtopp,var_dtoesp
Dec     cambio,registro,oldreg
Dec{2}  var_importe,var_importe_dtopp,var_importe_dtoesp
Dec     dif

v_bien = 0
moneda = uo_moneda.em_codigo.text
cambio = f_cambio_moneda(moneda)

str_contaapun    conta

oldreg = 0

// Valores comunes a todos los apuntes de todos los asientos
conta.empresa    = codigo_empresa
conta.ejercicio  = Dec(uo_ejercicio.em_ejercicio.text)
conta.origen     = "3"
conta.fapunte    = DateTime(Date(em_fapunte.text))
conta.mes        = Month(Date(conta.fapunte))
conta.asiento    = f_ultimo_asiento(conta.ejercicio,conta.empresa,conta.mes,conta.origen)
asiento=conta.asiento
conta.apunte     = 0
em_asiento.text  = String(conta.asiento,f_mascara_decimales(0))

//--------------------------------------------------------------
// APUNTE A LA CUENTA DEL PROVEEDOR  //
//--------------------------------------------------------------
str_vencimientos   vto

vto = f_vencimientos_pagos(codigo_empresa,Dec(em_importe.text),em_codpago.text,DateTime(Date(em_ffra.text)),uo_proveedor.em_codigo.text, moneda)
//For r = 1  To vto.efectos
//	conta.ampliacion = conta.ampliacion + string(vto.vencimiento[r],"dd-mm-yy")
//Next
importe_acree = 0
importe_prove = 0
importe_inmov = 0

total_detalle = dw_detalle.RowCount()
for i = 1 to total_detalle
	var_tipo     = dw_detalle.Getitemstring(i,"tipo")	
	var_tipo_iva = dw_detalle.GetItemString(i,"tipo_iva")
	var_iva      = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,var_tipo_iva)
	var_importe  = dw_detalle.GetItemNumber(i,"neto")
	var_dtopp    = dw_detalle.GetItemString(i,"dpp")
	var_dtoesp   = dw_detalle.GetItemString(i,"desp")
	choose case var_tipo
		case "A"
			if var_dtopp = "S" then
				var_importe_dtopp = var_importe * Dec(em_por_pp.text)/100
			else
				var_importe_dtopp = 0
			end if
			
			importe_acree = importe_acree + ((var_importe - var_importe_dtopp) +( (var_importe - var_importe_dtopp) * var_iva / 100)) - dec(em_importe_irpf.text)
			
		case "G"
			if var_dtopp = "S" then
				var_importe_dtopp = var_importe * Dec(em_por_pp.text)/100
			else
				var_importe_dtopp = 0
			end if
					
			importe_prove = importe_prove + ((var_importe - var_importe_dtopp) +( (var_importe - var_importe_dtopp) * var_iva / 100))
			
		case "I"
			if var_dtopp = "S" then
				var_importe_dtopp = var_importe * Dec(em_por_pp.text)/100
			else
				var_importe_dtopp = 0
			end if
						
			importe_inmov = importe_inmov + ((var_importe - var_importe_dtopp) +( (var_importe - var_importe_dtopp) * var_iva / 100))
			
	end choose
next
dif = dec(em_importe.text) - (importe_acree + importe_prove + importe_inmov)

if dif <> 0 then
	if dif > 0 then
		if importe_acree <> 0 then
			importe_acree = importe_acree + dif
		else
			if importe_prove <> 0 then
				importe_prove = importe_prove + dif
			else
				if importe_inmov <> 0 then
					importe_inmov = importe_inmov + dif
				end if
			end if
		end if
	else	
		if importe_acree <> 0 then
			importe_acree = importe_acree - dif
		else
			if importe_prove <> 0 then
				importe_prove = importe_prove - dif
			else
				if importe_inmov <> 0 then
					importe_inmov = importe_inmov - dif
				end if
			end if
		end if
	end if
end if
conta.concepto   = f_concepto_contagene(codigo_empresa,"1")
conta.ampliacion = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text
if importe_inmov <> 0 then
	dh = f_dh_contagene(codigo_empresa,"1")
	conta.divisas    = importe_inmov
	if dh = "H" then
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	else
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	end if
	conta.deducible   = "S"
	conta.actualizado = "N"
	conta.listado     = "N"
	conta.tipoter     = "P"
	conta.cuenta      = f_cta_comproveedor(conta.empresa,Trim(uo_proveedor.em_codigo.text),"I")
	conta.moneda      = moneda
	conta.cambio      = cambio
	conta.documento   = em_fra.text
	conta.factura     = em_fra.text
	conta.ffactura    = DateTime(date(em_ffra.text))
	conta.imponible   = 0
	conta.tipoiva     = ""
	SetNUll(conta.iva)
	SetNull(conta.punteado)
	SetNull(conta.fvalor)
	SetNull(conta.docpunteo)
	SetNull(conta.coste)
	SetNull(conta.fregistro)
	SetNull(conta.registro)
	SetNull(conta.conciliado)
	SetNull(conta.clipro)
	
	conta.apunte   = conta.apunte + 1
	
	IF Not f_insert_contaapun(conta) Then 	v_bien = 1
end if
if importe_prove <> 0 then
	dh = f_dh_contagene(codigo_empresa,"1")
	conta.divisas    = importe_prove
	if dh = "H" then
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	else
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	end if
	conta.deducible   = "S"
	conta.actualizado = "N"
	conta.listado     = "N"
	conta.tipoter     = "P"
	conta.cuenta      = f_cta_comproveedor(conta.empresa,Trim(uo_proveedor.em_codigo.text),"G")
	conta.moneda      = moneda
	conta.cambio      = cambio
	conta.documento   = em_fra.text
	conta.factura     = em_fra.text
	conta.ffactura    = DateTime(date(em_ffra.text))
	conta.imponible   = 0
	conta.tipoiva     = ""
	SetNUll(conta.iva)
	SetNull(conta.punteado)
	SetNull(conta.fvalor)
	SetNull(conta.docpunteo)
	SetNull(conta.coste)
	SetNull(conta.fregistro)
	SetNull(conta.registro)
	SetNull(conta.conciliado)
	SetNull(conta.clipro)
	
	conta.apunte   = conta.apunte + 1
	
	IF Not f_insert_contaapun(conta) Then 	v_bien = 1
end if

if importe_acree <> 0 then
	dh = f_dh_contagene(codigo_empresa,"1")
	conta.divisas    = importe_acree
	if dh = "H" then
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	else
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	end if
	conta.deducible   = "S"
	conta.actualizado = "N"
	conta.listado     = "N"
	conta.tipoter     = "P"
	conta.cuenta      = f_cta_comproveedor(conta.empresa,Trim(uo_proveedor.em_codigo.text),"A")
	conta.moneda      = moneda
	conta.cambio      = cambio
	conta.documento   = em_fra.text
	conta.factura     = em_fra.text
	conta.ffactura    = DateTime(date(em_ffra.text))
	conta.imponible   = 0
	conta.tipoiva     = ""
	SetNUll(conta.iva)
	SetNull(conta.punteado)
	SetNull(conta.fvalor)
	SetNull(conta.docpunteo)
	SetNull(conta.coste)
	SetNull(conta.fregistro)
	SetNull(conta.registro)
	SetNull(conta.conciliado)
	SetNull(conta.clipro)
	
	conta.apunte   = conta.apunte + 1
	
	IF Not f_insert_contaapun(conta) Then 	v_bien = 1
end if

//--------------------------------------------------------------
// APUNTE A LA CUENTA DE I.R.P.F. si hay  //
//--------------------------------------------------------------

IF Dec(em_importe_irpf.text) <> 0 THEN
	conta.divisas    = Dec(em_importe_irpf.text)
	conta.concepto   = f_concepto_contagene(codigo_empresa,"5")
	conta.ampliacion = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text
	dh = f_dh_contagene(codigo_empresa,"5")
	IF dh = "H" THEN
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	ELSE
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	END IF
	conta.deducible   = "N"
	conta.actualizado = "N"
	conta.listado     = "N"
	conta.tipoter     = "P"
	conta.cuenta      =  f_cta_irpf_comprov(codigo_empresa,uo_proveedor.em_codigo.text)
	if conta.cuenta = "" then
		messagebox("INCIDENCIA","No hay cuenta de IRPF")		
	end if
	
	conta.moneda      = moneda
	conta.cambio      = cambio
	conta.documento   = em_fra.text
	conta.factura     = em_fra.text
	conta.ffactura    = DateTime(date(em_ffra.text))
	conta.imponible   = 0
	conta.tipoiva     = ""
	SetNUll(conta.iva)
	SetNull(conta.punteado)
	SetNull(conta.fvalor)
	SetNull(conta.docpunteo)
	SetNull(conta.coste)
	SetNull(conta.fregistro)
	SetNull(conta.registro)
	SetNull(conta.conciliado)
	SetNull(conta.clipro)

	
	conta.apunte   = conta.apunte + 1
	
	IF Not f_insert_contaapun(conta) Then 	v_bien = 1
END IF

// APUNTE A LA CUENTA DE DESCUENTOS P.P. Y COMERCIAL //

//IF Dec(em_importe_pp.text) <> 0 or Dec(em_importe_esp.text) <> 0 THEN
IF Dec(em_importe_pp.text) <> 0 THEN
	conta.cuenta	  = f_cuenta_contagene(codigo_empresa,"4")
	conta.divisas    = Dec(em_importe_pp.text)
	conta.concepto   = f_concepto_contagene(codigo_empresa,"4")
	conta.ampliacion = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text
	dh = f_dh_contagene(codigo_empresa,"4")
	if dh = "H" then
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	else
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
	end if
	conta.deducible   = "N"
	conta.actualizado = "N"
	conta.listado     = "N"
	conta.tipoter     = "P"
	conta.moneda      = moneda
	conta.cambio      = cambio
	conta.documento   = em_fra.text
	conta.factura     = em_fra.text
	conta.ffactura    = DateTime(date(em_ffra.text))
	conta.imponible   = 0
	conta.tipoiva     = ""
	SetNUll(conta.iva)
	SetNull(conta.punteado)
	SetNull(conta.fvalor)
	SetNull(conta.docpunteo)
	SetNull(conta.coste)
	SetNull(conta.fregistro)
	SetNull(conta.registro)
	SetNull(conta.conciliado)
	SetNull(conta.clipro)
	conta.apunte     = conta.apunte + 1
	IF Not f_insert_contaapun(conta) Then 	v_bien = 1
END IF

//--------------------------------------------------------------
				/// APUNTE A LOS IVAS //
//--------------------------------------------------------------

r1 = dw_ivas.RowCount()
For r = 1 To r1
	conta.tipoiva   = dw_ivas.GetItemString(r,"tipo_iva")
	if conta.tipoiva <> "10" then
		if (conta.tipoiva <> "13") and (conta.tipoiva <> "15") then
			conta.apunte     = conta.apunte + 1
			conta.concepto   = f_concepto_contagene(codigo_empresa,"2")
			conta.ampliacion = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text
			dh = f_dh_contagene(codigo_empresa,"2")
			conta.divisas  = dw_ivas.GetItemNumber(r,"impiva")
			if dh = "H" then
				conta.debe  = 0
				conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
			else
				conta.haber = 0
				conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
			end if
			conta.clipro    = Trim(uo_proveedor.em_codigo.text)
			libro				 = f_libro_contaiva(conta.ejercicio,codigo_empresa,conta.tipoiva)
			
			// Santiago 04/12/00. Cada tipo de iva tiene su contador
			//	// Esto se hace porque si hay más de un iva en la factura, todos deben
			//	// llevar el mismo nº de iva
			//	IF oldreg > 0 THEN
			//		registro 	 = oldreg
			//	ELSE
			registro        = f_contador_contalibros(conta.ejercicio,conta.empresa,libro)
			//	END IF
			oldreg 			 = registro
			if retrasada and uo_serie.em_codigo.text = "1" then
				conta.cuenta = "4720000999"
			else
				conta.cuenta = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
			end if
			conta.iva       = f_iva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
			conta.nif       = f_cif_genter(conta.empresa,conta.tipoter,conta.clipro)
			conta.tipoapu   = libro
			conta.imponible = dw_ivas.GetItemNumber(r,"base") / cambio
			conta.registro  = registro
			conta.fregistro = DateTime(Date(em_fregistro.text))
			
			IF Not f_actualizar_contalibros(conta.ejercicio,conta.empresa,libro,registro) Then Return FALSE
			IF Not f_insert_contaapun(conta) Then 	v_bien = 1
		end if	
		// El tipo 13 (iva de compras autorrepercutido) es un caso especial
		//  - No se suma al total de la factura
		//  - Se hace otro apunte al tipo 14 (iva de ventas autorrepercutido)
		//		por la misma cantidad
		
		if conta.tipoiva = "13" or conta.tipoiva = "15" then
			libro				 = f_libro_contaiva(conta.ejercicio,codigo_empresa,conta.tipoiva)	
			registro = f_contador_contalibros(conta.ejercicio,conta.empresa,libro)
			conta.tipoter   = "P"		
			conta.clipro 	 = uo_proveedor.em_codigo.text
			if conta.clipro = "" then
				messagebox("No se puede continuar","Falta el código de proveedor como cliente")
				v_bien = 1
			end if
			conta.debe 	= 	0
			conta.haber = 	0
			conta.cuenta    = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
	//		conta.iva       = f_iva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
			conta.iva       = 0
			conta.nif       = f_cif_genter(conta.empresa,conta.tipoter,conta.clipro)
			conta.tipoapu   = libro
			conta.imponible = dw_ivas.GetItemNumber(r,"base")
			conta.registro  = registro
			conta.fregistro = DateTime(Date(em_fregistro.text))
			conta.apunte = conta.apunte + 1
			
			IF Not f_actualizar_contalibros(conta.ejercicio,conta.empresa,libro,registro) Then Return FALSE			
			IF Not f_insert_contaapun(conta) Then 	v_bien = 1
			
			// Hacemos el apunte por el iva tipo 14
			
			conta.tipoiva   = "14"
			conta.apunte     = conta.apunte + 1
			
			if dh = "H" then
				conta.haber = 0
				conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
			else
				conta.debe  = 0
				conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
			end if
			
			libro				 = f_libro_contaiva(conta.ejercicio,codigo_empresa,conta.tipoiva)	
			if f_tipo_libro(conta.ejercicio,codigo_empresa,libro) = "C" then
				registro = f_contador_contalibros(conta.ejercicio,conta.empresa,libro)
			else
				registro = dec(conta.factura)
			end if	
			
			conta.clipro 	 = f_codigo_cliente_empresa(codigo_empresa)
			if conta.clipro = "" then
				messagebox("No se puede continuar","Falta el código de la empresa como cliente")
				v_bien = 1
			end if
			
			conta.tipoter   = "C"		
			
			conta.cuenta    = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
			conta.iva       = f_iva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
			conta.nif       = f_cif_genter(conta.empresa,conta.tipoter,conta.clipro)
			conta.tipoapu   = libro
			conta.imponible = dw_ivas.GetItemNumber(r,"base") / cambio
			conta.registro  = registro
			conta.fregistro = DateTime(Date(em_fregistro.text))
			
			IF Not f_actualizar_contalibros(conta.ejercicio,conta.empresa,libro,registro) Then Return FALSE			
			IF Not f_insert_contaapun(conta) Then 	v_bien = 1
			
			setnull(conta.factura)
			setnull(conta.documento)
		end if
	end if
	
Next

//--------------------------------------------------------------
/// APUNTES A LAS CUENTAS DE GASTOS //
//--------------------------------------------------------------
r1 = dw_detalle.RowCount()
For r = 1 To r1
	conta.cuenta     = dw_detalle.GetItemString(r,"cuenta")
	IF not(isnull(conta.cuenta)) then
		conta.apunte     = conta.apunte + 1
		conta.divisas    = dw_detalle.GetItemNumber(r,"neto")
		conta.concepto   = dw_detalle.GetItemString(r,"concepto")
		conta.ampliacion = dw_detalle.GetItemString(r,"ampliacion")
		IF Trim(conta.ampliacion) = "" THEN
			conta.ampliacion  = Trim(uo_proveedor.em_campo.text)
		END IF
		dh = f_dh_contagene(codigo_empresa,"3")
		if dh = "H" then
			conta.debe  = 0
			conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
		else
			conta.haber = 0
			conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
		end if
		conta.imponible = 0
		SetNull(conta.tipoiva)
		SetNull(conta.iva)
		SetNull(conta.tipoapu)
		SetNull(conta.clipro)
		SetNull(conta.registro)
		IF Not f_insert_contaapun(conta) Then 	v_bien = 1
		dw_detalle.SetItem(r,"apunte",conta.apunte)
	END IF
Next
// CANCELO EL PAGO AUTOMATICAMANTE
//----------------------------------
IF pago.checked = TRUE THEN
				conta.imponible   = 0
				conta.tipoiva     = ""
				SetNUll(conta.iva)
				SetNull(conta.punteado)
				SetNull(conta.fvalor)
				SetNull(conta.docpunteo)
				SetNull(conta.coste)
				SetNull(conta.fregistro)
				SetNull(conta.registro)
				SetNull(conta.conciliado)
				SetNull(conta.clipro)
				conta.deducible   = "S"
				conta.actualizado = "N"
				conta.listado     = "N"
				conta.tipoter     = "P"
				conta.moneda      = moneda
				conta.cambio      = cambio
				
				conta.divisas    = Dec(em_importe.text)
				conta.concepto   = f_concepto_contagene(codigo_empresa,"10")
				conta.ampliacion = "Pago Fra "+em_fra.text+" "+uo_proveedor.em_campo.text+" "+st_nombre_banco.text
				dh = f_dh_contagene(codigo_empresa,"10")
				if dh = "H" then
					conta.debe  = 0
					conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
				else
					conta.haber = 0
					conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
				end if
				
				conta.cuenta      = f_cuenta_genter(conta.empresa,conta.tipoter,Trim(uo_proveedor.em_codigo.text))
				conta.documento   = em_fra.text
				conta.factura     = em_fra.text
				conta.ffactura    = DateTime(date(em_ffra.text))
			
				conta.apunte   = conta.apunte + 1
				IF Not f_insert_contaapun(conta) Then 	v_bien = 1
				//--------------------------------------------------------
				// AL BANCO
				//--------------------------------------------------------
				conta.concepto   = f_concepto_contagene(codigo_empresa,"11")
				conta.ampliacion = "Pago Fra "+em_fra.text+" "+uo_proveedor.em_campo.text+" "+st_nombre_banco.text
				dh = f_dh_contagene(codigo_empresa,"11")
				if dh = "H" then
					conta.debe  = 0
					conta.haber = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
				else
					conta.haber = 0
					conta.debe  = Dec(String(conta.divisas / cambio,f_mascara_decimales(2)))
				end if
				
				conta.cuenta      = f_cuenta_carbancos(conta.empresa,em_banco.text)
				conta.documento   = em_fra.text
				conta.factura     = em_fra.text
				conta.ffactura    = DateTime(date(em_ffra.text))
			
				conta.apunte   = conta.apunte + 1
				IF Not f_insert_contaapun(conta) Then 	v_bien = 1
END IF
//-----------------------------------------

if v_bien = 1 Then
	Return False
Else
//	IF Not f_actualizar_contalibros(conta.ejercicio,conta.empresa,libro,registro) Then Return FALSE
	// Miramos si alguna cuenta tiene analitica
	IF f_datos_costes()	THEN
		Return True
	ELSE
		RETURN FALSE
	END IF
End If

end function

public function boolean f_grabar_pagos_nuevo ();Integer r
Integer bien
Dec     cambio
Dec{2}  por_inmov,por_acree,por_prove
Dec{2}  var_importe_inmov,var_importe_acree,var_importe_prove
Dec{2}  var_divisas_inmov,var_divisas_acree,var_divisas_prove
String  var_cuenta_inmov,var_cuenta_acree,var_cuenta_prove
long    ll_orden_agrupado
str_carpagos     car
str_carpagosdetagrupado detagrupado
str_vencimientos vto

IF pagos = "N" Then  Return True

bien = 0
if importe_acree <> 0 then
	por_acree = abs(importe_acree / dec(em_importe.text))
else
	por_acree = 0
end if
if importe_prove <> 0 then
	por_prove = abs(importe_prove / dec(em_importe.text))
else
	por_prove = 0
end if
if importe_inmov <> 0 then
	por_inmov = abs(importe_inmov / dec(em_importe.text))
else
	por_inmov = 0
end if

vto = f_vencimientos_pagos(codigo_empresa,Dec(em_importe.text),em_codpago.text,DateTime(Date(em_ffra.text)),uo_proveedor.em_codigo.text, uo_moneda.em_codigo.text)
car.moneda    = uo_moneda.em_codigo.text
car.proveedor = uo_proveedor.em_codigo.text
//car.codpago   = em_codpago.text
//car.tipodoc   = f_tipodoc_carforpag(codigo_empresa,car.codpago)
cambio        = f_cambio_moneda(car.moneda)
car.empresa   = codigo_empresa
//car.cuenta    = f_cuenta_genter(car.empresa,"P",car.proveedor)
car.cuenta    = ""
car.anyo 	  = Dec(uo_ejercicio.em_ejercicio.text)
car.ffra 	  = DateTime(Date(em_ffra.text))
car.fra  	  = em_fra.text
car.anyofra   = Year(Date(car.ffra))
car.cambio    = cambio

//Select  Max(carpagos.orden)
//Into 	  :car.orden
//From	  carpagos
//Where   carpagos.empresa = :codigo_empresa
//And     carpagos.anyo    = :car.anyo ;
//IF IsNull(car.orden) Then car.orden = 0

car.orden   = f_ultimo_orden_carpagos(codigo_empresa,car.anyo)

// Si hay banco puesto se asigna en este momento
if em_banco.text <> "" then
	car.banco = em_banco.text
else
	car.banco = ""
end if

For r = 1  To vto.efectos
	choose case r
		case 1
			car.codpago   = f_codpago1_carforpag(codigo_empresa,em_codpago.text)
		case 2
			car.codpago   = f_codpago2_carforpag(codigo_empresa,em_codpago.text)			
		case 3
			car.codpago   = f_codpago3_carforpag(codigo_empresa,em_codpago.text)			
		case 4
			car.codpago   = f_codpago4_carforpag(codigo_empresa,em_codpago.text)			
		case 5
			car.codpago   = f_codpago5_carforpag(codigo_empresa,em_codpago.text)			
		case 6
			car.codpago   = f_codpago6_carforpag(codigo_empresa,em_codpago.text)			
		case 7
			car.codpago   = f_codpago7_carforpag(codigo_empresa,em_codpago.text)			
		case 8
			car.codpago   = f_codpago8_carforpag(codigo_empresa,em_codpago.text)			
		case 9
			car.codpago   = f_codpago9_carforpag(codigo_empresa,em_codpago.text)						
	end choose
	car.tipodoc   = f_tipodoc_carforpag(codigo_empresa,car.codpago)				
	//car.orden = car.orden + 1
	car.recibo = r
	car.fvto    = DateTime(vto.vencimiento[r])
	car.divisas = Dec(string(vto.importe[r],f_mascara_decimales(f_decimales_moneda(uo_moneda.em_codigo.text))))
	car.importe = Dec(String(car.divisas / cambio,f_mascara_decimales(2)))
	car.situacion = '0'
	
	if (importe_acree <> 0 and importe_prove <> 0) or (importe_acree <> 0 and importe_inmov <> 0) or (importe_prove <> 0 and importe_inmov <> 0) then
		//Si vamos a introducir mas de un efecto creamos uno que agrupe a los demas.
		car.cuenta  = ""
		car.agrupado = "S"
		car.orden    = car.orden + 1
		IF Not f_insert_carpagos(car) Then bien  = 1
		ll_orden_agrupado = car.orden
	end if
	
	if importe_acree <> 0 then
		var_importe_acree = dec(string(vto.importe[r] / cambio * por_acree,f_mascara_decimales(2))) -(dec(em_importe_irpf) / cambio)
		var_divisas_acree = dec(string(vto.importe[r] * por_acree,f_mascara_decimales(f_decimales_moneda(uo_moneda.em_codigo.text)))) - dec(em_importe_irpf)
		var_cuenta_acree  = f_cta_comproveedor(codigo_empresa,Trim(uo_proveedor.em_codigo.text),"A")
		
		car.divisas = var_divisas_acree
		car.importe = var_importe_acree
		car.cuenta  = var_cuenta_acree
		//if not f_insertar_carpagos_cuentas(car.anyo,car.orden,var_cuenta_acree,var_importe_acree,var_divisas_acree,car.cambio,"A") then bien = 1
		car.orden   = car.orden + 1
		if (importe_acree <> 0 and importe_prove <> 0) or (importe_acree <> 0 and importe_inmov <> 0) or (importe_prove <> 0 and importe_inmov <> 0) then
			//Si vamos a introducir mas de un efecto grabaremos este como detalle de agrupado
			detagrupado.empresa        = codigo_empresa
			detagrupado.anyo_agrupado  = car.anyo
			detagrupado.orden_agrupado = ll_orden_agrupado
			detagrupado.anyo           = car.anyo
			detagrupado.orden          = car.orden
			detagrupado.anyofra        = car.anyofra		
			detagrupado.fra            = car.fra
			detagrupado.recibo         = car.recibo
			detagrupado.ffra           = car.ffra
			detagrupado.fvto           = car.fvto
			detagrupado.fpago          = car.fpago
			detagrupado.importe        = car.importe
			detagrupado.divisas        = car.divisas
			detagrupado.moneda         = car.moneda
			detagrupado.banco          = car.banco
			detagrupado.proveedor      = car.proveedor
			detagrupado.tipodoc        = car.tipodoc
			detagrupado.codpago        = car.codpago
			detagrupado.situacion      = car.situacion
			detagrupado.cuenta         = car.cuenta
			detagrupado.femi           = car.femi
			detagrupado.num_talon      = car.num_talon
			detagrupado.asignar_banco  = car.asignar_banco
			detagrupado.tipodoc_pago   = car.tipodoc_pago
			detagrupado.cambio         = car.cambio
			detagrupado.punteado       = car.punteado
			detagrupado.concepto       = car.concepto
			detagrupado.observaciones  = car.observaciones	
			
			if not(f_insert_carpagosdetagrupado(detagrupado)) then
				bien  = 1
			end if			
		else
			IF Not f_insert_carpagos(car) Then bien  = 1
		end if
	else
		var_importe_acree = 0
		var_divisas_acree = 0
		var_cuenta_acree  = ""
	end if
	
	if importe_prove <> 0 then
		var_importe_prove = dec(string(vto.importe[r] / cambio * por_prove,f_mascara_decimales(2)))
		var_divisas_prove = dec(string(vto.importe[r] * por_prove,f_mascara_decimales(f_decimales_moneda(uo_moneda.em_codigo.text))))
		var_cuenta_prove  = f_cta_comproveedor(codigo_empresa,Trim(uo_proveedor.em_codigo.text),"G")
		//if not f_insertar_carpagos_cuentas(car.anyo,car.orden,var_cuenta_prove,var_importe_prove,var_divisas_prove,car.cambio,"G") then bien = 1
		
		car.divisas = var_divisas_prove
		car.importe = var_importe_prove
		car.cuenta  = var_cuenta_prove
		car.orden   = car.orden + 1
		
		if (importe_acree <> 0 and importe_prove <> 0) or (importe_acree <> 0 and importe_inmov <> 0) or (importe_prove <> 0 and importe_inmov <> 0) then
			//Si vamos a introducir mas de un efecto grabaremos este como detalle de agrupado
			detagrupado.empresa        = codigo_empresa
			detagrupado.anyo_agrupado  = car.anyo
			detagrupado.orden_agrupado = ll_orden_agrupado
			detagrupado.anyo           = car.anyo
			detagrupado.orden          = car.orden
			detagrupado.anyofra        = car.anyofra		
			detagrupado.fra            = car.fra
			detagrupado.recibo         = car.recibo
			detagrupado.ffra           = car.ffra
			detagrupado.fvto           = car.fvto
			detagrupado.fpago          = car.fpago
			detagrupado.importe        = car.importe
			detagrupado.divisas        = car.divisas
			detagrupado.moneda         = car.moneda
			detagrupado.banco          = car.banco
			detagrupado.proveedor      = car.proveedor
			detagrupado.tipodoc        = car.tipodoc
			detagrupado.codpago        = car.codpago
			detagrupado.situacion      = car.situacion
			detagrupado.cuenta         = car.cuenta
			detagrupado.femi           = car.femi
			detagrupado.num_talon      = car.num_talon
			detagrupado.asignar_banco  = car.asignar_banco
			detagrupado.tipodoc_pago   = car.tipodoc_pago
			detagrupado.cambio         = car.cambio
			detagrupado.punteado       = car.punteado
			detagrupado.concepto       = car.concepto
			detagrupado.observaciones  = car.observaciones	
			
			if not(f_insert_carpagosdetagrupado(detagrupado)) then
				bien  = 1
			end if			
		else
			IF Not f_insert_carpagos(car) Then bien  = 1
		end if
	else
		var_importe_prove = 0
		var_divisas_prove = 0
		var_cuenta_prove  = ""
	end if
	
	if importe_inmov <> 0 then
		var_importe_inmov = dec(string(vto.importe[r] / cambio * por_inmov,f_mascara_decimales(2)))
		var_divisas_inmov = dec(string(vto.importe[r] * por_inmov,f_mascara_decimales(f_decimales_moneda(uo_moneda.em_codigo.text))))
		var_cuenta_inmov  = f_cta_comproveedor(codigo_empresa,Trim(uo_proveedor.em_codigo.text),"I")
		//if not f_insertar_carpagos_cuentas(car.anyo,car.orden,var_cuenta_inmov,var_importe_inmov,var_divisas_inmov,car.cambio,"I") then bien = 1
		
		car.divisas = var_divisas_inmov
		car.importe = var_importe_inmov
		car.cuenta  = var_cuenta_inmov
		car.orden   = car.orden + 1
		
		if (importe_acree <> 0 and importe_prove <> 0) or (importe_acree <> 0 and importe_inmov <> 0) or (importe_prove <> 0 and importe_inmov <> 0) then
			//Si vamos a introducir mas de un efecto grabaremos este como detalle de agrupado
			detagrupado.empresa        = codigo_empresa
			detagrupado.anyo_agrupado  = car.anyo
			detagrupado.orden_agrupado = ll_orden_agrupado
			detagrupado.anyo           = car.anyo
			detagrupado.orden          = car.orden
			detagrupado.anyofra        = car.anyofra		
			detagrupado.fra            = car.fra
			detagrupado.recibo         = car.recibo
			detagrupado.ffra           = car.ffra
			detagrupado.fvto           = car.fvto
			detagrupado.fpago          = car.fpago
			detagrupado.importe        = car.importe
			detagrupado.divisas        = car.divisas
			detagrupado.moneda         = car.moneda
			detagrupado.banco          = car.banco
			detagrupado.proveedor      = car.proveedor
			detagrupado.tipodoc        = car.tipodoc
			detagrupado.codpago        = car.codpago
			detagrupado.situacion      = car.situacion
			detagrupado.cuenta         = car.cuenta
			detagrupado.femi           = car.femi
			detagrupado.num_talon      = car.num_talon
			detagrupado.asignar_banco  = car.asignar_banco
			detagrupado.tipodoc_pago   = car.tipodoc_pago
			detagrupado.cambio         = car.cambio
			detagrupado.punteado       = car.punteado
			detagrupado.concepto       = car.concepto
			detagrupado.observaciones  = car.observaciones	
			
			if not(f_insert_carpagosdetagrupado(detagrupado)) then
				bien  = 1
			end if			
		else
			IF Not f_insert_carpagos(car) Then bien  = 1
		end if
	else
		var_importe_inmov = 0
		var_divisas_inmov = 0
		var_cuenta_inmov  = ""
	end if
	
	//IF Not f_insert_carpagos(car) Then bien  = 1
	
Next
IF bien = 1 Then Return False
Return TRue
end function

public function boolean f_insertar_carpagos_cuentas (long anyo, long orden, string cuenta, decimal importe, decimal divisas, decimal cambio, string tipo);INSERT INTO carpagos_cuentas
       ( empresa,   
         anyo,   
         orden,   
         cuenta,   
         importe,   
         divisas,   
         cambio,   
         tipo)   
VALUES ( :codigo_empresa,   
         :anyo,   
         :orden,   
         :cuenta,   
         :importe,   
         :divisas,   
         :cambio,   
         :tipo)
USING SQLCA ;
IF SQLCA.SQLCODE <> 0 Then
	f_mensaje("Error en f_insert_carpagos_cuentas",SQLCA.SQLERRTEXT)
	Return FALSE
END IF
Return TRUE
end function

public function boolean f_comprueba_si_existe_factura ();//Control de factura repetida
string   ls_factura,ls_tipoter,ls_clipro
long     ll_ejercicio,ll_existe_factura_en_otro_asiento
datetime ldt_ffactura

ls_factura   = em_fra.text
ldt_ffactura = datetime(date(em_ffra.text))
ll_ejercicio = year(date(ldt_ffactura))
ls_tipoter   = 'P'
ls_clipro    = uo_proveedor.em_codigo.text

if ll_ejercicio > 0 and trim(ls_clipro) <> "" and trim(ls_factura) <> "" then
	
	select isnull(count(*),0)
	into   :ll_existe_factura_en_otro_asiento
	from   contaapun
	where  contaapun.empresa   = :codigo_empresa
	and    contaapun.factura               = :ls_factura
	and    datepart(yy,contaapun.ffactura) = :ll_ejercicio
	and    contaapun.tipoter               = :ls_tipoter
	and    contaapun.clipro                = :ls_clipro;
	
	if ll_existe_factura_en_otro_asiento > 0 then
		messagebox("¡Error!","Se está introduciendo una factura duplicada.~nRevise los datos.")
		return true
	else
		return false
	end if
else	
	return false
end if
end function

event open;call super::open;This.title = " Introducción documentos compras"
em_ffra.text = String(Today(),"dd-mm-yy")
em_fapunte.text = String(Today(),"dd-mm-yy")
em_fregistro.text = String(Today(),"dd-mm-yy")
dw_detalle.Visible=FALSE
dw_ivas.Visible=FALSE
dw_recibos.Visible=FALSE
dw_recibos.SetTransObject(SQLCA)

//f_mascara_columna(dw_detalle,"importe",f_mascara_decimales(0))
//f_mascara_columna(dw_ivas,"base",f_mascara_decimales(0))
//f_mascara_columna(dw_ivas,"impiva",f_mascara_decimales(0))

f_mascara_columna(dw_detalle,"importe","###,###,##0.00")

conexion= "N"
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN 
	conexion= "S"
	f_posicion_inicio(This)
END IF

em_por_pp.text = "0"
em_por_esp.text = "0"
hoy = DateTime(Today())
retrasada = FALSE
   
f_activar_campo(uo_serie.em_campo)
end event

on w_int_carpagos.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_10=create gb_10
this.gb_2=create gb_2
this.gb_1=create gb_1
this.pb_salir=create pb_salir
this.em_ffra=create em_ffra
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.em_importe=create em_importe
this.cb_confirmar=create cb_confirmar
this.cb_salir=create cb_salir
this.st_22=create st_22
this.em_asiento=create em_asiento
this.st_33=create st_33
this.em_registro=create em_registro
this.st_88=create st_88
this.em_importe_irpf=create em_importe_irpf
this.st_89=create st_89
this.em_importe_pp=create em_importe_pp
this.st_90=create st_90
this.em_importe_esp=create em_importe_esp
this.st_91=create st_91
this.st_92=create st_92
this.em_por_pp=create em_por_pp
this.em_por_esp=create em_por_esp
this.em_banco=create em_banco
this.st_nombre_banco=create st_nombre_banco
this.st_1=create st_1
this.pago=create pago
this.em_por_irpf=create em_por_irpf
this.cbx_generar_pago=create cbx_generar_pago
this.cbx_fobs=create cbx_fobs
this.gb_4=create gb_4
this.dw_detalle=create dw_detalle
this.dw_ivas=create dw_ivas
this.st_333=create st_333
this.uo_proveedor=create uo_proveedor
this.em_fra=create em_fra
this.em_codpago=create em_codpago
this.st_nombre_codpago=create st_nombre_codpago
this.cb_continuar=create cb_continuar
this.uo_serie=create uo_serie
this.em_fapunte=create em_fapunte
this.st_15=create st_15
this.em_fregistro=create em_fregistro
this.st_16=create st_16
this.uo_moneda=create uo_moneda
this.uo_ejercicio=create uo_ejercicio
this.gb_5=create gb_5
this.dw_recibos=create dw_recibos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_10
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.pb_salir
this.Control[iCurrent+6]=this.em_ffra
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.st_7
this.Control[iCurrent+12]=this.em_importe
this.Control[iCurrent+13]=this.cb_confirmar
this.Control[iCurrent+14]=this.cb_salir
this.Control[iCurrent+15]=this.st_22
this.Control[iCurrent+16]=this.em_asiento
this.Control[iCurrent+17]=this.st_33
this.Control[iCurrent+18]=this.em_registro
this.Control[iCurrent+19]=this.st_88
this.Control[iCurrent+20]=this.em_importe_irpf
this.Control[iCurrent+21]=this.st_89
this.Control[iCurrent+22]=this.em_importe_pp
this.Control[iCurrent+23]=this.st_90
this.Control[iCurrent+24]=this.em_importe_esp
this.Control[iCurrent+25]=this.st_91
this.Control[iCurrent+26]=this.st_92
this.Control[iCurrent+27]=this.em_por_pp
this.Control[iCurrent+28]=this.em_por_esp
this.Control[iCurrent+29]=this.em_banco
this.Control[iCurrent+30]=this.st_nombre_banco
this.Control[iCurrent+31]=this.st_1
this.Control[iCurrent+32]=this.pago
this.Control[iCurrent+33]=this.em_por_irpf
this.Control[iCurrent+34]=this.cbx_generar_pago
this.Control[iCurrent+35]=this.cbx_fobs
this.Control[iCurrent+36]=this.gb_4
this.Control[iCurrent+37]=this.dw_detalle
this.Control[iCurrent+38]=this.dw_ivas
this.Control[iCurrent+39]=this.st_333
this.Control[iCurrent+40]=this.uo_proveedor
this.Control[iCurrent+41]=this.em_fra
this.Control[iCurrent+42]=this.em_codpago
this.Control[iCurrent+43]=this.st_nombre_codpago
this.Control[iCurrent+44]=this.cb_continuar
this.Control[iCurrent+45]=this.uo_serie
this.Control[iCurrent+46]=this.em_fapunte
this.Control[iCurrent+47]=this.st_15
this.Control[iCurrent+48]=this.em_fregistro
this.Control[iCurrent+49]=this.st_16
this.Control[iCurrent+50]=this.uo_moneda
this.Control[iCurrent+51]=this.uo_ejercicio
this.Control[iCurrent+52]=this.gb_5
this.Control[iCurrent+53]=this.dw_recibos
end on

on w_int_carpagos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_10)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.pb_salir)
destroy(this.em_ffra)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.em_importe)
destroy(this.cb_confirmar)
destroy(this.cb_salir)
destroy(this.st_22)
destroy(this.em_asiento)
destroy(this.st_33)
destroy(this.em_registro)
destroy(this.st_88)
destroy(this.em_importe_irpf)
destroy(this.st_89)
destroy(this.em_importe_pp)
destroy(this.st_90)
destroy(this.em_importe_esp)
destroy(this.st_91)
destroy(this.st_92)
destroy(this.em_por_pp)
destroy(this.em_por_esp)
destroy(this.em_banco)
destroy(this.st_nombre_banco)
destroy(this.st_1)
destroy(this.pago)
destroy(this.em_por_irpf)
destroy(this.cbx_generar_pago)
destroy(this.cbx_fobs)
destroy(this.gb_4)
destroy(this.dw_detalle)
destroy(this.dw_ivas)
destroy(this.st_333)
destroy(this.uo_proveedor)
destroy(this.em_fra)
destroy(this.em_codpago)
destroy(this.st_nombre_codpago)
destroy(this.cb_continuar)
destroy(this.uo_serie)
destroy(this.em_fapunte)
destroy(this.st_15)
destroy(this.em_fregistro)
destroy(this.st_16)
destroy(this.uo_moneda)
destroy(this.uo_ejercicio)
destroy(this.gb_5)
destroy(this.dw_recibos)
end on

event ue_esc;call super::ue_esc;IF pb_salir.enabled = TRUE Then
	pb_salir.TriggerEvent(Clicked!)
END IF
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_f5;call super::ue_f5;IF cb_continuar.Enabled = TRUE Then cb_continuar.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_carpagos
integer x = 50
integer y = 1408
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_carpagos
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_carpagos
integer x = 32
integer y = 8
integer width = 3205
end type

type gb_3 from groupbox within w_int_carpagos
integer x = 9
integer y = 100
integer width = 2555
integer height = 556
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_10 from groupbox within w_int_carpagos
boolean visible = false
integer x = 2391
integer y = 1252
integer width = 375
integer height = 212
integer taborder = 150
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
end type

type gb_2 from groupbox within w_int_carpagos
boolean visible = false
integer x = 2770
integer y = 1252
integer width = 375
integer height = 212
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
end type

type gb_1 from groupbox within w_int_carpagos
boolean visible = false
integer x = 2391
integer y = 1448
integer width = 754
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_salir from upb_salir within w_int_carpagos
integer x = 3259
integer y = 4
integer width = 110
integer height = 104
integer taborder = 0
boolean cancel = false
end type

event clicked;If conexion = "N" Then
	Close (Parent)
Else
	CloseWithReturn(Parent,em_asiento.text)
End If
end event

type em_ffra from u_em_campo within w_int_carpagos
integer x = 818
integer y = 332
integer width = 283
integer height = 80
integer taborder = 40
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

event modificado;call super::modificado;Integer dia_hoy,mes_hoy,mes_fac,anyo_fac

dw_detalle.reset()
IF date(em_ffra.text) > Today() THEN
	MessageBox("Fecha de Factura","La fecha es superior a la fecha del sistema",Exclamation!)
	f_activar_campo(em_ffra)
else
	dia_hoy  = day(date(hoy))
	mes_hoy  = month(date(hoy))
	mes_fac  = month(date(em_ffra.text))
	anyo_fac = year(date(em_ffra.text))
	if dia_hoy >= 20 then
		if mes_fac < mes_hoy then
			em_fregistro.text = String("01/"+string(mes_hoy,"##")+"/"+string(anyo_fac,"####"))
			retrasada = TRUE
		end if
	else
		if (mes_fac = mes_hoy - 1) or (mes_fac = mes_hoy) then
			em_fregistro.text = em_ffra.text
			retrasada = FALSE
		else
			em_fregistro.text = String("01/"+string(mes_hoy,"##")+"/"+string(anyo_fac,"####"))
			retrasada = TRUE
		end if
	end if
	em_fapunte.text  = em_ffra.text
	em_fregistro.text = em_ffra.text	
END IF
end event

type st_3 from statictext within w_int_carpagos
integer x = 32
integer y = 256
integer width = 270
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_carpagos
integer x = 23
integer y = 344
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Factura"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_carpagos
integer x = 672
integer y = 336
integer width = 146
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F.Fra "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_carpagos
integer x = 1102
integer y = 344
integer width = 215
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "C. Pago"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_int_carpagos
integer x = 69
integer y = 428
integer width = 233
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Importe "
alignment alignment = right!
boolean focusrectangle = false
end type

type em_importe from u_em_campo within w_int_carpagos
integer x = 306
integer y = 416
integer width = 503
integer taborder = 60
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,###"
end type

type cb_confirmar from u_boton within w_int_carpagos
boolean visible = false
integer x = 2405
integer y = 1484
integer width = 361
integer height = 124
integer taborder = 0
boolean bringtotop = true
string text = "&Confirmar"
end type

event clicked;call super::clicked;f_procesar()






end event

type cb_salir from u_boton within w_int_carpagos
boolean visible = false
integer x = 2770
integer y = 1484
integer width = 361
integer height = 124
integer taborder = 0
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;F_SALIR()
end event

type st_22 from statictext within w_int_carpagos
boolean visible = false
integer x = 2414
integer y = 1268
integer width = 329
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Asiento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_asiento from u_em_campo within w_int_carpagos
event modificado pbm_custom02
boolean visible = false
integer x = 2405
integer y = 1364
integer width = 347
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "######0"
string displaydata = "<ü"
end type

event modificado;call super::modificado;dw_detalle.reset()

end event

type st_33 from statictext within w_int_carpagos
boolean visible = false
integer x = 2793
integer y = 1268
integer width = 329
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Reg. Iva"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_registro from u_em_campo within w_int_carpagos
event modificado pbm_custom02
boolean visible = false
integer x = 2798
integer y = 1364
integer width = 329
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "######0"
string displaydata = "<ü"
end type

event modificado;call super::modificado;dw_detalle.reset()
end event

type st_88 from statictext within w_int_carpagos
integer x = 23
integer y = 516
integer width = 279
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Imp I.R.P.F."
alignment alignment = right!
boolean focusrectangle = false
end type

type em_importe_irpf from u_em_campo within w_int_carpagos
integer x = 425
integer y = 504
integer width = 384
integer taborder = 90
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,###"
end type

event modificado;call super::modificado;IF dw_ivas.RowCount() <> 0 Then
	dw_ivas.object.irpf[1] = Dec(em_importe_irpf.text)
END IF
end event

type st_89 from statictext within w_int_carpagos
integer x = 1079
integer y = 516
integer width = 238
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Dto. P.P."
alignment alignment = right!
boolean focusrectangle = false
end type

type em_importe_pp from u_em_campo within w_int_carpagos
integer x = 1605
integer y = 508
integer width = 475
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,###"
end type

type st_90 from statictext within w_int_carpagos
integer x = 1056
integer y = 428
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Dto. Com."
alignment alignment = right!
boolean focusrectangle = false
end type

type em_importe_esp from u_em_campo within w_int_carpagos
boolean visible = false
integer x = 1605
integer y = 536
integer width = 475
integer taborder = 160
boolean bringtotop = true
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,###"
end type

type st_91 from statictext within w_int_carpagos
integer x = 1541
integer y = 516
integer width = 55
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "%"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_92 from statictext within w_int_carpagos
integer x = 1536
integer y = 428
integer width = 55
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "%"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_por_pp from u_em_campo within w_int_carpagos
integer x = 1326
integer y = 508
integer width = 206
integer taborder = 100
boolean bringtotop = true
alignment alignment = right!
textcase textcase = anycase!
maskdatatype maskdatatype = numericmask!
string mask = "##,##"
string displaydata = ""
end type

event modificado;call super::modificado;//dtopp = Dec(This.text)
//em_importe_pp.text = String(Dec(em_importe.text) * dtopp / 100,f_mascara_moneda(uo_moneda.em_codigo.text))
end event

type em_por_esp from u_em_campo within w_int_carpagos
integer x = 1326
integer y = 420
integer width = 206
integer taborder = 70
boolean bringtotop = true
alignment alignment = right!
textcase textcase = anycase!
maskdatatype maskdatatype = numericmask!
string mask = "##,##"
string displaydata = "Ä"
end type

event modificado;call super::modificado;//dto1 = Dec(This.text)
//em_importe_esp.text = String(Dec(em_importe.text) * dto1 / 100,f_mascara_moneda(uo_moneda.em_codigo.text))
end event

type em_banco from u_em_campo within w_int_carpagos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 2798
integer y = 560
integer width = 178
integer height = 72
integer taborder = 0
integer textsize = -9
fontcharset fontcharset = ansi!
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE BANCO"
ue_datawindow ="dw_ayuda_carbancos"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;st_nombre_banco.text = f_nombre_banco_abr(codigo_empresa,em_banco.text)
end event

type st_nombre_banco from statictext within w_int_carpagos
integer x = 2981
integer y = 560
integer width = 274
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
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_int_carpagos
integer x = 2624
integer y = 568
integer width = 169
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Banco:"
boolean focusrectangle = false
end type

type pago from radiobutton within w_int_carpagos
boolean visible = false
integer x = 2624
integer y = 500
integer width = 539
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Pago Automático"
boolean automatic = false
boolean lefttext = true
end type

event clicked;IF checked Then
	checked = FALSE
ELSE
	checked = TRUE
END IF
end event

type em_por_irpf from u_em_campo within w_int_carpagos
event modificado pbm_custom02
integer x = 306
integer y = 504
integer width = 114
integer taborder = 80
boolean bringtotop = true
alignment alignment = right!
textcase textcase = anycase!
maskdatatype maskdatatype = numericmask!
string mask = "##,##"
string displaydata = ""
end type

event modificado;call super::modificado;//dtopp = Dec(This.text)
//em_importe_pp.text = String(Dec(em_importe.text) * dtopp / 100,f_mascara_moneda(uo_moneda.em_codigo.text))
end event

type cbx_generar_pago from checkbox within w_int_carpagos
integer x = 2624
integer y = 500
integer width = 379
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Generar efecto"
boolean checked = true
end type

type cbx_fobs from checkbox within w_int_carpagos
boolean visible = false
integer x = 2994
integer y = 532
integer width = 206
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fobs"
end type

type gb_4 from groupbox within w_int_carpagos
integer x = 2610
integer y = 472
integer width = 654
integer height = 168
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_detalle from u_datawindow within w_int_carpagos
integer y = 668
integer width = 3374
integer height = 560
integer taborder = 0
string dataobject = "dw_int_carpagos1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;valor_empresa = TRUE
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "tipo_iva"
	bus_titulo     = "VENTANA SELECCION DE IVAS "
	bus_datawindow = "dw_ayuda_contaiva_compras"
	bus_filtro     = "ejercicio = "+string(dec(uo_ejercicio.em_ejercicio.text))
CASE "cuenta"
	bus_titulo     = "VENTANA SELECCION DE CUENTAS "
	bus_datawindow = "dw_ayuda_contaplan_directo"
	bus_filtro     = "ejercicio = "+string(dec(uo_ejercicio.em_ejercicio.text))
CASE "concepto"
	bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
	bus_datawindow = "dw_ayuda_contaconcepto"
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event valores_numericos;call super::valores_numericos;f_valores_numericos(dw_detalle,"concepto")
f_valores_numericos(dw_detalle,"cuenta")

end event

event key;valor_empresa = TRUE
bus_filtro=""
bus_campo= ""
//IF  key <> KeyEnter! Then
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "tipo_iva"
		bus_titulo     = "VENTANA SELECCION DE IVAS "
		bus_datawindow = "dw_ayuda_contaiva_compras"
		bus_filtro     = "ejercicio = "+string(dec(uo_ejercicio.em_ejercicio.text))
	CASE "cuenta"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS "
		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro     = "ejercicio = "+string(dec(uo_ejercicio.em_ejercicio.text))
		
	CASE "concepto"
		bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
		bus_datawindow = "dw_ayuda_contaconcepto"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
// END IF

CALL Super::Key

IF  key = KeyF2! Then f_insertar_linea(dw_detalle.GetRow())
IF  key = KeyInsert! Then f_insertar_linea(dw_detalle.GetRow())
IF  key = KeyF3! Then f_borrar_linea(dw_detalle.GetRow())
end event

event itemchanged;String tipoiva,var_tipo
Dec  registro
Dec{2} var_importe
String ampli, concept

// para calcular el importe de iva
CHOOSE CASE  GetColumnName() 
	CASE "importe","tipo_iva","dpp","desp","irpf"
		post f_ivas()
END CHOOSE

IF GetColumnName()= "tipo_iva" Then
	AcceptText()
	tipoiva = dw_detalle.GetItemString(row,"tipo_iva")
	IF Not f_tipo_iva_compras(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,tipoiva) Then
		SetNull(tipoiva)
		SetItem(row,"tipo_iva",tipoiva)
		SetColumn("tipo_iva")
		Return
	END IF
	IF Not IsNull(tipoiva) and Trim(tipoiva) <> "" Then
		libro = f_libro_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,tipoiva)
		IF Not IsNull(libro) and Trim(libro) <> "" Then
			registro = f_contador_contalibros(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,libro)
			em_registro.text = STring(registro,f_mascara_decimales(0))
		END IF
	END IF
END IF

IF GetColumnName() = "cuenta" THEN
	AcceptText()
	ampli = dw_detalle.GetitemString(row,"ampliacion")
	IF Trim(ampli) = "" OR IsNull(ampli) THEN
		ampli = "Fra "+em_fra.text+" "+uo_proveedor.em_campo.text
		dw_detalle.SetItem(row,"ampliacion",ampli)
	END IF
	if varias <> "" then
		if varias = "A" then
			dw_detalle.SetItem(row,"tipo","A")
			dw_detalle.SetItem(row,"tipo_iva","3")
		end if
		if varias = "G" then
			dw_detalle.SetItem(row,"tipo","G")
			dw_detalle.SetItem(row,"tipo_iva","3")
		end if
		if varias = "I" then
			dw_detalle.SetItem(row,"tipo","I")
			dw_detalle.SetItem(row,"tipo_iva","11")
		end if
	else
		if trim(em_importe_irpf.text) <> "" or trim(em_por_irpf.text) <> "" then
//			dw_detalle.SetItem(row,"tipo","A")
			dw_detalle.SetItem(row,"tipo_iva","3")
		end if
		if left(data,1) = "6" or left(data,1) = "4" then
//			dw_detalle.SetItem(row,"tipo","G")
			dw_detalle.SetItem(row,"tipo_iva","3")
		end if
		if left(data,1) = "2" then
//			dw_detalle.SetItem(row,"tipo","I")
			dw_detalle.SetItem(row,"tipo_iva","11")
		end if
	end if
END IF

IF GetColumnName() = "tipo" THEN
	AcceptText()
	choose case uo_serie.em_codigo.text
		case "1"
			if left(data,1) = "A" or left(data,1) = "G" then
				dw_detalle.SetItem(row,"tipo_iva","3")
			end if
			if left(data,1) = "I" then
				dw_detalle.SetItem(row,"tipo_iva","11")
			end if
		case "2"
			if left(data,1) = "A" or left(data,1) = "G" then
				dw_detalle.SetItem(row,"tipo_iva","13")
			end if
			if left(data,1) = "I" then
				dw_detalle.SetItem(row,"tipo_iva","15")
			end if
		case "3"
			dw_detalle.SetItem(row,"tipo_iva","10")
	end choose
END IF

IF GetColumnName() = "importe" THEN
	AcceptText()
	var_importe = dec(data) - (dec(data) * dw_detalle.GetItemNumber(row,"dto")/100)
	dw_detalle.SetItem(row,"neto",var_importe)
END IF

IF GetColumnName() = "desp" THEN
	AcceptText()
	if data = "S" then
		dw_detalle.SetItem(row,"dto",dec(em_por_esp.text))
		var_importe = dw_detalle.GetItemNumber(row,"importe") - (dw_detalle.GetItemNumber(row,"importe") * dw_detalle.GetItemNumber(row,"dto")/100)
	else
		var_importe = dw_detalle.GetItemNumber(row,"importe")
		dw_detalle.SetItem(row,"dto",0)
	end if
	dw_detalle.SetItem(row,"neto",var_importe)
END IF

end event

event itemfocuschanged;call super::itemfocuschanged;String ampli,var_tipo

IF GetColumnName() = "cuenta" OR IsNull(ampli) THEN
	ampli = dw_detalle.GetitemString(row,"ampliacion")
	IF Trim(ampli) = "" THEN
		ampli = "FR. " + Trim(em_fra.text) + " " + Trim(uo_proveedor.em_campo.text)
		dw_detalle.SetItem(row,"ampliacion",ampli)
	END IF
END IF

if dwo.name = "concepto" then
	if varias <> "" then
		var_tipo = dw_detalle.GetitemString(row,"tipo")
		if varias <> var_tipo then
			messagebox("Atención","Opción no permitida "+var_tipo)
			dw_detalle.SetItem(row,"tipo",varias)
			This.SetColumn("tipo")
		end if
	end if
end if
end event

event clicked;call super::clicked;if dwo.name = "insertar" then
	f_insertar_linea(dw_detalle.GetRow())	
end if
if dwo.name = "borrar" then
	f_borrar_linea(dw_detalle.GetRow())
end if

end event

type dw_ivas from u_datawindow within w_int_carpagos
event rbuttondown pbm_dwnrbuttondown
event key pbm_dwnkey
event valores_numericos pbm_custom01
integer y = 1240
integer width = 2327
integer height = 368
integer taborder = 0
string dataobject = "dw_int_carpagos2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;f_ivas()

IF f_objeto_datawindow(dw_ivas)= "recalcular" Then
	IF dec(em_importe_irpf.text) <> irpftot THEN 
		messagebox("error en la factura "," Valor de IRPF distinto del calculado ")
		em_importe_irpf.text = String(irpftot,f_mascara_moneda(uo_moneda.em_codigo.text))
	end if
	IF dec(em_importe_pp.text) <> dpptot THEN 
		messagebox("error en la factura "," Valor del descuento P.P. distinto del calculado ")
		em_importe_pp.text = String(dpptot,f_mascara_moneda(uo_moneda.em_codigo.text))
	end if
	IF dec(em_importe_esp.text) <> desptot THEN 
		messagebox("error en la factura "," Valor del descuento Especial distinto del calculado ")
		em_importe_esp.text = String(desptot,f_mascara_moneda(uo_moneda.em_codigo.text))
	end if
	This.object.irpf[1] = Dec(em_importe_irpf.text)
	em_importe_irpf.enabled= TRUE
	em_importe_esp.enabled = TRUE
	em_importe_pp.enabled= TRUE
	em_importe_pp.enabled= TRUE
END IF
//
//f_ivas()
//
//IF f_objeto_datawindow(dw_ivas)= "recalcular" Then
//	em_importe_irpf.text = String(Dec(This.object.baset[1]) * dec(em_por_irpf.text) / 100,f_mascara_moneda(uo_moneda.em_codigo.text))
//	em_importe_pp.text = String(Dec(This.object.baset[1]) * dtopp / 100,f_mascara_moneda(uo_moneda.em_codigo.text))
//	em_importe_esp.text = String(Dec(This.object.baset[1]) * dto1 / 100,f_mascara_moneda(uo_moneda.em_codigo.text))
//	This.object.irpf[1] = Dec(em_importe_irpf.text)
//	em_importe_irpf.enabled= TRUE
//	em_importe_esp.enabled = TRUE
//	em_importe_pp.enabled= TRUE
//END IF
end event

type st_333 from statictext within w_int_carpagos
integer x = 32
integer y = 160
integer width = 270
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Serie"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_proveedor from u_em_campo_2 within w_int_carpagos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 306
integer y = 244
integer width = 1353
integer height = 80
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String proveedor,banco_proveedor
String textoactivo
Long cuantos

uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)

IF Trim(uo_proveedor.em_campo.text)="" THEN 
	IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
	Return
END IF

IF f_activo_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)= "N" Then
	textoactivo = f_textoactivo_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
	MessageBox("Proveedor Inactivo",textoactivo+" Para pasar la factura hay que activarlo.",information!,Ok!) 
	uo_proveedor.em_campo.text = ""
	uo_proveedor.em_codigo.text = ""
	Return
END IF

uo_moneda.em_codigo.text = f_moneda_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
uo_moneda.em_campo.text =f_nombre_moneda(uo_moneda.em_codigo.text)
em_importe.setmask (decimalmask!,f_mascara_moneda(uo_moneda.em_codigo.text))
em_importe_irpf.setmask (decimalmask!,f_mascara_moneda(uo_moneda.em_codigo.text))
em_codpago.text =f_codpago_comprov(codigo_empresa,uo_proveedor.em_codigo.text)
em_codpago.TriggerEvent("modificado")
IF dw_recibos.retrieve(codigo_empresa,uo_proveedor.em_codigo.text) = 0 Then
	dw_recibos.visible = FALSE
ELSE
	dw_recibos.visible = TRUE
END IF
proveedor=uo_proveedor.em_codigo.text

SELECT comproveedores.irpf,comproveedores.dtopp,comproveedores.dto1,comproveedores.banco
INTO :irpf,:dtopp,:dto1,:banco_proveedor  
FROM comproveedores  
WHERE comproveedores.empresa = :codigo_empresa
AND   comproveedores.codigo  = :proveedor;

IF sqlca.sqlcode = 100 Then
	em_por_pp.text  		= "0"
	em_por_esp.text 		= "0"
	em_banco.text 			= ""
	st_nombre_banco.text = ""
ELSE
	em_por_pp.text  		= String(dtopp)
	em_por_esp.text 		= String(dto1)
	em_por_irpf.text		= String(irpf)
	em_banco.text   		= banco_proveedor
	st_nombre_banco.text = f_nombre_banco_abr(codigo_empresa,banco_proveedor)	
END IF

SELECT count(*)
INTO :cuantos
FROM comproveedores_cuenta
WHERE comproveedores_cuenta.empresa = :codigo_empresa
AND   comproveedores_cuenta.codigo  = :proveedor;
if cuantos = 0 then
	messagebox("Atención","Este proveedor no tiene cuentas contables")
	varias = ""
	f_activar_campo(uo_proveedor.em_campo)
	return
else
	if cuantos = 1 then
		SELECT comproveedores_cuenta.tipo
		INTO  :varias
		FROM  comproveedores_cuenta
		WHERE comproveedores_cuenta.empresa = :codigo_empresa
		AND   comproveedores_cuenta.codigo  = :proveedor;
	else
		varias = ""
	end if
end if
end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE PROVEEDORES"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE
end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type em_fra from u_em_campo within w_int_carpagos
integer x = 306
integer y = 332
integer width = 366
integer height = 80
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
end type

type em_codpago from u_em_campo within w_int_carpagos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1326
integer y = 332
integer width = 206
integer height = 80
integer taborder = 50
boolean bringtotop = true
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Formas de pago"
ue_datawindow = "dw_ayuda_carforpag"
ue_filtro     = ""
valor_empresa = TRUE
end event

event modificado;call super::modificado;st_nombre_codpago.text=f_nombre_carforpag(codigo_empresa,em_codpago.text)
IF LEN(st_nombre_codpago.text)=0 THEN 
   IF LEN(em_codpago.text)<>0 Then f_activar_campo(em_codpago)
   em_codpago.text="" 
   Return
END IF
//IF st_nombre_codpago.text = "CONTADO" Then
//	pago.checked = TRUE
//ELSE
	pago.checked = FALSE
//END IF
//




end event

type st_nombre_codpago from statictext within w_int_carpagos
integer x = 1536
integer y = 332
integer width = 987
integer height = 84
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_continuar from u_boton within w_int_carpagos
integer x = 2162
integer y = 500
integer width = 361
integer height = 140
integer taborder = 140
boolean bringtotop = true
string text = "F5 Continuar"
end type

event clicked;Dec  registro
Long cuentas

if em_codpago.text = '' or isnull(em_codpago.text) then
	messagebox("Aviso", "El proveedor no tinen forma de pago")
else

	IF uo_serie.em_codigo.text = "" Then
		f_mensaje("Error en datos","Introduzca la serie")
		f_activar_campo(uo_serie.em_campo)
		Return
	End IF
	
	IF uo_proveedor.em_codigo.text = "" Then
		f_mensaje("Error en datos","Introduzca el proveedor")
		f_activar_campo(uo_proveedor.em_campo)
		Return
	End IF
	
	select count(*)
	into :cuentas
	from comproveedores_cuenta
	where empresa = :codigo_empresa and codigo = :uo_proveedor.em_codigo.text;
	
	if isnull(cuentas) or cuentas = 0 then
		f_mensaje("Error en datos","Este proveedor no tiene cuenta contable")
		f_activar_campo(uo_proveedor.em_campo)
		Return
	end if
	
	IF em_codpago.text = "" Then
		pagos = "N"
	ELSE
		pagos = "S"
	End IF
	
	IF em_ffra.text="" Then
		f_mensaje("Error en datos","Introduzca la fecha fra")
		f_activar_campo(em_ffra)
		Return
	End IF
	
	IF em_fapunte.text="" Then
		f_mensaje("Error en datos","Introduzca la fecha del apunte")
		f_activar_campo(em_fapunte)
		Return
	End IF
	
	IF Year(Date(em_fapunte.text)) <> Dec(uo_ejercicio.em_ejercicio.text) Then
		f_mensaje("Error en datos","La Fecha no corresponde con el ejercicio")
		f_activar_campo(em_fapunte)
		Return
	END IF
	
	IF em_fra.text = "" Then
		f_mensaje("Error en datos","Introduzca la factura de pago")
		f_activar_campo(em_fra)
		Return
	End IF
	
	IF em_importe.text = "" or em_importe.text = "0" Then
		f_mensaje("Error en datos","Introduzca el total factura")
		f_activar_campo(em_importe)
		Return
	End IF
	
	IF Dec(em_importe_pp.text) > 0 AND Dec(em_por_pp.text) = 0 THEN
		f_mensaje("Error en datos","Introduzca el porcentaje de Pronto Pago")
		f_activar_campo(em_por_pp)
		Return
	End IF
	
	IF Dec(em_importe_pp.text) = 0 AND Dec(em_por_pp.text) > 0 THEN
		f_mensaje("Error en datos","Introduzca el Importe de Pronto Pago")
		f_activar_campo(em_importe_pp)
		Return
	End IF
	
	//IF Dec(em_importe_esp.text) > 0 AND Dec(em_por_esp.text) = 0 THEN
	//	f_mensaje("Error en datos","Introduzca el porcentaje de Descuento Especial")
	//	f_activar_campo(em_por_esp)
	//	Return
	//End IF
	//
	//IF Dec(em_importe_esp.text) = 0 AND Dec(em_por_esp.text) > 0 THEN
	//	f_mensaje("Error en datos","Introduzca el Importe de Descuento Especial")
	//	f_activar_campo(em_importe_esp)
	//	Return
	//End IF
	
	IF em_banco.text = "" and pago.checked = TRUE Then
		f_mensaje("Error en datos","Introduzca el banco")
		f_activar_campo(em_banco)
		Return
	End IF
			
	if f_comprueba_si_existe_factura() then
		return
	end if
			
	f_activar(FALSE)
	dw_detalle.Reset()
	f_insertar_linea (0)
end if
end event

type uo_serie from u_em_campo_2 within w_int_carpagos
event destroy ( )
integer x = 306
integer y = 156
integer width = 914
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_serie.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_serie.em_campo.text=f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)

If Trim(uo_serie.em_campo.text)="" then
	uo_serie.em_campo.text=""
	uo_serie.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Series"
	ue_datawindow ="dw_ayuda_venseries"
	ue_filtro = ""

end event

type em_fapunte from u_em_campo within w_int_carpagos
event modificado pbm_custom02
integer x = 2889
integer y = 284
integer width = 347
integer height = 72
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;dw_detalle.reset()
IF date(em_fapunte.text) > Today() THEN
	MessageBox("Fecha de Asiento","La fecha es superior a la fecha del sistema",Exclamation!)
	f_activar_campo(em_fapunte)
END IF


end event

type st_15 from statictext within w_int_carpagos
integer x = 2679
integer y = 284
integer width = 192
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F.Asto"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fregistro from u_em_campo within w_int_carpagos
integer x = 2889
integer y = 392
integer width = 347
integer height = 72
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;dw_detalle.reset()
IF date(em_fregistro.text) > Today() THEN
	MessageBox("Fecha del Registro de IVA","La fecha es superior a la fecha del sistema",Exclamation!)
	f_activar_campo(em_fapunte)
END IF


end event

type st_16 from statictext within w_int_carpagos
integer x = 2642
integer y = 392
integer width = 238
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F.reg.IVA"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_moneda from u_em_campo_2 within w_int_carpagos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1701
integer y = 244
integer width = 581
integer height = 80
boolean bringtotop = true
boolean border = true
long backcolor = 128
borderstyle borderstyle = stylelowered!
end type

event modificado;
uo_moneda.em_campo.text = f_nombre_moneda_abr(uo_moneda.em_codigo.text)

IF Trim(uo_moneda.em_campo.text)="" THEN 
 IF Trim(uo_moneda.em_codigo.text)<>"" Then uo_moneda.em_campo.SetFocus()
 uo_moneda.em_campo.text=""
 uo_moneda.em_codigo.text=""
else
	em_importe.setmask(NumericMask!,f_mascara_moneda(uo_moneda.em_codigo.text))
	em_importe_esp.setmask(NumericMask!,f_mascara_moneda(uo_moneda.em_codigo.text))
	em_importe_irpf.setmask(NumericMask!,f_mascara_moneda(uo_moneda.em_codigo.text))
	em_importe_pp.setmask(NumericMask!,f_mascara_moneda(uo_moneda.em_codigo.text))
END IF

dw_detalle.Reset()

end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE MONEDAS"
ue_datawindow = "dw_ayuda_divisas"
ue_filtro     = ""
valor_empresa = FALSE
end event

on uo_moneda.destroy
call u_em_campo_2::destroy
end on

type uo_ejercicio from u_ejercicio within w_int_carpagos
event destroy ( )
integer x = 2615
integer y = 180
integer height = 232
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type gb_5 from groupbox within w_int_carpagos
integer x = 2555
integer y = 96
integer width = 745
integer height = 560
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_recibos from datawindow within w_int_carpagos
boolean visible = false
integer x = 23
integer y = 600
integer width = 1984
integer height = 604
string dataobject = "dw_int_carpagos3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

