$PBExportHeader$w_lis_packing_list_de_facturas.srw
forward
global type w_lis_packing_list_de_facturas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_packing_list_de_facturas
end type
type st_2 from statictext within w_lis_packing_list_de_facturas
end type
type em_anyo from u_em_campo within w_lis_packing_list_de_facturas
end type
type em_albaran from u_em_campo within w_lis_packing_list_de_facturas
end type
type st_3 from statictext within w_lis_packing_list_de_facturas
end type
type cb_2 from u_boton within w_lis_packing_list_de_facturas
end type
type cb_1 from u_boton within w_lis_packing_list_de_facturas
end type
type gb_2 from groupbox within w_lis_packing_list_de_facturas
end type
type gb_1 from groupbox within w_lis_packing_list_de_facturas
end type
type st_cliente from statictext within w_lis_packing_list_de_facturas
end type
type st_codcli from statictext within w_lis_packing_list_de_facturas
end type
type gb_3 from groupbox within w_lis_packing_list_de_facturas
end type
type dw_preliminar from datawindow within w_lis_packing_list_de_facturas
end type
type dw_packing from datawindow within w_lis_packing_list_de_facturas
end type
type dw_bandas from datawindow within w_lis_packing_list_de_facturas
end type
type st_1 from statictext within w_lis_packing_list_de_facturas
end type
type cbx_1 from checkbox within w_lis_packing_list_de_facturas
end type
end forward

global type w_lis_packing_list_de_facturas from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 2894
integer height = 2136
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_albaran em_albaran
st_3 st_3
cb_2 cb_2
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
st_cliente st_cliente
st_codcli st_codcli
gb_3 gb_3
dw_preliminar dw_preliminar
dw_packing dw_packing
dw_bandas dw_bandas
st_1 st_1
cbx_1 cbx_1
end type
global w_lis_packing_list_de_facturas w_lis_packing_list_de_facturas

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli
Dec{4}  var_total
integer lineas = 21
integer lnpie,contador,var_tipo
String  var_clase,c,des

end variables

forward prototypes
public subroutine f_proceso ()
public subroutine f_renumerar ()
public subroutine f_marcar ()
public subroutine f_bandas ()
end prototypes

public subroutine f_proceso ();dw_preliminar.Retrieve(codigo_empresa,Dec(em_anyo.text),DEC(em_albaran.text))
dw_preliminar.sort()
dw_preliminar.groupcalc()
end subroutine

public subroutine f_renumerar ();Integer registros,v_paldesde,v_palhasta,registro,v_pallets,anterior
String  v_articulo,v_tipo_pallet
Dec{4}  v_cantidad,acumulado
dw_preliminar.SetRedraw(FALSE)
registros = dw_preliminar.RowCOunt()
IF registros = 0 Then return
acumulado =0
anterior = 1
For registro     = 1 To registros

	v_articulo    = f_valor_columna(dw_preliminar,registro,"venlifac_articulo")
	v_tipo_pallet = f_valor_columna(dw_preliminar,registro,"venlifac_tipo_pallet")
	v_cantidad    = Dec(f_valor_columna(dw_preliminar,registro,"venlifac_cantidad"))
	v_pallets     = Dec(f_valor_columna(dw_preliminar,registro,"venlifac_pallets"))
	iF IsNull(v_pallets)  or v_pallets = 0 Then v_pallets = 1
	acumulado = acumulado + v_pallets

	v_palhasta     = acumulado
	IF v_pallets = 0 then
		v_paldesde     = anterior 
	ELSE
		v_paldesde     = anterior + 1
	END IF
	iF registro = 1 Then v_paldesde = 1
	f_asignar_columna(dw_preliminar,registro,"venlifac_paldesde",String(v_paldesde))
	f_asignar_columna(dw_preliminar,registro,"venlifac_palhasta",String(v_palhasta))
	anterior = acumulado
next
dw_preliminar.SetRedraw(TRUE)
end subroutine

public subroutine f_marcar ();Integer reg,reg1
dw_preliminar.SetRedraw(FALSE)
reg = dw_preliminar.rowCount()
For reg1 = 1 To reg
		f_asignar_columna(dw_preliminar,reg1,"listar","S")

