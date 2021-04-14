$PBExportHeader$w_int_impagados.srw
$PBExportComments$€
forward
global type w_int_impagados from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_impagados
end type
type cb_procesar from commandbutton within w_int_impagados
end type
type dw_detalle from datawindow within w_int_impagados
end type
type st_1 from statictext within w_int_impagados
end type
type uo_cliente from u_em_campo_2 within w_int_impagados
end type
type em_asiento from u_em_campo within w_int_impagados
end type
type st_3 from statictext within w_int_impagados
end type
type em_fapunte from u_em_campo within w_int_impagados
end type
type st_4 from statictext within w_int_impagados
end type
type st_11 from statictext within w_int_impagados
end type
type uo_banco from u_em_campo_2 within w_int_impagados
end type
type st_5 from statictext within w_int_impagados
end type
type em_fcobro from u_em_campo within w_int_impagados
end type
type st_6 from statictext within w_int_impagados
end type
type em_divisas from u_em_campo within w_int_impagados
end type
type uo_ejercicio from u_ejercicio within w_int_impagados
end type
type cb_salir from commandbutton within w_int_impagados
end type
type cb_borrar from commandbutton within w_int_impagados
end type
type st_22 from statictext within w_int_impagados
end type
type uo_moneda from u_em_campo_2 within w_int_impagados
end type
type st_moneda from statictext within w_int_impagados
end type
type em_importe from u_em_campo within w_int_impagados
end type
type st_pts from statictext within w_int_impagados
end type
type em_cambio from u_em_campo within w_int_impagados
end type
type st_7 from statictext within w_int_impagados
end type
type em_total from u_em_campo within w_int_impagados
end type
type em_gastos from u_em_campo within w_int_impagados
end type
type st_pts2 from statictext within w_int_impagados
end type
type st_9 from statictext within w_int_impagados
end type
type ln_1 from line within w_int_impagados
end type
type st_pts3 from statictext within w_int_impagados
end type
type st_8 from statictext within w_int_impagados
end type
type dw_selecion from u_datawindow_consultas within w_int_impagados
end type
type gb_cuenta from groupbox within w_int_impagados
end type
type gb_2 from groupbox within w_int_impagados
end type
type gb_1 from groupbox within w_int_impagados
end type
type st_pts4 from statictext within w_int_impagados
end type
type em_correo from u_em_campo within w_int_impagados
end type
type st_66 from statictext within w_int_impagados
end type
type cb_2 from commandbutton within w_int_impagados
end type
type cbx_historico from checkbox within w_int_impagados
end type
type em_cuentadesde from u_em_campo within w_int_impagados
end type
type st_nom1 from statictext within w_int_impagados
end type
end forward

global type w_int_impagados from w_int_con_empresa
integer x = 46
integer y = 16
integer width = 3579
integer height = 2264
pb_1 pb_1
cb_procesar cb_procesar
dw_detalle dw_detalle
st_1 st_1
uo_cliente uo_cliente
em_asiento em_asiento
st_3 st_3
em_fapunte em_fapunte
st_4 st_4
st_11 st_11
uo_banco uo_banco
st_5 st_5
em_fcobro em_fcobro
st_6 st_6
em_divisas em_divisas
uo_ejercicio uo_ejercicio
cb_salir cb_salir
cb_borrar cb_borrar
st_22 st_22
uo_moneda uo_moneda
st_moneda st_moneda
em_importe em_importe
st_pts st_pts
em_cambio em_cambio
st_7 st_7
em_total em_total
em_gastos em_gastos
st_pts2 st_pts2
st_9 st_9
ln_1 ln_1
st_pts3 st_pts3
st_8 st_8
dw_selecion dw_selecion
gb_cuenta gb_cuenta
gb_2 gb_2
gb_1 gb_1
st_pts4 st_pts4
em_correo em_correo
st_66 st_66
cb_2 cb_2
cbx_historico cbx_historico
em_cuentadesde em_cuentadesde
st_nom1 st_nom1
end type
global w_int_impagados w_int_impagados

type variables
date var_fechalimite
STring  conexion = "N",Mesa
end variables

forward prototypes
public subroutine f_control ()
public function boolean f_procesar_recibos (integer i)
public subroutine f_pro ()
public subroutine f_control2 ()
public subroutine f_activar (boolean bo)
public function boolean f_grabar_apunte ()
public function boolean f_grabar_apunte_viejo ()
public subroutine f_carga_efectos_historico ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
string is_filtro=""
dec registros,r,re
dw_detalle.SetTransObject(sqlca)
dw_detalle.SetFilter("")
dw_detalle.Filter()

string f="",fi=""
if tipo_vista="Nacional" then fi="(nacional='S')"
if tipo_vista="Exportacion" then fi="(nacional='N')"
if tipo_vista="Ambos" then fi="((nacional='N') or (nacional='S'))"
f=fi
dw_detalle.SetFilter(f)
dw_detalle.Filter()
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,uo_moneda.em_codigo.text,Dec(em_cambio.text))
if cbx_historico.checked then
	f_carga_efectos_historico()
end if
dw_detalle.sort()
f_control2()


end subroutine

public function boolean f_procesar_recibos (integer i);Int  bien = 0
string agrupado,borrar,historico
Dec    anyo_efecto,orden_efecto,linea_efecto,devpts,linea_historico
Dec    camb,dev,gastos,importe,cambio,correo,importepts,existe
str_carefectos carefectos

camb            = Dec(em_cambio.text)
anyo_efecto     = dw_selecion.GetItemnumber(i,"anyo")
orden_efecto    = dw_selecion.GetItemnumber(i,"orden")
historico       = dw_selecion.GetItemstring(i,"historico")
if historico = "S" then
	linea_historico = dw_selecion.GetItemnumber(i,"linea_historico")
