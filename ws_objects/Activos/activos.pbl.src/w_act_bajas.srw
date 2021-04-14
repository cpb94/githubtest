$PBExportHeader$w_act_bajas.srw
forward
global type w_act_bajas from w_int_con_empresa
end type
type st_1 from statictext within w_act_bajas
end type
type uo_ejercicio from u_ejercicio within w_act_bajas
end type
type em_elemento from u_em_campo within w_act_bajas
end type
type st_2 from statictext within w_act_bajas
end type
type em_importe from u_em_campo within w_act_bajas
end type
type st_3 from statictext within w_act_bajas
end type
type em_prov from u_em_campo within w_act_bajas
end type
type st_4 from statictext within w_act_bajas
end type
type em_fcompra from u_em_campo within w_act_bajas
end type
type st_elemento from statictext within w_act_bajas
end type
type em_acum from u_em_campo within w_act_bajas
end type
type st_6 from statictext within w_act_bajas
end type
type em_base from u_em_campo within w_act_bajas
end type
type st_7 from statictext within w_act_bajas
end type
type st_prov from statictext within w_act_bajas
end type
type cb_proceso from u_boton within w_act_bajas
end type
type st_13 from statictext within w_act_bajas
end type
type em_fbaja from u_em_campo within w_act_bajas
end type
type st_14 from statictext within w_act_bajas
end type
type em_obs from u_em_campo within w_act_bajas
end type
type st_15 from statictext within w_act_bajas
end type
type em_bbase from u_em_campo within w_act_bajas
end type
type st_22 from statictext within w_act_bajas
end type
type em_fasiento from u_em_campo within w_act_bajas
end type
type cb_1 from u_boton within w_act_bajas
end type
type st_24 from statictext within w_act_bajas
end type
type em_cliente from u_em_campo within w_act_bajas
end type
type st_cliente from statictext within w_act_bajas
end type
type ddlb_causa from dropdownlistbox within w_act_bajas
end type
type st_5 from statictext within w_act_bajas
end type
type bajas from structure within w_act_bajas
end type
type bienesdet from structure within w_act_bajas
end type
end forward

type bajas from structure
	string		empresa
	decimal { 2 }		elemento
	integer		orden
	decimal { 2 }		ibajabase
	decimal { 2 }		ibajaamor
	datetime		fechaba
	decimal { 2 }		ibajaresto
	string		observacionesba
end type

type bienesdet from structure
	string		empresa
	decimal { 2 }		elemento
	decimal { 2 }		amor_acumulada
	decimal { 2 }		importe
	datetime		fechabaja
	decimal { 2 }		bajas
end type

global type w_act_bajas from w_int_con_empresa
integer x = 27
integer y = 320
integer width = 2871
integer height = 1440
st_1 st_1
uo_ejercicio uo_ejercicio
em_elemento em_elemento
st_2 st_2
em_importe em_importe
st_3 st_3
em_prov em_prov
st_4 st_4
em_fcompra em_fcompra
st_elemento st_elemento
em_acum em_acum
st_6 st_6
em_base em_base
st_7 st_7
st_prov st_prov
cb_proceso cb_proceso
st_13 st_13
em_fbaja em_fbaja
st_14 st_14
em_obs em_obs
st_15 st_15
em_bbase em_bbase
st_22 st_22
em_fasiento em_fasiento
cb_1 cb_1
st_24 st_24
em_cliente em_cliente
st_cliente st_cliente
ddlb_causa ddlb_causa
st_5 st_5
end type
global w_act_bajas w_act_bajas

type variables
Integer		orden
DataStore	ds_a1 //,ds_a2,ds_elemento
end variables

forward prototypes
public subroutine f_rellenoapunte (ref str_contaapun apu)
public subroutine f_proceso ()
end prototypes

public subroutine f_rellenoapunte (ref str_contaapun apu);String	c1,c2
Boolean	res
Dec		elemento

// Valores comunes a todos los apuntes de todos los asientos
apu.ejercicio  = Dec(uo_ejercicio.em_ejercicio.text)
apu.empresa    = codigo_empresa
apu.mes    = Month(Date(em_fasiento.text))
apu.asiento    = f_ultimo_asiento(apu.ejercicio,apu.empresa,apu.mes,apu.origen)
apu.fapunte    = DateTime(Date(em_fasiento.text))
apu.fvalor		= apu.fapunte

SetNUll(apu.diario)
SetNUll(apu.tipoapu)
SetNUll(apu.documento)
SetNUll(apu.factura)
SetNUll(apu.ffactura)
SetNUll(apu.imponible)
SetNUll(apu.tipoiva)
SetNull(apu.iva)
SetNull(apu.divisas)
SetNull(apu.deducible)
SetNull(apu.actualizado)
SetNull(apu.listado)
SetNull(apu.registro)
SetNull(apu.tipoter)
SetNull(apu.clipro)
SetNull(apu.conciliado)
SetNull(apu.nif)
SetNull(apu.punteado)
SetNull(apu.docpunteo)
SetNull(apu.coste)
SetNull(apu.fregistro)

apu.cambio = 1
apu.moneda = f_paramemp_moneda_emp(codigo_empresa)

elemento = Dec(em_elemento.text)


apu.orden_apunte = 0

end subroutine

public subroutine f_proceso ();String	cuenta_abono,cuenta_activo,descripcion,codigo
Dec	valor,valor2,n1,n2
Dec	b1ibajabase,b1ibajaamor//,b2ibajabase,b2ibajaamor
String	cad,cad2,c1
bajas		ba,b1//,b2
bienesdet	a1//,a2
DateTime	fecha,fecha2
Str_contaapun	apu
Dec	acudebe,acuhaber,importeresto,d1,contador,venta
Boolean bien
Str_parametros	param,param_rec
integer	resp
BOOLEAN material

bien = True
material = True

