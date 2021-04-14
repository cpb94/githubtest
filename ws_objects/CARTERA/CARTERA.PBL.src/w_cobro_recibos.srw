$PBExportHeader$w_cobro_recibos.srw
$PBExportComments$€
forward
global type w_cobro_recibos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_cobro_recibos
end type
type cb_procesar from commandbutton within w_cobro_recibos
end type
type cb_2 from commandbutton within w_cobro_recibos
end type
type uo_cliente from u_em_campo_2 within w_cobro_recibos
end type
type em_asiento from u_em_campo within w_cobro_recibos
end type
type st_3 from statictext within w_cobro_recibos
end type
type em_fapunte from u_em_campo within w_cobro_recibos
end type
type st_4 from statictext within w_cobro_recibos
end type
type st_11 from statictext within w_cobro_recibos
end type
type uo_banco from u_em_campo_2 within w_cobro_recibos
end type
type st_5 from statictext within w_cobro_recibos
end type
type em_fcobro from u_em_campo within w_cobro_recibos
end type
type st_6 from statictext within w_cobro_recibos
end type
type em_divisas from u_em_campo within w_cobro_recibos
end type
type uo_ejercicio from u_ejercicio within w_cobro_recibos
end type
type cb_salir from commandbutton within w_cobro_recibos
end type
type cb_borrar from commandbutton within w_cobro_recibos
end type
type st_22 from statictext within w_cobro_recibos
end type
type uo_moneda from u_em_campo_2 within w_cobro_recibos
end type
type st_moneda from statictext within w_cobro_recibos
end type
type em_importe from u_em_campo within w_cobro_recibos
end type
type st_pts from statictext within w_cobro_recibos
end type
type em_cambio from u_em_campo within w_cobro_recibos
end type
type st_7 from statictext within w_cobro_recibos
end type
type em_gastos from u_em_campo within w_cobro_recibos
end type
type st_pts2 from statictext within w_cobro_recibos
end type
type st_9 from statictext within w_cobro_recibos
end type
type ln_1 from line within w_cobro_recibos
end type
type st_pts3 from statictext within w_cobro_recibos
end type
type st_8 from statictext within w_cobro_recibos
end type
type dw_selecion from u_datawindow_consultas within w_cobro_recibos
end type
type gb_1 from groupbox within w_cobro_recibos
end type
type rb_pendientes from checkbox within w_cobro_recibos
end type
type cb_gastos from commandbutton within w_cobro_recibos
end type
type dw_gastos from u_datawindow within w_cobro_recibos
end type
type em_total from u_em_campo within w_cobro_recibos
end type
type cbx_ecc from checkbox within w_cobro_recibos
end type
type dw_detalle from datawindow within w_cobro_recibos
end type
type cbx_devuelto from checkbox within w_cobro_recibos
end type
type st_2 from statictext within w_cobro_recibos
end type
type st_10 from statictext within w_cobro_recibos
end type
type em_fvto from u_em_campo within w_cobro_recibos
end type
type cbx_mostrar_anticipados from checkbox within w_cobro_recibos
end type
type cbx_mostrar_factorizados from checkbox within w_cobro_recibos
end type
end forward

global type w_cobro_recibos from w_int_con_empresa
integer x = 142
integer y = 4
integer width = 4352
integer height = 3280
pb_1 pb_1
cb_procesar cb_procesar
cb_2 cb_2
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
em_gastos em_gastos
st_pts2 st_pts2
st_9 st_9
ln_1 ln_1
st_pts3 st_pts3
st_8 st_8
dw_selecion dw_selecion
gb_1 gb_1
rb_pendientes rb_pendientes
cb_gastos cb_gastos
dw_gastos dw_gastos
em_total em_total
cbx_ecc cbx_ecc
dw_detalle dw_detalle
cbx_devuelto cbx_devuelto
st_2 st_2
st_10 st_10
em_fvto em_fvto
cbx_mostrar_anticipados cbx_mostrar_anticipados
cbx_mostrar_factorizados cbx_mostrar_factorizados
end type
global w_cobro_recibos w_cobro_recibos

type variables
date var_fechalimite
STring  conexion = "N"
dec total_selec,total_por
int total_reg


end variables

forward prototypes
public subroutine f_control ()
public subroutine f_pro ()
public subroutine f_control2 ()
public subroutine f_activar (boolean bo)
public function boolean f_grabar_apunte ()
public function decimal f_total_gastos ()
public function boolean f_grabar_apunte_viejo ()
protected function boolean f_procesar_recibos (integer i)
public function boolean f_comprobar_existencias_cuentas (string cliente)
end prototypes

public subroutine f_control ();dw_detalle.Reset()
string is_filtro="", cliente
string situaciones[5]
dec registros,r,re
dw_detalle.SetTransObject(sqlca)
dw_detalle.SetFilter("")
dw_detalle.Filter()

string f="",fi=""
if tipo_vista="Nacional" then fi="(nacional='S')"
if tipo_vista="Exportacion" then fi="(nacional='N')"
if isnull(tipo_vista) or tipo_vista = "" or tipo_vista="Ambos" then fi="((nacional='N') OR (nacional='S'))"
f=fi

if cbx_mostrar_anticipados.checked then
	situaciones[1] = "8"
	situaciones[2] = "0"
	situaciones[3] = "6"
	situaciones[4] = "1"
	situaciones[5] = "10"
	if cbx_mostrar_factorizados.checked then
		situaciones[6] = "7" //Factorizado
	end if
else
	situaciones[1] = "0"//Cartera
	if cbx_devuelto.checked then
		situaciones[2] = "2"//Devuelto
	else
		situaciones[2] = ""
	end if
	
	situaciones[3] = "6"//Gestion de cobro
	situaciones[4] = "1"//Remesado
	if rb_pendientes.checked then
		situaciones[5] = "10"//Pendiente de recibir
	else
		situaciones[5] = ""
	end if
	if cbx_mostrar_factorizados.checked then
		situaciones[6] = "7" //Factorizado
	end if
end if

dw_detalle.SetFilter(f)
dw_detalle.Filter()
cliente = trim(uo_cliente.em_codigo.text)
if isnull(cliente) or cliente = "" then
	cliente = '%'
end if
dw_detalle.Retrieve(codigo_empresa,cliente,uo_moneda.em_codigo.text,Dec(em_cambio.text),situaciones, Date(em_fvto.text))

f_control2()


end subroutine

public subroutine f_pro ();Integer r , r1,e
r1 = dw_detalle.RowCount()
For r = 1 To r1
	IF dw_detalle.GetItemSTring(r,"libre") = "S" Then
		e = dw_selecion.find("anyo ="+String(dw_detalle.GetItemNumber(r,"anyo"),"####")+" and orden ="+String(dw_detalle.GetItemNumber(r,"orden"),"#####"),1,dw_selecion.RowCount())
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
		dw_selecion.SetItem(e,"cancelado",dw_detalle.GetItemNumber(r,"total"))
		dw_selecion.SetItem(e,"cancelado_divisas",dw_detalle.GetItemNumber(r,"nuevo"))
		dw_selecion.SetItem(e,"cambio",dw_detalle.GetItemNumber(r,"cambio"))
		dw_selecion.SetItem(e,"divisas",dw_detalle.GetItemNumber(r,"divisas"))
		dw_selecion.SetItem(e,"situacion",dw_detalle.GetItemString(r,"situacion"))
		dw_selecion.SetItem(e,"gastos",dw_detalle.GetItemString(r,"gasto"))
	END IF
Next
end subroutine

public subroutine f_control2 ();Dec registros,r,re
registros = dw_detalle.RowCount()

For r = 1 To registros
	re = dw_selecion.find("anyo = "+String(dw_detalle.GetItemNumber(r,"anyo"),"#######")+" and orden= "+String(dw_detalle.GetItemNumber(r,"orden"),"#######") ,1,dw_selecion.RowCount())
	IF re <> 0 Then
	dw_detalle.SetItem(r,"nuevo",dw_selecion.GetItemNumber(re,"cancelado"))
	dw_detalle.SetItem(r,"libre","S")
END IF
Next
end subroutine

public subroutine f_activar (boolean bo);em_cambio.enabled  = bo
//em_divisas.enabled = bo
em_fcobro.enabled  = bo
//em_importe.enabled = bo
em_total.enabled   = bo
uo_banco.enabled   = bo
uo_moneda.enabled  = bo
cb_gastos.enabled  = bo
end subroutine

