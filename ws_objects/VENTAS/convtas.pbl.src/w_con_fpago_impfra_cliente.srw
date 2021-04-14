$PBExportHeader$w_con_fpago_impfra_cliente.srw
forward
global type w_con_fpago_impfra_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_fpago_impfra_cliente
end type
type st_1 from statictext within w_con_fpago_impfra_cliente
end type
type dw_listado from datawindow within w_con_fpago_impfra_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_fpago_impfra_cliente
end type
type cb_continuar from u_boton within w_con_fpago_impfra_cliente
end type
type pb_2 from upb_salir within w_con_fpago_impfra_cliente
end type
type pb_3 from upb_imprimir within w_con_fpago_impfra_cliente
end type
type gb_4 from groupbox within w_con_fpago_impfra_cliente
end type
type dw_detalle from datawindow within w_con_fpago_impfra_cliente
end type
type st_2 from statictext within w_con_fpago_impfra_cliente
end type
type st_3 from statictext within w_con_fpago_impfra_cliente
end type
type em_importe from u_em_campo within w_con_fpago_impfra_cliente
end type
type uo_pago from u_em_campo_2 within w_con_fpago_impfra_cliente
end type
type cb_grabar from u_boton within w_con_fpago_impfra_cliente
end type
type cb_borrar from u_boton within w_con_fpago_impfra_cliente
end type
end forward

global type w_con_fpago_impfra_cliente from w_int_con_empresa
integer width = 2853
integer height = 1648
pb_1 pb_1
st_1 st_1
dw_listado dw_listado
uo_cliente uo_cliente
cb_continuar cb_continuar
pb_2 pb_2
pb_3 pb_3
gb_4 gb_4
dw_detalle dw_detalle
st_2 st_2
st_3 st_3
em_importe em_importe
uo_pago uo_pago
cb_grabar cb_grabar
cb_borrar cb_borrar
end type
global w_con_fpago_impfra_cliente w_con_fpago_impfra_cliente

type variables
String modo



end variables

event ue_listar;String filtro
dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve(codigo_empresa)

if trim(uo_cliente.em_codigo.text)<>"" then
   filtro  = " cliente = '" + uo_cliente.em_codigo.text + "'"
End if

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta Formas de pago por importe de factura"
This.title=istr_parametros.s_titulo_ventana
dw_listado.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)



end event

on w_con_fpago_impfra_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_listado=create dw_listado
this.uo_cliente=create uo_cliente
this.cb_continuar=create cb_continuar
this.pb_2=create pb_2
this.pb_3=create pb_3
this.gb_4=create gb_4
this.dw_detalle=create dw_detalle
this.st_2=create st_2
this.st_3=create st_3
this.em_importe=create em_importe
this.uo_pago=create uo_pago
this.cb_grabar=create cb_grabar
this.cb_borrar=create cb_borrar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.cb_continuar
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.pb_3
this.Control[iCurrent+8]=this.gb_4
this.Control[iCurrent+9]=this.dw_detalle
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.em_importe
this.Control[iCurrent+13]=this.uo_pago
this.Control[iCurrent+14]=this.cb_grabar
this.Control[iCurrent+15]=this.cb_borrar
end on

on w_con_fpago_impfra_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.uo_cliente)
destroy(this.cb_continuar)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.gb_4)
destroy(this.dw_detalle)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_importe)
destroy(this.uo_pago)
destroy(this.cb_grabar)
destroy(this.cb_borrar)
end on

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

event ue_f2;call super::ue_f2;cb_grabar.TriggerEvent(Clicked!)
end event

event ue_f3;call super::ue_f3;cb_borrar.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_fpago_impfra_cliente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_fpago_impfra_cliente
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_fpago_impfra_cliente
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_fpago_impfra_cliente
boolean visible = false
integer x = 2875
integer width = 128
integer height = 112
integer taborder = 0
end type

type st_1 from statictext within w_con_fpago_impfra_cliente
integer x = 64
integer y = 200
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_fpago_impfra_cliente
boolean visible = false
integer x = 1742
integer width = 494
integer height = 84
boolean bringtotop = true
string dataobject = "report_con_fpago_impfra_cliente"
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_con_fpago_impfra_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 293
integer y = 192
integer width = 1207
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
dw_detalle.Reset()	
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type cb_continuar from u_boton within w_con_fpago_impfra_cliente
integer x = 1509
integer y = 196
integer width = 393
integer height = 76
integer taborder = 30
string text = "F5 Continuar"
end type

event clicked;call super::clicked;dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end event

type pb_2 from upb_salir within w_con_fpago_impfra_cliente
integer x = 2688
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "EXIT!"
end type

type pb_3 from upb_imprimir within w_con_fpago_impfra_cliente
integer x = 1911
integer y = 192
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;string filtro
filtro=""
dw_listado.setfilter(filtro)
if trim(uo_cliente.em_codigo.text)<>"" then
	filtro = " cliente = '"+uo_cliente.em_codigo.text+"'"
	dw_listado.setfilter(filtro)