b1.ibajabase=0
b1.ibajaamor=0
b1ibajabase=0
b1ibajaamor=0
//b2.ibajabase=0
//b2.ibajaamor=0
//b2ibajabase=0
//b2ibajaamor=0
a1.empresa 	= trim(ds_a1.GetItemString(1,"empresa"))
a1.elemento = ds_a1.GetItemDecimal(1,"elemento")
a1.importe	= ds_a1.GetItemDecimal(1,"importe")
a1.amor_acumulada = ds_a1.GetItemDecimal(1,"amor_acumulada")
If isnull(a1.amor_acumulada) then a1.amor_acumulada = 0
a1.fechabaja = ds_a1.GetItemDateTime(1,"fechabaja")
a1.bajas = ds_a1.GetItemDecimal(1,"bajas")
If isnull(a1.bajas) then a1.bajas = 0
/*If ds_a2.RowCount()>0 then
	a2.empresa  = trim(ds_a2.GetItemString(1,"empresa"))
	a2.elemento = ds_a2.GetItemDecimal(1,"elemento")
	a2.importe	= ds_a2.GetItemDecimal(1,"importe")
	a2.amor_acumulada = ds_a2.GetItemDecimal(1,"amor_acumulada")
	a2.fechabaja = ds_a2.GetItemDateTime(1,"fechabaja")
	a2.bajas = ds_a2.GetItemDecimal(1,"bajas")	
Else
	setnull(a2.empresa)
End If */
  
SELECT sum(ibajabase),sum(ibajaamor)
INTO :b1.ibajabase,:b1.ibajaamor
FROM act_bajas  
WHERE ( act_bajas.empresa = :a1.empresa ) AND  
         ( act_bajas.elemento = :a1.elemento ) ;
			
If isnull(b1.ibajabase) then b1.ibajabase = 0
If isnull(b1.ibajaamor) then b1.ibajaamor = 0

/*If not isnull(a2.empresa) then
	  SELECT sum(ibajabase),sum(ibajaamor)
		 INTO :b2.ibajabase,:b2.ibajaamor
		 FROM act_bajas  
		WHERE ( act_bajas.empresa = :a2.empresa ) AND  
				( act_bajas.elemento = :a2.elemento ) ;
				
		If isnull(b2.ibajabase) then b2.ibajabase = 0
		If isnull(b2.ibajaamor) then b2.ibajaamor = 0	
End If*/

SELECT sum(importe_amor)  
INTO :a1.amor_acumulada
FROM act_amortizaciones  
WHERE ( act_amortizaciones.empresa = :a1.empresa ) AND  
      ( act_amortizaciones.elemento = :a1.elemento ) AND  
      ( act_amortizaciones.actualizado = 'S' )   ;

If isnull(a1.amor_acumulada) then a1.amor_acumulada = 0

/*If not isnull(a2.empresa) then	  	
  SELECT sum(importe_amor)  
    INTO :a2.amor_acumulada
    FROM act_amortizaciones  
   WHERE ( act_amortizaciones.empresa = :a2.empresa ) AND  
         ( act_amortizaciones.elemento = :a2.elemento ) AND  
         ( act_amortizaciones.actualizado = 'S' )   ;
End If

If isnull(a2.amor_acumulada) then a2.amor_acumulada = 0				*/

b1ibajabase = a1.importe - b1.ibajabase
b1ibajaamor = a1.amor_acumulada - b1.ibajaamor

// Comprobación de fecha de baja correcta

SetNull(fecha2)

fecha = ds_a1.GetItemDateTime(1,"fechabaja")
If isnull(fecha) then //or fecha=Datetime(Date('01-01-1900')) or fecha=DateTime(Date('31-12-1989')) then
	SELECT max(fecha_amor)  
	INTO :fecha2
	FROM act_amortizaciones  
	WHERE ( act_amortizaciones.empresa = :a1.empresa ) AND  
         ( act_amortizaciones.elemento = :a1.elemento ) AND  
         ( act_amortizaciones.actualizado = 'S' )   ;
	If not isnull(fecha2) then //or fecha2=Datetime(Date('01-01-1900')) or fecha2=DateTime(Date('31-12-1989'))) then
		fecha = DateTime(Date(em_fbaja.text))
//		f_mensaje("debug","Baja= " + string(fecha) + char(13) +&
//					"Ultima Amort = " + string(fecha2))

/* Comentado por David 01-04-05 por que lo dice Pedro
		If fecha > DateTime(RelativeDate(Date(fecha2),1)) then
			f_mensaje("Aviso","Existe un período de tiempo en el elemento " +&
			"que no ha sido amortizado." + char(13) + "Debe amortizar el elemento " +&
			"hasta el día anterior a la baja.")
			em_fbaja.SetFocus()
			Return
		ElseIf fecha < DateTime(RelativeDate(Date(fecha2),1)) then
				f_mensaje("Aviso","Fecha de baja no permitida. Fecha anterior " +&
				"a la última amortización.")
				em_fbaja.SetFocus()
				Return
		End If		
*/		
// Esto habrá que quitarlo si descomento lo de arriba
		If fecha < DateTime(RelativeDate(Date(fecha2),1)) then
				f_mensaje("Aviso","Fecha de baja no permitida. Fecha anterior " +&
				"a la última amortización.")
				em_fbaja.SetFocus()
				Return
		End If		
// Fin: Esto habrá que quitarlo si descomento lo de arriba

	Else
		f_mensaje("Aviso","El elemento todavía no ha sido amortizado." + char(13) +&
		"Debe amortizar el elemento hasta el día anterior a la baja.")
		em_fbaja.SetFocus()
		Return		
	End If
end If

b1ibajaamor = (a1.amor_acumulada * b1ibajabase) / (a1.importe - a1.bajas)
//em_bacum.text = b1ibajaamor
If a1.bajas + b1ibajabase > a1.importe then
	f_mensaje("Error","Importe de baja excede lo permitido.")
	em_base.setfocus()
	return
end If
If b1ibajaamor > a1.amor_acumulada then
	f_mensaje("Error","Parte de elemento no amortizada.")
	return
end If

/*If not isnull(a2.empresa) then	  	
	b2ibajabase = (b1ibajabase * a2.importe) / a1.importe
	b2ibajaamor = (a2.amor_acumulada * b2ibajabase) / (a2.importe - a1.bajas)
	If isnull(b2ibajaamor) then b2ibajaamor= 0
	em_bhbase.text = String(b2ibajabase,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
	em_bhacum.text = String(b2ibajaamor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
End If*/

