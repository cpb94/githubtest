$PBExportHeader$w_cancelacion_pagos_emi.srw
forward
global type w_cancelacion_pagos_emi from w_int_con_empresa
end type
type gb_5 from groupbox within w_cancelacion_pagos_emi
end type
type gb_4 from groupbox within w_cancelacion_pagos_emi
end type
type gb_2 from groupbox within w_cancelacion_pagos_emi
end type
type pb_2 from upb_salir within w_cancelacion_pagos_emi
end type
type dw_listado from datawindow within w_cancelacion_pagos_emi
end type
type uo_ejercicio from u_ejercicio within w_cancelacion_pagos_emi
end type
type cb_1 from commandbutton within w_cancelacion_pagos_emi
end type
type em_asiento from u_em_campo within w_cancelacion_pagos_emi
end type
type cb_2 from commandbutton within w_cancelacion_pagos_emi
end type
type gb_3 from groupbox within w_cancelacion_pagos_emi
end type
type st_22 from statictext within w_cancelacion_pagos_emi
end type
type em_fapunte from u_em_campo within w_cancelacion_pagos_emi
end type
type dw_1 from u_datawindow_consultas within w_cancelacion_pagos_emi
end type
type cb_salir from u_boton within w_cancelacion_pagos_emi
end type
type cb_procesar from u_boton within w_cancelacion_pagos_emi
end type
type uo_banco from u_em_campo_2 within w_cancelacion_pagos_emi
end type
type st_6 from statictext within w_cancelacion_pagos_emi
end type
type st_4 from statictext within w_cancelacion_pagos_emi
end type
type em_documento from u_em_campo within w_cancelacion_pagos_emi
end type
end forward

global type w_cancelacion_pagos_emi from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2926
integer height = 1644
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
pb_2 pb_2
dw_listado dw_listado
uo_ejercicio uo_ejercicio
cb_1 cb_1
em_asiento em_asiento
cb_2 cb_2
gb_3 gb_3
st_22 st_22
em_fapunte em_fapunte
dw_1 dw_1
cb_salir cb_salir
cb_procesar cb_procesar
uo_banco uo_banco
st_6 st_6
st_4 st_4
em_documento em_documento
end type
global w_cancelacion_pagos_emi w_cancelacion_pagos_emi

type variables

end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_activar (boolean bol)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
dw_data.reset()
dw_data.SetTransObject(sqlca)
dw_data.Retrieve(codigo_empresa,uo_banco.em_codigo.text)
registros = dw_data.RowCount()


end subroutine

public subroutine f_activar (boolean bol);
uo_banco.em_codigo.enabled    = bol
uo_banco.em_campo.enabled     = bol
em_fapunte.enabled				= bol
cb_1.enabled						= bol
uo_ejercicio.em_ejercicio.enabled = bol

IF bol THEN 
	bol = FALSE
ELSE
	bol = TRUE
END IF

em_documento.enabled	= bol
cb_procesar.enabled  = bol
cb_salir.enabled     = bol
cb_2.enabled			= bol
em_asiento.enabled	= bol

end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CANCELACION DE PAGOS EMITIDOS"

f_activar(TRUE)

cb_procesar.BringToTop=True
dw_1.Setfocus()

em_fapunte.text = String(Today(),"dd-mm-yy")
f_mascara_columna(dw_1,"nuevo",f_mascara_decimales(0))

f_activar_campo(em_fapunte)
//uo_banco.em_campo.setfocus()


end event

on w_cancelacion_pagos_emi.create
int iCurrent
call super::create
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_2=create gb_2
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.uo_ejercicio=create uo_ejercicio
this.cb_1=create cb_1
this.em_asiento=create em_asiento
this.cb_2=create cb_2
this.gb_3=create gb_3
this.st_22=create st_22
this.em_fapunte=create em_fapunte
this.dw_1=create dw_1
this.cb_salir=create cb_salir
this.cb_procesar=create cb_procesar
this.uo_banco=create uo_banco
this.st_6=create st_6
this.st_4=create st_4
this.em_documento=create em_documento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_ejercicio
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.em_asiento
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.st_22
this.Control[iCurrent+12]=this.em_fapunte
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.cb_salir
this.Control[iCurrent+15]=this.cb_procesar
this.Control[iCurrent+16]=this.uo_banco
this.Control[iCurrent+17]=this.st_6
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.em_documento
end on

