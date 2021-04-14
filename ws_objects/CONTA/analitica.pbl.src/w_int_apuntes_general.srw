$PBExportHeader$w_int_apuntes_general.srw
$PBExportComments$No se utiliza
forward
global type w_int_apuntes_general from w_int_con_empresa
end type
type pb_salir from upb_salir within w_int_apuntes_general
end type
type em_asiento from u_em_campo within w_int_apuntes_general
end type
type st_asiento from statictext within w_int_apuntes_general
end type
type em_fasiento from u_em_campo within w_int_apuntes_general
end type
type st_2 from statictext within w_int_apuntes_general
end type
type st_3 from statictext within w_int_apuntes_general
end type
type uo_origen from u_em_campo_2 within w_int_apuntes_general
end type
type dw_apuntes from datawindow within w_int_apuntes_general
end type
type pb_1 from upb_imprimir within w_int_apuntes_general
end type
type dw_listado from datawindow within w_int_apuntes_general
end type
type grabar from u_boton within w_int_apuntes_general
end type
type borrar from u_boton within w_int_apuntes_general
end type
type salir from u_boton within w_int_apuntes_general
end type
type nombre_cuenta from statictext within w_int_apuntes_general
end type
type dw_debe from u_datawindow within w_int_apuntes_general
end type
type nombre_concepto from statictext within w_int_apuntes_general
end type
type cb_borrar from u_boton within w_int_apuntes_general
end type
type dw_cobros from datawindow within w_int_apuntes_general
end type
type st_1 from statictext within w_int_apuntes_general
end type
type st_4 from statictext within w_int_apuntes_general
end type
type st_5 from statictext within w_int_apuntes_general
end type
type gb_2 from groupbox within w_int_apuntes_general
end type
type gb_1 from groupbox within w_int_apuntes_general
end type
type dw_impagados from datawindow within w_int_apuntes_general
end type
type dw_pagos from datawindow within w_int_apuntes_general
end type
type dw_haber from u_datawindow within w_int_apuntes_general
end type
type uo_ejercicio from u_ejercicio within w_int_apuntes_general
end type
type st_11 from statictext within w_int_apuntes_general
end type
type st_14 from statictext within w_int_apuntes_general
end type
type st_15 from statictext within w_int_apuntes_general
end type
type st_125 from statictext within w_int_apuntes_general
end type
type st_135 from statictext within w_int_apuntes_general
end type
type dw_listado2 from datawindow within w_int_apuntes_general
end type
type dw_listado3 from datawindow within w_int_apuntes_general
end type
type st_33 from statictext within w_int_apuntes_general
end type
end forward

global type w_int_apuntes_general from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2994
integer height = 2132
string title = "Consulta de Movimientos"
pb_salir pb_salir
em_asiento em_asiento
st_asiento st_asiento
em_fasiento em_fasiento
st_2 st_2
st_3 st_3
uo_origen uo_origen
dw_apuntes dw_apuntes
pb_1 pb_1
dw_listado dw_listado
grabar grabar
borrar borrar
salir salir
nombre_cuenta nombre_cuenta
dw_debe dw_debe
nombre_concepto nombre_concepto
cb_borrar cb_borrar
dw_cobros dw_cobros
st_1 st_1
st_4 st_4
st_5 st_5
gb_2 gb_2
gb_1 gb_1
dw_impagados dw_impagados
dw_pagos dw_pagos
dw_haber dw_haber
uo_ejercicio uo_ejercicio
st_11 st_11
st_14 st_14
st_15 st_15
st_125 st_125
st_135 st_135
dw_listado2 dw_listado2
dw_listado3 dw_listado3
st_33 st_33
end type
global w_int_apuntes_general w_int_apuntes_general

type variables
Datawindow d_w
String restaurar = "N"
end variables

forward prototypes
public subroutine f_confirmar ()
public subroutine f_salir ()
public subroutine f_activar (boolean boo)
public subroutine f_ok ()
public function string f_tipo_cta (string cuenta)
public subroutine f_activar_linea (datawindow dw, integer reg)
public function boolean f_control (datawindow dw)
public subroutine f_valores_fijos (datawindow dw, integer reg)
public subroutine f_insertar_linea (datawindow dw)
public subroutine f_borrar_linea (datawindow dw)
public subroutine f_nueva (datawindow dw)
public subroutine f_visualizar ()
public function boolean f_pagar (string empresa, string cuenta, string ampliacion, decimal importe)
public subroutine f_cambio_linea (datawindow dw)
public function boolean f_cobro (string empresa, string cuenta, string ampliacion, decimal importe)
public function boolean f_impagar (string empresa, string cuenta, string ampliacion, decimal importe)
public function boolean f_gastos (string empresa, string cuenta, string ampliacion, decimal importe)
public function boolean f_restablecer_pagar (string empresa, string cuenta, string ampliacion, decimal importe)
public function boolean f_restablecer_gastos (string empresa, string cuenta, string ampliacion, decimal importe)
public function boolean f_restablecer_impagar (string empresa, string cuenta, string ampliacion, decimal importe)
public function boolean f_restaurar_linea (datawindow dw, integer elemento)
public function boolean f_restablecer_cobro (string empresa, string cuenta, string ampliacion, decimal importe, string concepto)
end prototypes

public subroutine f_confirmar ();Dec bien = 0
Dec tot,t
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
IF Sqlca.sqlcode <> 0 Then 
	bien = 1
	f_mensaje("Error","Error al borrar asiento")
END IF

tot = dw_debe.RowCount()
con.apunte = 0
For t = 1 To tot
	con.apunte     = con.apunte +1
	con.cuenta     = dw_debe.GetItemSTring(t,"cuenta")
	con.concepto   = dw_debe.GetItemSTring(t,"concepto")
	con.debe       = dw_debe.GetItemNumber(t,"importe")
	con.haber      = 0
	con.ampliacion = dw_debe.GetItemString(t,"ampliacion")
	SetNUll(con.clipro)
	con.documento  = ""
	con.factura    = ""
	SetNUll(con.ffactura)
	SetNUll(con.registro)
	SetNUll(con.tipoapu)
	SetNull(con.fregistro)
	SetNUll(con.tipoiva)
	con.iva = 0
	con.imponible = 0
	IF Not f_insert_contaapun(con) Then 
		bien = 1
		f_mensaje("Error","Error al grabar asiento")
	END IF
	IF con.concepto = "40" Then
		IF Not f_pagar(con.empresa,con.cuenta,con.ampliacion,con.debe) Then 
			bien = 1
			f_mensaje("Error","Error al pagar")
			END IF
	END IF
	
	IF con.concepto = "15" Then
		IF dw_debe.GetItemNumber(t,"apunte") = 0 Then
			IF Not f_gastos(con.empresa,con.cuenta,con.ampliacion,con.debe) Then bien = 1
		END IF
	END IF
	IF con.concepto = "14" Then
		IF dw_debe.GetItemNumber(t,"apunte") = 0 Then
			IF Not f_impagar(con.empresa,con.cuenta,con.ampliacion,con.debe) Then bien = 1
		END IF
	END IF
Next
tot = dw_haber.RowCount()
For t = 1 To tot
	con.apunte     = con.apunte +1
	con.cuenta     = dw_haber.GetItemSTring(t,"cuenta")
	con.concepto   = dw_haber.GetItemSTring(t,"concepto")
	con.debe       = 0
	con.haber      = dw_haber.GetItemNumber(t,"importe")
	con.ampliacion = dw_haber.GetItemString(t,"ampliacion")
	SetNUll(con.clipro)
	con.documento  = ""
	con.factura    = ""
	SetNUll(con.ffactura)
	SetNUll(con.registro)
	SetNUll(con.tipoapu)
	SetNull(con.fregistro)
	SetNUll(con.tipoiva)
	con.iva = 0
	con.imponible = 0
	IF con.concepto = "11" or con.concepto = "12"  or con.concepto = '13' Then
		IF dw_haber.GetItemNumber(t,"apunte") = 0 Then
			IF Not f_cobro(con.empresa,con.cuenta,con.ampliacion,con.haber) Then bien = 1
		END IF
	END IF
	IF Not f_insert_contaapun(con) Then 
		bien = 1
		f_mensaje("Error","Error al grabar asiento")
	END IF
Next

//dw_debe.Reset()
//dw_haber.Reset()
//em_asiento.text = ""
if not f_asignacion_costes_asiento(con.ejercicio,con.empresa,con.mes,con.origen,con.asiento) then
	bien =1
end if

IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso","La operacion no se contabiliza")
END IF
f_activar(TRUE)
f_activar_campo(em_asiento)

end subroutine

public subroutine f_salir ();IF MessageBox("Salir del Asiento sin grabar","¿Salir sin grabar?",Question!,YesNo!)= 2 Then 
	Return
END IF
f_activar(TRUE)
dw_debe.Reset()
dw_haber.Reset()
dw_pagos.Reset()
dw_pagos.Visible = FALSE

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

public subroutine f_ok ();

end subroutine

public function string f_tipo_cta (string cuenta);IF (Mid(cuenta,1,1)= "6" or Mid(cuenta,1,2)= "48") Then  Return "G"
IF (Mid(cuenta,1,2)= "40" or Mid(cuenta,1,2)= "41")  Then	Return "P"
IF (Mid(cuenta,1,2)= "47") Then	Return "I"
Return "G"
end function

public subroutine f_activar_linea (datawindow dw, integer reg);reg = dw.GetRow()
dw.SetFocus()
dw.ScrollToRow(reg)
dw.SetColumn("cuenta")


end subroutine

public function boolean f_control (datawindow dw);Integer      r, r1 ,mes,nu,ejer
Dec reg,asto,importe
String      ncta,cta,pro,origen,ampliacion
Dec debe,haber
IF Not IsValid(dw) Then Return TRue



r1 = dw.RowCount()
IF r1 = 0 Then Return False
For r = 1 To r1
	cta   = dw.GetItemString(r,"cuenta")
	IF IsNUll(cta) or Trim(cta) = "" Then 
		f_mensaje("Campo Obligatorio","Introducir Cuenta Contable")
		dw.SetFocus()
		dw.SetRow(r)
		dw.SetColumn("cuenta")
		Return False
	END IF
	ncta = f_nombre_contaplan(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cta)
	IF IsNUll(ncta) or Trim(ncta) = "" Then 
		f_mensaje("Campo Obligatorio","Introducir Cuenta Contable")
		dw.SetFocus()
		dw.SetRow(r)
		dw.SetColumn("cuenta")
		Return False
	END IF
	importe = dw.GetItemNumber(r,"importe")
	IF IsNUll(importe) Then importe = 0
	IF importe = 0 Then
		f_mensaje("Campo Obligatorio","Introducir el importe")
		dw.SetFocus()
		dw.SetRow(r)
		dw.SetColumn("importe")
		Return False
	END IF
	IF dw.GetItemString(r,"concepto") = '40' Then
		ampliacion = dw.GetItemString(r,"ampliacion")
		IF IsNUll(ampliacion) Then ampliacion = ""
		IF importe = 0 Then
			f_mensaje("Campo Obligatorio","Introducir la ampliacion")
			dw.SetFocus()
			dw.SetRow(r)
			dw.SetColumn("ampliacion")
			Return False
		END IF
	END IF
Next
Return True
end function

public subroutine f_valores_fijos (datawindow dw, integer reg);dw.SetItem(reg,"empresa",codigo_empresa)
dw.SetItem(reg,"ejercicio",Dec(uo_ejercicio.em_ejercicio.text))

end subroutine

public subroutine f_insertar_linea (datawindow dw);Integer r 
r = dw.GetRow()
IF r = 0 or r = 1 Then
	r = 1
