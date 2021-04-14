$PBExportHeader$w_int_facturas_compras.srw
$PBExportComments$Introducción de facturas de compras.
forward
global type w_int_facturas_compras from w_int_con_empresa
end type
type pb_salir from upb_salir within w_int_facturas_compras
end type
type em_fechafac from u_em_campo within w_int_facturas_compras
end type
type st_1 from statictext within w_int_facturas_compras
end type
type uo_proveedor from u_em_campo_2 within w_int_facturas_compras
end type
type st_5 from statictext within w_int_facturas_compras
end type
type st_2 from statictext within w_int_facturas_compras
end type
type em_anyofac from u_em_campo within w_int_facturas_compras
end type
type em_codpago from u_em_campo within w_int_facturas_compras
end type
type cb_salir from u_boton within w_int_facturas_compras
end type
type st_3 from statictext within w_int_facturas_compras
end type
type em_tipoiva from u_em_campo within w_int_facturas_compras
end type
type em_numfac from u_em_campo within w_int_facturas_compras
end type
type cb_continuar from u_boton within w_int_facturas_compras
end type
type cb_procesar from u_boton within w_int_facturas_compras
end type
type st_323 from statictext within w_int_facturas_compras
end type
type em_fapunte from u_em_campo within w_int_facturas_compras
end type
type st_223 from statictext within w_int_facturas_compras
end type
type em_asiento from u_em_campo within w_int_facturas_compras
end type
type st_8888 from statictext within w_int_facturas_compras
end type
type em_impfac from u_em_campo within w_int_facturas_compras
end type
type st_33 from statictext within w_int_facturas_compras
end type
type em_moneda from u_em_campo within w_int_facturas_compras
end type
type st_nombre_codpago from statictext within w_int_facturas_compras
end type
type st_nombre_moneda from statictext within w_int_facturas_compras
end type
type st_34 from statictext within w_int_facturas_compras
end type
type em_dtopp from u_em_campo within w_int_facturas_compras
end type
type em_dto1 from u_em_campo within w_int_facturas_compras
end type
type st_35 from statictext within w_int_facturas_compras
end type
type st_tipoiva from statictext within w_int_facturas_compras
end type
type em_totbruto from u_em_campo within w_int_facturas_compras
end type
type em_totdtopp from u_em_campo within w_int_facturas_compras
end type
type em_totdto1 from u_em_campo within w_int_facturas_compras
end type
type em_baseimpon from u_em_campo within w_int_facturas_compras
end type
type em_totiva from u_em_campo within w_int_facturas_compras
end type
type em_totfactura from u_em_campo within w_int_facturas_compras
end type
type st_7 from statictext within w_int_facturas_compras
end type
type st_8 from statictext within w_int_facturas_compras
end type
type st_9 from statictext within w_int_facturas_compras
end type
type st_10 from statictext within w_int_facturas_compras
end type
type st_11 from statictext within w_int_facturas_compras
end type
type st_12 from statictext within w_int_facturas_compras
end type
type r_2 from rectangle within w_int_facturas_compras
end type
type st_55 from statictext within w_int_facturas_compras
end type
type st_4444443 from statictext within w_int_facturas_compras
end type
type st_cambio from statictext within w_int_facturas_compras
end type
type st_nombre_moneda2 from statictext within w_int_facturas_compras
end type
type st_36 from statictext within w_int_facturas_compras
end type
type em_decimales_precios from u_em_campo within w_int_facturas_compras
end type
type gb_1 from groupbox within w_int_facturas_compras
end type
type uo_ejercicio from u_ejercicio within w_int_facturas_compras
end type
type dw_cta from datawindow within w_int_facturas_compras
end type
type cb_1 from commandbutton within w_int_facturas_compras
end type
type pb_1 from picturebutton within w_int_facturas_compras
end type
type dw_detalle_cuentas from u_datawindow within w_int_facturas_compras
end type
type dw_detalle from u_datawindow within w_int_facturas_compras
end type
type dw_factura_proveedor from datawindow within w_int_facturas_compras
end type
type dw_detalle_bases_imponibles from datawindow within w_int_facturas_compras
end type
type cb_grabar from commandbutton within w_int_facturas_compras
end type
type dw_agrupa_articulos from datawindow within w_int_facturas_compras
end type
type st_4 from statictext within w_int_facturas_compras
end type
type st_6 from statictext within w_int_facturas_compras
end type
type em_desde from u_em_campo within w_int_facturas_compras
end type
type em_hasta from u_em_campo within w_int_facturas_compras
end type
end forward

global type w_int_facturas_compras from w_int_con_empresa
integer x = 5
integer y = 16
integer width = 8535
integer height = 4036
string title = "Consulta de Movimientos"
long backcolor = 32238571
pb_salir pb_salir
em_fechafac em_fechafac
st_1 st_1
uo_proveedor uo_proveedor
st_5 st_5
st_2 st_2
em_anyofac em_anyofac
em_codpago em_codpago
cb_salir cb_salir
st_3 st_3
em_tipoiva em_tipoiva
em_numfac em_numfac
cb_continuar cb_continuar
cb_procesar cb_procesar
st_323 st_323
em_fapunte em_fapunte
st_223 st_223
em_asiento em_asiento
st_8888 st_8888
em_impfac em_impfac
st_33 st_33
em_moneda em_moneda
st_nombre_codpago st_nombre_codpago
st_nombre_moneda st_nombre_moneda
st_34 st_34
em_dtopp em_dtopp
em_dto1 em_dto1
st_35 st_35
st_tipoiva st_tipoiva
em_totbruto em_totbruto
em_totdtopp em_totdtopp
em_totdto1 em_totdto1
em_baseimpon em_baseimpon
em_totiva em_totiva
em_totfactura em_totfactura
st_7 st_7
st_8 st_8
st_9 st_9
st_10 st_10
st_11 st_11
st_12 st_12
r_2 r_2
st_55 st_55
st_4444443 st_4444443
st_cambio st_cambio
st_nombre_moneda2 st_nombre_moneda2
st_36 st_36
em_decimales_precios em_decimales_precios
gb_1 gb_1
uo_ejercicio uo_ejercicio
dw_cta dw_cta
cb_1 cb_1
pb_1 pb_1
dw_detalle_cuentas dw_detalle_cuentas
dw_detalle dw_detalle
dw_factura_proveedor dw_factura_proveedor
dw_detalle_bases_imponibles dw_detalle_bases_imponibles
cb_grabar cb_grabar
dw_agrupa_articulos dw_agrupa_articulos
st_4 st_4
st_6 st_6
em_desde em_desde
em_hasta em_hasta
end type
global w_int_facturas_compras w_int_facturas_compras

type variables
String conexion
String pagos = "S"
STring moneda
Integer laprimeravez = 0
Dec  cambio
string texto_vencimientos
dec{2} importe_acree, importe_prove, importe_inmov

end variables

forward prototypes
public subroutine f_activar ()
public subroutine f_desactivar ()
public function boolean f_grabar_apuntes ()
public function boolean f_grabar_pagos ()
public function boolean f_grabar_facturas ()
public subroutine f_datos_albaran (string empresa, string anyo, string albaran)
public subroutine f_comprueba_si_existe_factura ()
public subroutine f_calculo_totales_fra ()
public function boolean f_procesar ()
public function boolean f_insertar_carpagos_cuentas (long anyo, long orden, string cuenta, decimal importe, decimal divisas, decimal camb, string tipo)
end prototypes

public subroutine f_activar ();// Activar cabecera
uo_proveedor.em_campo.Enabled  = TRUE
uo_proveedor.em_codigo.Enabled = TRUE
em_codpago.Enabled             = TRUE
em_tipoiva.Enabled             = TRUE
em_moneda.Enabled              = TRUE
em_decimales_precios.Enabled   = TRUE
em_dtopp.Enabled               = TRUE
em_dto1.Enabled                = TRUE
em_anyofac.Enabled             = TRUE
em_numfac.Enabled              = TRUE
em_fechafac.Enabled            = TRUE
cb_continuar.Enabled           = TRUE

em_desde.enabled = true
em_hasta.enabled = true


// Desactivar DW
dw_detalle.Reset()
dw_detalle.Visible             = FALSE
dw_detalle_cuentas.visible     = false

dw_agrupa_articulos.Reset()
dw_agrupa_articulos.Visible             = FALSE

//dw_detalle_bases_imponibles.visible = false

cb_salir.Visible               = FALSE
cb_grabar.Visible           = false

cb_procesar.Visible            = FALSE

laprimeravez       = 0
em_numfac.text     = ""
em_fechafac.text   = ""
em_impfac.text     = ""
em_totbruto.text   = ""
em_totdtopp.text	 = ""
em_totdto1.text	 = ""
em_baseimpon.text	 = ""
em_totiva.text		 = ""
em_totfactura.text = ""

dw_factura_proveedor.visible = false
end subroutine

public subroutine f_desactivar ();// Desactivar cabecera
uo_proveedor.em_campo.Enabled  = FALSE
uo_proveedor.em_codigo.Enabled = FALSE
em_codpago.Enabled             = FALSE
em_tipoiva.Enabled            = FALSE
em_moneda.Enabled             = FALSE
em_decimales_precios.Enabled  = FALSE
em_dtopp.Enabled              = FALSE
em_dto1.Enabled               = FALSE
em_anyofac.Enabled            = FALSE
em_numfac.Enabled             = FALSE
em_fechafac.Enabled           = FALSE
cb_continuar.Enabled          = FALSE

em_desde.enabled = false
em_hasta.enabled = false



// Activar DW
dw_detalle.Visible            = TRUE
cb_salir.Visible              = TRUE
cb_procesar.Visible           = TRUE
cb_grabar.Visible           = true


dw_agrupa_articulos.Visible             = TRUE



em_totbruto.text   = ""
em_totdtopp.text	 = ""
em_totdto1.text	 = ""
em_baseimpon.text	 = ""
em_totiva.text		 = ""
em_totfactura.text = ""

dw_factura_proveedor.visible = false
end subroutine

public function boolean f_grabar_apuntes ();Integer r,r1,var_anyo
String  lamoneda,cuenta,dh,libro,tipo_iva,filtro,mascara_moneda_empresa,mascara_moneda,sel
string  libro_auto = ""
Dec     importe
dec{2}  debe_total,haber_total,diferencia,porcentaje,porcentaje_total
dec	  var_divisas_linea,var_importe_linea,var_divisas_cuenta,var_importe_cuenta,var_importe_total_cuentas
dec     divisas
long    indice,total,indice2,total2,var_albaran,var_linea,donde,registro
boolean bien
str_contaapun    conta
str_costesapu	  coste

Datastore dw_cuentas_gastos

bien     = true
lamoneda = Trim(em_moneda.text)
cambio   = f_cambio_moneda(lamoneda)
IF cambio = 0 OR IsNull(cambio) THEN cambio = 1

mascara_moneda_empresa = f_mascara_moneda(f_moneda_empresa(codigo_empresa))
mascara_moneda         = f_mascara_moneda(lamoneda)

// Valores comunes a todos los apuntes de todos los asientos
conta.empresa    = codigo_empresa
conta.ejercicio  = Dec(uo_ejercicio.em_ejercicio.text)
conta.origen     = "3"
conta.fapunte    = DateTime(Date(em_fapunte.text))
conta.mes        = Month(Date(conta.fapunte))
conta.asiento    = f_ultimo_asiento(conta.ejercicio,conta.empresa,conta.mes,conta.origen)
conta.apunte     = 0
em_asiento.text  = String(conta.asiento,f_mascara_decimales(0))

// APUNTE A LA CUENTA DEL PROVEEDOR  //

conta.divisas    = Dec(em_totfactura.text)
conta.concepto   = f_concepto_contagene(codigo_empresa,"1")
conta.ampliacion = "FRA. "+Trim(em_numfac.text)+" "+texto_vencimientos
dh = f_dh_contagene(codigo_empresa,"1")
if dh = "H" then
	conta.debe  = 0
	conta.haber = Dec(String(conta.divisas / cambio,mascara_moneda_empresa))
else
	conta.haber = 0
	conta.debe  = Dec(String(conta.divisas / cambio,mascara_moneda_empresa))
end if
conta.deducible   = "N"
conta.actualizado = "N"
conta.listado     = "N"
conta.tipoter     = "P"
//conta.cuenta      = f_cuenta_genter(conta.empresa,conta.tipoter,Trim(uo_proveedor.em_codigo.text))
//conta.cuenta      = f_cuenta_genter_2(conta.empresa,conta.tipoter,Trim(uo_proveedor.em_codigo.text))
// David 04-03-03
conta.cuenta = f_cta_comproveedor(codigo_empresa, Trim(uo_proveedor.em_codigo.text), "G")
if conta.cuenta = "" then
	conta.cuenta = f_cta_comproveedor(codigo_empresa, Trim(uo_proveedor.em_codigo.text), "A")
end if
if conta.cuenta = "" then
	messagebox("Revisar las cuentas del proveedor", "No existe cuenta de Proveedor ni acreedor")
	bien = false
end if
// fin david 04-03-03
conta.moneda      = lamoneda
conta.cambio      = cambio
conta.documento   = em_numfac.text
conta.factura     = em_numfac.text
conta.ffactura    = DateTime(date(em_fechafac.text))
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
IF Not f_insert_contaapun(conta) Then bien = false

// APUNTE A LA CUENTA DE DESCUENTOS P.P. Y COMERCIAL  //

IF Dec(em_totdtopp.text) + Dec(em_dto1.text) <> 0 THEN
	conta.cuenta	  = f_cuenta_contagene(codigo_empresa,"4")
	conta.divisas    = Dec(em_totdtopp.text) + Dec(em_totdto1.text)
	conta.concepto   = f_concepto_contagene(codigo_empresa,"4")
	conta.ampliacion = "FRA. "+Trim(em_numfac.text)+' '+uo_proveedor.em_campo.text
	dh = f_dh_contagene(codigo_empresa,"4")
	if dh = "H" then
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas / cambio,mascara_moneda_empresa))
	else
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas / cambio,mascara_moneda_empresa))
	end if
	conta.deducible   = "N"
	conta.actualizado = "N"
	conta.listado     = "N"
	conta.tipoter     = "P"
	conta.moneda      = lamoneda
	conta.cambio      = cambio
	conta.documento   = em_numfac.text
	conta.factura     = em_numfac.text
	conta.ffactura    = DateTime(date(em_fechafac.text))
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
	IF Not f_insert_contaapun(conta) Then bien = false
END IF

/// APUNTE AL I.V.A.    //
total = dw_detalle_bases_imponibles.rowcount()

