$PBExportHeader$w_int_facturas_recibidas.srw
$PBExportComments$No se utiliza
forward
global type w_int_facturas_recibidas from w_int_con_empresa
end type
type pb_salir from upb_salir within w_int_facturas_recibidas
end type
type em_asiento from u_em_campo within w_int_facturas_recibidas
end type
type st_asiento from statictext within w_int_facturas_recibidas
end type
type em_fasiento from u_em_campo within w_int_facturas_recibidas
end type
type st_2 from statictext within w_int_facturas_recibidas
end type
type st_3 from statictext within w_int_facturas_recibidas
end type
type uo_origen from u_em_campo_2 within w_int_facturas_recibidas
end type
type pb_1 from upb_imprimir within w_int_facturas_recibidas
end type
type nombre_gasto from statictext within w_int_facturas_recibidas
end type
type nombre_proveedor from statictext within w_int_facturas_recibidas
end type
type dw_1 from datawindow within w_int_facturas_recibidas
end type
type dw_vto from datawindow within w_int_facturas_recibidas
end type
type cb_insertar from u_boton within w_int_facturas_recibidas
end type
type cb_borrar from u_boton within w_int_facturas_recibidas
end type
type cb_grabar from u_boton within w_int_facturas_recibidas
end type
type grabar from u_boton within w_int_facturas_recibidas
end type
type borrar from u_boton within w_int_facturas_recibidas
end type
type salir from u_boton within w_int_facturas_recibidas
end type
type dw_detalle from u_datawindow within w_int_facturas_recibidas
end type
type borrar_asiento from u_boton within w_int_facturas_recibidas
end type
type dw_listado2 from datawindow within w_int_facturas_recibidas
end type
type uo_ejercicio from u_ejercicio within w_int_facturas_recibidas
end type
type dw_apuntes from datawindow within w_int_facturas_recibidas
end type
type dw_temp from datawindow within w_int_facturas_recibidas
end type
end forward

global type w_int_facturas_recibidas from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3017
integer height = 1712
string title = "Consulta de Movimientos"
pb_salir pb_salir
em_asiento em_asiento
st_asiento st_asiento
em_fasiento em_fasiento
st_2 st_2
st_3 st_3
uo_origen uo_origen
pb_1 pb_1
nombre_gasto nombre_gasto
nombre_proveedor nombre_proveedor
dw_1 dw_1
dw_vto dw_vto
cb_insertar cb_insertar
cb_borrar cb_borrar
cb_grabar cb_grabar
grabar grabar
borrar borrar
salir salir
dw_detalle dw_detalle
borrar_asiento borrar_asiento
dw_listado2 dw_listado2
uo_ejercicio uo_ejercicio
dw_apuntes dw_apuntes
dw_temp dw_temp
end type
global w_int_facturas_recibidas w_int_facturas_recibidas

type variables
String Modo
DateTime vvto
boolean contado_o_fvto
end variables

forward prototypes
public subroutine f_cambio_linea (integer reg)
public subroutine f_nueva ()
public subroutine f_confirmar ()
public subroutine f_salir ()
public subroutine f_activar (boolean boo)
public function boolean f_control ()
public subroutine f_valores_fijos (integer reg)
public subroutine f_insertar_linea ()
public subroutine f_activar_linea (integer reg)
public subroutine f_borrar_linea ()
public subroutine f_ok ()
public function string f_tipo_cta (string cuenta)
public subroutine f_visualizar (datawindow data)
public subroutine f_vencimientos (string proveedor, decimal importe, string fra, datetime ffra)
public subroutine f_sacar_vencimientos (string proveedor, decimal importe, string fra, datetime ffra)
public subroutine f_guardar_vencimientos (string proveedor, decimal importe, string fra, datetime ffra)
public subroutine f_cargar_vencimientos (string proveedor, string fra, datetime ffra)
public function boolean f_grabar_pagos (string proveedor, string fra)
public function boolean f_limpiar_vencimientos ()
end prototypes

public subroutine f_cambio_linea (integer reg);Integer ln
String gasto,proveedor
dw_detalle.Accepttext()

if dw_detalle.RowCount() = 0 tHEN Return
iF IsNull(reg) Then Return
IF reg = 0 Then Return
ln = Integer(dw_detalle.Describe("DataWindow.LastRowOnPage"))
dw_detalle.AcceptText()
Dec ejer
ejer = Dec(uo_ejercicio.em_ejercicio.text)

gasto = dw_detalle.GetItemString(dw_detalle.GetRow(),"gasto")
nombre_gasto.text = "Gasto:  "+f_nombre_contaplan(ejer,codigo_empresa,gasto)

proveedor = dw_detalle.GetItemString(dw_detalle.GetRow(),"proveedor")
nombre_proveedor.text = "Proveedor:  " + f_nombre_contaplan(ejer,codigo_empresa,proveedor)

end subroutine

public subroutine f_nueva ();Dec reg
modo = "I"
IF dw_detalle.GetRow() <> dw_detalle.RowCount() Then Return
reg = dw_detalle.RowCount() + 1
dw_detalle.InsertRow(reg)
dw_detalle.SetRow(reg)
IF reg >1 Then
	IF Trim(dw_detalle.GetItemSTring(reg -1,"tipoiva")) = "" Then
		dw_detalle.SetItem(reg,"registro",dw_detalle.GetItemNumber(reg -1,"registro"))
	ELSE
		dw_detalle.SetItem(reg,"registro",dw_detalle.GetItemNumber(reg -1,"registro")+1)
	END IF
END IF
f_valores_fijos(reg)
f_activar_linea(reg)

end subroutine

public subroutine f_confirmar ();Dec bien = 0
Dec tot,t
STRING nombre_pago,ana

str_contaapun con
con.empresa   = codigo_empresa
con.origen    = uo_origen.em_codigo.text
con.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
con.mes       = Month(Date(em_fasiento.text))
con.fapunte = DateTime(Date(em_fasiento.text))
con.asiento = Dec(em_asiento.text)
Delete from contaapun
Where ejercicio = :con.ejercicio
And   empresa   = :con.empresa
And   mes       = :con.mes
And   origen    = :con.origen
And   asiento   = :con.asiento;
IF Sqlca.sqlcode <> 0 Then bien = 1

