$PBExportHeader$w_int_contaapun.srw
$PBExportComments$€
forward
global type w_int_contaapun from w_int_con_empresa
end type
type pb_salir from upb_salir within w_int_contaapun
end type
type em_asiento from u_em_campo within w_int_contaapun
end type
type st_asiento from statictext within w_int_contaapun
end type
type em_fasiento from u_em_campo within w_int_contaapun
end type
type st_2 from statictext within w_int_contaapun
end type
type pb_altas from u_calculadora within w_int_contaapun
end type
type st_4 from statictext within w_int_contaapun
end type
type uo_recur from u_em_campo_2 within w_int_contaapun
end type
type st_3 from statictext within w_int_contaapun
end type
type uo_origen from u_em_campo_2 within w_int_contaapun
end type
type cb_borrar from u_boton within w_int_contaapun
end type
type pb_1 from upb_imprimir within w_int_contaapun
end type
type dw_listado from datawindow within w_int_contaapun
end type
type dw_apuntes from datawindow within w_int_contaapun
end type
type st_11 from statictext within w_int_contaapun
end type
type uo_ejercicio from u_ejercicio within w_int_contaapun
end type
type dw_detalle from u_datawindow within w_int_contaapun
end type
type dw_iva from u_datawindow within w_int_contaapun
end type
end forward

global type w_int_contaapun from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3703
integer height = 2944
string title = "Consulta de Movimientos"
pb_salir pb_salir
em_asiento em_asiento
st_asiento st_asiento
em_fasiento em_fasiento
st_2 st_2
pb_altas pb_altas
st_4 st_4
uo_recur uo_recur
st_3 st_3
uo_origen uo_origen
cb_borrar cb_borrar
pb_1 pb_1
dw_listado dw_listado
dw_apuntes dw_apuntes
st_11 st_11
uo_ejercicio uo_ejercicio
dw_detalle dw_detalle
dw_iva dw_iva
end type
global w_int_contaapun w_int_contaapun

type variables
String 	Modo,conta_i
Dec{0}	asiento_i,apunte_i
end variables

forward prototypes
public subroutine f_visualizar ()
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
public subroutine f_datos_iva ()
public subroutine f_orden_datos_iva (boolean bool)
public subroutine f_ok ()
public function boolean f_recurente (string cod)
public subroutine f_cambio_linea_costes (integer reg)
public function string f_datos_costes ()
end prototypes

public subroutine f_visualizar ();IF dw_detalle.retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,Month(Date(em_fasiento.text)),uo_origen.em_codigo.text,Dec(em_asiento.text)) <> 0 Then
//	cb_borrar.enabled = TRUE
ELSE
//	cb_borrar.enabled = FALSE
END IF

modo = "M"
f_activar_campo(em_asiento)
end subroutine

public subroutine f_cambio_linea (integer reg);Integer ln
if dw_detalle.RowCount() = 0 tHEN Return
iF IsNull(reg) Then Return
IF reg = 0 Then Return
ln = Integer(dw_detalle.Describe("DataWindow.LastRowOnPage"))
dw_detalle.SetItem(ln,"cta",dw_detalle.GetItemString(reg,"cuenta"))
dw_detalle.SetItem(ln,"con",dw_detalle.GetItemString(reg,"concepto"))
dw_detalle.AcceptText()

end subroutine

public subroutine f_nueva ();Integer reg
reg = dw_detalle.RowCount() + 1
dw_detalle.InsertRow(reg)
dw_detalle.SetItem(reg,"debe",0)
dw_detalle.SetItem(reg,"haber",0)

f_valores_fijos(reg)
f_activar_linea(reg)

end subroutine

public subroutine f_confirmar ();Dec v_ejercicio,v_mes,reg,cn,bien,ap,ap2
String cta,tipocta
bien = 0
dec{2} total_debe, total_haber

if f_mes_cerrado(codigo_empresa,integer(uo_ejercicio.em_ejercicio.text),month(date(em_fasiento.text))) then
	messagebox("No se puede continuar","El mes está cerrado")
	return	
end if

DateTime fecha
SetNull(fecha)
String v_origen,tipoapu
Dec asto,re,re1,ra

IF Not f_control() Then Return

total_Debe = dw_detalle.getItemNumber(dw_detalle.RowCount(),"totald") 
total_haber =  dw_detalle.getItemNumber(dw_detalle.RowCount(),"totalh")

IF total_debe <> total_haber Then
	IF MessageBox("Apunte Descuadrado","¿Grabar Apunte Descuadrado?",Question!,YesNo!) = 2 Then
		f_activar_linea(dw_detalle.RowCount())
		return
	END IF
END IF
v_origen    = uo_origen.em_codigo.text
v_ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
v_mes       = Month(Date(em_fasiento.text))

IF Modo = "I" Then
	asto = f_ultimo_asiento(v_ejercicio,codigo_empresa,v_mes,v_origen)
	em_asiento.text   = String(asto,f_mascara_decimales(0))
	// David 17-06-04: Cada vez que le damos a grabar nos daba siempres un número de asiento nuevo
	Modo = "M"
ELSE
	asto = Dec(em_asiento.text)
END IF

Select Max(apunte) Into :ap From contaapun
Where  ejercicio  = :v_ejercicio
And    empresa    = :codigo_empresa
And    mes        = :v_mes
And    origen		= :v_origen
And    asiento		= :asto;
IF IsNull(ap) Then ap = 0
re1 = dw_detalle.RowCount()
For re = 1 To re1 
	ap2 = dw_detalle.GetItemNumber(re,"apunte")
	tipoapu = dw_detalle.GetItemString(re,"tipoapu")

	IF IsNull(ap2 ) Then ap2 = 0
		IF ap2 = 0 Then
			ap = ap +1
			dw_detalle.SetItem(re,"apunte",ap)
			IF Not IsNUll(tipoapu) and Trim(tipoapu) <> "" Then
				IF  f_tipo_contador_contalibros(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,tipoapu) = "C" Then
					reg = f_registro_tipoiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_detalle.getItemSTring(re,"tipoiva"))
					dw_detalle.SetItem(re,"registro",reg)
					IF Not f_actualizar_contalibros(v_ejercicio,codigo_empresa,tipoapu,reg) Then bien = 1
				END IF
			END IF
		END IF
		dw_detalle.SetItem(re,"asiento",asto)
		dw_detalle.SetItem(re,"orden_apunte",re)
		dw_detalle.SetItem(re,"fapunte",DateTime(Date(em_fasiento.text)))
		dw_detalle.SetItem(re,"origen",uo_origen.em_codigo.text)
		dw_detalle.SetItem(re,"actualizado","N")
		dw_detalle.SetItem(re,"listado","N")
		dw_detalle.SetItem(re,"conciliado","N")
		//dw_detalle.SetItem(re,"punteado",fecha)
		dw_detalle.SetItem(re,"fvalor",fecha)
		v_ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
		cta =  dw_detalle.getItemString(re,"cuenta")
		tipocta = f_tipocta_contaplan(v_ejercicio,codigo_empresa,cta)
		
	// esto esta tapado porque puede haber apunte de iva en cuentas de
	// clientes o proveedores porque el iva sea 0
	
	
