$PBExportHeader$w_con_clientes_agente.srw
forward
global type w_con_clientes_agente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_clientes_agente
end type
type st_agente from statictext within w_con_clientes_agente
end type
type uo_agente from u_em_campo_2 within w_con_clientes_agente
end type
type uo_manejo from u_manejo_datawindow within w_con_clientes_agente
end type
type dw_listado_agentes from datawindow within w_con_clientes_agente
end type
type dw_agentes from datawindow within w_con_clientes_agente
end type
type pb_imprimir from upb_imprimir within w_con_clientes_agente
end type
type rb_1 from radiobutton within w_con_clientes_agente
end type
type rb_2 from radiobutton within w_con_clientes_agente
end type
type rb_3 from radiobutton within w_con_clientes_agente
end type
type cb_1 from commandbutton within w_con_clientes_agente
end type
end forward

global type w_con_clientes_agente from w_int_con_empresa
integer width = 2949
integer height = 2000
pb_1 pb_1
st_agente st_agente
uo_agente uo_agente
uo_manejo uo_manejo
dw_listado_agentes dw_listado_agentes
dw_agentes dw_agentes
pb_imprimir pb_imprimir
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
cb_1 cb_1
end type
global w_con_clientes_agente w_con_clientes_agente

type variables
string filtro,tipocon
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Agentes"
This.title=istr_parametros.s_titulo_ventana

dw_agentes.SetTransObject(SQLCA)
dw_agentes.SetRowFocusIndicator(Hand!)
uo_agente.em_campo.text= f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)
dw_listado_agentes.SetTransObject(SQLCA)

tipocon = "T"
f_activar_campo(uo_agente.em_campo)

end event

event ue_listar;string activo,activo1,texto

CHOOSE CASE tipocon
	CASE "T"
		  activo  = "S"
		  activo1 = "N"
		  texto   = "Todos"
	case "S"
		  activo  = "S"
		  activo1 = "S"
		  texto   = "Solo activos"
	case "N"
		  activo  = "N"
		  activo1 = "N"
		  texto   = "Solo inactivos"
END CHOOSE

dw_listado_agentes.Retrieve(codigo_empresa,uo_agente.em_codigo.text,activo,activo1,texto)
dw_report=dw_listado_agentes
CALL Super::ue_listar
end event

on w_con_clientes_agente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_agente=create st_agente
this.uo_agente=create uo_agente
this.uo_manejo=create uo_manejo
this.dw_listado_agentes=create dw_listado_agentes
this.dw_agentes=create dw_agentes
this.pb_imprimir=create pb_imprimir
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_agente
this.Control[iCurrent+3]=this.uo_agente
this.Control[iCurrent+4]=this.uo_manejo
this.Control[iCurrent+5]=this.dw_listado_agentes
this.Control[iCurrent+6]=this.dw_agentes
this.Control[iCurrent+7]=this.pb_imprimir
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.rb_2
this.Control[iCurrent+10]=this.rb_3
this.Control[iCurrent+11]=this.cb_1
end on

on w_con_clientes_agente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_agente)
destroy(this.uo_agente)
destroy(this.uo_manejo)
destroy(this.dw_listado_agentes)
destroy(this.dw_agentes)
destroy(this.pb_imprimir)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.cb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_agentes)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_agentes)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_clientes_agente
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_clientes_agente
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_agente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_clientes_agente
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_clientes_agente
integer x = 2729
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_agente from statictext within w_con_clientes_agente
integer x = 14
integer y = 168
integer width = 238
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Agente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_agente from u_em_campo_2 within w_con_clientes_agente
integer x = 283
integer y = 160
integer width = 1093
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)
IF Trim(uo_agente.em_campo.text)="" THEN 
 IF Trim(uo_agente.em_codigo.text)<>"" Then uo_agente.em_campo.SetFocus()
 uo_agente.em_campo.text=""
 uo_agente.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Agentes"
ue_datawindow = "dw_ayuda_venagentes"
ue_filtro     = ""


end event

on uo_agente.destroy
call u_em_campo_2::destroy
end on

type uo_manejo from u_manejo_datawindow within w_con_clientes_agente
integer x = 2254
integer y = 132
integer width = 613
end type

event valores;call super::valores;dw_data=dw_agentes
f_activar_campo(uo_agente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_agentes from datawindow within w_con_clientes_agente
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_clientes_agente"
boolean livescroll = true
end type

type dw_agentes from datawindow within w_con_clientes_agente
integer y = 284
integer width = 2857
integer height = 1504
string dataobject = "dw_con_clientes_agente"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[1]="wi_con_clientes_agente"
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clientes2,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_clientes_agente
integer x = 2734
integer y = 180
integer taborder = 0
boolean bringtotop = true
string picturename = "print!"
end type

event clicked;call super::clicked;if trim(uo_agente.em_campo.text)="" then
	f_mensaje("Faltan datos","Introduzca el agente")
	f_activar_campo(uo_agente.em_campo)
	Return
End if
PArent.triggerevent("ue_listar")
f_activar_campo(uo_agente.em_campo)
end event

type rb_1 from radiobutton within w_con_clientes_agente
event clicked pbm_bnclicked
integer x = 1769
integer y = 120
integer width = 247
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
boolean checked = true
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

IF tipocon <> 'T' THEN dw_agentes.Reset()

tipocon = 'T'

cb_1.TriggerEvent(clicked!)
f_activar_campo(uo_agente.em_campo)		// Despues de Activar pasar al campo clave.
end event

type rb_2 from radiobutton within w_con_clientes_agente
event clicked pbm_bnclicked
integer x = 1769
integer y = 168
integer width = 274
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Activos"
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

IF tipocon <> 'S' THEN dw_agentes.Reset()

tipocon = 'S'

cb_1.TriggerEvent(clicked!)
f_activar_campo(uo_agente.em_campo)		// Despues de Activar pasar al campo clave.
end event

type rb_3 from radiobutton within w_con_clientes_agente
event clicked pbm_bnclicked
integer x = 1769
integer y = 220
integer width = 347
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Inactivos"
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

IF tipocon <> 'N' THEN dw_agentes.Reset()

tipocon = 'N'

cb_1.TriggerEvent(clicked!)
f_activar_campo(uo_agente.em_campo)		// Despues de Activar pasar al campo clave.
end event

type cb_1 from commandbutton within w_con_clientes_agente
integer x = 1385
integer y = 160
integer width = 347
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;if trim(uo_agente.em_campo.text)="" then
	f_mensaje("Faltan datos","Introduzca el agente")
	f_activar_campo(uo_agente.em_campo)
	Return
End if
string activo,activo1

CHOOSE CASE tipocon
	CASE "T"
		  activo  = "S"
		  activo1 = "N"
	case "S"
		  activo  = "S"
		  activo1 = "S"
	case "N"
		  activo  = "N"
		  activo1 = "N"
END CHOOSE



dw_agentes.Retrieve(codigo_empresa,uo_agente.em_codigo.text,activo,activo1)
end event