for indice = 1 to total
	tipo_iva = dw_detalle_bases_imponibles.object.tipo_iva[indice]
	libro		= dw_detalle_bases_imponibles.object.libro[indice]
	registro = dw_detalle_bases_imponibles.object.registro[indice]
	//Modificacion para poder contabilizar varios libros de iva
	if registro = 0 then
		registro = f_contador_contalibros(conta.ejercicio,conta.empresa,libro)
		for indice2 = 1 to total
			if dw_detalle_bases_imponibles.object.libro[indice2] = libro and dw_detalle_bases_imponibles.object.registro[indice2] = 0 then
				dw_detalle_bases_imponibles.object.registro[indice2] = registro				
			end if
		next
	end if	

	conta.divisas    = dw_detalle_bases_imponibles.object.importe_iva[indice]
	
	conta.apunte     = conta.apunte + 1
	conta.concepto   = f_concepto_contagene(codigo_empresa,"2")
	conta.ampliacion = "FRA. "+Trim(em_numfac.text)+' '+uo_proveedor.em_campo.text
	dh = f_dh_contagene(codigo_empresa,"2")
	if dh = "H" then
		conta.debe  = 0
		conta.haber = Dec(String(conta.divisas / cambio,mascara_moneda_empresa))
	else
		conta.haber = 0
		conta.debe  = Dec(String(conta.divisas / cambio,mascara_moneda_empresa))
	end if
	conta.clipro    = Trim(uo_proveedor.em_codigo.text)
	conta.nif       = f_cif_genter(conta.empresa,conta.tipoter,conta.clipro)
	conta.tipoiva   = tipo_iva
	conta.iva       = f_iva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
	conta.cuenta    = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
	conta.tipoapu   = libro
	conta.imponible = dec(string(dw_detalle_bases_imponibles.object.base_imponible[indice]/cambio,f_mascara_moneda(f_moneda_empresa(codigo_empresa))))
	conta.registro  = registro
	conta.fregistro = conta.fapunte
	
	IF Not f_insert_contaapun(conta) Then bien = false
	// Nuevo		
	// El tipo 13 (iva de compras autorrepercutido) es un caso especial
	//  - No se suma al total de la factura
	//  - Se hace otro apunte al tipo 14 (iva de ventas autorrepercutido)
	//		por la misma cantidad
	
	if conta.tipoiva = "13" or conta.tipoiva = "25" then
		conta.apunte     = conta.apunte + 1
		// Hacenos el apunte por el iva tipo 14
		if dh = "H" then
			conta.haber = 0
			conta.debe  = Dec(String(conta.divisas / cambio,mascara_moneda_empresa))
		else
			conta.debe  = 0
			conta.haber = Dec(String(conta.divisas / cambio,mascara_moneda_empresa))
		end if
		
		//IVA REPERCUTIDO
		if conta.tipoiva = "13" then
			conta.tipoiva = "14"
		elseif conta.tipoiva = "25" then
			conta.tipoiva = "26"
		end if
		
		//conta.tipoiva = "14"

		libro_auto		 = f_libro_contaiva(conta.ejercicio,codigo_empresa,conta.tipoiva)	
		
		conta.cuenta    = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
		conta.iva       = f_iva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)			
		conta.tipoapu   = libro_auto			
		
		IF Not f_insert_contaapun(conta) Then bien = false
		
		conta.apunte     = conta.apunte + 1
		// Hacenos el apunte por el iva tipo 6
		if dh = "H" then
			conta.haber = 0
			conta.debe  = 0
		else
			conta.debe  = 0
			conta.haber = 0
		end if
		
		
		//NO PARECE TENER SENTIDO EL APUNTE CON DEBE Y HABER CERO PARA IVA REPERCUTIDO 7 - Se comenta
		/*
		conta.tipoiva = "6"

		libro_auto		 = f_libro_contaiva(conta.ejercicio,codigo_empresa,conta.tipoiva)	
		
		conta.cuenta    = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
		conta.iva       = f_iva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)			
		conta.tipoapu   = libro_auto			
		
		IF Not f_insert_contaapun(conta) Then bien = false		
		*/
		
	end if
	//Fin de Nuevo.
next

/// Apuntes a las cuentas de gastos

sel = "select letras cuenta,numerico divisas,numerico importe from comodin"
//dw_cuentas_gastos = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw_cuentas_gastos)

if dw_cuentas_gastos.rowcount() = 1 then
	dw_cuentas_gastos.deleterow(1)
end if

total = dw_detalle.RowCount()

For indice = 1 To total
	IF dw_detalle.GetItemString(indice,"cmarca") = "S" Then
		
		var_anyo    = dec(dw_detalle.object.comlinalb_anyo[indice])
		var_albaran = dec(dw_detalle.object.comlinalb_albaran[indice])
		var_linea   = dec(dw_detalle.object.comlinalb_linea[indice])		
		
//		var_divisas_linea = dw_detalle.object.comcabalb_importe_moneda_proveedor[indice]
		var_divisas_linea = dw_detalle.object.comlinalb_importe[indice]
			var_importe_linea = dec(string(var_divisas_linea / cambio,mascara_moneda_empresa))		
		
		filtro = "anyo = "+string(var_anyo,"####")+" and albaran = "+string(var_albaran,"######")+" and linea = "+string(var_linea,"###")+" and orden > 0"
		dw_detalle_cuentas.setfilter(filtro)
		dw_detalle_cuentas.filter()		
		
		total2 = dw_detalle_cuentas.rowcount()
		porcentaje_total          = 0
		var_importe_total_cuentas = 0
		if total2 > 0 then
			for indice2 = 1 to total2
				cuenta     = dw_detalle_cuentas.object.cuenta[indice2]
				porcentaje = dw_detalle_cuentas.object.porcentaje[indice2]
				
				if isnull(cuenta) then cuenta = ""
				if trim(cuenta) = "" then
					bien = false
					messagebox("Error","Linea de albaran con cuenta de gastos en blanco.~n"+string(var_albaran,"######")+"/"+string(var_anyo,"####"))
				end if
				
				if indice2 = total2 then				
					var_importe_cuenta = var_importe_linea - var_importe_total_cuentas
					var_divisas_cuenta = dec(string(var_importe_cuenta * cambio,mascara_moneda))				
					
					porcentaje_total          = porcentaje_total + porcentaje
					var_importe_total_cuentas = var_importe_total_cuentas + var_importe_cuenta
				else
					var_importe_cuenta = dec(string((var_importe_linea / 100) * porcentaje,mascara_moneda_empresa))
					var_divisas_cuenta = dec(string(var_importe_cuenta * cambio,mascara_moneda))
					
					porcentaje_total          = porcentaje_total + porcentaje
					var_importe_total_cuentas = var_importe_total_cuentas + var_importe_cuenta				
				end if
							
				donde  = dw_cuentas_gastos.Find("cuenta = '"+cuenta+"'",1,dw_cuentas_gastos.RowCount()) 
				
				IF donde <= 0 Then
					donde = dw_cuentas_gastos.InsertRow(0)
					dw_cuentas_gastos.object.cuenta[donde]  = cuenta
					dw_cuentas_gastos.object.importe[donde] = 0
					dw_cuentas_gastos.object.divisas[donde] = 0				
				END IF					
				
				if donde > 0 then
					importe = dw_cuentas_gastos.object.importe[donde]
					divisas = dw_cuentas_gastos.object.divisas[donde]
					
					dw_cuentas_gastos.object.importe[donde] = importe + var_importe_cuenta
					dw_cuentas_gastos.object.divisas[donde] = divisas + var_divisas_cuenta
				else
					bien = false	
					messagebox("Error","Al agrupar las cuentas de gastos.~n"+string(donde))
				end if
			next
		else
			bien = false
			messagebox("Error","Linea de albaran sin cuenta de gastos.~n"+string(var_albaran,"######")+"/"+string(var_anyo,"####"))
		end if
		
		if porcentaje_total > 100 then
			bien = false
		end if
		
	END IF
Next

conta.concepto   = f_concepto_contagene(codigo_empresa,"3")
conta.ampliacion = "FRA. "+Trim(em_numfac.text)+' '+uo_proveedor.em_campo.text
							
dh = f_dh_contagene(codigo_empresa,"3")
conta.imponible = 0
SetNull(conta.tipoiva)
SetNull(conta.iva)
SetNull(conta.tipoapu)
SetNull(conta.clipro)
SetNull(conta.registro)
		
total = dw_cuentas_gastos.RowCount()
For indice = 1 To total
	conta.divisas = dw_cuentas_gastos.object.divisas[indice]
	
	IF conta.divisas <> 0 THEN
		conta.apunte     = conta.apunte + 1
		conta.cuenta     = dw_cuentas_gastos.object.cuenta[indice]

		if dh = "H" then
			conta.debe  = 0
			conta.haber = dw_cuentas_gastos.object.importe[indice]
		else
			conta.haber = 0
			conta.debe  = dw_cuentas_gastos.object.importe[indice]
		end if
		IF Not f_insert_contaapun(conta) Then bien = false
	END IF
Next

destroy dw_cuentas_gastos
//Fin apuntes de gastos

//-----------------------------------------
// APUNTE DE DESCUADRES
//-----------------------------------------
SELECT sum(debe), sum(haber) into :debe_total, :haber_total FROM contaapun
WHERE empresa 		= :conta.empresa 		AND
		ejercicio 	= :conta.ejercicio 	AND
		origen     	= :conta.origen		AND
		mes 			= :conta.mes 			AND
		asiento		= :conta.asiento;

diferencia = debe_total - haber_total

IF diferencia <> 0 THEN
	IF moneda = f_moneda_empresa(codigo_empresa) THEN
		f_mensaje("Error","Asiento descuadrado ~n~nDebe: "+string(debe_total,mascara_moneda_empresa)+"     Haber: "+string(haber_total,mascara_moneda_empresa))
	ELSE
		conta.concepto   = "4"
		conta.ampliacion = "Redondeo Euro"
		if diferencia > 0 then
			conta.debe  	= 0
			conta.haber 	= abs(diferencia)
			conta.cuenta	= "769000000"	
		else
			conta.haber 	= 0
			conta.debe  	= abs(diferencia)
			conta.cuenta	= 	"669000000"	
		end if
		conta.documento   = em_numfac.text
		conta.factura     = em_numfac.text
		conta.ffactura    = DateTime(date(em_fechafac.text))
	
		conta.apunte   = conta.apunte + 1
		IF Not f_insert_contaapun(conta) Then bien = false
	END IF
END IF

if bien Then
	//Actualizamos los libros de iva
	total = dw_detalle_bases_imponibles.rowcount()
	
	for indice = 1 to total
		tipo_iva = dw_detalle_bases_imponibles.object.tipo_iva[indice]
		libro		= dw_detalle_bases_imponibles.object.libro[indice]
		registro = dw_detalle_bases_imponibles.object.registro[indice]	
		
		if Not f_actualizar_contalibros(conta.ejercicio,codigo_empresa,libro,registro) Then 
			bien = false
			messagebox("Atención!","Error al actualizar el libro de I.V.A.")
		end if
		
		if tipo_iva = "13" or tipo_iva = "25" then

			tipo_iva = "14"

			libro = f_libro_contaiva(conta.ejercicio,codigo_empresa,tipo_iva)		
			
			if Not f_actualizar_contalibros(conta.ejercicio,codigo_empresa,libro,registro) Then 
				bien = false
				messagebox("Atención!","Error al actualizar el libro de I.V.A.")
			end if
			
			tipo_iva = "6"

			libro = f_libro_contaiva(conta.ejercicio,codigo_empresa,tipo_iva)		
			
			if Not f_actualizar_contalibros(conta.ejercicio,codigo_empresa,libro,registro) Then 
				bien = false
				messagebox("Atención!","Error al actualizar el libro de I.V.A.")
			end if
			
		end if
	next
End If

return bien



end function

public function boolean f_grabar_pagos ();Integer r
Int     bien
DEc{2}  importe
bien = 0
str_vencimientos   vto
str_carpagos       car


importe = Dec(em_totfactura.text)
vto = f_vencimientos_pagos(codigo_empresa,importe,em_codpago.text,DateTime(Date(em_fechafac.text)),uo_proveedor.em_codigo.text,em_moneda.text)
//vto = f_vencimientos_pagos(codigo_empresa,importe,em_codpago.text,DateTime(Date(em_fechafac.text)),uo_proveedor.em_codigo.text)
car.moneda    = em_moneda.text
car.cambio    = cambio
car.proveedor = uo_proveedor.em_codigo.text
car.codpago   = em_codpago.text
car.tipodoc   = f_tipodoc_carforpag(codigo_empresa,car.codpago)
car.empresa   = codigo_empresa
car.banco     = f_banco_comproveedor(codigo_empresa,uo_proveedor.em_codigo.text)
// David 30-08-02
//car.cuenta    = f_cuenta_genter_2(car.empresa,"P",car.proveedor)  
car.cuenta = f_cta_comproveedor(codigo_empresa, Trim(uo_proveedor.em_codigo.text), "G")
if car.cuenta = "" then
	car.cuenta = f_cta_comproveedor(codigo_empresa, Trim(uo_proveedor.em_codigo.text), "A")
end if
if car.cuenta = "" then
	messagebox("Revisar las cuentas del proveedor", "No existe cuenta de Proveedor ni acreedor")
	return false
end if

car.anyo      = Year(Today())
car.ffra      = DateTime(Date(em_fechafac.text))
car.fra       = em_numfac.text
car.anyofra   = Year(Date(car.ffra))


//Select  Max(carpagos.orden) 
//Into    :car.orden 
//From    carpagos
//Where   carpagos.empresa = :codigo_empresa
//And     carpagos.anyo    = :car.anyo ;
//IF IsNull(car.orden) Then car.orden = 0

car.orden   = f_ultimo_orden_carpagos(codigo_empresa,car.anyo)

if vto.efectos > 1 then
	texto_vencimientos = "VTOS.:"
else
	texto_vencimientos = "VTO.:"
end if

For r = 1  To vto.efectos
	car.orden = car.orden + 1
	car.recibo = r
	car.fvto    = DateTime(vto.vencimiento[r])
	car.divisas = vto.importe[r]
	car.importe = Dec(String(car.divisas / cambio))
	car.situacion = "0"
	IF Not f_insert_carpagos(car) Then bien  = 1
	//if not f_insertar_carpagos_cuentas(car.anyo, car.orden, car.cuenta, car.importe, car.divisas, car.cambio, "G") Then bien = 1
	
	texto_vencimientos = texto_vencimientos +" "+string(car.fvto,"dd/mm/yy")
Next
IF bien = 1 Then Return False
Return TRue
end function

public function boolean f_grabar_facturas ();Boolean  bien = true
Dec 		var_descuento_comercial,var_descuento_pp
long     indice,total,numero
String 	linealbaran,linea_nueva

str_comcabfac cab
str_comlinfac comlinfac


total = dw_detalle.RowCount()

// Asignamos los valores para la cabecera de factura pero no
// insertamos hasta que se graben las lineas, pues si no han
// marcado lineas insertariamos la cabecera sin lineas
			
IF total = 0 THEN
	RETURN FALSE
END IF

var_descuento_comercial = Dec(Trim(em_dto1.text))
var_descuento_pp        = Dec(Trim(em_dtopp.text))

cab.empresa			= codigo_empresa
cab.anyo      		= Dec(em_anyofac.text)
cab.proveedor 		= uo_proveedor.em_codigo.text
cab.factura   		= em_numfac.text
cab.fecha_fac 		= DateTime(Date(em_fechafac.text))
cab.fecha_entrega = DateTime(Date(em_fechafac.text))

SELECT comproveedores.forma_envio 
INTO   :cab.forma_envio 
FROM   comproveedores
WHERE  comproveedores.empresa	= :codigo_empresa
AND    comproveedores.codigo	= :cab.proveedor;

cab.forma_pago  	    = em_codpago.text
cab.incidencias 	    = ""
cab.libre			    = ""
cab.pedidopor		    = ""
cab.tipoiva  		    = Trim(em_tipoiva.text)
cab.iva 				    = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cab.tipoiva)
cab.moneda			    = Trim(em_moneda.text)
cab.dtopp			    = var_descuento_pp
cab.dto1 			    = var_descuento_comercial
cab.cambio            = dec(st_cambio.text) 
cab.decimales_precios = dec(em_decimales_precios.text)
cab.facturado_por     = nombre_usuario
// Insertamos las lineas de factura