tot = dw_detalle.RowCount()
con.apunte = 0
con.concepto = "52"
For t = 1 To tot
	con.apunte     = con.apunte +1
	con.cuenta     = dw_detalle.GetItemSTring(t,"gasto")
	con.debe       = dw_detalle.GetItemNumber(t,"imponible")
	con.haber      = 0
	con.ampliacion = dw_detalle.GetItemString(t,"ampliacion")
	con.clipro     = dw_detalle.GetItemString(t,"codpro")
	con.documento  = dw_detalle.GetItemString(t,"factura")
	con.factura    = dw_detalle.GetItemString(t,"factura")
	con.ffactura   = dw_detalle.GetItemdateTime(t,"ffra")
	con.registro   = dw_detalle.GetItemNumber(t,"registro")
	SetNUll(con.tipoapu)
	SetNull(con.fregistro)
	con.tipoiva = dw_detalle.GetItemSTring(t,"tipoiva")
	con.iva = 0
	con.imponible = 0
	IF Not f_insert_contaapun(con) Then bien = 1
	IF dw_detalle.GetItemString(t,"tipoiva") <> "" Then
		con.apunte     = con.apunte +1
		con.cuenta     = f_ctaiva_contaiva(con.ejercicio,con.empresa,con.tipoiva)
		con.debe       = dw_detalle.GetItemNumber(t,"impiva")
		con.haber      = 0
		con.ampliacion = dw_detalle.GetItemString(t,"ampliacion")
		con.clipro     = dw_detalle.GetItemString(t,"codpro")
		con.documento  = dw_detalle.GetItemString(t,"factura")
		con.factura    = dw_detalle.GetItemString(t,"factura")
		con.ffactura   = dw_detalle.GetItemdateTime(t,"ffra")
		con.fregistro  = dw_detalle.GetItemdateTime(t,"ffra")
		con.registro   = dw_detalle.GetItemNumber(t,"registro")
		con.tipoapu    = f_libro_contaiva(con.ejercicio,con.empresa,con.tipoiva)
		con.tipoiva    = dw_detalle.GetItemSTring(t,"tipoiva")
		con.iva        = f_iva_contaiva(con.ejercicio,con.empresa,con.tipoiva)
		con.imponible  = dw_detalle.GetItemNumber(t,"totalfac") - dw_detalle.GetItemNumber(t,"impiva")
		con.clipro     = dw_detalle.GetItemSTring(t,"codpro") 
		Select cif Into :con.nif From genter
		Where  empresa = :codigo_empresa
		And    tipoter = "P"
		And    codigo  = :con.clipro;
		con.tipoter = "P"
		IF Not f_insert_contaapun(con) Then bien = 1
		
		
		IF Not f_grabar_pagos(dw_detalle.GetItemString(t,"codpro"),dw_detalle.GetItemString(t,"factura")) Then bien = 1		
		con.apunte     = con.apunte +1
		con.cuenta     = dw_detalle.GetItemString(t,"proveedor")
		con.debe       = 0
		con.haber      = dw_detalle.GetItemNumber(t,"totalfac")
		con.clipro     = dw_detalle.GetItemString(t,"codpro")
		nombre_pago    = f_nombre_carforpag(codigo_empresa,f_codpago_comprov(codigo_empresa,con.clipro))
		
		IF contado_o_fvto=True Then
			con.ampliacion = " Vto: " +String(date(vvto),"dd-mm-yyyy")
		ELSE
			con.ampliacion = " CONTADO"
		END IF
		
		con.documento  = dw_detalle.GetItemString(t,"factura")
		con.factura    = dw_detalle.GetItemString(t,"factura")
		con.ffactura   = dw_detalle.GetItemdateTime(t,"ffra")
		SetNUll(con.fregistro)
		con.registro   = dw_detalle.GetItemNumber(t,"registro")
		SetNull(con.tipoapu)
		con.tipoiva    = dw_detalle.GetItemSTring(t,"tipoiva")
		con.iva        = f_iva_contaiva(con.ejercicio,con.empresa,con.tipoiva)
		con.imponible  = dw_detalle.GetItemNumber(t,"totalfac") - dw_detalle.GetItemNumber(t,"impiva")
		con.clipro     = dw_detalle.GetItemSTring(t,"codpro") 
		Select cif Into :con.nif From genter
		Where  empresa = :codigo_empresa
		And    tipoter = "P"
		And    codigo  = :con.clipro;
		con.tipoter = "P"
		IF Not f_insert_contaapun(con) Then bien = 1

	END IF
Next

IF Not f_limpiar_vencimientos() Then bien = 1
//dw_detalle.Reset()
//em_asiento.text = ""
IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso","La operacion no se contabiliza")
END IF
IF Not f_asignacion_costes_asiento(con.ejercicio,con.empresa,con.mes,con.origen,con.asiento) Then
	// error al asignar el desglose analitico
END IF
	COMMIT;


f_activar(TRUE)
f_activar_campo(em_asiento)

end subroutine

public subroutine f_salir ();IF MessageBox("Salir del Asiento sin grabar","¿Salir sin grabar?",Question!,YesNo!)= 2 Then 
	Return
END IF
f_activar(TRUE)
dw_detalle.Reset()
em_asiento.text= ""
f_activar_campo(em_asiento)

end subroutine

public subroutine f_activar (boolean boo);em_asiento.enabled = boo
em_fasiento.enabled =boo
uo_origen.enabled =boo
uo_ejercicio.enabled = boo
pb_salir.enabled = boo
st_asiento.enabled = boo
pb_1.enabled = boo

end subroutine

public function boolean f_control ();Integer      r, r1 ,mes,nu,ejer
Dec reg,asto
String      cta,ncta,gasto,pro,origen
Dec debe,haber
r1 = dw_detalle.RowCount()
IF r1 = 0 Then Return False
For r = 1 To r1
	gasto   = dw_detalle.GetItemString(r,"gasto")
	IF IsNUll(gasto) or Trim(gasto) = "" Then 
		f_mensaje("Campo Obligatorio","Introducir Cuenta Contable")
		dw_detalle.SetFocus()
		dw_detalle.SetRow(r)
		dw_detalle.SetColumn("gasto")
		Return False
	END IF
	ncta = f_nombre_contaplan(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,gasto)
	IF IsNUll(ncta) or Trim(ncta) = "" Then 
		f_mensaje("Campo Obligatorio","Introducir Cuenta Contable")
		dw_detalle.SetFocus()
		dw_detalle.SetRow(r)
		dw_detalle.SetColumn("gasto")
		Return False
	END IF
	
// Control cta proveedor	
	IF Trim(dw_detalle.GetItemString(r,"tipoiva")) = "" or IsNUll(Trim(dw_detalle.GetItemString(r,"tipoiva"))) Then
//		IF r = dw_detalle.RowCount() Then
//			f_mensaje("Campo Obligatorio","Introducir tipo de iva")
//			dw_detalle.SetFocus()
//			dw_detalle.SetRow(r)
//			dw_detalle.SetColumn("tipoiva")
//			Return FAlse
//		END IF
	Else
		pro   = dw_detalle.GetItemString(r,"proveedor")
		IF IsNUll(pro) or Trim(pro) = "" Then 
			f_mensaje("Campo Obligatorio","Introducir Cuenta Contable")
			dw_detalle.SetFocus()
			dw_detalle.SetRow(r)
			dw_detalle.SetColumn("proveedor")
			Return False
		END IF
		ncta = f_nombre_contaplan(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,pro)
		IF IsNUll(ncta) or Trim(ncta) = "" Then 
			f_mensaje("Campo Obligatorio","Introducir Cuenta Contable")
			dw_detalle.SetFocus()
			dw_detalle.SetRow(r)
			dw_detalle.SetColumn("pro")
			Return False
		END IF
	END IF

	
Next
Return True
end function

public subroutine f_valores_fijos (integer reg);dw_detalle.SetItem(reg,"empresa",codigo_empresa)
dw_detalle.SetItem(reg,"ejercicio",Dec(uo_ejercicio.em_ejercicio.text))

