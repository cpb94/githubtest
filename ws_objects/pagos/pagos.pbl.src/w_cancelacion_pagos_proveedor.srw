$PBExportHeader$w_cancelacion_pagos_proveedor.srw
$PBExportComments$Cancelacion de Pagos tipo doc <> pagare
forward
global type w_cancelacion_pagos_proveedor from w_int_con_empresa
end type
type gb_5 from groupbox within w_cancelacion_pagos_proveedor
end type
type gb_4 from groupbox within w_cancelacion_pagos_proveedor
end type
type gb_2 from groupbox within w_cancelacion_pagos_proveedor
end type
type pb_2 from upb_salir within w_cancelacion_pagos_proveedor
end type
type dw_listado from datawindow within w_cancelacion_pagos_proveedor
end type
type uo_ejercicio from u_ejercicio within w_cancelacion_pagos_proveedor
end type
type uo_proveedor from u_em_campo_2 within w_cancelacion_pagos_proveedor
end type
type st_2 from statictext within w_cancelacion_pagos_proveedor
end type
type gb_1 from groupbox within w_cancelacion_pagos_proveedor
end type
type cb_1 from commandbutton within w_cancelacion_pagos_proveedor
end type
type em_asiento from u_em_campo within w_cancelacion_pagos_proveedor
end type
type cb_2 from commandbutton within w_cancelacion_pagos_proveedor
end type
type gb_3 from groupbox within w_cancelacion_pagos_proveedor
end type
type st_22 from statictext within w_cancelacion_pagos_proveedor
end type
type em_fapunte from u_em_campo within w_cancelacion_pagos_proveedor
end type
type dw_1 from u_datawindow_consultas within w_cancelacion_pagos_proveedor
end type
type cb_salir from u_boton within w_cancelacion_pagos_proveedor
end type
type cb_procesar from u_boton within w_cancelacion_pagos_proveedor
end type
type uo_banco from u_em_campo_2 within w_cancelacion_pagos_proveedor
end type
type st_6 from statictext within w_cancelacion_pagos_proveedor
end type
type st_4 from statictext within w_cancelacion_pagos_proveedor
end type
type em_documento from u_em_campo within w_cancelacion_pagos_proveedor
end type
type cbx_detallar_apunte_banco from checkbox within w_cancelacion_pagos_proveedor
end type
end forward

global type w_cancelacion_pagos_proveedor from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3703
integer height = 2136
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
pb_2 pb_2
dw_listado dw_listado
uo_ejercicio uo_ejercicio
uo_proveedor uo_proveedor
st_2 st_2
gb_1 gb_1
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
cbx_detallar_apunte_banco cbx_detallar_apunte_banco
end type
global w_cancelacion_pagos_proveedor w_cancelacion_pagos_proveedor

type variables

end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_activar (boolean bol)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
dw_data.reset()
dw_data.SetTransObject(sqlca)
dw_data.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,uo_banco.em_codigo.text)
registros = dw_data.RowCount()


end subroutine

public subroutine f_activar (boolean bol);
uo_proveedor.em_codigo.enabled= bol
uo_proveedor.em_campo.enabled = bol
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
This.title = " CANCELACION DE PAGOS POR PROVEEDOR"

f_activar(TRUE)

cb_procesar.BringToTop=True
dw_1.Setfocus()

em_fapunte.text = String(Today(),"dd-mm-yy")
//f_mascara_columna(dw_1,"nuevo",f_mascara_decimales(0))

//f_activar_campo(em_fapunte)
//uo_banco.em_campo.setfocus()


end event

on w_cancelacion_pagos_proveedor.create
int iCurrent
call super::create
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_2=create gb_2
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.uo_ejercicio=create uo_ejercicio
this.uo_proveedor=create uo_proveedor
this.st_2=create st_2
this.gb_1=create gb_1
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
this.cbx_detallar_apunte_banco=create cbx_detallar_apunte_banco
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_ejercicio
this.Control[iCurrent+7]=this.uo_proveedor
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.em_asiento
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.st_22
this.Control[iCurrent+15]=this.em_fapunte
this.Control[iCurrent+16]=this.dw_1
this.Control[iCurrent+17]=this.cb_salir
this.Control[iCurrent+18]=this.cb_procesar
this.Control[iCurrent+19]=this.uo_banco
this.Control[iCurrent+20]=this.st_6
this.Control[iCurrent+21]=this.st_4
this.Control[iCurrent+22]=this.em_documento
this.Control[iCurrent+23]=this.cbx_detallar_apunte_banco
end on