comlinfac.empresa             = codigo_empresa 
comlinfac.anyo                = cab.anyo
comlinfac.proveedor           = cab.proveedor
comlinfac.factura             = cab.factura
comlinfac.linea               = 0
For indice = 1 To total
	IF dw_detalle.GetItemString(indice,"cmarca") = "S" Then
		comlinfac.linea ++		
		linea_nueva = dw_detalle.GetItemSTring(indice,"comcabalb_linea_nueva")
		
		if linea_nueva = "S" then			
			comlinfac.mprima              = ""
			comlinfac.cantidad            = dw_detalle.object.comlinalb_cantidad[indice]
//			comlinfac.precio              = dw_detalle.object.comcabalb_precio_moneda_proveedor[indice]
			comlinfac.precio              = dw_detalle.object.comlinalb_precio[indice]
			setnull(comlinfac.fecha_entrega)
			comlinfac.unidad_medida       = "1"
			comlinfac.pedido              = ""
			comlinfac.linea_pedido        = ""
			comlinfac.situacion           = "C"
			comlinfac.observaciones       = ""
			comlinfac.libre               = ""
			comlinfac.anyo_pedido         = ""
			setnull(comlinfac.fecha_control)
			comlinfac.seccion             = dw_detalle.object.comlinalb_seccion[indice]
			comlinfac.subseccion          = ""
			comlinfac.descripcion         = dw_detalle.object.comlinalb_descripcion[indice]
			comlinfac.envase              = ""
			comlinfac.cuenta              = ""
//			comlinfac.importe             = dw_detalle.object.comcabalb_importe_moneda_proveedor[indice]
			comlinfac.importe             = dw_detalle.object.comlinalb_importe[indice]
			comlinfac.albaran             = ""
			comlinfac.anyo_albaran        = ""
			comlinfac.lote                = ""
			comlinfac.albaran_proveedor   = ""
			setnull(comlinfac.fecha_albaran)
			setnull(comlinfac.fecha_pedido)
			comlinfac.descuento           = dw_detalle.object.comlinalb_descuento[indice]
			
			if dw_detalle.object.aplicar_dto[indice] = "S" then
				comlinfac.descuento_comercial = var_descuento_comercial
			else
				comlinfac.descuento_comercial = 0
			end if
			
			if dw_detalle.object.aplicar_dto_pp[indice] = "S" then
				comlinfac.descuento_pp        = var_descuento_pp
			else
				comlinfac.descuento_pp        = 0
			end if
						
			comlinfac.tipo_iva            = dw_detalle.object.tipo_iva[indice]
			comlinfac.iva                 = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,comlinfac.tipo_iva)
			comlinfac.pedido_por          = ""
			comlinfac.recibido_por        = ""
			comlinfac.usuario_control     = ""

		else		
			comlinfac.mprima              = ""
			comlinfac.cantidad            = dw_detalle.object.comlinalb_cantidad[indice]
//			comlinfac.precio              = dw_detalle.object.comcabalb_precio_moneda_proveedor[indice]
			comlinfac.precio              = dw_detalle.object.comlinalb_precio[indice]
			setnull(comlinfac.fecha_entrega)
			comlinfac.unidad_medida       = ""
			comlinfac.pedido              = ""
			comlinfac.linea_pedido        = ""
			comlinfac.situacion           = "C"
			comlinfac.observaciones       = ""
			comlinfac.libre               = ""
			comlinfac.anyo_pedido         = ""
			setnull(comlinfac.fecha_control)
			comlinfac.seccion             = dw_detalle.object.comlinalb_seccion[indice]
			comlinfac.subseccion          = ""
			comlinfac.descripcion         = dw_detalle.object.comlinalb_descripcion[indice]
			comlinfac.envase              = ""
			comlinfac.cuenta              = ""
//			comlinfac.importe             = dw_detalle.object.comcabalb_importe_moneda_proveedor[indice]
			comlinfac.importe             = dw_detalle.object.comlinalb_importe[indice]

			comlinfac.albaran             = dw_detalle.object.comlinalb_albaran[indice]
			comlinfac.anyo_albaran        = dw_detalle.object.comlinalb_anyo[indice]
			comlinfac.lote                = ""
			comlinfac.albaran_proveedor   = dw_detalle.object.comcabalb_albaran_proveedor[indice]
			comlinfac.fecha_albaran       = dw_detalle.object.comcabalb_fecha_alb[indice]
			setnull(comlinfac.fecha_pedido)
			comlinfac.descuento           = dw_detalle.object.comlinalb_descuento[indice]
			
			if dw_detalle.object.aplicar_dto_pp[indice] = "S" then
				comlinfac.descuento_comercial = var_descuento_comercial
			else
				comlinfac.descuento_comercial = 0
			end if
			
			if dw_detalle.object.aplicar_dto[indice] = "S" then
				comlinfac.descuento_pp        = var_descuento_pp
			else
				comlinfac.descuento_pp        = 0
			end if
						
			comlinfac.tipo_iva            = dw_detalle.object.tipo_iva[indice]
			comlinfac.iva                 = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,comlinfac.tipo_iva)
			comlinfac.pedido_por          = ""
			comlinfac.recibido_por        = dw_detalle.object.comcabalb_recibido_por[indice]
			comlinfac.usuario_control     = ""
																
			linealbaran           = dw_detalle.GetItemString(indice,"comlinalb_linea")
																		
			SELECT 
				comlinalb.mprima,
				comlinalb.fecha_entrega,
				comlinalb.unidad_medida,
				comlinalb.pedido,
				comlinalb.linea_pedido,
				comlinalb.observaciones,
				comlinalb.anyo_pedido,
				comlinalb.fecha_control,
				comlinalb.envase,
				comlinalb.lote,
				comlinalb.fecha_pedido,
				comlinalb.pedido_por,			
				comlinalb.usuario_control
			INTO
				:comlinfac.mprima,
				:comlinfac.fecha_entrega,
				:comlinfac.unidad_medida,
				:comlinfac.pedido,
				:comlinfac.linea_pedido,
				:comlinfac.observaciones,
				:comlinfac.anyo_pedido,
				:comlinfac.fecha_control,
				:comlinfac.envase,
				:comlinfac.lote,
				:comlinfac.fecha_pedido,
				:comlinfac.pedido_por,			
				:comlinfac.usuario_control
			FROM    comlinalb  
			Where   comlinalb.empresa = :codigo_empresa
			And     comlinalb.anyo    = :comlinfac.anyo_albaran
			And     comlinalb.albaran = :comlinfac.albaran
			And     comlinalb.linea   = :linealbaran;
			
			IF SQLCA.SQLCODE <> 0 Then 
				bien = false
				MessageBox("Error al leer Linea de albaran",String(comlinfac.albaran)+" "+String(linealbaran))
			END IF
						// borramos la linea del albaran
			Delete FROM comlinalb  
			Where   comlinalb.empresa = :codigo_empresa
			And     comlinalb.anyo    = :comlinfac.anyo_albaran
			And     comlinalb.albaran = :comlinfac.albaran
			And     comlinalb.linea   = :linealbaran;
			
			IF SQLCA.SQLCODE <> 0 Then 
				bien = false
				MessageBox("Error al borrar Linea de albaran",String(comlinfac.albaran)+" "+String(linealbaran))
			END IF
			
		end if		
		// Insertamos la linea en facturas

 		IF Not f_insert_comlinfac(comlinfac) THEN
			bien = false
		END IF
		
		numero = 0
		
		SELECT Count(*)
		INTO   :numero
		FROM   comlinalb  
		WHERE  comlinalb.empresa = :codigo_empresa
		AND    comlinalb.anyo    = :comlinfac.anyo_albaran
		AND    comlinalb.albaran = :comlinfac.albaran;
		
		IF IsNull(numero) THEN numero = 0
		IF numero = 0 THEN
			// borramos la cabecera del albaran si no tiene lineas
			DELETE FROM comcabalb
			WHERE  comcabalb.empresa  = :codigo_empresa
			AND    comcabalb.anyo     = :comlinfac.anyo_albaran
			AND    comcabalb.albaran  = :comlinfac.albaran;
			IF SQLCA.SQLCODE <> 0 THEN 
				bien = false
				MessageBox("Error al borrar Cabecera de albaran",String(comlinfac.albaran))
			END IF
		END IF		
	END IF
NEXT

numero = 0

SELECT Count(*)
INTO   :numero
FROM   comlinfac
WHERE  comlinfac.empresa 	= :codigo_empresa
AND	 comlinfac.anyo		= :cab.anyo
AND	 comlinfac.proveedor	= :cab.proveedor
AND	 comlinfac.factura	= :cab.factura;

IF IsNull(numero) THEN numero = 0

IF numero > 0 AND bien THEN
	IF Not f_insert_comcabfac(cab) THEN
		bien = false	
	END IF
END IF

return bien
	
	
end function

public subroutine f_datos_albaran (string empresa, string anyo, string albaran);Dec	dtopp,dto1

SELECT comcabalb.forma_pago,comcabalb.moneda, comcabalb.dtopp,
		 comcabalb.dto1
		INTO :em_codpago.text,:em_moneda.text,:dtopp,:dto1 FROM comcabalb
	WHERE comcabalb.empresa = :codigo_empresa
	AND   comcabalb.anyo    = :anyo
	AND   comcabalb.albaran = :albaran;
	em_dtopp.text = String(dtopp)
	em_dto1.text = String(dto1)
	st_nombre_codpago.text = f_nombre_carforpag(codigo_empresa,Trim(em_codpago.text))
	st_nombre_moneda.text = f_nombre_moneda(Trim(em_moneda.text))
end subroutine

public subroutine f_comprueba_si_existe_factura ();//Control de factura repetida
string   ls_factura,ls_tipoter,ls_clipro
long     ll_ejercicio,ll_existe_factura_en_otro_asiento
datetime ldt_ffactura

ls_factura   = em_numfac.text
ll_ejercicio = long(em_anyofac.text)
ls_tipoter   = 'P'
ls_clipro    = uo_proveedor.em_codigo.text

cb_continuar.enabled = true

if ll_ejercicio > 0 and trim(ls_clipro) <> "" and trim(ls_factura) <> "" then
	
	select isnull(count(*),0)
	into   :ll_existe_factura_en_otro_asiento
	from   contaapun
	where  contaapun.empresa   = :codigo_empresa
	and    contaapun.factura               = :ls_factura
	and    datepart(yy,contaapun.ffactura) = :ll_ejercicio
	and    contaapun.tipoter               = :ls_tipoter
	and    contaapun.clipro                = :ls_clipro
	;
	
	if ll_existe_factura_en_otro_asiento > 0 then
		messagebox("¡Error!","Se está introduciendo una factura duplicada.~nRevise los datos.")
		cb_continuar.enabled = false
		return
	end if
end if

long     existe,anyo
int      decimales_precios,decimales_moneda
dec      dtopp,dto1
string   proveedor,factura,forma_pago,tipoiva,mascara_moneda
datetime fecha_fac

anyo      = dec(em_anyofac.text)
proveedor = uo_proveedor.em_codigo.text
factura   = em_numfac.text

if anyo > 0 and trim(proveedor) <> "" and trim(factura) <> "" then
	select count(*)
	into   :existe
	from   comcabfac
	where  empresa   = :codigo_empresa
	and    anyo      = :anyo
	and    proveedor = :proveedor
	and    factura   = :factura;
	
	if isnull(existe) then existe = 0
	
	if existe = 1 then
	
		select fecha_fac,				forma_pago,			tipoiva,
				 moneda,					dtopp,				dto1,
				 cambio,					decimales_precios
		into   :fecha_fac,			:forma_pago,		:tipoiva,
				 :moneda,				:dtopp,				:dto1,
				 :cambio,				:decimales_precios
		from   comcabfac
		where  empresa   = :codigo_empresa
		and    anyo      = :anyo
		and    proveedor = :proveedor
		and    factura   = :factura;
	
		if isnull(cambio) then cambio = 0
		if isnull(decimales_precios) then decimales_precios = 0
		//Comprobamos el cambio
		if cambio = 0 then
			cambio = f_cambio_moneda(moneda)
		end if		
		//
		//Comprobamos los decimales del precio
		decimales_moneda = f_decimales_moneda(moneda)
		
		if decimales_moneda > decimales_precios then
			decimales_precios = decimales_moneda
		end if
		//
		em_tipoiva.text           = tipoiva
		st_tipoiva.text           = f_nombre_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,em_tipoiva.text)
		em_codpago.text           = forma_pago
		st_nombre_codpago.text    = f_nombre_carforpag(codigo_empresa,Trim(em_codpago.text))
		em_moneda.text            = moneda
		st_nombre_moneda.text     = f_nombre_moneda(moneda)
		st_nombre_moneda2.text    = f_nombre_moneda(moneda)
		st_cambio.text            = String(cambio,"#####0.00####")	
		em_dtopp.text             = String(dtopp)
		em_dto1.text              = String(dto1)
		em_decimales_precios.text = string(decimales_precios)	
		em_fechafac.text          = string(date(fecha_fac))
		
		mascara_moneda = f_mascara_moneda(moneda)
		
		em_baseimpon.setmask(decimalmask!,mascara_moneda)
		em_impfac.setmask(decimalmask!,mascara_moneda)
		em_totbruto.setmask(decimalmask!,mascara_moneda)
		em_totdto1.setmask(decimalmask!,mascara_moneda)
		em_totdtopp.setmask(decimalmask!,mascara_moneda)
		em_totfactura.setmask(decimalmask!,mascara_moneda)
		em_totiva.setmask(decimalmask!,mascara_moneda)	
		
		em_moneda.enabled            = false
		em_decimales_precios.enabled = false
		em_fechafac.enabled          = false	
		
		messagebox("Atención","La factura ya habia sido contabilizada.~nSe añadiran nuevas lineas")
		
		dw_factura_proveedor.retrieve(codigo_empresa,anyo,proveedor,factura)
		dw_factura_proveedor.visible = true
	else
		em_moneda.enabled            = true
		em_decimales_precios.enabled = true
		em_fechafac.enabled          = true
	end if
end if
end subroutine

public subroutine f_calculo_totales_fra ();dec    total_bruto,total_dto_pronto_pago,total_dto_comercial,total_base_imponible,total_importe_iva 
long   indice,total
string mascara_moneda,tipo_iva

mascara_moneda        = f_mascara_moneda(moneda) 
total_bruto           = 0
total_dto_pronto_pago = 0
total_dto_comercial   = 0
total_base_imponible  = 0
total_importe_iva     = 0

total = dw_detalle_bases_imponibles.rowcount()

for indice = 1 to total
	total_bruto           = total_bruto           + dw_detalle_bases_imponibles.object.bruto[indice]
	total_dto_pronto_pago = total_dto_pronto_pago + dw_detalle_bases_imponibles.object.dto_pronto_pago[indice]
	total_dto_comercial   = total_dto_comercial   + dw_detalle_bases_imponibles.object.dto_comercial[indice]
	total_base_imponible  = total_base_imponible  + dw_detalle_bases_imponibles.object.base_imponible[indice]
	//Controlamos ivas autorepercutidos, que no deben sumarse al total de la fra
	tipo_iva              = dw_detalle_bases_imponibles.object.tipo_iva[indice]
	if tipo_iva <> "13" and tipo_iva <> "25" then
		total_importe_iva     = total_importe_iva     + dw_detalle_bases_imponibles.object.importe_iva[indice]
	end if