ELSE
	r = r -1
END IF
dw.InsertRow(r)
f_valores_fijos(dw,r)
f_activar_linea(dw,r)

end subroutine

public subroutine f_borrar_linea (datawindow dw);Int r
r = dw.getRow()
IF r =0 Then return
IF Not f_restaurar_linea(dw,r) Then
	f_mensaje("Error en proceso","Error al restaurar la cartera")
	
END IF
dw.DeleteRow(r)
IF dw.RowCount() = 0 Then 
	//
Else
	If dw.RowCount()< r Then r =  dw.RowCount()
	f_activar_linea(dw,r)
END IF
end subroutine

public subroutine f_nueva (datawindow dw);Dec reg
IF dw.GetRow() <> dw.RowCount() Then Return
reg = dw.RowCount() + 1
dw.InsertRow(reg)
dw.SetRow(reg)
f_valores_fijos(dw,reg)
f_activar_linea(dw,reg)

end subroutine

public subroutine f_visualizar ();//data.Retrieve(codigo_empresa,Dec(em_asiento.text),DateTime(Date(em_fasiento.text)))
DataStore d
datawindow data
dw_debe.Reset()
dw_haber.Reset()
String sel,cuenta,concepto,ampliacion,anali
Dec mes,j,cont,impiva,totalfac,importe,reg,congas,xx,la,debe,haber,apunte
Dec imponible
DateTime ffra
mes = Month(Date(em_fasiento.text))
ampliacion =  ""
sel = " Select * from contaapun" + +&
      " Where ejercicio = "  + uo_ejercicio.em_ejercicio.text +&
		" And   empresa   = '" + codigo_empresa +"'" +&
		" And   origen    = '" + uo_origen.em_codigo.text +"'"+&
		" And   mes       = " + STring(mes) +&
		" And   asiento   = "  + String(Dec(em_asiento.text)) +&
		" order by ejercicio,empresa,origen,mes,asiento,apunte"
		
// d = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, d)

cont = 0
dw_debe.SetRedraw(FALSE)
dw_haber.SetRedraw(FALSE)
For j = 1 To d.Rowcount()
		cuenta     = d.GetItemString(j,"cuenta")
		anali = f_analitica_contaplan(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta)
   	apunte     = d.GetItemNumber(j,"apunte")
		concepto   = d.GetItemString(j,"concepto")
		ampliacion = d.GetItemString(j,"ampliacion")
		debe       = d.GetItemNumber(j,"debe")
		haber      = d.GetItemNumber(j,"haber")
		
		IF debe <> 0 Then
			data = dw_debe
			importe = debe
		ELSE
			data = dw_haber
			importe = haber
		END IF
		cont = data.InsertRow(0)
		data.SetItem(cont,"importe",importe)
		data.SetItem(cont,"empresa",codigo_empresa)
		data.SetItem(cont,"ejercicio",Dec(uo_ejercicio.em_ejercicio.text))	
		data.SetItem(cont,"ampliacion",ampliacion)
		data.SetItem(cont,"concepto",concepto)
		data.SetItem(cont,"cuenta",cuenta)
		data.SetItem(cont,"anali",anali)
		data.SetItem(cont,"apunte",apunte)

	Next

dw_debe.SetRedraw(TRUE)
dw_haber.SetRedraw(TRUE)
dw_debe.SetRow(1)
destroy d;
end subroutine

public function boolean f_pagar (string empresa, string cuenta, string ampliacion, decimal importe);String fra,pro,com
dec recibo,j,bien
str_carpagos car

bien = 0

Select codigo Into :pro from genter
Where  empresa = :empresa
And    cuenta  = :cuenta;
IF SQLCA.SQLCODE = 100 Then 
	PRO = cuenta
end if

For j = 1 To len(ampliacion)
	IF Mid(ampliacion,j,1) <> "/" Then
		com = com + Mid(ampliacion,j,1)
	ELSE
		fra = com
		com = ""
	END IF
NExt
IF IsNUll(fra) or Trim(fra) = "" Then
	Return  TRUE
END IF
recibo = Dec(com)
datastore   d
string sel
sel = " Select * from carpagos " +&
		" Where  empresa   = '" + empresa + "'"+&
		" And    proveedor = '" + pro     + "'"+&
		" And    fra   = '" + fra     + "'"+&
		" and    recibo    = "  + String(recibo,"######") +&
		" and    importe  <= "  + String(importe,"##########")+&
		" and    situacion = '0'"
		
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
For j = 1 To d.RowCOunt()
	car.importe = d.GetItemNumber(j,"importe")
	car.empresa = d.GetItemString(j,"empresa")
	car.anyo = d.GetItemNumber(j,"anyo")
	car.orden = d.GetItemNumber(j,"orden")
	car.fpago = d.GetItemDateTime(j,"fvto")
	IF car.importe = importe Then
		Update carpagos 
		Set situacion  = '1',
		    fpago      = :car.fvto
		Where  empresa = :car.empresa
		And    anyo    = :car.anyo
		And    orden   = :car.orden;
		IF sqlca.sqlcode <> 0 Then bien = 1
		Exit
	ELSE
		Update carpagos Set importe = importe - :importe,
								  divisas = divisas - :importe
		Where  empresa = :car.empresa
		And    anyo    = :car.anyo
		And    orden   = :car.orden;
		IF sqlca.sqlcode <> 0 Then bien = 1
		  SELECT carpagos.empresa,   
         carpagos.anyo,   
         carpagos.orden,   
         carpagos.anyofra,   
         carpagos.fra,   
         carpagos.recibo,   
         carpagos.ffra,   
         carpagos.fvto,   
         carpagos.fpago,   
         carpagos.importe,   
         carpagos.divisas,   
         carpagos.moneda,   
         carpagos.banco,   
         carpagos.proveedor,   
         carpagos.tipodoc,   
         carpagos.codpago,   
         carpagos.situacion,   
         carpagos.cuenta,   
         carpagos.femi,   
         carpagos.num_talon,   
         carpagos.asignar_banco

    INTO :car.empresa,   
         :car.anyo,   
         :car.orden,   
         :car.anyofra,   
         :car.fra,   
         :car.recibo,   
         :car.ffra,   
         :car.fvto,   
         :car.fpago,   
         :car.importe,   
         :car.divisas,   
         :car.moneda,   
         :car.banco,   
         :car.proveedor,   
         :car.tipodoc,   
         :car.codpago,   
         :car.situacion,   
         :car.cuenta,   
         :car.femi,   
         :car.num_talon,   
         :car.asignar_banco

    FROM carpagos  
   WHERE ( carpagos.empresa = :car.empresa ) AND  
         ( carpagos.anyo = :car.anyo ) AND  
         ( carpagos.orden = :car.orden )   ;
			car.situacion = "1"
			car.importe   = importe
			car.divisas   = importe
			car.fpago = d.GetItemDateTime(j,"fvto")
			Select max(orden) Into :car.orden from  carpagos
		   WHERE ( carpagos.empresa = :car.empresa ) AND  
			      ( carpagos.anyo = :car.anyo );
			car.orden = car.orden +1
			IF Not(f_insert_carpagos(car)) then bien = 1

	END IF
NExt

IF bien = 1 Then Return FALSE

destroy d
Return TRUE
end function

public subroutine f_cambio_linea (datawindow dw);IF Not IsValid(dw) Then Return
Integer ln,j
String cta,con,pro,am,ampliacion,fra,com
dw.Accepttext()



if dw.RowCount() = 0 tHEN Return
ln = Integer(dw.Describe("DataWindow.LastRowOnPage"))
dw.AcceptText()
Dec ejer
ejer = Dec(uo_ejercicio.em_ejercicio.text)
nombre_cuenta.text = ""
cta = dw.GetItemString(dw.GetRow(),"cuenta")
if cta="" or isnull(cta) then
else
	nombre_cuenta.text = f_nombre_contaplan(ejer,codigo_empresa,cta)
	IF Trim(nombre_cuenta.text) = "" Then
		f_mensaje("Error en introduccion de datos","La cuenta no existe")
		dw.SetColumn("cuenta")
	ELSE
		nombre_cuenta.text = "Cta:  " + nombre_cuenta.text
	END IF
end if

con = dw.GetItemString(dw.GetRow(),"concepto")
IF IsNull(con) Then con = ""

IF con <> '14' and con <> '15' Then
	dw_impagados.visible  = FALSE
	dw_impagados.Reset()
END IF


nombre_concepto.text = "Concepto:  "+f_nombre_concepto(codigo_empresa,con)
IF con <> "40" Then
	dw_pagos.visible = FALSE
	dw_pagos.Reset()
END IF
IF con <> "11" and con <> '12' and con <> '13'Then
	dw_cobros.visible = FALSE
	dw_cobros.Reset()
END IF

IF con = "40" Then
	dw_pagos.visible = TRUE
	Select codigo Into :pro  from genter
	Where empresa = :codigo_empresa
	and   tipoter = 'P'
	And   cuenta  = :cta;
	iF sqlca.sqlcode = 100 Then pro = cta
	am = dw.GetItemString(dw.GetRow(),"ampliacion")
	IF ISNUll(am) Then am = ""
	IF Trim(am) = "" Then
		dw_pagos.DataObject = "dw_in_apuntes_carga_general1"
		dw_pagos.SetTransObject(SQLCA)
		dw_pagos.Retrieve(codigo_empresa,pro,'0')
	ELSE
		dw_pagos.DataObject = "dw_in_apuntes_carga_general5"
		dw_pagos.SetTransObject(SQLCA)
		ampliacion = dw.GetItemSTring(dw.GetRow(),"ampliacion")
		For j = 1 To len(ampliacion)
			IF Mid(ampliacion,j,1) <> "/" Then
				com = com + Mid(ampliacion,j,1)
			ELSE
				fra = com
				com = ""
			END IF
		NExt
		dw_pagos.Retrieve(codigo_empresa,pro,fra,Dec(com))
	END IF
END IF


IF con = "11" or con = '12' or con = '13' Then
	dw_cobros.visible = TRUE
	Select codigo Into :pro  from genter
	Where empresa = :codigo_empresa
	and   tipoter = 'C'
	And   cuenta  = :cta;
	am = dw.GetItemString(dw.GetRow(),"ampliacion")
	IF ISNUll(am) Then am = ""
	IF (Trim(am) = "") or (Trim(am) <>"" and dw.GetItemNumber(dw.GetRow(),"apunte")= 0)  Then
		IF con = '11'  Then dw_cobros.DataObject = "dw_in_apuntes_carga_general4"
		IF con = '12'  Then dw_cobros.DataObject = "dw_in_apuntes_carga_general4d"
		IF con = '13'  Then dw_cobros.DataObject = "dw_in_apuntes_carga_general4d2"
		dw_cobros.SetTransObject(SQLCA)
		dw_cobros.Retrieve(codigo_empresa,pro)
	ELSE
		dw_cobros.DataObject = "dw_in_apuntes_carga_general6"
		dw_cobros.SetTransObject(SQLCA)
		ampliacion = dw.GetItemSTring(dw.GetRow(),"ampliacion")
		For j = 1 To len(ampliacion)
			IF Mid(ampliacion,j,1) <> "/" Then
				com = com + Mid(ampliacion,j,1)
			ELSE
				fra = com
				com = ""
			END IF
		NExt
		dw_cobros.Retrieve(codigo_empresa,pro,fra,Dec(com))
	END IF
END IF



