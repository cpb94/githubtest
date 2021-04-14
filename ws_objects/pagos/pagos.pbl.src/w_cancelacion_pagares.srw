$PBExportHeader$w_cancelacion_pagares.srw
$PBExportComments$Cancelación Pagos Doc = Pagaré
forward
global type w_cancelacion_pagares from w_int_con_empresa
end type
type pb_2 from upb_salir within w_cancelacion_pagares
end type
type cb_consulta from u_boton within w_cancelacion_pagares
end type
type st_1 from statictext within w_cancelacion_pagares
end type
type em_hasta from u_em_campo within w_cancelacion_pagares
end type
type gb_1 from groupbox within w_cancelacion_pagares
end type
type dw_totales from datawindow within w_cancelacion_pagares
end type
type dw_fechas from datawindow within w_cancelacion_pagares
end type
type cb_procesar from u_boton within w_cancelacion_pagares
end type
type dw_1 from u_datawindow_consultas within w_cancelacion_pagares
end type
type uo_ejercicio from u_ejercicio within w_cancelacion_pagares
end type
end forward

global type w_cancelacion_pagares from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2935
integer height = 1676
pb_2 pb_2
cb_consulta cb_consulta
st_1 st_1
em_hasta em_hasta
gb_1 gb_1
dw_totales dw_totales
dw_fechas dw_fechas
cb_procesar cb_procesar
dw_1 dw_1
uo_ejercicio uo_ejercicio
end type
global w_cancelacion_pagares w_cancelacion_pagares

type variables
String situacion= "0"
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_totales ()
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
dw_data.reset()
dw_data.SetTransObject(sqlca)
situacion = '1'
dw_data.Retrieve(codigo_empresa,DateTime(Date(em_hasta.text)),situacion)
registros = dw_data.RowCount()
f_totales()
end subroutine

public subroutine f_totales ();dw_totales.Retrieve(codigo_empresa)
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
dw_fechas.SetTransObject(sqlca)
dw_totales.SetTransObject(sqlca)
This.title = " CANCELACION DE PAGOS PAGARES"
cb_procesar.BringToTop=True
dw_1.Setfocus()
em_hasta.text = String(Today(),"dd-mm-yy")

f_activar_campo(em_hasta)


end event

on w_cancelacion_pagares.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.st_1=create st_1
this.em_hasta=create em_hasta
this.gb_1=create gb_1
this.dw_totales=create dw_totales
this.dw_fechas=create dw_fechas
this.cb_procesar=create cb_procesar
this.dw_1=create dw_1
this.uo_ejercicio=create uo_ejercicio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_hasta
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.dw_totales
this.Control[iCurrent+7]=this.dw_fechas
this.Control[iCurrent+8]=this.cb_procesar
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.uo_ejercicio
end on

on w_cancelacion_pagares.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.st_1)
destroy(this.em_hasta)
destroy(this.gb_1)
destroy(this.dw_totales)
destroy(this.dw_fechas)
destroy(this.cb_procesar)
destroy(this.dw_1)
destroy(this.uo_ejercicio)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cancelacion_pagares
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cancelacion_pagares
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cancelacion_pagares
integer x = 59
integer y = 8
integer width = 2642
end type

type pb_2 from upb_salir within w_cancelacion_pagares
integer x = 2734
integer y = 8
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_cancelacion_pagares
integer x = 887
integer y = 144
integer width = 329
integer height = 84
integer taborder = 20
string text = "&Continuar"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(em_hasta)

end event

type st_1 from statictext within w_cancelacion_pagares
integer x = 32
integer y = 144
integer width = 530
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 12632256
string text = "Fecha de Pago"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;dw_fechas.SetTransObject(SQLCA)
dw_fechas.Retrieve(codigo_empresa)
dw_fechas.visible = TRUE
end event