next

em_totbruto.text   = String(total_bruto,mascara_moneda)
em_totdtopp.text   = String(total_dto_pronto_pago,mascara_moneda)
em_totdto1.text    = String(total_dto_comercial,mascara_moneda)
em_baseimpon.text  = String(total_base_imponible,mascara_moneda)
em_totiva.text 	 = String(total_importe_iva,mascara_moneda)
em_totfactura.text = String(total_base_imponible + total_importe_iva,mascara_moneda)
end subroutine

public function boolean f_procesar ();boolean bien
bien = true

IF bien Then 
	IF Not f_grabar_facturas() Then
		bien = false
		f_mensaje("Error Grabando Factura","La operacion no se actualiza")
	end if
END IF

IF bien Then 
	IF Not f_grabar_pagos()   Then
		bien = false
		f_mensaje("Error Grabando Cartera de Pagos","La operacion no se actualiza")
	end if
END IF

IF bien Then 
	IF Not f_grabar_apuntes() Then
		bien = false
		f_mensaje("Error Grabando Apuntes","La operacion no se actualiza")
	end if
END IF

IF bien Then
	COMMIT;
	str_parametros lstr_param
	
	lstr_param.i_nargumentos   = 4
	lstr_param.s_argumentos[1] = "w_int_facturas_compras"
	lstr_param.s_argumentos[2] = Trim(uo_proveedor.em_codigo.text)
	lstr_param.s_argumentos[3] = Trim(em_numfac.text)
	lstr_param.s_argumentos[4] = string(year(date(em_fechafac.text)))
	OpenWithParm(w_con_pagos_proveedor_fra,lstr_param) 	
	
	if dec(em_asiento.text) > 0 then
		lstr_param.i_nargumentos   = 5
		lstr_param.s_argumentos[2] = uo_ejercicio.em_ejercicio.text
		lstr_param.s_argumentos[3] = "3"
		lstr_param.s_argumentos[4] = em_fapunte.text
		lstr_param.s_argumentos[5] = em_asiento.text
		
		OpenWithParm(w_int_contaapun,lstr_param) 	
	end if	
	dw_detalle_bases_imponibles.visible = true
ELSE
	ROLLBACK;
	f_mensaje("Error EN proceso de datos","La operacion no se actualiza")
END IF

return bien
end function

public function boolean f_insertar_carpagos_cuentas (long anyo, long orden, string cuenta, decimal importe, decimal divisas, decimal camb, string tipo);INSERT INTO carpagos_cuentas
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
         :camb,   
         :tipo)
USING SQLCA ;
IF SQLCA.SQLCODE <> 0 Then
	f_mensaje("Error en f_insert_carpagos_cuentas",SQLCA.SQLERRTEXT)
	Return FALSE
END IF
Return TRUE
end function

event open;call super::open;This.title = "Introducción Facturas de Compras"


dw_detalle.SetTransObject(SQLCA)
dw_detalle.Visible = FALSE

dw_factura_proveedor.SetTransObject(SQLCA)
dw_agrupa_articulos.SetTransObject(SQLCA)

em_anyofac.text = String(Year(Today()))
em_fechafac.text = String(Today())
em_fapunte.text = String(Today())

//em_desde.text = "01-01-2001"
//em_hasta.text = String(Today())

em_desde.text = "01-01-2001"
em_hasta.text = String(Today())  



f_activar()

uo_proveedor.em_campo.text= f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)

f_activar_campo(uo_proveedor.em_campo)

  

end event

on w_int_facturas_compras.create
int iCurrent
call super::create
this.pb_salir=create pb_salir
this.em_fechafac=create em_fechafac
this.st_1=create st_1
this.uo_proveedor=create uo_proveedor
this.st_5=create st_5
this.st_2=create st_2
this.em_anyofac=create em_anyofac
this.em_codpago=create em_codpago
this.cb_salir=create cb_salir
this.st_3=create st_3
this.em_tipoiva=create em_tipoiva
this.em_numfac=create em_numfac
this.cb_continuar=create cb_continuar
this.cb_procesar=create cb_procesar
this.st_323=create st_323
this.em_fapunte=create em_fapunte
this.st_223=create st_223
this.em_asiento=create em_asiento
this.st_8888=create st_8888
this.em_impfac=create em_impfac
this.st_33=create st_33
this.em_moneda=create em_moneda
this.st_nombre_codpago=create st_nombre_codpago
this.st_nombre_moneda=create st_nombre_moneda
this.st_34=create st_34
this.em_dtopp=create em_dtopp
this.em_dto1=create em_dto1
this.st_35=create st_35
this.st_tipoiva=create st_tipoiva
this.em_totbruto=create em_totbruto
this.em_totdtopp=create em_totdtopp
this.em_totdto1=create em_totdto1
this.em_baseimpon=create em_baseimpon
this.em_totiva=create em_totiva
this.em_totfactura=create em_totfactura
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.r_2=create r_2
this.st_55=create st_55
this.st_4444443=create st_4444443
this.st_cambio=create st_cambio
this.st_nombre_moneda2=create st_nombre_moneda2
this.st_36=create st_36
this.em_decimales_precios=create em_decimales_precios
this.gb_1=create gb_1
this.uo_ejercicio=create uo_ejercicio
this.dw_cta=create dw_cta
this.cb_1=create cb_1
this.pb_1=create pb_1
this.dw_detalle_cuentas=create dw_detalle_cuentas
this.dw_detalle=create dw_detalle
this.dw_factura_proveedor=create dw_factura_proveedor
this.dw_detalle_bases_imponibles=create dw_detalle_bases_imponibles
this.cb_grabar=create cb_grabar
this.dw_agrupa_articulos=create dw_agrupa_articulos
this.st_4=create st_4
this.st_6=create st_6
this.em_desde=create em_desde
this.em_hasta=create em_hasta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_salir
this.Control[iCurrent+2]=this.em_fechafac
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.uo_proveedor
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_anyofac
this.Control[iCurrent+8]=this.em_codpago
this.Control[iCurrent+9]=this.cb_salir
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.em_tipoiva
this.Control[iCurrent+12]=this.em_numfac
this.Control[iCurrent+13]=this.cb_continuar
this.Control[iCurrent+14]=this.cb_procesar
this.Control[iCurrent+15]=this.st_323
this.Control[iCurrent+16]=this.em_fapunte
this.Control[iCurrent+17]=this.st_223
this.Control[iCurrent+18]=this.em_asiento
this.Control[iCurrent+19]=this.st_8888
this.Control[iCurrent+20]=this.em_impfac
this.Control[iCurrent+21]=this.st_33
this.Control[iCurrent+22]=this.em_moneda
this.Control[iCurrent+23]=this.st_nombre_codpago
this.Control[iCurrent+24]=this.st_nombre_moneda
this.Control[iCurrent+25]=this.st_34
this.Control[iCurrent+26]=this.em_dtopp
this.Control[iCurrent+27]=this.em_dto1
this.Control[iCurrent+28]=this.st_35
this.Control[iCurrent+29]=this.st_tipoiva
this.Control[iCurrent+30]=this.em_totbruto
this.Control[iCurrent+31]=this.em_totdtopp
this.Control[iCurrent+32]=this.em_totdto1
this.Control[iCurrent+33]=this.em_baseimpon
this.Control[iCurrent+34]=this.em_totiva
this.Control[iCurrent+35]=this.em_totfactura
this.Control[iCurrent+36]=this.st_7
this.Control[iCurrent+37]=this.st_8
this.Control[iCurrent+38]=this.st_9
this.Control[iCurrent+39]=this.st_10
this.Control[iCurrent+40]=this.st_11
this.Control[iCurrent+41]=this.st_12
this.Control[iCurrent+42]=this.r_2
this.Control[iCurrent+43]=this.st_55
this.Control[iCurrent+44]=this.st_4444443
this.Control[iCurrent+45]=this.st_cambio
this.Control[iCurrent+46]=this.st_nombre_moneda2
this.Control[iCurrent+47]=this.st_36
this.Control[iCurrent+48]=this.em_decimales_precios
this.Control[iCurrent+49]=this.gb_1
this.Control[iCurrent+50]=this.uo_ejercicio
this.Control[iCurrent+51]=this.dw_cta
this.Control[iCurrent+52]=this.cb_1
this.Control[iCurrent+53]=this.pb_1
this.Control[iCurrent+54]=this.dw_detalle_cuentas
this.Control[iCurrent+55]=this.dw_detalle
this.Control[iCurrent+56]=this.dw_factura_proveedor
this.Control[iCurrent+57]=this.dw_detalle_bases_imponibles
this.Control[iCurrent+58]=this.cb_grabar
this.Control[iCurrent+59]=this.dw_agrupa_articulos
this.Control[iCurrent+60]=this.st_4
this.Control[iCurrent+61]=this.st_6
this.Control[iCurrent+62]=this.em_desde
this.Control[iCurrent+63]=this.em_hasta
end on

on w_int_facturas_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_salir)
destroy(this.em_fechafac)
destroy(this.st_1)
destroy(this.uo_proveedor)
destroy(this.st_5)
destroy(this.st_2)
destroy(this.em_anyofac)
destroy(this.em_codpago)
destroy(this.cb_salir)
destroy(this.st_3)
destroy(this.em_tipoiva)
destroy(this.em_numfac)
destroy(this.cb_continuar)
destroy(this.cb_procesar)
destroy(this.st_323)
destroy(this.em_fapunte)
destroy(this.st_223)
destroy(this.em_asiento)
destroy(this.st_8888)
destroy(this.em_impfac)
destroy(this.st_33)
destroy(this.em_moneda)
destroy(this.st_nombre_codpago)
destroy(this.st_nombre_moneda)
destroy(this.st_34)
destroy(this.em_dtopp)
destroy(this.em_dto1)
destroy(this.st_35)
destroy(this.st_tipoiva)
destroy(this.em_totbruto)
destroy(this.em_totdtopp)
destroy(this.em_totdto1)
destroy(this.em_baseimpon)
destroy(this.em_totiva)
destroy(this.em_totfactura)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.r_2)
destroy(this.st_55)
destroy(this.st_4444443)
destroy(this.st_cambio)
destroy(this.st_nombre_moneda2)
destroy(this.st_36)
destroy(this.em_decimales_precios)
destroy(this.gb_1)
destroy(this.uo_ejercicio)
destroy(this.dw_cta)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.dw_detalle_cuentas)
destroy(this.dw_detalle)
destroy(this.dw_factura_proveedor)
destroy(this.dw_detalle_bases_imponibles)
destroy(this.cb_grabar)
destroy(this.dw_agrupa_articulos)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.em_desde)
destroy(this.em_hasta)
end on

event ue_esc;call super::ue_esc;IF pb_salir.enabled = TRUE THEN
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

event ue_f5;call super::ue_f5;IF cb_continuar.Enabled = TRUE THEN
	cb_continuar.TriggerEvent(Clicked!)
END IF
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_facturas_compras
integer x = 745
integer y = 128
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_facturas_compras
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_facturas_compras
integer width = 8475
integer height = 84
integer textsize = -12
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19474154
end type

type pb_salir from upb_salir within w_int_facturas_compras
integer x = 8187
integer y = 208
integer width = 146
integer height = 128
integer taborder = 0
integer textsize = -8
fontcharset fontcharset = ansi!
boolean cancel = false
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Log Out_24x24.png"
end type

type em_fechafac from u_em_campo within w_int_facturas_compras
integer x = 4393
integer y = 196
integer width = 297
integer height = 80
integer taborder = 170
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 30593746
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

event modificado;call super::modificado;dw_detalle.reset()

em_fapunte.text = this.text

uo_ejercicio.em_ejercicio.text = string(year(date(this.text)))
end event

type st_1 from statictext within w_int_facturas_compras
integer x = 18
integer y = 136
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Proveedor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_proveedor from u_em_campo_2 within w_int_facturas_compras
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 329
integer y = 132
integer width = 2574
integer height = 80
integer taborder = 10
boolean border = true
long backcolor = 553648127
borderstyle borderstyle = stylelowered!
end type

event modificado;Dec	 dtopp,dto1
int    decimales_precios
STring tipo_iva,forma_pago,mascara_moneda

uo_proveedor.em_campo.text = f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)

dw_detalle_cuentas.reset()

IF Trim(uo_proveedor.em_campo.text) = "" THEN
 	IF Trim(uo_proveedor.em_codigo.text) <> "" THEN uo_proveedor.em_campo.SetFocus()
 	uo_proveedor.em_campo.text  = ""
 	uo_proveedor.em_codigo.text = ""
END IF

IF Trim(uo_proveedor.em_codigo.text) <> "" THEN
	SELECT tipo_iva,				forma_pago,
			 moneda,					dtopp,
			 dto1,					decimales_precios
	INTO   :tipo_iva,				:forma_pago,
			 :moneda,				:dtopp,
			 :dto1,					:decimales_precios
	FROM   comproveedores
	WHERE  empresa = :codigo_empresa
	AND    codigo  = :uo_proveedor.em_codigo.text;
		
		
	if isnull(tipo_iva) then tipo_iva = ""
	if isnull(forma_pago) then forma_pago = ""
	if isnull(moneda) then moneda = ""
	if isnull(dtopp) then dtopp = 0
	if isnull(dto1) then dto1 = 0
	if isnull(decimales_precios) then decimales_precios = 0		
		
	cambio = f_cambio_moneda(moneda)
	
	em_tipoiva.text           = tipo_iva
	st_tipoiva.text           = f_nombre_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,em_tipoiva.text)
	em_codpago.text           = forma_pago
	st_nombre_codpago.text    = f_nombre_carforpag(codigo_empresa,Trim(em_codpago.text))
	em_moneda.text            = moneda
	st_nombre_moneda.text     = f_nombre_moneda(moneda)
	st_nombre_moneda2.text    = f_nombre_moneda(moneda)
	st_cambio.text            = String(cambio,"#####0.00####")	
	em_dtopp.text             = String(dtopp)
	em_dto1.text              = String(dto1)
	em_decimales_precios.text = string(decimales_precios)	
	
	mascara_moneda = f_mascara_moneda(moneda)
	
	em_baseimpon.setmask(decimalmask!,mascara_moneda)
	em_impfac.setmask(decimalmask!,mascara_moneda)
	em_totbruto.setmask(decimalmask!,mascara_moneda)
	em_totdto1.setmask(decimalmask!,mascara_moneda)
	em_totdtopp.setmask(decimalmask!,mascara_moneda)
	em_totfactura.setmask(decimalmask!,mascara_moneda)
	em_totiva.setmask(decimalmask!,mascara_moneda)
	
	f_mascara_columna(dw_detalle_bases_imponibles,"bruto",mascara_moneda)
	f_mascara_columna(dw_detalle_bases_imponibles,"dto_pronto_pago",mascara_moneda)
	f_mascara_columna(dw_detalle_bases_imponibles,"dto_comercial",mascara_moneda)
	f_mascara_columna(dw_detalle_bases_imponibles,"base_imponible",mascara_moneda)
	f_mascara_columna(dw_detalle_bases_imponibles,"importe_iva",mascara_moneda)
	
	f_comprueba_si_existe_factura()
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = " AYUDA SELECCION DE PROVEEDORES"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE


end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type st_5 from statictext within w_int_facturas_compras
integer x = 4398
integer y = 124
integer width = 297
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24076881
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_facturas_compras
integer x = 73
integer y = 228
integer width = 242
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "F. Pago:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyofac from u_em_campo within w_int_facturas_compras
integer x = 3621
integer y = 196
integer width = 178
integer height = 80
integer taborder = 100
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 32238571
alignment alignment = right!
end type

event modified;f_comprueba_si_existe_factura()
end event

type em_codpago from u_em_campo within w_int_facturas_compras
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 329
integer y = 220
integer width = 160
integer height = 80
integer taborder = 30
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 553648127
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCIÓN DE FORMAS DE PAGO"
ue_datawindow = "dw_ayuda_carforpag"
ue_filtro     = ""
end event

event modificado;call super::modificado;
st_nombre_codpago.text = f_nombre_carforpag(codigo_empresa,em_codpago.text)

IF Len(st_nombre_codpago.text)=0 THEN 
   IF Len(em_codpago.text)<>0 THEN
		f_activar_campo(em_codpago)
	END IF
   em_codpago.text = "" 
   Return
END IF
f_activar_campo(em_numfac)






end event

event losefocus;call super::losefocus;st_nombre_codpago.text = f_nombre_carforpag(codigo_empresa,em_codpago.text)

IF Len(st_nombre_codpago.text)=0 THEN 
   IF Len(em_codpago.text)<>0 THEN
		f_activar_campo(em_codpago)
	END IF
   em_codpago.text = "" 
   Return
END IF
end event

type cb_salir from u_boton within w_int_facturas_compras
integer x = 6789
integer y = 216
integer width = 384
integer height = 116
integer taborder = 0
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Salir"
end type

event clicked;call super::clicked;f_activar()
f_activar_campo(uo_proveedor.em_campo)
end event

type st_3 from statictext within w_int_facturas_compras
integer x = 59
integer y = 320
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Tipo IVA :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_tipoiva from u_em_campo within w_int_facturas_compras
integer x = 329
integer y = 308
integer width = 160
integer height = 80
integer taborder = 70
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 553648127
end type

event modificado;call super::modificado;st_tipoiva.text = f_nombre_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,em_tipoiva.text)

IF Len(st_tipoiva.text)=0 THEN 
   IF Len(em_tipoiva.text)<>0 THEN
		f_activar_campo(em_tipoiva)
	END IF
   em_tipoiva.text = "" 
   Return
END IF

f_activar_campo(em_numfac)





end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCIÓN DE TIPOS DE IVA"
ue_datawindow = "dw_ayuda_contaiva"
ue_filtro     = ""
end event

type em_numfac from u_em_campo within w_int_facturas_compras
integer x = 3803
integer y = 196
integer width = 585
integer height = 80
integer taborder = 140
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 32238571
alignment alignment = right!
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

event modified;f_comprueba_si_existe_factura()
end event

type cb_continuar from u_boton within w_int_facturas_compras
event clicked pbm_bnclicked
integer x = 5362
integer y = 292
integer width = 375
integer height = 100
integer taborder = 0
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "F5 Ok"
end type

event clicked;string filtro

if uo_proveedor.em_codigo.text <> "" then
	update comlinalb
	set cmarca = 'N'
	using SQLCA;
	
	commit using SQLCA;
end if

if f_ejercicio_activo(codigo_empresa) <> Dec(uo_ejercicio.em_ejercicio.text) then
	messagebox("Información","Ejercicio no activo.")
	return
end if
IF Not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),DateTime(date(em_fapunte.text))) Then 
	Return 
END IF



// Control de proveedor
IF Trim(uo_proveedor.em_codigo.text) = "" THEN
	f_mensaje("Error en datos","Introduzca el Proveedor.")
	f_activar_campo(uo_proveedor.em_campo)
	Return
End IF

IF Trim(em_codpago.text) = "" THEN
	f_mensaje("Error en datos","Introduzca la Forma de Pago del Proveedor.")
	f_activar_campo(em_codpago)
	Return
End IF

IF Trim(em_tipoiva.text) = "" THEN
	f_mensaje("Error en datos","Introduzca el Tipo de IVA del Proveedor.")
	f_activar_campo(em_tipoiva)
	Return
End IF

// Control factura
IF em_numfac.text = "" THEN
	f_mensaje("Error en datos","Introduzca el Número de Factura.")
	f_activar_campo(em_numfac)
	Return
End IF

IF em_fechafac.text = "00-00-00" THEN
	f_mensaje("Error en datos","Introduzca la fecha de Factura.")
	f_activar_campo(em_fechafac)
	Return
End IF

IF Dec(em_impfac.text) = 0 THEN
	f_mensaje("Error en datos","Introduzca el total de Factura.")
	f_activar_campo(em_impfac)
	Return
End IF

//f_mascara_columna(dw_detalle,"comlinalb_importe",f_mascara_moneda(moneda))
//f_mascara_columna(dw_detalle,"comlinalb_precio",f_mascara_decimales(2))

// Recoger los albaranes
Integer cuantas,decimales_precios,ejercicio

ejercicio = Dec(uo_ejercicio.em_ejercicio.text)

decimales_precios = dec(em_decimales_precios.text)
f_mascara_columna(dw_detalle,"comcabalb_precio_moneda_proveedor",f_mascara_decimales(decimales_precios))
f_mascara_columna(dw_detalle,"comcabalb_importe_moneda_proveedor",f_mascara_moneda(em_moneda.text))

//dw_detalle.Retrieve(codigo_empresa,Trim(uo_proveedor.em_codigo.text),em_moneda.text,ejercicio)
dw_detalle.Retrieve(codigo_empresa,Trim(uo_proveedor.em_codigo.text), em_moneda.text, ejercicio, datetime(em_desde.text), datetime(em_hasta.text))
dw_detalle_bases_imponibles.reset()
dw_detalle_bases_imponibles.visible = false


//cuantas = dw_detalle.RowCount()
//dw_detalle.ScrollToRow(cuantas)

dw_agrupa_articulos.retrieve (codigo_empresa, uo_proveedor.em_codigo.text, datetime(em_desde.text), datetime(em_hasta.text))


//IF dw_detalle.RowCount()=0 THEN
//	f_mensaje("Aviso","¡No Existen Albaranes para el Proveedor!")
//	f_activar()
//	f_activar_campo(uo_proveedor.em_campo)
//	Return
//ELSE
//	f_desactivar()
//END IF
	f_desactivar()


end event

type cb_procesar from u_boton within w_int_facturas_compras
event clicked pbm_bnclicked
integer x = 6391
integer y = 216
integer width = 384
integer height = 116
integer taborder = 0
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;Dec{2} total_marcado

dw_detalle.Accepttext()
total_marcado = Dec(em_totfactura.text)
IF total_marcado = 0 THEN
	MessageBox("Error de marcado","No ha marcado ningun albarán")
	RETURN
END IF

IF round(total_marcado,2) <> round(Dec(em_impfac.text),2) THEN
	MessageBox("Error en Importes","El total marcado no coincide con el total factura introducido")
ELSE
	cambio = dec(st_cambio.text)
	if cambio = 0 then
		messagebox("Atención","Cambio 0")
	else
		em_impfac.enabled = false
		if f_procesar() then
			laprimeravez = 0
			em_impfac.enabled = true
			cb_salir.TriggerEvent(Clicked!)
		end if
	end if
END IF
end event

type st_323 from statictext within w_int_facturas_compras
integer x = 2985
integer y = 220
integer width = 210
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Fecha:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fapunte from u_em_campo within w_int_facturas_compras
event modificado pbm_custom02
integer x = 3214
integer y = 212
integer width = 274
integer taborder = 200
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 553648127
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

event modificado;call super::modificado;dw_detalle.reset()
end event

type st_223 from statictext within w_int_facturas_compras
integer x = 2976
integer y = 324
integer width = 210
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Asto:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_asiento from u_em_campo within w_int_facturas_compras
event modificado pbm_custom02
integer x = 3214
integer y = 304
integer width = 274
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = ""
end type

event modificado;call super::modificado;dw_detalle.reset()
end event

type st_8888 from statictext within w_int_facturas_compras
integer x = 4695
integer y = 124
integer width = 654
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24076881
boolean enabled = false
string text = "Importe"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_impfac from u_em_campo within w_int_facturas_compras
event modificado pbm_custom02
integer x = 4695
integer y = 196
integer width = 411
integer taborder = 190
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 30593746
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;dw_detalle.reset()
end event

type st_33 from statictext within w_int_facturas_compras
integer x = 1262
integer y = 228
integer width = 229
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Moneda:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_moneda from u_em_campo within w_int_facturas_compras
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 1504
integer y = 220
integer width = 174
integer height = 80
integer taborder = 40
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCIÓN DE MONEDA"
ue_datawindow = "dw_ayuda_divisas"
ue_filtro     = ""

valor_empresa = false
end event

event losefocus;call super::losefocus;st_nombre_moneda.text = f_nombre_moneda(em_moneda.text)

IF Len(st_nombre_moneda.text)=0 THEN 
   IF Len(em_moneda.text)<>0 THEN
		f_activar_campo(em_moneda)
	END IF
   em_moneda.text = "" 
   Return
END IF
end event

event modificado;int    decimales_precios
string mascara_moneda

moneda = em_moneda.text

if trim(moneda) <> "" then
	st_nombre_moneda.text  = f_nombre_moneda(em_moneda.text)
	st_nombre_moneda2.text = f_nombre_moneda(em_moneda.text)
	
	cambio            = f_cambio_moneda(em_moneda.text)
	decimales_precios = f_decimales_precios_moneda(em_moneda.text)
	
	st_cambio.text            = String(cambio,"#####0.00####")
	em_decimales_precios.text = string(decimales_precios)
	
	mascara_moneda = f_mascara_moneda(moneda)
	
	em_baseimpon.setmask(decimalmask!,mascara_moneda)
	em_impfac.setmask(decimalmask!,mascara_moneda)
	em_totbruto.setmask(decimalmask!,mascara_moneda)
	em_totdto1.setmask(decimalmask!,mascara_moneda)
	em_totdtopp.setmask(decimalmask!,mascara_moneda)
	em_totfactura.setmask(decimalmask!,mascara_moneda)
	em_totiva.setmask(decimalmask!,mascara_moneda)
		
	IF Len(st_nombre_moneda.text)=0 THEN 
		IF Len(em_moneda.text)<>0 THEN
			f_activar_campo(em_moneda)
		END IF
		em_moneda.text = "" 
		Return
	END IF

	f_activar_campo(em_numfac)
else
	st_nombre_moneda.text  = ""
	st_nombre_moneda2.text = ""
	st_cambio.text         = "0"
	em_decimales_precios.text = "0"
end if





end event

type st_nombre_codpago from statictext within w_int_facturas_compras
integer x = 494
integer y = 220
integer width = 754
integer height = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217731
boolean enabled = false
boolean focusrectangle = false
end type

type st_nombre_moneda from statictext within w_int_facturas_compras
integer x = 1682
integer y = 220
integer width = 425
integer height = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217731
boolean enabled = false
boolean focusrectangle = false
end type

type st_34 from statictext within w_int_facturas_compras
integer x = 1275
integer y = 320
integer width = 215
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Dto.P.P.:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_dtopp from u_em_campo within w_int_facturas_compras
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 1504
integer y = 308
integer width = 174
integer height = 80
integer taborder = 80
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 553648127
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##.00"
string displaydata = ""
end type

event modified;call super::modified;f_activar_campo(em_numfac)
end event

type em_dto1 from u_em_campo within w_int_facturas_compras
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 1943
integer y = 308
integer width = 174
integer taborder = 90
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 553648127
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##.00"
string displaydata = "À"
end type

event modified;call super::modified;f_activar_campo(em_numfac)
end event

type st_35 from statictext within w_int_facturas_compras
integer x = 1691
integer y = 320
integer width = 242
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Dto.Com:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_tipoiva from statictext within w_int_facturas_compras
integer x = 494
integer y = 312
integer width = 754
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217731
boolean enabled = false
boolean focusrectangle = false
end type

type em_totbruto from u_em_campo within w_int_facturas_compras
event modificado pbm_custom02
integer x = 521
integer y = 3220
integer width = 457
integer height = 72
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 255
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;//dw_detalle.reset()
end event

type em_totdtopp from u_em_campo within w_int_facturas_compras
event modificado pbm_custom02
integer x = 1390
integer y = 3220
integer width = 398
integer height = 72
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 255
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;//dw_detalle.reset()
end event

type em_totdto1 from u_em_campo within w_int_facturas_compras
event modificado pbm_custom02
integer x = 983
integer y = 3220
integer width = 398
integer height = 72
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 255
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;//dw_detalle.reset()
end event

type em_baseimpon from u_em_campo within w_int_facturas_compras
event modificado pbm_custom02
integer x = 1792
integer y = 3220
integer width = 457
integer height = 72
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 255
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;//dw_detalle.reset()
end event

type em_totiva from u_em_campo within w_int_facturas_compras
event modificado pbm_custom02
integer x = 2249
integer y = 3220
integer width = 389
integer height = 72
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 255
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;//dw_detalle.reset()
end event

type em_totfactura from u_em_campo within w_int_facturas_compras
event modificado pbm_custom02
integer x = 2647
integer y = 3220
integer width = 462
integer height = 72
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 255
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;//dw_detalle.reset()
end event

type st_7 from statictext within w_int_facturas_compras
integer x = 517
integer y = 3160
integer width = 462
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 15793151
long backcolor = 24076881
boolean enabled = false
string text = "Importe Bruto"
alignment alignment = center!
boolean border = true
long bordercolor = 255
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_8 from statictext within w_int_facturas_compras
integer x = 1385
integer y = 3160
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 15793151
long backcolor = 24076881
boolean enabled = false
string text = "Dto. P.P."
alignment alignment = center!
boolean border = true
long bordercolor = 255
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_facturas_compras
integer x = 978
integer y = 3160
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 15793151
long backcolor = 24076881
boolean enabled = false
string text = "Dto. Com."
alignment alignment = center!
boolean border = true
long bordercolor = 255
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_10 from statictext within w_int_facturas_compras
integer x = 1787
integer y = 3160
integer width = 462
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 15793151
long backcolor = 24076881
boolean enabled = false
string text = "Base Impon."
alignment alignment = center!
boolean border = true
long bordercolor = 255
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_11 from statictext within w_int_facturas_compras
integer x = 2249
integer y = 3160
integer width = 393
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 15793151
long backcolor = 24076881
boolean enabled = false
string text = "I.V.A."
alignment alignment = center!
boolean border = true
long bordercolor = 255
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_12 from statictext within w_int_facturas_compras
integer x = 2642
integer y = 3160
integer width = 462
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 15793151
long backcolor = 24076881
boolean enabled = false
string text = "TOTAL Fact."
alignment alignment = center!
boolean border = true
long bordercolor = 255
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type r_2 from rectangle within w_int_facturas_compras
long linecolor = 12639424
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 24076881
integer x = 5
integer y = 3148
integer width = 3118
integer height = 156
end type

type st_55 from statictext within w_int_facturas_compras
integer x = 3616
integer y = 124
integer width = 777
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24076881
boolean enabled = false
string text = "Factura"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4444443 from statictext within w_int_facturas_compras
integer x = 5358
integer y = 124
integer width = 375
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24076881
boolean enabled = false
string text = "Cambio"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_cambio from statictext within w_int_facturas_compras
integer x = 5358
integer y = 200
integer width = 375
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217731
boolean enabled = false
alignment alignment = right!
boolean border = true
boolean focusrectangle = false
end type