// Impagados//
//-----------//
IF con = '14' or con ='15' Then
	dw_impagados.visible = TRUE
	Select codigo Into :pro  from genter
	Where empresa = :codigo_empresa
	and   tipoter = 'C'
	And   cuenta  = :cta;
	am = dw.GetItemString(dw.GetRow(),"ampliacion")
	IF ISNUll(am) Then am = ""
	IF (Trim(am) = "") or (Trim(am) <>"" and dw.GetItemNumber(dw.GetRow(),"apunte")= 0)  Then
		dw_impagados.DataObject = "dw_in_apuntes_carga_general7_2"
		dw_impagados.SetTransObject(SQLCA)
		dw_impagados.Retrieve(codigo_empresa,pro)
	ELSE
		dw_impagados.DataObject = "dw_in_apuntes_carga_general8"
		dw_impagados.SetTransObject(SQLCA)
		ampliacion = dw.GetItemSTring(dw.GetRow(),"ampliacion")
		For j = 1 To len(ampliacion)
			IF Mid(ampliacion,j,1) <> "/" Then
				com = com + Mid(ampliacion,j,1)
			ELSE
				fra = com
				com = ""
			END IF
		NExt
		dw_impagados.Retrieve(codigo_empresa,pro,fra,Dec(com))
	END IF
END IF
//---------------------

end subroutine

public function boolean f_cobro (string empresa, string cuenta, string ampliacion, decimal importe);String fra,pro,com
dec recibo,j,bien
str_carefectos car
str_carhistorico his

bien = 0

Select codigo Into :pro from genter
Where  empresa = :empresa
And    tipoter = 'C'
And    cuenta  = :cuenta;
IF SQLCA.SQLCODE = 100 Then 
	bien = 1
	f_mensaje("Error","El cliente no existe")
END IF

For j = 1 To len(ampliacion)
	IF Mid(ampliacion,j,1) <> "/" Then
		com = com + Mid(ampliacion,j,1)
	ELSE
		fra = com
		com = ""
	END IF
NExt
recibo = Dec(com)
datastore   d
string sel
sel = " Select * from carefectos " +&
		" Where  empresa   = '" + empresa + "'"+&
		" And    cliente = '" + pro     + "'"+&
		" And    factura   = '" + fra     + "'"+&
		" and    recibo    = "  + String(recibo,"######") +&
		" and    importe  >= "  + String(importe,"##########") +&
		" and    ((situacion = '0' and tipodoc In('1','5','6')) or situacion = '2')"

		
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
For j = 1 To d.RowCOunt()
			IF j = 1 Then
				// Inserto en el historico	
					his.empresa = codigo_empresa
					his.anyo = d.GetItemNumber(j,"anyo")
					his.orden = d.GetItemNumber(j,"orden")
				SELECT carefectos.empresa,   
							carefectos.anyo,   
							carefectos.orden,   
							carefectos.anyofra,   
							carefectos.factura,   
							carefectos.recibo,   
							carefectos.fvto,   
							carefectos.ffra,   
							carefectos.fcobro,   
							carefectos.importe,   
							carefectos.divisas,   
							carefectos.monedas,   
							carefectos.fpago,   
							carefectos.tipodoc,   
							carefectos.banco,   
							carefectos.remesa,   
							carefectos.fremesa,   
							carefectos.situacion,   
							carefectos.agente1,   
							carefectos.pais,   
							carefectos.cuenta,   
							carefectos.domiciliacion,   
							carefectos.Nacional,   
							carefectos.observaciones,   
							carefectos.libre,   
							carefectos.gasto,   
							carefectos.fdevolucion,   
							carefectos.agrupado,   
							carefectos.efectoagrupa,   
							carefectos.anyoagrupa,   
							carefectos.cliente,   
							carefectos.anyo_remesa,   
							carefectos.comision11,   
							carefectos.comision12,   
							carefectos.agente2,   
							carefectos.comision21,   
							carefectos.comision22,   
							carefectos.agente3,   
							carefectos.comision31,   
							carefectos.comision32,   
							carefectos.cambio,   
							carefectos.serie
				
				
					 INTO :his.empresa,   
							:his.anyo,   
							:his.orden,   
							:his.anyofra,   
							:his.factura,   
							:his.recibo,   
							:his.fvto,   
							:his.ffra,   
							:his.fcobro,   
							:his.importe,   
							:his.divisas,   
							:his.monedas,   
							:his.fpago,   
							:his.tipodoc,   
							:his.banco,   
							:his.remesa,   
							:his.fremesa,   
							:his.situacion,   
							:his.agente1,   
							:his.pais,   
							:his.cuenta,   
							:his.domiciliacion,   
							:his.nacional,   
							:his.observaciones,   
							:his.libre,   
							:his.gasto,   
							:his.fdevolucion,   
							:his.agrupado,   
							:his.efectoagrupa,   
							:his.anyoagrupa,   
							:his.cliente,   
							:his.anyo_remesa,   
							:his.comision11,   
							:his.comision12,   
							:his.agente2,   
							:his.comision21,   
							:his.comision22,   
							:his.agente3,   
							:his.comision31,   
							:his.comision32,   
							:his.cambio,   
							:his.serie
				
				
					 FROM carefectos  
					WHERE ( carefectos.empresa = :codigo_empresa ) AND  
							( carefectos.anyo = :his.anyo ) AND  
							( carefectos.orden = :his.orden )   ;
							IF SQLCA.SQLCODE <> 0 Then
								bien = 1
								f_mensaje("Error","El recibo no existe")
							END IF
							
							his.situacion_anterior = his.situacion
							his.situacion   = '9'
							his.importe     = importe
							his.divisas     = importe
							his.fcobro      = DateTime(Today())
							his.linea       = 0
							
							Select max(linea) Into :his.linea from  carhistorico
							WHERE  empresa  = :his.empresa 
							AND    anyo     = :his.anyo 
							AND    orden    = :his.orden;
							If IsNUll(his.linea) Then his.linea = 0
							his.linea = his.linea  +1
							IF Not(f_insert_carhistorico(his)) then bien = 1
				END IF
				
				
				
	car.importe = d.GetItemNumber(j,"importe")
	car.empresa = d.GetItemString(j,"empresa")
	car.anyo = d.GetItemNumber(j,"anyo")
	car.orden = d.GetItemNumber(j,"orden")
	IF car.importe = importe Then
		Delete from carefectos
		Where  empresa = :car.empresa
		And    anyo    = :car.anyo
		And    orden   = :car.orden;
		IF sqlca.Sqlcode <> 0 Then
				f_mensaje("Error","error al borrar el recibo")
			bien = 1
		END IF
		IF car.situacion= '3'  Then
			Delete from carefectos
			Where  empresa = :car.empresa
			And    anyo    = :car.anyoagrupa
			And    orden   = :car.efectoagrupa;
			IF sqlca.Sqlcode <> 0 Then
				f_mensaje("Error","error al borrar el recibo")
				bien = 1
			END IF
		END IF
		
		//  Insertar linea en el historico
		Exit
	ELSE
		Update carefectos Set importe = importe - :importe,
								    divisas = divisas - :importe
		Where  empresa = :car.empresa

		And    anyo    = :car.anyo
		And    orden   = :car.orden;
		IF sqlca.sqlcode <> 0 Then
			bien = 1
				f_mensaje("Error","Error el modifica el recibo")
		END IF
	END IF
Next

			Destroy d;
			IF bien = 1 Then Return FALSE
destroy d			
Return TRUE
end function

public function boolean f_impagar (string empresa, string cuenta, string ampliacion, decimal importe);String fra,pro,com
dec recibo,j,bien,vlinea,cc
str_carefectos car
str_carhistorico his

bien = 0

Select codigo Into :pro from genter
Where  empresa = :empresa
And    tipoter = 'C'
And    cuenta  = :cuenta;
IF SQLCA.SQLCODE = 100 Then 
	bien = 1
	f_mensaje("Error","El cliente no existe")
END IF

For j = 1 To len(ampliacion)
	IF Mid(ampliacion,j,1) <> "/" Then
		com = com + Mid(ampliacion,j,1)
	ELSE
		fra = com
		com = ""
	END IF
NExt
recibo = Dec(com)
datastore   d
string sel
IF dw_impagados.DataObject = "dw_in_apuntes_carga_general7" Then
// IMPAGAR RECIBO COBRADO
				sel = " Select * from carhistorico " +&
						" Where  empresa   = '" + empresa + "'"+&
						" And    cliente = '" + pro     + "'"+&
						" And    factura   = '" + fra     + "'"+&
						" and    recibo    = "  + String(recibo,"######") +&
						" and    importe  >= "  + String(importe,"##########") 
						
				
						
//				d = f_cargar_cursor(sel)
				f_cargar_cursor_nuevo(sel, d)
				IF d.RowCOunt() = 0 Then 
					destroy d
					Return FALSE
				end if
				For j = 1 To 1
						car.empresa = d.GetItemString(j,"empresa")
						car.anyo    = d.GetItemNumber(j,"anyo")
						car.orden   = d.GetItemNumber(j,"orden")
						vlinea      = d.GetItemNumber(j,"linea")
						
							  SELECT   carhistorico.anyofra,   
									carhistorico.factura,   
									carhistorico.recibo,   
									carhistorico.fvto,   
									carhistorico.ffra,   
									carhistorico.fvto_original, 
									carhistorico.importe,   
									carhistorico.divisas,   
									carhistorico.monedas,   
									carhistorico.fpago,   
									carhistorico.tipodoc,   
									carhistorico.banco,   
									carhistorico.agente1,   
									carhistorico.pais,   
									carhistorico.cuenta,   
									carhistorico.domiciliacion,   
									carhistorico.Nacional,   
									carhistorico.observaciones,   
									carhistorico.libre,   
									carhistorico.gasto,   
									carhistorico.fdevolucion,   
									carhistorico.agrupado,   
									carhistorico.efectoagrupa,   
									carhistorico.anyoagrupa,   
									carhistorico.cliente,   
									carhistorico.comision11,   
									carhistorico.comision12,   
									carhistorico.comision21,   
									carhistorico.comision22,   
									carhistorico.comision31,   
									carhistorico.comision32,   
									carhistorico.agente2,   
									carhistorico.agente3,   
									carhistorico.cambio,   
									carhistorico.serie  
							 INTO :car.anyofra,   
									:car.factura,   
									:car.recibo,   
									:car.fvto,   
									:car.ffra,  
									:car.fvto_original, 
									:car.importe,   
									:car.divisas,   
									:car.monedas,   
									:car.fpago,   
									:car.tipodoc,   
									:car.banco,   
									:car.agente1,   
									:car.pais,   
									:car.cuenta,   
									:car.domiciliacion,   
									:car.nacional,   
									:car.observaciones,   
									:car.libre,   
									:car.gasto,   
									:car.fdevolucion,   
									:car.agrupado,   
									:car.efectoagrupa,   
									:car.anyoagrupa,   
									:car.cliente,   
									:car.comision11,   
									:car.comision12,   
									:car.comision21,   
									:car.comision22,   
									:car.comision31,   
									:car.comision32,   
									:car.agente2,   
									:car.agente3,   
									:car.cambio,   
									:car.serie
							 FROM carhistorico  
							WHERE carhistorico.empresa = :car.empresa
							AND   carhistorico.anyo    = :car.anyo
							AND   carhistorico.orden   = :car.orden
							AND   carhistorico.linea   = :vlinea;
							IF sqlca.sqlcode <> 0 Then 
								bien = 1
								f_mensaje("Error","No encuentro linea en el historico" )
							END IF
							IF car.importe = importe Then
								Delete from carhistorico
								Where  empresa = :car.empresa
								And    anyo    = :car.anyo
								And    orden   = :car.orden
								And    linea   = :vlinea;
								iF sqlca.sqlcode <> 0 Then bien = 1
							ELSE
								Update carhistorico set carhistorico.importe  = carhistorico.importe - :importe,
																carhistorico.divisas  = carhistorico.divisas - :importe
								Where  empresa = :car.empresa
								And    anyo    = :car.anyo
								And    orden   = :car.orden
								And    linea   = :vlinea;
								IF sqlca.sqlcode <> 0 Then 
									bien = 1
									f_mensaje("Error","Fallo la modificacion del historico al impagar")
								END IF
								
							END IF
							
				
									car.orden = 0
									Select Max(orden) Into :car.orden From carefectos
									Where  empresa = :car.empresa
									And    anyo    = :car.anyo;
									IF IsNUll(car.orden) Then car.orden = 0
									car.orden = car.orden +1
									car.situacion = '2'
									//car.situacion_anterior = '9'
									car.gasto = "N"
									car.importe = importe
									car.divisas = importe
									setNull(car.fremesa)
									setNull(car.banco)
									setNull(car.remesa)
									IF Not f_insert_carefectos(car) Then bien = 1
				
						
				
					
				Next