end subroutine

public subroutine f_insertar_linea ();Integer r 
r = dw_detalle.GetRow()
IF r = 0 or r = 1 Then
	r = 1
ELSE
	r = r -1
END IF
dw_detalle.InsertRow(r)
f_valores_fijos(r)
f_activar_linea(r)

end subroutine

public subroutine f_activar_linea (integer reg);reg = dw_detalle.GetRow()
dw_detalle.SetFocus()
dw_detalle.ScrollToRow(reg)
IF reg = 1 Then
	dw_detalle.SetColumn("registro")
ELSE
	dw_detalle.SetColumn("gasto")
END IF

end subroutine

public subroutine f_borrar_linea ();Int r
r = dw_Detalle.getRow()
IF r =0 Then return
dw_detalle.DeleteRow(r)
IF dw_detalle.RowCount() = 0 Then 
	f_salir()
Else
	If dw_detalle.RowCount()< r Then r =  dw_detalle.RowCount()
	f_activar_linea(r)
END IF
end subroutine

public subroutine f_ok ();

end subroutine

public function string f_tipo_cta (string cuenta);IF (Mid(cuenta,1,7)= "4009000") Then	Return "G"
IF (Mid(cuenta,1,4)= "4109") Then	Return "G"
IF (Mid(cuenta,1,1)= "6"  or Mid(cuenta,1,2)= "48")   Then  Return "G"
IF (Mid(cuenta,1,2)= "40" or Mid(cuenta,1,2)= "41")  Then	Return "P"
IF (Mid(cuenta,1,2)= "47") Then	Return "I"
Return "G"
end function

public subroutine f_visualizar (datawindow data);dw_temp.Reset()
data.Retrieve(codigo_empresa,Dec(em_asiento.text),DateTime(Date(em_fasiento.text)))
DataStore d
String sel,ctaiva,proveedor,cuenta,tipoiva,numdoc,ante_numdoc,bus,con,codpro
STring gasto,an
STring ampliacion
Dec mes,j,cont,impiva,totalfac,importe,reg,congas,xx,la,ejer
Dec imponible
DateTime ffra
mes = Month(Date(em_fasiento.text))
ejer = Dec(uo_ejercicio.em_ejercicio.text)
congas = 0
ampliacion =  ""
imponible = 0
ante_numdoc = ""
gasto = ""
sel = " Select * from contaapun" + +&
      " Where ejercicio = "  + uo_ejercicio.em_ejercicio.text +&
		" And   empresa   = '" + codigo_empresa +"'" +&
		" And   origen    = '" + uo_origen.em_codigo.text +"'"+&
		" And   mes       = " + STring(mes) +&
		" And   asiento   = "  + String(Dec(em_asiento.text)) +&
		" order by ejercicio,empresa,origen,mes,asiento,apunte"
		
//d = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, d)

cont = 0
data.SetRedraw(FALSE)
For j = 1 To d.Rowcount()
	cuenta = d.GetItemString(j,"cuenta")
	codpro = d.GetItemString(j,"clipro")
	ffra = d.GetItemDateTime(j,"ffactura")
	numdoc = d.GetItemString(j,"documento")
	ampliacion = d.GetItemString(j,"ampliacion")
	importe= d.GetItemNumber(j,"debe")
	tipoiva = d.GetItemString(j,"tipoiva")
	reg = d.GetItemNumber(j,"registro")		
	IF importe = 0 Then importe = d.GetItemNumber(j,"haber")
	IF f_tipo_cta(cuenta) = "G" Then
		cont    = data.RowCount() +1
		data.InsertRow(cont)
	END IF
	IF f_tipo_cta(cuenta) = "G" Then
		gasto      = cuenta
		Select analitica Into :an from contaplan
		Where  ejercicio  = :ejer
		And    empresa    = :codigo_empresa
		And    cuenta     = :gasto;
		imponible  =  importe
		data.SetItem(cont,"gasto",gasto)
		data.SetItem(cont,"apunte",d.GetItemNumber(j,"apunte"))
		data.Object.analitica[cont] = an
		data.SetItem(cont,"imponible",imponible)
		data.SetItem(cont,"ampliacion",ampliacion)
	END IF
	IF f_tipo_cta(cuenta)= "P" Then	
		proveedor = cuenta
		data.SetItem(cont,"proveedor",proveedor)
		data.SetItem(cont,"factura",numdoc)
		data.SetItem(cont,"totalfac",importe)
		f_cargar_vencimientos(codpro,numdoc,ffra)
	END IF
	IF f_tipo_cta(cuenta)= "I" Then	
		impiva  = importe
		data.SetItem(cont,"impiva",impiva)
	END IF
		data.SetItem(cont,"empresa",codigo_empresa)
		data.SetItem(cont,"ejercicio",Dec(uo_ejercicio.em_ejercicio.text))
		data.SetItem(cont,"factura",numdoc)
//		data.SetItem(cont,"ampliacion",ampliacion)
		data.SetItem(cont,"ffra",ffra)
		data.SetItem(cont,"registro",reg)
		data.SetItem(cont,"tipoiva",tipoiva)
		data.SetItem(cont,"codpro",codpro)
	Next
	IF data.RowCOunt() <> 0 Then
		f_sacar_vencimientos(dw_detalle.GetItemString(1,"codpro"),dw_detalle.GetItemNumber(1,"totalfac"),dw_detalle.GetItemString(1,"factura"),dw_detalle.GetItemDateTime(1,"ffra"))
	END IF
data.SetRedraw(TRUE)
destroy d
end subroutine

public subroutine f_vencimientos (string proveedor, decimal importe, string fra, datetime ffra);Integer r,j,r2
Int bien
Dec cambio
bien = 0
str_vencimientos   vto
str_carpagos       car

For r2 = 1 To dw_temp.RowCOunt()
	IF dw_temp.GetItemString(r2,"proveedor") = proveedor and dw_temp.GetItemString(r2,"fra") = fra Then
		IF dw_temp.GetItemString(r2,"situacion") = "S" Then
			f_mensaje("Prevision cancelada","No se puede recalcular la prevision")
			Return
		END IF
	END IF
Next



For r2 = dw_temp.RowCOunt() To 1 step -1
	IF dw_temp.GetItemString(r2,"proveedor") = proveedor and dw_temp.GetItemString(r2,"fra") = fra Then
		dw_temp.deleteRow(r2)
	END IF
Next


String cod_pago
  SELECT forma_pago,moneda  
    INTO :cod_pago,:car.moneda
    FROM comproveedores  
   WHERE ( comproveedores.empresa = :codigo_empresa ) AND  
         ( comproveedores.codigo = :proveedor )   ;