If year(Date(em_fasiento.text))<>Integer(uo_ejercicio.em_ejercicio.text) then	
	f_mensaje("Aviso","Fecha no correcta. No corresponde al ejercicio." +&
				char(13) + string(year(Date(em_fasiento.text))))
	em_fasiento.SetFocus()
	Return
Else
//	If not f_control_fecha_apunte(a1.empresa,Dec(uo_ejercicio.em_ejercicio.text),DateTime(Date(em_fasiento.text))) then Return			
	If not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),DateTime(Date(em_fasiento.text))) then Return			
end If

if Dec(em_bbase.text)<>0 and not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,em_cliente.text) then
	f_mensaje("Aviso","No existe la cuenta del cliente.")
	em_cliente.SetFocus()
	Return
End If

/////////////////////////////////////////////////////////////
//// Mostrar asiento antes de realizar la contabilizacion

delete from act_tmp_apun;
acudebe = 0
acuhaber = 0
descripcion = trim(ds_a1.GetItemString(1,"descripcion"))

// Graba el apunte para el elemento
//If not isnull(em_importe.text) and dec(em_importe.text)<> 0 then
//	apu.ampliacion = "Amort. Acum. VENTA"
//else
//	apu.ampliacion = "Amort. Acum. BAJA"
//End If

apu.ampliacion = "Amort. Acum. "+ddlb_causa.text

apu.ampliacion = apu.ampliacion + ' ' + descripcion

cuenta_abono = trim(ds_a1.GetItemString(1,"cuenta_abono"))
cuenta_activo = trim(ds_a1.GetItemString(1,"cuenta_activo"))
contador = 1
// Graba el apunte para el elemento
apu.cuenta = cuenta_abono
If f_dh_contagene(codigo_empresa,"600")='D' then
	apu.debe  = a1.amor_acumulada
	apu.haber = 0
else
	apu.debe  = 0
	apu.haber = a1.amor_acumulada
end if
acudebe = acudebe + apu.debe
acuhaber = acuhaber + apu.haber

INSERT INTO act_tmp_apun  
		( cuenta,   
		  debe,   
		  haber ,
		  codigo,
		  elemento,
		  amortizacion,
		  ampliacion)  
VALUES (:apu.cuenta,   
		  :apu.debe,   
		  :apu.haber,
		  :contador,
		  0,
		  0,
		  :apu.ampliacion)  ;
contador = contador + 1


If a1.importe <>0 then
	apu.cuenta = cuenta_activo
	If f_dh_contagene(codigo_empresa,"605")='D' then
		apu.debe  = a1.importe 
		apu.haber = 0
	else
		apu.debe  = 0
		apu.haber = a1.importe 
	end if	
	acudebe = acudebe + apu.debe
	acuhaber = acuhaber + apu.haber
//	If not isnull(em_importe.text) and dec(em_importe.text)<> 0 then
//		apu.ampliacion = "VTA"
//	Else
//		apu.ampliacion = "BAJ"
//	End If
	apu.ampliacion = ddlb_causa.text
	
	apu.ampliacion = apu.ampliacion + ' ' + descripcion

	INSERT INTO act_tmp_apun  
			( cuenta,   
			  debe,   
			  haber ,
			  codigo,
			  elemento,
			  amortizacion,
			  ampliacion)  
	VALUES (:apu.cuenta,   
			  :apu.debe,   
			  :apu.haber,
			  :contador,
			  0,
			  0,
			  :apu.ampliacion)  ;
	contador = contador + 1
End  If

If dec(em_bbase.text)<> 0 then 
	apu.cuenta = em_cliente.text
	If f_dh_contagene(codigo_empresa,"602")='D' then
		apu.debe  = dec(em_bbase.text)
		apu.haber = 0
	else
		apu.debe  = 0
		apu.haber = dec(em_bbase.text)
	end if	
	acudebe = acudebe + apu.debe
	acuhaber = acuhaber + apu.haber
		
	INSERT INTO act_tmp_apun  
			( cuenta,   
			  debe,   
			  haber ,
			  codigo,
			  elemento,
			  amortizacion,
			  ampliacion)  
	VALUES (:apu.cuenta,   
			  :apu.debe,   
			  :apu.haber,
			  :contador,
			  0,
			  0,
			  :apu.ampliacion)  ;
	contador = contador + 1
End If


importeresto = acudebe - acuhaber
If importeresto <> 0 then
	
	resp = MessageBox("Aviso","¿Se trata de un bien de inmovilizado material?",Question!,YesNo!,1)
	If resp = 1 then 
		material = true
	else
		material = false
	end if
	
	If importeresto > 0 then // beneficio
		If material then 
			codigo = "603"
		Else
			codigo = "606"
		End If
		apu.cuenta = f_cuenta_contagene(codigo_empresa,codigo)
		If f_dh_contagene(codigo_empresa,codigo)='D' then	
			apu.debe  = importeresto
			apu.haber = 0
		else
			apu.debe  = 0
			apu.haber = importeresto
		end if	
	Else
		importeresto = importeresto * -1
		If material then 
			codigo = "604"
		Else
			codigo = "607"
		End If

		apu.cuenta = f_cuenta_contagene(codigo_empresa,codigo)
		If f_dh_contagene(codigo_empresa,codigo)='D' then	
			apu.debe  = importeresto
			apu.haber = 0
		else
			apu.debe  = 0
			apu.haber = importeresto
		end if	
	End If
	acudebe = acudebe + apu.debe
	acuhaber = acuhaber + apu.haber
	apu.ampliacion = f_nombre_contaplan(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,apu.cuenta)
	apu.ampliacion = apu.ampliacion + ' ' + descripcion

	INSERT INTO act_tmp_apun  
			( cuenta,   
			  debe,   
			  haber ,
			  codigo,
			  elemento,
			  amortizacion,
			  ampliacion)  
	VALUES (:apu.cuenta,   
			  :apu.debe,   
			  :apu.haber,
			  :contador,
			  0,
			  0,
			  :apu.ampliacion)  ;
End If


