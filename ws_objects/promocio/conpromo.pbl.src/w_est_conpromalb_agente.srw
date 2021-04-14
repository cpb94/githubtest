$PBExportHeader$w_est_conpromalb_agente.srw
forward
global type w_est_conpromalb_agente from w_int_con_empresa
end type
type uo_conpromalb2 from u_em_campo_2 within w_est_conpromalb_agente
end type
type pb_1 from upb_salir within w_est_conpromalb_agente
end type
type pb_imprimir from upb_imprimir within w_est_conpromalb_agente
end type
type dw_listado_conpromalb2 from datawindow within w_est_conpromalb_agente
end type
type uo_manejo from u_manejo_datawindow within w_est_conpromalb_agente
end type
type dw_conpromalb2 from datawindow within w_est_conpromalb_agente
end type
type gb_boton from groupbox within w_est_conpromalb_agente
end type
type gb_cliente from groupbox within w_est_conpromalb_agente
end type
type gb_fecha from groupbox within w_est_conpromalb_agente
end type
type em_fechadesde from u_em_campo within w_est_conpromalb_agente
end type
type em_fechahasta from u_em_campo within w_est_conpromalb_agente
end type
type st_1 from statictext within w_est_conpromalb_agente
end type
type cb_1 from commandbutton within w_est_conpromalb_agente
end type
type cb_2 from commandbutton within w_est_conpromalb_agente
end type
end forward

global type w_est_conpromalb_agente from w_int_con_empresa
integer x = 14
integer y = 16
integer width = 3127
integer height = 2160
uo_conpromalb2 uo_conpromalb2
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado_conpromalb2 dw_listado_conpromalb2
uo_manejo uo_manejo
dw_conpromalb2 dw_conpromalb2
gb_boton gb_boton
gb_cliente gb_cliente
gb_fecha gb_fecha
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_1 st_1
cb_1 cb_1
cb_2 cb_2
end type
global w_est_conpromalb_agente w_est_conpromalb_agente

on w_est_conpromalb_agente.create
int iCurrent
call super::create
this.uo_conpromalb2=create uo_conpromalb2
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado_conpromalb2=create dw_listado_conpromalb2
this.uo_manejo=create uo_manejo
this.dw_conpromalb2=create dw_conpromalb2
this.gb_boton=create gb_boton
this.gb_cliente=create gb_cliente
this.gb_fecha=create gb_fecha
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_conpromalb2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.dw_listado_conpromalb2
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.dw_conpromalb2
this.Control[iCurrent+7]=this.gb_boton
this.Control[iCurrent+8]=this.gb_cliente
this.Control[iCurrent+9]=this.gb_fecha
this.Control[iCurrent+10]=this.em_fechadesde
this.Control[iCurrent+11]=this.em_fechahasta
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.cb_2
end on

on w_est_conpromalb_agente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_conpromalb2)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado_conpromalb2)
destroy(this.uo_manejo)
destroy(this.dw_conpromalb2)
destroy(this.gb_boton)
destroy(this.gb_cliente)
destroy(this.gb_fecha)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Informe Promoción por Agente"
istr_parametros.s_listado        =   "report_conpromalb2"
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromalb2.SetTransObject(SQLCA)
dw_listado_conpromalb2.SetTransObject(SQLCA)
f_activar_campo(uo_conpromalb2.em_campo)

em_fechadesde.text=string(datetime(date(year(today()),01,01)))
em_fechahasta.text=string(datetime(today()))
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromalb2)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromalb2)
end event

event ue_listar;dw_listado_conpromalb2.Retrieve(codigo_empresa,uo_conpromalb2.em_codigo.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
dw_listado_conpromalb2.SetTransObject(SQLCA)
dw_report =dw_listado_conpromalb2
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_est_conpromalb_agente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_est_conpromalb_agente
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_conpromalb2.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_est_conpromalb_agente
integer x = 18
end type

type uo_conpromalb2 from u_em_campo_2 within w_est_conpromalb_agente
integer x = 791
integer y = 212
integer width = 1065
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_conpromalb2.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Agentes"
   ue_datawindow ="dw_ayuda_venagentes"
   ue_filtro = ""
	
end event

event modificado;call super::modificado;uo_conpromalb2.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_conpromalb2.em_codigo.text)
If Trim(uo_conpromalb2.em_campo.text)="" then
	uo_conpromalb2.em_campo.text=""
	uo_conpromalb2.em_codigo.text=""
	Return
end if 
dw_conpromalb2.Retrieve(codigo_empresa,uo_conpromalb2.em_codigo.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
end event

type pb_1 from upb_salir within w_est_conpromalb_agente
integer x = 2853
integer y = 20
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_est_conpromalb_agente
integer x = 2871
integer y = 220
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;if trim( uo_conpromalb2.em_codigo.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca el Cliente")
	  Return
END IF

f_activar_campo(uo_conpromalb2.em_campo)
Parent.triggerEvent("ue_listar")
end event

type dw_listado_conpromalb2 from datawindow within w_est_conpromalb_agente
boolean visible = false
integer x = 64
integer y = 16
integer width = 402
integer height = 168
boolean bringtotop = true
string dataobject = "report_est_conpromalb_agente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_est_conpromalb_agente
integer x = 2391
integer y = 172
integer width = 617
integer height = 156
end type

event valores;call super::valores;dw_data=dw_conpromalb2
f_activar_campo(uo_conpromalb2.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_conpromalb2 from datawindow within w_est_conpromalb_agente
integer x = 23
integer y = 328
integer width = 2994
integer height = 1576
boolean bringtotop = true
string dataobject = "dw_est_conpromalb_agente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if row=0 then Return
string albaran
date fec
str_parametros lstr_param 
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(dw_conpromalb2.GetItemNumber(This.GetRow(),"anyo"))
  lstr_param.s_argumentos[3]=String(dw_conpromalb2.GetItemNumber(This.GetRow(),"albaran"))
  OpenWithParm(w_con_promalbaranes,lstr_param)

end event

type gb_boton from groupbox within w_est_conpromalb_agente
integer x = 1934
integer y = 144
integer width = 329
integer height = 176
integer taborder = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_cliente from groupbox within w_est_conpromalb_agente
integer x = 695
integer y = 144
integer width = 1221
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

type gb_fecha from groupbox within w_est_conpromalb_agente
integer x = 9
integer y = 144
integer width = 667
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type em_fechadesde from u_em_campo within w_est_conpromalb_agente
integer x = 41
integer y = 216
integer width = 265
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fechahasta from u_em_campo within w_est_conpromalb_agente
integer x = 393
integer y = 216
integer width = 265
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_1 from statictext within w_est_conpromalb_agente
integer x = 315
integer y = 212
integer width = 64
integer height = 68
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_est_conpromalb_agente
integer x = 1947
integer y = 184
integer width = 302
integer height = 60
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;dw_conpromalb2.Modify("DataWindow.detail.Height=129")
dw_listado_conpromalb2.Modify("DataWindow.detail.Height=129")
end event

type cb_2 from commandbutton within w_est_conpromalb_agente
integer x = 1947
integer y = 248
integer width = 302
integer height = 60
integer taborder = 43
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resumen"
end type

event clicked;dw_conpromalb2.Modify("DataWindow.detail.Height=0")
dw_listado_conpromalb2.Modify("DataWindow.detail.Height=0")
end event