end if
cambio     = Dec(em_cambio.text)
dev        = dw_selecion.GetItemnumber(i,"devuelto_divisas")
devpts     = dw_selecion.GetItemnumber(i,"devuelto")
gastos     = dw_selecion.GetItemnumber(i,"gastos") 
correo     = dw_selecion.GetItemnumber(i,"correo")
importe    = dw_selecion.GetItemnumber(i,"divisas") - dev
importepts = dw_selecion.GetItemnumber(i,"importe") - devpts
	
	
if historico = "N" then
	// Selecciono datos del efecto y los inserto gastos
	  SELECT	carefectos.anyofra,carefectos.factura,carefectos.recibo,
				carefectos.fvto, carefectos.ffra,  
				carefectos.importe,carefectos.divisas,carefectos.monedas,
				carefectos.fpago,carefectos.tipodoc,carefectos.banco,   
				carefectos.remesa,carefectos.fremesa,
				carefectos.agente1,carefectos.pais,carefectos.cuenta,   
				carefectos.domiciliacion,carefectos.Nacional,
				carefectos.observaciones,carefectos.libre,carefectos.gasto,   
				carefectos.fdevolucion,carefectos.agrupado,   
				carefectos.efectoagrupa,carefectos.anyoagrupa,
				carefectos.cliente,carefectos.anyo_remesa ,
				carefectos.comision11,carefectos.comision12,carefectos.comision21,
				carefectos.comision22,carefectos.comision31,carefectos.comision32,
				carefectos.agente2,carefectos.agente3,carefectos.cambio,carefectos.serie
		 INTO :carefectos.anyofra,:carefectos.factura,:carefectos.recibo,   
				:carefectos.fvto,:carefectos.ffra,:carefectos.importe,
				:carefectos.divisas,:carefectos.monedas,:carefectos.fpago,
				:carefectos.tipodoc,:carefectos.banco,:carefectos.remesa,
				:carefectos.fremesa,  
				:carefectos.agente1,:carefectos.pais,:carefectos.cuenta,   
				:carefectos.domiciliacion,:carefectos.nacional,   
				:carefectos.observaciones,:carefectos.libre,:carefectos.gasto,   
				:carefectos.fdevolucion,:carefectos.agrupado,
				:carefectos.efectoagrupa,:carefectos.anyoagrupa,   
				:carefectos.cliente,:carefectos.anyo_remesa,
				:carefectos.comision11,:carefectos.comision12,:carefectos.comision21,
				:carefectos.comision22,:carefectos.comision31,:carefectos.comision32,
				:carefectos.agente2,:carefectos.agente3,:carefectos.cambio,:carefectos.serie
	FROM     carefectos  
	WHERE    carefectos.empresa = :codigo_empresa
	AND      carefectos.anyo    = :anyo_efecto
	AND      carefectos.orden   = :orden_efecto;
	IF SQLCA.SQLCODE <> 0 Then
		bien = 1		
			f_mensaje("Error","Error al seleccionar recibo")
	END IF
	IF importe = 0 Then	
		DELETE   carefectos
		WHERE    carefectos.empresa = :codigo_empresa
		AND      carefectos.anyo    = :anyo_efecto
		AND      carefectos.orden   = :orden_efecto;
		
		IF sqlca.sqlcode <> 0 Then 
			bien = 1
			f_mensaje("Error","Error al borrar recibo")
		END IF
	ELSE 
		UPDATE   carefectos
		Set      carefectos.importe  = :importepts,
					carefectos.divisas  = :importe 
		FROM     carefectos  
		WHERE    carefectos.empresa = :codigo_empresa
		AND      carefectos.anyo    = :anyo_efecto	
		AND      carefectos.orden   = :orden_efecto;
		
		IF sqlca.sqlcode <> 0 Then
			f_mensaje("Error","Error al ,modificar recibo")
			bien = 1
		END IF
	END IF
else
	//Modificamos el efecto en el historico
	  SELECT	carhistorico.anyofra,carhistorico.factura,carhistorico.recibo,
				carhistorico.fvto, carhistorico.ffra,  
				carhistorico.importe,carhistorico.divisas,carhistorico.monedas,
				carhistorico.fpago,carhistorico.tipodoc,
				carhistorico.agente1,carhistorico.pais,carhistorico.cuenta,   
				carhistorico.domiciliacion,carhistorico.Nacional,
				carhistorico.observaciones,carhistorico.libre,carhistorico.gasto,   
				carhistorico.fdevolucion,carhistorico.agrupado,   
				carhistorico.efectoagrupa,carhistorico.anyoagrupa,
				carhistorico.cliente,carhistorico.anyo_remesa ,
				carhistorico.comision11,carhistorico.comision12,carhistorico.comision21,
				carhistorico.comision22,carhistorico.comision31,carhistorico.comision32,
				carhistorico.agente2,carhistorico.agente3,carhistorico.cambio,carhistorico.serie
		 INTO :carefectos.anyofra,:carefectos.factura,:carefectos.recibo,   
				:carefectos.fvto,:carefectos.ffra,:carefectos.importe,
				:carefectos.divisas,:carefectos.monedas,:carefectos.fpago,
				:carefectos.tipodoc,  
				:carefectos.agente1,:carefectos.pais,:carefectos.cuenta,   
				:carefectos.domiciliacion,:carefectos.nacional,   
				:carefectos.observaciones,:carefectos.libre,:carefectos.gasto,   
				:carefectos.fdevolucion,:carefectos.agrupado,
				:carefectos.efectoagrupa,:carefectos.anyoagrupa,   
				:carefectos.cliente,:carefectos.anyo_remesa,
				:carefectos.comision11,:carefectos.comision12,:carefectos.comision21,
				:carefectos.comision22,:carefectos.comision31,:carefectos.comision32,
				:carefectos.agente2,:carefectos.agente3,:carefectos.cambio,:carefectos.serie
	FROM     carhistorico  
	WHERE    carhistorico.empresa = :codigo_empresa
	AND      carhistorico.anyo    = :anyo_efecto
	AND      carhistorico.orden   = :orden_efecto
	and      carhistorico.linea   = :linea_historico;
	IF SQLCA.SQLCODE <> 0 Then
		bien = 1		
			f_mensaje("Error","Error al seleccionar recibo")
	END IF
	IF importe = 0 Then	
		DELETE   carhistorico
		WHERE    carhistorico.empresa = :codigo_empresa
		AND      carhistorico.anyo    = :anyo_efecto
		AND      carhistorico.orden   = :orden_efecto
		and      carhistorico.linea   = :linea_historico;
		
		IF sqlca.sqlcode <> 0 Then 
			bien = 1
			f_mensaje("Error","Borrando Historico")
		END IF
	ELSE 
		UPDATE   carhistorico
		Set      carhistorico.importe = :importepts,
					carhistorico.divisas = :importe 
		WHERE    carhistorico.empresa = :codigo_empresa
		AND      carhistorico.anyo    = :anyo_efecto	
		AND      carhistorico.orden   = :orden_efecto
		and      carhistorico.linea   = :linea_historico;
		IF sqlca.sqlcode <> 0 Then
			f_mensaje("Error","Modificando Historico")
			bien = 1
		END IF
	END IF	
end if

agrupado = 	carefectos.agrupado 
dev = round(dev,2)
IF agrupado = "S" and dev <> carefectos.divisas Then
	Mesa= "Recibo agrupado debe de impagarse por su totalidad"
	bien = 1	
END IF
IF agrupado = "S" or historico = "S" Then	
	select count(*)
	into :existe
	from carefectos
	where empresa = :codigo_empresa
	and anyo      = :anyo_efecto 
	and orden     = :orden_efecto;
	if isnull(existe) then existe = 0
	if existe > 0 then
		carefectos.orden  = f_orden_carparam(codigo_empresa,anyo_efecto)
	else
		carefectos.orden  = orden_efecto
	end if
ELSE
	carefectos.orden  = f_orden_carparam(codigo_empresa,anyo_efecto)
END IF

carefectos.empresa     = codigo_empresa
carefectos.anyo        = anyo_efecto 
carefectos.situacion   = "2"
carefectos.importe     = devpts
carefectos.divisas     = dev
carefectos.gasto       = "N"
carefectos.fdevolucion = datetime(date(em_fcobro.text))
carefectos.devuelto_notificado_agente = "N"

If not f_insert_carefectos(carefectos) then bien=1

carefectos.agrupado    = "N"
carefectos.importe     = gastos + correo
carefectos.divisas     = gastos + correo
carefectos.monedas	  = f_moneda_empresa(codigo_empresa)
carefectos.gasto       = "S"
carefectos.fdevolucion = datetime(date(em_fcobro.text))
carefectos.orden       = f_orden_carparam(codigo_empresa,anyo_efecto)
SetNull(carefectos.banco)
SetNull(carefectos.remesa)
SetNull(carefectos.anyo_remesa)
if carefectos.importe<>0 then
	If not f_insert_carefectos(carefectos) then bien=1
end if

IF Not f_actualizar_carparam(carefectos.empresa,carefectos.anyo,carefectos.orden) Then bien = 1
IF bien = 0 Then
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