vto = f_vencimientos_pagos(codigo_empresa,importe,cod_pago,ffra,proveedor,car.moneda)
car.proveedor = proveedor
car.codpago   = cod_pago
car.tipodoc   = f_tipodoc_carforpag(codigo_empresa,car.codpago)
cambio        = f_cambio_moneda(car.moneda)
car.empresa   = codigo_empresa
car.cuenta    = f_cuenta_genter(car.empresa,"P",car.proveedor)
car.anyo = Year(Today())
car.ffra = ffra
car.fra  = fra
car.anyofra = Year(Date(car.ffra))
dw_vto.Reset()
IF IsNull(cambio) Or cambio = 0 Then cambio = 1
For r = 1  To vto.efectos
	car.fvto    = DateTime(vto.vencimiento[r])
	car.divisas = vto.importe[r]
	car.importe = Dec(String(car.divisas * cambio,f_mascara_decimales(0)))
	r = dw_vto.InsertRow(0)
	dw_vto.SetItem(r,"empresa",car.empresa)
	dw_vto.SetItem(r,"cuenta",car.cuenta)	
	dw_vto.SetItem(r,"anyo",car.anyo)	
	dw_vto.SetItem(r,"proveedor",car.proveedor)
	dw_vto.SetItem(r,"importe",car.importe)
	dw_vto.SetItem(r,"fra",car.fra)
	dw_vto.SetItem(r,"anyofra",car.anyofra)
	dw_vto.SetItem(r,"ffra",car.ffra)
	dw_vto.SetItem(r,"vto",car.fvto)	
	dw_vto.SetItem(r,"situacion","N")
	r2 = dw_temp.InsertRow(0)
	dw_temp.SetItem(r2,"empresa",car.empresa)
	dw_temp.SetItem(r2,"cuenta",car.cuenta)	
	dw_temp.SetItem(r2,"anyo",car.anyo)	
	dw_temp.SetItem(r2,"proveedor",car.proveedor)
	dw_temp.SetItem(r2,"importe",car.importe)
	dw_temp.SetItem(r2,"fra",car.fra)
	dw_temp.SetItem(r2,"anyofra",car.anyofra)
	dw_temp.SetItem(r2,"ffra",car.ffra)
	dw_temp.SetItem(r2,"vto",car.fvto)	
	dw_temp.SetItem(r2,"situacion","N")	
Next

dw_vto.visible = True
end subroutine

public subroutine f_sacar_vencimientos (string proveedor, decimal importe, string fra, datetime ffra);
Integer r,jj
Int bien
Dec cambio
bien = 0
dw_vto.Reset()
For jj = 1 To dw_temp.RowCOunt()
	IF dw_temp.GetItemSTring(jj,"proveedor") = proveedor  and dw_temp.GetItemSTring(jj,"fra") = fra Then
		r = dw_vto.InsertRow(0)
		dw_vto.SetItem(r,"empresa",dw_temp.GeTItemString(jj,"empresa"))
		dw_vto.SetItem(r,"cuenta",dw_temp.GeTItemString(jj,"cuenta"))	
		dw_vto.SetItem(r,"situacion",dw_temp.GeTItemString(jj,"situacion"))	
		dw_vto.SetItem(r,"anyo",dw_temp.GeTItemNumber(jj,"anyo"))	
		dw_vto.SetItem(r,"proveedor",dw_temp.GeTItemString(jj,"proveedor"))
		dw_vto.SetItem(r,"importe",dw_temp.GeTItemNumber(jj,"importe"))
		dw_vto.SetItem(r,"fra",dw_temp.GeTItemString(jj,"fra"))
		dw_vto.SetItem(r,"anyofra",dw_temp.GeTItemNumber(jj,"anyofra"))
		dw_vto.SetItem(r,"ffra",dw_temp.GeTItemDateTime(jj,"ffra"))
		dw_vto.SetItem(r,"vto",dw_temp.GeTItemDateTime(jj,"vto"))	
	END IF
Next
end subroutine

public subroutine f_guardar_vencimientos (string proveedor, decimal importe, string fra, datetime ffra);Integer r,j,r2
Int bien
Dec cambio
bien = 0
str_carpagos       car



For r2 = dw_temp.RowCOunt() To 1 step -1
	IF dw_temp.GetItemString(r2,"proveedor") = proveedor and dw_temp.GetItemString(r2,"fra") = fra Then
		dw_temp.deleteRow(r2)
	END IF
Next
For r = 1  To dw_vto.RowCOunt()
	car.empresa   = dw_vto.GetItemString(r,"empresa")
	car.cuenta    = dw_vto.GetItemString(r,"cuenta")	
	car.anyo      = dw_vto.GetItemNumber(r,"anyo")	
	car.proveedor = dw_vto.GetItemString(r,"proveedor")
	car.importe   = dw_vto.GetItemNumber(r,"importe")
	car.fra       = dw_vto.GetItemString(r,"fra")
	car.anyofra   = dw_vto.GetItemNumber(r,"anyofra")
	car.ffra      = dw_vto.GetItemDateTime(r,"ffra")
	car.fvto      = dw_vto.GetItemDateTime(r,"vto")	
	r2 = dw_temp.InsertRow(0)
	dw_temp.SetItem(r2,"empresa",car.empresa)
	dw_temp.SetItem(r2,"cuenta",car.cuenta)	
	dw_temp.SetItem(r2,"anyo",car.anyo)	
	dw_temp.SetItem(r2,"proveedor",car.proveedor)
	dw_temp.SetItem(r2,"importe",car.importe)
	dw_temp.SetItem(r2,"fra",car.fra)
	dw_temp.SetItem(r2,"anyofra",car.anyofra)
	dw_temp.SetItem(r2,"ffra",car.ffra)
	dw_temp.SetItem(r2,"vto",car.fvto)
	dw_temp.SetItem(r2,"situacion",dw_vto.GetItemString(r,"situacion"))
Next
end subroutine

public subroutine f_cargar_vencimientos (string proveedor, string fra, datetime ffra);Integer r,j,r2
Int bien
Dec cambio
bien = 0
str_carpagos       car
DataStore data
String sel,sit

sel = " Select * from carpagos " +&
		" Where empresa   =  '" + codigo_empresa + "'" +&
		" And   proveedor =  '" + proveedor      + "'" +&
		" And   fra       =  '" + fra            + "'" 
		
//data = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, data)
car.empresa = codigo_empresa
car.proveedor = proveedor
car.cuenta    = f_cuenta_genter(car.empresa,"P",car.proveedor)
car.ffra      = ffra
car.anyofra   = Year(Date(car.ffra))
car.anyo   = Year(Today())

For r = 1  To data.RowCOunt()

	r2 = dw_temp.InsertRow(0)
	dw_temp.SetItem(r2,"empresa",car.empresa)
	dw_temp.SetItem(r2,"cuenta",car.cuenta)	
	dw_temp.SetItem(r2,"anyo",car.anyo)	
	dw_temp.SetItem(r2,"proveedor",car.proveedor)
	dw_temp.SetItem(r2,"importe",data.GetItemNumber(r,"importe"))
	dw_temp.SetItem(r2,"fra",data.GetItemString(r,"fra"))
	dw_temp.SetItem(r2,"anyofra",car.anyofra)
	dw_temp.SetItem(r2,"ffra",car.ffra)
	IF data.GetItemString(r,"situacion") = "1" Then
		// cobrado
		dw_temp.SetItem(r2,"situacion","S")
	ELSE
		// pendiente
		dw_temp.SetItem(r2,"situacion","N")
	END IF
	dw_temp.SetItem(r2,"vto",data.GetItemDateTime(r,"fvto"))	
