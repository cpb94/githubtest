$PBExportHeader$w_con_costes_apunte.srw
$PBExportComments$€
forward
global type w_con_costes_apunte from w_int_con_empresa
end type
type dw_mapa_costes from datawindow within w_con_costes_apunte
end type
type st_3 from statictext within w_con_costes_apunte
end type
type uo_origen from u_em_campo_2 within w_con_costes_apunte
end type
type st_2 from statictext within w_con_costes_apunte
end type
type em_fasiento from u_em_campo within w_con_costes_apunte
end type
type em_asiento from u_em_campo within w_con_costes_apunte
end type
type st_asiento from statictext within w_con_costes_apunte
end type
type dw_costes from u_datawindow within w_con_costes_apunte
end type
type dw_apuntes from datawindow within w_con_costes_apunte
end type
end forward

global type w_con_costes_apunte from w_int_con_empresa
integer width = 2967
integer height = 1568
string title = "Introducción apuntes analítica"
dw_mapa_costes dw_mapa_costes
st_3 st_3
uo_origen uo_origen
st_2 st_2
em_fasiento em_fasiento
em_asiento em_asiento
st_asiento st_asiento
dw_costes dw_costes
dw_apuntes dw_apuntes
end type
global w_con_costes_apunte w_con_costes_apunte

type variables
str_parametros		paras	
Integer	vale
Dec{0} mes,asiento_i,apunte_i
dec{2} importe_d,importe_h,ejer
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

public function boolean f_confirmar_costes ();Dec{2}	pasado_d,pasado_h,sumado_d,sumado_h,bien,cuantas
	

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
Next

pasado_d = dw_costes.GetItemNumber(dw_costes.RowCount(),"importe_pasado_debe")
pasado_h = dw_costes.GetItemNumber(dw_costes.RowCount(),"importe_pasado_haber")

sumado_d = dw_costes.GetItemNumber(dw_costes.RowCount(),"totald")
sumado_h = dw_costes.GetItemNumber(dw_costes.RowCount(),"totalh")
IF pasado_d <> sumado_d THEN
//	f_mensaje("Apunte Descuadrado","No se graba") 
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
	  MessageBox("APUNTE DESCUADRADO","Desea Modificarlo",Exclamation!,Ok!,1)
	  vale = 0
	  Return
	END IF
	CloseWithReturn(w_costes,String(vale))
	Return
end subroutine

on w_con_costes_apunte.create
int iCurrent
call super::create
this.dw_mapa_costes=create dw_mapa_costes
this.st_3=create st_3
this.uo_origen=create uo_origen
this.st_2=create st_2
this.em_fasiento=create em_fasiento
this.em_asiento=create em_asiento
this.st_asiento=create st_asiento
this.dw_costes=create dw_costes
this.dw_apuntes=create dw_apuntes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mapa_costes
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.uo_origen
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_fasiento
this.Control[iCurrent+6]=this.em_asiento
this.Control[iCurrent+7]=this.st_asiento
this.Control[iCurrent+8]=this.dw_costes
this.Control[iCurrent+9]=this.dw_apuntes
end on

on w_con_costes_apunte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_mapa_costes)
destroy(this.st_3)
destroy(this.uo_origen)
destroy(this.st_2)
destroy(this.em_fasiento)
destroy(this.em_asiento)
destroy(this.st_asiento)
destroy(this.dw_costes)
destroy(this.dw_apuntes)
end on

event open;call super::open;dw_apuntes.SetTransObject(sqlca)
This.title = " CONSULTA COSTES APUNTE"
dw_costes.SetTransObject(SQLCA)




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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_costes_apunte
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_costes_apunte
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_costes_apunte
end type

type dw_mapa_costes from datawindow within w_con_costes_apunte
boolean visible = false
integer x = 937
integer y = 644
integer width = 494
integer height = 360
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_costesmapa_2"
boolean livescroll = true
end type

type st_3 from statictext within w_con_costes_apunte
integer x = 27
integer y = 160
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

type uo_origen from u_em_campo_2 within w_con_costes_apunte
event destroy ( )
integer x = 27
integer y = 236
integer width = 736
integer height = 80
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_origen.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)

IF Trim(uo_origen.em_campo.text)="" THEN 
 IF Trim(uo_origen.em_codigo.text)<>"" Then uo_origen.em_campo.SetFocus()
 uo_origen.em_campo.text=""
 uo_origen.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE ORIGENES"
		ue_datawindow = "dw_ayuda_contaorigen"
		ue_filtro     = ""

end event

type st_2 from statictext within w_con_costes_apunte
integer x = 768
integer y = 160
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

type em_fasiento from u_em_campo within w_con_costes_apunte
integer x = 768
integer y = 236
integer width = 293
integer height = 80
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

type em_asiento from u_em_campo within w_con_costes_apunte
integer x = 1061
integer y = 236
integer width = 352
integer height = 80
integer taborder = 40
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "Ä"
end type

event modificado;call super::modificado;dw_costes.Retrieve(Year(date(em_fasiento.text)),codigo_empresa,Month(date(em_fasiento.text)),uo_origen.em_codigo.text,Dec(em_asiento.text))
end event

type st_asiento from statictext within w_con_costes_apunte
integer x = 1061
integer y = 160
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
IF dw_apuntes.retrieve(Year(DAte(em_fasiento.text)),codigo_empresa,Month(Date(em_fasiento.text)),uo_origen.em_codigo.text) <> 0 Then
	dw_apuntes.visible = TRUE
END IF
end event

type dw_costes from u_datawindow within w_con_costes_apunte
integer x = 23
integer y = 324
integer width = 2885
integer height = 1040
integer taborder = 70
string dataobject = "dw_con_costes_asiento"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Boolean	bolero
Integer	op

IF f_objeto_datawindow(dw_costes) = "actualizar" Then
	This.Update()
	COMMIT;
	Return
END IF
IF f_objeto_datawindow(dw_costes) = "borrar" Then
	f_borrar_linea_costes()
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

type dw_apuntes from datawindow within w_con_costes_apunte
boolean visible = false
integer x = 1417
integer y = 160
integer width = 731
integer height = 788
integer taborder = 20
string dataobject = "dw_con_costes_apun"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(dw_apuntes) = "salir" Then
	This.Reset()
	This.visible = FALSE
END IF
IF row = 0     Then return
IF IsNull(row) Then return
em_asiento.text = String(GetItemNumber(row,"asiento"))
em_fasiento.text = String(Date(GetItemDateTime(row,"fapunte")))
This.Reset()
This.visible = FALSE
dw_costes.Retrieve(Year(date(em_fasiento.text)),codigo_empresa,Month(date(em_fasiento.text)),uo_origen.em_codigo.text,Dec(em_asiento.text))
end event