public subroutine f_pro ();string v_anyo,v_orden,v_historico,v_seleccion,v_linea_historico
Integer r , r1,e
r1 = dw_detalle.RowCount()
For r = 1 To r1
	IF dw_detalle.GetItemSTring(r,"libre") = "S" Then
		v_anyo      = String(dw_detalle.GetItemNumber(r,"anyo"),"####")
		v_orden     = String(dw_detalle.GetItemNumber(r,"orden"),"#####")
		v_historico = dw_detalle.GetItemString(r,"historico")
		v_linea_historico = String(dw_detalle.GetItemNumber(r,"linea_historico"),"####0")
		v_seleccion =  "anyo = "+v_anyo+&
					  		" and orden = "+v_orden+&
					  		" and historico = '"+v_historico+"'"+&
					  		" and linea_historico = "+v_linea_historico

		e = dw_selecion.find(v_seleccion,1,dw_selecion.RowCount())
      IF e = 0 Then
			e = dw_selecion.RowCOunt() + 1
			dw_selecion.InsertRow(e)
		END IF
		dw_selecion.SetItem(e,"empresa",codigo_empresa)
		dw_selecion.SetItem(e,"anyo",dw_detalle.GetItemNumber(r,"anyo"))
		dw_selecion.SetItem(e,"orden",dw_detalle.GetItemNumber(r,"orden"))
		dw_selecion.SetItem(e,"cliente",dw_detalle.GetItemString(r,"cliente"))
		dw_selecion.SetItem(e,"fra",dw_detalle.GetItemSTring(r,"factura"))
		dw_selecion.SetItem(e,"ffra",dw_detalle.GetItemdateTime(r,"ffra"))
		dw_selecion.SetItem(e,"importe",dw_detalle.GetItemNumber(r,"importe"))
		dw_selecion.SetItem(e,"devuelto",dw_detalle.GetItemNumber(r,"total"))
		dw_selecion.SetItem(e,"correo",dw_detalle.GetItemNumber(r,"correo"))
		dw_selecion.SetItem(e,"gastos",dw_detalle.GetItemNumber(r,"gastos"))
		dw_selecion.SetItem(e,"devuelto_divisas",dw_detalle.GetItemNumber(r,"nuevo"))
		dw_selecion.SetItem(e,"cambio",dw_detalle.GetItemNumber(r,"cambio"))
		dw_selecion.SetItem(e,"divisas",dw_detalle.GetItemNumber(r,"divisas"))
		dw_selecion.SetItem(e,"situacion",dw_detalle.GetItemString(r,"situacion"))
		dw_selecion.SetItem(e,"historico",dw_detalle.GetItemString(r,"historico"))
		dw_selecion.SetItem(e,"linea_historico",dw_detalle.GetItemnumber(r,"linea_historico"))
	END IF
Next
end subroutine

public subroutine f_control2 ();string v_anyo,v_orden,v_historico,v_seleccion,v_linea_historico
Dec registros,r,re
registros = dw_detalle.RowCount()

For r = 1 To registros
	v_anyo      = String(dw_detalle.GetItemNumber(r,"anyo"),"####")
	v_orden     = String(dw_detalle.GetItemNumber(r,"orden"),"#####")
	v_historico = dw_detalle.GetItemString(r,"historico")
	v_linea_historico = String(dw_detalle.GetItemNumber(r,"linea_historico"),"####0")
	v_seleccion =  "anyo = "+v_anyo+&
						" and orden = "+v_orden+&
						" and historico = '"+v_historico+"'"+&
						" and linea_historico = "+v_linea_historico

	re = dw_selecion.find(v_seleccion,1,dw_selecion.RowCount())	
	IF re > 0 Then
	dw_detalle.SetItem(r,"nuevo",dw_selecion.GetItemNumber(re,"devuelto"))
	dw_detalle.SetItem(r,"gastos",dw_selecion.GetItemNumber(re,"gastos"))
	dw_detalle.SetItem(r,"correo",dw_selecion.GetItemNumber(re,"correo"))
	dw_detalle.SetItem(r,"libre","S")
END IF
Next
end subroutine

public subroutine f_activar (boolean bo);em_cambio.enabled = bo
em_divisas.enabled = bo
em_fcobro.enabled = bo
em_gastos.enabled = bo
em_correo.enabled = bo
em_importe.enabled = bo
em_total.enabled = bo
uo_banco.enabled = bo
uo_moneda.enabled = bo
end subroutine

public function boolean f_grabar_apunte ();Integer   bien
Dec acu,i,registros,dif,gastos
String  ampli,cta_gene,facturas
Str_contaapun apu 
apu.empresa   = codigo_empresa
apu.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
apu.fapunte   = Datetime(date(em_fapunte.text))
apu.mes = Month(Date(apu.fapunte))
apu.origen = "2"
bien = 0
ampli = "F."
registros=dw_selecion.rowcount()

apu.asiento     = f_ultimo_asiento(apu.ejercicio,apu.empresa,apu.mes,apu.origen)
em_asiento.text = STring(apu.asiento,f_mascara_decimales(0))
apu.apunte      = 0


apu.moneda = uo_moneda.em_codigo.text
SetNull(apu.fregistro)
SetNull(apu.coste)
SetNull(apu.docpunteo)
SetNull(apu.fvalor)
SetNull(apu.punteado)
SetNull(apu.nif)
SetNull(apu.conciliado)
SetNull(apu.clipro)
SetNull(apu.tipoter)
SetNull(apu.registro)
SetNull(apu.listado)
SetNull(apu.deducible)
SetNull(apu.tipoiva)
SetNull(apu.tipoapu)
SetNull(apu.diario)
SetNull(apu.iva)


acu = 0
facturas = ""
for i=1 to registros
	IF Not f_procesar_recibos(i) Then
		bien= 1
		mesa = mesa + "Error el procesar recibos"
	END IF
	ampli = "IMPAGO FRA "+dw_selecion.GetItemString(i,"fra")+" "+&
				f_RAZON_GENTER(codigo_empresa,"C",uo_cliente.em_codigo.text)
	if facturas = "" then
		facturas = dw_selecion.GetItemString(i,"fra")
	else
		facturas = facturas +","+dw_selecion.GetItemString(i,"fra")
	end if
	// *******************************************************************
	// APUNTE A LA CUENTA DE IMPAGADOS DEL CLIENTE. UN APUNTE POR EFECTO
	// *******************************************************************
	
	apu.apunte  = apu.apunte + 1	
	apu.cambio  = dw_selecion.GetItemNumber(i,"cambio")
	apu.divisas = dw_selecion.GetItemNumber(i,"devuelto_divisas")
	
	IF f_dh_contagene(codigo_empresa,"102")= "D" THEN
		apu.debe = dw_selecion.GetItemNumber(i,"devuelto")
		apu.haber= 0
		acu = acu + apu.debe
	else
		apu.debe = 0
		apu.haber= dw_selecion.GetItemNumber(i,"devuelto")
		acu = acu + apu.haber
	end if
	
	
	apu.concepto   = 	f_concepto_contagene(codigo_empresa,"102")	
	
	apu.ampliacion = ampli
	
	apu.documento  = dw_selecion.GetItemString(i,"fra")
	apu.factura    = dw_selecion.GetItemString(i,"fra")
	
	apu.ffactura   = dw_selecion.GetItemDateTime(i,"ffra")
	
	apu.cuenta     = f_cuenta_impagados_venclientes(codigo_empresa,uo_cliente.em_codigo.text)
	if trim(apu.cuenta) = "" then
		bien = 1
		messagebox("Error","No existe la cuenta de impagados del cliente.")
	end if

	IF Not f_insert_contaapun(apu) Then bien = 1
	
	//No llevan en Baldocer cuentas de riesgo de clientes