public function boolean f_grabar_apunte ();Integer   bien,anyo_efecto,cont
Dec acu,i,registros,dif,orden_efecto
String  ampli,facturas,cuenta_gasto,cuenta_dif,agrupado,situacion,gastos,moneda_empresa
Str_contaapun apu 
String cliente_actual, cliente_anterior, extra_cliente
moneda_empresa = f_moneda_empresa(codigo_empresa)

apu.empresa   = codigo_empresa
apu.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
apu.fapunte   = Datetime(date(em_fapunte.text))
apu.mes       = Month(Date(apu.fapunte))
apu.origen    = "2"
bien          = 0
ampli         = "F."
registros     = dw_selecion.rowcount()
facturas      = ""

// CONSTRUCCION DE LA AMPLIACION
for i = 1 to registros
	cliente_actual = f_razon_genter(codigo_empresa,"C",dw_selecion.GetItemString(i,"cliente"))
	
	//Lo quitamos el 30-01-2017 Paco Marin
	//David 18-06-2014:  No queremos que genere el asiento si no existe la cuenta de ECC.
//	if cbx_ecc.checked then
//		if not f_comprobar_existencias_cuentas (dw_selecion.GetItemString(i,"cliente")) then
//			messagebox ("Error", "No existe la cuenta de ECC del cliente o el cliente no tiene cuenta asignada "+cliente_actual+". No se cancela ningún efecto. Repetir proceso.")	
//			return false																							
//		end if
//	end if
	// Fin David 18-06-2014
	//Lo quitamos el 30-01-2017 Paco Marin
	
	if facturas = "" then
		facturas = dw_selecion.GetItemString(i,"fra")
	else
		if mid(facturas,len(facturas) - 1,1)<>';' then
			facturas = facturas+","+dw_selecion.GetItemString(i,"fra")
		else
			facturas = facturas+dw_selecion.GetItemString(i,"fra")			
		end if
	end if
	
	anyo_efecto=dw_selecion.GetItemNumber(i,"anyo")
	orden_efecto=dw_selecion.GetItemNumber(i,"orden")
	
	select agrupado
	into :agrupado
	from carefectos
  	where carefectos.empresa = :codigo_empresa
	and   carefectos.anyo    = :anyo_efecto
	and   carefectos.orden   = :orden_efecto;

	if agrupado='S' then
		String sel
		DataStore   dw_cursor_agrupados
		
		sel = " Select * from carefectos " + &
		      	" where carefectos.empresa       =  '"+ codigo_empresa +"'"+&
		      	" And   carefectos.situacion     =  '3' " + &
				" And   carefectos.anyoagrupa    =  " + String(anyo_efecto,"####") +&
				" And   carefectos.efectoagrupa  =  " + string(orden_efecto,"####") 
		
		//dw_cursor_agrupados= f_cargar_cursor2(sel)
		f_cargar_cursor_nuevo(sel, dw_cursor_agrupados)
		facturas=facturas+":"
		for cont=1 to dw_cursor_agrupados.rowcount()
			if cont=1 then
				facturas=facturas+dw_cursor_agrupados.GetItemString(cont,"factura")				
			else
				facturas=facturas+","+dw_cursor_agrupados.GetItemString(cont,"factura")
			end if
		next
		destroy dw_cursor_agrupados
		facturas=facturas+';'
	end if
	cliente_anterior = f_razon_genter(codigo_empresa,"C",dw_selecion.GetItemString(i,"cliente"))
Next

// INSERCION DEL APUNTE DE LA CUENTA DEL BANCO AL DEBE
apu.asiento     = f_ultimo_asiento(apu.ejercicio,apu.empresa,apu.mes,apu.origen)
em_asiento.text = STring(apu.asiento,f_mascara_decimales(0))
apu.apunte      = 1


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
apu.imponible = 0
apu.actualizado = "N"
apu.cambio  = Dec(em_cambio.text)
apu.divisas = Dec(em_total.text) * apu.cambio 
if dec(em_importe.text)>0 then
	apu.debe = Dec(em_total.text)
   	apu.haber= 0
else
	apu.debe = 0
    apu.haber= abs(Dec(em_total.text))
End if
apu.concepto = "53"
apu.ampliacion= "Cobro fra:"+facturas+" "+f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
apu.documento= ""
apu.factura  = ""
SetNull(apu.ffactura) 
apu.cuenta = f_cuenta_carbancos(codigo_empresa,uo_banco.em_codigo.text)
IF Not f_insert_contaapun(apu) Then bien = 1
acu = 0

// CALCULAMOS EL TOTAL DE LAS FACTURAS PARA CALCULAR PORCENTAJE EN COMISIONES
for i=1 to registros
	total_selec = total_selec + dw_selecion.GetItemNumber(i,"cancelado")
Next

total_por = (dec(em_importe.text)-total_selec)/total_selec
// APUNTE A LA CUENTA DEL CLIENTE POR EL IMPORTE CANCELADO, MENOS LOS GASTOS, MAS LAS DIFERENCIAS DE CAMBIO
// LOS GASTOS Y LAS DIFERENCIAS LOS DIVIDIMOS ENTRE LOS RECIBOS CANCELADOS
dec gastos_recibo_divisas,gastos_recibo_pts,dif_recibo_pts,dif_recibo_divisas
gastos_recibo_divisas = dec(string((Dec(em_gastos.text) * apu.cambio)/registros,f_mascara_moneda(uo_moneda.em_codigo.text)))
gastos_recibo_pts     = dec(string(Dec(em_gastos.text)/registros,f_mascara_moneda(moneda_empresa)))
for i=1 to registros
	acu = acu + dw_selecion.GetItemNumber(i,"cancelado")
Next
dif_recibo_pts     = dec(string((Dec(em_importe.text) - acu)/registros,f_mascara_moneda(moneda_empresa)))
dif_recibo_divisas = dec(string(((Dec(em_importe.text) - acu)* apu.cambio)/registros,f_mascara_moneda(uo_moneda.em_codigo.text)))
for i=1 to registros
	IF Not f_procesar_recibos(i) Then bien = 1
	apu.apunte     = apu.apunte + 1	
	apu.cambio     = dw_selecion.GetItemNumber(i,"cambio")
	apu.divisas    = dw_selecion.GetItemNumber(i,"cancelado_divisas") - gastos_recibo_divisas + dif_recibo_divisas// 
	apu.debe       = 0
	apu.haber      = dw_selecion.GetItemNumber(i,"cancelado") - gastos_recibo_pts + dif_recibo_pts// 
	//acu            = acu + dw_selecion.GetItemNumber(i,"cancelado")
	apu.concepto   = "40"
	//apu.ampliacion = "Cobro fra:"+facturas+" "+f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text) //Pedro Museros 04/04/2014
	apu.ampliacion = "Cobro fra:"+dw_selecion.GetItemString(i,"fra")+" "+f_razon_genter(codigo_empresa,"C",dw_selecion.GetItemString(i,"cliente")) //Pedro Museros 04/04/2014
	apu.documento  = dw_selecion.GetItemString(i,"fra")
	apu.factura    = dw_selecion.GetItemString(i,"fra")
	apu.ffactura   = dw_selecion.GetItemDateTime(i,"ffra")
	situacion      = dw_selecion.GetItemString(i,"situacion")
	gastos         = dw_selecion.GetItemString(i,"gastos")
	if isnull(gastos) then gastos = "N"
	if gastos = "S" then
		apu.cuenta = "76900002"//Recuperacion gastos devoluciones
	else
		if situacion = "2" then
			apu.cuenta = f_venclientes_cuenta_impagados(codigo_empresa,dw_selecion.GetItemString(i,"cliente"))
			if trim(apu.cuenta) = "" then
				bien = 1
				messagebox("Error","No existe la cuenta de impagados del cliente.")
			end if			
		else
			if situacion = "8" then
				//Efecto anticipado
				apu.cuenta = f_venclientes_cuenta_ecd(codigo_empresa,dw_selecion.GetItemString(i,"cliente"))
			else
				apu.cuenta = f_cuenta_genter(codigo_empresa,"C",dw_selecion.GetItemString(i,"cliente"))
			end if
			//Lo quitamos el 30-01-2017 Paco Marin
			// David 26-08-02. Si cobramos el efecto en la fecha de vencimiento (sin haberlo descontado previamente) 
			// tendremos que hacer cargo al cuenta de ECC
//			if cbx_ecc.checked then
//				apu.cuenta    = f_venclientes_cuenta_ecc(codigo_empresa,dw_selecion.GetItemString(i,"cliente"))// f_comp_cta_riesgo_431x("4310000000",apu.cuenta)
//			end if
			//Lo quitamos el 30-01-2017 Paco Marin
		end if
	end if