//	IF tipocta =  f_tipocta_iva_contaparam(v_ejercicio,codigo_empresa) Then
	IF Trim(dw_detalle.GetItemString(re,"tipoiva")) <> "" THEN
		tipoapu = f_libro_contaiva(v_ejercicio,codigo_empresa,dw_detalle.GetItemString(re,"tipoiva"))
		dw_detalle.SetItem(re,"tipoapu",tipoapu)
	END IF
//	ELSE
//				dw_detalle.SetItem(re,"tipoiva","")
//				dw_detalle.SetItem(re,"iva",0)
//				dw_detalle.SetItem(re,"clipro","")
//				dw_detalle.SetItem(re,"tipoter","")
//				dw_detalle.SetItem(re,"tipoapu","")
//				dw_detalle.SetItem(re,"imponible",0)
//				dw_detalle.SetItem(re,"factura","")
//				dw_detalle.SetItem(re,"fregistro",fecha)
//				dw_detalle.SetItem(re,"nif","")
//	END IF
NEXT
String vale = "1"

IF dw_detalle.Update() = -1 Then bien = 1
IF bien = 0 Then 
	vale = f_datos_costes()	// mira si hay analitica en algun apunte
	IF vale = "0" THEN
		bien = 1
	ELSE
		bien = 0
	END IF
END IF
IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso","La operacion no se contabiliza")
END IF

dw_iva.visible = FALSE
f_activar(TRUE)
f_activar_campo(uo_origen.em_campo)

end subroutine

public subroutine f_salir ();decimal v_debe, v_haber
long v_mes, v_asiento, v_ejercicio

v_mes = month(date(em_fasiento.text))
v_asiento = long(em_asiento.text)
v_ejercicio = long(uo_ejercicio.em_ejercicio.text)

select sum(debe), sum(haber)
into :v_debe, :v_haber
from contaapun
where empresa = :codigo_empresa
and ejercicio = :v_ejercicio
and asiento = :v_asiento
and origen = :uo_origen.em_codigo.text
and mes = :v_mes;

if v_debe <> v_haber then
	messagebox ("Atención, Atención", "Asiento descuadrado")
	return
end if

IF MessageBox("Salir del Asiento sin grabar","¿Salir sin grabar?",Question!,YesNo!)= 2 Then 
	Return
END IF
f_activar(TRUE)
dw_detalle.Reset()
dw_iva.Reset()
dw_iva.visible = FALSE
uo_recur.em_codigo.text = ""
uo_recur.em_campo.text = ""
em_asiento.text= ""
f_activar_campo(uo_origen.em_campo)

end subroutine

public subroutine f_activar (boolean boo);em_asiento.enabled = boo
em_fasiento.enabled =boo
uo_origen.enabled =boo
uo_recur.enabled =boo
uo_ejercicio.enabled = boo
pb_altas.enabled = boo
pb_salir.enabled = boo
//cb_borrar.enabled = boo
st_asiento.enabled = boo
pb_1.enabled = boo

end subroutine

public function boolean f_control ();Integer      r, r1 
String      cta,ncta
Dec 			poriva
Dec{2}		impiva,debe,haber,imponible,importe


r1 = dw_detalle.RowCount()
IF r1 = 0 Then Return False
For r = 1 To r1
	cta    = dw_detalle.GetItemString(r,"cuenta")
	debe   = dw_detalle.GetItemNumber(r,"debe")
	haber  = dw_detalle.GetItemNumber(r,"haber")
	IF IsNull(debe)  Then debe = 0
	IF IsNull(haber) Then haber = 0
	IF IsNUll(cta) or Trim(cta) = "" Then 
		f_mensaje("Campo Obligatorio","Introducir Cuenta Contable Línea "+string(r))
		dw_detalle.SetFocus()
		dw_detalle.SetRow(r)
		dw_detalle.SetColumn("cuenta")
		Return False
	END IF
	ncta = f_nombre_contaplan(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cta)
	IF IsNUll(ncta) or Trim(ncta) = "" Then 
		f_mensaje("Campo Obligatorio","Introducir Cuenta Contable Línea "+string(r))
		dw_detalle.SetFocus()
		dw_detalle.SetRow(r)
		dw_detalle.SetColumn("cuenta")
		Return False
	END IF
		// Controlamos si han modificado los importes de Iva para
		// ver si tambien hay que modificar la base Imponible
	IF Trim(dw_detalle.GetItemString(r,"tipoiva")) <> "" THEN
		IF debe <> 0 THEN
			importe = debe
		ELSE
			importe = haber
		END IF
		imponible = dw_detalle.GetItemNumber(r,"imponible")
		poriva 	 = dw_detalle.GetItemNumber(r,"iva")
		impiva	 = imponible * poriva / 100
		IF importe <> impiva THEN
			int opci 
			
			opci = messagebox("DESCUADRE","La base imponible en registro de IVA no está modificada. ¿ Desea continuar?",question!,yesno!,2)
			if opci = 2 then RETURN FALSE
			
		END IF
	END IF
Next
Return True
end function

public subroutine f_valores_fijos (integer reg);dw_detalle.SetItem(reg,"empresa",codigo_empresa)
dw_detalle.SetItem(reg,"ejercicio",Dec(uo_ejercicio.em_ejercicio.text))
dw_detalle.SetItem(reg,"asiento",Dec(em_asiento.text))
dw_detalle.SetItem(reg,"origen",uo_origen.em_codigo.text)
dw_detalle.SetItem(reg,"fapunte",DateTime(Date(em_fasiento.text)))
dw_detalle.SetItem(reg,"mes",Month(Date(em_fasiento.text)))
dw_detalle.SetItem(reg,"debe",0)
dw_detalle.SetItem(reg,"haber",0)
if reg > 1 then
	dw_detalle.object.ampliacion[reg] = dw_detalle.object.ampliacion[reg -1]
	dw_detalle.object.concepto[reg]   = dw_detalle.object.concepto[reg -1]
end if

end subroutine

public subroutine f_insertar_linea ();Integer r,donde

