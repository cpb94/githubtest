$PBExportHeader$w_con_partes_trabajador.srw
forward
global type w_con_partes_trabajador from w_int_con_empresa
end type
type st_1 from statictext within w_con_partes_trabajador
end type
type uo_1 from u_em_campo_2 within w_con_partes_trabajador
end type
type dw_1 from datawindow within w_con_partes_trabajador
end type
type dw_listado from datawindow within w_con_partes_trabajador
end type
type pb_imprimir from upb_imprimir within w_con_partes_trabajador
end type
type st_2 from statictext within w_con_partes_trabajador
end type
type cb_1 from commandbutton within w_con_partes_trabajador
end type
type em_1 from u_em_campo within w_con_partes_trabajador
end type
type em_2 from u_em_campo within w_con_partes_trabajador
end type
type pb_1 from upb_salir within w_con_partes_trabajador
end type
end forward

global type w_con_partes_trabajador from w_int_con_empresa
integer width = 2779
integer height = 1668
st_1 st_1
uo_1 uo_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
st_2 st_2
cb_1 cb_1
em_1 em_1
em_2 em_2
pb_1 pb_1
end type
global w_con_partes_trabajador w_con_partes_trabajador

on w_con_partes_trabajador.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.st_2=create st_2
this.cb_1=create cb_1
this.em_1=create em_1
this.em_2=create em_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.em_1
this.Control[iCurrent+9]=this.em_2
this.Control[iCurrent+10]=this.pb_1
end on

on w_con_partes_trabajador.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de partes por trabajador"
istr_parametros.s_listado        =   "report_formatos_familias"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)

dw_listado.SetTransObject(SQLCA)

f_activar_campo(uo_1.em_campo)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_partes_trabajador
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_partes_trabajador
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_partes_trabajador
end type

type st_1 from statictext within w_con_partes_trabajador
integer x = 59
integer y = 192
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Trabajador"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_1 from u_em_campo_2 within w_con_partes_trabajador
integer x = 434
integer y = 188
integer width = 1083
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_1.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Empleados"
ue_datawindow ="dw_ayuda_trabajadores"
ue_filtro = ""
end event

event modificado;uo_1.em_campo.text=f_compuesto_empleados(codigo_empresa,dec(uo_1.em_codigo.text))
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

end event

type dw_1 from datawindow within w_con_partes_trabajador
integer x = 78
integer y = 284
integer width = 2514
integer height = 1112
boolean bringtotop = true
string dataobject = "dw_con_trabajador_dia"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_listado from datawindow within w_con_partes_trabajador
boolean visible = false
integer width = 521
integer height = 208
boolean bringtotop = true
string dataobject = "report_con_costes_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_partes_trabajador
event clicked pbm_bnclicked
integer x = 2638
integer y = 184
integer taborder = 50
boolean originalsize = false
string picturename = "print!"
end type

event clicked;

dw_listado.filter()
dw_listado.sort()
dw_listado.SetRedraw(TRUE)

f_imprimir_datawindow(dw_listado)

end event

type st_2 from statictext within w_con_partes_trabajador
integer x = 1522
integer y = 192
integer width = 183
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Entre:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_con_partes_trabajador
integer x = 2299
integer y = 184
integer width = 334
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;dec trabajador
datetime dia1, dia2


trabajador = dec(uo_1.em_codigo.text)
dia1 = datetime (em_1.text)
dia2 = datetime (em_2.text)

dw_1.Retrieve(codigo_empresa,trabajador,dia1,dia2)



end event

type em_1 from u_em_campo within w_con_partes_trabajador
integer x = 1696
integer y = 180
integer width = 274
integer taborder = 20
boolean bringtotop = true
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

type em_2 from u_em_campo within w_con_partes_trabajador
integer x = 1998
integer y = 180
integer width = 274
integer taborder = 30
boolean bringtotop = true
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

type pb_1 from upb_salir within w_con_partes_trabajador
integer x = 2638
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
string picturename = "exit!"
end type

