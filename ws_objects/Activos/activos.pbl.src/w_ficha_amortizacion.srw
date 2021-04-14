$PBExportHeader$w_ficha_amortizacion.srw
forward
global type w_ficha_amortizacion from w_int_con_empresa
end type
type st_1 from statictext within w_ficha_amortizacion
end type
type em_elemento from u_em_campo within w_ficha_amortizacion
end type
type st_delemento from statictext within w_ficha_amortizacion
end type
type dw_1 from u_datawindow within w_ficha_amortizacion
end type
type cb_3 from u_boton within w_ficha_amortizacion
end type
type dw_listado from datawindow within w_ficha_amortizacion
end type
type dw_2 from u_datawindow within w_ficha_amortizacion
end type
type pb_1 from upb_salir within w_ficha_amortizacion
end type
type pb_2 from upb_imprimir within w_ficha_amortizacion
end type
type st_2 from statictext within w_ficha_amortizacion
end type
type em_elemento_hasta from u_em_campo within w_ficha_amortizacion
end type
type st_delemento_hasta from statictext within w_ficha_amortizacion
end type
type kk from structure within w_ficha_amortizacion
end type
end forward

type kk from structure
	string		empresa
	decimal {0}	elemento
	integer		amortizacion
	decimal {0}	ejercicio
	decimal {0}	clase_inmobilizado
	string		familia
	decimal {0}	bien
	decimal {0}	periodo
	string		tipo_amor
	decimal {0}	porcentaje_amor
	string		cuenta_activo
	string		cuenta_cargo
	string		cuenta_abono
	string		seccion
	string		centro_coste
	date		fecha_contable
	decimal {0}	asiento
	string		actualizado
	date		fecha_amor
	decimal {0}	importe_amor
	decimal {0}	importe_amorfis
	string		clase_amor
end type

global type w_ficha_amortizacion from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 3049
integer height = 2748
string title = "Ficha de Amortización"
st_1 st_1
em_elemento em_elemento
st_delemento st_delemento
dw_1 dw_1
cb_3 cb_3
dw_listado dw_listado
dw_2 dw_2
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_elemento_hasta em_elemento_hasta
st_delemento_hasta st_delemento_hasta
end type
global w_ficha_amortizacion w_ficha_amortizacion

type variables


end variables

on w_ficha_amortizacion.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_elemento=create em_elemento
this.st_delemento=create st_delemento
this.dw_1=create dw_1
this.cb_3=create cb_3
this.dw_listado=create dw_listado
this.dw_2=create dw_2
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_elemento_hasta=create em_elemento_hasta
this.st_delemento_hasta=create st_delemento_hasta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_elemento
this.Control[iCurrent+3]=this.st_delemento
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.pb_2
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.em_elemento_hasta
this.Control[iCurrent+12]=this.st_delemento_hasta
end on

on w_ficha_amortizacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.em_elemento)
destroy(this.st_delemento)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.dw_listado)
destroy(this.dw_2)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_elemento_hasta)
destroy(this.st_delemento_hasta)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Ficha de Amortización" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_ficha_amortizacion
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_ficha_amortizacion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_ficha_amortizacion
integer width = 2875
end type

type st_1 from statictext within w_ficha_amortizacion
integer x = 82
integer y = 156
integer width = 480
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Elemento desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_elemento from u_em_campo within w_ficha_amortizacion
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 567
integer y = 152
integer width = 393
integer taborder = 10
alignment alignment = right!
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' then
	f_mensaje("Aviso","El elemento no existe.")
	em_elemento.SetFocus()
	return
Else
	st_delemento.text = cadena
End If

end event

type st_delemento from statictext within w_ficha_amortizacion
integer x = 969
integer y = 156
integer width = 1129
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_1 from u_datawindow within w_ficha_amortizacion
integer x = 82
integer y = 344
integer width = 2834
integer height = 532
integer taborder = 0
string dataobject = "dw_ficha_amortizacion_total"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_3 from u_boton within w_ficha_amortizacion
event clicked pbm_bnclicked
integer x = 2130
integer y = 196
integer width = 274
integer height = 88
integer taborder = 60
string text = "&Consulta"
end type

event clicked;call super::clicked;IF isnull(em_elemento.text) or trim(em_elemento.text)='' THEN
	f_mensaje("Error","Introduzca el elemento.")
	em_elemento.SetFocus()
	Return
END IF

dw_1.Retrieve(codigo_empresa,dec(em_elemento.text))
dw_2.Retrieve(codigo_empresa,dec(em_elemento.text))
end event

type dw_listado from datawindow within w_ficha_amortizacion
boolean visible = false
integer x = 128
integer y = 376
integer width = 494
integer height = 360
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_ficha_amortizacion_total"
boolean livescroll = true
end type

type dw_2 from u_datawindow within w_ficha_amortizacion
integer x = 91
integer y = 896
integer width = 2825
integer height = 1708
integer taborder = 0
string dataobject = "dw_ficha_amortizaciones"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_salir within w_ficha_amortizacion
integer x = 2583
integer y = 196
integer taborder = 40
boolean bringtotop = true
end type

type pb_2 from upb_imprimir within w_ficha_amortizacion
integer x = 2418
integer y = 196
integer width = 160
integer height = 132
integer taborder = 30
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;IF isnull(em_elemento.text) or trim(em_elemento.text)='' THEN
	f_mensaje("Error","Introduzca el elemento desde.")
	em_elemento.SetFocus()
	Return
END IF
IF isnull(em_elemento_hasta.text) or trim(em_elemento_hasta.text)='' THEN
	f_mensaje("Error","Introduzca el elemento hasta.")
	em_elemento_hasta.SetFocus()
	Return
END IF
dw_listado.Retrieve(codigo_empresa,dec(em_elemento.text),dec(em_elemento_hasta.text))
f_imprimir_datawindow(dw_listado)
end event

type st_2 from statictext within w_ficha_amortizacion
integer x = 82
integer y = 248
integer width = 480
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Elemento hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_elemento_hasta from u_em_campo within w_ficha_amortizacion
integer x = 567
integer y = 244
integer width = 393
integer taborder = 20
alignment alignment = right!
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' then
	f_mensaje("Aviso","El elemento no existe.")
	em_elemento_hasta.SetFocus()
	return
Else
	st_delemento_hasta.text = cadena
End If

end event

type st_delemento_hasta from statictext within w_ficha_amortizacion
integer x = 969
integer y = 248
integer width = 1129
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