if year(date(em_fasiento.text)) <> dec(uo_ejercicio.em_ejercicio.text) then
	messagebox("¡¡ATENCION!!","La fecha del apunte no se corresponde con el ejercicio")
	return
end if
// Santiago 13/09/00. Siempre inserta al final
//r = dw_detalle.GetRow()
//
//IF r = dw_detalle.RowCount() THEN
//	r = 0
//END IF
r = dw_detalle.RowCount() + 1
// Santiago 13/09/00. Siempre inserta al final

donde = dw_detalle.InsertRow(r)
f_valores_fijos(donde)
f_activar_linea(donde)

end subroutine

public subroutine f_activar_linea (integer reg);dw_detalle.SetFocus()
dw_detalle.SetRow(reg)
dw_detalle.ScrollToRow(reg)
dw_detalle.SetColumn("cuenta")

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

public subroutine f_datos_iva ();Int r
String iv,tipocta
Dec {0}	ejer

r = dw_detalle.getRow()

IF r = 0 Then return

IF dw_iva.visible = FALSE Then	dw_iva.visible = TRUE

IF dw_iva.RowCount() = 0 Then
	dw_iva.Reset()
	dw_iva.InsertRow(0)
END IF

ejer = Dec(uo_ejercicio.em_ejercicio.text)

dw_iva.SetItem(1,"ejercicio",Dec(uo_ejercicio.em_ejercicio.text))
dw_iva.SetItem(1,"empresa",codigo_empresa)
dw_iva.SetItem(1,"cuenta",dw_detalle.GetItemString(r,"cuenta"))
dw_iva.SetItem(1,"tipo_iva",dw_detalle.GetItemString(r,"tipoiva"))
dw_iva.SetItem(1,"clipro",dw_detalle.GetItemString(r,"clipro"))
dw_iva.SetItem(1,"tipoter",dw_detalle.GetItemString(r,"tipoter"))
dw_iva.SetItem(1,"imponible",dw_detalle.GetItemNumber(r,"imponible"))
tipocta = f_tipocta_contaplan(ejer,codigo_empresa,dw_detalle.GetItemString(r,"cuenta"))
IF dw_detalle.GetItemString(r,"tipoter")= "C" Then
	IF tipocta = f_tipocta_iva_contaparam(ejer,codigo_empresa) Then
		dw_iva.SetItem(1,"importe",dw_detalle.GetItemNumber(r,"haber"))
	ELSE
		dw_iva.SetItem(1,"importe",0)
	END IF
	dw_iva.SetItem(1,"registro",Dec(dw_detalle.GetItemString(r,"documento")))
ELSE
	IF tipocta = f_tipocta_iva_contaparam(ejer,codigo_empresa) Then
		dw_iva.SetItem(1,"importe",dw_detalle.GetItemNumber(r,"debe"))
	ELSE
		dw_iva.SetItem(1,"importe",0)
	END IF
	dw_iva.SetItem(1,"registro",dw_detalle.GetItemNumber(r,"registro"))
END IF
dw_iva.SetItem(1,"factura",dw_detalle.GetItemString(r,"factura"))
dw_iva.SetItem(1,"ffactura",dw_detalle.GetItemDateTime(r,"ffactura"))
dw_iva.SetItem(1,"fregistro",dw_detalle.GetItemDateTime(r,"fregistro"))
dw_iva.SetItem(1,"nif",dw_detalle.GetItemString(r,"nif"))
iv = dw_detalle.GetItemString(r,"tipoiva")
IF IsNull(iv) or Trim(iv) = "" Then
	f_orden_datos_iva(TRUE)
	dw_iva.Setfocus()
	dw_iva.SetRow(1)
	dw_iva.SetColumn("tipo_iva")
ELSE
	f_orden_datos_iva(FALSE)
END IF

if f_contasii_calendario_bloqueado(codigo_empresa,datetime(date(em_fasiento.text))) then
	dw_iva.enabled = false
else
	dw_iva.enabled = true
end if
end subroutine

public subroutine f_orden_datos_iva (boolean bool);IF bool Then
	dw_iva.SetTabOrder("tipo_iva",1)
	dw_iva.SetTabOrder("factura",2)
	dw_iva.SetTabOrder("ffactura",3)
	dw_iva.SetTabOrder("clipro",4)
	dw_iva.SetTabOrder("nif",5)
	dw_iva.SetTabOrder("imponible",6)
	dw_iva.SetTabOrder("importe",7)
	dw_iva.SetTabOrder("registro",8)
	dw_iva.SetTabOrder("fregistro",9)
//	dw_iva.imponible.enabled = TRUE
//	dw_iva.importe.enabled   = TRUE
ELSE
	dw_iva.SetTabOrder("tipo_iva",0)
	dw_iva.SetTabOrder("factura",0)
	dw_iva.SetTabOrder("ffactura",0)
	dw_iva.SetTabOrder("clipro",0)
	dw_iva.SetTabOrder("nif",0)
	dw_iva.SetTabOrder("imponible",0)
	dw_iva.SetTabOrder("importe",0)
	dw_iva.SetTabOrder("registro",0)
	dw_iva.SetTabOrder("fregistro",0)
//	dw_iva.imponible.enabled = FALSE
//	dw_iva.importe.enabled   = FALSE
END IF


end subroutine

public subroutine f_ok ();Dec 		r,ejer,imponible,poriva
Dec	   impiva
String 	tp,tipocta

ejer = Dec(uo_ejercicio.em_ejercicio.text)

r = dw_detalle.getRow()
IF r = 0 Then return

dw_iva.accepttext()

imponible  = dw_iva.GetItemNumber(1,"imponible")
poriva	  = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.GetItemString(1,"tipo_iva"))
tp 		  = dw_iva.GetItemString(1,"tipo_iva")

// Control de que si han modificado la base imponible no coincide con 
// el importe de IVA


impiva = imponible * poriva / 100

impiva = round(impiva, 2)

IF impiva <> dw_iva.GetItemNumber(1,"importe") THEN
	f_mensaje("DESCUADRE","La base imponible no se corresponde con el importe de IVA")
	RETURN
END IF

//Control de factura repetida
string   ls_factura,ls_tipoter,ls_clipro
long     ll_ejercicio
datetime ldt_ffactura

long ll_contaapun_ejercicio,ll_contaapun_asiento,ll_existe_factura_en_otro_asiento
int  li_contaapun_mes
string ls_contaapun_origen

ls_factura   = dw_iva.object.factura[1]
ldt_ffactura = dw_iva.object.ffactura[1]
ll_ejercicio = year(date(ldt_ffactura))
ls_tipoter   = dw_iva.object.tipoter[1]
ls_clipro    = dw_iva.object.clipro[1]

