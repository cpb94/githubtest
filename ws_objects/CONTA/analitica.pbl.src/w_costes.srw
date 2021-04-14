$PBExportHeader$w_costes.srw
$PBExportComments$€
forward
global type w_costes from w_int_con_empresa
end type
type dw_mapa_costes from datawindow within w_costes
end type
type dw_costes from u_datawindow within w_costes
end type
type pb_salir from picturebutton within w_costes
end type
end forward

global type w_costes from w_int_con_empresa
integer width = 2967
integer height = 2096
string title = "Introducción apuntes analítica"
dw_mapa_costes dw_mapa_costes
dw_costes dw_costes
pb_salir pb_salir
end type
global w_costes w_costes

type variables
str_parametros		paras	
Integer	vale
Dec{0} mes,asiento_i,apunte_i,importe_d,importe_h,ejer
String origen, conta_i,concepto,ampliacion
DateTime fapunte

end variables

forward prototypes
public subroutine f_orden_datos_costes (boolean bool)
public function boolean f_confirmar_costes ()
public subroutine f_insertar_linea_costes ()
public subroutine f_valores_fijos_costes (integer reg)
public subroutine f_activar_linea_costes (integer reg)
public subroutine f_borrar_linea_costes ()
public function boolean f_control_costes ()
public subroutine f_nueva_costes ()
public function decimal f_salir_costes ()
public subroutine f_cambio_linea_costes (integer reg)
public subroutine f_confirmar ()
end prototypes

public subroutine f_orden_datos_costes (boolean bool);IF bool Then
	dw_costes.SetTabOrder("coste",1)
	dw_costes.SetTabOrder("concepto",2)
	dw_costes.SetTabOrder("ampliacion",3)
	dw_costes.SetTabOrder("debe",4)
	
ELSE
	dw_costes.SetTabOrder("coste",0)
	dw_costes.SetTabOrder("concepto",0)
	dw_costes.SetTabOrder("ampliacion",0)
	dw_costes.SetTabOrder("debe",0)
	
END IF
dw_costes.Enabled = bool
	
end subroutine

public function boolean f_confirmar_costes ();Dec{2}	pasado_d,pasado_h,sumado_d,sumado_h
dec{0}   bien,cuantas
	

bien = 0

cuantas = dw_costes.RowCount()
IF cuantas = 0 THEN
	RETURN TRUE
END IF

Dec j
For j = 1 To dw_costes.RowCount()
	IF Trim(f_nombre_costesplan(ejer,codigo_empresa,dw_costes.Object.coste[j])) = "" Then
		f_mensaje("Error en Introduccion de datos"," EL centro de coste no existe")
		Return False
	END IF
	If Trim(dw_costes.Object.coste[j]) = "" Then
		f_mensaje("Error en Introduccion de datos"," EL centro de coste no existe")
		Return False
	END IF
Next

pasado_d = dw_costes.GetItemNumber(dw_costes.RowCount(),"importe_pasado_debe")
pasado_h = dw_costes.GetItemNumber(dw_costes.RowCount(),"importe_pasado_haber")

sumado_d = dw_costes.GetItemNumber(dw_costes.RowCount(),"totald")
sumado_h = dw_costes.GetItemNumber(dw_costes.RowCount(),"totalh")
IF pasado_d <> sumado_d THEN
	f_mensaje("Apunte Descuadrado","No se graba") 
	Return FALSE
END IF
IF pasado_h <> sumado_h THEN
	f_mensaje("Apunte Descuadrado","No se graba") 
	Return FALSE
END IF
IF dw_costes.Update() = -1 Then bien = 1
IF bien = 1 Then
	f_mensaje("Error en proceso","La operacion no se contabiliza")
	Return FALSE
END IF
Return TRUE

end function

public subroutine f_insertar_linea_costes ();Integer r 

r = dw_costes.GetRow()
IF r = 0 or r = 1 Then
	r = 1
ELSE
	r = r -1
END IF
dw_costes.InsertRow(r)
f_valores_fijos_costes(r)
f_activar_linea_costes(r)