Next
dw_preliminar.SetRedraw(TRUE)
end subroutine

public subroutine f_bandas ();Dec var_anyo,var_albaran
var_anyo  = Dec(em_anyo.text)
var_albaran = Dec(em_albaran.text)
dw_bandas.SetTransObject(SQLCA)
dw_bandas.Retrieve(codigo_empresa,var_anyo,var_albaran)

f_imprimir_datawindow(dw_bandas)



end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Listado Packing List"
This.title=istr_parametros.s_titulo_ventana

dw_preliminar.SetTransObject(SQLCA)
dw_packing.settransobject(sqlca)
dw_bandas.SetTransObject(SQLCA)

em_anyo.text = String(Year(Today()))

f_mascara_columna(dw_preliminar,"venlifac_paldesde",f_mascara_decimales(0))
f_mascara_columna(dw_preliminar,"venlifac_palhasta",f_mascara_decimales(0))

IF istr_parametros.i_nargumentos>1 THEN
	em_anyo.text=istr_parametros.s_argumentos[2]	
	em_albaran.text=istr_parametros.s_argumentos[3]	
	IF Not IsNull(em_albaran.text) and Trim(em_albaran.text) <> "" Then
		em_albaran.TriggerEvent("modificado")
		cb_1.triggerevent(clicked!)
	END IF
END IF

end event

on ue_listar;//dw_report  = dw_detalle
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_lis_packing_list_de_facturas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_albaran=create em_albaran
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.gb_3=create gb_3
this.dw_preliminar=create dw_preliminar
this.dw_packing=create dw_packing
this.dw_bandas=create dw_bandas
this.st_1=create st_1
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_albaran
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.st_cliente
this.Control[iCurrent+11]=this.st_codcli
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.dw_preliminar
this.Control[iCurrent+14]=this.dw_packing
this.Control[iCurrent+15]=this.dw_bandas
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.cbx_1
end on

on w_lis_packing_list_de_facturas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_albaran)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.gb_3)
destroy(this.dw_preliminar)
destroy(this.dw_packing)
destroy(this.dw_bandas)
destroy(this.st_1)
destroy(this.cbx_1)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_preliminar)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_preliminar)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_preliminar)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_preliminar)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_packing_list_de_facturas
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_packing_list_de_facturas
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_albaran)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_packing_list_de_facturas
integer x = 14
integer y = 4
integer width = 2450
integer height = 96
end type

type pb_1 from upb_salir within w_lis_packing_list_de_facturas
integer x = 2661
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_lis_packing_list_de_facturas
integer x = 18
integer y = 100
integer width = 210
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Factura:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_lis_packing_list_de_facturas
integer x = 37
integer y = 176
integer width = 178
integer height = 72
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type em_albaran from u_em_campo within w_lis_packing_list_de_facturas
integer x = 274
integer y = 176
integer width = 265
integer height = 72
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######"
end type

