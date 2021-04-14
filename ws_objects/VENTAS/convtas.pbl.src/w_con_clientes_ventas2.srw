$PBExportHeader$w_con_clientes_ventas2.srw
forward
global type w_con_clientes_ventas2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_clientes_ventas2
end type
type st_1 from statictext within w_con_clientes_ventas2
end type
type uo_pais from u_em_campo_2 within w_con_clientes_ventas2
end type
type st_2 from statictext within w_con_clientes_ventas2
end type
type uo_provincia from u_em_campo_2 within w_con_clientes_ventas2
end type
type uo_manejo from u_manejo_datawindow within w_con_clientes_ventas2
end type
type dw_listado4 from datawindow within w_con_clientes_ventas2
end type
type pb_imprimir from upb_imprimir within w_con_clientes_ventas2
end type
type dw_distribuidores from datawindow within w_con_clientes_ventas2
end type
type cb_1 from commandbutton within w_con_clientes_ventas2
end type
type st_3 from statictext within w_con_clientes_ventas2
end type
type st_4 from statictext within w_con_clientes_ventas2
end type
type uo_familia from u_em_campo_2 within w_con_clientes_ventas2
end type
end forward

global type w_con_clientes_ventas2 from w_int_con_empresa
integer x = 14
integer y = 32
integer width = 4096
integer height = 3092
pb_1 pb_1
st_1 st_1
uo_pais uo_pais
st_2 st_2
uo_provincia uo_provincia
uo_manejo uo_manejo
dw_listado4 dw_listado4
pb_imprimir pb_imprimir
dw_distribuidores dw_distribuidores
cb_1 cb_1
st_3 st_3
st_4 st_4
uo_familia uo_familia
end type
global w_con_clientes_ventas2 w_con_clientes_ventas2

type variables
string filtro,tipocon
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Listado comercial de clientes"
This.title=istr_parametros.s_titulo_ventana

dw_distribuidores.SetTransObject(SQLCA)
dw_distribuidores.SetRowFocusIndicator(Hand!)
//uo_pais.em_codigo.text = "11"

uo_pais.em_campo.text= f_nombre_pais(uo_pais.em_codigo.text)
uo_pais.em_campo.SetFocus()
dw_listado4.SetTransObject(SQLCA)
end event

event ue_listar;string provinc, pais, familia

if uo_pais.em_codigo.text = "" then
	pais = "%"
else
	pais = uo_pais.em_codigo.text
end if

if uo_provincia.em_codigo.text = "" then
	provinc = "%"
else
	provinc = uo_provincia.em_codigo.text
end if

if uo_familia.em_codigo.text = "" then
	familia = "%"
else
	familia = uo_familia.em_codigo.text
end if

dw_listado4.Retrieve(codigo_empresa,pais,provinc,familia)
dw_report=dw_listado4
CALL Super::ue_listar
end event

on w_con_clientes_ventas2.create
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
this.cb_1=create cb_1
this.st_3=create st_3
this.st_4=create st_4
this.uo_familia=create uo_familia
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
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.uo_familia
end on

on w_con_clientes_ventas2.destroy
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
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.uo_familia)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_clientes_ventas2
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_clientes_ventas2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_clientes_ventas2
integer y = 8
integer width = 1893
end type

type pb_1 from upb_salir within w_con_clientes_ventas2
integer x = 3337
integer y = 24
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "EXIT!"
end type

type st_1 from statictext within w_con_clientes_ventas2
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

type uo_pais from u_em_campo_2 within w_con_clientes_ventas2
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

type st_2 from statictext within w_con_clientes_ventas2
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
string text = "Provincia"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_provincia from u_em_campo_2 within w_con_clientes_ventas2
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

type uo_manejo from u_manejo_datawindow within w_con_clientes_ventas2
integer x = 2021
integer y = 4
integer width = 613
end type

event valores;call super::valores;dw_data=dw_distribuidores
f_activar_campo(uo_provincia.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado4 from datawindow within w_con_clientes_ventas2
boolean visible = false
integer x = 37
integer y = 4
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_clientes_ventas2"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_clientes_ventas2
integer x = 3333
integer y = 180
integer taborder = 0
boolean bringtotop = true
string picturename = "PRINT!"
end type

event clicked;Parent.triggerevent("ue_listar")
end event

type dw_distribuidores from datawindow within w_con_clientes_ventas2
event doubleclicked pbm_dwnlbuttondblclk
integer x = 5
integer y = 380
integer width = 4009
integer height = 2548
string dataobject = "dw_con_clientes_ventas2"
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

type cb_1 from commandbutton within w_con_clientes_ventas2
integer x = 2866
integer y = 188
integer width = 453
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;String provinc, pais, familia

if uo_pais.em_codigo.text = "" then
	pais = "%"
else
	pais = uo_pais.em_codigo.text
end if

if uo_provincia.em_codigo.text = "" then
	provinc = "%"
else
	provinc = uo_provincia.em_codigo.text
end if

if uo_familia.em_codigo.text = "" then
	familia = "%"
else
	familia = uo_familia.em_codigo.text
end if

dw_distribuidores.Retrieve(codigo_empresa,pais,provinc, familia)
if dw_distribuidores.rowcount() = 0 then
	messagebox("Atención","No hay datos")
end if
f_activar_campo(uo_provincia.em_campo)
end event

type st_3 from statictext within w_con_clientes_ventas2
integer x = 23
integer y = 300
integer width = 2647
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "* Los campos no son obligatorios. Deje los campos vacíos para obtener el listado completo"
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_clientes_ventas2
integer x = 1298
integer y = 108
integer width = 626
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Familia Cliente"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_familia from u_em_campo_2 within w_con_clientes_ventas2
event destroy ( )
integer x = 1317
integer y = 188
integer width = 599
integer taborder = 90
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= descripcion
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