type em_hasta from u_em_campo within w_cancelacion_pagares
integer x = 558
integer y = 144
integer width = 325
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type gb_1 from groupbox within w_cancelacion_pagares
integer x = 9
integer y = 104
integer width = 1225
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_totales from datawindow within w_cancelacion_pagares
integer x = 5
integer y = 1168
integer width = 2853
integer height = 284
boolean bringtotop = true
string dataobject = "dw_cancelacion_pagos3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_fechas from datawindow within w_cancelacion_pagares
boolean visible = false
integer x = 64
integer y = 232
integer width = 498
integer height = 456
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_cancelacion_pagares_fechas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row<> 0  Then 
	em_hasta.text = String(Date(This.GetItemDateTime(row,"fpago")),"dd-mm-yy")
	
END IF
	This.Reset()
	This.visible = FALSE
	f_activar_campo(em_hasta)
end event

type cb_procesar from u_boton within w_cancelacion_pagares
integer x = 2167
integer y = 1088
integer width = 343
integer height = 72
integer taborder = 0
string text = "&Procesar"
end type

event clicked;call super::clicked;// Proceso Cancelacion  de Pagos


if  messagebox("!! A t e n c i ó n ","¿Desea continuar con el proceso?",Question!,YesNo!,1)<>1 then
    Return
end if 	


Dec v_anyo
Dec v_orden
String ante_talon,ante_pro,ante_banco
Dec acu
acu = 0
SetNull(ante_talon)
SetNull(ante_banco)
IF dw_1.RowCount() = 0 Then Return
Str_contaapun apu  

Int bien = 0
Int r1,r
r1 = dw_1.RowCOunt()
apu.empresa = codigo_empresa
apu.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
apu.fapunte = DateTime(Date(em_hasta.text))
apu.mes = Month(Date(apu.fapunte))

// recogemos el origen de contagene
apu.origen	  = f_diario_contagene(codigo_empresa,"11")	

apu.apunte = 0
IF Not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),DateTime(date(em_hasta.text))) Then 
	f_activar_campo(em_hasta)
	Return