event modificado;var_idioma      = f_idioma_venfac(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda      = f_divisa_venfac(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_codcli      = f_cliente_venfac(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
st_codcli.text  = var_codcli
st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)
call super::modificado
end event

type st_3 from statictext within w_lis_packing_list_de_facturas
integer x = 224
integer y = 152
integer width = 46
integer height = 92
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
boolean focusrectangle = false
end type

type cb_2 from u_boton within w_lis_packing_list_de_facturas
event clicked pbm_bnclicked
integer x = 2162
integer y = 208
integer width = 384
integer height = 72
integer taborder = 60
string text = "&Imprimir"
end type

event clicked;string ver_cabecera

if cbx_1.checked then
	ver_cabecera = 'S'
else
	ver_cabecera = 'N'
end if

dw_packing.Retrieve(codigo_empresa,Dec(em_anyo.text),DEC(em_albaran.text), ver_cabecera)
dw_packing.sort()
dw_packing.groupcalc()
f_imprimir_datawindow(dw_packing)
end event

type cb_1 from u_boton within w_lis_packing_list_de_facturas
integer x = 2162
integer y = 128
integer width = 384
integer height = 72
integer taborder = 70
boolean bringtotop = true
string text = "Continuar"
end type

event clicked;if len(em_albaran.text)=0 then
	MessageBox("Introduzca la Factura","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_albaran)
	Return
End if

f_activar_campo(em_albaran)

em_albaran.TriggerEvent("modificado")
dw_preliminar.visible= FALSE
dw_preliminar.reset()
dw_preliminar.SetRedraw(FALSE)
f_proceso()
dw_preliminar.visible= TRUE
dw_preliminar.SetRedraw(TRUE)


end event

type gb_2 from groupbox within w_lis_packing_list_de_facturas
integer x = 1810
integer y = 96
integer width = 315
integer height = 204
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cabecera"
end type

type gb_1 from groupbox within w_lis_packing_list_de_facturas
integer x = 2135
integer y = 88
integer width = 439
integer height = 212
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_cliente from statictext within w_lis_packing_list_de_facturas
integer x = 754
integer y = 172
integer width = 1029
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
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

type st_codcli from statictext within w_lis_packing_list_de_facturas
integer x = 553
integer y = 172
integer width = 201
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_lis_packing_list_de_facturas
integer x = 9
integer y = 88
integer width = 1787
integer height = 208
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_preliminar from datawindow within w_lis_packing_list_de_facturas
integer y = 316
integer width = 2821
integer height = 1580
boolean bringtotop = true
string dataobject = "dw_paking_list_de_facturas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;visible = FALSE
end event

event clicked;
Dec{0} v_pallets,v_albaran,v_anyo_pedido,v_pedido,v_linea,v_linea_pedido,v_anyo,x1,v_paldesde,v_palhasta
dec{0} var_pallets,var_linea,var_cajas,var_total_cajas,var_caj,var_tcaj,var_cant,var_pal,var_peso
String var_art,var_tp
Dec{0} var_anyo,var_albaran
var_anyo   = Dec(em_anyo.text)
var_albaran = Dec(em_albaran.text)

IF This.RowCount() = 0 Then return
If row <> 0 Then 
	SetRow(row)
	Setcolumn("venlifac_paldesde")
END IF

IF f_objeto_datawindow(This) = "renumerar" Then
   f_renumerar()
END IF

IF f_objeto_datawindow(This) = "marcar" Then
	f_marcar()
	Return
END IF
IF f_objeto_datawindow(This) = "impbandas" Then
	f_bandas()
	Return
END IF

IF f_objeto_datawindow(This) = "listar" Then
	iF f_valor_columna(This,Row,"listar") = "S" Then
		f_asignar_columna(This,Row,"listar","N")
	ELSE
		f_asignar_columna(This,Row,"listar","S")
	END IF
	Return
END IF


IF f_objeto_datawindow(This) = "pallet_menos" Then
	IF GetRow() <> 0  Then
		var_anyo     = Dec(em_anyo.text)
		var_albaran    = Dec(em_albaran.text)

		var_linea    = GetItemNumber(GetRow(),"linea_factura")		
		var_pallets    = GetItemNumber(GetRow(),"venlifac_pallets")		
		if var_pallets = 0 or isnull(var_pallets) then return
		
		Update   venlifac
		Set      venlifac.pallets       = pallets - 1
		Where    venlifac.empresa       = :codigo_empresa
		And      venlifac.anyo          = :var_anyo
		And      venlifac.factura       = :var_albaran
		And      venlifac.linea_factura = :var_linea;
		Commit;
		SetItem(GetRow(),"venlifac_pallets",var_pallets -1)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "pallet_mas" Then
	IF GetRow() <> 0  Then
		var_anyo    = Dec(em_anyo.text)
		var_albaran   = Dec(em_albaran.text)
		var_linea   = GetItemNumber(GetRow(),"linea_factura")		
		var_pallets = GetItemNumber(GetRow(),"venlifac_pallets")		
			
		Update   venlifac
		Set      venlifac.pallets    = venlifac.pallets + 1
		Where    venlifac.empresa    = :codigo_empresa
		And      venlifac.anyo       = :var_anyo
		And      venlifac.factura    = :var_albaran
		And      venlifac.linea_factura   = :var_linea;
		Commit;
		SetItem(GetRow(),"venlifac_pallets",var_pallets +1)
	 	Return
	END IF
END IF



IF f_objeto_datawindow(This) = "caja_mas" Then
	IF GetRow() <> 0  Then
		var_anyo    = Dec(em_anyo.text)
		var_albaran   = Dec(em_albaran.text)
		var_linea       = GetItemNumber(GetRow(),"linea_factura")		
		var_cajas       = GetItemNumber(GetRow(),"venlifac_cajas")		
		var_total_cajas = GetItemNumber(GetRow(),"venlifac_total_cajas")		
		Update   venlifac
		Set      venlifac.cajas = cajas + 1,
		         venlifac.total_cajas = total_cajas + 1
		Where    venlifac.empresa     = :codigo_empresa
		And      venlifac.anyo        = :var_anyo
		And      venlifac.factura     = :var_albaran
		And      venlifac.linea_factura   = :var_linea;
		Commit;
		SetItem(GetRow(),"cajas",var_cajas +1)
		SetItem(GetRow(),"total_cajas",var_total_cajas +1)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "caja_menos" Then
	IF GetRow() <> 0  Then
		var_anyo    = Dec(em_anyo.text)
		var_albaran   = Dec(em_albaran.text)
		var_linea       = GetItemNumber(GetRow(),"linea_factura")		
		var_cajas       = GetItemNumber(GetRow(),"venlifac_cajas")		
		var_total_cajas = GetItemNumber(GetRow(),"venlifac_total_cajas")		
      if var_total_cajas = 0 or isnull(var_total_cajas) then return
		Update   venlifac		
		Set      venlifac.cajas = cajas - 1,
		         venlifac.total_cajas = total_cajas - 1
		Where    venlifac.empresa     = :codigo_empresa
		And      venlifac.anyo        = :var_anyo
		And      venlifac.factura     = :var_albaran
		And      venlifac.linea_factura   = :var_linea;
		Commit;
		SetItem(GetRow(),"cajas",var_cajas -1)
		SetItem(GetRow(),"total_cajas",var_total_cajas -1)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "actualizar" Then
	dw_preliminar.Accepttext()
	
	For x1 = 1 To dw_preliminar.RowCOunt()
		
		var_anyo    = Dec(em_anyo.text)
		var_albaran   = Dec(em_albaran.text)
		var_linea    = dw_preliminar.object.linea_factura[x1]		
		v_paldesde   = dw_preliminar.object.venlifac_paldesde[x1]		
		v_palhasta   = dw_preliminar.object.venlifac_palhasta[x1]		
		
		Update   venlifac
		Set      venlifac.palhasta   = :v_palhasta,
		         venlifac.paldesde   = :v_paldesde
		Where    venlifac.empresa    = :codigo_empresa
		And      venlifac.anyo       = :var_anyo
		And      venlifac.factura    = :var_albaran
		And      venlifac.linea_factura   = :var_linea;
		
		if sqlca.sqlcode = 0 then
			Commit;
		else
			rollback;
			messagebox("ERROR", sqlca.sqlerrtext)
		end if
	Next
	Return
END IF

end event

event rowfocuschanged;If GetRow() = 0 Then Return
SetRow(GetRow())
Setcolumn("venlifac_paldesde")
end event

type dw_packing from datawindow within w_lis_packing_list_de_facturas
boolean visible = false
integer x = 2610
integer y = 152
integer width = 151
integer height = 108
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_packing_de_factura"
boolean livescroll = true
end type

type dw_bandas from datawindow within w_lis_packing_list_de_facturas
boolean visible = false
integer x = 434
integer y = 456
integer width = 2107
integer height = 500
integer taborder = 40
string dataobject = "dw_bandas_packig"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type st_1 from statictext within w_lis_packing_list_de_facturas
integer x = 503
integer y = 100
integer width = 247
integer height = 52
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
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_lis_packing_list_de_facturas
integer x = 1934
integer y = 184
integer width = 69
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
boolean checked = true
boolean lefttext = true
end type