param.i_nargumentos = 2
param.s_argumentos[1] = codigo_empresa
param.s_argumentos[2] = uo_ejercicio.em_ejercicio.text
param.s_argumentos[3] = em_fbaja.text

//IF not f_control_fecha_apunte(codigo_empresa,Dec(uo_ejercicio.em_ejercicio.text),DateTime(Date(param.s_argumentos[3]))) then Return
IF not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),DateTime(Date(param.s_argumentos[3]))) then Return

OpenWithParm(w_act_meses_apun,param)

param_rec = Message.PowerObjectParm
IF param_rec.s_argumentos[1] <> '1' THEN Return

resp = MessageBox("Confirme la contabilización","Se va a producir la baja del elemento." + char(13) + "¿Desea contabilizar el asiento generado?",Question!,YesNoCancel!,1)

If resp = 3 then Return 

If resp = 1 then 
// ------------------ Realizar apuntes contables ----------------------

	apu.origen     = f_diario_contagene(codigo_empresa,"600")
	f_rellenoapunte(apu)
	apu.apunte = 1
	
	//cuenta_abono = trim(ds_a1.GetItemString(1,"cuenta_abono"))
	//cuenta_activo = trim(ds_a1.GetItemString(1,"cuenta_activo"))
	descripcion = trim(ds_a1.GetItemString(1,"descripcion"))
	
	// Graba el apunte para el elemento
	If not isnull(em_importe.text) and dec(em_importe.text)<> 0 then
		apu.ampliacion = "Amort. Acum. VENTA"
	else
		apu.ampliacion = "Amort. Acum. BAJA"
	End If
	
	apu.concepto = f_concepto_contagene(codigo_empresa,"600")
	apu.cuenta = cuenta_abono
	apu.ampliacion = apu.ampliacion + ' ' + descripcion
	//apu.debe = b1ibajaamor
	If f_dh_contagene(codigo_empresa,"600")='D' then
		apu.debe  = a1.amor_acumulada
		apu.haber = 0
	else
		apu.debe  = 0
		apu.haber = a1.amor_acumulada
	end if
	
	acudebe = 0
	acuhaber = 0
	
	//f_mensaje("debug","Cuenta:" + apu.cuenta + char(13) +&
	//			"debe: " + string(apu.debe) + char(13) +&
	//			"haber: " + string(apu.haber) )
				
	If not f_insert_contaapun(apu) then
		f_mensaje("Aviso","No grabo asientos se retrocede !!")
		bien = False
	End If
	apu.apunte = apu.apunte +1
	
	acudebe = acudebe + apu.debe
	acuhaber = acuhaber + apu.haber
	
	/*// Graba el apunte para el hijo si existe
	If b2ibajaamor<>0 then
		apu.debe = b2ibajaamor
		If f_dh_contagene(codigo_empresa,"600")='D' then
			apu.debe  = b2ibajaamor
			apu.haber = 0
		else
			apu.debe  = 0
			apu.haber = b2ibajaamor
		end if	
		f_mensaje("debug","Cuenta:" + apu.cuenta + char(13) +&
					"debe: " + string(apu.debe) + char(13) +&
					"haber: " + string(apu.haber) )
		If not f_insert_contaapun(apu) then
			f_mensaje("Aviso","No grabo asientos se retrocede !!")
			bien = False
		End If
	End If
	apu.apunte = apu.apunte +1
	acudebe = acudebe + apu.debe
	acuhaber = acuhaber + apu.haber
	*/
	// Graba el apunte para el elemento
	If b1ibajabase<>0 then
		apu.origen     = f_diario_contagene(codigo_empresa,"605")
		apu.concepto = f_concepto_contagene(codigo_empresa,"605")
		If not isnull(em_importe.text) and dec(em_importe.text)<> 0 then
			apu.ampliacion = "VTA"
		Else
			apu.ampliacion = "BAJ"
		End If
		apu.cuenta = cuenta_activo
	//	apu.debe = b1ibajabase 
		// **** VA AL DEBE O AL HABER
		If f_dh_contagene(codigo_empresa,"605")='D' then
			apu.debe  = a1.importe 
			apu.haber = 0
		else
			apu.debe  = 0
			apu.haber = a1.importe 
		end if	
		apu.ampliacion = apu.ampliacion + ' ' + descripcion	
	
	//	f_mensaje("debug","Cuenta:" + apu.cuenta + char(13) +&
	//				"debe: " + string(apu.debe) + char(13) +&
	//				"haber: " + string(apu.haber) )
		If not f_insert_contaapun(apu) then
			f_mensaje("Aviso","No grabo asientos se retrocede !!")
			bien = False
		End If
		
		apu.apunte = apu.apunte +1
		acudebe = acudebe + apu.debe
		acuhaber = acuhaber + apu.haber
		
	End If
	
	/*// Graba el apunte para el hijo si existe
	If b2ibajabase<>0 then
		If not isnull(em_importe.text) and dec(em_importe.text)<> 0 then
			apu.ampliacion = "VTA"
		Else
			apu.ampliacion = "BAJ"
		End If
		apu.debe = b2ibajabase 
		// **** VA AL DEBE O AL HABER
		If f_dh_contagene(codigo_empresa,"605")='D' then
			apu.debe  = b2ibajabase
			apu.haber = 0
		else
			apu.debe  = 0
			apu.haber = b2ibajabase
		end if	
		apu.ampliacion = apu.ampliacion + ' ' + descripcion	
	
		f_mensaje("debug","Cuenta:" + apu.cuenta + char(13) +&
					"debe: " + string(apu.debe) + char(13) +&
					"haber: " + string(apu.haber) )
		If not f_insert_contaapun(apu) then
			f_mensaje("Aviso","No grabo asientos se retrocede !!")
			bien = False
		End If
		
		apu.apunte = apu.apunte +1
		acudebe = acudebe + apu.debe
		acuhaber = acuhaber + apu.haber	
	End If */
	
	If not isnull(em_bbase.text) and dec(em_bbase.text)<> 0 then
		apu.origen     = f_diario_contagene(codigo_empresa,"602")
		apu.concepto = f_concepto_contagene(codigo_empresa,"602")
		If not isnull(em_bbase.text) and dec(em_bbase.text)<> 0 then
			apu.ampliacion = "VTA"
		else
			apu.ampliacion = "BAJ"
		End If
	//	apu.cuenta = cuenta_activo
		apu.cuenta = em_cliente.text
	//	apu.debe = b1ibajabase 
		// **** VA AL DEBE O AL HABER
		If f_dh_contagene(codigo_empresa,"602")='D' then
			apu.debe  = dec(em_bbase.text)
			apu.haber = 0
		else
			apu.debe  = 0
			apu.haber = dec(em_bbase.text)
		end if	
		apu.ampliacion = apu.ampliacion + ' ' + descripcion	
	
	//	f_mensaje("debug","Cuenta:" + apu.cuenta + char(13) +&
	//				"debe: " + string(apu.debe) + char(13) +&
	//				"haber: " + string(apu.haber) )
		If not f_insert_contaapun(apu) then
			f_mensaje("Aviso","No grabo asientos se retrocede !!")
			bien = False
		End If
		
		apu.apunte = apu.apunte +1
		acudebe = acudebe + apu.debe
		acuhaber = acuhaber + apu.haber
	End If	
	
	importeresto = acudebe - acuhaber
	If importeresto <> 0 then
		If importeresto > 0 then // beneficio
			apu.origen     = f_diario_contagene(codigo_empresa,codigo) 
			apu.concepto = f_concepto_contagene(codigo_empresa,codigo)
			apu.cuenta = f_cuenta_contagene(codigo_empresa,codigo)
			apu.ampliacion = f_nombre_contaplan(apu.ejercicio,codigo_empresa,apu.cuenta)
			If f_dh_contagene(codigo_empresa,codigo)='D' then	
				apu.debe  = importeresto
				apu.haber = 0
			else
				apu.debe  = 0
				apu.haber = importeresto
			end if	
		Else
			importeresto = importeresto * -1
			apu.origen     = f_diario_contagene(codigo_empresa,codigo)
			apu.concepto = f_concepto_contagene(codigo_empresa,codigo) 
			apu.cuenta = f_cuenta_contagene(codigo_empresa,codigo)
			apu.ampliacion = f_nombre_contaplan(apu.ejercicio,codigo_empresa,apu.cuenta)
			If f_dh_contagene(codigo_empresa,codigo)='D' then	
				apu.debe  = importeresto
				apu.haber = 0
			else
				apu.debe  = 0
				apu.haber = importeresto
			end if	
		End If
	//	If not isnull(em_importe.text) and dec(em_importe.text)<> 0 then
	//		apu.ampliacion = "VTA"
	//	else
	//		apu.ampliacion = "BAJ"
	//	End If
		apu.ampliacion = apu.ampliacion + ' ' + descripcion	
		
	//	f_mensaje("debug","Cuenta:" + apu.cuenta + char(13) +&
	//				"debe: " + string(apu.debe) + char(13) +&
	//				"haber: " + string(apu.haber) )
		If not f_insert_contaapun(apu) then
			f_mensaje("Aviso","No grabo asientos se retrocede !!")
			bien = False
		End If
		
		apu.apunte = apu.apunte +1
		acudebe = acudebe + apu.debe
		acuhaber = acuhaber + apu.haber
		
	End If