Next

destroy data
end subroutine

public function boolean f_grabar_pagos (string proveedor, string fra);Integer r,j
Int bien
Dec cambio
bien = 0
str_vencimientos   vto
str_carpagos       car

IF IsNUll(proveedor) or Trim(proveedor) = "" Then 
		 f_mensaje("Error"," el prov. no ext. f_gragar_pagos")
END IF

  SELECT  forma_pago,moneda  
    INTO :car.codpago,:car.moneda
    FROM comproveedores  
   WHERE comproveedores.empresa = :codigo_empresa
	AND   comproveedores.codigo = :proveedor;

car.moneda = f_peseta()
car.proveedor = proveedor
car.tipodoc   = f_tipodoc_carforpag(codigo_empresa,car.codpago)
cambio        = f_cambio_moneda(car.moneda)
car.empresa   = codigo_empresa
car.cuenta    = f_cuenta_genter(car.empresa,"P",car.proveedor)
car.recibo = 0
delete from carpagos
Where empresa   = :codigo_empresa
And   fra   = :fra
And   proveedor = :proveedor
and   situacion = '0';
iF sqlca.sqlcode <> 0 Then bien = -1

contado_o_fvto=false

For j = 1 To dw_temp.RowCount()
	IF dw_temp.GetItemSTring(j,"proveedor") = proveedor and dw_temp.GetItemSTring(j,"fra") = fra and dw_temp.GetItemSTring(j,"situacion") = "N" Then
		car.anyo = Year(Today())
		car.ffra = dw_temp.GetItemDateTime(j,"ffra")
		car.fra  = dw_temp.GetItemString(j,"fra")
		car.anyofra = Year(Date(car.ffra))
		car.banco = '4'
		Select  Max(carpagos.orden) Into :car.orden From carpagos
		Where   carpagos.empresa = :codigo_empresa
		And     carpagos.anyo    = :car.anyo ;
		IF IsNull(car.orden) Then car.orden = 0
		car.orden   = car.orden + 1
		car.recibo  = car.recibo +1
		car.fvto    =  dw_temp.GetItemDateTime(j,"vto")
		car.divisas =  dw_temp.GetItemNumber(j,"importe")
		car.importe = dw_temp.GetItemNumber(j,"importe")
		car.situacion = "0"
		dw_temp.SetItem(j,"situacion","S")
		IF Not f_insert_carpagos(car) Then bien  = 1
		vvto = car.fvto
		contado_o_fvto=True
	END IF
Next

IF bien = 1 Then Return False
Return TRue
end function

public function boolean f_limpiar_vencimientos ();Integer r,j
Int bien
Dec cambio
bien = 0

String pro,fra
For j = 1 To dw_temp.RowCount()
	IF dw_temp.GetItemSTring(j,"situacion") = "N" Then
		fra  = dw_temp.GetItemString(j,"fra")
		pro  = dw_temp.GetItemString(j,"proveedor")


		Delete  From carpagos
		Where   carpagos.empresa   = :codigo_empresa
		And     carpagos.fra       = :fra
		and     carpagos.proveedor = :pro;
		IF sqlca.sqlcode <>0 Then bien  = 1
	END IF
Next

IF bien = 1 Then Return False
Return TRue
end function

event open;call super::open;This.title = " INTRODUCCION DE FACTURAS RECIBIDAS"
Date fecha
IF Month(Today()) = 12 Then
	fecha = MDY(1,1,Year(Today())+1)
ELSE
	fecha = MDY(Month(Today())+1,1,Year(Today()))
END IF
fecha = RelativeDate(fecha,-1)
em_fasiento.text = String(fecha,"dd-mm-yy")
dw_detalle.SetTransObject(SQLCA)
dw_listado2.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)
dw_vto.SetTransObject(SQLCA)
dw_detalle.visible = TRUE
uo_origen.em_codigo.text = "3"
uo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)
f_mascara_columna(dw_detalle,"registro",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"imponible",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"totalfac",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"impiva",f_mascara_decimales(0))

f_mascara_columna(dw_1,"registro",f_mascara_decimales(0))
f_mascara_columna(dw_1,"imponible",f_mascara_decimales(0))
f_mascara_columna(dw_1,"totalfac",f_mascara_decimales(0))
f_mascara_columna(dw_1,"impiva",f_mascara_decimales(0))

f_mascara_columna(dw_vto,"importe",f_mascara_decimales(0))
f_mascara_columna(dw_vto,"importe_1",f_mascara_decimales(0))
f_mascara_columna(dw_vto,"importe_2",f_mascara_decimales(0))

// Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_ejercicio.em_ejercicio.text =istr_parametros.s_argumentos[2]
      em_fasiento.text   = String(Date(istr_parametros.s_argumentos[4]),"dd-mm-yy")
		em_asiento.text    = istr_parametros.s_argumentos[5]   
		f_visualizar(dw_detalle)
	ELSE
		f_activar_campo(em_fasiento)
   END IF


end event

on w_int_facturas_recibidas.create
int iCurrent
call super::create
this.pb_salir=create pb_salir
this.em_asiento=create em_asiento
this.st_asiento=create st_asiento
this.em_fasiento=create em_fasiento
this.st_2=create st_2
this.st_3=create st_3
this.uo_origen=create uo_origen
this.pb_1=create pb_1
this.nombre_gasto=create nombre_gasto
this.nombre_proveedor=create nombre_proveedor
this.dw_1=create dw_1
this.dw_vto=create dw_vto
this.cb_insertar=create cb_insertar
this.cb_borrar=create cb_borrar
this.cb_grabar=create cb_grabar
this.grabar=create grabar
this.borrar=create borrar
this.salir=create salir
this.dw_detalle=create dw_detalle
this.borrar_asiento=create borrar_asiento
this.dw_listado2=create dw_listado2
this.uo_ejercicio=create uo_ejercicio
this.dw_apuntes=create dw_apuntes
this.dw_temp=create dw_temp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_salir
this.Control[iCurrent+2]=this.em_asiento
this.Control[iCurrent+3]=this.st_asiento
this.Control[iCurrent+4]=this.em_fasiento
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.uo_origen
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.nombre_gasto
this.Control[iCurrent+10]=this.nombre_proveedor
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.dw_vto
this.Control[iCurrent+13]=this.cb_insertar
this.Control[iCurrent+14]=this.cb_borrar
this.Control[iCurrent+15]=this.cb_grabar
this.Control[iCurrent+16]=this.grabar
this.Control[iCurrent+17]=this.borrar
this.Control[iCurrent+18]=this.salir
this.Control[iCurrent+19]=this.dw_detalle
this.Control[iCurrent+20]=this.borrar_asiento
this.Control[iCurrent+21]=this.dw_listado2
this.Control[iCurrent+22]=this.uo_ejercicio
this.Control[iCurrent+23]=this.dw_apuntes
this.Control[iCurrent+24]=this.dw_temp
end on