ELSE
	// IMPAGAR RECIBO REMESADO
		sel = " Select * from carefectos " +&
						" Where  empresa   = '" + empresa + "'"+&
						" And    cliente = '" + pro     + "'"+&
						" And    factura   = '" + fra     + "'"+&
						" and    recibo    = "  + String(recibo,"######") +&
						" and    importe  >= "  + String(importe,"##########") 
						
				
						
//				d = f_cargar_cursor(sel)
				f_cargar_cursor_nuevo(sel, d)
				IF d.RowCOunt() = 0 Then 
					destroy d
					Return FALSE
				end if
				For j = 1 To 1
						car.empresa = d.GetItemString(j,"empresa")
						car.anyo    = d.GetItemNumber(j,"anyo")
						car.orden   = d.GetItemNumber(j,"orden")
						
							  SELECT anyofra,	factura,recibo,fvto,ffra, fvto_original,   
									importe,	divisas, monedas,	fpago,   
									tipodoc,banco,   
									agente1,   
									pais,   
									cuenta,   
									domiciliacion,   
									Nacional,   
									observaciones,   
									libre,   
									gasto,   
									fdevolucion,   
									agrupado,   
									efectoagrupa,   
									anyoagrupa,   
									cliente,   
									comision11,   
									comision12,   
									comision21,   
									comision22,   
									comision31,   
									comision32,   
									agente2,   
									agente3,   
									cambio,   
									serie,
									situacion
							 INTO :car.anyofra,   
									:car.factura,   
									:car.recibo,   
									:car.fvto,   
									:car.fvto_original, 
									:car.ffra,   
									:car.importe,   
									:car.divisas,   
									:car.monedas,   
									:car.fpago,   
									:car.tipodoc,   
									:car.banco,   
									:car.agente1,   
									:car.pais,   
									:car.cuenta,   
									:car.domiciliacion,   
									:car.nacional,   
									:car.observaciones,   
									:car.libre,   
									:car.gasto,   
									:car.fdevolucion,   
									:car.agrupado,   
									:car.efectoagrupa,   
									:car.anyoagrupa,   
									:car.cliente,   
									:car.comision11,   
									:car.comision12,   
									:car.comision21,   
									:car.comision22,   
									:car.comision31,   
									:car.comision32,   
									:car.agente2,   
									:car.agente3,   
									:car.cambio,   
									:car.serie  ,
									:car.situacion
							 FROM carefectos
							WHERE empresa = :car.empresa
							AND   anyo    = :car.anyo
							AND   orden   = :car.orden;
							IF sqlca.sqlcode <> 0 Then 
								bien = 1
								f_mensaje("Error","No encuentro linea en el historico" )
							END IF
							IF car.importe = importe Then
								Update carefectos Set situacion = "2"//,	situacion_anterior = :car.situacion_anterior
								Where  empresa = :car.empresa
								And    anyo    = :car.anyo
								And    orden   = :car.orden;
								iF sqlca.sqlcode <> 0 Then bien = 1
							ELSE
								Update carefectos set importe  = importe - :importe,
															 divisas  = divisas - :importe
								Where  empresa = :car.empresa
								And    anyo    = :car.anyo
								And    orden   = :car.orden;
								IF sqlca.sqlcode <> 0 Then 
									bien = 1
									f_mensaje("Error","Fallo la modificacion del historico al impagar")
								END IF
								
									car.orden = 0
									Select Max(orden) Into :car.orden From carefectos
									Where  empresa = :car.empresa
									And    anyo    = :car.anyo;
									IF IsNUll(car.orden) Then car.orden = 0
									car.orden = car.orden +1
									car.situacion = '2'
									car.gasto = "N"
									car.importe = importe
									car.divisas = importe
									setNull(car.fremesa)
									setNull(car.banco)
									setNull(car.remesa)
									IF Not f_insert_carefectos(car) Then bien = 1
								END IF
					
					
				Next
END IF

Destroy d;
IF bien = 1 Then Return FALSE
Return TRUE
end function

public function boolean f_gastos (string empresa, string cuenta, string ampliacion, decimal importe);String fra,pro,com
dec recibo,j,bien,vlinea,cc
str_carefectos car
str_carhistorico his

bien = 0

Select codigo Into :pro from genter
Where  empresa = :empresa
And    tipoter = 'C'
And    cuenta  = :cuenta;
IF SQLCA.SQLCODE = 100 Then 
	bien = 1
	f_mensaje("Error","El cliente no existe")
END IF

For j = 1 To len(ampliacion)
	IF Mid(ampliacion,j,1) <> "/" Then
		com = com + Mid(ampliacion,j,1)
	ELSE
		fra = com
		com = ""
	END IF
NExt
recibo = Dec(com)
datastore   d
string sel
sel = " Select * from carefectos " +&
		" Where  empresa   = '" + empresa + "'"+&
		" And    cliente = '" + pro     + "'"+&
		" And    factura   = '" + fra     + "'"+&
		" and    recibo    = "  + String(recibo,"######") +&
		" and    importe  >= "  + String(importe,"##########") 
		

		
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
For j = 1 To d.RowCOunt()
		car.empresa = d.GetItemString(j,"empresa")
		car.anyo    = d.GetItemNumber(j,"anyo")
		car.orden   = d.GetItemNumber(j,"orden")

		
			  SELECT   anyofra,   
					factura,   
					recibo,   
					fvto,   
					ffra,   
					fvto_original, 
					importe,   
					divisas,   
					monedas,   
					fpago,   
					tipodoc,   
					banco,   
					agente1,   
					pais,   
					cuenta,   
					domiciliacion,   
					Nacional,   
					observaciones,   
					libre,   
					gasto,   
					fdevolucion,   
					agrupado,   
					efectoagrupa,   
					anyoagrupa,   
					cliente,   
					comision11,   
					comision12,   
					comision21,   
					comision22,   
					comision31,   
					comision32,   
					agente2,   
					agente3,   
					cambio,   
					serie  
			 INTO :car.anyofra,   
					:car.factura,   
					:car.recibo,   
					:car.fvto,   
					:car.ffra,   
					:car.fvto_original,   
					:car.importe,   
					:car.divisas,   
					:car.monedas,   
					:car.fpago,   
					:car.tipodoc,   
					:car.banco,   
					:car.agente1,   
					:car.pais,   
					:car.cuenta,   
					:car.domiciliacion,   
					:car.nacional,   
					:car.observaciones,   
					:car.libre,   
					:car.gasto,   
					:car.fdevolucion,   
					:car.agrupado,   
					:car.efectoagrupa,   
					:car.anyoagrupa,   
					:car.cliente,   
					:car.comision11,   
					:car.comision12,   
					:car.comision21,   
					:car.comision22,   
					:car.comision31,   
					:car.comision32,   
					:car.agente2,   
					:car.agente3,   
					:car.cambio,   
					:car.serie  
			 FROM carefectos
			WHERE empresa = :car.empresa
			AND   anyo    = :car.anyo
			AND   orden   = :car.orden;
			
			IF sqlca.sqlcode <> 0 Then bien = 0
			
					car.orden = 0
					Select Max(orden) Into :car.orden From carefectos
					Where  empresa = :car.empresa
					And    anyo    = :car.anyo;
					IF IsNUll(car.orden) Then car.orden = 0
					car.orden = car.orden +1
					car.situacion = '2'
					car.gasto = "S"
					car.importe = importe
					car.divisas = importe
					IF Not f_insert_carefectos(car) Then bien = 1

		

	
Next

Destroy d;
IF bien = 1 Then Return FALSE
Return TRUE
end function

public function boolean f_restablecer_pagar (string empresa, string cuenta, string ampliacion, decimal importe);String fra,pro,com
dec recibo,j,bien
str_carpagos car

bien = 0

Select codigo Into :pro from genter
Where  empresa = :empresa
And    cuenta  = :cuenta;
IF SQLCA.SQLCODE = 100 Then 
	PRO = cuenta
end if

For j = 1 To len(ampliacion)
	IF Mid(ampliacion,j,1) <> "/" Then
		com = com + Mid(ampliacion,j,1)
	ELSE
		fra = com
		com = ""
	END IF
NExt





IF IsNUll(fra) or Trim(fra) = "" Then
	Return  TRUE
END IF
recibo = Dec(com)
datastore   d

string sel
sel = " Select * from carpagos " +&
		" Where  empresa   = '" + empresa + "'"+&
		" And    proveedor = '" + pro     + "'"+&
		" And    fra   = '" + fra     + "'"+&
		" and    recibo    = "  + String(recibo,"######") +&
		" and    importe   = "  + String(importe,"##########")+&
		" and    situacion = '1'"
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
For j = 1 To d.RowCOunt()
	car.importe = d.GetItemNumber(j,"importe")
	car.empresa = d.GetItemString(j,"empresa")
	car.anyo = d.GetItemNumber(j,"anyo")
	car.orden = d.GetItemNumber(j,"orden")
	

	Update carpagos 
	Set situacion  = '0',
		 fpago      = null
	Where  empresa = :car.empresa
	And    anyo    = :car.anyo
	And    orden   = :car.orden;
	IF sqlca.sqlcode <> 0 Then bien = 1
	Exit
next

destroy d
IF bien = 1 Then Return FALSE
Return TRUE
end function

public function boolean f_restablecer_gastos (string empresa, string cuenta, string ampliacion, decimal importe);String fra,pro,com
dec recibo,j,bien,vlinea,cc
str_carefectos car
str_carhistorico his

bien = 0

Select codigo Into :pro from genter
Where  empresa = :empresa
And    tipoter = 'C'
And    cuenta  = :cuenta;
IF SQLCA.SQLCODE = 100 Then 
	bien = 1
	f_mensaje("Error","El cliente no existe")
END IF

For j = 1 To len(ampliacion)
	IF Mid(ampliacion,j,1) <> "/" Then
		com = com + Mid(ampliacion,j,1)
	ELSE
		fra = com
		com = ""
	END IF
NExt

recibo = Dec(com)
datastore   d

string sel
sel = " Select * from carefectos " +&
		" Where  empresa    = '" + empresa + "'"+&
		" And    cliente    = '" + pro     + "'"+&
		" And    factura    = '" + fra     + "'"+&
		" And    recibo     = "  + String(recibo,"######") +&
		" And    importe    = "  + String(importe,"##########") +&
		" And    situacion  = '2'" +&
		" And    gasto     = 'S'"
				
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
For j = 1 To d.RowCOunt()
		car.empresa = d.GetItemString(j,"empresa")
		car.anyo    = d.GetItemNumber(j,"anyo")
		car.orden   = d.GetItemNumber(j,"orden")
		Delete FROM carefectos
		WHERE empresa = :car.empresa
		AND   anyo    = :car.anyo
		AND   orden   = :car.orden;
		IF sqlca.sqlcode <> 0 Then bien = 1
		Exit
