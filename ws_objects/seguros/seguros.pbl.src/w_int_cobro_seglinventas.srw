$PBExportHeader$w_int_cobro_seglinventas.srw
forward
global type w_int_cobro_seglinventas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_cobro_seglinventas
end type
type dw_listado_detalle from datawindow within w_int_cobro_seglinventas
end type
type st_6 from statictext within w_int_cobro_seglinventas
end type
type uo_cliente from u_em_campo_2 within w_int_cobro_seglinventas
end type
type cb_1 from u_boton within w_int_cobro_seglinventas
end type
type uo_1 from u_manejo_datawindow within w_int_cobro_seglinventas
end type
type st_1 from statictext within w_int_cobro_seglinventas
end type
type em_cobrado from u_em_campo within w_int_cobro_seglinventas
end type
type st_fcobro from statictext within w_int_cobro_seglinventas
end type
type em_fecha_cobro from u_em_campo within w_int_cobro_seglinventas
end type
type st_resto from statictext within w_int_cobro_seglinventas
end type
type em_resto from u_em_campo within w_int_cobro_seglinventas
end type
type rb_devolucion from radiobutton within w_int_cobro_seglinventas
end type
type rb_renovacion from radiobutton within w_int_cobro_seglinventas
end type
type st_notificar from statictext within w_int_cobro_seglinventas
end type
type notificar from dropdownlistbox within w_int_cobro_seglinventas
end type
type st_fvto from statictext within w_int_cobro_seglinventas
end type
type em_fecha_vto from u_em_campo within w_int_cobro_seglinventas
end type
type dw_detalle from u_datawindow_consultas within w_int_cobro_seglinventas
end type
type cb_2 from u_boton within w_int_cobro_seglinventas
end type
end forward

global type w_int_cobro_seglinventas from w_int_con_empresa
integer width = 2917
integer height = 1588
pb_1 pb_1
dw_listado_detalle dw_listado_detalle
st_6 st_6
uo_cliente uo_cliente
cb_1 cb_1
uo_1 uo_1
st_1 st_1
em_cobrado em_cobrado
st_fcobro st_fcobro
em_fecha_cobro em_fecha_cobro
st_resto st_resto
em_resto em_resto
rb_devolucion rb_devolucion
rb_renovacion rb_renovacion
st_notificar st_notificar
notificar notificar
st_fvto st_fvto
em_fecha_vto em_fecha_vto
dw_detalle dw_detalle
cb_2 cb_2
end type
global w_int_cobro_seglinventas w_int_cobro_seglinventas

type variables
string filtro,moneda,var_tipo


end variables

event ue_listar;//
//dw_report  = dw_listado_detalle
//dw_report.SetTransObject(SQLCA)
//dw_report.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)	
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Cancelación Cobros Asegurados"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
em_fecha_cobro.text= String(Today())
var_tipo = "D"
rb_devolucion.checked = TRUE
rb_renovacion.checked = FALSE
notificar.text= "Si"
f_activar_campo(uo_cliente.em_campo)


end event

on w_int_cobro_seglinventas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado_detalle=create dw_listado_detalle
this.st_6=create st_6
this.uo_cliente=create uo_cliente
this.cb_1=create cb_1
this.uo_1=create uo_1
this.st_1=create st_1
this.em_cobrado=create em_cobrado
this.st_fcobro=create st_fcobro
this.em_fecha_cobro=create em_fecha_cobro
this.st_resto=create st_resto
this.em_resto=create em_resto
this.rb_devolucion=create rb_devolucion
this.rb_renovacion=create rb_renovacion
this.st_notificar=create st_notificar
this.notificar=create notificar
this.st_fvto=create st_fvto
this.em_fecha_vto=create em_fecha_vto
this.dw_detalle=create dw_detalle
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado_detalle
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.em_cobrado
this.Control[iCurrent+9]=this.st_fcobro
this.Control[iCurrent+10]=this.em_fecha_cobro
this.Control[iCurrent+11]=this.st_resto
this.Control[iCurrent+12]=this.em_resto
this.Control[iCurrent+13]=this.rb_devolucion
this.Control[iCurrent+14]=this.rb_renovacion
this.Control[iCurrent+15]=this.st_notificar
this.Control[iCurrent+16]=this.notificar
this.Control[iCurrent+17]=this.st_fvto
this.Control[iCurrent+18]=this.em_fecha_vto
this.Control[iCurrent+19]=this.dw_detalle
this.Control[iCurrent+20]=this.cb_2
end on

on w_int_cobro_seglinventas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado_detalle)
destroy(this.st_6)
destroy(this.uo_cliente)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.em_cobrado)
destroy(this.st_fcobro)
destroy(this.em_fecha_cobro)
destroy(this.st_resto)
destroy(this.em_resto)
destroy(this.rb_devolucion)
destroy(this.rb_renovacion)
destroy(this.st_notificar)
destroy(this.notificar)
destroy(this.st_fvto)
destroy(this.em_fecha_vto)
destroy(this.dw_detalle)
destroy(this.cb_2)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_cobro_seglinventas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_cobro_seglinventas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_cobro_seglinventas
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_cobro_seglinventas
integer x = 2702
integer y = 4
integer width = 128
integer height = 108
integer taborder = 0
string picturename = "exit!"
end type

