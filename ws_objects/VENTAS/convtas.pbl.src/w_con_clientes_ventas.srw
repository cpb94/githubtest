$PBExportHeader$w_con_clientes_ventas.srw
forward
global type w_con_clientes_ventas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_clientes_ventas
end type
type st_1 from statictext within w_con_clientes_ventas
end type
type uo_pais from u_em_campo_2 within w_con_clientes_ventas
end type
type st_2 from statictext within w_con_clientes_ventas
end type
type uo_provincia from u_em_campo_2 within w_con_clientes_ventas
end type
type uo_manejo from u_manejo_datawindow within w_con_clientes_ventas
end type
type dw_listado4 from datawindow within w_con_clientes_ventas
end type
type pb_imprimir from upb_imprimir within w_con_clientes_ventas
end type
type dw_distribuidores from datawindow within w_con_clientes_ventas
end type
type rb_1 from radiobutton within w_con_clientes_ventas
end type
type rb_2 from radiobutton within w_con_clientes_ventas
end type
type rb_3 from radiobutton within w_con_clientes_ventas
end type
type cb_1 from commandbutton within w_con_clientes_ventas
end type
type st_3 from statictext within w_con_clientes_ventas
end type
type sle_tipodoc from singlelineedit within w_con_clientes_ventas
end type
type uo_banco from u_em_campo_2 within w_con_clientes_ventas
end type
type st_4 from statictext within w_con_clientes_ventas
end type
type uo_pago from u_em_campo_2 within w_con_clientes_ventas
end type
type st_7 from statictext within w_con_clientes_ventas
end type
end forward

global type w_con_clientes_ventas from w_int_con_empresa
integer x = 46
integer y = 48
integer width = 5353
integer height = 3056
pb_1 pb_1
st_1 st_1
uo_pais uo_pais
st_2 st_2
uo_provincia uo_provincia
uo_manejo uo_manejo
dw_listado4 dw_listado4
pb_imprimir pb_imprimir
dw_distribuidores dw_distribuidores
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
cb_1 cb_1
st_3 st_3
sle_tipodoc sle_tipodoc
uo_banco uo_banco
st_4 st_4
uo_pago uo_pago
st_7 st_7
end type
global w_con_clientes_ventas w_con_clientes_ventas

type variables
string filtro,tipocon
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Listado de clientes financiero"
This.title=istr_parametros.s_titulo_ventana

dw_distribuidores.SetTransObject(SQLCA)
dw_distribuidores.SetRowFocusIndicator(Hand!)
uo_pais.em_codigo.text = "11"

uo_pais.em_campo.text= f_nombre_pais(uo_pais.em_codigo.text)
uo_pais.em_campo.SetFocus()
dw_listado4.SetTransObject(SQLCA)

tipocon = 'T' // opcion de todos los clientes
end event

event ue_listar;filtro = ""

filtro = " genter_activo = '" + tipocon + "' "

if tipocon = 'T' then filtro = ""

if Trim(uo_provincia.em_codigo.text)<>"" then 
	if trim(filtro)="" then 
    	filtro = " provincia = '" + uo_provincia.em_codigo.text + "'"
	else
		filtro = filtro +"and "+" provincia = '" + uo_provincia.em_codigo.text + "'" 
   end if
End if

IF TRIM(filtro)<>"" THEN
 dw_listado4.SetFilter(filtro)
 dw_listado4.Filter()
END IF

dw_listado4.Retrieve(codigo_empresa,uo_pais.em_codigo.text)
dw_report=dw_listado4
CALL Super::ue_listar
end event

on w_con_clientes_ventas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.uo_pais=create uo_pais
this.st_2=create st_2
this.uo_provincia=create uo_provincia
this.uo_manejo=create uo_manejo
this.dw_listado4=create dw_listado4
this.pb_imprimir=create pb_imprimir
this.dw_distribuidores=create dw_distribuidores
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.cb_1=create cb_1
this.st_3=create st_3
this.sle_tipodoc=create sle_tipodoc
this.uo_banco=create uo_banco
this.st_4=create st_4
this.uo_pago=create uo_pago
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_pais
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.uo_provincia
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.dw_listado4
this.Control[iCurrent+8]=this.pb_imprimir
this.Control[iCurrent+9]=this.dw_distribuidores
this.Control[iCurrent+10]=this.rb_1
this.Control[iCurrent+11]=this.rb_2
this.Control[iCurrent+12]=this.rb_3
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.sle_tipodoc
this.Control[iCurrent+16]=this.uo_banco
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.uo_pago
this.Control[iCurrent+19]=this.st_7
end on