ll_contaapun_ejercicio = dw_detalle.object.ejercicio[r]
ll_contaapun_asiento   = dw_detalle.object.asiento[r]
ls_contaapun_origen    = dw_detalle.object.origen[r]
li_contaapun_mes       = dw_detalle.object.mes[r]

//Para asientos nuevos que se insertan como nulos
if isnull(ll_contaapun_asiento) then ll_contaapun_asiento = 0

select isnull(count(*),0)
into   :ll_existe_factura_en_otro_asiento
from   contaapun
where  contaapun.empresa   = :codigo_empresa
and  ( contaapun.ejercicio <> :ll_contaapun_ejercicio
or     contaapun.asiento   <> :ll_contaapun_asiento
or     contaapun.origen    <> :ls_contaapun_origen
or     contaapun.mes       <> :li_contaapun_mes )
and    contaapun.factura               = :ls_factura
and    datepart(yy,contaapun.ffactura) = :ll_ejercicio
and    contaapun.tipoter               = :ls_tipoter
and    contaapun.clipro                = :ls_clipro;

if ll_existe_factura_en_otro_asiento > 0 then
	messagebox("¡Error!","Se está introduciendo una factura duplicada.~nRevise los datos.")
	return	
end if

dw_detalle.SetItem(r,"tipoiva",tp)
dw_detalle.SetItem(r,"iva",poriva)
dw_detalle.SetItem(r,"tipoapu",f_libro_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.GetItemString(1,"tipo_iva")))
dw_detalle.SetItem(r,"clipro",dw_iva.GetItemString(1,"clipro"))
dw_detalle.SetItem(r,"tipoter",dw_iva.GetItemString(1,"tipoter"))
dw_detalle.SetItem(r,"imponible",imponible)
		
	// asignacion debe o haber segun libro cuando tiene apunte de iva.
	// Si no, al estar en el apunte al cliente o proveedor no se asigna
	// nada porque el importe de iva es 0

tipocta = f_tipocta_contaplan(ejercicio_activo,codigo_empresa,dw_detalle.GetItemString(r,"cuenta"))

IF tipocta = f_tipocta_iva_contaparam(ejer,codigo_empresa) THEN
	IF f_tipo_cta_libro(ejer,codigo_empresa,f_libro_contaiva(ejer,codigo_empresa,tp)) = "H" Then
		//Baldocer (Siempre apuntes positivos)
		if dw_iva.GetItemNumber(1,"importe")>0 then
			dw_detalle.SetItem(r,"haber",dw_iva.GetItemNumber(1,"importe"))
		else
			dw_detalle.SetItem(r,"debe",abs( dw_iva.GetItemNumber(1,"importe")))
		end if
	ELSE
		if dw_iva.GetItemNumber(1,"importe")>0 then
			dw_detalle.SetItem(r,"debe",dw_iva.GetItemNumber(1,"importe"))
		else
			dw_detalle.SetItem(r,"haber", abs( dw_iva.GetItemNumber(1,"importe")))
		end if
	END IF
END IF

dw_detalle.SetItem(r,"registro",dw_iva.GetItemNumber(1,"registro"))
dw_detalle.SetItem(r,"factura",dw_iva.GetItemString(1,"factura"))
dw_detalle.SetItem(r,"documento",dw_iva.GetItemString(1,"factura"))
dw_detalle.SetItem(r,"ffactura",dw_iva.GetItemDateTime(1,"ffactura"))
dw_detalle.SetItem(r,"fregistro",dw_iva.GetItemDateTime(1,"fregistro"))
dw_detalle.SetItem(r,"nif",dw_iva.GetItemString(1,"nif"))
dw_detalle.SetFocus()
dw_detalle.SetRow(r)
dw_detalle.SetColumn("concepto")
end subroutine

public function boolean f_recurente (string cod);STring    prog
prog = f_programa_contarecur(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cod)
IF IsNull(prog) Then prog = ""
IF Trim(prog) <> "" Then 
	str_parametros lstr_param
	lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[1]  = "w_int_contaapun"
	lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[2]=uo_ejercicio.em_ejercicio.text
	Window ventana
	OpenWithParm(ventana,lstr_param,prog)
	em_asiento.text = Message.StringParm
	f_visualizar()
	uo_recur.em_codigo.text = ""
	uo_recur.em_campo.text = ""
	Return FALSE
END IF




DataStore  dw_comodin
Int r1,r
STring sel
sel = " Select * from contarecurlin" + &
		" Where ejercicio = "+ uo_ejercicio.em_ejercicio.text+&
		" And   empresa   =  '"+codigo_empresa+"'"+ &
		" And   codigo    = '"+ cod +"' Order By Linea"
//dw_comodin = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw_comodin)
r1 = dw_comodin.RowCount()
IF r1 = 0 Then Return FALSE
For r =1 To r1
  dw_detalle.InsertRow(r)
  f_valores_fijos(r)
  dw_detalle.SetItem(r,"cuenta",dw_comodin.getItemSTring(r,"cuenta"))
  dw_detalle.SetItem(r,"concepto",dw_comodin.getItemSTring(r,"concepto"))
  dw_detalle.SetItem(r,"ampliacion",dw_comodin.getItemSTring(r,"ampliacion"))
Next
f_activar_linea(1)
Return TRUE
destroy dw_comodin
end function

public subroutine f_cambio_linea_costes (integer reg);//Integer ln
//if dw_costes.RowCount() = 0 tHEN Return
//iF IsNull(reg) Then Return
//IF reg = 0 Then Return
//ln = Integer(dw_costes.Describe("DataWindow.LastRowOnPage"))
//dw_costes.SetItem(ln,"cta",dw_costes.GetItemString(reg,"coste"))
//dw_costes.SetItem(ln,"con",dw_costes.GetItemString(reg,"concepto"))
//dw_costes.AcceptText()
//
end subroutine

public function string f_datos_costes ();Int 		r,xx,mes,rr,xy,vale
String	ana,origen,coste,concepto,ampliacion
Dec{0}	importe_d,importe_h,parcial,pasado,sumado,difer,suma,ejer
Dec{2}	porcent
Datetime	fapunte

r = dw_detalle.RowCount()
IF r = 0 Then Return "0"
ejer = Dec(uo_ejercicio.em_ejercicio.text)