on w_cancelacion_pagos_emi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.uo_ejercicio)
destroy(this.cb_1)
destroy(this.em_asiento)
destroy(this.cb_2)
destroy(this.gb_3)
destroy(this.st_22)
destroy(this.em_fapunte)
destroy(this.dw_1)
destroy(this.cb_salir)
destroy(this.cb_procesar)
destroy(this.uo_banco)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.em_documento)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cancelacion_pagos_emi
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cancelacion_pagos_emi
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cancelacion_pagos_emi
integer x = 32
integer y = 4
integer width = 2638
end type

type gb_5 from groupbox within w_cancelacion_pagos_emi
integer x = 1440
integer y = 104
integer width = 357
integer height = 252
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_cancelacion_pagos_emi
integer x = 27
integer y = 220
integer width = 1408
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_cancelacion_pagos_emi
integer x = 9
integer y = 1252
integer width = 2135
integer height = 164
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_cancelacion_pagos_emi
integer x = 2734
integer y = 8
integer width = 110
integer height = 100
integer taborder = 0
end type

type dw_listado from datawindow within w_cancelacion_pagos_emi
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_asignacion_pagos_bancos"
boolean livescroll = true
end type

type uo_ejercicio from u_ejercicio within w_cancelacion_pagos_emi
event destroy ( )
integer x = 2126
integer y = 140
integer height = 300
integer taborder = 40
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type cb_1 from commandbutton within w_cancelacion_pagos_emi
integer x = 1815
integer y = 172
integer width = 283
integer height = 140
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;f_cargar(dw_1)

IF dw_1.rowcount() = 0 THEN
	f_activar(TRUE)
	f_activar_campo(uo_banco.em_campo)
ELSE
	f_activar(FALSE)
	f_activar_campo(em_documento)
END IF



end event

type em_asiento from u_em_campo within w_cancelacion_pagos_emi
integer x = 2514
integer y = 1308
integer width = 283
integer taborder = 0
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "(t"
end type

type cb_2 from commandbutton within w_cancelacion_pagos_emi
integer x = 2185
integer y = 1316
integer width = 283
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
string text = "Asiento"
end type

event clicked;isnull(em_asiento)
em_asiento.text = ""
end event

type gb_3 from groupbox within w_cancelacion_pagos_emi
integer x = 2144
integer y = 1252
integer width = 690
integer height = 164
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_22 from statictext within w_cancelacion_pagos_emi
integer x = 1449
integer y = 156
integer width = 315
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "\BMP\Mano.cur"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha apte"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fapunte from u_em_campo within w_cancelacion_pagos_emi
integer x = 1472
integer y = 240
integer width = 306
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type dw_1 from u_datawindow_consultas within w_cancelacion_pagos_emi
integer x = 5
integer y = 464
integer width = 2853
integer height = 796
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_cancelacion_pagos_emi"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event clicked;call super::clicked;Dec Reg 

IF f_objeto_datawindow(dw_1) = "todo" Then
		For reg = 1 To dw_1.RowCOunt()
//		dw_1.SetItem(reg,"nuevo",dw_1.GetItemNumber(reg,"importe"))
		dw_1.SetItem(reg,"marca",0)
	Next
END IF

IF f_objeto_datawindow(dw_1) = "marca" Then
	IF dw_1.GetItemNumber(row,"marca") = 0 Then
//		dw_1.SetItem(row,"nuevo",dw_1.GetItemNumber(row,"importe"))
		dw_1.SetItem(row,"marca",1)
		dw_1.SetFocus()
		dw_1.SetRow(row)
//		dw_1.SetColumn("nuevo")
	ELSE
		dw_1.SetItem(row,"marca",0)
//		dw_1.SetItem(row,"nuevo",dw_1.GetItemNumber(row,"importe"))
		END IF
END IF
iF row <> 0 Then
	dw_1.SetFocus()
	dw_1.SetRow(row)
//	dw_1.SetColumn("nuevo")
END IF






end event

event itemchanged;call super::itemchanged;dw_1.AcceptText()
IF dw_1.GetItemNumber(row,"importe") < dw_1.GetItemNumber(row,"nuevo") Then
	dw_1.SetItem(row,"nuevo",dw_1.GetItemNumber(row,"importe"))
END IF
end event

type cb_salir from u_boton within w_cancelacion_pagos_emi
event clicked pbm_bnclicked
integer x = 1778
integer y = 1308
integer width = 293
integer height = 84
integer taborder = 70
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;
f_activar(TRUE)
end event

type cb_procesar from u_boton within w_cancelacion_pagos_emi
integer x = 1070
integer y = 1296
integer width = 398
integer height = 104
integer taborder = 60
boolean bringtotop = true
string text = "&Procesar"
end type

event clicked;// Proceso Cancelacion  de Pagos
Dec v_anyo,var_importe,dif
Dec v_orden,acumulado
acumulado = 0
DateTime fpago
STring   banco,proveedor
str_carpagos pag