End If


ba.empresa = a1.empresa
ba.elemento = a1.elemento

  SELECT max(orden)  
    INTO :ba.orden  
    FROM act_bajas  
   WHERE ( act_bajas.empresa = :ba.empresa ) AND  
         ( act_bajas.elemento = :ba.elemento )   ;
			
if isnull(ba.orden) then ba.orden = 0
ba.orden = ba.orden + 1
ba.fechaba = a1.fechabaja
 If isnull(ba.fechaba) then ba.fechaba = DateTime(Date(em_fbaja.text))
ba.ibajabase = b1ibajabase
ba.ibajaamor = b1ibajaamor
ba.ibajaresto = 0
ba.observacionesba = em_obs.text
venta = Dec(em_bbase.text)

  INSERT INTO act_bajas  
         ( empresa,   
           elemento,   
           orden,   
           fechaba,   
           ibajabase,   
           ibajaamor,   
           ibajaresto,   
           observacionesba,
			  venta)  
  VALUES ( :ba.empresa,   
           :ba.elemento,   
           :ba.orden,   
           :ba.fechaba,   
           :ba.ibajabase,   
           :ba.ibajaamor,   
           :ba.ibajaresto,   
           :ba.observacionesba,
			  :venta)  ;
	
	If sqlca.sqlcode<> 0 then
		bien = False
	End If

/*If not isnull(a2.empresa) then
	ba.empresa = a2.empresa
	ba.elemento = a2.elemento
	
	  SELECT max(orden)  
		 INTO :ba.orden  
		 FROM act_bajas  
		WHERE ( act_bajas.empresa = :ba.empresa ) AND  
				( act_bajas.elemento = :ba.elemento )   ;
				
	if isnull(ba.orden) then ba.orden = 0
	ba.orden = ba.orden + 1
	ba.fechaba = a2.fechabaja
	ba.ibajabase = b2ibajabase
	ba.ibajaamor = b2ibajaamor
	ba.ibajaresto = 0
	ba.observacionesba = em_obs.text
	
	  INSERT INTO act_bajas  
				( empresa,   
				  elemento,   
				  orden,   
				  fechaba,   
				  ibajabase,   
				  ibajaamor,   
				  ibajaresto,   
				  observacionesba )  
	  VALUES ( :ba.empresa,   
				  :ba.elemento,   
				  :ba.orden,   
				  :ba.fechaba,   
				  :ba.ibajabase,   
				  :ba.ibajaamor,   
				  :ba.ibajaresto,   
				  :ba.observacionesba )  ;

				  	
	If sqlca.sqlcode<> 0 then
		bien = False
	End If
End If*/

a1.bajas = a1.bajas + b1ibajabase
a1.amor_acumulada = a1.amor_acumulada - b1ibajaamor

  UPDATE act_bienesdet  
     SET bajas = :a1.bajas,   
         amor_acumulada = :a1.amor_acumulada  
   WHERE ( act_bienesdet.empresa = :a1.empresa ) AND  
         ( act_bienesdet.elemento = :a1.elemento )   ;			
	
	If sqlca.sqlcode<> 0 then
		bien = False
	End If
			
			