end subroutine

public subroutine f_valores_fijos_costes (integer reg);dw_costes.Object.empresa[reg]   = codigo_empresa
dw_costes.Object.ejercicio[reg] = ejer
dw_costes.Object.origen[reg]    = origen
dw_costes.Object.fapunte[reg]   = fapunte
dw_costes.Object.mes[reg]       = mes
dw_costes.Object.cuenta[reg]    = conta_i
dw_costes.Object.apunte[reg]    = apunte_i
dw_costes.Object.asiento[reg]   = asiento_i
dw_costes.Object.debe[reg]      = 0
dw_costes.Object.haber[reg]     = 0
dw_costes.Object.linea[reg]     = reg



end subroutine

public subroutine f_activar_linea_costes (integer reg);dw_costes.SetFocus()
dw_costes.SetRow(reg)
dw_costes.ScrollToRow(reg)
dw_costes.SetColumn("coste")

end subroutine

public subroutine f_borrar_linea_costes ();Int r

r = dw_costes.GetRow()
IF r =0 Then return
dw_costes.DeleteRow(r)
IF dw_costes.RowCount() = 0 Then 
	f_salir_costes()
Else
	If dw_costes.RowCount()< r Then r =  dw_costes.RowCount()
	f_activar_linea_costes(r)
END IF
end subroutine

public function boolean f_control_costes ();Integer      r, r1 
String      cta,ncta
Dec debe,haber
r1 = dw_costes.RowCount()
IF r1 = 0 Then Return False
For r = 1 To r1
	cta    = dw_costes.GetItemString(r,"coste")
	debe   = dw_costes.GetItemNumber(r,"debe")
	haber  = dw_costes.GetItemNumber(r,"haber")
	IF IsNull(debe)  Then debe = 0
	IF IsNull(haber) Then haber = 0
	IF IsNUll(cta) or Trim(cta) = "" Then 
		f_mensaje("Campo Obligatorio","Introducir Cuenta Analitica")
		dw_costes.SetFocus()
		dw_costes.SetRow(r)
		dw_costes.SetColumn("coste")
		Return False
	END IF
	ncta = f_nombre_costesplan(ejer,codigo_empresa,cta)
	IF IsNUll(ncta) or Trim(ncta) = "" Then 
		f_mensaje("Campo Obligatorio","Introducir Cuenta Contable")
		dw_costes.SetFocus()
		dw_costes.SetRow(r)
		dw_costes.SetColumn("coste")
		Return False
	END IF
NEXT
Return True
end function

public subroutine f_nueva_costes ();Integer reg
reg = dw_costes.RowCount() + 1
dw_costes.InsertRow(reg)
dw_costes.SetItem(reg,"debe",0)
dw_costes.SetItem(reg,"haber",0)

f_valores_fijos_costes(reg)
f_activar_linea_costes(reg)

end subroutine

public function decimal f_salir_costes ();
//IF MessageBox("Salir del Asiento sin grabar","¿Salir sin grabar?",Question!,YesNo!)= 1 Then 
//	Return 0
//END IF
//RETURN 1
 
	IF f_confirmar_costes() THEN
		vale = 1
	ELSE
	  MessageBox("APUNTE DESCUADRADO","Desea Modificarlo",Exclamation!,Ok!,1)
	  vale = 0
	  Return 1
	END IF
	Return 0
end function

public subroutine f_cambio_linea_costes (integer reg);Integer ln
if dw_costes.RowCount() = 0 tHEN Return
iF IsNull(reg) Then Return
IF reg = 0 Then Return
ln = Integer(dw_costes.Describe("DataWindow.LastRowOnPage"))
dw_costes.SetItem(ln,"cta",dw_costes.GetItemString(reg,"coste"))

dw_costes.AcceptText()

end subroutine

public subroutine f_confirmar ();Boolean bolero
Dec op
bolero = f_confirmar_costes()
	IF bolero = TRUE THEN
		vale = 1
	ELSE
