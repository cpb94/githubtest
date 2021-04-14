$PBExportHeader$wi_con_versiones_articulos.srw
forward
global type wi_con_versiones_articulos from w_int_con_empresa
end type
type st_1 from statictext within wi_con_versiones_articulos
end type
type uo_1 from u_em_campo_2 within wi_con_versiones_articulos
end type
type dw_1 from datawindow within wi_con_versiones_articulos
end type
type pb_1 from upb_salir within wi_con_versiones_articulos
end type
end forward

global type wi_con_versiones_articulos from w_int_con_empresa
integer width = 2821
integer height = 2224
st_1 st_1
uo_1 uo_1
dw_1 dw_1
pb_1 pb_1
end type
global wi_con_versiones_articulos wi_con_versiones_articulos

on wi_con_versiones_articulos.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.pb_1
end on

on wi_con_versiones_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Versiones Artículos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)


f_activar_campo(uo_1.em_campo)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_versiones_articulos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_versiones_articulos
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_con_versiones_articulos
end type

type st_1 from statictext within wi_con_versiones_articulos
integer x = 59
integer y = 192
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Articulo"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_1 from u_em_campo_2 within wi_con_versiones_articulos
integer x = 366
integer y = 188
integer width = 846
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_1.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Familias"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

event modificado;uo_1.em_campo.text = f_nombre_articulo(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 
dw_1.retrieve(codigo_empresa,uo_1.em_codigo.text)
end event

type dw_1 from datawindow within wi_con_versiones_articulos
integer x = 73
integer y = 284
integer width = 2062
integer height = 1516
boolean bringtotop = true
string dataobject = "dw_con_versiones_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_salir within wi_con_versiones_articulos
integer x = 2693
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
string picturename = "exit!"
end type