If a1.bajas = a1.importe then
  If isnull(ba.fechaba)	then ba.fechaba = DateTime(Date(em_fbaja.text))
  UPDATE act_bienesdet  
     SET fechabaja = :ba.fechaba   
   WHERE ( act_bienesdet.empresa = :a1.empresa ) AND  
         ( act_bienesdet.elemento = :a1.elemento )   ;
	
	If sqlca.sqlcode<> 0 then
		bien = False
	End If
			
  DELETE FROM act_amortizaciones  
   WHERE ( act_amortizaciones.empresa = :a1.empresa ) AND  
         ( act_amortizaciones.elemento = :a1.elemento ) AND  
         ( act_amortizaciones.actualizado = 'N' )   ;
End If

/*If not isnull(a2.empresa) then
	a2.bajas = a2.bajas + b2ibajabase
	a2.amor_acumulada = a2.amor_acumulada - b2ibajaamor

  UPDATE act_bienesdet  
     SET bajas = :a2.bajas,   
         amor_acumulada = :a2.amor_acumulada  
   WHERE ( act_bienesdet.empresa = :a2.empresa ) AND  
         ( act_bienesdet.elemento = :a2.elemento )   ;
	If sqlca.sqlcode<> 0 then 
		bien = False
	End If
			
	If a2.bajas = a2.importe then
	  If isnull(ba.fechaba)	then ba.fechaba = DateTime(Date(em_fbaja))
	  UPDATE act_bienesdet  
		  SET fechabaja = :ba.fechaba   
		WHERE ( act_bienesdet.empresa = :a2.empresa ) AND  
				( act_bienesdet.elemento = :a2.elemento )   ;
				
		If sqlca.sqlcode<> 0 then 
			bien = False
		End If
	  DELETE FROM act_amortizaciones  
		WHERE ( act_amortizaciones.empresa = :a2.empresa ) AND  
				( act_amortizaciones.elemento = :a2.elemento ) AND  
				( act_amortizaciones.actualizado = 'N' )   ;
	End If	
End If */

If bien then 
	f_mensaje("Fin del proceso","El proceso de baja ha finalizado con éxito.")
	commit using sqlca;
Else
	f_mensaje("Fin del proceso","El proceso de baja ha finalizado con errores. No se actualizan las operaciones")
	rollback using sqlca;
End If
end subroutine

on w_act_bajas.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_ejercicio=create uo_ejercicio
this.em_elemento=create em_elemento
this.st_2=create st_2
this.em_importe=create em_importe
this.st_3=create st_3
this.em_prov=create em_prov
this.st_4=create st_4
this.em_fcompra=create em_fcompra
this.st_elemento=create st_elemento
this.em_acum=create em_acum
this.st_6=create st_6
this.em_base=create em_base
this.st_7=create st_7
this.st_prov=create st_prov
this.cb_proceso=create cb_proceso
this.st_13=create st_13
this.em_fbaja=create em_fbaja
this.st_14=create st_14
this.em_obs=create em_obs
this.st_15=create st_15
this.em_bbase=create em_bbase
this.st_22=create st_22
this.em_fasiento=create em_fasiento
this.cb_1=create cb_1
this.st_24=create st_24
this.em_cliente=create em_cliente
this.st_cliente=create st_cliente
this.ddlb_causa=create ddlb_causa
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.em_elemento
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_importe
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_prov
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.em_fcompra
this.Control[iCurrent+10]=this.st_elemento
this.Control[iCurrent+11]=this.em_acum
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.em_base
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.st_prov
this.Control[iCurrent+16]=this.cb_proceso
this.Control[iCurrent+17]=this.st_13
this.Control[iCurrent+18]=this.em_fbaja
this.Control[iCurrent+19]=this.st_14
this.Control[iCurrent+20]=this.em_obs
this.Control[iCurrent+21]=this.st_15
this.Control[iCurrent+22]=this.em_bbase
this.Control[iCurrent+23]=this.st_22
this.Control[iCurrent+24]=this.em_fasiento
this.Control[iCurrent+25]=this.cb_1
this.Control[iCurrent+26]=this.st_24
this.Control[iCurrent+27]=this.em_cliente
this.Control[iCurrent+28]=this.st_cliente
this.Control[iCurrent+29]=this.ddlb_causa
this.Control[iCurrent+30]=this.st_5
end on

on w_act_bajas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uo_ejercicio)
destroy(this.em_elemento)
destroy(this.st_2)
destroy(this.em_importe)
destroy(this.st_3)
destroy(this.em_prov)
destroy(this.st_4)
destroy(this.em_fcompra)
destroy(this.st_elemento)
destroy(this.em_acum)
destroy(this.st_6)
destroy(this.em_base)
destroy(this.st_7)
destroy(this.st_prov)
destroy(this.cb_proceso)
destroy(this.st_13)
destroy(this.em_fbaja)
destroy(this.st_14)
destroy(this.em_obs)
destroy(this.st_15)
destroy(this.em_bbase)
destroy(this.st_22)
destroy(this.em_fasiento)
destroy(this.cb_1)
destroy(this.st_24)
destroy(this.em_cliente)
destroy(this.st_cliente)
destroy(this.ddlb_causa)
destroy(this.st_5)
end on

event open;call super::open;   istr_parametros.s_titulo_ventana = "Baja de Elementos de Amortización" 
	valor_empresa = True
	istr_parametros.s_listado        = "report_act_bajas"
   This.title = istr_parametros.s_titulo_ventana
   

	em_base.text = string(0.00)
//	dw_2.SetTransObject(sqlca)

   // Si recibo el codigo lo visualizo
/*
	IF istr_parametros.i_nargumentos>1 THEN
		elemento = Dec(istr_parametros.s_argumentos[2])
		dw_2.Retrieve(codigo_empresa,elemento)
		f_baja()		
	End IF
	*/
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_act_bajas
integer x = 891
integer y = 560
integer taborder = 80
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_act_bajas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_act_bajas
integer x = 14
integer y = 20
integer width = 2683
integer height = 96
integer textsize = -10
fontcharset fontcharset = ansi!
end type