type dw_listado_detalle from datawindow within w_int_cobro_seglinventas
boolean visible = false
integer x = 96
integer width = 494
integer height = 92
integer taborder = 140
boolean bringtotop = true
boolean livescroll = true
end type

type st_6 from statictext within w_int_cobro_seglinventas
integer y = 144
integer width = 357
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
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_int_cobro_seglinventas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 370
integer y = 136
integer width = 1193
integer taborder = 150
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within w_int_cobro_seglinventas
event clicked pbm_bnclicked
integer x = 1573
integer y = 132
integer height = 92
integer taborder = 90
string text = "&Continuar"
end type

event clicked;call super::clicked;dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)	


end event

type uo_1 from u_manejo_datawindow within w_int_cobro_seglinventas
integer x = 2158
integer y = 92
integer taborder = 80
end type

event valores;call super::valores;dw_data = dw_detalle
end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type st_1 from statictext within w_int_cobro_seglinventas
integer x = 37
integer y = 1096
integer width = 521
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Importe Cobrado:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cobrado from u_em_campo within w_int_cobro_seglinventas
integer x = 562
integer y = 1092
integer width = 379
integer taborder = 20
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0"
end type

event modificado;call super::modificado;em_resto.text = String(Dec(f_valor_columna(dw_detalle,dw_detalle.GetRow(),"importe")) - Dec(This.text))
IF Dec(em_resto.text) <> 0 Then
	em_fecha_vto.visible  = TRUE
	em_resto.visible      = TRUE
	notificar.visible     = TRUE
	rb_devolucion.visible = TRUE
	rb_renovacion.visible = TRUE
	st_fvto.visible       = TRUE
	st_notificar.visible  = TRUE
	st_resto.visible      = TRUE
ELSE
	em_fecha_vto.visible  = FALSE
	em_resto.visible      = FALSE
	notificar.visible     = FALSE
	rb_devolucion.visible = FALSE
	rb_renovacion.visible = FALSE
	st_fvto.visible       = FALSE
	st_notificar.visible  = FALSE
	st_resto.visible      = FALSE
END IF

end event

type st_fcobro from statictext within w_int_cobro_seglinventas
integer x = 965
integer y = 1100
integer width = 389
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Cobro:"
boolean focusrectangle = false
end type

type em_fecha_cobro from u_em_campo within w_int_cobro_seglinventas
integer x = 1358
integer y = 1092
integer width = 293
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type st_resto from statictext within w_int_cobro_seglinventas
boolean visible = false
integer x = 37
integer y = 1188
integer width = 521
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Resto:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_resto from u_em_campo within w_int_cobro_seglinventas
boolean visible = false
integer x = 562
integer y = 1184
integer width = 379
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0"
end type

type rb_devolucion from radiobutton within w_int_cobro_seglinventas
boolean visible = false
integer x = 987
integer y = 1192
integer width = 407
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Devolución"
boolean lefttext = true
end type

event clicked;var_tipo = "D"
rb_devolucion.checked = TRUE
rb_renovacion.checked = FALSE
end event

type rb_renovacion from radiobutton within w_int_cobro_seglinventas
boolean visible = false
integer x = 1426
integer y = 1192
integer width = 425
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Renovación"
boolean lefttext = true
end type

event clicked;var_tipo = "R"
rb_devolucion.checked = FALSE
rb_renovacion.checked = TRUE
end event

type st_notificar from statictext within w_int_cobro_seglinventas
boolean visible = false
integer x = 37
integer y = 1292
integer width = 521
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Notificar:"
alignment alignment = right!
boolean focusrectangle = false
end type

type notificar from dropdownlistbox within w_int_cobro_seglinventas
boolean visible = false
integer x = 562
integer y = 1292
integer width = 247
integer height = 172
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type st_fvto from statictext within w_int_cobro_seglinventas
boolean visible = false
integer x = 1010
integer y = 1292
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Vto:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_vto from u_em_campo within w_int_cobro_seglinventas
boolean visible = false
integer x = 1358
integer y = 1284
integer width = 297
integer taborder = 110
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type dw_detalle from u_datawindow_consultas within w_int_cobro_seglinventas
integer x = 5
integer y = 248
integer width = 2839
integer height = 804
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_int_cobro_seglinventas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;IF GetRow() = 0 Then Return
em_cobrado.text = f_valor_columna(this,getRow(),"importe")
em_cobrado.TriggerEvent("modificado")
f_activar_campo(em_cobrado)
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param