// No fecha de pago sólo fecha del apunte 
fpago = DateTime(Date(em_fapunte.text))
banco = uo_banco.em_codigo.text

IF dw_1.RowCOunt() = 0 Then Return
Str_contaapun apu  

Int bien = 0
Int r1,r,ultimo
r1 = dw_1.RowCOunt()
apu.empresa    =  codigo_empresa
apu.ejercicio  =  Dec(uo_ejercicio.em_ejercicio.text)
apu.fapunte    =  DateTime(Date(em_fapunte.text))
apu.mes        =  Month(Date(apu.fapunte))
// recogemos el origen de la tabla contagen
apu.origen	   = f_diario_contagene(codigo_empresa,"10")	
apu.apunte     =  0

IF Trim(uo_banco.em_codigo.text)= "" Then
	f_mensaje("Error en Introduccion de datos","Introduzca el banco")
	f_activar(TRUE)
	f_activar_campo(uo_banco.em_campo)
	Return
END IF


IF Not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),DateTime(date(em_fapunte.text))) Then 
	f_activar(TRUE)
	f_activar_campo(em_fapunte)
	Return
END IF


if isnull(em_asiento) or trim(em_asiento.text)="" then
	apu.asiento = f_ultimo_asiento(apu.ejercicio,apu.empresa,apu.mes,apu.origen)
   em_asiento.text = string(apu.asiento)
	cb_2.enabled = True
else
	apu.asiento = dec(em_asiento.text)
	Dec sto
	Select Max(contaapun.apunte) Into :sto From contaapun
   Where  contaapun.ejercicio = :apu.ejercicio
   And    contaapun.empresa   = :codigo_empresa
   And    contaapun.mes       = :apu.mes
	And    contaapun.origen    = :apu.origen
   And    contaapun.asiento   = :apu.asiento;
   IF IsNull(sto) Then sto = 0
	sto = sto + 1
	apu.apunte = sto
End if