type st_1 from statictext within w_act_bajas
integer x = 9
integer y = 144
integer width = 320
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Elemento"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_ejercicio from u_ejercicio within w_act_bajas
event destroy ( )
integer x = 2062
integer y = 132
integer taborder = 100
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type em_elemento from u_em_campo within w_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 347
integer y = 140
integer width = 379
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
end type

event getfocus;call super::getfocus;ue_datawindow     = "dw_ayuda_act_bienesdet"
ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena
DateTime	fecha
Integer	rr
Dec		valor,valor2,elemento

cb_proceso.Enabled = False

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))
st_elemento.text = cadena

If cadena='' then
	f_mensaje("Aviso","El elemento no existe.")
	em_elemento.text= ''
	em_elemento.SetFocus()
	return
End If


// el elemento existe
cadena = "SELECT amor_acumulada,ctaproveedor,fechacompra,importe, " +&
			"empresa,elemento,fechabaja,bajas,cuenta_abono,cuenta_activo,descripcion " +&
			"FROM act_bienesdet " +& 
		   "WHERE ( act_bienesdet.empresa = '" + codigo_empresa + "') AND " +&
			"( act_bienesdet.elemento = "+ this.text +")"


//ds_a1 = f_cargar_cursor(cadena)  //ds_a1 es el elemento
f_cargar_cursor_nuevo(cadena, ds_a1)


rr = ds_a1.RowCount()

If rr<>1 then
	f_mensaje("Error","Se ha producido un error al buscar el elemento " +&
	+ this.text + char(13) + sqlca.sqlerrtext + char(13) + cadena)
	em_elemento.SetFocus()
	destroy ds_a1
	return	
End If

fecha = ds_a1.GetItemDateTime(1,"fechabaja")

If not isnull(fecha) then 
	f_mensaje("Aviso","El elemento ha sido dado de baja.")
	em_elemento.text= ''
	st_elemento.text = ''
	em_elemento.SetFocus()
	destroy ds_a1
	return
End If


/*
sle_valor.SetFocus()
sle_valor.text = f_componer_familia()
If sle_valor.text <>'' then sle_valor.TriggerEvent("tecla_tabulador") */