/*	if dw_selecion.object.situacion[i] = "5" then
		// *******************************************************************+
		// APUNTE AL RIESGO DE LOS CLIENTES. UN APUNTE POR EFECTO
		//	*******************************************************************+
							
		cta_gene		   =  f_cuenta_contagene(codigo_empresa,"104")
		apu.cuenta		=  f_comp_cta_riesgo(cta_gene,uo_cliente.em_codigo.text)
			
		apu.concepto	=	f_concepto_contagene(codigo_empresa,"104")	
		apu.ampliacion	= ampli
							
		apu.documento  = dw_selecion.GetItemString(i,"fra")
		apu.factura    = dw_selecion.GetItemString(i,"fra")
		apu.ffactura   = dw_selecion.GetItemDateTime(i,"ffra")
		
		apu.origen		=	f_diario_contagene(codigo_empresa,"104")	
		
		IF f_dh_contagene(codigo_empresa,"104")= "D" THEN
			//apu.debe		=	abs(acu)
			apu.debe		=  dw_selecion.GetItemNumber(i,"devuelto")
			apu.haber	=	0
		ELSE
			apu.debe		=	0
			//apu.haber	=	abs(acu)
			apu.haber	=  dw_selecion.GetItemNumber(i,"devuelto")
		END IF	
				
		apu.apunte		=	apu.apunte + 1	
		apu.orden_apunte	=	apu.apunte
				
		IF Not f_insert_contaapun(apu) Then bien = 1
		
		// *******************************************************************+
		//  CANCELACIÓN RIESGO DEL BANCO 
		//	*******************************************************************+
						
		// obtenemos la cuenta de riesgo componiendola
		// con la que se obtiene de la tabla contagene
		// y el código del banco
		
		
		//cta_gene			=	f_cuenta_contagene(codigo_empresa,"103")
		//apu.cuenta		=  f_comp_cta_riesgo(cta_gene,uo_banco.em_codigo.text)
		apu.cuenta		=  f_cta_riesgo_carbancos(codigo_empresa,uo_banco.em_codigo.text)
		apu.concepto	=	f_concepto_contagene(codigo_empresa,"103")	
		apu.ampliacion	=  ampli
																			
		apu.origen		=	f_diario_contagene(codigo_empresa,"103")	
		
		IF f_dh_contagene(codigo_empresa,"103")= "D" THEN
			apu.debe		=	dw_selecion.GetItemNumber(i,"devuelto")
			apu.haber	=	0
		ELSE
			apu.debe		=	0
			apu.haber	=	dw_selecion.GetItemNumber(i,"devuelto")
		END IF	
				
		apu.apunte		  = apu.apunte	+ 1
		apu.orden_apunte = apu.apunte
		
		IF Not f_insert_contaapun(apu) Then bien = 1
				
	end if*/
	
	//********************************************************************
	// APUNTE POR LOS GASTOS. UN APUNTE POR EFECTO
	//********************************************************************
	
	dec{2} v_gastos, v_correo
	if isnull(dw_selecion.GetItemNumber(i,"gastos")  ) then
		v_gastos = 0
	else
		v_gastos = dw_selecion.GetItemNumber(i,"gastos") 
	end if
	if isnull(dw_selecion.GetItemNumber(i,"correo")  ) then
		v_correo = 0
	else
		v_correo = dw_selecion.GetItemNumber(i,"correo") 
	end if

	gastos =	v_gastos+ v_correo
	IF gastos <> 0 Then
		
		apu.concepto   = f_concepto_contagene(codigo_empresa,"101")	
		apu.apunte     = apu.apunte + 1	
		apu.cambio     = Dec(em_cambio.text)
		apu.divisas    = gastos * apu.cambio 
		
		IF f_dh_contagene(codigo_empresa,"101")= "D" THEN
			apu.debe  = gastos
			apu.haber = 0
		else
			apu.debe  = 0
			apu.haber = gastos
		end if
		apu.cuenta = em_cuentadesde.text
		//apu.cuenta = f_cuenta_contagene(codigo_empresa,"101")
		IF Not f_insert_contaapun(apu) Then bien = 1
		
	END IF
	
	f_contador_procesos(i,registros)
Next



//**********************************************************************
//   APUNTE AL BANCO
//**********************************************************************+

apu.apunte      = apu.apunte + 1
apu.imponible   = 0
apu.actualizado = "N"
apu.cambio      = Dec(em_cambio.text)
//apu.divisas     = Dec(em_total.text) / apu.cambio 
apu.divisas     = dw_selecion.GetItemNumber(1,"total") * apu.cambio 

IF f_dh_contagene(codigo_empresa,"100")= "D" THEN
	apu.haber   = 0
//	apu.debe    = abs(Dec(em_total.text))
	apu.debe    = abs(dw_selecion.GetItemNumber(1,"total"))
else
//	apu.haber   = abs(Dec(em_total.text))
	apu.haber   = abs(dw_selecion.GetItemNumber(1,"total"))	
	apu.debe    = 0
end if

apu.concepto   = f_concepto_contagene(codigo_empresa,"100") 
apu.ampliacion = "IMPAGO FRA "+facturas+" "+&
					  f_RAZON_GENTER(codigo_empresa,"C",uo_cliente.em_codigo.text)
apu.documento  = ""
apu.factura    = ""
apu.ffactura   = apu.fapunte 
apu.cuenta     = f_cuenta_carbancos(codigo_empresa,uo_banco.em_codigo.text)


IF Not f_insert_contaapun(apu) Then bien = 1


dif = Dec(em_total.text) - dw_selecion.GetItemNumber(1,"total")
string dh
if dif<>0 then
	
	//Apunte a la cuenta de diferencias de cambio	
	apu.apunte=apu.apunte+1
	apu.cambio=0
	apu.divisas=0
	apu.ampliacion='DIF. DE CAMBIO FRA. '+facturas
	if dif<0 then
		apu.cuenta='66800001'//f_cuenta_contagene(codigo_empresa,'27')
		apu.concepto=f_concepto_contagene(codigo_empresa,'27')
		dh=f_dh_contagene(codigo_empresa,'27')
	else
		apu.cuenta='76800001'//f_cuenta_contagene(codigo_empresa,'26')
		apu.concepto=f_concepto_contagene(codigo_empresa,'26')	
		dh=f_dh_contagene(codigo_empresa,'26')
	end if
	
	if dh='D' then
		apu.haber=0
		apu.debe=abs(dif)
	else
		apu.debe=0
		apu.haber=abs(dif)
	end if	
	if not f_insert_contaapun(apu) then bien=1
	
//Apunte al banco por la diferencia de cambio
	apu.apunte=apu.apunte+1
	apu.cuenta=f_cuenta_carbancos(codigo_empresa,uo_banco.em_codigo.text)
	
	if dh='D' then
		apu.haber=abs(dif)
		apu.debe=0
	else
		apu.debe=abs(dif)
		apu.haber=0
	end if	
	
	if not f_insert_contaapun(apu) then bien=1
	
end if

	
IF bien = 0 Then
	Return True
Else
	Return FALSE