For xx = 1 To r
	conta_i = f_valor_columna(dw_detalle,xx,"cuenta")
	SELECT contaplan.analitica  
    INTO :ana  
    FROM contaplan  
   WHERE ( contaplan.ejercicio = :ejer) AND  
         ( contaplan.empresa = :codigo_empresa ) AND  
         ( contaplan.cuenta = :conta_i )   ;
	IF ana <> 'S'  OR  IsNull(ana) = TRUE Then	Continue 

	mes        = Integer(f_valor_columna(dw_detalle,xx,"mes"))
	origen     = f_valor_columna(dw_detalle,xx,"origen")
	asiento_i  = Dec(f_valor_columna(dw_detalle,xx,"asiento"))
	
	importe_d  = Dec(f_valor_columna(dw_detalle,xx,"debe"))
	importe_h  = Dec(f_valor_columna(dw_detalle,xx,"haber"))
	apunte_i   = Dec(f_valor_columna(dw_detalle,xx,"apunte"))
	concepto   = f_valor_columna(dw_detalle,xx,"concepto")
	ampliacion = f_valor_columna(dw_detalle,xx,"ampliacion")
	fapunte    = dw_detalle.GetItemDateTime(xx,"fapunte")
	
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
		Return vale_st
	END IF
Next
Return "1"
end function

event open;call super::open;This.title = " INTRODUCCION DE APUNTES CONTABLES"
em_fasiento.text = String(Today(),"dd-mm-yy")


dw_detalle.SetTransObject(SQLCA)
dw_detalle.visible = TRUE
f_mascara_columna(dw_detalle,"totald",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"totalh",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"debe",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"haber",f_mascara_decimales(2))
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	uo_ejercicio.em_ejercicio.text =istr_parametros.s_argumentos[2]
	uo_origen.em_codigo.text     = istr_parametros.s_argumentos[3]
	em_fasiento.text   = String(Date(istr_parametros.s_argumentos[4]),"dd-mm-yy")
	em_asiento.text    = istr_parametros.s_argumentos[5]   
	uo_origen.TriggerEvent("modificado")
	f_visualizar()
END IF
	
//
//if f_permisos_usuario("2") then
//	cb_borrar.enabled = true
//else
//	cb_borrar.enabled = false
//end if
//	
f_activar_campo(uo_origen.em_campo)


end event

on w_int_contaapun.create
int iCurrent
call super::create
this.pb_salir=create pb_salir
this.em_asiento=create em_asiento
this.st_asiento=create st_asiento
this.em_fasiento=create em_fasiento
this.st_2=create st_2
this.pb_altas=create pb_altas
this.st_4=create st_4
this.uo_recur=create uo_recur
this.st_3=create st_3
this.uo_origen=create uo_origen
this.cb_borrar=create cb_borrar
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.dw_apuntes=create dw_apuntes
this.st_11=create st_11
this.uo_ejercicio=create uo_ejercicio
this.dw_detalle=create dw_detalle
this.dw_iva=create dw_iva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_salir
this.Control[iCurrent+2]=this.em_asiento
this.Control[iCurrent+3]=this.st_asiento
this.Control[iCurrent+4]=this.em_fasiento
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.pb_altas
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.uo_recur
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.uo_origen
this.Control[iCurrent+11]=this.cb_borrar
this.Control[iCurrent+12]=this.pb_1
this.Control[iCurrent+13]=this.dw_listado
this.Control[iCurrent+14]=this.dw_apuntes
this.Control[iCurrent+15]=this.st_11
this.Control[iCurrent+16]=this.uo_ejercicio
this.Control[iCurrent+17]=this.dw_detalle
this.Control[iCurrent+18]=this.dw_iva
end on

on w_int_contaapun.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_salir)
destroy(this.em_asiento)
destroy(this.st_asiento)
destroy(this.em_fasiento)
destroy(this.st_2)
destroy(this.pb_altas)
destroy(this.st_4)
destroy(this.uo_recur)
destroy(this.st_3)
destroy(this.uo_origen)
destroy(this.cb_borrar)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.dw_apuntes)
destroy(this.st_11)
destroy(this.uo_ejercicio)
destroy(this.dw_detalle)
destroy(this.dw_iva)
end on

event ue_f5;IF pb_altas.enabled = TRUE Then
	pb_altas.TriggerEvent(Clicked!)
ELSE
	f_confirmar()
END IF

//f_confirmar()
end event

event ue_esc;IF pb_salir.enabled = TRUE Then
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

event ue_f2;call super::ue_f2;
	f_insertar_linea()

end event

event ue_f3;call super::ue_f3;
	f_borrar_linea()

end event

event closequery;IF not pb_salir.enabled  Then
	IF MessageBox("Salir del Asiento sin grabar","¿Salir sin grabar?",Question!,YesNo!)= 2 Then 
		Return 1
	END IF
END IF
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_contaapun
integer x = 800
integer y = 816
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_contaapun
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_contaapun
integer y = 20
integer width = 3598
end type

type pb_salir from upb_salir within w_int_contaapun
integer x = 3497
integer y = 208
integer width = 110
integer height = 96
integer taborder = 0
boolean cancel = false
boolean originalsize = true
string disabledname = "Exit!"
end type

event clicked;decimal v_debe, v_haber
long v_mes, v_asiento, v_ejercicio

v_mes = month(date(em_fasiento.text))
v_asiento = long(em_asiento.text)
v_ejercicio = long(uo_ejercicio.em_ejercicio.text)

select sum(debe), sum(haber)
into :v_debe, :v_haber
from contaapun
where empresa = :codigo_empresa
and ejercicio = :v_ejercicio
and asiento = :v_asiento
and origen = :uo_origen.em_codigo.text
and mes = :v_mes;

if v_debe <> v_haber then
	messagebox ("Atención, Atención, ....", "Asiento descuadrado")
	return
end if

CALL Super::clicked
end event

type em_asiento from u_em_campo within w_int_contaapun
integer x = 1765
integer y = 216
integer width = 357
integer height = 80
integer taborder = 60
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "Ä"
end type

event modificado;call super::modificado;f_visualizar()
end event

type st_asiento from statictext within w_int_contaapun
integer x = 1765
integer y = 140
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

type em_fasiento from u_em_campo within w_int_contaapun
integer x = 1472
integer y = 216
integer width = 293
integer height = 80
integer taborder = 50
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

event modificado;call super::modificado;
dw_detalle.reset()
end event

event losefocus;call super::losefocus;//IF Dec(Year(date(em_fasiento.text))) <> Dec(uo_ejercicio.em_ejercicio.text) THEN
//	MessageBox("Fecha de Asiento","No coincide el ejercicio con el año de la fecha",Exclamation!)
//	f_activar_campo(em_fasiento)
//END IF
end event

event modified;IF Dec(Year(date(em_fasiento.text))) <> Dec(uo_ejercicio.em_ejercicio.text) THEN
	MessageBox("Fecha de Asiento","No coincide el ejercicio con el año de la fecha",Exclamation!)
	f_activar_campo(em_fasiento)
