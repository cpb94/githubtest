$PBExportHeader$w_lis_packing_list.srw
forward
global type w_lis_packing_list from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_packing_list
end type
type st_2 from statictext within w_lis_packing_list
end type
type em_anyo from u_em_campo within w_lis_packing_list
end type
type em_albaran from u_em_campo within w_lis_packing_list
end type
type st_3 from statictext within w_lis_packing_list
end type
type cb_2 from u_boton within w_lis_packing_list
end type
type cb_1 from u_boton within w_lis_packing_list
end type
type gb_1 from groupbox within w_lis_packing_list
end type
type st_7 from statictext within w_lis_packing_list
end type
type st_cliente from statictext within w_lis_packing_list
end type
type st_codcli from statictext within w_lis_packing_list
end type
type gb_3 from groupbox within w_lis_packing_list
end type
type dw_preliminar from datawindow within w_lis_packing_list
end type
type dw_bandas from datawindow within w_lis_packing_list
end type
type dw_packing from datawindow within w_lis_packing_list
end type
end forward

global type w_lis_packing_list from w_int_con_empresa
integer x = 46
integer y = 48
integer width = 2912
integer height = 2136
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_albaran em_albaran
st_3 st_3
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
st_7 st_7
st_cliente st_cliente
st_codcli st_codcli
gb_3 gb_3
dw_preliminar dw_preliminar
dw_bandas dw_bandas
dw_packing dw_packing
end type
global w_lis_packing_list w_lis_packing_list

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

	v_articulo    = f_valor_columna(dw_preliminar,registro,"venlialb_articulo")
	v_tipo_pallet = f_valor_columna(dw_preliminar,registro,"venlialb_tipo_pallet")
	v_cantidad    = Dec(f_valor_columna(dw_preliminar,registro,"venlialb_cantidad"))
	v_pallets     = Dec(f_valor_columna(dw_preliminar,registro,"venlialb_pallets"))
	iF IsNull(v_pallets)  or v_pallets = 0 Then v_pallets = 1
	acumulado = acumulado + v_pallets

	v_palhasta     = acumulado
	IF v_pallets = 0 then
		v_paldesde     = anterior 
	ELSE
		v_paldesde     = anterior + 1
	END IF
	iF registro = 1 Then v_paldesde = 1
	f_asignar_columna(dw_preliminar,registro,"venlialb_paldesde",String(v_paldesde))
	f_asignar_columna(dw_preliminar,registro,"venlialb_palhasta",String(v_palhasta))
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

public subroutine f_bandas ();Integer registro,registros,reg,desde,hasta,bul,var_divisor
Dec{0}  var_anyo,var_albaran,var_linea
String v_pais,v_ciudad,v_nombre_pais,v_razon,v_observaciones,var_cliente
dw_bandas.Reset()
dw_bandas.SetRedraw (FALSE)
dw_bandas.enabled =FALSE
var_anyo  = Dec(em_anyo.text)
var_albaran = Dec(em_albaran.text)

String var_matricula,var_bulto,ante_bulto,ante_bulto2,var_bulto2
//var_cliente   = f_valor_columna(dw_preliminar,1,"cliente")
var_cliente   = st_cliente.text
//var_matricula = f_valor_columna(dw_preliminar,1,"matricula")
SetNull(ante_bulto)
reg = 0
registros = dw_preliminar.RowCount()
For registro = 1 To registros
	IF f_valor_columna(dw_preliminar,registro,"listar")="S" Then
		var_bulto = f_valor_columna(dw_preliminar,registro,"venlialb_paldesde")
		var_bulto2 = f_valor_columna(dw_preliminar,registro,"venlialb_palhasta")
		IF ISNULL(ante_bulto)  or ante_bulto <> var_bulto Then 
	   	desde = dec(var_bulto)
		   hasta = dec(var_bulto2)
		   var_divisor = (hasta - desde) + 1
	   	For bul = desde To hasta
		     reg = reg +1
			  dw_bandas.InsertRow(reg)		
		Next
	END IF
	ante_bulto = var_bulto
	ante_bulto2 = var_bulto2
END IF
Next

v_razon    = f_razon_genter(codigo_empresa,"C",var_cliente)
v_ciudad   = f_localidad_genter(codigo_empresa,"C",var_cliente)
v_nombre_pais     = f_nombre_pais(f_pais_genter(codigo_empresa,"C",var_cliente))