//	if not f_Existe_cuenta(ejercicio_activo, codigo_empresa, apu.cuenta) then   				// Nuevo 17-06--2014
//		bien = 1																									// Nuevo 17-06--2014
//		messagebox ("Atención", " La cuenta "+apu.cuenta+" no existe en el PGC")			// Nuevo 17-06--2014
//	else																											// Nuevo 17-06--2014
		IF Not f_insert_contaapun(apu) Then bien = 1
//	end if																											// Nuevo 17-06--2014
	f_contador_procesos(i,registros)
	
Next


//-----------------------------------------------------------------

//Contabilizamos los gastos
long indice,total
dec importe	

total = dw_gastos.rowcount()
dw_gastos.accepttext()
for indice = 1 to total
	importe      = dw_gastos.object.importe[indice]
	cuenta_gasto = dw_gastos.object.cuenta_gasto[indice]
	if isnull(cuenta_gasto) then cuenta_gasto = ""
	if isnull(importe) then importe = 0
	if importe <> 0 and trim(cuenta_gasto) <> "" then
		//Apunte a la cuenta del cliente por el importe del gasto
		apu.apunte     = apu.apunte + 1	
		apu.cambio     = Dec(em_cambio.text)
		apu.divisas    = importe * apu.cambio 
		if importe>0 then
			apu.debe       = 0
			apu.haber      = importe
		else
			apu.debe       = - importe
			apu.haber      = 0
		end if
		apu.concepto   = "40"
		apu.ampliacion = f_nombre_contaplan(apu.ejercicio,codigo_empresa,cuenta_gasto)+" fra:"+facturas+" "+f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
		apu.documento  = ""
		apu.factura    = ""
		apu.ffactura   = DateTime(Date(em_fcobro.text))
		apu.cuenta     = f_cuenta_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
		IF Not f_insert_contaapun(apu) Then bien = 1		
		//Apunte a la cuenta de gastos				
		apu.apunte     = apu.apunte + 1	
		apu.cuenta     = cuenta_gasto
		apu.cambio     = Dec(em_cambio.text)
		apu.divisas    = importe * apu.cambio 
		apu.debe       = importe
		apu.haber      = 0
		apu.concepto   = ""
		apu.ampliacion = f_nombre_contaplan(apu.ejercicio,codigo_empresa,cuenta_gasto)+" fra:"+facturas+" "+f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
		apu.documento  = ""
		apu.factura    = ""
		apu.ffactura   = DateTime(Date(em_fcobro.text))
		IF Not f_insert_contaapun(apu) Then bien = 1		
	end if
next

//-----------------------------------------------------------------
dif = round(dec(em_importe.text),2) - round(acu,2)

//-----------------------------------------------------------------


IF dif <> 0 Then
	IF dif < 0 THEN
		cuenta_dif = "6680000001"
	ELSE
		cuenta_dif = "7680000001"
	END IF

	//Apunte a la cuenta del cliente por el importe de la diferencia
	apu.apunte     = apu.apunte + 1	
	IF dif < 0 then 
		apu.debe = 0
		apu.haber= ABS(dif)
	else
		apu.debe = ABS(dif)
		apu.haber= 0
	end if	
	apu.cambio     = Dec(em_cambio.text)
	apu.divisas    = Abs(dif * apu.cambio) 
	apu.concepto   = ""
	apu.ampliacion = f_nombre_contaplan(apu.ejercicio,codigo_empresa,cuenta_dif)+" fra:"+facturas+" "+f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
	apu.documento  = ""
	apu.factura    = ""
	apu.ffactura   = DateTime(Date(em_fcobro.text))
	apu.cuenta     = f_cuenta_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
	//Lo quitamos el 30-01-2017 Paco Marin
	// David 26-08-02. Si cobramos el efecto en la fecha de vencimiento (sin haberlo descontado previamente) 
	// tendremos que hacer cargo al cuenta de ECC
//	if cbx_ecc.checked then
//		apu.cuenta    =  f_venclientes_cuenta_ecc(codigo_empresa,dw_selecion.GetItemString(i,"cliente"))//f_comp_cta_riesgo_431x("4310000000",apu.cuenta)
//	end if
	//Lo quitamos el 30-01-2017 Paco Marin
//	if not f_Existe_cuenta(ejercicio_activo, codigo_empresa, apu.cuenta) then   				// Nuevo 17-06--2014
//		bien = 1																									// Nuevo 17-06--2014
//		messagebox ("Atención", " La cuenta "+apu.cuenta+" no existe en el PGC")			// Nuevo 17-06--2014
//	else																											// Nuevo 17-06--2014
		IF Not f_insert_contaapun(apu) Then bien = 1
//	end if																											// Nuevo 17-06--2014

	//Apunte a la cuenta de diferencias de cambio
	apu.apunte = apu.apunte + 1	
	apu.cuenta = cuenta_dif
	apu.cambio = Dec(em_cambio.text)
	apu.divisas = Abs(dif * apu.cambio) 	
	IF dif < 0 then 
		apu.debe = ABS(dif)
		apu.haber= 0
	else
		apu.debe = 0
		apu.haber= ABS(dif)
	end if
	apu.concepto   = ""
	apu.ampliacion = f_nombre_contaplan(apu.ejercicio,codigo_empresa,cuenta_dif)+" fra:"+facturas+" "+f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
	apu.documento  = ""
	apu.factura    = ""
	apu.ffactura   = DateTime(Date(em_fcobro.text))
	IF Not f_insert_contaapun(apu) Then bien = 1
END IF

total_selec = 0
total_por   = 0
total_reg   = 0

IF bien = 0 Then
	Return True
Else
	Return FALSE
END IF


end function

public function decimal f_total_gastos ();long indice,total
dec total_gastos,importe	

total_gastos = 0
total = dw_gastos.rowcount()
dw_gastos.accepttext()
for indice = 1 to total
	importe = dw_gastos.object.importe[indice]
	if isnull(importe) then importe = 0
	total_gastos = total_gastos + importe	
next
return total_gastos
end function

public function boolean f_grabar_apunte_viejo ();

Integer   bien
Dec acu,i,registros,dif
String  ampli
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
//	apu.apunte      = 1
//ELSE
//	apu.asiento = Dec(em_asiento.text)
//	Select Max(contaapun.apunte) Into :apu.apunte From contaapun
//	Where  contaapun.ejercicio = :apu.ejercicio
//	And    contaapun.empresa   = :apu.empresa
//	And    contaapun.mes       = :apu.mes
//	And    contaapun.origen    = :apu.origen
//	And    contaapun.asiento   = :apu.asiento;
//	apu.apunte = apu.apunte + 1
//END IF
//

apu.asiento     = f_ultimo_asiento(apu.ejercicio,apu.empresa,apu.mes,apu.origen)
em_asiento.text = STring(apu.asiento,f_mascara_decimales(0))
apu.apunte      = 1


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
apu.imponible = 0
apu.actualizado = "N"
apu.cambio = Dec(em_cambio.text)
apu.divisas = Dec(em_total.text) / apu.cambio 
if dec(em_total.text)>0 then
	apu.debe = Dec(em_total.text)
   apu.haber= 0
else
	apu.debe = 0
   apu.haber= abs(Dec(em_total.text))
End if
apu.concepto = "53"
apu.ampliacion= "Fecha: "+ String(Date(em_fcobro.text),"dd-mm-yy")
apu.documento= ""
apu.factura  = ""
SetNull(apu.ffactura) 
apu.cuenta = f_cuenta_carbancos(codigo_empresa,uo_banco.em_codigo.text)
IF Not f_insert_contaapun(apu) Then bien = 1
acu = 0

// calculamos el total de las facturas
// para calcular porcentaje en comisiones
for i=1 to registros
	total_selec = total_selec + dw_selecion.GetItemNumber(i,"cancelado")
Next

total_por = (dec(em_importe.text)-total_selec)/total_selec