END IF


end function

public function boolean f_grabar_apunte_viejo ();Integer   bien
Dec acu,i,registros,dif,gastos
String  ampli,cta_gene
Str_contaapun apu 
apu.empresa   = codigo_empresa
apu.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
apu.fapunte   = Datetime(date(em_fapunte.text))
apu.mes = Month(Date(apu.fapunte))
apu.origen = "2"
bien = 0
ampli = "F."
registros=dw_selecion.rowcount()

//iF em_asiento.text = "" Then
//	apu.asiento     = f_ultimo_asiento(apu.ejercicio,apu.empresa,apu.mes,apu.origen)
//	em_asiento.text = STring(apu.asiento,f_mascara_decimales(0))
//	apu.apunte      = 0
//ELSE
//	apu.asiento = Dec(em_asiento.text)
//	Select Max(contaapun.apunte) Into :apu.apunte
//	From   contaapun
//	Where  contaapun.ejercicio = :apu.ejercicio
//	And    contaapun.empresa   = :apu.empresa
//	And    contaapun.mes       = :apu.mes
//	And    contaapun.origen    = :apu.origen
//	And    contaapun.asiento   = :apu.asiento;
//END IF



apu.asiento     = f_ultimo_asiento(apu.ejercicio,apu.empresa,apu.mes,apu.origen)
em_asiento.text = STring(apu.asiento,f_mascara_decimales(0))
apu.apunte      = 0


apu.moneda = uo_moneda.em_codigo.text
SetNull(apu.fregistro)
SetNull(apu.coste)
SetNull(apu.docpunteo)
SetNull(apu.fvalor)
SetNull(apu.punteado)
SetNull(apu.nif)
SetNull(apu.conciliado)
SetNull(apu.clipro)
SetNull(apu.tipoter)
SetNull(apu.registro)
SetNull(apu.listado)
SetNull(apu.deducible)
SetNull(apu.tipoiva)
SetNull(apu.tipoapu)
SetNull(apu.diario)
SetNull(apu.iva)


acu = 0
for i=1 to registros
	IF Not f_procesar_recibos(i) Then
		bien= 1
		mesa = mesa + "Error el procesar recibos"
	END IF
	// *******************************************************************
	// APUNTE AL CLIENTE. UN APUNTE POR EFECTO
	// *******************************************************************
	
	apu.apunte = apu.apunte + 1	
	apu.cambio = dw_selecion.GetItemNumber(i,"cambio")
	apu.divisas = dw_selecion.GetItemNumber(i,"devuelto_divisas")
	
	IF f_dh_contagene(codigo_empresa,"102")= "D" THEN
		apu.debe = dw_selecion.GetItemNumber(i,"devuelto")
		apu.haber= 0
		acu = acu + apu.debe
	else
		apu.debe = 0
		apu.haber= dw_selecion.GetItemNumber(i,"devuelto")
		acu = acu + apu.haber
	end if
	
	
	apu.concepto   = 	f_concepto_contagene(codigo_empresa,"102")	
	
	apu.ampliacion = f_ampliacion_contagene(codigo_empresa,"102")+ &
						" Fecha: "+ String(Date(em_fcobro.text),"dd-mm-yy") + &
						" " + f_nombre_banco_abr(codigo_empresa,uo_banco.em_codigo.text)
	
	apu.documento  = dw_selecion.GetItemString(i,"fra")
	apu.factura    = dw_selecion.GetItemString(i,"fra")
	ampli = ampli + "-" + apu.factura
	apu.ffactura = dw_selecion.GetItemDateTime(i,"ffra")
	
	apu.cuenta = f_cuenta_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)


	IF Not f_insert_contaapun(apu) Then bien = 1
	
	// *******************************************************************+
	// APUNTE AL RIESGO DE LOS CLIENTES. UN APUNTE POR EFECTO
	//	*******************************************************************+
						
	cta_gene		   =  f_cuenta_contagene(codigo_empresa,"104")
	apu.cuenta		=  f_comp_cta_riesgo(cta_gene,uo_cliente.em_codigo.text)
		
	apu.concepto	=	f_concepto_contagene(codigo_empresa,"104")	
	apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"104") + &
						" Fecha: "+ String(Date(em_fcobro.text),"dd-mm-yy") + &
						" " +f_nombre_banco_abr(codigo_empresa,uo_banco.em_codigo.text)
		
			
	apu.documento  = dw_selecion.GetItemString(i,"fra")
	apu.factura    = dw_selecion.GetItemString(i,"fra")
	apu.ffactura   = dw_selecion.GetItemDateTime(i,"ffra")
	
	apu.origen		=	f_diario_contagene(codigo_empresa,"104")	
	
	IF f_dh_contagene(codigo_empresa,"104")= "D" THEN
		//apu.debe		=	abs(acu)
		apu.debe		=  dw_selecion.GetItemNumber(i,"devuelto")
		apu.haber	=	0
	ELSE
		apu.debe		=	0
		//apu.haber	=	abs(acu)
		apu.haber	=  dw_selecion.GetItemNumber(i,"devuelto")
	END IF	
	
	
	apu.apunte		=	apu.apunte + 1	
	apu.orden_apunte	=	apu.apunte
	
	
	IF Not f_insert_contaapun(apu) Then bien = 1
	
	//********************************************************************
	// APUNTE POR LOS GASTOS. UN APUNTE POR EFECTO
	//********************************************************************
	
	gastos =	dw_selecion.GetItemNumber(i,"gastos") + dw_selecion.GetItemNumber(i,"correo")
	IF gastos <> 0 Then
		
		apu.concepto   = f_concepto_contagene(codigo_empresa,"101")	
		apu.apunte = apu.apunte + 1	
		apu.cambio = Dec(em_cambio.text)
		apu.divisas = gastos / apu.cambio 
		
		IF f_dh_contagene(codigo_empresa,"101")= "D" THEN
			apu.debe = gastos
			apu.haber= 0
		else
			apu.debe = 0
			apu.haber= gastos
		end if
		
		apu.cuenta = f_cuenta_contagene(codigo_empresa,"101")
		IF Not f_insert_contaapun(apu) Then bien = 1
		
	END IF
	
	f_contador_procesos(i,registros)
Next



//**********************************************************************
//   APUNTE AL BANCO
//**********************************************************************+

apu.apunte = apu.apunte + 1
apu.imponible = 0
apu.actualizado = "N"
apu.cambio  = Dec(em_cambio.text)
apu.divisas = Dec(em_total.text) / apu.cambio 

IF f_dh_contagene(codigo_empresa,"100")= "D" THEN
	apu.haber   = 0
	apu.debe    = abs(Dec(em_total.text))
else
	apu.haber   = abs(Dec(em_total.text))
	apu.debe    = 0
end if

apu.concepto = f_concepto_contagene(codigo_empresa,"100") 
apu.ampliacion= f_ampliacion_contagene(codigo_empresa,"100")+ &
					" Fecha: "+ String(Date(em_fcobro.text),"dd-mm-yy") + &
					" " +f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
apu.documento= ""
apu.factura  = ""
apu.ffactura = apu.fapunte 
apu.cuenta = f_cuenta_carbancos(codigo_empresa,uo_banco.em_codigo.text)


IF Not f_insert_contaapun(apu) Then bien = 1


// *******************************************************************+
//  CANCELACIÓN RIESGO DEL BANCO 
//	*******************************************************************+
				
