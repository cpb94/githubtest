$PBExportHeader$w_con_cliseg_provincia.srw
forward
global type w_con_cliseg_provincia from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_cliseg_provincia
end type
type st_1 from statictext within w_con_cliseg_provincia
end type
type uo_pais from u_em_campo_2 within w_con_cliseg_provincia
end type
type st_2 from statictext within w_con_cliseg_provincia
end type
type uo_provincia from u_em_campo_2 within w_con_cliseg_provincia
end type
type uo_manejo from u_manejo_datawindow within w_con_cliseg_provincia
end type
type dw_listado4 from datawindow within w_con_cliseg_provincia
end type
type pb_imprimir from upb_imprimir within w_con_cliseg_provincia
end type
type dw_distribuidores from datawindow within w_con_cliseg_provincia
end type
type cb_1 from commandbutton within w_con_cliseg_provincia
end type
type uo_companya from u_em_campo_2 within w_con_cliseg_provincia
end type
type st_3 from statictext within w_con_cliseg_provincia
end type
end forward

global type w_con_cliseg_provincia from w_int_con_empresa
integer width = 2953
integer height = 1692
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
uo_companya uo_companya
st_3 st_3
end type
global w_con_cliseg_provincia w_con_cliseg_provincia

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Clientes por pais provincia"
This.title=istr_parametros.s_titulo_ventana

dw_distribuidores.SetTransObject(SQLCA)
dw_distribuidores.SetRowFocusIndicator(Hand!)
uo_pais.em_codigo.text = "11"

uo_pais.em_campo.text= f_nombre_pais(uo_pais.em_codigo.text)
uo_companya.em_campo.SetFocus()
dw_listado4.SetTransObject(SQLCA)


end event

event ue_listar;dw_listado4.Retrieve(codigo_empresa,uo_pais.em_codigo.text,uo_provincia.em_codigo.text,uo_companya.em_codigo.text)
dw_report=dw_listado4
CALL Super::ue_listar
end event

on w_con_cliseg_provincia.create
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
this.uo_companya=create uo_companya
this.st_3=create st_3
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
this.Control[iCurrent+11]=this.uo_companya
this.Control[iCurrent+12]=this.st_3
end on

on w_con_cliseg_provincia.destroy
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
destroy(this.uo_companya)
destroy(this.st_3)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_cliseg_provincia
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_cliseg_provincia
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_cliseg_provincia
integer y = 8
integer width = 2555
end type

type pb_1 from upb_salir within w_con_cliseg_provincia
integer x = 2688
integer y = 8
integer width = 114
integer height = 108
integer taborder = 0
string picturename = "exit!"
end type

type st_1 from statictext within w_con_cliseg_provincia
integer x = 914
integer y = 144
integer width = 256
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pais"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_pais from u_em_campo_2 within w_con_cliseg_provincia
integer x = 1189
integer y = 132
integer width = 654
integer taborder = 30
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

type st_2 from statictext within w_con_cliseg_provincia
integer x = 864
integer y = 224
integer width = 306
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Provincia"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_provincia from u_em_campo_2 within w_con_cliseg_provincia
integer x = 1189
integer y = 224
integer width = 654
integer taborder = 40
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

type uo_manejo from u_manejo_datawindow within w_con_cliseg_provincia
integer x = 2240
integer y = 164
integer width = 613
end type

event valores;call super::valores;dw_data=dw_distribuidores
f_activar_campo(uo_provincia.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado4 from datawindow within w_con_cliseg_provincia
boolean visible = false
integer x = 27
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_cliseg_provincias"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_cliseg_provincia
integer x = 2720
integer y = 212
integer taborder = 0
boolean bringtotop = true
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
end event

type dw_distribuidores from datawindow within w_con_cliseg_provincia
event doubleclicked pbm_dwnlbuttondblclk
integer x = 32
integer y = 324
integer width = 2825
integer height = 1132
string dataobject = "dw_con_cliseg_provincias"
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

type cb_1 from commandbutton within w_con_cliseg_provincia
integer x = 1856
integer y = 224
integer width = 357
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;dw_distribuidores.Retrieve(codigo_empresa,uo_pais.em_codigo.text,uo_provincia.em_codigo.text,uo_companya.em_codigo.text)
f_activar_campo(uo_provincia.em_campo)
end event

type uo_companya from u_em_campo_2 within w_con_cliseg_provincia
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 41
integer y = 216
integer width = 814
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_companya.em_campo.text=f_nombre_segcompanyia(codigo_empresa,uo_companya.em_codigo.text)
IF Trim(uo_companya.em_campo.text)="" THEN 
 IF Trim(uo_companya.em_codigo.text)<>"" Then uo_companya.em_campo.SetFocus()
 uo_companya.em_campo.text=""
 uo_companya.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion Compañias"
ue_datawindow = "dw_ayuda_segcompanyias"
ue_filtro     = ""
valor_empresa = TRUE

end event

on uo_companya.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within w_con_cliseg_provincia
integer x = 41
integer y = 124
integer width = 827
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Compañia de Seguros"
alignment alignment = center!
boolean focusrectangle = false
end type