for i=1 to registros
	IF Not f_procesar_recibos(i) Then bien= 1
	apu.apunte = apu.apunte + 1	
	apu.cambio = dw_selecion.GetItemNumber(i,"cambio")
	apu.divisas = dw_selecion.GetItemNumber(i,"cancelado_divisas")
	apu.debe = 0
	apu.haber= dw_selecion.GetItemNumber(i,"cancelado")
	acu = acu + apu.haber
	apu.concepto = "40"
	apu.ampliacion= "Fecha: "+ String(Date(em_fcobro.text),"dd-mm-yy")
	apu.documento= dw_selecion.GetItemString(i,"fra")
	apu.factura  = dw_selecion.GetItemString(i,"fra")
	ampli = ampli +"-" + apu.factura
	apu.ffactura = dw_selecion.GetItemDateTime(i,"ffra")
	apu.cuenta = f_cuenta_genter(codigo_empresa,"C",dw_selecion.GetItemString(i,"cliente"))
	IF Not f_insert_contaapun(apu) Then bien = 1
	f_contador_procesos(i,registros)
Next


//-----------------------------------------------------------------

//Contabilizamos los gastos
long indice,total
dec importe	

total = dw_gastos.rowcount()
dw_gastos.accepttext()
for indice = 1 to total
	importe    = dw_gastos.object.importe[indice]
	apu.cuenta = dw_gastos.object.cuenta_gasto[indice]
	if isnull(apu.cuenta) then apu.cuenta = ""
	if isnull(importe) then importe = 0
	if importe <> 0 and trim(apu.cuenta) <> "" then
		apu.apunte     = apu.apunte + 1	
		apu.cambio     = Dec(em_cambio.text)
		apu.divisas    = importe / apu.cambio 
		apu.debe       = importe
		apu.haber      = 0
		apu.concepto   = ""
		apu.ampliacion = ampli 
		apu.documento  = ""
		apu.factura    = ""
		apu.ffactura   = DateTime(Date(em_fcobro.text))
		IF Not f_insert_contaapun(apu) Then bien = 1		
	end if
next

//////////
//IF Dec(em_gastos.text) <> 0 Then
//	apu.apunte = apu.apunte + 1	
//	apu.cambio = Dec(em_cambio.text)
//	apu.divisas = Dec(em_gastos.text) / apu.cambio 
//	apu.debe = Dec(em_gastos.text)
//	apu.haber= 0
//	apu.concepto = ""
//	apu.ampliacion= ampli 
//	apu.documento= ""
//	apu.factura  = ""
//	apu.ffactura =DateTime(Date(em_fcobro.text))
//	apu.cuenta = "669000003"
//	IF Not f_insert_contaapun(apu) Then bien = 1
//END IF
//////////

//-----------------------------------------------------------------
dif = Dec(em_importe.text) - acu
//-----------------------------------------------------------------
IF dif <> 0 Then
	IF dif < 0 THEN
		apu.cuenta = "66800001"
	ELSE
		apu.cuenta = "76800001"
	END IF
	apu.apunte = apu.apunte + 1	
	apu.cambio = Dec(em_cambio.text)
	apu.divisas = Abs(dif / apu.cambio) 
	
	IF dif < 0 then 
		apu.debe = ABS(dif)
		apu.haber= 0
	else
		apu.debe = 0
		apu.haber= ABS(dif)
	end if
	apu.concepto   = ""
	apu.ampliacion = ampli
	apu.documento  = ""
	apu.factura    = ""
	apu.ffactura   = DateTime(Date(em_fcobro.text))
	IF Not f_insert_contaapun(apu) Then bien = 1
END IF

total_selec = 0
total_por   = 0
total_reg   = 0

IF bien = 0 Then
	Return True
Else
	Return FALSE
END IF


end function

protected function boolean f_procesar_recibos (integer i);dec      divisas_efecto,cambio_cobro
long     anyo_efecto,orden_efecto
string   banco
datetime fecha_cobro
boolean  lb_correcto = true

cambio_cobro   = Dec(em_cambio.text)
anyo_efecto    = dw_selecion.GetItemnumber(i,"anyo")
orden_efecto   = dw_selecion.GetItemnumber(i,"orden")
divisas_efecto = round(dw_selecion.GetItemnumber(i,"cancelado_divisas"),2)
banco          = uo_banco.em_codigo.text
fecha_cobro    = datetime(date(em_fcobro.text))

if not(f_cobrar_efecto(codigo_empresa,anyo_efecto,orden_efecto,divisas_efecto,cambio_cobro,fecha_cobro,banco)) then
	lb_correcto = false
end if

return lb_correcto