Next

Destroy d;
IF bien = 1 Then Return FALSE
Return TRUE
end function

public function boolean f_restablecer_impagar (string empresa, string cuenta, string ampliacion, decimal importe);String fra,pro,com
dec recibo,j,bien,vlinea,cc
str_carefectos car
str_carhistorico his

bien = 0

Select codigo Into :pro from genter
Where  empresa = :empresa
And    tipoter = 'C'
And    cuenta  = :cuenta;
IF SQLCA.SQLCODE = 100 Then 
	bien = 1
	f_mensaje("Error","El cliente no existe")
END IF

For j = 1 To len(ampliacion)
	IF Mid(ampliacion,j,1) <> "/" Then
		com = com + Mid(ampliacion,j,1)
	ELSE
		fra = com
		com = ""
	END IF
NExt
recibo = Dec(com)
datastore   d
string sel

	// RESTABLECER IMPAGAR 
		sel = " Select * from carefectos " +&
						" Where  empresa    = '" + empresa + "'"+&
						" And    cliente    = '" + pro     + "'"+&
						" And    factura    = '" + fra     + "'"+&
						" and    recibo     = "  + String(recibo,"######") +&
						" and    importe    = "  + String(importe,"##########")  +&
						" and    situacion  = '2'"
						
				
						
//				d = f_cargar_cursor(sel)
				f_cargar_cursor_nuevo(sel, d)
				IF d.RowCOunt() = 0 Then 
					destroy d
					Return FALSE
				end if
				For j = 1 To 1
						car.empresa             =   d.GetItemString(j,"empresa")
						car.anyo                =   d.GetItemNumber(j,"anyo")
						car.orden               =   d.GetItemNumber(j,"orden")
						car.factura             =   d.GetItemString(j,"factura")
						car.situacion  =   d.GetItemString(j,"situacion")
						IF Not IsNull(car.situacion)  and Trim(car.situacion) <> "" Then
							car.situacion = car.situacion
						Else
							f_mensaje("Atencion!","Se Restablece el recibo Nº Orden" + String(car.orden,"######") + " de la fra " + car.factura + " Impagado a cartera")
							car.situacion = '0'
						End If
						
						Update carefectos 
						Set Situacion = :car.situacion,
							 gasto = 'N'
							WHERE empresa = :car.empresa
							AND   anyo    = :car.anyo
							AND   orden   = :car.orden;
							IF sqlca.sqlcode <> 0 Then 
								bien = 1
								f_mensaje("Error","No encuentro la linea" )
							END IF
	
					
				Next
Destroy d;
IF bien = 1 Then Return FALSE
Return TRUE

end function

public function boolean f_restaurar_linea (datawindow dw, integer elemento);Dec bien
bien = 0
str_contaapun con

IF restaurar = "N" Then Return True

IF dw.GetItemNumber(elemento,"apunte") = 0 Then Return true

   //--------------------------------------------------------------------------------------//
  //-----------------------Vamos a restaurar----------------------------------------------//
 //--------------------------------------------------------------------------------------//

con.empresa   = codigo_empresa
con.cuenta     = dw.GetItemSTring(elemento,"cuenta")
con.concepto   = dw.GetItemSTring(elemento,"concepto")
con.debe       = dw.GetItemNumber(elemento,"importe")
con.ampliacion = dw.GetItemString(elemento,"ampliacion")


	IF con.concepto = "40" Then
		IF Not f_restablecer_pagar(con.empresa,con.cuenta,con.ampliacion,con.debe)     Then bien = 1
	END IF
	IF con.concepto = "15" Then
			IF Not f_restablecer_gastos(con.empresa,con.cuenta,con.ampliacion,con.debe) Then bien = 1
	END IF
	IF con.concepto = "14" Then
			IF Not f_restablecer_impagar(con.empresa,con.cuenta,con.ampliacion,con.debe) Then bien = 1
	END IF
	IF con.concepto = "11" or con.concepto = "12"  or con.concepto = "13"Then
			IF Not f_restablecer_cobro(con.empresa,con.cuenta,con.ampliacion,con.debe,con.concepto)  Then bien = 1
	END IF

//--------------------------------------------------------------------------------------//
IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error ","No se pudo restablecer")
END IF


Return True
end function

public function boolean f_restablecer_cobro (string empresa, string cuenta, string ampliacion, decimal importe, string concepto);String fra,pro,com
dec recibo,j,bien
str_carefectos car
str_carhistorico his

bien = 0

Select codigo Into :pro from genter
Where  empresa = :empresa
And    tipoter = 'C'
And    cuenta  = :cuenta;
IF SQLCA.SQLCODE = 100 Then 
	bien = 1
	f_mensaje("Error","El cliente no existe")
END IF

For j = 1 To len(ampliacion)
	IF Mid(ampliacion,j,1) <> "/" Then
		com = com + Mid(ampliacion,j,1)
	ELSE
		fra = com
		com = ""
	END IF
NExt
recibo = Dec(com)
datastore   d
string sel


		sel = " Select * from carhistorico " +&
				" Where  empresa   = '" + empresa + "'"+&
				" And    cliente = '" + pro     + "'"+&
				" And    factura   = '" + fra     + "'"+&
				" and    recibo    = "  + String(recibo,"######") +&
				" and    importe  = "  + String(importe,"##########") +&
				" and    situacion = '9'"
		
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
For j = 1 To d.RowCOunt()
			IF j = 1 Then
				// Inserto en el historico	
					his.empresa = codigo_empresa
					his.anyo = d.GetItemNumber(j,"anyo")
					his.orden = d.GetItemNumber(j,"orden")
					his.linea = d.GetItemNumber(j,"linea")
					
					
				SELECT empresa,anyo,orden,anyofra,factura,recibo,fvto,ffra,fvto_original,fcobro,importe,   
						 divisas,monedas,fpago,tipodoc,banco,remesa,fremesa,situacion,agente1,   
						 pais,cuenta,domiciliacion,Nacional,observaciones,libre,gasto,fdevolucion,   
						 agrupado,efectoagrupa,anyoagrupa,cliente,anyo_remesa,comision11,   
					 	 comision12,agente2,comision21,comision22,agente3,comision31,comision32,   
						 cambio,serie//,situacion_anterior
				 INTO :car.empresa,:car.anyo,:car.orden,:car.anyofra,:car.factura,:car.recibo,   
						:car.fvto,:car.ffra,:car.fvto_original,:car.fcobro,:car.importe,:car.divisas,:car.monedas,   
						:car.fpago,:car.tipodoc,:car.banco,:car.remesa,:car.fremesa,:car.situacion,   
						:car.agente1,:car.pais,:car.cuenta,:car.domiciliacion,:car.nacional,   
						:car.observaciones,:car.libre,:car.gasto,:car.fdevolucion,:car.agrupado,   
						:car.efectoagrupa,:car.anyoagrupa,:car.cliente,:car.anyo_remesa,   
						:car.comision11,:car.comision12,:car.agente2,:car.comision21,:car.comision22,   
						:car.agente3,:car.comision31,:car.comision32,:car.cambio,:car.serie//,:car.situacion_anterior
				   FROM  carhistorico  
					WHERE empresa  = :codigo_empresa
					AND  	anyo     = :his.anyo
					AND  	orden    = :his.orden
					AND  	linea    = :his.linea;
					IF SQLCA.SQLCODE <> 0 Then		bien = 1
										
				   Delete carhistorico  
					WHERE empresa  = :codigo_empresa
					AND  	anyo     = :his.anyo
					AND  	orden    = :his.orden
					AND  	linea    = :his.linea;
					IF SQLCA.SQLCODE <> 0 Then		bien = 1
							car.gasto = 'N'
							IF concepto = '11' Then car.situacion = '0'
							IF concepto = '12' Then 
								car.situacion = '2'
								car.gasto = 'N'
							END IF
							IF concepto = '13' Then 
								car.situacion = '2'
								car.gasto = 'S'
							END IF
							
							IF Trim(car.situacion)  <> "" and  Not IsNull(car.situacion) Then
								car.situacion = car.situacion
							END IF
							
							his.linea = 0
							Select max(orden) Into :car.orden from  carefectos
							WHERE  empresa = :car.empresa 
							AND    anyo = :car.anyo;
							If IsNUll(car.orden) Then car.orden = 0
							car.orden = car.orden  +1
							IF Not(f_insert_carefectos(car)) then bien = 1
				END IF
				
				
				
Exit
Next

Destroy d;
IF bien = 1 Then Return FALSE
Return TRUE
end function

event open;call super::open;This.title = " INTRODUCCION APUNTES CARGA GENERAL"
Date fecha
IF Month(Today()) = 12 Then
	fecha = MDY(1,1,Year(Today())+1)
ELSE
	fecha = MDY(Month(Today())+1,1,Year(Today()))
END IF
fecha = RelativeDate(fecha,-1)
em_fasiento.text = String(fecha,"dd-mm-yy")
dw_debe.SetTransObject(SQLCA)
dw_pagos.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_impagados.SetTransObject(SQLCA)
dw_LISTADO2.SetTransObject(SQLCA)
dw_LISTADO3.SetTransObject(SQLCA)
dw_cobros.SetTransObject(SQLCA)
//dw_1.SetTransObject(SQLCA)
uo_origen.em_codigo.text = "2"
uo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)

uo_origen.ue_valor_anterior = uo_origen.em_campo.text
f_mascara_columna(dw_debe,"importe",f_mascara_decimales(0))
f_mascara_columna(dw_haber,"importe",f_mascara_decimales(0))
f_activar_campo(em_fasiento)

// Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_ejercicio.em_ejercicio.text =istr_parametros.s_argumentos[2]
      uo_origen.em_codigo.text     = istr_parametros.s_argumentos[3]
		em_fasiento.text   = String(Date(istr_parametros.s_argumentos[4]),"dd-mm-yy")
		em_asiento.text    = istr_parametros.s_argumentos[5]   
		uo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)
		f_activar_campo(uo_origen.em_campo)
		f_visualizar()
   END IF


end event

on w_int_apuntes_general.create
int iCurrent
call super::create
this.pb_salir=create pb_salir
this.em_asiento=create em_asiento
this.st_asiento=create st_asiento
this.em_fasiento=create em_fasiento
this.st_2=create st_2
this.st_3=create st_3
this.uo_origen=create uo_origen
this.dw_apuntes=create dw_apuntes
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.grabar=create grabar
this.borrar=create borrar
this.salir=create salir
this.nombre_cuenta=create nombre_cuenta
this.dw_debe=create dw_debe
this.nombre_concepto=create nombre_concepto
this.cb_borrar=create cb_borrar
this.dw_cobros=create dw_cobros
this.st_1=create st_1
this.st_4=create st_4
this.st_5=create st_5
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_impagados=create dw_impagados
this.dw_pagos=create dw_pagos
this.dw_haber=create dw_haber
this.uo_ejercicio=create uo_ejercicio
this.st_11=create st_11
this.st_14=create st_14
this.st_15=create st_15
this.st_125=create st_125
this.st_135=create st_135
this.dw_listado2=create dw_listado2
this.dw_listado3=create dw_listado3
this.st_33=create st_33
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_salir
this.Control[iCurrent+2]=this.em_asiento
this.Control[iCurrent+3]=this.st_asiento
this.Control[iCurrent+4]=this.em_fasiento
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.uo_origen
this.Control[iCurrent+8]=this.dw_apuntes
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.dw_listado
this.Control[iCurrent+11]=this.grabar
this.Control[iCurrent+12]=this.borrar
this.Control[iCurrent+13]=this.salir
this.Control[iCurrent+14]=this.nombre_cuenta
this.Control[iCurrent+15]=this.dw_debe
this.Control[iCurrent+16]=this.nombre_concepto
this.Control[iCurrent+17]=this.cb_borrar
this.Control[iCurrent+18]=this.dw_cobros
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.st_5
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.gb_1
this.Control[iCurrent+24]=this.dw_impagados
this.Control[iCurrent+25]=this.dw_pagos
this.Control[iCurrent+26]=this.dw_haber
this.Control[iCurrent+27]=this.uo_ejercicio
this.Control[iCurrent+28]=this.st_11
this.Control[iCurrent+29]=this.st_14
this.Control[iCurrent+30]=this.st_15
this.Control[iCurrent+31]=this.st_125
this.Control[iCurrent+32]=this.st_135
this.Control[iCurrent+33]=this.dw_listado2
this.Control[iCurrent+34]=this.dw_listado3
this.Control[iCurrent+35]=this.st_33
end on