end if

dw_listado.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
f_imprimir_datawindow(dw_listado)
f_activar_campo(uo_cliente.em_campo)

end event

type gb_4 from groupbox within w_con_fpago_impfra_cliente
integer x = 50
integer y = 148
integer width = 1979
integer height = 140
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_detalle from datawindow within w_con_fpago_impfra_cliente
integer x = 46
integer y = 312
integer width = 2688
integer height = 928
boolean bringtotop = true
string dataobject = "dw_con_fpago_impfra_cliente1"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return
em_importe.text = String(dw_detalle.GetItemNumber(row,"importe"))
uo_pago.em_codigo.text = dw_detalle.GetItemString(row,"codpago")
uo_pago.em_campo.text = f_nombre_carforpag(codigo_empresa,uo_pago.em_codigo.text)
f_activar_campo(em_importe)
end event

type st_2 from statictext within w_con_fpago_impfra_cliente
integer x = 46
integer y = 1248
integer width = 535
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Importe más...."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_fpago_impfra_cliente
integer x = 581
integer y = 1248
integer width = 1614
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "FORMA DE PAGO"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_importe from u_em_campo within w_con_fpago_impfra_cliente
integer x = 46
integer y = 1324
integer width = 535
integer taborder = 40
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0"
end type

type uo_pago from u_em_campo_2 within w_con_fpago_impfra_cliente
integer x = 581
integer y = 1320
integer width = 1614
integer height = 88
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda Formas de Pago"
ue_datawindow = "dw_ayuda_carforpag"
ue_filtro     = ""
end event

event modificado;call super::modificado;uo_pago.em_campo.text = f_nombre_carforpag(codigo_empresa,uo_pago.em_codigo.text)
IF Trim(uo_pago.em_campo.text)="" Then
	uo_pago.em_campo.text= ""
	uo_pago.em_codigo.text= ""
	return
END IF
end event

on uo_pago.destroy
call u_em_campo_2::destroy
end on

type cb_grabar from u_boton within w_con_fpago_impfra_cliente
integer x = 2249
integer y = 1252
integer height = 80
integer taborder = 0
string text = "F2 Grabar"
end type

event clicked;call super::clicked;String v_cliente,v_pago
Dec    importe,numero
importe = Dec(em_importe.text)
v_cliente = uo_cliente.em_codigo.text
v_pago    = uo_pago.em_codigo.text
IF Trim(uo_cliente.em_campo.text) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca el cliente")
	f_activar_campo(uo_cliente.em_campo)
	Return
END IF
IF Trim(uo_pago.em_campo.text) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca la forma de pago")
	f_activar_campo(uo_pago.em_campo)
	Return
END IF

Select Count(*) Into :numero From venfpagoimpfra
Where venfpagoimpfra.empresa = :codigo_empresa
And   venfpagoimpfra.cliente = :v_cliente
And   venfpagoimpfra.importe = :importe;
IF IsNull(numero) Then numero = 0

IF numero = 0 Then
	  INSERT INTO venfpagoimpfra  
		      (empresa,cliente,importe,codpago)  
	  VALUES (:codigo_empresa,:v_cliente,:importe,:v_pago);

ELSE
	UPDATE venfpagoimpfra  
	SET    codpago = :v_pago
	Where venfpagoimpfra.empresa = :codigo_empresa
	And   venfpagoimpfra.cliente = :v_cliente
	And   venfpagoimpfra.importe = :importe;
	
END IF
COMMIT;
dw_detalle.Retrieve(codigo_empresa,v_cliente)
em_importe.text = ""
uo_pago.em_codigo.text= ""
uo_pago.em_campo.text= ""
f_activar_campo(em_importe)

end event

type cb_borrar from u_boton within w_con_fpago_impfra_cliente
event clicked pbm_bnclicked
integer x = 2249
integer y = 1332
integer height = 80
integer taborder = 0
boolean bringtotop = true
string text = "F3  Borrar"
end type

event clicked;call super::clicked;String v_cliente,v_pago
Dec    importe,numero
importe = Dec(em_importe.text)
v_cliente = uo_cliente.em_codigo.text
v_pago    = uo_pago.em_codigo.text

Select Count(*) Into :numero From venfpagoimpfra
Where venfpagoimpfra.empresa = :codigo_empresa
And   venfpagoimpfra.cliente = :v_cliente
And   venfpagoimpfra.importe = :importe;
IF IsNull(numero) Then numero = 0

IF numero = 0 Then
f_mensaje("No existe forma de pago a este importe","No se puede borrar la linea")

ELSE
	DELETE venfpagoimpfra  
	Where venfpagoimpfra.empresa = :codigo_empresa
	And   venfpagoimpfra.cliente = :v_cliente
	And   venfpagoimpfra.importe = :importe;
	
END IF
COMMIT;
dw_detalle.Retrieve(codigo_empresa,v_cliente)
em_importe.text = ""
uo_pago.em_codigo.text= ""
uo_pago.em_campo.text= ""
f_activar_campo(em_importe)

end event