// obtenemos la cuenta de riesgo componiendola
// con la que se obtiene de la tabla contagene
// y el código del banco


//cta_gene			=	f_cuenta_contagene(codigo_empresa,"103")
//apu.cuenta		=  f_comp_cta_riesgo(cta_gene,uo_banco.em_codigo.text)
apu.cuenta		=  f_cta_riesgo_carbancos(codigo_empresa,uo_banco.em_codigo.text)
apu.concepto	=	f_concepto_contagene(codigo_empresa,"103")	
apu.ampliacion	=  f_ampliacion_contagene(codigo_empresa,"103")+&
					" Fecha: "+ String(Date(em_fcobro.text),"dd-mm-yy") + &
					" " +f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
									
setnull(apu.documento )


				
apu.ffactura	=  apu.fapunte
apu.origen		=	f_diario_contagene(codigo_empresa,"103")	

IF f_dh_contagene(codigo_empresa,"103")= "D" THEN
	apu.debe		=	abs(acu)
	apu.haber	=	0
ELSE
	apu.debe		=	0
	apu.haber	=	abs(acu)
END IF	


apu.apunte		=	apu.apunte	 + 1
apu.orden_apunte	=	apu.apunte

IF Not f_insert_contaapun(apu) Then bien = 1
	
IF bien = 0 Then
	Return True
Else
	Return FALSE
END IF


end function

public subroutine f_carga_efectos_historico ();string   sel,fra,situacion,filtro_vista
datetime ffra,fvto
long     indice,total,anyo,orden,donde,recibo,linea
dec      importe,cambio,divisas

datastore historico

if tipo_vista="Nacional" then 
	filtro_vista = "and nacional='S'"
else
	if tipo_vista="Exportacion" then 
		filtro_vista = "and nacional='N'"
	else
		if tipo_vista="Ambos" then 
			filtro_vista = "and (nacional='N' or nacional='S')"
		else
			filtro_vista = ""
		end if
	end if
end if

sel = "select anyo,orden,factura,ffra,importe,cambio,divisas,"+&
		"situacion,fvto,recibo,linea "+&
		"from carhistorico "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and cliente = '"+uo_cliente.em_codigo.text+"' "+&
		"and monedas = '"+uo_moneda.em_codigo.text+"' "+&
		filtro_vista
		
//historico = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, historico)
total = historico.rowcount()

for indice = 1 to total
	anyo      = historico.object.anyo[indice]
	orden     = historico.object.orden[indice]
	linea     = historico.object.linea[indice]
	fra       = historico.object.factura[indice]
	ffra      = historico.object.ffra[indice]
	importe   = historico.object.importe[indice]
	cambio    = historico.object.cambio[indice]
	divisas   = historico.object.divisas[indice]
	situacion = historico.object.situacion[indice]
	fvto      = historico.object.fvto[indice]
	recibo    = historico.object.recibo[indice]
	
	donde     = dw_detalle.insertrow(0)
	dw_detalle.object.anyo[donde]            = anyo
	dw_detalle.object.orden[donde]           = orden
	dw_detalle.object.linea_historico[donde] = linea
	dw_detalle.object.factura[donde]         = fra
	dw_detalle.object.ffra[donde]            = ffra
	dw_detalle.object.importe[donde]         = importe
	dw_detalle.object.cambio[donde]          = cambio
	dw_detalle.object.divisas[donde]         = divisas
	dw_detalle.object.nuevo[donde]           = divisas
	dw_detalle.object.situacion[donde]       = situacion
	dw_detalle.object.monedas[donde]         = uo_moneda.em_codigo.text
	dw_detalle.object.fvto[donde]            = fvto
	dw_detalle.object.recibo[donde]          = recibo
	dw_detalle.object.historico[donde]       = "S"
next

destroy historico
end subroutine

event close;call super::close;//dw_detalle.reset()
//dw_listado.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Introducción Impagados"
This.title=istr_parametros.s_titulo_ventana
 // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
		conexion= "S"
		f_posicion_inicio(this)
    END IF
//uo_moneda.em_codigo.text = f_peseta()
uo_moneda.em_codigo.text = "7"

uo_moneda.TriggerEvent("modificado")
em_fcobro.text = String(Today(),"dd-mm-yy")
em_fapunte.text = String(Today(),"dd-mm-yy")
dw_detalle.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"nuevo",f_mascara_moneda(uo_moneda.em_codigo.text))
f_mascara_columna(dw_detalle,"correo",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"gastos",f_mascara_decimales(2))
f_activar_campo(em_fapunte)

end event

event ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//dw_report.Retrieve(codigo_empresa,dec(em_anyo.text),em_banco.text,dec(em_remesa.text))
////IF TRIM(filtro)<>"" THEN
//// dw_report.SetFilter(filtro)
//// dw_report.Filter()
////END IF
//CALL Super::ue_listar
end event

on w_int_impagados.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_procesar=create cb_procesar
this.dw_detalle=create dw_detalle
this.st_1=create st_1
this.uo_cliente=create uo_cliente
this.em_asiento=create em_asiento
this.st_3=create st_3
this.em_fapunte=create em_fapunte
this.st_4=create st_4
this.st_11=create st_11
this.uo_banco=create uo_banco
this.st_5=create st_5
this.em_fcobro=create em_fcobro
this.st_6=create st_6
this.em_divisas=create em_divisas
this.uo_ejercicio=create uo_ejercicio
this.cb_salir=create cb_salir
this.cb_borrar=create cb_borrar
this.st_22=create st_22
this.uo_moneda=create uo_moneda
this.st_moneda=create st_moneda
this.em_importe=create em_importe
this.st_pts=create st_pts
this.em_cambio=create em_cambio
this.st_7=create st_7
this.em_total=create em_total
this.em_gastos=create em_gastos
this.st_pts2=create st_pts2
this.st_9=create st_9
this.ln_1=create ln_1
this.st_pts3=create st_pts3
this.st_8=create st_8
this.dw_selecion=create dw_selecion
this.gb_cuenta=create gb_cuenta
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_pts4=create st_pts4
this.em_correo=create em_correo
this.st_66=create st_66
this.cb_2=create cb_2
this.cbx_historico=create cbx_historico
this.em_cuentadesde=create em_cuentadesde
this.st_nom1=create st_nom1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.uo_cliente
this.Control[iCurrent+6]=this.em_asiento
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.em_fapunte
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_11
this.Control[iCurrent+11]=this.uo_banco
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.em_fcobro
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.em_divisas
this.Control[iCurrent+16]=this.uo_ejercicio
this.Control[iCurrent+17]=this.cb_salir
this.Control[iCurrent+18]=this.cb_borrar
this.Control[iCurrent+19]=this.st_22
this.Control[iCurrent+20]=this.uo_moneda
this.Control[iCurrent+21]=this.st_moneda
this.Control[iCurrent+22]=this.em_importe
this.Control[iCurrent+23]=this.st_pts
this.Control[iCurrent+24]=this.em_cambio
this.Control[iCurrent+25]=this.st_7
this.Control[iCurrent+26]=this.em_total
this.Control[iCurrent+27]=this.em_gastos
this.Control[iCurrent+28]=this.st_pts2
this.Control[iCurrent+29]=this.st_9
this.Control[iCurrent+30]=this.ln_1
this.Control[iCurrent+31]=this.st_pts3
this.Control[iCurrent+32]=this.st_8
this.Control[iCurrent+33]=this.dw_selecion
this.Control[iCurrent+34]=this.gb_cuenta
this.Control[iCurrent+35]=this.gb_2
this.Control[iCurrent+36]=this.gb_1
this.Control[iCurrent+37]=this.st_pts4
this.Control[iCurrent+38]=this.em_correo
this.Control[iCurrent+39]=this.st_66
this.Control[iCurrent+40]=this.cb_2
this.Control[iCurrent+41]=this.cbx_historico
this.Control[iCurrent+42]=this.em_cuentadesde
this.Control[iCurrent+43]=this.st_nom1
end on