// Para ver si hay alguno marcado
int cuantos
cuantos = 0
dw_1.accepttext()
For r = 1 To r1
	IF dw_1.GetItemNumber(r,"marca") = 0 Then
		ultimo=r
		// Hay al menos uno
		cuantos ++

		var_importe    = dw_1.GetItemNumber(r,"importe")
		apu.moneda     = dw_1.GetItemString(r,"moneda")
		apu.cambio     = f_cambio_moneda(apu.moneda)
		iF apu.cambio = 0 Then apu.cambio = 1
		IF apu.cambio = 0 OR IsNull(apu.cambio) THEN apu.cambio = 1
		apu.divisas    = var_importe / apu.cambio
		apu.diario     = ""
		SetNUll(apu.tipoapu)
		apu.documento  = dw_1.GetItemString(r,"fra")
		apu.factura    = dw_1.GetItemString(r,"fra")
		apu.ffactura   = dw_1.GetItemDateTime(r,"ffra")
		apu.imponible  = 0
		SetNull(apu.tipoiva)
		SetNull(apu.iva)
		apu.deducible= ""
		apu.actualizado="N"
		SetNUll(apu.listado)
		SetNUll(apu.registro)
		SetNUll(apu.tipoter)
		SetNull(apu.clipro)
		SetNull(apu.conciliado)
		SetNull(apu.nif)
		SetNull(apu.punteado)
		SetNull(apu.fvalor)
		SetNull(apu.docpunteo)
		SetNull(apu.coste)
		SetNull(apu.registro)
		
		// Apunte al Proveedor
		dif  =  dw_1.GetItemNumber(r,"importe") - var_importe	
		apu.cuenta     = f_cuenta_genter(apu.empresa,"P",dw_1.GetItemstring(r,"proveedor"))
		// Recogemos de contagene datos de origen,concepto,ampliación y ampliación
		apu.origen	  = f_diario_contagene(codigo_empresa,"10")		
		apu.concepto   = f_concepto_contagene(codigo_empresa,"10")
		apu.ampliacion = f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemstring(r,"tipodoc"))+" "+f_nombre_banco_abr(codigo_empresa,uo_banco.em_codigo.text)
		
		IF dif <> 0 Then
			apu.ampliacion = apu.ampliacion + " P.CTA"
		END IF				
		string dh
		dh               = f_dh_contagene(codigo_empresa,"10")
		
		IF dh = "H" THEN
			apu.debe    	= 0
			apu.haber   	= var_importe
		ELSE
			apu.haber   	= 0
			apu.debe    	= var_importe
		END IF
		apu.apunte = apu.apunte + 1
		IF Not f_insert_contaapun(apu) Then bien = 1
		v_anyo  = dw_1.GetItemNumber(r,"anyo")
		v_orden = dw_1.GetItemNumber(r,"orden")
		
		IF dif <> 0 Then
				// Insertar  diferencia pendiente de pago
		
				pag.empresa = codigo_empresa
				pag.anyo    = v_anyo 
				Select  Max(carpagos.orden) Into :pag.orden From carpagos
				Where   carpagos.empresa = :codigo_empresa
				And     carpagos.anyo    = :pag.anyo ;
				pag.orden     = pag.orden +1
				pag.anyofra   = dw_1.GetItemNumber(r,"anyofra")
				pag.fra       = dw_1.GetItemString(r,"fra")
				pag.recibo    = dw_1.GetItemNumber(r,"recibo")
				pag.ffra      = dw_1.GetItemdateTime(r,"ffra")
				pag.fvto      = dw_1.GetItemdatetime(r,"fvto")
				pag.fpago     = dw_1.GetItemdatetime(r,"fpago")
				pag.importe   = dif
				pag.divisas   = dif/apu.cambio
				pag.cambio	  = apu.cambio
				pag.moneda    = dw_1.GetItemString(r,"moneda")
				pag.banco     = dw_1.GetItemString(r,"banco")
				pag.proveedor = dw_1.GetItemString(r,"proveedor")   
				pag.tipodoc   = dw_1.GetItemString(r,"tipodoc")
				pag.codpago   = dw_1.GetItemString(r,"codpago")
				pag.situacion = "0"
				pag.cuenta    = dw_1.GetItemString(r,"cuenta")
				pag.femi      = dw_1.GetItemdateTime(r,"femi")
				IF Not f_insert_carpagos(pag) Then bien = 1
	
				
		END IF
		UPDATE carpagos SET situacion = "2",
									  proveedor = :proveedor,
									  banco     = :banco,
									  fpago     = :fpago,
									  importe   = :var_importe,
									  divisas   = :var_importe/:apu.cambio
		WHERE  carpagos.empresa = :codigo_empresa
		AND    carpagos.anyo    = :v_anyo
		AND    carpagos.orden   = :v_orden;
			
		acumulado = acumulado + var_importe

	END IF

	
		// Apunte al Banco
		apu.cuenta     = f_cuenta_carbancos(apu.empresa,uo_banco.em_codigo.text)
		apu.documento  = em_documento.text

		// Recogemos de contagene datos de origen,concepto y ampliación
		apu.origen	   = f_diario_contagene(codigo_empresa,"11")		
		
		apu.concepto   = f_concepto_contagene(codigo_empresa,"11")
		
		apu.ampliacion = Trim(f_ampliacion_contagene(codigo_empresa,"11")) 
		
		if isnull(apu.ampliacion) then  apu.ampliacion ="" 
		
		apu.ampliacion = f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemstring(r,"tipodoc"))+" "+f_razon_genter(codigo_empresa,"P",dw_1.GetItemString(r,"proveedor")   )
						
		dh               = f_dh_contagene(codigo_empresa,"11")
		IF dh = "H" THEN
			apu.debe    	= 0
			apu.haber   	= var_importe
		 ELSE
			apu.haber   	= 0
			apu.debe    	= var_importe		 	
		END IF
				
		apu.divisas    = var_importe / apu.cambio
		apu.ffactura   = fpago
		apu.apunte = apu.apunte + 1
		IF Not f_insert_contaapun(apu) Then bien = 1
		f_contador_procesos(r,r1)
NEXT
	
	
IF bien = 0 Then
	Commit;
Else
	f_mensaje("Error En proceso","La Operacion no se contabiliza")
	RollBack;
End if
f_cargar(dw_1)
cb_salir.TriggerEvent(Clicked!)

end event

type uo_banco from u_em_campo_2 within w_cancelacion_pagos_emi
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 361
integer y = 256
integer width = 1042
integer height = 80
integer taborder = 20
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

event getfocus;call super::getfocus;ue_titulo = "Selección de Bancos"
ue_datawindow ="dw_ayuda_carbancos"

end event

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type st_6 from statictext within w_cancelacion_pagos_emi
integer x = 87
integer y = 1316
integer width = 311
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Documen."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_cancelacion_pagos_emi
integer x = 59
integer y = 264
integer width = 256
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Banco"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_documento from u_em_campo within w_cancelacion_pagos_emi
integer x = 384
integer y = 1308
integer width = 389
integer taborder = 50
boolean bringtotop = true
string displaydata = "Ä"
end type