END IF
apu.asiento = f_ultimo_asiento(apu.ejercicio,apu.empresa,apu.mes,apu.origen)
For r = 1 To r1
	apu.divisas= dw_1.GetItemNumber(r,"divisas")
	apu.moneda= dw_1.GetItemString(r,"moneda")
	apu.cambio = f_cambio_moneda(apu.moneda)
	IF apu.cambio = 0 OR IsNull(apu.cambio) THEN apu.cambio = 1
	apu.diario= ""
	SetNUll(apu.tipoapu)
	apu.factura= dw_1.GetItemString(r,"fra")
	apu.ffactura= apu.fapunte
	apu.imponible = 0
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
	

	IF (Not ISNull(ante_talon) and ante_talon <> dw_1.getItemSTring(r,"num_talon"))&
		OR (Not ISNull(ante_banco) and ante_banco <> dw_1.getItemSTring(r,"banco"))	THEN
		//-------------------------------
		// Apunte al Banco
		//-------------------------------
		apu.cuenta     = f_cuenta_carbancos(apu.empresa,ante_banco)
		apu.documento  = ante_talon
		
		apu.origen	  = f_diario_contagene(codigo_empresa,"11")		
		
		apu.concepto   = f_concepto_contagene(codigo_empresa,"11")
			
		apu.ampliacion = Trim(f_ampliacion_contagene(codigo_empresa,"11")) 
		
		if isnull(apu.ampliacion) then  apu.ampliacion ="" 
		
		apu.ampliacion = apu.ampliacion +"P. "+ f_razon_genter(apu.empresa,"P",ante_pro)
		
		
		string dh
		dh               = f_dh_contagene(codigo_empresa,"11")
		IF dh = "H" THEN
			apu.debe    	= 0
			apu.haber   	= ACU
			
		  ELSE
			apu.haber   	= 0
			apu.debe    	= ACU
		   	
		END IF
		apu.apunte = apu.apunte + 1
		IF Not f_insert_contaapun(apu) Then bien = 1
		acu = 0
	END IF
	acu = acu + Dec(String(apu.divisas * apu.cambio,f_mascara_decimales(0)))
	ante_talon	= 	dw_1.getItemSTring(r,"num_talon")
	ante_pro    = dw_1.getItemSTring(r,"proveedor")
	ante_banco  = dw_1.getItemSTring(r,"banco")
	
	// Apunte al Proveedor
	apu.documento  = ante_talon
	apu.cuenta     = f_cuenta_genter(apu.empresa,"P",dw_1.getItemSTring(r,"proveedor"))
	IF Trim(apu.cuenta) = "" OR IsNull(apu.cuenta) THEN
		MessageBox("Cuenta Contable","El proveedor "+dw_1.getItemSTring(r,"proveedor")+" no tiene Cta. Contable",Exclamation!)
		bien = 1
		EXIT
	END IF
	apu.origen	  = f_diario_contagene(codigo_empresa,"12")		
		
	apu.concepto   = f_concepto_contagene(codigo_empresa,"12")
		
	apu.ampliacion = Trim(f_ampliacion_contagene(codigo_empresa,"12")) +&
		               String(Date(dw_1.getItemDateTime(r,"fpago")),"dd-mm-yy")  
		
			
	dh               = f_dh_contagene(codigo_empresa,"12")
	IF dh = "H" THEN
		apu.debe    	= 0
		apu.haber   	= Dec(String(apu.divisas * apu.cambio,f_mascara_decimales(0)))
			
	  ELSE
		apu.haber   	= 0
		apu.debe    	= Dec(String(apu.divisas * apu.cambio,f_mascara_decimales(0)))
		   	
	END IF
	apu.apunte = apu.apunte + 1
	IF Not f_insert_contaapun(apu) Then bien = 1
	
	v_anyo  = dw_1.GetItemNumber(r,"anyo")
	v_orden = dw_1.GetItemNumber(r,"orden")
	
	UPDATE carpagos SET situacion = "2"
	WHERE  carpagos.empresa = :codigo_empresa
	AND    carpagos.anyo    = :v_anyo
	AND    carpagos.orden   = :v_orden;
	IF r = r1 Then
		//-------------------------------
		// Apunte al Banco
		//-------------------------------
		apu.cuenta     = f_cuenta_carbancos(apu.empresa,ante_banco)
		apu.documento  = ante_talon
				
		apu.origen	  = f_diario_contagene(codigo_empresa,"11")		
		
		apu.concepto   = f_concepto_contagene(codigo_empresa,"11")
		
		apu.ampliacion = Trim(f_ampliacion_contagene(codigo_empresa,"11")) 
		
		if isnull(apu.ampliacion) then  apu.ampliacion ="" 
		
		apu.ampliacion = apu.ampliacion +"P. "+ f_razon_genter(apu.empresa,"P",ante_pro)
		
		dh               = f_dh_contagene(codigo_empresa,"11")
		IF dh = "H" THEN
			apu.debe    	= 0
			apu.haber   	= ACU
			
		  ELSE
			apu.haber   	= 0
			apu.debe    	= ACU
		   	
		END IF
		apu.apunte = apu.apunte + 1
		IF Not f_insert_contaapun(apu) Then bien = 1
		acu = 0
	END IF
	f_contador_procesos(r,r1)
Next

IF bien = 0 Then
	Commit;
	dec opcion
   opcion = messagebox("Asiento introducido","Desea ver apuntes del asiento",Question!,YesNo!,1)

   IF opcion=1 THEN 
		str_parametros zstr_param
		zstr_param.i_nargumentos=3
		zstr_param.s_argumentos[2]=string(apu.ejercicio)
		zstr_param.s_argumentos[3]=apu.origen
		zstr_param.s_argumentos[4]=string(Date(apu.fapunte))
		zstr_param.s_argumentos[5]=string(apu.asiento)
	   OpenWithParm(w_con_contaapun,zstr_param) 
   end if 	

Else
	f_mensaje("Error En proceso","El proceso no se contabiliza")
	RollBack;
End if
f_cargar(dw_1)
end event

type dw_1 from u_datawindow_consultas within w_cancelacion_pagares
integer x = 9
integer y = 252
integer width = 2853
integer height = 908
integer taborder = 0
string dataobject = "dw_cancelacion_pagares"
boolean vscrollbar = true
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

type uo_ejercicio from u_ejercicio within w_cancelacion_pagares
event destroy ( )
integer x = 2213
integer y = 148
integer taborder = 40
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