on w_cancelacion_pagos_proveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.uo_ejercicio)
destroy(this.uo_proveedor)
destroy(this.st_2)
destroy(this.gb_1)
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
destroy(this.cbx_detallar_apunte_banco)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cancelacion_pagos_proveedor
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cancelacion_pagos_proveedor
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cancelacion_pagos_proveedor
integer x = 32
integer y = 4
integer width = 2638
end type

type gb_5 from groupbox within w_cancelacion_pagos_proveedor
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

type gb_4 from groupbox within w_cancelacion_pagos_proveedor
integer x = 27
integer y = 104
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

type gb_2 from groupbox within w_cancelacion_pagos_proveedor
integer x = 9
integer y = 1760
integer width = 2299
integer height = 164
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_cancelacion_pagos_proveedor
integer x = 3502
integer y = 8
integer width = 110
integer height = 100
integer taborder = 0
end type

type dw_listado from datawindow within w_cancelacion_pagos_proveedor
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_asignacion_pagos_bancos"
boolean livescroll = true
end type

type uo_ejercicio from u_ejercicio within w_cancelacion_pagos_proveedor
event destroy ( )
integer x = 2126
integer y = 140
integer height = 300
integer taborder = 60
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type uo_proveedor from u_em_campo_2 within w_cancelacion_pagos_proveedor
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 357
integer y = 252
integer width = 1051
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
dw_1.Reset()
If Trim(uo_proveedor.em_campo.text)="" then
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_cancelacion_pagos_proveedor
integer x = 50
integer y = 256
integer width = 288
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_cancelacion_pagos_proveedor
integer x = 27
integer y = 212
integer width = 1408
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_1 from commandbutton within w_cancelacion_pagos_proveedor
integer x = 1815
integer y = 172
integer width = 293
integer height = 140
integer taborder = 40
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

type em_asiento from u_em_campo within w_cancelacion_pagos_proveedor
integer x = 2661
integer y = 1816
integer width = 283
integer taborder = 0
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "(t"
end type

type cb_2 from commandbutton within w_cancelacion_pagos_proveedor
integer x = 2331
integer y = 1824
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

type gb_3 from groupbox within w_cancelacion_pagos_proveedor
integer x = 2313
integer y = 1760
integer width = 667
integer height = 164
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_22 from statictext within w_cancelacion_pagos_proveedor
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

type em_fapunte from u_em_campo within w_cancelacion_pagos_proveedor
integer x = 1472
integer y = 240
integer width = 306
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type dw_1 from u_datawindow_consultas within w_cancelacion_pagos_proveedor
integer x = 5
integer y = 464
integer width = 3607
integer height = 1296
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_cancelacion_pagos_proveedor"
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
		long anyo,orden
		
		if row > 0 then
			anyo  = this.object.anyo[row]
			orden = this.object.orden[row]
			f_muestra_detalle_pago_agrupado(anyo,orden,ypos + this.y + parent.y)
		end if		
 END CHOOSE
 CALL Super::rbuttondown
end event

event clicked;call super::clicked;string ls_banco

IF f_objeto_datawindow(dw_1) = "marca" Then
	ls_banco = this.object.banco[row]
	if isnull(ls_banco) then ls_banco = ''
	
	if ls_banco = uo_banco.em_codigo.text or trim(ls_banco) = '' then
		IF dw_1.GetItemSTring(row,"marca") = "0" Then
			dw_1.SetItem(row,"nuevo",0)
			dw_1.SetItem(row,"marca","1")
			dw_1.SetFocus()
			dw_1.SetRow(row)
			dw_1.SetColumn("nuevo")
		ELSE
			dw_1.SetItem(row,"marca","0")
			dw_1.SetItem(row,"nuevo",dw_1.GetItemNumber(row,"importe"))
	
		END IF
	else
		messagebox("¡Atención!","Solo puede marcar efectos del banco seleccionado o sin banco asignado.")
	end if
END IF
iF row <> 0 Then
	dw_1.SetFocus()
	dw_1.SetRow(row)
	dw_1.SetColumn("nuevo")
END IF
end event

event itemchanged;call super::itemchanged;dw_1.AcceptText()