//Viejo 11-12-2017
//str_carhistorico historico
//int  bien = 0
//dec camb,j1,v_gastos_fletes,v_cambiofra,v_comision,v_comisionliqui,v_comisionliquipts
//dec fac,v_baseliqui,v_baseliquipts,v_comisiones
//dec anyo_efecto,orden_efecto,linea_efecto
//dec importe_nuevo
//dec{0} v_linea
//string borrar,v_moneda
//
//camb = Dec(em_cambio.text)
//v_moneda = uo_moneda.em_codigo.text
//anyo_efecto=dw_selecion.GetItemnumber(i,"anyo")
//orden_efecto=dw_selecion.GetItemnumber(i,"orden")
//importe_nuevo= round(dw_selecion.GetItemnumber(i,"cancelado_divisas"),2)
//historico.fcobro    = datetime(date(em_fcobro.text))
//
//// Selecciono datos del efecto AGRUPADO y los inserto en carhistorico 
//SELECT	carefectos.anyofra,carefectos.factura,carefectos.recibo,
//			carefectos.fvto, carefectos.fvto_original, carefectos.ffra,  
//			carefectos.importe,carefectos.divisas,carefectos.monedas,
//			carefectos.fpago,carefectos.tipodoc,carefectos.banco,   
//			carefectos.remesa,carefectos.fremesa,
//			carefectos.agente1,carefectos.pais,carefectos.cuenta,   
//			carefectos.domiciliacion,carefectos.Nacional,
//			carefectos.observaciones,carefectos.libre,carefectos.gasto,   
//			carefectos.fdevolucion,carefectos.agrupado,   
//			carefectos.efectoagrupa,carefectos.anyoagrupa,
//			carefectos.cliente,carefectos.anyo_remesa ,
//			carefectos.comision11,carefectos.comision12,carefectos.comision21,
//			carefectos.comision22,carefectos.comision31,carefectos.comision32,
//			carefectos.agente2,carefectos.agente3,carefectos.cambio,carefectos.serie, fecha_Recibido, banco_docu
// INTO 	:historico.anyofra,:historico.factura,:historico.recibo,   
//			:historico.fvto, :historico.fvto_original, :historico.ffra,
//			:historico.importe,:historico.divisas,:historico.monedas,   
//			:historico.fpago,:historico.tipodoc,:historico.banco,   
//			:historico.remesa,:historico.fremesa,  
//			:historico.agente1,:historico.pais,:historico.cuenta,   
//			:historico.domiciliacion,:historico.nacional,   
//			:historico.observaciones,:historico.libre,:historico.gasto,   
//			:historico.fdevolucion,:historico.agrupado,
//			:historico.efectoagrupa,:historico.anyoagrupa,   
//			:historico.cliente,:historico.anyo_remesa,
//			:historico.comision11,:historico.comision12,:historico.comision21,
//			:historico.comision22,:historico.comision31,:historico.comision32,
//			:historico.agente2,:historico.agente3,:historico.cambio,:historico.serie, :historico.fecha_recibido, :historico.banco_Docu
//FROM  carefectos  
//WHERE carefectos.empresa = :codigo_empresa
//AND   carefectos.anyo    = :anyo_efecto
//AND   carefectos.orden   = :orden_efecto;
//IF SQLCA.SQLCODE <> 0 Then bien = 1		
//	
//	
//IF IsNull(historico.agrupado) or Trim(historico.agrupado)= "" Then
//	historico.agrupado= "N"
//END IF
//
//
//// David 10-10-2011.  Pongo esto porque no se estaba grabando en el histórico el efecto agrupado.
//IF historico.agrupado = "S" then
//	historico.cambio_cobro = camb		
//	historico.empresa   = codigo_empresa
//	historico.anyo      = anyo_efecto 
//	historico.orden     = orden_efecto
//	historico.situacion = "9"
//	historico.fcobro    = datetime(date(em_fcobro.text))
//	
//	
//	SELECT max(carhistorico.linea )   INTO :linea_efecto    FROM carhistorico  
//	WHERE  carhistorico.empresa = :codigo_empresa 
//	AND    carhistorico.anyo    = :anyo_efecto 
//	AND    carhistorico.orden   = :orden_efecto ;
//	
//	if sqlca.sqlcode=100 then linea_efecto=0
//	if isnull(linea_efecto) then linea_efecto=0
//	historico.linea=linea_efecto + 1
//	
//	if not f_insert_carhistorico(historico) then bien=1
//	
//	IF SQLCA.SQLCODE <> 0 Then bien = 1
//end if
////  fin Pongo esto porque no se estaba grabando en el histórico el efecto agrupado.
//
//IF historico.agrupado <> "S" then
//	historico.cambio_cobro = camb		
//	historico.empresa   = codigo_empresa
//	historico.anyo      = anyo_efecto 
//	historico.orden     = orden_efecto
//	historico.situacion = "9"
//	historico.fcobro    = datetime(date(em_fcobro.text))
//	
//	IF historico.divisas <> importe_nuevo then
//		integer opcion
//		opcion=messagebox("Fra. "+historico.factura+" cancelada en parte"," Desea anular el resto.",question!,yesno!)
//		CHOOSE CASE opcion
//			case 1
//				historico.divisas=importe_nuevo
//				historico.importe=importe_nuevo / camb
//				borrar="SI"
//			case 2
//				historico.divisas=importe_nuevo
//				historico.importe=importe_nuevo / camb
//				borrar="NO"
//			case else
//				borrar="SI"
//		end choose
//	ELSE
//		borrar="SI"
//	END IF
//	
//	SELECT max(carhistorico.linea )   INTO :linea_efecto    FROM carhistorico  
//	WHERE  carhistorico.empresa = :codigo_empresa 
//	AND    carhistorico.anyo    = :anyo_efecto 
//	AND    carhistorico.orden   = :orden_efecto ;
//	
//	if sqlca.sqlcode=100 then linea_efecto=0
//	if isnull(linea_efecto) then linea_efecto=0
//	historico.linea=linea_efecto + 1
//	
//	if not f_insert_carhistorico(historico) then bien=1
//	
//
//
//	// Borro el efecto de carefectos
//	if borrar="SI" then
//		DELETE FROM carefectos  
//		WHERE carefectos.empresa = :codigo_empresa
//		AND   carefectos.anyo = :anyo_efecto 
//		AND  	carefectos.orden = :orden_efecto;
//		IF SQLCA.SQLCODE <> 0 Then bien = 1
//	else
//		UPDATE carefectos
//		SET    carefectos.divisas=carefectos.divisas - :importe_nuevo,
//				 carefectos.importe=(carefectos.divisas - :importe_nuevo) / :camb
//		WHERE  carefectos.empresa = :codigo_empresa 
//		AND   carefectos.anyo = :anyo_efecto 
//		AND   carefectos.orden = :orden_efecto;
//		IF SQLCA.SQLCODE <> 0 Then bien = 1
//	end if
//ELSE		
//	// Si el efecto es agrupado proceso el detalle
//		integer det_registros
//		String sel
//		DataStore   dw_cursor_agrupados
//		
//	
//		sel = " Select * from carefectos " + &
//				" where carefectos.empresa       =  '"+ codigo_empresa +"'"+&
//				" And   carefectos.situacion     =  '3' " + &
//				" And   carefectos.anyoagrupa    =  " + String(anyo_efecto,"####") +&
//				" And   carefectos.efectoagrupa  =  " + STRING(orden_efecto,"####") 
//		
//		//dw_cursor_agrupados= f_cargar_cursor2(sel)
//		f_cargar_cursor_nuevo(sel, dw_cursor_agrupados)
//		det_registros=dw_cursor_agrupados.rowcount()
//				// Selecciono datos del efecto y los inserto en carhistorico
//		integer r
//		dec det_anyo_efecto,det_orden_efecto,det_linea_efecto
//		str_carhistorico det_historico
//		IF det_registros = 0 Then
//			f_mensaje("Error","no hay registros como recibos agrupado")
//			bien = 1
//		END IF
//		for r=1 to det_registros
//			det_anyo_efecto  =dw_cursor_agrupados.GetItemNumber(r,"anyo")
//			det_orden_efecto =dw_cursor_agrupados.GetItemNumber(r,"orden")
//	  		
//	  		SELECT 	carefectos.anyofra,carefectos.factura,carefectos.recibo,
//						carefectos.fvto, carefectos.ffra, fvto_original,  
//						carefectos.importe,carefectos.divisas,carefectos.monedas,
//						carefectos.fpago,carefectos.tipodoc,carefectos.banco,   
//						carefectos.remesa,carefectos.fremesa,
//						carefectos.agente1,carefectos.pais,carefectos.cuenta,   
//						carefectos.domiciliacion,carefectos.Nacional,
//						carefectos.observaciones,carefectos.libre,carefectos.gasto,   
//						carefectos.fdevolucion,carefectos.agrupado,   
//						carefectos.efectoagrupa,carefectos.anyoagrupa,
//						carefectos.cliente,carefectos.anyo_remesa, fecha_recibido, banco_docu  
//    			INTO
//						:det_historico.anyofra,:det_historico.factura,:det_historico.recibo,   
//						:det_historico.fvto,:det_historico.ffra, :det_historico.fvto_original,
//						:det_historico.importe,:det_historico.divisas,:det_historico.monedas,   
//						:det_historico.fpago,:det_historico.tipodoc,:det_historico.banco,   
//						:det_historico.remesa,:det_historico.fremesa,  
//						:det_historico.agente1,:det_historico.pais,:det_historico.cuenta,   
//						:det_historico.domiciliacion,:det_historico.nacional,   
//						:det_historico.observaciones,:det_historico.libre,:det_historico.gasto,   
//						:det_historico.fdevolucion,:det_historico.agrupado,
//						:det_historico.efectoagrupa,:det_historico.anyoagrupa,   
//						:det_historico.cliente,:det_historico.anyo_remesa, :historico.fecha_Recibido, :historico.banco_docu  
//    			FROM carefectos  
//   			WHERE  ( carefectos.empresa = :codigo_empresa ) AND  
//						( carefectos.anyo  = :det_anyo_efecto ) AND  
//						( carefectos.orden = :det_orden_efecto )   ;
//			IF SQLCA.SQLCODE <> 0 Then bien = 1
//			det_historico.empresa=codigo_empresa
//			det_historico.anyo=det_anyo_efecto 
//			det_historico.orden=det_orden_efecto
//			det_historico.fcobro=historico.fcobro
//			det_historico.situacion="3"
//			
//	  		SELECT max(carhistorico.linea )  
//			INTO :det_linea_efecto  
//			FROM carhistorico  
//			WHERE 	( carhistorico.empresa = :codigo_empresa ) AND  
//						( carhistorico.anyo = :det_anyo_efecto ) AND  
//						( carhistorico.orden = :det_orden_efecto )   ;
//						
//			if sqlca.sqlcode=100 then det_linea_efecto=0
//			if isnull(det_linea_efecto) then det_linea_efecto=0
//			det_historico.linea=det_linea_efecto + 1
//			
//			if not f_insert_carhistorico(det_historico) then bien=1
//					
//			// borro el detalle de carefectos
//	
//			DELETE FROM carefectos  
//				WHERE carefectos.empresa = :codigo_empresa 
//			AND   carefectos.anyo = :det_anyo_efecto 
//			AND   carefectos.orden = :det_orden_efecto    ;
//			IF SQLCA.SQLCODE <> 0 Then bien = 1
//		next
//		// Despues de eliminar el detalle elimino el agrupado
//		DELETE FROM carefectos  
//   		WHERE carefectos.empresa = :codigo_empresa
//		AND   carefectos.anyo = :anyo_efecto 
//		AND  	carefectos.orden = :orden_efecto;
//		IF SQLCA.SQLCODE <> 0 Then bien = 1
//End if
////  Fin cancelacion agrupados
//
//// COMPRUEBO SI QUEDA ALGÚN RECIBO POR COBRAR
//long cuantos_recibos = 0
//SELECT COUNT(carefectos.recibo)  
//INTO :cuantos_recibos  
//FROM carefectos  
//WHERE ( carefectos.empresa = :codigo_empresa ) AND  
//		( carefectos.anyofra = :historico.anyofra ) AND  
//		( carefectos.factura = :historico.factura )   ;
//	
//fac=Dec(historico.factura)
//
//
//if isnull(cuantos_Recibos) then cuantos_recibos = 0
////David
////if cuantos_recibos > 0 then
//if cuantos_recibos = 0 then
//	Update 	carcomisiones 
//	Set    	carcomisiones.cobrado          = "S",
//			carcomisiones.fcobro			  = :historico.fcobro
//	Where  	carcomisiones.empresa = :codigo_empresa
//	ANd    	carcomisiones.anyo    = :historico.anyofra
//	And    	carcomisiones.factura = :fac;
//	IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en fproceso_recibos",sqlca.sqlerrtext)
//end if
//
//// Busco si hay mas efectos con ese nº de remesa. En caso de ser el
//// último pongo carremesas en situacion de cancelada
//
//int hay
//
//SELECT Count(*) INTO :hay FROM carefectos
//WHERE carefectos.empresa 		= :codigo_empresa
//AND   carefectos.banco	 		= :historico.banco
//AND   carefectos.anyo_remesa 	= :historico.anyo_remesa
//AND   carefectos.remesa			= :historico.remesa;
//
//IF IsNull(hay) THEN hay = 0
//
//IF hay = 0 THEN
//	UPDATE carremesas SET carremesas.situacion = '5'
//	WHERE carremesas.empresa		= :codigo_empresa
//	AND   carremesas.anyo			= :historico.anyo_remesa
//	AND   carremesas.banco			= :historico.banco
//	AND   carremesas.naci_extra 	= "N"
//	AND   carremesas.remesa			= :historico.remesa;
//END IF
//	
//// if sqlca.sqlcode=100 or cuantos_recibos=0 or isnull(cuantos_recibos) then
////			// PASO A CARCOMISIONES COMO COBRADO
////
////			fac=Dec(historico.factura)
////			
////			Select sum(carhistorico.divisas),sum(carhistorico.importe) 
////			Into   :v_baseliqui,:v_baseliquipts From carhistorico
////			Where  carhistorico.empresa = :codigo_empresa
////			And    carhistorico.anyo    = :historico.anyofra
////			And    carhistorico.factura = :historico.factura
////			And    carhistorico.situacion = "9";
////	
////			//----------------------
////			// recalculo comisiones
////			//-----------------------
////			
////			DataStore dw 
////			String selo
////			Selo = " Select * From  carcomisiones   " +&
////					 " Where  carcomisiones.empresa = '"+codigo_empresa + "'" +&
////					 " ANd    carcomisiones.anyo    = "+ String(historico.anyofra,"####") +&
////					 " And    carcomisiones.factura = " + String(fac ,"########")
////			
////			dw = f_cargar_cursor2(selo)
////			
////			dec v_baseliqui_total,v_baseliquipts_total
////			
////			v_baseliqui_total = v_baseliqui
////			v_baseliquipts_total = v_baseliquipts
////			
////			
////			IF dw.RowCount() <> 0 Then
////				For j1 = 1 To dw.RowCount()
////						if total_reg=1 then
////								v_baseliqui     = dec(string(em_divisas.text,f_mascara_moneda(v_moneda)))
////								v_baseliquipts  = dec(string(em_importe.text,'###,###,###'))
////						  else
////								v_baseliqui     = dec(string(v_baseliqui_total    + (v_baseliqui_total*total_por),f_mascara_moneda(v_moneda)))
////								v_baseliquipts  = dec(string(v_baseliquipts_total + (v_baseliquipts_total*total_por),'###,###,###,###'))
////						END IF		
////						
////								
////						v_gastos_fletes	 = dw.GetItemNumber(j1,"gastos_fletes")
////						IF IsNull(v_gastos_fletes) then v_gastos_fletes=0
////						v_comision			 = dw.GetItemNumber(j1,"comision")
////						v_moneda           = dw.GetItemString(j1,"moneda")
////						v_linea            = dw.GetItemNumber(j1,"linea")
////												
////						v_baseliqui        = Dec(String(v_baseliqui - (v_gastos_fletes/camb),f_mascara_moneda(v_moneda)))
////						v_baseliquipts     = Dec(String(v_baseliquipts - v_gastos_fletes,f_mascara_decimales(0)))
////						v_comisionliqui    = Dec(String(v_baseliqui * v_comision / 100,f_mascara_moneda(v_moneda)))
////						v_comisionliquipts = Dec(String(v_baseliquipts * v_comision / 100,f_mascara_decimales(0)))
////						
////						Update carcomisiones 
////						Set    carcomisiones.cobrado          = "S",
////								 carcomisiones.baseliqui        = :v_baseliqui,
////								 carcomisiones.baseliquipts     = :v_baseliquipts,
////								 carcomisiones.comisionliqui    = :v_comisionliqui,
////								 carcomisiones.comisionliquipts = :v_comisionliquipts
////						Where  carcomisiones.empresa = :codigo_empresa
////						ANd    carcomisiones.anyo    = :historico.anyofra
////						And    carcomisiones.factura = :fac
////						And    carcomisiones.linea   = :v_linea;
////						  IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en fproceso_recibos",sqlca.sqlerrtext)
////					Next
////				END IF
////END IF
//
//destroy dw_cursor_agrupados
//IF bien =0 Then
//	RETURN TRUE
//ELSE
//	RETURN FALSE
//END IF
end function