on w_con_clientes_ventas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.uo_pais)
destroy(this.st_2)
destroy(this.uo_provincia)
destroy(this.uo_manejo)
destroy(this.dw_listado4)
destroy(this.pb_imprimir)
destroy(this.dw_distribuidores)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.sle_tipodoc)
destroy(this.uo_banco)
destroy(this.st_4)
destroy(this.uo_pago)
destroy(this.st_7)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_distribuidores)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_distribuidores)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_clientes_ventas
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_clientes_ventas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_clientes_ventas
integer y = 8
integer width = 5024
end type

type pb_1 from upb_salir within w_con_clientes_ventas
integer x = 5093
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_1 from statictext within w_con_clientes_ventas
integer x = 32
integer y = 108
integer width = 617
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "País"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_pais from u_em_campo_2 within w_con_clientes_ventas
integer x = 32
integer y = 188
integer width = 617
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on modificado;call u_em_campo_2::modificado;uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)
IF Trim(uo_pais.em_campo.text)="" THEN 
 IF Trim(uo_pais.em_codigo.text)<>"" Then uo_pais.em_campo.SetFocus()
 uo_pais.em_campo.text=""
 uo_pais.em_codigo.text=""
END IF


end on

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de paises"
ue_datawindow = "dw_ayuda_paises"
ue_filtro     = ""
valor_empresa = FALSE

end on

on uo_pais.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_con_clientes_ventas
integer x = 658
integer y = 108
integer width = 654
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Provinicia"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_provincia from u_em_campo_2 within w_con_clientes_ventas
integer x = 658
integer y = 188
integer width = 654
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_provincia.em_campo.text=f_nombre_provincia(uo_pais.em_codigo.text,uo_provincia.em_codigo.text)
IF Trim(uo_provincia.em_campo.text)="" THEN 
 IF Trim(uo_provincia.em_codigo.text)<>"" Then uo_provincia.em_campo.SetFocus()
 uo_provincia.em_campo.text=""
 uo_provincia.em_codigo.text=""
END IF


end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de provincias"
ue_datawindow = "dw_ayuda_provincias"
ue_filtro      = "pais = '" + uo_pais.em_codigo.text + "' "
valor_empresa = FALSE

end on

on uo_provincia.destroy
call u_em_campo_2::destroy
end on

type uo_manejo from u_manejo_datawindow within w_con_clientes_ventas
integer x = 4603
integer y = 124
integer width = 613
end type