IF dw_1.GetItemNumber(row,"importe") < dw_1.GetItemNumber(row,"nuevo") Then
	dw_1.SetItem(row,"nuevo",dw_1.GetItemNumber(row,"importe"))
END IF
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param

IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carpagos,lstr_param)
End If
end event

type cb_salir from u_boton within w_cancelacion_pagos_proveedor
event clicked pbm_bnclicked
integer x = 1897
integer y = 1800
integer width = 398
integer height = 112
integer taborder = 80
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;
f_activar(TRUE)
end event

type cb_procesar from u_boton within w_cancelacion_pagos_proveedor
integer x = 1472
integer y = 1800
integer width = 398
integer height = 112
integer taborder = 70
boolean bringtotop = true
string text = "&Procesar"
end type

event clicked;// Proceso Cancelacion  de Pagos
dec{2} diferencia,debe_total,haber_total,ld_importe
int cuantos = 0
Int bien = 0
Int r1,r,ultimo
long ll_anyo_agrupado,ll_orden_agrupado,ll_cuentas,ll_indice,ll_total
Dec v_anyo,var_importe,dif
Dec v_orden,acumulado = 0
DateTime fpago
STring   banco,proveedor,ls_agrupado,ls_cuenta,ls_sel
string dh
str_carpagos pag
boolean se_han_cancelado_divisas = false
datastore ds_datos

//IF f_cuenta_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text) = "" Then
//	f_mensaje("Error en datos","Este proveedor no tiene cuenta contable")
//	cb_salir.TriggerEvent(Clicked!)
//	f_activar_campo(uo_proveedor.em_campo)
//	Return
//END IF

// No fecha de pago sólo fecha del apunte 
fpago = DateTime(Date(em_fapunte.text))
banco = uo_banco.em_codigo.text
proveedor = uo_proveedor.em_codigo.text
IF dw_1.RowCOunt() = 0 Then Return
Str_contaapun apu  

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

if isnull(em_asiento) or trim(em_asiento.text)="" or 1 = 1 then
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