type st_nombre_moneda2 from statictext within w_int_facturas_compras
integer x = 5111
integer y = 200
integer width = 242
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217731
boolean enabled = false
boolean focusrectangle = false
end type

type st_36 from statictext within w_int_facturas_compras
integer x = 2117
integer y = 228
integer width = 334
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Dec. Precios:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_decimales_precios from u_em_campo within w_int_facturas_compras
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 2459
integer y = 220
integer width = 187
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 553648127
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "0"
boolean spin = true
double increment = 1
string minmax = "0~~6"
end type

event modified;call super::modified;f_activar_campo(em_numfac)
end event

type gb_1 from groupbox within w_int_facturas_compras
integer x = 9
integer y = 84
integer width = 2917
integer height = 324
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 32238571
end type

type uo_ejercicio from u_ejercicio within w_int_facturas_compras
event destroy ( )
integer x = 2939
integer y = 112
integer width = 667
integer height = 308
long backcolor = 32238571
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_cta from datawindow within w_int_facturas_compras
boolean visible = false
integer x = 82
integer y = 252
integer width = 1810
integer height = 220
integer taborder = 50
string dataobject = "dw_int_facturas_compras2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_int_facturas_compras
integer x = 151
integer y = 3156
integer width = 361
integer height = 136
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle Bases"
end type

event clicked;dw_detalle_bases_imponibles.visible = not(dw_detalle_bases_imponibles.visible)
end event

type pb_1 from picturebutton within w_int_facturas_compras
integer x = 5
integer y = 3156
integer width = 146
integer height = 136
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\prelimi.bmp"
alignment htextalign = right!
end type

event clicked;dw_detalle_bases_imponibles.visible = not(dw_detalle_bases_imponibles.visible)
end event

type dw_detalle_cuentas from u_datawindow within w_int_facturas_compras
boolean visible = false
integer x = 3534
integer y = 412
integer width = 1723
integer height = 2700
integer taborder = 20
string dataobject = "dw_int_facturas_compras_detalle_cuentas"
boolean border = false
end type

event key;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE

CHOOSE CASE bus_campo
	CASE "cuenta"
		bus_filtro     = ""//"cuenta like '6%' or cuenta like '4%' or cuenta like '2%'"
		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event rbuttondown;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE

CHOOSE CASE bus_campo
	CASE "cuenta"
		bus_filtro     = ""//"cuenta like '6%' or cuenta like '4%' or cuenta like '2%'"
		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::RbuttonDown
end event

event clicked;call super::clicked;int    var_anyo,var_ejercicio,var_anyo2
long   var_albaran,var_linea,linea_albaran_activa,donde,ultima_linea,orden,indice,total,indice2,total2
long   var_albaran2,var_linea2,indice3,total3
string var_mprima,var_mprima2,cuentas[],filtro
dec    porcentajes[]

if dwo.name =  "pb_salir" then
	this.visible = false
else
	linea_albaran_activa = dw_detalle.getrow()//dwcontrol.GetSelectedRow(0)
	
	if linea_albaran_activa > 0 then
		var_anyo      = dec(dw_detalle.object.comlinalb_anyo[linea_albaran_activa])
		var_albaran   = dec(dw_detalle.object.comlinalb_albaran[linea_albaran_activa])
		var_linea     = dec(dw_detalle.object.comlinalb_linea[linea_albaran_activa])
		var_mprima    = dw_detalle.object.comlinalb_mprima[linea_albaran_activa]
		var_ejercicio = dec(uo_ejercicio.em_ejercicio.text)
		
		ultima_linea = this.rowcount()
		choose case dwo.name
			case "pb_anyadir"
				if ultima_linea > 0 then
					orden = this.object.orden[ultima_linea]
				else
					orden = 0
				end if
				
				orden ++
				
				donde = this.insertrow(0)
				this.object.empresa[donde]    = codigo_empresa
				this.object.anyo[donde]       = var_anyo
				this.object.albaran[donde]    = var_albaran
				this.object.linea[donde]      = var_linea
				this.object.ejercicio[donde]  = var_ejercicio
				this.object.orden[donde]      = orden						
				this.object.porcentaje[donde] = 100
				
				this.groupcalc()
			case "pb_borrar"
				this.deleterow(this.getrow())
			case "pb_aplicar"
				this.setredraw(false)
				filtro = "anyo = "+string(var_anyo,"####")+" and albaran = "+string(var_albaran,"#####")+" and linea = "+string(var_linea,"#####")+" and orden > 0"			
				this.setfilter(filtro)
				this.filter()
				
				total = this.rowcount()
				
				for indice = 1 to total
					cuentas[indice]     = this.object.cuenta[indice]
					porcentajes[indice] = this.object.porcentaje[indice]
				next
				
				total2 = dw_detalle.rowcount()
				
				for indice2 = 1 to total2
					f_mensaje_proceso("Asignando Cuentas",indice2,total2)
					var_anyo2      = dec(dw_detalle.object.comlinalb_anyo[indice2])
					var_albaran2   = dec(dw_detalle.object.comlinalb_albaran[indice2])
					var_linea2     = dec(dw_detalle.object.comlinalb_linea[indice2])
					var_mprima2    = dw_detalle.object.comlinalb_mprima[indice2]				
					
					if var_mprima2 = var_mprima then
						filtro = "anyo = "+string(var_anyo2,"####")+" and albaran = "+string(var_albaran2,"#####")+" and linea = "+string(var_linea2,"#####")
						this.setfilter(filtro)
						this.filter()
						
						total3 = this.rowcount()
						
						for indice3 = total3 to 1 step -1
							this.deleterow(indice3)
						next
						
						for indice3 = 1 to total
							donde = this.insertrow(0)
							this.object.empresa[donde]    = codigo_empresa
							this.object.anyo[donde]       = var_anyo2
							this.object.albaran[donde]    = var_albaran2
							this.object.linea[donde]      = var_linea2
							this.object.ejercicio[donde]  = var_ejercicio
							this.object.cuenta[donde]     = cuentas[indice3]
							this.object.porcentaje[donde] = porcentajes[indice3]
							this.object.orden[donde]      = indice3										
						next
					end if
				next
//				filtro = "anyo = "+string(var_anyo,"####")+" and albaran = "+string(var_albaran,"#####")+" and linea = "+string(var_linea,"#####")
//				this.setfilter(filtro)
//				this.filter()
//				this.sort()
				dw_detalle.event doubleclicked(0,0,linea_albaran_activa,dwo)
				this.setredraw(true)
		end choose
	end if
end if
end event

event ue_valores;call super::ue_valores;ue_marca_linea = TRUE
end event

type dw_detalle from u_datawindow within w_int_facturas_compras
integer x = 5
integer y = 412
integer width = 5243
integer height = 2700
integer taborder = 0
string dataobject = "dw_int_facturas_compras"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event clicked;call super::clicked;Long 		ll_lineas,ll_indice,donde
String   ls_marcado
Dec{2}	poriva, brutin = 0,bruto

ll_lineas = dw_detalle.RowCount()

//this.setredraw(false)
//
//this.selectrow(0,false)
//this.selectrow(row,true)
//this.setrow(row)

//if dwo.name = "cmarca" then
//	dw_agrupa_articulos.retrieve (codigo_empresa, uo_proveedor.em_codigo.text, datetime(em_desde.text), datetime(em_hasta.text))	
//end if	


if row = 0 then
	string   ls_objeto_y_row,ls_object,ls_albaran_proveedor,ls_albaran_marcado
	long     ll_row,ll_inicio_grupo,ll_final_grupo
	datetime ldt_fecha_albaran
	
	ls_objeto_y_row = getobjectatpointer()
	
	ls_object = Left(ls_objeto_y_row, Pos(ls_objeto_y_row, "~t", 1) - 1)
	ll_row    = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))	
	
	CHOOSE CASE ls_object //f_objeto_datawindow(dw_detalle)
		CASE "cmarca_albaran"
			ls_albaran_proveedor = this.object.comcabalb_albaran_proveedor[ll_row]
			ldt_fecha_albaran    = this.object.comcabalb_fecha_alb[ll_row]
			ls_albaran_marcado   = this.object.cmarca_albaran[ll_row]
			
			if ls_albaran_marcado = 'S' then
				ls_albaran_marcado = 'N'
			else
				ls_albaran_marcado = 'S'				
			end if
			
			ll_inicio_grupo = ll_row 

			ll_final_grupo = this.findgroupchange(ll_row +1,1)
				
			if ll_final_grupo > 0 then
				ll_final_grupo --
			else
				ll_final_grupo = rowcount()
			end if
			
			this.selectrow(0,false)
			for ll_row = ll_inicio_grupo to ll_final_grupo
				this.object.cmarca_albaran[ll_row] = ls_albaran_marcado
				if this.object.cmarca[ll_row] <> ls_albaran_marcado then 
					if this.event itemchanged(ll_row,this.object.cmarca,ls_albaran_marcado)	= 0 then
						this.object.cmarca[ll_row] = ls_albaran_marcado
					end if
				end if
				this.selectrow(ll_row,true)
			next						
			
		CASE "boton_todo"
				bruto = 0
				FOR ll_indice = 1 TO ll_lineas
					this.object.cmarca_albaran[ll_indice] = "S"
					
					IF dw_detalle.GetItemString(ll_indice,"comlinalb_situacion") <> "N" THEN
//						dw_detalle.SetItem(i,"cmarca","S")
						if this.object.cmarca[ll_indice] <> "S" then							
							
		//					dw_detalle.Accepttext()
							if dw_detalle.event itemchanged(ll_indice, this.object.cmarca, "S") = 0 then
								this.object.cmarca[ll_indice]  = "S"
							end if
	
							brutin = dw_detalle.GetItemNumber(ll_indice,"comlinalb_importe") / cambio
							bruto = bruto + brutin
						end if
					END IF
				NEXT		
//				em_totbruto.text   = String(bruto,f_redondeo_moneda(em_moneda.text))
//				em_totdtopp.text   = String(bruto*Dec(em_dtopp.text)/100,f_redondeo_moneda(em_moneda.text))
//				em_totdto1.text    = String(bruto*Dec(em_dto1.text)/100,f_redondeo_moneda(em_moneda.text))
//				em_baseimpon.text  = String(bruto - Dec(em_totdtopp.text) - Dec(em_totdto1.text))
//				poriva   			 = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,em_tipoiva.text)
//				em_totiva.text 	 = String(Dec(em_baseimpon.text)*poriva/100,f_redondeo_moneda(em_moneda.text))
//				em_totfactura.text = String(Dec(em_baseimpon.text)+Dec(em_totiva.text))		
				
		CASE "boton_ninguno"
				FOR ll_indice = 1 TO ll_lineas
					this.object.cmarca_albaran[ll_indice] = "N"
					
//					dw_detalle.SetItem(i,"cmarca","N")
					if this.object.cmarca[ll_indice] <> "N" then
	
						if dw_detalle.event itemchanged(ll_indice, this.object.cmarca, "N") = 0 then
							this.object.cmarca[ll_indice]  = "N"
						end if
						
					end if
				NEXT	
				
//				em_totbruto.text 	  = ""
//				em_totdtopp.text 	  = ""
//				em_totdto1.text  	  = ""
//				em_baseimpon.text   = ""
//				em_totiva.text		  = ""
//				em_totfactura.text  = ""
//				bruto = 0				
				
		CASE "pb_anyadir"
			this.selectrow(0,false)

//			donde = this.insertrow(this.rowcount()+1)
			donde = this.insertrow(0)
			this.object.comcabalb_empresa[donde]                  = codigo_empresa
			this.object.comcabalb_albaran_proveedor[donde]        = "*Lineas Nuevas"
			this.object.comcabalb_fecha_alb[donde]                = datetime(today())
			this.object.comlinalb_anyo[donde]                     = string(year(today()),"####")
			this.object.comlinalb_albaran[donde]                  = "99999"
			this.object.comlinalb_linea[donde]                    = string(donde,"####0")
			this.object.comlinalb_ubicado[donde]                  = "N"
			this.object.comlinalb_descripcion[donde]              = ""
			this.object.comlinalb_cantidad[donde]                 = 0
			this.object.comlinalb_precio[donde]                   = 0
			this.object.comlinalb_importe[donde]                  = 0
			this.object.comcabalb_precio_moneda_proveedor[donde]  = 0
			this.object.comcabalb_importe_moneda_proveedor[donde] = 0		
			this.object.comlinalb_cuenta[donde]                   = ""
			this.object.comcabalb_linea_nueva[donde]              = "S"
			this.object.comlinalb_situacion[donde]                = "C"
			this.object.cmarca[donde]                             = "N"
			this.object.comcabalb_moneda[donde]                   = em_moneda.text
			this.object.comcabalb_decimales_precios[donde]        = dec(em_decimales_precios.text)
			this.object.comcabalb_cambio[donde]                   = dec(st_cambio.text)
			this.object.comlinalb_unidad_medida[donde]            = "1" //Unidades
			this.object.tipo_iva[donde]                           = em_tipoiva.text
			this.object.comlinalb_descuento[donde]                = 0
			this.object.aplicar_dto[donde]                        = "N"
			this.object.aplicar_dto_pp[donde]                     = "N"
			
			this.sort()
			this.groupcalc()
			
			donde = this.find("comcabalb_albaran_proveedor = '"+"*Lineas Nuevas"+"' and comlinalb_linea = '"+string(donde,"####0")+"'",1,donde)
			
			this.selectrow(0,false)
			this.selectrow(donde,true)
			this.scrolltorow(donde)
			this.setrow(donde)
			this.setcolumn("comlinalb_descripcion")

	END CHOOSE
else
	if dw_detalle_cuentas.visible then
		this.event doubleclicked(xpos,ypos,row,dwo)
	end if
end if

this.setredraw(True)




end event

event retrieveend;long   indice,total,donde,var_albaran,var_linea
dec    importe_moneda_albaran,importe_moneda_proveedor,precio_albaran,precio_moneda_proveedor,cambio_albaran
dec    cantidad,cambio_moneda_proveedor,descuento
string var_cuenta,moneda_albaran,moneda_proveedor,var_tipo_iva,var_mprima,criterio_busqueda
int    decimales_albaran,decimales_proveedor,decimales_moneda,var_anyo,var_ejercicio

total = rowcount

moneda_proveedor        = em_moneda.text
decimales_proveedor     = dec(em_decimales_precios.text)
cambio_moneda_proveedor = f_cambio_moneda(moneda_proveedor)
var_ejercicio           = dec(uo_ejercicio.em_ejercicio.text)