on w_int_facturas_recibidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_salir)
destroy(this.em_asiento)
destroy(this.st_asiento)
destroy(this.em_fasiento)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.uo_origen)
destroy(this.pb_1)
destroy(this.nombre_gasto)
destroy(this.nombre_proveedor)
destroy(this.dw_1)
destroy(this.dw_vto)
destroy(this.cb_insertar)
destroy(this.cb_borrar)
destroy(this.cb_grabar)
destroy(this.grabar)
destroy(this.borrar)
destroy(this.salir)
destroy(this.dw_detalle)
destroy(this.borrar_asiento)
destroy(this.dw_listado2)
destroy(this.uo_ejercicio)
destroy(this.dw_apuntes)
destroy(this.dw_temp)
end on

event ue_f5;call super::ue_f5;IF em_asiento.enabled = TRUE Then

ELSE
	f_confirmar()
END IF
end event

event ue_esc;call super::ue_esc;IF pb_salir.enabled = TRUE Then
	pb_salir.TriggerEvent(Clicked!)
ELSE
	f_salir()
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

event ue_f2;call super::ue_f2;f_insertar_linea()
end event

event ue_f3;call super::ue_f3;f_borrar_linea()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_facturas_recibidas
integer x = 800
integer y = 816
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_facturas_recibidas
integer x = 32
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_facturas_recibidas
boolean visible = false
integer y = 20
integer width = 2642
end type

type pb_salir from upb_salir within w_int_facturas_recibidas
integer x = 2734
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean cancel = false
boolean originalsize = true
end type

type em_asiento from u_em_campo within w_int_facturas_recibidas
integer x = 1038
integer y = 92
integer width = 352
integer height = 80
integer taborder = 40
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "Ä"
end type

event modificado;call super::modificado;f_visualizar(dw_detalle)
IF dw_detalle.RowCount() = 0 Then 
	String v_origen 
	dw_detalle.Reset()
	v_origen    = uo_origen.em_codigo.text
	IF Trim(v_origen)= "" Then
		f_mensaje("Campo Obligatorio","Introduzca el origen")
		f_activar_campo(uo_origen.em_campo)
		Return
	END IF
	f_activar(FALSE)
	f_nueva()
	Return
END IF
end event

type st_asiento from statictext within w_int_facturas_recibidas
integer x = 1038
integer y = 16
integer width = 357
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 33554432
long backcolor = 15780518
string text = "Asiento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;dw_apuntes.SetTransObject(SQLCA)
IF dw_apuntes.retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,Month(Date(em_fasiento.text)),uo_origen.em_codigo.text) <> 0 Then
	dw_apuntes.visible = TRUE
END IF
end event

type em_fasiento from u_em_campo within w_int_facturas_recibidas
integer x = 745
integer y = 92
integer width = 293
integer height = 80
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

event modificado;call super::modificado;Dec anyo

anyo = Year(Date(em_fasiento.text))
uo_ejercicio.em_ejercicio.text = String(anyo,"####")

dw_detalle.reset()
end event

type st_2 from statictext within w_int_facturas_recibidas
integer x = 745
integer y = 16
integer width = 293
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_facturas_recibidas
integer x = 5
integer y = 16
integer width = 736
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Origen "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_origen from u_em_campo_2 within w_int_facturas_recibidas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 5
integer y = 92
integer width = 736
integer height = 80
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)

IF Trim(uo_origen.em_campo.text)="" THEN 
 IF Trim(uo_origen.em_codigo.text)<>"" Then uo_origen.em_campo.SetFocus()
 uo_origen.em_campo.text=""
 uo_origen.em_codigo.text=""
END IF
dw_detalle.Reset()

end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE ORIGENES"
		ue_datawindow = "dw_ayuda_contaorigen"
		ue_filtro     = ""

end event

on uo_origen.destroy
call u_em_campo_2::destroy
end on

type pb_1 from upb_imprimir within w_int_facturas_recibidas
integer x = 1394
integer y = 80
integer taborder = 0
end type

event clicked;f_visualizar(dw_1)


dw_1.SetRedraw(TRUE)
dw_1.InsertRow(dw_1.RowCOunt() + 1)
dw_1.GroupCalc()
dw_1.DeleteRow(dw_1.RowCOunt())

f_imprimir_datawindow(dw_1)
Dec mes
mes = Month(Date(em_fasiento.text))
IF dw_listado2.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,mes,uo_origen.em_codigo.text,Dec(em_asiento.text)) <> 0 Then
	f_imprimir_datawindow(dw_listado2)
end if

end event

type nombre_gasto from statictext within w_int_facturas_recibidas
integer y = 1268
integer width = 1362
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551858
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type nombre_proveedor from statictext within w_int_facturas_recibidas
integer y = 1380
integer width = 1362
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551858
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_int_facturas_recibidas
boolean visible = false
integer x = 2322
integer y = 156
integer width = 494
integer height = 360
boolean bringtotop = true
string dataobject = "report_in_facturas_recibidas"
boolean livescroll = true
end type

type dw_vto from datawindow within w_int_facturas_recibidas
integer x = 1362
integer y = 1168
integer width = 1294
integer height = 324
boolean bringtotop = true
string dataobject = "dw_in_facturas_recibidas2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_insertar from u_boton within w_int_facturas_recibidas
integer x = 2656
integer y = 1172
integer width = 270
integer height = 108
integer taborder = 0
string text = "&Insertar"
end type

event clicked;call super::clicked;Dec r,vanyo,vanyofra
String vproveedor,vcuenta,vfra
DateTime vffra
vproveedor = dw_detalle.GetItemString(dw_detalle.GetRow(),"proveedor")
vcuenta    = f_cuenta_genter(codigo_empresa,"P",vproveedor)
vanyo = Year(Today())
vffra = dw_detalle.GetItemDateTime(dw_detalle.GetRow(),"ffra")
vfra  = dw_detalle.GetItemString(dw_detalle.GetRow(),"factura")
vanyofra = Year(Date(vffra))
	r = dw_vto.InsertRow(0)
	
	dw_vto.SetItem(r,"empresa",codigo_empresa)
	dw_vto.SetItem(r,"cuenta",vcuenta)	
	dw_vto.SetItem(r,"anyo",vanyo)	
	dw_vto.SetItem(r,"proveedor",vproveedor)
	dw_vto.SetItem(r,"importe",0)
	dw_vto.SetItem(r,"fra",vfra)
	dw_vto.SetItem(r,"anyofra",vanyofra)
	dw_vto.SetItem(r,"ffra",vffra)
	dw_vto.SetItem(r,"vto",vffra)	
end event

type cb_borrar from u_boton within w_int_facturas_recibidas
integer x = 2656
integer y = 1280
integer width = 270
integer height = 108
integer taborder = 0
boolean bringtotop = true
string text = "&Borrar"
end type

event clicked;call super::clicked;IF dw_vto.Getrow() = 0 Then Return
dw_vto.DeleteRow(dw_vto.Getrow())

end event

type cb_grabar from u_boton within w_int_facturas_recibidas
integer x = 2656
integer y = 1388
integer width = 270
integer height = 104
integer taborder = 0
boolean bringtotop = true
string text = "&Grabar"
end type