IF row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=string(This.GetItemNumber(row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(row,"orden"))
  OpenWithParm(wi_mant_seglinventas,lstr_param) 
End if

end event

type cb_2 from u_boton within w_int_cobro_seglinventas
event clicked pbm_bnclicked
integer x = 1691
integer y = 1088
integer height = 92
integer taborder = 91
string text = "&Grabar"
end type

event clicked;call super::clicked;Dec{0}  var_orden,var_anyo,var_importe,var_impdev,var_recibo,var_cambiofra
Datetime var_fcobro,var_fdev,var_ffra,var_fvto
String   var_cliente,var_cuenta,var_moneda,var_companyia,var_declarada,var_situacion,var_forma_pago,var_fra
IF messageBox("Proceso de cancelacion cobros","Desea Cancelar este recibo",Question!,YesNo!)= 2 Then
	Return
END IF
IF var_tipo = "R" Then
	IF em_fecha_vto.text = "00-00-00" Then	
		f_mensaje("Campo Obligatorio","Introduzca el Vto")
		f_activar_campo(em_fecha_vto)
		return
	END IF
	
END IF
var_anyo  = Dec(f_valor_columna(dw_detalle,dw_detalle.GetRow(),"anyo"))
var_orden  = Dec(f_valor_columna(dw_detalle,dw_detalle.GetRow(),"orden"))
var_fcobro  = DateTime(Date(em_fecha_cobro.text))
var_importe = Dec(em_cobrado.text)
SetNull(var_fdev)
var_impdev  = 0
IF var_tipo = "D" Then
	var_fdev = DateTime(Date(em_fecha_cobro.text))
	var_impdev = Dec(em_resto.text)
END IF

  UPDATE seglinventas  
     SET fcobro  = :var_fcobro,   
         fdev    = :var_fdev,   
         impdev  = :var_impdev,   
         importe = :var_importe,
			situacion ='4'
   WHERE (seglinventas.empresa = :codigo_empresa )
	AND   (seglinventas.anyo    = :var_anyo )
	AND   (seglinventas.orden   = :var_orden );


IF Dec(em_resto.text) <> 0 Then
	        var_anyo  = Dec(f_valor_columna(dw_detalle,dw_detalle.GetRow(),"anyo"))
			  Select Max(orden) Into :var_orden From seglinventas
			  Where  seglinventas.empresa = :codigo_empresa
			  And    seglinventas.anyo    = :var_anyo;
			  IF IsNull(var_orden) Then var_orden = 0
           var_impdev= 0
           var_orden     = var_orden + 1
           var_fra       = f_valor_columna(dw_detalle,dw_detalle.GetRow(),"fra")
           var_recibo    = Dec(f_valor_columna(dw_detalle,dw_detalle.GetRow(),"recibo")  )
           var_ffra      = dw_detalle.GetItemdateTime(dw_detalle.GetRow(),"ffra")  
           var_cliente   = f_valor_columna(dw_detalle,dw_detalle.GetRow(),"cliente")  
           var_fvto      = dw_detalle.GetItemDateTime(dw_detalle.GetRow(),"fvto")  
			  var_importe   = Dec(f_valor_columna(dw_detalle,dw_detalle.GetRow(),"importe"))
           var_moneda    = f_valor_columna(dw_detalle,dw_detalle.GetRow(),"moneda")  
           var_cambiofra = Dec(f_valor_columna(dw_detalle,dw_detalle.GetRow(),"cambiofra"))  
           If notificar.text= "Si" Then
					var_declarada ="S"
			  Else
					var_declarada ="N"
			  END IF
           var_cuenta= f_valor_columna(dw_detalle,dw_detalle.GetRow(),"cuenta")  
           var_companyia= f_valor_columna(dw_detalle,dw_detalle.GetRow(),"companyia")  
           var_forma_pago= f_valor_columna(dw_detalle,dw_detalle.GetRow(),"forma_pago")  
			  IF var_tipo= "D" Then
           	var_situacion= "2"
		     ELSE
           	var_situacion= "3"
			  END IF
			  IF var_tipo = "R" Then
      	     var_fdev = DateTime(Date(em_fecha_vto.text)) 
				  var_fvto = DateTime(Date(em_fecha_vto.text))
			  END IF

           var_impdev =0
	  INSERT INTO seglinventas  
         ( empresa,anyo,orden,fra,recibo,ffra,cliente,fcobro,   
           fvto,importe,moneda,cambiofra,declarado,f_notificacion,   
           cuenta,companyia,forma_pago,situacion,fdev,impdev)  
  VALUES ( :codigo_empresa,   
           :var_anyo,   
           :var_orden,   
           :var_fra,   
           :var_recibo,   
           :var_ffra,   
           :var_cliente,   
           null,   
           :var_fvto,   
           :var_importe,   
           :var_moneda,   
           :var_cambiofra,   
           :var_declarada,   
           null,   
           :var_cuenta,   
           :var_companyia,   
           :var_forma_pago,   
           :var_situacion,   
           :var_fdev,   
           :var_impdev )  ;

END IF


COMMIT;

dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)	


end event