public function boolean f_comprobar_existencias_cuentas (string cliente);//string cuenta
//
//cuenta = ''
//if cbx_ecc.checked then
////	cuenta = f_cuenta_genter(codigo_empresa,"C",cliente)
////	cuenta = f_comp_cta_riesgo_431x("4310000000", cuenta)
//	
//	select cuenta_ecc 
//	into :cuenta
//	from venclientes
//	where empresa = :codigo_empresa
//	and codigo = :cliente;
//	
//	if isnull (cuenta) or cuenta = '' then
//		return false
//	end if
//	
//end if
//
//if not f_Existe_cuenta(ejercicio_activo, codigo_empresa, cuenta) then   				
//	return false
//end if

return true

end function

event close;call super::close;//dw_detalle.reset()
//dw_listado.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="COBROS"
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
em_fvto.text = String(Today(),"dd-mm-yy")
em_fapunte.text = String(Today(),"dd-mm-yy")
dw_detalle.SetTransObject(SQLCA)
dw_gastos.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"nuevo",f_mascara_decimales(2))
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

on w_cobro_recibos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_procesar=create cb_procesar
this.cb_2=create cb_2
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
this.em_gastos=create em_gastos
this.st_pts2=create st_pts2
this.st_9=create st_9
this.ln_1=create ln_1
this.st_pts3=create st_pts3
this.st_8=create st_8
this.dw_selecion=create dw_selecion
this.gb_1=create gb_1
this.rb_pendientes=create rb_pendientes
this.cb_gastos=create cb_gastos
this.dw_gastos=create dw_gastos
this.em_total=create em_total
this.cbx_ecc=create cbx_ecc
this.dw_detalle=create dw_detalle
this.cbx_devuelto=create cbx_devuelto
this.st_2=create st_2
this.st_10=create st_10
this.em_fvto=create em_fvto
this.cbx_mostrar_anticipados=create cbx_mostrar_anticipados
this.cbx_mostrar_factorizados=create cbx_mostrar_factorizados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.em_asiento
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_fapunte
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_11
this.Control[iCurrent+10]=this.uo_banco
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.em_fcobro
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.em_divisas
this.Control[iCurrent+15]=this.uo_ejercicio
this.Control[iCurrent+16]=this.cb_salir
this.Control[iCurrent+17]=this.cb_borrar
this.Control[iCurrent+18]=this.st_22
this.Control[iCurrent+19]=this.uo_moneda
this.Control[iCurrent+20]=this.st_moneda
this.Control[iCurrent+21]=this.em_importe
this.Control[iCurrent+22]=this.st_pts
this.Control[iCurrent+23]=this.em_cambio
this.Control[iCurrent+24]=this.st_7
this.Control[iCurrent+25]=this.em_gastos
this.Control[iCurrent+26]=this.st_pts2
this.Control[iCurrent+27]=this.st_9
this.Control[iCurrent+28]=this.ln_1
this.Control[iCurrent+29]=this.st_pts3
this.Control[iCurrent+30]=this.st_8
this.Control[iCurrent+31]=this.dw_selecion
this.Control[iCurrent+32]=this.gb_1
this.Control[iCurrent+33]=this.rb_pendientes
this.Control[iCurrent+34]=this.cb_gastos
this.Control[iCurrent+35]=this.dw_gastos
this.Control[iCurrent+36]=this.em_total
this.Control[iCurrent+37]=this.cbx_ecc
this.Control[iCurrent+38]=this.dw_detalle
this.Control[iCurrent+39]=this.cbx_devuelto
this.Control[iCurrent+40]=this.st_2
this.Control[iCurrent+41]=this.st_10
this.Control[iCurrent+42]=this.em_fvto
this.Control[iCurrent+43]=this.cbx_mostrar_anticipados
this.Control[iCurrent+44]=this.cbx_mostrar_factorizados
end on