event clicked;call super::clicked;dw_vto.AccepTtext()
IF dw_detalle.GetItemNumber(dw_detalle.GetRow(),"totalfac") <> Dec(dw_vto.GetItemSTring(1,"totalfac")) Then
		f_mensaje("Error","El total no cuadra")
		Return
END IF
f_guardar_vencimientos(dw_detalle.GetItemString(dw_detalle.GetRow(),"proveedor"),dw_detalle.GetItemNumber(dw_detalle.GetRow(),"totalfac"),dw_detalle.GetItemString(dw_detalle.GetRow(),"factura"),dw_detalle.GetItemDateTime(dw_detalle.GetRow(),"ffra"))
dw_detalle.Setfocus()
dw_detalle.Setcolumn("ffra")
end event

type grabar from u_boton within w_int_facturas_recibidas
integer x = 5
integer y = 1172
integer width = 453
integer height = 92
integer taborder = 10
string text = " Grabar Asto"
end type

event clicked;dw_detalle.AcceptText()
dw_detalle.TriggerEvent(itemfocuschanged!)
IF f_control() Then
	f_confirmar()
	COMMIT;
	Return
END IF


end event

type borrar from u_boton within w_int_facturas_recibidas
integer x = 457
integer y = 1172
integer width = 453
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = " Borrar Apunte"
end type

event clicked;call super::clicked;	f_borrar_linea()



end event

type salir from u_boton within w_int_facturas_recibidas
event clicked pbm_bnclicked
integer x = 910
integer y = 1172
integer width = 453
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = " Salir del Asto"
end type

event clicked;call super::clicked;f_salir()



end event

type dw_detalle from u_datawindow within w_int_facturas_recibidas
integer y = 192
integer width = 2930
integer height = 980
integer taborder = 0
string dataobject = "dw_in_facturas_recibidas1"
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Dec       asiento_i,importe_d,importe_h,xx,apunte_i,mes,vejercicio
String    concepto,ampliacion,ana,conta_i,origen
DateTime  fapunte



f_activar(FALSE)

str_parametros lstr_param
IF f_objeto_datawindow(dw_detalle) = "t_gasto" Then
	OpenWithParm(wi_mant_contaplan,lstr_param)
end if
IF f_objeto_datawindow(dw_detalle) = "t_proveedor" Then
	lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"proveedor")
	OpenWithParm(w_mant_comproveedores,lstr_param)
end if

IF dwo.name = "anali" Then
	IF Not f_asignacion_costes_apunte(Year(DAte(em_fasiento.text)),codigo_empresa,Month(DAte(em_fasiento.text)),uo_origen.em_codigo.text,Dec(em_asiento.text),object.apunte[Row]) Then
		// error al asignar el desglose analitico
	END IF
END IF
end event

event key;

IF Not KeyDown(KeyEnter!) Then
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "gasto"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro =""
	CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro =""
 	CASE "tipoiva"
      bus_titulo     = "VENTANA SELECCION DE IVAS"
 		bus_datawindow = "dw_ayuda_contaiva"
		 bus_filtro    = "ejercicio = " +uo_ejercicio.em_ejercicio.text
 	CASE "concepto"
      bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
 		bus_datawindow = "dw_ayuda_contaconcepto"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

IF  KeyDown(KeyEscape!) Then Parent.TriggerEvent("ue_esc")
IF  KeyDown(KeyF5!)Then Parent.TriggerEvent("ue_f5")
IF  KeyDown(KeyF2!)Then Parent.TriggerEvent("ue_f2")
IF  KeyDown(KeyF3!)Then Parent.TriggerEvent("ue_f3")
IF KeyDown(KeyEnter!) Then
	IF This.GetColumnName() = "ffra" Then
		dw_detalle.AcceptText()
		f_vencimientos(dw_detalle.GetItemString(dw_detalle.GetRow(),"codpro"),dw_detalle.GetItemNumber(dw_detalle.GetRow(),"totalfac"),dw_detalle.GetItemString(dw_detalle.GetRow(),"factura"),dw_detalle.GetItemDateTime(dw_detalle.GetRow(),"ffra"))
		IF dw_vto.RowCount() = 0 Then
			dw_vto.InsertRow(0)
		END IF
		dw_vto.SetFocus()
		dw_vto.SetRow(1)
		dw_vto.SetColumn("vto")
	END IF
END IF

IF  KeyDown(KeyInsert!) THEN
		IF Not f_control() Then Return
		  f_nueva()
END IF
end event

event rbuttondown;
 bus_filtro=""
 bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "gasto"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro =""
	CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro =""
 	CASE "tipoiva"
      bus_titulo     = "VENTANA SELECCION DE IVAS"
 		bus_datawindow = "dw_ayuda_contaiva"
		 bus_filtro    = "ejercicio = " +uo_ejercicio.em_ejercicio.text
 	CASE "concepto"
      bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
 		bus_datawindow = "dw_ayuda_contaconcepto"
 CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event valores_numericos;call super::valores_numericos;f_valores_numericos(dw_detalle,"gasto")
f_valores_numericos(dw_detalle,"proveedor")
f_valores_numericos(dw_detalle,"tipoiva")

end event

event itemfocuschanged;call super::itemfocuschanged;f_cambio_linea(row)
Dec r ,iva,ejer,imponible,impiva,xx,j,totalfac,nu
ejer = Dec(uo_ejercicio.em_ejercicio.text)
String tipoiva,codpro,proveedor,gasto
DateTime ffra
String fra

AcceptText()
r = GetRow()

		proveedor = GetItemString(r,"proveedor")
		IF Trim(proveedor) <> "" Then
				Select codigo Into :codpro From genter
				Where  empresa = :codigo_empresa
				And    tipoter = 'P'
				And    cuenta  = :proveedor;
				IF SQLCA.SQLCODE = 100 Then
					f_mensaje("El proveedor no existe",String(proveedor))
					Return
				END IF
				SetItem(r,"codpro",codpro)

		END IF
		
		gasto = GetItemString(r,"gasto")
		IF Trim(gasto) <> "" Then
				Select count(*) Into :nu From contaplan
				Where  ejercicio = :ejer
				And    empresa = :codigo_empresa
				And    cuenta  = :gasto;
				IF nu = 0 Then
					f_mensaje("El gasto no existe",String(gasto))
					Return
				END IF

		END IF



impiva = GetItemNumber(r,"impiva")
tipoiva = GetItemSTring(r,"tipoiva")
IF IsNUll(tipoiva ) Then tipoiva = ""
IF Trim(tipoiva) =  "" Then
	impiva = 0
	totalfac = 0
	SetItem(r,"impiva",0)
	SetItem(r,"totalfac",0)
ELSE
	Select count(*) Into :nu From contaiva
	Where  ejercicio = :ejer
	And    empresa   = :codigo_empresa
	And    tipoiva   = :tipoiva;
	IF nu = 0 Then
		f_mensaje("El tipo de iva no existe",String(tipoiva))
		SetItem(r,"impiva",0)
		SetItem(r,"totalfac",0)
		SetItem(r,"tipoiva","")
		Return
	END IF
END IF