END IF
IF date(em_fasiento.text) > Today() THEN
	MessageBox("Fecha de Asiento","La fecha es superior a la fecha del sistema",Exclamation!)
	f_activar_campo(em_fasiento)
END IF
end event

type st_2 from statictext within w_int_contaapun
integer x = 1472
integer y = 140
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

type pb_altas from u_calculadora within w_int_contaapun
integer x = 2130
integer y = 212
integer taborder = 0
string disabledname = "Compute!"
string powertiptext = "F5"
end type

event clicked;String v_origen 
em_asiento.TEXT = ""
dw_detalle.Reset()
v_origen    = uo_origen.em_codigo.text
IF Trim(v_origen)= "" Then
	f_mensaje("Campo Obligatorio","Introduzca el origen")
	f_activar_campo(uo_origen.em_campo)
	Return
END IF

IF Dec(Year(date(em_fasiento.text))) <> Dec(uo_ejercicio.em_ejercicio.text) THEN
	MessageBox("Fecha de Asiento","No coincide el ejercicio con el año de la fecha",Exclamation!)
	f_activar_campo(em_fasiento)
	Return
END IF

IF Trim(uo_recur.em_codigo.text) = "" Then
	f_activar(FALSE)
	dw_detalle.visible= TRUE	
	f_nueva()
ELSE
	IF f_recurente(uo_recur.em_codigo.text) Then
		f_activar(FALSE)
		dw_detalle.visible= TRUE
	END IF
END IF
modo = "I"
end event

type st_4 from statictext within w_int_contaapun
integer x = 2144
integer y = 168
integer width = 87
integer height = 44
boolean bringtotop = true
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 8421376
boolean enabled = false
string text = "F5 "
alignment alignment = center!
long bordercolor = 8421376
boolean focusrectangle = false
end type

type uo_recur from u_em_campo_2 within w_int_contaapun
event destroy ( )
integer x = 14
integer y = 216
integer width = 718
integer height = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_recur.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE RECURENTES"
		ue_datawindow = "dw_ayuda_contarecur"
		ue_filtro     = "ejercicio = "+uo_ejercicio.em_ejercicio.text
		
	
end event

event modificado;call super::modificado;uo_recur.em_campo.text=f_nombre_contarecur(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_recur.em_codigo.text)

IF Trim(uo_recur.em_campo.text)="" THEN 
 IF Trim(uo_recur.em_codigo.text)<>"" Then uo_recur.em_campo.SetFocus()
 uo_recur.em_campo.text=""
 uo_recur.em_codigo.text=""
END IF
uo_origen.em_codigo.text = f_origen_contarecur(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_recur.em_codigo.text)
uo_origen.em_campo.text = f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)


end event

type st_3 from statictext within w_int_contaapun
integer x = 731
integer y = 140
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

type uo_origen from u_em_campo_2 within w_int_contaapun
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 731
integer y = 216
integer width = 736
integer height = 80
integer taborder = 40
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

type cb_borrar from u_boton within w_int_contaapun
integer x = 3035
integer y = 208
integer width = 443
integer height = 96
integer taborder = 0
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&Borrar Asiento"
end type

event clicked;String      origen
Int borrar
Dec         mes,asiento
long ll_indice,ll_total
boolean lb_asiento_con_iva = false
string ls_cuenta,ls_tipocta
long   ll_ejercicio

str_ventana_alerta parametros

ll_ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
origen    = uo_origen.em_codigo.text
mes       = Month(Date(em_fasiento.text))
asiento   = Dec(em_asiento.text)

parametros.titulo = "Atención Borrado de Apunte"
parametros.subtitulo = "Borrar Apunte"
parametros.mensaje = "¿Esta seguro de que desea borrar el apunte de la contabilidad?"
parametros.tipo = 1
//parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar = Int(Message.DoubleParm)

IF borrar <> 1 Then 
	return
END IF

lb_asiento_con_iva = false
ll_total = dw_detalle.rowcount()

for ll_indice = 1 to ll_total
	
	ls_cuenta  = dw_detalle.object.cuenta[ll_indice]
	ll_ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
	ls_tipocta = f_tipocta_contaplan(ll_ejercicio,codigo_empresa,ls_cuenta)
	
	IF ls_tipocta =  f_tipocta_iva_contaparam(ll_ejercicio,codigo_empresa) Then
		lb_asiento_con_iva = true
	end if		
next

if lb_asiento_con_iva then
	if f_contasii_calendario_bloqueado(codigo_empresa,datetime(date(em_fasiento.text))) then
		messagebox("¡Atención!","No se puede borrar un registro de IVA de un dia bloqueado por el SII.")
		return
	end if		
end if

Delete from contaapun
Where  contaapun.ejercicio = :ll_ejercicio
And    contaapun.empresa   = :codigo_empresa
And    contaapun.origen    = :origen
And    contaapun.mes       = :mes
ANd    contaapun.asiento   = :asiento;

DELETE FROM costesapu
WHERE costesapu.ejercicio = :ll_ejercicio
AND   costesapu.empresa   = :codigo_empresa
AND   costesapu.origen    = :origen
AND   costesapu.mes       = :mes
AND   costesapu.asiento   = :asiento;

COMMIT;
em_asiento.text = ""
f_visualizar()
end event

type pb_1 from upb_imprimir within w_int_contaapun
integer x = 2245
integer y = 212
integer taborder = 10
string disabledname = "Print!"
end type

event clicked;call super::clicked;dw_listado.SetTransObject(SQLCA)
dw_listado.retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,Month(Date(em_fasiento.text)),uo_origen.em_codigo.text,Dec(em_asiento.text)) 
f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_int_contaapun
boolean visible = false
integer x = 2953
integer y = 40
integer width = 229
integer height = 100
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_de_un_apunte"
boolean livescroll = true
end type

type dw_apuntes from datawindow within w_int_contaapun
boolean visible = false
integer x = 1390
integer y = 140
integer width = 731
integer height = 788
integer taborder = 70
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

type st_11 from statictext within w_int_contaapun
integer x = 14
integer y = 140
integer width = 718
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Recurrente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_ejercicio from u_ejercicio within w_int_contaapun
event destroy ( )
integer x = 2382
integer y = 212
integer height = 276
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_detalle from u_datawindow within w_int_contaapun
integer x = 55
integer y = 384
integer width = 3557
integer height = 2396
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_int_contaapun_nuevo"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;String vale

IF f_objeto_datawindow(dw_detalle) = "confirmar" Then
	if pb_altas.enabled = FALSE Then
		f_confirmar()
	end if
	Return