on w_int_impagados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_procesar)
destroy(this.dw_detalle)
destroy(this.st_1)
destroy(this.uo_cliente)
destroy(this.em_asiento)
destroy(this.st_3)
destroy(this.em_fapunte)
destroy(this.st_4)
destroy(this.st_11)
destroy(this.uo_banco)
destroy(this.st_5)
destroy(this.em_fcobro)
destroy(this.st_6)
destroy(this.em_divisas)
destroy(this.uo_ejercicio)
destroy(this.cb_salir)
destroy(this.cb_borrar)
destroy(this.st_22)
destroy(this.uo_moneda)
destroy(this.st_moneda)
destroy(this.em_importe)
destroy(this.st_pts)
destroy(this.em_cambio)
destroy(this.st_7)
destroy(this.em_total)
destroy(this.em_gastos)
destroy(this.st_pts2)
destroy(this.st_9)
destroy(this.ln_1)
destroy(this.st_pts3)
destroy(this.st_8)
destroy(this.dw_selecion)
destroy(this.gb_cuenta)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_pts4)
destroy(this.em_correo)
destroy(this.st_66)
destroy(this.cb_2)
destroy(this.cbx_historico)
destroy(this.em_cuentadesde)
destroy(this.st_nom1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_impagados
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_impagados
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_impagados
integer x = 5
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_int_impagados
integer x = 2734
integer width = 114
integer height = 96
integer taborder = 0
end type

event clicked;If conexion = "N" Then
	Close (Parent)
Else
	CloseWithReturn(Parent,em_asiento.text)
End If
end event

type cb_procesar from commandbutton within w_int_impagados
event clicked pbm_bnclicked
integer x = 2313
integer y = 1956
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -6
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "\BMP\Mano.cur"
string text = "&Procesar"
end type

event clicked;//if dec(em_gastos.text) <> 0 or dec(em_correo.text) <> 0 then
//	messagebox("Aviso",nombre_usuario+" :Deberá introducir la cuenta de gastos")
//	return
//end if

long registros
mesa = ""
integer i,bien
Dec  dif,acu
bien=0
dif = 0
dw_selecion.AcceptText()
registros=dw_selecion.rowcount()
iF registros = 0 Then Return


IF dw_selecion.GetItemNumber(1,"total") <> Dec(em_total.text) Then
	if messagebox("Error en Introduccion de datos","Los totales no coinciden"+char(13)+char(13)+"¿Es diferencia de cambio?",question!,YesNO!,1)<>1 then
     f_activar_campo(uo_cliente.em_campo)
     Return
   End if
END IF
IF Dec(em_cambio.text) = 1 Then
		IF dw_selecion.GetItemNumber(1,"total_cancelacion") <> Dec(em_importe.text) Then
		   if messagebox("Error en Introduccion de datos","Los totales no coinciden"+char(13)+char(13)+"¿Es diferencia de cambio?",question!,YesNO!,1)<>1 then
		     f_activar_campo(uo_cliente.em_campo)
		     Return
		   End if
   	END IF
END IF
IF Not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),DateTime(date(em_fapunte.text))) Then 
	f_activar_campo(em_fapunte)
	Return
END IF

IF Not f_grabar_apunte() Then 
	bien = 1
	Mesa = mesa + "Error en apuntes"
END IF

If bien <> 0  Then
	RollBack;
	f_mensaje("Error en proceso",mesa + "El proceso no se actualiza(" +sqlca.sqlerrtext+")")
ELSE
	Commit;

END IF
cb_salir.triggerEvent(Clicked!)


end event

type dw_detalle from datawindow within w_int_impagados
integer x = 201
integer y = 508
integer width = 3063
integer height = 876
string dataobject = "dw_int_impagados"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;string v_anyo,v_orden,v_historico,v_seleccion,v_linea_historico

This.AcceptText()
Dec e,r
IF f_objeto_datawindow(dw_detalle) = "ok" Then f_pro()
IF row <> 0 Then
	r = row
IF f_objeto_datawindow(dw_detalle) = "libre" Then	
IF dw_detalle.GetItemString(row,"libre") = "S" Then
	dw_detalle.SetItem(row,"libre","N")
	v_anyo      = String(dw_detalle.GetItemNumber(row,"anyo"),"####")
	v_orden     = String(dw_detalle.GetItemNumber(row,"orden"),"#####")
	v_historico = dw_detalle.GetItemString(row,"historico")	
	v_linea_historico = String(dw_detalle.GetItemNumber(row,"linea_historico"),"####0")
	v_seleccion = "anyo = "+v_anyo+&
					  " and orden = "+v_orden+&
					  " and historico = '"+v_historico+"'"+&
					  " and linea_historico = "+v_linea_historico
	e = dw_selecion.find(v_seleccion,1,dw_selecion.RowCount())

	IF e <> 0 Then
		dw_selecion.DeleteRow(e)
	END IF
ELSE
	dw_detalle.SetItem(row,"libre","S") 
	dw_detalle.SetFocus()
	dw_detalle.SetRow(row)
	dw_detalle.SetColumn("nuevo")
END IF
END IF
f_pro()
END IF
end event

event itemfocuschanged;This.AcceptText()
f_pro()
end event

event itemchanged;This.AcceptText()
f_pro()
end event

type st_1 from statictext within w_int_impagados
integer x = 14
integer y = 348
integer width = 1129
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "C  l  i  e  n  t  e"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_int_impagados
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 14
integer y = 416
integer width = 1147
integer height = 76
integer taborder = 110
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,'C',uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
dw_detalle.Reset()


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Cliente"
ue_datawindow ="dw_ayuda_clientes"

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type em_asiento from u_em_campo within w_int_impagados
integer x = 3154
integer y = 196
integer width = 293
integer height = 76
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
end type

type st_3 from statictext within w_int_impagados
integer x = 2866
integer y = 196
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long backcolor = 12632256
string text = "Asiento:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;em_asiento.text = ""
end event

type em_fapunte from u_em_campo within w_int_impagados
integer x = 3154
integer y = 112
integer width = 293
integer height = 76
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_4 from statictext within w_int_impagados
integer x = 2857
integer y = 116
integer width = 288
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
boolean enabled = false
string text = "F.Apunte:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within w_int_impagados
integer x = 32
integer y = 100
integer width = 187
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Banco:"
boolean focusrectangle = false
end type

type uo_banco from u_em_campo_2 within w_int_impagados
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 224
integer y = 96
integer width = 1307
integer height = 76
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_banco.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco.em_codigo.text)
If Trim(uo_banco.em_campo.text)="" then
	uo_banco.em_campo.text=""
	uo_banco.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Banco"
ue_datawindow ="dw_ayuda_carbancos"

end event

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type st_5 from statictext within w_int_impagados
integer x = 1554
integer y = 100
integer width = 224
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
boolean enabled = false
string text = "F.Dev:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fcobro from u_em_campo within w_int_impagados
integer x = 1778
integer y = 96
integer width = 288
integer height = 76
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event modificado;call super::modificado;em_fapunte.text = text
end event