//	  MessageBox("APUNTE DESCUADRADO","Desea Modificarlo",Exclamation!,Ok!,1)
	  vale = 0
	  Return
	END IF
	CloseWithReturn(w_costes,String(vale))
	Return
end subroutine

on w_costes.create
int iCurrent
call super::create
this.dw_mapa_costes=create dw_mapa_costes
this.dw_costes=create dw_costes
this.pb_salir=create pb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mapa_costes
this.Control[iCurrent+2]=this.dw_costes
this.Control[iCurrent+3]=this.pb_salir
end on

on w_costes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_mapa_costes)
destroy(this.dw_costes)
destroy(this.pb_salir)
end on

event open;call super::open;dec{0}   linea,j
Dec{2}	suma,parcial,pasado,sumado,difer
Dec{2}	porcent,importe
String	coste,d_h
Integer	rr,xy

paras = Message.PowerObjectParm

This.title = " INTRODUCCION DE APUNTES DE COSTES"
This.X = 30
This.Y = 320

vale = 1


dw_mapa_costes.SetTransObject(SQLCA)
dw_costes.SetTransObject(SQLCA)

mes        = Dec(paras.s_argumentos[1])
origen     = paras.s_argumentos[2]
asiento_i  = Dec(paras.s_argumentos[3])
conta_i    = paras.s_argumentos[4]
importe_d  = Dec(paras.s_argumentos[5])
apunte_i   = Dec(paras.s_argumentos[6])
concepto   = paras.s_argumentos[7]
ampliacion = paras.s_argumentos[8]
fapunte    = DateTime(Date(paras.s_argumentos[9]))
importe_h  = Dec(paras.s_argumentos[10])
ejer		  = Dec(paras.s_argumentos[11])


IF importe_d <> 0 THEN
	d_h = "D"
	importe = importe_d
else
	d_h = "H"
	importe = importe_h
END IF

rr = dw_costes.Retrieve(ejer,codigo_empresa,mes,origen, &
                        asiento_i,conta_i,importe_d,importe_h,apunte_i)
iF rr > 0 Then
	FOr j = 1 To rr
		dw_costes.Object.linea[j] = j
	Next
END IF
IF rr < 1 THEN
	suma = 0
	rr = dw_mapa_costes.Retrieve(ejer,codigo_empresa,conta_i)
	IF rr = 0 THEN
		dw_costes.Reset()
		dw_costes.InsertRow(1)
		f_valores_fijos_costes(1)
		dw_costes.Object.ejercicio[1]  = ejer
		dw_costes.Object.empresa[1]    = codigo_empresa
		dw_costes.Object.mes[1]        = mes
		dw_costes.Object.origen[1]     = origen
		dw_costes.Object.asiento[1]    = asiento_i
		dw_costes.Object.apunte[1]     = apunte_i
		dw_costes.Object.ampliacion[1] = ampliacion
	ELSE
		For xy = 1 To rr
			dw_costes.InsertRow(xy)
			f_valores_fijos_costes(xy)
			dw_costes.Object.ejercicio[xy] = ejer
			dw_costes.Object.empresa[xy]=codigo_empresa
			dw_costes.Object.mes[xy] = mes
			dw_costes.Object.origen[xy]  = origen 
			dw_costes.Object.asiento[xy] = asiento_i
			dw_costes.Object.apunte[xy]  = apunte_i
			dw_costes.Object.linea[xy]  = xy
			coste = dw_mapa_costes.Object.coste[xy]
			dw_costes.Object.coste[xy] = coste
			porcent = dw_mapa_costes.Object.reparto[xy]
			
			IF d_h = "D" THEN
				parcial = importe * porcent / 100
				dw_costes.Object.debe[xy] = parcial
			ELSE
				parcial = importe * porcent / 100
				dw_costes.Object.haber[xy] = parcial
			END IF
			suma = suma + parcial
			
			dw_costes.Object.concepto[xy]   = concepto
			dw_costes.Object.ampliacion[xy] = ampliacion
			dw_costes.Object.cuenta[xy]     = conta_i
		Next
	END IF
	pasado = importe
	sumado = suma
	difer  = pasado - sumado
	IF difer <> 0 THEN
		IF d_h = "D" THEN
			pasado = dw_costes.Object.debe[1]
			pasado = pasado + difer
			dw_costes.Object.debe[1] = pasado
		ELSE
			pasado = dw_costes.Object.haber[1]
			pasado = pasado + difer
			dw_costes.Object.haber[1]=pasado
		END IF
	END IF
	f_orden_datos_costes(TRUE)
	dw_costes.Setfocus()
	dw_costes.SetRow(1)
	dw_costes.SetColumn("coste")
	IF dw_costes.RowCount() = 0 Then
		dw_costes.Reset()
		dw_costes.InsertRow(1)
	END IF