on w_cobro_recibos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_procesar)
destroy(this.cb_2)
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
destroy(this.em_gastos)
destroy(this.st_pts2)
destroy(this.st_9)
destroy(this.ln_1)
destroy(this.st_pts3)
destroy(this.st_8)
destroy(this.dw_selecion)
destroy(this.gb_1)
destroy(this.rb_pendientes)
destroy(this.cb_gastos)
destroy(this.dw_gastos)
destroy(this.em_total)
destroy(this.cbx_ecc)
destroy(this.dw_detalle)
destroy(this.cbx_devuelto)
destroy(this.st_2)
destroy(this.st_10)
destroy(this.em_fvto)
destroy(this.cbx_mostrar_anticipados)
destroy(this.cbx_mostrar_factorizados)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cobro_recibos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cobro_recibos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cobro_recibos
integer x = 5
integer y = 4
integer width = 4146
integer height = 76
end type

type pb_1 from upb_salir within w_cobro_recibos
integer x = 4146
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

event clicked;If conexion = "N" Then
	Close (Parent)
Else
	CloseWithReturn(Parent,em_asiento.text)
End If
end event

type cb_procesar from commandbutton within w_cobro_recibos
event clicked pbm_bnclicked
integer x = 3035
integer y = 2348
integer width = 603
integer height = 96
boolean bringtotop = true
integer textsize = -6
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Procesar"
end type

event clicked;long registros
integer i,bien
Dec  dif,acu
bien=0
dif = 0
f_pro()
registros=dw_selecion.rowcount()
iF registros = 0 Then Return
//Comprobamos que la suma de los efectos cuadre con el importe que ponemos a mano.
IF Dec(em_cambio.text) = 1 Then
		IF dw_selecion.GetItemNumber(1,"total_cancelacion") <> Dec(em_importe.text) Then
		   if messagebox("Error en Introduccion de datos","Los totales no coinciden"+char(13)+char(13)+"¿Es diferencia de cambio?",question!,YesNO!,1)<>1 then
		     f_activar_campo(uo_cliente.em_campo)
		     Return				
		   End if
   	END IF
END IF

IF Not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),datetime(date(em_fapunte.text))) Then Return
IF Not f_grabar_apunte() Then bien = 1

If bien <> 0  Then
	RollBack;
	f_mensaje("Error en proceso","El proceso no se actualiza(" +sqlca.sqlerrtext+")")
ELSE
	Commit;
	dw_gastos.reset()
	em_gastos.text = ""
END IF
cb_salir.triggerEvent(Clicked!)


end event

type cb_2 from commandbutton within w_cobro_recibos
integer x = 1947
integer y = 288
integer width = 283
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;f_activar_campo(uo_cliente.em_campo)
f_activar(FALSE)
f_control()

end event

type uo_cliente from u_em_campo_2 within w_cobro_recibos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 229
integer y = 184
integer width = 1303
integer height = 80
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,'C',uo_cliente.em_codigo.text)
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

type em_asiento from u_em_campo within w_cobro_recibos
integer x = 3968
integer y = 372
integer width = 293
integer taborder = 0
boolean enabled = false
alignment alignment = right!
end type

type st_3 from statictext within w_cobro_recibos
integer x = 3689
integer y = 372
integer width = 279
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string pointer = "\BMP\Mano.cur"
long textcolor = 33554432
long backcolor = 12632256
string text = "Asiento:"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;em_asiento.text = ""
end event

type em_fapunte from u_em_campo within w_cobro_recibos
integer x = 3968
integer y = 284
integer width = 293
integer taborder = 0
boolean bringtotop = true
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_4 from statictext within w_cobro_recibos
integer x = 3680
integer y = 296
integer width = 288
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F.Apunte:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within w_cobro_recibos
integer x = 27
integer y = 96
integer width = 187
integer height = 76
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

type uo_banco from u_em_campo_2 within w_cobro_recibos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 224
integer y = 96
integer width = 1307
integer height = 72
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;dw_gastos.reset()
uo_banco.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco.em_codigo.text)
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

type st_5 from statictext within w_cobro_recibos
integer x = 1550
integer y = 96
integer width = 224
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
string text = "F.Cobro:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fcobro from u_em_campo within w_cobro_recibos
integer x = 1883
integer y = 88
integer width = 352
integer height = 76
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
boolean dropdowncalendar = true
end type

event modificado;call super::modificado;em_fapunte.text = this.text
end event

type st_6 from statictext within w_cobro_recibos
integer x = 2267
integer y = 192
integer width = 201
integer height = 72
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

type em_divisas from u_em_campo within w_cobro_recibos
integer x = 2473
integer y = 192
integer width = 366
integer height = 72
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = styleraised!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.##"
end type

event modificado;call super::modificado;//em_importe.text = String(dec(em_importe.text),f_mascara_moneda(uo_moneda.em_codigo.text))
if Dec(em_cambio.text) <> 0 then
	em_importe.text = String(Dec(em_divisas.text) / Dec(em_cambio.text),f_mascara_decimales(2))
else
	messagebox("ERROR", "La moneda no tiene el cambio definido")
end if

em_total.text   = String(Dec(em_importe.text) - Dec(em_gastos.text),f_mascara_decimales(2))
end event

type uo_ejercicio from u_ejercicio within w_cobro_recibos
integer x = 3630
integer y = 100
integer height = 176
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type cb_salir from commandbutton within w_cobro_recibos
event clicked pbm_bnclicked
integer x = 3035
integer y = 2440
integer width = 603
integer height = 96
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;dw_detalle.Reset()
dw_selecion.Reset()
f_activar(TRUE)
//em_cambio.text = ""
//em_divisas.text = ""
//em_gastos.text = ""
//em_importe.text = ""
//em_total.text = ""
//uo_banco.em_campo.text = ""
//uo_cliente.em_campo.text = ""
//uo_moneda.em_campo.text = ""
//uo_banco.em_codigo.text = ""
//uo_cliente.em_codigo.text = ""
//uo_moneda.em_codigo.text = ""
f_activar_campo(uo_banco.em_campo)
end event

type cb_borrar from commandbutton within w_cobro_recibos
event clicked pbm_bnclicked
integer x = 3035
integer y = 2532
integer width = 603
integer height = 96
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Borrar"
end type

event clicked;IF dw_selecion.GetRow() = 0 Then Return
	dw_selecion.DeleteRow(dw_selecion.GetRow())
f_control2()
end event

type st_22 from statictext within w_cobro_recibos
integer x = 2254
integer y = 92
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

type uo_moneda from u_em_campo_2 within w_cobro_recibos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 2478
integer y = 92
integer width = 219
integer height = 72
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_moneda.em_campo.text=f_nombre_moneda_abr(uo_moneda.em_codigo.text)
st_moneda.text = f_nombre_moneda_abr(uo_moneda.em_codigo.text)

If Trim(uo_moneda.em_campo.text)<> "" then
	em_cambio.text = String(f_cambio_moneda(uo_moneda.em_codigo.text),f_mascara_decimales(4))
	em_divisas.TriggerEvent("modificado")
	em_importe.TriggerEvent("modificado")
	em_gastos.TriggerEvent("modificado")
end if

If Trim(uo_moneda.em_campo.text)="" then
	uo_moneda.em_campo.text=""
	uo_moneda.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo     = "Selección de Monedas"
ue_datawindow = "dw_ayuda_divisas"
valor_empresa = False
end event

on uo_moneda.destroy
call u_em_campo_2::destroy
end on

type st_moneda from statictext within w_cobro_recibos
integer x = 2853
integer y = 192
integer width = 242
integer height = 72
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

type em_importe from u_em_campo within w_cobro_recibos
integer x = 3118
integer y = 192
integer width = 421
integer height = 72
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = styleraised!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;if Dec(em_cambio.text) <> 0 then
	em_divisas.text = String(Dec(em_importe.text) * Dec(em_cambio.text),f_mascara_moneda(uo_moneda.em_codigo.text))
end if
em_total.text = String(Dec(em_importe.text) - Dec(em_gastos.text),f_mascara_decimales(2))
end event

type st_pts from statictext within w_cobro_recibos
integer x = 3543
integer y = 216
integer width = 114
integer height = 60
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
string text = "€"
boolean focusrectangle = false
end type

type em_cambio from u_em_campo within w_cobro_recibos
integer x = 2738
integer y = 92
integer width = 375
integer height = 72
integer taborder = 40
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

