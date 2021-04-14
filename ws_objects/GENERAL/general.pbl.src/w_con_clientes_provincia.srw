$PBExportHeader$w_con_clientes_provincia.srw
forward
global type w_con_clientes_provincia from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_clientes_provincia
end type
type st_1 from statictext within w_con_clientes_provincia
end type
type uo_pais from u_em_campo_2 within w_con_clientes_provincia
end type
type st_2 from statictext within w_con_clientes_provincia
end type
type uo_provincia from u_em_campo_2 within w_con_clientes_provincia
end type
type uo_manejo from u_manejo_datawindow within w_con_clientes_provincia
end type
type dw_listado4 from datawindow within w_con_clientes_provincia
end type
type pb_imprimir from upb_imprimir within w_con_clientes_provincia
end type
type dw_distribuidores from datawindow within w_con_clientes_provincia
end type
end forward

global type w_con_clientes_provincia from w_int_con_empresa
integer width = 2921
integer height = 2164
pb_1 pb_1
st_1 st_1
uo_pais uo_pais
st_2 st_2
uo_provincia uo_provincia
uo_manejo uo_manejo
dw_listado4 dw_listado4
pb_imprimir pb_imprimir
dw_distribuidores dw_distribuidores
end type
global w_con_clientes_provincia w_con_clientes_provincia

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Clientes por Provincia"
This.title=istr_parametros.s_titulo_ventana

dw_distribuidores.SetTransObject(SQLCA)
dw_distribuidores.SetRowFocusIndicator(Hand!)
uo_pais.em_codigo.text = "11"
uo_pais.em_campo.text= f_nombre_pais(uo_pais.em_codigo.text)
uo_pais.em_campo.SetFocus()
dw_listado4.SetTransObject(SQLCA)
end event

event ue_listar;dw_listado4.Retrieve(codigo_empresa,uo_pais.em_codigo.text,uo_provincia.em_codigo.text,"C")
dw_report=dw_listado4
CALL Super::ue_listar
end event

on w_con_clientes_provincia.create
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
end on

on w_con_clientes_provincia.destroy
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
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_distribuidores)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_distribuidores)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_clientes_provincia
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_clientes_provincia
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_clientes_provincia
integer y = 8
integer width = 1893
end type

type pb_1 from upb_salir within w_con_clientes_provincia
integer x = 2706
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_1 from statictext within w_con_clientes_provincia
integer x = 41
integer y = 164
integer width = 151
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pais"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_pais from u_em_campo_2 within w_con_clientes_provincia
integer x = 210
integer y = 156
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

type st_2 from statictext within w_con_clientes_provincia
integer x = 887
integer y = 164
integer width = 288
integer height = 72
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

type uo_provincia from u_em_campo_2 within w_con_clientes_provincia
integer x = 1184
integer y = 156
integer width = 654
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on modificado;call u_em_campo_2::modificado;uo_provincia.em_campo.text=f_nombre_provincia(uo_pais.em_codigo.text,uo_provincia.em_codigo.text)
IF Trim(uo_provincia.em_campo.text)="" THEN 
 IF Trim(uo_provincia.em_codigo.text)<>"" Then uo_provincia.em_campo.SetFocus()
 uo_provincia.em_campo.text=""
 uo_provincia.em_codigo.text=""
END IF
dw_distribuidores.Retrieve(codigo_empresa,uo_pais.em_codigo.text,uo_provincia.em_codigo.text)

end on

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de provincias"
ue_datawindow = "dw_ayuda_provincias"
ue_filtro      = "pais = '" + uo_pais.em_codigo.text + "' "
valor_empresa = FALSE

end on

on uo_provincia.destroy
call u_em_campo_2::destroy
end on

type uo_manejo from u_manejo_datawindow within w_con_clientes_provincia
integer x = 2226
integer y = 132
integer width = 613
end type

event valores;call super::valores;dw_data=dw_distribuidores
f_activar_campo(uo_provincia.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado4 from datawindow within w_con_clientes_provincia
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_clientes_provincia"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_clientes_provincia
integer x = 2702
integer y = 176
integer taborder = 0
boolean bringtotop = true
string picturename = "print!"
end type

event clicked;call super::clicked;

Parent.triggerevent("ue_listar")
end event

type dw_distribuidores from datawindow within w_con_clientes_provincia
event doubleclicked pbm_dwnlbuttondblclk
integer y = 280
integer width = 2825
integer height = 1656
string dataobject = "dw_con_clientes_provincias1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[2]="C"
lstr_param.s_argumentos[3]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clipro,lstr_param) 


end event