IF Trim(tipoiva) <> ""  or IsNUll(tipoiva) Then
			ffra = GetItemDateTime(r,"ffra")
			fra = GetItemSTring(r,"factura")
			iva = f_iva_contaiva(ejer,codigo_empresa,tipoiva)
			imponible = GetItemNumber(r,"imponible")
			For xx = 1 To 100
				j = r - xx
				IF j  = 0 Then Exit
				IF GetItemSTring(j,"tipoiva") = ""  or IsNUll(GetItemSTring(j,"tipoiva"))Then
					IF impiva = 0 or IsNUll(impiva) Then					
						imponible = imponible + GetItemNumber(j,"imponible") 
					END IF
						SetItem(j,"ffra",ffra)
						SetItem(j,"factura",fra)
				ELSE
					Exit
				END IF
			Next
			IF impiva = 0 or IsNUll(impiva) Then					
			impiva = Dec(String((imponible * iva / 100),f_mascara_moneda(f_peseta())))
			IF ISNull(impiva) Then impiva = 0
				SetItem(r,"impiva",impiva)
				SetItem(r,"totalfac",impiva + imponible)
			END IF
	END IF

IF Trim(tipoiva) <> "" Then
	imponible = GetItemNumber(r,"imponible")
	For xx = 1 To 100
					j = r - xx
					IF j  = 0 Then Exit
					IF GetItemSTring(j,"tipoiva") = ""  or IsNUll(GetItemSTring(j,"tipoiva"))Then
						imponible = imponible + GetItemNumber(j,"imponible") 
					ELSE
						Exit
					END IF
	Next
				impiva = GetItemNumber(r,"impiva") 
				IF ISNull(impiva) Then impiva = 0
				SetItem(r,"totalfac",impiva + imponible)
END IF

end event

event retrieveend;call super::retrieveend;enabled = TRUE

end event

event retrievestart;call super::retrievestart;enabled = FALSE
end event

event rowfocuschanged;call super::rowfocuschanged;IF rowCount() = 0 Then Return
IF currentrow > 0 and Not IsNUll(currentrow) Then
	f_sacar_vencimientos(dw_detalle.GetItemString(currentrow,"codpro"),dw_detalle.GetItemNumber(currentrow,"totalfac"),dw_detalle.GetItemString(dw_detalle.GetRow(),"factura"),dw_detalle.GetItemDateTime(currentrow,"ffra"))
	f_cambio_linea(currentrow)
END IF
end event

event itemchanged;String gasto,an
IF Not IsValid(dwo) Then Return
IF dwo.name = "registro" Then
	Dec reg,mes,asto,ejer,nu
	String origen
// control registros duplicados
	reg    = Dec(data)
	origen = uo_origen.em_codigo.text
	mes    = Month(Date(em_fasiento.text))
	asto   = Dec(em_asiento.text)
	ejer   = Dec(uo_ejercicio.em_ejercicio.text)

	Select count(*) Into :nu From contaapun
	where ejercicio  = :ejer
	And   empresa    = :codigo_empresa
	And   registro   = :reg
	and   origen = :origen   
	and   mes  = :mes 
   and asiento <> :asto;
	IF IsNUll(nu) Then nu = 0
	IF nu <> 0 Then
			f_mensaje("Control registro","Introducir nuevo registro")
			dw_detalle.Settext('')
			return 1
	END IF
END IF
IF dwo.name = "gasto" Then
	gasto = data
	Select analitica Into :an from contaplan
	Where  ejercicio  = :ejercicio_activo
	And    empresa    = :codigo_empresa
	And    cuenta     = :gasto;
	IF IsNull(an) or Trim(an) = "" Then an = "N"
	object.analitica[getRow()] = an
	
END IF



end event

event itemerror;call super::itemerror;Return 1
end event

type borrar_asiento from u_boton within w_int_facturas_recibidas
event clicked pbm_bnclicked
integer x = 2272
integer y = 16
integer width = 457
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = " Borrar Asiento"
end type

event clicked;Dec bien = 0
String pre 
String var_factura,var_proveedor,vorigen
DateTime var_ffactura
Dec var_ejercicio,var_mes,var_origen,var_asiento,jj

	f_visualizar(dw_detalle)
	IF dw_detalle.Rowcount() = 0 Then return
	pre = "S"
	IF messageBox("Opcion borrado del asiento.","¿Desea Borrar el asiento completo?",Question!,YesNo!) = 2 Then Return
	IF messageBox("Opcion borrado del asiento.","¿Desea Borrar la prevision?",Question!,YesNo!) = 2 Then 
		pre = "N"
	End If
	
var_ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
var_mes       = Month(Date(em_fasiento.text))
var_asiento   = Dec(em_asiento.text)
vorigen       = uo_origen.em_codigo.text
IF pre = "S" Then
	For jj = 1 To dw_detalle.RowCount()
		var_proveedor = ""
		var_proveedor = dw_detalle.Object.proveedor[jj]
		var_factura   = dw_detalle.Object.factura[jj]
		var_ffactura  = dw_detalle.Object.ffra[jj]
		IF IsNull(var_proveedor) or Trim(var_proveedor) = "" Then
			Delete from carpagos
			Where empresa     =  :codigo_empresa
			And   proveedor   =  :var_proveedor
			And   fra         =  :var_factura
			And   ffra        =  :var_ffactura
			And   situacion   =  '0';
			IF sqlca.sqlcode <> 0 Then bien =1
		END IF
	Next
End If

Delete from  contaapun
Where  ejercicio = :var_ejercicio
And    empresa   = :codigo_empresa
And    origen    = :vorigen
And    mes       = :var_mes
And    asiento   = :var_asiento;
IF sqlca.sqlcode <> 0 Then bien =1

Delete from  costesapu
Where  ejercicio = :var_ejercicio
And    empresa   = :codigo_empresa
And    origen    = :vorigen
And    mes       = :var_mes
And    asiento   = :var_asiento;
IF sqlca.sqlcode <> 0 Then bien =1

IF bien  = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en el proceso!!","La Operacion no se contabiliza!")
END IF
	
end event

type dw_listado2 from datawindow within w_int_facturas_recibidas
boolean visible = false
integer x = 137
integer y = 188
integer width = 494
integer height = 360
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_in_facturas_recibidas_costes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_ejercicio from u_ejercicio within w_int_facturas_recibidas
event destroy ( )
integer x = 1646
integer y = 20
integer height = 276
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_apuntes from datawindow within w_int_facturas_recibidas
boolean visible = false
integer x = 1070
integer y = 140
integer width = 731
integer height = 788
string dataobject = "dw_int_contaapun2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(dw_apuntes) = "salir" Then
	This.Reset()
	This.visible = FALSE
	f_visualizar(dw_Detalle)
END IF
IF row = 0     Then return
IF IsNull(row) Then return
em_asiento.text = String(GetItemNumber(row,"asiento"))
em_fasiento.text = String(Date(GetItemDateTime(row,"fapunte")))
This.Reset()
This.visible = FALSE
f_visualizar(dw_detalle)
end event

type dw_temp from datawindow within w_int_facturas_recibidas
boolean visible = false
integer x = 1806
integer y = 132
integer width = 1088
integer height = 188
string dataobject = "dw_in_facturas_recibidas3"
boolean livescroll = true
end type