type st_7 from statictext within w_cobro_recibos
integer x = 2834
integer y = 280
integer width = 270
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

type em_gastos from u_em_campo within w_cobro_recibos
integer x = 3118
integer y = 268
integer width = 421
integer height = 72
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

type st_pts2 from statictext within w_cobro_recibos
integer x = 3543
integer y = 292
integer width = 114
integer height = 60
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
string text = "€"
boolean focusrectangle = false
end type

type st_9 from statictext within w_cobro_recibos
integer x = 2898
integer y = 396
integer width = 210
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
string text = "Liquido:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ln_1 from line within w_cobro_recibos
long linecolor = 33554432
integer linethickness = 8
integer beginx = 3095
integer beginy = 368
integer endx = 3543
integer endy = 368
end type

type st_pts3 from statictext within w_cobro_recibos
integer x = 3543
integer y = 388
integer width = 114
integer height = 60
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
string text = "€"
boolean focusrectangle = false
end type

type st_8 from statictext within w_cobro_recibos
integer x = 2679
integer y = 104
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

type dw_selecion from u_datawindow_consultas within w_cobro_recibos
integer y = 2032
integer width = 2427
integer height = 1008
integer taborder = 0
string dataobject = "dw_cobros_recibos1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_cobro_recibos
integer x = 3022
integer y = 2308
integer width = 631
integer height = 336
integer textsize = -6
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type rb_pendientes from checkbox within w_cobro_recibos
integer x = 37
integer y = 300
integer width = 869
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mostrar Pendientes de Recibir"
boolean checked = true
boolean lefttext = true
end type

event clicked;if this.checked then
	cbx_mostrar_anticipados.checked = false
end if
end event

type cb_gastos from commandbutton within w_cobro_recibos
integer x = 2473
integer y = 260
integer width = 347
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle Gtos"
end type

event clicked;long donde
string moneda = "1"
if dw_gastos.rowcount() > 0 then
	dw_gastos.visible = true
	dw_gastos.enabled = true
	dw_gastos.setfocus()	
else
	dw_gastos.retrieve(codigo_empresa,moneda,dec(uo_ejercicio.em_ejercicio.text))
	donde = dw_gastos.insertrow(0)
	dw_gastos.setrow(donde)
	dw_gastos.setcolumn("cuenta_gasto")
	dw_gastos.visible = true
	dw_gastos.enabled = true
	dw_gastos.setfocus()
end if
end event

type dw_gastos from u_datawindow within w_cobro_recibos
boolean visible = false
integer x = 1079
integer y = 256
integer width = 1499
integer height = 668
integer taborder = 100
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "Introducción de gastos"
string dataobject = "dw_int_gastos_cobro_recibo"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;long donde
choose case f_objeto_datawindow(this)
	case "anyadir"
		this.enabled = false
		donde = this.insertrow(0)
		this.setrow(donde)
		this.setcolumn("cuenta_gasto")	
		this.enabled = true	
		this.setfocus()			
	case "borrar"		
		if this.getrow() <> 0 then
			this.deleterow(this.getrow())
		end if
	case "salir"
		this.visible = false
		this.enabled = false
		em_gastos.text  = string(f_total_gastos(),f_mascara_decimales(2))		
		em_importe.text = String(Dec(em_total.text) + Dec(em_gastos.text),f_mascara_decimales(2))
		em_total.triggerevent("modificado")
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;string cuenta
long ejercicio
Boolean 	existe
IF GetRow()<> 0 THEN
	if this.enabled then
		ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
		cuenta    = this.object.cuenta_gasto[GetRow()]
		existe = f_existe_cuenta(ejercicio,codigo_empresa,cuenta)
		IF Not existe THEN
			MessageBox("CONTROL DE DATOS","La cuenta Contable no existe",Exclamation!)
			this.SetColumn("cuenta_gasto")
		END IF
	end if
end if

end event

event rbuttondown;
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
   CASE "cuenta_gasto"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
		bus_datawindow = "dw_ayuda_contaplan_directo_sin_ej"
		bus_filtro     = "ejercicio = "+string(dec(uo_ejercicio.em_ejercicio.text))
 CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event key;long donde

//IF Not KeyDown(KeyEnter!) Then
	bus_filtro=""
	bus_campo = This.GetColumnName()
	CHOOSE CASE bus_campo
	CASE "cuenta_gasto"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS "
		bus_datawindow = "dw_ayuda_contaplan_directo_sin_ej"
		bus_filtro     = "ejercicio = "+string(dec(uo_ejercicio.em_ejercicio.text))
	CASE ELSE
		SetNull(bus_campo)
	END CHOOSE
	CALL Super::Key
//END IF
 
IF  KeyDown(Keyf2!) THEN
	this.enabled = false
	donde = this.insertrow(0)
	this.setrow(donde)
	this.setcolumn("cuenta_gasto")
	this.enabled = true	
	this.setfocus()	
end if
IF  KeyDown(Keyf3!) THEN
	if this.getrow() <> 0 then
		this.deleterow(this.getrow())
	end if	
end if

end event

type em_total from u_em_campo within w_cobro_recibos
integer x = 3118
integer y = 384
integer width = 421
integer height = 72
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

event modificado;call super::modificado;em_importe.text = String(Dec(em_total.text) + Dec(em_gastos.text),f_mascara_decimales(2))
if Dec(em_cambio.text) <> 0 then
	em_divisas.text = String(Dec(em_importe.text) * Dec(em_cambio.text),f_mascara_moneda(uo_moneda.em_codigo.text))
end if

end event

type cbx_ecc from checkbox within w_cobro_recibos
boolean visible = false
integer x = 3063
integer y = 2240
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -6
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388736
long backcolor = 12632256
string text = "Cancelar de ECC"
boolean lefttext = true
end type

type dw_detalle from datawindow within w_cobro_recibos
integer y = 496
integer width = 4265
integer height = 1472
string dataobject = "dw_cobros_recibos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;string moneda

This.AcceptText()
Dec e,r
if row > 0 then
	moneda = this.object.monedas[row]
end if
if moneda = uo_moneda.em_codigo.text then
	IF f_objeto_datawindow(dw_detalle) = "ok" Then f_pro()
	IF row <> 0 Then
		r = row
		IF f_objeto_datawindow(dw_detalle) = "libre" Then	
			IF dw_detalle.GetItemString(row,"libre") = "S" Then
				dw_detalle.SetItem(row,"libre","N")
					e = dw_selecion.find("anyo ="+String(dw_detalle.GetItemNumber(r,"anyo"),"####")+" and orden ="+String(dw_detalle.GetItemNumber(r,"orden"),"#####"),1,dw_selecion.RowCount())
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
end if
end event

event itemfocuschanged;This.AcceptText()
f_pro()
end event

event itemchanged;This.AcceptText()
f_pro()
end event

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
	an =this.GetItemNumber(row,"anyo")
	ord =this.GetItemNumber(row,"orden")
	
	str_parametros lstr_param 
	lstr_param.i_nargumentos=3
	lstr_param.s_argumentos[1]=codigo_empresa
	lstr_param.s_argumentos[2]=string(an)
	lstr_param.s_argumentos[3]=string(ord)
	
	OpenWithParm(w_detalle_agrupado,lstr_param)


End If
end event

type cbx_devuelto from checkbox within w_cobro_recibos
integer x = 951
integer y = 292
integer width = 869
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
string text = "Mostrar Devueltos"
boolean lefttext = true
end type

event clicked;if this.checked then
	cbx_mostrar_anticipados.checked = false
end if
end event

type st_2 from statictext within w_cobro_recibos
integer x = 27
integer y = 184
integer width = 187
integer height = 76
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
string text = "Cliente:"
boolean focusrectangle = false
end type

type st_10 from statictext within w_cobro_recibos
integer x = 1522
integer y = 184
integer width = 347
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
string text = "F.Vto. Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fvto from u_em_campo within w_cobro_recibos
integer x = 1883
integer y = 184
integer width = 352
integer height = 76
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
boolean dropdowncalendar = true
end type

type cbx_mostrar_anticipados from checkbox within w_cobro_recibos
integer x = 37
integer y = 376
integer width = 869
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mostrar Anticipados"
boolean lefttext = true
end type

event clicked;if this.checked then
	rb_pendientes.checked = false
	cbx_devuelto.checked = false
end if
end event

type cbx_mostrar_factorizados from checkbox within w_cobro_recibos
integer x = 951
integer y = 376
integer width = 869
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mostrar Factorizados"
boolean lefttext = true
end type