For indice = 1 To total	
	var_anyo    = dec(this.object.comlinalb_anyo[indice])
	var_albaran = dec(this.object.comlinalb_albaran[indice])
	var_linea   = dec(this.object.comlinalb_linea[indice])
	var_mprima  = this.object.comlinalb_mprima[indice]
	var_cuenta  = this.object.comlinalb_cuenta[indice]
	
	if isnull(var_cuenta) then var_cuenta = ""	
	if trim(var_cuenta) = "" then
		var_cuenta = f_cuenta_mprima(codigo_empresa,var_mprima)
		//SetItem(indice,"comlinalb_cuenta",))
	end if
	criterio_busqueda = "anyo = "+string(var_anyo,"####")+" and albaran = "+string(var_albaran,"######")+" and linea = "+string(var_linea,"######")
	donde = dw_detalle_cuentas.find(criterio_busqueda,1,dw_detalle_cuentas.rowcount())
	
	if donde <= 0 then
		donde = dw_detalle_cuentas.insertrow(0)	
		dw_detalle_cuentas.object.empresa[donde]    = codigo_empresa
		dw_detalle_cuentas.object.anyo[donde]       = var_anyo
		dw_detalle_cuentas.object.albaran[donde]    = var_albaran
		dw_detalle_cuentas.object.linea[donde]      = var_linea
		dw_detalle_cuentas.object.cuenta[donde]     = var_cuenta
		dw_detalle_cuentas.object.ejercicio[donde]  = var_ejercicio
		dw_detalle_cuentas.object.porcentaje[donde] = 100
		dw_detalle_cuentas.object.orden[donde]      = 1
	end if
		
	var_tipo_iva = GetItemstring(indice,"tipo_iva")
	if isnull(var_tipo_iva) then var_tipo_iva = ""	
	if trim(var_tipo_iva) = "" then
		SetItem(indice,"tipo_iva",em_tipoiva.text)
	end if		
	
	moneda_albaran    = this.object.comcabalb_moneda[indice]
	cambio_albaran    = this.object.comcabalb_cambio[indice]
	decimales_albaran = this.object.comcabalb_decimales_precios[indice]
	
	if isnull(moneda_albaran) then moneda_albaran = ""
	if isnull(cambio_albaran) then cambio_albaran = 0
	if isnull(decimales_albaran) then decimales_albaran = 0
	
	//Comprobamos los decimales del albaran
	decimales_moneda = f_decimales_moneda(moneda_albaran)
	
	if decimales_moneda > decimales_albaran then
		decimales_albaran = decimales_moneda
		this.object.comcabalb_decimales_precios[indice] = decimales_albaran
	end if
	//
	
	//Comprobamos el cambio del albaran
	if cambio_albaran = 0 then
		cambio_albaran = f_cambio_moneda(moneda_albaran)
		this.object.comcabalb_cambio[indice] = cambio_albaran
	end if
	//
	
	cantidad               = this.object.comlinalb_cantidad[indice]
	precio_albaran         = this.object.comlinalb_precio[indice]
	descuento              = this.object.comlinalb_descuento[indice]	
	precio_albaran         = dec(string(precio_albaran,f_mascara_decimales(decimales_albaran)))
	importe_moneda_albaran = precio_albaran * cantidad
	importe_moneda_albaran = dec(string(importe_moneda_albaran,f_mascara_moneda(moneda_albaran)))
	
	if isnull(descuento) then descuento  = 0
	if descuento <> 0 then
		importe_moneda_albaran = importe_moneda_albaran - ((importe_moneda_albaran / 100) * descuento)
		importe_moneda_albaran = dec(string(importe_moneda_albaran,f_mascara_moneda(moneda_albaran)))
	end if
	
		
	if moneda_proveedor <> moneda_albaran then
		if cambio_albaran <> 0 then
			precio_moneda_proveedor = (precio_albaran / cambio_albaran) * cambio_moneda_proveedor
			precio_moneda_proveedor = dec(string(precio_moneda_proveedor,f_mascara_decimales(decimales_proveedor))) 
		else
			precio_moneda_proveedor = precio_albaran
		end if
		
		importe_moneda_proveedor = precio_moneda_proveedor * cantidad
		importe_moneda_proveedor = dec(string(importe_moneda_proveedor,f_mascara_moneda(moneda_proveedor))) 
		
		if descuento <> 0 then
			importe_moneda_proveedor = importe_moneda_proveedor - ((importe_moneda_proveedor / 100) * descuento)
			importe_moneda_proveedor = dec(string(importe_moneda_proveedor,f_mascara_moneda(moneda_proveedor))) 
		end if		
	else
		precio_moneda_proveedor  = precio_albaran
		importe_moneda_proveedor = importe_moneda_albaran
	end if
	
	this.object.comlinalb_precio[indice]                   = precio_albaran
	this.object.comlinalb_importe[indice]                  = importe_moneda_albaran
	this.object.comcabalb_precio_moneda_proveedor[indice]  = precio_moneda_proveedor
	this.object.comcabalb_importe_moneda_proveedor[indice] = importe_moneda_proveedor
	
Next
	
end event

event itemchanged;dec    precio,cantidad,importe,poriva,descuento
dec    ejer
String oky,anyo,alba,marcado,tipo_iva,libro_iva,descripcion_iva,mascara_moneda,var_seccion
Long	 i,ejercicio,donde,existe
dec    porcentaje_dto_comercial,porcentaje_dto_pp,dto_comercial,dto_pronto_pago,porcentaje_iva,importe_iva
dec    base_imponible,bruto
String proveedor, mprima, tipo_materia,criterio_busqueda
Datetime fechcomp

string des_mprima
mascara_moneda = f_mascara_moneda(moneda)

if dwo.name = "comlinalb_mprima" then
	
	select descripcion
	into   :des_mprima
	from   venmprima
	where  empresa = :codigo_empresa
	and    codigo  = :data;
	
	this.object.comlinalb_descripcion[row] = des_mprima
	this.object.comlinalb_cuenta[row] = f_cuenta_mprima(codigo_empresa,data)
	
	criterio_busqueda = "anyo = "+this.object.comlinalb_anyo[row]+" and albaran = "+this.object.comlinalb_albaran[row]+" and linea = "+this.object.comlinalb_linea[row]
	donde = dw_detalle_cuentas.find(criterio_busqueda,1,dw_detalle_cuentas.rowcount())
	
	if donde <= 0 then
		donde = dw_detalle_cuentas.insertrow(0)	
		dw_detalle_cuentas.object.empresa[donde]    = codigo_empresa
		dw_detalle_cuentas.object.anyo[donde]       = long(this.object.comlinalb_anyo[row])
		dw_detalle_cuentas.object.albaran[donde]    = long(this.object.comlinalb_albaran[row])
		dw_detalle_cuentas.object.linea[donde]      = long(this.object.comlinalb_linea[row])
		dw_detalle_cuentas.object.cuenta[donde]     = dw_detalle.object.comlinalb_cuenta[row]
		dw_detalle_cuentas.object.ejercicio[donde]  = long(this.object.comlinalb_anyo[row])
		dw_detalle_cuentas.object.porcentaje[donde] = 100
		dw_detalle_cuentas.object.orden[donde]      = 1
	else
		dw_detalle_cuentas.object.cuenta[donde]     = dw_detalle.object.comlinalb_cuenta[row] 
	end if	
//	dw_detalle_cuentas.object.cuenta[row] = cuenta
	
end if

if dwo.name = "comlinalb_cuenta" then
	
	criterio_busqueda = "anyo = "+this.object.comlinalb_anyo[row]+" and albaran = "+this.object.comlinalb_albaran[row]+" and linea = "+this.object.comlinalb_linea[row]
	donde = dw_detalle_cuentas.find(criterio_busqueda,1,dw_detalle_cuentas.rowcount())
	
	if donde <= 0 then
		donde = dw_detalle_cuentas.insertrow(0)	
		dw_detalle_cuentas.object.empresa[donde]    = codigo_empresa
		dw_detalle_cuentas.object.anyo[donde]       = long(this.object.comlinalb_anyo[row])
		dw_detalle_cuentas.object.albaran[donde]    = long(this.object.comlinalb_albaran[row])
		dw_detalle_cuentas.object.linea[donde]      = long(this.object.comlinalb_linea[row])
		dw_detalle_cuentas.object.cuenta[donde]     = data
		dw_detalle_cuentas.object.ejercicio[donde]  = long(this.object.comlinalb_anyo[row])
		dw_detalle_cuentas.object.porcentaje[donde] = 100
		dw_detalle_cuentas.object.orden[donde]      = 1
	else
		dw_detalle_cuentas.object.cuenta[donde]     = data
	end if	
	
end if


IF  dwo.name = "comlinalb_cantidad"  or dwo.name = "comlinalb_descuento" or dwo.name = "comlinalb_precio" Then
	
	if dwo.name <> "comlinalb_importe" then
		
		if  dwo.name = "comlinalb_precio"   then
			precio    = dec(data)	
			cantidad  = this.object.comlinalb_cantidad[row]
			descuento = this.object.comlinalb_descuento[row]
			proveedor = uo_proveedor.em_codigo.text
			mprima = this.object.comlinalb_mprima[row]
			if f_precio_mprima(codigo_empresa,proveedor,mprima) <> precio and precio <> 0 then
				if messagebox("Precio modificado","Desea modificar el precio en la ficha del articulo",question!,yesno!) = 1 then
					fechcomp=datetime(today())
					UPDATE comartpro
					SET precio = :precio,
						 fecha  = :fechcomp
					WHERE ( comartpro.empresa   = :codigo_empresa ) AND
							( comartpro.proveedor = :proveedor ) AND
							( comartpro.mprima    = :mprima )   ;
					tipo_materia = ""
					SELECT tipo_materia INTO :tipo_materia FROM venmprima WHERE empresa = :codigo_empresa AND codigo = :mprima;
					if ( tipo_materia = '16' or tipo_materia = '17' ) then
						if  MessageBox("Atención", "Desea recalcular costes para el proveedor",  Question!, YesNO!, 2) = 1 then
							f_recalculo_costes_formulas (codigo_empresa, mprima)
						end if		
					end if
				end if
			end if
			
		else
			if dwo.name = "comlinalb_descuento" then
				precio    = this.object.comlinalb_precio[row]
				
				cantidad  = this.object.comlinalb_cantidad[row]
				descuento = dec(data)
			else
				precio    = this.object.comlinalb_precio[row]
				cantidad  = dec(data)
				descuento = this.object.comlinalb_descuento[row]
			end if
		end if
		importe = Dec(String(precio * cantidad,mascara_moneda))				
		
		if descuento <> 0 then
			importe = Dec(String(importe - ((importe / 100) * descuento),mascara_moneda))
		end if
		
		this.object.comlinalb_importe[row] = importe
	end if
END IF

IF dwo.name = "cmarca" THEN

	marcado = data
	
	bruto                    = this.object.comlinalb_importe[row]
	porcentaje_dto_comercial = dec(em_dto1.text)
	porcentaje_dto_pp        = dec(em_dtopp.text)
	tipo_iva                 = this.object.tipo_iva[row]
	ejercicio                = Dec(uo_ejercicio.em_ejercicio.text)
	porcentaje_iva           = f_iva_contaiva(ejercicio,codigo_empresa,tipo_iva)
	
	//Calculo Dto comercial
	if porcentaje_dto_comercial > 0 then
		if this.object.aplicar_dto[row] = "S" then
			dto_comercial = (bruto / 100) * porcentaje_dto_comercial
		else
			dto_comercial = 0
		end if
	else
		dto_comercial = 0
	end if
	dto_comercial = dec(string(dto_comercial,mascara_moneda))
	
	//Calculo Dto P.P.
	if porcentaje_dto_pp > 0 then
		if this.object.aplicar_dto_pp[row] = "S" then
			dto_pronto_pago = ((bruto - dto_comercial) / 100) * porcentaje_dto_pp
		else
			dto_pronto_pago = 0
		end if
	else
		dto_pronto_pago = 0
	end if
	dto_pronto_pago = dec(string(dto_pronto_pago,mascara_moneda))
	
	//Calculo Base Imponible
	
	base_imponible = (bruto - dto_comercial) - dto_pronto_pago
	
	if isnull(tipo_iva) then tipo_iva = ''
	
	donde = dw_detalle_bases_imponibles.find("tipo_iva = '"+tipo_iva+"'",1,dw_detalle_bases_imponibles.rowcount())
	if marcado = "S" then
		//Añadimos los importes de la linea
		//Comprobamos si ya hemos introducido una linea con el tipo de iva actual				
		
		if donde <= 0 then
			libro_iva       = f_libro_contaiva(ejercicio,codigo_empresa,tipo_iva)
			descripcion_iva = STring(porcentaje_iva,"##")+"% "+f_nombre_contaiva(ejercicio,codigo_empresa,tipo_iva)
			
			donde = dw_detalle_bases_imponibles.insertrow(0)
			dw_detalle_bases_imponibles.object.empresa[donde]         = codigo_empresa
			dw_detalle_bases_imponibles.object.bruto[donde]           = 0
			dw_detalle_bases_imponibles.object.dto_pronto_pago[donde] = 0
			dw_detalle_bases_imponibles.object.dto_comercial[donde]   = 0
			dw_detalle_bases_imponibles.object.base_imponible[donde]  = 0
			dw_detalle_bases_imponibles.object.importe_iva[donde]     = 0
			dw_detalle_bases_imponibles.object.tipo_iva[donde]        = tipo_iva
			dw_detalle_bases_imponibles.object.descripcion_iva[donde] = descripcion_iva	
			dw_detalle_bases_imponibles.object.iva[donde]             = porcentaje_iva	
			dw_detalle_bases_imponibles.object.registro[donde]        = 0
			dw_detalle_bases_imponibles.object.libro[donde]           = libro_iva
		end if
		bruto           = dw_detalle_bases_imponibles.object.bruto[donde]           + bruto
		dto_pronto_pago = dw_detalle_bases_imponibles.object.dto_pronto_pago[donde] + dto_pronto_pago
		dto_comercial   = dw_detalle_bases_imponibles.object.dto_comercial[donde]   + dto_comercial
		base_imponible  = dw_detalle_bases_imponibles.object.base_imponible[donde]  + base_imponible		
	else
		//Eliminamos los importes de la linea
		if dw_detalle_bases_imponibles.rowcount() > 0 then
			bruto           = dw_detalle_bases_imponibles.object.bruto[donde] - bruto
			dto_pronto_pago = dw_detalle_bases_imponibles.object.dto_pronto_pago[donde] - dto_pronto_pago
			dto_comercial   = dw_detalle_bases_imponibles.object.dto_comercial[donde]   - dto_comercial
			base_imponible  = dw_detalle_bases_imponibles.object.base_imponible[donde]  - base_imponible
		end if
	end if
	//Grabamos los nuevos valores
	
	if bruto <> 0 then
		dw_detalle_bases_imponibles.object.bruto[donde]           = bruto
		dw_detalle_bases_imponibles.object.dto_pronto_pago[donde] = dto_pronto_pago
		dw_detalle_bases_imponibles.object.dto_comercial[donde]   = dto_comercial
		dw_detalle_bases_imponibles.object.base_imponible[donde]  = base_imponible		
		
		//Calculo I.V.A.
		if porcentaje_iva > 0 then
			importe_iva = ((base_imponible) / 100) * porcentaje_iva
		else
			importe_iva = 0
		end if
		//messagebox("","Bruto "+string(bruto)+"~nDto Com "+string(dto_comercial)+"~nDtp PP "+string(dto_pronto_pago)+"~n Base Imp "+string(base_imponible)+"~nIVA "+string(importe_iva))
		importe_iva = dec(string(importe_iva,mascara_moneda))
		
		dw_detalle_bases_imponibles.object.importe_iva[donde]     = importe_iva			
	else
		dw_detalle_bases_imponibles.deleterow(donde)
	end if
	f_calculo_totales_fra()
	
end if


if dwo.name = "comlinalb_seccion" then
	var_seccion = data
	
	if trim(var_seccion) <> "" then
		select count(*)
		into   :existe
		from   contaseccion
		where  empresa = :codigo_empresa
		and    codigo  = :var_seccion;
		
		if isnull(existe) then existe = 0
		
		if existe = 0 then
			return 2
		end if		
	end if
end if


end event

event key;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE

CHOOSE CASE bus_campo
	CASE "comlinalb_mprima"
		bus_titulo     = "VENTANA SELECCION DE ARTÍCULOS DE COMPRAS "
		bus_datawindow = "dw_ayuda_venmprima"
		bus_filtro     =""		
	CASE "comlinalb_cuenta"
		bus_filtro     = "cuenta like '6%' or cuenta like '4%' or cuenta like '2%'"
		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	CASE "tipo_iva"
		bus_titulo     = "VENTANA SELECCION DE IVAS "
		bus_datawindow = "dw_ayuda_contaiva_compras"
		bus_filtro     = "ejercicio = " +uo_ejercicio.em_ejercicio.text				
	CASE "comlinalb_seccion"
		bus_titulo     = "AYUDA SELECCIÓN DE SECCIONES"
		bus_datawindow = "dw_ayuda_contaseccion"
		bus_filtro     = ""
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event rbuttondown;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE

CHOOSE CASE bus_campo
	CASE "comlinalb_mprima"
		bus_titulo     = "VENTANA SELECCION DE ARTÍCULOS DE COMPRAS "
		bus_datawindow = "dw_ayuda_venmprima"
		bus_filtro     =""		
	CASE "comlinalb_cuenta"
		bus_filtro     = "cuenta like '6%' or cuenta like '4%' or cuenta like '2%'"
		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	CASE "tipo_iva"
		bus_titulo     = "VENTANA SELECCION DE IVAS "
		bus_datawindow = "dw_ayuda_contaiva_compras"
		bus_filtro     ="ejercicio = " +uo_ejercicio.em_ejercicio.text		
	CASE "comlinalb_seccion"
		bus_titulo     = "AYUDA SELECCIÓN DE SECCIONES"
		bus_datawindow = "dw_ayuda_contaseccion"
		bus_filtro     = ""		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown

end event

event scrollvertical;dw_detalle_cuentas.visible = false
end event

event doubleclicked;long     firstrow,var_albaran,var_linea,indice,donde,var_ejercicio
int      var_anyo,grupos
string   var_mprima,filtro,ant_albaran_prov,albaran_prov
datetime ant_fecha_alb,fecha_alb

if row > 0 then
	dw_detalle_cuentas.setredraw(false)
	this.selectrow(0,false)
	this.selectrow(row,true)
	this.setrow(row)
	
	firstrow      = long(this.object.datawindow.FirstRowOnPage)
	var_anyo      = dec(this.object.comlinalb_anyo[row])
	var_albaran   = dec(this.object.comlinalb_albaran[row])
	var_linea     = dec(this.object.comlinalb_linea[row])
	var_mprima    = this.object.comlinalb_mprima[row]
	var_ejercicio = dec(uo_ejercicio.em_ejercicio.text)
	//Contamos los distintos grupos hasta la linea seleccionada
	grupos = 0
	ant_albaran_prov = this.object.comcabalb_albaran_proveedor[firstrow]
	ant_fecha_alb    = this.object.comcabalb_fecha_alb[firstrow]
	for indice = firstrow to row
		albaran_prov = this.object.comcabalb_albaran_proveedor[indice]
		fecha_alb    = this.object.comcabalb_fecha_alb[indice]
		
		if albaran_prov <> ant_albaran_prov or fecha_alb <> ant_fecha_alb then
			ant_albaran_prov = albaran_prov
			ant_fecha_alb    = fecha_alb
			
			grupos ++
		end if
	next
	grupos ++
	
	filtro = "anyo = "+string(var_anyo,"####")+" and albaran = "+string(var_albaran,"######")+" and linea = "+string(var_linea,"#####")
	
	dw_detalle_cuentas.setfilter(filtro)//(criterio_busqueda,1,dw_detalle_cuentas.rowcount())
	dw_detalle_cuentas.filter()
					
	for indice = dw_detalle_cuentas.rowcount() to 1 step -1
		if dw_detalle_cuentas.object.orden[indice] = 0 then
			dw_detalle_cuentas.deleterow(indice)
		end if
	next
	
	if dw_detalle_cuentas.rowcount() = 0 then
		donde = dw_detalle_cuentas.insertrow(0)	
		dw_detalle_cuentas.object.empresa[donde]    = codigo_empresa
		dw_detalle_cuentas.object.anyo[donde]       = var_anyo
		dw_detalle_cuentas.object.albaran[donde]    = var_albaran
		dw_detalle_cuentas.object.linea[donde]      = var_linea
		dw_detalle_cuentas.object.ejercicio[donde]  = var_ejercicio
		dw_detalle_cuentas.object.orden[donde]      = 1
		dw_detalle_cuentas.object.porcentaje[donde] = 100		
	end if
	
	for indice = firstrow to ((row -1) + grupos)
		donde = dw_detalle_cuentas.insertrow(0)	
		dw_detalle_cuentas.object.empresa[donde] = codigo_empresa
		dw_detalle_cuentas.object.anyo[donde]    = var_anyo
		dw_detalle_cuentas.object.albaran[donde] = var_albaran
		dw_detalle_cuentas.object.linea[donde]   = var_linea
		dw_detalle_cuentas.object.orden[donde]   = 0
	next	
	dw_detalle_cuentas.sort()
	dw_detalle_cuentas.setredraw(true)
	dw_detalle_cuentas.visible = true	
	
end if
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_unidad,ls_montaje,ls_mascara

if currentrow > 0 then
	this.setredraw(false)
	ls_unidad  = this.object.comlinalb_unidad_medida[currentrow]
	ls_mascara = f_mascara_unidad_compras(ls_unidad)
	
	ls_montaje = "comlinalb_cantidad.Edit.AutoSelect= Yes" 
	this.Modify(ls_montaje)
//	ls_montaje = "comlinalb_cantidad.Format=" +"'"+ ls_mascara +"'"
//	this.Modify(ls_montaje)
	ls_montaje = "comlinalb_cantidad.Edit.Format=" +"'"+ ls_mascara +"'"
	this.Modify(ls_montaje)
	this.setredraw(true)
end if
end event

type dw_factura_proveedor from datawindow within w_int_facturas_compras
boolean visible = false
integer y = 572
integer width = 3611
integer height = 1108
integer taborder = 130
string dataobject = "dw_con_factura_proveedor"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;dec  importe,poriva
long indice,total

importe = 0

total = rowcount
For indice = 1 to total
	importe = importe + this.object.comlinfac_importe[indice]
next

em_totbruto.text   = String(importe,f_redondeo_moneda(em_moneda.text))
em_totdtopp.text   = String(importe*Dec(em_dtopp.text)/100,f_redondeo_moneda(em_moneda.text))
em_totdto1.text    = String(importe*Dec(em_dto1.text)/100,f_redondeo_moneda(em_moneda.text))
em_baseimpon.text  = String(importe - Dec(em_totdtopp.text) - Dec(em_totdto1.text))
poriva   			 = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,em_tipoiva.text)
em_totiva.text 	 = String(Dec(em_baseimpon.text)*poriva/100,f_redondeo_moneda(em_moneda.text))
em_totfactura.text = String(Dec(em_baseimpon.text)+Dec(em_totiva.text))		
end event

type dw_detalle_bases_imponibles from datawindow within w_int_facturas_compras
boolean visible = false
integer x = 14
integer y = 3300
integer width = 3099
integer height = 552
string dataobject = "dw_int_facturas_compras_detalle_bases"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;dec    bruto,dto_pronto_pago,dto_comercial,base_imponible,importe_iva,iva
dec    total_bruto,total_dto_pronto_pago,total_dto_comercial,total_base_imponible,total_importe_iva 
long   indice,total
string mascara_moneda,campo,tipo_iva

mascara_moneda = f_mascara_moneda(moneda)

campo = dwo.name

choose case dwo.name
	case "bruto"
		bruto           = dec(data)
		dto_pronto_pago = this.object.dto_pronto_pago[row]
		dto_comercial   = this.object.dto_comercial[row]
		base_imponible  = (bruto - dto_comercial) - dto_pronto_pago
		iva             = this.object.iva[row]
		importe_iva     = dec(string((base_imponible / 100) * iva,mascara_moneda))
				
		this.object.base_imponible[row] = base_imponible				
		this.object.importe_iva[row]    = importe_iva 
	case "dto_pronto_pago"
		bruto           = this.object.bruto[row]
		dto_pronto_pago = dec(data)
		dto_comercial   = this.object.dto_comercial[row]
		base_imponible  = (bruto - dto_comercial) - dto_pronto_pago
		iva             = this.object.iva[row]
		importe_iva     = dec(string((base_imponible / 100) * iva,mascara_moneda))
		
		this.object.base_imponible[row] = base_imponible
		this.object.importe_iva[row]    = importe_iva 
	case "dto_comercial"
		bruto           = this.object.bruto[row]
		dto_pronto_pago = this.object.dto_pronto_pago[row]
		dto_comercial   = dec(data)
		base_imponible  = (bruto - dto_comercial) - dto_pronto_pago
		iva             = this.object.iva[row]
		importe_iva     = dec(string((base_imponible / 100) * iva,mascara_moneda))
		
		this.object.base_imponible[row] = base_imponible
		this.object.importe_iva[row]    = importe_iva 
	case "base_imponible"
		base_imponible  = dec(data)
		iva             = this.object.iva[row]
		importe_iva     = dec(string((base_imponible / 100) * iva,mascara_moneda))
				
		this.object.importe_iva[row] = importe_iva 
end choose

total_bruto           = 0
total_dto_pronto_pago = 0
total_dto_comercial   = 0
total_base_imponible  = 0
total_importe_iva     = 0

total = this.rowcount()

for indice = 1 to total	
	tipo_iva = dw_detalle_bases_imponibles.object.tipo_iva[indice]
	
	if indice = row then
		choose case dwo.name
			case "bruto"
				total_bruto           = total_bruto           + dec(data)
				total_dto_pronto_pago = total_dto_pronto_pago + this.object.dto_pronto_pago[indice]
				total_dto_comercial   = total_dto_comercial   + this.object.dto_comercial[indice]
				total_base_imponible  = total_base_imponible  + this.object.base_imponible[indice]
				//Controlamos ivas autorepercutidos, que no deben sumarse al total de la fra
				if tipo_iva <> "13" and tipo_iva <> "25" then				
					total_importe_iva     = total_importe_iva     + this.object.importe_iva[indice]						
				end if
			case "dto_pronto_pago"
				total_bruto           = total_bruto           + this.object.bruto[indice]
				total_dto_pronto_pago = total_dto_pronto_pago + dec(data)
				total_dto_comercial   = total_dto_comercial   + this.object.dto_comercial[indice]
				total_base_imponible  = total_base_imponible  + this.object.base_imponible[indice]
				//Controlamos ivas autorepercutidos, que no deben sumarse al total de la fra
				if tipo_iva <> "13" and tipo_iva <> "25" then				
					total_importe_iva     = total_importe_iva     + this.object.importe_iva[indice]						
				end if
			case "dto_comercial"
				total_bruto           = total_bruto           + this.object.bruto[indice]
				total_dto_pronto_pago = total_dto_pronto_pago + this.object.dto_pronto_pago[indice]
				total_dto_comercial   = total_dto_comercial   + dec(data)
				total_base_imponible  = total_base_imponible  + this.object.base_imponible[indice]
				//Controlamos ivas autorepercutidos, que no deben sumarse al total de la fra
				if tipo_iva <> "13" and tipo_iva <> "25" then				
					total_importe_iva     = total_importe_iva     + this.object.importe_iva[indice]						
				end if
			case "base_imponible"
				total_bruto           = total_bruto           + this.object.bruto[indice]
				total_dto_pronto_pago = total_dto_pronto_pago + this.object.dto_pronto_pago[indice]
				total_dto_comercial   = total_dto_comercial   + this.object.dto_comercial[indice]
				total_base_imponible  = total_base_imponible  + dec(data)
				//Controlamos ivas autorepercutidos, que no deben sumarse al total de la fra
				if tipo_iva <> "13" and tipo_iva <> "25" then				
					total_importe_iva     = total_importe_iva     + this.object.importe_iva[indice]						
				end if
			case "importe_iva"
				total_bruto           = total_bruto           + this.object.bruto[indice]
				total_dto_pronto_pago = total_dto_pronto_pago + this.object.dto_pronto_pago[indice]
				total_dto_comercial   = total_dto_comercial   + this.object.dto_comercial[indice]
				total_base_imponible  = total_base_imponible  + this.object.base_imponible[indice]
				//Controlamos ivas autorepercutidos, que no deben sumarse al total de la fra
				if tipo_iva <> "13" and tipo_iva <> "25" then				
					total_importe_iva     = total_importe_iva     + dec(data)
				end if								
		end choose
	else
		total_bruto           = total_bruto           + this.object.bruto[indice]
		total_dto_pronto_pago = total_dto_pronto_pago + this.object.dto_pronto_pago[indice]
		total_dto_comercial   = total_dto_comercial   + this.object.dto_comercial[indice]
		total_base_imponible  = total_base_imponible  + this.object.base_imponible[indice]
		//Controlamos ivas autorepercutidos, que no deben sumarse al total de la fra
		if tipo_iva <> "13" and tipo_iva <> "25" then						
			total_importe_iva     = total_importe_iva     + this.object.importe_iva[indice]
		end if
	end if
next

em_totbruto.text   = String(total_bruto,mascara_moneda)
em_totdtopp.text   = String(total_dto_pronto_pago,mascara_moneda)
em_totdto1.text    = String(total_dto_comercial,mascara_moneda)
em_baseimpon.text  = String(total_base_imponible,mascara_moneda)
em_totiva.text 	 = String(total_importe_iva,mascara_moneda)
em_totfactura.text = String(total_base_imponible + total_importe_iva,mascara_moneda)
end event

type cb_grabar from commandbutton within w_int_facturas_compras
integer x = 7790
integer y = 212
integer width = 384
integer height = 116
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;integer rtn


rtn = dw_detalle.update()
if rtn = -1 then
	rollback using SQLCA;
	messagebox("Error", "No se han grabado las modificaciones en los albaranes")
else
	commit using SQLCA;
end if

dw_agrupa_articulos.retrieve (codigo_empresa, uo_proveedor.em_codigo.text, datetime(em_desde.text), datetime(em_hasta.text))
end event

type dw_agrupa_articulos from datawindow within w_int_facturas_compras
integer x = 5257
integer y = 412
integer width = 3255
integer height = 2616
boolean bringtotop = true
string title = "none"
string dataobject = "dw_int_facturas_compras_agrupa_articulos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;if dwo.name = "p_imprimir" then
	if Printsetup() <> -1 then
		dw_agrupa_articulos.Print()
	end if
end if
end event

type st_4 from statictext within w_int_facturas_compras
integer x = 4741
integer y = 320
integer width = 210
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_facturas_compras
integer x = 4151
integer y = 324
integer width = 206
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_desde from u_em_campo within w_int_facturas_compras
integer x = 4398
integer y = 308
integer width = 297
integer height = 80
integer taborder = 200
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 30593746
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

event modificado;call super::modificado;dw_detalle.reset()

em_fapunte.text = this.text

uo_ejercicio.em_ejercicio.text = string(year(date(this.text)))
end event

type em_hasta from u_em_campo within w_int_facturas_compras
integer x = 4987
integer y = 308
integer width = 297
integer height = 80
integer taborder = 201
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 30593746
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

event modificado;call super::modificado;dw_detalle.reset()

em_fapunte.text = this.text

uo_ejercicio.em_ejercicio.text = string(year(date(this.text)))
end event