on w_int_apuntes_general.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_salir)
destroy(this.em_asiento)
destroy(this.st_asiento)
destroy(this.em_fasiento)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.uo_origen)
destroy(this.dw_apuntes)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.grabar)
destroy(this.borrar)
destroy(this.salir)
destroy(this.nombre_cuenta)
destroy(this.dw_debe)
destroy(this.nombre_concepto)
destroy(this.cb_borrar)
destroy(this.dw_cobros)
destroy(this.st_1)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_impagados)
destroy(this.dw_pagos)
destroy(this.dw_haber)
destroy(this.uo_ejercicio)
destroy(this.st_11)
destroy(this.st_14)
destroy(this.st_15)
destroy(this.st_125)
destroy(this.st_135)
destroy(this.dw_listado2)
destroy(this.dw_listado3)
destroy(this.st_33)
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

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(d_w)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(d_w)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(d_w)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(d_w)
end event

event ue_f3;call super::ue_f3;f_borrar_linea(d_w)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_apuntes_general
integer x = 800
integer y = 816
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_apuntes_general
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_apuntes_general
boolean visible = false
integer y = 20
integer width = 2642
end type

type pb_salir from upb_salir within w_int_apuntes_general
integer x = 2734
integer y = 16
integer width = 114
integer height = 108
integer taborder = 0
boolean cancel = false
end type

type em_asiento from u_em_campo within w_int_apuntes_general
integer x = 1061
integer y = 92
integer width = 352
integer height = 80
integer taborder = 40
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "Ä"
end type

event modificado;call super::modificado;


f_visualizar()

d_w = dw_debe
IF dw_debe.RowCount() + dw_haber.RowCount() = 0 Then 
	String v_origen 
	dw_debe.Reset()
	dw_haber.Reset()
	v_origen    = uo_origen.em_codigo.text
	IF Trim(v_origen)= "" Then
		f_mensaje("Campo Obligatorio","Introduzca el origen")
		f_activar_campo(uo_origen.em_campo)
		Return
	END IF
	f_activar(FALSE)
	f_nueva(d_w)
	Return
END IF

end event

type st_asiento from statictext within w_int_apuntes_general
integer x = 1061
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
long textcolor = 16711680
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

type em_fasiento from u_em_campo within w_int_apuntes_general
integer x = 768
integer y = 92
integer width = 293
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

event modificado;call super::modificado;Dec anyo

anyo = Year(Date(em_fasiento.text))
uo_ejercicio.em_ejercicio.text = String(anyo,"####")

dw_debe.reset()
dw_haber.reset()
end event

type st_2 from statictext within w_int_apuntes_general
integer x = 768
integer y = 16
integer width = 293
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_apuntes_general
integer x = 27
integer y = 16
integer width = 736
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "Origen "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_origen from u_em_campo_2 within w_int_apuntes_general
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 27
integer y = 92
integer width = 736
integer height = 80
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)

IF Trim(uo_origen.em_campo.text)="" THEN 
 IF Trim(uo_origen.em_codigo.text)<>"" Then uo_origen.em_campo.SetFocus()
 uo_origen.em_campo.text=""
 uo_origen.em_codigo.text=""
END IF
dw_debe.Reset()
dw_haber.Reset()

end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE ORIGENES"
		ue_datawindow = "dw_ayuda_contaorigen"
		ue_filtro     = ""

end event

on uo_origen.destroy
call u_em_campo_2::destroy
end on

type dw_apuntes from datawindow within w_int_apuntes_general
boolean visible = false
integer x = 1070
integer y = 140
integer width = 731
integer height = 788
boolean bringtotop = true
string dataobject = "dw_int_contaapun2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(dw_apuntes) = "salir" Then
	This.Reset()
	This.visible = FALSE
	f_visualizar()
END IF
IF row = 0     Then return
IF IsNull(row) Then return
em_asiento.text = String(GetItemNumber(row,"asiento"))
em_fasiento.text = String(Date(GetItemDateTime(row,"fapunte")))
This.Reset()
This.visible = FALSE
f_visualizar()
end event

type pb_1 from upb_imprimir within w_int_apuntes_general
integer x = 1422
integer y = 96
integer taborder = 0
end type

event clicked;dw_listado.Reset()
DataWindowChild dw_hija1
DataWindowChild dw_hija2
DataWindowChild dw_hija3
DataWindowChild dw_hija4
dw_listado.SetTransObject(SQLCA)
dw_listado.GetChild("dw_1", dw_hija1) 
dw_listado.GetChild("dw_2", dw_hija2)
dw_listado.GetChild("dw_3", dw_hija4)
dw_listado.GetChild("dw_cabecera", dw_hija3)
dw_hija3.SetTransObject(SQLCA)
dw_hija4.SetTransObject(SQLCA)
dw_hija1.SetTransObject(SQLCA)
dw_hija2.SetTransObject(SQLCA)
dw_hija4.InsertRow(1)
dw_hija4.SetItem(1,"titulo","LISTADO POLIZA   "+ String(Dec(em_asiento.text),"#########") + "   " + em_fasiento.text)
dw_debe.RowsCopy(1,dw_debe.RowCount(), Primary!, dw_hija1, 1, Primary!) 
dw_haber.RowsCopy(1,dw_haber.RowCount(), Primary!, dw_hija2, 1, Primary!)
//f_imprimir_datawindow2(dw_listado)
f_imprimir_datawindow(dw_listado)



Dec mes
mes = Month(Date(em_fasiento.text))
IF dw_listado3.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,mes,uo_origen.em_codigo.text,Dec(em_asiento.text)) <> 0 tHEN
	f_imprimir_datawindow(dw_listado3)
END IF

end event

type dw_listado from datawindow within w_int_apuntes_general
boolean visible = false
integer x = 2327
integer y = 156
integer width = 494
integer height = 360
boolean bringtotop = true
string dataobject = "report_in_apuntes_genereles"
boolean livescroll = true
end type

type grabar from u_boton within w_int_apuntes_general
integer x = 759
integer y = 1752
integer width = 503
integer height = 92
integer taborder = 0
string text = "F5 Grabar Asto."
end type

event clicked;dw_debe.AcceptText()
dw_haber.AcceptText()
d_w.AcceptText()
Dec debe,haber,j
debe = 0
haber = 0
For j = 1 To dw_debe.RowCOunt()
	debe = debe + dw_debe.GetItemNumber(j,"importe")
Next
For j = 1 To dw_haber.RowCOunt()
	haber = haber + dw_haber.GetItemNumber(j,"importe")
Next
IF debe <> haber Then
	f_mensaje("Control decuadre","El asiento esta descuadrado")
	return
END IF

IF f_control(dw_debe) Then
	IF f_control(dw_haber) Then
		f_confirmar()
		COMMIT;
		dw_pagos.visible = FALSE
		dw_cobros.visible = FALSE
		dw_impagados.visible = FALSE
		f_visualizar()
		Return
	END IF
END IF


end event

type borrar from u_boton within w_int_apuntes_general
integer x = 1275
integer y = 1752
integer width = 453
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = "F3 Borrar Apte."
end type

event clicked;restaurar = "N"



IF d_w.GetItemNumber(d_w.GetRow(),"apunte") <> 0 Then 
	IF Messagebox("Proceso de baja de un apunte","¿Desea Restaurar la cartera?",Question!,YesNo!,1) = 1 Then 
		restaurar = "S"
	ELSE
		restaurar = "N"
	END IF
END IF
	f_borrar_linea(d_w)



end event

type salir from u_boton within w_int_apuntes_general
event clicked pbm_bnclicked
integer x = 1737
integer y = 1752
integer width = 443
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = "Esc Salir Apte."
end type

event clicked;call super::clicked;f_salir()



end event

type nombre_cuenta from statictext within w_int_apuntes_general
integer x = 5
integer y = 1588
integer width = 1458
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 33551858
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_debe from u_datawindow within w_int_apuntes_general
integer x = 5
integer y = 192
integer width = 1458
integer height = 1392
integer taborder = 0
string dataobject = "dw_in_apuntes_carga_general"
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;d_w = This
IF d_w.RowCOunt() = 0 Then
	f_nueva(d_w)
	Return
END IF

d_w = This
str_parametros lstr_param
IF f_objeto_datawindow(dw_debe) = "t_cuenta" Then
	OpenWithParm(wi_mant_contaplan,lstr_param)
end if
f_activar(FALSE)
f_cambio_linea(d_w)

end event

event key;

IF Not KeyDown(KeyEnter!) Then
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro =""
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

IF  KeyDown(KeyInsert!) THEN
		This.AcceptText()
		IF Not f_control(d_w) Then Return
		  f_nueva(d_w)
END IF
end event

event rbuttondown;
 bus_filtro=""
 bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro =""
 	CASE "concepto"
      bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
 		bus_datawindow = "dw_ayuda_contaconcepto"
 CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event valores_numericos;call super::valores_numericos;f_valores_numericos(This,"cuenta")
f_valores_numericos(this,"concepto")


end event

event itemfocuschanged;call super::itemfocuschanged;f_cambio_linea(d_w)




end event

event retrieveend;call super::retrieveend;enabled = TRUE

end event

event retrievestart;call super::retrievestart;enabled = FALSE
end event

event rowfocuschanged;call super::rowfocuschanged;IF rowCount() = 0 Then Return
IF currentrow > 0 and Not IsNUll(currentrow) Then
	f_cambio_linea(d_w)
END IF
end event

event doubleclicked;IF dwo.name = "anali" Then
	IF Not f_asignacion_costes_apunte(Year(DAte(em_fasiento.text)),codigo_empresa,Month(DAte(em_fasiento.text)),uo_origen.em_codigo.text,Dec(em_asiento.text),object.apunte[Row]) Then
		// error al asignar el desglose analitico
	END IF
END IF
end event

type nombre_concepto from statictext within w_int_apuntes_general
integer x = 1463
integer y = 1588
integer width = 1463
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 33551858
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_borrar from u_boton within w_int_apuntes_general
event clicked pbm_bnclicked
integer x = 1541
integer y = 108
integer width = 480
integer height = 80
integer taborder = 10
boolean bringtotop = true
string text = " Borrar Asiento"
end type

event clicked;Dec r
IF MessageBox("Borrado del Asiento"," ¿Desa borrar el Asiento?",Question!,YesNo!,2)  = 2 Then
	Return
END IF