END IF
IF f_objeto_datawindow(dw_detalle) = "insertar" Then
	f_insertar_linea()
END IF

IF f_objeto_datawindow(dw_detalle) = "borrar" Then
	string ls_cuenta,ls_tipocta
	long   ll_ejercicio
	
	ls_cuenta  = this.object.cuenta[this.getrow()]
	ll_ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
	ls_tipocta = f_tipocta_contaplan(ll_ejercicio,codigo_empresa,ls_cuenta)
	
	IF ls_tipocta =  f_tipocta_iva_contaparam(ll_ejercicio,codigo_empresa) Then	
		if f_contasii_calendario_bloqueado(codigo_empresa,datetime(date(em_fasiento.text))) then
			messagebox("¡Atención!","No se puede borrar un registro de IVA de un dia bloqueado por el SII.")
		else
			f_borrar_linea()
		end if	
	else
		f_borrar_linea()
	end if
		
END IF

IF f_objeto_datawindow(dw_detalle) = "salir" Then
	f_salir()
	Return
END IF

IF f_objeto_datawindow(dw_detalle) = "ana" Then
	
	String	ana,origen,concepto,ampliacion
	Dec{0}	mes,importe_d,importe_h,ejer
	DateTime	fapunte
	
	ejer = Dec(uo_ejercicio.em_ejercicio.text)
	asiento_i  = Dec(f_valor_columna(dw_detalle,row,"asiento"))
	IF asiento_i > 0 AND Not IsNull(asiento_i) THEN
		conta_i = f_valor_columna(dw_detalle,row,"cuenta")
		SELECT contaplan.analitica INTO :ana FROM contaplan  
		WHERE ( contaplan.ejercicio = :ejer) AND  
				( contaplan.empresa   = :codigo_empresa ) AND  
				( contaplan.cuenta    = :conta_i )   ;
		IF ana = 'S' THEN
			mes        = Integer(f_valor_columna(dw_detalle,row,"mes"))
			origen     = f_valor_columna(dw_detalle,row,"origen")
			importe_d  = Dec(f_valor_columna(dw_detalle,row,"debe"))
			importe_h  = Dec(f_valor_columna(dw_detalle,row,"haber"))
			apunte_i   = Dec(f_valor_columna(dw_detalle,row,"apunte"))
			concepto   = f_valor_columna(dw_detalle,row,"concepto")
			ampliacion = f_valor_columna(dw_detalle,row,"ampliacion")
			fapunte    = dw_detalle.GetItemDateTime(row,"fapunte")
			
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
			lstr_param.s_argumentos[11] = Trim(uo_ejercicio.em_ejercicio.text)
				
			OpenWithParm(w_costes,lstr_param)
			vale = Message.StringParm
			IF vale = "1" THEN
				COMMIT;
			ELSE
				ROLLBACK;
			END IF
		END IF
	END IF
	RETURN
END IF
f_activar(FALSE)

end event

event key;

//IF Not KeyDown(KeyEnter!) Then
IF KeyDown(KeyEnter!) or KeyDown(KeyTab!) Then
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro ="ejercicio = "+uo_ejercicio.em_ejercicio.text+" "
// 	CASE "concepto"
//      bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
// 		bus_datawindow = "dw_ayuda_contaconcepto"
//		bus_filtro =""
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF
IF KeyDown(KeyTab!)  and getRow() <> 0  Then
	AcceptText()
	IF GetItemNumber(GetRow(),"debe")  <>0 Then SetItem(GetRow(),"haber",0)
	IF GetItemNumber(GetRow(),"haber") <>0 Then SetItem(GetRow(),"debe",0)

END IF
 
IF  KeyDown(KeyEscape!) Then Parent.TriggerEvent("ue_esc")
IF  KeyDown(KeyF5!)Then Parent.TriggerEvent("ue_f5")
IF  KeyDown(KeyF2!)Then Parent.TriggerEvent("ue_f2")
IF  KeyDown(KeyF3!)Then Parent.TriggerEvent("ue_f3")

IF  KeyDown(KeyInsert!) THEN
		IF Not f_control() Then Return
		f_nueva()
END IF
end event

event rbuttondown;
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
   CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro ="ejercicio = "+uo_ejercicio.em_ejercicio.text+" "
 	CASE "concepto"
      bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
 		bus_datawindow = "dw_ayuda_contaconcepto"
 CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event valores_numericos;f_valores_numericos(dw_detalle,"concepto")

end event

event itemfocuschanged;call super::itemfocuschanged;
f_cambio_linea(row)
Boolean 	existe
DateTime fecha
Dec 		v_ejercicio,r
String 	cta,tipocta,tipoapu

SetNull(fecha)

IF GetRow()<> 0 AND enabled THEN
	v_ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
	cta =  GetItemString(GetRow(),"cuenta")
	IF dwo.Name = "ampliacion" THEN
		IF dw_detalle.GetItemString(GetRow(),"concepto") <> '' THEN
			existe = f_existe_concepto(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"concepto"))
			IF Not existe THEN
				MessageBox("CONTROL DE DATOS","El Código de Concepto no existe",Exclamation!)
				dw_detalle.SetColumn("concepto")
			END IF
		END IF
	END IF
	IF dwo.Name = "ffactura" THEN
		existe = f_existe_cuenta(v_ejercicio,codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"cuenta"))
		IF Not existe THEN
			MessageBox("CONTROL DE DATOS","La cuenta Contable no existe",Exclamation!)
			dw_detalle.SetColumn("cuenta")
		END IF
	END IF
	tipoapu = getItemString(getRow(),"tipoapu")
	tipocta = f_tipocta_contaplan(v_ejercicio,codigo_empresa,cta)
	IF tipocta =  f_tipocta_iva_contaparam(v_ejercicio,codigo_empresa) Then
		IF GetColumnName() = "cuenta" or GetColumnName() = "ffactura" Then
		  	f_orden_datos_iva (TRUE)
		  	f_datos_iva()
		END IF
	ELSE
		dw_iva.visible = FALSE
		r = dw_detalle.getRow()
		IF r <> 0 Then 
			dw_detalle.SetItem(r,"tipoiva","")
			dw_detalle.SetItem(r,"iva",0)
			dw_detalle.SetItem(r,"clipro","")
			dw_detalle.SetItem(r,"tipoter","")
			dw_detalle.SetItem(r,"tipoapu","")
			dw_detalle.SetItem(r,"imponible",0)
			dw_detalle.SetItem(r,"factura","")
			dw_detalle.SetItem(r,"fregistro",fecha)
			dw_detalle.SetItem(r,"nif","")
		 END IF
	END IF

END IF


end event