END IF
For rr = 1 To dw_costes.RowCOunt()
	dw_costes.Object.cuenta[rr] = conta_i
Next
end event

event ue_f5;call super::ue_f5;Boolean bolero

bolero = f_confirmar_costes()

IF bolero = TRUE THEN
	vale = 0
ELSE
	vale = 1
END IF

CloseWithReturn(GetParent(),String(vale))
RETURN

end event

event ue_f3;call super::ue_f3;f_borrar_linea_costes()
end event

event ue_f2;call super::ue_f2;f_insertar_linea_costes()
end event

event ue_esc;call super::ue_esc;vale = f_salir_costes()
IF vale = 1 THEN
	vale = 0
	CloseWithReturn(This,String(vale))
	RETURN
END IF

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_costes
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_costes
end type

type st_empresa from w_int_con_empresa`st_empresa within w_costes
end type

type dw_mapa_costes from datawindow within w_costes
boolean visible = false
integer x = 937
integer y = 644
integer width = 494
integer height = 360
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_costesmapa_2"
boolean livescroll = true
end type

type dw_costes from u_datawindow within w_costes
integer x = 23
integer y = 172
integer width = 2885
integer height = 1712
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_int_costesapu"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Boolean	bolero
Integer	op

IF f_objeto_datawindow(dw_costes) = "confirmar" Then
	f_confirmar()
	Return
END IF

IF f_objeto_datawindow(dw_costes) = "insertar" Then
	f_insertar_linea_costes()
END IF

IF f_objeto_datawindow(dw_costes) = "borrar" Then
	f_borrar_linea_costes()
END IF

IF f_objeto_datawindow(dw_costes) = "salir" Then
	vale = f_salir_costes()
	IF vale = 0 THEN
		CloseWithReturn(Parent,String(vale))
		Return
	END IF
END IF

end event

event rbuttondown;
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
   CASE "coste"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS DE COSTE "
 		bus_datawindow = "dw_ayuda_costesplan_directo"
		bus_filtro ="ejercicio = " + String(ejercicio_activo)
 	CASE "concepto"
      bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
 		bus_datawindow = "dw_ayuda_contaconcepto"
 CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event key;

IF Not KeyDown(KeyEnter!) Then
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS ANALITICAS "
 		bus_datawindow = "dw_ayuda_costesplan_directo"
		bus_filtro =""
 	CASE "concepto"
      bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
 		bus_datawindow = "dw_ayuda_contaconcepto"
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
IF  KeyDown(KeyF5!)Then 
	f_confirmar()
	Return
END IF
IF  KeyDown(KeyF2!)Then Parent.TriggerEvent("ue_f2")
IF  KeyDown(KeyF3!)Then Parent.TriggerEvent("ue_f3")

IF  KeyDown(KeyInsert!) THEN
		IF Not f_control_costes() Then Return
		f_nueva_costes()
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;
f_cambio_linea_costes(currentrow)
end event

event itemfocuschanged;call super::itemfocuschanged;
f_cambio_linea_costes(row)
end event

type pb_salir from picturebutton within w_costes
integer x = 2798
integer y = 4
integer width = 110
integer height = 96
integer taborder = 1
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "exit!"
end type

event clicked;CloseWithReturn(Parent,vale)

end event