elemento = Dec(em_elemento.text)

  SELECT sum(importe_amor)  
    INTO :valor
    FROM act_amortizaciones  
   WHERE ( act_amortizaciones.empresa = :codigo_empresa ) AND  
         ( act_amortizaciones.elemento = :elemento ) AND  
         ( act_amortizaciones.actualizado = 'S' )   ;

	If isnull(valor) then valor = 0 
	
	valor2 = Dec(ds_a1.Object.amor_acumulada[1])
	If isnull(valor2) then valor2 = 0 
	em_acum.text = String(valor + valor2,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
	
  SELECT sum(ibajabase),sum(ibajaamor)
    INTO :valor,:valor2
    FROM act_bajas  
   WHERE ( act_bajas.empresa = :codigo_empresa ) AND  
         ( act_bajas.elemento = :elemento ) ;

	If isnull(valor) then valor = 0 
//	em_bajas.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
	If isnull(valor2) then valor2 = 0 

	em_prov.text = trim(ds_a1.GetItemString(1,"ctaproveedor"))
	st_prov.text = f_nombre_contaplan(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,em_prov.text) 	
	fecha = ds_a1.GetItemDateTime(1,"fechacompra")
	em_fcompra.text = String(fecha,"dd-mm-yyyy")
	em_importe.text = String(ds_a1.GetItemDecimal(1,"importe"),f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
	
//	valor = (Dec(em_importe.text) - Dec(em_bajas.text)) - (Dec(em_acum.text) - valor2)
	valor = Dec(em_importe.text) - (Dec(em_acum.text) - valor2)
	
	em_base.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
	
//	dw_2.Retrieve(codigo_empresa,elemento)
	
//	cadena = "SELECT act_bienesdet.* FROM act_bienesdet " +& 
//				"WHERE ( act_bienesdet.empresa = '" + codigo_empresa + "') AND " +&
//				"( act_bienesdet.elemento = "+ this.text +")"
//	
//	ds_a1 = f_cargar_cursor(cadena)  //ds_a1 es el elemento
	
/*	cadena = "SELECT act_bienesdet.* FROM act_bienesdet " +& 
				"WHERE ( act_bienesdet.empresa = '" + codigo_empresa + "') AND " +&
				"( act_bienesdet.elemento <> "+ this.text +") AND " +&
				"( act_bienesdet.padre = "+ this.text +")"
	
	ds_a2 = f_cargar_cursor(cadena)  //ds_a2 es el hijo(si existe)
	
	rr = ds_a2.RowCount()
	
	If rr>0 then
		elemento = ds_a2.GetItemDecimal(1,"elemento")
			
		  SELECT sum(importe_amor)  
			 INTO :valor
			 FROM act_amortizaciones  
			WHERE ( act_amortizaciones.empresa = :codigo_empresa ) AND  
					( act_amortizaciones.elemento = :elemento ) AND  
					( act_amortizaciones.actualizado = 'S' ) ;
			
			If isnull(valor) then valor = 0 
			em_hacum.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
			valor = ds_a2.GetItemDecimal(1,"importe")
			em_hvalor.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))

		  SELECT sum(ibajabase),sum(ibajaamor)
			 INTO :valor,:valor2
			 FROM act_bajas  
			WHERE ( act_bajas.empresa = :codigo_empresa ) AND  
					( act_bajas.elemento = :elemento ) ;
			If isnull(valor) then valor = 0 
			em_hbajas.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))

			valor = (Dec(em_hvalor.text) - Dec(em_hbajas.text)) - (Dec(em_hacum.text) - valor2)
			em_hbase.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))

	End IF */
	
	cb_proceso.Enabled = True
	
If ds_a1.RowCount()>0 then 
	cadena = trim(ds_a1.GetItemString(1,"empresa"))
	valor = ds_a1.GetItemDecimal(1,"elemento")
	SELECT max(fecha_amor)  
	 INTO :fecha
	 FROM act_amortizaciones  
	WHERE ( act_amortizaciones.empresa = :cadena ) AND  
			( act_amortizaciones.elemento = :valor ) AND  
			( act_amortizaciones.actualizado = 'S' )   ;
	If isnull(fecha) then //or fecha2=Datetime(Date('01-01-1900')) or fecha2=DateTime(Date('31-12-1989')) then
		fecha = DateTime(Today())
	Else
		fecha = DateTime(RelativeDate(Date(fecha),1))
	End If
	
//	f_mensaje("debug",string(fecha))
	
	em_fbaja.text = String(fecha,"dd-mm-yyyy")
	em_fasiento.text = String(fecha,"dd-mm-yyyy")
end if

//	destroy ds_a1

end event

type st_2 from statictext within w_act_bajas
integer x = 27
integer y = 240
integer width = 485
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Importe Compra"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_importe from u_em_campo within w_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 507
integer y = 240
integer width = 347
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
boolean displayonly = true
end type

type st_3 from statictext within w_act_bajas
integer x = 23
integer y = 336
integer width = 320
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_prov from u_em_campo within w_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 389
integer y = 336
integer width = 411
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
boolean displayonly = true
end type

type st_4 from statictext within w_act_bajas
integer x = 878
integer y = 240
integer width = 485
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Compra"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fcompra from u_em_campo within w_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1367
integer y = 240
integer width = 293
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
boolean displayonly = true
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_elemento from statictext within w_act_bajas
integer x = 745
integer y = 140
integer width = 1111
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_acum from u_em_campo within w_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 457
integer y = 448
integer width = 343
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
boolean displayonly = true
end type

type st_6 from statictext within w_act_bajas
integer x = 32
integer y = 448
integer width = 407
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Amort. Acum."
alignment alignment = center!
boolean focusrectangle = false
end type

type em_base from u_em_campo within w_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1367
integer y = 448
integer width = 352
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
boolean displayonly = true
end type

type st_7 from statictext within w_act_bajas
integer x = 946
integer y = 448
integer width = 407
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Base Amort."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_prov from statictext within w_act_bajas
integer x = 814
integer y = 336
integer width = 997
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cb_proceso from u_boton within w_act_bajas
integer x = 1083
integer y = 1084
integer width = 384
integer height = 112
integer taborder = 70
fontcharset fontcharset = ansi!
boolean enabled = false
string text = "&Procesar"
end type

event clicked;f_proceso()
end event

type st_13 from statictext within w_act_bajas
integer x = 14
integer y = 644
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Baja"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fbaja from u_em_campo within w_act_bajas
integer x = 366
integer y = 636
integer width = 288
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event getfocus;call super::getfocus;DateTime	fecha,fecha2
String	cad1
Dec		n1

SetNull(fecha2)

fecha = DateTime(this.text)

If isnull(fecha) or Trim(this.text)='' or Trim(this.text)='00-00-0000' then
	If st_elemento.text <> '' then 
		If ds_a1.RowCount()>0 then 
			cad1 = trim(ds_a1.GetItemString(1,"empresa"))
			n1 = ds_a1.GetItemDecimal(1,"elemento")
			SELECT max(fecha_amor)  
			 INTO :fecha2
			 FROM act_amortizaciones  
			WHERE ( act_amortizaciones.empresa = :cad1 ) AND  
					( act_amortizaciones.elemento = :n1 ) AND  
					( act_amortizaciones.actualizado = 'S' )   ;
			If isnull(fecha2) then //or fecha2=Datetime(Date('01-01-1900')) or fecha2=DateTime(Date('31-12-1989')) then
				fecha = DateTime(Today())
			Else
				fecha = DateTime(RelativeDate(Date(fecha2),1))
			End If
			
		//	f_mensaje("debug",string(fecha))
			
			em_fbaja.text = String(fecha,"dd-mm-yyyy")
		end if
	end if	
end If
end event

event losefocus;call super::losefocus;DateTime	fecha,fecha2
String	cad1
Dec		n1

fecha = DateTime(This.text)
If isnull(fecha) then
	This.SetFocus()
	Return
End If
end event

type st_14 from statictext within w_act_bajas
integer x = 718
integer y = 648
integer width = 439
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Observaciones"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_obs from u_em_campo within w_act_bajas
integer x = 1198
integer y = 640
integer width = 1289
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type st_15 from statictext within w_act_bajas
integer x = 261
integer y = 748
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Baja Base"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_bbase from u_em_campo within w_act_bajas
integer x = 640
integer y = 744
integer width = 320
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,##0.00"
end type

event losefocus;call super::losefocus;Dec	b1ibajaamor

If isnull(this.text) or trim(this.text)='' then
	This.text = '0.00'
end if
end event

type st_22 from statictext within w_act_bajas
integer x = 187
integer y = 984
integer width = 425
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Asiento"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fasiento from u_em_campo within w_act_bajas
integer x = 640
integer y = 976
integer width = 320
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from u_boton within w_act_bajas
integer x = 2199
integer y = 1088
integer width = 384
integer height = 108
integer taborder = 90
string text = "&Salir"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_24 from statictext within w_act_bajas
integer x = 174
integer y = 860
integer width = 443
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cuenta Cliente"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cliente from u_em_campo within w_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 640
integer y = 860
integer width = 370
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DEL PLAN DE CUENTAS"
ue_datawindow = "dw_ayuda_contaplan_activo_directos"
ue_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
end event

event modificado;call super::modificado;If not (isnull(this.text) or trim(this.text)='') then
	if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,this.text) then
		f_mensaje("Aviso","No existe la cuenta del cliente.")
	Else
		st_cliente.text = f_nombre_contaplan(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,this.text)
	end if
End If
end event

type st_cliente from statictext within w_act_bajas
integer x = 1033
integer y = 860
integer width = 997
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type ddlb_causa from dropdownlistbox within w_act_bajas
integer x = 631
integer y = 1100
integer width = 407
integer height = 400
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string item[] = {"VENTA","BAJA"}
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_act_bajas
integer x = 197
integer y = 1104
integer width = 425
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Causa:"
alignment alignment = right!
boolean focusrectangle = false
end type