SetNull(ante_bulto)
reg = 0
For registro = 1 To registros
	IF f_valor_columna(dw_preliminar,registro,"listar")="S" Then
		var_bulto  = f_valor_columna(dw_preliminar,registro,"venlialb_paldesde")
		var_bulto2 = f_valor_columna(dw_preliminar,registro,"venlialb_palhasta")
		IF ISNULL(ante_bulto)  or ante_bulto <> var_bulto Then 
		
	   	desde = dec(var_bulto)
		   hasta = dec(var_bulto2)
		   var_divisor = (hasta - desde) + 1
	   	For bul = desde To hasta
		     reg = reg +1
		     //dw_bandas.InsertRow(reg)		
		     f_asignar_columna(dw_bandas,reg,"empresa",codigo_empresa)
			  f_asignar_columna(dw_bandas,reg,"cliente",var_cliente)
			  f_asignar_columna(dw_bandas,reg,"ciudad",v_ciudad)
			  f_asignar_columna(dw_bandas,reg,"nombre_pais",v_nombre_pais)
			  f_asignar_columna(dw_bandas,reg,"razon",v_razon)
			  //f_asignar_columna(dw_bandas,reg,"pais",v_pais)
			  f_asignar_columna(dw_bandas,reg,"referencia",var_matricula)
			  f_asignar_columna(dw_bandas,reg,"bulto",String(bul))
			  f_asignar_columna(dw_bandas,reg,"paldesde",String(desde))
			  f_asignar_columna(dw_bandas,reg,"palhasta",String(hasta))
			  f_asignar_columna(dw_bandas,reg,"anyo",String(var_anyo))
//			  f_asignar_columna(dw_bandas,reg,"albaran",String(var_albaran))
			  f_asignar_columna(dw_bandas,reg,"divisor",String(var_divisor))
			  f_asignar_columna(dw_bandas,reg,"observaciones",v_observaciones)
	      Next
	END IF
	ante_bulto = var_bulto
	ante_bulto2 = var_bulto2
 END IF
NEXT

dw_bandas.InsertRow(1)
dw_bandas.DeleteRow(1)
dw_bandas.SetRedraw (TRUE)
dw_bandas.enabled =TRUE


f_imprimir_datawindow(dw_bandas)



end subroutine

event open;call super::open;Integer r,j
dw_packing.settransobject(sqlca)
istr_parametros.s_titulo_ventana="Listado Packing List"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))
istr_parametros = Message.PowerObjectParm
f_mascara_columna(dw_preliminar,"venlialb_paldesde",f_mascara_decimales(0))
f_mascara_columna(dw_preliminar,"venlialb_palhasta",f_mascara_decimales(0))
IF istr_parametros.i_nargumentos>1 THEN

	j= 1
   IF istr_parametros.s_argumentos[5]= "S"	 Then j = 2
     em_anyo.text=istr_parametros.s_argumentos[2]	
	  em_albaran.text=istr_parametros.s_argumentos[3]	
 	   IF Not IsNull(em_albaran.text) and Trim(em_albaran.text) <> "" Then
	  	  em_albaran.TriggerEvent("modificado")
	     istr_parametros.i_nargumentos=0
	  END IF

	Close(This)
	Return
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

on w_lis_packing_list.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_albaran=create em_albaran
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.st_7=create st_7
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.gb_3=create gb_3
this.dw_preliminar=create dw_preliminar
this.dw_bandas=create dw_bandas
this.dw_packing=create dw_packing
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_albaran
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.st_7
this.Control[iCurrent+10]=this.st_cliente
this.Control[iCurrent+11]=this.st_codcli
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.dw_preliminar
this.Control[iCurrent+14]=this.dw_bandas
this.Control[iCurrent+15]=this.dw_packing
end on

on w_lis_packing_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_albaran)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.st_7)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.gb_3)
destroy(this.dw_preliminar)
destroy(this.dw_bandas)
destroy(this.dw_packing)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_preliminar)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_preliminar)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_preliminar)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_preliminar)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_packing_list
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_packing_list
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_albaran)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_packing_list
integer x = 14
integer y = 4
integer width = 2450
integer height = 96
end type

type pb_1 from upb_salir within w_lis_packing_list
integer x = 2674
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_lis_packing_list
integer x = 18
integer y = 160
integer width = 210
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Albaran:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_lis_packing_list
integer x = 233
integer y = 156
integer width = 192
integer height = 80
integer taborder = 0
end type

type em_albaran from u_em_campo within w_lis_packing_list
integer x = 466
integer y = 156
integer width = 210
integer height = 80
integer taborder = 40
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######"
string displaydata = "~b"
end type

event modificado;var_idioma      = f_idioma_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda      = f_divisa_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_codcli      = f_cliente_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
st_codcli.text  = var_codcli
st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)
call super::modificado
end event

type st_3 from statictext within w_lis_packing_list
integer x = 425
integer y = 140
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

type cb_2 from u_boton within w_lis_packing_list
event clicked pbm_bnclicked
integer x = 2162
integer y = 208
integer width = 384
integer height = 72
integer taborder = 50
string text = "&Imprimir"
end type

event clicked;call super::clicked;dw_packing.Retrieve(codigo_empresa,Dec(em_anyo.text),DEC(em_albaran.text))
f_imprimir_datawindow(dw_packing)
end event

type cb_1 from u_boton within w_lis_packing_list
integer x = 2162
integer y = 128
integer width = 384
integer height = 72
integer taborder = 60
boolean bringtotop = true
string text = "Continuar"
end type