dw_1.accepttext()
For r = 1 To r1
	IF dw_1.GetItemString(r,"marca") = "0" Then
		ultimo=r
		// Hay al menos uno
		cuantos ++

		var_importe    = dw_1.GetItemNumber(r,"nuevo")
		apu.moneda     = dw_1.GetItemString(r,"moneda")
		IF apu.moneda <> f_moneda_empresa(codigo_empresa) then se_han_cancelado_divisas = true
		apu.cambio     = f_cambio_moneda(apu.moneda)
		
		IF apu.cambio = 0 OR IsNull(apu.cambio) THEN apu.cambio = 1
		
		ls_agrupado = dw_1.object.agrupado[r]
		
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
		dif  =  round(dw_1.GetItemNumber(r,"importe") - var_importe	, 2)
		
		IF dif <> 0 Then
			apu.ampliacion = apu.ampliacion + " P.CTA"
		END IF		

		apu.origen	   = f_diario_contagene(codigo_empresa,"10")		
		apu.concepto   = f_concepto_contagene(codigo_empresa,"10")
		//f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemstring(r,"tipodoc"))+" "+
		apu.ampliacion = "NP FRA "+apu.documento+" "+f_nombre_banco_abr(codigo_empresa,uo_banco.em_codigo.text)
		
		dh             = f_dh_contagene(codigo_empresa,"10")						
		
		if ls_agrupado = 'S' then
			ll_anyo_agrupado  = dw_1.object.anyo[r]
			ll_orden_agrupado = dw_1.object.orden[r]
			
			select isnull(count(distinct(isnull(cuenta,''))),0)
			into   :ll_cuentas
			from   carpagosdetagrupado
			where  empresa        = :codigo_empresa
			and    anyo_agrupado  = :ll_anyo_agrupado
			and    orden_agrupado = :ll_orden_agrupado;
			
			if ll_cuentas = 1 and 0 = 1 then
				//Esto no lo haremos nunca
				select max(isnull(cuenta,''))
				into   :ls_cuenta
				from   carpagosdetagrupado
				where  empresa        = :codigo_empresa
				and    anyo_agrupado  = :ll_anyo_agrupado
				and    orden_agrupado = :ll_orden_agrupado;				
				
				apu.cuenta = ls_cuenta
				
				IF dh = "H" THEN
					apu.debe    	= 0
					apu.haber   	= round(var_importe, 2)
				ELSE
					apu.haber   	= 0
					apu.debe    	= round(var_importe, 2)
				END IF
				apu.apunte = apu.apunte + 1
				IF Not f_insert_contaapun(apu) Then bien = 1			
			else
				//Esto lo haremos siempre
				ls_sel = "select fra,ffra,cuenta,importe "+&
				         "from   carpagosdetagrupado "+&
							"where  empresa        = '"+codigo_empresa+"' "+&
							"and    anyo_agrupado  = "+string(ll_anyo_agrupado,"###0")+" "+&
							"and    orden_agrupado = "+string(ll_orden_agrupado,"#####0")+" "+&
							"order by ffra,fra"
							
				f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
				ll_total = ds_datos.rowcount()
				for ll_indice = 1 to ll_total
					apu.documento  = ds_datos.GetItemString(ll_indice,"fra")
					apu.factura    = ds_datos.GetItemString(ll_indice,"fra")
					apu.ffactura   = ds_datos.GetItemDateTime(ll_indice,"ffra")					
					ls_cuenta      = ds_datos.object.cuenta[ll_indice]
					ld_importe     = ds_datos.object.importe[ll_indice]
					apu.cuenta     = ls_cuenta
					apu.ampliacion = "NP FRA "+apu.documento+" "+f_nombre_banco_abr(codigo_empresa,uo_banco.em_codigo.text)
					
					IF dh = "H" THEN
						apu.debe    	= 0
						apu.haber   	= round(ld_importe, 2)
					ELSE
						apu.haber   	= 0
						apu.debe    	= round(ld_importe, 2)
					END IF
					apu.apunte = apu.apunte + 1
					IF Not f_insert_contaapun(apu) Then bien = 1								
				next
				destroy ds_datos
			end if
		else
			apu.cuenta = dw_1.object.cuenta[r] //f_cuenta_genter(apu.empresa,"P",uo_proveedor.em_codigo.text)
			// Recogemos de contagene datos de origen,concepto,ampliación y ampliación
			
			IF dh = "H" THEN
				apu.debe    	= 0
				apu.haber   	= round(var_importe, 2)
			ELSE
				apu.haber   	= 0
				apu.debe    	= round(var_importe, 2)
			END IF
			apu.apunte = apu.apunte + 1
			IF Not f_insert_contaapun(apu) Then bien = 1
		end if
		
		if cbx_detallar_apunte_banco.checked then
		// APUNTE AL BANCO
			
			apu.cuenta     = f_cuenta_carbancos(apu.empresa,uo_banco.em_codigo.text)
			apu.documento  = em_documento.text
	
			// Recogemos de contagene datos de origen,concepto y ampliación
			apu.origen	   = f_diario_contagene(codigo_empresa,"11")		
			
			apu.concepto   = f_concepto_contagene(codigo_empresa,"11")
			
			apu.ampliacion = Trim(f_ampliacion_contagene(codigo_empresa,"11")) 
			
			if isnull(apu.ampliacion) then  apu.ampliacion ="" 
			
			apu.ampliacion = "NP "+uo_proveedor.em_campo.text+" FRA "+dw_1.GetItemString(r,"fra") //f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemstring(ultimo,"tipodoc"))+" "+uo_proveedor.em_campo.text
							
			dh               = f_dh_contagene(codigo_empresa,"11")
			IF dh = "H" THEN
				apu.debe    	= 0
				apu.haber   	= round(var_importe, 2)
			ELSE
				apu.haber   	= 0
				apu.debe    	= round(var_importe, 2)
			END IF
							
			apu.divisas    = var_importe / apu.cambio
			
			apu.ffactura   = fpago
			apu.apunte = apu.apunte + 1
			IF Not f_insert_contaapun(apu) Then bien = 1
		end if
		// Actualizar el efecto
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
				pag.importe   = round(dif, 2)
				pag.divisas   = dif / apu.cambio
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
									  divisas   = :var_importe / :apu.cambio
		WHERE  carpagos.empresa = :codigo_empresa
		AND    carpagos.anyo    = :v_anyo
		AND    carpagos.orden   = :v_orden;
			
		acumulado = round(acumulado + var_importe, 2)

	END IF
	f_contador_procesos(r,r1)
NEXT