IF Messagebox("Proceso de baja de un apunte","¿Desea Restaurar la cartera?",Question!,YesNo!,1) = 1 Then 
		restaurar = "S"
ELSE
		restaurar = "N"
END IF

str_contaapun con
con.empresa   = codigo_empresa
con.origen    = uo_origen.em_codigo.text
con.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
con.mes       = Month(Date(em_fasiento.text))
con.fapunte = DateTime(Date(em_fasiento.text))
con.asiento = Dec(em_asiento.text)



For r = 1 To dw_debe.RowCOunt()
	IF Not f_restaurar_linea(dw_debe,r) Then
		f_mensaje("Error en proceso","Error al restaurar la cartera")
	END IF
Next
For r = 1 To dw_haber.RowCOunt()
	IF Not f_restaurar_linea(dw_haber,r) Then
		f_mensaje("Error en proceso","Error al restaurar la cartera")
	END IF
Next

Delete from contaapun
Where ejercicio = :con.ejercicio
And   empresa   = :con.empresa
And   mes       = :con.mes
And   origen    = :con.origen
And   asiento   = :con.asiento;

Delete from  costesapu
Where ejercicio = :con.ejercicio
And   empresa   = :con.empresa
And   mes       = :con.mes
And   origen    = :con.origen
And   asiento   = :con.asiento;

COMMIT;

dw_debe.reset()
dw_haber.reset()
dw_pagos.reset()
f_activar_campo(em_asiento)

end event

type dw_cobros from datawindow within w_int_apuntes_general
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
boolean visible = false
integer y = 388
integer width = 1463
integer height = 784
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_in_apuntes_carga_general4"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	This.visible = FALSE
END IF
end event

event doubleclicked;String fra,c,cta,pro,nulo
SetNUll(nulo)
Dec recibo,vanyo,vorden,vlinea,cc
Dec importe,bien = 0

IF dw_cobros.GetItemString(row,"situacion") <> "9" Then
	fra     = dw_cobros.GetItemString(row,"factura")
	recibo  = dw_cobros.GetItemNumber(row,"recibo")
	importe = dw_cobros.GetItemNumber(row,"importe")
	c = Trim(Trim(fra) +"/"+string(recibo,"#########"))
	dw_haber.SetItem(dw_haber.GetRow(),"ampliacion",c)
	dw_haber.SetItem(dw_haber.GetRow(),"importe",importe)
ELSE
	// Recuperacion del cobro desde el historico
	//-----------------------------------------------
	str_carefectos car	
	car.empresa = codigo_empresa
	car.anyo      = dw_cobros.GetItemNumber(row,"anyo")
	car.orden     = dw_cobros.GetItemNumber(row,"orden")
	vlinea     = dw_cobros.GetItemNumber(row,"linea")

	  SELECT   carhistorico.anyofra,   
         carhistorico.factura,   
         carhistorico.recibo,   
         carhistorico.fvto,   
         carhistorico.ffra,   
		 carhistorico.fvto_original, 
         carhistorico.importe,   
         carhistorico.divisas,   
         carhistorico.monedas,   
         carhistorico.fpago,   
         carhistorico.tipodoc,   
         carhistorico.banco,   
         carhistorico.agente1,   
         carhistorico.pais,   
         carhistorico.cuenta,   
         carhistorico.domiciliacion,   
         carhistorico.Nacional,   
         carhistorico.observaciones,   
         carhistorico.libre,   
         carhistorico.gasto,   
         carhistorico.fdevolucion,   
         carhistorico.agrupado,   
         carhistorico.efectoagrupa,   
         carhistorico.anyoagrupa,   
         carhistorico.cliente,   
         carhistorico.comision11,   
         carhistorico.comision12,   
         carhistorico.comision21,   
         carhistorico.comision22,   
         carhistorico.comision31,   
         carhistorico.comision32,   
         carhistorico.agente2,   
         carhistorico.agente3,   
         carhistorico.cambio,   
         carhistorico.serie  
    INTO :car.anyofra,   
         :car.factura,   
         :car.recibo,   
         :car.fvto,   
         :car.ffra,   
		:car.fvto_original, 
         :car.importe,   
         :car.divisas,   
         :car.monedas,   
         :car.fpago,   
         :car.tipodoc,   
         :car.banco,   
         :car.agente1,   
         :car.pais,   
         :car.cuenta,   
         :car.domiciliacion,   
         :car.nacional,   
         :car.observaciones,   
         :car.libre,   
         :car.gasto,   
         :car.fdevolucion,   
         :car.agrupado,   
         :car.efectoagrupa,   
         :car.anyoagrupa,   
         :car.cliente,   
         :car.comision11,   
         :car.comision12,   
         :car.comision21,   
         :car.comision22,   
         :car.comision31,   
         :car.comision32,   
         :car.agente2,   
         :car.agente3,   
         :car.cambio,   
         :car.serie  
    FROM carhistorico  
   WHERE ( carhistorico.empresa = :car.empresa ) AND  
         ( carhistorico.anyo = :car.anyo ) AND  
         ( carhistorico.orden = :car.orden ) AND  
         ( carhistorico.linea = :vlinea )   ;
			IF sqlca.sqlcode <> 0 Then bien = 0
			Delete from carhistorico
			Where  empresa = :car.empresa
			And    anyo    = :car.anyo
			And    orden   = :car.orden
			And    linea   = :vlinea;
			
			cc = 0
			Select count(*) Into :cc From carefectos
			Where  empresa   = :codigo_empresa
			And    anyo      = :car.anyo
			And    factura   = :car.factura
			And    recibo    = :car.recibo
			And    situacion = '0';
			IF cc <> 1 Then
					car.orden = 0
					Select Max(orden) Into :car.orden From carefectos
					Where  empresa = :car.empresa
					And    anyo    = :car.anyo;
					IF IsNUll(car.orden) Then car.orden = 0
					car.orden = car.orden +1
					car.situacion = '0'
					IF Not f_insert_carefectos(car) Then bien = 1
			ELSE
				Select orden Into :car.orden From carefectos
				Where  empresa   = :codigo_empresa
				And    anyo      = :car.anyo
				And    factura   = :car.factura
				And    recibo    = :car.recibo
				And    situacion = '0'
				And    tipodoc  In ('1','5');
				
					Update carefectos set importe = importe + :car.importe,
								  divisas = divisas + :car.importe
				  Where empresa = :codigo_empresa
				  And   anyo    = :car.anyo
				  And   orden   = :car.orden;
				  IF sqlca.sqlcode <> 0 Then bien = 1
			END IF
			

	
	//----------------------------------------------------------
		str_contaapun con
		con.empresa   = codigo_empresa
		con.origen    = uo_origen.em_codigo.text
		con.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
		con.mes       = Month(Date(em_fasiento.text))
		con.fapunte = DateTime(Date(em_fasiento.text))
		con.asiento = Dec(em_asiento.text)
		con.apunte  = dw_haber.GetItemNumber(dw_haber.GetRow(),"apunte")
		dw_haber.SetItem(dw_haber.GetRow(),"ampliacion",nulo)
		dw_haber.SetItem(dw_haber.GetRow(),"apunte",0)
		Update contaapun set ampliacion = null
		Where  ejercicio = :con.ejercicio
		And    empresa   = :codigo_empresa
		And    mes       = :con.mes
		And    origen    = :con.origen
		And    asiento   = :con.asiento
		And    apunte    = :con.apunte;
		IF sqlca.sqlcode <> 0 Then
			f_mensaje("Error dob_clik dw_cobros",sqlca.sqlerrtext)
			bien = 1
		END IF
		IF bien = 0 Then
			COMMIT;
			cta = dw_haber.GetItemString(dw_debe.GetRow(),"cuenta")
			Select codigo Into :pro  from genter
			Where empresa = :codigo_empresa
			and   tipoter = 'C'
			And   cuenta  = :cta;
			f_cambio_linea(dw_haber)
		ELSE
			ROLLBACK;
		END IF
	
END IF
dw_haber.SetFocus()
dw_haber.SetColumn("importe")
end event

type st_1 from statictext within w_int_apuntes_general
integer x = 55
integer y = 1712
integer width = 475
integer height = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "(*) Recibos en cartera"
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_apuntes_general
integer x = 55
integer y = 1760
integer width = 475
integer height = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "(*) Recibos  cobrados"
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_apuntes_general
integer x = 55
integer y = 1804
integer width = 475
integer height = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "(*) Recibos devueltos"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_int_apuntes_general
integer x = 27
integer y = 1668
integer width = 544
integer height = 216
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
end type

type gb_1 from groupbox within w_int_apuntes_general
integer x = 741
integer y = 1708
integer width = 1481
integer height = 156
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
end type

type dw_impagados from datawindow within w_int_apuntes_general
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
boolean visible = false
integer x = 1431
integer y = 484
integer width = 1518
integer height = 784
integer taborder = 80
string dataobject = "dw_in_apuntes_carga_general7_2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	This.visible = FALSE
END IF

IF f_objeto_datawindow(This) = "historico" Then
	String cta,pro
	cta = dw_debe.GetItemString(dw_debe.GetRow(),"cuenta")
	Select codigo Into :pro  from genter
	Where empresa = :codigo_empresa
	and   tipoter = 'C'
	And   cuenta  = :cta;
		dw_impagados.DataObject = "dw_in_apuntes_carga_general7"
		dw_impagados.SetTransObject(SQLCA)
		dw_impagados.Retrieve(codigo_empresa,pro)
END IF
end event

event doubleclicked;String fra,c,cta,pro,nulo
SetNUll(nulo)
Dec recibo,vanyo,vorden,vlinea,cc
Dec importe,bien = 0

//IF dw_impagados.GetItemString(row,"situacion") = "9" Then
	fra     = dw_impagados.GetItemString(row,"factura")
	recibo  = dw_impagados.GetItemNumber(row,"recibo")
	importe = dw_impagados.GetItemNumber(row,"importe")
	c = Trim(Trim(fra) +"/"+string(recibo,"#########"))
	dw_debe.SetItem(dw_debe.GetRow(),"ampliacion",c)
	dw_debe.SetItem(dw_debe.GetRow(),"importe",importe)