event clicked;call super::clicked;if len(em_albaran.text)=0 then
	MessageBox("Introduzca al albaran","" ,Exclamation!, OK!, 2)
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

type gb_1 from groupbox within w_lis_packing_list
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

type st_7 from statictext within w_lis_packing_list
integer x = 690
integer y = 152
integer width = 297
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_cliente from statictext within w_lis_packing_list
integer x = 1193
integer y = 152
integer width = 910
integer height = 80
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

type st_codcli from statictext within w_lis_packing_list
integer x = 992
integer y = 152
integer width = 201
integer height = 80
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

type gb_3 from groupbox within w_lis_packing_list
integer x = 5
integer y = 80
integer width = 2121
integer height = 216
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_preliminar from datawindow within w_lis_packing_list
integer y = 316
integer width = 2821
integer height = 1584
boolean bringtotop = true
string dataobject = "dw_paking_list"
boolean hscrollbar = true
boolean vscrollbar = true
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
	Setcolumn("venlialb_paldesde")
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

		var_linea    = GetItemNumber(GetRow(),"venlialb_linea")		
		var_pallets    = GetItemNumber(GetRow(),"venlialb_pallets")		
		if var_pallets = 0 or isnull(var_pallets) then return
		
		Update   venlialb
		Set      venlialb.pallets    = pallets - 1

		Where    venlialb.empresa = :codigo_empresa
		And      venlialb.anyo    = :var_anyo
		And      venlialb.albaran   = :var_albaran
		And      venlialb.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"venlialb_pallets",var_pallets -1)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "pallet_mas" Then
	IF GetRow() <> 0  Then
		var_anyo    = Dec(em_anyo.text)
		var_albaran   = Dec(em_albaran.text)
		var_linea   = GetItemNumber(GetRow(),"venlialb_linea")		
		var_pallets = GetItemNumber(GetRow(),"venlialb_pallets")		
			
		Update   venlialb
		Set      venlialb.pallets    = venlialb.pallets + 1
		Where    venlialb.empresa = :codigo_empresa
		And      venlialb.anyo    = :var_anyo
		And      venlialb.albaran   = :var_albaran
		And      venlialb.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"venlialb_pallets",var_pallets +1)
	 	Return
	END IF
END IF



IF f_objeto_datawindow(This) = "caja_mas" Then
	IF GetRow() <> 0  Then
		var_anyo    = Dec(em_anyo.text)
		var_albaran   = Dec(em_albaran.text)
		var_linea       = GetItemNumber(GetRow(),"venlialb_linea")		
		var_cajas       = GetItemNumber(GetRow(),"venlialb_cajas")		
		var_total_cajas = GetItemNumber(GetRow(),"venlialb_total_cajas")		
		Update   venlialb
		Set      venlialb.cajas = cajas + 1,
		         venlialb.total_cajas = total_cajas + 1
		Where    venlialb.empresa = :codigo_empresa
		And      venlialb.anyo    = :var_anyo
		And      venlialb.albaran   = :var_albaran
		And      venlialb.linea   = :var_linea;
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
		var_linea       = GetItemNumber(GetRow(),"venlialb_linea")		
		var_cajas       = GetItemNumber(GetRow(),"venlialb_cajas")		
		var_total_cajas = GetItemNumber(GetRow(),"venlialb_total_cajas")		
      if var_total_cajas = 0 or isnull(var_total_cajas) then return
		Update   venlialb		
		Set      venlialb.cajas = cajas - 1,
		         venlialb.total_cajas = total_cajas - 1
		Where    venlialb.empresa = :codigo_empresa
		And      venlialb.anyo    = :var_anyo
		And      venlialb.albaran   = :var_albaran
		And      venlialb.linea   = :var_linea;
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
		var_linea    = GetItemNumber(x1,"venlialb_linea")		
		v_paldesde   = GetItemNumber(x1,"venlialb_paldesde")		
		v_palhasta =  GetItemNumber(x1,"venlialb_palhasta")		

		
		Update   venlialb
		Set      venlialb.palhasta   = :v_palhasta,
		         venlialb.paldesde   = :v_paldesde
		Where    venlialb.empresa = :codigo_empresa
		And      venlialb.anyo    = :var_anyo
		And      venlialb.albaran   = :var_albaran
		And      venlialb.linea   = :var_linea;
		Commit;
	Next
	 	Return
END IF

end event

event rowfocuschanged;If GetRow() = 0 Then Return
SetRow(GetRow())
Setcolumn("venlialb_paldesde")
end event

type dw_bandas from datawindow within w_lis_packing_list
boolean visible = false
integer x = 1061
integer y = 12
integer width = 955
integer height = 96
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_almcargas_bandas"
boolean livescroll = true
end type

type dw_packing from datawindow within w_lis_packing_list
boolean visible = false
integer y = 128
integer width = 494
integer height = 108
integer taborder = 1
boolean bringtotop = true
string dataobject = "report_packing"
boolean livescroll = true
end type