if not(cbx_detallar_apunte_banco.checked) then
	// Si se ha procesado al menos uno
	if cuantos >0 then
		
		// Apunte al Banco
		apu.cuenta     = f_cuenta_carbancos(apu.empresa,uo_banco.em_codigo.text)
		apu.documento  = em_documento.text

		// Recogemos de contagene datos de origen,concepto y ampliación
		apu.origen	   = f_diario_contagene(codigo_empresa,"11")		
		
		apu.concepto   = f_concepto_contagene(codigo_empresa,"11")
		
		apu.ampliacion = Trim(f_ampliacion_contagene(codigo_empresa,"11")) 
		
		if isnull(apu.ampliacion) then  apu.ampliacion ="" 
		
		apu.ampliacion = "NP "+uo_proveedor.em_campo.text+" "+f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemstring(ultimo,"tipodoc"))
						
		dh               = f_dh_contagene(codigo_empresa,"11")
		IF dh = "H" THEN
			apu.debe    	= 0
			apu.haber   	= round(acumulado, 2)
		 ELSE
			apu.haber   	= 0
			apu.debe    	= round(acumulado, 2)
		END IF
				
		apu.divisas    = acumulado / apu.cambio
		apu.ffactura   = fpago
		apu.apunte = apu.apunte + 1
		IF Not f_insert_contaapun(apu) Then bien = 1
	  else 
		messagebox("Atención","No hay elementos señalados")
	end if
end if
//-----------------------------------------
//-----------------------------------------
// APUNTE DE DESCUADRES
//-----------------------------------------
SELECT sum(debe), sum(haber) into :debe_total, :haber_total FROM contaapun
WHERE empresa 		= :apu.empresa 		AND
		ejercicio 	= :apu.ejercicio 	AND
		origen     	= :apu.origen		AND
		mes 			= :apu.mes 			AND
		asiento		= :apu.asiento;

diferencia = debe_total - haber_total

IF diferencia <> 0 THEN
	IF not se_han_cancelado_divisas THEN
		f_mensaje("Error","Asiento descuadrado")
	ELSE
		apu.concepto   = "4"
		apu.ampliacion = "Redondeo Euro"
		if diferencia > 0 then
			apu.debe  	= 0
			apu.haber 	= abs(diferencia)
			apu.cuenta	= 	"769000002"
		else
			apu.haber 	= 0
			apu.debe  	= abs(diferencia)
			apu.cuenta	= 	"669000000"
		end if
		apu.documento   = dw_1.GetItemString(r,"fra")
		apu.factura     = dw_1.GetItemString(r,"fra")
		apu.ffactura    = dw_1.GetItemdatetime(r,"ffra")
	
		apu.apunte   = apu.apunte + 1
		IF Not f_insert_contaapun(apu) Then bien = 1
	END IF
END IF
	
	
IF bien = 0 Then
	Commit;
	int op
	op = messagebox("Atención","¿Desea ver el asiento?",question!,yesno!,2)
	if op = 1 then
		str_parametros zstr_param
		zstr_param.i_nargumentos=5
		zstr_param.s_argumentos[2]=String(apu.ejercicio)
		zstr_param.s_argumentos[3]=apu.origen
		zstr_param.s_argumentos[4]=string(date(apu.fapunte))
		zstr_param.s_argumentos[5]=string(apu.asiento)
		 
		OpenWithParm(w_int_contaapun,zstr_param) 
	end if		
	
Else
	f_mensaje("Error En proceso","La Operacion no se contabiliza")
	RollBack;
End if
f_cargar(dw_1)
cb_salir.TriggerEvent(Clicked!)
f_activar_campo(uo_proveedor.em_campo)
end event

type uo_banco from u_em_campo_2 within w_cancelacion_pagos_proveedor
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 357
integer y = 140
integer width = 1051
integer height = 80
integer taborder = 10
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

type st_6 from statictext within w_cancelacion_pagos_proveedor
integer x = 23
integer y = 1824
integer width = 270
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

type st_4 from statictext within w_cancelacion_pagos_proveedor
integer x = 59
integer y = 148
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

type em_documento from u_em_campo within w_cancelacion_pagos_proveedor
integer x = 293
integer y = 1816
integer width = 389
integer taborder = 50
boolean bringtotop = true
string displaydata = "Ä"
end type

type cbx_detallar_apunte_banco from checkbox within w_cancelacion_pagos_proveedor
integer x = 699
integer y = 1828
integer width = 750
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "No agrupar apunte banco"
boolean checked = true
end type