//ELSE
//	// Recuperacion del cobro desde el historico
//	//-----------------------------------------------
//	str_carefectos car	
//	car.empresa = codigo_empresa
//	car.anyo      = dw_cobros.GetItemNumber(row,"anyo")
//	car.orden     = dw_cobros.GetItemNumber(row,"orden")
//	vlinea     = dw_cobros.GetItemNumber(row,"linea")
//
//	  SELECT   carhistorico.anyofra,   
//         carhistorico.factura,   
//         carhistorico.recibo,   
//         carhistorico.fvto,   
//         carhistorico.ffra,   
//         carhistorico.importe,   
//         carhistorico.divisas,   
//         carhistorico.monedas,   
//         carhistorico.fpago,   
//         carhistorico.tipodoc,   
//         carhistorico.banco,   
//         carhistorico.agente1,   
//         carhistorico.pais,   
//         carhistorico.cuenta,   
//         carhistorico.domiciliacion,   
//         carhistorico.Nacional,   
//         carhistorico.observaciones,   
//         carhistorico.libre,   
//         carhistorico.gasto,   
//         carhistorico.fdevolucion,   
//         carhistorico.agrupado,   
//         carhistorico.efectoagrupa,   
//         carhistorico.anyoagrupa,   
//         carhistorico.cliente,   
//         carhistorico.comision11,   
//         carhistorico.comision12,   
//         carhistorico.comision21,   
//         carhistorico.comision22,   
//         carhistorico.comision31,   
//         carhistorico.comision32,   
//         carhistorico.agente2,   
//         carhistorico.agente3,   
//         carhistorico.cambio,   
//         carhistorico.serie  
//    INTO :car.anyofra,   
//         :car.factura,   
//         :car.recibo,   
//         :car.fvto,   
//         :car.ffra,   
//         :car.importe,   
//         :car.divisas,   
//         :car.monedas,   
//         :car.fpago,   
//         :car.tipodoc,   
//         :car.banco,   
//         :car.agente1,   
//         :car.pais,   
//         :car.cuenta,   
//         :car.domiciliacion,   
//         :car.nacional,   
//         :car.observaciones,   
//         :car.libre,   
//         :car.gasto,   
//         :car.fdevolucion,   
//         :car.agrupado,   
//         :car.efectoagrupa,   
//         :car.anyoagrupa,   
//         :car.cliente,   
//         :car.comision11,   
//         :car.comision12,   
//         :car.comision21,   
//         :car.comision22,   
//         :car.comision31,   
//         :car.comision32,   
//         :car.agente2,   
//         :car.agente3,   
//         :car.cambio,   
//         :car.serie  
//    FROM carhistorico  
//   WHERE ( carhistorico.empresa = :car.empresa ) AND  
//         ( carhistorico.anyo = :car.anyo ) AND  
//         ( carhistorico.orden = :car.orden ) AND  
//         ( carhistorico.linea = :vlinea )   ;
//			IF sqlca.sqlcode <> 0 Then bien = 0
//			Delete from carhistorico
//			Where  empresa = :car.empresa
//			And    anyo    = :car.anyo
//			And    orden   = :car.orden
//			And    linea   = :vlinea;
//			
//			cc = 0
//			Select count(*) Into :cc From carefectos
//			Where  empresa   = :codigo_empresa
//			And    anyo      = :car.anyo
//			And    factura   = :car.factura
//			And    recibo    = :car.recibo
//			And    situacion = '0';
//			IF cc <> 1 Then
//					car.orden = 0
//					Select Max(orden) Into :car.orden From carefectos
//					Where  empresa = :car.empresa
//					And    anyo    = :car.anyo;
//					IF IsNUll(car.orden) Then car.orden = 0
//					car.orden = car.orden +1
//					car.situacion = '0'
//					IF Not f_insert_carefectos(car) Then bien = 1
//			ELSE
//				Select orden Into :car.orden From carefectos
//				Where  empresa   = :codigo_empresa
//				And    anyo      = :car.anyo
//				And    factura   = :car.factura
//				And    recibo    = :car.recibo
//				And    situacion = '0'
//				And    tipodoc  In ('1','5');
//				
//					Update carefectos set importe = importe + :car.importe,
//								  divisas = divisas + :car.importe
//				  Where empresa = :codigo_empresa
//				  And   anyo    = :car.anyo
//				  And   orden   = :car.orden;
//				  IF sqlca.sqlcode <> 0 Then bien = 1
//			END IF
//			
//
//	
//	//----------------------------------------------------------
//		str_contaapun con
//		con.empresa   = codigo_empresa
//		con.origen    = uo_origen.em_codigo.text
//		con.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
//		con.mes       = Month(Date(em_fasiento.text))
//		con.fapunte = DateTime(Date(em_fasiento.text))
//		con.asiento = Dec(em_asiento.text)
//		con.apunte  = dw_haber.GetItemNumber(dw_haber.GetRow(),"apunte")
//		dw_haber.SetItem(dw_haber.GetRow(),"ampliacion",nulo)
//		dw_haber.SetItem(dw_haber.GetRow(),"apunte",0)
//		Update contaapun set ampliacion = null
//		Where  ejercicio = :con.ejercicio
//		And    empresa   = :codigo_empresa
//		And    mes       = :con.mes
//		And    origen    = :con.origen
//		And    asiento   = :con.asiento
//		And    apunte    = :con.apunte;
//		IF sqlca.sqlcode <> 0 Then
//			f_mensaje("Error dob_clik dw_cobros",sqlca.sqlerrtext)
//			bien = 1
//		END IF
//		IF bien = 0 Then
//			COMMIT;
//			cta = dw_haber.GetItemString(dw_debe.GetRow(),"cuenta")
//			Select codigo Into :pro  from genter
//			Where empresa = :codigo_empresa
//			and   tipoter = 'C'
//			And   cuenta  = :cta;
//			f_cambio_linea(dw_haber)
//		ELSE
//			ROLLBACK;
//		END IF
//	
//END IF

dw_debe.Setfocus()
dw_debe.SetRow(dw_debe.GetRow())
dw_debe.Setcolumn("importe")
end event

type dw_pagos from datawindow within w_int_apuntes_general
boolean visible = false
integer x = 1463
integer y = 396
integer width = 1463
integer height = 776
integer taborder = 100
string dataobject = "dw_in_apuntes_carga_general1"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;String fra,c,cta,pro,nulo
SetNUll(nulo)
Dec recibo,vanyo,vorden
Dec importe,bien = 0
IF dw_pagos.GetItemString(row,"carpagos_situacion") = "0" Then
	IF dw_debe.GetItemString(dw_debe.GetRow(),"ampliacion") <> "" Then
		c = ""
	ELSE
		fra     = dw_pagos.GetItemString(row,"carpagos_fra")
		recibo  = dw_pagos.GetItemNumber(row,"carpagos_recibo")
		importe = dw_pagos.GetItemNumber(row,"carpagos_importe")
		c = Trim(Trim(fra) +"/"+string(recibo,"#########"))
		dw_debe.SetItem(dw_debe.GetRow(),"importe",importe)
	END IF
	dw_debe.SetItem(dw_debe.GetRow(),"ampliacion",c)

	
ELSE
	vanyo      = dw_pagos.GetItemNumber(row,"carpagos_anyo")
	vorden     = dw_pagos.GetItemNumber(row,"carpagos_orden")
	Update carpagos Set situacion  = '0',
						         fpago  = null
		Where empresa = :codigo_empresa
		And   anyo    = :vanyo
		And   orden   = :vorden;
		IF sqlca.sqlcode <> 0 Then
			f_mensaje("Error dob_clik dw_pagos",sqlca.sqlerrtext)
			bien = 1
		END IF
		str_contaapun con
		con.empresa   = codigo_empresa
		con.origen    = uo_origen.em_codigo.text
		con.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
		con.mes       = Month(Date(em_fasiento.text))
		con.fapunte = DateTime(Date(em_fasiento.text))
		con.asiento = Dec(em_asiento.text)
		con.apunte  = dw_debe.GetItemNumber(dw_debe.GetRow(),"apunte")
		dw_debe.SetItem(dw_debe.GetRow(),"ampliacion",nulo)
		Update contaapun set ampliacion = null
		Where  ejercicio = :con.ejercicio
		And    empresa   = :codigo_empresa
		And    mes       = :con.mes
		And    origen    = :con.origen
		And    asiento   = :con.asiento
		And    apunte    = :con.apunte;
		IF sqlca.sqlcode <> 0 Then
			f_mensaje("Error dob_clik dw_pagos",sqlca.sqlerrtext)
			bien = 1
		END IF
		IF bien = 0 Then
			COMMIT;
			cta = dw_debe.GetItemString(dw_debe.GetRow(),"cuenta")
			Select codigo Into :pro  from genter
			Where empresa = :codigo_empresa
			And   cuenta  = :cta;
		ELSE
			ROLLBACK;
		END IF
	
END IF
f_cambio_linea(dw_debe)
dw_debe.SetFocus()
dw_debe.SetColumn("importe")
end event

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	This.visible = FALSE
END IF
end event

type dw_haber from u_datawindow within w_int_apuntes_general
event clicked pbm_dwnlbuttonclk
event getfocus pbm_dwnsetfocus
event itemfocuschanged pbm_dwnitemchangefocus
event rbuttondown pbm_dwnrbuttondown
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
event rowfocuschanged pbm_dwnrowchange
event key pbm_dwnkey
event valores_numericos pbm_custom01
integer x = 1463
integer y = 192
integer width = 1463
integer height = 1392
integer taborder = 0
string dataobject = "dw_in_apuntes_carga_general3"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;d_w = This
IF d_w.RowCOunt() = 0 Then
	f_nueva(d_w)
	Return
END IF
dw_pagos.visible = FALSE
str_parametros lstr_param
IF f_objeto_datawindow(dw_debe) = "t_cuenta" Then
	OpenWithParm(wi_mant_contaplan,lstr_param)
end if
f_activar(FALSE)
f_cambio_linea(d_w)

end event

event getfocus;call super::getfocus;d_w = This
IF d_w.RowCount() = 0 Then
	f_nueva(d_w)
END IF
end event

event itemfocuschanged;call super::itemfocuschanged;f_cambio_linea(d_w)


end event

event rbuttondown;
 bus_filtro=""
 bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro =""
 	CASE "concepto"
      bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
 		bus_datawindow = "dw_ayuda_contaconcepto"
 CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event retrieveend;call super::retrieveend;enabled = TRUE

end event

event retrievestart;call super::retrievestart;enabled = FALSE
end event

event rowfocuschanged;call super::rowfocuschanged;IF rowCount() = 0 Then Return
IF currentrow > 0 and Not IsNUll(currentrow) Then
	f_cambio_linea(d_w)
END IF
end event

event key;

IF Not KeyDown(KeyEnter!) Then
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro =""
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

IF  KeyDown(KeyInsert!) THEN
		This.AcceptText()
		IF Not f_control(d_w) Then Return
		  f_nueva(d_w)
END IF
end event

event valores_numericos;call super::valores_numericos;f_valores_numericos(This,"cuenta")
f_valores_numericos(this,"concepto")


end event

event doubleclicked;IF dwo.name = "anali" Then
	IF Not f_asignacion_costes_apunte(Year(DAte(em_fasiento.text)),codigo_empresa,Month(DAte(em_fasiento.text)),uo_origen.em_codigo.text,Dec(em_asiento.text),object.apunte[Row]) Then
		// error al asignar el desglose analitico
	END IF
END IF
end event

type uo_ejercicio from u_ejercicio within w_int_apuntes_general
event destroy ( )
integer x = 2057
integer y = 28
integer height = 276
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type st_11 from statictext within w_int_apuntes_general
integer x = 2263
integer y = 1676
integer width = 475
integer height = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "(11) Cobro"
boolean focusrectangle = false
end type

type st_14 from statictext within w_int_apuntes_general
integer x = 2263
integer y = 1716
integer width = 475
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "(12) Cobro devolucion"
boolean focusrectangle = false
end type

type st_15 from statictext within w_int_apuntes_general
integer x = 2263
integer y = 1836
integer width = 480
integer height = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "(15) Gastos Impagados"
boolean focusrectangle = false
end type

type st_125 from statictext within w_int_apuntes_general
integer x = 2263
integer y = 1796
integer width = 480
integer height = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "(14) Int. Impagados"
boolean focusrectangle = false
end type

type st_135 from statictext within w_int_apuntes_general
integer x = 2263
integer y = 1876
integer width = 480
integer height = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "(40) Pago Fra."
boolean focusrectangle = false
end type

type dw_listado2 from datawindow within w_int_apuntes_general
boolean visible = false
integer x = 256
integer y = 168
integer width = 494
integer height = 360
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_in_carga_general_costes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado3 from datawindow within w_int_apuntes_general
boolean visible = false
integer x = 1723
integer y = 40
integer width = 494
integer height = 360
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_in_apuntes_general_costes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_33 from statictext within w_int_apuntes_general
integer x = 2263
integer y = 1752
integer width = 489
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "(13) Cobro Dev. Gastos"
boolean focusrectangle = false
end type