event valores;call super::valores;dw_data=dw_distribuidores
f_activar_campo(uo_provincia.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado4 from datawindow within w_con_clientes_ventas
integer y = 292
integer width = 5211
integer height = 2604
boolean bringtotop = true
string dataobject = "report_con_clientes_ventas"
boolean livescroll = true
end type

event clicked;if dwo.name = "t_banco" then
	this.setsort("carbancos_nombre desc")
end if

if dwo.name = "t_codigo" then
	this.setsort("integer(codigo) ASC")
end if

if dwo.name = "t_razon" then
	this.setsort("razon ASC")
end if

this.sort()
end event

type pb_imprimir from upb_imprimir within w_con_clientes_ventas
integer x = 5079
integer y = 176
integer taborder = 0
boolean bringtotop = true
string picturename = "PRINT!"
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
end event

type dw_distribuidores from datawindow within w_con_clientes_ventas
event doubleclicked pbm_dwnlbuttondblclk
integer y = 292
integer width = 3369
integer height = 2560
string dataobject = "dw_con_clientes_ventas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clientes2,lstr_param) 


end event

type rb_1 from radiobutton within w_con_clientes_ventas
boolean visible = false
integer x = 3666
integer y = 112
integer width = 247
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
boolean checked = true
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

//IF tipocon <> 'T' THEN dw_distribuidores.Reset()

tipocon = 'T'

cb_1.TriggerEvent(clicked!)
f_activar_campo(uo_provincia.em_campo)		// Despues de Activar pasar al campo clave.
end event

type rb_2 from radiobutton within w_con_clientes_ventas
boolean visible = false
integer x = 3666
integer y = 160
integer width = 274
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Activos"
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

//IF tipocon <> 'S' THEN dw_distribuidores.Reset()

tipocon = 'S'

cb_1.TriggerEvent(clicked!)
f_activar_campo(uo_provincia.em_campo)		// Despues de Activar pasar al campo clave.
end event

type rb_3 from radiobutton within w_con_clientes_ventas
boolean visible = false
integer x = 3666
integer y = 212
integer width = 347
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Inactivos"
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

//IF tipocon <> 'N' THEN dw_distribuidores.Reset()

tipocon = 'N'

cb_1.TriggerEvent(clicked!)
f_activar_campo(uo_provincia.em_campo)		// Despues de Activar pasar al campo clave.
end event

type cb_1 from commandbutton within w_con_clientes_ventas
integer x = 4101
integer y = 168
integer width = 453
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;string pais, provincia, tipodoc, banco, pago

filtro = ""
dw_listado4.Setfilter(filtro)

filtro = "activo = '" + tipocon + "'"

if tipocon = 'T' then filtro = ""

if uo_pais.em_codigo.text <> '' and not isnull (uo_pais.em_codigo.text) then
	pais =uo_pais.em_codigo.text
else 
	pais = '%'
end if

if Trim(uo_provincia.em_codigo.text)<>"" then 
    	provincia = " and  provincia = '"+  uo_provincia.em_codigo.text+"' "
End if

if sle_tipodoc.text <> '' then
	tipodoc =  " and  cartipodoc_resumido like '%"+sle_tipodoc.text+"%' "
end if

if sle_tipodoc.text <> '' then
	tipodoc =  " and  cartipodoc_resumido like '%"+sle_tipodoc.text+"%' "
end if

if uo_banco.em_codigo.text <> '' then
	banco =  " and  venclientes_banco_de_cobro = '"+uo_banco.em_codigo.text+"' "
else
	banco = ''
end if

if uo_pago.em_codigo.text <> '' then
	pago =  " and  venclientes_cod_pago = '"+uo_pago.em_codigo.text+"' "
else
	pago = ''
end if


filtro = '1 = 1 ' + provincia + tipodoc + banco + pago

IF TRIM(filtro)<>"" THEN
 dw_listado4.SetFilter(filtro)
 dw_listado4.Filter()
END IF



dw_listado4.Retrieve(codigo_empresa, pais)
f_activar_campo(uo_provincia.em_campo)


end event

type st_3 from statictext within w_con_clientes_ventas
integer x = 1339
integer y = 112
integer width = 654
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Tipo Documento"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_tipodoc from singlelineedit within w_con_clientes_ventas
integer x = 1321
integer y = 188
integer width = 832
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type uo_banco from u_em_campo_2 within w_con_clientes_ventas
integer x = 2162
integer y = 192
integer width = 617
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_banco.em_campo.text = f_nombre_banco(codigo_empresa, uo_banco.em_codigo.text)
IF Trim(uo_banco.em_campo.text)="" THEN 
 IF Trim(uo_banco.em_codigo.text)<>"" Then uo_banco.em_campo.SetFocus()
 uo_banco.em_campo.text=""
 uo_banco.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE BANCO"
ue_datawindow ="dw_ayuda_carbancos"
ue_filtro =""

valor_empresa = TRUE
end event

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_con_clientes_ventas
integer x = 2203
integer y = 116
integer width = 617
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Banco"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_pago from u_em_campo_2 within w_con_clientes_ventas
integer x = 2789
integer y = 192
integer width = 617
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_pago.em_campo.text = f_nombre_carforpag(codigo_empresa, uo_pago.em_codigo.text)
IF Trim(uo_pago.em_campo.text)="" THEN 
 IF Trim(uo_pago.em_codigo.text)<>"" Then uo_pago.em_campo.SetFocus()
 uo_pago.em_campo.text=""
 uo_pago.em_codigo.text=""
END IF



uo_banco.em_campo.text = f_nombre_banco(codigo_empresa, uo_banco.em_codigo.text)
IF Trim(uo_banco.em_campo.text)="" THEN 
 IF Trim(uo_banco.em_codigo.text)<>"" Then uo_banco.em_campo.SetFocus()
 uo_banco.em_campo.text=""
 uo_banco.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE BANCO"
ue_datawindow ="dw_ayuda_carforpag"
ue_filtro =""

valor_empresa = TRUE
end event

on uo_pago.destroy
call u_em_campo_2::destroy
end on

type st_7 from statictext within w_con_clientes_ventas
integer x = 2793
integer y = 116
integer width = 617
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "F. pago"
alignment alignment = center!
boolean focusrectangle = false
end type