type st_6 from statictext within w_int_impagados
integer x = 795
integer y = 180
integer width = 224
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
boolean enabled = false
string text = "Divisas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_divisas from u_em_campo within w_int_impagados
integer x = 1006
integer y = 176
integer width = 366
integer height = 76
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.##"
end type

event modificado;call super::modificado;em_importe.text = String(dec(em_importe.text),f_mascara_moneda(uo_moneda.em_codigo.text))
if Dec(em_cambio.text) <> 0 then
	em_importe.text = String(Dec(em_divisas.text) / Dec(em_cambio.text),f_mascara_decimales(2))
end if
em_importe.TriggerEvent("modificado")
em_gastos.TriggerEvent("modificado")
end event

type uo_ejercicio from u_ejercicio within w_int_impagados
integer x = 2199
integer y = 108
integer height = 176
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type cb_salir from commandbutton within w_int_impagados
event clicked pbm_bnclicked
integer x = 2944
integer y = 1956
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "\BMP\Mano.cur"
string text = "&Salir"
end type

event clicked;dw_detalle.Reset()
dw_selecion.Reset()
f_activar(TRUE)
em_cambio.text = ""
em_divisas.text = ""
em_gastos.text = ""
em_importe.text = ""
em_total.text = ""
em_correo.text = ""
uo_banco.em_campo.text = ""
uo_cliente.em_campo.text = ""
uo_moneda.em_campo.text = ""
uo_banco.em_codigo.text = ""
uo_cliente.em_codigo.text = ""
uo_moneda.em_codigo.text = ""
f_activar_campo(uo_banco.em_campo)
end event

type cb_borrar from commandbutton within w_int_impagados
event clicked pbm_bnclicked
integer x = 2629
integer y = 1956
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "\BMP\Mano.cur"
string text = "&Borrar"
end type

event clicked;IF dw_selecion.GetRow() = 0 Then Return
	dw_selecion.DeleteRow(dw_selecion.GetRow())
f_control2()
end event

type st_22 from statictext within w_int_impagados
integer y = 176
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Moneda:"
boolean focusrectangle = false
end type

type uo_moneda from u_em_campo_2 within w_int_impagados
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 224
integer y = 176
integer width = 219
integer height = 76
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_moneda.em_campo.text=f_nombre_moneda_abr(uo_moneda.em_codigo.text)
st_moneda.text=f_nombre_moneda_abr(uo_moneda.em_codigo.text)
em_cambio.text = string(f_cambio_moneda(uo_moneda.em_codigo.text))
em_divisas.TriggerEvent("modificado")
em_importe.TriggerEvent("modificado")
em_gastos.TriggerEvent("modificado")

If Trim(uo_moneda.em_campo.text)="" then
	uo_moneda.em_campo.text=""
	uo_moneda.em_codigo.text=""
	Return
end if 

f_mascara_columna(dw_detalle,"nuevo",f_mascara_moneda(uo_moneda.em_codigo.text))

end event

event getfocus;call super::getfocus;ue_titulo     = "Selección de Monedas"
ue_datawindow = "dw_ayuda_divisas"
valor_empresa = False
end event

on uo_moneda.destroy
call u_em_campo_2::destroy
end on

type st_moneda from statictext within w_int_impagados
integer x = 1381
integer y = 176
integer width = 242
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
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_importe from u_em_campo within w_int_impagados
integer x = 1646
integer y = 176
integer width = 421
integer height = 76
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;em_gastos.TriggerEvent("modificado")
end event

type st_pts from statictext within w_int_impagados
integer x = 2071
integer y = 184
integer width = 87
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "€"
boolean focusrectangle = false
end type

type em_cambio from u_em_campo within w_int_impagados
integer x = 489
integer y = 176
integer width = 288
integer height = 76
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.0000"
end type

event modificado;call super::modificado;em_divisas.TriggerEvent("modificado")
em_importe.TriggerEvent("modificado")
em_gastos.TriggerEvent("modificado")
end event

type st_7 from statictext within w_int_impagados
integer x = 1298
integer y = 264
integer width = 338
integer height = 60
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
string text = "Total Gtos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_total from u_em_campo within w_int_impagados
integer x = 1646
integer y = 416
integer width = 421
integer height = 76
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = styleraised!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

type em_gastos from u_em_campo within w_int_impagados
integer x = 1646
integer y = 256
integer width = 421
integer height = 76
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;em_correo.TriggerEvent("modificado")

end event

type st_pts2 from statictext within w_int_impagados
integer x = 2071
integer y = 264
integer width = 87
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "€"
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_impagados
integer x = 1454
integer y = 424
integer width = 183
integer height = 60
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
string text = "Total:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ln_1 from line within w_int_impagados
long linecolor = 33554432
integer linethickness = 8
integer beginx = 1646
integer beginy = 404
integer endx = 2066
integer endy = 404
end type

type st_pts3 from statictext within w_int_impagados
integer x = 2071
integer y = 424
integer width = 87
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "€"
boolean focusrectangle = false
end type

type st_8 from statictext within w_int_impagados
integer x = 434
integer y = 180
integer width = 46
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_selecion from u_datawindow_consultas within w_int_impagados
integer x = 206
integer y = 1396
integer width = 3063
integer height = 540
integer taborder = 0
string dataobject = "dw_int_impagados2"
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type gb_cuenta from groupbox within w_int_impagados
integer x = 2167
integer y = 320
integer width = 1303
integer height = 180
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cuenta Gastos"
end type

type gb_2 from groupbox within w_int_impagados
integer x = 2162
integer y = 64
integer width = 1303
integer height = 248
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_int_impagados
integer x = 2299
integer y = 1920
integer width = 969
integer height = 112
integer textsize = -6
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_pts4 from statictext within w_int_impagados
integer x = 2071
integer y = 344
integer width = 87
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "€"
boolean focusrectangle = false
end type

type em_correo from u_em_campo within w_int_impagados
event modificado pbm_custom02
integer x = 1646
integer y = 336
integer width = 421
integer height = 76
integer taborder = 100
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;em_total.text = String(Dec(em_importe.text) + Dec(em_gastos.text) + Dec(em_correo.text),f_mascara_decimales(2))
end event

type st_66 from statictext within w_int_impagados
integer x = 1403
integer y = 348
integer width = 233
integer height = 52
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
string text = "Correo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_int_impagados
integer x = 1166
integer y = 416
integer width = 283
integer height = 76
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;
f_activar_campo(uo_cliente.em_campo)
f_activar(FALSE)
f_control()

end event

type cbx_historico from checkbox within w_int_impagados
integer x = 14
integer y = 276
integer width = 1152
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Incluir efectos del historico en la selección"
boolean lefttext = true
end type

type em_cuentadesde from u_em_campo within w_int_impagados
integer x = 2190
integer y = 388
integer width = 416
integer taborder = 20
boolean bringtotop = true
alignment alignment = right!
string mask = "!!!!!!!!!!"
end type

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_contaplan_directo"
ue_filtro = ""
//ue_filtro     = "contaplan_ejercicio = "+string(uo_ejercicio.em_ejercicio.text,"####")+" "
end event

event modificado;call super::modificado;
st_nom1.text=f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,em_cuentadesde.text)

end event

type st_nom1 from statictext within w_int_impagados
integer x = 2619
integer y = 388
integer width = 823
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