event retrieveend;call super::retrieveend;IF rowcount = 0 Then
	visible = FALSE
ELSE
	visible = TRUE
END IF
enabled = TRUE

end event

event editchanged;call super::editchanged;
IF dw_detalle.GetRow()<>0 Then
	IF GetColumnName()= "debe" Then
		IF dw_detalle.GetItemNumber(dw_detalle.GetRow(),"debe")  <> 0 Then	dw_detalle.SetItem(dw_detalle.GetRow(),"haber",0) 
	END IF
	IF GetColumnName()= "haber" Then
		IF dw_detalle.GetItemNumber(dw_detalle.GetRow(),"haber") <> 0 Then	dw_detalle.SetItem(dw_detalle.GetRow(),"debe",0) 
	END IF
END IF
end event

event retrievestart;call super::retrievestart;enabled = FALSE
end event

event rowfocuschanged;call super::rowfocuschanged;f_cambio_linea(currentrow)
end event

type dw_iva from u_datawindow within w_int_contaapun
boolean visible = false
integer x = 55
integer width = 3557
integer height = 404
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_con_contaapun2"
borderstyle borderstyle = stylelowered!
end type

event clicked;call super::clicked;f_orden_datos_iva (TRUE)
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_int_contaapun"

CHOOSE CASE f_objeto_datawindow(dw_iva)
  	CASE 'pb_tipoiva'
		lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_iva")
		OpenWithParm(wi_mant_contaiva,lstr_param)  
	CASE 'ok'
		f_ok()
END CHOOSE

end event

event key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipo_iva"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE IVAS"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro     = "ejercicio= " + uo_ejercicio.em_ejercicio.text 
	CASE "clipro"
		IF dw_iva.GetITemString(1,"tipoter") = "C" Then
   	   bus_titulo     = "VENTANA SELECCION DE CLIENTES"
 			bus_datawindow = "dw_ayuda_clientes"
		ELSE
   	   bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
 			bus_datawindow = "dw_ayuda_proveedores"
		END IF
		bus_filtro    = ""			
	
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
IF key = KeyF2! Then f_ok()
end event

event rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipo_iva"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE IVAS"
 		bus_datawindow = "dw_ayuda_contaiva"
//		bus_filtro     = "ctaiva = '"+dw_iva.GetItemString(1,"cuenta")+"' and ejercicio= " + uo_ejercicio.em_ejercicio.text 
		bus_filtro     = "ejercicio= " + uo_ejercicio.em_ejercicio.text 
	CASE "clipro"
		IF dw_iva.GetITemString(1,"tipoter") = "C" Then
   	   bus_titulo     = "VENTANA SELECCION DE CLIENTES"
 			bus_datawindow = "dw_ayuda_clientes"
		ELSE
   	   bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
 			bus_datawindow = "dw_ayuda_proveedores"
		END IF
		bus_filtro    = ""		
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 

end event

event itemfocuschanged;call super::itemfocuschanged;String 	clipro,tipoter,nif,nif2
Dec 		imponible,iva,importe
Dec{0} 	ejer
string 	tp
DateTime f_factura,f_registro

// Santiago - 20/09/00 La fecha del registro de IVA debe ser la fecha de factura
//IF String(Date(dw_iva.getItemDateTime(1,"fregistro"))) = "00-00-00" THEN
f_factura  = dw_iva.GetItemDateTime(1,"ffactura")
f_registro = dw_iva.GetItemDateTime(1,"fregistro")
if isnull(f_registro) or String(Date(dw_iva.getItemDateTime(1,"fregistro"))) = "00-00-00" then
	dw_iva.SetItem(1,"fregistro",f_factura)
end if
//END IF
// Santiago - 20/09/00 La fecha del registro de IVA debe ser la fecha de factura

accepttext()

tp = dw_iva.getItemSTring(1,"tipo_iva")

IF Trim(tp) = "" THEN RETURN

ejer = Dec(uo_ejercicio.em_ejercicio.text)
clipro 	= dw_iva.GetItemString(1,"clipro")
tipoter 	= dw_iva.GetItemString(1,"tipoter")
nif 		= f_cif_genter(codigo_empresa,tipoter,clipro)
nif2 		= dw_iva.GetItemString(1,"nif")

IF IsNUll(nif2) OR Trim(nif2) = "" THEN
	dw_iva.SetItem(1,"nif",nif)
END IF

iva = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.getItemSTring(1,"tipo_iva"))

IF IsNull(iva ) THEN iva = 0

imponible 	= dw_iva.GetItemNumber(1,"imponible")
IF IsNull(imponible) Then imponible = 0

// Santiago - 20/09/00 Siempre debe calcular el importe del iva
//IF dw_iva.GetItemNumber(1,"importe") = 0 THEN
	importe 		= imponible * iva / 100
	dw_iva.SetItem(1,"importe",importe)
//END IF
// Santiago - 20/09/00 Siempre debe calcular el importe del iva

Dec 		regis
String 	tipo_contador

regis= dw_iva.GetItemNumber(1,"registro") 
IF IsNUll(regis) or regis = 0 THEN
	tipo_contador = f_tipo_contador_contalibros(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,f_libro_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.getItemSTring(1,"tipo_iva")))
	IF tipo_contador = "C" THEN
		regis = f_registro_tipoiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.getItemSTring(1,"tipo_iva"))
		dw_iva.SetItem(1,"registro",regis)
	END IF
	IF tipo_contador = "F" Then
		dw_iva.SetItem(1,"registro",Dec(dw_iva.getItemSTring(1,"factura")))
	END IF

END IF

end event

event itemchanged;Dec imponible,iva,importe
Dec{0} ejer
string tp

AcceptText()
tp = dw_iva.getItemSTring(1,"tipo_iva")
ejer = Dec(uo_ejercicio.em_ejercicio.text)
IF f_tipo_libro(ejer,codigo_empresa,f_libro_contaiva(ejer,codigo_empresa,tp)) = "V" Then
	dw_iva.SetItem(1,"tipoter","C")
ELSE
	dw_iva.SetItem(1,"tipoter","P")
END IF

IF f_objeto_datawindow(dw_iva) = "imponible" Then
	iva = f_iva_contaiva(ejer,codigo_empresa,tp)
	IF IsNull(iva ) Then iva = 0
	imponible = dw_iva.GetItemNumber(1,"imponible")
	IF IsNull(imponible) Then imponible = 0
	importe = imponible * iva / 100
	dw_iva.SetItem(1,"importe",importe)
END IF

end event

event valores_numericos;call super::valores_numericos;f_valores_numericos(This,"tipo_iva")
f_valores_numericos(This,"clipro")
end event

