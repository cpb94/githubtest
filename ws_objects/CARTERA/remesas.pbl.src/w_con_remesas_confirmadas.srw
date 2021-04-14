$PBExportHeader$w_con_remesas_confirmadas.srw
$PBExportComments$€
forward
global type w_con_remesas_confirmadas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_remesas_confirmadas
end type
type st_nombre_banco from statictext within w_con_remesas_confirmadas
end type
type dw_listado from datawindow within w_con_remesas_confirmadas
end type
type st_banco from statictext within w_con_remesas_confirmadas
end type
type em_banco from u_em_campo within w_con_remesas_confirmadas
end type
type dw_detalle from datawindow within w_con_remesas_confirmadas
end type
type pb_2 from upb_imprimir within w_con_remesas_confirmadas
end type
end forward

global type w_con_remesas_confirmadas from w_int_con_empresa
integer width = 2935
integer height = 2208
pb_1 pb_1
st_nombre_banco st_nombre_banco
dw_listado dw_listado
st_banco st_banco
em_banco em_banco
dw_detalle dw_detalle
pb_2 pb_2
end type
global w_con_remesas_confirmadas w_con_remesas_confirmadas

type variables
string filtro


end variables

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Remesas Confirmadas"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

dw_detalle.visible=false


f_activar_campo(em_banco)
end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.Retrieve(codigo_empresa,em_banco.text)
CALL Super::ue_listar
end event

on w_con_remesas_confirmadas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_nombre_banco=create st_nombre_banco
this.dw_listado=create dw_listado
this.st_banco=create st_banco
this.em_banco=create em_banco
this.dw_detalle=create dw_detalle
this.pb_2=create pb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_nombre_banco
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.st_banco
this.Control[iCurrent+5]=this.em_banco
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.pb_2
end on

on w_con_remesas_confirmadas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_nombre_banco)
destroy(this.dw_listado)
destroy(this.st_banco)
destroy(this.em_banco)
destroy(this.dw_detalle)
destroy(this.pb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_remesas_confirmadas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_remesas_confirmadas
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_banco)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_remesas_confirmadas
integer x = 9
integer y = 4
integer width = 2427
integer height = 104
end type

type pb_1 from upb_salir within w_con_remesas_confirmadas
integer x = 2720
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_nombre_banco from statictext within w_con_remesas_confirmadas
integer x = 567
integer y = 132
integer width = 1202
integer height = 88
boolean bringtotop = true
integer textsize = -10
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

type dw_listado from datawindow within w_con_remesas_confirmadas
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_con_remesas_confirmadas"
boolean livescroll = true
end type

type st_banco from statictext within w_con_remesas_confirmadas
integer x = 27
integer y = 140
integer width = 242
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Banco:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_banco from u_em_campo within w_con_remesas_confirmadas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 302
integer y = 132
integer width = 261
integer height = 88
integer taborder = 10
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE BANCOS"
		ue_datawindow = "dw_ayuda_carbancos"
		ue_filtro     = ""
  		
 

end event

event modificado;call super::modificado;st_nombre_banco.text = f_nombre_banco(codigo_empresa,em_banco.text)

string fi=""
if tipo_vista="Nacional" then fi="(nacional='S')"
if tipo_vista="Exportacion" then fi="(nacional='N')"
if tipo_vista="Ambos" then fi="((nacional='N') or (nacional='S'))"

dw_detalle.SetFilter(fi)
dw_detalle.Filter()

dw_detalle.retrieve(codigo_empresa,em_banco.text)
dw_detalle.visible=true
end event

type dw_detalle from datawindow within w_con_remesas_confirmadas
integer y = 244
integer width = 2853
integer height = 1748
string dataobject = "dw_con_remesas_confirmadas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_2 from upb_imprimir within w_con_remesas_confirmadas
event clicked pbm_bnclicked
integer x = 1769
integer y = 132
integer width = 105
integer height = 88
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

